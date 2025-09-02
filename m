Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0004BCA1007
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 22:32:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50D4C83390;
	Wed,  3 Sep 2025 00:32:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="FWLlY6ev";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1530C833C6; Wed,  3 Sep 2025 00:32:25 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5CDA832AD
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 00:32:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 292513F284
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 22:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1756852342;
 bh=hq793E6pQLm/PWZj6C7xYRQVLPWQ97sqs+aq57D6lQ0=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=FWLlY6evmHVn/bAbN/NF+pcKlOl1USYdtkqAUKWpHCIsHxzJkqT/3y9GRtVOQ42Wt
 bdyI0xtgncc0WOaCeqK4YwMeJoddJHa80HA6+joNQ7HArDUbnvNbcPoPKQ+TYNM/oC
 rs6R0b2eL2av6O6oUvLH8ZeYZLJvRHCySrz5byLieIY3lWe62OZE6FmDZbgnLmvgzJ
 3jwiiwAHm4zvN9TkY+2aq7ohopbKFDFD43eD+YcNocd5NFIfbYgu2BSPm1OqZVHs1K
 S7hoU+Lr6H3SmOItTG/OFzZ8BlQMwu5wKSHsqagD8i0MTMHeTKyQFfPkDXfatpro9Q
 /qFyxZs8tJSow==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45b8af0b986so2111115e9.1
 for <u-boot@lists.denx.de>; Tue, 02 Sep 2025 15:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756852341; x=1757457141;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hq793E6pQLm/PWZj6C7xYRQVLPWQ97sqs+aq57D6lQ0=;
 b=IjSuYT+EOJsMS0uOY2hPKDHHti4DMYEme/WwTEZlpPrghm5mYiilXove1HpDMIVOLK
 sXzparMpdKapKSQhfYZCQ83lKNoRqN6lGyOR+ioZvxcujAJcE/NwZGnYk7WveJRxbH35
 vuafdKQcagpoEnHu6uWRV6hrONoGsnkdiWby8fITP3wtXsJnwlrqek1ryx2l57DAiDKx
 yqial6fzHsvUp5wuy4fgRbMyhbtrT9Sw0xc/yPpBcRIPJEY88RaCh4P+o5FoZnPwbdYI
 7g/DjTHCIOH0P/Zk6k4h5/RC3gUdirXdd8y6N/MuHIt/Ogf0B9G8GoFtTWel2JAcJcYq
 X/JQ==
X-Gm-Message-State: AOJu0YxzxMB75hxQkTVhGL8nWs7uNg7Q0Dqd5rl93QKAB5+XtzrCH/uX
 98WWxAJzjrRBmOHX1KdOlqpUus0QusTiMd/JODk18V6/CwgEouuRfA9iU/Vr5MVYgJM2jnVHHu9
 eB1jLi29k+lcD2VB2kbQ0vQh+LhNLEK6I701ylxSWwu2aE1Y5Kak0iy5LHHow8X1+4Sq4hVs=
X-Gm-Gg: ASbGncueEuO6rwpw4pG8Xu0ImNzhMPuQaAb+4CPyOVnC34Ug9P5DsGxA9Px5JLI33Zi
 4mRbhVa9wh7XXswadWzjskAoNA5vw50pmq6R6/J0GyjqwVQ0+fFy3JU/5hL59rwI2yo1ahjjfPx
 lNUTVfnoGpJhToX9rsxyd9cX0KkYD3VXWW66JGzrvNQ1InwIypCt0UVVCFgj861Xvj6Ok5lJDgk
 HC6RjnBkZLPNYD54/GLazMM8HKHJ0U61s/HIxBWzydKKXhq84QDhCkOZntzAUeqxvcwnPZiGvoC
 7fIWVnRNMFYITh9iQMl2OkPROjRjZg/G4yrN7NQW6yaGvxK3gCyjOdnSDzQdAfYAIkRw3/YIef/
 0iUDQPZbV+k9ed5tJzQSseBkEZvRPbX9tdVgmqA==
X-Received: by 2002:a05:600c:2ed3:b0:459:dd1d:2ee0 with SMTP id
 5b1f17b1804b1-45b84bc984emr70741685e9.0.1756852341358; 
 Tue, 02 Sep 2025 15:32:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBjFvjVdwYpCSWqnbqfWNsWGtMpsVKNj26uGkMeq7XWmAqs57j43yXyX1cOQXIru1u8Indpw==
X-Received: by 2002:a05:600c:2ed3:b0:459:dd1d:2ee0 with SMTP id
 5b1f17b1804b1-45b84bc984emr70741525e9.0.1756852340898; 
 Tue, 02 Sep 2025 15:32:20 -0700 (PDT)
Received: from [192.168.103.116]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e8ab14esm231851705e9.21.2025.09.02.15.32.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 15:32:19 -0700 (PDT)
Message-ID: <00962cc7-4930-4dbf-9c51-0faacee221a1@canonical.com>
Date: Wed, 3 Sep 2025 00:32:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 04/10] eeprom: starfive: Correct
 get_pcb_revision_from_eeprom()
To: E Shattow <e@freeshell.de>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Leo
 <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Hal Feng <hal.feng@starfivetech.com>
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
 <20250829060931.79940-5-hal.feng@starfivetech.com>
 <7c0bdef3-69df-4536-bddf-e2912ce71eed@canonical.com>
 <ZQ2PR01MB1307D97D2C9566B8EE443812E6062@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
 <7f46fbd8-00bf-4a05-af78-a089332e55d6@freeshell.de>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <7f46fbd8-00bf-4a05-af78-a089332e55d6@freeshell.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 9/3/25 00:12, E Shattow wrote:
> 
> On 9/2/25 00:44, Hal Feng wrote:
>>> On 29.08.25 15:44, Heinrich Schuchardt wrote:
>>> On 29.08.25 08:09, Hal Feng wrote:
>>>> pcb_revision is stored in the pcb_revision field of ATOM4. Correct it.
>>>> Move the function description to the header file.
>>>> Remove the function calls in board/starfive/visionfive2/.
>>>>
>>>> Fixes: aea1bd95b61e ("eeprom: starfive: Enable ID EEPROM configuration")
>>>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>>>> ---
>>>>    arch/riscv/include/asm/arch-jh7110/eeprom.h   |  5 +++++
>>>>    board/starfive/visionfive2/spl.c              | 18 ++++++-----------
>>>>    .../visionfive2/starfive_visionfive2.c        | 20 ++++++-------------
>>>>    .../visionfive2/visionfive2-i2c-eeprom.c      | 11 ++--------
>>>>    4 files changed, 19 insertions(+), 35 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/include/asm/arch-jh7110/eeprom.h
>>> b/arch/riscv/include/asm/arch-jh7110/eeprom.h
>>>> index 6d0a0ba0c4a..025f1d32c49 100644
>>>> --- a/arch/riscv/include/asm/arch-jh7110/eeprom.h
>>>> +++ b/arch/riscv/include/asm/arch-jh7110/eeprom.h
>>>> @@ -9,6 +9,11 @@
>>>>
>>>>    #include <linux/types.h>
>>>>
>>>> +/**
>>>> + * get_pcb_revision_from_eeprom() - get the PCB revision
>>>> + *
>>>> + * @return: the PCB revision or 0xFF on error.
>>>> + */
> 
> No. Inverted logic. See below comment about body of function.
> 
>>>>    u8 get_pcb_revision_from_eeprom(void);
>>>>
>>>>    /**
>>>> diff --git a/board/starfive/visionfive2/spl.c
>>> b/board/starfive/visionfive2/spl.c
>>>> index 3dfa931b655..901e7b58f36 100644
>>>> --- a/board/starfive/visionfive2/spl.c
>>>> +++ b/board/starfive/visionfive2/spl.c
>>>> @@ -126,19 +126,13 @@ int board_fit_config_name_match(const char
>>> *name)
>>>>    		    !strncmp(get_product_id_from_eeprom(), "STAR64", 6)) {
>>>>    		return 0;
>>>>    	} else if (!strcmp(name, "starfive/jh7110-starfive-visionfive-2-v1.2a")
>>> &&
>>>> -		    !strncmp(get_product_id_from_eeprom(), "VF7110", 6)) {
>>>> -		switch (get_pcb_revision_from_eeprom()) {
>>>> -		case 'a':
>>>> -		case 'A':
>>>> -			return 0;
>>>> -		}
>>>> +		   (!strncmp(get_product_id_from_eeprom(), "VF7110A", 7)
>>> ||
>>>> +		    !strncmp(get_product_id_from_eeprom(), "VF7110a", 7)))
>>> {
>>>> +		return 0;
>>>>    	} else if (!strcmp(name, "starfive/jh7110-starfive-visionfive-2-v1.3b")
>>> &&
>>>> -		    !strncmp(get_product_id_from_eeprom(), "VF7110", 6)) {
>>>> -		switch (get_pcb_revision_from_eeprom()) {
>>>> -		case 'b':
>>>> -		case 'B':
>>>> -			return 0;
>>>> -		}
>>>> +		   (!strncmp(get_product_id_from_eeprom(), "VF7110B", 7)
>>> ||
>>>> +		    !strncmp(get_product_id_from_eeprom(), "VF7110b", 7)))
>>> {
>>>> +		return 0;
>>>>    	}
>>>>
>>>>    	return -EINVAL;
> 
> I agree it is good to delete the case statement and drop lowercase
> compare as suggested, also...
> 
>>>> diff --git a/board/starfive/visionfive2/starfive_visionfive2.c
>>> b/board/starfive/visionfive2/starfive_visionfive2.c
>>>> index bfbb11a2ee7..f38433e94ac 100644
>>>> --- a/board/starfive/visionfive2/starfive_visionfive2.c
>>>> +++ b/board/starfive/visionfive2/starfive_visionfive2.c
>>>> @@ -59,20 +59,12 @@ static void set_fdtfile(void)
>>>>    		fdtfile = "starfive/jh7110-milkv-mars.dtb";
>>>>    	} else if (!strncmp(get_product_id_from_eeprom(), "STAR64", 6)) {
>>>>    		fdtfile = "starfive/jh7110-pine64-star64.dtb";
>>>> -	} else if (!strncmp(get_product_id_from_eeprom(), "VF7110", 6)) {
>>>> -		switch (get_pcb_revision_from_eeprom()) {
>>>> -		case 'a':
>>>> -		case 'A':
>>>> -			fdtfile = "starfive/jh7110-starfive-visionfive-2-
>>> v1.2a.dtb";
>>>> -			break;
>>>> -		case 'b':
>>>> -		case 'B':
>>>> -			fdtfile = "starfive/jh7110-starfive-visionfive-2-
>>> v1.3b.dtb";
>>>> -			break;
>>>> -		default:
>>>> -			log_err("Unknown revision\n");
>>>> -			return;
>>>> -		}
>>>> +	} else if (!strncmp(get_product_id_from_eeprom(), "VF7110A", 7) ||
>>>> +		   !strncmp(get_product_id_from_eeprom(), "VF7110a", 7)) {
>>>
>>> Where boards both with 'a' and 'b' ever shipped?
>>> I have only seen 'A' and 'B' in pbuf.eeprom.atom1.data.pstr[6].
>>
>> You're right. There are no boards marked "VF7110a" or "VF7110b". Let's remove
>> the comparison of "VF7110a" and "VF7110b".
>>
>> Best regards,
>> Hal
> 
> ... again here too delete the case statement and drop lowercase compare.
> Thanks.
> 
>>
>>>
>>> The change looks technically correct.
>>>
>>> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>
>>>> +		fdtfile = "starfive/jh7110-starfive-visionfive-2-v1.2a.dtb";
>>>> +	} else if (!strncmp(get_product_id_from_eeprom(), "VF7110B", 7) ||
>>>> +		   !strncmp(get_product_id_from_eeprom(), "VF7110b", 7)) {
>>>> +		fdtfile = "starfive/jh7110-starfive-visionfive-2-v1.3b.dtb";
>>>>    	} else {
>>>>    		log_err("Unknown product\n");
>>>>    		return;
> 
>>>> diff --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
>>> b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
>>>> index 3866d07f9d4..43b8af4fc59 100644
>>>> --- a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
>>>> +++ b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
>>>> @@ -535,19 +535,12 @@ int mac_read_from_eeprom(void)
>>>>    	return 0;
>>>>    }
>>>>
>>>> -/**
>>>> - * get_pcb_revision_from_eeprom - get the PCB revision
>>>> - *
>>>> - * 1.2A return 'A'/'a', 1.3B return 'B'/'b',other values are illegal
>>>> - */
>>>>    u8 get_pcb_revision_from_eeprom(void)
>>>>    {
>>>> -	u8 pv = 0xFF;
>>>> -
>>>>    	if (read_eeprom())
>>>> -		return pv;
>>>> +		return 0xFF;
>>>>
>>>> -	return pbuf.eeprom.atom1.data.pstr[6];
>>>> +	return pbuf.eeprom.atom4.data.pcb_revision;
>>>>    }
>>>>
>>>>    u8 get_ddr_size_from_eeprom(void)
>>
> 
> No. I do not want to have to guess what error does "0xFF" have the
> meaning of, it makes the code annoying to read every function header
> documentation to learn this information.
> 
> Since we remove all users of mac_read_from_eeprom() it is certainly not
> a problem we care about now anymore. Default PCB revision in case of
> error may be zero. It is not important to make distinction of additional
> failure detection, this is already resolved by read_eeprom() where any
> error message may be presented to the user.
> 
> I appreciate the effort to be more technically correct and have a unique
> error value but with u8 return value 0xFF it is an additional layer of
> complication not needed. If you insist on this approach then the return
> value should be arbitrarily defined as a compiler macro, say
> CMD_EEPROM_FAIL (255) and consistently used. In fact I would not
> complain if it improved code readability.

There is no necessity to use u8 as the return value. We could also use 
int and return a negative error code (-EIO) on failure.

Best regards

Heinrich

> 
> -E

