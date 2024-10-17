Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3655D374A4
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 15:24:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 332B98900A;
	Thu, 17 Oct 2024 17:24:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ztxuZ8RT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41CCE89035; Thu, 17 Oct 2024 17:24:50 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 555A288E36
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 17:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c96b2a11e7so1424943a12.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 08:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729178685; x=1729783485; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n50O5l6k8b2ZzntecpRieeUQ51x/ax7VTHOYzpMcFdY=;
 b=ztxuZ8RTrktbIXwJ4ITMiyF8AstMYt67chVtvPzykUgQzga789d4AtuqGkW9DpBVOQ
 NRcyyXGooz33ekN+GRH2nJfxeU8C525UJhOj+0VKupsNuW+M6PdWkMcSa6p+C29VqizA
 Uzmp3KQQ8Hj8Pde2c+BFUujnPN3UGCrpgI3FJbUrgi1hwFupEd0QIP2c3McKDhQeywOJ
 mxQRxKx9EL4dD6CKIRLZoyvsd6IPL2eVO9lVLrvrvyciF4r7lsC0qSAxoh2uZOok5ZVJ
 Aavo9tWXY/W6/LUJbVgMFC1KtjIXMJkRBfcqVPRJjnyjo9EtFQU9na5Fya8fZhjolLt9
 JrMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729178685; x=1729783485;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n50O5l6k8b2ZzntecpRieeUQ51x/ax7VTHOYzpMcFdY=;
 b=MceGQOG7spAICPtcUG8hjq+GrDRy2/sM+O807MLZ3vWA64Q87ySgq3N9PguhMyDQkm
 GvvP7MwZLB5BYNoNtdkrvWXgfmxP0fKdDvop+lN/mijXP5jIiQ78BZyRkjEgHkeT8V4l
 X9ESAj+GZvG5X9xD4jvwq3Wa5eOgtjlwuFnBAd5d/Jz3GPupSXMVfobOpTvos5PXYqhJ
 scshsR2RgliDtX2ZbP18FszHB+VNiBZIGGXxuxfDybDbeNnlaA8s/xj6xsAfTT5SbMtN
 K++jvR5zvb608gZON8gtS/1zg5aJj9GlXGRoOJvwzoGeFsfMgSRT+9acuMSP5CCzOtR5
 BeJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeX3lGYgQ0CPRzwsZ/JgW3We7+65WTsCql1/PE32zs1/Ny6IudQMhsmy5acZRrWK7r/RwPGtU=@lists.denx.de
X-Gm-Message-State: AOJu0YytZUcwFZ37/RncYYsgxm9S9jnEStPcUouPuXRGua6SXAUxnDj3
 1u9hXhpmkXsurrbYU7foMIQWCpswhdzM171shbxFBsKA9MEMQ5/LiupzRXkFopc=
X-Google-Smtp-Source: AGHT+IGJK9DhxcBIEckwkJe8MVtTty+TzA4T86Dv3q/XBvEDx0oldvHKOdD0GvIIvJFyugwCoVJD1g==
X-Received: by 2002:a05:6402:210b:b0:5c9:69d8:6329 with SMTP id
 4fb4d7f45d1cf-5c969d86695mr15321420a12.20.1729178685297; 
 Thu, 17 Oct 2024 08:24:45 -0700 (PDT)
Received: from ?IPV6:2a02:8109:888d:ff00::2? ([2a02:8109:888d:ff00::2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c98d4f9612sm2866502a12.32.2024.10.17.08.24.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 08:24:44 -0700 (PDT)
Message-ID: <f74886fa-b7c1-4358-9c57-cd141be775a3@linaro.org>
Date: Thu, 17 Oct 2024 17:24:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: mach-snapdragon: configure a larger default
 SYS_MALLOC_LEN for fastboot
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20241016-topic-sm8x50-bigger-malloc-len-v1-1-361b132ce7d4@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20241016-topic-sm8x50-bigger-malloc-len-v1-1-361b132ce7d4@linaro.org>
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



On 16/10/2024 11:25, Neil Armstrong wrote:
> Fastboot is very hungry when it flashes larges chunks, and 8MiB
> is way too small, allocate a much bigger size like other platforms
> using Fastboot.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Confirmed on RB1 (1GiB total RAM) that this doesn't cause any issues.

Tested-by: Caleb Connolly <caleb.connolly@linaro.org> # rb1
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>

> ---
>   arch/arm/mach-snapdragon/Kconfig | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> index 536960b83c3..2985d9d3ca4 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -11,6 +11,9 @@ config SYS_VENDOR
>   	  Based on this option board/<CONFIG_SYS_VENDOR>/<CONFIG_SYS_BOARD>
>   	  will be used as the custom board directory.
>   
> +config SYS_MALLOC_LEN
> +	default 0x10000000
> +
>   config SYS_MALLOC_F_LEN
>   	default 0x2000
>   
> 
> ---
> base-commit: d5cab0d6adc26ec1bbd45c2fed101184d04454ae
> change-id: 20241016-topic-sm8x50-bigger-malloc-len-911bea6a047f
> 
> Best regards,

-- 
// Caleb (they/them)

