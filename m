Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF1EC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 10:29:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A211283B71;
	Thu, 10 Apr 2025 12:29:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bJpb3RW/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E48E183B7E; Thu, 10 Apr 2025 12:29:01 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF11583B24
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 12:28:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43ede096d73so4926055e9.2
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 03:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744280939; x=1744885739; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PiA5uYb6vD/wCrnAeQOr8Bdto06HZwigyZlO0EXAJuU=;
 b=bJpb3RW/bZS6HEO3fb9GNJlA9W3WLgUfExhvS/vgGfNGDG+6wl7/PCMO++NrPmRUbj
 oKugAShcXNQtR6L7XZbp3ys1phDSdCYn1WngcxnTjiP0gDsBg7I1RvxCNDVzkyF8y3ha
 XBCsBHTutxV6wnlAO7A6TWGyTloAIC3KPfxZCOl3FOlQXT3UA8PcaCTUNJgNhmm21IBz
 hh1/ba0IoGnsH3sWc15ukyx7miIxOGSlFX4gfQSHYB9ud2EbOyC8+Vf5oU2SDQxJ0B9/
 +EaHWIdjn85eQw7vu8LZXyoU13gEyVkO8SUHe9aaArV19tUI+Qas1PG+LhNutJP5Y8+P
 2/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744280939; x=1744885739;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PiA5uYb6vD/wCrnAeQOr8Bdto06HZwigyZlO0EXAJuU=;
 b=N5q3inmwNprC/PjSZOLO+HzHSIfB2wDu5udTmlAdif5LKF+ZG41An8z1a5HdsFpOka
 tknupsWpbZE/PbeM8/5WW4eCwg0pSa5RgEsUWv0aTibCPBu/j/yRHAHwAGwGF3aZoz58
 nHtW1UeeFd7Y5gtvF5cd9cHk0KgetCZJKSqQUzuLU9p5SMf5/NYbpjR6wx1VipnFvgMp
 9zjP+sK7So781brR+zz/OR4kIhePapmND1lZ14XBOV5/IZgR1WHnJDWxaZfvqPL8Syzb
 ppjxC+ht86qWJD2x7+wGGsLmJYvBI0LVLAN/b1TJNZZ2uAN33kHhQvsd4bnx6X79FQUR
 SOBw==
X-Gm-Message-State: AOJu0YyNAT0I44RLU9IPSD6a/r8q/IiQRRZ3WKuQh5MUWgZ9OOjXdVVz
 RPbJKQhSCrWyB1c/qboKWQiEY4bwbo/T+RNv8tDXytl8BxOZcdCDvZ86OZpnvSHEso5kEhIzdRc
 e
X-Gm-Gg: ASbGncuraApEjfKMfNFv0xyVIebKDaAJGreEY5r36E4zLNHLh3fDduv9np+yM3QHXaH
 E4d0n48aW46rehCyjqJ277xvFjpqbyTe6+EZsgB1qlw6CwYVvu65JQt+mt+TWk3z/4fCAIJrV76
 ddqtKcxJ0g2r9IsdfeKESUohPq2wYRVv/EcxH/WmlPNvJvsAggErDUYoQyADSIY27RLqjPrjJcf
 EGyR+0tluY3tytd3sjoGLV1yt6CyLJSPFOCOeHsM49Y6ItQjlF8Hjfwgh/y4OyDsivkvdmlPUMI
 vj3DzxVM7tLI/kzpw99Y7v/PxIvq6XFYvBbSXrwPqOYkIqo6
X-Google-Smtp-Source: AGHT+IEix1nvCU26Kg1mMJFOA2K1S1Bfj5oxaWELDYSJLIM/zbDJgpPkbS1jIOEhDq4gFFvDLXjw3A==
X-Received: by 2002:a05:600c:384b:b0:43c:f050:fed3 with SMTP id
 5b1f17b1804b1-43f2fedd212mr16870455e9.11.1744280939329; 
 Thu, 10 Apr 2025 03:28:59 -0700 (PDT)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d89361165sm4452615f8f.19.2025.04.10.03.28.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 03:28:59 -0700 (PDT)
Message-ID: <d7fc480b-a5cf-4fec-b9be-84c29e4d83ef@linaro.org>
Date: Thu, 10 Apr 2025 13:28:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] arm: at91: wdt: Remove unused at91_wdt struct
To: Zixun LI <admin@hifiphile.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250331191520.1805001-1-admin@hifiphile.com>
 <20250331191520.1805001-2-admin@hifiphile.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <20250331191520.1805001-2-admin@hifiphile.com>
Content-Type: text/plain; charset=UTF-8
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



On 3/31/25 22:15, Zixun LI wrote:
> at91_wdt struct is not used by anyone, let's remove it.
> 
> Signed-off-by: Zixun LI <admin@hifiphile.com>
> ---
>  arch/arm/mach-at91/include/mach/at91_wdt.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/include/mach/at91_wdt.h b/arch/arm/mach-at91/include/mach/at91_wdt.h
> index 8ef8e007d77..78ad0453fd9 100644
> --- a/arch/arm/mach-at91/include/mach/at91_wdt.h
> +++ b/arch/arm/mach-at91/include/mach/at91_wdt.h
> @@ -19,12 +19,6 @@
>  
>  #else
>  
> -typedef struct at91_wdt {
> -	u32	cr;
> -	u32	mr;
> -	u32	sr;
> -} at91_wdt_t;
> -
>  struct at91_wdt_priv {
>  	void __iomem *regs;
>  	u32 regval;

This breaks sama5d2_xplained_mmc_defconfig for example.

In file included from arch/arm/mach-at91/spl.c:8:
arch/arm/mach-at91/spl.c: In function ‘at91_disable_wdt’:
arch/arm/mach-at91/spl.c:19:39: error: invalid use of undefined type
‘struct at91_wdt’
   19 |         writel(AT91_WDT_MR_WDDIS, &wdt->mr);
      |                                       ^~
./arch/arm/include/asm/io.h:31:69: note: in definition of macro
‘__arch_putl’
   31 | #define __arch_putl(v,a)                (*(volatile unsigned int
*)(a) = (v))
      |
   ^
arch/arm/mach-at91/spl.c:19:9: note: in expansion of macro ‘writel’
   19 |         writel(AT91_WDT_MR_WDDIS, &wdt->mr);
      |         ^~~~~~

