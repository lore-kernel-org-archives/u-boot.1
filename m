Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10089C54E41
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 10:09:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57E8E87073;
	Tue,  5 Mar 2024 11:09:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="mmIQsNXJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B122887947; Tue,  5 Mar 2024 11:09:52 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13FC686DEE
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 11:09:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8d7b=KL=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1709633375;
 bh=Xv/v9xvOqDwaYEf/jMeeVjhl50stK5HllgrDDJJGstU=;
 b=mmIQsNXJnQKXKctEqhWhL3HO9L7t+vr0FezQ+KBfUtCANX9mzPlmdv55KJ8zQvRhSR/URPnX+
 vBdZM3lLgy29vRGd75sAPcmzb22SuJ9VpxiQJeisg+ZQY6zH67DHwZkpvmTHDIJJl+aASTb/HNu
 dV2LW2S8rbdZ2Qk+P8Q+keGc4OhYDDwsKR/2cc1znifrNovMLEmCY2k6mM3Yp6sLDga1ci3PVXk
 pg+UIPZSoHmOOw6iagFoCm2UVpc26aFozL8ubhBa9eNIsMdGr+OmljfJBEHvqyv5dkczi1WT5Km
 WYZK3kEq68TSOMaR17xFiFdHiiRK20JMIlAo0TGIS13w==
Message-ID: <589e6970-22bc-4502-b669-1ec6ea6a977f@kwiboo.se>
Date: Tue, 5 Mar 2024 11:09:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: rockchip: rock5b: enable environment
Content-Language: en-US
To: Christopher Obbard <chris.obbard@collabora.com>, Trevor Woerner
 <twoerner@gmail.com>
Cc: "U-Boot Mailing List" <u-boot@lists.denx.de>, Eugen Hristev
 <eugen.hristev@collabora.com>, Tom Rini <trini@konsulko.com>, Kever Yang
 <kever.yang@rock-chips.com>
References: <20240305021051.22405-1-twoerner@gmail.com>
 <20240305021051.22405-4-twoerner@gmail.com>
 <48a3680a-2e33-4c2f-b564-68fd13a4e064@kwiboo.se>
 <c0785fe90bc1128140480f7812cf6facbf6e637c.camel@collabora.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <c0785fe90bc1128140480f7812cf6facbf6e637c.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65e6ef5da3210ea3b04c7276
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

Hi Christopher,

On 2024-03-05 10:36, Christopher Obbard wrote:
> Hi Jonas & Trevor,
> 
> On Tue, 2024-03-05 at 10:31 +0100, Jonas Karlman wrote:
>> Hi Trevor,
>>
>> On 2024-03-05 03:10, Trevor Woerner wrote:
>>> Following the pattern of other Rockchip devices, enable the U-Boot
>>> environment to be stored in MMC. This patch specifically assumes the
>>> environment will be stored on the SDcard.
>>
>> This board has SPI flash, so storing env in SPI flash is probably a
>> better default.
> 
> I agree with that.
> 
>> However, preferably the env should be stored/loaded from
>> the same device that TPL/SPL was loaded from.
> 
> Do you know if there is some mechanism in U-Boot to do this already ?
> 
> It could be useful to enable autodetection on many boards which can boot U-
> Boot from either SPI flash / eMMC / SD card.
> 

I think it should be possible with a combo of env_get_location(),
arch_env_get_location() and mmc_get_env_dev().

board/theobroma-systems/common/common.c does something like this already,
other arch also have these functions defined, for inspiration.

Regards,
Jonas

> 
> Cheers!
> 
> Chris
> 
>>
>> Regards,
>> Jonas
>>
>>>
>>> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
>>> ---
>>>  configs/rock5b-rk3588_defconfig | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-
>>> rk3588_defconfig
>>> index 0595325e8107..64a242003aa1 100644
>>> --- a/configs/rock5b-rk3588_defconfig
>>> +++ b/configs/rock5b-rk3588_defconfig
>>> @@ -60,6 +60,8 @@ CONFIG_CMD_REGULATOR=y
>>>  CONFIG_SPL_OF_CONTROL=y
>>>  CONFIG_OF_LIVE=y
>>>  CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks
>>> assigned-clock-rates assigned-clock-parents"
>>> +CONFIG_ENV_IS_IN_MMC=y
>>> +CONFIG_SYS_MMC_ENV_DEV=1
>>>  CONFIG_SPL_DM_SEQ_ALIAS=y
>>>  CONFIG_SPL_REGMAP=y
>>>  CONFIG_SPL_SYSCON=y
>>

