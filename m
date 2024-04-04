Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2F7CD1292
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 08:40:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 562CF88275;
	Thu,  4 Apr 2024 10:40:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ElFnY0BJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E52888385; Thu,  4 Apr 2024 10:40:40 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9B5788253
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 10:40:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-55a179f5fa1so925765a12.0
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 01:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712220037; x=1712824837; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+TDjVv3zz4LcqYmrK1k8YxQJMx5Gz+lkAGDRsvFkzDc=;
 b=ElFnY0BJrCAjKtR2OpDkbpi9LqeYGbqEcQ3yMouBbkv7UdthwaoJFayCc1P1o9lmzH
 h6/GIHmW5AHFnO/4hHAwhtWow7eU+3tiE6KDZXESQX9Y3agJLC8uo6bg1/SpJnLY1TGa
 sJ9WrSXoH6ehBz/f8ZVi7PjucAm49GausrE2LhvwXYa3ZE7FEkX6V+vbgFveGyw6AEat
 YxtNatJvSC4tPg6M/oLUJ00YvJ6LxlpocTlHdJAFbxGcAIJjj1t5+GaRSqaZXwfrA+4Q
 R4uDfczsNs4qrNcH6X/34cY3rSAdHCRmL1qxK4gJrfXsGhVL5Q0K66gxnBeg4cMP/NSv
 KyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712220037; x=1712824837;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+TDjVv3zz4LcqYmrK1k8YxQJMx5Gz+lkAGDRsvFkzDc=;
 b=b3M7td2qhR7fQOB8+CDp9Kh+I4vqTUd+JkSueoigs+iaIPGwSmb60Dp65vCRsXGrdR
 ztXgNdTrz787rXMCWtndY9pj2xw/60i2JcNuEE+iS59Htk7bmdc5sM2v6wmIkVzHjbUc
 r/jeqzQfJA8qLpnKNO/eR2HtPMh+cYbANPxPn+YRZfeaQF+KBptadQ28WMU1Wn8wj48Q
 4ucKJwmKMEnVJ4XJFPmHNtsc21OPq8rcPLZMsIjC72ewM33wtHQYJNpv7WZWOIDPCU+L
 ZVqBrCbzwvBpv3RAP8A35TH9E72jdMo/pW/tW8JtFWOJ9QOjLAuxSIZRXahV7thdaD8V
 g6Cg==
X-Gm-Message-State: AOJu0YyH8JchKE1sM0r9IE6vioaRbUpS/AqwAnTePj8zSL+5M6IeG/SX
 shVH0VSIpAnKxZd4lx9QI6j78EjKnNjSGVCvRyQeyNJvYrGHOanTWjRG3jJfqMTiPkEG1E86dqE
 q
X-Google-Smtp-Source: AGHT+IESQ/Qo36P4idzJwmM/bbmLYB1Hkuc135aSmiOfBMW8cy/773BHrM/TAZvBulHWGM4HXBc1RA==
X-Received: by 2002:a50:cd99:0:b0:56c:5a72:176a with SMTP id
 p25-20020a50cd99000000b0056c5a72176amr1548435edi.3.1712220036934; 
 Thu, 04 Apr 2024 01:40:36 -0700 (PDT)
Received: from hera (ppp089210071137.access.hol.gr. [89.210.71.137])
 by smtp.gmail.com with ESMTPSA id
 j17-20020aa7de91000000b0056bfb7004basm8928901edv.90.2024.04.04.01.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 01:40:36 -0700 (PDT)
Date: Thu, 4 Apr 2024 11:40:33 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, jens.wiklander@linaro.org
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v4 2/5] cmd: optee_rpmb: close tee session
Message-ID: <Zg5ngbQinAX6bOjM@hera>
References: <20240404081352.3224643-1-igor.opaniuk@gmail.com>
 <20240404081352.3224643-3-igor.opaniuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404081352.3224643-3-igor.opaniuk@gmail.com>
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

Hi Igor,

I was about to apply the series, but noticed neither me or Jens were cc'ed
on this. Adding Jens to the party

On Thu, Apr 04, 2024 at 10:13:49AM +0200, Igor Opaniuk wrote:
> Add calls for closing tee session after every read/write operation.

What the patch is pretty obvious, but I am missing an explanation of why
this is needed

>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> ---
>
> (no changes since v1)
>
>  cmd/optee_rpmb.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/cmd/optee_rpmb.c b/cmd/optee_rpmb.c
> index e0e44bbed04..b3cafd92410 100644
> --- a/cmd/optee_rpmb.c
> +++ b/cmd/optee_rpmb.c
> @@ -87,8 +87,10 @@ static int read_persistent_value(const char *name,
>
>  	rc = tee_shm_alloc(tee, name_size,
>  			   TEE_SHM_ALLOC, &shm_name);
> -	if (rc)
> -		return -ENOMEM;
> +	if (rc) {
> +		rc = -ENOMEM;
> +		goto close_session;
> +	}

I don't think you need the session to be opened to allocate memory.
So instead of of doing this, why don't we just move the alloc call before
opening the session?

>
>  	rc = tee_shm_alloc(tee, buffer_size,
>  			   TEE_SHM_ALLOC, &shm_buf);
> @@ -125,6 +127,9 @@ out:
>  	tee_shm_free(shm_buf);
>  free_name:
>  	tee_shm_free(shm_name);
> +close_session:
> +	tee_close_session(tee, session);
> +	tee = NULL;
>
>  	return rc;
>  }
> @@ -139,17 +144,20 @@ static int write_persistent_value(const char *name,
>  	struct tee_param param[2];
>  	size_t name_size = strlen(name) + 1;
>
> +	if (!value_size)
> +		return -EINVAL;
> +
>  	if (!tee) {
>  		if (avb_ta_open_session())
>  			return -ENODEV;
>  	}
> -	if (!value_size)
> -		return -EINVAL;
>
>  	rc = tee_shm_alloc(tee, name_size,
>  			   TEE_SHM_ALLOC, &shm_name);
> -	if (rc)
> -		return -ENOMEM;
> +	if (rc) {
> +		rc = -ENOMEM;
> +		goto close_session;
> +	}

ditto

>
>  	rc = tee_shm_alloc(tee, value_size,
>  			   TEE_SHM_ALLOC, &shm_buf);
> @@ -178,6 +186,9 @@ out:
>  	tee_shm_free(shm_buf);
>  free_name:
>  	tee_shm_free(shm_name);
> +close_session:
> +	tee_close_session(tee, session);
> +	tee = NULL;
>
>  	return rc;
>  }
> --
> 2.34.1
>

Thanks
/Ilias
