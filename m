Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE91C369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 13:31:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 440EE82B5B;
	Wed, 16 Apr 2025 15:31:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744810290;
	bh=UOX56x+bgCK/uiJPk80toqJYTrZuQURY7uVjwrh1VH8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IwJgEanc2D7Cerbnx3EfJeYReRKA6r/SFC6BA6TM1pDLqYA7+yyuE9I/YLmdTVRHy
	 DPUVZ1jhOerInnj8gINFpM0PutiMlAMMFkhx88p7hptm/J8yczIQorNQTdE9LeO5gN
	 7ZMkS4/t5pPNBCtykYx4+0bG5osdEMHXip0pf3t6X6tlt/8DfvFV5rtX6uJt0yF1PE
	 2mtwoOviESIaqrdbonCuBJjYfIm5yksjVbDON2OkZ2AYtQscFHvKA43V/b9bnn3NbS
	 YIX2anw7cdOikHgHyZADTtZzhwFoOVWCo27B1pUhyGH7oZjXgFAHJrIBJQc8ZKynfO
	 v/oDjCMKzu1uQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C47E82CE7; Wed, 16 Apr 2025 15:31:29 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91D8C812BC
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 15:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4Zd23x1c2Cz9sdQ;
 Wed, 16 Apr 2025 15:31:25 +0200 (CEST)
Message-ID: <c02712fc-5ad2-4459-ab56-fc4d2832c9a6@denx.de>
Date: Wed, 16 Apr 2025 15:31:24 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] ARM: mvebu: Correct SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
 usage
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Chris Packham <judge.packham@gmail.com>
References: <20250315012905.399405-1-trini@konsulko.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250315012905.399405-1-trini@konsulko.com>
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

On 15.03.25 02:29, Tom Rini wrote:
> As the code is today, we get a warning about "select" statements on
> "choice" options not doing anything. However, it also works as intended
> because SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is the default option
> within that choice statement. To guard against future regressions, make
> the choice statement in common/spl/Kconfig have an explicit default if
> MVEBU_SPL_BOOT_DEVICE_MMC.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied to u-boot-marvell/master

Thanks,
Stefan

> ---
> Cc: Stefan Roese <sr@denx.de>
> Cc: "Marek Behún" <kabel@kernel.org>
> Cc: Chris Packham <judge.packham@gmail.com>
> ---
>   arch/arm/mach-mvebu/Kconfig | 1 -
>   common/spl/Kconfig          | 1 +
>   2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> index adb816982f87..c4be5d6e93e0 100644
> --- a/arch/arm/mach-mvebu/Kconfig
> +++ b/arch/arm/mach-mvebu/Kconfig
> @@ -394,7 +394,6 @@ config MVEBU_SPL_BOOT_DEVICE_MMC
>   	imply SPL_LIBDISK_SUPPORT
>   	imply SPL_MMC
>   	select SUPPORT_EMMC_BOOT if SPL_MMC
> -	select SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR if SPL_MMC
>   	select SPL_BOOTROM_SUPPORT
>   
>   config MVEBU_SPL_BOOT_DEVICE_SATA
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 97f542fcc8a5..c4715de0a582 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -538,6 +538,7 @@ if SPL_SYS_MMCSD_RAW_MODE
>   
>   choice
>   	prompt "Method for locating next phase of boot (e.g. U-Boot)"
> +	default SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR if MVEBU_SPL_BOOT_DEVICE_MMC
>   
>   config SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
>   	bool "MMC raw mode: by sector"

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

