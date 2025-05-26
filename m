Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7893C5AD49
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 12:21:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40D3A82DB7;
	Mon, 26 May 2025 14:21:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nnQAu5+X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 768D282DBC; Mon, 26 May 2025 14:20:59 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23C0982DA1
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 14:20:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so20030565e9.0
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 05:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748262056; x=1748866856; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=/4hp6WuIDybGK3TnDuL0dGOnFoS2sc53rtMMDrl86lg=;
 b=nnQAu5+XSGI+ayHQQkPSFaxabg3DFKpubvEpTxuvEn82jomy/8KGgD2YZNeKyhZfz/
 lj0epYu9fBCMENDk3cx7lKhSsTPw+HV7Q/zMwU6XSDd+qjRWDG9qG1WXZ2XnGpjz+Duq
 mfEPH9OBaBQt2N8l2HqDoaPcn1s64iZwPFofqm3ktDjGTzWWrYRwC949T5I9NG7xtNRE
 XV7az9bC48V97qUeIcwqUQBKdcMJrzvKWYXTPSGz4g9rexyd/GN9XF7asggAEk03oJPH
 WSkbtag8/+A2z6ErDce+6rmg/BtM32SoMuXUi0q8/BpCL9qN/OQ6ja2EA8gWzxbQDRSl
 a+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748262056; x=1748866856;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/4hp6WuIDybGK3TnDuL0dGOnFoS2sc53rtMMDrl86lg=;
 b=Vm447k17fUkjp4NoLceBe2gvjhUEzHt2jRUPI7NSJ9bvZRUho/YdSvP6u3WgTkvm/B
 9Zf1o0cXzuDtyz4VzlXTQe1Vt7delBm554i50f4PllHC9RDi1jVXQn42QhVE77Y7ATT+
 YM9HB5Aji9Cu+uptuWf0ZBMgsIiL5yJ6MruWBP5ho97vk4c/dpOvVYqLv3ETsW4MjIAL
 deFFzJRjnUwkDoR+R3nWCirfADdWr9Ny2DhPeL/jTXuRMMcrAaUfY4psbgT2BYzLE9KA
 vxMeOZwNIScTMfNKhd5n+Dr5HIvQXippalr1ttl1JgACp24F/tS6I+j8ZCJwz7kv/eEM
 kmGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDkxl7JkZZR2M/9/2Ve7ITys3NzdJaQrag8UiFnp8xwEfJcffrZiKX84tXaUrQ8kKh2hHHfBQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxZWAxBR/c7gQASZ6xTjKqL00Oe/p1qQ+H2JsYJG5JejNZhCuiX
 it/3n3ryBSOqmEGGCIGJ6Pb3jppG4+OEDFIlUe+AmM8ymJ4FEWlZIqykdC1pIS/bRQU=
X-Gm-Gg: ASbGnctJAsw1cRloj+gscQ0nM9c+JLzj47adLLQgqVIaE7TMEgx875I4dzjp8T0Yp7X
 NmwF4eAgLCAvNjpZdc/BYbNPVCJCPysxRpCfz81MNO1aeEUk3vQqSNosCNS7VC0+pwBZCXg6zg3
 jnuwftdmes5XguJLQDEZrLqI/yrjLqaudx0hz/4rN9v2dtpm9eVIuJ8N9v4jnP7eduQbxvU21vS
 HtaC/4qkUy/jv8r0CXJjYptaFvq5jatUQ40jC4DiuRpkr0T8B2nmzmVXSaN3tIPyTyXXjbJtO5p
 7WXlzhznDXw+2DIM4mgyjtbhmyXyVY8k3ZlJzRbETPaV1I7pAmfbExQwjzSH5J8mTT3IwgYhZ5j
 dxi7H6n0sRDB1M2XOzKtH5HO306AdQzOQ4vDaDlg=
X-Google-Smtp-Source: AGHT+IFvoF3W7gDRehV7YbcOOGTl/r6QDuDAeMneHWQeWdO7q8E/TpyClFCklDZzCZPE7qZ5jevadg==
X-Received: by 2002:a05:600c:6089:b0:444:c28f:e81a with SMTP id
 5b1f17b1804b1-44c94c246b9mr77200645e9.27.1748262056455; 
 Mon, 26 May 2025 05:20:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:485c:38a6:3d01:f4a4?
 ([2a01:e0a:3d9:2080:485c:38a6:3d01:f4a4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f6f0556bsm233429655e9.12.2025.05.26.05.20.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 05:20:56 -0700 (PDT)
Message-ID: <66da4aea-c47c-48d4-a9fd-35c5b63dfb16@linaro.org>
Date: Mon, 26 May 2025 14:20:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 0/2] Add Qualcomm Watchdog Driver Support
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, sr@denx.de, casey.connolly@linaro.org,
 sumit.garg@kernel.org, sjg@chromium.org, jonas@kwiboo.se,
 jerome.forissier@linaro.org, raymond.mao@linaro.org, ravi@prevas.dk,
 hs@denx.de, arturs.artamonovs@analog.com, devarsht@ti.com,
 nathan.morrison@timesys.com, bastien.curutchet@bootlin.com,
 ian.roberts@timesys.com, festevam@gmail.com, vasileios.bimpikas@analog.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250526093153.3387410-1-balaji.selvanathan@oss.qualcomm.com>
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
In-Reply-To: <20250526093153.3387410-1-balaji.selvanathan@oss.qualcomm.com>
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

Hi,

On 26/05/2025 11:31, Balaji Selvanathan wrote:
> This patch series introduces support for the Qualcomm watchdog timer
> in U-Boot. It includes a new driver based on the upstream Linux
> implementation and integrates the driver into the
> early boot initialization sequence.

A watchdog support has already been submitted at [1]. Can you check
if some support is missing on this implementation instead ?

[1] https://lore.kernel.org/all/20250422-b4-qcom-wdt-v3-1-730d4d5a858d@paulsajna.com/

Thanks,
Neil

> 
> The first patch adds the Qualcomm watchdog driver under
> drivers/watchdog/, while the second patch updates board_f.c to
> initialize the watchdog when CONFIG_QCOM_WATCHDOG is enabled.
> This ensures that the watchdog is properly configured during
> early boot on Qualcomm-based platforms.
> 
> Balaji Selvanathan (2):
>    drivers: watchdog: Add Qualcomm Watchdog Driver Support
>    common: board_f: Enable Qualcomm watchdog initialization in board_f
> 
>   common/board_f.c            |   2 +-
>   drivers/watchdog/Kconfig    |  17 ++++
>   drivers/watchdog/Makefile   |   2 +
>   drivers/watchdog/qcom-wdt.c | 194 ++++++++++++++++++++++++++++++++++++
>   4 files changed, 214 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/watchdog/qcom-wdt.c
> 

