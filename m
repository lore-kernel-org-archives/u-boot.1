Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9439DC83F17
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 22:12:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC1608357D;
	Thu, 24 Jul 2025 00:12:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=iro.umontreal.ca
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iro.umontreal.ca header.i=@iro.umontreal.ca header.b="nsJ178J6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B86B583599; Thu, 24 Jul 2025 00:11:53 +0200 (CEST)
Received: from mailscanner.iro.umontreal.ca (mailscanner.iro.umontreal.ca
 [132.204.25.50])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E596083577
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 00:11:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=iro.umontreal.ca
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=monnier@iro.umontreal.ca
Received: from pmg2.iro.umontreal.ca (localhost.localdomain [127.0.0.1])
 by pmg2.iro.umontreal.ca (Proxmox) with ESMTP id 27BED809C1;
 Wed, 23 Jul 2025 18:11:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iro.umontreal.ca;
 s=mail; t=1753308706;
 bh=l5TJKhkdALqkxdVQDtuNHZqeqWb9VSHC/F/4y9GH0Po=;
 h=From:To:Subject:Date:From;
 b=nsJ178J6wrYdvIkU+9GF/rbVBXJFeI7UU4HZ3Yt0GjjbwAt0Wzp2DCo89LldC4x4s
 5tZOJhq2e1Q93oJCzSUjSDQHm55mNccLBgPlYDuR268ZErT4oGtTuYolXzV9blhhgA
 7zgnE4XDHUYJBS5zDfMOrxc0OQRxylbhYW5fMN+zuC7Di12qRWHArdZppeCH4uQyW4
 HnTkor7XVa9uCnnQzl5J04CGIFXYANxd83Sq4ccGP4u89ocIWtugA/gwyAOKkA1m3B
 LrBAmmFrZIXK3kWjotH/mbAmUtnUbrBuBQybacN21ivgDjnxY5oc2wHBoRXUr5OLO0
 Ujg4JhVqsh58w==
Received: from mail01.iro.umontreal.ca (unknown [172.31.2.1])
 by pmg2.iro.umontreal.ca (Proxmox) with ESMTP id C1F2C805DC;
 Wed, 23 Jul 2025 18:11:46 -0400 (EDT)
Received: from lechazo (lechon.iro.umontreal.ca [132.204.27.242])
 by mail01.iro.umontreal.ca (Postfix) with ESMTPSA id B3DDF120331;
 Wed, 23 Jul 2025 18:11:46 -0400 (EDT)
From: Stefan Monnier <monnier@iro.umontreal.ca>
To: u-boot@lists.denx.de 
Subject: HDMI support for rockchip SBC
Message-ID: <jwv8qkea94d.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
Date: Wed, 23 Jul 2025 18:11:46 -0400
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 24 Jul 2025 00:12:26 +0200
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

[ AFAICT this mailing-list is used for development of U-Boot more than
  for users of U-Boot.  I s there a more appropriate mailing-list, for
  users?  ]

I'm building the bootloader for two different SBCs, both based on rk3568
(NanoPi R5S and Odroid-M1), and using the default config for those boards
I can easily make a bootloader that successfully loads my Debian
installation, but sadly it's all "blind" until the Linux kernel
initializes the display.

I saw that the default config does not include support for the HDMI
output, so I figured it would be easy to fix but I still haven't managed
to get any visual.

I made the following changes:

- Set CONFIG_BOOTDELAY to 10, to minimize the risk that my monitor
  sleeps through it all.
- I enabled: CONFIG_USB_KEYBOARD, CONFIG_VIDEO, CONFIG_VIDEO_ROCKCHIP,
  CONFIG_DISPLAY_ROCKCHIP_HDMI, CONFIG_DISPLAY, and CONFIG_VIDEO_DT_SIMPLEFB.

but still, nothing shows up on my screen until the Linux kernel
configures the display (and pressing a key on the keyboard doesn't seem
to prevent autobooting).

What am I missing?


        Stefan


--- .config.ORIG        2025-07-23 20:27:50.725403359 +0000
+++ .config     2025-07-23 21:12:52.281271378 +0000
@@ -464,6 +464,7 @@
 CONFIG_BOOTSTD_FULL=y
 CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_BOOTSTD_BOOTCOMMAND=y
+CONFIG_BOOTSTD_MENU=y
 CONFIG_BOOTMETH_GLOBAL=y
 # CONFIG_BOOTMETH_ANDROID is not set
 # CONFIG_BOOTMETH_CROS is not set
@@ -480,6 +481,7 @@
 # CONFIG_BOOTMETH_VBE_ABREC is not set
 CONFIG_BOOTMETH_VBE_SIMPLE_OS=y
 # CONFIG_SPL_BOOTMETH_VBE_SIMPLE is not set
+CONFIG_EXPO=y
 # CONFIG_BOOTMETH_RAUC is not set
 CONFIG_BOOTMETH_SCRIPT=y
 # CONFIG_UPL is not set
@@ -512,7 +514,7 @@
 # Autoboot options
 #
 CONFIG_AUTOBOOT=y
-CONFIG_BOOTDELAY=2
+CONFIG_BOOTDELAY=10
 # CONFIG_AUTOBOOT_KEYED is not set
 # CONFIG_AUTOBOOT_USE_MENUKEY is not set
 # CONFIG_BOOT_RETRY is not set
@@ -531,6 +533,7 @@
 # CONFIG_OF_SYSTEM_SETUP is not set
 # CONFIG_OF_STDOUT_VIA_ALIAS is not set
 # CONFIG_FDT_FIXUP_PARTITIONS is not set
+# CONFIG_FDT_SIMPLEFB is not set
 CONFIG_ARCH_FIXUP_FDT_MEMORY=y
 # CONFIG_USE_BOOTARGS is not set
 # CONFIG_BOOTARGS_SUBST is not set
@@ -544,6 +547,7 @@
 #
 # Configuration editor
 #
+# CONFIG_CEDIT is not set
 
 #
 # Console
@@ -565,7 +569,7 @@
 # CONFIG_SYS_CONSOLE_IS_IN_ENV is not set
 # CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE is not set
 # CONFIG_SYS_CONSOLE_INFO_QUIET is not set
-# CONFIG_SYS_STDIO_DEREGISTER is not set
+CONFIG_SYS_STDIO_DEREGISTER=y
 # CONFIG_SPL_SYS_STDIO_DEREGISTER is not set
 # CONFIG_SYS_DEVICE_NULLDEV is not set
 
@@ -945,6 +949,7 @@
 # Misc commands
 #
 # CONFIG_CMD_2048 is not set
+# CONFIG_CMD_BMP is not set
 # CONFIG_CMD_BSP is not set
 CONFIG_CMD_BLOCK_CACHE=y
 # CONFIG_CMD_CACHE is not set
@@ -967,6 +972,8 @@
 # CONFIG_CMD_PSTORE is not set
 # CONFIG_CMD_TERMINAL is not set
 # CONFIG_CMD_UUID is not set
+CONFIG_CMD_VIDCONSOLE=y
+# CONFIG_CMD_SELECT_FONT is not set
 
 #
 # TI specific command line interface
@@ -1368,9 +1375,12 @@
 # CONFIG_I2C_MUX is not set
 CONFIG_INPUT=y
 # CONFIG_SPL_INPUT is not set
-# CONFIG_DM_KEYBOARD is not set
+CONFIG_DM_KEYBOARD=y
 # CONFIG_SPL_DM_KEYBOARD is not set
+# CONFIG_APPLE_SPI_KEYB is not set
+# CONFIG_BUTTON_KEYBOARD is not set
 # CONFIG_CROS_EC_KEYB is not set
+# CONFIG_I8042_KEYB is not set
 # CONFIG_TWL4030_INPUT is not set
 
 #
@@ -2138,9 +2148,13 @@
 # USB peripherals
 #
 CONFIG_USB_STORAGE=y
-# CONFIG_USB_KEYBOARD is not set
+CONFIG_USB_KEYBOARD=y
 # CONFIG_USB_ONBOARD_HUB is not set
 CONFIG_USB_HUB_DEBOUNCE_TIMEOUT=1000
+CONFIG_USB_KEYBOARD_FN_KEYS=y
+CONFIG_SYS_USB_EVENT_POLL=y
+# CONFIG_SYS_USB_EVENT_POLL_VIA_INT_QUEUE is not set
+# CONFIG_SYS_USB_EVENT_POLL_VIA_CONTROL_EP is not set
 # CONFIG_USB_HOST_ETHER is not set
 # CONFIG_USB_GADGET is not set
 # CONFIG_SPL_USB_GADGET is not set
@@ -2153,7 +2167,105 @@
 #
 # Graphics support
 #
-# CONFIG_VIDEO is not set
+CONFIG_VIDEO=y
+# CONFIG_VIDEO_FONT_4X6 is not set
+CONFIG_VIDEO_FONT_8X16=y
+# CONFIG_VIDEO_FONT_SUN12X22 is not set
+# CONFIG_VIDEO_FONT_16X32 is not set
+CONFIG_VIDEO_LOGO=y
+CONFIG_BACKLIGHT=y
+CONFIG_VIDEO_PCI_DEFAULT_FB_SIZE=0x0
+# CONFIG_VIDEO_COPY is not set
+CONFIG_VIDEO_DAMAGE=y
+CONFIG_BACKLIGHT_PWM=y
+# CONFIG_BACKLIGHT_GPIO is not set
+CONFIG_VIDEO_BPP8=y
+CONFIG_VIDEO_BPP16=y
+CONFIG_VIDEO_BPP32=y
+CONFIG_VIDEO_ANSI=y
+# CONFIG_VIDEO_MIPI_DSI is not set
+CONFIG_CONSOLE_NORMAL=y
+# CONFIG_CONSOLE_ROTATION is not set
+# CONFIG_CONSOLE_TRUETYPE is not set
+CONFIG_SYS_WHITE_ON_BLACK=y
+# CONFIG_NO_FB_CLEAR is not set
+CONFIG_VIDEO_SYNC_MS=100
+CONFIG_PANEL=y
+CONFIG_SIMPLE_PANEL=y
+# CONFIG_PANEL_HX8238D is not set
+
+#
+# TrueType Fonts
+#
+# CONFIG_VIDEO_BOCHS is not set
+# CONFIG_VIDEO_VESA is not set
+# CONFIG_VIDEO_LCD_ANX9804 is not set
+# CONFIG_ATMEL_LCD_BGR555 is not set
+# CONFIG_VIDEO_BCM2835 is not set
+# CONFIG_VIDEO_LCD_ENDEAVORU is not set
+# CONFIG_VIDEO_LCD_HIMAX_HX8394 is not set
+# CONFIG_VIDEO_LCD_MOT is not set
+# CONFIG_VIDEO_LCD_NOVATEK_NT35510 is not set
+# CONFIG_VIDEO_LCD_ORISETECH_OTM8009A is not set
+# CONFIG_VIDEO_LCD_LG_LD070WX3 is not set
+# CONFIG_VIDEO_LCD_LG_LH400WV3 is not set
+# CONFIG_VIDEO_LCD_RAYDIUM_RM68200 is not set
+# CONFIG_VIDEO_LCD_RENESAS_R61307 is not set
+# CONFIG_VIDEO_LCD_RENESAS_R69328 is not set
+# CONFIG_VIDEO_LCD_SAMSUNG_LTL106HL02 is not set
+# CONFIG_VIDEO_LCD_SHARP_LQ079L1SX01 is not set
+# CONFIG_VIDEO_LCD_SHARP_LQ101R1SX01 is not set
+# CONFIG_VIDEO_LCD_SSD2828 is not set
+# CONFIG_VIDEO_LCD_TDO_TL070WSH30 is not set
+# CONFIG_VIDEO_LCD_HITACHI_TX10D07VM0BAA is not set
+# CONFIG_VIDEO_LCD_HITACHI_TX18D42VM is not set
+# CONFIG_VIDEO_MESON is not set
+# CONFIG_VIDEO_MVEBU is not set
+CONFIG_I2C_EDID=y
+# CONFIG_I2C_EDID_STANDARD is not set
+CONFIG_DISPLAY=y
+# CONFIG_NXP_TDA19988 is not set
+# CONFIG_ATMEL_HLCD is not set
+# CONFIG_BACKLIGHT_AAT2870 is not set
+# CONFIG_BACKLIGHT_LM3532 is not set
+# CONFIG_BACKLIGHT_LM3533 is not set
+# CONFIG_BACKLIGHT_LP855x is not set
+# CONFIG_AM335X_LCD is not set
+# CONFIG_VIDEO_EXYNOS is not set
+# CONFIG_LOGICORE_DP_TX is not set
+CONFIG_VIDEO_ROCKCHIP=y
+CONFIG_VIDEO_ROCKCHIP_MAX_XRES=3840
+CONFIG_VIDEO_ROCKCHIP_MAX_YRES=2160
+# CONFIG_DISPLAY_ROCKCHIP_EDP is not set
+# CONFIG_DISPLAY_ROCKCHIP_LVDS is not set
+CONFIG_DISPLAY_ROCKCHIP_HDMI=y
+# CONFIG_DISPLAY_ROCKCHIP_MIPI is not set
+# CONFIG_DISPLAY_ROCKCHIP_DW_MIPI is not set
+# CONFIG_VIDEO_ARM_MALIDP is not set
+# CONFIG_VIDEO_STM32 is not set
+# CONFIG_VIDEO_TIDSS is not set
+# CONFIG_VIDEO_BRIDGE is not set
+# CONFIG_HOST1X_TEGRA is not set
+# CONFIG_VIDEO_TEGRA is not set
+# CONFIG_TEGRA_BACKLIGHT_PWM is not set
+# CONFIG_VIDEO_TEGRA124 is not set
+# CONFIG_IMX_LCDIF is not set
+# CONFIG_VIDEO_MXS is not set
+# CONFIG_VIDEO_SEPS525 is not set
+CONFIG_CONSOLE_SCROLL_LINES=1
+CONFIG_VIDEO_DW_HDMI=y
+# CONFIG_VIDEO_SIMPLE is not set
+CONFIG_VIDEO_DT_SIMPLEFB=y
+# CONFIG_VIDEO_MCDE_SIMPLE is not set
+# CONFIG_OSD is not set
+# CONFIG_VIDEO_REMOVE is not set
+# CONFIG_SPLASH_SCREEN is not set
+# CONFIG_BMP is not set
+CONFIG_VIDEO_LOGO_MAX_SIZE=0x100000
+CONFIG_VIDEO_BMP_RLE8=y
+# CONFIG_BMP_16BPP is not set
+# CONFIG_BMP_24BPP is not set
+# CONFIG_BMP_32BPP is not set
 # CONFIG_SPL_VIDEO is not set

