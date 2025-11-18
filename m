Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25775CF2561
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 23:21:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1CF783B8B;
	Wed, 19 Nov 2025 00:21:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F2oWHjON";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 227A383BD2; Wed, 19 Nov 2025 00:21:27 +0100 (CET)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BD5C83BD2
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 00:21:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-656d9230ceaso1245722eaf.2
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 15:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763508082; x=1764112882; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wfYEdg5KdPlLZqBvMJfkBZ6MKkwJu0H+gA1JDHm6UaA=;
 b=F2oWHjON2gYL3Wived0PKxVNc0UH/9nhZizuD09e7UYDU1dqqRh683c2Sr7cWxs0LX
 qN07UvvUFJRhyhRrfD21pSquPAgsdY4xw3h7dHAueFlaGMwTgz+u6NXzMUjMzKQpo1x7
 WS4Sg7OTO7/2QnAEgVvvehZcSGJew6m260UiiyIjMbWSrtWm8V/MQaDVRwyVm4Htrdfq
 7E1LP2wTeGZmnwv1+yb/fN8M63tsXN50NnRBYxup39pWklCN7xyXR84k0rBmKQKvQq9F
 yO04/OucrHzDsZ0xqM/QsXM6ARqimVGiTEUNIesTB0ukbihcNarhT93QstuVxeJqyrXC
 2GpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763508082; x=1764112882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wfYEdg5KdPlLZqBvMJfkBZ6MKkwJu0H+gA1JDHm6UaA=;
 b=lDs0dP/Xwn5DJ5i+AKH46pnhZtpaFhvMWi33SlsaQiqRaCDIdJcRqvGQPXmPTpnsNS
 V9TNxlSDIDF7JPHcHg9X79Z7+uB8BNCaZH5Jqw6oiC7sik7eco1akv99ZtBVr7RrUMoA
 sBCuimE0XBw+zVeqIrpNNt2/Bg+d5mxzKisbtwLEShd5HG7rO3aJTuzEEYZQ8HrybJnu
 TVhiQ0kX40OsrW2dkmpY1vZSJlulFM4M9q2EqxvkHA3P5+tf1LJrODd35wssf4Qvk62I
 DNZoIgZuKPxwzwjAgJ+8lNx2CgES45AQzEYdd/oq0FYlRiFc/nBpu1fWt2RFlYm144ZL
 8DfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEgb2N+GTnDQ7lTU49P5b40jIScFrh2WYNUZ2FNg+1W9NkAjJXdQSP84anx3juY+M8wXjnxhY=@lists.denx.de
X-Gm-Message-State: AOJu0YxFfIwbt5zUFx9rxeTkLFxsB3L7FwxolBGkRNO8TWPSwuVbwnf2
 SDmCB1ElvcyqZD514RrK7Z/gDXbmZxj8xv8r2Za1h1i5ThDr1gBdSMUhru0Fp20DuZw=
X-Gm-Gg: ASbGnctzyeEMOSqHTzCZmUy3z+qf2MilN7THi5j9OgyqwHb0Y73FkXD1z3zycW0kM4h
 LSt9gK1qoMj4fKjGsSngZgMB5+R/86a14Ks/kSvleZEor82dHvCG9re7Y2pUQUhaWIBoyHA2WSF
 HDI6BvHCvdqk3RUglu/+BJj2Y+DM0MPK0WkHcwQeaV5jv08OM/am1SOrXx28ZCg1KJa+RdZnJcl
 gfpE5xPiJ12RkHMU+0U9SGi/Gv2CVWanV6WWRJ0pbqsJDbbWs0RvbgpJOBASQhalIhMeUirMCf9
 XtUIwbait2M4ls5zs+DFwiZzL5TI8jYxKrHY5dUjAfoZhOK9HqwT6RYFSvrMstssAWd732/7I7M
 Hg3H3wltsT35R2IrcqczQBD1oCY35IFBZx67/ogiNKhj7rY6DHN4UI6irFJWyNbefNhOepHzAAR
 Oqj4wkkysv3XXvGXNybG9/YGNupCS5k0Y=
X-Google-Smtp-Source: AGHT+IFK4evee8A+MAPfUzBZwvgnQjR3nFjAhQO6B+y8ftphPjgDHCAJhQRZIDGlw+3CYK/eeiDAkw==
X-Received: by 2002:a05:6820:2d9b:10b0:654:18f9:10f4 with SMTP id
 006d021491bc7-65733b20cd0mr5973108eaf.0.1763508082294; 
 Tue, 18 Nov 2025 15:21:22 -0800 (PST)
Received: from localhost ([2605:a601:81da:7100:264b:feff:fe59:d7f7])
 by smtp.gmail.com with UTF8SMTPSA id
 46e09a7af769-7c73b11eec6sm7083815a34.18.2025.11.18.15.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 15:21:21 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Minkyu Kang <promsoft@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.denx.de
Subject: [PATCH v3 2/6] board: samsung: e850-96: Add routines for checking
 boot dev
Date: Tue, 18 Nov 2025 17:21:15 -0600
Message-ID: <20251118232119.17928-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251118232119.17928-1-semen.protsenko@linaro.org>
References: <20251118232119.17928-1-semen.protsenko@linaro.org>
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
Changes in v3:
  - (none)

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
2.47.3

