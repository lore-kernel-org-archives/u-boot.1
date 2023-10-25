Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6C8C07545
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 13:44:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E26887A9C;
	Wed, 25 Oct 2023 15:44:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zjHkUkp8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B6BC87AC1; Wed, 25 Oct 2023 15:44:12 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1BCB87A9C
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 15:44:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32daeed7771so3756544f8f.3
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 06:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698241447; x=1698846247; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pgMEiQ9qrI5jzcjUzxc8cGJlWvarPMd4Fd2pY1VVN9g=;
 b=zjHkUkp8MUuDRMZC+4wJS2nDhfkuD1us7Ke2jLugE4XBCYFTWQNJkFEmQY+lBa5BZT
 WQLP/Lb/mHwbt2CEjZm6Pl45iAHqos8V9Hf0w+kNmlpCOJ0v9CxM44kBoyEJH+JN8g4U
 c0nJjvoKM47YNOAbL5sCyLNvh1JqCCsmixiiw+mGI2so4TOuKSy8RpFbmr9VlSE5q/xn
 vZoPNazhwRElYdl9/I82Ux8Bs86zsPMkhbZegrV8p0l6FwZEi8M+YoE3QfX8U3LP3tJA
 CZj0225GURXen22GSmglCqxi1cssxGmy7Th8tNVr7ZKq+faY+bcGPqC/jXwLm2WLEUaE
 RLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698241447; x=1698846247;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pgMEiQ9qrI5jzcjUzxc8cGJlWvarPMd4Fd2pY1VVN9g=;
 b=FIBpRdZn03mL80pagdINhPUmyO/xZSUhazH2Ln0GHXg3RlNnV5/76YftntnN7bDlYC
 oXMNcnPZ3uDoH2i1hNjKxE5Dz3uXNVxCh66RL2gS4E40yzmCasQJIfLxvYz33D4wC3+N
 THJFweZQ03FB2G5iDnMSe+DjQzJhhrP3R13vD+3dbdgPx60lhmBod0tQX+I3iLZtjFem
 Te4AbKOv6Iz49N8vCHZbmQMIeCK1r/MFORsSuVuN97gTDhHT93CXCk65ioKP6kNu4q3K
 g0b9DE+3AAmMw5jEDW7AjKwVmYR2S90huqoqgvn8yMW+tg3gID0TacVIe9CXc1n/G6Y1
 OFtg==
X-Gm-Message-State: AOJu0YxHRAHx9jO8q/edHKlIVoGZ+rmHLzjC2WS2EeSY1LMK3kt5BMCz
 ZrLN2hmypOrepq6bF/nTUiNhMA==
X-Google-Smtp-Source: AGHT+IHRA4zK6DtaskyeHCB+gxQ2U0GU9hNgFtnz3LWHLw4xlUFIb0f3lnJ6742sQswMwfHWSGkEPw==
X-Received: by 2002:adf:f78b:0:b0:32d:a6f5:a511 with SMTP id
 q11-20020adff78b000000b0032da6f5a511mr9700710wrp.13.1698241447239; 
 Wed, 25 Oct 2023 06:44:07 -0700 (PDT)
Received: from [192.168.1.15] (host-2-99-112-229.as13285.net. [2.99.112.229])
 by smtp.gmail.com with ESMTPSA id
 n11-20020adffe0b000000b0032dbf26e7aesm12050844wrr.65.2023.10.25.06.44.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 06:44:06 -0700 (PDT)
Message-ID: <184a6ae1-b911-4197-b311-645f4f795bae@linaro.org>
Date: Wed, 25 Oct 2023 14:44:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] clk/qcom: fix rcg divider value
Content-Language: en-US
To: Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Bharat Gooty <bharat.gooty@broadcom.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Luka Kovacic <luka.kovacic@sartura.hr>, Luka Perkov <luka.perkov@sartura.hr>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, u-boot@lists.denx.de
References: <20231024-b4-qcom-clk-v1-0-9d96359b9a82@linaro.org>
 <20231024-b4-qcom-clk-v1-8-9d96359b9a82@linaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20231024-b4-qcom-clk-v1-8-9d96359b9a82@linaro.org>
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



On 24/10/2023 21:23, Caleb Connolly wrote:
> The RCG divider field takes a value of (2*h - 1) where h is the divisor.
> This allows fractional dividers to be supported by calculating them at
> compile time using a macro.
> 
> However, the clk_rcg_set_rate_mnd() function was also performing the
> calculation. Clean this all up and consistently use the F() macro to
> calculate these at compile time and properly support fractional divisors.
> 
> Additionally, improve clk_bcr_update() to timeout with a warning rather
> than hanging the board, and make the freq_tbl struct and helpers common
> so that they can be reused by future platforms.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

[...]
>  
>  #define CFG_MODE_DUAL_EDGE (0x2 << 12) /* Counter mode */
>  
> -#define CFG_MASK 0x3FFF
> +// Disable the HW_CLK_CONTROL bit
> +#define CFG_MASK (0x3FFF | (1 << 20))

There seems to be a bug in this patch that causes the actual clock rate
to be wrong in some cases, most obvious with db845c UART. I had
initially thought it to be a board issue but upon further investigation
I think I'm wrong.

The UART clock frequency table in clock-sdm845.c is taken from Linux,
the 115200 baud rate corresponds to the lowest frequency (7372800Hz).
However, with the implementation changes here, the RCG configuration
actually results in a measured clock rate of 9085208Hz.

If the entry is changed as follows
-	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625)
+	F(7372800, CFG_CLK_SRC_GPLL0, 0.5, 192, 15625)

Then the resultant clock rate is 7372604Hz (within the tolerance)...

I will resolve this for v2.
>  
>  #define CFG_DIVIDER_MASK 0x1F
>  
> -/* root set rate for clocks with half integer and MND divider */
> +/*
> + * root set rate for clocks with half integer and MND divider
> + * div should be pre-calculated ((div * 2) - 1)
> + */
>  void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
>  			  int div, int m, int n, int source, u8 mnd_width)
>  {
> @@ -99,17 +125,15 @@ void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
>  	/* Program MND values */
>  	setbits_le32(base + regs->M, m_val & mask);
>  	setbits_le32(base + regs->N, n_val & mask);
> -	setbits_le32(base + regs->D, d_val & mask);
> +	setbits_le32(base + regs->D, (d_val & mask) == mask ? 0 : (d_val & mask));
>  
>  	/* setup src select and divider */
>  	cfg  = readl(base + regs->cfg_rcgr);
>  	cfg &= ~CFG_MASK;
>  	cfg |= source & CFG_CLK_SRC_MASK; /* Select clock source */
>  
> -	/* Set the divider; HW permits fraction dividers (+0.5), but
> -	   for simplicity, we will support integers only */
>  	if (div)
> -		cfg |= (2 * div - 1) & CFG_DIVIDER_MASK;
> +		cfg |= div & CFG_DIVIDER_MASK;
>  
>  	if (n_val)
>  		cfg |= CFG_MODE_DUAL_EDGE;

-- 
// Caleb (they/them)
