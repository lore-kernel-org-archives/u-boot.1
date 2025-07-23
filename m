Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAD0C83F1A
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 12:57:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7276833ED;
	Wed, 23 Jul 2025 14:57:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="u7aEC1e5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8174C82C65; Wed, 23 Jul 2025 13:41:45 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73D2C81E14
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 13:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ae0ccfd5ca5so944298866b.3
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 04:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1753270903; x=1753875703; darn=lists.denx.de;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KwAI34I1Nt++E9IL4yioQI/G+GcSVCcyI+2sbJo7NTQ=;
 b=u7aEC1e5Awui6sp3t1XwMAp94GM5e2Z5x8soONn7KMqzJylxYxfSmIDYKSJjPOeXCi
 2avP5vxZe2MZci6fkeOgulqqkQ1eUfotlCRZiHhnh/TgjfzjoMyj23Bx1+kxd9zsoUUj
 M8uATm/n8E3qfEz7L5Kzf1ntyl1b/N/GjrLaS5HzGtKgNbJv2/UvDXODZCgut99kHXg4
 HKtUslsSD095H1GxtLuMZPmOehDEdvgSeKASN9DscqqqnuszebD4mvucZOudH6U//H6Q
 t8vF21LOmD9SY0dn9al+4hhRdx6KiyDdg6Dw5frBKcrcPxoDxMvVAxTLALed2f/9decd
 +vkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753270903; x=1753875703;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KwAI34I1Nt++E9IL4yioQI/G+GcSVCcyI+2sbJo7NTQ=;
 b=OdrT9w6pxN1vLzipGLPFY/zbcxXbvHgFH5lwzZIdltgMkshcPucVbgLhZo7y+yXBCz
 3cft71+1+qG7n0L0//OpTyVxmu5f7yAo87y4IrjIPCQ1EDL/XMzWoM/iw9+fZ3Skxv4E
 OE5xQAshZFiQ3Tbm+KNR8/1LoJRQ+zuBsZmvkP8483dU3bPkltJu+9cx+e+LRclOBWHl
 kKIaCwmIV9BpJYfDQ78OfjOBaT8EHr8fXw+6d50YedkpJrtS6hLfoleCcO8+KZS1UfNo
 iNWdwBWqe5wUtfduYq7xLsJkCfWwRHSC08JwrtIqs+0Ko1ZVPomEQ/14jwF+jHOP4cu+
 XjYw==
X-Gm-Message-State: AOJu0YwFZOFrs+elG6C4b2zl1BoLG+ymXgUoGr7FsMiPS3whJ2N/omvV
 EcDmOqnXE7T5zsqRKS0ja6E2BUQcwq4WQL59B4sLtDhSnmueH3V7snS5JT5v6Y6FxE0=
X-Gm-Gg: ASbGncvIm8aAMI6aHmmz/CGAgKrGqoU4A/2aYTCvlxFg/zQ7lotx0rPYkp4xXPOH0sH
 xuuhORemZKYl7pHECTG4O49lHbmt7uKehBKBbYj+snFwtUQdcxl9Xk/QgCmUQuUT0oS2aRjCXO0
 rG/RN4vS3q/xMRZOIwLKoFyL9///j6BFKtLeCoMfKFNcNRQaFmOwN6rk06YgjvLn4MMFZQexa5E
 pJaN4U+gBhAXoql5n3r4TukZkJQxwDAd5xhwgS52xU8o2+fM/Vs+dnpvbfDnPC/JrOp0NMJxGOC
 7/DWFYz7Y7fyVSa1QwLv6VGNOeFQDSw4S6FeUstRKXMXr+27xhrvd1Vw/vUqmiWdV4OyQ1rNJFt
 pTrgNDVJ05oJ/KpUJpfzO3QVU3Tgrqhd2u/SK5lbkZCkj09qU818tUUbR1VGI3X2NZhcJeMKDI0
 ZUNQ==
X-Google-Smtp-Source: AGHT+IGV3wGqLKDvhRENdtILI1X7T/ULgntGRbGCeN5xt4UVJ7q7Y5VWjXWDS/pqc2hAPxbeoVfW9w==
X-Received: by 2002:a17:907:7b9a:b0:ae0:b847:438 with SMTP id
 a640c23a62f3a-af2f6c266damr237272166b.21.1753270902737; 
 Wed, 23 Jul 2025 04:41:42 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl.
 [144.178.202.139]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aec6caf733fsm1042106266b.159.2025.07.23.04.41.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jul 2025 04:41:42 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Jul 2025 13:41:41 +0200
Message-Id: <DBJENX4A7C1B.1PUG0XWDE98UE@fairphone.com>
Cc: <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: Re: [PATCH 1/8] clk/qcom: Add SM6350 clock driver
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Luca Weiss" <luca.weiss@fairphone.com>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Tom Rini" <trini@konsulko.com>, "Lukasz
 Majewski" <lukma@denx.de>, "Sean Anderson" <seanga2@gmail.com>, "Casey
 Connolly" <casey.connolly@linaro.org>, "Sumit Garg"
 <sumit.garg@kernel.org>, "Jaehoon Chung" <jh80.chung@samsung.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250618-sm6350-bringup-v1-0-3cc22aab7a7a@fairphone.com>
 <20250618-sm6350-bringup-v1-1-3cc22aab7a7a@fairphone.com>
 <7ba396a4-d248-41bd-ace2-6d8f5c4c3bda@linaro.org>
 <DAR8PXSLCOFN.GNOSXEGBFEX3@fairphone.com>
In-Reply-To: <DAR8PXSLCOFN.GNOSXEGBFEX3@fairphone.com>
X-Mailman-Approved-At: Wed, 23 Jul 2025 14:57:45 +0200
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

Hi Neil,

On Fri Jun 20, 2025 at 11:07 AM CEST, Luca Weiss wrote:
> On Fri Jun 20, 2025 at 10:54 AM CEST, Neil Armstrong wrote:
>> On 18/06/2025 16:25, Luca Weiss wrote:
>>> Add Clock driver for the GCC block found in the SM6350 SoC.
>>>=20
>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>> ---
>
> <snip>
>
>>> +static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] =3D {
>>> +	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
>>> +	F(9600000, CFG_CLK_SRC_CXO, 2, 0, 0),
>>> +	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
>>> +	F(25000000, CFG_CLK_SRC_GPLL0_ODD, 8, 0, 0),
>>> +	F(50000000, CFG_CLK_SRC_GPLL0_ODD, 4, 0, 0),
>>> +	F(100000000, CFG_CLK_SRC_GPLL0_ODD, 2, 0, 0),
>>> +	F(202000000, CFG_CLK_SRC_GPLL7, 4, 0, 0),
>>> +	{}
>>> +};
>>> +
>>> +static struct pll_vote_clk gpll7_vote_clk =3D {
>>> +	.status =3D APCS_GPLL7_STATUS,
>>> +	.status_bit =3D BIT(31),
>>> +	.ena_vote =3D APCS_GPLLX_ENA_REG,
>>> +	.vote_bit =3D BIT(7),
>>> +};
>>> +
>>> +static ulong sm6350_set_rate(struct clk *clk, ulong rate)
>>> +{
>>> +	struct msm_clk_priv *priv =3D dev_get_priv(clk->dev);
>>> +	const struct freq_tbl *freq;
>>> +
>>> +	if (clk->id < priv->data->num_clks)
>>> +		debug("%s: %s, requested rate=3D%ld\n", __func__,
>>> +		      priv->data->clks[clk->id].name, rate);
>>> +
>>> +	switch (clk->id) {
>>> +	case GCC_QUPV3_WRAP1_S3_CLK: /*UART9*/
>>> +		freq =3D qcom_find_freq(ftbl_gcc_qupv3_wrap1_s3_clk_src, rate);
>>> +		clk_rcg_set_rate_mnd(priv->base, GCC_SE12_UART_RCG_REG,
>>> +				     freq->pre_div, freq->m, freq->n, freq->src,
>>> +				     16);
>>> +
>>> +		return freq->freq;
>>> +	case GCC_SDCC2_APPS_CLK:
>>> +		/* Enable GPLL7 so that we can point SDCC2_APPS_CLK_SRC at it */
>>> +		clk_enable_gpll0(priv->base, &gpll7_vote_clk);
>>> +		freq =3D qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
>>> +		printf("%s: got freq %u\n", __func__, freq->freq);
>>> +		WARN(freq->src !=3D CFG_CLK_SRC_GPLL7,
>>> +		     "SDCC2_APPS_CLK_SRC not set to GPLL7, requested rate %lu\n",
>>> +		     rate);
>>
>> Why not enabling GPLL7 only if freq->src =3D=3D CFG_CLK_SRC_GPLL7 ??
>
> I honestly just copy-pasted this part, I didn't think too much about
> this code. But also doesn't the code do the wrong thing when pointing to
> any freq apart from 202 MHz? The warn and the clk_rcg_set_rate_mnd call
> below will complain about/set the wrong parent?
>
> Seems that construct is in clock drivers for qcm2290, sm6115 and sm8250.
>
> Also other clk drivers like clock-sc7280.c don't have any set_rate
> handling for this clock either and SD card supposedly works fine on the
> Shiftphone 8.

Do you have any feedback how the clock drivers would be correct?

Regards
Luca
