Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64C1D5A6FD
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 08:30:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 374F589140;
	Tue, 26 Nov 2024 09:30:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732609822;
	bh=mDtRic5yy2IyQlUoupriOX9cHgZ78WjXUMm29uPmSOg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zwRhQkT5QEskkfP9ja7dwonkwDsguwa0FXT7A1d5rBrJjw+HChtSy0Y0gUUPYbmYt
	 EzSQXA4mC6L4RMd+x2jas9sWWTOHHsL3fMAepojwNkOFi3MwNOxLLGxf4sQtFnBRtN
	 JPA9TrNtervzozmmfkJtXlebBiIKlC8itFshBz4KtK7kmy/eSGMliWFLoqIKmPOurO
	 R591ZZD1juEwNmYhN2IZaaw9pb7YrPPbXH05q6SByNHR+3sxh8PsN8uPU6UgPCoouI
	 k9vHId7CSzLrDfYOqXvNWTxl3vtbgUuAlfZ2Qxgx9LyM/ODJCGdcj12a5BcnX14nEH
	 l4YhtSJZCl0TQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 558DD89140; Tue, 26 Nov 2024 09:30:21 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5341088ECC
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 09:30:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4XyG3Y0wRBz9tCG;
 Tue, 26 Nov 2024 09:30:17 +0100 (CET)
Message-ID: <8e1d1e10-148c-4444-b651-5ca7896fa020@denx.de>
Date: Tue, 26 Nov 2024 09:30:15 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/7] arm: mvebu: x240: Switch to standard boot
To: Chris Packham <judge.packham@gmail.com>, u-boot@lists.denx.de
Cc: Alexander Dahl <ada@thorsis.com>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20241122003058.270163-1-judge.packham@gmail.com>
 <20241122003058.270163-3-judge.packham@gmail.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241122003058.270163-3-judge.packham@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XyG3Y0wRBz9tCG
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

On 22.11.24 01:30, Chris Packham wrote:
> Use standard boot instead of the distro boot scripts. Regenerate the
> board defconfig now that some options are selected automatically.
> 
> Signed-off-by: Chris Packham <judge.packham@gmail.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
> 
>   arch/arm/mach-mvebu/Kconfig | 1 +
>   configs/x240_defconfig      | 6 ------
>   include/configs/x240.h      | 9 ++-------
>   3 files changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> index b422bb09e023..adb816982f87 100644
> --- a/arch/arm/mach-mvebu/Kconfig
> +++ b/arch/arm/mach-mvebu/Kconfig
> @@ -224,6 +224,7 @@ config TARGET_X250
>   config TARGET_X240
>   	bool "Support Allied Telesis x240"
>   	select ALLEYCAT_5
> +	imply BOOTSTD_DEFAULTS
>   
>   config TARGET_DB_XC3_24G4XG
>   	bool "Support DB-XC3-24G4XG"
> diff --git a/configs/x240_defconfig b/configs/x240_defconfig
> index f930d28de2dd..4fca1096e740 100644
> --- a/configs/x240_defconfig
> +++ b/configs/x240_defconfig
> @@ -27,14 +27,9 @@ CONFIG_CMD_PCI=y
>   CONFIG_CMD_SPI=y
>   CONFIG_CMD_USB=y
>   # CONFIG_CMD_SETEXPR is not set
> -CONFIG_CMD_DHCP=y
> -CONFIG_CMD_PING=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_CMD_TIME=y
>   CONFIG_CMD_REGULATOR=y
> -CONFIG_CMD_EXT4=y
> -CONFIG_CMD_FAT=y
> -CONFIG_CMD_FS_GENERIC=y
>   CONFIG_CMD_UBI=y
>   CONFIG_ENV_IS_IN_SPI_FLASH=y
>   CONFIG_CLK=y
> @@ -74,7 +69,6 @@ CONFIG_DM_THERMAL=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
>   CONFIG_USB_EHCI_HCD=y
> -CONFIG_USB_STORAGE=y
>   CONFIG_USB_HOST_ETHER=y
>   CONFIG_USB_ETHER_ASIX=y
>   CONFIG_USB_ETHER_ASIX88179=y
> diff --git a/include/configs/x240.h b/include/configs/x240.h
> index bc66e4e3c8e6..05241f33d74f 100644
> --- a/include/configs/x240.h
> +++ b/include/configs/x240.h
> @@ -12,18 +12,13 @@
>   #define CFG_SYS_SDRAM_BASE   0x200000000
>   
>   /* Default Env vars */
> -
> -#define BOOT_TARGET_DEVICES(func) \
> -	func(USB, usb, 0) \
> -	func(DHCP, dhcp, na)
> -
> -#include <config_distro_bootcmd.h>
> +#define BOOT_TARGETS "usb dhcp"
>   
>   #define CFG_EXTRA_ENV_SETTINGS   \
> -	BOOTENV \
>   	"kernel_addr_r=0x202000000\0" \
>   	"fdt_addr_r=0x201000000\0"    \
>   	"ramdisk_addr_r=0x206000000\0"    \
> +	"boot_targets=" BOOT_TARGETS "\0" \
>   	"fdtfile=marvell/" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0"
>   
>   /*

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

