Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F92CFA773
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 10:47:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E50068367F;
	Fri, 21 Nov 2025 11:47:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lvX9b0fS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E38783693; Fri, 21 Nov 2025 11:47:53 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D51C80433
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 11:47:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-42b31507ed8so1610435f8f.1
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 02:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763722070; x=1764326870; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Bbo83ewuqtCd+KljDmIm/bG+Q/k54XNSHfiHxcDtdyA=;
 b=lvX9b0fSbJdF2Mbozy1DcgIfceTDzEuNLQRFIkax8WS+MJWo6mjZQtnKMkIx9DUnHt
 Z7e7UBIO3ceNzI7qq4hRMIeRq2OO+AjQXppV1boI5jbqwRZ3CpiPimPSa2mm3zFRGbuw
 PSXsNJMtqfdPYfnOoUGi6phEMiUw7ajaamuIlW/RtNsXOc1MFS9r4tfwbrvOyCIsgZ2E
 sEZEyhE8u+aZohXQycJ9yPPG8zFWdD2R2xGtqsJ8stxRuSfz3c/rM6SyExwhsC0UUaHY
 CXn4RxkHgNSLt3BCeqTVrczIE5DZEdf80h1dl6MUE3I1B7D1pc2Eq9X4Zki1fCLymV3h
 Qxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763722070; x=1764326870;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bbo83ewuqtCd+KljDmIm/bG+Q/k54XNSHfiHxcDtdyA=;
 b=ZgBS9q3w7DtSvWzmNMrl3E3L33sNb0b5s+Jis/ZUQv+cfMyP74C8UswnL0KKT8VWZ1
 pwIbXNOMpHzTjfDJQoj/tmUFkRTEPuyDbVFgUWPXOszP1bq+S/xJWevkcPxb2Eh+YBDn
 FQNCIeKD8JXlXHhGuxFDb5NnKCgzUZlLgB8WOpOzdESNPfFhdtfjNv5vEwEgjEd5Udd5
 zkuhN5py+l9DMMRDqKrziEfJlHq6wU8hTGoRKPBBmTtcDJDSLBjib4uBfNp/btYbMbbi
 aIxw0bhfOFbhSzohUHFYU4Li54fHtytK5aDHBl5PUM+hSCF8gH0GLtoNCkZleMl9Ypd4
 8vgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCViQ2A5anL85tDE+mVM/Qx1B5xQJ/yO8IihN1/seJpYjSYTq1P+Ww9P8YvEb2UCfqinZVilyqY=@lists.denx.de
X-Gm-Message-State: AOJu0YwLjLYGV7xciq+SD6E9AP9T2/uPrvqdVnjrIY55c7R01M5TDbkd
 Osmy2U6OCqAnG1YzF0BtIkcF5cg5SUVtLaZZ8QzZsyjvP98+/uWVrtk+KAaB1l+ppvw=
X-Gm-Gg: ASbGnctd8woH6jLlo8pb9GCjT1Ab6N9tbwbGUOQ9M2rT2V37qab1evw/pGnTI0zgLQI
 Qe3tKSxM4NuKd8DVQggR4WkTouXds9GGEbTcXJsuoAEtlV1SIMYtMhhdcMAshuIU+bFtzoGH0+i
 90g9+HbTksVFysy6P7EfBpBM9C0qGh9GaQNic4Bs2bPwrlf2dRT1Iki4nTrgiN/QcUSClTiSm2f
 jCmr+DF3YsWFcF8NJv1sOT7KeNH3qEoxoze5chNGEtMjZV9kMj+pScSpqKKpcyFUHaw7qiPwt+K
 p0WJ2yFGw4TQpiyL0T0aKCwovS2fTd9V8solB4Ht41o9PULmNd/kX7SEPbYUS0gA/UymDP3A6q3
 xFeNClonqiiUNb6qyQ2XIVkvHtOqgAiT6Wx4CyiYIkbTpA4xCSyC03ahKKthoC8DqMzvvjKXn+p
 irlxQxzQHit5mQ1JdFOw3SwgfgPy84+dCwnxVaWNqswZUipG4vTjeD0Hj0/BhaqmQ=
X-Google-Smtp-Source: AGHT+IGOEZUgHpGEv7ShYxzwi+0FhVdQPo3e2LjrNVG3XdJ7efundVQ1FZhGd19XzvxXGqMam0gRGw==
X-Received: by 2002:a05:6000:40cc:b0:42b:4267:83e9 with SMTP id
 ffacd0b85a97d-42cc1ac91e1mr1773208f8f.2.1763722069818; 
 Fri, 21 Nov 2025 02:47:49 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:159f:1839:bb92:1eca?
 ([2a01:e0a:3d9:2080:159f:1839:bb92:1eca])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fa35b7sm10525979f8f.20.2025.11.21.02.47.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Nov 2025 02:47:49 -0800 (PST)
Message-ID: <958c0c45-5f82-49ff-8488-ab5abd7c0e3a@linaro.org>
Date: Fri, 21 Nov 2025 11:47:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 2/6] drivers: usb: dwc3: Add delay after core soft reset
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, casey.connolly@linaro.org, sumit.garg@kernel.org,
 lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 ilias.apalodimas@linaro.org, rui.silva@linaro.org, luca.weiss@fairphone.com,
 quic_varada@quicinc.com, mkorpershoek@kernel.org, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20251119152530.4175628-1-balaji.selvanathan@oss.qualcomm.com>
 <20251119152530.4175628-3-balaji.selvanathan@oss.qualcomm.com>
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
In-Reply-To: <20251119152530.4175628-3-balaji.selvanathan@oss.qualcomm.com>
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

On 11/19/25 16:25, Balaji Selvanathan wrote:
> Add a 100 ms delay after clearing the core soft reset bit to ensure
> the DWC3 controller has sufficient time to complete its reset
> sequence before subsequent register accesses.
> 
> Without this delay, USB initialization can fail on some Qualcomm
> platforms, particularly when using super-speed capable PHYs like
> the QMP USB3-DP Combo PHY on SC7280/QCM6490.
> 
> The change is taken from following upstream Linux implementation:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/dwc3/core.c?id=3d25d46a255a83f94d7d4d4216f38aafc8e116b0

Can you explicit which actual commit added that on the Linux driver ?

> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>   drivers/usb/dwc3/core.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 847fa1f82c3..ff0bca0dd8e 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -94,6 +94,8 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
>   	reg &= ~DWC3_GCTL_CORESOFTRESET;
>   	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
>   
> +	mdelay(100);
> +
>   	return 0;
>   }
>   

