Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB42FC021A1
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 06:14:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24C1B80CF4;
	Tue, 11 Feb 2025 07:14:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B42F807C0; Tue, 11 Feb 2025 07:14:05 +0100 (CET)
Received: from mail.naobsd.org (sakura.naobsd.org [160.16.200.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABCD180C91
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 07:13:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=naoki@radxa.com
Received: from secure.fukaumi.org ([10.0.0.2])
 by mail.naobsd.org (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 51B6DR7d024871; Tue, 11 Feb 2025 15:13:30 +0900
From: FUKAUMI Naoki <naoki@radxa.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 banglang.huang@foxmail.com, jonas@kwiboo.se, trini@konsulko.com,
 gajjar04akash@gmail.com, eugen.hristev@linaro.org,
 quentin.schulz@cherry.de, macromorgan@hotmail.com,
 maximmosk4@gmail.com, dsimic@manjaro.org,
 christopher.obbard@linaro.org, wens@csie.org,
 sebastian.reichel@collabora.com, FUKAUMI Naoki <naoki@radxa.com>
Subject: [PATCH 6/6] rockchip: Add DFU to boot from USB for Radxa ROCK Pi S
Date: Tue, 11 Feb 2025 06:13:22 +0000
Message-ID: <20250211061322.94186-7-naoki@radxa.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250211061322.94186-1-naoki@radxa.com>
References: <20250211061322.94186-1-naoki@radxa.com>
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

Boot the Radxa ROCK Pi S from the USB OTG port using rkflashtool[1] or
rkusbboot[2] and dfu-util.

1a. Download the TPL and SPL using rkflashtool

$ openssl rc4 -provider legacy -K 7c4e0304550509072d2c7b38170d1711 \
	< mkimage-in-simple-bin.mkimage-rockchip-tpl | rkflashtool l
$ openssl rc4 -provider legacy -K 7c4e0304550509072d2c7b38170d1711 \
	< mkimage-in-simple-bin.mkimage-u-boot-spl | rkflashtool L

1b. Download the TPL and SPL using rkusbboot

$ rkusbboot \
	mkimage-in-simple-bin.mkimage-rockchip-tpl \
	mkimage-in-simple-bin.mkimage-u-boot-spl

2. Download the U-Boot

$ dfu-util -a 0 -D u-boot.itb

[1] https://github.com/linux-rockchip/rkflashtool
[2] https://github.com/RadxaNaoki/rkusbboot

Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
---
 configs/rock-pi-s-rk3308_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/configs/rock-pi-s-rk3308_defconfig b/configs/rock-pi-s-rk3308_defconfig
index 4b08af309b1..29eb6a26bfb 100644
--- a/configs/rock-pi-s-rk3308_defconfig
+++ b/configs/rock-pi-s-rk3308_defconfig
@@ -19,6 +19,8 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3308-rock-pi-s.dtb"
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
@@ -35,6 +37,9 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_CLK=y
+CONFIG_DFU_RAM=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
+CONFIG_SYS_DFU_MAX_FILE_SIZE=0x200000
 # CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
@@ -62,11 +67,14 @@ CONFIG_SYSINFO=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
+CONFIG_SPL_DM_USB_GADGET=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_FUNCTION_ROCKUSB=y
+CONFIG_SPL_DFU=y
 CONFIG_LZO=y
 CONFIG_ERRNO_STR=y
-- 
2.43.0

