Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492FBC001DE
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 09:05:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98D2F86CAC;
	Fri, 18 Aug 2023 11:05:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="edwjhycW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E98286C77; Fri, 18 Aug 2023 11:05:13 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3B4886C39
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 11:05:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9a1681fa868so18582266b.3
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 02:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692349510; x=1692954310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ri0sQtOdq6WBatEQEsgkrT023IyNXkjJ5uLxiGYZvX4=;
 b=edwjhycWRRGyIHdQMpQmLIH71Ha9bQlEveSS9sO/cnO8VRoeme07fnao3SOT1Fby4g
 xymgZnoI9KUek62tlA9PFn0qzOXiqk7BsH+7W2gicnFj6ksEmdI7eq6MzvbSUn35k4mC
 YmW8+N65lwFxKi06vuxgZRXKcYaB5x5XfaXON/1J62uOa0wI/ReEwNYchDLUDGPrfTjf
 AU7QxqKC++IwJJjF/6S6QMuO4uUxqBsNEMlDUOSOCieiHtabpyWZYK+oOG4bJIWjVqN8
 wKu97efLP7b5eadQyt0SnFclWNae5v4daboyRDWc3gonTIWczMjNOka0Ha0E3Gw1np06
 K+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692349510; x=1692954310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ri0sQtOdq6WBatEQEsgkrT023IyNXkjJ5uLxiGYZvX4=;
 b=WePEdJOeYx4LQVaeJWgDAgOAXcS+7Ph+V/8qQl8pwpaAHoog1rQUbC66hc9EL/XlWa
 yCpPVWxaLyKEVnU4p4FPArTnIYcdGYb13myYbBraS1kxQmQaDNTGyXBpU6ULiKyN5yR3
 k4yVtPs9cxcTdqxrAsE/9uqvCgNQsUpZb25Y6RFGfnOA2u2F+8rTAdcVbvroQH382gCT
 CW8jfjL9Qa5Wr1hgpjNWfUdVpR/3unY4DAPY+EquhCEmFMEq8YOtHzoCaEP+hjh6tc/2
 WU5VzPc+pAMRXcIWw7L5CwIonOsfsn+TBYMPluZXYc4yzrIys033QniHYntNbG4e6Vjs
 fykA==
X-Gm-Message-State: AOJu0YzkEuUGMtGireCztcpHy+8jg0D7sGeYLz2e80ypS5d9aDlD0rS0
 J5kasvhtbOUSvEDpOiGunF8=
X-Google-Smtp-Source: AGHT+IH1qanoPrvpO+53vNgJ8OqePqBCpPyW/yvyJ2rqmTMjRK2Ns4NhpXIvDlJP/7urSPHzj3O1bg==
X-Received: by 2002:a17:906:9d1:b0:992:13c7:563 with SMTP id
 r17-20020a17090609d100b0099213c70563mr1333436eje.75.1692349510197; 
 Fri, 18 Aug 2023 02:05:10 -0700 (PDT)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 va30-20020a17090711de00b0099ce025f8ccsm926772ejb.186.2023.08.18.02.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 02:05:09 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Maxim Schwalm <maxim.schwalm@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v9 3/7] ARM: tegra: add SoC UID calculation function
Date: Fri, 18 Aug 2023 12:04:43 +0300
Message-Id: <20230818090447.348820-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230818090447.348820-1-clamor95@gmail.com>
References: <20230818090447.348820-1-clamor95@gmail.com>
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

This is a small tool for calculation of SoC UID based on the same
Linux function. It can be further used for generation of device
unique data like mac address or exposing it as serial number.

Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS Grouper E1565
Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # LG P895 T30
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/include/asm/arch-tegra/fuse.h |   7 ++
 arch/arm/mach-tegra/Makefile           |   4 +
 arch/arm/mach-tegra/fuse.c             | 151 +++++++++++++++++++++++++
 3 files changed, 162 insertions(+)
 create mode 100644 arch/arm/mach-tegra/fuse.c

diff --git a/arch/arm/include/asm/arch-tegra/fuse.h b/arch/arm/include/asm/arch-tegra/fuse.h
index 5b8e0bd8d1..f3f2ad8e3f 100644
--- a/arch/arm/include/asm/arch-tegra/fuse.h
+++ b/arch/arm/include/asm/arch-tegra/fuse.h
@@ -19,4 +19,11 @@ struct fuse_regs {
 	u32 security_mode;		/* 0x1A0: FUSE_SECURITY_MODE */
 };
 
+/**
+ * Calculate SoC UID
+ *
+ * Return: uid if ok, 0 on error
+ */
+unsigned long long tegra_chip_uid(void);
+
 #endif	/* ifndef _FUSE_H_ */
diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 9147050b32..a5733b0bf6 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -32,6 +32,10 @@ endif
 obj-$(CONFIG_DISPLAY_CPUINFO) += sys_info.o
 obj-y += pmc.o
 
+ifndef CONFIG_TEGRA186
+obj-y += fuse.o
+endif
+
 obj-$(CONFIG_TEGRA20) += tegra20/
 obj-$(CONFIG_TEGRA30) += tegra30/
 obj-$(CONFIG_TEGRA114) += tegra114/
diff --git a/arch/arm/mach-tegra/fuse.c b/arch/arm/mach-tegra/fuse.c
new file mode 100644
index 0000000000..83bd505538
--- /dev/null
+++ b/arch/arm/mach-tegra/fuse.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  (C) Copyright 2012-2013
+ *  NVIDIA Corporation <www.nvidia.com>
+ *
+ *  (C) Copyright 2022
+ *  Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <common.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+
+#include <asm/arch/tegra.h>
+#include <asm/arch/gp_padctrl.h>
+#include <asm/arch/clock.h>
+#include <asm/arch-tegra/fuse.h>
+
+#include "cpu.h"
+
+#define FUSE_UID_LOW		0x108
+#define FUSE_UID_HIGH		0x10c
+
+#define FUSE_VENDOR_CODE	0x200
+#define FUSE_FAB_CODE		0x204
+#define FUSE_LOT_CODE_0		0x208
+#define FUSE_LOT_CODE_1		0x20c
+#define FUSE_WAFER_ID		0x210
+#define FUSE_X_COORDINATE	0x214
+#define FUSE_Y_COORDINATE	0x218
+
+#define FUSE_VENDOR_CODE_MASK	0xf
+#define FUSE_FAB_CODE_MASK	0x3f
+#define FUSE_WAFER_ID_MASK	0x3f
+#define FUSE_X_COORDINATE_MASK	0x1ff
+#define FUSE_Y_COORDINATE_MASK	0x1ff
+
+static u32 tegra_fuse_readl(unsigned long offset)
+{
+	return readl(NV_PA_FUSE_BASE + offset);
+}
+
+static void tegra_fuse_init(void)
+{
+	u32 reg;
+
+	/*
+	 * Performed by downstream and is not
+	 * documented by TRM. Whithout setting
+	 * this bit fuse region will not work.
+	 */
+	reg = readl_relaxed(NV_PA_CLK_RST_BASE + 0x48);
+	reg |= BIT(28);
+	writel(reg, NV_PA_CLK_RST_BASE + 0x48);
+
+	clock_enable(PERIPH_ID_FUSE);
+	udelay(2);
+	reset_set_enable(PERIPH_ID_FUSE, 0);
+}
+
+unsigned long long tegra_chip_uid(void)
+{
+	u64 uid = 0ull;
+	u32 reg;
+	u32 cid;
+	u32 vendor;
+	u32 fab;
+	u32 lot;
+	u32 wafer;
+	u32 x;
+	u32 y;
+	u32 i;
+
+	tegra_fuse_init();
+
+	/* This used to be so much easier in prior chips. Unfortunately, there
+	   is no one-stop shopping for the unique id anymore. It must be
+	   constructed from various bits of information burned into the fuses
+	   during the manufacturing process. The 64-bit unique id is formed
+	   by concatenating several bit fields. The notation used for the
+	   various fields is <fieldname:size_in_bits> with the UID composed
+	   thusly:
+	   <CID:4><VENDOR:4><FAB:6><LOT:26><WAFER:6><X:9><Y:9>
+	   Where:
+		Field    Bits  Position Data
+		-------  ----  -------- ----------------------------------------
+		CID        4     60     Chip id
+		VENDOR     4     56     Vendor code
+		FAB        6     50     FAB code
+		LOT       26     24     Lot code (5-digit base-36-coded-decimal,
+					re-encoded to 26 bits binary)
+		WAFER      6     18     Wafer id
+		X          9      9     Wafer X-coordinate
+		Y          9      0     Wafer Y-coordinate
+		-------  ----
+		Total     64
+	*/
+
+	switch (tegra_get_chip()) {
+	case CHIPID_TEGRA20:
+		/* T20 has simple calculation */
+		return ((unsigned long long)tegra_fuse_readl(FUSE_UID_HIGH) << 32ull) |
+			(unsigned long long)tegra_fuse_readl(FUSE_UID_LOW);
+	case CHIPID_TEGRA30:
+		/* T30 chip id is 0 */
+		cid = 0;
+		break;
+	case CHIPID_TEGRA114:
+		/* T11x chip id is 1 */
+		cid = 1;
+		break;
+	case CHIPID_TEGRA124:
+		/* T12x chip id is 3 */
+		cid = 3;
+		break;
+	case CHIPID_TEGRA210:
+		/* T210 chip id is 5 */
+		cid = 5;
+	default:
+		return 0;
+	}
+
+	vendor = tegra_fuse_readl(FUSE_VENDOR_CODE) & FUSE_VENDOR_CODE_MASK;
+	fab = tegra_fuse_readl(FUSE_FAB_CODE) & FUSE_FAB_CODE_MASK;
+
+	/* Lot code must be re-encoded from a 5 digit base-36 'BCD' number
+	   to a binary number. */
+	lot = 0;
+	reg = tegra_fuse_readl(FUSE_LOT_CODE_0) << 2;
+
+	for (i = 0; i < 5; ++i) {
+		u32 digit = (reg & 0xFC000000) >> 26;
+		lot *= 36;
+		lot += digit;
+		reg <<= 6;
+	}
+
+	wafer = tegra_fuse_readl(FUSE_WAFER_ID) & FUSE_WAFER_ID_MASK;
+	x = tegra_fuse_readl(FUSE_X_COORDINATE) & FUSE_X_COORDINATE_MASK;
+	y = tegra_fuse_readl(FUSE_Y_COORDINATE) & FUSE_Y_COORDINATE_MASK;
+
+	uid = ((unsigned long long)cid  << 60ull)
+	    | ((unsigned long long)vendor << 56ull)
+	    | ((unsigned long long)fab << 50ull)
+	    | ((unsigned long long)lot << 24ull)
+	    | ((unsigned long long)wafer << 18ull)
+	    | ((unsigned long long)x << 9ull)
+	    | ((unsigned long long)y << 0ull);
+
+	return uid;
+}
-- 
2.39.2

