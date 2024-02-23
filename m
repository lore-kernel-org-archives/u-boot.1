Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93851C5478C
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 11:38:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D37AC8751B;
	Fri, 23 Feb 2024 12:37:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B32Ajgh4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7026E8772A; Fri, 23 Feb 2024 12:37:57 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83874874B1
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 12:37:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-512e4f4e463so1037495e87.1
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 03:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708688273; x=1709293073; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ddzEgrR/8a7KGDikMuvYEUjeK+uAWcOznYl/XyYwEYY=;
 b=B32Ajgh4ZjDPzBGnjWnv75OzsHyC/spx2ruGt8weTWXpz31VkhXyzRJ5rh9+1sO4Oe
 5QoWk2I1zJ+98nPZPxBaawsHuVIxkNqCKYCTGsz9uMTOJGPFC56ce/Y8g1BxBM4mnb1G
 eSGIIVIdl4RPxCGqwaCovUxsYou7nWt0SfYegKddu3cBtOdj8Z5PaRdDm0y+hmru9PdQ
 eeTzrzBfvhOhQoNyM+s7aL7jWbkVDSLl0UP/a0hAkLfwk3rQx3Q5qOpTOc4NHn+oxOkg
 w2toroB83GUzTDa8WhWPQofUMQtpyeqN0o5/3fT2geUFhyND1Ymo/dBKAANwI20Wbski
 45Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708688273; x=1709293073;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ddzEgrR/8a7KGDikMuvYEUjeK+uAWcOznYl/XyYwEYY=;
 b=UIppMwhPA7dBonUPk1J9ht4QQ+6lfzitERN7xyTIkGu+mXCYMAUN4U2qW2Zy1Z95nv
 L9qHfd9Jt1+Rr+ZzrAoEa+0bo7WQHIwbvv+s4zqFtKIwjr0MtrLWyBX028hyQMyQ8tX4
 zRP1wg9e869TXDDzEJceOQyZb3bqwC5Nu6ylXFZF2v8V39H907aelUxkp4IyYk8Sh77E
 2Bg9jundSjLPiPnghI9grrZrQpUctX/Ahvf2iwBgl11c5YsCcZfIycIx6JEc0+N5WntY
 bB9OSM+3Bs0s1itR+B7Lr9Wwu82A5OCjpBj30IEFdJkHn04EMD1fJycyqVI9c1QB+9OX
 2eIQ==
X-Gm-Message-State: AOJu0YwEYLkJp0ef7l9Pi4WZ3ZybD681YUKMjKB1wUKEOkqkA5aaCWaX
 rN4QjVr+i4ZiLB6a/n2G4e1SVdkfuRTBv2Ni/suTVOmgAfeshT1rMg6p3aWpPy0=
X-Google-Smtp-Source: AGHT+IF9cQEo6kUiaGZY5qf7PSc07+5orP9PzgoeajSK3gFQpnqg5wj3yN9q/1bQ+zry0A0tUJhw2Q==
X-Received: by 2002:ac2:5e70:0:b0:512:b3ef:350f with SMTP id
 a16-20020ac25e70000000b00512b3ef350fmr1149571lfr.49.1708688272760; 
 Fri, 23 Feb 2024 03:37:52 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 iv15-20020a05600c548f00b004127dd1f713sm2103084wmb.27.2024.02.23.03.37.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 03:37:52 -0800 (PST)
Date: Fri, 23 Feb 2024 14:37:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bhargav Raviprakash <bhargav.r@ltts.com>
Cc: u-boot@lists.denx.de, jh80.chung@samsung.com, sjg@chromium.org,
 m.nirmaladevi@ltts.com, d-gole@ti.com
Subject: Re: [PATCH v1 5/5] power: regulator: tps65941: Add TPS65224 PMIC
 regulator support
Message-ID: <694aef8b-02e5-4b2a-b237-e1d28bf8956f@moroto.mountain>
References: <20240223091212.63627-1-bhargav.r@ltts.com>
 <20240223091212.63627-6-bhargav.r@ltts.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223091212.63627-6-bhargav.r@ltts.com>
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

On Fri, Feb 23, 2024 at 02:42:12PM +0530, Bhargav Raviprakash wrote:
> +	int mask = TPS65224_LDO_VOLT_MASK >> 1;
> +
> +	if (idx > 0) {
> +		base = TPS65224_LDO23_VOLT_MIN;
> +		max = TPS65224_LDO23_VOLT_MAX;
> +		reg_base = TPS65224_LDO23_VOLT_MIN_HEX;
> +		reg_max = TPS65224_LDO23_VOLT_MAX_HEX;
> +	}
> +
> +	val = val >> 1;
> +	if (val > mask || val < 0)
> +		return -EINVAL;
> +	else if (val >= reg_max)
> +		return max;
> +	else if (val <= reg_base)
> +		return base;
> +	else if (val >= 0)
> +		return base + (step * (val - reg_base));
> +	else
> +		return -EINVAL;

Instead of "if (val >= 0)" it would be more clear to write
"if (value > reg_base)".  Or something like this:

	val = val >> 1;
	if (val < 0 || val > mask)
		return -EINVAL;

	if (val <= reg_base)
		return base;
	if (val >= reg_max)
		return max;

	return base + (step * (val - reg_base));

regards,
dan carpenter

