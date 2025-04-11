Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C36C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 15:04:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A27F184158;
	Fri, 11 Apr 2025 17:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xBQemP7c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D016A84150; Fri, 11 Apr 2025 17:03:46 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C85D84107
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 17:03:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3913958ebf2so1916320f8f.3
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 08:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744383824; x=1744988624; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=blDKyqXKbjgArfufB3ibo9+djEvlb6KtPwnlWDxrz5M=;
 b=xBQemP7ctevVU9mIBFE1q7u/0aNiC1H/i0O491GuTK/CVkErHRwvmSQY08yUk9RJ5h
 ST0iYJ+XH6zU+7WqPBjJFDrnIL/hVShkRIonoVGND2bJl7WhZ8xlL87vyXUa1DGDGmvd
 6EXUqEXDMrsV0i3HEpwLHjxQ9a4KYwG+K8LPhAtZVE3PvfvgCxNLRek5Lyn6pBE5Wdte
 tdlQMExh+OTrRJe6XSxlS9mXb5xORMEp+lzUMtMbd37tCEaEZMTJJ6FaZRButEOtLTOf
 TedQx3TgUr525wAi1NDbGuG8oq8eB7Wjt5G1IkjUQW/kwofg6nfDHWqygRcgRpm0I8P7
 U8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744383824; x=1744988624;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=blDKyqXKbjgArfufB3ibo9+djEvlb6KtPwnlWDxrz5M=;
 b=VIyG1S9SUGu7eMUlsrb/MgaPWl7iKYci10gtiq67SPh/f+sZTUINDkwNFgJaQ42Nu1
 Rw8yoM6vPmjmTz+5flrCVrkXzjqoK40Kl7Kd/eQsT02d8DJZTiblZBgMjashPEKR/efz
 It/YGr+IGrIrQoVF0AHjiNEbspjK33irrCPWkQsXcv5qJMHmmkG3T70f2QmGA3C6Fasn
 PVNwIeXR69SZ2BqHiJzT9SpJLDzzFkRzfeqjQimqePUfpPXhIIJRUA24xAxWKJ/Wb5jS
 g29bcwhP65w5gqaaAgX7Y7p8HO5z+7jC2IzyxleqieHZ9L50Vj9O/AZEkIm4g0nPTdFT
 1s2w==
X-Gm-Message-State: AOJu0YwpTipW/Ndbumetze3ySSU9tnLLAoKi1OEMoOM3ygEjTizufo83
 5n+cMXAA0yuturSBK9Xa+CyIWu7KKjSWp2arifN0HPAVueMxU6GkAk17DZ2kDyqOZEpewsqCaR1
 QJ+w=
X-Gm-Gg: ASbGncsrCMjJEas/P+7sHSac1C5ytY1I2EDzaZT6Wg9EPrFw3YamevsfD004JxgoXqV
 JVuieheQpJASw1K9peAcnPQWf5kcElRKTbxtHOxfW/pa0ovyDTY0ftRyp9dzgM6bvOZStRTZz4a
 6A0Tj8bQbkfb0NXf9ikbRPhxCczgkVkK1lXJxu+v1RV6gSfntl13oHkjrj5F4sZhktdaL+/O4mu
 c//3LIZV5VlynOMgHvaHZO8hPIvK2T0chwYJNira1TKBRMvjVRyjoRNvQEq9vjQy6C+p1uMd2bO
 dyIRVNAjTBK4WY/LPYQmsAi9JLIS1LaWaYDuOId29q8GpYPbQ/1FUWBS+TtIB8663y3fdHTUQQk
 cmJOPKuzMCpmz6eQYiFkbH76ICdcH
X-Google-Smtp-Source: AGHT+IGdagyexz5RzxJszVDG+Ft+omCPioE6YJ1aUaGrm4upD0ctT/cBgZcrwhIN+7Wtvv2YxcZccQ==
X-Received: by 2002:a05:6000:1887:b0:390:f9d0:5df with SMTP id
 ffacd0b85a97d-39eaaec7a7bmr2345088f8f.52.1744383823275; 
 Fri, 11 Apr 2025 08:03:43 -0700 (PDT)
Received: from toyger.tail248178.ts.net (35-60-142-46.pool.kielnet.net.
 [46.142.60.35]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf445270sm2201005f8f.81.2025.04.11.08.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 08:03:42 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 11 Apr 2025 17:03:35 +0200
Subject: [PATCH v2 2/4] mach-snapdragon: CapsuleUpdate: support all boot
 methods
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-b4-qcom-capsule-update-improvements-v2-2-27f6b2fcc4a9@linaro.org>
References: <20250411-b4-qcom-capsule-update-improvements-v2-0-27f6b2fcc4a9@linaro.org>
In-Reply-To: <20250411-b4-qcom-capsule-update-improvements-v2-0-27f6b2fcc4a9@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11761;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=SJn2PMipCcPU0cV9zYGMfKyYlt3POed/wYvv8NICFC4=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn+S9JgyOhfy/dsLEtTRh7jOL7DvU9g0hzOsgUh
 RjzUjYk3p6JAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ/kvSQAKCRAFgzErGV9k
 tt/YD/9qA5Mn6zdSKj/ax/r/NL6rhfE6psLZmt4eVQ/b6vhlmAeOGzPZpFMeltAXHr8mXJEwwQI
 hnKRYVHKmbpZG/Wp3e+FSTLR0rUqxajEzpaBNwZszmqVCAe6lYFRWQ5v8JOgJnXBvso3fANAF9h
 3F1ZwTalSjI0n8aO6PscvW4bC8rw7RAI9M8R8Ox2teNKSJMyakfvPzrzzInaEfCtTgDUEA6r9D3
 PR1tZJNxUj7VjUTHVUJPPLebTU2p9C48b18ecFxT6sXMZNQtUwJAY/oFl3XKpRUdm6wB5nOI4BD
 TbWjpbJraw2DKIEC1UraVrtha1H49JB+HXsk4qUqukUmbbfbdXaz4xMyBdPhxTrVaWudqSBzey3
 1AOBVw0TM2UL5yiboN/zpOn+xjoDmidc8nhyljbCX46+m/rQ8wMmpiyh4/4J/8Tb7FfQmjakMff
 kw1lV01LQP29GzVyLPfIkEB5RA7htcBMT5hvMNgugEy/Qlo4u+enE5kQbv9GZTh4OmxYwu2rzG2
 tSfgzyQwgjJpuNfvdfDdzKBpfiIppi2mE5MWxFo3RJXwizTi7aefJozh7eq2OdiCfU9fnlbit/p
 dgnoiJlEJpM6acVPhcZyljXjox9aeiuVPGMLsOZeu+0f5GejESvGuG4UTqdSFTwNjBxXvFsBh3B
 KjnmEoe9gSGVEIg==
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/capsule_update.c | 274 ++++++++++++++++++++++++------
 1 file changed, 223 insertions(+), 51 deletions(-)

diff --git a/arch/arm/mach-snapdragon/capsule_update.c b/arch/arm/mach-snapdragon/capsule_update.c
index bf75a9a1b24c714792bae3712b83b96353b1df8f..4dced4961b684be198d8f9b5e30d2264871ea163 100644
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
@@ -56,37 +59,204 @@ struct part_slot_status {
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
+ * the slot status, and prioritizing the uefi partition over xbl if found.
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
+	bool have_ufs = false;
 
-	for (partnum = 1;; partnum++) {
-		ret = part_get_info(blk_dev, partnum, &info);
-		if (ret)
-			return ret;
+	/*
+	 * Check to see if we have UFS storage, if so U-Boot MUST be on it and we can skip
+	 * all non-UFS block devices
+	 */
+	uclass_foreach_dev_probe(UCLASS_UFS, dev) {
+		have_ufs = true;
+		break;
+	}
 
-		slot_status = (struct part_slot_status *)&info.type_flags;
-		log_io("%16s: Active: %1d, Successful: %1d, Unbootable: %1d, Tries left: %1d\n",
-		       info.name, slot_status->active,
-		       slot_status->successful, slot_status->unbootable,
-		       slot_status->tries_remaining);
+	uclass_foreach_dev_probe(UCLASS_BLK, dev) {
+		if (device_get_uclass_id(dev) != UCLASS_BLK)
+			continue;
+
+		/* If we have a UFS then don't look at any other block devices */
+		if (have_ufs) {
+			if (device_get_uclass_id(dev->parent->parent) != UCLASS_UFS)
+				continue;
 		/*
-		 * FIXME: eventually we'll want to find the active/inactive variant of the partition
-		 * but on the rb3gen2 these values might all be 0
+		 * If we don't have UFS, then U-Boot must be on the eMMC which is always the first
+		 * MMC device.
 		 */
-		if (!strncmp(info.name, partname, strlen(partname))) {
-			log_debug("Found active %s partition: '%s'!\n", partname, info.name);
-			strlcpy(name, info.name, sizeof(info.name));
-			return partnum;
+		} else if (dev->parent->seq_ > 0) {
+			continue;
+		}
+
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
@@ -100,14 +270,12 @@ static int find_boot_partition(const char *partname, struct blk_desc *blk_dev, c
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
@@ -116,38 +284,42 @@ void qcom_configure_capsule_updates(void)
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

