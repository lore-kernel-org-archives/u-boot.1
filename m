Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CC1CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 18:19:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87B3D83A2A;
	Wed,  8 Oct 2025 20:19:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eUnuM5AN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71F8583A5C; Wed,  8 Oct 2025 20:19:15 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 849858394E
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 20:19:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e3a50bc0fso1141865e9.3
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 11:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759947553; x=1760552353; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Ws9q8wramlie7UeNvTQwmXuXwGp6E3Y7QR786Mnbj6Q=;
 b=eUnuM5ANMjHFoaz7OyxQRCdubusvit8pzzBt8nTgEZA+BxD6ubcFvOreF+ltxqsgWe
 sZ//eC4qOV0LhsNimmK4CWPD/y80FDkUV1701PSBT7UxXrfv33tJgQPVE64l9SxIz98Z
 Z/uTazlgEsUSnjHKJmpEU+rrLwF5w0JtScrTsXUYbDsXZreXnwv0vgld/UaHbTqU1sjB
 w7TZLEJ36lKbG+9u0x+38qkLhrGcsweqejDfYocMfxaxQXEUm9/OrXRLfdV9D8qttf97
 D8BhmHQcdNC4SxFTakuT/+OTsBLatm7WeqOpucrj2xrLF60cbEoe0C9xaZdpY7FKcO3P
 sC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759947553; x=1760552353;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Ws9q8wramlie7UeNvTQwmXuXwGp6E3Y7QR786Mnbj6Q=;
 b=FSNSy2/j/ZrXuqZ3zV4KC/WlTgTV0GId1/U/jluN23Lo3O9bLj2cRzD1t+EfgP8FL/
 2m6D/2ZfvfomjgHZRzMDoFzKvlNCVOvIK/sznUgdSbkMtGBgevMDXJiel4KF9jC0aEmK
 YmqpCeAFRu1TYM8tDHAfrqa6DPHhYgXSN98QmG0+5rxAOVAAPrzzKZq5+8FmX4OtgTq2
 lCMYEee9c3RdwTmkcBDxUXfnq9H1gR7Uv7b8TUWof0AjtCBX2e4WTwzFBpzKBU/yr0/I
 GmaG5RFeQIJRAwaEtGyhDdAMrQGgTuj5bTBb86iah2LFwZLg4WTa/3tuLPZtoSFdbA7S
 oLFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsMnu096OJDZvzKTbFx0yOVEDWKqTJWbVJfJ0Ar5Nqsj93IqlypRalt9hmNvTL2LSXxVteqRY=@lists.denx.de
X-Gm-Message-State: AOJu0YzaoYvSv3PX/hL2YbKoC2TFrnOK1/ffxl0zCl2B7eTz62+L3j7p
 m5iZr9RXZ2s3KeNDtTeIDIgKtSHGfGsCNbPoZV/PKjU52QywGuKMga8azghB6AA3R9w=
X-Gm-Gg: ASbGncsWsgWxGZY9fo+hqqBRvLiq2J4Mxzb3Xu08DakqIW2UPhFc8dGa7ysXxrrf3iP
 EnDGwpKSSvfORCdPrFYLB0s7jrMNK4DDmkJqiGmomNm5UicroXX52827DHwq+ZQtWJEF/2B1oBA
 mFO8MwU2QGYPpeSgMVovr75D6lI1Hst4fD9LUXwS1C42lw3VxLrRLiQx4jtUS04abOA1FknF8sh
 hscJgRcPjjW1EJzX2v4qt9rEKKStIcqA2hwLZ5C+yJ/YG/gQAz5slGXtyTerfLnCdObB+p7/mUl
 beqOBQafzT9uxDBhZ4VnCw96UU8w5xcOKCmxKf+pMIjh00bbEgE/xEstFSBdbA/q78DSJ1Id5l6
 s1djqgzxwoWgKZ3WHLwGO7qp3gdcfWD0vGOK9kCKnJYHChtwDN9Cotd1YggkHghafYgj86OHaDY
 CBu0A3xh0ltanwM8By0xI=
X-Google-Smtp-Source: AGHT+IFqcsmwtH+LgMVMqdFIdWLqTSkEZCcbjVp1a0IC/AkPdREZzuyilhEgjLbW6BX/Ia2AzKBV1Q==
X-Received: by 2002:a05:600c:628d:b0:46e:396b:f5ae with SMTP id
 5b1f17b1804b1-46fa9aa471cmr46049045e9.16.1759947552670; 
 Wed, 08 Oct 2025 11:19:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:b264:afbc:dee:3d?
 ([2a01:e0a:3d9:2080:b264:afbc:dee:3d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8acc4csm30558816f8f.16.2025.10.08.11.19.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 11:19:12 -0700 (PDT)
Message-ID: <35bdb934-d923-4dba-bef6-b3acfaa62f0d@linaro.org>
Date: Wed, 8 Oct 2025 20:19:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] phy; qcom: Rework Kconfig logic around MSM8916_USB_PHY
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
References: <20251003203927.1030052-1-trini@konsulko.com>
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
In-Reply-To: <20251003203927.1030052-1-trini@konsulko.com>
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

On 10/3/25 22:39, Tom Rini wrote:
> This PHY driver is required by USB_EHCI_MSM and not useful on its own.
> Rather than have it be a prompted option, it should (and currently is)
> select'd by USB_EHCI_MSM. Remove the prompt for this option and then
> correct the dependency chain (it must select PHY).

Subject has ";" instead of ":".

Neil

> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Sumit Garg <sumit.garg@kernel.org>
> Cc: u-boot-qcom@groups.io
> ---
>   drivers/phy/qcom/Kconfig | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
> index 61e5e2fca413..0dd69f7ffd0c 100644
> --- a/drivers/phy/qcom/Kconfig
> +++ b/drivers/phy/qcom/Kconfig
> @@ -1,8 +1,8 @@
>   config MSM8916_USB_PHY
> -	bool "Qualcomm MSM8916 USB PHY support"
> -	depends on PHY
> +	bool
> +	select PHY
>   	help
> -          Support the USB PHY in msm8916
> +          Support the Qualcomm MSM8916 USB PHY
>   
>   	  This PHY is found on qualcomm dragonboard410c development board.
>   

