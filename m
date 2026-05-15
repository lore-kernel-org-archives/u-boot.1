Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC04CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 11:31:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 185498341A;
	Fri, 15 May 2026 13:31:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="GDSAym7d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C91783EF9; Fri, 15 May 2026 13:31:08 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72D2B80086
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 13:31:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso96636885e9.3
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 04:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778844665; x=1779449465; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=j4Qme2+bqgQmSSSyY1jvf8HJ73d8MF2lfdcGLevZffU=;
 b=GDSAym7d0dMxrASJnYZE4qr6yhbUcGwm0ATPYGO8x20KT3QuRScEx5sXTDyvTI+qrQ
 ysfeTNLxlrTU9/jXcuIHjrTmlfgLz7c2k5eCZCz6Pyk/3Ryouzpcpguc2uanbIjkmtQw
 AFVu/5QboELetLL9WOVIr/VwFIiWxplqmoOD6KGXv4o6XPE+/A2Cy//Ct64mvaPxNIT0
 UxV3C4l0vot6X4ymdYl8I7E/jvyPdJhi9+a/fxtfZxnLo+FMiIu/FuD5VJnYaM+5BjK9
 YGSZ2x+d/tnJnwhs+FcvmNWZNl19e7dqJ3Y+D0bvmIpgzN3PMt4Vge2Pix7ncDQHOkJx
 EPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778844665; x=1779449465;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j4Qme2+bqgQmSSSyY1jvf8HJ73d8MF2lfdcGLevZffU=;
 b=eXgvZwaW9sPzv/lsRd2mDeHL1+UxAedXaaQfNipAVtNtmmJA9XdaoxXzePynthktPw
 gkOF02KRm1prEuEVI8U71E18FYX/BZoU5Fju9eUB5WFolUflrpm+UbpTFib+R4ECZdol
 vThybwBvGkyTLqIzkm7cFe1fYbu2w4XHPYH8G/to2wSHMyJF7jCc0Ks18x2IWPkJipdn
 qofxorgrdMQ6i12WWeS4uUUEU/Q3xvBznYSfKOjNypbptTzmWZKAcrYuSv6Re6NTyM93
 vudaMSk1ZgyiS4V0Qhy623dmN9ocQfE8DH69LNyOsQiXFzmWYZTfryyI9sJ+KocdnL41
 9PFw==
X-Forwarded-Encrypted: i=1;
 AFNElJ905VYMK0WEqXSRtGe/B5zpkF6jMxX8igpn0hBqFFCXDNTQW6/rr/p3yTFtdoxm85w3CeSUC/U=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/yqjBmdntvaACCbA14QA2JdBNb8yoPyTbKmuWv+QelomuNULy
 aGWJYrVGSgqZkllGZo4PgpsMe/BRF3SZgxLpazE1J+1CeQWqom6C1DR0CkRkabRjMo0=
X-Gm-Gg: Acq92OFnHy2d8Po6KcoKB81d2twGlRZoszq40cfxsNo4AuDGTe5hyCksUXnTniD29IX
 EliqSasNl3bPJ5lzBsXgWgeuUURClw2DV9gZ+F4Wu38GvHUmQ4eCqbicDurST/kFU7H8pGiU/VE
 hAWS/bT3bMUzZUZAaSMPh9xX+18Og1y1iz18gk1OCDArbjj17ke7P2FVivL3WTLzwypykqr4G3C
 MnByY9puO96u+zZfw9ACMdAa/QfhiU0vMgXGp5rAGqf+jjaHyQYstUy3sdShy/Ic4I+W5el1vnn
 1VA+cXQu3Zf6U78XFW4ZfadYn46DfTQdsXhFjHiyzji1fAyAQv++zS5sHgOY1+Cv6J2Nsil1Np1
 GPvqaKJ1jFgw3N0321pujzbi4LbWzHNNNahygwK1u5+RtQz8wG0ftpOcwVk2gHatOkSnQxpQthL
 0iaNSH2QyzWvzCmgWTVEy7p5rHIi5aUQ0UcMV7z3gLaqlhUJ5L3XIDpSaaBTeNGIKaUm5j1PZq8
 cF5rU6eRhkKRiNoS6ta
X-Received: by 2002:a05:600c:1389:b0:48f:de5a:4c1 with SMTP id
 5b1f17b1804b1-48fe60e4dd4mr48370525e9.5.1778844664584; 
 Fri, 15 May 2026 04:31:04 -0700 (PDT)
Received: from [192.168.2.177] (59.85-85-174.dynamic.clientes.euskaltel.es.
 [85.85.174.59]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5cab882sm59670085e9.13.2026.05.15.04.31.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 04:31:04 -0700 (PDT)
Message-ID: <e369ec39-56ff-499f-9de8-f905373c7f89@suse.com>
Date: Fri, 15 May 2026 13:31:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/14] configs: add rpi_4_wolftpm_defconfig
To: Aidan Garske <aidan@wolfssl.com>, u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, David Garske <david@wolfssl.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <cover.1778619453.git.aidan@wolfssl.com>
 <20260513002625.76915-14-aidan@wolfssl.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20260513002625.76915-14-aidan@wolfssl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 13/05/2026 02:26, Aidan Garske wrote:
> From: Aidan <aidan@wolfssl.com>
> 
> Add a new defconfig variant for Raspberry Pi 4 that enables the
> wolfTPM stack and the hardware SPI driver out of the box, so users
> with an Infineon SLB9670 / SLB9672 TPM HAT can build a working
> U-Boot in a single 'make rpi_4_wolftpm_defconfig && make' step.
> 
> This is a separate defconfig rather than a modification to
> rpi_4_defconfig because the average RPi 4 user does not have a
> TPM attached and should not pay for SPI + TPM + wolfTPM code size
> by default - that was the concern raised against v3's modification
> of rpi_4_defconfig.
> 
> Compared to rpi_4_defconfig this enables:
>   - CONFIG_SPI / CONFIG_DM_SPI / CONFIG_BCM2835_SPI / CONFIG_CMD_SPI
>     The hardware SPI controller driver added earlier in this series,
>     plus the spi command for diagnostics.
>   - CONFIG_TPM / CONFIG_TPM_V2 / CONFIG_CMD_TPM
>     The core TPM 2.0 stack and 'tpm2' command.
>   - CONFIG_TPM_WOLF / CONFIG_CMD_WOLFTPM / CONFIG_WOLFTPM_SLB9672
>     wolfTPM as the active TPM backend, with SLB9672 firmware-update
>     support enabled.  CONFIG_WOLFTPM_LINUX_DEV is left off so
>     wolfTPM uses its native SPI HAL (the Linux-dev path is the
>     QEMU+swtpm path, not the bare-metal RPi path).
> 
> No debug / unit-test config (LOG, LOGLEVEL, UNIT_TEST,
> CONSOLE_RECORD, HEXDUMP) is enabled - those belong in a developer's
> local .config, not in a defconfig shipped in tree.
> 
> Signed-off-by: Aidan Garske <aidan@wolfssl.com>

Peter what is your view on that. Shall we add config options for specific hats?

I'm inclined to do so, but I wonder if we can have some kind of config overlay 
instead of a fresh new config. (I'm not aware that U-Boot allows for something 
like this right now).

Regards,
Matthias

> ---
>   configs/rpi_4_wolftpm_defconfig | 81 +++++++++++++++++++++++++++++++++
>   1 file changed, 81 insertions(+)
>   create mode 100644 configs/rpi_4_wolftpm_defconfig
> 
> diff --git a/configs/rpi_4_wolftpm_defconfig b/configs/rpi_4_wolftpm_defconfig
> new file mode 100644
> index 00000000000..4301d2a3e93
> --- /dev/null
> +++ b/configs/rpi_4_wolftpm_defconfig
> @@ -0,0 +1,81 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_BCM283X=y
> +CONFIG_TEXT_BASE=0x00080000
> +CONFIG_TARGET_RPI_4=y
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x7fffe30
> +CONFIG_ENV_SIZE=0x4000
> +CONFIG_DEFAULT_DEVICE_TREE="bcm2711-rpi-4-b"
> +CONFIG_OF_LIBFDT_OVERLAY=y
> +CONFIG_DM_RESET=y
> +CONFIG_SYS_LOAD_ADDR=0x1000000
> +CONFIG_PCI=y
> +CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
> +CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
> +CONFIG_BOOTSTD_DEFAULTS=y
> +CONFIG_OF_BOARD_SETUP=y
> +CONFIG_FDT_SIMPLEFB=y
> +CONFIG_USE_PREBOOT=y
> +CONFIG_PREBOOT="pci enum; usb start;"
> +CONFIG_SYS_PBSIZE=1049
> +# CONFIG_DISPLAY_CPUINFO is not set
> +# CONFIG_DISPLAY_BOARDINFO is not set
> +CONFIG_MISC_INIT_R=y
> +CONFIG_SYS_PROMPT="U-Boot> "
> +CONFIG_CMD_NVEDIT_EFI=y
> +CONFIG_CMD_DFU=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_SPI=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_EFIDEBUG=y
> +CONFIG_CMD_TPM=y
> +CONFIG_CMD_FS_UUID=y
> +CONFIG_CMD_WOLFTPM=y
> +CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
> +CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> +CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
> +CONFIG_TFTP_TSIZE=y
> +CONFIG_DM_DMA=y
> +CONFIG_DFU_MMC=y
> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
> +CONFIG_SYS_DFU_MAX_FILE_SIZE=0x200000
> +CONFIG_BCM2835_GPIO=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_BCM2835=y
> +CONFIG_BCMGENET=y
> +CONFIG_PCI_BRCMSTB=y
> +CONFIG_DM_RNG=y
> +CONFIG_PINCTRL=y
> +# CONFIG_PINCTRL_GENERIC is not set
> +CONFIG_RNG_IPROC200=y
> +# CONFIG_REQUIRE_SERIAL_CONSOLE is not set
> +CONFIG_SPI=y
> +CONFIG_DM_SPI=y
> +CONFIG_BCM2835_SPI=y
> +CONFIG_SYSINFO=y
> +CONFIG_SYSINFO_SMBIOS=y
> +# CONFIG_WOLFTPM_LINUX_DEV is not set
> +CONFIG_WOLFTPM_SLB9672=y
> +CONFIG_USB=y
> +CONFIG_DM_USB_GADGET=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_XHCI_PCI=y
> +CONFIG_USB_KEYBOARD=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_MANUFACTURER="FSL"
> +CONFIG_USB_GADGET_VENDOR_NUM=0x0525
> +CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
> +CONFIG_USB_GADGET_DWC2_OTG=y
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_VIDEO=y
> +# CONFIG_VIDEO_BPP8 is not set
> +# CONFIG_VIDEO_BPP16 is not set
> +CONFIG_SYS_WHITE_ON_BLACK=y
> +CONFIG_VIDEO_BCM2835=y
> +CONFIG_CONSOLE_SCROLL_LINES=10
> +CONFIG_PHYS_TO_BUS=y
> +CONFIG_TPM=y
> +# CONFIG_HEXDUMP is not set

