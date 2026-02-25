Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2E9FD374D
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 12:21:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE92783642;
	Wed, 25 Feb 2026 13:21:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="KQvqLBpW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 574828366F; Wed, 25 Feb 2026 13:21:13 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E2CD8003E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 13:21:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 057A13FB89
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 12:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772022071;
 bh=blwVU64SNeG3eyozVZW0wbgNQXYARd+LlR3Lmx185hw=;
 h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
 In-Reply-To:Content-Type;
 b=KQvqLBpWH4MABQKFYPvm+qrw5ByzUsLsZNq+51pN98dA8Ex/yMtm3QNUUfPEXdecI
 bnn8rHdZ1JqLljCtCRrcIVX4d4GkjXHhezdZFvhzNTa7kBPAUgv8O6Nf8u4O16nLMK
 w1buBFVVTskx0PxLEuY8ICQLt3cMNqp+KhE5xXVkpz+1wQ0c4EhJpXenxYJSDqtR3L
 8cPNcJpKq6DSr8ZDgsNRV2K3ZY5Fs4o9WBv32Jwkdexk8RaT+85zUqnTAt43tn3j8d
 Ne4g3q1tJ4HPUh/0bSg18uBnsIlv9GFu3nwpGl+uKrh49z6TBRUsvpRyS6fU/oVW0X
 glm29US+42ziXjEgGICtjX6AOj20Kynb3L7lZyh0O7mSEkgLMZn28RE/hA9fBjj9fa
 4htsdr2xfJiLJ2Jy+RhfKEkhWjB1siFkJlbFg3nhTzdhJOuPyL7P3KOChCCecgrWnO
 tollFbekQXU8Ni1r4ecUZRpxNAVgnX94SyQ1FwcNuBqR7pKv7dM6jEj/gX6nh8cfaj
 Sq6SMCYJbdM3FvZ/NP8VhoR8BVwHkYO5KFyxUci628c9d7zrjldKOM841BPbhMgCpI
 RWbsXfutJ0rtl/A0YcNrp9dOkP+J7j3YG+PNrBeTh7crL6+Z9BwVYm9/JoiGF1i1cK
 CKe3yccX2kDXxAqz/cyNsJxU=
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4376c206493so6671804f8f.0
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 04:21:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772022070; x=1772626870;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=blwVU64SNeG3eyozVZW0wbgNQXYARd+LlR3Lmx185hw=;
 b=VqI0+lhYKSVTcneBXboXEem2hNUIdMJgQtFMf9VFvKAKJiPTE06Cj02iW8EtdcL1UJ
 1xZs+9VVP/yZ4Yng6vbnwurcrS8BgpLSrjBeGbMehsBpASYxUvN3iOQn5KScMhPmywtx
 qBW2z4r3YGcQXzPzOoWCeX5srGt7N862iiMhqDD/XlxE+jq1r/xBUlyL55Ixy2LZ/v1f
 rpdtfJ+FzLnJKbt0b/kwHpLOQE0zzxw+JgL9Z4q2FUBtzIsPi2lcJdwBljIHHUpbyhTw
 aW2LkPw/hK1MkwFzCbols3mn0c3tfb6PDmR40NWNZisPZP1yPbnVLdDLIeyaS9oFROa2
 U9eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGF6y/EdeUxMUjuMP6RYkHa6DO4Jklx9V585uQUuFUcgXaX2Dg3FEa7sjYqafVQeQ40MwcG6E=@lists.denx.de
X-Gm-Message-State: AOJu0YxNdxSRmmhR04Eac8XymxH+5mVCSbKYYbO7AW2Eim7G9iMEUT59
 /e3jmd6itZXhL7syQOC+l1scQ9f3gpmfb4G1pytXrxTAneBcJ8EYvNYd75mrzy0/g+Mp56GgUVL
 xE96FisqZYqrm9zWKcVCx8W5EHp7rn+29v26AMhI0luajDZvbgfE8TmoiM6Eekz7ipc3QNDk=
X-Gm-Gg: ATEYQzxJGLusnQNO67mZCDfa89mrsY5AxjICVamQAa9eKbhSkeYcn4Z/C7JaSwHUihB
 T+Cs2Zh/X8iejF6CI+6XY+pBHSUEht9hP3JWFNnMKq2CJvbu/U0llEpgA+lWDnQ+2y73BR2GUd5
 IAAobnV5Zqq8C9o3WiZuhQEMLlo3WTJ02+2et00TljLUQAAm74POMLB1ELO2lroxIttsvolrfGG
 0lxC/tpA/F9QZxAy7XMdyZG7sqtXhPgXxruyAdhwVseNSB2uy8yvTtkkKDb92tVFa+1ABLAEj2d
 cTh/JUyZprWzAHq+AREpJZVjWph2+XtzAvYl86j3FsHqBqEiWSQxsvqPzTTOHXI+gBrtBeLwHS9
 iRH4Qy+jX/z5Wjppz6jr5QrKrytT/z6G+3Uk38/xGuzu92jGfMGdTMYJgaa+emp+EtmFVK/d8jP
 ld+frozH95cwBjiU7B9wyE/BlsU91pe/ToxbnGuU6F4tYaOeUudw0=
X-Received: by 2002:a05:6000:2881:b0:439:9282:e71d with SMTP id
 ffacd0b85a97d-43994294d13mr526171f8f.7.1772022070402; 
 Wed, 25 Feb 2026 04:21:10 -0800 (PST)
X-Received: by 2002:a05:6000:2881:b0:439:9282:e71d with SMTP id
 ffacd0b85a97d-43994294d13mr526129f8f.7.1772022069993; 
 Wed, 25 Feb 2026 04:21:09 -0800 (PST)
Received: from [192.168.103.130]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970bf9feasm33611414f8f.6.2026.02.25.04.21.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 04:21:09 -0800 (PST)
Message-ID: <d00103df-8188-4039-b618-dc48ab1c1a39@canonical.com>
Date: Wed, 25 Feb 2026 13:21:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] boot: don't select non-existent CONFIG_VPL_CRYPTO
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 George Chan <gchan9527@gmail.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, u-boot@lists.denx.de
References: <20260225073711.51688-1-heinrich.schuchardt@canonical.com>
 <ee169196-69a3-4003-8531-0ffa4e76bf6b@cherry.de>
 <e9d98d0b-578a-41ef-9440-00ea615d224d@canonical.com>
Content-Language: en-US
In-Reply-To: <e9d98d0b-578a-41ef-9440-00ea615d224d@canonical.com>
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

On 2/25/26 10:06, Heinrich Schuchardt wrote:
> On 2/25/26 09:37, Quentin Schulz wrote:
>> Hi Heinrich,
>>
>> On 2/25/26 8:37 AM, Heinrich Schuchardt wrote:
>>> Symbol CONFIG_VPL_CRYPTO does not exist.
>>
>> Correct but I have a hunch this was based off of SPL_FIT_SIGNATURE 
>> which does require crypto support, so I'm assuming VPL would too.
>>
>> But this symbol indeed never existed, and even if it did, it wouldn't 
>> compile anything else as far as I can tell since drivers/crypto is 
>> enabled by default in proper and only if CONFIG_SPL_CRYPTO is set for 
>> SPL, and only SPL (checking for !TPL and !VPL)... so something feels 
>> unfinished with VPL here to me.
>>
>> I'm not sure we're improving anything there but I don't think it makes 
>> things worse, as such
>>
>> Fixes: 4218456b3fac ("vbe: Add Kconfig options for VPL")
>>
>> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> Thanks!
>> Quentin
> 
> Thank you for reviewing.
> 
> There is a symbol CONFIG_VPL_MBEDTLS_LIB_CRYPTO that might be used but 
> then VPL_FIT_SIGNATURE support would have to depend on MBEDTLS.
> 
> Maybe Simon can inform us what his design intention was. Adding a 
> defconfig actually testing VPL_FIT_SIGNATURE would be helpful.
> 
> Best regards
> 
> Heinrich

There are more non-existent symbols implied by VPL_FIT_SIGNATURE

         imply VPL_RSA
         imply VPL_RSA_VERIFY

@Tom
I wonder why the VPL feature was suggested if it was never tested or 
used. Should we remove all of VPL?

Best regards

Heinrich
