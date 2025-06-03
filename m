Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B569BC5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 15:05:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23EFD82A8D;
	Tue,  3 Jun 2025 17:05:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RnoYdJ24";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85E4F82B00; Tue,  3 Jun 2025 17:05:50 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7898C82A76
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 17:05:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-442fda876a6so51231345e9.0
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 08:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748963148; x=1749567948; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LvRNDTmH/Gzq1BRUIlq9jIEKQWPKG4x4YH+2S98/VvM=;
 b=RnoYdJ24fWBrInlvk6vBCXuMx56tL18pAIh0llDAqxbO8GDV2yJ5pxM4FaHgCESS7p
 QxCfh9T2UEnDrxq03zM0tOwzIrdrLyd2UUeUibWDDmoafno2iijbm6i+8s1MRmL5esYX
 FZxX6wv0+V1MDpNc6ytgv4vZ8AUraGFuC60lKYr0Lz29zoFcfxZ2R3Hpt7/oU4xDn/e5
 IHyVmbJBaffz6axRHyCpzkf7i9a4CcwQoXycUHP9k1Ctl1KhctKeNlXjbuK9HpPHMd4u
 aZLwY658DiZoicSFasfWIQc5qc2AUw3Qg/bEeGl+YdRrW+3z6jJxVX91mWvwMb20HvUE
 YwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748963148; x=1749567948;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LvRNDTmH/Gzq1BRUIlq9jIEKQWPKG4x4YH+2S98/VvM=;
 b=O0BUQxj2oPrpXCJXmbdaH5+OkYTlx79zvhytd4EEEkKD8rkJ5KA/T4UNbuRUwoK4mw
 tWupa+JXAlTfWaXGTXXvuLS3sax+uDPJffOQMU1kEGitI7S67Rl0kC/fRBxt5Tvy1d7n
 3lG6alGhNbkOIvMeaZhhYmBTbsMU0iR35ONrePGO5sIsFcWMeetd/d8fOFZ2WjgEiqRA
 zSJUDS6/kFzmR/duZNNST8ESWzPBjLh/qeeiJgNsqKvMjwpxLiNKBdWxUClyT1l9vfRi
 0zGMrFSXhsmiCl7h4hHN5Qgu06wK5yRgSbD0TV4iZbQV+T5r1q5P/Iw6lcc7UItihOfn
 C/Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhWwTs6DFHz8HUJbNyuxexPwtjOz4kUnlBF9PVwPUpiMYe3xOad2Ubem5DWA01H0Br/8mSUfo=@lists.denx.de
X-Gm-Message-State: AOJu0YyPMl2okHOVZTOqj6Ee3qgjvuXRNYWNE8wii+IXwzBNap/Bj5ro
 YbgP5puWhD0nyYB1rwQ5+IPTHKcNAAurATuL9TtktbLYOqBCZFY8T9a/wGph+SReW+A=
X-Gm-Gg: ASbGncvjWkFpsytiJgqYZ74TtEP3boEISt46uFsToH3fVUpuoLP/CrPW+nOdvqs0i6K
 50T0GrXvrpV/UfT9ikoK5Riiji0cZ0WeAYUM4Hd3EdmaHMy/msnA+9FR2c9dpvlYukYKnKc5SqO
 bqhDJ2BcUzrC9ipXIbsz8vawBsdAxKa0Zce6Ht+CD1mWRrd4zMGbD+/P5qL9YNe8AxHZG7uPhyx
 82drTezv5jOCNeJoszIeZvOARb9RYBnN/eRL4QflV/SPfb6g5CUs/l30iERGVwWBijPgQk4UgPB
 hPIetc5ibC5LkcQDeFsdrxI3D6C1+Xf+N6SlqkS94QgmvmbtSXuvnp43YGdEWojVg9RaJSC47Ui
 tRRIhPrctEpEiujybNhNXiMDevg==
X-Google-Smtp-Source: AGHT+IHmFoFidyj3I8+a+2BO5uoGM0cZRW6ZmI5pASPUrlmHadY02JAzrJply5VJDZwFaQT90J7Odg==
X-Received: by 2002:a05:600c:5251:b0:43d:47b7:b32d with SMTP id
 5b1f17b1804b1-451221a223emr97828485e9.25.1748963146789; 
 Tue, 03 Jun 2025 08:05:46 -0700 (PDT)
Received: from ?IPV6:2a01:170:117e:fc:e089:f4a9:4c4d:e359?
 ([2a01:170:117e:fc:e089:f4a9:4c4d:e359])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7f8f188sm166607435e9.3.2025.06.03.08.05.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 08:05:46 -0700 (PDT)
Message-ID: <9e9e8f05-4703-4989-a263-8ec05029abb7@linaro.org>
Date: Tue, 3 Jun 2025 17:05:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/28] clk: qcom: Support uart clk on sc7280 CRD
To: Stephen Boyd <swboyd@chromium.org>, u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
References: <20250523225845.2311989-1-swboyd@chromium.org>
 <20250523225845.2311989-5-swboyd@chromium.org>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250523225845.2311989-5-swboyd@chromium.org>
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



On 5/24/25 00:58, Stephen Boyd wrote:
> Support setting the frequency of the UART clk on sc7280 so that the
> serial console works on devices like hoglin.
> 
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>   drivers/clk/qcom/clock-sc7280.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
> index 9aff8a847ad1..b9152c129df1 100644
> --- a/drivers/clk/qcom/clock-sc7280.c
> +++ b/drivers/clk/qcom/clock-sc7280.c
> @@ -38,6 +38,22 @@ static const struct freq_tbl ftbl_gcc_usb30_sec_master_clk_src[] = {
>   	{ }
>   };
>   
> +static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s2_clk_src[] = {
> +        F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
> +        F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
> +        F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
> +        F(29491200, CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
> +        F(32000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 75),
> +        F(48000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 25),
> +        F(52174000, CFG_CLK_SRC_GPLL0, 1, 2, 23),
> +        F(64000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 16, 75),
> +        F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
> +        F(80000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 15),
> +        F(96000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 25),
> +        F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
> +        { }

FYI your formatting got messed up here and it's indented with spaces. 
I'll fix it up while applying.

> +};
> +
>   static ulong sc7280_set_rate(struct clk *clk, ulong rate)
>   {
>   	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> @@ -47,6 +63,11 @@ static ulong sc7280_set_rate(struct clk *clk, ulong rate)
>   		debug("%s: %s, requested rate=%ld\n", __func__, priv->data->clks[clk->id].name, rate);
>   
>   	switch (clk->id) {
> +	case GCC_QUPV3_WRAP0_S5_CLK: /* UART5 */
> +		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s2_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, 0x17600,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 16);
> +		return freq->freq;
>   	case GCC_USB30_PRIM_MASTER_CLK:
>   		freq = qcom_find_freq(ftbl_gcc_usb30_prim_master_clk_src, rate);
>   		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR,
> @@ -107,6 +128,7 @@ static const struct gate_clk sc7280_clks[] = {
>   	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x52008, BIT(10)),
>   	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK, 0x52008, BIT(11)),
>   	GATE_CLK(GCC_QUPV3_WRAP0_S3_CLK, 0x52008, BIT(13)),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S5_CLK, 0x52008, BIT(15)),
>   	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x77010, BIT(0)),
>   	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x770cc, BIT(0)),
>   	GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x77018, BIT(0)),

-- 
Casey (she/they)

