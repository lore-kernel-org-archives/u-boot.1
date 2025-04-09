Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F22AC36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 15:23:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E41B48367B;
	Wed,  9 Apr 2025 17:23:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jhICeGDJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA3868367B; Wed,  9 Apr 2025 17:23:16 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C12C81FAB
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 17:23:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso47869055e9.3
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 08:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744212193; x=1744816993; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6T/2aiaxKRzlV8pZ9D0g7JDVOJXiAj2TM2jplRlwOmI=;
 b=jhICeGDJLQUrmZLsXPAukUW8uNlH5NgT8U+2aqmSIwf+cZ35rG3X+yrhYCiiv0nW1+
 0CcVa94YBEgpOT5uGgWe5BPazEiOhmew36Vgco8RvPyRhVjp3rYM1WVWa0DxEO1eNQdF
 HfrUOmrRwCfn2Uh7WbRQEzwploJW4BRkM1/AacHCGlOU0tq057sGE1ncpyI6XOF+rcqa
 tj0vGxnRVgKSGF0L6SsMDyfyVs7FLr2fF3H7aS9UWxgCqihTTFkzvkbQi5WlwHL2GI/Q
 SsC5mQxKPpS9g9gy5kW5pGVHwWgkCOfVlSTUJlb3Q2PyvQWv5NEVa3omp/MuypqBMPCm
 7S5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744212193; x=1744816993;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6T/2aiaxKRzlV8pZ9D0g7JDVOJXiAj2TM2jplRlwOmI=;
 b=c3AzXYJfaHuBF3VNFOWXs3JojmqZg/f8/5tfELVoHvrbWjLl6KNb/Ba0V6mn1LfWTt
 giCzTSkB7YXYyqXuVJvnEDnqf7Q+DH2SYbDQGV/3qr8ksf65S5FDN1x8Jx1MIkCGA++g
 PRBaQTE9tpvHusYtp7L4rB2fOJPcMOAdWBhOIHYy9kPLIZUWeDGKmdZEQ/vghtYg26VD
 GWUwQT+d+HDieZOkKcEu35JQkZv78M4NLGJkfq8iVRi7GEmz0FYIyHuipI/x6gL80PPB
 /UUu4Ndo4g6abXPy6jHsrPcuX9rF4wLcYjcYjp9EhQiyxJ4ZKCxjkIrFKRblAMTzXCL8
 G1+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZpP6KT0YfCdDyUa/OdmRWTRHoePO6ogYlCNVgfEH8GhsGHDihotf9eX1YdE0+xvlSfMP4eY8=@lists.denx.de
X-Gm-Message-State: AOJu0YxpG30HLvaMoiI4wLUPK4d6HVN8yTGcJ7QYBMxAVTcv28dms4sg
 ye1aFSIrnaGQc/a4+b6wtOoZMtM+dPE/CxA7cjTZwUBUWpz+UEL5KuhhMZsxEjw=
X-Gm-Gg: ASbGncslkmVYV4GDSgKVCNozbiUViN0ji62N2oDfsI/6Ydn79k14KDxQdRU3kiSLahp
 HTKxh4wFe8PJb4WlUT6fQIIpPSBcUrkxCanaMeQji/BdbOihKAuIIqVp27qYXN6iD3HkjMyGoOD
 QcbeCnxc4aMuzb4EBUJ2mdLpd6myRUXXVVpHSPfDkFs8Y0KgtzUJevNGwoE+O7S0rTz7X4qSonm
 nDVHy7shGUkv+ZxKW6er3vydN6z/axGjdCh8ORb4gR7nwxMmOEw1HK80HsUPg5yAgV4zMzynh3z
 nqk4uYiMt6VgBNiKOhfDrg0fVngpWU/5WqqaySTAIq9oOVIOOdWai2T/JsdqjX4v5Cug
X-Google-Smtp-Source: AGHT+IE5Kv9yU8EosM2IfDHq43hxqFN4WKLpoTJ8SeARS7oIXl02MRfnKesKhBnX4liW2OrAPbWOjw==
X-Received: by 2002:a05:600c:45d1:b0:43b:ce36:7574 with SMTP id
 5b1f17b1804b1-43f1fdf1ed8mr31251895e9.11.1744212193481; 
 Wed, 09 Apr 2025 08:23:13 -0700 (PDT)
Received: from [192.168.1.47] (i5E863B08.versanet.de. [94.134.59.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233c8224sm19207125e9.22.2025.04.09.08.23.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Apr 2025 08:23:12 -0700 (PDT)
Message-ID: <a09f329f-8e43-4581-97ac-83cd76e49074@linaro.org>
Date: Wed, 9 Apr 2025 17:23:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] board: dragonboard410c: Various fixes and cleanup
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Sam Day <me@samcday.com>
References: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
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



On 4/7/25 18:59, Stephan Gerhold wrote:
> The DB410c U-Boot port has not been updated much lately. This series
> includes various fixes and cleanup to bring it back into better shape. I've
> also added myself as new maintainer (and Sam as reviewer), since Ramon has
> not been active on the U-Boot mailing list for over a year now.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>

Thanks for this! Awesome cleanup. Really no other words, this is art :D

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>> ---
> Stephan Gerhold (13):
>        mach-snapdragon: Fix EL2 boot on DragonBoard 410c
>        board: dragonboard410c: Fix RAM size
>        board: dragonboard410c: Fix BD address
>        board: dragonboard410c: Drop UNSTUFF_BITS() macro
>        board: dragonboard410c: Drop reflash functionality
>        board: dragonboard410c: Drop unused linux_image
>        board: dragonboard410c: Use dynamically allocated load addresses
>        board: dragonboard410c: Fix counter frequency
>        board: dragonboard410c: Enable RTL8152 ethernet
>        board: dragonboard410c: Use BOOTSTD instead of DISTRO_DEFAULTS
>        board: dragonboard410c: Enable support for Android boot images
>        board: dragonboard410c: Use button_cmd instead of custom code
>        board: dragonboard410c: Update maintainers
> 
>   arch/arm/Kconfig                                   |  2 +-
>   arch/arm/dts/apq8016-sbc-u-boot.dtsi               |  2 +-
>   board/qualcomm/dragonboard410c/MAINTAINERS         |  3 +-
>   board/qualcomm/dragonboard410c/dragonboard410c.c   | 67 +++++++---------------
>   board/qualcomm/dragonboard410c/dragonboard410c.env | 38 ++----------
>   configs/dragonboard410c_defconfig                  | 10 ++--
>   include/configs/dragonboard410c.h                  | 11 ----
>   7 files changed, 35 insertions(+), 98 deletions(-)
> ---
> base-commit: 4b2895adb0ab94fdaabd6c19cef4d72986483461
> change-id: 20250407-db410c-fixes-85c6a6de2716
> 
> Best regards,
-- 
Caleb (they/them)

