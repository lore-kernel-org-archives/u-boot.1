Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370BDCFC528
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 09:27:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B97BA888BE;
	Mon, 14 Oct 2024 11:27:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=freemail.hu header.i=@freemail.hu header.b="PYUTMzcP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02CEC89071; Mon, 14 Oct 2024 11:27:15 +0200 (CEST)
Received: from smtp-out.freemail.hu (fmfe27.freemail.hu [46.107.16.232])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9956F89069
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 11:27:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=egyszeregy@freemail.hu
Received: from [192.168.0.16] (catv-178-48-208-49.catv.fixed.vodafone.hu
 [178.48.208.49])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.freemail.hu (Postfix) with ESMTPSA id 4XRsM34x58z7n0;
 Mon, 14 Oct 2024 11:27:11 +0200 (CEST)
Message-ID: <edd2bf00-800d-4ca2-81ef-f6af6130ccab@freemail.hu>
Date: Mon, 14 Oct 2024 11:25:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx9: Improve boot device auto-selection
To: Peng Fan <peng.fan@nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "sbabic@denx.de" <sbabic@denx.de>, "festevam@gmail.com"
 <festevam@gmail.com>
References: <20241013174120.1872-1-egyszeregy@freemail.hu>
 <PAXPR04MB845929FE951FCEC327F9F54788442@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Language: hu
From: =?UTF-8?Q?Sz=C5=91ke_Benjamin?= <egyszeregy@freemail.hu>
In-Reply-To: <PAXPR04MB845929FE951FCEC327F9F54788442@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1728898032; 
 s=20181004; d=freemail.hu;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 l=2960; bh=05IoTGRg2gy80pgqsrMZ+lhprp0KdtaKp14+YgT/A/8=;
 b=PYUTMzcPkT8m2vRR+jFjDISqHXvxgDZsFJQAU/P/CTlkBMynun4EPa5EEIXfnHON
 iUNF2bzQ95yjKDbVGVJq1qUsUiNG1AqpA4el/dxImO4qOY7Xld7qo4HjkD4jUh9+jPK
 AxBmLZLVkMxoTvz54+4XagPwelngKqanR+blBNcuxxt807Iw0o/2nh97ECxDZBkU1YU
 E+g3d8uNoMP8O89zB00mUv/wpt50X6wl5AVxR4nedq4cYtR9dixZQN8QSxqc0GnfX4R
 StqKF1ZZXVYByImZI/b5WFPS9q8Rezh8lP5bi98rPWWGdU8sYjcUn4Nyor9lqiOTu8B
 xtSaK64tPg==
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

2024. 10. 14. 2:39 keltezéssel, Peng Fan írta:
>> Subject: [PATCH] imx9: Improve boot device auto-selection
>>
>> From: Benjamin Szőke <egyszeregy@freemail.hu>
>>
>> Improve "mmcautodetect=yes" boot device auto-selection to able to
>> use it if CONFIG_ENV_IS_NOWHERE is enabled for i.MX9 SoC and
>> i.MX93 EVK board.
> 
> Would you please give more background on this, I not got
> the point on why doing this?
> 
> Thanks,
> Peng.
> 

If CONFIG_ENV_IS_NOWHERE is used in u-boot config instead of 
CONFIG_ENV_IS_IN_MMC, boot auto-selection does not work because of the incorrect 
#ifdef usage in /arch/arm/mach-imx/imx9/soc.c.

If CONFIG_ENV_IS_IN_MMC is not used, also need to define CONFIG_SYS_MMC_ENV_DEV 
to any default zero value manually, because the code of mmc_get_env_dev() of 
imx9 soc like to use it, if auto detection of boot is failed or it is not in SD 
or MMC boot mode.

Same things were solved in pico-imx7d source also.
https://github.com/u-boot/u-boot/blob/master/board/technexion/pico-imx7d/pico-imx7d.c#L159

>>
>> Signed-off-by: Benjamin Szőke <egyszeregy@freemail.hu>
>> ---
>>   arch/arm/mach-imx/imx9/soc.c          | 6 +++++-
>>   board/freescale/imx93_evk/imx93_evk.c | 2 +-
>>   include/configs/imx93_evk.h           | 6 ++++++
>>   3 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-
>> imx/imx9/soc.c index 7c28fa39e1..79ddbc7241 100644
>> --- a/arch/arm/mach-imx/imx9/soc.c
>> +++ b/arch/arm/mach-imx/imx9/soc.c
>> @@ -42,12 +42,16 @@ DECLARE_GLOBAL_DATA_PTR;
>>
>>   struct rom_api *g_rom_api = (struct rom_api *)0x1980;
>>
>> -#ifdef CONFIG_ENV_IS_IN_MMC
>> +#if CONFIG_IS_ENABLED(ENV_IS_IN_MMC) ||
>> +CONFIG_IS_ENABLED(ENV_IS_NOWHERE)
>>   __weak int board_mmc_get_env_dev(int devno)  {
>>   	return devno;
>>   }
>>
>> +#ifndef CONFIG_SYS_MMC_ENV_DEV
>> +#define CONFIG_SYS_MMC_ENV_DEV 0
>> +#endif
>> +
>>   int mmc_get_env_dev(void)
>>   {
>>   	int ret;
>> diff --git a/board/freescale/imx93_evk/imx93_evk.c
>> b/board/freescale/imx93_evk/imx93_evk.c
>> index 341831a7d3..c9171df330 100644
>> --- a/board/freescale/imx93_evk/imx93_evk.c
>> +++ b/board/freescale/imx93_evk/imx93_evk.c
>> @@ -58,7 +58,7 @@ int board_init(void)
>>
>>   int board_late_init(void)
>>   {
>> -#ifdef CONFIG_ENV_IS_IN_MMC
>> +#if CONFIG_IS_ENABLED(ENV_IS_IN_MMC) ||
>> +CONFIG_IS_ENABLED(ENV_IS_NOWHERE)
>>   	board_late_mmc_env_init();
>>   #endif
>>
>> diff --git a/include/configs/imx93_evk.h b/include/configs/imx93_evk.h
>> index 53fb8c9b1b..2a9595a261 100644
>> --- a/include/configs/imx93_evk.h
>> +++ b/include/configs/imx93_evk.h
>> @@ -27,6 +27,12 @@
>>   #define BOOTENV
>>   #endif
>>
>> +#if CONFIG_IS_ENABLED(ENV_IS_NOWHERE)
>> +#ifndef CONFIG_SYS_MMC_ENV_DEV
>> +#define CONFIG_SYS_MMC_ENV_DEV 0
>> +#endif
>> +#endif
>> +
>>   /* Initial environment variables */
>>   #define CFG_EXTRA_ENV_SETTINGS		\
>>   	BOOTENV \
>> --
>> 2.47.0.windows.1
> 

