Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A820E6B240
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 10:57:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1800488A37;
	Fri,  1 Nov 2024 11:57:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=freemail.hu header.i=@freemail.hu header.b="SeIysi8R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F43D88CC9; Fri,  1 Nov 2024 11:57:02 +0100 (CET)
Received: from smtp-out.freemail.hu (fmfe27.freemail.hu [46.107.16.232])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95E4688A37
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 11:56:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=freemail.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=egyszeregy@freemail.hu
Received: from [192.168.0.16] (catv-178-48-208-49.catv.fixed.vodafone.hu
 [178.48.208.49])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.freemail.hu (Postfix) with ESMTPSA id 4XfyVL42xpzDsm;
 Fri, 01 Nov 2024 11:56:58 +0100 (CET)
Message-ID: <9a06d2e7-37f8-4371-a4b2-0daaa38e2032@freemail.hu>
Date: Fri, 1 Nov 2024 11:55:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx9: Improve boot device auto-selection
To: Peng Fan <peng.fan@nxp.com>, Fabio Estevam <festevam@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "sbabic@denx.de" <sbabic@denx.de>
References: <20241013174120.1872-1-egyszeregy@freemail.hu>
 <PAXPR04MB845929FE951FCEC327F9F54788442@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <CAOMZO5DBDDYr+9K8rq56L-=5EGWDNXY514rz5zoqPdXOQ2x=jw@mail.gmail.com>
 <93d2989d-7d55-40a3-a44b-ef64e1feb511@freemail.hu>
 <CAOMZO5Bvkqj6uYpSU=JsWd_t7yfvHAqhs9J08fGiEa1nfCX3Hw@mail.gmail.com>
 <DB9PR04MB8461C9D5EB7ADA89A2D335CE884C2@DB9PR04MB8461.eurprd04.prod.outlook.com>
Content-Language: hu
From: =?UTF-8?Q?Sz=C5=91ke_Benjamin?= <egyszeregy@freemail.hu>
In-Reply-To: <DB9PR04MB8461C9D5EB7ADA89A2D335CE884C2@DB9PR04MB8461.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1730458619; 
 s=20181004; d=freemail.hu;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 l=2338; bh=JFn31wbpGsTXEYTiEvWPOVXnm63lTQl742gz2Jf1PbE=;
 b=SeIysi8Rpu/tTcLVdlrb5dJX+eta+O0klSVyxPdDUytThaVMSHgP4IhAXqkP+jA2
 BvSkyW5tjgQVJ7IbsaSDl3AQIGzVgeLLU29d7lSSj2fXSCWM00pQws1t4w07Qcj9G6x
 rEf4rVYOLWdpADYfUstr10c6VtGodKZezRNq2nEzfy1ATkLXxfMgd22/ilNpXn2Uwv7
 togAXeat7iEIf9kS5d3CRzZAbceoem9ovGqsTzSKysTmFeDhguBBO4IXeMoMNZD9Jmg
 oI+PaxOijKdOoGJMIPxE79xXJuukA2MAL4Rcm0dUrEtPhxRa1aLCuVM7uVgZanzRhbW
 6WgWZu4iHQ==
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

2024. 10. 22. 14:23 keltezéssel, Peng Fan írta:
>> Subject: Re: [PATCH] imx9: Improve boot device auto-selection
>>
>> On Wed, Oct 16, 2024 at 4:42 PM Szőke Benjamin
>> <egyszeregy@freemail.hu> wrote:
>>
>>> You can use only one of config from CONFIG_ENV_IS_IN_MMC=y and
>>> CONFIG_ENV_IS_NOWHERE=y in U-boot config in same time.
>>
>> imx93_11x11_evk_defconfig selects both CONFIG_ENV_IS_IN_MMC=y
>> and CONFIG_ENV_IS_NOWHERE=y.
>>
>>> If you like to use CONFIG_ENV_IS_NOWHERE=y, these codes in the
>> patched
>>> source files will be not part of the build, and the autodetection of
>>> the boot mode will never work. At the moment it works only if you
>> use
>>> CONFIG_ENV_IS_IN_MMC=y in U-boot config but it should work also
>> in
>>> case of use CONFIG_ENV_IS_NOWHERE=y option also.
>>
>> But like I said imx93_11x11_evk_defconfig selects both
>> CONFIG_ENV_IS_IN_MMC=y and CONFIG_ENV_IS_NOWHERE=y.
>>
>> I am still confused by your patch.
>>
>> I would like to get a feedback from Peng Fan.
> 
> In UUU boot mode, we use the env inside U-Boot proper, so
> it is NOWHERE.
> 
> In this patch, I think use changing to mmc for NOWHERE
> may break the rule.
> 
> Thanks,
> Peng.

If both CONFIG_ENV_IS_IN_MMC=y and CONFIG_ENV_IS_NOWHERE=y are in the config, 
CONFIG_ENV_IS_IN_MMC=y will be overrideing default CONFIG_ENV_IS_NOWHERE 
settings, so in imx9 defconfig it is useless to use both of them.

In my board i can use CONFIG_ENV_IS_NOWHERE=y without CONFIG_ENV_IS_IN_MMC=y in 
imX93 EVK board but i needed to make this patch in imx9/soc.c and imx93_evk.c 
source files imx9 to get it work.

It will not break any rules. In this boot mode selection it just a simple 
process to set "mmcdev" and "mmcroot" according your actual MMC device IDs from 
boot switches states. It never be able to break any rules for UUU booting in 
Serial download mode because you have to use manual commands from UUU script 
which will never use this mmc variables.
https://elixir.bootlin.com/u-boot/v2024.10/source/board/congatec/common/mmc.c#L41

Goal in my patch to able to use the boot mode autodecetion in case of use only 
CONFIG_ENV_IS_NOWHERE=y option (without CONFIG_ENV_IS_IN_MMC). It works for me. 
Please sit down, put your NXP board i your desk and try it, then analyse how 
well works for you also.
