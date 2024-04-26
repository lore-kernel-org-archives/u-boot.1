Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997E2C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 05:18:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C028088D0B;
	Fri, 26 Apr 2024 07:18:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pjEvzA4M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B13088DE7; Fri, 26 Apr 2024 07:18:26 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6751588BEE
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 07:18:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5196c755e82so2204621e87.0
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 22:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714108704; x=1714713504; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mQqwUHipI0ugq3Jsyqgcw4Ya0EuwuidJE6UUnpMIrPc=;
 b=pjEvzA4MOJKvHpnPLaI//VCR/XN5FXKmxeOyIxAPN1eb+UikVkzLtT36hdd3jXfFe+
 Tsy755SZP8aYKFlSudKye5lLqu3m3wZA6e1zo6BwB1DLrYhHBghtAvm8Pvm3DUabnvuu
 QzB0lZ1lTGFPXQ0KwKC7Ey0nPmTqUOsZIf10Nw6onrD9LdjUQVyTqL/dhwHrz+YuDFBP
 fB9rYi19pScQhR7CX3VSOBI0I0tt41YIjjoWwFjvLcvccGcAwCEnr78AgC6tSC/axx6a
 L8WCjXnbZqXil+F3lVmqwO+Ilzn6e7IcX/2L9zFNYgnodVjTA5BhRemVl0FAYe4OvZSS
 L9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714108704; x=1714713504;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mQqwUHipI0ugq3Jsyqgcw4Ya0EuwuidJE6UUnpMIrPc=;
 b=DY/E6fdlYieZElp2/8qzU24tjEcT/xgtMEv+yxNsUjC8IYex47YKF4w0YeqWGCpLji
 p8Sk9h2fhTDdeHodp7fU/ovbW8/TAs1e7P0knbbnJ5vpcsj1digstkNxe+b1vKG1vQjI
 5M9AeB97EdBuzBgIixtzvnQTYN7em5aC35hjjWW7W4YyWlaA1NAWEGgpoSeQTBIKzXKM
 d+gcgYiph9K6EHxsH4V9ZcACNi5vKGtD11RUrxp/C2hLWVmh1D5C33Cg8PdKg299wn0r
 RQAUmFz6Qkx6pDGzRsfpBksk0RUmUXKLPXZgtl0MCy2uEr0HBFLP8QnhFgZLoSkwAROH
 tlCg==
X-Gm-Message-State: AOJu0YzvRtfSnGwcGSJQWfIWhuptiWd83O6ymGISLskQBpt3V5iuK5DK
 7VtEB7MK32KDi5DlB2NxkIOLK5Q44tXxTGSRtIh4TbFvgQOrW1yPuYj9kz+46rc=
X-Google-Smtp-Source: AGHT+IEPpV4DC/13M1VnMpTGMgTXiHxjAnTZ9ZBg+SDzVJbqxsrDxpzSUmBoV6zXitii3UML2mpoJA==
X-Received: by 2002:a05:6512:10c9:b0:51c:c90d:90f3 with SMTP id
 k9-20020a05651210c900b0051cc90d90f3mr167645lfg.40.1714108703479; 
 Thu, 25 Apr 2024 22:18:23 -0700 (PDT)
Received: from hera (ppp089210108048.access.hol.gr. [89.210.108.48])
 by smtp.gmail.com with ESMTPSA id
 15-20020a0564021f4f00b00571d74c6074sm8100981edz.46.2024.04.25.22.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 22:18:22 -0700 (PDT)
Date: Fri, 26 Apr 2024 08:18:20 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: u-boot@lists.denx.de, jens.wiklander@linaro.org,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jorge Ramirez-Ortiz <jorge@foundries.io>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1] tee: sandbox: check for buffer size
Message-ID: <Zis5HMOgbvL8rgvo@hera>
References: <20240421204839.2129998-1-igor.opaniuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240421204839.2129998-1-igor.opaniuk@gmail.com>
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

On Sun, Apr 21, 2024 at 10:48:39PM +0200, Igor Opaniuk wrote:
> Add additional check for buffer size when reading out persistent
> storage value and provide back actual value size.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> ---
>
>  drivers/tee/sandbox.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tee/sandbox.c b/drivers/tee/sandbox.c
> index 8ad7c09efdd..86b16a3bb8d 100644
> --- a/drivers/tee/sandbox.c
> +++ b/drivers/tee/sandbox.c
> @@ -174,7 +174,7 @@ static u32 ta_avb_invoke_func(struct udevice *dev, u32 func, uint num_params,
>  	uint slot;
>  	u64 val;
>  	char *value;
> -	u32 value_sz;
> +	u32 value_sz, tmp_sz;
>
>  	switch (func) {
>  	case TA_AVB_CMD_READ_ROLLBACK_INDEX:
> @@ -267,8 +267,12 @@ static u32 ta_avb_invoke_func(struct udevice *dev, u32 func, uint num_params,
>  		if (!ep)
>  			return TEE_ERROR_ITEM_NOT_FOUND;
>
> -		value_sz = strlen(ep->data) + 1;
> -		memcpy(value, ep->data, value_sz);
> +		tmp_sz = strlen(ep->data) + 1;
> +		if (value_sz < tmp_sz)
> +			return TEE_ERROR_SHORT_BUFFER;
> +
> +		memcpy(value, ep->data, tmp_sz);
> +		params[1].u.memref.size = tmp_sz;
>
>  		return TEE_SUCCESS;
>  	case TA_AVB_CMD_WRITE_PERSIST_VALUE:
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

