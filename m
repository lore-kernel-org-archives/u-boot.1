Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4902CDE02B
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 18:32:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 491EA88DCD;
	Thu, 26 Sep 2024 20:31:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FF2888D9E; Thu, 26 Sep 2024 20:31:53 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3323D88D9E
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 20:31:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 02B5A1F00050
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 18:31:40 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id D56B1A6013F; Thu, 26 Sep 2024 18:31:38 +0000 (UTC)
Received: from localhost.localdomain (unknown [192.168.1.64])
 by laika.paulk.fr (Postfix) with ESMTP id B9E7EA60135;
 Thu, 26 Sep 2024 18:31:24 +0000 (UTC)
From: Paul Kocialkowski <paulk@sys-base.io>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Jonas Karlman <jonas@kwiboo.se>,
 Chris Morgan <macromorgan@hotmail.com>, Tim Lunn <tim@feathertop.org>,
 Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 4/4] rockchip: Disable DRAM debug by default
Date: Thu, 26 Sep 2024 20:31:11 +0200
Message-ID: <20240926183111.1324284-4-paulk@sys-base.io>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240926183111.1324284-1-paulk@sys-base.io>
References: <20240926183111.1324284-1-paulk@sys-base.io>
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

From: Paul Kocialkowski <contact@paulk.fr>

Printing debug details about DRAM is not useful in regular use and
adds visual pollution to the log. Disable it by default.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 configs/anbernic-rgxx3-rk3566_defconfig   | 1 -
 configs/neu2-io-rv1126_defconfig          | 1 -
 configs/roc-pc-mezzanine-rk3399_defconfig | 1 -
 configs/roc-pc-rk3399_defconfig           | 1 -
 configs/rock-pi-n10-rk3399pro_defconfig   | 1 -
 configs/rock-pi-n8-rk3288_defconfig       | 1 -
 configs/sonoff-ihost-rv1126_defconfig     | 1 -
 drivers/ram/rockchip/Kconfig              | 1 -
 8 files changed, 8 deletions(-)

diff --git a/configs/anbernic-rgxx3-rk3566_defconfig b/configs/anbernic-rgxx3-rk3566_defconfig
index a03509bf4671..5c074cffeb44 100644
--- a/configs/anbernic-rgxx3-rk3566_defconfig
+++ b/configs/anbernic-rgxx3-rk3566_defconfig
@@ -67,7 +67,6 @@ CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_SPL_RAM=y
-# CONFIG_RAM_ROCKCHIP_DEBUG is not set
 # CONFIG_RNG_SMCCC_TRNG is not set
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
diff --git a/configs/neu2-io-rv1126_defconfig b/configs/neu2-io-rv1126_defconfig
index 2a4c9b45a04f..84e4465f2c5f 100644
--- a/configs/neu2-io-rv1126_defconfig
+++ b/configs/neu2-io-rv1126_defconfig
@@ -45,7 +45,6 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_PWM_ROCKCHIP=y
-# CONFIG_RAM_ROCKCHIP_DEBUG is not set
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYSRESET=y
diff --git a/configs/roc-pc-mezzanine-rk3399_defconfig b/configs/roc-pc-mezzanine-rk3399_defconfig
index a57899bfdfa0..b4041902b381 100644
--- a/configs/roc-pc-mezzanine-rk3399_defconfig
+++ b/configs/roc-pc-mezzanine-rk3399_defconfig
@@ -65,7 +65,6 @@ CONFIG_REGULATOR_PWM=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
-# CONFIG_RAM_ROCKCHIP_DEBUG is not set
 CONFIG_RAM_ROCKCHIP_LPDDR4=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defconfig
index b45f0e0a8994..922f67320c20 100644
--- a/configs/roc-pc-rk3399_defconfig
+++ b/configs/roc-pc-rk3399_defconfig
@@ -62,7 +62,6 @@ CONFIG_REGULATOR_PWM=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
-# CONFIG_RAM_ROCKCHIP_DEBUG is not set
 CONFIG_RAM_ROCKCHIP_LPDDR4=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
diff --git a/configs/rock-pi-n10-rk3399pro_defconfig b/configs/rock-pi-n10-rk3399pro_defconfig
index ec995a54a0ee..17fe939ec989 100644
--- a/configs/rock-pi-n10-rk3399pro_defconfig
+++ b/configs/rock-pi-n10-rk3399pro_defconfig
@@ -51,7 +51,6 @@ CONFIG_PHY_ROCKCHIP_TYPEC=y
 CONFIG_PMIC_RK8XX=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
-# CONFIG_RAM_ROCKCHIP_DEBUG is not set
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
diff --git a/configs/rock-pi-n8-rk3288_defconfig b/configs/rock-pi-n8-rk3288_defconfig
index 4c09b9137ef8..af0fa8879421 100644
--- a/configs/rock-pi-n8-rk3288_defconfig
+++ b/configs/rock-pi-n8-rk3288_defconfig
@@ -73,7 +73,6 @@ CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_RAM=y
 CONFIG_SPL_RAM=y
-# CONFIG_RAM_ROCKCHIP_DEBUG is not set
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
diff --git a/configs/sonoff-ihost-rv1126_defconfig b/configs/sonoff-ihost-rv1126_defconfig
index 4890644c7e6f..739adb49ce93 100644
--- a/configs/sonoff-ihost-rv1126_defconfig
+++ b/configs/sonoff-ihost-rv1126_defconfig
@@ -46,7 +46,6 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_PWM_ROCKCHIP=y
-# CONFIG_RAM_ROCKCHIP_DEBUG is not set
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYSRESET=y
diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
index 67c63ecba047..e030c982eccb 100644
--- a/drivers/ram/rockchip/Kconfig
+++ b/drivers/ram/rockchip/Kconfig
@@ -15,7 +15,6 @@ if RAM_ROCKCHIP
 
 config RAM_ROCKCHIP_DEBUG
 	bool "Rockchip ram drivers debugging"
-	default y
 	help
 	  This enables debugging ram driver API's for the platforms
 	  based on Rockchip SoCs.
-- 
2.46.2

