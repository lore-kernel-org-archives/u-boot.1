Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A8AC48BC4
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 05:59:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46E7D87F77;
	Tue, 20 Feb 2024 06:57:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PZjNyFv/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80DD587F63; Tue, 20 Feb 2024 06:57:05 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64E6F876E7
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 06:56:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a3e87b2de41so165325866b.2
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 21:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708408606; x=1709013406; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XoGp42Yx1tk2F21J4DXwNtmcz9195v8cyuaQ1QsDvVw=;
 b=PZjNyFv/flQMDWba4KEt2g+9btZwk56zU8j0B4ZPaIoe8NNeu+pZI6E8/XVcaFtoW3
 oUMiGCZqbw6mHRMsDGEL3g3vixKS4hZLlKzhZ/ryGbXVtdlwF0xjKXv+ES93mI/8OB7H
 e2/WzeVpsvG3fRlD+4jNCeKwMXHZa1mHvm47kYXhw/RsCd6xgUwcQnPhUK9z8t9GfkLM
 QKxeNuoIV31TlsaO/TeVppyp9xZe8ij0MS/RxT1AclirdK9nBAvrisjp+kcWNuxrW5gN
 xQq1CX4CsjHIoiO8kDsJ+biqsw251AH6fOeQxfgtTW+BHy1SLc0GwINSKEY7/aBCW7cw
 xXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708408606; x=1709013406;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XoGp42Yx1tk2F21J4DXwNtmcz9195v8cyuaQ1QsDvVw=;
 b=v497xa1Vv9yj1zirkGnjQDQgu1wISDnXeeH6DYNjzulHnRLMuPByYRuL9ByenlAO2l
 m3MlQBX6IzHcDnMv1mL6TeO6DAC+5MqeMfF5XFL1m+57x63pex505768bp9gNr4t34/b
 qS6kE5NEbvVExrUrXYzL9mgvt5gIImeiliJAHrZll93P/YJlJ5l6kc4an+qIUdskjp/g
 +TuBIKEdUNokx/1Jl1xoHg031sHdxEtvnmlBl6QHlR0gL/GmuwwdJrqKkHjctMbAx1g2
 04E8YGjthcpv+4jUQLu5Ty4VcCXBXNrglW3boD8G9aqkhdQuNmUSrJHfJFCnC931dNCP
 9fHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUexcYzaQPuiFYDCGp58+bbJUkDjb3LSwbGFmO2CoOrsDO8J8+6Mv+tXF5FcFW2qLefkX9c9xBcshfHVLlmFUCOIbiR4g==
X-Gm-Message-State: AOJu0Yz9MbIJaR1qPLiK0k/3sEcJZ7h1yzcpdhuXlmJyfsuTO2p1rRNy
 PPz9uLGfMUA/gzp7byzgc+VZCwbjQQmrgb7+1fq4AkJs5aT3KH2Hay9f5U3H4+Y=
X-Google-Smtp-Source: AGHT+IF7dwkpsDW8eK/6MXxc7w38muroMqdFzfOi2IBBFPbZuR7lbC3vTMsi0rToM1jnS5k3UWYN2Q==
X-Received: by 2002:a17:906:69d0:b0:a3c:af7e:1660 with SMTP id
 g16-20020a17090669d000b00a3caf7e1660mr9858438ejs.22.1708408605809; 
 Mon, 19 Feb 2024 21:56:45 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 lf17-20020a170906ae5100b00a3eac4fc956sm1412594ejb.150.2024.02.19.21.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 21:56:45 -0800 (PST)
Date: Tue, 20 Feb 2024 08:56:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Frieder Schrempf <frieder@fris.de>
Cc: Fabio Estevam <festevam@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Christian Hewitt <christianshewitt@gmail.com>,
 FUKAUMI Naoki <naoki@radxa.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Marek Vasut <marex@denx.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tianling Shen <cnsztl@gmail.com>
Subject: Re: [PATCH v3 2/3] board: Add support for Sielaff i.MX6 Solo board
Message-ID: <1a3b311d-0f5d-4f2e-a9f7-da0ec0c4f60b@moroto.mountain>
References: <20240215133527.216126-1-frieder@fris.de>
 <20240215133527.216126-2-frieder@fris.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215133527.216126-2-frieder@fris.de>
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

On Thu, Feb 15, 2024 at 02:35:20PM +0100, Frieder Schrempf wrote:
> +int board_mmc_getcd(struct mmc *mmc)

This function is never called.  Also for bool functions make them type
bool and name them so that it's clear they return true/false such as
board_mmc_getcd_was_successful() but less wordy.

> +{
> +	struct fsl_esdhc_cfg *cfg = (struct fsl_esdhc_cfg *)mmc->priv;
> +	int ret = 0;
> +
> +	switch (cfg->esdhc_base) {
> +	case USDHC3_BASE_ADDR:
> +		ret = !gpio_get_value(USDHC3_CD_GPIO);
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +int board_mmc_init(struct bd_info *bis)
> +{
> +	int i, ret;
> +
> +	/*
> +	 * According to the board_mmc_init() the following map is done:
> +	 * (U-boot device node)    (Physical Port)
> +	 * mmc0                    USDHC1
> +	 * mmc1                    USDHC2
> +	 */
> +	for (i = 0; i < CFG_SYS_FSL_USDHC_NUM; i++) {
> +		switch (i) {
> +		case 0:
> +			imx_iomux_v3_setup_multiple_pads(usdhc3_pads,
> +							 ARRAY_SIZE(usdhc3_pads));
> +			gpio_direction_input(USDHC3_CD_GPIO);
> +			usdhc_cfg[0].sdhc_clk = mxc_get_clock(MXC_ESDHC3_CLK);
> +			break;
> +		default:
> +			printf("Warning: you configured more USDHC controllers \
> +				(%d) than supported by the board\n", i + 1);
> +			return -EINVAL;

This will look weird if it's ever printed:

"Warning: you configured more USDHC controllers 				(%d) than supported by the board\n"

There is a checkpatch warnings for this.

WARNING: Avoid line continuations in quoted strings
#1137: FILE: board/sielaff/imx6dl-sielaff/spl.c:96:
+                       printf("Warning: you configured more USDHC controllers \

regards,
dan carpenter

