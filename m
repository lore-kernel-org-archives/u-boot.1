Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7BBC5478C
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 06:53:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BE1486D38;
	Fri,  1 Mar 2024 07:53:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="psXQRFui";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 132CC87D57; Fri,  1 Mar 2024 07:53:55 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C5F08644E
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 07:53:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a4499ef8b5aso13230966b.0
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 22:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709276032; x=1709880832; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JDaVJYWxWU6qWXoF+AZtVhBzxChdTH7FQffmCMBp8qg=;
 b=psXQRFuiCqfanQNXpgm20tD8oIOftZR1IZeeNgvfhBBlGoKpsXQEdiS0jVLNMS79wJ
 gqQmkSSePd9xCQVn3dEZ0Ix9mRl4hNXcVciWngJOfgX1MXJpvBaOP4cyMGBN3LsipgX7
 iSyCgN30FXiGt4CpBSUTt6ItRiWgewgKWzSxoMO7wduhrbwZUuW80ojNGUHelQ7TBryf
 pVtknCdlvrUJcKaZdNgdh56NGgphcZ+8cl2b32rNLLLkWRkzOdkTVouCKNRrykvstRDy
 0dX/9wDbDNzHzlE62AZxpGvb+7AdxREVNFdC/E4wOT0P7ZR6U6RvgfjiRnowh+uulojY
 02dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709276032; x=1709880832;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JDaVJYWxWU6qWXoF+AZtVhBzxChdTH7FQffmCMBp8qg=;
 b=GJkEdU1r3yjuTDViUmodRm/oBeVMSfzQHPV4ZkAtw4ziqRfLFU78pcWWEymAZMMH0I
 kM435mb2Qp8ciAr1Gc51a/GhYC1hpolhnqmV0rMk8iNDjVxw8WCijpCG6UvqTrXapoEf
 Vr70EwEOFSfD3vcHcSqx4+YWj445xeELZ+YRqJGNaWuesbfT2wl4J4GqJVN/eYGcNZdO
 IJe+jYczhcN1wNMVzuXNbaQyifpE2tRpOL0TRutfgSf/1jzgEwVU88S3SlpicOqaBN3T
 h5Y9dNyxvb7vxRRi+kDqJjZMKWwmGPDLHjXrX2KqZkr5NXLeQo/iKhr5m+6euAPfg0eB
 2hOw==
X-Gm-Message-State: AOJu0YzEl0pSu0kIMGstazTlYp48rCO/qZjZY1LelbXciLVKnIgynDxe
 82IzJISJIAj5zKSHAQE00uNg8o2UZ9GKr/UMYof5yusgq09Rt1LoT9aqCa8Z4ag=
X-Google-Smtp-Source: AGHT+IFZR09XzxYPxC116wtTggu3mgNzSL/w4l7uAQr8Lu4d+rUJcH7xDGy3bLQaURWxr2etaVRukQ==
X-Received: by 2002:a17:906:5a90:b0:a44:9616:ae53 with SMTP id
 l16-20020a1709065a9000b00a449616ae53mr354267ejq.17.1709276032506; 
 Thu, 29 Feb 2024 22:53:52 -0800 (PST)
Received: from hades (ppp046103107123.access.hol.gr. [46.103.107.123])
 by smtp.gmail.com with ESMTPSA id
 z20-20020a170906271400b00a441cb52bfcsm1404799ejc.165.2024.02.29.22.53.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 22:53:52 -0800 (PST)
Date: Fri, 1 Mar 2024 08:53:49 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Igor Opaniuk <igor.opaniuk@foundries.io>
Cc: u-boot@lists.denx.de, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jens Wiklander <jens.wiklander@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1 1/5] tee: optee: fix description in Kconfig
Message-ID: <ZeF7fbyvXBbUQmv9@hades>
References: <20240214183444.493629-1-igor.opaniuk@gmail.com>
 <20240214183444.493629-2-igor.opaniuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214183444.493629-2-igor.opaniuk@gmail.com>
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

On Wed, Feb 14, 2024 at 07:34:40PM +0100, Igor Opaniuk wrote:
> Fix OPTEE_TA_AVB symbol description in Kconfig:
> s/"write"rb"/"write_rb"/g
> 
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> ---
> 
>  drivers/tee/optee/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
> index 9dc65b0501e..db0bcfa6f15 100644
> --- a/drivers/tee/optee/Kconfig
> +++ b/drivers/tee/optee/Kconfig
> @@ -19,7 +19,7 @@ config OPTEE_TA_AVB
>  	default y
>  	help
>  	  Enables support for the AVB Trusted Application (TA) in OP-TEE.
> -	  The TA can support the "avb" subcommands "read_rb", "write"rb"
> +	  The TA can support the "avb" subcommands "read_rb", "write_rb"
>  	  and "is_unlocked".
>  
>  config OPTEE_TA_RPC_TEST
> -- 
> 2.34.1
> 

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

