Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D88CE7B0E
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 09:01:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2492886E29;
	Thu, 28 Sep 2023 11:01:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MsJgEEs+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 128C186E29; Thu, 28 Sep 2023 11:01:48 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3344486E28
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 11:01:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-32003aae100so9276996f8f.0
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 02:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695891704; x=1696496504; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=uEQGpxyRNw1vaDxWidc8elGY+OEmWW8l9oS3yi9pv2o=;
 b=MsJgEEs+tp28A4RtP2lyp+gj3rX/MFIVbHXloZhBFR6ztNmiclsNzWgjM0EWzCGOtW
 Khct1jCoUcdOq1vvZPpSg7JmmG8EwgQ/Ec3zcle7tEATZ3+VxYop4il1w1rdSkvu3Ucg
 9jIGITxcKXgE1qKDrxqjQL2i2ybPCH7nC1pwbJMwO34ru61u3t+ic9fuD21csJuxk9UD
 /Wg7iNGXCt8kJ+t3d/fKrbsIcKHW2zRV0Vm/0F+rtNvANnqLskCsXIb8YPC5aB1LO4cA
 7Qst5FwEdzUljxj2oPxv87BFLRn0YX1pNzexQUwLDo7etqVcYDzmGksvYPkqRs347Sy2
 z2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695891704; x=1696496504;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=uEQGpxyRNw1vaDxWidc8elGY+OEmWW8l9oS3yi9pv2o=;
 b=Vqo4sdFxLlCqSPX3y4MpjvA0XtrRLYUgXslKj4weJQDb6ccwiz4sULeLTk4XWxBGKW
 3IBixka2vy3Nu+KFyfszSWRpWRN3XpeokmohCu+GhPA2OzAmsfxofoOHP0kP30L0MovU
 JQ5kl4UdmwZshvY7+RpHlp+g5xdOcBavSrtMNNJ/yOUSRtf6cqxlaSm1atLMiJ9yI/s1
 Hwd26bq3JS2jfbgKa8ZPkCLmuYUEWWxS5BG6m8iZKngfqMUk2z0S8TZfd2RXSkdrSPlr
 DeEZ1aSW1gSN4e04UGUsb7rt0iR1O2wEkro8l7szMaR3Yw5yenWiAnDOqQOxXwQvd8+a
 iOeg==
X-Gm-Message-State: AOJu0YzImoejPgxwlVbcLZ+0nL38NdDwrp5LgxTOjKOSG56n41gfpffT
 nfuOisAdad5FXv+jwqLQsJAuRg==
X-Google-Smtp-Source: AGHT+IEo0+XZHgWBTVrOGhPW/uGkWQEqcmK5tjyIxU6Mvdl4ASvfa1FQijRvDEbENtZ79pQYtldFRw==
X-Received: by 2002:a5d:66c6:0:b0:318:720c:bb3 with SMTP id
 k6-20020a5d66c6000000b00318720c0bb3mr637141wrw.20.1695891704672; 
 Thu, 28 Sep 2023 02:01:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:17b1:9dda:a3d1:a0b6?
 ([2a01:e0a:982:cbb0:17b1:9dda:a3d1:a0b6])
 by smtp.gmail.com with ESMTPSA id
 x5-20020adfdcc5000000b0031c6581d55esm19176915wrm.91.2023.09.28.02.01.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 02:01:44 -0700 (PDT)
Message-ID: <e7b32c24-0097-4611-a2da-f32bccb81aa8@linaro.org>
Date: Thu, 28 Sep 2023 11:01:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 0/2] clk: amlogic: a1: Add Amlogic A1 clock driver
Content-Language: en-US, fr
To: Igor Prusov <ivprusov@salutedevices.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru, u-boot-amlogic@groups.io,
 u-boot@lists.denx.de
References: <20230925155209.130671-1-ivprusov@salutedevices.com>
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
In-Reply-To: <20230925155209.130671-1-ivprusov@salutedevices.com>
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

On 25/09/2023 17:52, Igor Prusov wrote:
> This series adds dt-bindings and driver implementation for Amlogic A1
> PLL and Peripherals clock controllers.
> 
> V1: https://lore.kernel.org/all/20230917101308.1250-1-ivprusov@salutedevices.com/
> 
> V1 -> V2:
>   - Add more verbose comments for driver
> 
> Igor Prusov (2):
>    dt-bindings: clock: Add Amlogic A1 clock bindings
>    clk: Add clock driver for Amlogic A1
> 
>   arch/arm/include/asm/arch-meson/clock-a1.h    |  23 +
>   drivers/clk/meson/Kconfig                     |   8 +
>   drivers/clk/meson/Makefile                    |   1 +
>   drivers/clk/meson/a1.c                        | 723 ++++++++++++++++++
>   .../clock/amlogic,a1-peripherals-clkc.h       | 168 ++++
>   .../dt-bindings/clock/amlogic,a1-pll-clkc.h   |  25 +
>   6 files changed, 948 insertions(+)
>   create mode 100644 arch/arm/include/asm/arch-meson/clock-a1.h
>   create mode 100644 drivers/clk/meson/a1.c
>   create mode 100644 include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h
>   create mode 100644 include/dt-bindings/clock/amlogic,a1-pll-clkc.h
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

I'll apply it for next u-boot release,

Thanks,
Neil
