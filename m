Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED22DC67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 07:12:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CA0C883EE;
	Fri,  5 Apr 2024 09:12:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="V6519GP+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2197883EE; Fri,  5 Apr 2024 09:12:40 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9951687F4E
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 09:12:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 13D643F594
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 07:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712301158;
 bh=MHjoJf+iXove5/U8iPU7hqGSnSEbG186fD+fmhPZ8xY=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=V6519GP+ckyqhFP96iwBp8dblQWEkuBq8DJzYaksm+28X5ffb6A2iVv6MXdJFSnlZ
 Fhbq5+eHakC66Yot5u0OEBHIr6FzZmqDQ0FIVqsGR5p36q9Vi0vRihQGA78/CdCwm6
 BfwUf69y4RLmwQ1tVthDPSnCPchaEBVzrMzfz1vTuicYvZaAQmeU/fn6CKdDqmjyBM
 t3/KfhZGxg/+7EPm/AFPwjcsKxMv8FwnbrJayfKBiQ3xQ69wCTI2VgTLv7daFzJD6M
 oCYz7qsGaAvif7LphA4yynloaYexUZeoFSJSyCYQhuctAHvKZsGxDIHorUZ5pWr95p
 cOqH/003EYddA==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33ec4fb1a83so818161f8f.2
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 00:12:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712301157; x=1712905957;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MHjoJf+iXove5/U8iPU7hqGSnSEbG186fD+fmhPZ8xY=;
 b=iPaoZ8zVj4UJb2I+g0n5N51OcvACwxI9+zUMbSq/7VvR6Dn87jSSoXNgpxfz/ow8uz
 n4OuNU4aTvJlNcc8uTyfAhgudVQ2fIniyL0xJay5hor44zl1LH/2W6xaH/Vd7BgnztGS
 hZTMWG9sfl0ocnutbGyObgKEkyY3uGm6Bn9NPGTqKl+R6VnqJup3Ekh8SnIwGtf7lEKp
 z8DMWaDSGEhcZfQn9S9x5QwmX0A1FSDoN1EKWDd1JNxVeuclfX6b4AuW//xiy5g7CY8t
 71dnaOSaIzV9DkUhZVbBcQ+OUjNqWZP7LMA8X2iR7r8NDZC+D0Lmxa/zTWf+vrtvU7qf
 cIzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq7g/76RM8Ge96V0hxrO5/11DJNgzwA7cQ9B6MxFMHhn14lBdjhEM3CZVhF2+quTFTmk7/3EFFczUDcHKnj7WMDVsDiA==
X-Gm-Message-State: AOJu0YzufBKuRdi6yUIHvPrw+6iLFwbXRLvNOLkrnnSTuyelRE7nZJei
 dMmA1BaMAOAlg5ksKHZJU8/UacIVSL3ucgPwKPM78yge0JqgzhjRxQ0Yguc7qzQQwysv43spQGq
 vekXZjWhyk9DWIONuUnLBbeuitkZF5wnU3nwv86mHGBPljBJGZJeCqTNglZQyl0dG3JM=
X-Received: by 2002:a5d:4045:0:b0:33e:bf11:a007 with SMTP id
 w5-20020a5d4045000000b0033ebf11a007mr394101wrp.31.1712301157745; 
 Fri, 05 Apr 2024 00:12:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaMlOLdQuSrLseQAG2TC9ayWDXtXNfI3LB4eHrj3u3zz/AZEhlXGJF47QEIXCLnqh25lKARg==
X-Received: by 2002:a5d:4045:0:b0:33e:bf11:a007 with SMTP id
 w5-20020a5d4045000000b0033ebf11a007mr394087wrp.31.1712301157371; 
 Fri, 05 Apr 2024 00:12:37 -0700 (PDT)
Received: from [192.168.123.161]
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 y4-20020a056000108400b00343bccbe0c7sm1273412wrw.26.2024.04.05.00.12.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Apr 2024 00:12:36 -0700 (PDT)
Message-ID: <e9a8767d-27af-45cd-87b7-e2cbe188db56@canonical.com>
Date: Fri, 5 Apr 2024 09:12:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: access __efi_runtime_start/stop without &
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng@tinylab.org>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20240404063535.469995-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240404063535.469995-1-ilias.apalodimas@linaro.org>
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

On 4/4/24 08:35, Ilias Apalodimas wrote:
> A symbol defined in a linker script (e.g. __efi_runtime_start = .;) is
> only a symbol, not a variable and should not be dereferenced.
> The common practice is either define it as
> extern uint32_t __efi_runtime_start or
> extern char __efi_runtime_start[] and access it as
> &__efi_runtime_start or __efi_runtime_start respectively.
> 
> So let's access it properly since we define it as an array

Thanks for investigating this.

Beyond this patch I guess we should eliminate these duplicate defintions:

include/asm-generic/sections.h:38:extern char __efi_runtime_start[], 
__efi_runtime_stop[];
include/efi_loader.h:348:extern char __efi_runtime_start[], 
__efi_runtime_stop[];

> 
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   lib/efi_loader/efi_memory.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> index edfad2d95a1d..98f104390c8d 100644
> --- a/lib/efi_loader/efi_memory.c
> +++ b/lib/efi_loader/efi_memory.c
> @@ -933,8 +933,8 @@ static void add_u_boot_and_runtime(void)
>   	 * Add Runtime Services. We mark surrounding boottime code as runtime as
>   	 * well to fulfill the runtime alignment constraints but avoid padding.
>   	 */
> -	runtime_start = (ulong)&__efi_runtime_start & ~runtime_mask;
> -	runtime_end = (ulong)&__efi_runtime_stop;
> +	runtime_start = (ulong)__efi_runtime_start & ~runtime_mask;

Using (uintptr_t) would make it clearer that we are converting from a 
pointer to an integer type.

Best regards

Heinrich

> +	runtime_end = (ulong)__efi_runtime_stop;
>   	runtime_end = (runtime_end + runtime_mask) & ~runtime_mask;
>   	runtime_pages = (runtime_end - runtime_start) >> EFI_PAGE_SHIFT;
>   	efi_add_memory_map_pg(runtime_start, runtime_pages,

