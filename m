Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0240C3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 07:18:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BA3382EFC;
	Tue,  8 Apr 2025 09:18:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="a3lJISo9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47587831FE; Tue,  8 Apr 2025 09:18:26 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D90C981F66
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 09:18:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43ed8d32a95so29347785e9.3
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 00:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744096702; x=1744701502; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Vc30F09uiiYMRK6xcBcEJZUu4Fm7zrBqV2NwwBM31fA=;
 b=a3lJISo9wOADvF+rJ5cDHgsMyHJ7wImso2x0hNEWxkZSSsq25rz9NfxE6L71V7RUX1
 38W5KGF+cXytHpF6b6NZCsYlN1TL21qeap5Ff+frlsKpZ17w0g7RNkrFzJ0PD4SzOZzr
 CPmBGPa+d1UCHKT9kQsLSxHNikak0B4q/z0Dc/0wk1qKE3Y55ByzfStwzL9FQt1Xh7+V
 tZTfp7Eb0SWYjDYdlV4J/V2uOrjoVVr9Mb8IiY+tnzAPW5Utq4MTdOY5RvcD0LznklQw
 Pmux8N0ab1yf6Ia4oUgoRqc7Cf8UKLchB76uEROOY1jXX0Cw0DgFWegThFmvZuGs+4ER
 kIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744096702; x=1744701502;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Vc30F09uiiYMRK6xcBcEJZUu4Fm7zrBqV2NwwBM31fA=;
 b=u1yVgE3VUUDIWg+OnPz96N+zsLkoJcpx/+7enQlHklGNvs0JZ9PBhtkqraPLitiK8U
 aFLy1XOPDISQLxByEP1853+asENNnCKJt4LfotJQELDNrSV7RueW3YpT8Pq7GyTQ5/lS
 iaOobtRLO/f9/7Z8kx9xT1ofLnGDwkWMGtM4oHczZwOQzuP1ivs7K0BNsm6pX9FV3vto
 rrLvJnChg/WkjThKLjpn5NdLT+3HC7QAVr8NlKd9rYeSkUD1zXsRzLQHJLtgb/8mc+y1
 v/nsdk5jh8wQZAet5lmXWXuNm/mL3PR4yypMLgLta3urFse2d5/gySf3q7tDDC5hCPgb
 JQTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKrlqKS9ovJ2V8C64rAlubgtwnPyEhvTaRn4Ve6PFNIdnpDZJ21uHRfVKK03Qkwjvq1TfGv+g=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8KXa42nKzvgCwm1GYJWVlSfD1eTq2w4Mo9rCImO+gFW9HEJxp
 PNR6D7ugHFyi+9ZCy20+Bjp0Aibqcmp/fmps6JeHQoEHilCrUAjpWOTvRl9ctsg=
X-Gm-Gg: ASbGncvp9sRYEGKsiNLMk2RRGNHBGGRLOpU09s3g6SPZvarTC0diEeDsjMMpNnGwH15
 DR6WIXdT8nsi4c2SeizHIXGcfuL9o4kRN/R7vQPqmfGQODptaBCi6ClVlNO8PzZftFZnSbA2sj6
 4bjPiiheTb4O5xtS1Wj8IHkg0Nn8KV+Z0akHBsAtWKQOLZ/Ukhk91XOgfrmnQ5pvm8bw0oztsPx
 bcfkgjQg1LlN6w/hX6fwi80WlGXdoTUEd0fJ9R68ZXd5lX1IO5UO0hlJaZW+dwhujhwZykQTRJM
 yMO6YW+/RUNTi+8H/bUTRWd/2GUXte6VL3nAyxL3mQC0xsB7x6F0gcKyi1IEdILRt/SdPx5Kg3C
 yaz2HtVZB9XMnR6Cuh2o03xr+a5Lq2BdC
X-Google-Smtp-Source: AGHT+IH20Oa7onREdFzLsSjCNKg2D2/0BvW1d0lHwi3aYgaYiJhd8wPVB9/2vwe0JOHM+j3wLfNzIw==
X-Received: by 2002:a05:600c:1e23:b0:43b:c95f:fd9 with SMTP id
 5b1f17b1804b1-43ecf81c304mr137256665e9.5.1744096702291; 
 Tue, 08 Apr 2025 00:18:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3daa:5b6d:6ccb:4c71?
 ([2a01:e0a:3d9:2080:3daa:5b6d:6ccb:4c71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30096ed7sm13672275f8f.8.2025.04.08.00.18.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Apr 2025 00:18:21 -0700 (PDT)
Message-ID: <2eb96077-b91b-4ff5-b076-73f3e549b333@linaro.org>
Date: Tue, 8 Apr 2025 09:18:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 11/13] board: dragonboard410c: Enable support for Android
 boot images
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Sam Day <me@samcday.com>
References: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
 <20250407-db410c-fixes-v1-11-524aefbc8bb4@linaro.org>
 <fb4750e2-2f1b-4b17-8bd5-c050dcca01ee@linaro.org>
 <Z_TJuL42qnWemuyl@linaro.org>
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
In-Reply-To: <Z_TJuL42qnWemuyl@linaro.org>
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

On 08/04/2025 09:01, Stephan Gerhold wrote:
> On Mon, Apr 07, 2025 at 08:10:24PM +0200, Neil Armstrong wrote:
>> On 07/04/2025 18:59, Stephan Gerhold wrote:
>>> The U-Boot port for DB410c still has plenty of extra space available at
>>> this point, so avoid disabling features that would be normally enabled by
>>> default. In particular, this incldues support for Android boot images,
>>> which is quite likely to be used together with the USB Fastboot interface.
>>>
>>> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
>>> ---
>>>    configs/dragonboard410c_defconfig | 2 --
>>>    1 file changed, 2 deletions(-)
>>>
>>> diff --git a/configs/dragonboard410c_defconfig b/configs/dragonboard410c_defconfig
>>> index 62fc42c9460d075fd27c3e2823eb8eea2a559772..414dda6778c95eb3fdcd6ef522d8c7d0ef9219fa 100644
>>> --- a/configs/dragonboard410c_defconfig
>>> +++ b/configs/dragonboard410c_defconfig
>>> @@ -14,7 +14,6 @@ CONFIG_OF_LIBFDT_OVERLAY=y
>>>    CONFIG_SYS_LOAD_ADDR=0x80080000
>>>    CONFIG_IDENT_STRING="\nQualcomm-DragonBoard 410C"
>>>    CONFIG_REMAKE_ELF=y
>>> -# CONFIG_ANDROID_BOOT_IMAGE is not set
>>>    CONFIG_FIT=y
>>>    CONFIG_BOOTSTD_FULL=y
>>>    CONFIG_OF_BOARD_SETUP=y
>>> @@ -25,7 +24,6 @@ CONFIG_SYS_PBSIZE=548
>>>    # CONFIG_DISPLAY_BOARDINFO is not set
>>>    CONFIG_MISC_INIT_R=y
>>>    CONFIG_SYS_PROMPT="dragonboard410c => "
>>> -# CONFIG_CMD_IMI is not set
>>
>>
>> What is IMI ?
>>
> 
> The "iminfo" command. "print header information for application image".
> I don't know why we need to disable that. I just dropped all weird
> exclusions in the defconfig here.

Indeed, weird


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

> 
> Thanks,
> Stephan

