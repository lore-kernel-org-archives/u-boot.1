Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF003109024C
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 16:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F13083DC9;
	Thu, 19 Mar 2026 17:14:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OqjQwUtx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70C7E83F2D; Thu, 19 Mar 2026 17:14:06 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8E2383DA6
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 17:14:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-439b97a8a8cso1095295f8f.1
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 09:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773936843; x=1774541643;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Mzbl859JHjDKq30DERYoV125UiquN8pv65J81zT8Akg=;
 b=OqjQwUtxOkhyIBn7FGQJPhaTAN8ubZ8bJ8Ip6aVyHdXgwvHyvonF678cNDbxLzi9+e
 ItFh7W16AyvPo7AnMwfBdLXQ/nGRssHmOS09OZKHypwGgkjzQOql6GOZtfwZRgqAaDOV
 euGES23R6d3UO9Dqs112BjhQSnP3WXXCullw/z119Qr6fbmNPwS2AGJhUOorPirTFFAt
 v9qRQHUlB2OPOl3QBtZ/x9RfrCNJiPpEpZatVnHXHu/Ealkj8nEuUJ6lURBb0/V3TrKb
 OyYmMj5PqWHzXERG2Kj8fC4zoIMg6uIR3xjWP8IydQiulDJcKkls18KZLOzsmoFFahsL
 ns7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773936843; x=1774541643;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mzbl859JHjDKq30DERYoV125UiquN8pv65J81zT8Akg=;
 b=Jq4N6hwm2iQW8VeMde1hBoGmXznlOanvlcN39RMno8FSpQndNotFhtqZENR20ovoMj
 7Fc75Q2XvHKZvr43Pt7HI17c71DoNuB6m9Vkc/2qA32AASuofFFfJoshGwS1umNFKYIR
 flEfsGprAUeE4FIspTQg/sNowc8yabidFQpK+xzK9Nu5uZx8F/7vR8Z5fYonPSEV4SFO
 VxmfzJ8Xx/m26fVU0mcBmvfJNKIlhqSBHJweQYxtrUu34Y0akNeETT/0P8Ii1TAt7frk
 7JugMjje61Z2bhKU4bW/pDU4pmqqpu/YDYQesi0gDpro2z6jZkUVnCIEEo+cHFk5J1j6
 EZLw==
X-Gm-Message-State: AOJu0Ywh5Wsw1i2/C4jstMaKq1+Au4htZ9BnHOmRXW2+bWGclhMwREAp
 6QnFlckjjBHbpSlCEkv0NuLXTpN6C7rNZvndYI2oI99eyeB48NOziNnVCJocFInrHwk=
X-Gm-Gg: ATEYQzzoBpTYMwpxKTN96wrSEErntsO8MPGDtL88ZygQ9Cfe/0/rL0dCYR7admuOXu6
 qCcuI5b8WyLecCyiQa/Q4HnDrPMGCd4e5eGmPfMSs+SCQdeCrwVClU2uIkfkDNGko/D1b+JnkeA
 C6gbm1adDOSEsuq4F4w1atdPJmOmBIAMYeywjJ7DxuoV5uvuKRXQACLDP26G1FVqY6k1cdmopZA
 hlizgg9iLjDSkf5ncEfTV2xTSmO1O2O9iCQklEVhRY4udya7hWmW5EHwV2VarX/MyfjUZN8Y3b9
 3Xsjv8iqZxPYOsHG8pD2tT0+lcXxCnOdRkOzbn/eGN8kRw79aNUkoAret8vSo/7X1pwkI8wCgAb
 NBVu1iWLuY8o0RSn5/QQxhNauNZQrBxyld7l+nRE67KaeIeHdgLkVpKZlwyzDGcD88r/hx+M0+p
 oO66k30LMJXaL1FiIdwPu0MRYjmcSEkucc3qejmuQL00Q3TuY6Tubi7fJuyqbuE7pRKTKu3GS3h
 JxeJFhTq8hMmFQR0jMk8tdzdXhNRRTK0/6FYs8IrjSi1b+NWH6y1hULtGA23F/wIljld2sBFDdT
 UMEVqRs=
X-Received: by 2002:a05:600c:b8a:b0:485:34b3:8589 with SMTP id
 5b1f17b1804b1-486f4570873mr137760055e9.31.1773936843286; 
 Thu, 19 Mar 2026 09:14:03 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f460e990sm57313055e9.1.2026.03.19.09.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 09:14:02 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 19 Mar 2026 17:14:05 +0100
Subject: [PATCH] scripts: merge_config.sh: support include directives in
 fragments
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-merge_configs-support-include-directive-v1-1-dcfb1c7f934c@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3NWwrCMBBG4a2UeXYglyLoVkREkr9xQJMwaYtQu
 veGPn4v52zUoIJG92EjxSpNSu6wl4HC550TWGI3OeOuxtsb/6AJr1DyJKlxW2otOrPk8F0iOIo
 izLKC4WN0o7ejsZZ6rSom+Z+nx3PfDwluILt5AAAA
X-Change-ID: 20260319-merge_configs-support-include-directive-e3dd24314011
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, dlechner@baylibre.com, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Many defconfig files rely on include directives to factor out common
configuration. When running "make some_board_defconfig", these files are
preprocessed and the includes are resolved automatically. However,
merge_config.sh script currently does not handle include directives in
configuration fragments.

Add a preprocessing step to resolve include directives in all fragments
before merging them.

By default, the include search path consists of:
  - the current working directory
  - the fragment's directory
  - the default U-Boot configs/ directory

This ensures that existing defconfig files work out of the box. Additional
include directories can be specified using the -I option:

  ./scripts/kconfig/merge_config.sh -I <additional include dir>  configs/some_board_defconfig frag1.cfg frag2.cfg

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 scripts/kconfig/merge_config.sh | 56 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 5 deletions(-)

diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config.sh
index 0ef90649964..a78cfa5da02 100755
--- a/scripts/kconfig/merge_config.sh
+++ b/scripts/kconfig/merge_config.sh
@@ -21,7 +21,7 @@
 #  See the GNU General Public License for more details.
 
 clean_up() {
-	rm -f $TMP_FILE
+	rm -f $TMP_FILE $TMP_PREPROCESSED
 	exit
 }
 trap clean_up HUP INT TERM
@@ -33,6 +33,7 @@ usage() {
 	echo "  -n    use allnoconfig instead of alldefconfig"
 	echo "  -r    list redundant entries when merging fragments"
 	echo "  -O    dir to put generated output files.  Consider setting \$KCONFIG_CONFIG instead."
+	echo "  -I    include dir to search for includes. Defaults to pwd, u-boot configs and directory containing the fragment."
 	echo
 	echo "Used prefix: '$CONFIG_PREFIX'. You can redefine it with \$CONFIG_ environment variable."
 }
@@ -42,6 +43,7 @@ ALLTARGET=alldefconfig
 WARNREDUN=false
 OUTPUT=.
 CONFIG_PREFIX=${CONFIG_-CONFIG_}
+INCLUDE_DIR="-I $(pwd) -I $(pwd)/configs"
 
 while true; do
 	case $1 in
@@ -74,6 +76,16 @@ while true; do
 		shift 2
 		continue
 		;;
+	"-I")
+		if [ -d $2 ];then
+			INCLUDE_DIR="$INCLUDE_DIR -I $2"
+		else
+			echo "include directory $2 does not exist" 1>&2
+			exit 1
+		fi
+		shift 2
+		continue
+		;;
 	*)
 		break
 		;;
@@ -106,9 +118,39 @@ SED_CONFIG_EXP1="s/^\(${CONFIG_PREFIX}[a-zA-Z0-9_]*\)=.*/\1/p"
 SED_CONFIG_EXP2="s/^# \(${CONFIG_PREFIX}[a-zA-Z0-9_]*\) is not set$/\1/p"
 
 TMP_FILE=$(mktemp ./.tmp.config.XXXXXXXXXX)
+TMP_PREPROCESSED=$(mktemp ./.tmp.config.preprocessed.XXXXXXXXXX)
+
+# Function to preprocess config file with cpp to expand #include directives
+preprocess_config() {
+	local input_file="$1"
+	local output_file="$2"
+
+	# Get the directory of the input file for include path
+	local include_dir=$(dirname "$input_file")
+
+	# Use cpp to preprocess the file, similar to how "make board_defconfig"
+	# does (./scripts/kconfig/Makefile):
+	#
+	#   %_defconfig: $(obj)/conf
+        #      $(Q)$(CPP) -nostdinc -P -I $(srctree) -undef -x assembler-with-cpp $(srctree)/arch/$(SRCARCH)/configs/$@ -o generated_defconfig
+        #      $(Q)sed -i -e 's/^[[:space:]]//' generated_defconfig
+
+	cpp -nostdinc -P -undef -x assembler-with-cpp \
+		-I "$include_dir" $INCLUDE_DIR  \
+		"$input_file" -o "$output_file"
+
+	if [ $? -ne 0 ]; then
+		# If cpp fails, fall back to just copying the file
+		echo "Warning: C preprocessor failed for $input_file, using file as-is" >&2
+		cp "$input_file" "$output_file"
+	else
+		# Clean up any leading spaces that cpp might have added
+		sed -i 's/^[[:space:]]//' "$output_file"
+	fi
+}
 
 echo "Using $INITFILE as base"
-cat $INITFILE > $TMP_FILE
+preprocess_config "$INITFILE" "$TMP_FILE"
 
 # Merge files, printing warnings on overridden values
 for MERGE_FILE in $MERGE_LIST ; do
@@ -117,12 +159,16 @@ for MERGE_FILE in $MERGE_LIST ; do
 		echo "The merge file '$MERGE_FILE' does not exist.  Exit." >&2
 		exit 1
 	fi
-	CFG_LIST=$(sed -n -e "$SED_CONFIG_EXP1" -e "$SED_CONFIG_EXP2" $MERGE_FILE)
+
+	# Preprocess the fragment to expand includes
+	preprocess_config "$MERGE_FILE" "$TMP_PREPROCESSED"
+
+	CFG_LIST=$(sed -n -e "$SED_CONFIG_EXP1" -e "$SED_CONFIG_EXP2" $TMP_PREPROCESSED)
 
 	for CFG in $CFG_LIST ; do
 		grep -q -w $CFG $TMP_FILE || continue
 		PREV_VAL=$(grep -w $CFG $TMP_FILE)
-		NEW_VAL=$(grep -w $CFG $MERGE_FILE)
+		NEW_VAL=$(grep -w $CFG $TMP_PREPROCESSED)
 		if [ "x$PREV_VAL" != "x$NEW_VAL" ] ; then
 			echo Value of $CFG is redefined by fragment $MERGE_FILE:
 			echo Previous  value: $PREV_VAL
@@ -133,7 +179,7 @@ for MERGE_FILE in $MERGE_LIST ; do
 		fi
 		sed -i "/$CFG[ =]/d" $TMP_FILE
 	done
-	cat $MERGE_FILE >> $TMP_FILE
+	cat $TMP_PREPROCESSED >> $TMP_FILE
 done
 
 if [ "$RUNMAKE" = "false" ]; then

---
base-commit: 142c805d470cd02470146d6d70aa9c522d4da16c
change-id: 20260319-merge_configs-support-include-directive-e3dd24314011

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>

