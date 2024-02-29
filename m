Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA059C48BF6
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 14:49:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B04E880D5;
	Thu, 29 Feb 2024 15:49:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yRuO6FUk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03EE6880CC; Thu, 29 Feb 2024 15:49:38 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B29AB880DE
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 15:49:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d23d301452so10796321fa.1
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 06:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709218173; x=1709822973; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BeTjDnAlA66GAxRx1ZuTTHvCCxbIXAy8bPvZimhdcjc=;
 b=yRuO6FUkgRJ0tMQNpJwgSGY47mauBvoq1JOBUSyOZqup53gFGAMqlEP2/3Y8ANpAoC
 +x3XDwcUrZ05/KuLui1mtegGUwKvvEXi0vJgUfIAdRsXZm/JFtc1HaOV2DtqyQqMnYMF
 0i+hxp9SCRTtY0s68LSUHsnN1lJptMYYdPlhNSrn3NRms+vwfFmpUMpZaDfoFFb2nXje
 B9Quh9jRseSs45vcwiANvbMHgBDxIdAwYVO9vTVHy7LHM/LrkLl0uQGs46NyLzX+x7Tq
 Xz8eJ3Sp14PkwhYqD8dUYzrV2y7/jp7fDP4qU83ef6bTWvT8TemHsDHHd80yQodWvS/M
 LaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709218173; x=1709822973;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BeTjDnAlA66GAxRx1ZuTTHvCCxbIXAy8bPvZimhdcjc=;
 b=NbQiTknxJx2SieFqIrraMrBZJ50yjrxVYgrgjNfUU9Hst4QMK82q8Fb3kiTj9VVy3y
 VGq97tTnRTb+ZBCMUwLOH7h0+QclXWPtPI/fuHY0yzVdatqvT7K4m/xpkvjR1gh6cQbY
 THIXcmIgvDpftt6e+Zs+COk8lNmqPbJE7USvuCjbWpZYpgln1/mgoR6g1KYYV+Jmqm8E
 DzLiXRqwomSSaS6OXRxuvQeWtnbvbkGl2zKx/HNABmJLbQkp+FlJBmcMlDo6qLg8JvdG
 L0njcojPdzQ7XWUz5rFV/DkqpPy0z9vX6tbzN/1ilzjbFtOWU28RoHQT/bJmxZ9TyQ5U
 Iv8Q==
X-Gm-Message-State: AOJu0Yz7DYmYd6Sc9juOlLxAOw4KRLhQmNRNWLpkjnLvOPkbA5ASuDwc
 BUBMu82TywJUXP1iPfp1oGu8jI6ieqopbzXch9tQIxr78/nTfyXeiS0+wWWYkKc=
X-Google-Smtp-Source: AGHT+IGHS4sq7vEeAYRWhwayeBjWlNFK2Eh93MF32Qotp/AvHNw45kpMp3EgNIPOFYjLKHwL51LbGw==
X-Received: by 2002:a2e:874c:0:b0:2d2:e28e:bde3 with SMTP id
 q12-20020a2e874c000000b002d2e28ebde3mr1461117ljj.48.1709218172929; 
 Thu, 29 Feb 2024 06:49:32 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 j3-20020adff003000000b0033e01e397d6sm1958562wro.54.2024.02.29.06.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 06:49:32 -0800 (PST)
Date: Thu, 29 Feb 2024 17:49:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 4/8] clk: qcom: add support for power domains uclass
Message-ID: <bedecc11-851a-4e0f-8ba4-9d53f87712e4@moroto.mountain>
References: <20240229142043.1263690-1-volodymyr_babchuk@epam.com>
 <20240229142043.1263690-5-volodymyr_babchuk@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229142043.1263690-5-volodymyr_babchuk@epam.com>
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

On Thu, Feb 29, 2024 at 02:21:08PM +0000, Volodymyr Babchuk wrote:
> @@ -223,7 +229,7 @@ U_BOOT_DRIVER(qcom_clk) = {
>  int qcom_cc_bind(struct udevice *parent)
>  {
>  	struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(parent);
> -	struct udevice *clkdev, *rstdev;
> +	struct udevice *clkdev, *rstdev, *pwrdev;
>  	struct driver *drv;
>  	int ret;
>  
> @@ -253,6 +259,20 @@ int qcom_cc_bind(struct udevice *parent)
>  	if (ret)
>  		device_unbind(clkdev);

Change this to:

	if (ret)
		goto unbind_clkdev;

>  
> +	if (!data->power_domains)
> +		return ret;


Then this becomes:

	if (!data->power_domains)
		return 0;

> +
> +	/* Get a handle to the common power domain handler */
> +	drv = lists_driver_lookup_name("qcom_power");
> +	if (!drv)
> +		return -ENOENT;

	if (!drv) {
		ret = -ENOENT;
		goto unbind_rstdev;
	}

> +
> +	/* Register the power domain controller */
> +	ret = device_bind_with_driver_data(parent, drv, "qcom_power", (ulong)data,
> +					   dev_ofnode(parent), &pwrdev);
> +	if (ret)
> +		device_unbind(pwrdev);

pwrdev wasn't bound.  Free the last *successful* allocation which was
still rstdev.

	if (ret)
		goto unbind_rstdev;

	return 0;

unbind_rstdev:
	device_unbind(rstdev);
unbind_clkdev:
	device_unbind(clkdev);

	return ret;

> +
>  	return ret;
>  }
>  

regards,
dan carpenter
