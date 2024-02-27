Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA55BC48BF6
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 02:48:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFC8A87F7D;
	Tue, 27 Feb 2024 03:48:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uob3xLs5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC27C87F80; Tue, 27 Feb 2024 03:48:10 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C1A587F7D
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 03:48:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-412ad34f3adso1001045e9.2
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709002088; x=1709606888; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZFvV7U+wXF34Kaj7qT+2D6pSA5BVn3UwMjhd3pzUabA=;
 b=uob3xLs5YaHTyMbzW9EZ6qbcOlD/0DbcME/8cNIi0CYSG9cbZIRZ8hNVYRI7pQnvPb
 E0vRM9bFKZsgXQOL5WQ7pGTrb0CSCeD2ausk0FbAhBnF0YGgXbMhWctkAIEBgYWm1rAb
 Wxzr28c22lmuCWvI8qEEENapjmboCRnUavJ/o/SURq2vILTbM2Wy8R9V/HbooO3pZIao
 cGYM+gtRDHnS612E/4+dRytmsHY0A/KSNzESw0pKhdT/prkgqqU6Z0WAaUrQELHBTnv2
 YMw0xlgmrtPNZe2kWh+DiPvGvEQ9E4ZaT2NAZQJESUWR+KGGhCjKEnGDUOEPnZLzgcph
 j4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709002088; x=1709606888;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZFvV7U+wXF34Kaj7qT+2D6pSA5BVn3UwMjhd3pzUabA=;
 b=MRY+63jT7xeJREMFMvDogcBMio419YoUuuEmL4oKVpn+EktE/z9t1b5E5JQ6dpHZKi
 QUx8KIIemfLUa3DBghlA/k0C3K3rrFVZDC94eyx3b0rQqsS2x8VTYIFkOVQx96gNcukk
 b7CfYveHRoBr1tKBpzkp+qi8nRSerFS3cuDkjMPkKK1/lYG4/SiT2nmDD5t0jTO9FkMH
 VMg9M3eOOI5TYnQa5+D3ytxDwyL4kBWhv/3KndR+DPLUNOByhYkcf1VxvAe5PdGJxlxM
 q04HIChujGiMEfwdTFOQMzH3nGeZy1yMwTnNuRFsV9k+ay/RGK8DUkRmRxxVbcVlAMbH
 r5xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUWk546WJHj1yyMqCzM2PDRweoV9StPeGhSAFe/8x/cdpsr/yF8IfsbTNfl2dqUC3jJ30L4PQcOqigWSLslgNEHLwOXg==
X-Gm-Message-State: AOJu0YzUGlZJe2+S2AeT6zvahmg0xWyoVMFrabGU/PeSrmuq1Ivdg3p1
 oPbChhMApyK8jJNX2PfSbxU+Ri4ns6BrBXU0Ot8A1mg7BolE0uWqT5eay1C9PwA=
X-Google-Smtp-Source: AGHT+IH4qbWBihxf07RSdWt9/5VlrBvbScQFt5ecSwp6ECYiwzbkUtMF6w+fKVeMPVaSdamkBpULpg==
X-Received: by 2002:adf:f891:0:b0:33d:82c5:3b76 with SMTP id
 u17-20020adff891000000b0033d82c53b76mr6205904wrp.14.1709002087921; 
 Mon, 26 Feb 2024 18:48:07 -0800 (PST)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bj20-20020a0560001e1400b0033db0c866f7sm10027559wrb.11.2024.02.26.18.48.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 18:48:07 -0800 (PST)
Message-ID: <983777e4-bcde-4ecd-8915-8d9b0cff27be@linaro.org>
Date: Tue, 27 Feb 2024 02:48:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] clk/qcom: Add support for clock registers in IPQ9574
Content-Language: en-US
To: Varadarajan Narayanan <quic_varada@quicinc.com>, u-boot@lists.denx.de
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Lukasz Majewski
 <lukma@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20240226100807.1095607-1-quic_varada@quicinc.com>
 <20240226100807.1095607-4-quic_varada@quicinc.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240226100807.1095607-4-quic_varada@quicinc.com>
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



On 26/02/2024 10:08, Varadarajan Narayanan wrote:
> The BCR registers in IPQ9574 are different and have
> different fields. Add function to program these
> clocks accordingly.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> 
>  drivers/clk/qcom/clock-qcom.c | 32 ++++++++++++++++++++++++++++++++
>  drivers/clk/qcom/clock-qcom.h |  8 ++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
> index 7c683e5192..fe60490186 100644
> --- a/drivers/clk/qcom/clock-qcom.c
> +++ b/drivers/clk/qcom/clock-qcom.c
> @@ -156,6 +156,38 @@ void clk_rcg_set_rate(phys_addr_t base, const struct bcr_regs *regs, int div,
>  	clk_bcr_update(base + regs->cmd_rcgr);
>  }
>  
> +#define CFG_MASK 0x3FFF
Please define this in terms of the individual register fields.
> +
> +#define CFG_DIVIDER_MASK 0x1F
This is just CFG_SRC_DIV_MASK, please use that instead.
> +
> +/* root set rate for clocks without the MND divider */
Please adjust this comment to explain what's different about v2 and
where it's relevant (is it just IPQ SoCs? Or "some IPQ SoCs"?).
> +void clk_rcg_set_rate_v2(phys_addr_t base, const struct bcr_regs_v2 *regs,
> +			 int div, int cdiv, int source)
As far as I can tell, this is like the RCG clocks in that the cfg
register is always cmd + 4 and div_cdivr is always cfg + 4.

In this case let's simplify this and save a whole lot of lines by just
passing in the cmd register address and using offsets for the others.
There's no need to specify all these manually. See
https://lore.kernel.org/u-boot/20240131-b4-qcom-livetree-v1-4-4071c0787db0@linaro.org/
> +{
> +	u32 cfg;
> +
> +	/* setup src select and divider */
> +	cfg  = readl(base + regs->cfg_rcgr);
> +	cfg &= ~CFG_MASK;
> +	cfg |= source & CFG_CLK_SRC_MASK; /* Select clock source */
> +
> +	/*
> +	 * Set the divider; HW permits fraction dividers (+0.5), but
> +	 * for simplicity, we will support integers only
> +	 */
> +	if (div)
> +		cfg |= div & CFG_DIVIDER_MASK;
> +
> +	writel(cfg, base + regs->cfg_rcgr); /* Write new clock configuration */
> +
> +	/* Write the common divider clock configuration */
> +	if (regs->div_cdivr)
> +		writel(cdiv, base + regs->div_cdivr);
> +
> +	/* Inform h/w to start using the new config. */
> +	clk_bcr_update(base + regs->cmd_rcgr);
> +}
> +
>  const struct freq_tbl *qcom_find_freq(const struct freq_tbl *f, uint rate)
>  {
>  	if (!f)
> diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
> index 01088c1901..95f6162ea4 100644
> --- a/drivers/clk/qcom/clock-qcom.h
> +++ b/drivers/clk/qcom/clock-qcom.h
> @@ -32,6 +32,12 @@ struct bcr_regs {
>  	uintptr_t D;
>  };
>  
> +struct bcr_regs_v2 {
> +	uintptr_t cfg_rcgr;
> +	uintptr_t cmd_rcgr;
> +	uintptr_t div_cdivr;
> +};> +
>  struct freq_tbl {
>  	uint freq;
>  	uint src;
> @@ -86,6 +92,8 @@ void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
>  			  int div, int m, int n, int source, u8 mnd_width);
>  void clk_rcg_set_rate(phys_addr_t base, const struct bcr_regs *regs, int div,
>  		      int source);
> +void clk_rcg_set_rate_v2(phys_addr_t base, const struct bcr_regs_v2 *regs,
> +			 int div, int cdiv, int source);
>  
>  static inline void qcom_gate_clk_en(const struct msm_clk_priv *priv, unsigned long id)
>  {

-- 
// Caleb (they/them)
