Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32A2CCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 18:44:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F02B83621;
	Tue, 30 Sep 2025 20:44:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Rl9YUtDW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38CFD8362C; Tue, 30 Sep 2025 20:44:54 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E81D834D4
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 20:44:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e52279279so20228625e9.3
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 11:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759257891; x=1759862691; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=wJ0Ok0bNNkm3W6rv+ypY2VFMbEu2k40L19GncgQJgDs=;
 b=Rl9YUtDWBUiK+c7mw1ZaKEJcSMvwZrLIMjzjkzshrA3XPV5/nmQIiFBcvCBKUilYIo
 0tIsG70wk8gM+pGKzwN4JOeLkiHx1FlZ886cNaj+jEqniOSVqqJrihyBbFLM2YQEzboD
 t9oa4Lk47lKgpmIu7zB7OHif/+fmy5uyDhi9+Wmvs/iT1FgkfbO3XFZVmjJoqwtCIqGh
 LVJyvzvpKUO2tSjRn1WI5c7GJ8Rmad0R0THUl4E71IueALMf+WR3tHjVfeKvyvn+vRq8
 QXLQD7W+GEezrZnA3B1/cNJQw29itlTOG3mYku0EWF5aJqp+MtSuKY020AnXnzlUgCYp
 2yXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759257891; x=1759862691;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wJ0Ok0bNNkm3W6rv+ypY2VFMbEu2k40L19GncgQJgDs=;
 b=mY1T5i3xoga6342G7Ap5uGx+QN2f33L4hLibW44pGXwsw+/sIyV2Fr1oEXHGIH4T3r
 aWyk2IPJg/TZSCghCqS37TSQeAkKfTiyWspeknbPx+VHsAvZsPpzh69+C0ZC7/TZWHOO
 x0WCUqip70DYbv18ynlakmeDY/SiL0LlVCWA9BS+8XV2Iqvy4xbnk/FwvCAqjv7WNmVS
 Q8gd1W3zIrN0DUbqfDHJtBJLlNkGDJ1SV+5QsusKTHosUl1ZJ+4ngkVolbr9SE9B/NwN
 GtS8fISVDW48WXlfb3TeNgmQX3JjoQOZQTFGgoCIQqZkmdN62k3UIs4jfs9ZBUL8uBB9
 N8Vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL/bJSayMi96KINKcJ6DboXcSXArwi7oHCGrpoJL4U1c1mVGraQQ/YJL2J3Uc7qlnRYSHfrr0=@lists.denx.de
X-Gm-Message-State: AOJu0YzQlnGs5OnTfg+pqX9nB+7xHAhNTYvYqvi80cZ9woT1ohDMxuN4
 6QlgN4bKHGOaR3jDug2JV45A2w710UG1ZiIQAOiUCT+vr4KNHMbfjR0bPjrhSsPFchQ=
X-Gm-Gg: ASbGnctg5dGCAQrBwSLn5NcYoID7lxhQUq16BSbwj+0B3AsFh8O1EjEUy86KBnuWrS/
 fCVCdbPTPrVB4lcvX1v0gb1G9hC1QUhKPkat9prLwa9DTd/tWCKj/Q73i3O/kv+2NKH8/9lhfQM
 Ml0BT0hS6CjeIhWtohXWJIEFl8u67HOh7zFNjdIqB27wL/3iAWX0ljmB4JBuAV5dL0nqPf9c9T+
 x4tiRFl4nZRxWSnE8uEluVR80CUwTcax3LFYaDkPMUYu40RIk8CbuqN4zw2UaxntASu0V2fuUjC
 nTnURHYT10ZLooUv65I70TTxdxB9X/fs/jujD8k4Wt0NjXZ8SwMXU9KAxCvXYUuTUs7dDbxt68T
 K0I3A5yviqc3/XlQjWLddhqUXqPkZv1+iABke6XQwJ0ijzITyHeovTQAtUf92qHTx00gUt+opff
 kWKEitK+Wlvnj88wGmlMDM15RcgSxTRhoA3A==
X-Google-Smtp-Source: AGHT+IHZIVpLFttTWu3+nA+GWx07lYqJsQZ4Mvb1dzCGkaN2u5W53xigNu61Fn0JvrYdAEnyhMMLXg==
X-Received: by 2002:a05:600c:8b83:b0:46e:49fb:4776 with SMTP id
 5b1f17b1804b1-46e61216b48mr7701425e9.11.1759257891318; 
 Tue, 30 Sep 2025 11:44:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:9459:14e0:525e:d859?
 ([2a01:e0a:3d9:2080:9459:14e0:525e:d859])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619b3b61sm4698955e9.18.2025.09.30.11.44.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 11:44:50 -0700 (PDT)
Message-ID: <0aa3025b-d2bb-4a8e-b0c3-ccc934b77fb3@linaro.org>
Date: Tue, 30 Sep 2025 20:44:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/5] clk/qcom: sdm845: add support for sdm670
To: David Wronek <david.wronek@mainlining.org>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julius Lehmann <lehmanju@devpi.de>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rui Miguel Silva <rui.silva@linaro.org>, Sam Day <me@samcday.com>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: linux@mainlining.org, ~postmarketos/upstreaming@lists.sr.ht,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250914-sdm670-v1-0-a344024062ab@mainlining.org>
 <20250914-sdm670-v1-2-a344024062ab@mainlining.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20250914-sdm670-v1-2-a344024062ab@mainlining.org>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/14/25 11:42, David Wronek wrote:
> The global clock controller on SDM670 is similar to SDM845, so let's add
> support here.
> 
> Signed-off-by: David Wronek <david.wronek@mainlining.org>
> ---
>   drivers/clk/qcom/clock-sdm845.c | 127 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 127 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
> index 5c8702ef2fe00a46a30dbdfddd6e649d20465006..c9a057cf6f9b0cbe4c285b98e888d8528dfec8d9 100644
> --- a/drivers/clk/qcom/clock-sdm845.c
> +++ b/drivers/clk/qcom/clock-sdm845.c
> @@ -23,6 +23,7 @@
>   #define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf018
>   #define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf030
>   #define USB3_PRIM_PHY_AUX_CMD_RCGR 0xf05c
> +#define SDCC1_APPS_CLK_CMD_RCGR 0x26028
>   #define SDCC2_APPS_CLK_CMD_RCGR 0x1400c
>   
>   static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
> @@ -44,6 +45,18 @@ static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
>   	{ }
>   };
>   
> +static const struct freq_tbl ftbl_gcc_sdcc1_apps_clk_src[] = {
> +	F(144000, CFG_CLK_SRC_CXO, 16, 3, 25),
> +	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
> +	F(20000000, CFG_CLK_SRC_GPLL0_EVEN, 5, 1, 3),
> +	F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 1, 2),
> +	F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
> +	F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
> +	F(192000000, CFG_CLK_SRC_GPLL6, 2, 0, 0),
> +	F(384000000, CFG_CLK_SRC_GPLL6, 1, 0, 0),
> +	{ }
> +};
> +
>   static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
>   	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
>   	F(9600000, CFG_CLK_SRC_CXO, 2, 0, 0),
> @@ -55,6 +68,22 @@ static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
>   	{ }
>   };
>   
> +static ulong sdm670_clk_set_rate(struct clk *clk, ulong rate)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +	const struct freq_tbl *freq;
> +
> +	switch (clk->id) {
> +	case GCC_SDCC1_APPS_CLK:
> +		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, SDCC1_APPS_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 8);
> +		return freq->freq;
> +	default:
> +		return 0;
> +	}
> +}
> +
>   static ulong sdm845_clk_set_rate(struct clk *clk, ulong rate)
>   {
>   	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> @@ -76,6 +105,54 @@ static ulong sdm845_clk_set_rate(struct clk *clk, ulong rate)
>   	}
>   }
>   
> +static const struct gate_clk sdm670_clks[] = {
> +	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK,		0x8201c, 0x00000001),
> +	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK,		0x0502c, 0x00000001),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK,		0x5200c, 0x00000400),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK,		0x5200c, 0x00000800),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK,		0x5200c, 0x00001000),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S3_CLK,		0x5200c, 0x00002000),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S4_CLK,		0x5200c, 0x00004000),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S5_CLK,		0x5200c, 0x00008000),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S6_CLK,		0x5200c, 0x00010000),
> +	GATE_CLK(GCC_QUPV3_WRAP0_S7_CLK,		0x5200c, 0x00020000),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S0_CLK,		0x5200c, 0x00400000),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S1_CLK,		0x5200c, 0x00800000),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S3_CLK,		0x5200c, 0x02000000),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S4_CLK,		0x5200c, 0x04000000),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S5_CLK,		0x5200c, 0x08000000),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S6_CLK,		0x5200c, 0x10000000),
> +	GATE_CLK(GCC_QUPV3_WRAP1_S7_CLK,		0x5200c, 0x20000000),
> +	GATE_CLK(GCC_QUPV3_WRAP_0_M_AHB_CLK,		0x5200c, 0x00000040),
> +	GATE_CLK(GCC_QUPV3_WRAP_0_S_AHB_CLK,		0x5200c, 0x00000080),
> +	GATE_CLK(GCC_QUPV3_WRAP_1_M_AHB_CLK,		0x5200c, 0x00100000),
> +	GATE_CLK(GCC_QUPV3_WRAP_1_S_AHB_CLK,		0x5200c, 0x00200000),
> +	GATE_CLK(GCC_SDCC1_AHB_CLK,			0x26008, 0x00000001),
> +	GATE_CLK(GCC_SDCC1_APPS_CLK,			0x26004, 0x00000001),
> +	GATE_CLK(GCC_SDCC1_ICE_CORE_CLK,		0x2600c, 0x00000001),
> +	GATE_CLK(GCC_SDCC2_AHB_CLK,			0x14008, 0x00000001),
> +	GATE_CLK(GCC_SDCC2_APPS_CLK,			0x14004, 0x00000001),
> +	GATE_CLK(GCC_SDCC4_AHB_CLK,			0x16008, 0x00000001),
> +	GATE_CLK(GCC_SDCC4_APPS_CLK,			0x16004, 0x00000001),
> +	GATE_CLK(GCC_UFS_MEM_CLKREF_CLK,		0x8c000, 0x00000001),
> +	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK,		0x82024, 0x00000001),
> +	GATE_CLK(GCC_UFS_PHY_AHB_CLK,			0x77010, 0x00000001),
> +	GATE_CLK(GCC_UFS_PHY_AXI_CLK,			0x7700c, 0x00000001),
> +	GATE_CLK(GCC_UFS_PHY_ICE_CORE_CLK,		0x77058, 0x00000001),
> +	GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK,		0x7708c, 0x00000001),
> +	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK,		0x77018, 0x00000001),
> +	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK,		0x77014, 0x00000001),
> +	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK,		0x77054, 0x00000001),
> +	GATE_CLK(GCC_USB30_PRIM_MASTER_CLK,		0x0f00c, 0x00000001),
> +	GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK,		0x0f014, 0x00000001),
> +	GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK,		0x0f010, 0x00000001),
> +	GATE_CLK(GCC_USB3_PRIM_CLKREF_CLK,		0x8c008, 0x00000001),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK,		0x0f04c, 0x00000001),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK,		0x0f050, 0x00000001),
> +	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK,		0x0f054, 0x00000001),
> +	GATE_CLK(GCC_USB_PHY_CFG_AHB2PHY_CLK,		0x6a004, 0x00000001),
> +};
> +
>   static const struct gate_clk sdm845_clks[] = {
>   	GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK,		0x8201c, 0x00000001),
>   	GATE_CLK(GCC_AGGRE_USB3_SEC_AXI_CLK,		0x82020, 0x00000001),
> @@ -140,6 +217,28 @@ static const struct gate_clk sdm845_clks[] = {
>   	GATE_CLK(GCC_USB_PHY_CFG_AHB2PHY_CLK,		0x6a004, 0x00000001),
>   };
>   
> +static int sdm670_clk_enable(struct clk *clk)
> +{
> +	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +	debug("%s: clk %s\n", __func__, sdm670_clks[clk->id].name);
> +
> +	switch (clk->id) {
> +	case GCC_USB30_PRIM_MASTER_CLK:
> +		qcom_gate_clk_en(priv, GCC_USB_PHY_CFG_AHB2PHY_CLK);
> +		/* These numbers are just pulled from the frequency tables in the Linux driver */
> +		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR,
> +				     (4.5 * 2) - 1, 0, 0, 1 << 8, 8);
> +		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR,
> +				     1, 0, 0, 0, 8);
> +		clk_rcg_set_rate_mnd(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR,
> +				     1, 0, 0, 0, 8);
> +		break;
> +	}
> +
> +	return qcom_gate_clk_en(priv, clk->id);
> +}
> +
>   static int sdm845_clk_enable(struct clk *clk)
>   {
>   	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> @@ -188,6 +287,17 @@ static const struct qcom_reset_map sdm845_gcc_resets[] = {
>   	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
>   };
>   
> +static const struct qcom_power_map sdm670_gdscs[] = {
> +	[UFS_PHY_GDSC] = { 0x77004 },
> +	[USB30_PRIM_GDSC] = { 0xf004 },
> +	[HLOS1_VOTE_AGGRE_NOC_MMU_AUDIO_TBU_GDSC] = { 0x7d030 },
> +	[HLOS1_VOTE_AGGRE_NOC_MMU_TBU1_GDSC] = { 0x7d034 },
> +	[HLOS1_VOTE_AGGRE_NOC_MMU_TBU2_GDSC] = { 0x7d038 },
> +	[HLOS1_VOTE_MMNOC_MMU_TBU_HF0_GDSC] = { 0x7d040 },
> +	[HLOS1_VOTE_MMNOC_MMU_TBU_HF1_GDSC] = { 0x7d048 },
> +	[HLOS1_VOTE_MMNOC_MMU_TBU_SF_GDSC] = { 0x7d044 },
> +};
> +
>   static const struct qcom_power_map sdm845_gdscs[] = {
>   	[PCIE_0_GDSC] = { 0x6b004 },
>   	[PCIE_1_GDSC] = { 0x8d004 },
> @@ -292,6 +402,19 @@ static const char *const sdm845_rcg_names[] = {
>   	"GCC_UFS_PHY_PHY_AUX",
>   };
>   
> +static struct msm_clk_data sdm670_clk_data = {
> +	/* Snapdragon 670 can function without its own exclusive resets. */
> +	.resets = sdm845_gcc_resets,
> +	.num_resets = ARRAY_SIZE(sdm845_gcc_resets),
> +	.clks = sdm670_clks,
> +	.num_clks = ARRAY_SIZE(sdm670_clks),
> +	.power_domains = sdm670_gdscs,
> +	.num_power_domains = ARRAY_SIZE(sdm670_gdscs),
> +
> +	.enable = sdm670_clk_enable,
> +	.set_rate = sdm670_clk_set_rate,
> +};
> +
>   static struct msm_clk_data sdm845_clk_data = {
>   	.resets = sdm845_gcc_resets,
>   	.num_resets = ARRAY_SIZE(sdm845_gcc_resets),
> @@ -310,6 +433,10 @@ static struct msm_clk_data sdm845_clk_data = {
>   };
>   
>   static const struct udevice_id gcc_sdm845_of_match[] = {
> +	{
> +		.compatible = "qcom,gcc-sdm670",
> +		.data = (ulong)&sdm670_clk_data,
> +	},
>   	{
>   		.compatible = "qcom,gcc-sdm845",
>   		.data = (ulong)&sdm845_clk_data,
> 

Nice reuse, looks fine:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
