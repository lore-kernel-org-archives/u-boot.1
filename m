Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CF5C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 16:18:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FEDC8786E;
	Thu, 21 Dec 2023 17:18:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mn3G5chq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9095686E7E; Thu, 21 Dec 2023 17:17:58 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 220018789A
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 17:17:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33678156e27so859334f8f.1
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 08:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703175473; x=1703780273; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=cqK9bMGS2U7U6iFCABVJSJ6YC9O4Cps2CGWShOmSKrg=;
 b=mn3G5chq2rBOuNTw/E3SiTK3J+Rnz93NAcP6kH/XdTBs4uGU9r5S3ueNxdUIUZPcDF
 H6QEgPyF1RHK1afgujgtbkGXhvvsoIKlyjP0VJwWsYQotCdfw2or/B40isF8TpeMheeA
 eVrBzb/MHJNkG4KFJyRxT/M6AA231nJwHbj+xkeizeDmNh9lx0eweTqVuCIeEnjuRVl5
 wQnG6d4z8KIYILRUisx3K50vRY0yHrBPFmF1tsR7pwHBmhyhiJ563zLfKbzi1X28REKa
 izqJ6YxpvqdwM98N5esXCqYLqI6yXHeEQz6vv7ya7EQbnT3A5pvYMiap8sz6LoxsQaQx
 9Epw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703175473; x=1703780273;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=cqK9bMGS2U7U6iFCABVJSJ6YC9O4Cps2CGWShOmSKrg=;
 b=GCWJtVyn2RJ7x4uQBzyeHo+dTiluNK5ilWE4xYJQWdovkZ8JQZ3h+i8ntbGX1n/N0/
 n10Aw+sUtmj2ROV2R3Eb72lLRa7LuqBUwGZVkI7rNlNsLXhYSxfSgPXLQyTGnnotvC10
 S8lZyIhEMGJ/2uxfubGbHgubuYXTczQiPKKJ73wYgywuh7VClCWACvMXNiYMoBRaVW+w
 Q0rTJ2/mq2HE5qiRQBh0xR9oJsxvs8EdzipiejyXOIly/vK4Gq9IwceiRPtumcsPplVm
 eV9EIZo0VPZVZoMqFdHK862LfBtBNkSxEvuqyvEFCRdmUkrME0przWiN/0yNT0FYMe5v
 u9Hg==
X-Gm-Message-State: AOJu0YzQ4MBaONNiRqROjYFfdw8uW3UsiDvzw4NbnH1neWFVp7I+ZGYC
 XsIGwDsQR2my1ReNMUqdD6bXJw==
X-Google-Smtp-Source: AGHT+IEi/QfrVEnzbdC/pspKgrhG0zTWFmISLlplHbIHG1oFZpp7Dju1CCTlpA3FzGor3YBg6NPgEg==
X-Received: by 2002:a05:600c:4e8e:b0:40d:2f88:89f3 with SMTP id
 f14-20020a05600c4e8e00b0040d2f8889f3mr913882wmq.44.1703175473450; 
 Thu, 21 Dec 2023 08:17:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed?
 ([2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed])
 by smtp.gmail.com with ESMTPSA id
 a26-20020a5d457a000000b003364bb3e989sm2316961wrc.110.2023.12.21.08.17.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 08:17:53 -0800 (PST)
Message-ID: <d7a821ec-1a91-49d6-a8db-468c27423da8@linaro.org>
Date: Thu, 21 Dec 2023 17:17:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 07/32] serial: msm: fix clock handling
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
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
 <20231219-b4-qcom-common-target-v2-7-b6dd9704219e@linaro.org>
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
In-Reply-To: <20231219-b4-qcom-common-target-v2-7-b6dd9704219e@linaro.org>
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

On 19/12/2023 17:04, Caleb Connolly wrote:
> Use the modern helpers to fetch the clock and use the correct property
> ("clocks" instead of "clock")
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/dts/dragonboard410c.dts |  3 ++-
>   arch/arm/dts/dragonboard820c.dts |  3 ++-
>   drivers/serial/serial_msm.c      | 24 +++++-------------------
>   3 files changed, 9 insertions(+), 21 deletions(-)
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
> index 19a5a3a788f7..0148ddb54df6 100644
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
>   	clk_free(&clk);
> @@ -252,6 +237,7 @@ U_BOOT_DRIVER(serial_msm) = {
>   	.priv_auto	= sizeof(struct msm_serial_data),
>   	.probe = msm_serial_probe,
>   	.ops	= &msm_serial_ops,
> +	.flags = DM_FLAG_PRE_RELOC,

Is this flag introduction related to this particular clock property name change ?

>   };
>   
>   #ifdef CONFIG_DEBUG_UART_MSM
> 

