Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942CCC28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 07:00:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD8418129F;
	Thu, 20 Mar 2025 08:00:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742454028;
	bh=O7HOo+FpTnoJfnlWZsvB/4pfI49U2TgnICQEys/DyHA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OA43r8PhLr3uuL3MH3oOKBN/4vXRm2Ou9LvnTxBCravr+eNDOLjNWD2sW7x+In416
	 1XQgXmoFQPqyyrxqBYpRsQ3dYq+1OTHluZBN3yPs+b96V5JoNeHGRA/+oCQvVs0MPH
	 Vq/NXW3GIdm7Wt2kkci30boOwA0oj9Tr7R4zzIXV3NWpacKH3CU4BeLsCdsOfGpT4s
	 0bRE8hCYZ7JPAGPu9fNgwWl1bt66zGpnaNM6fW3dDkaGT5gjytkMjVYcHsUuV42IDa
	 XLfENUMCvvlcmUqTusLaq7cUq3ViBk2Nz7+mLrBuYcJNYEoh10BCphx6Dtog3jnEDe
	 xoURX0A02/BvA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B389C8129F; Thu, 20 Mar 2025 08:00:22 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D90F38083E
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 08:00:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4ZJGg362fmz9stw;
 Thu, 20 Mar 2025 08:00:15 +0100 (CET)
Message-ID: <6d7d6c02-8859-462c-aa99-26d583b4a25e@denx.de>
Date: Thu, 20 Mar 2025 08:00:14 +0100
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
X-Rspamd-Queue-Id: 4ZJGg362fmz9stw
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
> ---
> Cc: Stefan Roese <sr@denx.de>
> Cc: "Marek Behún" <kabel@kernel.org>
> Cc: Chris Packham <judge.packham@gmail.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

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

