Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E726C5AD49
	for <u-boot@archiver.kernel.org>; Sun,  8 Jun 2025 04:28:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E3B6807B1;
	Sun,  8 Jun 2025 06:28:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="UV2sXKdZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBE1A80E9A; Sun,  8 Jun 2025 03:08:19 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 896DE8003E
 for <u-boot@lists.denx.de>; Sun,  8 Jun 2025 03:08:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alicja.michalska@9elements.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-acacb8743a7so554476766b.1
 for <u-boot@lists.denx.de>; Sat, 07 Jun 2025 18:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1749344897; x=1749949697; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pcphLIhvVAxdMXaGryRF8bXQuGMf5vXgSAMNqmh7T+U=;
 b=UV2sXKdZK6mz8rTzHK9B4B79vJ7xOTjbTSCUWguNwsc4rNHQbmnUEscW85+5YjjgcA
 YekmmhY8k5CD3BzJUtYaKaJGXHK41ju1rbf0rJ6uFl0CMY8fqn7hKsNANZYi12zzdUBG
 EH9KGlRkWL9uHqbWU11bC6YSR8Q5lMG/YYTg2hSfIgmODrEBKlD7Z96JVZTg5KXiDyD6
 Yaket81hRzOF+zhBoq0N3bgypmaU6fz4qLpLn+enWyYvXuloD5BP3a03RHK3svkod7jy
 rHJHNZGic2YJchfstm6K27otyHcQVD2vJEBtR9pC/5X8zKrf9QhGXZbs0Ln43+0X6ol+
 ++Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749344897; x=1749949697;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pcphLIhvVAxdMXaGryRF8bXQuGMf5vXgSAMNqmh7T+U=;
 b=D0u8ZCvzmYcwrSfV1Rnex+eFsZH0iUxNqfMhLvvY6Q6YOrPdApguhryNIV7KzU1JdZ
 7o74n2HG7d3kpm42G5zpSyAqqLWOCAiw2Ga+UTFB0fZI7go2yPBTrsPJfTfu6GK1eXmm
 3cvJRFYKRCkop2k6oKpwpADrhfUFFcJuGHEoVtPFiPYRTv+mZdnbjqr10BAgd4leIvvi
 hjoPHgI2tGBdgPERuWZNyP6/XD1/BLY+ziOW3iLZWB9Y+3XYLT+re1ImTGPB1d9NxBwN
 caKNjpomFerDTa3w9L71bYjBd7Jlb68/Pg1LBvXJLf+esk8RGs7zQGy2QirxuSU9PRd3
 62yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm2qMsA9Xy1bdY2OQttMN7gh75eExvgdr+aaaTiXHM498ThcIfWY5Ik5bA/I5HBbvjdDXjupc=@lists.denx.de
X-Gm-Message-State: AOJu0YyiUZ9fRI76Q5dO3tM4OvZE1a4AZjIQ6Ixwlja6pK/Cqs9BZdq7
 c0QNMQLE9H0SJNRAN9ANy1UDun0M7UlVwAXjIAaE3bkylbBkG7i9EmFlu6X8/brKgCg=
X-Gm-Gg: ASbGncsS66lV6RRin3z0LoNIxLWU/Nr2p+6wWTYauLwlBvMpxJ08m25Pw2480JbRtVg
 UUy+WVnkjPx5wewqGIocxNGHSEz2X844IMIsVDnYCMGq+2pkZhcw9ZF+ksEPRbOuJ9L9J1sCba3
 XBEenfTY8VlogC9HHBgoJPWkHX/JKDAVbcLZ5MqugJZIkoFk2kqSTWhbfCbem2bQ2J/JJypJkCy
 e76b8gbIkeCqoyTxlwD4Wg24r9Nj24hX1jqd8MbRS9cK7EXhPMJn5deiFNZjo/nq5v96ghyRkUJ
 fVWEZdvket+B62bMbws8MU0WHmgp6xds9YvGvByoRBOJLbt4Y6XoNfldz4G5sLQDVCJTt4eYSzQ
 ZcAlxCoJbqoD/GJ8w6O8Qvgeu9Ut+6cOllovs5eeWIIdlMOHPv2F4xn9xoLfI
X-Google-Smtp-Source: AGHT+IHAc6wk3s6o9Qv0yy8+dBB1Cj3x7kA13owv2bB+tie/oy+PIQ5yI0SbN5nizPg39GOMyYTxtg==
X-Received: by 2002:a17:907:9726:b0:ade:4121:8d2d with SMTP id
 a640c23a62f3a-ade4121a183mr328362766b.20.1749344896839; 
 Sat, 07 Jun 2025 18:08:16 -0700 (PDT)
Received: from localhost.localdomain (83.22.30.62.ipv4.supernova.orange.pl.
 [83.22.30.62]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-ade1dc7d658sm343300566b.176.2025.06.07.18.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Jun 2025 18:08:16 -0700 (PDT)
From: Alicja Michalska <alicja.michalska@9elements.com>
To: lukma@denx.de, seanga2@gmail.com, ryder.lee@mediatek.com,
 weijie.gao@mediatek.com, chunfeng.yun@mediatek.com
Cc: GSS_MTK_Uboot_upstream@mediatek.com,
	u-boot@lists.denx.de
Subject: [PATCH] drivers: clk: mtk: Decouple MediaTek clock drivers from SoC
Date: Sun,  8 Jun 2025 03:07:58 +0200
Message-ID: <20250608010758.1662149-1-alicja.michalska@9elements.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 08 Jun 2025 06:28:02 +0200
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

As a part of ongoing coreboot/U-Boot payload work on modern ARM64
Chromebooks, we need to decouple MediaTek's clock driver from depending
on SoC targets.

This patch essentially mimicks behaviour of Qualcomm clock drivers in
U-Boot, allowing us to pick them independently if we're building for
coreboot target.

Choosing CONFIG_TARGET_$SOC will still automatically enable the clock
driver for desired target, avoiding breakage.

Signed-off-by: Alicja Michalska <alicja.michalska@9elements.com>
---
 drivers/clk/Kconfig           |   1 +
 drivers/clk/Makefile          |   2 +-
 drivers/clk/mediatek/Kconfig  | 127 ++++++++++++++++++++++++++++++++++
 drivers/clk/mediatek/Makefile |  27 ++++----
 4 files changed, 143 insertions(+), 14 deletions(-)
 create mode 100644 drivers/clk/mediatek/Kconfig

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 19aa2ffa539..f8f82fc9f3f 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -260,6 +260,7 @@ source "drivers/clk/exynos/Kconfig"
 source "drivers/clk/imx/Kconfig"
 source "drivers/clk/meson/Kconfig"
 source "drivers/clk/microchip/Kconfig"
+source "drivers/clk/mediatek/Kconfig"
 source "drivers/clk/mvebu/Kconfig"
 source "drivers/clk/owl/Kconfig"
 source "drivers/clk/qcom/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 5f0c0d8a5c2..da58381b247 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -23,7 +23,7 @@ obj-y += ti/
 obj-$(CONFIG_CLK_THEAD) += thead/
 obj-$(CONFIG_$(PHASE_)CLK_INTEL) += intel/
 obj-$(CONFIG_ARCH_ASPEED) += aspeed/
-obj-$(CONFIG_ARCH_MEDIATEK) += mediatek/
+obj-$(CONFIG_CLK_MEDIATEK) += mediatek/
 obj-$(CONFIG_ARCH_MESON) += meson/
 obj-$(CONFIG_ARCH_MTMIPS) += mtmips/
 obj-$(CONFIG_ARCH_NPCM) += nuvoton/
diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
new file mode 100644
index 00000000000..9c34a000d0e
--- /dev/null
+++ b/drivers/clk/mediatek/Kconfig
@@ -0,0 +1,127 @@
+if ARCH_MEDIATEK || ARCH_COREBOOT
+
+config CLK_MTK
+	bool
+	depends on CLK && DM_RESET && POWER_DOMAIN
+	def_bool n
+
+menu "MediaTek clock drivers"
+
+config CLK_MTK_MT7623
+	bool "MediaTek MT7623 GCC"
+	select CLK_MTK
+	default y if CONFIG_TARGET_MT7623
+	help
+	Say Y here to enable support for the Global Clock Controller
+	on the MediaTek MT7623 SoC. This driver supports the clocks
+	and resets exposed by the GCC hardware block.
+
+config MT7622
+	bool "MediaTek MT7622 GCC"
+	select CLK_MTK
+	default y if CONFIG_TARGET_MT7622
+	help
+	Say Y here to enable support for the Global Clock Controller
+	on the MediaTek MT7622 SoC. This driver supports the clocks
+	and resets exposed by the GCC hardware block.
+
+config CLK_MTK_MT7629
+	bool "MediaTek MT7629 GCC"
+	select CLK_MTK
+	default y if CONFIG_TARGET_MT7629
+	help
+	Say Y here to enable support for the Global Clock Controller
+	on the MediaTek MT7629 SoC. This driver supports the clocks
+	and resets exposed by the GCC hardware block.
+
+config CLK_MTK_MT7986
+	bool "MediaTek MT7986 GCC"
+	select CLK_MTK
+	default y if CONFIG_TARGET_MT7986
+	help
+	Say Y here to enable support for the Global Clock Controller
+	on the MediaTek MT7986 SoC. This driver supports the clocks
+	and resets exposed by the GCC hardware block.
+
+config CLK_MTK_MT7981
+	bool "MediaTek MT7981 GCC"
+	select CLK_MTK
+	default y if CONFIG_TARGET_MT7981
+	help
+	Say Y here to enable support for the Global Clock Controller
+	on the MediaTek MT7981 SoC. This driver supports the clocks
+	and resets exposed by the GCC hardware block.
+
+config CLK_MTK_MT7988
+	bool "MediaTek MT7988 GCC"
+	select CLK_MTK
+	default y if CONFIG_TARGET_MT7988
+	help
+	Say Y here to enable support for the Global Clock Controller
+	on the MediaTek MT7988 SoC. This driver supports the clocks
+	and resets exposed by the GCC hardware block.
+
+config CLK_MTK_MT7987
+	bool "MediaTek MT7987 GCC"
+	select CLK_MTK
+	default y if CONFIG_TARGET_MT7987
+	help
+	Say Y here to enable support for the Global Clock Controller
+	on the MediaTek MT7987 SoC. This driver supports the clocks
+	and resets exposed by the GCC hardware block.
+
+config CLK_MTK_MT8183
+	bool "MediaTek MT8183 GCC"
+	default y if CONFIG_TARGET_MT8183 || ARCH_COREBOOT
+	help
+	Say Y here to enable support for the Global Clock Controller
+	on the MediaTek MT8183 SoC. This driver supports the clocks
+	and resets exposed by the GCC hardware block.
+
+config CLK_MTK_MT8186
+	bool "MediaTek MT8186 GCC"
+	select CLK_MTK
+	default y if ARCH_COREBOOT
+	help
+	Say Y here to enable support for the Global Clock Controller
+	on the MediaTek MT8186 SoC. This driver supports the clocks
+	and resets exposed by the GCC hardware block.
+
+config CLK_MTK_MT8365
+	bool "MediaTek MT8365 GCC"
+	select CLK_MTK
+	default y if CONFIG_TARGET_MT8365
+	help
+	Say Y here to enable support for the Global Clock Controller
+	on the MediaTek MT8365 SoC. This driver supports the clocks
+	and resets exposed by the GCC hardware block.
+
+config CLK_MTK_MT8512
+	bool "MediaTek MT8512 GCC"
+	select CLK_MTK
+	default y if CONFIG_TARGET_MT8512
+	help
+	Say Y here to enable support for the Global Clock Controller
+	on the MediaTek MT8512 SoC. This driver supports the clocks
+	and resets exposed by the GCC hardware block.
+
+config CLK_MTK_MT8516
+	bool "MediaTek MT8516 GCC"
+	select CLK_MTK
+	default y if CONFIG_TARGET_MT8516
+	help
+	Say Y here to enable support for the Global Clock Controller
+	on the MediaTek MT8516 SoC. This driver supports the clocks
+	and resets exposed by the GCC hardware block.
+
+config CLK_MTK_MT8518
+	bool "MediaTek MT8518 GCC"
+	select CLK_MTK
+	default y if CONFIG_TARGET_MT8518
+	help
+	Say Y here to enable support for the Global Clock Controller
+	on the MediaTek MT8518 SoC. This driver supports the clocks
+	and resets exposed by the GCC hardware block.
+
+endmenu
+endif
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 12893687b68..4abe09a2452 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -1,17 +1,18 @@
 # SPDX-License-Identifier: GPL-2.0
 # Core
-obj-$(CONFIG_ARCH_MEDIATEK) += clk-mtk.o
+obj-y += clk-mtk.o
 
 # SoC Drivers
-obj-$(CONFIG_TARGET_MT7623) += clk-mt7623.o
-obj-$(CONFIG_TARGET_MT7622) += clk-mt7622.o
-obj-$(CONFIG_TARGET_MT7629) += clk-mt7629.o
-obj-$(CONFIG_TARGET_MT7986) += clk-mt7986.o
-obj-$(CONFIG_TARGET_MT7981) += clk-mt7981.o
-obj-$(CONFIG_TARGET_MT7988) += clk-mt7988.o
-obj-$(CONFIG_TARGET_MT7987) += clk-mt7987.o
-obj-$(CONFIG_TARGET_MT8183) += clk-mt8183.o
-obj-$(CONFIG_TARGET_MT8365) += clk-mt8365.o
-obj-$(CONFIG_TARGET_MT8512) += clk-mt8512.o
-obj-$(CONFIG_TARGET_MT8516) += clk-mt8516.o
-obj-$(CONFIG_TARGET_MT8518) += clk-mt8518.o
+obj-$(CONFIG_CLK_MTK_MT7623) += clk-mt7623.o
+obj-$(CONFIG_CLK_MTK_MT7622) += clk-mt7622.o
+obj-$(CONFIG_CLK_MTK_MT7629) += clk-mt7629.o
+obj-$(CONFIG_CLK_MTK_MT7986) += clk-mt7986.o
+obj-$(CONFIG_CLK_MTK_MT7981) += clk-mt7981.o
+obj-$(CONFIG_CLK_MTK_MT7988) += clk-mt7988.o
+obj-$(CONFIG_CLK_MTK_MT7987) += clk-mt7987.o
+obj-$(CONFIG_CLK_MTK_MT8183) += clk-mt8183.o
+obj-$(CONFIG_CLK_MTK_MT8186) += clk-mt8186.o
+obj-$(CONFIG_CLK_MTK_MT8365) += clk-mt8365.o
+obj-$(CONFIG_CLK_MTK_MT8512) += clk-mt8512.o
+obj-$(CONFIG_CLK_MTK_MT8516) += clk-mt8516.o
+obj-$(CONFIG_CLK_MTK_MT8518) += clk-mt8518.o
-- 
2.49.0

