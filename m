Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F64EC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 13:35:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8F32882DD;
	Thu,  2 May 2024 15:35:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mEIRZbTB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DAA08830F; Thu,  2 May 2024 15:35:41 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8747F882D0
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 15:35:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a56d7d457a1so1015912266b.1
 for <u-boot@lists.denx.de>; Thu, 02 May 2024 06:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714656939; x=1715261739; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k+vx3uqZtejthqbqmPU41zyHFkZccUHvnxUabuUSyMU=;
 b=mEIRZbTBAAIolPSGqAbFmXqWzr1rYdwS8qIhIFcNhdoyYUgOalC6OqefHvHVYDJLvI
 2Et4/8m1MhPexdhfN9arJ/mb5mz1rVUTthMYphZKzROjp31NxXoFsoQLPsqZoLYACyVQ
 0ZkOfy4hDnfppl68YgZPfBlLk0oKBn0OzvsnJFbdRntQxAqagwILK4Xa8Ae0xdHGXKLc
 Hkn4nVIjmNlFc+A8F2TjPqTYqkhUfPBLHx1KC6iHtcu6U14fTpVgSs2PxcUC07ovkbJZ
 kdlJFnJvavmLRvQfUqUz+pP8KVnCtU1IqFoc/iI2bMnhl2Lg5crXmIOltoS8xIFifRW/
 kISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714656939; x=1715261739;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k+vx3uqZtejthqbqmPU41zyHFkZccUHvnxUabuUSyMU=;
 b=DxXGTsp67NA5vukNNLA0Ws7+QcM7RvzHkLd+H8QMN5mTjWLXSgvHiGwifQcNvzPwYh
 xwBkyk81TDQ+b7PMy0A0U2NVp0xmLtaj2VU0FFvbbWomKehArIhkYov9IHJRRzPG4anH
 oOkXKQ99fUNzOf2m551GIh/FgN5wQ5i2yoYIJDWkIVEVLYiJvz8aOopBTCWpYdY+ECLZ
 NZUeOJXiStnNCd63JCs9A0OCKvJWNw60Xhuvvi9RJjAZzOWv4VjSTFXQGsaXdZ+mhbCB
 9N/OcuCa01+KH/Cui643W7x+CWM3Ff8RFmIichiYuoALF6MacjHl2jpeW4G062IUzchd
 IOxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUH1YgT7Z33QZGRUxM2jUJMyb1Qg7z/xJTXuZhkr/Si18nh0StWl+VwvzZwvRBCmf7D5T+eL7b6RsHsP9ytZBsWhgNW8g==
X-Gm-Message-State: AOJu0YwCdg9zEBND+UuRJTK8+BlDJdnf3g9+Z6zo8fjCi71SiErCAc3O
 i0FjvfMscseI9DFvpx80Jb2+Y7zsdyajAnu0nK0zBwQFq4f3kuFtgMWtpnIQCl+0iU2nUeb9+MD
 0iosolg==
X-Google-Smtp-Source: AGHT+IG+5rFW5ZzNHacArWeTKV/xPnbCUsZFMPUu+s2JHqfx1sfOn+ptRqObkSPQ/08HAIgUfH1lHw==
X-Received: by 2002:a17:906:f5a9:b0:a59:766b:d83 with SMTP id
 cm41-20020a170906f5a900b00a59766b0d83mr382469ejd.22.1714656938923; 
 Thu, 02 May 2024 06:35:38 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8bb3? ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 a17-20020a1709065f9100b00a58ca98bbfbsm576361eju.30.2024.05.02.06.35.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 06:35:38 -0700 (PDT)
Message-ID: <d92b9c91-0e21-4695-95b9-61276dc4eac0@linaro.org>
Date: Thu, 2 May 2024 15:35:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] clk/qcom: apq8016: add support for USB_HS clocks
To: Sam Day <me@samcday.com>, u-boot@lists.denx.de
References: <20240502-msm8916-hs-usb-clocks-v1-0-eeccf483b68d@samcday.com>
 <20240502-msm8916-hs-usb-clocks-v1-1-eeccf483b68d@samcday.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240502-msm8916-hs-usb-clocks-v1-1-eeccf483b68d@samcday.com>
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



On 02/05/2024 15:16, Sam Day wrote:
> The newer "register map for simple gate clocks" support added for qcom
> clocks is used. As a result gcc_apq8016 now has a mixture of the old and
> new styles. I didn't (and still don't!) feel comfortable enough in this
> area to update the existing code.
> 
> Some groundwork was also laid to dump the state of these gate clocks
> with the recently-added qcom dump callbacks.

I'm not sure which part of the patch you're referring to, but the dump 
callbacks aren't in upstream yet.
> 
> Signed-off-by: Sam Day <me@samcday.com>
> ---
>   drivers/clk/qcom/clock-apq8016.c | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
> index d3b63b9c1a..745371a289 100644
> --- a/drivers/clk/qcom/clock-apq8016.c
> +++ b/drivers/clk/qcom/clock-apq8016.c
> @@ -17,6 +17,8 @@
>   
>   #include "clock-qcom.h"
>   
> +#define USB_HS_SYSTEM_CLK_CMD_RCGR	0x41010
> +
>   /* Clocks: (from CLK_CTL_BASE)  */
>   #define GPLL0_STATUS			(0x2101C)
>   #define APCS_GPLL_ENA_VOTE		(0x45000)
> @@ -39,6 +41,11 @@
>   /* GPLL0 clock control registers */
>   #define GPLL0_STATUS_ACTIVE BIT(17)
>   
> +static const struct freq_tbl ftbl_gcc_usb_hs_system_clk[] = {
> +	F(80000000, CFG_CLK_SRC_GPLL0, 10, 0, 0),

Since this is just one entry, it probably makes more sense to just put 
the literal values in the clk_rcg_set_rate_mnd(). This makes it clear 
that there's only one actual frequency, and we have the kernel for 
reference anyway.
> +	{ }
> +};
> +
>   static struct pll_vote_clk gpll0_vote_clk = {
>   	.status = GPLL0_STATUS,
>   	.status_bit = GPLL0_STATUS_ACTIVE,
> @@ -52,6 +59,11 @@ static struct vote_clk gcc_blsp1_ahb_clk = {
>   	.vote_bit = BIT(10),
>   };
>   
> +static const struct gate_clk apq8016_clks[] = {

Please define the size of this array, or add a bounds check in 
apq8016_clk_enable() (I know this is missing for some of the other drivers).
> +	GATE_CLK(GCC_USB_HS_AHB_CLK,    0x41008, 0x00000001),
> +	GATE_CLK(GCC_USB_HS_SYSTEM_CLK,	0x41004, 0x00000001),
> +};
> +
>   /* SDHCI */
>   static int apq8016_clk_init_sdc(struct msm_clk_priv *priv, int slot, uint rate)
>   {
> @@ -106,6 +118,7 @@ int apq8016_clk_init_uart(phys_addr_t base, unsigned long id)
>   
>   static ulong apq8016_clk_set_rate(struct clk *clk, ulong rate)
>   {
> +	const struct freq_tbl *freq;
>   	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
>   
>   	switch (clk->id) {
> @@ -117,13 +130,31 @@ static ulong apq8016_clk_set_rate(struct clk *clk, ulong rate)
>   	case GCC_BLSP1_UART2_APPS_CLK: /* UART2 */
>   		apq8016_clk_init_uart(priv->base, clk->id);
>   		return 7372800;
> +	case GCC_USB_HS_SYSTEM_CLK:
> +		freq = qcom_find_freq(ftbl_gcc_usb_hs_system_clk, rate);

As there is only one valid "rate" for this clock, I would be in favour 
of a log_warn() if the rate is wrong (it should be 80000000).

Thanks and regards,
> +		clk_rcg_set_rate_mnd(priv->base, USB_HS_SYSTEM_CLK_CMD_RCGR,
> +		                     freq->pre_div, freq->m, freq->n, freq->src, 0);
> +		return freq->freq;
>   	default:
>   		return 0;
>   	}
>   }
>   
> +static int apq8016_clk_enable(struct clk *clk)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +	debug("%s: clk %s\n", __func__, apq8016_clks[clk->id].name);
> +	qcom_gate_clk_en(priv, clk->id);
> +
> +	return 0;
> +}
> +
>   static struct msm_clk_data apq8016_clk_data = {
>   	.set_rate = apq8016_clk_set_rate,
> +	.clks = apq8016_clks,
> +	.num_clks = ARRAY_SIZE(apq8016_clks),
> +	.enable = apq8016_clk_enable,
>   };
>   
>   static const struct udevice_id gcc_apq8016_of_match[] = {
> 

-- 
// Caleb (they/them)
