Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E7FEE4998
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 22:22:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31956869B9;
	Sat, 19 Aug 2023 00:22:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="USoMaaN8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64BF3869BC; Sat, 19 Aug 2023 00:22:37 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88F74869B5
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 00:22:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-68874269df4so1197980b3a.2
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 15:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692397353; x=1693002153;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hm/pEBQ3pzpEk8IwkrvkJZsxt2TcTrvYGwRpvT1Cn4Y=;
 b=USoMaaN8vK8XpzgW/CtI9Q9oQO44F+ZZM/suteG/u8Smenbm870SsI/bQiCg6iwBy3
 D/mI1FaXeTJyWpTpgaQdUDid29DUXYC6o370oUji48tay1+MPQrtz7wQ/Lw5L1Ox1EPE
 x00sjn1fblMAvVPAKuwT7OPTbf/OvQs5F171B7UMsRED9AnWCsyBdM2QmgnSAYwwlZgV
 efMzt0DuBrtj/AotK8cIL1+lQZ+w/seDt9E6d4FLLUFIN6LeGJUye1SUxfxJuISzc7Ab
 kzvZ9Lh6R/oVgGO4JJn6/z31ltp3TH5zqICWwWa9Y0QJzdmLvUxCxAwTy+pz1+NtmYgH
 yIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692397353; x=1693002153;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hm/pEBQ3pzpEk8IwkrvkJZsxt2TcTrvYGwRpvT1Cn4Y=;
 b=OSyP+cxTUjLRght+7Dr6kkrmAdPBEPIBeT9fcItxTHMxRckKjoRcyQ6EHVxXBe3QgD
 u11D3J2683PQWzXdOyTFTmzruJqtZI+zS4xsK+9jd0GwRW3/rUz6dBEKoxSrGPtxdQm0
 aFju1K9mjK19QauMiK+W/SBC7W6O4jfnd3nM7oC+eHH+x7uHI5FMYij470NIQLMh8048
 4RTmdK4Ucf4u3/Q1qbPNbEAV/d/1lAzNX3odp+cYcxWTN296dqd6ROCrq7xEDyEiPbIy
 2g+PDKom4hC5R/lLox7TctUR4THjHrSPC0BFqLtdaSQtzQUYazdXAnXN6AN4Y7JQtfIS
 ORhA==
X-Gm-Message-State: AOJu0YwNQDn4jo179pddsuYUwxfoUhuAS+LQmZ0S0W5MSktWXdiDiqJA
 iMzJ1nf7ATIWPcom2JnDxfQ=
X-Google-Smtp-Source: AGHT+IEkD2m9ejCmwsNCFopqA58YRGGZ0Pni5oNFN4on/dfaUOJY1zyIiR4kY80u7MHlcdSz3OglZw==
X-Received: by 2002:a05:6a00:80c:b0:687:6184:deed with SMTP id
 m12-20020a056a00080c00b006876184deedmr623253pfk.22.1692397352764; 
 Fri, 18 Aug 2023 15:22:32 -0700 (PDT)
Received: from [10.64.107.252] (static-198-54-134-172.cust.tzulo.com.
 [198.54.134.172]) by smtp.gmail.com with ESMTPSA id
 j3-20020a62e903000000b006879493aca0sm1996179pfh.26.2023.08.18.15.22.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Aug 2023 15:22:32 -0700 (PDT)
Message-ID: <f3121fa3-d63d-d12a-d1af-4c727e480b00@gmail.com>
Date: Fri, 18 Aug 2023 15:22:30 -0700
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
 <1522f5e0-bdf6-cff6-3300-2bcbc3853457@gmail.com>
 <20230818152728.49dd6e4f@donnerap.manchester.arm.com>
From: Sam Edwards <cfsworks@gmail.com>
In-Reply-To: <20230818152728.49dd6e4f@donnerap.manchester.arm.com>
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

On 8/18/23 07:27, Andre Przywara wrote:

Hi Andre,

> So instead of trying to derive some pattern from where there is none, I'd
> rather do: config SUNXI_CPU_HOTPLUG_ADDRESS
> 	hex
> 	default 0x01c000bc if MACH_SUN8I_R40

But the hotplug flag register is at 0x01c000b8 for R40?

> 	....
> 	default 0x01c25da4
> and then use that symbol in both places (v7 PSCI + v8 FEL).
> As mentioned, I can fix the pieces that break when naively doing so in the
> FEL code. That has also the rewarding property of allowing to remove both
> SUNXI_R_CPUCFG_BASE and SUNXI_RTC_BASE from the code base completely.

I might hold on to SUNXI_RTC_BASE for a bit, since the SPL may need it 
for the various reset-to-FEL mechanisms. I still want a nice way of 
getting mainline U-Boot to do this in the near term.

> What do you think?

I don't think this really solves your underlying grievance, since 
various sunxis need distinct offsets to jump from the hotplug address 
register to the secondary CPU soft entry point:

CONFIG_SUNXI_CPU_HOTPLUG_ADDRESS + 4 // for R40
CONFIG_SUNXI_CPU_HOTPLUG_ADDRESS + 8 // for R528

...at which point we're back to the "Kconfig symbol is really pointing 
to a sort of control block" idea.

We could take advantage of the fact that ARMv7 psci.c and ARMv8 
fel_utils.S are never both built and call it something horrible like 
"SUNXI_CPU_HOTPLUG_OR_SOFT_ENTRY_ADDR" but then it wouldn't be clear 
from a glance *which* it is. We could go with *two* (three, if we need 
R528's CPU0 entry for a reset-to-FEL mechanism) Kconfig symbols, but 
that's a lot for configuration symbols that are really only needed in 
pretty much one place each.

> 
> Cheers,
> Andre

Likewise,
Sam
