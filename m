Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47EE5C54766
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 09:48:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 947B687BFE;
	Mon, 19 Feb 2024 10:48:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VYQ7CMrN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCCC387E80; Mon, 19 Feb 2024 10:48:28 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A01587DE8
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 10:47:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-41267d9d6faso3453875e9.3
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 01:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708336063; x=1708940863; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=mba+qCwonQT/VDU3DUPDMl7Mm0x32aDol+eU92x9tho=;
 b=VYQ7CMrNczqUFZE61H4qq5jFVEOIaWEm2mYFKsS2rv48zvVTy/BT6kEZdpclPT8zzW
 bEqIJ/AlvnaOF/or5gnZMiZsunsW/7tg4jDS36aQZeu4l69FiZAg5WSIewz7HMHgkGF7
 Q9DgxuFbDZhj/lH+6ws0mqNL+mqQuyqfLUfQpK5nNDsIEIVDSfEwv+KCoOgZinEDGJA+
 rsv+s8Np3O8QMHhK317bedqbv91MQvX54UbmnA9eoBMVTArzWoYX4NCYuAeVffR9IV+P
 JiMhMTc9LNN0gIJPr+BXeCXryVFXMPsy/CqV8+uGGGAf269ANY/QqiE75aaR5f37hBLF
 bY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708336063; x=1708940863;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=mba+qCwonQT/VDU3DUPDMl7Mm0x32aDol+eU92x9tho=;
 b=DeiPs+oPORkGmXr9Z9aAKLIxrtHG3+Lfx9U+F5CuZdCXoRP1j0OodgfS2GJisjez9K
 LY4jZTcfsA9CDvYCJoqL9TxQcm5yl0giS3GaR4SNGU+Qlk48zIrUIRTVSSsMDh/48gzf
 eAkBJ78rZdQiH36RZGS7bqIMn5HG4h3KLNoIo//ytLzsCo8mX8ys1p97vI9fqTyUfP8z
 zuSe7hl6NNR7H5LKgWTY998eNoDb9zizVVtFn/Sslmpfg8NuAq5qUBBwSUwZte6d+rKS
 Uw5Odg46rmKeZ7/NvyUeAuP1sYrNQqxA8aoq0f/+1SPfz6d7g052RLn9IhJO+iPJmwqM
 XC8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB4t+ifCZebsRO8bcxCmIPPna1Aba9hHqvDESeStiM6gFVtmJkjt5Cf0vMS0miKOAhaMoCgnQ3dAEfJG1AGnnmF9lEbA==
X-Gm-Message-State: AOJu0YzSWKuLb2QrTgVmWanfngjtPLcQWbrW+TxU1ltVWUVtI32OlQnF
 WYNUzwCoqIe5xdR/JhXzMkRWyhQhe7YRF/Rjg1yhEDJ1QkbAq8h8WR90R15FykE=
X-Google-Smtp-Source: AGHT+IG7uO02o8EreiX/XOkPc8sJNWL2nso+O1JYxTaTXxKA6kG3wAntMDO5RzGCbNtMUTOiIFBcWA==
X-Received: by 2002:a05:600c:4f53:b0:412:5ef7:29c0 with SMTP id
 m19-20020a05600c4f5300b004125ef729c0mr3677015wmq.13.1708336062920; 
 Mon, 19 Feb 2024 01:47:42 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:9470:c6e0:c87a:fa9f?
 ([2a01:e0a:982:cbb0:9470:c6e0:c87a:fa9f])
 by smtp.gmail.com with ESMTPSA id
 q17-20020a05600c46d100b0041249ea88b9sm10136159wmo.16.2024.02.19.01.47.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 01:47:42 -0800 (PST)
Message-ID: <cb5d655e-7a69-47a1-a7dd-2b879593daea@linaro.org>
Date: Mon, 19 Feb 2024 10:47:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 08/39] serial: msm: fix clock handling and pinctrl
Content-Language: en-US, fr
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-8-ed06355c634a@linaro.org>
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
Organization: Linaro Developer Services
In-Reply-To: <20240215-b4-qcom-common-target-v4-8-ed06355c634a@linaro.org>
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

On 15/02/2024 21:52, Caleb Connolly wrote:
> Use the modern helpers to fetch the clock and use the correct property
> ("clocks" instead of "clock"). Drop the call to pinctrl_select_state()
> as no boards have a "uart" pinctrl state and this prints confusing
> errors.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/dts/dragonboard410c.dts |  3 ++-
>   arch/arm/dts/dragonboard820c.dts |  3 ++-
>   drivers/serial/serial_msm.c      | 25 +++++--------------------
>   3 files changed, 9 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/arm/dts/dragonboard410c.dts b/arch/arm/dts/dragonboard410c.dts
> index 02c824d0226c..c395e6cc0427 100644
> --- a/arch/arm/dts/dragonboard410c.dts
> +++ b/arch/arm/dts/dragonboard410c.dts
> @@ -84,7 +84,8 @@
>   		serial@78b0000 {
>   			compatible = "qcom,msm-uartdm-v1.4";
>   			reg = <0x78b0000 0x200>;
> -			clock = <&clkc 4>;
> +			clocks = <&clkc 4>;
> +			clock-names = "core";
>   			pinctrl-names = "uart";
>   			pinctrl-0 = <&blsp1_uart>;
>   		};
> diff --git a/arch/arm/dts/dragonboard820c.dts b/arch/arm/dts/dragonboard820c.dts
> index 146a0af8aafe..86b7f83d36d6 100644
> --- a/arch/arm/dts/dragonboard820c.dts
> +++ b/arch/arm/dts/dragonboard820c.dts
> @@ -78,7 +78,8 @@
>   		blsp2_uart2: serial@75b0000 {
>   			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
>   			reg = <0x75b0000 0x1000>;
> -			clock = <&gcc 4>;
> +			clocks = <&gcc 4>;
> +			clock-names = "core";
>   			pinctrl-names = "uart";
>   			pinctrl-0 = <&blsp8_uart>;
>   		};
> diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
> index 44b93bd7ff21..ac4280c6c4c2 100644
> --- a/drivers/serial/serial_msm.c
> +++ b/drivers/serial/serial_msm.c
> @@ -160,29 +160,14 @@ static int msm_uart_clk_init(struct udevice *dev)
>   {
>   	uint clk_rate = fdtdec_get_uint(gd->fdt_blob, dev_of_offset(dev),
>   					"clock-frequency", 115200);
> -	uint clkd[2]; /* clk_id and clk_no */
> -	int clk_offset;
> -	struct udevice *clk_dev;
>   	struct clk clk;
>   	int ret;
>   
> -	ret = fdtdec_get_int_array(gd->fdt_blob, dev_of_offset(dev), "clock",
> -				   clkd, 2);
> -	if (ret)
> -		return ret;
> -
> -	clk_offset = fdt_node_offset_by_phandle(gd->fdt_blob, clkd[0]);
> -	if (clk_offset < 0)
> -		return clk_offset;
> -
> -	ret = uclass_get_device_by_of_offset(UCLASS_CLK, clk_offset, &clk_dev);
> -	if (ret)
> -		return ret;
> -
> -	clk.id = clkd[1];
> -	ret = clk_request(clk_dev, &clk);
> -	if (ret < 0)
> +	ret = clk_get_by_name(dev, "core", &clk);
> +	if (ret < 0) {
> +		pr_warn("%s: Failed to get clock: %d\n", __func__, ret);
>   		return ret;
> +	}
>   
>   	ret = clk_set_rate(&clk, clk_rate);
>   	if (ret < 0)
> @@ -218,7 +203,6 @@ static int msm_serial_probe(struct udevice *dev)
>   	if (ret)
>   		return ret;
>   
> -	pinctrl_select_state(dev, "uart");
>   	uart_dm_init(priv);
>   
>   	return 0;
> @@ -251,6 +235,7 @@ U_BOOT_DRIVER(serial_msm) = {
>   	.priv_auto	= sizeof(struct msm_serial_data),
>   	.probe = msm_serial_probe,
>   	.ops	= &msm_serial_ops,
> +	.flags = DM_FLAG_PRE_RELOC,
>   };
>   
>   #ifdef CONFIG_DEBUG_UART_MSM
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
