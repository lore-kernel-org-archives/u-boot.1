Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E192EE57D7
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 15:27:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64A94840A6;
	Wed, 31 Dec 2025 16:27:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="Tcizyalb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0558D840A9; Wed, 31 Dec 2025 16:27:46 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2A3D8409B
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 16:27:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1767194848;
 bh=66VmT+Ud/9DIZjiguoW/byBQythzTt5iEbtWRF6tp4o=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Tcizyalbdg7WmXlshwiPcTBp2Mtk3beYLuLtRR4DAhaCRhjk8Oa8g02ZQ7no5Q4PE
 JvDnUQbMU7effu569raCyUKlwRafHs/Av/zfsE4MHH6XJXU48F2fr1xZTqvDAD77WQ
 9VA4WWWlra6806SWW4EXua1ugDio2w+03jC0vgduT5cI903Yy/PNJrTiFGOFmHzn0k
 V2g0XjXcDKckR7OSxb4mGk0Ih9jWRPm2oWVVtmuBkCzhKshJCf7bCNjwnadwwjCRwq
 SIQdiMjam8ZugnfvXigbDQ0LMc6W84KRysdn/XzUWGeogkwnyqKYjPtiMMmP+g9tqT
 HbLl3fXGctfcw==
Received: from [IPV6:2605:59c0:2078:cf00:c0b6:e37b:5515:2b98] (unknown
 [IPv6:2605:59c0:2078:cf00:c0b6:e37b:5515:2b98])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 7C2C5B2207B2;
 Wed, 31 Dec 2025 16:27:27 +0100 (CET)
Message-ID: <967e53d4-02de-465f-bd14-04fe9845a9ef@freeshell.de>
Date: Wed, 31 Dec 2025 07:27:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] configs: starfive: Add Orange Pi RV to visionfive2
To: Hal Feng <hal.feng@starfivetech.com>, Leo Liang <ycliang@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20251226193034.181659-1-e@freeshell.de>
 <20251226193034.181659-5-e@freeshell.de>
 <ZQ2PR01MB1307A29262132CA6FAB3BE24E6BD2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <ZQ2PR01MB1307A29262132CA6FAB3BE24E6BD2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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


On 12/31/25 01:12, Hal Feng wrote:
>> On 27.12.25 03:30, E Shattow wrote:
>> Add Orange Pi RV to visionfive2 CONFIG_OF_LIST
> 
> Missing Signed-off-by here?
> 

Good catch, thanks Hal.


> With that,
> 
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> 
> Best regards,
> Hal
> 
>> ---
>>  configs/starfive_visionfive2_defconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/configs/starfive_visionfive2_defconfig
>> b/configs/starfive_visionfive2_defconfig
>> index a754134a313..7c957cc0ea1 100644
>> --- a/configs/starfive_visionfive2_defconfig
>> +++ b/configs/starfive_visionfive2_defconfig
>> @@ -80,7 +80,7 @@ CONFIG_WGET_HTTPS=y
>>  CONFIG_CMD_BOOTSTAGE=y
>>  CONFIG_OF_BOARD=y
>>  CONFIG_DEVICE_TREE_INCLUDES="starfive-visionfive2-u-boot.dtsi"
>> -CONFIG_OF_LIST="starfive/jh7110-deepcomputing-fml13v01
>> starfive/jh7110-milkv-mars starfive/jh7110-milkv-marscm-emmc
>> starfive/jh7110-milkv-marscm-lite starfive/jh7110-pine64-star64
>> starfive/jh7110-starfive-visionfive-2-v1.2a starfive/jh7110-starfive-
>> visionfive-2-v1.3b"
>> +CONFIG_OF_LIST="starfive/jh7110-deepcomputing-fml13v01
>> starfive/jh7110-milkv-mars starfive/jh7110-milkv-marscm-emmc
>> starfive/jh7110-milkv-marscm-lite starfive/jh7110-orangepi-rv
>> starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a
>> starfive/jh7110-starfive-visionfive-2-v1.3b"
>>  CONFIG_MULTI_DTB_FIT=y
>>  CONFIG_ENV_OVERWRITE=y
>>  CONFIG_ENV_IS_IN_SPI_FLASH=y
>> --
>> 2.50.0
> 

Signed-off-by: E Shattow <e@freeshell.de>
