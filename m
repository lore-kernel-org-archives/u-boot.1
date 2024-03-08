Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF95C5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 03:38:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EC1D87E2A;
	Fri,  8 Mar 2024 04:38:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="rXtzwZeT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACC5987E0C; Fri,  8 Mar 2024 04:38:17 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C361F87150
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 04:38:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2C5423F6B1
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 03:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1709869094;
 bh=X4H9c3mzDdWrsDDTA14L2ZMbcfDpfrPujRGF+0PTgq0=;
 h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
 In-Reply-To:Content-Type;
 b=rXtzwZeTwv/ZuzvNt28Fw+WjpPisHmDUYlkXIEEDULx1G0NVsGHa13ZbRgnl08Ekq
 syqDOW1GkuERLajHwdw+zY+i9QvlO3BPzm6a0jdXK2CxehrC82ECmKDqh+9IAWT/x6
 q6RP0jYBhoWvfEJhy6+2i2MyxikP0xNlpmMvO3RwIpcYkjWglb6qswHpvuPEP5wBm0
 kh4Iunoi8JSUvVn1AG2UCBvgtvuSpFx+sOHYP2dHx0MUhPf6HwuUucF7TwqGNWsuNq
 D3zFNE84XFWlZxFDf/5ijyEAF04nuGOH2lfWuXEGLbzNse1bl+S7iZ/odGt/HQ7Mpp
 O/kss8aUk5GJA==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33e78c1b314so1313f8f.3
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 19:38:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709869094; x=1710473894;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X4H9c3mzDdWrsDDTA14L2ZMbcfDpfrPujRGF+0PTgq0=;
 b=roUvCQABuzLUf5dnrMswnwahUZETLqNNZRYRZbiVIBN5kEC2p+aoOf8pfDpJEzTU4s
 Nh+meDOCN6i+ELhjyee98IwPPOZNC5HObS1vDxRCiXzWiJi7ffbqCeXj+OIOl5aeg+dO
 bIG3lG9WLrMpC6vRZi/6ckivPgY2nzXrO8AWPK1E7eFkUNsuFXhCcNvR1rN0sdCS2nK2
 llzTF5xeqf/Lp5/c2BBbDa+kW4OeyJtZwTAlPI/WLL2VPG5YGtikSPp5jgfXNbFfTgH8
 wGJbqFvrnxpgXUqRYGjgM5qsrb+jdBe4m41JdTTpj72MILizJWCZSxWiCfDFbGCAUl1w
 mJCA==
X-Gm-Message-State: AOJu0Yw6qd9qjNct4ggpzbWb5DNgsTRVi/56ALcOHNKgn08uGKrblnoY
 KqgFWLlJYU4QUUiQvUQOdBbSJlwWYuvi3EuCV6UTEvQnNQOvh72wQZB0QhZX8+Qv2dAe/IHfoSB
 17CaSJ37IwMftceC7xS5w2GkjXHKO8NDAsv8S2M/K+LYO0HL/Sp0IpTM91FPgL4U9ROg=
X-Received: by 2002:a5d:49c3:0:b0:33e:6fd3:7366 with SMTP id
 t3-20020a5d49c3000000b0033e6fd37366mr1614003wrs.68.1709869093754; 
 Thu, 07 Mar 2024 19:38:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5nDfX4mQasmzj4IydEaTtL2qdD8aRCfJ5VDvPLFWBx04sjkvJfhm1NqvoWeuomrD/24PFVg==
X-Received: by 2002:a5d:49c3:0:b0:33e:6fd3:7366 with SMTP id
 t3-20020a5d49c3000000b0033e6fd37366mr1613996wrs.68.1709869093401; 
 Thu, 07 Mar 2024 19:38:13 -0800 (PST)
Received: from ?IPV6:2a00:20:9:393f:4294:78eb:608e:9569?
 ([2a00:20:9:393f:4294:78eb:608e:9569])
 by smtp.gmail.com with ESMTPSA id
 bw1-20020a0560001f8100b0033d6bc17d0esm22245272wrb.74.2024.03.07.19.38.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 19:38:12 -0800 (PST)
Message-ID: <b2191232-b59c-4a9e-bafa-4e1bbe382375@canonical.com>
Date: Fri, 8 Mar 2024 04:38:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/5] board: starfive: support Milk-V Mars board
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: E Shattow <lucent@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240303130122.29983-1-heinrich.schuchardt@canonical.com>
 <20240303130122.29983-4-heinrich.schuchardt@canonical.com>
 <CANV2PTMcS800x8OTuDbv8orqUD=-frNpa+0dHu4=L__D_Rmk_g@mail.gmail.com>
 <CANV2PTMtPggmS0hxxuovDfUnSAGM7tDXSewQ-eRTmd_+xR_L-g@mail.gmail.com>
 <f76541f4-503f-432f-9cfe-a74b78523c3b@canonical.com>
In-Reply-To: <f76541f4-503f-432f-9cfe-a74b78523c3b@canonical.com>
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

On 3/8/24 04:20, Heinrich Schuchardt wrote:
> On 3/8/24 03:06, E Shattow wrote:
>> P.S. Found the longer description at 
>> https://github.com/milkv-mars/mars-buildroot-sdk/commit/d381610c92827de01b25843786012351b3f35519 <https://github.com/milkv-mars/mars-buildroot-sdk/commit/d381610c92827de01b25843786012351b3f35519> as follows: "if configured as 24c04, its address will occupy 0x51, conflicting with the RTC chip pcf85063 on the IO-Board. Refer to: Documentation/misc-devices/eeprom.rst". What does that even mean, it is for Raspberry Pi Compute IO carrier only?
> 
> According to
> https://ww1.microchip.com/downloads/en/devicedoc/doc0180.pdf
> the chips differ in how their address lines are used. Either they select 
> a chip or a memory address.
> 
> The chip is at reg 0x50. So it could be that if you read the upper 
> memory of atmel,24c04 it would use reg 0x51.
> 
> https://datasheets.raspberrypi.com/cm4io/cm4io-datasheet.pdf says the 
> CM4IO board has an RTC at address 0x51.
> 
> Together with the commit message this really sounds like the smaller 
> chip size is faked due to incompatibility.

Running i2cdetect on my Mars Milk-V board shows that a device is 
responding to address 0x51:

$ sudo i2cdetect 5
I will probe file /dev/i2c-5.
I will probe address range 0x08-0x77.
Continue? [Y/n] y
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:
10:
20:
30: -- -- -- -- -- -- UU --
40:
50: 50 51 -- -- -- -- -- -- -- -- -- -- -- -- -- --
60:
70:

> 
> As you mentioned to have access to a CM module I would like to know what 
> its serial number looks like to understand what if it can be used to 
> detect if we are running U-Boot on full board or a CM module.
> 
> For my Milk-V board I have:
> 
> MARS-V11-2340-D008E000-xxxxxxxx
> 
> Best regards
> 
> Heinrich
> 
> 
> 
> 
> 
> 
> 

