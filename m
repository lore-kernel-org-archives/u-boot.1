Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DC1C47DA2
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 17:15:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41D4287A4B;
	Tue, 16 Jan 2024 18:14:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cBY2UhU0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F2C887957; Tue, 16 Jan 2024 18:14:43 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C07C187A2A
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 18:14:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4299f424e55so34198331cf.1
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 09:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705425279; x=1706030079; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sh1PboXM4KWGx4Dn9iKPRhwy3ZKG9+ed3EIYhUX8XFU=;
 b=cBY2UhU0fYO3JAQR7zvUvGG0IO5OB54ug6AYnRrMYY6J/uzQxZ4m8cNQwQuPAAw5wj
 4nkBV7Lf9zqrW6GKvmjCnUvOXx+ISC9fv9d3IyRXFuFb+NSFiHyJ9FS9s86mKoZleSwY
 8iAVEVGy/oSou5kajyI0nJ9Pje+eNT3JnJlSTB/KlOn3Shl/pIERqdJXT6JO5F/V3ZQR
 yYjSDsYf5Rb4hmGyXhQKp89eS7K0G/UMvgW4FtjHkLHgzEraQyWefvlvcziFdZP4Y7Ww
 7m30t1Ln5XKRsPB0gV1b8lFaDlW4Qyi0jg5x6KA0K1ycIJ/WYneYo0VL0thNVUaVG6pW
 AlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705425279; x=1706030079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sh1PboXM4KWGx4Dn9iKPRhwy3ZKG9+ed3EIYhUX8XFU=;
 b=aGGjmyGw2lgXyfWfDKYTrgB9ONFNV8vTBXZE7PCDf8Z4feGu/l3bO4N0Bj+T33DEpq
 YnUKbhG6xMgKsLyyuo00CfXI2sOhLdy/C4K+8zH5vJlttSGKyu4Qj2DrWUzcMYykAUfy
 o9oKStk8+cIJU+//kiFMibOzev/NVEb5QW/6SNUcDgi3ADtN+zLVCu6JTuBWnm1opTSX
 7hRkwEmnQPFBjPPoiyQ+zOL2Q4bmAI54UtTkUKPolnKWT1pmAZSTAusBhAXVKJVl2IEW
 sf8c34jTge8N91xq7FUCYQZQyPan8A002qtPLwjlLXDN++Poq4Fc0OwtPdxCP5pnG6Md
 Kf9A==
X-Gm-Message-State: AOJu0Yy2ZHLBYlZBJxJ4AxHFPLgs78tUeGy7LeOntwVSawPz9KKpwwmv
 qVLKTl1yYZL+KRKAxJ5vngVP+P0kQ9xHfj1NjiMaJ0BcK/s=
X-Google-Smtp-Source: AGHT+IFXTBjg7hN5oeRho504gN1NYtZkzY+BEYMrgh9TbHCf/180+126uSL9LCNMuYHNKshPhHcw7Q==
X-Received: by 2002:a05:622a:256:b0:42a:c6e:fd8f with SMTP id
 c22-20020a05622a025600b0042a0c6efd8fmr152168qtx.69.1705425279395; 
 Tue, 16 Jan 2024 09:14:39 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 bp43-20020a05622a1bab00b00427e0e9c22dsm4988291qtb.54.2024.01.16.09.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 09:14:39 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Fabio Estevam <festevam@denx.de>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 Yang Xiwen <forbidden405@outlook.com>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 Peng Fan <peng.fan@nxp.com>, Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <seanga2@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH v6 6/7] arm: Get bloblist from boot arguments
Date: Tue, 16 Jan 2024 09:13:51 -0800
Message-Id: <20240116171356.376801-7-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240116171356.376801-1-raymond.mao@linaro.org>
References: <20240116171356.376801-1-raymond.mao@linaro.org>
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

Add arch custom function to get bloblist from boot arguments.
Check whether boot arguments aligns with the register conventions
defined in FW Handoff spec v0.9.
Add bloblist related options into qemu-arm default config.
Remove OF_HAS_PRIOR_STAGE and OF_BOARD from qemu-arm config.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Remove low level code for copying boot arguments.
- Refactor board_fdt_blob_setup() and remove direct access of gd->bloblist.
Changes in v3
- Optimize board_bloblist_from_boot_arg().
Changes in v4
- Move the function as an Arm-arch library instead of a board-specific one.
Changes in V5
- Drop the dependence on OF_BOARD.
- Move external declaration to header file.
- Adjust the position of BLOBLIST in defconfig file.
Changes in V6
- Drop imply OF_HAS_PRIOR_STAGE from qemu-arm.

 arch/arm/Kconfig             |  1 -
 arch/arm/lib/Makefile        |  2 ++
 arch/arm/lib/xferlist.c      | 27 +++++++++++++++++++++++++++
 arch/arm/lib/xferlist.h      | 19 +++++++++++++++++++
 configs/qemu_arm64_defconfig |  3 +++
 5 files changed, 51 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/lib/xferlist.c
 create mode 100644 arch/arm/lib/xferlist.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2d4458b7b5..745b68f20f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1047,7 +1047,6 @@ config ARCH_QEMU
 	imply DM_RNG
 	imply DM_RTC
 	imply RTC_PL031
-	imply OF_HAS_PRIOR_STAGE
 	imply VIDEO
 	imply VIDEO_BOCHS
 	imply SYS_WHITE_ON_BLACK
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index b1bcd37466..67275fba61 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -85,6 +85,8 @@ obj-y	+= psci-dt.o
 
 obj-$(CONFIG_DEBUG_LL)	+= debug.o
 
+obj-$(CONFIG_BLOBLIST)  += xferlist.o
+
 # For EABI conformant tool chains, provide eabi_compat()
 ifneq (,$(findstring -mabi=aapcs-linux,$(PLATFORM_CPPFLAGS)))
 extra-y	+= eabi_compat.o
diff --git a/arch/arm/lib/xferlist.c b/arch/arm/lib/xferlist.c
new file mode 100644
index 0000000000..e9734959dc
--- /dev/null
+++ b/arch/arm/lib/xferlist.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
+ */
+#include <linux/types.h>
+#include <errno.h>
+#include <bloblist.h>
+#include "xferlist.h"
+
+int xferlist_from_boot_arg(ulong addr, ulong size)
+{
+	int ret;
+
+	ret = bloblist_check(saved_args[3], size);
+	if (ret)
+		return ret;
+
+	/* Check the register conventions */
+	ret = bloblist_check_reg_conv(saved_args[0], saved_args[2],
+				      saved_args[1]);
+	if (!ret)
+		/* Relocate the bloblist to the fixed address */
+		ret = bloblist_reloc((void *)addr, size);
+
+	return ret;
+}
diff --git a/arch/arm/lib/xferlist.h b/arch/arm/lib/xferlist.h
new file mode 100644
index 0000000000..60d79c1a8e
--- /dev/null
+++ b/arch/arm/lib/xferlist.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0+ BSD-3-Clause */
+/*
+ * Copyright (C) 2023 Linaro Limited
+ * Author: Raymond Mao <raymond.mao@linaro.org>
+ */
+
+#ifndef _XFERLIST_H_
+#define _XFERLIST_H_
+
+/*
+ * Boot parameters saved from start.S
+ * saved_args[0]: FDT base address
+ * saved_args[1]: Bloblist signature
+ * saved_args[2]: must be 0
+ * saved_args[3]: Bloblist base address
+ */
+extern unsigned long saved_args[];
+
+#endif /* _XFERLIST_H_ */
diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 5100e193be..80a5409c51 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -27,6 +27,9 @@ CONFIG_USE_PREBOOT=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_PCI_INIT_R=y
+CONFIG_BLOBLIST=y
+CONFIG_BLOBLIST_ADDR=0x40004000
+CONFIG_BLOBLIST_SIZE=0x4000
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
-- 
2.25.1

