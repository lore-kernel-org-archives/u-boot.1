Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EDEC36010
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 16:33:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B53EE806D8;
	Thu, 27 Mar 2025 17:33:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OiYCJRsv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D78FA81DB4; Thu, 27 Mar 2025 17:33:48 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AE06805C8
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 17:33:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so9521625e9.1
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 09:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743093225; x=1743698025; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KJLVGP3Y4EpaB4LQtl2QT3tBias/icUqF7MaXr4Mm+c=;
 b=OiYCJRsvYBuTI3dOgY19exj+WKFuzOTQE+aP5QisMIAGQd4XNj69jlImdVu0WWz/S9
 qY1si+fF6Fk0zKkfYtFRC4LYIcpjmS3M9ZnH8iZqduXz0JmruYfELq3eIp49itnJe1Mx
 zpetWaQQUpYpJiB2LsUi473obS58RHy7lWD1h0iv0z0pn6BDE+4I9f5xH955jHHaX6xr
 nNxUasAqNRq1kP9e8nVdwq4BdfLVcxxIsmPmOpQsDdVmn8ATj/onlwiijiuGz29KHuUJ
 +HBE+Zd7yMNQd+MZKDJMfgG+EveKdp7I34NcorpiJ2eq/Q9KwCHyDAGldU0kc2VcpIlu
 bhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743093225; x=1743698025;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KJLVGP3Y4EpaB4LQtl2QT3tBias/icUqF7MaXr4Mm+c=;
 b=XpiUXyrH/Q6o7H7SYjzIwQYd/dH8XHUTlOwMJDj9B0Ri14XgAXiUiWymEoWA/8MIAb
 PlNKsU5NVbjJh6qp4mIS0iDUw/vnhg7HqcSOmoGK26xA9zGUbzLwbi8x06YqC1tWA7WW
 KeWMUyTBi5eeaD5LMqxdTPborYDtqBtF0fq1myW94HSdsfuy61xDCm157dEG5uDT9zQt
 m0CYLWkmiF/zQrh+Ni/68L9alspZgPvUdj3NDYo4nBt0DOi+pak98vIL3ewHJh/oyo+2
 ISiy81KrSFMT2VUeV23UtFEv5tnaHadSIffqyC7JMkSWmxl3cmdHEXFPVHCeoS9yCrqq
 x//w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVqEnXSYfB6WZA559w3r5OZ0WjigIJS1AzhVLF2zR+qYLi4C/TNEL+cZV03S80oK8+BK27tnU=@lists.denx.de
X-Gm-Message-State: AOJu0YygntHTOXNsVlsslDPN8OF5VMqibRSDu7Kja0AhChAxyzYqOnIZ
 Kf0wvuFoAEULwwxtTq5/9qd9/VRZLq2cVz1Y2JgvHvT2PwfuMBIAz613kGRYW1U=
X-Gm-Gg: ASbGncsjSjdr0SbZtZ+thuuFSfpPzEEKTsP7nsFuNk2VOsjYVJ/AkV5eGXEi0apQmsu
 VeUHm5cRarbKMWJboFkYxqbjggb6YMax3SgI24imlN5v6qNkKTOT9blllFsLtXw6Ogl4TPAdiJL
 4c5yc2JXg9h4A3Dphjbv90WCyLKs46GfPeliZNImNHGlauTCCysTeE6MaFIiC2HemuQzn7vBO+w
 mQLTtQw40iie1zjuToKx/k99abHiPiBZHIFrIPOg6ao1nLce53XKwBL0GF0ONbCcuHPqd+hLdyS
 wNyXT2M1miZN6vcwudz94YBDjbGjTf9Zm4lO0RWgP8u/ZaLa9m59bJFg/FlIIufZvHgQpkfdWu8
 =
X-Google-Smtp-Source: AGHT+IEeAkxWluUi5raxDQkhzJCmV38ogsi16PKTShyE51kJA0saJZ8OH2uzNSykvysQKsLFfH4YYA==
X-Received: by 2002:a05:600c:3509:b0:43d:585f:ebf5 with SMTP id
 5b1f17b1804b1-43d84f60bf4mr38455085e9.1.1743093225169; 
 Thu, 27 Mar 2025 09:33:45 -0700 (PDT)
Received: from [192.168.1.38] (i5E863BED.versanet.de. [94.134.59.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8f404ac3sm538655e9.0.2025.03.27.09.33.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 09:33:44 -0700 (PDT)
Message-ID: <a9ac4bc4-5732-4c14-a11d-dc3c9e0ae4e5@linaro.org>
Date: Thu, 27 Mar 2025 17:33:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 22/29] efi: arm: Drop startup code from the app
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>
References: <20250215032254.4121030-1-sjg@chromium.org>
 <20250215032254.4121030-23-sjg@chromium.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250215032254.4121030-23-sjg@chromium.org>
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



On 2/15/25 04:22, Simon Glass wrote:
> The EFI app uses different startup and relocation code and the existing
> code uses symbols not present in the app. Drop it.

Shouldn't this be squashed into patch 18 ("efi: arm: Omit the ARM 
start-up code in the EFI app")?
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
> 
> (no changes since v1)
> 
>   arch/arm/cpu/armv8/Makefile | 2 ++
>   arch/arm/lib/Makefile       | 4 +++-
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
> index 7bd6cf21b19..a8f5de58cc4 100644
> --- a/arch/arm/cpu/armv8/Makefile
> +++ b/arch/arm/cpu/armv8/Makefile
> @@ -3,7 +3,9 @@
>   # (C) Copyright 2000-2003
>   # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
>   
> +ifndef CONFIG_EFI_APP
>   extra-y	:= start.o
> +endif
>   
>   obj-y	+= cpu.o
>   ifndef CONFIG_$(PHASE_)TIMER
> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index 9500ba6fddc..a41566c816d 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -24,11 +24,13 @@ endif  # ARM64
>   endif  # CONFIG_EFI_APP
>   
>   ifndef CONFIG_XPL_BUILD
> +ifndef CONFIG_EFI_APP
>   ifdef CONFIG_ARM64
>   obj-y	+= relocate_64.o
>   else
>   obj-y	+= relocate.o
> -endif
> +endif  # ARM64
> +endif  # EFI_APP
>   
>   obj-$(CONFIG_CPU_V7M) += cmd_boot.o
>   obj-$(CONFIG_OF_LIBFDT) += bootm-fdt.o

-- 
Caleb (they/them)

