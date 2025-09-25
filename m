Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5C3CAC5B1
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 14:09:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3528E80107;
	Thu, 25 Sep 2025 16:09:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="m+G48tZv";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="F5HVhilv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E74BB836F0; Thu, 25 Sep 2025 10:25:31 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E38E836B4
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 10:25:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cXRc91RyGz9tJx;
 Thu, 25 Sep 2025 10:25:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758788729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lyru5m3KUcAH0XxoJh8JTiMCNPEmxO4uzw2h21NSt6s=;
 b=m+G48tZvg2W4Xh0QhMygeqW6GxLqBlu2YUnGNeyToPWM0EGIsX9ZNCRnh/TswSQa2yrfzm
 sv7QchO5Y1bwwtSDtzO6zqIkSeimNZkvmcMYcRhdqESyGWcSHihwyno6PorLmL5OXj2PhI
 +wn65Tu3S/0wvTKd3bXxzHaLVBEZTmFCi6lhGTeMb/H0FLxvx2nuWviTUVD7F8nq0RBE+9
 h4mgJtLNkbhei/hrTCIHvpGUl9WqCkj1+WWlh7Ae5/d7IT2Cw8C2Rvxi4aZ58InUBQNY1N
 gjW9sYh6ss+bK5XBmOIEPH0K9ck/ZZlbNx8rTdl3nuMXC0Y0v0wHChC3dX9c8Q==
Message-ID: <7ec0eba7-ab95-4269-9b5d-256c1eef50a0@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758788726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lyru5m3KUcAH0XxoJh8JTiMCNPEmxO4uzw2h21NSt6s=;
 b=F5HVhilvFEDCKeSEcFpVfrn/WcpFcFRMotTJD82Xclo99V+vG3gyKs91ZMYR94rgXRykUG
 LwOTJ6a7cmKDv2QpGRkXkaoQ+BUtGZIUJ6K7QG3R3xtiWhFU8nZ7iixacoigbRq79bbhyV
 /0cIyFcuCtqPjjJcHslxPYCe1OsZOQ8BUQhqN2rxnhj9JVR+k0EKCju3twkr/wSfMkMPzr
 VmTtW4f40V+ilOfQllQI3xyshwTcZYDzgkLL1K3VEZeP+gYwn46LZePj2utpNXUvcZ2OO2
 DKY7QsZFu8JJvCc56FjezSZGSdfFM6zXxquObvppLgnepamBDGthRdyUUhChEg==
Date: Thu, 25 Sep 2025 10:25:20 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v7 2/5] bootstd: select BLK rather than depending on it
To: Simon Glass <sjg@u-boot.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>,
 Ezra Buehler <ezra.buehler@husqvarnagroup.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Peter Robinson <pbrobinson@gmail.com>,
 Thomas Chou <thomas@wytron.com.tw>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20250925002308.2825164-1-sjg@u-boot.org>
 <20250925002308.2825164-3-sjg@u-boot.org>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20250925002308.2825164-3-sjg@u-boot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 1dreiku87bkarnkxg3m75rocpxodoj63
X-MBO-RS-ID: 592dd03a7945eaed56b
X-Mailman-Approved-At: Thu, 25 Sep 2025 16:09:51 +0200
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

Hi Simon,

glad to "hear" something from you again. ;)

...

On 9/25/25 02:23, Simon Glass wrote:
> From: Simon Glass <sjg@chromium.org>
> 
> With recent changes to how BLK works, we must use 'select' to enable the
> BLK feature, which is currently required by BOOTSTD.
> 
> This fixes the following error:
> 
>      GEN     Makefile
>    scripts/kconfig/conf  --syncconfig Kconfig
>    boot/Kconfig:496:error: recursive dependency detected!
>    boot/Kconfig:496:	symbol BOOTSTD_DEFAULTS depends on BOOTSTD
>    boot/Kconfig:441:	symbol BOOTSTD default is visible depending on BLK
>    drivers/block/Kconfig:1:	symbol BLK is selected by USB
>    drivers/usb/Kconfig:1:	symbol USB is selected by BOOTSTD_DEFAULTS
> 
> Disable BOOTSTD for the boards which don't have enough space or some
> other problem:
> 
>    zynq_cse_nand
>    zynq_cse_nor
>    zynq_cse_qspi
>    gardena-smart-gateway-mt7688
>    10m50
>    3c120
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v7:
> - Put this patch earlier in the series, so it is bisectable
> - Disable some boards which lack space
> 
> Changes in v6:
> - Add new patch to select BLK rather than depending on it
> 
>   boot/Kconfig                                   | 3 ++-
>   configs/10m50_defconfig                        | 1 +
>   configs/3c120_defconfig                        | 1 +
>   configs/gardena-smart-gateway-mt7688_defconfig | 1 +

For this platform:

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

>   configs/zynq_cse_nand_defconfig                | 1 +
>   configs/zynq_cse_nor_defconfig                 | 1 +
>   configs/zynq_cse_qspi_defconfig                | 1 +
>   7 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/boot/Kconfig b/boot/Kconfig
> index d1e608f2595..2cc33cc874d 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -438,8 +438,9 @@ config BOOT_DEFAULTS
>   
>   menuconfig BOOTSTD
>   	bool "Standard boot"
> -	default y if BLK
> +	default y
>   	depends on DM && OF_CONTROL
> +	select BLK
>   	help
>   	  U-Boot supports a standard way of locating something to boot,
>   	  typically an Operating System such as Linux, provided by a distro such
> diff --git a/configs/10m50_defconfig b/configs/10m50_defconfig
> index 8180ed55e3e..0d4b1dc8d94 100644
> --- a/configs/10m50_defconfig
> +++ b/configs/10m50_defconfig
> @@ -13,6 +13,7 @@ CONFIG_SYS_LOAD_ADDR=0xcc000000
>   CONFIG_ENV_ADDR=0xF4080000
>   CONFIG_SYS_MONITOR_BASE=0xCFF80000
>   CONFIG_FIT=y
> +# CONFIG_BOOTSTD is not set
>   # CONFIG_AUTOBOOT is not set
>   CONFIG_SYS_CBSIZE=256
>   CONFIG_SYS_PBSIZE=276
> diff --git a/configs/3c120_defconfig b/configs/3c120_defconfig
> index 0a6eae4b5dd..c444a12f485 100644
> --- a/configs/3c120_defconfig
> +++ b/configs/3c120_defconfig
> @@ -13,6 +13,7 @@ CONFIG_SYS_LOAD_ADDR=0xd4000000
>   CONFIG_ENV_ADDR=0xE2880000
>   CONFIG_SYS_MONITOR_BASE=0xD7F80000
>   CONFIG_FIT=y
> +# CONFIG_BOOTSTD is not set
>   # CONFIG_AUTOBOOT is not set
>   CONFIG_SYS_CBSIZE=256
>   CONFIG_SYS_PBSIZE=276
> diff --git a/configs/gardena-smart-gateway-mt7688_defconfig b/configs/gardena-smart-gateway-mt7688_defconfig
> index 3c2bcc6a3c4..ea0094394eb 100644
> --- a/configs/gardena-smart-gateway-mt7688_defconfig
> +++ b/configs/gardena-smart-gateway-mt7688_defconfig
> @@ -31,6 +31,7 @@ CONFIG_HAS_BOARD_SIZE_LIMIT=y
>   CONFIG_BOARD_SIZE_LIMIT=655360
>   CONFIG_FIT=y
>   CONFIG_FIT_SIGNATURE=y
> +# CONFIG_BOOTSTD is not set
>   CONFIG_LEGACY_IMAGE_FORMAT=y
>   CONFIG_AUTOBOOT_KEYED=y
>   CONFIG_AUTOBOOT_STOP_STR="x"
> diff --git a/configs/zynq_cse_nand_defconfig b/configs/zynq_cse_nand_defconfig
> index 4272b7320b6..9b85b23a9d5 100644
> --- a/configs/zynq_cse_nand_defconfig
> +++ b/configs/zynq_cse_nand_defconfig
> @@ -23,6 +23,7 @@ CONFIG_SPL=y
>   CONFIG_REMAKE_ELF=y
>   CONFIG_SYS_CUSTOM_LDSCRIPT=y
>   CONFIG_SYS_LDSCRIPT="arch/arm/mach-zynq/u-boot.lds"
> +# CONFIG_BOOTSTD is not set
>   # CONFIG_AUTOBOOT is not set
>   CONFIG_USE_PREBOOT=y
>   CONFIG_SYS_CBSIZE=1024
> diff --git a/configs/zynq_cse_nor_defconfig b/configs/zynq_cse_nor_defconfig
> index 74c4595eb43..fab02bfdb0a 100644
> --- a/configs/zynq_cse_nor_defconfig
> +++ b/configs/zynq_cse_nor_defconfig
> @@ -23,6 +23,7 @@ CONFIG_SPL=y
>   CONFIG_REMAKE_ELF=y
>   CONFIG_SYS_CUSTOM_LDSCRIPT=y
>   CONFIG_SYS_LDSCRIPT="arch/arm/mach-zynq/u-boot.lds"
> +# CONFIG_BOOTSTD is not set
>   # CONFIG_AUTOBOOT is not set
>   CONFIG_USE_PREBOOT=y
>   CONFIG_SYS_CBSIZE=1024
> diff --git a/configs/zynq_cse_qspi_defconfig b/configs/zynq_cse_qspi_defconfig
> index 145b7fd33bb..31ff00c689c 100644
> --- a/configs/zynq_cse_qspi_defconfig
> +++ b/configs/zynq_cse_qspi_defconfig
> @@ -29,6 +29,7 @@ CONFIG_DEBUG_UART=y
>   CONFIG_REMAKE_ELF=y
>   CONFIG_SYS_CUSTOM_LDSCRIPT=y
>   CONFIG_SYS_LDSCRIPT="arch/arm/mach-zynq/u-boot.lds"
> +# CONFIG_BOOTSTD is not set
>   # CONFIG_AUTOBOOT is not set
>   # CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
>   CONFIG_USE_PREBOOT=y

