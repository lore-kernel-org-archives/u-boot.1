Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DEB5C4828F
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 10:34:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4973587E11;
	Thu,  8 Feb 2024 11:33:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CKas6Dej";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47AD787E21; Thu,  8 Feb 2024 11:33:56 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A247387DFF
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 11:33:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33b0e5d1e89so1364016f8f.0
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 02:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707388433; x=1707993233;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=KDknJ67l+vkS24SK0iZ7AH306bsau8l0OTJEXXlYJoA=;
 b=CKas6DejyOOlDhxMOXmXkMJS04rMzfnfTa9EzcAD41lQ+n8jE/tJCYmZVr7kl2lQ9w
 b6uZbFlT2Dzla0T3d7IM7eec6lSv+0QIIaShRVIx42qyc/I4zvWsd9vTJWjd6SYNZFYf
 46SXuFZKHah02NrIOPfygXZtM9BRWb7pzCAKs6kuvqkh2y9zX/MBG6xagnx/EzA7w/m3
 uz6YHtOptTlZEBJNOTuTfJTC37Q53XWXAyqk0yRSi0RW2giTtgaSymZaY1Hv7usNINIv
 3t2B6SgdWvNEOnuWvgZJHGs47DFgZItRJMi1pp/LEWUMuGuF++BCFlL7v4PnTKqzV8vk
 hmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707388433; x=1707993233;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KDknJ67l+vkS24SK0iZ7AH306bsau8l0OTJEXXlYJoA=;
 b=KQ0U5oFkF/d4MGTsJCG0TsiGEjVEHdomMU/SDMc0+man+d3VGJ21osTrfV/NteVHlW
 BXaSR5b5nYQ4mICbb2Ie//LEjBulGiUBjuZL66LCuWRMGRaM2noEKhOZsywnxHBb+qCl
 PM9hYvG7oXhbi8opjovL1G5jmGrnqsqIqO5GWZcjG5+VHTZf4vE0LCT/t1q49U7SPdsf
 lGSDzE3TN5hk6QMNr9Xo7wF6u+FUOIJVTPHqCsQLR8F98o8jVHIHwrJ+821hycCZMuGk
 yd7ZYKgJUdaXeenUo2mPuEMIGULnbzymgND5N3EnyiNuHA4W2e7NSaXjuaQb6KMf1Q9M
 a9DA==
X-Gm-Message-State: AOJu0Yxk27Fzgb9SDAH7igMsEYTZ9tyYsiE0kL+jRRPBfd4BGcMfAk5z
 7798a8Kcd7Va92WnWImUIAVKFmcFlSpSxpIPI9QH+3TUABRZ1HLCx7jlF9IWdtA=
X-Google-Smtp-Source: AGHT+IGtoRLaRmQB7ijEBYLTjCHP7M1dvfse1nAcqtWW4N0NHtQY6p39LrdRHmCCqtm5aZi4+UpPZA==
X-Received: by 2002:a05:6000:2:b0:33b:3c99:357a with SMTP id
 h2-20020a056000000200b0033b3c99357amr4764759wrx.28.1707388432919; 
 Thu, 08 Feb 2024 02:33:52 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX42CleD5tHjZMHcLxj3lfwZzTlBseimCRNsvVtjouIogt6L7QPlqkFyHTXTdURiEYXCVdPmAec1c3jBVuOApop1S3pdwwVg91Q1tbdXIdXloax7Mu30pwqvykQZUMwevRJ6xhmCONVpXqJI17A9V4gb8/W0j1Zn6fFOxaGo30Fy/nbvirjp8OkzDt4ct9KXAdxaAC9tlokfPYBsY1oKC/QYf0Sh6KJ8LeCZyxqELvAsQtZAh7PUxl2ro77d4MYEbXG8D6d
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 j9-20020a5d6189000000b0033b0e82b23asm3313563wru.47.2024.02.08.02.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 02:33:52 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Sjoerd Simons <sjoerd@collabora.com>, u-boot@lists.denx.de
Cc: Martyn Welch <martyn.welch@collabora.com>, Roger Quadros
 <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>, Andrew Davis
 <afd@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Kamlesh Gurudasani
 <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Nikhil M Jain
 <n-jain1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>
Subject: Re: [PATCH v4 5/7] configs: am62x_evm_*: Enable USB and DFU support
In-Reply-To: <20240112085317.1866449-6-sjoerd@collabora.com>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
 <20240112085317.1866449-6-sjoerd@collabora.com>
Date: Thu, 08 Feb 2024 11:33:51 +0100
Message-ID: <87h6ijjldc.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Sjoerd,

Thank you for the patch.

On ven., janv. 12, 2024 at 09:52, Sjoerd Simons <sjoerd@collabora.com> wrote:

> Enable USB host as well as USB gadget and DFU support for a53; For the
> r5 due to the smaller available size create a config fragment for DFU
> supports which disables support for persistent storage to free up space
> for USB support
>
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>

I know this will be reworked in v5 (to use defconfig fragments) as
discussed in [1] but i'd still like to give some feedback on my testing.

Applying this series seems to break eMMC booting for me on AM62x SK EVM:

U-Boot SPL 2024.04-rc1-00106-g7c3798e43744 (Feb 08 2024 - 10:41:17 +0100)
SYSFW ABI: 3.1 (firmware rev 0x0009 '9.1.8--v09.01.08 (Kool Koala)')
SPL initial stack usage: 13368 bytes
Trying to boot from MMC1
alloc space exhausted
spl_load_image_fat: error reading image tispl.bin, err - -22
SPL: failed to boot from all boot devices
### ERROR ### Please RESET the board ###

It seems that the size of tispl.bin gets too big because of this commit.

Before series:
~/work/ti/src/bootloaders-upstream/out/ $ du -s tispl.bin_unsigned
796     tispl.bin_unsigned

After series:
~/work/ti/src/bootloaders-upstream/out/ $ du -s tispl.bin_unsigned
876     tispl.bin_unsigned

Per my understanding, this change increases the size of the a53 U-Boot
SPL, which is why we can no longer boot from eMMC.

Here is are other depending project refs:
- optee_os: 439c5ecbb68b ("core: arm: fix integer overflow in generic_timer_{handler,start}()")
- ti-linux-firmware: 0350c2edecab ("ti-dm: Update firmware for J722S device")
- trustef-firmware-a: 17bef2248d45 ("Merge "feat(fvp): delegate FFH RAS handling to SP" into integration")

Reverting just this commit makes it boot to eMMC for me again.

I also tried this downstream change[2] to increase the alloc space in
the SPL. That did not fix the booting problem.

To fix it, I had to remove:
CONFIG_SPL_ENV_SUPPORT=y
CONFIG_SPL_DFU=y

Which bring down the tispl to:
~/work/ti/src/bootloaders-upstream/out/ $ du -s tispl.bin_unsigned
820     tispl.bin_unsigned

Of course, removing both config options is not an acceptable solution since
it defeats the purpose of this patch.

Did you test booting from eMMC when developping this series, or did you
just tested booting from DFU ?

[1] https://lore.kernel.org/all/b587fcaebed8b61285a901b468e3ccbddf7d06f2.camel@collabora.com/
[2] https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=ti-u-boot-2023.04&id=28c1b1ec8ba89b7c7b2cd43483054a432552008f

>
> ---
>
> Changes in v4:
> - Move R5 dfu config to a config fragment rather then a full defconfig
> - Don't enable XHCI for the R5 SPL, unneeded
>
> Changes in v3:
> - Run savedefconfig to adjust to more recent u-boot
>
> Changes in v2:
> - Create a seperate defconfig for R5
>
>  configs/am62x_evm_a53_defconfig | 30 ++++++++++++++++++++++++++++++
>  configs/am62x_r5_usbdfu.config  | 28 ++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
>  create mode 100644 configs/am62x_r5_usbdfu.config
>
> diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
> index aa96c1b3125..f335eb11e63 100644
> --- a/configs/am62x_evm_a53_defconfig
> +++ b/configs/am62x_evm_a53_defconfig
> @@ -1,5 +1,6 @@
>  CONFIG_ARM=y
>  CONFIG_ARCH_K3=y
> +CONFIG_SYS_MALLOC_LEN=0x2000000
>  CONFIG_SYS_MALLOC_F_LEN=0x8000
>  CONFIG_SPL_LIBCOMMON_SUPPORT=y
>  CONFIG_SPL_LIBGENERIC_SUPPORT=y
> @@ -41,16 +42,23 @@ CONFIG_SPL_SYS_MALLOC_SIMPLE=y
>  CONFIG_SPL_STACK_R=y
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1400
> +CONFIG_SPL_ENV_SUPPORT=y
>  CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
>  CONFIG_SPL_DM_MAILBOX=y
>  CONFIG_SPL_DM_SPI_FLASH=y
>  CONFIG_SPL_POWER_DOMAIN=y
> +CONFIG_SPL_RAM_SUPPORT=y
> +CONFIG_SPL_RAM_DEVICE=y
>  # CONFIG_SPL_SPI_FLASH_TINY is not set
>  CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
>  CONFIG_SPL_SPI_LOAD=y
>  CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000
> +CONFIG_SPL_USB_GADGET=y
> +CONFIG_SPL_DFU=y
>  CONFIG_SPL_YMODEM_SUPPORT=y
> +CONFIG_CMD_DFU=y
>  CONFIG_CMD_MMC=y
> +CONFIG_CMD_USB=y
>  CONFIG_OF_CONTROL=y
>  CONFIG_SPL_OF_CONTROL=y
>  CONFIG_MULTI_DTB_FIT=y
> @@ -61,10 +69,17 @@ CONFIG_SPL_DM=y
>  CONFIG_SPL_DM_SEQ_ALIAS=y
>  CONFIG_REGMAP=y
>  CONFIG_SPL_REGMAP=y
> +CONFIG_SYSCON=y
> +CONFIG_SPL_SYSCON=y
>  CONFIG_SPL_OF_TRANSLATE=y
>  CONFIG_CLK=y
>  CONFIG_SPL_CLK=y
>  CONFIG_CLK_TI_SCI=y
> +CONFIG_DFU_MMC=y
> +CONFIG_DFU_RAM=y
> +CONFIG_DFU_SF=y
> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x5000
> +CONFIG_SYS_DFU_MAX_FILE_SIZE=0x800000
>  CONFIG_DMA_CHANNELS=y
>  CONFIG_TI_K3_NAVSS_UDMA=y
>  CONFIG_TI_SCI_PROTOCOL=y
> @@ -103,4 +118,19 @@ CONFIG_CADENCE_QSPI=y
>  CONFIG_SYSRESET=y
>  CONFIG_SPL_SYSRESET=y
>  CONFIG_SYSRESET_TI_SCI=y
> +CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
> +CONFIG_SPL_DM_USB_GADGET=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_XHCI_DWC3=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_SPL_USB_DWC3_GENERIC=y
> +CONFIG_SPL_USB_DWC3_AM62=y
> +CONFIG_USB_DWC3_AM62=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
> +CONFIG_USB_GADGET_VENDOR_NUM=0x0451
> +CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
> +CONFIG_USB_GADGET_DOWNLOAD=y
>  CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
> diff --git a/configs/am62x_r5_usbdfu.config b/configs/am62x_r5_usbdfu.config
> new file mode 100644
> index 00000000000..772bb2ab935
> --- /dev/null
> +++ b/configs/am62x_r5_usbdfu.config
> @@ -0,0 +1,28 @@
> +CONFIG_SPL_ENV_SUPPORT=y
> +CONFIG_SYSCON=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x5000
> +CONFIG_MISC=y
> +CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
> +CONFIG_SPL_DM_USB_GADGET=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_SPL_USB_DWC3_GENERIC=y
> +CONFIG_SPL_USB_DWC3_AM62=y
> +CONFIG_USB_GADGET=y
> +CONFIG_SPL_USB_GADGET=y
> +CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
> +CONFIG_USB_GADGET_VENDOR_NUM=0x0451
> +CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_SPL_DFU=y
> +# CONFIG_SPL_MMC is not set
> +# CONFIG_SPL_FS_FAT is not set
> +# CONFIG_SPL_LIBDISK_SUPPORT is not set
> +# CONFIG_SPL_SPI is not set
> +# CONFIG_SPL_SYS_MALLOC is not set
> +# CONFIG_CMD_GPT is not set
> +# CONFIG_CMD_MMC is not set
> +# CONFIG_CMD_FAT is not set
> +# CONFIG_MMC_SDHCI is not set
> -- 
> 2.43.0
