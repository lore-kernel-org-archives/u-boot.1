Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D193C3DA64
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 00:01:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33C8C88814;
	Mon, 29 Jul 2024 01:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A7518806A; Sun, 28 Jul 2024 22:27:09 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EC7887DB6
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 22:27:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 906F51F00068
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 20:26:37 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 8C3C8A11FC7; Sun, 28 Jul 2024 20:26:36 +0000 (UTC)
Received: from localhost.localdomain (unknown [192.168.1.64])
 by laika.paulk.fr (Postfix) with ESMTP id D6181A11FB9;
 Sun, 28 Jul 2024 20:25:19 +0000 (UTC)
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
Subject: [PATCH 06/12] dra7xx: Unify init stack pointer address across boards
Date: Sun, 28 Jul 2024 22:24:55 +0200
Message-ID: <20240728202501.3204905-7-paulk@sys-base.io>
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

The DRA7xx EVM board use a slightly different init stack pointer
address compared to the AM57xx EVM board, for no particular reason.

Align the address with the AM57xx EVM board (which matches the usual
offset to the end of SRAM used by other OMAP devices) prior to removing
it as a per-board option in a later commit.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 configs/dra7xx_evm_defconfig        | 2 +-
 configs/dra7xx_hs_evm_defconfig     | 2 +-
 configs/dra7xx_hs_evm_usb_defconfig | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/configs/dra7xx_evm_defconfig b/configs/dra7xx_evm_defconfig
index 0cea5504364b..dd2378801249 100644
--- a/configs/dra7xx_evm_defconfig
+++ b/configs/dra7xx_evm_defconfig
@@ -4,7 +4,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x18000
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4037fef0
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4037ff00
 CONFIG_SF_DEFAULT_SPEED=76800000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
diff --git a/configs/dra7xx_hs_evm_defconfig b/configs/dra7xx_hs_evm_defconfig
index 5f56b1875037..b698a36eb838 100644
--- a/configs/dra7xx_hs_evm_defconfig
+++ b/configs/dra7xx_hs_evm_defconfig
@@ -5,7 +5,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x18000
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4037fef0
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4037ff00
 CONFIG_SF_DEFAULT_SPEED=76800000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
diff --git a/configs/dra7xx_hs_evm_usb_defconfig b/configs/dra7xx_hs_evm_usb_defconfig
index 5b67a0e8392f..40f47a3adb1e 100644
--- a/configs/dra7xx_hs_evm_usb_defconfig
+++ b/configs/dra7xx_hs_evm_usb_defconfig
@@ -5,7 +5,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x18000
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4037fef0
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4037ff00
 CONFIG_SF_DEFAULT_SPEED=76800000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
-- 
2.45.2

