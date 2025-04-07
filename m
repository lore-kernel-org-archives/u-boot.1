Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861D6C369A5
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 15:12:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3B9C82ED0;
	Mon,  7 Apr 2025 17:12:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="g5/DRgvP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7549482F4B; Mon,  7 Apr 2025 17:12:49 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8B4E82CEB
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 17:12:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso30286225e9.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 08:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744038766; x=1744643566; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=xWy8SYfgI1SLrgK8o/PyNxDLSCkGKWQ4quGyY/m9oYY=;
 b=g5/DRgvP2x2uK6OyJWFpdJZ/bmAMOBKLy2m6QM3MZULzIduUbw5m8ZF6BaSa7OBpOI
 oQFQynuvy3G/UFjTIzfrPUM0pF6E5/zk4znuMT/4mQCCFQWgaLSjyDK92WY5+i1uAaHj
 4sPkrGuGr/LZpoCiD3zXiYu7dSQ7fVwOWgClxRTHLRVuLh5zdkzLbXm3R+O7x6JuE4/6
 63NNluSNIjkMjhHjnC0fdWYWA9aj5HVlTJvXaeyzTq+res/P8DtYaxYy1JCcPf8GuYSf
 bu4dBj0hXSgPeav7rHyHk1TSGslh22vb6tZSgtK4i6z/I8FOSP6YB0Y3HLyuxj/jjsAV
 W5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744038766; x=1744643566;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xWy8SYfgI1SLrgK8o/PyNxDLSCkGKWQ4quGyY/m9oYY=;
 b=O1Fa0qtDIoU1BTPu8vtT8s1H1NOKdiCf0k184O3jKdpmBJI1oNJNVUix2DOUtqu1hR
 3CWUCo6kF1eZQCP2s1hP0aC9v/SlbG8kbg0QXL33+LqNIFX1HY0FQiLqo9Nu4xx5Y923
 970OlzrequkhdPQs+rZOCYYfHYggv5BVFUZQJsUTn1I1o/mH5qzDjnNEJ0dGdNe1uSwC
 WQhmZKN7f5Wom0u2WZ59RW1jtQVzv7316T/rNTOnkSsyP4Cnl75YpkCbtjbM+F+6WTNp
 rJMwmsqTcrNX40+NBEJlbg3bxX95YH0SMpQgMU277Exq98QYfxhPNh2m8vwIzyHwq1Gn
 Mh8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKDt/jXfReN4v44pgGQ0HN2aHlLno/hdZh0pI/CvmXNW6HGJJr/iZUpx1TLz5PlDHMeuaA77A=@lists.denx.de
X-Gm-Message-State: AOJu0YykCrluz4yAtFctOF3KJtNd7tn549QUxf8XI2G0Uj+FPy4ZfGCR
 sYFNQlnI1oOisAHrsmA4TlmNjTBnAi2ACNx9oha7+UliU4zk8Be3xltzb2KVxGM=
X-Gm-Gg: ASbGncsBvAu4yI0srF8+oFN0J8mEl2iBJ/cB5HppXOKJ65UXfIyf2DgYzRPPepL8qwy
 sNaumftehGyhbyN9kj8+S25/iP1uxbVr1frQnlHpTWT0e0socqiEI/z0QcF49LKHqF+WA6/9vUd
 4YW3da35jmuv36ceHwIkxcL/+b2xXKvqvOXtbBM16Ny/ZmXmcBg6D0Q5j8yR6Sd5R3cH6lZYD0S
 nMG0FbZMb5clz3iV85I3XEqbyV3c335e4fxyWDMjqAluyRyV8euyzRj82s6gUgzDqMMbPDcmFnO
 EkFNLhC00tJUHAdbgfgyBCnanMI0clUxfkSSXsyjG2tFKZtJWdRyM6WkXGprJ5ELI5omkEeRLEc
 8xmFjdZlGfCfO5RTgUahrnQ==
X-Google-Smtp-Source: AGHT+IGNELMGCL4z+zyzw/cAVgnrvsF6N3p1oyWwbvZ/UANC7IiUNNZMglCb22ODxPGdJSSZm0fFMg==
X-Received: by 2002:a05:600c:1f16:b0:43a:b8eb:9e5f with SMTP id
 5b1f17b1804b1-43ede41cc27mr108543185e9.3.1744038766369; 
 Mon, 07 Apr 2025 08:12:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f2a4:b974:cba3:a605?
 ([2a01:e0a:3d9:2080:f2a4:b974:cba3:a605])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec16313edsm136188865e9.6.2025.04.07.08.12.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 08:12:45 -0700 (PDT)
Message-ID: <c834224a-a69d-42d5-ae2a-b6b363d9d2ee@linaro.org>
Date: Mon, 7 Apr 2025 17:12:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/5] clk/qcom: apq8096: fix the sdhci clock
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
Cc: caleb.connolly@linaro.org, sumit.garg@kernel.org, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20250407120536.236003-1-jorge.ramirez@oss.qualcomm.com>
 <20250407120536.236003-3-jorge.ramirez@oss.qualcomm.com>
 <ca4b11e9-4bd0-4a9b-9980-ff2367f8c43f@linaro.org> <Z/PeZVBhwcNOVRAD@trex>
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
In-Reply-To: <Z/PeZVBhwcNOVRAD@trex>
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

On 07/04/2025 16:17, Jorge Ramirez wrote:
> On 07/04/25 14:36:51, neil.armstrong@linaro.org wrote:
>> On 07/04/2025 14:05, Jorge Ramirez-Ortiz wrote:
>>> Select the right clock for sdhci.
>>>
>>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
>>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>>    drivers/clk/qcom/clock-apq8096.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
>>> index bc00826a5e8..551f52d5197 100644
>>> --- a/drivers/clk/qcom/clock-apq8096.c
>>> +++ b/drivers/clk/qcom/clock-apq8096.c
>>> @@ -83,7 +83,7 @@ static ulong apq8096_clk_set_rate(struct clk *clk, ulong rate)
>>>    	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
>>>    	switch (clk->id) {
>>> -	case GCC_SDCC1_APPS_CLK: /* SDC1 */
>>> +	case GCC_SDCC2_APPS_CLK: /* SDC2 */
>>
>> Should be GCC_SDCC2_AHB_CLK
> 
> why? also if I do that, mcc fails to probe

The discussion at https://lore.kernel.org/all/Z/OqoqnPb1gfk5iG@trex/ made me thought using GCC_SDCC2_AHB_CLK fixed the sdhci set_rate, but I maybe did misread.

Neil

> 
>>
>>>    		return clk_init_sdc(priv, rate);
>>>    		break;
>>>    	case GCC_BLSP2_UART2_APPS_CLK: /*UART2*/
>>

