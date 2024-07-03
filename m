Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB43CC30653
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 13:48:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CD8088861;
	Wed,  3 Jul 2024 15:46:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=bade.nz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=bade.nz header.i=@bade.nz header.b="Mhe8ueaY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF0BB887D5; Wed,  3 Jul 2024 10:41:09 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A450788599
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 10:41:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=bade.nz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=leith@leithalweapon.geek.nz
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-652fd0bb5e6so3475059a12.0
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 01:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bade.nz; s=google; t=1719996062; x=1720600862; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xSJ7oo71ly7/RapeDbzrQ1diRwU7ySkJp2Pph2Pftzo=;
 b=Mhe8ueaYakBhYd3D3xIEvX5TMiI+2xU8cCkweqpz10epx7WD3hO8XATZJQsGxOcV/0
 x8hgbfPm7CHtD1zK+ACPQ4rsLBuW+fVgboucptPt5kxeACzbe15gbI0JSyfH7Rf3rymI
 woP75U3zInFRl376FDSZKy8LIkxZ0DvmGcXPnRe7qPfKM6D/GD605aPrUZaztYB/Vc3q
 O2VrnEYtT+lQbxdypwpyqKo78/6cwkaauxjdYvKcNARylo0ph47jrhzGHJU6+r0FqfoJ
 8eRZXuD0rXnZT46oeojd7bPgBICyIyG/I6vdOQj+PqXw0F7tfC5h6nk4E2eO7EUFlDFB
 GyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719996062; x=1720600862;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xSJ7oo71ly7/RapeDbzrQ1diRwU7ySkJp2Pph2Pftzo=;
 b=TKXXOwpgJPBq26PgsF+iqst5ls5tuRKugCH/3iyPrAaMxPulrI3qFhM35iWZFWWsEi
 0AuRetQ7nMiHfGjoAUxX1aWj8nXcDBVPWgielTPfJzKpLII/lXSdxn9bid96ec5ZlgfN
 t3B6FIhAmc5PVhRS7nKfW7Lb4bHVT8z+s311NcjxwDspMbpP5g40rn8LRg27X3Tr7+DT
 jZUlFUiKSdTHLMF+A9IqBhZU8nt7Pyt+1LJ3+LdS3Tp0gEMVelLJES1hK4w3cE/1b/LB
 1mNGZnomvfir5nGuI8dAj+UM8swcDE8OU9nCY7y9HWBH6GNswo1I2BnMyr/OVuZPBOXX
 GUdQ==
X-Gm-Message-State: AOJu0YySGCUJWwIiKaduqw7PmfriOZUl+HCtbwS8l+oVa6B+NgfnFuqg
 UgeIgaTm1uTJe9osBOLc8S1d5NLN0TkWhfg1PX6u/iZO340pSKx1HWuWrRg7SX40Dz3pGMGMdJ/
 ksSMU
X-Google-Smtp-Source: AGHT+IG2aJ1+VUdTH7imCJ3IGU6rjjeM6v8DbosInVkyC+6Ttio6xlAhI05L+OpyHB3HrzF73D5vbg==
X-Received: by 2002:a05:6a20:488a:b0:1be:c58a:7433 with SMTP id
 adf61e73a8af0-1bef6265d1amr10848623637.59.1719996061664; 
 Wed, 03 Jul 2024 01:41:01 -0700 (PDT)
Received: from localhost.localdomain ([2403:5816:cd6c:0:3a8b:2d58:1092:c2d2])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fb13059efasm9803275ad.41.2024.07.03.01.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 01:41:01 -0700 (PDT)
From: Leith Bade <leith@bade.nz>
To: u-boot@lists.denx.de
Cc: Leith Bade <leith@bade.nz>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Sam Shih <sam.shih@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Julien Masson <jmasson@baylibre.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm: mediatek: split config into separate options for the
 board and SoC
Date: Wed,  3 Jul 2024 18:40:35 +1000
Message-Id: <20240703084035.2891892-1-leith@bade.nz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 03 Jul 2024 15:46:48 +0200
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

The current MediaTek Kconfig layout prevents the addition of new board
targets that require the existing SoC drivers.

By making the SoC drivers depend on new CONFIG_MTxxxx variables, it
becomes possible to select these drivers when adding new boards to the
board selection list. The existing TARGET_MTxxxx are then changed to
select the correct SoC driver targets and can continue to be used as a
generic target.

Signed-off-by: Leith Bade <leith@bade.nz>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: Sam Shih <sam.shih@mediatek.com>
---
This is my first U-boot patch so I apologise in advance if I am doing
something wrong.

There seems to be a number of different ways to organise the Kconfig
file to support multiple boards using the same CPU. So picked an approach
that required the least number of changes.

My motivation was to be able to add files under a new
board/bananapi/bpi-r3 directory for the Banana Pi BPI-R3 board so I can
add a .env file to set up the required values for the "Standard Boot".

If this change is accepted I plan to follow up with future patches to
add this .env file.

 arch/arm/mach-mediatek/Kconfig  | 43 ++++++++++++++++++++++++++++++++-
 arch/arm/mach-mediatek/Makefile | 20 +++++++--------
 drivers/clk/mediatek/Makefile   | 20 +++++++--------
 drivers/ram/mediatek/Makefile   |  2 +-
 4 files changed, 63 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index ff1fdee5c8..4b4faad8b4 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -6,8 +6,38 @@ config SYS_SOC
 config SYS_VENDOR
 	default "mediatek"
 
+config MT7622
+	bool
+
+config MT7623
+	bool
+
+config MT7629
+	bool
+
+config MT7981
+	bool
+
+config MT7986
+	bool
+
+config MT7988
+	bool
+
+config MT8183
+	bool
+
+config MT8365
+        bool
+
 config MT8512
-	bool "MediaTek MT8512 SoC"
+	bool
+
+config MT8516
+	bool
+
+config MT8518
+	bool
 
 choice
 	prompt "MediaTek board select"
@@ -15,6 +45,7 @@ choice
 config TARGET_MT7622
 	bool "MediaTek MT7622 SoC"
 	select ARM64
+	select MT7622
 	help
 	  The MediaTek MT7622 is a ARM64-based SoC with a dual-core Cortex-A53.
 	  including UART, SPI, USB3.0, SD and MMC cards, NAND, SNFI, PWM, PCIe,
@@ -24,6 +55,7 @@ config TARGET_MT7623
 	bool "MediaTek MT7623 SoC"
 	select CPU_V7A
 	select MMC_SUPPORTS_TUNING
+	select MT7623
 	help
 	  The MediaTek MT7623 is a ARM-based SoC with a quad-core Cortex-A7
 	  including NEON and GPU, Mali-450 graphics, several DDR3 options,
@@ -36,6 +68,7 @@ config TARGET_MT7629
 	bool "MediaTek MT7629 SoC"
 	select CPU_V7A
 	select SPL
+	select MT7629
 	help
 	  The MediaTek MT7629 is a ARM-based SoC with a dual-core Cortex-A7
 	  including DDR3, crypto engine, 3x3 11n/ac Wi-Fi, Gigabit Ethernet,
@@ -45,6 +78,7 @@ config TARGET_MT7981
 	bool "MediaTek MT7981 SoC"
 	select ARM64
 	select CPU
+	select MT7981
 	help
 	  The MediaTek MT7981 is a ARM64-based SoC with a dual-core Cortex-A53.
 	  including UART, SPI, USB, NAND, SNFI, PWM, Gigabit Ethernet, I2C,
@@ -54,6 +88,7 @@ config TARGET_MT7986
 	bool "MediaTek MT7986 SoC"
 	select ARM64
 	select CPU
+	select MT7986
 	help
 	  The MediaTek MT7986 is a ARM64-based SoC with a quad-core Cortex-A53.
 	  including UART, SPI, SPI flash, USB3.0, MMC, NAND, SNFI, PWM, PCIe,
@@ -63,6 +98,7 @@ config TARGET_MT7988
 	bool "MediaTek MT7988 SoC"
 	select ARM64
 	select CPU
+	select MT7988
 	help
 	  The MediaTek MT7988 is a ARM64-based SoC with a quad-core Cortex-A73.
 	  including UART, SPI, SPI flash, USB3.0, MMC, NAND, SNFI, PWM, PCIe,
@@ -71,6 +107,7 @@ config TARGET_MT7988
 config TARGET_MT8183
 	bool "MediaTek MT8183 SoC"
 	select ARM64
+	select MT8183
 	help
 	  The MediaTek MT8183 is a ARM64-based SoC with a quad-core Cortex-A73 and
 	  a quad-core Cortex-A53. It is including UART, SPI, USB3.0 dual role,
@@ -80,6 +117,7 @@ config TARGET_MT8183
 config TARGET_MT8365
 	bool "MediaTek MT8365 SoC"
 	select ARM64
+	select MT8365
 	help
 	  The MediaTek MT8365 is a ARM64-based SoC with a quad-core Cortex-A53.
 	  It is including UART, SPI, USB2.0 dual role, SD and MMC cards, NAND, PWM,
@@ -98,6 +136,7 @@ config TARGET_MT8512
 config TARGET_MT8516
 	bool "MediaTek MT8516 SoC"
 	select ARM64
+	select MT8516
 	help
 	  The MediaTek MT8516 is a ARM64-based SoC with a quad-core Cortex-A35.
 	  including UART, SPI, USB2.0 and OTG, SD and MMC cards, NAND, PWM,
@@ -107,6 +146,7 @@ config TARGET_MT8516
 config TARGET_MT8518
 	bool "MediaTek MT8518 SoC"
 	select ARM64
+	select MT8518
 	help
 	  The MediaTek MT8518 is a ARM64-based SoC with a quad-core Cortex-A53.
 	  including UART, SPI, USB2.0 and OTG, SD and MMC cards, NAND, PWM,
@@ -124,6 +164,7 @@ config SYS_BOARD
 	default "mt7986" if TARGET_MT7986
 	default "mt7988" if TARGET_MT7988
 	default "mt8183" if TARGET_MT8183
+        default "mt8365" if TARGET_MT8365
 	default "mt8512" if TARGET_MT8512
 	default "mt8516" if TARGET_MT8516
 	default "mt8518" if TARGET_MT8518
diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
index 46bdab8820..c32f78f82b 100644
--- a/arch/arm/mach-mediatek/Makefile
+++ b/arch/arm/mach-mediatek/Makefile
@@ -3,14 +3,14 @@
 obj-y	+= cpu.o
 obj-$(CONFIG_SPL_BUILD)	+= spl.o
 
+obj-$(CONFIG_MT7622) += mt7622/
+obj-$(CONFIG_MT7623) += mt7623/
+obj-$(CONFIG_MT7629) += mt7629/
+obj-$(CONFIG_MT7981) += mt7981/
+obj-$(CONFIG_MT7986) += mt7986/
+obj-$(CONFIG_MT7988) += mt7988/
+obj-$(CONFIG_MT8183) += mt8183/
+obj-$(TARGET_MT8365) += mt8365/
 obj-$(CONFIG_MT8512) += mt8512/
-obj-$(CONFIG_TARGET_MT7622) += mt7622/
-obj-$(CONFIG_TARGET_MT7623) += mt7623/
-obj-$(CONFIG_TARGET_MT7629) += mt7629/
-obj-$(CONFIG_TARGET_MT7981) += mt7981/
-obj-$(CONFIG_TARGET_MT7986) += mt7986/
-obj-$(CONFIG_TARGET_MT7988) += mt7988/
-obj-$(CONFIG_TARGET_MT8183) += mt8183/
-obj-$(CONFIG_TARGET_MT8365) += mt8365/
-obj-$(CONFIG_TARGET_MT8516) += mt8516/
-obj-$(CONFIG_TARGET_MT8518) += mt8518/
+obj-$(CONFIG_MT8516) += mt8516/
+obj-$(CONFIG_MT8518) += mt8518/
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index e631f79e4d..62e26de5e0 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -3,14 +3,14 @@
 obj-$(CONFIG_ARCH_MEDIATEK) += clk-mtk.o
 
 # SoC Drivers
+obj-$(CONFIG_MT7623) += clk-mt7623.o
+obj-$(CONFIG_MT7622) += clk-mt7622.o
+obj-$(CONFIG_MT7629) += clk-mt7629.o
+obj-$(CONFIG_MT7986) += clk-mt7986.o
+obj-$(CONFIG_MT7981) += clk-mt7981.o
+obj-$(CONFIG_MT7988) += clk-mt7988.o
+obj-$(CONFIG_MT8183) += clk-mt8183.o
+obj-$(CONFIG_MT8365) += clk-mt8365.o
 obj-$(CONFIG_MT8512) += clk-mt8512.o
-obj-$(CONFIG_TARGET_MT7623) += clk-mt7623.o
-obj-$(CONFIG_TARGET_MT7622) += clk-mt7622.o
-obj-$(CONFIG_TARGET_MT7629) += clk-mt7629.o
-obj-$(CONFIG_TARGET_MT7986) += clk-mt7986.o
-obj-$(CONFIG_TARGET_MT7981) += clk-mt7981.o
-obj-$(CONFIG_TARGET_MT7988) += clk-mt7988.o
-obj-$(CONFIG_TARGET_MT8183) += clk-mt8183.o
-obj-$(CONFIG_TARGET_MT8365) += clk-mt8365.o
-obj-$(CONFIG_TARGET_MT8516) += clk-mt8516.o
-obj-$(CONFIG_TARGET_MT8518) += clk-mt8518.o
+obj-$(CONFIG_MT8516) += clk-mt8516.o
+obj-$(CONFIG_MT8518) += clk-mt8518.o
diff --git a/drivers/ram/mediatek/Makefile b/drivers/ram/mediatek/Makefile
index 95507b593c..71f2c4fe83 100644
--- a/drivers/ram/mediatek/Makefile
+++ b/drivers/ram/mediatek/Makefile
@@ -4,4 +4,4 @@
 # SPDX-License-Identifier:      GPL-2.0
 #
 
-obj-$(CONFIG_TARGET_MT7629) = ddr3-mt7629.o
+obj-$(CONFIG_MT7629) = ddr3-mt7629.o
-- 
2.25.1

