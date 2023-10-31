Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02164C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 16:03:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7AFC87619;
	Tue, 31 Oct 2023 17:03:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NJGzouPQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36599875E8; Tue, 31 Oct 2023 17:03:01 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC243875E8
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 17:02:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40836ea8cbaso44135395e9.0
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 09:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698768178; x=1699372978; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=jsXGyhyG+e8QyIxvfHR25ygMUH3FdbVvyQdXvOv+DOc=;
 b=NJGzouPQBO1ZR7PhUk/HM6i6g8yntFYCdpX4KTWrXo61r55gbAiSplwirRk8Yx0CI5
 yT+i09Ylt6KGLcsOp+sEowASzrFVlQJ88IAFIIQg+KhGNZ9XU4hOHqbWA593xgzU9XCO
 5GubNk8O5HqTEuvkpshNeAB7TuMWonz3trKpWUeN7ICBj1UaBU0gUVghMn3Zd71Dkpde
 PJqmdBL2hSD8Lt1N8mXBueNn9EhTn+PlPMJ759145ACZtPX1pbF7/OvyE1xjt9pzeIaN
 Mu2HVYN6EvowbeozfXV9KQbOIdrGZBkeBkCrfJgAE6yHZTbAT2rgcXUF28TzpVz5gsFC
 A5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698768178; x=1699372978;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jsXGyhyG+e8QyIxvfHR25ygMUH3FdbVvyQdXvOv+DOc=;
 b=Lw5Ds1xla4GkDnbo2+z5t4k55bJhCJcuhvpAl0yJ1ggfl5uvyVSd3+juCFxNZi/QkK
 H9iRArCpwdfGPxNczEm6mykneKWxW7ABCJLW5Gj0oNpoxxJKFaPeRvX0S/gOY+xX5F6j
 yZh66YH/Xw2DavaOIbZOZDMw4p7rICIYf4OXvw0g/2iwhJJRnKCCHjtaCsv4hyjumOyt
 +7HWe4Ecv+RiAeHGxlDZW7vCIZRge8Zl+AKelV8ISyNeWqijUh2iBXSmvP6AOiO1Pc/z
 RrAzhwPFz5J055PcPOVUOP2PsF95TD3dlgZ+CrMgw7HwtKHSaJ8Qv226N0+qEdG6BNhL
 1VMw==
X-Gm-Message-State: AOJu0YwEp8MB2lz8kd/qr1HMeHQbl789EhW3/9xBzXDrTwFyAll2gYWF
 T34+sWPmo/8bEx7snpHG65dpkg==
X-Google-Smtp-Source: AGHT+IGDeoLkSRm/T898QBFKl6EMlMj2sftCOyjzXHZbM42JOMBFU35nIWFeAEeelkz0DvhoWC4YOw==
X-Received: by 2002:a05:600c:1c90:b0:405:37bb:d942 with SMTP id
 k16-20020a05600c1c9000b0040537bbd942mr10841856wms.4.1698768178272; 
 Tue, 31 Oct 2023 09:02:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4d69:3958:c5b9:5f3e?
 ([2a01:e0a:982:cbb0:4d69:3958:c5b9:5f3e])
 by smtp.gmail.com with ESMTPSA id
 r19-20020a05600c159300b004077219aed5sm2099318wmf.6.2023.10.31.09.02.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 09:02:57 -0700 (PDT)
Message-ID: <3e00ae04-9bdf-4a4d-9cbb-7f3ffa1ed3ba@linaro.org>
Date: Tue, 31 Oct 2023 17:02:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: update Qualcomm maintainer
To: Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de
References: <20231031-b4-qcom-maintainer-v1-1-d905d73d8cab@linaro.org>
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
Organization: Linaro Developer Services
In-Reply-To: <20231031-b4-qcom-maintainer-v1-1-d905d73d8cab@linaro.org>
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

On 31/10/2023 16:19, Caleb Connolly wrote:
> As Ramon has been inactive for some time now, add myself and Neil
> Armstrong to maintain Qualcomm efforts going forwards.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> I greatly appreciate the work done by Ramon Fried in keeping Qualcomm
> support alive in U-Boot the last few years. However it's clear that
> he hasn't been very active for some time now.
> 
> I am currently working on a large cleanup effort to modernise Qualcomm
> support and enable several new reference platforms. To better facilitate
> this and to handle Qualcomm support going forwards, make myself maintainer
> of ARM SNAPDRAGON as well as my colleague Neil Armstrong (Amlogic
> maintainer).
> 
> I hope Ramon continues to participate in discussions and reviews going
> forward.
> ---
> base-commit: cbba1b7766bd93d74e28202c46e69095ac13760b
> 
> // Caleb (they/them)
> ---
>   MAINTAINERS | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cde778bc4d3d..be3666d14047 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -567,7 +567,8 @@ S:	Supported
>   F:	arch/arm/dts/am335x-sancloud*
>   
>   ARM SNAPDRAGON
> -M:	Ramon Fried <rfried.dev@gmail.com>
> +M:	Caleb Connolly <caleb.connolly@linaro.org>
> +M:	Neil Armstrong <neil.armstrong@linaro.org>
>   S:	Maintained
>   F:	arch/arm/mach-snapdragon/
>   F:	drivers/gpio/msm_gpio.c
> 

Obviously:
Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks Caleb, cleanup of mach-snapdragon is welcome and I'll be happy to participate!

Neil
