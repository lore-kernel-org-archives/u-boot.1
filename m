Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6E0E7F14F
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 23:32:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D3EC86DDB;
	Thu, 28 Sep 2023 01:32:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TLwjsYPc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40CA986DDE; Thu, 28 Sep 2023 01:32:11 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12C5186A24
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 01:32:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-79fe99a5f29so115637439f.1
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 16:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695857527; x=1696462327; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1tAJWWKm8HcGBOJK7dYcDJJeAT5HV3BW9/FCQXPkS3s=;
 b=TLwjsYPcSfC2ykpwlZKJM/taAF1bHAYAuNo4Wn3KQK44lX4SwVsq5FQ068QmGfNsPS
 nQEq5hemu2I3JVLLURwJpTDeXwNWJOPNZiave6eP2KWHZvSJb/9aG/21BA/DsnbZUQ34
 VL1ExNUYY2sdDa1Z5O4DsFHik2U5lodnleRUGZ41m/Cz10nYZaDhRvXS2tD660rADfIR
 OUWXyPymXZJ+Y4uxU9xAYEN/zt8cN1wi5QWkGfWY+msKNHSHhQe+6Y0THH9kaeVU5JxY
 B42m22ygRSH8CcZOz5UpWfiVAA3Yn3473utw1AepS8kuVHklONaDQLMawF1rB67pjl34
 efSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695857527; x=1696462327;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1tAJWWKm8HcGBOJK7dYcDJJeAT5HV3BW9/FCQXPkS3s=;
 b=GLLi1kb+F9d2z8a7GzUs/Z2mLSN74gM1b4q4NfBWccGCmXiDKZBDJilCo7KIPu4tyg
 ZxTndKZVfwotExB3MdUGNEYyv8o5ATB3hbe/WWwDX6TEFBhG34LqvW/R2TD8GMa05lSM
 llw03i9obpZmzzBsAcQHOQ1c26R+HmC8sBtcHmkH1jeq+CqCI+CW/UqARYmNnAebVxF/
 p8Sq5jYCY3lHRzz5zIIJmmlGS5XdRF1ZgXe1QLYFtKKLAaJK6ndOGSFpz61X3nEREntr
 JIe5v65z2nQAXjz6PHXYflKNc6lSVntXLJ8DKqskJucbb8RNwzBKRFZ5gV2gb5gG/UTg
 bGiA==
X-Gm-Message-State: AOJu0YxvxS7BQ55fhBYZPAWRDPIzLYAaJLwGV0VT0ZhcIHRNp9/CTsuC
 WO0c8RBGGQEkl3MPCruVy6o=
X-Google-Smtp-Source: AGHT+IE/hoL+1XlDgg9Vkr7ffyoHkHTF6vVYqQDhHIUHA9Cx5Gj/Ffzf63qo43z2EceylvKeE3jtow==
X-Received: by 2002:a5e:8f41:0:b0:786:f4a0:d37e with SMTP id
 x1-20020a5e8f41000000b00786f4a0d37emr3616177iop.4.1695857527620; 
 Wed, 27 Sep 2023 16:32:07 -0700 (PDT)
Received: from ?IPV6:2001:470:42c4:101:e9f:af6b:c19f:be24?
 ([2001:470:42c4:101:e9f:af6b:c19f:be24])
 by smtp.gmail.com with ESMTPSA id
 o16-20020a056638125000b00439c3385402sm4250587jas.149.2023.09.27.16.32.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 16:32:07 -0700 (PDT)
Message-ID: <4cb83200-9652-2f88-f25d-88fc81f11f88@gmail.com>
Date: Wed, 27 Sep 2023 17:32:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/5] sunxi: psci: clean away preprocessor macros
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maksim Kiselev <bigunclemax@gmail.com>
References: <20230816173420.83232-1-CFSworks@gmail.com>
 <20230816173420.83232-2-CFSworks@gmail.com>
 <20230818151103.3fe5a32e@donnerap.manchester.arm.com>
 <ba7bf86f-3f4d-036a-9531-72a97d741f91@gmail.com>
 <00d8e7d3-15a0-20cc-90bd-7a2fbc1867e8@gmail.com>
 <20230927173410.32710be1@donnerap.manchester.arm.com>
From: Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <20230927173410.32710be1@donnerap.manchester.arm.com>
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

On 9/27/23 10:34, Andre Przywara wrote:
>> In the majority of cases, there are no changes to the text section
>> introduced by this patch. In the R40 case, there's a small change where
>> the compiler adds a NULL check onto the result of the `(void *)cpucfg +
>> SUN8I_R40_PWR_CLAMP(cpu)` computation, which we can ignore as it won't
>> affect anything in practice. In the sun7i case, the only changes are
>> because I am NOT hardcoding the CPU to 0, which does look like I broke
>> it (since that means it will use cpu=1). So I'm going to need to fix
>> that in v3.
> 
>        ^^^^^^^
> Do you have an update on this? I will try to test it on an R40 ASAP.

In my (not yet submitted) v3, I have the following change done:

  	if (IS_ENABLED(CONFIG_MACH_SUN7I)) {
  		clamp = &cpucfg->cpu1_pwr_clamp;
  		pwroff = &cpucfg->cpu1_pwroff;
+		cpu = 0;
  	} else if (IS_ENABLED(CONFIG_MACH_SUN8I_R40)) {

That does negate any binary change in the SUN7I case. R40 is the only 
one that needs testing still. If you feel like testing on any SUN7Is 
just for good measure, you'll want to add in that missing line.

> Cheers,
> Andre

Likewise,
Sam
