Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF290CE7B0C
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 09:01:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3D6286D43;
	Thu, 28 Sep 2023 11:01:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ce8n5PKJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B32086E10; Thu, 28 Sep 2023 11:01:10 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75252869CA
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 11:01:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4064867903cso23570325e9.2
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 02:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695891667; x=1696496467; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=NcYm25a/EilSoFwSGe3SbRfK+UBHFB6MWlJ2lOpQFwM=;
 b=Ce8n5PKJBa6ILyAviL6mJtbUWPXPf2vZp+NplO7fcaEe9FKljUc7Ho3wkNMdAcJSku
 +m2NrBtkSNq5hDP8aYkCTKZ2dyS+ZIrPyXSIkRXGCUGXMFoWMFn5RyIQSazKEa5/MrUp
 yHyNux3M/1K8FlejS22C74X6RnVeXCaXg5V2w3cl2q6C8VDMx7Lo29AgB6KNePPNs/K7
 IN4NwfhIEXG88kWQfs9s89jUv4Ip+fyVmO6vt0m5eLPZDywWRyZCAK249MqSiCAOjcy0
 hm9/6RhuSVXa0cG+n8KuShCXjo8wAcdhsg4s/N0QhhW94i+SUJsaZcOGzJ+xzpgYSrkO
 K5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695891667; x=1696496467;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=NcYm25a/EilSoFwSGe3SbRfK+UBHFB6MWlJ2lOpQFwM=;
 b=hXcvi8t1jtbTvy/OIxvq/KaQ80HHMghpDb8NH3uzdlaJ8kpKOy3JgUKwrf2lBklxmg
 3r9JzMDDfPtC2obdeXgPpD/yfqFjch1iaV7IBuqVEDeIHhnjXiA74PNY9MISOYkg0oT9
 Lw6HiKFcr9o3egfZ1ndhKKOEhny8+b0gVF32PRKJi6Ps2PcvQmGl5oh3K+K0deBSWdTE
 gLu6QR0+oxZocarfT3E+t3JX6X2iDPWdvC55AEN53PpyVNjVqpw1TFh5u3E4SWgkP1KJ
 +pioCWzOanlcn8ayg+zDnl6VjhzUmT6Hah2VEQS2WO+CZyha482Tdy82uipDLStaW5lO
 gaxw==
X-Gm-Message-State: AOJu0YzNwNyIvwIobR51Y/vI2cvFDX7ONEYRZfvZhilY9d7SyP56H53y
 WSLUiJCD0OUNMW1RgvWzWAB6lg==
X-Google-Smtp-Source: AGHT+IGvqc+FHMFfviD4rzP2sae3SzRwr8GVQVtd5axE5DdZeoDnSkZnnCom5WmYw/yPjih0c/fg3g==
X-Received: by 2002:a05:600c:3657:b0:404:2dbb:8943 with SMTP id
 y23-20020a05600c365700b004042dbb8943mr745404wmq.2.1695891666710; 
 Thu, 28 Sep 2023 02:01:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:17b1:9dda:a3d1:a0b6?
 ([2a01:e0a:982:cbb0:17b1:9dda:a3d1:a0b6])
 by smtp.gmail.com with ESMTPSA id
 x5-20020adfdcc5000000b0031c6581d55esm19176915wrm.91.2023.09.28.02.01.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 02:01:06 -0700 (PDT)
Message-ID: <88840967-5f39-4f21-ad0b-6b356398ec77@linaro.org>
Date: Thu, 28 Sep 2023 11:01:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 0/8] Add SM uclass and Meson SM driver
Content-Language: en-US, fr
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com,
 sjg@google.com, takahiro.akashi@linaro.org, ilias.apalodimas@linaro.org,
 post@lespocky.de, marex@denx.de, msuchanek@suse.de, sughosh.ganu@linaro.org,
 jh80.chung@samsung.com, paul.barker@sancloud.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
References: <20230921081346.22157-1-avromanov@salutedevices.com>
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
In-Reply-To: <20230921081346.22157-1-avromanov@salutedevices.com>
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

On 21/09/2023 10:13, Alexey Romanov wrote:
> Hello!
> 
> At the moment, there is no single general approach to using
> secure monitor in U-Boot, there is only the smc_call() function,
> over which everyone builds their own add-ons. This patchset
> is designed to solve this problem by adding a new uclass -
> SM_UCLASS. This UCLASS export following generic API:
> 
> 1. sm_call() - generic SMC call to the secure-monitor
> 2. sm_call_read() - retrieve data from secure-monitor
> 3. sm_call_write() - send data to secure-monitor
> 
> In the future, it is necessary to completely get rid of raw
> smc_call() calls, replacing them with the use of SM_UCLASS
> based drivers.
> 
> V2:
> 
> - Add SM UCLASS
> - Add SM sandbox driver
> - Add test for sandbox driver
> - Meson Secure Monitor driver now based on SM_UCLASS
> - Fix include order in arch/arm/mach-meson/sm.c
> 
> Also, during the discussion in V1 of this patchset, it was
> discussed to create MESON_SM_UCLASS, but I considered such
> a uclass to be too arch-specific. That's why I suggest
> SM_UCLASS, which is not so arch-specific: secure monitor can
> used for whole ARM devices, not only for Amlogic SoC's.
> 
> V3:
> 
> - Fix typos in commit messages
> - Use uclass_first_device_err() instead of uclass_get_device_by_name()
> - Return -ENOSYS instead of -EPROTONOSUPPORT if SM_UCLASS option not
> implemented
> 
> Alexey Romanov (8):
>    drivers: introduce Secure Monitor uclass
>    sandbox: add sandbox sm uclass driver
>    sandbox: dts: add meson secure monitor node
>    sandbox: add tests for UCLASS_SM
>    sandbox: defconfig: enable CONFIG_SM option
>    drivers: introduce Meson Secure Monitor driver
>    arch: meson: sm: set correct order of the includes
>    arch: meson: use secure monitor driver
> 
>   MAINTAINERS                 |   1 +
>   arch/arm/mach-meson/Kconfig |   1 +
>   arch/arm/mach-meson/sm.c    | 116 +++++++++++----------
>   arch/sandbox/dts/test.dts   |   4 +
>   configs/sandbox_defconfig   |   1 +
>   drivers/Kconfig             |   2 +
>   drivers/Makefile            |   1 +
>   drivers/sm/Kconfig          |   9 ++
>   drivers/sm/Makefile         |   5 +
>   drivers/sm/meson-sm.c       | 198 ++++++++++++++++++++++++++++++++++++
>   drivers/sm/sandbox-sm.c     |  76 ++++++++++++++
>   drivers/sm/sm-uclass.c      |  55 ++++++++++
>   include/dm/uclass-id.h      |   1 +
>   include/meson/sm.h          |  19 ++++
>   include/sandbox-sm.h        |  18 ++++
>   include/sm-uclass.h         |  72 +++++++++++++
>   include/sm.h                |  67 ++++++++++++
>   test/dm/Makefile            |   1 +
>   test/dm/sm.c                |  65 ++++++++++++
>   19 files changed, 656 insertions(+), 56 deletions(-)
>   create mode 100644 drivers/sm/Kconfig
>   create mode 100644 drivers/sm/Makefile
>   create mode 100644 drivers/sm/meson-sm.c
>   create mode 100644 drivers/sm/sandbox-sm.c
>   create mode 100644 drivers/sm/sm-uclass.c
>   create mode 100644 include/meson/sm.h
>   create mode 100644 include/sandbox-sm.h
>   create mode 100644 include/sm-uclass.h
>   create mode 100644 include/sm.h
>   create mode 100644 test/dm/sm.c
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

I'll apply it for next u-boot release,

Thanks,
Neil
