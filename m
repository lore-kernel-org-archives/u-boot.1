Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A0BC54FB9
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 18:51:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ED2486DE0;
	Fri, 17 Nov 2023 19:51:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AW3+BULe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5475D86EA3; Fri, 17 Nov 2023 19:51:05 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F14386CF7
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 19:51:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=inindev@gmail.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-77897c4ac1fso144302085a.3
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 10:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700247060; x=1700851860; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iewvQ8puOqtkFO9eeBIuiU2OlpAY8pjvlRItjXvU2v4=;
 b=AW3+BULeOFUkBebBrSxBa8nZYUB/bm7DwZcvepPPR4p7h/BZcYmMzKMsirx1nTvzdI
 rBtX+/AyGeiFjZKeK+5SI2gshLLwifWRjrjheOi95MHxlWsvL88r0QaL2Oh8yj9ETG0O
 ukmRtsmypE0C1q92r/L2yPVOJofX/RfAaUurc0ydzEAi85OZR6BEvTz2a369NG/djyvC
 tmIf9CzMid9jEO9Cl1l9L5SqVzxDVncD7yerJ/bhusNNDV0FZcWZD64780Xq+cXMz8UA
 SV0zRwatfdpqcluCo43qa8UmKEMn0OSflVnCFtzIAknSytfFtp5u+kADmnjuY/WmCjsG
 ug3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700247060; x=1700851860;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iewvQ8puOqtkFO9eeBIuiU2OlpAY8pjvlRItjXvU2v4=;
 b=uaAtqMLYNZ2w8DjFQci0elfclJXufQpHQSERwfsFeQNe6BbDZRlQX0dLGqJkBQdT0I
 kmjLarWpeopsgCwN2ad0xTPMFs6byLT5h00VT87CyZ4Jbo9x85G4Z5oKWqOm+exfOsdp
 2Nj952qne7GMZxeIjSggXeSlMir7hfbigfXrzP1qbBE5GdJwCEzetFGVCDpZZKRwn8/Q
 EakPnUeiPEjQDowypdKLPQ23jl5r3QorxZbrUuvC23AV78myJVtWA+PnAvP7TR0aEHfd
 0o18vaAZs0ftWLWtcAvVETOT9Wj2UghDk1LgF9nnPEuoYHX8PvfYThq9OPdXBL8e3Zk6
 eiOg==
X-Gm-Message-State: AOJu0YwWH5kdOOUv6wx0MlBv59PmXO21WpD4cQh0NRAOvAXtFQucBm28
 IAX5kSthR15P2dgzdCH9t2eLdq0+YmUuJg==
X-Google-Smtp-Source: AGHT+IGu+C0lcT6VkhEWpDJMRxwNf/1J9UgzVJeaLCP5fKR3PYGMD4Sf5JjHkfHwhpzOy2ER2JaOBw==
X-Received: by 2002:a05:6214:23c8:b0:66d:4d2c:b0d3 with SMTP id
 hr8-20020a05621423c800b0066d4d2cb0d3mr15916863qvb.4.1700247059935; 
 Fri, 17 Nov 2023 10:50:59 -0800 (PST)
Received: from [192.168.20.212] (cpe-107-15-246-199.nc.res.rr.com.
 [107.15.246.199]) by smtp.gmail.com with ESMTPSA id
 s7-20020ad45007000000b00677b1664f9csm828158qvo.69.2023.11.17.10.50.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Nov 2023 10:50:59 -0800 (PST)
Message-ID: <31e783f3-a73b-e6fc-bf25-84a8b2c4cd1d@gmail.com>
Date: Fri, 17 Nov 2023 13:50:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 1/4] rockchip: rk3588: Fix boot from SPI flash
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Slawomir Stepien <sst@poczta.fm>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Eugen Hristev <eugen.hristev@collabora.com>, u-boot@lists.denx.de
References: <20231112102705.1180714-1-jonas@kwiboo.se>
 <20231112102705.1180714-2-jonas@kwiboo.se>
 <561f7d8a-bf46-4ba7-a353-b5d3dfab95b0@theobroma-systems.com>
 <ZVdyu2vjW0LrW6Jf@nr200> <20231117175020.GP170968@bill-the-cat>
From: John Clark <inindev@gmail.com>
In-Reply-To: <20231117175020.GP170968@bill-the-cat>
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


On 11/17/23 12:50 PM, Tom Rini wrote:
> On Fri, Nov 17, 2023 at 03:03:39PM +0100, Slawomir Stepien wrote:
>> On lis 14, 2023 15:06, Quentin Schulz wrote:
>>> Hi Jonas,
>> Hi Quentin
>>
>>> On 11/12/23 11:26, Jonas Karlman wrote:
>>>> The commit fd6e425be243 ("rockchip: rk3588-rock-5b: Enable boot from SPI
>>>> NOR flash") added a new BROM_BOOTSOURCE_SPINOR_RK3588 with value 6.
>>>>
>>>> At the time the reason for this new bootsource id value 6 was unknown.
>>>>
>>>> We now know that the BootRom on RK3588 use different bootsource id
>>>> values depending on the iomux used by the flash spi controller, and not
>>>> by the type of spi nor or spi nand flash used.
>>>>
>>>> Add the following defines and use them for RK3588 boot_devices.
>>>>
>>>> - BROM_BOOTSOURCE_FSPI_M0 = 3
>>>> - BROM_BOOTSOURCE_FSPI_M1 = 4
>>>> - BROM_BOOTSOURCE_FSPI_M2 = 6
>>>>
>>>> Fixes: fd6e425be243 ("rockchip: rk3588-rock-5b: Enable boot from SPI NOR flash")
>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>> ---
>>>>    arch/arm/include/asm/arch-rockchip/bootrom.h | 4 +++-
>>>>    arch/arm/mach-rockchip/rk3588/rk3588.c       | 5 +++--
>>>>    2 files changed, 6 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/arch/arm/include/asm/arch-rockchip/bootrom.h b/arch/arm/include/asm/arch-rockchip/bootrom.h
>>>> index 7dab18fbc3fb..f78337397d63 100644
>>>> --- a/arch/arm/include/asm/arch-rockchip/bootrom.h
>>>> +++ b/arch/arm/include/asm/arch-rockchip/bootrom.h
>>>> @@ -47,8 +47,10 @@ enum {
>>>>    	BROM_BOOTSOURCE_EMMC = 2,
>>>>    	BROM_BOOTSOURCE_SPINOR = 3,
>>>>    	BROM_BOOTSOURCE_SPINAND = 4,
>>>> +	BROM_BOOTSOURCE_FSPI_M0 = 3,
>>>> +	BROM_BOOTSOURCE_FSPI_M1 = 4,
>>> I'm a bit wary of two pairs of enums sharing the same value, especially when
>>> we want to use them as offset in a static definition of an array.
>>>
>>> Should we #ifdef it (meh) for RK3588?
>>> Should we add a suffix like before for identifying RK3588-specific options?
>>>
>>> At the very least explicit that those are RK3588-specific in a comment for
>>> both conflicts (the ones that apply to everything except RK3588 to say to
>>> use only for !RK3588, and the ones that apply to RK3588 only)?
>> Can you say why it is so important to know that given enum is specific to given CPU here in the
>> header file? I think that the enums in the bootrom.h should be as generic as possible.
>>
>> By using the possible enums in a static array, "solves" the problem of assigning the boot source to
>> specific CPU. There is not need to make such grouping in the bootrom.h.
> Do we have any insight as to why Rockchip re-used those values? Looking
> at the header I see RK3588 has a different SPINOR value than others.
> Does RK3588 share the same value for other sources? How much of
> bootrom.h is still correct for RK3588? I'd rather not have to move to
> having bootrom_${soc}.h like so many other headers are, and if it's just
> these values, it might be cleaner to #if .. #else .. #endif the whole
> enum, and then re-evaluate things abased on whatever the next new SoC
> does here.
>
Which c specification does u-boot follow?  Duplicate values in 
enumerations are explicitly allowed in c as far as I ever have known.

"The use of enumerators with = may produce enumeration constants with 
values that duplicate other values in the same enumeration."
https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2310.pdf

