Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16688C54E58
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 17:18:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5292187FD7;
	Fri, 15 Mar 2024 18:18:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zWyl72Es";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A31587FD7; Fri, 15 Mar 2024 18:18:36 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F67787CB7
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 18:18:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-513dbb5a1f9so936937e87.2
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 10:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710523113; x=1711127913; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=DdMgDbeRuMd/8XTKfU20vPf+5vkgINOS0VRvCVMRv4k=;
 b=zWyl72Es4bvmOoiQyd3ZJfGeypdiIUoKX/f+IheusYY1vuS+0yBtJGlff5KzMimBhS
 SLqfZoiVVw/oy/kMX67Vv8hLLmRtk5FI/o3l7zSdiQQ6EY6kVN7dXyWb5ppfRRdD+gFb
 krtgqZUV10D7B7Nj9lcqyZAB58eDeWNtGr6AgjoYUB39fLXxdovRQaZEPpyyGrKtxJCR
 sVpKHX/DpvomPPfJkz/H9XMoe45E35lDV6gz7watv7HYUFp1ZjxRko4e9J54YduFNKaX
 hnHGFLPdHmYQfYl7nWsjCXYtGoFw3G2zL6Bv7d+V0HJQRaRJhyw+78R8gRyRucBSNP99
 I94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710523113; x=1711127913;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=DdMgDbeRuMd/8XTKfU20vPf+5vkgINOS0VRvCVMRv4k=;
 b=K/A3Ksqy2qSvy8l6DFTE33an1EZPfoUqga00wrCKglWUkXGm0fLmOZLOvXQLmZga0B
 Eb2X5saPgrucyvXIsWNPz3+6qD8aCYd/mjbM9KaFD7LyslCp4tJItuYdgnWkrOvTn4FN
 j4clWuyV3fqqDqsl7yavIl7ZYM0wjyTv5fkbvUd42ygjmm5VYO3YJPl9rmetfJYTQ8ci
 6MZ87Go0xBSJUltbYXKIlgHkZABEgrUc2qun/EChDm2d+EF1QRomhXqIaBMjPg+4LTtL
 S4aP9JgwHagbAY4AkGJAz44ieTQ+2FpB9dooQZoEeQ9TaZlOR6qi+BE7cdm72uZ0I+Gd
 MGAg==
X-Gm-Message-State: AOJu0YyI4Y/JeybtdN49I1vpE1S9vXFfVspCBreimAxJM89wr1f84BmW
 Hv1ZebLYzoEqncqrabn93DdMdrVCd/t8xeKqjDsyinY1AHYWP0lkRDXJxhbFrfk=
X-Google-Smtp-Source: AGHT+IEArmcz20OrQhaxZXUyhN+55nDEWEzsmXxd1vmFihRYOSSLYlD5eaKo+iTlSj4dK79ZQ4OzWw==
X-Received: by 2002:a19:910b:0:b0:513:ccec:a822 with SMTP id
 t11-20020a19910b000000b00513cceca822mr3849607lfd.28.1710523112590; 
 Fri, 15 Mar 2024 10:18:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a633:992a:92cc:9c3?
 ([2a01:e0a:982:cbb0:a633:992a:92cc:9c3])
 by smtp.gmail.com with ESMTPSA id
 bi12-20020a05600c3d8c00b0041403e8ee2esm1349105wmb.18.2024.03.15.10.18.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Mar 2024 10:18:32 -0700 (PDT)
Message-ID: <fc840e49-8f1b-4df6-b83e-dafc9d84518e@linaro.org>
Date: Fri, 15 Mar 2024 18:18:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 09/14] serial: msm-geni: support livetree
Content-Language: en-US, fr
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240315-b4-qcom-livetree-v2-0-ab635774b2dc@linaro.org>
 <20240315-b4-qcom-livetree-v2-9-ab635774b2dc@linaro.org>
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
In-Reply-To: <20240315-b4-qcom-livetree-v2-9-ab635774b2dc@linaro.org>
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

On 15/03/2024 16:10, Caleb Connolly wrote:
> When using OF_LIVE, the debug UART driver won't be probed if it's a
> subnode of the geni-se-qup controller. Add a NOP driver for the
> controller to correctly discover its child nodes.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/serial/serial_msm_geni.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
> index 4aa0bc8c72bc..5260474fb9a4 100644
> --- a/drivers/serial/serial_msm_geni.c
> +++ b/drivers/serial/serial_msm_geni.c
> @@ -605,8 +605,21 @@ U_BOOT_DRIVER(serial_msm_geni) = {
>   	.ops = &msm_serial_ops,
>   	.flags = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
>   };
>   
> +static const struct udevice_id geniqup_ids[] = {
> +	{ .compatible = "qcom,geni-se-qup" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(geni_se_qup) = {
> +	.name = "geni-se-qup",
> +	.id = UCLASS_NOP,
> +	.of_match = geniqup_ids,
> +	.bind = dm_scan_fdt_dev,
> +	.flags = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
> +};
> +
>   #ifdef CONFIG_DEBUG_UART_MSM_GENI
>   
>   static struct msm_serial_data init_serial_data = {
>   	.base = CONFIG_VAL(DEBUG_UART_BASE)
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
