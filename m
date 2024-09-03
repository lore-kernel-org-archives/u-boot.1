Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC20BCD342F
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 06:57:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52D9988AD3;
	Tue,  3 Sep 2024 08:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725346651;
	bh=gfqqL4dUaAPUXPM3Sk82yDyrwn7os78IC3Y7az5fUFc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jLDYg31gJz1g5M8TfzqE6qxNqd+2yhVhKYWk49HC+mEyOU4JSmV0oldl668slnFcB
	 PquoFStn+CZMWOAc/3lsJun0QotbvK1Qjf7gMDLkQ4gvs/yfv7fLMWtX3dEK+prlJu
	 4sNuVbo/L8tnA+655cQlzQf0rXH8xZGcBIAvc1V1V3o7ShK5eIsHiWWHLPWPJyvueQ
	 iuo/Y6Pt+pz86SrxW3ihwe6FmUgCJ+QcRIzbXum/HOUezIekXaY2rwYn+wuPSPdiqn
	 MqfUHe2NeICs5YzqZJeuc0lBKEZjLutESOMt2M7JlR3UAqtVQh2RFctmeOOV7z0slO
	 o9CWRv9LsiItg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0A6188ACB; Tue,  3 Sep 2024 08:57:29 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E60358892C
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 08:57:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4Wybz965TSz9sSq;
 Tue,  3 Sep 2024 08:57:25 +0200 (CEST)
Message-ID: <acfd0636-8132-4fa7-91e6-af78a6fdbeec@denx.de>
Date: Tue, 3 Sep 2024 08:57:24 +0200
MIME-Version: 1.0
Subject: Re: [PATCH u-boot-marvell 2/3] arm: mvebu: turris_omnia: Use the
 i2c_eeprom misc driver for EEPROM reading in U-Boot proper
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: u-boot@lists.denx.de
References: <20240829080849.20276-1-kabel@kernel.org>
 <20240829080849.20276-3-kabel@kernel.org>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240829080849.20276-3-kabel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Wybz965TSz9sSq
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

On 8/29/24 10:08, Marek Behún wrote:
> Use the i2c_eeprom miscellaneous driver for reading Turris Omnia EEPROM
> in U-Boot proper. Keep using dm_i2c_read() in SPL build, since adding
> the i2c_eeprom driver to SPL build increases the image by 1.5 KiB.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>
> ---
>   arch/arm/mach-mvebu/Kconfig              | 1 +
>   board/CZ.NIC/turris_omnia/turris_omnia.c | 9 +++++++--
>   configs/turris_omnia_defconfig           | 1 -
>   3 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> index 4a8328760eb..c1a1a333e6c 100644
> --- a/arch/arm/mach-mvebu/Kconfig
> +++ b/arch/arm/mach-mvebu/Kconfig
> @@ -149,6 +149,7 @@ config TARGET_TURRIS_OMNIA
>   	select SPL_SYS_MALLOC_SIMPLE
>   	select SYS_I2C_MVTWSI
>   	select ATSHA204A
> +	select I2C_EEPROM
>   	select ARMADA_38X_SUPPORT_OLD_DDR3_TRAINING
>   
>   config TARGET_TURRIS_MOX
> diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/turris_omnia/turris_omnia.c
> index 392df53a6d8..46f20f05c05 100644
> --- a/board/CZ.NIC/turris_omnia/turris_omnia.c
> +++ b/board/CZ.NIC/turris_omnia/turris_omnia.c
> @@ -23,6 +23,7 @@
>   #include <dt-bindings/gpio/gpio.h>
>   #include <fdt_support.h>
>   #include <hexdump.h>
> +#include <i2c_eeprom.h>
>   #include <time.h>
>   #include <turris-omnia-mcu-interface.h>
>   #include <linux/bitops.h>
> @@ -473,9 +474,13 @@ static bool omnia_read_eeprom(struct omnia_eeprom *oep)
>   	if (!eeprom)
>   		return false;
>   
> -	ret = dm_i2c_read(eeprom, 0, (void *)oep, sizeof(*oep));
> +	if (IS_ENABLED(CONFIG_SPL_BUILD))
> +		ret = dm_i2c_read(eeprom, 0, (void *)oep, sizeof(*oep));
> +	else
> +		ret = i2c_eeprom_read(eeprom, 0, (void *)oep, sizeof(*oep));

So whats the advantage using i2c_eeprom_read() here in U-Boot proper?
The only thing that stands out to me is that the code get more complex
because of the SPL/non-SPL distinction.

Thanks,
Stefan

> +
>   	if (ret) {
> -		printf("dm_i2c_read failed: %i, cannot read EEPROM\n", ret);
> +		printf("cannot read EEPROM: %d\n", ret);
>   		return false;
>   	}
>   
> diff --git a/configs/turris_omnia_defconfig b/configs/turris_omnia_defconfig
> index c8756a3a788..93f0bc53f9e 100644
> --- a/configs/turris_omnia_defconfig
> +++ b/configs/turris_omnia_defconfig
> @@ -92,7 +92,6 @@ CONFIG_SPL_OF_TRANSLATE=y
>   CONFIG_AHCI_PCI=y
>   CONFIG_AHCI_MVEBU=y
>   CONFIG_DM_PCA953X=y
> -CONFIG_I2C_EEPROM=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_MV=y
>   CONFIG_DM_MTD=y

