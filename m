Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B25CCD19A
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 08:07:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3815E83C98;
	Tue, 18 Nov 2025 09:07:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d7UpLVOe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 827A783CB9; Tue, 18 Nov 2025 09:07:14 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CC9983C5E
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 09:07:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4779a637712so18674515e9.1
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 00:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763453231; x=1764058031; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=ASa62ZETVCODmiDFMh9WqPbgvaUKtma71TlVB54r/k0=;
 b=d7UpLVOeJxPuiSKjEzO3TYsjjJ6N2y9jxM/NKi1RPFB8Qh9i+aX4pEEiu/wMeWg/0O
 9+0nqEPi7Qaa/Zj6tK1vIcay3irsyb0BebtFUh3Eld/aQL1WnHgmezlxPr2gsvw01SZF
 0nDxluPqtpGVwMf8mr8J+rLMEkhp0ueyabUECimMi4n68W5udzEROZI5ixg1LW50IOI+
 gVoEJidqAAQICRbOWFnk8q5X6ptH0tWzIaYqXGeBRJ/zo49pc1cep/5PENUv7JE7iGfR
 k8Hio27Wcrzn/keUH3LQOLHvV29j1xyqnRuLeARZG95pOd48LFNzDhP9imB/QDoFkg/1
 OIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763453231; x=1764058031;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ASa62ZETVCODmiDFMh9WqPbgvaUKtma71TlVB54r/k0=;
 b=JqlCXy2p8F/ib1sfjFNzpu2erbz+9QKb7Lno0SerdFx3ozxzqYIUn9YFedGLICpM/i
 2wq29Nwt6TR4CVsuMpptgnRAvDFNCc5kvK3SebmKld0C1gK4ZvQNZxCeXS7ylK0mYNKv
 jWNRJDfy9NxIYk8vH/X6Su1i3TYvolm1LP4Wa6/XZxk6Wexoekx8fsYTZ7eJY7R6msCX
 YBwROrc48ogmMGQS1oiqnxRgCevYyv8M6rGbxhd1XvMjXewExTkYr8Hc/0JKDQxjadXV
 W0sU/TxOzijhUFBxUCsTR+AVdyQAfPGD3nNpnCVDxiFhcOedvStdkUHnjYlqdZLEE13H
 HBuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlKcmWF0Kkl40puXMEiGZfu2YoU1ELz9tZe9HVelQWKY9w2/JzqW8NNKZfrxe1mOEmjFK9yA8=@lists.denx.de
X-Gm-Message-State: AOJu0YxT7vqI7JyxU63js2i9LLrHhs8bKBWqWkIns2F5m96RzF0x+s4e
 a5ZsvwNu+sf56/zNSQBsfJlr4FuNmG9IG6+1fsJIDaqPYtOiQSvUucFr3RZxKN5iRHE=
X-Gm-Gg: ASbGncvoGZaMTxNo1lkeS+o9PfturqKlzghrL3O2cfMAHlLC41Y08q8NCd+2Lb9dO1z
 PKPo+R3Q2016CwWxQROsDSLdsXaB24bQnMd52BzQZm52f71BVcFdadHdBQ8fzleItDnj5VI01wQ
 zxDjQ6JZ7C4HtEnZwmed/5lRuXQe1h/7MqGCQHJFJd6MzieYSsz14yTrqLGP+TSbnx030ZEHe13
 juFsLNir5189fQ0AWH4KGCry6t2xQZ8LJOvkfxjpJQK6tqw67NqV8rGSwdxw8IxsPUWUAR1IKJ2
 PLIqQ4FZI0s17I94G5WoThAlfrZYHl0v/V6Rl1LLRlFIBiS9IvcfWRAgNRhukS0e0d0AB+gFTBZ
 gx2ZH5Bmkf6rLPP8B5m38BmP9y6bJiCe15iEdZsgUrOd8LasqV6pN6UwaDL36WHhZywuHYo+yxT
 XDQsz4a4FWFDvGnvCdvVRhYuh+AfcJvhVMWe3I0UxlIVbC99RtGh5v3ZYpFXQNmjz+cFmNvfewf
 A==
X-Google-Smtp-Source: AGHT+IHzW4F/z29CxPSxNGY02AsNYQjMIYlHwJTI0LIc75zli+1sMfjHHlKahMzGCBmvR56CREwfVw==
X-Received: by 2002:a05:600c:46ca:b0:471:14af:c715 with SMTP id
 5b1f17b1804b1-4778fe4f06dmr148338785e9.3.1763453231470; 
 Tue, 18 Nov 2025 00:07:11 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:366e:5264:fffe:1c49?
 ([2a01:e0a:3d9:2080:366e:5264:fffe:1c49])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a9e1b657sm9975675e9.17.2025.11.18.00.07.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 00:07:11 -0800 (PST)
Message-ID: <834a823c-353f-4d1b-ad4e-974a5ff0f303@linaro.org>
Date: Tue, 18 Nov 2025 09:07:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 2/3] clk: qcom: qcs615: Add GCC_AHB2PHY_WEST_CLK clock
 support
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, aswin.murugan@oss.qualcomm.com, lukma@denx.de,
 seanga2@gmail.com, casey.connolly@linaro.org, sumit.garg@kernel.org,
 alexeymin@postmarketos.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20251114063804.3835132-1-balaji.selvanathan@oss.qualcomm.com>
 <20251114063804.3835132-3-balaji.selvanathan@oss.qualcomm.com>
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
In-Reply-To: <20251114063804.3835132-3-balaji.selvanathan@oss.qualcomm.com>
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

On 11/14/25 07:38, Balaji Selvanathan wrote:
> Add GCC_AHB2PHY_WEST_CLK gate clock definition to the QCS615
> clock driver. This clock is required for proper PHY operation
> and eliminates clock-related warnings during USB initialization.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>   drivers/clk/qcom/clock-qcs615.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/qcom/clock-qcs615.c b/drivers/clk/qcom/clock-qcs615.c
> index 4700baba8c9..2b59c4d13fd 100644
> --- a/drivers/clk/qcom/clock-qcs615.c
> +++ b/drivers/clk/qcom/clock-qcs615.c
> @@ -66,6 +66,7 @@ static const struct gate_clk qcs615_clks[] = {
>   	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf050, BIT(0)),
>   	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf054, BIT(0)),
>   	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0xf058, BIT(0)),
> +	GATE_CLK(GCC_AHB2PHY_WEST_CLK, 0x6a004, BIT(0)),
>   	GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x5200c, GCC_QUPV3_WRAP0_S0_CLK_ENA_BIT),
>   	GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK, 0x5200c, GCC_QUPV3_WRAP0_S1_CLK_ENA_BIT),
>   	GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK, 0x5200c, GCC_QUPV3_WRAP0_S2_CLK_ENA_BIT),

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
