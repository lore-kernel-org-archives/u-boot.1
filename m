Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AC5C77B7C
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 09:40:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D878882D21;
	Tue, 24 Jun 2025 11:40:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XqLxW1pe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C288E82E20; Tue, 24 Jun 2025 11:40:05 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5777882C84
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 11:40:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4531e146a24so1479315e9.0
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 02:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750758002; x=1751362802; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=TJ0jPZRvYl9NswujPOHhw6xJcdDcINuqHYGDZuvE8XU=;
 b=XqLxW1pewePH3Erxi61+ehqayL9aqr4LzjR2i1ThotO6pe2KAAVma0Ha6aimaE4Nsf
 nPeLDN6e6XHQdEY2cIMgcyEKksSIp4gktuSd+xsXvjV9DbsdHNxFr92SCftXjuvznKnp
 WtRItvBKA3mRsJyW0weW8aXLFa3C0+lzYk4gXuTvvEfCBhpPIUNe5ojKvu0aePzgd/Uc
 BrD/X1DF0QsTWjMevYWs8pyopaLBwOtEh//LdScSmA+hEAm8Z0Jiy1kSP4fiw3tNfwFV
 5OqiPMj/iG65Zcly1cMoI3HUt03U5EWbv9sI5JjBQziHnutPtRNmTOxIa61AQDB4dg08
 sF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750758002; x=1751362802;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=TJ0jPZRvYl9NswujPOHhw6xJcdDcINuqHYGDZuvE8XU=;
 b=Cwy2zBkmuWgg8yKfvEGCoO2lpq8eamciSLZnPs9K5p34+BejPKaLtYnWfFZ3crNpeS
 kPTdum1Iq/uOs//HHoAyiIbxvIQ6P+J6XPkiKbYIjunjfIIkO18oAZB19D5N5M9tImmD
 eOiNe3kUcLaQWyX+iCLR8naSIKh/AnNjUve+9UUgEPfXadE9N2/VaCOllguvRizuPs8G
 o4RD7FWcAaG1Q4IGuw940ozac/TS5lSyy86qMkbLri6CTSFiezyISFTU9ksbEf2IoGVg
 XzYtEA+GGnBvIIErvtBhPk46EYPh3EiFFYE+n8FXcJ7RTTUbREK9qS94sH+2FGHQ/PVg
 NMgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkjzC5ZT4CRdOZEt9oliAAVBm9sEaoKy6dks4r02ADj4AjiFaPcQNJxM3igpMSOi1zOHJAQ3E=@lists.denx.de
X-Gm-Message-State: AOJu0YwS2NDUBI9bpNyRfFOzSOqNKj1obzwSCxIoKMFI3+tDUHOQwBFt
 aHL22DyWWrPOoD6D2/uywfLlxn09mexhEzz4tnP0w3AavvXu6t9K4CEESnEvGvdKSjo=
X-Gm-Gg: ASbGncuNGDDZcnlEVRX0pEf/6dfzRs69Z1KIXUGKOrVd7n2YFAg76wypgNDMtrcArUg
 aPnvx+fYshiB5pPi+Y8z/qoe2N5f4Xb4GJIJ2h9AkbABfhY79JVP1hG8q2QEk0glydzYvXHm4hU
 BKEw54+IGLp0pscSDnMwrR1cmzfUq1iYuuim2dU0elZNqmbUy0EdU7SP6kRNENbWVYN+6hvo7HH
 sYPi6fzqAFivO5wBG8dG73uQqPTgLuJBdlnSrSNL2VzgCnu+3QU7YGohtPiBCUyR+rGm5ONSfX5
 9XCv3fjGuVIQUet55FhRxwG0+W/WmeYdkHwTgdQyYqilnUScZDfbpmQQShpDUKIFCeC5d/DSoY/
 cF+a7D4eerjlzI0/OURnbS13Tadb6Np+62D2ovRs=
X-Google-Smtp-Source: AGHT+IHj8DW5HbHASX8OpfI3LmLpXUFDQ4JnRkhQqg7ihEDIeK93eHqQAQuxiZoLnofvcuES2Jqc4Q==
X-Received: by 2002:a05:6000:4284:b0:3a4:e844:745d with SMTP id
 ffacd0b85a97d-3a6d13315c2mr14012726f8f.56.1750758001819; 
 Tue, 24 Jun 2025 02:40:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:6fea:600c:ca20:f54a?
 ([2a01:e0a:3d9:2080:6fea:600c:ca20:f54a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e810a9bbsm1459552f8f.86.2025.06.24.02.40.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 02:40:01 -0700 (PDT)
Message-ID: <97283669-8382-48ca-b48c-48449ad17fd8@linaro.org>
Date: Tue, 24 Jun 2025 11:40:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 09/10] serial: msm: Re-enable after resetting
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Sam Day <me@samcday.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250624-db410c-autoboot-fixes-v1-0-d96c97ae41d1@linaro.org>
 <20250624-db410c-autoboot-fixes-v1-9-d96c97ae41d1@linaro.org>
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
In-Reply-To: <20250624-db410c-autoboot-fixes-v1-9-d96c97ae41d1@linaro.org>
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
> The documentation for the UART controller in the APQ8016E specifies that
> both RESET and ENABLE commands must be issued to set up the receiver and
> transmitter, but at the moment we only issue RESET. This doesn't seem to
> cause issues in practice (looks like the reset already re-enables the
> receiver/transmitter), but let's add the two writes to RX_ENABLE/TX_ENABLE
> to better match the recommendations in the documentation.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>   drivers/serial/serial_msm.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
> index 5523ec4afe17f242d61bc2ec4b4534b5b974434c..2c08a84b02773663f3c3a11eddaaa7a8bab2b4a1 100644
> --- a/drivers/serial/serial_msm.c
> +++ b/drivers/serial/serial_msm.c
> @@ -50,6 +50,8 @@
>   #define UARTDM_SR_UART_OVERRUN   (1 << 4) /* Receive overrun */
>   
>   #define UARTDM_CR                         0xA8 /* Command register */
> +#define UARTDM_CR_RX_ENABLE               (1 << 0) /* Enable receiver */
> +#define UARTDM_CR_TX_ENABLE               (1 << 2) /* Enable transmitter */
>   #define UARTDM_CR_CMD_RESET_RX            (1 << 4) /* Reset receiver */
>   #define UARTDM_CR_CMD_RESET_TX            (2 << 4) /* Reset transmitter */
>   #define UARTDM_CR_CMD_RESET_ERR           (3 << 4) /* Clear overrun error */
> @@ -225,6 +227,8 @@ static void uart_dm_init(struct msm_serial_data *priv)
>   
>   	writel(UARTDM_CR_CMD_RESET_RX, priv->base + UARTDM_CR);
>   	writel(UARTDM_CR_CMD_RESET_TX, priv->base + UARTDM_CR);
> +	writel(UARTDM_CR_RX_ENABLE, priv->base + UARTDM_CR);
> +	writel(UARTDM_CR_TX_ENABLE, priv->base + UARTDM_CR);
>   }
>   static int msm_serial_probe(struct udevice *dev)
>   {
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
