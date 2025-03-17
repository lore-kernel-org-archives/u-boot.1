Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D346C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 16:16:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E970E8198F;
	Mon, 17 Mar 2025 17:16:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IwnJIQbv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DE9C810F4; Mon, 17 Mar 2025 17:16:52 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9281280F4C
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 17:16:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43d04ea9d9aso10334315e9.3
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 09:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742228210; x=1742833010; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=G7tb//uA//yPizi4uC/rfV7Xjt/YVMccvWR0uRGeH5s=;
 b=IwnJIQbv4yYSSDbizHoXi5WMxpHSLdEBnziouEEZB2Na466HLWHuNc2mtQkyChSby6
 5xkKRYhcmH1bWl2YYP/uOxkeFiObyhj9HoBFbQsZPC2cT86qEBLB+cgSsMcUyvVOc3tb
 reA1FQemlRv0nrAqJWppF2cjGZyw+xN758rbR+Tg7HtdBTJrBN6VjuINm6fJAhofCRJv
 +t0e4qp9lyXrILNyrgK7VPohxLMZlDc5k1PRbmlQrizu2UF5uN6mG5sk7PK5MDyUPHsb
 SsTwGyrPxIUce781muJYMNewCq6tQlZk11z8iOzwI7N/XcVuVcdmYW7B+G16DomfX60n
 424Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742228210; x=1742833010;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=G7tb//uA//yPizi4uC/rfV7Xjt/YVMccvWR0uRGeH5s=;
 b=VhzF42zDZ1s7I5hhn+Eh7goz4tFEJf7AVLFlS9f1+GkfFu/yugw9mchI4ZrFqE9WT8
 0AjAVs7YasKP4WHfiPbEjidbKmpbrg2lB9HX21SdUrvmMAbjZ3Q/CqZN3RzyKy4/mlVc
 pLNZcCM5FageMndRUBW9JC43o2d3+IqnZDXD7Z055f+/J5kdy+7xuieBOmSnbupAUcys
 pTrha2yQDriOQaDm6OLVYMeG9WlBFYQGIXc/J6uvm638m04JMw23fbTOlroXFQ0/npbM
 cccHnQSakGFpC9fpsVH51+rZYH3QSg1qoXIPOLvJvUT3ycv5LruY1rS6drMxA4VZtRvy
 Yp9g==
X-Gm-Message-State: AOJu0YyCmX6S4ygz9MLV/KWV0hkLJd8j83ytO0TJAPA6kr1ERQSxICus
 BApKLp9o+54TWE4uyAGOEm/6HpSYTxI9Vvq5HZ+8YHsULXLLA1aPHqK0Vb1UGj4=
X-Gm-Gg: ASbGncsiyzEUtQxFT/bef1uy9rofPM2KqGS9aN+phwq/ALaAvtOKDbF51IT9D5tm46f
 l5sWtjxEgUcy4JzzdwbdIfTesRCCo4JMINC9k6xJFEY8nu+WsGDB6r9ARdx7ief3Qt92/3bGfPP
 yl/PY8e9Smg5TrrfXjq2ueGz6VoQkJM4TmlEGb52uI/H8C9P5nUtjiIYFroc7sH4WWCyg9qss/q
 6rX1oLSF6kayj0ovewFb1fcwPEsV2RmcpU/2EmPtD9Lxm+jnqoNUQbnuSZPqIJysJ78Ik9CENAk
 qXgDUm+CSbte2ei9vjPmrxez1eA9nSfHRmNfjULafsHZz9gS8AIFPsTm5Iy0qK9mKCuY031lIPe
 Eudi9YrHW6PMLZsj18ttytw==
X-Google-Smtp-Source: AGHT+IFjdvoNt7x5VGbMR7EkULjC7x0/395SM5tMHHI37E+u9rLdHtgZDDLNlCzua2S4qJX4sxp7rA==
X-Received: by 2002:a05:600c:35d2:b0:43c:f3e4:d6f6 with SMTP id
 5b1f17b1804b1-43d1ed1af1bmr132081195e9.31.1742228210008; 
 Mon, 17 Mar 2025 09:16:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:1a77:b55f:a550:458c?
 ([2a01:e0a:3d9:2080:1a77:b55f:a550:458c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1ffb626esm108815445e9.8.2025.03.17.09.16.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 09:16:49 -0700 (PDT)
Message-ID: <4eec3426-4878-4958-b045-f62fb6ad0577@linaro.org>
Date: Mon, 17 Mar 2025 17:16:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/2] clk/qcom: sc7280: add missing UFS and MMC clocks
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250317-sc7280-mmc-ufs-clocks-v1-0-38e05c16511b@linaro.org>
 <20250317-sc7280-mmc-ufs-clocks-v1-2-38e05c16511b@linaro.org>
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
In-Reply-To: <20250317-sc7280-mmc-ufs-clocks-v1-2-38e05c16511b@linaro.org>
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

On 17/03/2025 17:15, Caleb Connolly wrote:
> These are all usually enabled, hence we don't (yet) bother configuring
> their RCG src clocks.
> 
> Add them to remove the errors about missing clocks when the UFS and MMC
> drivers probe.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/clk/qcom/clock-sc7280.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
> index 8691f08109b39639d8a5defe75161049399bf682..9aff8a847ad1bd59b7ec7246f5719e4d7c32ec65 100644
> --- a/drivers/clk/qcom/clock-sc7280.c
> +++ b/drivers/clk/qcom/clock-sc7280.c
> @@ -106,8 +106,19 @@ static const struct gate_clk sc7280_clks[] = {
>   	GATE_CLK(GCC_AGGRE_NOC_PCIE_CENTER_SF_AXI_CLK, 0x52008, BIT(28)),
>   	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x52008, BIT(10)),
>   	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK, 0x52008, BIT(11)),
>   	GATE_CLK(GCC_QUPV3_WRAP0_S3_CLK, 0x52008, BIT(13)),
> +	GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x77010, BIT(0)),
> +	GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x770cc, BIT(0)),
> +	GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x77018, BIT(0)),
> +	GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x7705c, BIT(0)),
> +	GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK, 0x7709c, BIT(0)),
> +	GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK, 0x7701c, BIT(0)),
> +	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK, 0x77020, BIT(0)),
> +	GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_1_CLK, 0x770b8, BIT(0)),
> +	GATE_CLK(GCC_UFS_1_CLKREF_EN, 0x8c000, BIT(0)),
> +	GATE_CLK(GCC_SDCC2_AHB_CLK, 0x14008, BIT(0)),
> +	GATE_CLK(GCC_SDCC2_APPS_CLK, 0x14004, BIT(0)),
>   };
>   
>   static int sc7280_enable(struct clk *clk)
>   {
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
