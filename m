Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE833C36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 17:41:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4FEF81CFD;
	Wed, 26 Mar 2025 18:40:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SIeKdj40";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEC1581DCD; Wed, 26 Mar 2025 18:40:51 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 710F08070C
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 18:40:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso1030255e9.1
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 10:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743010849; x=1743615649; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ikSL2AAWUyJTbVR3jVZtuurYvhIfIe7xlH7DI1JMgb0=;
 b=SIeKdj404+kza9fQ0ozGculmhgun3lNrRxMXsRJ34ZUS0vlVJqQyieTDTwupqpBGA6
 M0CsfijJqn+GRDPhJ7tmTC5NpD49gqoVewMbctMEoPzf5+ZJlnfqgjgUrSXm5Ryq57Ds
 JscZX5wDpDxCEhu/VOOJbD6qdrEEJL09a4/+O51KzZM/FDp8TVuEjz/Ok1TdVzDwsRr/
 CnrTVXpXDgR5EzmaHVT4avR/Ui0Zy/OWwjuTJ76Sfn4ouAFj9wrBuEq2e8iYxwjfrL09
 3dqkY1FKTgdN6bZS8G7hxwYjjrU50n5qhUnzoNumCv+6NU8DVSOCqBt5ig2QVw6kTKie
 9BFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743010849; x=1743615649;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ikSL2AAWUyJTbVR3jVZtuurYvhIfIe7xlH7DI1JMgb0=;
 b=lN4tyo9oLFS6exhhxNNiVLHm0z/o/d8AcWst459Wi5kasbwv02rPxj4yLgkHPfgwD9
 KXTjuw8gTZ3KRRMYfQOZgtcJNUzT8SP8gXtW7fGHE9Law9HNmT+yZfDUge9P8B+tCwn+
 00QG6bMyNYNlwnX1rEVLsZoex4P01nTxbG8jWZTlkDCLjKY3tn4qs/Klg5lr7Xau5aUJ
 J6YQjJtCaQ0Wng4+Qlu1JQtV4nK7SBpTGghNgySq7h4lAdW9LiWEf6V8ghh6s/u5vxUD
 Yq5WwgSPowCSAG4dvlVVGebcG5jaeMFw0TMV4aeZkMen5p03CvbSeIGOlBoohUNl9kPa
 tu/w==
X-Gm-Message-State: AOJu0Yye46RZVYRMCZlW18+6A//VybQ1CUsroYtcw7SQg+5di7NbfNig
 IkRxViGpyHzQ9Dm5vIIx1hbyhjSTS0LTVrSD1s3ahC0J8/MjZGKVD1+QPd/TlSM=
X-Gm-Gg: ASbGncs2BOmUBMOrQmH0lslWb1pE7iW0PFaXBOrDsmwFU5HT6QNFigf8+FdQCOQigyz
 iuYn/spPBKxf0ShoRPJkHQ+GUIB84D6+jcW6DZRqdsoLWdTX1XyO7fODQd2wZjVWnni2U+r19KL
 K4ZMUBnKnlSqFajze66HtCmE4Lg0/m1yOU12F7ApQbSFjlRgup2UqqPfeiPwWalws/nY8dyNu/I
 6yZiyUN44n9Aa6xPKCQ77+DbrhQK3mRYZGO0y+QyJc706xhe7lU8kIXiNAeuYaM4lMohgbIS5Ft
 dOM/BGoUaMkuobYHcEVdE4YYrTw7bFtBql5BN7zJ/7/VXdPgN6YFrcJ4FwDeo3+pM9gXPW3EkOZ
 qiuAJ8mZr5djo
X-Google-Smtp-Source: AGHT+IHUUiMJy4lwM5QzklYCWILfaSH+3rUDjHBOz86+8d2kS/Mf2iTl9Q/a1nA4UObuHmVBB8JzPQ==
X-Received: by 2002:a05:600c:4f94:b0:43c:eea9:f45d with SMTP id
 5b1f17b1804b1-43d850fd6aemr3635095e9.18.1743010848755; 
 Wed, 26 Mar 2025 10:40:48 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9957d9sm17397321f8f.9.2025.03.26.10.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 10:40:47 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 26 Mar 2025 18:40:35 +0100
Subject: [PATCH 2/4] mach-snapdragon: CapsuleUpdate: support all boot methods
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-b4-qcom-capsule-update-improvements-v1-2-afe2e3696675@linaro.org>
References: <20250326-b4-qcom-capsule-update-improvements-v1-0-afe2e3696675@linaro.org>
In-Reply-To: <20250326-b4-qcom-capsule-update-improvements-v1-0-afe2e3696675@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11118;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=25UcTZsX0d7vrPgsCaRXzdbGe525CzEDJNtuEx8Pw4s=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn5DwbJ2jGe1ZyoltuUfj4c/f6wTvJjrQjgRU/6
 jY0RQkDu8OJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ+Q8GwAKCRAFgzErGV9k
 tkWoD/9+IhtYF8f7fxWDdGn6W1clCtwl5C+m/LnuHHEXLa6HiXAy2Uu/xQ5MywrSD/tBl8R6dfT
 HOq2JSGzimRJiXP1TuBAuVjlshoLgFKJCiZRqljSWFEZ3WQCCfs0LfB9UW9zbp+PEalGg1q3fp/
 dsaGsfUu+gK4YUWBsFrqMmPIF7UHgU3X50F8/JCQRNJM3Ybn+pvIr6aMb8XsHenUUmwO3LBeOE9
 2CD3f/1xj56+7TfKS1PiBxYXJeRiOjxu9aM45tnGx49lHvk0wsF0nVNPH8dTlTokcyIfBl7xsfu
 od3cZzA2U271CksvpfQrn0ZMwfmuZk17ikGfCDjJM/qPdSsthai31cIQ2twnAz1OpGGDRoGz7ra
 f7A+DDm2ywXWGFz7li12xb5ceHl9sdiQ04ZukFUE7XLq6HWF8uoF9h4wMFCNVS6luJgScr2x5mI
 RzC5cSYDpvpKIO7MBHdEiMroEFQf38/8J6MLeRflrGJmSXmotDXZBrZtz7bTF3uLR41b/bLEf1G
 geobndTKBMzhAQN872xhwdVdcHgteCEI3328oDt8wk/S/ifnDX9/vuSIHgG3cPf1EtcfQrt3qN/
 rHSCLl9oWbSjO3FWyGU63Um9/IMH5X6Ewm9uvb4LQO/nT9/v3jGyaeJG61PU92Z67PlhNhlJdWh
 AywVTxIQoJg/v1g==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Expand capsule update support to correctly identify which partition
U-Boot is flashed to (between xbl, uefi, and boot including A/B
variants).

Use qcom_boot_source to determine if we were chainloaded from ABL,
meaning U-Boot is on the boot partition, otherwise we assume uefi if
it's available, finally leaving the xbl partition.

Set a different fw_name based on the target partition to prevent GUID
collisions, since a board may support U-Boot flashed to boot or XBL we
need to differentiate them since the U-Boot binary must be built
differently.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/capsule_update.c | 256 +++++++++++++++++++++++-------
 1 file changed, 203 insertions(+), 53 deletions(-)

diff --git a/arch/arm/mach-snapdragon/capsule_update.c b/arch/arm/mach-snapdragon/capsule_update.c
index bf75a9a1b24c714792bae3712b83b96353b1df8f..eedfc40004c06aa6271c685aaca32ccab8f5c491 100644
--- a/arch/arm/mach-snapdragon/capsule_update.c
+++ b/arch/arm/mach-snapdragon/capsule_update.c
@@ -19,24 +19,21 @@
 
 #include "qcom-priv.h"
 
 /*
- * NOTE: for now this implementation only supports the rb3gen2. Supporting other
- * boards that boot in different ways (e.g. chainloaded from ABL) will require
- * additional complexity to properly create the dfu string and fw_images array.
- */
-
-/*
- * To handle different variants like chainloaded U-Boot here we'll need to
- * build the fw_images array dynamically at runtime. It looks like
- * mach-rockchip is a good example for how to do this.
- * Detecting which image types a board uses is TBD, hence for now we only
- * support the one new board that runs U-Boot as its primary bootloader.
+ * To handle different variants like chainloaded U-Boot here we need to
+ * build the fw_images array dynamically at runtime. These are the possible
+ * implementations:
+ *
+ * - Devices with U-Boot on the uefi_a/b partition
+ * - Devices with U-Boot on the boot (a/b) partition
+ * - Devices with U-Boot on the xbl (a/b) partition
+ *
+ * Which partition actually has U-Boot on it is determined based on the
+ * qcom_boot_source variable and additional logic in find_target_partition().
  */
 struct efi_fw_image fw_images[] = {
 	{
-		/* U-Boot flashed to the uefi_X partition (e.g. rb3gen2) */
-		.fw_name = u"UBOOT_UEFI_PARTITION",
 		.image_index = 1,
 	},
 };
 
@@ -46,8 +43,14 @@ struct efi_capsule_update_info update_info = {
 	.num_images = ARRAY_SIZE(fw_images),
 	.images = fw_images,
 };
 
+enum target_part_type {
+	TARGET_PART_UEFI = 1,
+	TARGET_PART_XBL,
+	TARGET_PART_BOOT,
+};
+
 /* LSB first */
 struct part_slot_status {
 	u16: 2;
 	u16 active : 1;
@@ -56,37 +59,182 @@ struct part_slot_status {
 	u16 unbootable : 1;
 	u16 tries_remaining : 4;
 };
 
-static int find_boot_partition(const char *partname, struct blk_desc *blk_dev, char *name)
+enum ab_slot {
+	SLOT_NONE,
+	SLOT_A,
+	SLOT_B,
+};
+
+static enum ab_slot get_part_slot(const char *partname)
+{
+	int len = strlen(partname);
+
+	if (partname[len - 2] != '_')
+		return SLOT_NONE;
+	if (partname[len - 1] == 'a')
+		return SLOT_A;
+	if (partname[len - 1] == 'b')
+		return SLOT_B;
+
+	return SLOT_NONE;
+}
+
+/*
+ * Determine which partition U-Boot is flashed to based on the boot source (ABL/XBL),
+ * the slot status, and prioritising the uefi partition over xbl if found.
+ */
+static int find_target_partition(int *devnum, enum uclass_id *uclass,
+				 enum target_part_type *target_part_type)
 {
 	int ret;
-	int partnum;
+	int partnum, uefi_partnum = -1, xbl_partnum = -1;
 	struct disk_partition info;
 	struct part_slot_status *slot_status;
+	struct udevice *dev = NULL;
+	struct blk_desc *desc = NULL, *xbl_desc = NULL;
+	uchar ptn_name[32] = { 0 };
 
-	for (partnum = 1;; partnum++) {
-		ret = part_get_info(blk_dev, partnum, &info);
-		if (ret)
-			return ret;
+	uclass_foreach_dev_probe(UCLASS_BLK, dev) {
+		if (device_get_uclass_id(dev) != UCLASS_BLK)
+			continue;
 
-		slot_status = (struct part_slot_status *)&info.type_flags;
-		log_io("%16s: Active: %1d, Successful: %1d, Unbootable: %1d, Tries left: %1d\n",
-		       info.name, slot_status->active,
-		       slot_status->successful, slot_status->unbootable,
-		       slot_status->tries_remaining);
-		/*
-		 * FIXME: eventually we'll want to find the active/inactive variant of the partition
-		 * but on the rb3gen2 these values might all be 0
-		 */
-		if (!strncmp(info.name, partname, strlen(partname))) {
-			log_debug("Found active %s partition: '%s'!\n", partname, info.name);
-			strlcpy(name, info.name, sizeof(info.name));
-			return partnum;
+		desc = dev_get_uclass_plat(dev);
+		if (!desc || desc->part_type == PART_TYPE_UNKNOWN)
+			continue;
+		for (partnum = 1;; partnum++) {
+			ret = part_get_info(desc, partnum, &info);
+			if (ret)
+				break;
+
+			slot_status = (struct part_slot_status *)&info.type_flags;
+
+			/*
+			 * Qualcomm Linux devices have a "uefi" partition, it's A/B but the
+			 * flags might not be set so we assume the A partition unless the B
+			 * partition is active.
+			 */
+			if (!strncmp(info.name, "uefi", strlen("uefi"))) {
+				/*
+				 * If U-Boot was chainloaded somehow we can't be flashed to
+				 * the uefi partition
+				 */
+				if (qcom_boot_source != QCOM_BOOT_SOURCE_XBL)
+					continue;
+
+				*target_part_type = TARGET_PART_UEFI;
+				/*
+				 * Found an active UEFI partition, this is where U-Boot is
+				 * flashed.
+				 */
+				if (slot_status->active)
+					goto found;
+
+				/* Prefer A slot if it's not marked active */
+				if (get_part_slot(info.name) == SLOT_A) {
+					/*
+					 * If we found the A slot after the B slot (both
+					 * inactive) then we assume U-Boot is on the A slot.
+					 */
+					if (uefi_partnum >= 0)
+						goto found;
+
+					/* Didn't find the B slot yet */
+					uefi_partnum = partnum;
+					strlcpy(ptn_name, info.name, 32);
+				} else {
+					/*
+					 * Found inactive B slot after inactive A slot, return
+					 * the A slot
+					 */
+					if (uefi_partnum >= 0) {
+						partnum = uefi_partnum;
+						goto found;
+					}
+
+					/*
+					 * Didn't find the A slot yet. Record that we found the
+					 * B slot
+					 */
+					uefi_partnum = partnum;
+					strlcpy(ptn_name, info.name, 32);
+				}
+				/* xbl and aboot are effectively the same */
+			} else if ((!strncmp(info.name, "xbl", strlen("xbl")) &&
+				    strlen(info.name) == 5) ||
+				    !strncmp(info.name, "aboot", strlen("aboot"))) {
+				/*
+				 * If U-Boot was booted via ABL, we can't be flashed to the
+				 * XBL partition
+				 */
+				if (qcom_boot_source != QCOM_BOOT_SOURCE_XBL)
+					continue;
+
+				/*
+				 * ignore xbl partition if we have uefi partitions, U-Boot will
+				 * always be on the UEFI partition in this case.
+				 */
+				if (*target_part_type == TARGET_PART_UEFI)
+					continue;
+
+				/* Either non-A/B or find the active XBL partition */
+				if (slot_status->active || !get_part_slot(info.name)) {
+					/*
+					 * No quick return since we might find a uefi partition
+					 * later
+					 */
+					xbl_partnum = partnum;
+					*target_part_type = TARGET_PART_XBL;
+					xbl_desc = desc;
+					strlcpy(ptn_name, info.name, 32);
+				}
+
+				/*
+				 * No fast return since we might also have a uefi partition which
+				 * will take priority.
+				 */
+			} else if (!strncmp(info.name, "boot", strlen("boot"))) {
+				/* We can only be flashed to boot if we were chainloaded */
+				if (qcom_boot_source != QCOM_BOOT_SOURCE_ANDROID)
+					continue;
+
+				/*
+				 * Either non-A/B or find the active partition. We can return
+				 * immediately here since we've narrowed it down to a single option
+				 */
+				if (slot_status->active || !get_part_slot(info.name)) {
+					*target_part_type = TARGET_PART_BOOT;
+					goto found;
+				}
+			}
 		}
 	}
 
+	/*
+	 * Now we've exhausted all options, if we didn't find a uefi partition
+	 * then we are indeed flashed to the xbl partition.
+	 */
+	if (*target_part_type == TARGET_PART_XBL) {
+		partnum = xbl_partnum;
+		desc = xbl_desc;
+		goto found;
+	}
+
+	/* Found no candidate partitions */
 	return -1;
+
+found:
+	if (desc) {
+		*devnum = desc->devnum;
+		*uclass = desc->uclass_id;
+	}
+
+	/* info won't match for XBL hence the copy. */
+	log_info("Capsule update target: %s (disk %d:%d)\n",
+		 *target_part_type == TARGET_PART_BOOT ? info.name : ptn_name,
+		 *devnum, partnum);
+	return partnum;
 }
 
 /**
  * qcom_configure_capsule_updates() - Configure the DFU string for capsule updates
@@ -100,14 +248,12 @@ static int find_boot_partition(const char *partname, struct blk_desc *blk_dev, c
  * in the GPT partition vendor attribute bits.
  */
 void qcom_configure_capsule_updates(void)
 {
-	struct blk_desc *desc;
 	int ret = 0, partnum = -1, devnum;
 	static char dfu_string[32] = { 0 };
-	char name[32]; /* GPT partition name */
-	char *partname = "uefi_a";
-	struct udevice *dev = NULL;
+	enum target_part_type target_part_type = 0;
+	enum uclass_id dev_uclass;
 
 	if (IS_ENABLED(CONFIG_SCSI)) {
 		/* Scan for SCSI devices */
 		ret = scsi_scan(false);
@@ -116,38 +262,42 @@ void qcom_configure_capsule_updates(void)
 			return;
 		}
 	}
 
-	uclass_foreach_dev_probe(UCLASS_BLK, dev) {
-		if (device_get_uclass_id(dev) != UCLASS_BLK)
-			continue;
-
-		desc = dev_get_uclass_plat(dev);
-		if (!desc || desc->part_type == PART_TYPE_UNKNOWN)
-			continue;
-		devnum = desc->devnum;
-		partnum = find_boot_partition(partname, desc,
-					      name);
-		if (partnum >= 0)
-			break;
-	}
-
+	partnum = find_target_partition(&devnum, &dev_uclass, &target_part_type);
 	if (partnum < 0) {
 		log_err("Failed to find boot partition\n");
 		return;
 	}
 
-	switch (desc->uclass_id) {
+	/*
+	 * Set the fw_name based on the partition type. This causes the GUID to be different
+	 * so we will never accidentally flash a U-Boot image intended for XBL to the boot
+	 * partition.
+	 */
+	switch (target_part_type) {
+	case TARGET_PART_UEFI:
+		fw_images[0].fw_name = u"UBOOT_UEFI_PARTITION";
+		break;
+	case TARGET_PART_XBL:
+		fw_images[0].fw_name = u"UBOOT_XBL_PARTITION";
+		break;
+	case TARGET_PART_BOOT:
+		fw_images[0].fw_name = u"UBOOT_BOOT_PARTITION";
+		break;
+	}
+
+	switch (dev_uclass) {
 	case UCLASS_SCSI:
 		snprintf(dfu_string, 32, "scsi %d=u-boot.bin part %d", devnum, partnum);
 		break;
 	case UCLASS_MMC:
 		snprintf(dfu_string, 32, "mmc 0=u-boot.bin part %d %d", devnum, partnum);
 		break;
 	default:
-		debug("Unsupported storage uclass: %d\n", desc->uclass_id);
+		debug("Unsupported storage uclass: %d\n", dev_uclass);
 		return;
 	}
-	log_debug("boot partition is %s, DFU string: '%s'\n", name, dfu_string);
+	log_debug("DFU string: '%s'\n", dfu_string);
 
 	update_info.dfu_string = dfu_string;
 }

-- 
2.49.0

