Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5251EC3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 16:21:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30680806D8;
	Thu, 27 Mar 2025 17:21:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vcA45M04";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5612B8082A; Thu, 27 Mar 2025 17:21:19 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C37C2805C8
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 17:21:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-391342fc1f6so994511f8f.1
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 09:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743092476; x=1743697276; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/D4drTMs485QaNLOzNlOS1NXFOzkx6vphpfi75qHmbg=;
 b=vcA45M04cNi0EE0AXk06PTuUPIaMd12krkkEEdINqsPXby+DZaa7RFPEltcnwddSrg
 h7fcxfcySOdkHx2b0MVENxyX7bt13uKovtic/fmU4+qZ2Eon0dGwQe8/cEW/EVJ/Uhgi
 gKQ3r4JDHIJ4y+KznMp85dyTgtq/fuXdaGfTlNSYh3XxHbo73MY7DR7+nlOmosj9xbCC
 Fwmdbp6W7/rhLr1H1G2SYlIFMDgg7+hwsd7M0kRsTUEkQkHdT+FjeQ++lUxb5JXqCxCJ
 TEIeENB+v2lEUUyVVezGYOLE/ORaxcsM/QQ7xap8BMIaBdvFLgz1o/l0uOWIy/KCE+Vu
 8RHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743092476; x=1743697276;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/D4drTMs485QaNLOzNlOS1NXFOzkx6vphpfi75qHmbg=;
 b=Nho9L2SgYdftCs4aT64L9FIxrJoxAwW3Adt9AhT6RLj9SA78bBUJ3H8lQEkBCwZjvl
 d0Qma0Qxho38P0ywDRPhk6ZmIW24/TZL90eNp4B6NR2/33KcANgbNfNx07Htax39SvaX
 oRGAnUeAas514pELNTMoD2YZlZW7uTCYh89aR7LEDnpYccLAbmn6wrcB7ZL9l4WOEJL6
 PsNKYN5wQIIl9V/iVFRtzgcvLZwTxg5bso0/1N/vWQ5r8qSlGyZmNP/9jwgD0Z4DyB0H
 ZG8nj3xzboR4HuKXwTmZFxpLIbxDudtJWdzSvMiysI2yE6c+xfQ2I17alT0PFQANYDh6
 Zziw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoCRSWkOMo6agGauKyjiyZFIcYiuOqBQkp3HWjlL/8woo+p1vVVOc1SeIA0wBKup1entcGQ0w=@lists.denx.de
X-Gm-Message-State: AOJu0YznI0/i/2qSMMbC0sBgqyQBPtMX+Fbza4HRrqQCCc5gynBhJ+C9
 Gd+68SQRTrJsLZsGxPe8VuVp9IIgH2uc914I3KBB+vpb5bykMDInGCeomFu6NgI=
X-Gm-Gg: ASbGncvVfOkosUDXnmZLRh1GSpyGpzwRBn8Y+Gwvs3uEFWTrf8xdiH3Vc5AlEO/I3bb
 sxL+4AwcAYCV5FvJyoSCrzVzMmywuVcEfzGD3N9lHKAdJbbduTLbqNqg8XpuCae7tFG5C3crlRl
 W7vI6Qdm7SHHSYeUSXc9z/o3jUQHm7xMGpM6uGt4Be0w5D8qgHKH1jQnWKSVO3t+EdPIlU4NNyc
 R7DG8LIQ4EJReRpZqIO1htB8z3IoFlFzom+O8g/fhaAHUJSJ6CImThfr35zJ1dyXyMZDjOBdzs6
 uqbYQyviUuJwJek1ZfU2GlTfs3w5JKN9vNsRf1n5OMy4R+gvhrfz3sQwpu5id02O9zVSt25gInw
 =
X-Google-Smtp-Source: AGHT+IFxBy41XJO4jXdNGR1ZK8JNxtdRZjkeERAf6qACsKanRLFMejDOTJGp69W0EsKlzMfoe7/Qbw==
X-Received: by 2002:a05:6000:4011:b0:38d:bccf:f342 with SMTP id
 ffacd0b85a97d-39ad1760510mr3912608f8f.43.1743092476041; 
 Thu, 27 Mar 2025 09:21:16 -0700 (PDT)
Received: from [192.168.1.38] (i5E863BED.versanet.de. [94.134.59.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9eef37sm20045322f8f.85.2025.03.27.09.21.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 09:21:15 -0700 (PDT)
Message-ID: <07df3ff7-65ed-47d5-928b-0c901ec5448e@linaro.org>
Date: Thu, 27 Mar 2025 17:21:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/29] efi: lmb: Avoid access to _start
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Janne Grunau <j@jannau.net>, Sughosh Ganu <sughosh.ganu@linaro.org>
References: <20250215032254.4121030-1-sjg@chromium.org>
 <20250215032254.4121030-14-sjg@chromium.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250215032254.4121030-14-sjg@chromium.org>
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
> The app does not have this symbol. Also the memory where the app is
> loaded is not under U-Boot's control.
> 
> There is no sense in relocating from one alloced region to another.
> U-Boot is not able to relocate to the top of memory, nor decide what
> other parts of memory are used for.
> 
> For these reasons, the EFI app skips relocation. It is not running at
> the address pointed to by the _start symbol.

is there a symbol or not? If there is could we have some "relocate in 
place" mechanism so that it's valid? When I (finally...) get around to 
re-sending the symbol lookup support it would be nice if it worked for 
the EFI app, and it relies on _start.
> 
> So disable this reservation for the EFI app.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - Expand commit message to explains that EFI_APP skips relocation
> 
>   lib/lmb.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 588787d2a90..420eae4d0b8 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -560,7 +560,8 @@ static void lmb_reserve_uboot_region(void)
>   		lmb_reserve_flags(rsv_start, bank_end - rsv_start + 1,
>   				  LMB_NOOVERWRITE);
>   
> -		if (gd->flags & GD_FLG_SKIP_RELOC)
> +		if (!IS_ENABLED(CONFIG_EFI_APP) &&
> +		    (gd->flags & GD_FLG_SKIP_RELOC))
>   			lmb_reserve_flags((phys_addr_t)(uintptr_t)_start,
>   					  gd->mon_len, LMB_NOOVERWRITE);
>   

-- 
Caleb (they/them)

