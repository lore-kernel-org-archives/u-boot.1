Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF83CCF9E0
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 06:15:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D840F83804;
	Mon, 27 Oct 2025 07:15:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UIQNlc68";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC7F3836B2; Mon, 27 Oct 2025 07:14:59 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8600E836B4
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 07:14:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c531445494so1341339a34.2
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 23:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761545695; x=1762150495; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yJsq8btvUwsUZu0btwa80g9IQvr66/vLl02V9yFMdMI=;
 b=UIQNlc68MqpsBCNWxYVevaFIl+UPtbm91+kA8B0jYYC98Trj8WL5ISRnExMrj3XwfM
 kYqB2hmGI0YpSbhK/ELlXwH8VBBhpH5BMhYt+KW/obqrtp/EpRM2dLySzOn77XBC6Igb
 LUfvFs/sK8b8n08bHgBU6G8rhhVjciLt28EO5x+p0KajSdIvKk1Sb8ohSwj8fh+4SOVT
 MKxasOExKbTk9dwZ6vT1GxcbZb/7oeTtZlXGvazKyIKfsRA1vX1TcKtUYx+5Jc0eflpp
 FmA+OEq9ldOq/DE2HXfU/9ItqyywZdTJqSsReDenOReI+poOTWvMYA8QSZMDQoxFF5ZW
 brgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761545695; x=1762150495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yJsq8btvUwsUZu0btwa80g9IQvr66/vLl02V9yFMdMI=;
 b=RBGB4+52UZzNHD2o12OVqWi8Tlmj3Mucmryf3NqcAZhRugjzfi6bNlJeF/V0RUopU9
 ek5M5L0+TSmbnDxTzf/7mM1XzSibBSxKPPnxNJxdWGeUxD4ptpZknGJemUx8m4ZkY7+A
 0SRLHV18plefjG9renRBQ0V5jmCtjChBpRG3xL01Og4AfLyQN5mIfrkmJZ2/uBEfaw4n
 uGntCG/gCf11IA2N0kks3rZXZPxYmUSphOVdWxISLtPvlr6Ca7zboJrpBQUlyu+hq7GB
 CTNtqbkbGaU51+BjlfYLnXCBdf1tFDkfxJXP/Jif58nRWkMzaLFDrbqY+sZLagni4s2E
 N6xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcTwFL7Y7UVXJ3XzYuFiauZ7d5Ld8h1sbCuy6L00k0OrIKYwuYYUEn+nAeDB7A99tr/IYfRpo=@lists.denx.de
X-Gm-Message-State: AOJu0YxP7pGckDmeVwk2Kx8eD1hkX0rDZ9EcNp2vW5TClprkt+DIPZBv
 qS+r7Ih4WeRFtXBMsJFjseOzL4b9foXFfity+oIUe5RT9gxwV/0jMiU7wg/2tJ9twIA=
X-Gm-Gg: ASbGncuh1xW1E6yn0w+iHnrPhBYDOYxYUf9BwEeME+LnJKfKaVcKCd1hmVHvofPDNpB
 6iGJcuCmYGf8tmw8dDYAS6TEig4j4GeMMc/OxSX81Mzn/cocwTljEbgnkLacBAu8z/nN7VPN4rA
 OGI3wWMxdrL6FbFQdAr6zgikX1h9RZny3YkG2d/diOxMWOoS0jNecx5boWKcZgK0SLmHkbxAK6j
 Rv1ufmuTsjpE6YlQdyCzhA5tfTowZfrzIWFkDbMP2mWQ7No/gZT7s8diYM568LY68JV+YjrLYLt
 S5+cVCK1LNbiIrY3RqrzR35hoz/9XK6v7jZOpJkvkusWnOQyT3zl9ADjR3wYAyX5/oYi6F4SeqT
 gq2wVm/N7pmXmjd1W8/o35y7uMn8ZPl5BI4mH95D8vMmhJCicgG783+wDmlY4dVYmjT7KY1UXGI
 ySpOhFxcqDgg==
X-Google-Smtp-Source: AGHT+IHxJMFfJfTWxNAIxXpIqFy72A2OGcl+E2nuJEzz/PSK9Waoqi3o7yCjTh0sDqtbk5RDQ+odvA==
X-Received: by 2002:a05:6830:7110:b0:78e:3093:80cb with SMTP id
 46e09a7af769-7c27cc0bcfdmr18241748a34.27.1761545695229; 
 Sun, 26 Oct 2025 23:14:55 -0700 (PDT)
Received: from localhost ([2605:a601:81da:7100:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c5301e3404sm1996246a34.20.2025.10.26.23.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Oct 2025 23:14:54 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 2/5] board: samsung: e850-96: Add routines for checking
 boot dev
Date: Mon, 27 Oct 2025 01:14:49 -0500
Message-Id: <20251027061452.21165-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251027061452.21165-1-semen.protsenko@linaro.org>
References: <20251027061452.21165-1-semen.protsenko@linaro.org>
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
Changes in v2:
  - (none)

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

