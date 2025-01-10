Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC98E7719C
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 09:53:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21FA7800D0;
	Fri, 10 Jan 2025 10:52:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CCspnT5L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47CE1801F5; Fri, 10 Jan 2025 10:52:58 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADF34800C2
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 10:52:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so19841955e9.3
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 01:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736502775; x=1737107575; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=KTGvgSlqHSdjdGjgvqmgklWQachImCGJkJPC8PaU2PE=;
 b=CCspnT5Ld4bqwSRK4NTNEc5qxBPnukvgLgJTXgTRlLfEBH4aug8WCnCVO410BCRj3x
 AxDhieLyhALqkICyKMI/s8PMqI0KZuhyNXl+jrnPoR+R0TgOM6F8b2CEe0+vR22Tmlgw
 +lMFlXxWJOJLlV3Zx6y6EgCclYrMOXJIPILXdqt9XVFebw1G3OWSl9XNLyT5hG6puL7e
 HjpaaHOGPRX33ioLWVwf30UF2B6laNLGmchswkSa3bQES7M+XTtKHc1JDRPPOIQdfY+w
 56Hnz/ot/0lcubjyk3ub/S8RA/PBn36jrgm07TG+rjgBJIl4kqyhka82JL6HFSNzjLcy
 Octw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736502775; x=1737107575;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=KTGvgSlqHSdjdGjgvqmgklWQachImCGJkJPC8PaU2PE=;
 b=I5XbdOOx7EXzrJuLQTcxRPkZonsg5SAjEkqnE/y3FFDKZGi/taFOeoq1YrqZEo5/Cw
 SdYuwWWrAVTHf0iB8wUKMI5XMrm0jdKCATTC9s9a8PcrKaSE1+z30gFnXPAOt/Edyrzm
 eD1l4khQgs79Urp53uNo87L6nXnLcdXnBgpsKUfhqTI0Q0VZI1C9mbMf7d0ztSoqadFu
 x5k+Kd/xrpr2Oq9eBeekYtMhKm4Jnoz15qMyfHGXyE+o13o9EKCxJdGdhaWmzankJqbS
 UPI+yA3LS9nxCfmAS0sy1Jalnrkmoa2x6c1CG0pfv6UMo5awulI+5lGekcfIXA202Pfn
 frpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjmmOSVN5a1QgcFkbSi65eeA8Bl3QSeGu8WqBhDT0xX8rx1NAWHS/ESoBsRIbKwl56Ihw85aU=@lists.denx.de
X-Gm-Message-State: AOJu0Yyn35/WXt4ArKUKmMsEaCYmzF71cfU0l8AlrGhaL3X/32jnvzjk
 ierVybiSsSDJZ+sQheX8XftBJAzp3cYDOslVRtWz42Okog0KGSekOtzOQIJ1b6c=
X-Gm-Gg: ASbGncv93ZRecYxAipTGvgQrN9zh+zEkmycS7Uf35feH0+Mo/P9uq5O2ozJ2zkYE8ug
 AVlBO0KcmKinJjjiX4RCgOV3F3lxRERKqG2V9buL8xyFvQ/WDVOvJZJHsXxJPiB6wchZo3VV66j
 cKo7IoeTg+WPqjhZcykq9FlT5qHUD6/m2LzzQY8TY0j50Q3/+/xInJv8WR8WA6kzYRnErrHWjRd
 LhfDazRisfs8QzYzTbQ7pHZp/REqCJKoX4R/UXglKh61jWp+//yuAUS1SqklFi2WoFGtVOdq8De
 xxnJYZxUwj+fqeU8RTibMRpA9//r1D448A==
X-Google-Smtp-Source: AGHT+IE+e1o6at3dxDpqHrOfkViJYmpSZv8MJO0NYLPQcunMxYHijSnmT6If/sH48qvI1z7Tdfeylw==
X-Received: by 2002:a05:600c:470f:b0:434:a94f:f8a9 with SMTP id
 5b1f17b1804b1-436e26f1305mr72758085e9.28.1736502774962; 
 Fri, 10 Jan 2025 01:52:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:bf4e:5758:59ef:deb8?
 ([2a01:e0a:982:cbb0:bf4e:5758:59ef:deb8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2e89ca5sm81330755e9.29.2025.01.10.01.52.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 01:52:54 -0800 (PST)
Message-ID: <242faa80-7b18-4d03-b7f8-b9a809eeb585@linaro.org>
Date: Fri, 10 Jan 2025 10:52:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1] usb: dwc3: core: Fix timeout check
To: Varadarajan Narayanan <quic_varada@quicinc.com>, marex@denx.de,
 trini@konsulko.com, mkorpershoek@baylibre.com, caleb.connolly@linaro.org,
 u-boot@lists.denx.de
References: <20250110074306.3897847-1-quic_varada@quicinc.com>
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
In-Reply-To: <20250110074306.3897847-1-quic_varada@quicinc.com>
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

On 10/01/2025 08:43, Varadarajan Narayanan wrote:
> dwc3_core_init loops 'timeout' times to check if the IP block is out
> of reset using 'while (timeout--)'. If there is some issue and
> the block doesn't come out of reset, the loop will run till
> 'timeout' becomes zero and the post decrement operator would set
> timeout to 0xffffffff. Though the IP block is not out reset, the
> subsequent if check 'if !timeout' would fail as timeout is not
> equal to zero and the function proceeds with the initialization.
> 
> Make this a pre decrement to address this.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>   drivers/usb/dwc3/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index a35b8c2f64..8f58e4ea2d 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -612,7 +612,7 @@ static int dwc3_core_init(struct dwc3 *dwc)
>   	/* issue device SoftReset too */
>   	timeout = 5000;
>   	dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_CSFTRST);
> -	while (timeout--) {
> +	while (--timeout) {
>   		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
>   		if (!(reg & DWC3_DCTL_CSFTRST))
>   			break;

Good catch !

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
