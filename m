Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C7CEC369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 13:32:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01AA482DB4;
	Wed, 16 Apr 2025 15:32:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744810349;
	bh=SXSnUQJxa944qLfeK/Gton7NpuF6VxhBmMfBNeF5JfU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ztelXbzgIo1EgrAYjr9BvQSEgVdmagEqQsEtyEM0t5jRzVJ/egZUBgrPdoF/wvcoG
	 MQKt8C2EEcBAWARn8W9z5KtmcF5IrIMFvzsQaEXvNPgA5o+4T2ZE3raiENJBS20xjd
	 3pRDUx6+AWuQab/xke9/u/3I/VHf4MGVZnDuxrHO/KNIN9DPY3aAR93M5NBLrVOcjF
	 Rq8prnX/oPczlhXnc+ctUL76nQItAAig6C3QKUdJJAwVCGxHIohCwEhvBt0TxnnJP2
	 hw4nAh7r0TGd/tE/tVnCRE4/s86MWEVakskL8VXMAXs07hroynS1PRy1XTW0nHkYG6
	 o92eHzHBwjIMQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60CCB82E9F; Wed, 16 Apr 2025 15:32:28 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24E9C82B5B
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 15:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4Zd2531YVyz9tPW;
 Wed, 16 Apr 2025 15:32:23 +0200 (CEST)
Message-ID: <ebae4ce2-b730-4794-85d0-afbca511773e@denx.de>
Date: Wed, 16 Apr 2025 15:32:22 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] configs: clearfog,helios4: disable sdhci sdma
To: Josua Mayer <josua@solid-run.com>, Tom Rini <trini@konsulko.com>,
 Dennis Gilmore <dgilmore@redhat.com>
Cc: u-boot@lists.denx.de
References: <20250208-a388-kerneladdr-v2-1-17c01313eba2@solid-run.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250208-a388-kerneladdr-v2-1-17c01313eba2@solid-run.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 08.02.25 13:22, Josua Mayer wrote:
> Testing has shown that loading large initramfs causes data corruption
> where the kernel image had been loaded to.
> Debian 12 installation using a 17M initramfs boots fine, but the final
> system with an initramfs of 27M obscurely fails to boot with bootz
> reporting "Bad magic!".
> Inspecting kernel_addr_r after this failed boot attempt does show
> garbage in place of the expected zimage header.
> 
> The problem seems to occur on armada 388 only when sdhci sdma is enabled
> in defconfig. Other armada boards such as turris omnia did not enable
> the option.
> 
> Remove sdhci sdma from defconfig for now as a workaround.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Applied to u-boot-marvell/master

Thanks,
Stefan

> ---
> Changes in v2:
> - changed *all* a388 clearfog_* defconfig files
> - Link to v1: https://lore.kernel.org/r/20250208-a388-kerneladdr-v1-1-1ed91f642c2d@solid-run.com
> ---
>   configs/clearfog_defconfig      | 1 -
>   configs/clearfog_sata_defconfig | 1 -
>   configs/clearfog_spi_defconfig  | 1 -
>   configs/helios4_defconfig       | 1 -
>   4 files changed, 4 deletions(-)
> 
> diff --git a/configs/clearfog_defconfig b/configs/clearfog_defconfig
> index 6f6597c5331f4aadf827b40a8f2864722585fda9..a139d7cb463167f59931fd4a151a309c29ba3a44 100644
> --- a/configs/clearfog_defconfig
> +++ b/configs/clearfog_defconfig
> @@ -60,7 +60,6 @@ CONFIG_SYS_I2C_MVTWSI=y
>   CONFIG_I2C_EEPROM=y
>   CONFIG_SPL_I2C_EEPROM=y
>   CONFIG_MMC_SDHCI=y
> -CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_MV=y
>   CONFIG_SPI_FLASH_WINBOND=y
>   CONFIG_SPI_FLASH_MTD=y
> diff --git a/configs/clearfog_sata_defconfig b/configs/clearfog_sata_defconfig
> index 491a27321f9c52af3bd28da546b7065b0aaf38e0..b927532a8c7e99632aa7c45cb809115be9524e04 100644
> --- a/configs/clearfog_sata_defconfig
> +++ b/configs/clearfog_sata_defconfig
> @@ -61,7 +61,6 @@ CONFIG_I2C_EEPROM=y
>   CONFIG_SPL_I2C_EEPROM=y
>   CONFIG_SUPPORT_EMMC_BOOT=y
>   CONFIG_MMC_SDHCI=y
> -CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_MV=y
>   CONFIG_SPI_FLASH_WINBOND=y
>   CONFIG_SPI_FLASH_MTD=y
> diff --git a/configs/clearfog_spi_defconfig b/configs/clearfog_spi_defconfig
> index d3de1657c09ac8afb7655094d88b649f711e36b7..85be40db48536ca153d0dae8eda69532745b5526 100644
> --- a/configs/clearfog_spi_defconfig
> +++ b/configs/clearfog_spi_defconfig
> @@ -61,7 +61,6 @@ CONFIG_I2C_EEPROM=y
>   CONFIG_SPL_I2C_EEPROM=y
>   CONFIG_SUPPORT_EMMC_BOOT=y
>   CONFIG_MMC_SDHCI=y
> -CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_MV=y
>   CONFIG_SPI_FLASH_WINBOND=y
>   CONFIG_SPI_FLASH_MTD=y
> diff --git a/configs/helios4_defconfig b/configs/helios4_defconfig
> index 2778cb7dc8680191155582da14a21b6a521fdef1..baf7c9396362fd9f6a8e527e27e8ad75a1fe643e 100644
> --- a/configs/helios4_defconfig
> +++ b/configs/helios4_defconfig
> @@ -60,7 +60,6 @@ CONFIG_SYS_I2C_MVTWSI=y
>   CONFIG_I2C_EEPROM=y
>   CONFIG_SPL_I2C_EEPROM=y
>   CONFIG_MMC_SDHCI=y
> -CONFIG_MMC_SDHCI_SDMA=y
>   CONFIG_MMC_SDHCI_MV=y
>   CONFIG_SPI_FLASH_WINBOND=y
>   CONFIG_SPI_FLASH_MTD=y
> 
> ---
> base-commit: ac3dcb0c2710c4917d93d6d2eb34dbfb00516bc2
> change-id: 20250207-a388-kerneladdr-23438bb34215
> 
> Best regards,

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

