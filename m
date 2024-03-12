Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 171B6C54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 18:02:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 825A787F3F;
	Tue, 12 Mar 2024 19:02:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A02j0kS+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78E3B87F46; Tue, 12 Mar 2024 19:02:12 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 899448792D
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 19:02:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-41336981b3aso1726895e9.1
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 11:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710266530; x=1710871330; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TqF6GAgdmi8Z0cAdrdHsG4K7Sb1eAmzZGJ9pPJsdVp0=;
 b=A02j0kS+K6MJZhaT/Jv96GJtanbY8oo+KqX+OkKRiE193zniDF11JgQqRi87YqNw9k
 RpilaVxA5IwnZFDZm87NJrhO0p/aL4jSZixmm2W+tla+hJgyRZiPJJ5KLxBWwq+1T5me
 nOz4tpJX6IsH4niSwoXZvYljTvuLenaEtTiHl1rOZRAlFTNMDpZqHgK7+KnpgA/4wG1z
 DhorFZuaFFj47s4v67jHTUNJC6tRxcEIgvsws9ZLfqg4V0CSB/XKJYB3qLsBxn8nBHcr
 WYvXTMqEelbWf6t9rN174VS1+amPnbgbJiUEnlHTHymRr+1j/7xiv2hEIcg5L5UwNxTU
 PZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710266530; x=1710871330;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TqF6GAgdmi8Z0cAdrdHsG4K7Sb1eAmzZGJ9pPJsdVp0=;
 b=WXVlpkID52PPzi/EwRChZhIL9mKycWSn/xv2bBr5SJUIhlCRg44ZF9FQ8ueTjOiAqb
 C9f6yhHCjhpu/qZWdam1wey1c6BoggeCLEqBGyTlpdF1PAjNir0rzKvHCF5vh81Ndarw
 T4VX+wAewoQhPBPi165LPy+/THUm4sO3vHSOrLoRD4z0P3U5Wu0RE91OiINvYh6Nom3N
 rB8CDglUph6WQfbGGY7zZPiZsyvHm5bbQWfJeS8taKCi0H4T7UXsvQamiXXTLFajdywl
 sxsbCvbQlXFz1aDPUMZGzzWGFd/pRae091bzfMErWn8Sp0C9JULwKFS5G8JrMsOHJyLL
 ov5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmEKp4lcUQUssUvA+4SbgKGjojZ79JGODqoaBXgccztMj0kgwoPVjfl3X1NrcIT3qXZq9Ob1+h92zAW53hpxD8JexDCQ==
X-Gm-Message-State: AOJu0YxV5XqWJMtoyE0A31ucWhmFvf8klexgNKTFu9r2dxFyZGl8eMGS
 AQsJUZPYcCRlGKJD2+8KcCtJtO1fbfYnifu/rKQWZ9fgfGQcK03lV+q8HCh3V20=
X-Google-Smtp-Source: AGHT+IESv8bn2gx7W8yWm4EU9ECViCJ2sGjLOowJZV0Iu9znRmMf0MaAmiDbrKtSraOVBeSd3Mg2aw==
X-Received: by 2002:a05:600c:35cc:b0:412:ed3f:1b4b with SMTP id
 r12-20020a05600c35cc00b00412ed3f1b4bmr3147833wmq.11.1710266530144; 
 Tue, 12 Mar 2024 11:02:10 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 q14-20020a05600c46ce00b00412b4dca795sm13068004wmo.7.2024.03.12.11.02.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 11:02:09 -0700 (PDT)
Message-ID: <bdf6f0aa-6178-4f2a-ba46-891676bcc592@linaro.org>
Date: Tue, 12 Mar 2024 18:02:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] qcom: board: validate fdt before trying to use it
Content-Language: en-US
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Sumit Garg <sumit.garg@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20240311213334.3567389-1-volodymyr_babchuk@epam.com>
 <20240311213334.3567389-2-volodymyr_babchuk@epam.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240311213334.3567389-2-volodymyr_babchuk@epam.com>
Content-Type: text/plain; charset=UTF-8
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



On 11/03/2024 21:33, Volodymyr Babchuk wrote:
> There are cases when previous bootloader stage leaves some seemingly
> valid value in r0, which in fact does not point to valid FDT
> blob. This behavior was encountered when trying to boot U-Boot as
> "hyp" loader on SA8155P-ADP.
> 
> To be sure that we really got the pointer to a device tree we need to
> validate it with fdt_check_header() function.
> 
> Note: This approach is not 100% fool-proof, as get_prev_bl_fdt_addr()
> theoretically can return a pointer to a region that is not physically
> mapped and we will get data abort exception when fdt_check_header()
> will try to access it. But at this early boot stage we don't know
> where RAM is anyways so there is little we can do.
> 
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> 
> ---
> 
> Changes in v3:
>  - Replaced fdt_valid() with fdt_check_header()
>  - Added Sumit's R-B tag
> 
> Changes in v2:
>  - New patch in v2
> 
>  arch/arm/mach-snapdragon/board.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index f12f5791a1..6f762fc948 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -24,6 +24,7 @@
>  #include <linux/sizes.h>
>  #include <lmb.h>
>  #include <malloc.h>
> +#include <fdt_support.h>
>  #include <usb.h>
>  #include <sort.h>
>  
> @@ -93,7 +94,9 @@ void *board_fdt_blob_setup(int *err)
>  	 * try and use the FDT built into U-Boot if there is one...
>  	 * This avoids having a hard dependency on the previous stage bootloader
>  	 */
> -	if (IS_ENABLED(CONFIG_OF_SEPARATE) && (!fdt || fdt != ALIGN(fdt, SZ_4K))) {
> +
> +	if (IS_ENABLED(CONFIG_OF_SEPARATE) && (!fdt || fdt != ALIGN(fdt, SZ_4K) ||
> +					       fdt_check_header((void *)fdt))) {
>  		debug("%s: Using built in FDT, bootloader gave us %#llx\n", __func__, fdt);
>  		return (void *)gd->fdt_blob;
>  	}

-- 
// Caleb (they/them)
