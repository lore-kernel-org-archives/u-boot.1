Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA4FC87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 13:23:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F1D983990;
	Fri, 25 Jul 2025 15:23:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rNto1eXL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAD6D83993; Fri, 25 Jul 2025 15:23:55 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70BCA8398C
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 15:23:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45555e3317aso11869075e9.3
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 06:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753449833; x=1754054633; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ixARUCEq5bEkqL/JvqusyItOduS5+N6vlFsWeRfX/dA=;
 b=rNto1eXLx8jynFFidhRCgAUlBIU6b/fXrLvRrZBVUTo1ICQvJUfXaWStPWLnSzEYe6
 dRvNWBYmWXfoiSPXHOU8sOfnubJHIL48cxJxJEUpspw1bgGmCJypG02aR5T/mESCORaL
 fwea/8YKMANcaTYz5tA1z33+xm+GLzI047u/K9WbI8jkQodhD9jCVnyGiwUamY3mMq8y
 1nAsKD1HpCe0awLsUVlPva+bf0/oFz3AQrx51GeACpM3qr67vpn/YAq6bKNklEIDynLJ
 3RrI7zBws5UFzt5v8lVpaixLv9pvgxV+zfaRGnMNdQsJb8lsLq19Btbtcs6+CfNiNS4E
 U5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753449833; x=1754054633;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ixARUCEq5bEkqL/JvqusyItOduS5+N6vlFsWeRfX/dA=;
 b=ZkoCU7JLZtF/T7dq/c9v8slrjSm9wFgOBYExXv5UCa5B6AY5N1UdF1aeT6WVcxz4SU
 /cvhEnAyi9HkScegHCqRp/9b7ijW8GCM44SKMwTrPOunX+u1flh919zy3klroBwtHW/z
 yhJ6TcR33QTRzioCoEXbrSG04k3r4PbqhnBaH6VGRCEMHLvzq+t4v/T3ReGDDiSe58Bp
 AuzdOsSWppo/aQbytUw00+16iDBMnUCCyA8aD8e6N/agyevms2yRmvvuJgY5w8eb+w60
 OI0xI+ioo84xYt41BjRNiOsawTuQDYB4w7/i7SqbeDT2ZD26Krl2ZfjvjZK2aM9n5kbp
 DVKQ==
X-Gm-Message-State: AOJu0YxFu4oJ8Q2V65a3dfqot2vFCfYF+beqKIhQfgC/67+8nCElRUIG
 PxzP+P3SsWBVLMTeOMK32UQ6qK4ofeqLyXLi68zLmS+Pxpx8xmHAcMxiilCZn3jpzZg=
X-Gm-Gg: ASbGnctzkXbEcxFCVS3zk5sZNU6pHstQQCMJuDTetXPwYTFun56p9nr0l0hyy0v6HBT
 0GkRirfv1TzxVmpvurvcg4DeVKqfilHNzny7E9wAHAgs76vR9JqygugGU6FA5sVz4GnimFaBasn
 6QjNVX55BhjqR2mJOZDxz61fIIEPTr6WI146vi+9a32mQKpwz3C3K+ifBQN+UkqF76+0CPz7exI
 1InDlNnKlnsjfXUWe8EWC5ElEW/HHO/jie/vunTfq/w4qOXpphsLGSgLp0gIQeYTbzkYs5KwWw9
 RRl/ln6tJQBdYGqt+ILMVuAqn0W5OUtFLdPDktuwlf9yTEx4SlVQ7A7zH2DL79E6/pDxyQIFzDG
 msAYJHA0WrBh6ySfl05uxOEMBR21k/J1mL2APNvKbmGwkuG2PjibHLrwe7d+mAGM=
X-Google-Smtp-Source: AGHT+IEcOSE1rcRHwR9i4oxWPzVPFiRWlbmw0g3mQdIpYfJFsjYfx81eUCD3u6tjIlsHnmX99Hl7fw==
X-Received: by 2002:a05:600c:4ed1:b0:456:e98:9d17 with SMTP id
 5b1f17b1804b1-4587630365cmr18369725e9.5.1753449832853; 
 Fri, 25 Jul 2025 06:23:52 -0700 (PDT)
Received: from [192.168.1.37] (p549d4bd0.dip0.t-ipconnect.de. [84.157.75.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4586eef77e8sm41231895e9.3.2025.07.25.06.23.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 06:23:52 -0700 (PDT)
Message-ID: <8dfaba78-110e-4658-a77e-3ebfa2534f6e@linaro.org>
Date: Fri, 25 Jul 2025 15:23:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] clk/qcom: Add SM6350 clock driver
Content-Language: en-US
To: Luca Weiss <luca.weiss@fairphone.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250618-sm6350-bringup-v1-0-3cc22aab7a7a@fairphone.com>
 <20250618-sm6350-bringup-v1-1-3cc22aab7a7a@fairphone.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250618-sm6350-bringup-v1-1-3cc22aab7a7a@fairphone.com>
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

Hi Luca,

On 18/06/2025 16:25, Luca Weiss wrote:
> Add Clock driver for the GCC block found in the SM6350 SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/clk/qcom/Kconfig        |   8 ++
>  drivers/clk/qcom/Makefile       |   1 +
>  drivers/clk/qcom/clock-sm6350.c | 194 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 203 insertions(+)
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 3ea01f3c969a3456a7c2ebf731b8b74b66d93f96..e0e91dadd854e6e3a7beb1ef351734a5ab77787f 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -79,6 +79,14 @@ config CLK_QCOM_SM6115
>  	  on the Snapdragon SM6115 SoC. This driver supports the clocks
>  	  and resets exposed by the GCC hardware block.
>  

[snip]

> +static ulong sm6350_set_rate(struct clk *clk, ulong rate)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +	const struct freq_tbl *freq;
> +
> +	if (clk->id < priv->data->num_clks)
> +		debug("%s: %s, requested rate=%ld\n", __func__,
> +		      priv->data->clks[clk->id].name, rate);
> +
> +	switch (clk->id) {
> +	case GCC_QUPV3_WRAP1_S3_CLK: /*UART9*/
> +		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap1_s3_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, GCC_SE12_UART_RCG_REG,
> +				     freq->pre_div, freq->m, freq->n, freq->src,
> +				     16);
> +
> +		return freq->freq;
> +	case GCC_SDCC2_APPS_CLK:
> +		/* Enable GPLL7 so that we can point SDCC2_APPS_CLK_SRC at it */
> +		clk_enable_gpll0(priv->base, &gpll7_vote_clk);
> +		freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
> +		printf("%s: got freq %u\n", __func__, freq->freq);

Please drop this printf, then add

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

I think we'll have to do some kind of improvement around the frequency
selection stuff eventually... Not the end of the world today as we'll at
least get warnings if something goes wrong due to DTS or driver changes.

Kind regards,

-- 
// Casey (she/her)

