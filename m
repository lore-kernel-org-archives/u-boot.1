Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4F9C77B7F
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 09:39:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FB3A82D17;
	Tue, 24 Jun 2025 11:39:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eJCH8SdP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADBB882D21; Tue, 24 Jun 2025 11:39:41 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFF2482C84
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 11:39:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45377776935so16550565e9.3
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 02:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750757979; x=1751362779; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=1AS7JVW9X2Ijh3XQBGanysXsBPgL9g9SPfOud60dJWA=;
 b=eJCH8SdPn+Q27yXHyowg/qvCfs5G6Feq3WDSiqockxoki4xb7o/YSfB3Izor4q/fAi
 2k1S38369yfBvOIzJM5N/LcPXK58AQtsQs0tFjeISvgosDU/CcDWXshs6pDsSoxLX0Z7
 FQmGEYVXoDztMPNGV1MuuE+3JRVH0VbfOIkXObojhN885hvVlDM+T5L4bhDFP4QtNJQN
 DaToMG4a6tmDpkC7+N57ygZ6huHc320dD22G0rAC+1Ki8lVviGzTWaPRTUmcr4iOkNVI
 F+Ia3jsYAenrFlRnPITXrqKTaLmfcRanKJ3MgOP5ZJAtdrbk8Kmv7/nf2eLEp4cMDVgW
 Cldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750757979; x=1751362779;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1AS7JVW9X2Ijh3XQBGanysXsBPgL9g9SPfOud60dJWA=;
 b=VFsXJVR6zRFHs79Mt6h2i5bwW+YJ4MYCzvjBo+dYjcjPL8Zekv7Yd8uMat1yw5UVfH
 u7j6Dpo5K1fMwfffvCex+H+dJZnKOYLtx8iBNE087B0bmgUpSFYpN3s4hf9QvKUQEsK6
 /u/L6b2y/4AoFtdz+VeW0AMhT5pANfzGDmn8B50bbzOyASoCuRCGkrh8h1daYzO6da0B
 AdaJX3lXOZ33zy/EFrVNAstZEBvQ+lSvO+kyIk6U9MAKcJP82w6L8Q2cCzv5KRUITZ8i
 xVhaM0L3p/geTEJJLPslQ+P2CqXF0pg3geNmp8OxStxn3QU9EnQZ+fN/ULUJxo9UH5B1
 3qXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUA3mqL5CxtP0lARtkQQ3DQbCIO2yJBHvRq7K/O+jAYOxusNLKh+24Aa6z/gZfxKvr6IimyimE=@lists.denx.de
X-Gm-Message-State: AOJu0YykQm9NaE4xJfpQ5XX5Mnh7fp4kA/TKTV3sLKk3Dtiu0bts6Ttr
 8B9bhutqYzpQCp7yxMOxiRyDLS2EJdalbvr4pXSQoleja3Wmyjts+WQwtuVc7eSykEs=
X-Gm-Gg: ASbGncvZ3l+JMQSgMglFkCuF8zYyy4QKn1xa73uc9pVMvCTZrGi+8bZqba7vOrRgI/M
 NnSUtBZG0wNV6neJZbroOk9wPPoJTPtRLtC0Iy09Vbrj7ZFcgoTuBKTps6VFMUvMssjyi5p727b
 RH29g7FNZzzVzYBBuwewpHkJQuYmTa5wQogqD4scuGi6xelCDzcp+Xtz+ALguCEm8UagEE7sUna
 vGzup80bCZztaVU4UTX+jvaf2VfQytQMHYTjdi5Togwlf3pVSAPfCM2it0+EGnWB5co3QKmGf8m
 YxIkgyH3ZEnkkF5wLpswB1X8S/rhnSwv2eoOxllLX7xOm+J5vcwozxXiWs42pbSs4vPKaAhrr1B
 mXwxhQLU/k0EwA+4A1MX5piadAmJ6Iu4ZeflB3JQ=
X-Google-Smtp-Source: AGHT+IG+z1PfPiPZtNso5fXxNmq2cHJouplMitwC3dycl3ag13BQWIzrdP/Xw9AAb2Bh7mxDkPpztQ==
X-Received: by 2002:a05:600c:b86:b0:441:b076:fce8 with SMTP id
 5b1f17b1804b1-453659c0bb9mr176554685e9.14.1750757979010; 
 Tue, 24 Jun 2025 02:39:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:6fea:600c:ca20:f54a?
 ([2a01:e0a:3d9:2080:6fea:600c:ca20:f54a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453646cb64csm141318485e9.4.2025.06.24.02.39.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 02:39:38 -0700 (PDT)
Message-ID: <863d6e20-5148-4109-b14b-4d4523dbf017@linaro.org>
Date: Tue, 24 Jun 2025 11:39:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 08/10] serial: msm: Reset after writing to DMEN
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Sam Day <me@samcday.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250624-db410c-autoboot-fixes-v1-0-d96c97ae41d1@linaro.org>
 <20250624-db410c-autoboot-fixes-v1-8-d96c97ae41d1@linaro.org>
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
In-Reply-To: <20250624-db410c-autoboot-fixes-v1-8-d96c97ae41d1@linaro.org>
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

On 24/06/2025 10:45, Stephan Gerhold wrote:
> According to the documentation of the UART controller in the APQ8016E TRM,
> clearing bits inside UARTDM_DMEN requires resetting the transmitter and/or
> receiver. We do reset inside uart_dm_init(), but before writing to
> UARTDM_DMEN. This doesn't seem to cause problems in practice, but let's
> move the reset to the end of uart_dm_init() to better match the
> recommendations in the documentation.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>   drivers/serial/serial_msm.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
> index aa4d10e7c5138f919978272e4967ece8293073b3..5523ec4afe17f242d61bc2ec4b4534b5b974434c 100644
> --- a/drivers/serial/serial_msm.c
> +++ b/drivers/serial/serial_msm.c
> @@ -219,11 +219,12 @@ static void uart_dm_init(struct msm_serial_data *priv)
>   	/* Enable RS232 flow control to support RS232 db9 connector */
>   	writel(UARTDM_MR1_RX_RDY_CTL, priv->base + UARTDM_MR1);
>   	writel(UARTDM_MR2_8_N_1_MODE, priv->base + UARTDM_MR2);
> -	writel(UARTDM_CR_CMD_RESET_RX, priv->base + UARTDM_CR);
> -	writel(UARTDM_CR_CMD_RESET_TX, priv->base + UARTDM_CR);
>   
>   	/* Make sure BAM/single character mode is disabled */
>   	writel(0x0, priv->base + UARTDM_DMEN);
> +
> +	writel(UARTDM_CR_CMD_RESET_RX, priv->base + UARTDM_CR);
> +	writel(UARTDM_CR_CMD_RESET_TX, priv->base + UARTDM_CR);
>   }
>   static int msm_serial_probe(struct udevice *dev)
>   {
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
