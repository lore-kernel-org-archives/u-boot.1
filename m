Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0C5C001B0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 01:48:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A07E8679B;
	Wed, 16 Aug 2023 03:48:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QyhxRcI5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 996758697E; Wed, 16 Aug 2023 03:48:56 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3BBA8671F
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 03:48:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-686f94328a4so4067234b3a.0
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 18:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692150532; x=1692755332;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qyR8YnY7wdXR0PjcTNPB224pOdFCoOmuWGuWGyaENLQ=;
 b=QyhxRcI5mb7bpRzu26GscXbwuHCNplQiDDnDiaHGoU4+jfNzaVVy/qxJ+Rnnau8ukB
 PIUr3p3HKksmKcMFsCFBoozIAHpQPBdOND5Q5QCPEVLc8OBsJH2xbOq0xomJZiktOmE9
 Zi16H1tv1oysSn+PE0uwbTNY0WBsst+187Wy6outHyNaiMXzxaCJoo1ax3Frsv+HsdNu
 KOgbna8YoEzfyRlMovXKeiJJFIjcTiakPkXmAnm5E52lJBMUu55vIyyI1C5jV4QJv0Hh
 VdtqW2V2m9eNwJ0Xdf5XEXhOr4k5CZ76CABNbUgDbltev+HOgZu5dq3JZudlwrrKyJXw
 WjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692150532; x=1692755332;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qyR8YnY7wdXR0PjcTNPB224pOdFCoOmuWGuWGyaENLQ=;
 b=Qg7BF4uVAks+sC5ThVTKyw0Vq3ae/yuw05ZFYvHRNQwFWsUrAOUvVb/8jRwONh4k4b
 ESQR3QmnwHxmNNnZkDgVR8qSO2h4Mo4lpnU0A5F/FmuW+t5vdr4I5dV8rusPY54y3adK
 wAZzpexdtPfnt+ZReDj98Wb/Jmj9U25bdFayW93GGuRC4/IHvwrC2Tz8iDwQu2/1+eYJ
 q1sB7sArrsF12ui+MRbV7oTr7c89HfZV/2S30Ig+SxQ0Cunom78RuZaoeXxUOFNIjB9b
 yvBIet4hgpfeU2FlW7RINLvtvCxGsaahyhfGk7YLfhw1wrKw1sAKIR5yNrwbo4RY8CJ5
 HhvQ==
X-Gm-Message-State: AOJu0Yw8IwhfuvxaESbwJiA0w5KbncPyH8ULTEsnCcwwZ0KTtz8iQwHI
 ve5MFbODDL2jxnrOycBURZE=
X-Google-Smtp-Source: AGHT+IH3EGf3R912E9ZgNE1TflZMbZJe1uXMxgFcXTY1ra4mHWJbM8o5FA6NF5KU/a/34edarYYn+Q==
X-Received: by 2002:a05:6a20:2444:b0:13a:dd47:c31a with SMTP id
 t4-20020a056a20244400b0013add47c31amr4474081pzc.20.1692150531786; 
 Tue, 15 Aug 2023 18:48:51 -0700 (PDT)
Received: from [10.64.107.252] (static-198-54-134-172.cust.tzulo.com.
 [198.54.134.172]) by smtp.gmail.com with ESMTPSA id
 i1-20020a639d01000000b00565d46c5ca2sm2330428pgd.27.2023.08.15.18.48.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Aug 2023 18:48:51 -0700 (PDT)
Message-ID: <1522f5e0-bdf6-cff6-3300-2bcbc3853457@gmail.com>
Date: Tue, 15 Aug 2023 18:48:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] sunxi: psci: implement PSCI on R528
Content-Language: en-US
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maksim Kiselev <bigunclemax@gmail.com>
References: <20230812003055.74527-1-CFSworks@gmail.com>
 <20230812003055.74527-4-CFSworks@gmail.com>
 <20230814151642.6f47f6b5@donnerap.manchester.arm.com>
 <225be7f9-558e-4695-0b38-b30b0229cdcd@gmail.com>
 <20230815235946.0c8b0dce@slackpad.lan>
From: Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <20230815235946.0c8b0dce@slackpad.lan>
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

On 8/15/23 15:59, Andre Przywara wrote:
> Hi Sam,

Hi Andre,

> So that's a bit more nasty indeed. I don't even know if R_CPUCFG really
> makes sense here, as the _R_ term typically refers to the management
> processor, which the D1/R528 don't have. Or at least the always-on power
> domain, but then again this hardly relates to the secondary entry
> point. I think the name was just used because the address matches the
> one used in the H6.

Oh, no. That was my doing (and my reasoning) by suggesting that for 
inclusion in your series. Yours is good reasoning to be rid of it.

> So taking a step back, I wonder if we should actually just define a
> CONFIG_SUNXI_CPU_SOFT_ENTRY (or so) *Kconfig* symbol, which holds that
> address, and let the per-SoC definition be solved in Kconfig instead.
> Because SUNXI_R_CPUCFG_BASE and also SUNXI_RTC_BASE seem to be just
> used as the base address for that purpose, with some magic offset
> added, across all of U-Boot (ARMv8 FEL and v7 PSCI).

Mmh, since this is a block of soft registers for managing several 
functions of both cores, I think I'd rather point to the base of the 
block and still use an offset to get to the specific soft register. 
Allwinner may keep this layout for a 4-core chip in the near future or 
U-Boot may want to add code that sets the CPU0 hotplug flag, for example.

I'm not unwilling to do the Kconfig route, but just out of curiosity, 
what would your fallback plan be?

> So can you try to work on that base? I will take care of
> armv8/fel_utils.S, which uses some post-increment assembly trick to
> keep the code small, which wouldn't work anymore. But I have an idea
> how to solve this.

Before that, I think now might be a good time for me to send in the v2 
that I have so far; I doubt the final patch of my v2 series will pass 
review, but I'd like to keep us synced up (and clear away any patches in 
that series that do pass review off from my mental desktop).

> Cheers,
> Andre

Likewise,
Sam
