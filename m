Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E042C3DA64
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 00:02:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D272887E8;
	Mon, 29 Jul 2024 01:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFB9788677; Sun, 28 Jul 2024 22:28:29 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFF1A885E7
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 22:28:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 9AC3E1F00086
 for <u-boot@lists.denx.de>; Sun, 28 Jul 2024 20:27:40 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id B85E5A11FC7; Sun, 28 Jul 2024 20:27:39 +0000 (UTC)
Received: from localhost.localdomain (unknown [192.168.1.64])
 by laika.paulk.fr (Postfix) with ESMTP id D3C44A11FBF;
 Sun, 28 Jul 2024 20:25:35 +0000 (UTC)
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
Subject: [PATCH 12/12] omap3: sniper: Streamline defconfig
Date: Sun, 28 Jul 2024 22:25:01 +0200
Message-ID: <20240728202501.3204905-13-paulk@sys-base.io>
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

Remove custom config options that are not particularly necessary.
Align them with OMAP3 defaults used on other boards (especially for
memory locations).

Also enable Thumb build to reduce the SPL size and remove the custom
prompt text.

This makes the config a lot more minimalistic, maintainable and easier
to read.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 configs/sniper_defconfig | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/configs/sniper_defconfig b/configs/sniper_defconfig
index 08ab3a66c51a..5c6f9328bf8b 100644
--- a/configs/sniper_defconfig
+++ b/configs/sniper_defconfig
@@ -1,28 +1,20 @@
 CONFIG_ARM=y
-# CONFIG_SYS_THUMB_BUILD is not set
 CONFIG_ARCH_OMAP2PLUS=y
-CONFIG_TEXT_BASE=0x80100000
-CONFIG_SYS_MALLOC_LEN=0x120000
-CONFIG_SYS_MALLOC_F_LEN=0x400
+CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_TARGET_SNIPER=y
-CONFIG_SPL_STACK=0x4020fffc
-CONFIG_SPL_BSS_START_ADDR=0x80000000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x400
 CONFIG_SPL=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="setenv boot_mmc_part ${kernel_mmc_part}; if test reboot-${reboot-mode} = reboot-r; then echo recovery; setenv boot_mmc_part ${recovery_mmc_part}; fi; if test reboot-${reboot-mode} = reboot-b; then echo fastboot; fastboot 0; fi; part start mmc ${boot_mmc_dev} ${boot_mmc_part} boot_mmc_start; part size mmc ${boot_mmc_dev} ${boot_mmc_part} boot_mmc_size; mmc dev ${boot_mmc_dev}; mmc read ${kernel_addr_r} ${boot_mmc_start} ${boot_mmc_size} && bootm ${kernel_addr_r};"
-CONFIG_SYS_CBSIZE=512
-CONFIG_SYS_PBSIZE=538
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80208000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 # CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=2
 # CONFIG_SPL_FS_EXT4 is not set
 # CONFIG_SPL_NAND_SUPPORT is not set
-CONFIG_SYS_PROMPT="sniper # "
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
-- 
2.45.2

