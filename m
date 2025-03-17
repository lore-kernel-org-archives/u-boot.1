Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB4DC282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 14:01:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17ADE81101;
	Mon, 17 Mar 2025 15:01:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rQ4SuG+i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56AFE811DF; Mon, 17 Mar 2025 15:01:41 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5409F80107
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 15:01:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso13816525e9.0
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 07:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742220099; x=1742824899; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=t48gf/ODZhLw9Zn1mIbAE1MjfapDp4s44jFamQAcpJA=;
 b=rQ4SuG+ihnsWPFAQQs0MYEHZf7q6NXPElXPQbV1uKVDYZqZDoZsfcm0+YtbcoWlBeq
 CvaEZEgG5HMHMsVYnFDqPaUuSfSK75upbU4sdT+gSgDEPUehL+ryIy/tJzUZcZWB2i+y
 e/cY0olOK9UQQKVOfvbm3VrbnTRkXtY+iq5fH5gYsINf7hBiC6tg0KzZDCOByYNk/ZaW
 NVsAwhaJcqwgzpz5n2HGVmtrjcAj9rvmoSApMiZKphJzFot1mJ8UJ5BIAZmgwtCY0hds
 xdxGjodvsUgizYFW4VNRfT8iLwDAHJSPrxaV3CfJoN70r9yXV/zUVnedwcdj0az2V9bg
 xdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742220099; x=1742824899;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=t48gf/ODZhLw9Zn1mIbAE1MjfapDp4s44jFamQAcpJA=;
 b=MKlV2g1qasP6nzORp2p/fQ262P4yKEJR9uB+Cbwg2to4vpOAfhg7KE9gDgmFc2Ko4f
 fMjWs5b6iwSi4AKAMU74swjAOz9IamKw2Z/ZZAjqtYOFp5IB5MplVDbolBQLO914GDsk
 ouHJsmCCIsR3me7ytPf2fGm4kLryy4a+N/Cl0N/quLqCynxoSA+tf+FPF/ELMnzwK6yn
 5hx7fG/YFJGUzp99z4BrBo1QjEWWlCtCOERXjeipcP/yvsOBOH3RQWJJ52kHHj8NZ8tp
 FscMexBkyXvmQ6EcjHdXSG3Yu7p4wUEA7o+xb3DyIcNCNUnxienVLdPtEYvrA30ZQYyV
 JwdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUejWS6kXPE7unJHVLubTMkWp+Mx6lY3v/Nt8jm/RSVx236ioA/+JaYwh5/+IS19g5VcuJhe1A=@lists.denx.de
X-Gm-Message-State: AOJu0YxwoLQ9ozvVig1/HJC12UKQkHEUmwL7FX4JUzNzIYVK5AyMKjzS
 ERVZ+3IP+cPYL7vY8sdzIUJYR0P1oLHo0/wbEEoBv7KyOLYA1AB3zUhqoLVF6Ws=
X-Gm-Gg: ASbGnctx9PYXIjtSyhztUQLvzQ0shBj/dUAbaeopoiBMiVachOVGBWpSuB9AzSD1fF6
 qz9KCmW1+B/6joDYRoVbBZGOXxsG6dO3Wu/6IHpQjYq3/ocoLzoM8+7JD54gAAlL705a/fOZKPf
 CPtT3QzeYv8crBKaoHQSY3Ro60GCXKWKzBH4QVX9rFa/IwWGJ/Zk8Im3j50J50/Aa2ApH3sQ+yJ
 ChX9EQQqbt+XKYf/WFUGHLMiBf312W/0WcwT2RM5Byye8mCd8SjlTTJYBBWTnDAdnIjegxWnBg+
 vN+QlYwa4u4PIVDY4+Tkh5IYTY/X5YPY2Xz+GkAiXOk44pS+B9KudShm/+inrYVrs3aytHns5AC
 4qzHEgK+m7sugNf/fL0yVHQ==
X-Google-Smtp-Source: AGHT+IFa2qUMNiw3lNyRdEaDTmTbB9aVgsD2rB4v/Kv1fWBrnftlU332xPm7sEVRRAT1i1p5xfe1Bg==
X-Received: by 2002:a05:600c:594f:b0:43b:c592:7e16 with SMTP id
 5b1f17b1804b1-43d1805a527mr165428025e9.3.1742220098321; 
 Mon, 17 Mar 2025 07:01:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:1a77:b55f:a550:458c?
 ([2a01:e0a:3d9:2080:1a77:b55f:a550:458c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d2010de59sm104701095e9.33.2025.03.17.07.01.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 07:01:38 -0700 (PDT)
Message-ID: <562a9b04-0e44-4619-99be-ae84ddd24b64@linaro.org>
Date: Mon, 17 Mar 2025 15:01:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/3] clk/qcom: sc7280: add some debug data
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250314-sc7280-more-clocks-v1-0-ead54487c38e@linaro.org>
 <20250314-sc7280-more-clocks-v1-2-ead54487c38e@linaro.org>
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
In-Reply-To: <20250314-sc7280-more-clocks-v1-2-ead54487c38e@linaro.org>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 14/03/2025 16:31, Caleb Connolly wrote:
> Dump a few PCIe and USB clocks
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/clk/qcom/clock-sc7280.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
> index 8ffd1f43f23e51140c7822f0f523fdfd8ab1de7a..2cbc01b6e0a4f1db0e4a894cd869b532d6b3fa45 100644
> --- a/drivers/clk/qcom/clock-sc7280.c
> +++ b/drivers/clk/qcom/clock-sc7280.c
> @@ -99,8 +99,20 @@ static const struct qcom_power_map sc7280_gdscs[] = {
>   	[GCC_UFS_PHY_GDSC] = { 0x77004 },
>   	[GCC_USB30_PRIM_GDSC] = { 0xf004 },
>   };
>   
> +static const phys_addr_t sc7280_rcg_addrs[] = {
> +	0x10f020, // USB30_PRIM_MASTER_CLK_CMD_RCGR
> +	0x10f038, // USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR
> +	0x18d058, // PCIE_1_AUX_CLK_CMD_RCGR
> +};
> +
> +static const char *const sc7280_rcg_names[] = {
> +	"USB30_PRIM_MASTER_CLK_SRC",
> +	"USB30_PRIM_MOCK_UTMI_CLK_SRC",
> +	"GCC_PCIE_1_AUX_CLK_SRC",
> +};
> +
>   static struct msm_clk_data qcs404_gcc_data = {
>   	.resets = sc7280_gcc_resets,
>   	.num_resets = ARRAY_SIZE(sc7280_gcc_resets),
>   	.clks = sc7280_clks,
> @@ -110,8 +122,12 @@ static struct msm_clk_data qcs404_gcc_data = {
>   	.num_power_domains = ARRAY_SIZE(sc7280_gdscs),
>   
>   	.enable = sc7280_enable,
>   	.set_rate = sc7280_set_rate,
> +
> +	.dbg_rcg_addrs = sc7280_rcg_addrs,
> +	.num_rcgs = ARRAY_SIZE(sc7280_rcg_addrs),
> +	.dbg_rcg_names = sc7280_rcg_names,
>   };
>   
>   static const struct udevice_id gcc_sc7280_of_match[] = {
>   	{
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
