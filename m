Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8FDC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 06:30:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E31E38331D;
	Thu, 17 Jul 2025 08:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JSy7fKvv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90ECF83330; Thu, 17 Jul 2025 08:30:29 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51C6C832E6
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 08:30:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0AACE601D5;
 Thu, 17 Jul 2025 06:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B5FC4CEE3;
 Thu, 17 Jul 2025 06:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1752733825;
 bh=dQ+WLVT8YXXmNQ7Hh/PKs16xBDvpRkXQd5RyndcRlxE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=JSy7fKvv/oID3LTsks5LSs9rZMfgdVMPdFCIvr41vtVTCo1qk0EtuGqEbt+v1hgec
 E05mh++l6xyUkDZR2YBumLwuCw1f3DHAXhZG7/0vZEJLbhzoF2SXXAPcMTrIVuDYGU
 8GPYT93lqzU9cvrGkJjX9kUbdMCnxOgONQAC7wRVI1U5StLE8M7RHxwoHlMg1M3Fav
 m4Ph2eC/nmZS3ZG5iFxLkp6s0/dSvrO93bFSiwoI75gjpFMv8T7CgtWUef9QxDv25w
 S4T/xQCDB6HRikTm4XvVTf5/WzyjrOuzKzOQWvrabMGFIjBrceMob9xPPj8KEoh3cs
 F5XBcBZCgsSQg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>, u-boot@lists.denx.de
Cc: mkorpershoek@kernel.org, trini@konsulko.com,
 jerome.forissier@linaro.org, patrice.chotard@foss.st.com,
 ilias.apalodimas@linaro.org, andre.przywara@arm.com,
 casey.connolly@linaro.org, mwalle@kernel.org, Ariel D'Alessandro
 <ariel.dalessandro@collabora.com>
Subject: Re: [PATCH v2] drivers: fastboot: Add support for SPI flash memory
In-Reply-To: <20250715191109.329588-1-ariel.dalessandro@collabora.com>
References: <20250715191109.329588-1-ariel.dalessandro@collabora.com>
Date: Thu, 17 Jul 2025 08:30:23 +0200
Message-ID: <87y0sn2utc.fsf@kernel.org>
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

Hi Ariel,

Thank you for the patch.

On Tue, Jul 15, 2025 at 16:11, Ariel D'Alessandro <ariel.dalessandro@collabora.com> wrote:

> Fastboot currently supports MMC and NAND flash devices. Similarly,
> extend the support to SPI flash memories.
>
> Note that in this initial implementation, partitions on the device are
> not supported yet, but raw partitions can be set in u-boot environment.

nitpick: u-boot -> U-Boot

>
> To define a raw partition descriptor, add an environment variable
> similar to the MMC case:
>
> ```
> fastboot_raw_partition_<raw partition name>=<offset> <size>
> ```
>
> for example:
>
> ```
> fastboot_raw_partition_boot=0x0 0x1000000
> ```
>
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> ---
>  drivers/fastboot/Kconfig        |   6 +-
>  drivers/fastboot/Makefile       |   1 +
>  drivers/fastboot/fb_command.c   |   8 +
>  drivers/fastboot/fb_getvar.c    |   6 +
>  drivers/fastboot/fb_spi_flash.c | 249 ++++++++++++++++++++++++++++++++
>  include/fb_spi_flash.h          |  40 +++++

Can we also include a doc change to doc/android/fastboot.rst ?
The current doc mentions:
"Support for both eMMC and NAND devices is included."

We should add SPI flash to that sentence.

Maybe also mention in the "Raw partition descriptors" that this is
supported for SPI flash as well.

>  6 files changed, 309 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/fastboot/fb_spi_flash.c
>  create mode 100644 include/fb_spi_flash.h
>

[...]

> +
> +/**
> + * fastboot_spi_flash_get_part_info() - Lookup SPI flash partition by name
> + *
> + * @part_name: Named device to lookup
> + * @part_info: Pointer to returned struct disk_partition
> + * @response: Pointer to fastboot response buffer

Can we add a Return: line to document the return code?

> + */
> +int fastboot_spi_flash_get_part_info(const char *part_name,
> +				     struct disk_partition *part_info,
> +				     char *response);
> +
> +/**
> + * fastboot_spi_flash_write() - Write image to SPI flash for fastboot
> + *
> + * @cmd: Named device to write image to
> + * @download_buffer: Pointer to image data
> + * @download_bytes: Size of image data
> + * @response: Pointer to fastboot response buffer
> + */
> +void fastboot_spi_flash_write(const char *cmd, void *download_buffer,
> +			      u32 download_bytes, char *response);
> +
> +/**
> + * fastboot_spi_flash_erase() - Erase SPI flash for fastboot
> + *
> + * @cmd: Named device to erase
> + * @response: Pointer to fastboot response buffer
> + */
> +void fastboot_spi_flash_erase(const char *cmd, char *response);
> +#endif

> 2.50.0
