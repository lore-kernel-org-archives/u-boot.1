Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272FAC25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 17:18:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50A668837D;
	Mon, 27 May 2024 19:18:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="is8W8VSR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 279738837A; Mon, 27 May 2024 19:17:59 +0200 (CEST)
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com
 [IPv6:2a00:1450:4864:20::242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88D1188385
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 19:17:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x242.google.com with SMTP id
 38308e7fff4ca-2e719bab882so111759801fa.3
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 10:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716830276; x=1717435076; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=86mUaD1/vTfxTWu9OPghZY4V0R/+KpfioAzFBHX9LDw=;
 b=is8W8VSRtjo0rB7B8KSSN2GprgBjZW7Ot+5kVumCSLFezotNUNEcT+MsIZ8XfydTH1
 pN0TiGJaWFg8yfYOyAnnu+XFAuvbSofg2BHp8aZfPdcpZ5HrjW+ryjRmyaHffLUkgrLc
 8AAEuhrP6qDFWG+1lTT7VhxxRXHz++LXLh2KTIyINob/dQdpFqx6PMwaPV+XkoPU/iKw
 7BXSb6wRcu1ZR0Im3ctjg5FIS7p0xrMzwX0uoSoTi7J9AEiezLywXBF9E4miig6XBB5A
 PSSeF8BN6IR2kJH9PVnK4E9ZmfX1mAezAvfbsq+ea5+8qCiXTthfVbHu1NuAUzBDCcPu
 hJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716830276; x=1717435076;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=86mUaD1/vTfxTWu9OPghZY4V0R/+KpfioAzFBHX9LDw=;
 b=EVBgVQ6sGqmHxNeXlN7+EYo+xlXx7AXxY1Bz9m3MWq8MGIJ0HgOUxcbDghuNfJWm8Y
 avGKE921qNlPJOZy3UtI/slKwXi/XlqwE9R7nsu2dly9g2I3AWwNmXFnTcH2uA3d2S+J
 lhjpljdA4Ae6/vHAsFvQwARI4Cd6GZxBPC9B7A8NH7ALLxAQZVDzXZ4uFzTySXuPEbWt
 D4lbGhkIqf7kY+dR4i+zUwkt8tuEEDPwMVqEVTqN03Sg+HJbU9Npp2yBNCv1bdUlrCeO
 XFo6qianoe+dZ9fQfIxlquSh8q4UTM1viLjXiRSAxPkpmimHTuo0rodXkl+dS5TM4IUn
 C6dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgZwpY3tj/BLLmLO9OioggVIte2kncffAD9z8xv5KNMmUDdmcC/9lXXYHmD3GUm1BAbNkFS8KiQ7gI9tVNznFdWHyQcQ==
X-Gm-Message-State: AOJu0YxpaWcSnBeeCTor2g28XRLEMqufl1exGIMYSFVQB2pP9OqSYkLA
 CR1iS3Bu18u3XQ0vix7LSE/D85GGAgyJ3k2tJUpjS1U8LWq/PayR+QNTQ6hXb/A=
X-Google-Smtp-Source: AGHT+IHQ763NCgqgIWNT33lU9veYDr0oWEqavQY7ysbm/+qs8fPdoMEh+MLtZUzWUYjHM8gpjVo7RA==
X-Received: by 2002:ac2:5181:0:b0:51d:97e8:b780 with SMTP id
 2adb3069b0e04-52966bb1fcemr5858558e87.44.1716830275935; 
 Mon, 27 May 2024 10:17:55 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc8b874sm509469266b.163.2024.05.27.10.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 10:17:55 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 27 May 2024 19:17:52 +0200
Subject: [PATCH v2 4/8] mach-snapdragon: implement capsule update support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-b4-qcom-capsule-updates-v2-4-47583d7ad428@linaro.org>
References: <20240527-b4-qcom-capsule-updates-v2-0-47583d7ad428@linaro.org>
In-Reply-To: <20240527-b4-qcom-capsule-updates-v2-0-47583d7ad428@linaro.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7614;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=EpMPrXl1BpsSBb6KK0OxGXPTs1+7bPTJNY03PRK3KtI=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmVMA+bfWJV25PvKaOuYJ1+KxsuYkLxHZsuStGW
 evVY1L1mJaJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZlTAPgAKCRAFgzErGV9k
 to3BD/9WXMynkxPSaPpn8r0s+yl8ULY3307eC6ybW3Ds4zpPrcLY5oHS2vpP0H+DRoADBlIzU5U
 6w4wn4BqzGbZCPGf49WJAi5yNbk2R1Xtt5Sny+00dN21I5f9I6NSa0Ru4qYJuoal+tIVdNNWemA
 32x4MK4QG8LjrvwPOc+/97yY2QJ2CP7TNyKmMDNKAhLKiE2ChVtEv4GyaQb3llmjEF0EW5d84Hg
 KvbnHeEEW0Q/tdexLKSq01wApGNog75OWxuYYr9HpUHy/b03hWPJuDr8XVYtaIGd8vk2gFHtg2w
 EwVlzkDxSDloshC4l73qgpCLM5W17WmuY3y1DIY0Z572oiQnxvFvEho5Wk6DBVe/5Je99wD7xww
 DFRXBsnedwB2ZY1san6BG7JZypKn215oKUqLPEL8JdT0WTmUGEaGETk7uYBNWDUaDmep7mh88Lv
 R8Omrep5j2MyFZRffqo2EtjM5ibHYtgdkpP/gxVop/z8it2mJPm5yqvcSrOZSehZT7/P4Uxpj/n
 Iuh+WbtY1bumKP8k6Q0ZhA7FeOnuA1iptZbMIWFqw6qUfdnrwqhykmzrHEmbAfec3ys1kw7nXdD
 f+WO5qlFDSWSy/Al++5hSjOlwvgsbxcQuuzXK/ArJy9qwpeOv4lmmQpH6jv+AOkOLAv8J62Gkc0
 Q/9Gcb42LWllQ3A==
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

Qualcomm boards flash U-Boot to the boot partition, implement support
for determining which slot U-Boot is running from and finding the
correct boot partition for that slot and configuring the appropriate DFU
string.

For now this only supports boards with SCSI/UFS storage where U-Boot is
flashed to the boot partition, and only U-Boot itself is updated. In the
future we may also support updating additional firmware components (tz,
hyp, xbl) as well as having U-Boot installed to other partitions (e.g.
as a first-stage bootloader).

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/Makefile         |   1 +
 arch/arm/mach-snapdragon/board.c          |   3 +
 arch/arm/mach-snapdragon/capsule_update.c | 147 ++++++++++++++++++++++++++++++
 arch/arm/mach-snapdragon/qcom-priv.h      |   6 ++
 include/configs/qcom.h                    |   5 +
 5 files changed, 162 insertions(+)

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
index b439a19ec7eb..c4a3394706e6 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -299,8 +299,11 @@ int board_late_init(void)
 
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
index 000000000000..505f5bf5ae07
--- /dev/null
+++ b/arch/arm/mach-snapdragon/capsule_update.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Common initialisation for Qualcomm Snapdragon boards.
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
+struct efi_fw_image fw_images[] = {
+	{
+		.image_type_id = QUALCOMM_UBOOT_BOOT_IMAGE_GUID,
+		.fw_name = u"QUALCOMM-UBOOT",
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
+		if (!strncmp(info.name, partname, strlen(partname)) && slot_status->active) {
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
+	char *partname = "boot";
+	struct udevice *dev = NULL;
+
+	/*
+	 * There is currently no good way to check how U-Boot is booting, but we have
+	 * a few hueristics, like here checking if our DTB has a kaslr-seed specified
+	 * will tell us if we were chainloaded by another bootloader.
+	 * FIXME: we should do this check once and use some proper API to expose the data.
+	 */
+	if (!ofnode_has_property(ofnode_path("/chosen"), "kaslr-seed")) {
+		log_debug("No initrd address present, skip as we might not be chainloaded\n");
+		return;
+	}
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
+		snprintf(dfu_string, 32, "scsi %d=u-boot-bin part %d", devnum, partnum);
+		break;
+	case UCLASS_MMC:
+		snprintf(dfu_string, 32, "mmc 0=u-boot-bin part %d %d", devnum, partnum);
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
index e50b3bce5cdd..b6b5acffe5e4 100644
--- a/include/configs/qcom.h
+++ b/include/configs/qcom.h
@@ -10,8 +10,13 @@
 #define __CONFIGS_SNAPDRAGON_H
 
 #define CFG_SYS_BAUDRATE_TABLE	{ 115200, 230400, 460800, 921600 }
 
+// 2a5aa852-b856-4d97-baa9-5c5f4421551f
+#define QUALCOMM_UBOOT_BOOT_IMAGE_GUID \
+	EFI_GUID(0x2a5aa852, 0xb856, 0x4d97, 0xba, 0xa9, \
+		0x5c, 0x5f, 0x44, 0x21, 0x55, 0x1f)
+
 /* Load addressed are calculated during board_late_init(). See arm/mach-snapdragon/board.c */
 #define CFG_EXTRA_ENV_SETTINGS \
 	"stdin=serial,button-kbd\0"	\
 	"stdout=serial,vidconsole\0"	\

-- 
2.45.0

