Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4B4CD5BD2
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 14:03:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 133E5848A2;
	Tue, 26 May 2026 16:03:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J79+/MMS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6419848A1; Tue, 26 May 2026 16:03:32 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9623848AA
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 16:03:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-49041e84237so34608425e9.1
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 07:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779804210; x=1780409010; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=raA9Y5PbYFaCemqmMVbkI4GAibID69avO+ltzoshNhc=;
 b=J79+/MMSa57jL5/2Jn6oMsZAYSwByZQhzsxWagk4qfNoy2Sz5+fZq9lkYZiGZT0haW
 2MMHluSrogSZqULBe6O2h31INU6XuxgQ6D2+qxBdTjNOoDowmquGrif95ms5bOsHUILL
 JYf6X5Am3TPfHMo6ReorrOuDKMexoATmRD6QHLfNrNWzt2LPM/YPXBXup1uryIZ5SWgG
 gKfRgvDd2iHWhZ4gLkiNcA9u3QXbr1XIbDI0r+WfiFEvm/BqmoIGP/xyrbzstqoFvn1O
 wlqIE7Zxm+tA+AZxKuhyP5jlTk4HSdm4JGHjZkyCzFD0PSoChHxW7GNHg0oXAvik6FPb
 zR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779804210; x=1780409010;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=raA9Y5PbYFaCemqmMVbkI4GAibID69avO+ltzoshNhc=;
 b=krHXEZISpsJnRVL/vwyd8hngAmwC25YCiHQV3JFVcMs6Em4iTM3fKYlTxfDLYk/zDl
 7rsf90jYqY+V+Te+wXG488HBQehBnGFCksWfqtqJw72mB6uXhMCl/2wxkeDDI5sD7K1u
 lwzVJYtkSk+MfpnIwMKmHStJ1uoU9DVXQTGBHTNELQfpZ0Lu/hyzMz9DW0biDBs2XbMz
 0h2agU26pTg4Vn0MeoWdMem1SwmHPl4S6avKYt4oZU4JvUygkk1GHjjpjHQsrx4S1AUf
 LRSwv5iSgGReb7BDpP93T8Zoy99tp9HWrW0ESlTKvzuynY+g+E/DF/nLenzXzWAKb5mm
 uatQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8qyXFDWXxgLYNAgd9WajfaEKBxM54H/1YnoQ43ZM2pade0OG3b4OeJRbaqLTTC/DpL2vMGTSY=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3OGjo6c0KqUw98AMUh6d0rzjTjABENbMbB4B+BgnQgrVOYmtc
 y+XFlaoFBXb6Eh0YNxBvHL3wXy+8O29rqpberupscNqeGRGPZtd1FfYJiLkWLHSWKLKpYPWbTMJ
 zch+Z
X-Gm-Gg: Acq92OGexrF146yShs7MvhEdPKJWJtBDAmozcnDS+fiOwnAVVrh1WJgQ/juhIh/m/gk
 0bnGZ+yEz8eAxP1LnSzNsulLuXfgE+4BWMRyC2GbcNxsCQR6hAfsh+ravGAEXvHs3Q/8QKX5ZRY
 kRBEQmdY6Wc67kipw4OFo3dvnmArvOfmNubShuYicvo7cSyYcjfphbD+qyvK6yyUPWERHIOcrCv
 2NyIiees3vxrAfH/oI/5pqSQUnraCSuGSOlugmJ11XMDfDX7c4IHiK6buAK2rrzxCCDM8CtnXIn
 v3X0aiRIUt5vx5F+YJkCg97pgZxkn6xZc64gx5sGKDUlKaK6AowxobX0cAprqcC0tvaY3x80qZw
 BvH2YU6dHUtn/gr2t4dacQTJu05Ihf5HVqrr7znzSMX0eVpjy+VJXurGUaGVZRGmOYDFTg74p47
 bDmkEhYeu9X1l3vHyogOJvjIFiUntM+K3gE42YpB6wjWBXJBbMyk6eXbAdRR6y3etueG51myMYb
 MVU03MKY417
X-Received: by 2002:a05:600c:2a8b:b0:489:1abb:5559 with SMTP id
 5b1f17b1804b1-4904226d9camr165805345e9.5.1779804210031; 
 Tue, 26 May 2026 07:03:30 -0700 (PDT)
Received: from [192.168.1.36] (p549d4239.dip0.t-ipconnect.de. [84.157.66.57])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454cfcaesm322842255e9.4.2026.05.26.07.03.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 07:03:29 -0700 (PDT)
Message-ID: <45e7f64d-5ea3-444e-9756-739577fd5421@linaro.org>
Date: Tue, 26 May 2026 16:03:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: sa8775p: Add SDCC1 clock support with
 frequency table
Content-Language: en-US
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Swathi Tamilselvan <swathi.tamilselvan@oss.qualcomm.com>
References: <20260526-mmc-v1-1-5a76de90e792@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260526-mmc-v1-1-5a76de90e792@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 26/05/2026 10:58, Balaji Selvanathan wrote:
> Add support for SDCC1 (eMMC) clock on SA8775P platform.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>  drivers/clk/qcom/clock-sa8775p.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
> index 4957abf6f58..0ec4ad041c6 100644
> --- a/drivers/clk/qcom/clock-sa8775p.c
> +++ b/drivers/clk/qcom/clock-sa8775p.c
> @@ -44,6 +44,22 @@
>  
>  #define GCC_QUPV3_WRAP3_S0_CLK_ENA_BIT BIT(25)
>  
> +#define SDCC1_APPS_CLK_CMD_RCGR			0x20014
> +
> +/* SDCC1 APPS clock frequency table */
> +static const struct freq_tbl ftbl_gcc_sdcc1_apps_clk_src[] = {
> +	F(144000, CFG_CLK_SRC_CXO, 16, 3, 25),
> +	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
> +	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
> +	F(20000000, CFG_CLK_SRC_GPLL0_EVEN, 5, 1, 3),
> +	F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
> +	F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
> +	F(100000000, CFG_CLK_SRC_GPLL0_EVEN, 3, 0, 0),
> +	F(192000000, CFG_CLK_SRC_GPLL9, 4, 0, 0),
> +	F(384000000, CFG_CLK_SRC_GPLL9, 2, 0, 0),
> +	{ }
> +};
> +
>  static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
>  {
>  	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> @@ -63,6 +79,11 @@ static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
>  				     5, 0, 0, CFG_CLK_SRC_GPLL0, 8);
>  		clk_rcg_set_rate(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR, 0, 0);
>  		return rate;
> +	case GCC_SDCC1_APPS_CLK:
> +		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, SDCC1_APPS_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 8);
> +		return freq->freq;
>  	default:
>  		return 0;
>  	}
> @@ -106,6 +127,10 @@ static const struct gate_clk sa8775p_clks[] = {
>  
>  	/* QUP Wrapper 3 clocks */
>  	GATE_CLK(GCC_QUPV3_WRAP3_S0_CLK, 0x4b000, GCC_QUPV3_WRAP3_S0_CLK_ENA_BIT),
> +
> +	/* SDCC1 clocks */
> +	GATE_CLK(GCC_SDCC1_AHB_CLK, 0x2000c, 1),
> +	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x20004, 1),
>  };
>  
>  static int sa8775p_enable(struct clk *clk)
> 
> ---
> base-commit: 76d62273bc8a5dc126ed79ed0fb65e5a97359577
> change-id: 20260526-mmc-328c4d2c9055
> 
> Best regards,

-- 
// Casey (she/her)

