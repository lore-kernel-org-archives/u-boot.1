Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DA9C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 16:38:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83143878A1;
	Thu, 21 Dec 2023 17:38:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xEokDR1K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5D878786E; Thu, 21 Dec 2023 17:38:12 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DD56878D7
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 17:38:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40d3f2586d4so6977285e9.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 08:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703176689; x=1703781489; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=EyVnAf77ckQX+w0UW1y8UPFX/V4LHkSoacTAjVL6Hxw=;
 b=xEokDR1K0viy6JDltx8bpS5gOYpAfjKPWQj1+bzEe44TB4ZyhEkPnS5bkGwI3C8NwD
 8ny0zgFUIPDEeZfADK4bVAu9yvNotPnLJGWZREje7Kj8PhHVYrlkmNzdDp3rDl+bEfPx
 CLY7MeFYAmkqvgbR65yrOpQlx9WnQ3KK8J2vdcZyXCQVQs+7YBGKoHUFraFwgYcdRM7F
 amNYXr62uD+6KFSFoD0T2+sfU3//+D53pwIEpEvLHdH2t2fdK6AIGCurTx7fFl9kXHa9
 SjGyd57LCvUUdNYKI0yZf1+WdVH4lIoXLTTxpbtVDmFmgHYwsjCu+faxKduRDgCuaH3E
 2S+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703176689; x=1703781489;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=EyVnAf77ckQX+w0UW1y8UPFX/V4LHkSoacTAjVL6Hxw=;
 b=Fq5aoayE+O73Kc9oklR0W7niznNw0XAXK6ZZBZ/aX+gXf9TywrKkd8HqvPSDJ5utyM
 ugRjsnTIy95fiTSrc6s1Wbw5Sp+NT6sAc2xdUS5pwCvBzHOlddOfPf9uzBgCmpuvv6MK
 CurgMmKyaQaz6unjL6q9+o+gUTrhfBcA7Dznm1b/vc/vM+CYGraDl5xPj427StN1wXx+
 fAgWsr2gOQ8v8LAmO3bxtWNvNmQ1+uDIoD4pjjuz98b3up4Se+8JR8Sq3OoLwvzwBb8g
 ca9lDMzmH7tu+GuROudas78jvjP6WPTxNW1WayipoiTyz2Vfm4c7xTsAUz7YcaovO8ht
 eaQw==
X-Gm-Message-State: AOJu0YyTIJbiqzYg1HM5wBk0SvuPIC1rKGbl/XXi8uBJhsfPlFNCKu6k
 GxSs4O6+uxZOVI8ri0b36JYPEw==
X-Google-Smtp-Source: AGHT+IEmyqLkPzKdh84d5w21AW8lDCMYznorh/FRIkI5EppioLSYC0zNpuCjYtg6ZFQuXrCBdETTVg==
X-Received: by 2002:a05:600c:b43:b0:40d:30c0:dda4 with SMTP id
 k3-20020a05600c0b4300b0040d30c0dda4mr976327wmr.150.1703176689010; 
 Thu, 21 Dec 2023 08:38:09 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed?
 ([2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed])
 by smtp.gmail.com with ESMTPSA id
 bd7-20020a05600c1f0700b0040c420eda48sm12216169wmb.22.2023.12.21.08.38.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 08:38:08 -0800 (PST)
Message-ID: <e628e721-4747-4b53-9a69-53c95864bb6d@linaro.org>
Date: Thu, 21 Dec 2023 17:38:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 24/32] dts: msm8916: replace with upstream DTS
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
 <20231219-b4-qcom-common-target-v2-24-b6dd9704219e@linaro.org>
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
In-Reply-To: <20231219-b4-qcom-common-target-v2-24-b6dd9704219e@linaro.org>
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
> Drop the U-Boot specific dragonboard410c.dts in favour of the upstream
> msm8916-sbc.dts. No additional changes are needed to this DTS for U-Boot
> support.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/dts/Makefile                   |    2 +-
>   arch/arm/dts/apq8016-sbc.dts            |  729 +++++++++
>   arch/arm/dts/dragonboard410c-uboot.dtsi |   44 -
>   arch/arm/dts/dragonboard410c.dts        |  209 +--
>   arch/arm/dts/msm8916.dtsi               | 2702 +++++++++++++++++++++++++++++++
>   configs/dragonboard410c_defconfig       |    2 +-
>   6 files changed, 3472 insertions(+), 216 deletions(-)
> 

<snip>
Same as patch 19, with the commit id:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
