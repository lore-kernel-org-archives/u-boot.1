Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D84C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 12:27:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CA2287D0A;
	Mon, 11 Mar 2024 13:27:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xqSLljvA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C97A287DD5; Mon, 11 Mar 2024 13:27:15 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A934087D0A
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 13:27:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a45ecef71deso326345066b.2
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 05:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710160033; x=1710764833; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kkIZrTy8mZUsXnTvgRBo0GLd59308JfQfYRE65nqbQc=;
 b=xqSLljvAkN3REBtpL810dqoSJzMdAIMDlWE4AgizEYoi+8/suS58eRYKh2of56W8/h
 PLvf154Gt91QyY43ud8lEYOTm4jSdtN/ye4cn1XTrVgjMvOnEFKihcXQ0FZWYJNEz5O8
 62WCfw8cJRau3/TzxjieNtZfngrUhQ6N/Uf1tDHh426FnnGBQgb+og3yFB4H/JtlnKf+
 t+blVpaAUtAj0d/yu4OlNKnJhbMVYn4+kP61aZLNKFkjWPV2HTG4s/O6qKF/qnpcEVas
 +Kd6SY5mjh8b1xqFKJwpwxxoFu3oOyTSqNEacKzHl0VMpCJUnorQGoMgCnWz0IVrtmwR
 NDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710160033; x=1710764833;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kkIZrTy8mZUsXnTvgRBo0GLd59308JfQfYRE65nqbQc=;
 b=CS+djvn7q26kJ4f/8dO/wUcTI6+IZqY7fgxBJ5ZkuOXPdJlzq0H+Aq71WRWBaIYsTP
 VTMmv7InaDmSXyQXI7vpGcd8++sz0/xAbKlkhmiuSY/jOHfflnMDf1DD33vruvZD5v5A
 bAVLmMbhRjH3NOBiVbzixf3VbYCF+QFwNWnQKW/1Qce4iId6HxG1O5jO7x+p/cLW4bSj
 C5ZzZOcpJWXL6XPXfyU163jSGN8YVxNGL6Sd9cjELZDlW7A2erJBdWRgb+vFAqIu6SPQ
 7u1ekHhrgWP6PtTQxAT1h85wX4QJdUg330fWHCfv5DAQbQoTxX0IhEgyBPjbx8ra4+Xd
 I9Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9LnNGOGOtbpM0Mk04Gcd4W55zREyZKFPZQTWNyMOUyMazuza9ae74iWBW6Fk7SnOANTahFAG88os3hcGZ7Ow+2IJsbA==
X-Gm-Message-State: AOJu0YwYuOJcdpEhiX7JiIYbQeaS5zxKSb0Nyek50ACN/gRvnZskPtII
 pM8KWCJrJSGQU0na0e0GLyO14j/Nk8ya/2j7jCQGq33nWuSp0zuIPAZZngMnBZ8=
X-Google-Smtp-Source: AGHT+IGuSBVxDfRnN5XRu7c/o2dDxT4xXav7m8pWYQQ/5Fr9s/xFVj9935XhIOSHQcJY02lQL+Mohg==
X-Received: by 2002:a17:906:3c4f:b0:a45:f705:777c with SMTP id
 i15-20020a1709063c4f00b00a45f705777cmr3644485ejg.40.1710160033044; 
 Mon, 11 Mar 2024 05:27:13 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 k9-20020a1709063e0900b00a45a73e0be9sm2792638eji.180.2024.03.11.05.27.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 05:27:12 -0700 (PDT)
Message-ID: <0867ce89-b6db-482c-a0f6-e2d2535dad30@linaro.org>
Date: Mon, 11 Mar 2024 12:27:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] apq8016: Add support for UART1 clocks and pinmux
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, sjg@chromium.org, laetitia.mariottini@se.com,
 pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com,
 benjamin.missey@non.se.com, daniel.thompson@linaro.org, stephan@gerhold.net
References: <20240311111027.44577-1-sumit.garg@linaro.org>
 <20240311111027.44577-3-sumit.garg@linaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240311111027.44577-3-sumit.garg@linaro.org>
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

Hi Sumit,

On 11/03/2024 11:10, Sumit Garg wrote:
> SE HMIBSC board uses UART1 as the main debug console, so add
> corresponding clocks and pinmux support. Along with that update
> instructions to enable clocks for debug UART support.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/clk/qcom/clock-apq8016.c       | 50 +++++++++++++++++++++-----
>  drivers/pinctrl/qcom/pinctrl-apq8016.c |  1 +
>  drivers/serial/serial_msm.c            |  6 ++--
>  3 files changed, 47 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
> index e6647f7c41d..a620a10a520 100644
> --- a/drivers/clk/qcom/clock-apq8016.c
> +++ b/drivers/clk/qcom/clock-apq8016.c
> @@ -43,6 +43,14 @@
>  #define BLSP1_UART2_APPS_N		(0x3040)
>  #define BLSP1_UART2_APPS_D		(0x3044)
>  
> +#define BLSP1_UART1_BCR			(0x2038)
> +#define BLSP1_UART1_APPS_CBCR		(0x203C)
> +#define BLSP1_UART1_APPS_CMD_RCGR	(0x2044)
> +#define BLSP1_UART1_APPS_CFG_RCGR	(0x2048)
> +#define BLSP1_UART1_APPS_M		(0x204C)
> +#define BLSP1_UART1_APPS_N		(0x2050)
> +#define BLSP1_UART1_APPS_D		(0x2054)
> +
>  /* GPLL0 clock control registers */
>  #define GPLL0_STATUS_ACTIVE BIT(17)
>  
> @@ -77,7 +85,7 @@ static struct vote_clk gcc_blsp1_ahb_clk = {
>  };
>  
>  /* SDHCI */
> -static int clk_init_sdc(struct msm_clk_priv *priv, int slot, uint rate)
> +static int apq8016_clk_init_sdc(struct msm_clk_priv *priv, int slot, uint rate)
This seems like an unrelated change, I don't think we need to namespace
this function as it's static.
>  {
>  	int div = 15; /* 100MHz default */
>  
> @@ -94,6 +102,33 @@ static int clk_init_sdc(struct msm_clk_priv *priv, int slot, uint rate)
>  	return rate;
>  }
>  
> +static const struct bcr_regs uart1_regs = {
> +	.cfg_rcgr = BLSP1_UART1_APPS_CFG_RCGR,
> +	.cmd_rcgr = BLSP1_UART1_APPS_CMD_RCGR,
> +	.M = BLSP1_UART1_APPS_M,
> +	.N = BLSP1_UART1_APPS_N,
> +	.D = BLSP1_UART1_APPS_D,
> +};
> +
> +/* UART: 115200 */
> +static int apq8016_clk_init_uart1(phys_addr_t base)

I know we're still dealing with some tech debt here, but I'm not a big
fan of this approach. I notice that the RCG and CBCR registers are all
offset by exactly 0xff0 between UART1 and UART2, what about adding a
second "index" parameter to apq8016_clk_init_uart() and then offsetting
the addresses by (0xff0 * index)?

This will get cleaner once we drop the bcr_regs struct.
> +{
> +	/* Enable AHB clock */
> +	clk_enable_vote_clk(base, &gcc_blsp1_ahb_clk);
> +
> +	/* 7372800 uart block clock @ GPLL0 */
> +	clk_rcg_set_rate_mnd(base, &uart1_regs, 1, 144, 15625,
> +			     CFG_CLK_SRC_GPLL0, 16);
> +
> +	/* Vote for gpll0 clock */
> +	clk_enable_gpll0(base, &gpll0_vote_clk);
> +
> +	/* Enable core clk */
> +	clk_enable_cbc(base + BLSP1_UART1_APPS_CBCR);
> +
> +	return 0;
> +}
> +
>  static const struct bcr_regs uart2_regs = {
>  	.cfg_rcgr = BLSP1_UART2_APPS_CFG_RCGR,
>  	.cmd_rcgr = BLSP1_UART2_APPS_CMD_RCGR,
> @@ -103,7 +138,7 @@ static const struct bcr_regs uart2_regs = {
>  };
>  
>  /* UART: 115200 */
> -int apq8016_clk_init_uart(phys_addr_t base)
> +int apq8016_clk_init_uart2(phys_addr_t base)
>  {
>  	/* Enable AHB clock */
>  	clk_enable_vote_clk(base, &gcc_blsp1_ahb_clk);
> @@ -127,14 +162,13 @@ static ulong apq8016_clk_set_rate(struct clk *clk, ulong rate)
>  
>  	switch (clk->id) {
>  	case GCC_SDCC1_APPS_CLK: /* SDC1 */
> -		return clk_init_sdc(priv, 0, rate);
> -		break;
> +		return apq8016_clk_init_sdc(priv, 0, rate);
>  	case GCC_SDCC2_APPS_CLK: /* SDC2 */
> -		return clk_init_sdc(priv, 1, rate);
> -		break;
> +		return apq8016_clk_init_sdc(priv, 1, rate);
>  	case GCC_BLSP1_UART2_APPS_CLK: /* UART2 */
> -		return apq8016_clk_init_uart(priv->base);
> -		break;
> +		return apq8016_clk_init_uart2(priv->base);
> +	case GCC_BLSP1_UART1_APPS_CLK: /* UART1 */
> +		return apq8016_clk_init_uart1(priv->base);
>  	default:
>  		return 0;
>  	}
> diff --git a/drivers/pinctrl/qcom/pinctrl-apq8016.c b/drivers/pinctrl/qcom/pinctrl-apq8016.c
> index db0e2124684..cb0e2227079 100644
> --- a/drivers/pinctrl/qcom/pinctrl-apq8016.c
> +++ b/drivers/pinctrl/qcom/pinctrl-apq8016.c
> @@ -29,6 +29,7 @@ static const char * const msm_pinctrl_pins[] = {
>  };
>  
>  static const struct pinctrl_function msm_pinctrl_functions[] = {
> +	{"blsp_uart1", 2},
>  	{"blsp_uart2", 2},
>  };
>  
> diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
> index ac4280c6c4c..eaf024a55b0 100644
> --- a/drivers/serial/serial_msm.c
> +++ b/drivers/serial/serial_msm.c
> @@ -248,12 +248,14 @@ static struct msm_serial_data init_serial_data = {
>  #include <debug_uart.h>
>  
>  /* Uncomment to turn on UART clocks when debugging U-Boot as aboot on MSM8916 */
Please update the comment to offer some hints about which UART should be
enabled.
> -//int apq8016_clk_init_uart(phys_addr_t gcc_base);
> +//int apq8016_clk_init_uart1(phys_addr_t gcc_base);
> +//int apq8016_clk_init_uart2(phys_addr_t gcc_base);
>  
>  static inline void _debug_uart_init(void)
>  {
>  	/* Uncomment to turn on UART clocks when debugging U-Boot as aboot on MSM8916 */
> -	//apq8016_clk_init_uart(0x1800000);
> +	//apq8016_clk_init_uart1(0x1800000);
> +	//apq8016_clk_init_uart2(0x1800000);
>  	uart_dm_init(&init_serial_data);
>  }
>  

-- 
// Caleb (they/them)
