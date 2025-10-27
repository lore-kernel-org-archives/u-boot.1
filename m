Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05656CCF9E0
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 05:51:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5457E83804;
	Mon, 27 Oct 2025 06:51:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Am/MyUxS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D44A836B4; Mon, 27 Oct 2025 06:51:12 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDD5C832AD
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 06:51:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7c532d70cfaso1265352a34.1
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 22:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761544267; x=1762149067; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y9Pld6TQDEqSJUZxO12Q8A6wcmvDDEq+9oRPz4tmi9U=;
 b=Am/MyUxSa5ZYD1n8Cmxdojq9hSm2z/310KutrI6RHIGY0ZztJpvfpQhgvG0CxAT3kb
 F0fgwoWxlZzdQN1Dx3qXb6Cb00FbBTFdbTQguPnMI04/ubuYRf8K9+Yq0RBMOz2Nfit3
 hKLa9rgJnBVgN0jAOaAMx3hWkzRKEJ/QFX8TpkoITuce7kr2wGQOsRYA29QdKjwcd7We
 8x3hc5tcRUuPB8H6I+OxUoLhHOvpiv+b6gp90+fng1w2GRJKAd79ksder4AQNTz2nS5X
 NA/yV0rMjhXLIuuPZOioCV6qZfzYFJHy1jSfE7d1enYOGNxXVR6q3GsBGEYMxhe9cprk
 l9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761544267; x=1762149067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y9Pld6TQDEqSJUZxO12Q8A6wcmvDDEq+9oRPz4tmi9U=;
 b=f3tDypRgZRgcKTz63Htmlsua560EIUju4XQA4IuOkjMsysbFDQs5+ah171FxZwfHQ8
 Usgkoz5fGWoOeihjZC/hopZ0JcPhjydfXKK/H+cK50KhGmwW71NaN7tRnpkmoA6Y3I9E
 VXAcdFX1pycxUSWKOIOXimk19y24OpKrgzlln918zcQADHM5wofGqp25OOk0pgo6K8z5
 Pe6iaAklaLrsk46FW6h8eC1QK6rsvgDn3GAlT+nYnKpwSXBR+nNhbJVNvB7PCyr/OgRB
 NKcas+1EffZeGok4gAH2L0e5qvSoBZItaChp02S0UBZ+ljXNZE7T7x2GznJknHUnBuYH
 2IIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmWJBXe8FxbUblLkqjZfrY9jH5MB2vF4vuLuPw8a7ezH5CXXLlUcRYLBzAyrgCX7EvXKHoDy8=@lists.denx.de
X-Gm-Message-State: AOJu0YwehOmf3fzOfPDbayctodJWFjC6SLh5aocA/CMW8VZoLJmLwZsT
 lhN1+E0uKMQF+bnAMp0Tjtuo1kmLUwLoDdH0eB1HzjDCUFqRygpbmWRa9GYVMtOAMQA=
X-Gm-Gg: ASbGncs6pkW7L+txyWvni30beFs94LTIcQMfbuczJlAdEicU4jugTWEpX9T7PeGR+A8
 TCArEBlPGSBcZcldLaI8MYeiBAT6BnaWthPdt6ZUzEvjcd6IHakpkEVs8OEk+nIwewhVPh6dtlB
 i4oUSwIRLmnvkfM2f5uXB/DlsL/FmTkgSwI0/A5Gkmdb37VwvOCboIk6snvcel+KGOdbjOaR4Ke
 NJtUSO7C5MeFFQ0CeCGAJrTGFBl0P/XuUO6Spauk1UJ57q3JQvuSR+8BQbWNz4wJ6a96la4muOY
 SKPQWKLUu2INCh1K0a2Rj/ZZxwEOnUMjxHF08Go5jxYVfTsMuIS3pDVP5EKMILRmhQ/smtPURve
 cYQsBIS/MUmHUwFTq5RYrFf+Aucu5TF52yfJsoxXh+SKraBEZnXuSFn8U1NPJX/rf5kdjZB3z2r
 xXeE0g+R/0R4zyYZki8nmJIm7UPX9XPws=
X-Google-Smtp-Source: AGHT+IGU53RjMButnZpTxQB6leSQSeSNELRUHvRwEb+sP/BP1EIEII6hqu6kKEdcxFtEyJcCh4p5yg==
X-Received: by 2002:a05:6808:c2a6:b0:44d:b760:3d3b with SMTP id
 5614622812f47-44db7604a28mr1662634b6e.26.1761544267515; 
 Sun, 26 Oct 2025 22:51:07 -0700 (PDT)
Received: from localhost ([2605:a601:81da:7100:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-654ef27255bsm1647500eaf.0.2025.10.26.22.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Oct 2025 22:51:07 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	u-boot@lists.denx.de
Subject: [PATCH 2/5] board: samsung: e850-96: Add routines for checking boot
 dev
Date: Mon, 27 Oct 2025 00:51:02 -0500
Message-Id: <20251027055105.720-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251027055105.720-1-semen.protsenko@linaro.org>
References: <20251027055105.720-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Implement functionality to check the current boot device (a device where
the SoC ROM code is loading the bootloaders from). The boot device order
can be changed using the SW1 DIP switch on the E850-96 board (which
controls XOM SoC lines), as stated in [1].

The boot device information is requested from EL3 software using the
corresponding SMC call, which in turn reads it from iRAM memory, which
was written by the ROM code. New routines decode that data and allow the
user to check the current boot device, boot order, etc. That API can be
used further to implement different code flows depending on the current
boot device, e.g.:

  - on eMMC boot: obtain the firmware binaries from eMMC
  - on USB boot: download the firmware over USB instead

No functional change; this patch only adds new functionality but it's
not used yet.

[1] doc/board/samsung/e850-96.rst

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 board/samsung/e850-96/Makefile  |  2 +-
 board/samsung/e850-96/bootdev.c | 99 +++++++++++++++++++++++++++++++++
 board/samsung/e850-96/bootdev.h | 23 ++++++++
 3 files changed, 123 insertions(+), 1 deletion(-)
 create mode 100644 board/samsung/e850-96/bootdev.c
 create mode 100644 board/samsung/e850-96/bootdev.h

diff --git a/board/samsung/e850-96/Makefile b/board/samsung/e850-96/Makefile
index 76b8d47994e8..e9c62d3181fd 100644
--- a/board/samsung/e850-96/Makefile
+++ b/board/samsung/e850-96/Makefile
@@ -3,4 +3,4 @@
 # Copyright (C) 2024, Linaro Limited
 # Sam Protsenko <semen.protsenko@linaro.org>
 
-obj-y := e850-96.o fw.o acpm.o pmic.o
+obj-y := e850-96.o fw.o acpm.o pmic.o bootdev.o
diff --git a/board/samsung/e850-96/bootdev.c b/board/samsung/e850-96/bootdev.c
new file mode 100644
index 000000000000..7d5ae7128f49
--- /dev/null
+++ b/board/samsung/e850-96/bootdev.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2025 Linaro Ltd.
+ * Author: Sam Protsenko <semen.protsenko@linaro.org>
+ *
+ * Routines for checking current boot device.
+ */
+
+#include <linux/arm-smccc.h>
+#include <vsprintf.h>
+#include "bootdev.h"
+
+/* Flag from BL2 bootloader in RAM */
+#define BL2_TAG_ADDR			0x80000000	/* DRAM base */
+#define BL2_TAG				0xabcdef
+
+/* Boot device info location in iRAM (only accessible from EL3) */
+#define IRAM_BASE			0x02020000
+#define BOOTDEVICE_INFO_ADDR		(IRAM_BASE + 0x64)
+
+/* SMC call for getting boot device information from EL3 monitor */
+#define SMC_CMD_CHECK_SECOND_BOOT	-233
+
+/* Boot device constants for the encoded boot device info value */
+#define BD_NO_DEVICE			0x0
+#define BD_UFS				0x1
+#define BD_EMMC				0x2
+#define BD_ERROR			0x3
+#define BD_USB				0x4
+#define BD_SDMMC			0x5
+#define BD_UFS_CARD			0x6
+#define BD_SPI				0x7
+
+/* If BL2 bootloader wasn't executed, it means U-Boot is running via JTAG */
+static bool bootdev_is_jtag_session(void)
+{
+	u32 bl2_tag_val = *(u32 *)BL2_TAG_ADDR;
+
+	return bl2_tag_val != BL2_TAG;
+}
+
+/* Obtain boot device information encoded in 32-bit value */
+static u32 bootdev_get_info(void)
+{
+	u32 info;
+
+	/*
+	 * On regular boot U-Boot is executed by BL2 bootloader, and is running
+	 * in EL1 mode, so the boot device information has to be obtained via
+	 * SMC call from EL3 software (EL3 monitor), which can read that info
+	 * from the protected iRAM memory. If U-Boot is running via TRACE32 JTAG
+	 * (in EL3 mode), read the boot device info directly from iRAM, as EL3
+	 * software might not be available.
+	 */
+	if (bootdev_is_jtag_session()) {
+		info = *(u32 *)BOOTDEVICE_INFO_ADDR;
+	} else {
+		struct arm_smccc_res res;
+
+		arm_smccc_smc(SMC_CMD_CHECK_SECOND_BOOT, 0, 0, 0, 0, 0, 0, 0,
+			      &res);
+		info = (u32)res.a2;
+	}
+
+	return info;
+}
+
+enum bootdev bootdev_get_current(void)
+{
+	u32 info, magic, order, dev;
+
+	info = bootdev_get_info();
+	magic = info >> 24;
+	order = info & 0xf;
+	dev = (info >> (4 * order)) & 0xf;
+
+	if (magic != 0xcb)
+		panic("Abnormal boot");
+
+	switch (dev) {
+	case BD_UFS:
+		return BOOTDEV_UFS;
+	case BD_EMMC:
+		return BOOTDEV_EMMC;
+	case BD_USB:
+		return BOOTDEV_USB;
+	case BD_SDMMC:
+		return BOOTDEV_SD;
+	default:
+		return BOOTDEV_ERROR;
+	}
+
+	return BOOTDEV_ERROR;
+}
+
+bool bootdev_is_usb(void)
+{
+	return bootdev_get_current() == BOOTDEV_USB;
+}
diff --git a/board/samsung/e850-96/bootdev.h b/board/samsung/e850-96/bootdev.h
new file mode 100644
index 000000000000..5f454bf00901
--- /dev/null
+++ b/board/samsung/e850-96/bootdev.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2025 Linaro Ltd.
+ * Sam Protsenko <semen.protsenko@linaro.org>
+ */
+
+#ifndef __E850_96_BOOTDEV_H
+#define __E850_96_BOOTDEV_H
+
+#include <stdbool.h>
+
+enum bootdev {
+	BOOTDEV_ERROR,
+	BOOTDEV_SD,
+	BOOTDEV_EMMC,
+	BOOTDEV_USB,
+	BOOTDEV_UFS,
+};
+
+enum bootdev bootdev_get_current(void);
+bool bootdev_is_usb(void);
+
+#endif /* __E850_96_BOOTDEV_H */
-- 
2.39.5

