Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65D6D711C0
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 16:55:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4882489270;
	Wed, 20 Nov 2024 17:55:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dCACikS+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6B288933D; Wed, 20 Nov 2024 17:55:52 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60E1E8925A
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 17:55:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a9ed0ec0e92so630431766b.0
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 08:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732121750; x=1732726550; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6JO7qr/H97v/ygTJxCjRz309Nrl8YKqgj5vyTyKa2XY=;
 b=dCACikS+QDDNcCjGwxtvAHWCkWa7DKTai9PhLDWO95GCC2IxEizO/eEnDekhOwg+GE
 xVlECHHbDSqDnF/iwDPowjt66ANjTxrmnkLJjAr547DEv/WU9Vhi8Fixi79zx7NOUipn
 Do+yHtea/dndwqdH/6SxcykynWm35BfrMJRE1szgpZsh6Q8tFLd6W5oUkOhSS7QzOVa/
 Svo9/856xMhFDzc2PLwVm8z2xE/JFjjJUabhvj3WGYHu5uzJC+5rpcIIkv94CjnSlZ5B
 VdDLfv27SexttggwcOhJo2/LYiicFo5PoFh7dBh8L4xeppnrXpF4Pl52bHyVcgbxMSwg
 mUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732121750; x=1732726550;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6JO7qr/H97v/ygTJxCjRz309Nrl8YKqgj5vyTyKa2XY=;
 b=inxalDz/PRKnanLmyMwuSkbggDSiF+myt3uQa0UxCic+JAMalJM56mzBuiS42WJJqF
 U3Ln8NO6hVYAzia9oZJSiaSph8tCyhqN9zCN7GF1ELeYOBkOPkTa/VQehgdPqZGhKEIe
 W6nvdl+hHNlHLel5aWJmPr99HVV+T55nQmty8YpwNwCXLBZXkO1oEXktmP9vpRwiOqNZ
 1+VxpNkVa24sGhrX/0K7A+FeBLzauj3fT4KunhGF8mLe4ZjrJNszM5ZJRWGmFCDM2XRH
 +JbIBCM2NwrZEimh2AgsQYum47iQDG6nm1Y1bf0peNZj0hOUh/Kyrw1kwbKYxC5fsZDF
 LGDg==
X-Gm-Message-State: AOJu0Yz29ENqE12OF/NXQBwCsf5yijartParj9ukAzXdFEGaFxpGUV+K
 +pbdbplrMcfIreP0sntIjrjMYpk9xE3D7xwbC13Ur4rnZLrrWA7TU4K8vZNHtws=
X-Google-Smtp-Source: AGHT+IG7P04n1mCouwFovfFBMhwEOeohpn0rCkEvsQ91fS2Xi9pNcb4cWmHcLK5U/DKzWKMy+3PFBA==
X-Received: by 2002:a17:906:6a08:b0:aa4:9ab1:1982 with SMTP id
 a640c23a62f3a-aa4dd548167mr318325866b.4.1732121749860; 
 Wed, 20 Nov 2024 08:55:49 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20e086299sm784919166b.195.2024.11.20.08.55.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2024 08:55:49 -0800 (PST)
Message-ID: <7af74c01-1307-4be1-9603-8902d57d1137@linaro.org>
Date: Wed, 20 Nov 2024 17:55:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] common: Move autoprobe out to board init
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Svyatoslav <clamor95@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>
References: <20241120153642.861633-1-sjg@chromium.org>
 <20241120153642.861633-4-sjg@chromium.org>
 <460f478d-62cc-4f17-8d52-00d2e1e83485@linaro.org>
 <CAFLszTjzZQ=Uaw+wjHUeP86SaHppYBMa3ZPSpFAoBwG9jJfEZw@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszTjzZQ=Uaw+wjHUeP86SaHppYBMa3ZPSpFAoBwG9jJfEZw@mail.gmail.com>
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



On 20/11/2024 17:03, Simon Glass wrote:
> Hi Caleb,
> 
> On Wed, 20 Nov 2024 at 08:51, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> Hi Simon, Marex,
>>
>> On 20/11/2024 16:36, Simon Glass wrote:
>>> Rather than doing autoprobe within the driver model code, move it out to
>>> the board-init code. This makes it clear that it is a separate step from
>>> binding devices.
>>>
>>> For now this is always done twice, before and after relocation, but we
>>> should discuss whether it might be possible to drop the post-relocation
>>> probe.
>>>
>>> For boards with SPL, the autoprobe is still done there as well.
>>>
>>> Note that with this change, autoprobe happens after the
>>> EVT_DM_POST_INIT_R/F events are sent, rather than before.
>>>
>>> Link: https://lore.kernel.org/u-boot/20240626235717.272219-1-marex@denx.de/
>>>
>>> Signed-off-by: Simon Glass <sjg@chromium.org>
>>> ---
>>
>> [...]
>>
>>> +For some platforms, certain devices must be probed to get the platform into
>>> +a working state. To help with this, drivers marked with DM_FLAG_PROBE_AFTER_BIND
>>
>> I've found the documentation around this flag lacking, and the
>> implementation confusing. Here you say /drivers/ with this flag (which
>> would imply I can add it to the U_BOOT_DRIVER() definition, but further
>> below the function doc says /device/ with this flag.
>>
>> In practise, it seems like the flag has to be added to the device in the
>> bind() function, and adding it to the driver definition doesn't work
>> (this left me scrataching my head for a while). The commit message
>> adding it explains this and it seems like the idea was to have a way to
>> trigger probing a device from the .bind() callback.
>>
>> I don't think I'm the only one confused by this, since grepping for it
>> reveals two watchdog drivers which set this on their U_BOOT_DRIVER()
>> definition.
>>
>> I can only see one driver that ever enables this flag conditionally,
>> that's the ARM PSCI driver. Every other user sets it unconditionally in
>> the .bind() callback.
>>
>> Would it make sense to rework this into a driver flag?
>>
>> Otherwise, could you document this behaviour more explicitly in this series?
> 
> I agree with you and I very-much want to document this better.
> 
> The original patch[1] came with no documentation nor tests. It was
> applied within 5 days, after Sean raised exactly the same objections
> that I have with this feature. Those objections were overruled and the
> patch was applied anyway.
> 
> So here I am trying to clean this up.

Ok, good to hear. Then it would be great if at least the comment above
the flag definition could be made more explicit (that it must be applied
to a device not a driver).
> 
> As to the driver thing, my main concern is that it is too easy for
> people to add the flag, causing a large slowdown in U-Boot's
> pre-relocation startup speed. Perhaps the solution to that could be to
> enable bootstage everywhere and report the time in the banner?

I'm not sure what the problem is here. You're worried that people will
set this flag when it isn't needed? This ought to be handled during
review of the driver in question.

Certainly I don't think making features more obscure will point people
towards better solution, more likely they'll just get frustrated,
particularly when this flag actually IS the correct solution as is the
case for many drivers.

Kind regards,
> 
> Regards,
> Simon
> 
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20220422131555.123598-1-marex@denx.de/

-- 
// Caleb (they/them)

