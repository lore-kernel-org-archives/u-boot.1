Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE36C3DA49
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 00:02:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4704C8887D;
	Mon, 29 Jul 2024 01:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF2A588276; Sun, 28 Jul 2024 22:28:15 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F032387F7D
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 22:28:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 269EB1F00072
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 20:27:30 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 75FD7A11FC2; Sun, 28 Jul 2024 20:27:29 +0000 (UTC)
Received: from localhost.localdomain (unknown [192.168.1.64])
 by laika.paulk.fr (Postfix) with ESMTP id 540CFA11FB4;
 Sun, 28 Jul 2024 20:25:31 +0000 (UTC)
From: Paul Kocialkowski <paulk@sys-base.io>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Yegor Yefremov <yegorslists@googlemail.com>,
 Sjoerd Simons <sjoerd.simons@collabora.co.uk>,
 Govindaraji Sivanantham <Govindaraji.Sivanantham@in.bosch.com>,
 Hiremath Gireesh <Gireesh.Hiremath@in.bosch.com>,
 "Andrew F . Davis" <afd@ti.com>,
 =?UTF-8?q?Javier=20Mart=C3=ADnez=20Canillas?= <javier@dowhile0.org>,
 Felix Brack <fb@ltec.ch>, Heiko Schocher <hs@denx.de>,
 Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 Adam Ford <aford173@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 Marcin Niestroj <m.niestroj@grinn-global.com>,
 Nikita Kiryanov <nikita@compulab.co.il>,
 Thomas Weber <weber@corscience.de>, Enrico Leto <enrico.leto@siemens.com>,
 "Derald D . Woods" <woods.technical@gmail.com>,
 "Matwey V . Kornilov" <matwey.kornilov@gmail.com>,
 Niel Fourie <lusus@denx.de>, Parthiban Nallathambi <parthiban@linumiz.com>,
 Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 11/12] dra7xx: Remove explicit DRAM banks number from
 defconfigs
Date: Sun, 28 Jul 2024 22:25:00 +0200
Message-ID: <20240728202501.3204905-12-paulk@sys-base.io>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240728202501.3204905-1-paulk@sys-base.io>
References: <20240728202501.3204905-1-paulk@sys-base.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 29 Jul 2024 01:59:10 +0200
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

The common EMIF init code used for DRA7xx does not explicitly fill
the gd->bd->bi_dram entries (like OMAP3 does), so there is no reason
to set an explicit number of DRAM banks which doesn't correspond to
anything in particular.

Remove the CONFIG_NR_DRAM_BANKS option from the concerned defconfigs.
The dram_init_banksize default implementation will be fine with the
default value for the config option.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 configs/am57xx_evm_defconfig        | 1 -
 configs/am57xx_hs_evm_defconfig     | 1 -
 configs/am57xx_hs_evm_usb_defconfig | 1 -
 configs/dra7xx_evm_defconfig        | 1 -
 configs/dra7xx_hs_evm_defconfig     | 1 -
 configs/dra7xx_hs_evm_usb_defconfig | 1 -
 6 files changed, 6 deletions(-)

diff --git a/configs/am57xx_evm_defconfig b/configs/am57xx_evm_defconfig
index 145c6d8e5855..587af53acb61 100644
--- a/configs/am57xx_evm_defconfig
+++ b/configs/am57xx_evm_defconfig
@@ -1,7 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_TI_COMMON_CMD_OPTIONS=y
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_SF_DEFAULT_SPEED=76800000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
diff --git a/configs/am57xx_hs_evm_defconfig b/configs/am57xx_hs_evm_defconfig
index 850fce024f1d..b790897645fb 100644
--- a/configs/am57xx_hs_evm_defconfig
+++ b/configs/am57xx_hs_evm_defconfig
@@ -2,7 +2,6 @@ CONFIG_ARM=y
 CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_TI_SECURE_DEVICE=y
 CONFIG_TI_COMMON_CMD_OPTIONS=y
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_SF_DEFAULT_SPEED=76800000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
diff --git a/configs/am57xx_hs_evm_usb_defconfig b/configs/am57xx_hs_evm_usb_defconfig
index d1ef82b7bcb2..450751b354fd 100644
--- a/configs/am57xx_hs_evm_usb_defconfig
+++ b/configs/am57xx_hs_evm_usb_defconfig
@@ -2,7 +2,6 @@ CONFIG_ARM=y
 CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_TI_SECURE_DEVICE=y
 CONFIG_TI_COMMON_CMD_OPTIONS=y
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_SF_DEFAULT_SPEED=76800000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
diff --git a/configs/dra7xx_evm_defconfig b/configs/dra7xx_evm_defconfig
index 244d5351bd83..6264d9fa7ada 100644
--- a/configs/dra7xx_evm_defconfig
+++ b/configs/dra7xx_evm_defconfig
@@ -2,7 +2,6 @@ CONFIG_ARM=y
 CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_SYS_MALLOC_F_LEN=0x18000
 CONFIG_TI_COMMON_CMD_OPTIONS=y
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_SF_DEFAULT_SPEED=76800000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
diff --git a/configs/dra7xx_hs_evm_defconfig b/configs/dra7xx_hs_evm_defconfig
index 225f279572d5..4e7929718fd8 100644
--- a/configs/dra7xx_hs_evm_defconfig
+++ b/configs/dra7xx_hs_evm_defconfig
@@ -3,7 +3,6 @@ CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_TI_SECURE_DEVICE=y
 CONFIG_SYS_MALLOC_F_LEN=0x18000
 CONFIG_TI_COMMON_CMD_OPTIONS=y
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_SF_DEFAULT_SPEED=76800000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
diff --git a/configs/dra7xx_hs_evm_usb_defconfig b/configs/dra7xx_hs_evm_usb_defconfig
index 3b37355654ce..68d342b277cd 100644
--- a/configs/dra7xx_hs_evm_usb_defconfig
+++ b/configs/dra7xx_hs_evm_usb_defconfig
@@ -3,7 +3,6 @@ CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_TI_SECURE_DEVICE=y
 CONFIG_SYS_MALLOC_F_LEN=0x18000
 CONFIG_TI_COMMON_CMD_OPTIONS=y
-CONFIG_NR_DRAM_BANKS=2
 CONFIG_SF_DEFAULT_SPEED=76800000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
-- 
2.45.2

