Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B52FC3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 16:30:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C5D3806D8;
	Thu, 27 Mar 2025 17:30:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e055Reml";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63E8B806FC; Thu, 27 Mar 2025 17:30:14 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A808805C8
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 17:30:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-391342fc1f6so1004510f8f.1
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 09:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743093010; x=1743697810; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ylaEU9QVTbD+hsZ+5QtGzyO/y5IS1tRHeIBkxtgJFmE=;
 b=e055Reml66Me43q4JIr0xZEB3Y9tIKLZ+qR005xpItQ5JChQ8In8xM8M0YRLx4TBX9
 1lTdG2y0v1l5A59Av6pnDUEwF1wVUa/d0rPGFXJAGroXRO4NuPRFhJdcmIlC4KFTn9kA
 TlPLcBA4TT8Zb5swlMx8qOb+z+wS+XgQrcj/niPIctBrd2NWIwPrU5UVkGU5Y1i2jOIo
 UYspUpw44p+O2lwjk5bklgP4+bPpMUYWhm9cNzFUlTXbttizBWXA4N4SnEO+9qjVzGqs
 oSoJJoOL5Doq5kNdtGhASsboBIl6ax2qLZR2eG0nIOMZzlQfBJtwLA96iHO4JrOpfwNT
 HX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743093010; x=1743697810;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ylaEU9QVTbD+hsZ+5QtGzyO/y5IS1tRHeIBkxtgJFmE=;
 b=MqvNNS1un4LYcClUbV7J+oGydLW+Xi9SsGD0+BhRCfYhWtwgHNRhukbeRlBAXfrFGK
 9M8h/xtczPkGUCNeQ1TV6sNOV/qTNnHu0XZSvzi5MPnCA1OKK3AMZl8qBlwWvO3cjzWg
 zA6yZheKEqQi1phsTO7hrNmsaY1jMm/8NHUMVJejuhDaOvsiGOoEqN2z45abFh/Ck11R
 qumE5burZ8OahenV4GmkRQxyiJXCEOV5rjFm9mQTSacTDZJRXO6DeAnzaZlUpP1pp82d
 a2f0AVbXX8znB2qI67j3wMpOVh0WBAt5MLKsTiDKV1ZotObSV/kEY8ETH4XCzwM2EIhJ
 9CGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI3sKSYRW/xUCHUKfgKG2MOvuxhXodz4JMx+JIEC5stsNcDu8w+mRx2hF2bMdr/HgcWZXCdEI=@lists.denx.de
X-Gm-Message-State: AOJu0Yxea0+1/Lk8sfQnKrvIgU+oA0rhF0PsfmaZE2NnkxzuF2cAY0/x
 7Gz6vvNOrhQ2iThuGaAW24ChZTMQ5ECWTr5bL9gXQGM41yPrEL10Ra7EDkoRQfQ=
X-Gm-Gg: ASbGncsKZIWe2mP4My/2aqU4kUGdaHgtjKt2/nEWoiUoOO+eG/vYQFidrLGKo0zsHlQ
 GpNEavMEIkSHjHygKnV+/ySqHe+1jcQTRAgO0aJk9kpz4hY+gTYAWIy9PDHS9NNkA6Tv8Vp7RTO
 aCXQ7aSbVQteBQwtAF23lBkPeVkVBHfdX+MyFoZKc04eU0ew6tIG+fWcRFYT8ITnmNSVhV+dvVd
 SPlrnwOYvWYu01g2BmpzZM4nqTCAmbezwRhJIHG3ess+YfrN79TMdDSfyulSZZhzr9WQ4Uunm4x
 E57Y/ZJ42WsoLRB0PeJ3FhOmGXhn5s8C80gFQz4lbo2QHLg/nYtL+AaxUWYQcvHlZPjV4+PfRms
 =
X-Google-Smtp-Source: AGHT+IHYAQAAAoLnyLe0OKb7Vym/5qDISvU7TwwLe0nnl3pK8nqc9BK9XwRi/wGBOZRMZi/XN05Krg==
X-Received: by 2002:a5d:584b:0:b0:391:1218:d5f7 with SMTP id
 ffacd0b85a97d-39ad175c0f4mr4104329f8f.40.1743093008622; 
 Thu, 27 Mar 2025 09:30:08 -0700 (PDT)
Received: from [192.168.1.38] (i5E863BED.versanet.de. [94.134.59.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b66d0dbsm112f8f.58.2025.03.27.09.30.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 09:30:07 -0700 (PDT)
Message-ID: <391711e2-8a46-4c0d-a7bc-8a53a1da39fa@linaro.org>
Date: Thu, 27 Mar 2025 17:30:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/29] efi: arm: Implement access to global_data for EFI
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Albert Aribaud <albert.u.boot@aribaud.net>
References: <20250215032254.4121030-1-sjg@chromium.org>
 <20250215032254.4121030-18-sjg@chromium.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250215032254.4121030-18-sjg@chromium.org>
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
> The EFI app likes to use a simple variable for global data. Implement
> this for ARM (for use only with 64-bit ARM at present).
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - Mention '64-bit ARM' here, rather than just 'ARM'
> 
>   arch/arm/include/asm/global_data.h | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
> index 6e4471662a3..8d51111f095 100644
> --- a/arch/arm/include/asm/global_data.h
> +++ b/arch/arm/include/asm/global_data.h
> @@ -115,7 +115,13 @@ struct arch_global_data {
>   
>   #include <asm-generic/global_data.h>
>   
> -#if defined(__clang__) || defined(LTO_ENABLE)
> +#ifdef CONFIG_EFI_APP
> +
> +#define DECLARE_GLOBAL_DATA_PTR   extern struct global_data *global_data_ptr
> +
> +#define gd global_data_ptr
> +
> +#elif defined(__clang__) || defined(LTO_ENABLE)
>   
>   #define DECLARE_GLOBAL_DATA_PTR
>   #define gd	get_gd()
> @@ -144,7 +150,11 @@ static inline gd_t *get_gd(void)
>   
>   static inline void set_gd(volatile gd_t *gd_ptr)
>   {
> -#ifdef CONFIG_ARM64
> +#ifdef CONFIG_EFI_APP
> +	extern struct global_data *global_data_ptr;
> +
> +	global_data_ptr = (void *)gd_ptr;
> +#elif defined CONFIG_ARM64
>   	__asm__ volatile("ldr x18, %0\n" : : "m"(gd_ptr));
>   #elif __ARM_ARCH >= 7
>   	__asm__ volatile("ldr r9, %0\n" : : "m"(gd_ptr));

-- 
Caleb (they/them)

