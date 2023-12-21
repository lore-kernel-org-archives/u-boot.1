Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD5BC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 16:15:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5AC787860;
	Thu, 21 Dec 2023 17:15:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PIAMsfne";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91E81877E5; Thu, 21 Dec 2023 17:15:22 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A757A878A4
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 17:15:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40c48d7a7a7so7614275e9.3
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 08:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703175320; x=1703780120; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=9ZO0udYzCaoUjoA1VBJpagLT5vG5HHB4TndbW3qJ+QI=;
 b=PIAMsfneHCMjn7ymXNqkUjLvPZLDtKpydkXN1Dz00PgEszxVhabXVJ5C11BapZinSm
 QFlgQgxGqO9bNvr0Nsf07+Syzc1cbsSLZ2cI66VkIJhN69BMrsPv2MS3QTZamqX4uOYd
 m4ndN2LnivgatGGzQNMAzqCSu/KO9sOyZKfmibBLJfkoot7NgRYn2BSptxq00rXsX6xc
 mCHaT0PFuRBiZcrwgzI6K7avaw4KhZFuqGLWNtpGdm+szdzfn4B6B+eqB0NIFbdFrPLN
 RAVg4c3dnSxj3v3bLSI/Xjvx+Zr8NFVkHPAOXiBIhlubrWuDTn6s9GnQ75LgS35TItqk
 P/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703175320; x=1703780120;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9ZO0udYzCaoUjoA1VBJpagLT5vG5HHB4TndbW3qJ+QI=;
 b=rEV7PdyMsJbZPo8x6Jy6kQgomsUM6cMuaM5aCO3bVAHjZazetQ8AcTVSzzyTFANf8J
 bjdVO4UD4pXZKgmr0iI8YaNptkb2Bh+NgyYM5LI8ThTwyrhXGTU/60XBGdO6gbK7tt5y
 cUQ4jfAaaSFmKQy6AN7rzrWwUfvwsNtxwE5oG60w7AjuZCagvl2ajzvh4RCUSf9c1z/x
 7Khmn+IIl5+UDLzo0Q+wrvZmdBEQOMs6hw0ggOlmikGq+eh/A4g0URUAm4e6P4rRbadr
 6fftbtKJxo3teWADi2lYsOt0WQ7o8Fp6RqhqWOQgv2YIS5/FjzGvdYEpHuCZvwnexc+1
 D2pg==
X-Gm-Message-State: AOJu0Yxiq1HFjwwBowPx+RfknrG6lyMJL7/qyaCRPSQwQ3bYy1Y86UAX
 35lBPDf2aYexisNgw1sm/SrQrw==
X-Google-Smtp-Source: AGHT+IHMnlWqh2qG4MlB+Zt1qD3qgxSylcldVyl2T9P1Nxq3ukKUYC+ebQc+1E/ZYeLEFdZXTCcEng==
X-Received: by 2002:a05:600c:1897:b0:40d:3e05:9aab with SMTP id
 x23-20020a05600c189700b0040d3e059aabmr832340wmp.112.1703175320105; 
 Thu, 21 Dec 2023 08:15:20 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed?
 ([2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed])
 by smtp.gmail.com with ESMTPSA id
 j16-20020a05600c191000b0040c11fbe581sm3865415wmq.27.2023.12.21.08.15.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 08:15:19 -0800 (PST)
Message-ID: <814c4224-5054-40ab-b0fd-bbf9b17ba596@linaro.org>
Date: Thu, 21 Dec 2023 17:15:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 05/32] clk/qcom: use upstream compatible properties
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
 <20231219-b4-qcom-common-target-v2-5-b6dd9704219e@linaro.org>
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
In-Reply-To: <20231219-b4-qcom-common-target-v2-5-b6dd9704219e@linaro.org>
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
> Adjust the apq8016 and apq8096 drivers to use the upstream compatible
> properties, and adjust the associated dts files in U-Boot.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/dts/dragonboard410c.dts | 2 +-
>   drivers/clk/qcom/clock-apq8016.c | 2 +-
>   drivers/clk/qcom/clock-apq8096.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/dts/dragonboard410c.dts b/arch/arm/dts/dragonboard410c.dts
> index 6a4e3ccf17b1..02c824d0226c 100644
> --- a/arch/arm/dts/dragonboard410c.dts
> +++ b/arch/arm/dts/dragonboard410c.dts
> @@ -75,7 +75,7 @@
>   			};
>   		};
>   		clkc: qcom,gcc@1800000 {
> -			compatible = "qcom,gcc-apq8016";
> +			compatible = "qcom,gcc-msm8916";
>   			reg = <0x1800000 0x80000>;
>   			#address-cells = <0x1>;
>   			#size-cells = <0x0>;
> diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
> index c0ce570edc79..0af7191cff52 100644
> --- a/drivers/clk/qcom/clock-apq8016.c
> +++ b/drivers/clk/qcom/clock-apq8016.c
> @@ -145,7 +145,7 @@ static struct msm_clk_data apq8016_clk_data = {
>   
>   static const struct udevice_id gcc_apq8016_of_match[] = {
>   	{
> -		.compatible = "qcom,gcc-apq8016",
> +		.compatible = "qcom,gcc-msm8916",
>   		.data = (ulong)&apq8016_clk_data,
>   	},
>   	{ }
> diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
> index cf1a347309a5..1e6fdb5cd42d 100644
> --- a/drivers/clk/qcom/clock-apq8096.c
> +++ b/drivers/clk/qcom/clock-apq8096.c
> @@ -123,7 +123,7 @@ static struct msm_clk_data apq8096_clk_data = {
>   
>   static const struct udevice_id gcc_apq8096_of_match[] = {
>   	{
> -		.compatible = "qcom,gcc-apq8096",
> +		.compatible = "qcom,gcc-msm8996",
>   		.data = (ulong)&apq8096_clk_data,
>   	},
>   	{ }
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
