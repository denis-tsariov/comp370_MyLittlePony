#!/bin/bash

# Complete script for speaker frequency analysis
CSV_FILE="my-little-pony-transcript/clean_dialog.csv"
OUTPUT_FILE="Line_percentages.csv"

# Check if file exists
if [ ! -f "$CSV_FILE" ]; then
    echo "Error: $CSV_FILE not found!"
    exit 1
fi

# Get total lines (excluding header)
TOTAL_LINES=$(tail -n +2 "$CSV_FILE" | wc -l)
echo "Total lines in dataset: $TOTAL_LINES"

# Extract speaker column for analysis
cut -d',' -f1 "$CSV_FILE" | tail -n +2 > speakers_temp.txt

# Count lines for each main pony
TWILIGHT_COUNT=$(grep -c -i "twilight sparkle" speakers_temp.txt)
RARITY_COUNT=$(grep -c -i "^rarity$" speakers_temp.txt)
PINKIE_COUNT=$(grep -c -i "pinkie pie" speakers_temp.txt)
RAINBOW_COUNT=$(grep -c -i "rainbow dash" speakers_temp.txt)
FLUTTERSHY_COUNT=$(grep -c -i "^fluttershy$" speakers_temp.txt)

# Calculate percentages
TWILIGHT_PERCENT=$(echo "scale=2; $TWILIGHT_COUNT * 100 / $TOTAL_LINES" | bc)
RARITY_PERCENT=$(echo "scale=2; $RARITY_COUNT * 100 / $TOTAL_LINES" | bc)
PINKIE_PERCENT=$(echo "scale=2; $PINKIE_COUNT * 100 / $TOTAL_LINES" | bc)
RAINBOW_PERCENT=$(echo "scale=2; $RAINBOW_COUNT * 100 / $TOTAL_LINES" | bc)
FLUTTERSHY_PERCENT=$(echo "scale=2; $FLUTTERSHY_COUNT * 100 / $TOTAL_LINES" | bc)

# Create output CSV
echo "pony_name,total_line_count,percent_all_lines" > "$OUTPUT_FILE"
echo "Twilight Sparkle,$TWILIGHT_COUNT,$TWILIGHT_PERCENT" >> "$OUTPUT_FILE"
echo "Rarity,$RARITY_COUNT,$RARITY_PERCENT" >> "$OUTPUT_FILE"
echo "Pinkie Pie,$PINKIE_COUNT,$PINKIE_PERCENT" >> "$OUTPUT_FILE"
echo "Rainbow Dash,$RAINBOW_COUNT,$RAINBOW_PERCENT" >> "$OUTPUT_FILE"
echo "Fluttershy,$FLUTTERSHY_COUNT,$FLUTTERSHY_PERCENT" >> "$OUTPUT_FILE"

# Display results
echo "=== RESULTS ==="
cat "$OUTPUT_FILE"

# Clean up
rm speakers_temp.txt

echo ""
echo "Analysis complete! Results saved to $OUTPUT_FILE"