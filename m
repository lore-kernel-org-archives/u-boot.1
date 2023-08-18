Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0D0EE4980
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 17:32:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1F3586E52;
	Fri, 18 Aug 2023 19:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f/CzhvNB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D884986E56; Fri, 18 Aug 2023 19:32:42 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05ECE86E45
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 19:32:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-26d4264493bso731146a91.0
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 10:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692379958; x=1692984758;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KjcS+5JsxAOzQDw8ZN/IE2a9uvZ/B0f6PbvVnlbL7I8=;
 b=f/CzhvNBfbBGb7Xk3JbcKcKTmWwaZva0gFxOG9KD4BrdNIcUXUNYkgVgepZzcvkONJ
 ZEYNFIN1GsYlmT/KEItH+cLZ5lyWOaQhfRhlhuJjYZIBtvmmbHcQsRMLt9KYCMSwMibg
 iAjcPzPOFWLgXEZel9+Uzld5KucmVl/KjiayJN0t/lbgmPHUwlm8gDZ93AJaih1lEg0P
 i1yklTmroaCexdQ7gQISsRyQazMnAVt4xChBijqNNRa2GEYtxLlH4Go1x699P7GUWzvc
 wdlHukB3PdzhnVBcZ5IbB3BF5NRZk7mGUPTdSPN5VEejEB/F1WpS9ucrq6socAqQC4m+
 uqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692379958; x=1692984758;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KjcS+5JsxAOzQDw8ZN/IE2a9uvZ/B0f6PbvVnlbL7I8=;
 b=KLZl7o6bWYWc4r4ll/goV/YfUFPlgfo3D9B/MB4XGA18xTXkbcTj9Cf58PF/iw31gU
 D+710tLMEg3LTMKHBI0qNDAkInVl+jvevKgjiX+5hY+HIPfGjd4adk4m2ta8O33VXbOE
 4jsK1lhMGP2jgFVrrSguBM1bQbqTfFlpy3eY5yTTRHmRZizqOUbSgOdjkaornWsaOk4P
 QGIrcAszjgLOH4jhzT/8o6o7wp4rJwc2eEyltqQzYWXx4r86uVAumRfHcyoKEylGuxoP
 oMuJbxAvklHzyjZAnEm5JYUicaeAICFhaJp+z/2UGxKDrVM+6TVmlEaQolcYZDbUy9kU
 fvxA==
X-Gm-Message-State: AOJu0YwT3rveeCYJmrGZDW9cDePbrwfSBlBmCTVVPMQLEhBT0G2ValPj
 GyPhXktl8ZQPJUqTIRSUYDA=
X-Google-Smtp-Source: AGHT+IHaj5Du6ZcW8Eu/r2gplJcv7FvDroX/FObb812TMDm6HogndWUG44vjyU5tqs58kg1L6qBXJQ==
X-Received: by 2002:a17:90a:974b:b0:26d:1efe:95bf with SMTP id
 i11-20020a17090a974b00b0026d1efe95bfmr3116193pjw.39.1692379958022; 
 Fri, 18 Aug 2023 10:32:38 -0700 (PDT)
Received: from [10.64.107.252] (static-198-54-134-172.cust.tzulo.com.
 [198.54.134.172]) by smtp.gmail.com with ESMTPSA id
 gj3-20020a17090b108300b0025bfda134ccsm1827549pjb.16.2023.08.18.10.32.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Aug 2023 10:32:37 -0700 (PDT)
Message-ID: <ac2afdc8-b81d-7888-b949-4a69d9fd075a@gmail.com>
Date: Fri, 18 Aug 2023 10:32:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/5] sunxi: psci: refactor register access to separate
 functions
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maksim Kiselev <bigunclemax@gmail.com>
References: <20230816173420.83232-1-CFSworks@gmail.com>
 <20230816173420.83232-3-CFSworks@gmail.com>
 <20230818155753.388aa967@donnerap.manchester.arm.com>
From: Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <20230818155753.388aa967@donnerap.manchester.arm.com>
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

On 8/18/23 07:57, Andre Przywara wrote:
> On Wed, 16 Aug 2023 10:34:17 -0700
> Sam Edwards <cfsworks@gmail.com> wrote:
> 
> Hi Sam,

Likewise Andre,

>> -static void __secure sunxi_set_entry_address(void *entry)
>> +static void __secure sunxi_cpu_set_entry(int __always_unused cpu, void *entry)
> 
> So what is the reasoning behind this change?

The primary reason is to be consistent with every other sunxi_cpu_* 
function, while the *tertiary* reason is that it was useful to have that 
argument preserved in a debug build, so that when I was tracing 
execution I could be *sure* that the correct CPU was being chosen (this 
was before I found out that the GIC400 base was being determined 
incorrectly). As for the secondary reason...

> If *none* of the Allwinner SoCs have independent secondary entry point
> registers, we should not give the impression some do in the prototype.
> Should later a SoC emerge that changes this, adjusting this one is the
> least of our problems then.

Ah, but the T113 is already such an SoC. From the user manual:
- The Soft Entry Address Register of CPU0 is 0x070005C4.
- The Soft Entry Address Register of CPU1 is 0x070005C8.

...so my second reason for the function prototype being the way it is 
(and perhaps something which I should be driving home in patch 4/5) is 
indeed to give that impression: that it is *not* the case that none of 
the sunxis have independent secondary entry point registers.

>> +void __secure sunxi_cpu_power_off(u32 cpuid)
> 
> Can you please mark this as static on the way? That does not seem to be
> used anywhere, and even the name suggests it's local.
> Saves 8 bytes of .text ;-)

Easy enough, it shall be done!

Thanks,
Sam
