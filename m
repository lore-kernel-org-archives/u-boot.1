Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2ACCD1296
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 13:17:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EA30880AD;
	Mon,  8 Apr 2024 15:17:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n13oHrVS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D132B880DE; Mon,  8 Apr 2024 15:17:08 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE56987D08
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 15:17:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a51d3193e54so126870366b.2
 for <u-boot@lists.denx.de>; Mon, 08 Apr 2024 06:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712582226; x=1713187026; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bW95WMca1Bkn9x+YymO5qMbA/BHuHpB2MZsTyFXUj7g=;
 b=n13oHrVSBUAc6WvXOYTTZ56d/8bDXxL4Wvuh1pmwgKaRucGYZJMW2+Zv5sc//6q6OV
 WKJdEfUcOUVb4p8mXMPYUZAIdp+T4KbkMur8uRjDs8T8KjAC2kC+I6XiNRWEEecPs31J
 tObqixy0ysR1iONbHNzefUr8Z5/4la5dInC0bGwKgSPAs9v80fAfAdVDIOALOomKPXRM
 xF8RGyeDC9ugsdEqm992QeOkZHDFTNMC8cY4jlqmflFrBX9Pu5pgItPW+AHk/yO/CYoz
 lnFbEgKHbHI3JDXctfEkkhNXb9QrFkB1IBF87ZbOFdOa8uIivoHEMeiPLuv91x7wBkhU
 ijGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712582226; x=1713187026;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bW95WMca1Bkn9x+YymO5qMbA/BHuHpB2MZsTyFXUj7g=;
 b=cYF6uxY3vWqEuK47ZBqpYE8qBS28btJ4y+ozOff8boavGbrvInhSht9TUmFWUXYBrX
 zYd+ZXL6adAp+mXOmoZX7Zvg16yNdtE3omr+bZHtQ/YQJ9CM9yUaUgGbtJs6xzu4/6H5
 PM5ofblawJR/8jp6oEVfEZgG2zb1UCyiMmYSlLtTVC0LtbiZOT8PHpTTQdgZ7b9El+NS
 Je0qARuPyNQ7X2QtiORshiSVwfO8iB1CXA3B+U0/WzAdfhPiH6kbvWRBTY0bLE0Eh6lR
 rBbVQrpy3iFg3R0i4E5qes2SRYyKVnsdEbIgXKIZ4ceiDuolzVU2drPmshAiJyCODCK4
 ig2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7pEDLAgrpz9sN4zyxfBDA9B2EqEXJJSFmzFEA1ottbXvP4VbQjbjDliAkinPIFb0EMUiP+AzIBYMuGVZzMzASflYClw==
X-Gm-Message-State: AOJu0YzfRu+fiezJKDCsqtVB0OPR1oyvDGPXuJI+bCa6d9UsVHxLzqij
 4ZO7tVFQZa/bdNHGDzWphN4vDWXoOlJuQSUkj7POJFYmWHVhnjVnRv/6Q0TeTrw=
X-Google-Smtp-Source: AGHT+IH6nWCwcrINJvNMUnVob4kO8rfdHZsaSUiXupM9fwS7+m6L0Htd8wWXvJ2VzbWMyPcuoG+u/A==
X-Received: by 2002:a17:906:1390:b0:a51:9341:a37f with SMTP id
 f16-20020a170906139000b00a519341a37fmr5088151ejc.71.1712582226350; 
 Mon, 08 Apr 2024 06:17:06 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::570d? ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 hv6-20020a17090760c600b00a469d3df3c1sm4461158ejc.96.2024.04.08.06.17.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 06:17:06 -0700 (PDT)
Message-ID: <9bbab772-4914-4d41-b13a-ad0e5738f5bc@linaro.org>
Date: Mon, 8 Apr 2024 15:17:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] apq8016: Add support for UART1 clocks and pinmux
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, trini@konsulko.com, lukma@denx.de,
 seanga2@gmail.com, sjg@chromium.org, laetitia.mariottini@se.com,
 pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com,
 benjamin.missey@non.se.com, daniel.thompson@linaro.org, stephan@gerhold.net
References: <20240405090742.4148304-1-sumit.garg@linaro.org>
 <20240405090742.4148304-3-sumit.garg@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240405090742.4148304-3-sumit.garg@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 05/04/2024 11:07, Sumit Garg wrote:
> SE HMIBSC board uses UART1 as the main debug console, so add
> corresponding clocks and pinmux support. Along with that update
> instructions to enable clocks for debug UART support.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/clk/qcom/clock-apq8016.c       | 38 ++++++++++++++++++--------
>   drivers/pinctrl/qcom/pinctrl-apq8016.c |  1 +
>   drivers/serial/serial_msm.c            | 11 ++++++--
>   3 files changed, 35 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
> index 5a5868169c8..9556b94774a 100644
> --- a/drivers/clk/qcom/clock-apq8016.c
> +++ b/drivers/clk/qcom/clock-apq8016.c
> @@ -31,7 +31,8 @@
>   #define BLSP1_AHB_CBCR			0x1008
>   
>   /* Uart clock control registers */
> -#define BLSP1_UART2_BCR			(0x3028)
> +#define BLSP1_UART1_APPS_CBCR		(0x203C)
> +#define BLSP1_UART1_APPS_CMD_RCGR	(0x2044)
>   #define BLSP1_UART2_APPS_CBCR		(0x302C)
>   #define BLSP1_UART2_APPS_CMD_RCGR	(0x3034)
>   
> @@ -52,7 +53,7 @@ static struct vote_clk gcc_blsp1_ahb_clk = {
>   };
>   
>   /* SDHCI */
> -static int clk_init_sdc(struct msm_clk_priv *priv, int slot, uint rate)
> +static int apq8016_clk_init_sdc(struct msm_clk_priv *priv, int slot, uint rate)
>   {
>   	int div = 15; /* 100MHz default */
>   
> @@ -70,20 +71,35 @@ static int clk_init_sdc(struct msm_clk_priv *priv, int slot, uint rate)
>   }
>   
>   /* UART: 115200 */
> -int apq8016_clk_init_uart(phys_addr_t base)
> +int apq8016_clk_init_uart(phys_addr_t base, unsigned long id)
>   {
> +	u32 cmd_rcgr, apps_cbcr;
> +
> +	switch (id) {
> +	case GCC_BLSP1_UART1_APPS_CLK:
> +		cmd_rcgr = BLSP1_UART1_APPS_CMD_RCGR;
> +		apps_cbcr = BLSP1_UART1_APPS_CBCR;
> +		break;
> +	case GCC_BLSP1_UART2_APPS_CLK:
> +		cmd_rcgr = BLSP1_UART2_APPS_CMD_RCGR;
> +		apps_cbcr = BLSP1_UART2_APPS_CBCR;
> +		break;
> +	default:
> +		return 0;
> +	}
> +
>   	/* Enable AHB clock */
>   	clk_enable_vote_clk(base, &gcc_blsp1_ahb_clk);
>   
>   	/* 7372800 uart block clock @ GPLL0 */
> -	clk_rcg_set_rate_mnd(base, BLSP1_UART2_APPS_CMD_RCGR, 1, 144, 15625,
> -			     CFG_CLK_SRC_GPLL0, 16);
> +	clk_rcg_set_rate_mnd(base, cmd_rcgr, 1, 144, 15625, CFG_CLK_SRC_GPLL0,
> +			     16);
>   
>   	/* Vote for gpll0 clock */
>   	clk_enable_gpll0(base, &gpll0_vote_clk);
>   
>   	/* Enable core clk */
> -	clk_enable_cbc(base + BLSP1_UART2_APPS_CBCR);
> +	clk_enable_cbc(base + apps_cbcr);
>   
>   	return 0;
>   }
> @@ -94,14 +110,12 @@ static ulong apq8016_clk_set_rate(struct clk *clk, ulong rate)
>   
>   	switch (clk->id) {
>   	case GCC_SDCC1_APPS_CLK: /* SDC1 */
> -		return clk_init_sdc(priv, 0, rate);
> -		break;
> +		return apq8016_clk_init_sdc(priv, 0, rate);
>   	case GCC_SDCC2_APPS_CLK: /* SDC2 */
> -		return clk_init_sdc(priv, 1, rate);
> -		break;
> +		return apq8016_clk_init_sdc(priv, 1, rate);
> +	case GCC_BLSP1_UART1_APPS_CLK: /* UART1 */
>   	case GCC_BLSP1_UART2_APPS_CLK: /* UART2 */
> -		return apq8016_clk_init_uart(priv->base);
> -		break;
> +		return apq8016_clk_init_uart(priv->base, clk->id);
>   	default:
>   		return 0;
>   	}
> diff --git a/drivers/pinctrl/qcom/pinctrl-apq8016.c b/drivers/pinctrl/qcom/pinctrl-apq8016.c
> index a9a00f4b081..1ee8b7db1a2 100644
> --- a/drivers/pinctrl/qcom/pinctrl-apq8016.c
> +++ b/drivers/pinctrl/qcom/pinctrl-apq8016.c
> @@ -29,6 +29,7 @@ static const char * const msm_pinctrl_pins[] = {
>   };
>   
>   static const struct pinctrl_function msm_pinctrl_functions[] = {
> +	{"blsp_uart1", 2},
>   	{"blsp_uart2", 2},
>   };
>   
> diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
> index ac4280c6c4c..4de10e75191 100644
> --- a/drivers/serial/serial_msm.c
> +++ b/drivers/serial/serial_msm.c
> @@ -248,12 +248,17 @@ static struct msm_serial_data init_serial_data = {
>   #include <debug_uart.h>
>   
>   /* Uncomment to turn on UART clocks when debugging U-Boot as aboot on MSM8916 */
> -//int apq8016_clk_init_uart(phys_addr_t gcc_base);
> +//int apq8016_clk_init_uart(phys_addr_t gcc_base, unsigned long id);
>   
>   static inline void _debug_uart_init(void)
>   {
> -	/* Uncomment to turn on UART clocks when debugging U-Boot as aboot on MSM8916 */
> -	//apq8016_clk_init_uart(0x1800000);
> +	/*
> +	 * Uncomment to turn on UART clocks when debugging U-Boot as aboot
> +	 * on MSM8916. Supported debug UART clock IDs:
> +	 *   - db410c: GCC_BLSP1_UART2_APPS_CLK
> +	 *   - HMIBSC: GCC_BLSP1_UART1_APPS_CLK
> +	 */
> +	//apq8016_clk_init_uart(0x1800000, <uart_clk_id>);
>   	uart_dm_init(&init_serial_data);
>   }
>   

-- 
// Caleb (they/them)
