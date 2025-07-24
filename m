Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87DAC83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 07:33:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 186528365E;
	Thu, 24 Jul 2025 09:33:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MKqNbibU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AAE783655; Thu, 24 Jul 2025 09:33:24 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BD1783669
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 09:33:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aef575ad59eso116030466b.2
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 00:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753342402; x=1753947202; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3easQBFGuv9t7rYjXTWDF1fSzLR0+RX/O6Bk/T4ZYAg=;
 b=MKqNbibUIK9cFL3/5TZHsR/jNKl8IFTQ8iiKoFG6x9C0TU7Vt+b0sMlU+mcdv8lKpk
 b924615QZ5Oj21+h9P8K5Shdf8hMuaNnC8AzKC/q7Z3ejv168L+XtEMIMgmQ5/Dvemr4
 BR+FmjR7Q2XhxC1x9VNfC8cLTBeY+tW72hXgnkFc2kExFZhhLz4phw9r4OW31hEp1tC7
 CBcHQTUUjllFNgKuXWWHIflRMpJUAKlaA4Xe9Twf0YCSv2zacJA7sT8Ds0M4GhCIGUFl
 kDIDHsilCHFIGWnLwmGymuRmy9aPPtOa2uw4PW9W0ea5k3kCiko8aEzud6tcSKAa5uVy
 mNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753342402; x=1753947202;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3easQBFGuv9t7rYjXTWDF1fSzLR0+RX/O6Bk/T4ZYAg=;
 b=VldCo8YPCzDs76VhvtaQ3/Tf0UEGJqGqAgbQN53/lPqBEN595QtWfdtRl/ATneAe9q
 tTejc7SqXLt2aTl89PcwtQjUNLSqP0K7MCVFtdUVNhMz9mCqTnHub3B9uS4y+chfpnDj
 P0u4ueWYdUBa0cJeiADWCnWwolR+/n11AR2Yxx+1WrC1Mk1k9saC27tfEUlW5p3DAMQg
 0CwCOYVNTVds1AFrzcSTMYqgbn4NplFQNhtYQVwhSahDFY+J1orq9ZljYOCRAn+QfB9+
 xjC2cmR2/7ieXNQQpE3ZgVnOMDMG6W8T7qGS6NqJE3DUZVvbAWTECKSqJQC0jirYBOll
 NWMw==
X-Gm-Message-State: AOJu0YzxU6QOFcEkLivJjxmgiBKpPgJ1YXZdz1Mdoj3cQcn5LT2CffGK
 /yNGykCGgRo9hPvQS4wop1Wd+m356GW+exxSm5h6CDKlMobdCMDQBEN3m45TWQLNFTWWBFeK2RQ
 p1GPHdbyaKI2uLIA/JbnWUU5Nu/jGFqb82+Pc
X-Gm-Gg: ASbGncug6yIe2LjHM3zKtkRqhz795Pymbk1VkEK1zuMfQ5i+FSuT0FDO2AM3iJLSvjb
 mwwvs+G5F93XNDdD9yHLWszn+Uujhn1SrciOPkLg5IOVtjWbnc+9x58+xNf287xZPSsTu9xL4/0
 dyiRXfsKLqnEQgZLKzjt22YQN1Aj1RCTiQu5avLqkNR7MZNiKxdntpVlNJoxATGoaf7wIP2tJXz
 Z3LFxYmSXsSXMF3/IW7rJY3P4hrG+kuWGT31zYGz7CmpKi7SuM=
X-Google-Smtp-Source: AGHT+IF6qiaZ0lcLzOkLYxmylovLXpmqRw3LJKRyOVSichhA4nxbplZsgxcQkhFUGgqdmkqItUSq0LpVGAlE7I1vHvE=
X-Received: by 2002:a17:907:9444:b0:ae3:5e70:330d with SMTP id
 a640c23a62f3a-af2f66c1f64mr599486866b.12.1753342401334; Thu, 24 Jul 2025
 00:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <jwv8qkea94d.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
In-Reply-To: <jwv8qkea94d.fsf-monnier+gmane.comp.boot-loaders.u-boot@gnu.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 24 Jul 2025 08:33:10 +0100
X-Gm-Features: Ac12FXx16CN2rIRQmC1ReWG_XzPOSjxl3vSFVlI7Qsfnwr98E9F2pMjTJVu9obU
Message-ID: <CALeDE9NDru0WLy14gFRAnk=O+hVUS7D-b1Qg3Su+96FQQ8EVBA@mail.gmail.com>
Subject: Re: HDMI support for rockchip SBC
To: Stefan Monnier <monnier@iro.umontreal.ca>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 23 Jul 2025 at 23:40, Stefan Monnier <monnier@iro.umontreal.ca> wrote:
>
> [ AFAICT this mailing-list is used for development of U-Boot more than
>   for users of U-Boot.  I s there a more appropriate mailing-list, for
>   users?  ]
>
> I'm building the bootloader for two different SBCs, both based on rk3568
> (NanoPi R5S and Odroid-M1), and using the default config for those boards
> I can easily make a bootloader that successfully loads my Debian
> installation, but sadly it's all "blind" until the Linux kernel
> initializes the display.
>
> I saw that the default config does not include support for the HDMI
> output, so I figured it would be easy to fix but I still haven't managed
> to get any visual.
>
> I made the following changes:
>
> - Set CONFIG_BOOTDELAY to 10, to minimize the risk that my monitor
>   sleeps through it all.
> - I enabled: CONFIG_USB_KEYBOARD, CONFIG_VIDEO, CONFIG_VIDEO_ROCKCHIP,
>   CONFIG_DISPLAY_ROCKCHIP_HDMI, CONFIG_DISPLAY, and CONFIG_VIDEO_DT_SIMPLEFB.
>
> but still, nothing shows up on my screen until the Linux kernel
> configures the display (and pressing a key on the keyboard doesn't seem
> to prevent autobooting).
>
> What am I missing?

Support for the rk35xx isn't upstream yet, this patch series is likely
a good start:
https://lists.denx.de/pipermail/u-boot/2025-June/591737.html

>         Stefan
>
>
> --- .config.ORIG        2025-07-23 20:27:50.725403359 +0000
> +++ .config     2025-07-23 21:12:52.281271378 +0000
> @@ -464,6 +464,7 @@
>  CONFIG_BOOTSTD_FULL=y
>  CONFIG_BOOTSTD_DEFAULTS=y
>  CONFIG_BOOTSTD_BOOTCOMMAND=y
> +CONFIG_BOOTSTD_MENU=y
>  CONFIG_BOOTMETH_GLOBAL=y
>  # CONFIG_BOOTMETH_ANDROID is not set
>  # CONFIG_BOOTMETH_CROS is not set
> @@ -480,6 +481,7 @@
>  # CONFIG_BOOTMETH_VBE_ABREC is not set
>  CONFIG_BOOTMETH_VBE_SIMPLE_OS=y
>  # CONFIG_SPL_BOOTMETH_VBE_SIMPLE is not set
> +CONFIG_EXPO=y
>  # CONFIG_BOOTMETH_RAUC is not set
>  CONFIG_BOOTMETH_SCRIPT=y
>  # CONFIG_UPL is not set
> @@ -512,7 +514,7 @@
>  # Autoboot options
>  #
>  CONFIG_AUTOBOOT=y
> -CONFIG_BOOTDELAY=2
> +CONFIG_BOOTDELAY=10
>  # CONFIG_AUTOBOOT_KEYED is not set
>  # CONFIG_AUTOBOOT_USE_MENUKEY is not set
>  # CONFIG_BOOT_RETRY is not set
> @@ -531,6 +533,7 @@
>  # CONFIG_OF_SYSTEM_SETUP is not set
>  # CONFIG_OF_STDOUT_VIA_ALIAS is not set
>  # CONFIG_FDT_FIXUP_PARTITIONS is not set
> +# CONFIG_FDT_SIMPLEFB is not set
>  CONFIG_ARCH_FIXUP_FDT_MEMORY=y
>  # CONFIG_USE_BOOTARGS is not set
>  # CONFIG_BOOTARGS_SUBST is not set
> @@ -544,6 +547,7 @@
>  #
>  # Configuration editor
>  #
> +# CONFIG_CEDIT is not set
>
>  #
>  # Console
> @@ -565,7 +569,7 @@
>  # CONFIG_SYS_CONSOLE_IS_IN_ENV is not set
>  # CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE is not set
>  # CONFIG_SYS_CONSOLE_INFO_QUIET is not set
> -# CONFIG_SYS_STDIO_DEREGISTER is not set
> +CONFIG_SYS_STDIO_DEREGISTER=y
>  # CONFIG_SPL_SYS_STDIO_DEREGISTER is not set
>  # CONFIG_SYS_DEVICE_NULLDEV is not set
>
> @@ -945,6 +949,7 @@
>  # Misc commands
>  #
>  # CONFIG_CMD_2048 is not set
> +# CONFIG_CMD_BMP is not set
>  # CONFIG_CMD_BSP is not set
>  CONFIG_CMD_BLOCK_CACHE=y
>  # CONFIG_CMD_CACHE is not set
> @@ -967,6 +972,8 @@
>  # CONFIG_CMD_PSTORE is not set
>  # CONFIG_CMD_TERMINAL is not set
>  # CONFIG_CMD_UUID is not set
> +CONFIG_CMD_VIDCONSOLE=y
> +# CONFIG_CMD_SELECT_FONT is not set
>
>  #
>  # TI specific command line interface
> @@ -1368,9 +1375,12 @@
>  # CONFIG_I2C_MUX is not set
>  CONFIG_INPUT=y
>  # CONFIG_SPL_INPUT is not set
> -# CONFIG_DM_KEYBOARD is not set
> +CONFIG_DM_KEYBOARD=y
>  # CONFIG_SPL_DM_KEYBOARD is not set
> +# CONFIG_APPLE_SPI_KEYB is not set
> +# CONFIG_BUTTON_KEYBOARD is not set
>  # CONFIG_CROS_EC_KEYB is not set
> +# CONFIG_I8042_KEYB is not set
>  # CONFIG_TWL4030_INPUT is not set
>
>  #
> @@ -2138,9 +2148,13 @@
>  # USB peripherals
>  #
>  CONFIG_USB_STORAGE=y
> -# CONFIG_USB_KEYBOARD is not set
> +CONFIG_USB_KEYBOARD=y
>  # CONFIG_USB_ONBOARD_HUB is not set
>  CONFIG_USB_HUB_DEBOUNCE_TIMEOUT=1000
> +CONFIG_USB_KEYBOARD_FN_KEYS=y
> +CONFIG_SYS_USB_EVENT_POLL=y
> +# CONFIG_SYS_USB_EVENT_POLL_VIA_INT_QUEUE is not set
> +# CONFIG_SYS_USB_EVENT_POLL_VIA_CONTROL_EP is not set
>  # CONFIG_USB_HOST_ETHER is not set
>  # CONFIG_USB_GADGET is not set
>  # CONFIG_SPL_USB_GADGET is not set
> @@ -2153,7 +2167,105 @@
>  #
>  # Graphics support
>  #
> -# CONFIG_VIDEO is not set
> +CONFIG_VIDEO=y
> +# CONFIG_VIDEO_FONT_4X6 is not set
> +CONFIG_VIDEO_FONT_8X16=y
> +# CONFIG_VIDEO_FONT_SUN12X22 is not set
> +# CONFIG_VIDEO_FONT_16X32 is not set
> +CONFIG_VIDEO_LOGO=y
> +CONFIG_BACKLIGHT=y
> +CONFIG_VIDEO_PCI_DEFAULT_FB_SIZE=0x0
> +# CONFIG_VIDEO_COPY is not set
> +CONFIG_VIDEO_DAMAGE=y
> +CONFIG_BACKLIGHT_PWM=y
> +# CONFIG_BACKLIGHT_GPIO is not set
> +CONFIG_VIDEO_BPP8=y
> +CONFIG_VIDEO_BPP16=y
> +CONFIG_VIDEO_BPP32=y
> +CONFIG_VIDEO_ANSI=y
> +# CONFIG_VIDEO_MIPI_DSI is not set
> +CONFIG_CONSOLE_NORMAL=y
> +# CONFIG_CONSOLE_ROTATION is not set
> +# CONFIG_CONSOLE_TRUETYPE is not set
> +CONFIG_SYS_WHITE_ON_BLACK=y
> +# CONFIG_NO_FB_CLEAR is not set
> +CONFIG_VIDEO_SYNC_MS=100
> +CONFIG_PANEL=y
> +CONFIG_SIMPLE_PANEL=y
> +# CONFIG_PANEL_HX8238D is not set
> +
> +#
> +# TrueType Fonts
> +#
> +# CONFIG_VIDEO_BOCHS is not set
> +# CONFIG_VIDEO_VESA is not set
> +# CONFIG_VIDEO_LCD_ANX9804 is not set
> +# CONFIG_ATMEL_LCD_BGR555 is not set
> +# CONFIG_VIDEO_BCM2835 is not set
> +# CONFIG_VIDEO_LCD_ENDEAVORU is not set
> +# CONFIG_VIDEO_LCD_HIMAX_HX8394 is not set
> +# CONFIG_VIDEO_LCD_MOT is not set
> +# CONFIG_VIDEO_LCD_NOVATEK_NT35510 is not set
> +# CONFIG_VIDEO_LCD_ORISETECH_OTM8009A is not set
> +# CONFIG_VIDEO_LCD_LG_LD070WX3 is not set
> +# CONFIG_VIDEO_LCD_LG_LH400WV3 is not set
> +# CONFIG_VIDEO_LCD_RAYDIUM_RM68200 is not set
> +# CONFIG_VIDEO_LCD_RENESAS_R61307 is not set
> +# CONFIG_VIDEO_LCD_RENESAS_R69328 is not set
> +# CONFIG_VIDEO_LCD_SAMSUNG_LTL106HL02 is not set
> +# CONFIG_VIDEO_LCD_SHARP_LQ079L1SX01 is not set
> +# CONFIG_VIDEO_LCD_SHARP_LQ101R1SX01 is not set
> +# CONFIG_VIDEO_LCD_SSD2828 is not set
> +# CONFIG_VIDEO_LCD_TDO_TL070WSH30 is not set
> +# CONFIG_VIDEO_LCD_HITACHI_TX10D07VM0BAA is not set
> +# CONFIG_VIDEO_LCD_HITACHI_TX18D42VM is not set
> +# CONFIG_VIDEO_MESON is not set
> +# CONFIG_VIDEO_MVEBU is not set
> +CONFIG_I2C_EDID=y
> +# CONFIG_I2C_EDID_STANDARD is not set
> +CONFIG_DISPLAY=y
> +# CONFIG_NXP_TDA19988 is not set
> +# CONFIG_ATMEL_HLCD is not set
> +# CONFIG_BACKLIGHT_AAT2870 is not set
> +# CONFIG_BACKLIGHT_LM3532 is not set
> +# CONFIG_BACKLIGHT_LM3533 is not set
> +# CONFIG_BACKLIGHT_LP855x is not set
> +# CONFIG_AM335X_LCD is not set
> +# CONFIG_VIDEO_EXYNOS is not set
> +# CONFIG_LOGICORE_DP_TX is not set
> +CONFIG_VIDEO_ROCKCHIP=y
> +CONFIG_VIDEO_ROCKCHIP_MAX_XRES=3840
> +CONFIG_VIDEO_ROCKCHIP_MAX_YRES=2160
> +# CONFIG_DISPLAY_ROCKCHIP_EDP is not set
> +# CONFIG_DISPLAY_ROCKCHIP_LVDS is not set
> +CONFIG_DISPLAY_ROCKCHIP_HDMI=y
> +# CONFIG_DISPLAY_ROCKCHIP_MIPI is not set
> +# CONFIG_DISPLAY_ROCKCHIP_DW_MIPI is not set
> +# CONFIG_VIDEO_ARM_MALIDP is not set
> +# CONFIG_VIDEO_STM32 is not set
> +# CONFIG_VIDEO_TIDSS is not set
> +# CONFIG_VIDEO_BRIDGE is not set
> +# CONFIG_HOST1X_TEGRA is not set
> +# CONFIG_VIDEO_TEGRA is not set
> +# CONFIG_TEGRA_BACKLIGHT_PWM is not set
> +# CONFIG_VIDEO_TEGRA124 is not set
> +# CONFIG_IMX_LCDIF is not set
> +# CONFIG_VIDEO_MXS is not set
> +# CONFIG_VIDEO_SEPS525 is not set
> +CONFIG_CONSOLE_SCROLL_LINES=1
> +CONFIG_VIDEO_DW_HDMI=y
> +# CONFIG_VIDEO_SIMPLE is not set
> +CONFIG_VIDEO_DT_SIMPLEFB=y
> +# CONFIG_VIDEO_MCDE_SIMPLE is not set
> +# CONFIG_OSD is not set
> +# CONFIG_VIDEO_REMOVE is not set
> +# CONFIG_SPLASH_SCREEN is not set
> +# CONFIG_BMP is not set
> +CONFIG_VIDEO_LOGO_MAX_SIZE=0x100000
> +CONFIG_VIDEO_BMP_RLE8=y
> +# CONFIG_BMP_16BPP is not set
> +# CONFIG_BMP_24BPP is not set
> +# CONFIG_BMP_32BPP is not set
>  # CONFIG_SPL_VIDEO is not set
>
