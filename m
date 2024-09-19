Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E740CF3962
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 17:37:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7DE38929E;
	Thu, 19 Sep 2024 19:37:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="bLPvtUwb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9BB4892B8; Thu, 19 Sep 2024 19:37:01 +0200 (CEST)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 934EE891DF
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 19:36:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-42cb8dac900so10278255e9.3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 10:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1726767418; x=1727372218; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=EUheScEdsrvB675mdKCA7KeQMkTpJHqb0dQvgbNO+RY=;
 b=bLPvtUwbLoNmAaQW8YsDa+ir0QdxYtXUYxPTiMIu2DieC1hLcStHGGm+MJ9amKoRYp
 e+0YfKwMDeNa9vdzMl2KG1PwRl9nKkA0FegXeIrkKQ0vrHamGXoLAjSfd67qZYMGjyOc
 LIk9wK/U9M/L36cY9hLXeSBQu4OXGxKF2v2Vrs43Ql8bNNP4gU/+NWjE6mVb/f5S99dR
 saUU4x0IVeyKQcbqNcHZjH0YJMPRKLJwqGKIVa4tSN7kAnft+2Lo3xj2UZjimPWAu25H
 aVP11HTcE/E0PfRXWNokwPEC5bQ7GXrSiFmR1WMBoNNrrZQVax3ifaCW8hc/OYDm58jN
 5yYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726767418; x=1727372218;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EUheScEdsrvB675mdKCA7KeQMkTpJHqb0dQvgbNO+RY=;
 b=AYMRRifOddiwmY5sWpvcVTf244AmfkPjTYrWONb4q9KaJOO4nPA2pVp0qI1UOEuZO5
 sp/+f1mQ4AI4MAy63UvJQggt2rep8kZ3Hv7gybZl5xCWrtvQU4oI8o6+IcgmHSeMhwjC
 IYwHaMlz1XOF/UlPT/6oM8XUNG0OOxNdOLnfEj69oQdbL7bkG2ev2YaVezaAQonOhNDn
 Ls7JhOiOtNecxxdfqCpDaDIcbVOPFIzx2uJOq7X6duT4bJlKcd5IjoeNMPffQVvJm12K
 06gEJhCST0q/RtTQq7dt6y9m9rEAtoy0AB5Su96JrnGXjBEqMlWU5X1fVfw+Ob5bX293
 sxSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4Kn/3l6UOKI1bqTBGiuopwmwzAkt6Fs5rSFPKR3MdGtq4pWoOI0z/gzV6yY4vQ9zfdYq9jCs=@lists.denx.de
X-Gm-Message-State: AOJu0YxZLJKsdHHXQgXsvHJNzJOY1IQ7u+7Xf0KZ19YE+hYr8we2d9at
 1o2uZrWV8UZA1YKiCvCbsQ+0rwNWvpn/1kXrl+gYJadH3z2MYp5L61311S7ssEs=
X-Google-Smtp-Source: AGHT+IEVqYA1EUf2F21ieryjDlIqdT38hBVosVEmCfFP2cNyOQ1Q/dMuXmInG60AJYNZ/QtoRkXAOQ==
X-Received: by 2002:a05:600c:35cf:b0:426:5fbc:f319 with SMTP id
 5b1f17b1804b1-42e7ad97027mr1152105e9.33.1726767417871; 
 Thu, 19 Sep 2024 10:36:57 -0700 (PDT)
Received: from [192.168.0.31] (80.224.71.185.static.user.ono.com.
 [80.224.71.185]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e78002a4sm15805682f8f.78.2024.09.19.10.36.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2024 10:36:57 -0700 (PDT)
Message-ID: <886c753a-1018-4a2f-83a3-69070b6ca90d@suse.com>
Date: Thu, 19 Sep 2024 19:36:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 26/35] arm: mach-bcm283x: Map the ARM local MMIO as well
To: Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
 <20240918152136.3395170-27-patrick.rudolph@9elements.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20240918152136.3395170-27-patrick.rudolph@9elements.com>
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



On 18/09/2024 17:20, Patrick Rudolph wrote:
> Cover the "ARM local MMIO" range as well in the default MMU mapping in
> order to allow future code to access the GIC-400 without crashing. For
> now the GIC is not touched in u-boot, thus this change is a noop.
> 
> See [1](BCM2711 ARM Peripherals) for reference.
> 
> TEST: Enabled CONFIG_GICV2 and accessed the GIC in C code without crash.
> 
> 1: https://datasheets.raspberrypi.com/bcm2711/bcm2711-peripherals.pdf
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>

Acked-by: Matthias Brugger <mbrugger@suse.com>

> ---
>   arch/arm/mach-bcm283x/init.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.c
> index 1b459707bc..7a1de22e0a 100644
> --- a/arch/arm/mach-bcm283x/init.c
> +++ b/arch/arm/mach-bcm283x/init.c
> @@ -50,7 +50,7 @@ static struct mm_region bcm2711_mem_map[MEM_MAP_MAX_ENTRIES] = {
>   	}, {
>   		.virt = 0xfc000000UL,
>   		.phys = 0xfc000000UL,
> -		.size = 0x03800000UL,
> +		.size = 0x04000000UL,
>   		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>   			 PTE_BLOCK_NON_SHARE |
>   			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
