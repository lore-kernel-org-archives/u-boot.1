Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1D9C5478C
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 06:55:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EB1987D57;
	Fri,  1 Mar 2024 07:55:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GWxUQQyq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B09287D9B; Fri,  1 Mar 2024 07:55:42 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C0108644E
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 07:55:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a36126ee41eso284652266b.2
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 22:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709276139; x=1709880939; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Y4wmvXeWOQyOt/V/oT9ck99GQpnPGCcRl11+8OoRlxg=;
 b=GWxUQQyqDDu5VTyB1KNTwBZUBJBsLFrPKv5ZV4zJmYwVHCVWJVvqIAkcfa9protmhI
 hktsZsOP5iVa50xX0iyi91V/QwMQVFx3Ibq6suC5AhVU0kU3VzvcuUifxx8cJXTwg6du
 Vf28rObxCrHhDhWGbRuD05sjWLHBRl55KV9PyXnJD3KO2vV61h8LnOP+XTZasgRd4iH0
 fFOjFfYlydgi/RUwksB9aTWD0aQerMtftCbLF2JloXZ5dSbTBmNtrfEAiGIGjiEq6lFm
 7hSxvix+m9G+zW50uDJ1qtnc6J0Bs5hlnzikhx9M29T57KRTNGiINHcQx91HEQ/G8DyJ
 labA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709276139; x=1709880939;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y4wmvXeWOQyOt/V/oT9ck99GQpnPGCcRl11+8OoRlxg=;
 b=Q6MQMul3H2mDMDa8T60f2fmYm5Moddz8eDkziwh3jn6HY3Y4DqCr+F860PTEtwBTOV
 fAULwkvFeB550shTpxjhfusrFoLdzPngX0UYD0Ik+DNX4MqEJo8tb8BxHJotPTg/FFVQ
 aEfBiXbIdswAY1OkI2u+wx1Zz62NuR5PaEMDDxIMozhgtkFi3QBlNp84z9DZWJ/MQApl
 pZIoZtELZ2vX7RZ1Nkmh7aAEUqkLBJnjvz83fE/oPOOtzn1DYw1Xa5OwOz1Bn6Pd9q3z
 Ldt7Ibp7fualE5UwTYvizzd4krhiYbeg1OxS59A++MxmJD4PuVakKNKf/vnjrTYjYl4/
 oBNw==
X-Gm-Message-State: AOJu0YxK3J/jryYkhVyj+Qv37Z4GJokGQLw8vAbBYHvxarkRkltGD4wK
 YmpgvJLWs5qWhDMyFE/jNO5JkoqiVmVhnkVuraGiBzqghcSnpLdTrUamZIwfdA0=
X-Google-Smtp-Source: AGHT+IFRdn5m16K+e73hYVRz5bcjR8r115fglJ3j5j8HSQ8AR0ELIFYkyDoVUxgmJ2aJ70oQ39o8PQ==
X-Received: by 2002:a17:906:e0d5:b0:a44:9fe3:d7d1 with SMTP id
 gl21-20020a170906e0d500b00a449fe3d7d1mr108246ejb.43.1709276139514; 
 Thu, 29 Feb 2024 22:55:39 -0800 (PST)
Received: from hades (ppp046103107123.access.hol.gr. [46.103.107.123])
 by smtp.gmail.com with ESMTPSA id
 ti8-20020a170907c20800b00a4450442b46sm1142958ejc.216.2024.02.29.22.55.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 22:55:39 -0800 (PST)
Date: Fri, 1 Mar 2024 08:55:36 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Igor Opaniuk <igor.opaniuk@foundries.io>
Cc: u-boot@lists.denx.de, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Jorge Ramirez-Ortiz <jorge@foundries.io>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1 2/5] tee: sandbox: fix spelling errors
Message-ID: <ZeF76GLildbEE9bB@hades>
References: <20240214183444.493629-1-igor.opaniuk@gmail.com>
 <20240214183444.493629-3-igor.opaniuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214183444.493629-3-igor.opaniuk@gmail.com>
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

On Wed, Feb 14, 2024 at 07:34:41PM +0100, Igor Opaniuk wrote:
> Fix spelling errors in comments.
> 
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> ---
> 
>  drivers/tee/sandbox.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tee/sandbox.c b/drivers/tee/sandbox.c
> index 86219a9bb1a..ec66401878c 100644
> --- a/drivers/tee/sandbox.c
> +++ b/drivers/tee/sandbox.c
> @@ -14,7 +14,7 @@
>  #include "optee/optee_private.h"
>  
>  /*
> - * The sandbox tee driver tries to emulate a generic Trusted Exectution
> + * The sandbox tee driver tries to emulate a generic Trusted Execution
>   * Environment (TEE) with the Trusted Applications (TA) OPTEE_TA_AVB and
>   * OPTEE_TA_RPC_TEST available.
>   */
> @@ -23,7 +23,7 @@ static const u32 pstorage_max = 16;
>  /**
>   * struct ta_entry - TA entries
>   * @uuid:		UUID of an emulated TA
> - * @open_session	Called when a session is openened to the TA
> + * @open_session	Called when a session is opened to the TA
>   * @invoke_func		Called when a function in the TA is to be invoked
>   *
>   * This struct is used to register TAs in this sandbox emulation of a TEE.
> @@ -140,8 +140,8 @@ static u32 pta_scp03_invoke_func(struct udevice *dev, u32 func, uint num_params,
>  			provisioned = true;
>  
>  		/*
> -		 * Either way, we asume both operations succeeded and that
> -		 * the communication channel has now been stablished
> +		 * Either way, we assume both operations succeeded and that
> +		 * the communication channel has now been established
>  		 */
>  
>  		return TEE_SUCCESS;
> -- 
> 2.34.1
> 
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

