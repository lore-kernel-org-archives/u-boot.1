Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4E7D3E775
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 22:12:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30A4788FD2;
	Tue,  5 Nov 2024 23:12:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=freemail.hu header.i=@freemail.hu header.b="NtAIeumy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE0058904C; Tue,  5 Nov 2024 23:12:56 +0100 (CET)
Received: from smtp-out.freemail.hu (fmfe26.freemail.hu [46.107.16.231])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 572F588FD2
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 23:12:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=egyszeregy@freemail.hu
Received: from [192.168.0.16] (catv-178-48-208-49.catv.fixed.vodafone.hu
 [178.48.208.49])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.freemail.hu (Postfix) with ESMTPSA id 4XjjJP3RQnzFkC;
 Tue, 05 Nov 2024 23:12:53 +0100 (CET)
Message-ID: <40c2800b-86e0-46e8-8b8a-add3b96dfc3d@freemail.hu>
Date: Tue, 5 Nov 2024 23:10:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx9: Improve boot device auto-selection
To: Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "sbabic@denx.de" <sbabic@denx.de>
References: <20241013174120.1872-1-egyszeregy@freemail.hu>
 <PAXPR04MB845929FE951FCEC327F9F54788442@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <CAOMZO5DBDDYr+9K8rq56L-=5EGWDNXY514rz5zoqPdXOQ2x=jw@mail.gmail.com>
 <93d2989d-7d55-40a3-a44b-ef64e1feb511@freemail.hu>
 <CAOMZO5Bvkqj6uYpSU=JsWd_t7yfvHAqhs9J08fGiEa1nfCX3Hw@mail.gmail.com>
 <DB9PR04MB8461C9D5EB7ADA89A2D335CE884C2@DB9PR04MB8461.eurprd04.prod.outlook.com>
 <9a06d2e7-37f8-4371-a4b2-0daaa38e2032@freemail.hu>
 <CAOMZO5DPZMRV-mYydxbLL8CGTocXp1ex6DSMgL5JJwP_FN1i9Q@mail.gmail.com>
Content-Language: hu
From: =?UTF-8?Q?Sz=C5=91ke_Benjamin?= <egyszeregy@freemail.hu>
In-Reply-To: <CAOMZO5DPZMRV-mYydxbLL8CGTocXp1ex6DSMgL5JJwP_FN1i9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1730844773; 
 s=20181004; d=freemail.hu;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 l=2669; bh=MVww7rhbPVq2aXJ4No8Cn4xbSlA91eQ5rkmxn/Jwiuk=;
 b=NtAIeumyJD29oiP6iZyeIjHgJU+j7EhF9l5Va91weAOOV8sefmWOBID2r5jEuCeh
 TC6hb1YIK+kkzcVnV+WuDIiMR//SjeB68aRI7x4RD0BpiLfqd/tXrFf9GWz64WsqaKZ
 2f44mBRR6EcF8g7OVkTNkxsRKlYGAEoPHF6FELwsczgqZBaNqXRCnLZD/A5x4Zig9o7
 pNCg0g5467Sf2L95Ol6AeHd83eIjOQwxugFIZRoAWlHwOgI2eCa1fvSJwo7T8W51g0w
 cmbQm2fClo/T4LcMViWbztQaGk0ec9vwATJldYDeA7+Ww+0kfCF8ZR1WRpK7/uefE32
 HKeokLlsaw==
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

2024. 11. 01. 13:30 keltezéssel, Fabio Estevam írta:
> On Fri, Nov 1, 2024 at 7:56 AM Szőke Benjamin <egyszeregy@freemail.hu> wrote:
> 
>> If both CONFIG_ENV_IS_IN_MMC=y and CONFIG_ENV_IS_NOWHERE=y are in the config,
>> CONFIG_ENV_IS_IN_MMC=y will be overrideing default CONFIG_ENV_IS_NOWHERE
>> settings, so in imx9 defconfig it is useless to use both of them.
>>
>> In my board i can use CONFIG_ENV_IS_NOWHERE=y without CONFIG_ENV_IS_IN_MMC=y in
>> imX93 EVK board but i needed to make this patch in imx9/soc.c and imx93_evk.c
>> source files imx9 to get it work.
>>
>> It will not break any rules. In this boot mode selection it just a simple
>> process to set "mmcdev" and "mmcroot" according your actual MMC device IDs from
>> boot switches states. It never be able to break any rules for UUU booting in
>> Serial download mode because you have to use manual commands from UUU script
>> which will never use this mmc variables.
>> https://elixir.bootlin.com/u-boot/v2024.10/source/board/congatec/common/mmc.c#L41
>>
>> Goal in my patch to able to use the boot mode autodecetion in case of use only
>> CONFIG_ENV_IS_NOWHERE=y option (without CONFIG_ENV_IS_IN_MMC). It works for me.
>> Please sit down, put your NXP board i your desk and try it, then analyse how
>> well works for you also.
> 
> It would help to put some of the details you add above into the commit log.
> 
> There are checkpatch errors in your patch:
> 
> $ ./scripts/checkpatch.pl
> ~/Downloads/imx9-Improve-boot-device-auto-selection.patch
> WARNING: Use 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef'
> where possible
> #121: FILE: arch/arm/mach-imx/imx9/soc.c:45:
> +#if CONFIG_IS_ENABLED(ENV_IS_IN_MMC) || CONFIG_IS_ENABLED(ENV_IS_NOWHERE)
> 
> WARNING: Use 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef'
> where possible
> #127: FILE: arch/arm/mach-imx/imx9/soc.c:51:
> +#ifndef CONFIG_SYS_MMC_ENV_DEV
> 
> ERROR: All CONFIG symbols are managed by Kconfig
> #128: FILE: arch/arm/mach-imx/imx9/soc.c:52:
> +#define CONFIG_SYS_MMC_ENV_DEV 0
> 
> WARNING: Use 'if (IS_ENABLED(CONFIG...))' instead of '#if or #ifdef'
> where possible
> #143: FILE: board/freescale/imx93_evk/imx93_evk.c:61:
> +#if CONFIG_IS_ENABLED(ENV_IS_IN_MMC) || CONFIG_IS_ENABLED(ENV_IS_NOWHERE)
> 
> ERROR: All CONFIG symbols are managed by Kconfig
> #157: FILE: include/configs/imx93_evk.h:32:
> +#define CONFIG_SYS_MMC_ENV_DEV 0
> 
> total: 2 errors, 3 warnings, 0 checks, 37 lines checked


In my next [PATCH v2], these errors were fixed:
[PATCH v2] imx9: Improve boot mode autodetection
https://lists.denx.de/pipermail/u-boot/2024-November/570295.html

