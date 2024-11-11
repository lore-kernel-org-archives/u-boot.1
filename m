Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF00DD2E9C2
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 08:51:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36A1F88D14;
	Mon, 11 Nov 2024 09:51:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731315117;
	bh=VN8qgkNiK6+3FHzyBQOGE08iHAs+pShS1CV5/bmG9O8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=G5fWV8KpbcrCDu+scFilC2uOKQk8jTflujXotyNgkd7qtyvLDQ5W/kDlw4bUqiTTY
	 7ROdxQRNjGe/SUV5CMCCQdXlIV3eG7CHmfjBmufP+HrOjjXt4pJ1DhI4YZlhEbZpdk
	 qtX2wV6IrGAAyw9srafsPLNe54cy2Z0A4189Cm3bcfcZlFFVTz0Pa8nE6RGOeUSqnc
	 0PNmxw3L4DqE/nfzkyoJho1Menj6D9q4phowyi9Sd1uyJk1/QyhYwexe+5HmFFUtuR
	 27uM0d1dXYpUoZ3X0YozH7O9a8BwAwTcu/JYsmBmv+FcuzFQ2Lt7kpEpFjzjP+nBfD
	 nyFsFwmX98GXw==
Received: from [192.168.1.107] (87-97-106-70.pool.digikabel.hu [87.97.106.70])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8851988AE8;
 Mon, 11 Nov 2024 09:51:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731315115;
 bh=VN8qgkNiK6+3FHzyBQOGE08iHAs+pShS1CV5/bmG9O8=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=dO4YRVtvzqJ5LDKlMzP4b6jnO1WhN3a2EaToQkooqvTy85RYfp/t56gG+ThdiyREG
 qqYd6bmOj5XyXVx2WTtXF8RF3yZYSla+So1h8r7H/Ll9dKQFTwHyfu7Uroh3RRPxAt
 kCj54bd89MYW8mYBH1Kd6K1w2XbgEIGhPLFHFAgWHijdPvZfTXyj57cGkgR8j0+xXt
 +Bcx4YUfbdxr1eihRQWbxy+JM3UX7UA9Hqqp0fKF8/87Wckwa7j9+eZxAOfQc4vLUz
 lLIJaTcDocxDa+7qIkDzTbpb7wGo4HErJe03iVoaVR2dl/t1z1fzPdVHDxMh+FFurh
 dVEDO18esEqtQ==
Message-ID: <9240c726-5d78-a06f-a819-409fbd1af39d@denx.de>
Date: Mon, 11 Nov 2024 09:49:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 08/22] siemens: capricorn: use DCD_SKIP entry
Content-Language: en-US
To: "Schweizer, Walter" <walter.schweizer@siemens.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "agust@denx.de" <agust@denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, "Leto, Enrico" <enrico.leto@siemens.com>,
 "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
References: <20241108052143.26874-1-hs@denx.de>
 <20241108052143.26874-9-hs@denx.de>
 <1f2dfebdf27fac0813731a07046956f56a888ef6.camel@siemens.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <1f2dfebdf27fac0813731a07046956f56a888ef6.camel@siemens.com>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Wolater,

On 11.11.24 09:35, Schweizer, Walter wrote:
> On Fri, 2024-11-08 at 06:21 +0100, Heiko Schocher wrote:
>> Boards which use DCD data in SCFW can drop SPL.
>>
>> We tried in our mainline rework to use this approach
>> too as other imx8qxp boards do in mainline. But we
>> failed ... it was a hard way to understand the
>> reason!
>>
>> We cannot use DCD image in container as the SCFW
>> from siemens, does the RAM init on boot itself!
>>
>> Siemens SCFW reads the RAM config from i2c eeprom and
>> dependent on this settings, initializes the RAM.
>>
>> Adding DCD data to the bootcontainer will result in
>> hang of the SCFW, also DCD data in container image is
>> static which do not fit our needs.
>>
>> So we must drop DCD data image, and this has the side
>> effect that we need SPL, as the task which loads the images
>> from the container only loads the images to addresses,
>> and if executed bit is set, starts them.
>>
>> As now RAM is not initialized from it, and there is no
>> option to "wait until SCFW has setup RAM",  we can only
>> load SPL into internal RAM at this point, as than SPL
>> and SCFW boot parallel.
>>
>> The SPL itself than uses the SCU API to communicate
> 
> I think there is a typo "than" should be "then"?

Fixed, thanks!

bye,
Heiko
> 
>> with the SCFW and it seems that SCFW only responds to
>> this API requests when RAM setup is already done by the
>> SCFW, which has a side-effect of a "sync" for the RAM
>> setup is done by SCFW!
>>
>> We checked if SPL is always save in accessing RAM for
>> loading images to it! For tests, we added in our RAM
>> init part in the SCFW long delays (10 seconds and more)
>> as we thought there is such a sync missing, and we can
>> break the board through delaying RAM setup... but we
>> did not managed to fail booting U-Boot from SPL!
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>> ---
>>
>>   board/siemens/capricorn/imximage.cfg | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/board/siemens/capricorn/imximage.cfg
>> b/board/siemens/capricorn/imximage.cfg
>> index 4350e2967cc..e45f2c9589e 100644
>> --- a/board/siemens/capricorn/imximage.cfg
>> +++ b/board/siemens/capricorn/imximage.cfg
>> @@ -9,6 +9,10 @@
>>   
>>   /* Boot from SD, sector size 0x400 */
>>   BOOT_FROM      sd
>> +
>> +/* skip DCD data, as firmware initializes the RAM */
>> +DCD_SKIP true
>> +
>>   /* SoC type IMX8QX */
>>   SOC_TYPE IMX8QX
>>   /* Append seco container image */
> 

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
