Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9981EC83030
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 11:39:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2565F82E08;
	Thu,  3 Jul 2025 13:39:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="p5LrkVCA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58F9282EA9; Thu,  3 Jul 2025 13:39:37 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 434B582103
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 13:39:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-453066fad06so54457805e9.2
 for <u-boot@lists.denx.de>; Thu, 03 Jul 2025 04:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751542775; x=1752147575; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PH3LCGRKx77EcbEyR9dU5rGg1kgbvcrfGBft0BhAdmc=;
 b=p5LrkVCAmc53Ed+Akes2CvMuRCZ5o/6KEjkYps28LNINLYNpa61bXRgfFcWSsXsuPq
 FhqI9sHH9fslxLw6h13FgrwiU6HsZZ5e9hZUxrJsVbnES1wlWBDMj170sJyOnfmoJqMO
 YF7ea3O7e2CTfowJHkLn5KaJqDdFJswVVIccqc0yxpRnqKyPjoC8aJXB61WMr3/2iSv7
 HrNwTAP9Uhcx6kkox//AFWgT4ygPD9B63gOHKXbWhpZVB6bxwhm57Am7gEXzhUJQwlIl
 b8SdqT8p8cysZvedIazV+XGjtoihwwr+RriT8SDTYSwg4r5JvaJhKdaocm+Lvdn+zUDe
 3PEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751542775; x=1752147575;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PH3LCGRKx77EcbEyR9dU5rGg1kgbvcrfGBft0BhAdmc=;
 b=CTLOyQm+BXN9hMkCVfzlxf6gLITPnujtWBa9MbLWIITazi/WGy1ESTaeb4A2wC2aiK
 P9/C9OJRNGVe1FlevWSSBoPnzNyQ7zrJWPPj8CoVnRKkVyTvjXtHSfX22Hr3GbkvxdIL
 zjgLY7VI7gGKyAsCDl5nOyJx6XGmW9YyhTDQIe+JdQLlaOSzvi3H8tiGIUJAZCBDkIpk
 sHiHT4xZoQcdvsDyoBAjIhCpX3HNOvGtOAf7PyoHSWS2H6N0nIwmiDyeUKQ//kNWwqpw
 /5nhzNReNLV15VbvAvxqYUr/dlIGXig8/QYQq/XulZUHPy/OBknmeCwIxXY2zInbGn3T
 KA7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoUaiuqCjIKllUl80+5EJL7nFOG+AIp4iJT13EypYd8R2t2onWgQnZvmfS5K1hhP/+VfeNj34=@lists.denx.de
X-Gm-Message-State: AOJu0YyVdMLAgnOXhO9+R2VsP50xBMNDaw3jGC7pW8g2SNx3O/CCtJi8
 Sz57CDurdtDhSWExfAyt1GkSan2uYgajuXqaSy0uQP6aLL74r18pZ7oYBOwzxbFaJTY=
X-Gm-Gg: ASbGncslEQC/H/PY3Ey1xXKxiLGI2Y2+8lu2palFaZa0lcC5YXbU6sd/JzsjIqwIc8h
 MByr1EZXRv/HTNWfgaDJNKPfbMGQGbJXEj8j2eWjAIWfQpQSeTOKSecajyzRlx+aTZB1go1kw2A
 Zhujx0UVGWw4sP9+uy/mR9wn0Uz0+hqVY05aCE9eD41nf9c6x0yxywv2VVtFNbeKmbYeiokPKyl
 /WKSx7P9FpFRqwzLU/uaaZgGSmiLORfFGfBiMt9SNE0QXaBfKPwIIcNDaFHRt2Mxev6tftB160x
 mFvykrPzXWGhlcfhEoe91Sn/CcHOnsJEpJdrefO/MIHbsRearoDovV/WjeJUylTuCS+9uIA2drq
 N/tHpLhGcV13IwMR/lSnUpRFXR9bj
X-Google-Smtp-Source: AGHT+IGTxFdWb9wEU1kfdzyCVBxCTfebsUAtMqlOg33Rk35klm2uHPAobNq0A8xXESOBAcaepCAJUQ==
X-Received: by 2002:a05:600c:820d:b0:442:f4a3:b5f2 with SMTP id
 5b1f17b1804b1-454ab368d5dmr24943385e9.6.1751542774534; 
 Thu, 03 Jul 2025 04:39:34 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3d084.dip0.t-ipconnect.de. [79.195.208.132])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9969058sm24811895e9.3.2025.07.03.04.39.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 04:39:34 -0700 (PDT)
Message-ID: <9501ecf8-1e2f-4a49-93ce-be18525d69d0@linaro.org>
Date: Thu, 3 Jul 2025 13:39:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: simplify interrupt code
Content-Language: en-US
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
References: <20250703051951.43372-1-heinrich.schuchardt@canonical.com>
 <20250703051951.43372-6-heinrich.schuchardt@canonical.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250703051951.43372-6-heinrich.schuchardt@canonical.com>
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



On 03/07/2025 07:19, Heinrich Schuchardt wrote:
> Carve out a function except_msg() to handle the output for most type of
> interrupts.
> 
> Consistently use 16 digits for printing the exception syndrome register
> esr to match the register size.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>> ---
>  arch/arm/lib/interrupts_64.c | 72 ++++++++++++------------------------
>  1 file changed, 24 insertions(+), 48 deletions(-)
> 
> diff --git a/arch/arm/lib/interrupts_64.c b/arch/arm/lib/interrupts_64.c
> index 970f8b6831f..cc20528327b 100644
> --- a/arch/arm/lib/interrupts_64.c
> +++ b/arch/arm/lib/interrupts_64.c
> @@ -170,14 +170,18 @@ static bool smh_emulate_trap(struct pt_regs *regs)
>  	return true;
>  }
>  
> -/*
> - * do_bad_sync handles the impossible case in the Synchronous Abort vector.
> +/**
> + * except_msg() - print exception message
> + *
> + * Print exception message, register contents, backtrace, loaded EFI images.
> + *
> + * @msg:	message describing exception type
> + * @pt_regs:	registers
>   */
> -void do_bad_sync(struct pt_regs *pt_regs)
> +static void except_msg(const char *msg, struct pt_regs *pt_regs)
>  {
>  	efi_restore_gd();
> -	printf("Bad mode in \"Synchronous Abort\" handler, esr 0x%08lx\n",
> -	       pt_regs->esr);
> +	printf("%s handler, esr 0x%016lx\n", msg, pt_regs->esr);
>  	show_regs(pt_regs);
>  	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
>  		show_backtrace(pt_regs);
> @@ -185,18 +189,20 @@ void do_bad_sync(struct pt_regs *pt_regs)
>  	panic("Resetting CPU ...\n");
>  }
>  
> +/*
> + * do_bad_sync handles the impossible case in the Synchronous Abort vector.
> + */
> +void do_bad_sync(struct pt_regs *pt_regs)
> +{
> +	except_msg("Bad mode in \"Synchronous Abort\"", pt_regs);
> +}
> +
>  /*
>   * do_bad_irq handles the impossible case in the Irq vector.
>   */
>  void do_bad_irq(struct pt_regs *pt_regs)
>  {
> -	efi_restore_gd();
> -	printf("Bad mode in \"Irq\" handler, esr 0x%08lx\n", pt_regs->esr);
> -	show_regs(pt_regs);
> -	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
> -		show_backtrace(pt_regs);
> -	show_efi_loaded_images(pt_regs);
> -	panic("Resetting CPU ...\n");
> +	except_msg("Bad mode in \"Irq\"", pt_regs);
>  }
>  
>  /*
> @@ -204,13 +210,7 @@ void do_bad_irq(struct pt_regs *pt_regs)
>   */
>  void do_bad_fiq(struct pt_regs *pt_regs)
>  {
> -	efi_restore_gd();
> -	printf("Bad mode in \"Fiq\" handler, esr 0x%08lx\n", pt_regs->esr);
> -	show_regs(pt_regs);
> -	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
> -		show_backtrace(pt_regs);
> -	show_efi_loaded_images(pt_regs);
> -	panic("Resetting CPU ...\n");
> +	except_msg("Bad mode in \"Fiq\"", pt_regs);
>  }
>  
>  /*
> @@ -218,13 +218,7 @@ void do_bad_fiq(struct pt_regs *pt_regs)
>   */
>  void do_bad_error(struct pt_regs *pt_regs)
>  {
> -	efi_restore_gd();
> -	printf("Bad mode in \"Error\" handler, esr 0x%08lx\n", pt_regs->esr);
> -	show_regs(pt_regs);
> -	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
> -		show_backtrace(pt_regs);
> -	show_efi_loaded_images(pt_regs);
> -	panic("Resetting CPU ...\n");
> +	except_msg("Bad mode in \"Error\"", pt_regs);
>  }
>  
>  /*
> @@ -236,7 +230,7 @@ void do_sync(struct pt_regs *pt_regs)
>  	    smh_emulate_trap(pt_regs))
>  		return;
>  	efi_restore_gd();
> -	printf("\"Synchronous Abort\" handler, esr 0x%08lx", pt_regs->esr);
> +	printf("\"Synchronous Abort\" handler, esr 0x%016lx", pt_regs->esr);
>  	dump_far(pt_regs->esr);
>  	printf("\n");
>  	show_regs(pt_regs);
> @@ -251,13 +245,7 @@ void do_sync(struct pt_regs *pt_regs)
>   */
>  void do_irq(struct pt_regs *pt_regs)
>  {
> -	efi_restore_gd();
> -	printf("\"Irq\" handler, esr 0x%08lx\n", pt_regs->esr);
> -	show_regs(pt_regs);
> -	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
> -		show_backtrace(pt_regs);
> -	show_efi_loaded_images(pt_regs);
> -	panic("Resetting CPU ...\n");
> +	except_msg("\"Irq\"", pt_regs);
>  }
>  
>  /*
> @@ -265,13 +253,7 @@ void do_irq(struct pt_regs *pt_regs)
>   */
>  void do_fiq(struct pt_regs *pt_regs)
>  {
> -	efi_restore_gd();
> -	printf("\"Fiq\" handler, esr 0x%08lx\n", pt_regs->esr);
> -	show_regs(pt_regs);
> -	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
> -		show_backtrace(pt_regs);
> -	show_efi_loaded_images(pt_regs);
> -	panic("Resetting CPU ...\n");
> +	except_msg("\"Fiq\"", pt_regs);
>  }
>  
>  /*
> @@ -282,11 +264,5 @@ void do_fiq(struct pt_regs *pt_regs)
>   */
>  void __weak do_error(struct pt_regs *pt_regs)
>  {
> -	efi_restore_gd();
> -	printf("\"Error\" handler, esr 0x%08lx\n", pt_regs->esr);
> -	show_regs(pt_regs);
> -	if (CONFIG_IS_ENABLED(FRAMEPOINTER))
> -		show_backtrace(pt_regs);
> -	show_efi_loaded_images(pt_regs);
> -	panic("Resetting CPU ...\n");
> +	except_msg("\"Error\"", pt_regs);
>  }

-- 
// Casey (she/her)

