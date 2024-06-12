Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C69C27C53
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 14:41:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFA8B887F0;
	Wed, 12 Jun 2024 16:41:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97C9A86784; Wed, 12 Jun 2024 16:41:10 +0200 (CEST)
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch
 [45.157.188.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB0528867D
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 16:41:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VzpBX3YKhz3gC;
 Wed, 12 Jun 2024 16:41:08 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VzpBW6rZcz8H5; Wed, 12 Jun 2024 16:41:07 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 12 Jun 2024 16:40:48 +0200
Subject: [PATCH 1/2] rockchip: ringneck-px30: get closer to other Theobroma
 defconfigs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-ringneck-bootd-v1-1-f0bc3816b822@cherry.de>
References: <20240612-ringneck-bootd-v1-0-f0bc3816b822@cherry.de>
In-Reply-To: <20240612-ringneck-bootd-v1-0-f0bc3816b822@cherry.de>
To: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Klaus Goger <klaus.goger@cherry.de>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 heiko@sntech.de
X-Mailer: b4 0.14-dev-a6ee3
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

RK3588 Jaguar and Tiger, and RK3399 Puma use standard boot with the full
feature set, so let's do that as well for PX30 Ringneck.

Disable support for unused OSes as Linux is the primary target.

Enable a bunch of commands:
 - boot/bootd
 - erofs
 - gpio
 - iminfo
 - imxtract
 - itest
 - pmic
 - regulator
 - sleep
 - squashfs

that could be useful and are also found in Jaguar and Tiger defconfigs.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 configs/ringneck-px30_defconfig | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/configs/ringneck-px30_defconfig b/configs/ringneck-px30_defconfig
index dedf35d4347..a0c1fec0951 100644
--- a/configs/ringneck-px30_defconfig
+++ b/configs/ringneck-px30_defconfig
@@ -20,6 +20,7 @@ CONFIG_DEBUG_UART=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
+CONFIG_BOOTSTD_FULL=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/px30-ringneck-haikou.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
@@ -34,12 +35,15 @@ CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x200
 CONFIG_SPL_ATF=y
 # CONFIG_TPL_FRAMEWORK is not set
 # CONFIG_TPL_SYS_MALLOC_SIMPLE is not set
-# CONFIG_CMD_BOOTD is not set
+# CONFIG_BOOTM_NETBSD is not set
+# CONFIG_BOOTM_PLAN9 is not set
+# CONFIG_BOOTM_RTEMS is not set
+# CONFIG_CMD_VBE is not set
+# CONFIG_BOOTM_VXWORKS is not set
 # CONFIG_CMD_ELF is not set
-# CONFIG_CMD_IMI is not set
-# CONFIG_CMD_XIMG is not set
 # CONFIG_CMD_LZMADEC is not set
 # CONFIG_CMD_UNZIP is not set
+CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 # CONFIG_CMD_LOADB is not set
@@ -47,9 +51,11 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
-# CONFIG_CMD_ITEST is not set
 # CONFIG_CMD_SETEXPR is not set
-# CONFIG_CMD_SLEEP is not set
+CONFIG_CMD_PMIC=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_EROFS=y
+CONFIG_CMD_SQUASHFS=y
 # CONFIG_SPL_DOS_PARTITION is not set
 # CONFIG_ISO_PARTITION is not set
 CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64

-- 
2.45.2

