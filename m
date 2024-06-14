Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AD3C27C75
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 11:05:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1A88889B8;
	Fri, 14 Jun 2024 13:05:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB3C5889A1; Fri, 14 Jun 2024 13:05:08 +0200 (CEST)
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::8fae])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAA82889AA
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 13:05:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4W0xJL2Zs2z1BG;
 Fri, 14 Jun 2024 13:05:06 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4W0xJK5xyGzSbl; Fri, 14 Jun 2024 13:05:05 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 14 Jun 2024 13:04:53 +0200
Subject: [PATCH next 1/4] rockchip: ringneck-px30: disable broken USB
 gadget
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-ringneck-no-gadget-v1-1-d3bc6e5088de@cherry.de>
References: <20240614-ringneck-no-gadget-v1-0-d3bc6e5088de@cherry.de>
In-Reply-To: <20240614-ringneck-no-gadget-v1-0-d3bc6e5088de@cherry.de>
To: Klaus Goger <klaus.goger@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
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

USB gadget simply doesn't work right now on PX30. Tested on PX30 EVB and
PX30 Ringneck with Linux mainline and Rockchip 5.10 Linux as well as
U-Boot.

We don't want to our users to assume that USB gadget is supported on Q7
USB P1 on Ringneck Haikou, so let's remove its support, which also
removes the ums CLI command, fastboot and Android image booting
support.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 configs/ringneck-px30_defconfig | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/configs/ringneck-px30_defconfig b/configs/ringneck-px30_defconfig
index 23204794205..2ec5f72e47a 100644
--- a/configs/ringneck-px30_defconfig
+++ b/configs/ringneck-px30_defconfig
@@ -15,7 +15,6 @@ CONFIG_DEBUG_UART_BASE=0xFF030000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART=y
-# CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
@@ -42,6 +41,7 @@ CONFIG_SPL_ATF=y
 # CONFIG_CMD_ELF is not set
 # CONFIG_CMD_LZMADEC is not set
 # CONFIG_CMD_UNZIP is not set
+CONFIG_CMD_BIND=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
@@ -49,7 +49,6 @@ CONFIG_CMD_I2C=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
-CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
@@ -73,8 +72,6 @@ CONFIG_BUTTON=y
 CONFIG_BUTTON_GPIO=y
 CONFIG_CLK=y
 CONFIG_SPL_CLK=y
-CONFIG_FASTBOOT_BUF_ADDR=0x800800
-CONFIG_FASTBOOT_BUF_SIZE=0x04000000
 CONFIG_GPIO_HOG=y
 CONFIG_SPL_GPIO_HOG=y
 CONFIG_ROCKCHIP_GPIO=y
@@ -112,8 +109,6 @@ CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
-CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_SPL_TINY_MEMSET=y
 CONFIG_TPL_TINY_MEMSET=y
 CONFIG_LZO=y

-- 
2.45.2

