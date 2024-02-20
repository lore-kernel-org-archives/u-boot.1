Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A680C48BC4
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 07:20:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7F9887D5E;
	Tue, 20 Feb 2024 08:20:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SgYdOTO0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5798087B3D; Tue, 20 Feb 2024 08:20:21 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 490E987F63
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 08:20:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-512b13bf764so2265890e87.0
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 23:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708413613; x=1709018413; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nPsi9NY8PAzo2zPxTcNQzhgLFFdThvt+y0Ju+n6EymY=;
 b=SgYdOTO0fsCgwxL26AFNs0tX65H9v9SwnmayzxP3D4nvyKjyV6mOfs0NyzDmH37gis
 6gEAwDPfArzKGuTsH4/hQ8EZ9AI0gLptVb+GEei8hXNj/U37MKr356fe1uHF0pD6/yzb
 QffTHufaHW9Tscs1aYcnJhLYWFz+rmgCL8fILOkwuDFE8r8zFC67jA1rzzy3LtxRRBpp
 TyF3R0qoS94tRcHCRXHHIJOUoecOqL/BGB2bziYe3b1dQWJS3X54ZIUYlrGlq+ysTxgQ
 Cx4ZZRKapxdPramZ8S8XdairyqJ5JtYhuoUuA/2bjbxoz9hVYMe9RPmsxe/ui5olqERT
 686w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708413613; x=1709018413;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nPsi9NY8PAzo2zPxTcNQzhgLFFdThvt+y0Ju+n6EymY=;
 b=K/5n9NT8L0IDDt40ISeTP2JYRIiYCS25WVqhwMrgWgzARo/pjvg9v2HA7nOXoKo+Fe
 v0+Oc7dY7kzNtLCW3Wz5wSACkBGKL5IiHA9urxBpA1c0ZFfaIv39cL/lhbdtq/V29K5p
 XLQRTvLWt5LyNZEB7HPNnh6pJBfXq+BLCHEeXi2yK0RYfELP52jMWkh1tRGh5QMwQBfY
 AKeZp2bWETwdBGDKm4529HKZchjvZpVlj/O5IDlLj0DiJnXhAR4o+jduS7d2UjcthZfZ
 I7kb648Yvcz0qAna2MBv2qTOah6sMMrBooFMw8D1QCL2mdZAKU/3+mmCagr3zA/61fcb
 ukpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpGcrIG2vqVbwI44ms1x3WWOQrWbWY8IueHbPHviDIMXHKp+/ec8yL2Q3hjDIAq1yt1YsUpevZqbmZUBOZpLB7vrT9Dw==
X-Gm-Message-State: AOJu0Yw+p+UAtK08w7/Eq3XvfMEi5nKWhIj8eSRwCXxn3Lpy5U2NMZfp
 558xgQm2A7hPMVYFOgISSRnR6NOv5t+TjKe5t74ePQHoDgtAu/R2V/xEa6vBYK0=
X-Google-Smtp-Source: AGHT+IFPaKjWjiRGWTtUl0f46InOGQY8/Lz8OAE0XfmQj8ez8tZF3J7vQhCvsV1A1cGpoj+opBR0bw==
X-Received: by 2002:a05:6512:138e:b0:512:b2fb:a726 with SMTP id
 fc14-20020a056512138e00b00512b2fba726mr5080365lfb.63.1708413613328; 
 Mon, 19 Feb 2024 23:20:13 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 h2-20020a1709067cc200b00a3d125b9c0asm3657326ejp.81.2024.02.19.23.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 23:20:12 -0800 (PST)
Date: Tue, 20 Feb 2024 10:20:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v4 03/39] mmc: msm_sdhci: use modern clock handling
Message-ID: <04afafac-ce62-46ca-ba01-ac8364e7432c@moroto.mountain>
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-3-ed06355c634a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215-b4-qcom-common-target-v4-3-ed06355c634a@linaro.org>
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

On Thu, Feb 15, 2024 at 08:52:21PM +0000, Caleb Connolly wrote:
>  static int msm_sdc_clk_init(struct udevice *dev)
>  {
> -	int node = dev_of_offset(dev);
> -	uint clk_rate = fdtdec_get_uint(gd->fdt_blob, node, "clock-frequency",
> -					400000);
> -	uint clkd[2]; /* clk_id and clk_no */
> -	int clk_offset;
> -	struct udevice *clk_dev;
> -	struct clk clk;
> -	int ret;
> +	struct msm_sdhc *prv = dev_get_priv(dev);
> +	ofnode node = dev_ofnode(dev);
> +	uint clk_rate;
> +	int ret, i = 0, n_clks;
> +	const char *clk_name;
>  
> -	ret = fdtdec_get_int_array(gd->fdt_blob, node, "clock", clkd, 2);
> +	ret = ofnode_read_u32(node, "clock-frequency", &clk_rate);
>  	if (ret)
> -		return ret;
> +		clk_rate = 400000;
>  
> -	clk_offset = fdt_node_offset_by_phandle(gd->fdt_blob, clkd[0]);
> -	if (clk_offset < 0)
> -		return clk_offset;
> -
> -	ret = uclass_get_device_by_of_offset(UCLASS_CLK, clk_offset, &clk_dev);
> -	if (ret)
> +	ret = clk_get_bulk(dev, &prv->clks);
> +	if (ret) {
> +		log_warning("Couldn't get mmc clocks: %d\n", ret);
>  		return ret;
> +	}
>  
> -	clk.id = clkd[1];
> -	ret = clk_request(clk_dev, &clk);
> -	if (ret < 0)
> +	ret = clk_enable_bulk(&prv->clks);
> +	if (ret) {
> +		log_warning("Couldn't enable mmc clocks: %d\n", ret);
>  		return ret;
> +	}
>  
> -	ret = clk_set_rate(&clk, clk_rate);
> -	if (ret < 0)
> -		return ret;
> +	/* If clock-names is unspecified, then the first clock is the core clock */
> +	if (!ofnode_get_property(node, "clock-names", &n_clks)) {
> +		if (!clk_set_rate(&prv->clks.clks[0], clk_rate)) {
> +			log_warning("Couldn't set core clock rate: %d\n", ret);

s/ret/clk_rate/

regards,
dan carpenter

> +			return -EINVAL;
> +		}
> +	}
> +
> +	/* Find the index of the "core" clock */
> +	while (i < n_clks) {
> +		ofnode_read_string_index(node, "clock-names", i, &clk_name);
> +		if (!strcmp(clk_name, "core"))
> +			break;
> +		i++;
> +	}
> +
> +	if (i >= prv->clks.count) {
> +		log_warning("Couldn't find core clock (index %d but only have %d clocks)\n", i,
> +		       prv->clks.count);
> +		return -EINVAL;
> +	}
> +
> +	/* The clock is already enabled by the clk_bulk above */
> +	ret = clk_set_rate(&prv->clks.clks[i], clk_rate);
> +	/* If we get a rate of 0 then something has probably gone wrong. */
> +	if (ret == 0) {
> +		log_warning("Couldn't set core clock rate to %u! Driver returned rate of 0\n", clk_rate);
> +		return -EINVAL;
> +	}
>  
>  	return 0;
>  }

