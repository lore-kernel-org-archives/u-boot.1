Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F24C369BA
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 18:57:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4651282E38;
	Wed, 16 Apr 2025 20:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LxWWqE7j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EF3882E3F; Wed, 16 Apr 2025 20:57:05 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 518FB82BA2
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 20:57:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-abbd96bef64so1357937666b.3
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 11:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744829823; x=1745434623; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xKrumP+0w2SfAg39fBeId0HIeJZUwWoEXoWOmDtxS/I=;
 b=LxWWqE7jiGjEdv73anuIh5SNyn+4a8QnfH940C7JO8TreQMqpbaGjZ6PDy5jyuDWU9
 5xWb4VRrP3y2+Ftc+WcdNya7IGNlSiQ96bsyGr9kcKo5ed/nmYFaaA5p767j++FfFKu5
 ELERDYgH1BsYkyI27KOhmeqJ2ZtF73UpeeKqUFv8iUOgvKobqTDXBL40sTRPvHkroPfa
 pFTQzD9XSyJoDFEa19Vx2lAXPO1436tzJnyASl5t/4q6arg+Wnw2077Dr+vGNeFrcR7g
 LRiY0k21EV8aQTs9lFa1VRmHsIuGsfLgoGC5KV5u9XCyhbtFTO2plpVEJghQzdTKo5Wc
 I9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744829823; x=1745434623;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xKrumP+0w2SfAg39fBeId0HIeJZUwWoEXoWOmDtxS/I=;
 b=VsG4Yzq+nGVD44AKSVdGb/I0OfIugGq5PGJa0JUYQYe3oUyyoq44I7SQckgny3h6KD
 XB9GEgoTK8gwZklx/5dMVhCWoINXJlFKrUyw4dsJzyR9l7NedHPRCJyzT/uYub9rL59B
 zOoK/Ah4T0XZWVKBXvuC2/5hftYbSED0Gjea1ZoOUCoTCoAD+4s2X1BrQi7Tbo81aDFC
 JhLMsAoo9hYB/MSBQKlp6KlGnKI2FPhoxVPX28etlIw2f5kItILpHM3QFX5VyolvAbO+
 g0GOidqFnyXH1OswN6JvLpFDlZOrny4adX4ag47lID+YPGU0AY63Ry+Cb0BP8Tr6RLtI
 CPsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaxAjKwemaahBiekWRaeXpS72D7NRkwCNbDCcBp104wkuSlRW2V8mI5cmrXAYPJn9qS/QRdao=@lists.denx.de
X-Gm-Message-State: AOJu0YzebdDivXAN6jFl6MFuupCsMAaWd0vxq5dQdUswUTvluUgtvAV0
 /RcBmyj6ympRsIBmiktERSLN8YfjTrVI+0uUg03G60WauAnSudnlOLOuUtkWKDBYtWRCHjFzsqF
 I
X-Gm-Gg: ASbGncuUhn92h/4D2o00KIZlQaH+kuj+kJ9czMDNoLgvthTfbEe5ntRQZFLPrmrfyhz
 TOMUTkDdR+y/PHcSHYnT7+JY1W/1VM91iVETGp/qx3r6p5+ZjRvf+FtsCfN1yqdA3EHGdajCzfT
 9+ehK7U5ZF7rxZt8HxKwcXSyo/S7f1MOIzeT2w+tRrAtszsui6nXezZzz20sWNnIaNz7W68tqYC
 +UxxXKhCHpgE12lefHGMpUq1vnclPScQjar5tzDO2eyejcp9SqSCoEd4omwLCFA/WPhEqHAU4lh
 2ZaMrjk1YF7RyFXcfNqjXLic/VXU5dZdrR8UTqB5irtlMwRaV1qiGaNM5FEtZg==
X-Google-Smtp-Source: AGHT+IFP09S3EYb5/pBqgZYZWg94fE14s82cZgILxCA+Ud1908JrUDpw0R+YeeubqQ9Me9pycPPdjQ==
X-Received: by 2002:a17:907:7285:b0:aca:d571:7790 with SMTP id
 a640c23a62f3a-acb4298397bmr285815466b.16.1744829822630; 
 Wed, 16 Apr 2025 11:57:02 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef30:4dd7:8393:2255:f87])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acb3d128583sm179532266b.98.2025.04.16.11.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 11:57:02 -0700 (PDT)
Date: Wed, 16 Apr 2025 20:57:00 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Sam Day <me@samcday.com>
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: Re: [PATCH 2/3] usb: host: ehci-msm: Register ChipIdea UDC from glue
 wrapper
Message-ID: <Z__9fHFbNoAojR4Q@linaro.org>
References: <20250412-msm8916-usb-v1-0-2925239caf4b@samcday.com>
 <20250412-msm8916-usb-v1-2-2925239caf4b@samcday.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412-msm8916-usb-v1-2-2925239caf4b@samcday.com>
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

On Sat, Apr 12, 2025 at 07:40:03PM +0000, Sam Day wrote:
> When CONFIG_DM_USB_GADGET is enabled, the CI UDC driver needs to be
> explicitly bound. So we do this from the newly introduced glue driver.
> 
> Signed-off-by: Sam Day <me@samcday.com>
> ---
>  drivers/usb/host/ehci-msm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/host/ehci-msm.c b/drivers/usb/host/ehci-msm.c
> index 8aeb6a915563453ad2a02721d4828fd1b300a4e4..ae40e96e6349b1a352608e6350ce950a3cff95af 100644
> --- a/drivers/usb/host/ehci-msm.c
> +++ b/drivers/usb/host/ehci-msm.c
> @@ -161,6 +161,13 @@ static int qcom_ci_hdrc_bind(struct udevice *dev)
>  	if (ret)
>  		return ret;
>  
> +	if (IS_ENABLED(CONFIG_DM_USB_GADGET) && IS_ENABLED(CONFIG_CI_UDC)) {
> +		ret = device_bind_driver_to_node(dev, "ci-udc", "ci-udc",
> +				dev_ofnode(dev), NULL);

Nitpick: Indentation looks off here (we usually align with the open
parenthesis (

Thanks,
Stephan
