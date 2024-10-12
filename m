Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C0BCF2566
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 13:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02CF588C8F;
	Sat, 12 Oct 2024 15:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h905H5Jg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 345D388D9B; Sat, 12 Oct 2024 15:57:32 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E62888D99
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 15:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9932aa108cso428148966b.2
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 06:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728741449; x=1729346249; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a0MjAs/rUfWKx52CnsUN494P84tk7qtJGRejbig5imM=;
 b=h905H5Jg2IZzQ1QycX0Wp/VEOsdlWOgprsvk0ltMnYxuAdwYqqEb6cgivtBTmViR3m
 1POGE7lKwynTEAHriQPCAsxUPsJJDPav2aRY+qP9zsUecaB+h+m7NT5xcYVrW+rzTMAe
 CX8lY6hFBzDPQnjtGyGN+LI1Ab1ZX/5RFw0rq1ubwsEdahMvl2o8rQ1FBCdB2zLYmrNg
 8lOnLVDU1AQpMDqGdHLqeyzLZcruwv0YExCXlTrCdhoBCvpatQD6kqNjnyF0d/UmDX1K
 vw0wvmr875+9LIrvP67GhLKLA4fNNpYSI143hGmxzHtAUKjkXumbn16tkxwc1VScwYVp
 cl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728741449; x=1729346249;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a0MjAs/rUfWKx52CnsUN494P84tk7qtJGRejbig5imM=;
 b=cBhEt5cPzwdtY96lRCC5ASEBxXDj6OxCiPJY1zw3nwV4xsPwcQYOvTvaB5EfczFSxH
 j9MGazQz4t1/lVUh0qk0SnooA3l1vxSZg/GEHcjp8Wb/rGYcJ7sR5ifvrEcSAJwvDf9Y
 SeVpa/CF+c7c/LGANfeO0YZuGX11JVsT3WXEplKiTyMwafGWGyOsUKYCCFMQyLa5bPHd
 qM8t90JwD0q0uadSu1ryu0VGVlmfMNBphuaxTzjqrjqJgaqRZ3a/PsyXZHrFWStsyO24
 vFfIpL0MIMFVuXixAdT1ulYs30siZGq5lNHvMNB5/tQ/STdinRbRtgjaXS/R8BN+q0KP
 eu5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoqgUI0IXIZNshQn0+3e4iJOAwp5A0UG2dvA5D7rHiDIhwYmby1jYoj17AvEembDVm2V5mzJQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9Wx5krtCGaCqILhkJ4GgtNfLxijCq1CHDyXMkKbHGVqL6m7E3
 UvJ2Q1nLMi3STCnU55p8lSH5nhBqNxEWA3dMDG2/mGMr5IiYRyLGBtz6CqcLiOM=
X-Google-Smtp-Source: AGHT+IHZqrdq8mNYrGsyo+Lm/VwkRN/u6niSSy/H1ybMhvU13ufOZWvVcqn3fKGdhKe/DPvBoNGLlw==
X-Received: by 2002:a17:907:d2e8:b0:a8a:4e39:a462 with SMTP id
 a640c23a62f3a-a99b943bc4bmr478826766b.7.1728741448654; 
 Sat, 12 Oct 2024 06:57:28 -0700 (PDT)
Received: from cymric.local ([2a02:8109:888d:ff00::2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a7f2c1f4sm324955966b.87.2024.10.12.06.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Oct 2024 06:57:28 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Sat, 12 Oct 2024 15:57:19 +0200
Subject: [PATCH v4 3/4] mach-snapdragon: implement capsule update support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241012-b4-qcom-capsule-updates-v4-3-abd05f15255f@linaro.org>
References: <20241012-b4-qcom-capsule-updates-v4-0-abd05f15255f@linaro.org>
In-Reply-To: <20241012-b4-qcom-capsule-updates-v4-0-abd05f15255f@linaro.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=8093;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=0/4C2jgVMfFw5GLYIQGV/So+oMFio6R1x6EIR8TTAvY=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBnCoBDEz32N8FZS6tELX4p3MzrHmNL1OkKfMoRn
 cHE0ip2kTOJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZwqAQwAKCRAFgzErGV9k
 thspD/46sAj4DA3WXajh96ArthjaT9jr/wFt3Vp8fRz99lIHwdCxl/WuC+9vVgcZCaP2r+CU+72
 4unczT0B0gH3smGeXKHpqyI0iJqdlRMk83m3dBQVEcLtJkXFK4GA5uWLXWGx7twHoiCmqFFlE3g
 uYULV9aB49fy+F2wPX6wxJaS4T/h0ZLd4Op5+ex6I+Fhl44YJNiCENi7P6gdVH6Z1b0+TDa/Q+i
 T7GW1J3gbLvvrNX/Bq3aBkI29LeedW2xygKiJ8sEfiZutqusLRFHaMCRRpplFcLN2x8dzYPqCzZ
 dNy0Ut7krH3CDct/E7Qv0Em7V97o6Y27O1bc05Mt1uMPS6vr5zGVgIyPJEUEuWpCGhI1N6QAXCi
 TnYcsSh8u4pAlhML0M42OnKAyyliMsTSLgzKTNyj7Tx8A3aajQxmhhjpzLR03zIKGYZgIuWDvA8
 oEmb1ILCFSbeuYoOpv1QSGFqlMzoQnCgjFEbR6FFbt/aa6I1DslDSQHUTKzEXsOVU9Hr7jJuZsg
 QvzblmHvtQOZOPUhXleBdmhTPdZE4pbwC3BVlDCVawbkMgUgQpa6mBoAaa2VoJuE4u8XyHktDy+
 YF5JA6E+bSotWNKfolRtbyMYrRC0Hhu9q2gg6UdUVA6f8CV09BTT7fB8oYlg4N80fV7su7Wxdbm
 7QPY0J9Oap36GKg==
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

Qualcomm boards flash U-Boot a variety of partitions, implement support
for determining which slot U-Boot is running from, finding the correct
partition for that slot and configuring the appropriate DFU string.

Initially, we only support the RB3 Gen 2 where U-Boot is flashed to the
UEFI partition, and ignore handling of slots. In the future we will
additionally support booting U-Boot from other partitions (e.g. boot)
and correct handling for A/B.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/Kconfig          |   3 +
 arch/arm/mach-snapdragon/Makefile         |   1 +
 arch/arm/mach-snapdragon/board.c          |   3 +
 arch/arm/mach-snapdragon/capsule_update.c | 153 ++++++++++++++++++++++++++++++
 arch/arm/mach-snapdragon/qcom-priv.h      |   6 ++
 include/configs/qcom.h                    |   5 +
 6 files changed, 171 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 536960b83c3b..f82cd0d32915 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -19,8 +19,11 @@ config SPL_SYS_MALLOC_F
 
 config SPL_SYS_MALLOC_F_LEN
 	default 0x2000
 
+config SYS_MALLOC_LEN
+	default 0x800000
+
 config LNX_KRNL_IMG_TEXT_OFFSET_BASE
 	default 0x80000000
 
 config SYS_BOARD
diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index 7a4495c8108f..343e825c6fdd 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -2,5 +2,6 @@
 #
 # (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
 
 obj-y += board.o
+obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += capsule_update.o
 obj-$(CONFIG_OF_LIVE) += of_fixup.o
diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 2ab2ceb51389..fbb6cf7c6599 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -447,8 +447,11 @@ int board_late_init(void)
 
 	configure_env();
 	qcom_late_init();
 
+	/* Configure the dfu_string for capsule updates */
+	qcom_configure_capsule_updates();
+
 	return 0;
 }
 
 static void build_mem_map(void)
diff --git a/arch/arm/mach-snapdragon/capsule_update.c b/arch/arm/mach-snapdragon/capsule_update.c
new file mode 100644
index 000000000000..bf75a9a1b24c
--- /dev/null
+++ b/arch/arm/mach-snapdragon/capsule_update.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Capsule update support for Qualcomm boards.
+ *
+ * Copyright (c) 2024 Linaro Ltd.
+ * Author: Caleb Connolly <caleb.connolly@linaro.org>
+ */
+
+#define pr_fmt(fmt) "QCOM-FMP: " fmt
+
+#include <dm/device.h>
+#include <dm/uclass.h>
+#include <efi.h>
+#include <efi_loader.h>
+#include <malloc.h>
+#include <scsi.h>
+#include <part.h>
+#include <linux/err.h>
+
+#include "qcom-priv.h"
+
+/*
+ * NOTE: for now this implementation only supports the rb3gen2. Supporting other
+ * boards that boot in different ways (e.g. chainloaded from ABL) will require
+ * additional complexity to properly create the dfu string and fw_images array.
+ */
+
+/*
+ * To handle different variants like chainloaded U-Boot here we'll need to
+ * build the fw_images array dynamically at runtime. It looks like
+ * mach-rockchip is a good example for how to do this.
+ * Detecting which image types a board uses is TBD, hence for now we only
+ * support the one new board that runs U-Boot as its primary bootloader.
+ */
+struct efi_fw_image fw_images[] = {
+	{
+		/* U-Boot flashed to the uefi_X partition (e.g. rb3gen2) */
+		.fw_name = u"UBOOT_UEFI_PARTITION",
+		.image_index = 1,
+	},
+};
+
+struct efi_capsule_update_info update_info = {
+	/* Filled in by configure_dfu_string() */
+	.dfu_string = NULL,
+	.num_images = ARRAY_SIZE(fw_images),
+	.images = fw_images,
+};
+
+/* LSB first */
+struct part_slot_status {
+	u16: 2;
+	u16 active : 1;
+	u16: 3;
+	u16 successful : 1;
+	u16 unbootable : 1;
+	u16 tries_remaining : 4;
+};
+
+static int find_boot_partition(const char *partname, struct blk_desc *blk_dev, char *name)
+{
+	int ret;
+	int partnum;
+	struct disk_partition info;
+	struct part_slot_status *slot_status;
+
+	for (partnum = 1;; partnum++) {
+		ret = part_get_info(blk_dev, partnum, &info);
+		if (ret)
+			return ret;
+
+		slot_status = (struct part_slot_status *)&info.type_flags;
+		log_io("%16s: Active: %1d, Successful: %1d, Unbootable: %1d, Tries left: %1d\n",
+		       info.name, slot_status->active,
+		       slot_status->successful, slot_status->unbootable,
+		       slot_status->tries_remaining);
+		/*
+		 * FIXME: eventually we'll want to find the active/inactive variant of the partition
+		 * but on the rb3gen2 these values might all be 0
+		 */
+		if (!strncmp(info.name, partname, strlen(partname))) {
+			log_debug("Found active %s partition: '%s'!\n", partname, info.name);
+			strlcpy(name, info.name, sizeof(info.name));
+			return partnum;
+		}
+	}
+
+	return -1;
+}
+
+/**
+ * qcom_configure_capsule_updates() - Configure the DFU string for capsule updates
+ *
+ * U-Boot is flashed to the boot partition on Qualcomm boards. In most cases there
+ * are two boot partitions, boot_a and boot_b. As we don't currently support doing
+ * full A/B updates, we only support updating the currently active boot partition.
+ *
+ * So we need to find the current slot suffix and the associated boot partition.
+ * We do this by looking for the boot partition that has the 'active' flag set
+ * in the GPT partition vendor attribute bits.
+ */
+void qcom_configure_capsule_updates(void)
+{
+	struct blk_desc *desc;
+	int ret = 0, partnum = -1, devnum;
+	static char dfu_string[32] = { 0 };
+	char name[32]; /* GPT partition name */
+	char *partname = "uefi_a";
+	struct udevice *dev = NULL;
+
+	if (IS_ENABLED(CONFIG_SCSI)) {
+		/* Scan for SCSI devices */
+		ret = scsi_scan(false);
+		if (ret) {
+			debug("Failed to scan SCSI devices: %d\n", ret);
+			return;
+		}
+	}
+
+	uclass_foreach_dev_probe(UCLASS_BLK, dev) {
+		if (device_get_uclass_id(dev) != UCLASS_BLK)
+			continue;
+
+		desc = dev_get_uclass_plat(dev);
+		if (!desc || desc->part_type == PART_TYPE_UNKNOWN)
+			continue;
+		devnum = desc->devnum;
+		partnum = find_boot_partition(partname, desc,
+					      name);
+		if (partnum >= 0)
+			break;
+	}
+
+	if (partnum < 0) {
+		log_err("Failed to find boot partition\n");
+		return;
+	}
+
+	switch (desc->uclass_id) {
+	case UCLASS_SCSI:
+		snprintf(dfu_string, 32, "scsi %d=u-boot.bin part %d", devnum, partnum);
+		break;
+	case UCLASS_MMC:
+		snprintf(dfu_string, 32, "mmc 0=u-boot.bin part %d %d", devnum, partnum);
+		break;
+	default:
+		debug("Unsupported storage uclass: %d\n", desc->uclass_id);
+		return;
+	}
+	log_debug("boot partition is %s, DFU string: '%s'\n", name, dfu_string);
+
+	update_info.dfu_string = dfu_string;
+}
diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
index 0a7ed5eff8b8..74d39197b89f 100644
--- a/arch/arm/mach-snapdragon/qcom-priv.h
+++ b/arch/arm/mach-snapdragon/qcom-priv.h
@@ -2,8 +2,14 @@
 
 #ifndef __QCOM_PRIV_H__
 #define __QCOM_PRIV_H__
 
+#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
+void qcom_configure_capsule_updates(void);
+#else
+void qcom_configure_capsule_updates(void) {}
+#endif /* EFI_HAVE_CAPSULE_SUPPORT */
+
 #if CONFIG_IS_ENABLED(OF_LIVE)
 /**
  * qcom_of_fixup_nodes() - Fixup Qualcomm DT nodes
  *
diff --git a/include/configs/qcom.h b/include/configs/qcom.h
index 5b5ebbd844df..9b41ab9e982b 100644
--- a/include/configs/qcom.h
+++ b/include/configs/qcom.h
@@ -10,5 +10,10 @@
 #define __CONFIGS_SNAPDRAGON_H
 
 #define CFG_SYS_BAUDRATE_TABLE	{ 115200, 230400, 460800, 921600 }
 
+// 2a5aa852-b856-4d97-baa9-5c5f4421551f
+#define QUALCOMM_UBOOT_BOOT_IMAGE_GUID \
+	EFI_GUID(0x2a5aa852, 0xb856, 0x4d97, 0xba, 0xa9, \
+		0x5c, 0x5f, 0x44, 0x21, 0x55, 0x1f)
+
 #endif

-- 
2.46.2

