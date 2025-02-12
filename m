Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867BAC02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 08:21:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC35980824;
	Wed, 12 Feb 2025 09:21:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sjE0Bzac";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5072D80842; Wed, 12 Feb 2025 09:21:44 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42FC3807C0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 09:21:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4394c192285so14885115e9.0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 00:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739348502; x=1739953302; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=fpwNDuMmVFZufVh5GinXYabm/51hviWd7gmujQbWAjg=;
 b=sjE0Bzac+JBuv/vF1P6tlbX6hT+ND2UCIeuHERGV9ynOF5Pes0fxZVdPQT3+I3qUEQ
 zwnDHbvuU7UT1HUjIt9jKLMVozc+CpApjleifhAXj2TBwjMb4K1r0jATR/0wH98Nmtst
 /SZs85OMrJv/RlESq7chowxWg/oA/ImB7q0Jj2eM70gGO5kd9Cir8YPUO0A+t8x86B8f
 4yEoZaMYN9IjQtBJhwSZdyNk6Pwbhf9ZJnCViQUEJlmA9HF47/amlJ3IXXH6pCFfA0Tc
 0OxneKkAAUz/+G594PPQQ4VC7Dx/4fUv6S9tmFuZFnz6j3jjaNq4grsw+CDm6Bw0MfPf
 UXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739348502; x=1739953302;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=fpwNDuMmVFZufVh5GinXYabm/51hviWd7gmujQbWAjg=;
 b=Slg59Q1GjMBj1h/phZRW3YqyHzMXlyaN2QBlkA4rCVnjEJeQkFzSQv0pQyLstAksm8
 5+ePipyqmODAItxz1BYJaFJg2thwwIYcC4RNg/aarOtGSOoBXk4rHWa7pGeHjJ8aDUBO
 n5atXf8Ju08YFbNnwpQgGjUj9N0GbqYeXx7TZ0ymYPae7neDFz2L0qtkS4/kjHlkYePE
 T8/ZVS/f6CvU3AZXXAcaNEmPyC7bOdRygCm3QoDESq+KwJGwx0b4/mfdS8OkheDsMFBs
 nAiTz1v8gTg8jwRawitUgeNK8C4gMuU5nmRkIe7DK0JStQXeks3ZUSNkb245DFUW7khO
 3EVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDKzflknqVNgO2NxgzRhXFJWSS4V7jiOp7sIp+KLEyinPAA7v+icUjitztbU66ISvuPGrmeaM=@lists.denx.de
X-Gm-Message-State: AOJu0YwGCqdJUeVRj6Gm3Gwm2ZQ/TeivsPVnXqF47xHmfTkqvyAHxH0y
 5+oSnVVBtgLzeoS231BHquGwwpgmnh6kO5qX9fpyNd4ClqJHGt5vrlLG4S2i3Xo=
X-Gm-Gg: ASbGnct2jkMi75Z/NEE+86HIB58s+lx4qGULxFWb5RNoTehvuByO2jZbUhUXHKxbOf9
 dNaqqfYeQXXGZN28Cd1STlnmfllnCgX1gZ53y867rZfwTFjr0DzICTUKRb4TYOpp+11OI1urYS6
 1RmWWrcbR40ZqF99f4xq9KAAqkY2J73amVMfA2PoLlOpHLYlFkqySM0AdthojVlfJ+liYlV30JZ
 IOCCmQDrBgA23jF4E67PaX15u5HJH38vOSpMXN4wlhdMyXLONvZ2u88p0IwAq077a09BpjqNJ6W
 00ZOMDAIxpsw7Ve0tRh3d93+PXkTnNWKkXHmKOHL6UFd6OQk/ypPpn8m7pzOZTDLULqk
X-Google-Smtp-Source: AGHT+IFXmctVlWNiWfPGns9yopaetdSZrkutMioC66VdRt5wQBpKDPKQueFov3vXimYYKk8xiJyW0g==
X-Received: by 2002:a05:600c:2d53:b0:439:5a37:8167 with SMTP id
 5b1f17b1804b1-4395a37827fmr11597745e9.19.1739348501672; 
 Wed, 12 Feb 2025 00:21:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:aaf2:5110:cd96:8172?
 ([2a01:e0a:982:cbb0:aaf2:5110:cd96:8172])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395afaf052sm8628145e9.13.2025.02.12.00.21.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 00:21:41 -0800 (PST)
Message-ID: <8de86ad6-03b6-4346-bb42-8637e630904b@linaro.org>
Date: Wed, 12 Feb 2025 09:21:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/2] pinctrl: qcom: sm8250: fix pin count
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: Amit Pundir <amit.pundir@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20250210-b4-rb5-sdcard-v1-0-3c34a8bee77b@linaro.org>
 <20250210-b4-rb5-sdcard-v1-2-3c34a8bee77b@linaro.org>
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
In-Reply-To: <20250210-b4-rb5-sdcard-v1-2-3c34a8bee77b@linaro.org>
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

On 10/02/2025 17:30, Caleb Connolly wrote:
> The pin count wasn't updated when the special pins were added, as a
> result it was never possible to configure the special pins on SM8250
> boards.
> 
> Fix the pin count and allow the special pins to be configured. This
> fixes sdcard support on the RB5.
> 
> Fixes: 58fa52042471 ("pinctr: qcom: sm8250: add special pins pins configuration data")
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/pinctrl/qcom/pinctrl-sm8250.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-sm8250.c b/drivers/pinctrl/qcom/pinctrl-sm8250.c
> index cab42fa64ed2eeda7259b0f6065bae8779d06d34..b21cdc4d24b7abd34d3a08a5e1f5d74f9bba4184 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sm8250.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sm8250.c
> @@ -106,9 +106,9 @@ static unsigned int sm8250_get_function_mux(__maybe_unused unsigned int pin, uns
>   
>   static struct msm_pinctrl_data sm8250_data = {
>   	.pin_data = {
>   		.pin_offsets = sm8250_pin_offsets,
> -		.pin_count = ARRAY_SIZE(sm8250_pin_offsets),
> +		.pin_count = 184,
>   		.special_pins_start = 180,
>   		.special_pins_data = sm8250_special_pins_data,
>   	},
>   	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
