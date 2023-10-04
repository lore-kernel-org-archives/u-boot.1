Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E79E7C4DA
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 16:03:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A87A86EE4;
	Wed,  4 Oct 2023 18:03:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d+Vs91+4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57CA5874FA; Wed,  4 Oct 2023 18:03:32 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF93586ED9
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 18:03:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3231d6504e1so13401f8f.2
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 09:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696435405; x=1697040205; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=OPvjO8lYvdOLsOicndz0QDkBhUs1H4o8/7ctqlMJDgc=;
 b=d+Vs91+4PN/WjGjJvpunMi3YAp+K3EYrU0bTIyT5fZXNDOQBATePxWVqLQ6JrT+3v1
 YFvPi4nikQJa/TTfRqx8CN2GBj0Cbdi4U7gsbBHmTRZa6SPJfJgs359RJp5Bw7h7thkW
 OxZnX79k4XAsm+c7tWpMzQYJkPazO+rvo1dqbylNI+sfyuQHtwvBL0fuyvvB82yjoKgD
 TISBCctWAtaSpfeXGwgCSsS9nXB7T5z+ndALNMZoqcM0TEH2w3joYOL9lp2i5QCF+/dO
 gMXC2If6kp2ZLyTLEP6XFVc1qQPsZ90eEbzqyopn+sYF8Ms5WdOVgqVyMMbT6rPUC2Ap
 WBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696435405; x=1697040205;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OPvjO8lYvdOLsOicndz0QDkBhUs1H4o8/7ctqlMJDgc=;
 b=ZY6LY2h3mSe8eDSbmYrhBuJB6QcqxmSTqSZWlML2TpAnxBzNmXiUPuDEk+LJJmpUVD
 Z7ilQkuaCRH18UG73wdFUqng3VXMr/i6R1DlYTW/43Ta2yeSJ+BeIVUbMtSL0gAEMjPZ
 WUHpsVQpcvLNAe/U1WwflNw5hrQ8UDQLbz7meP3hkLmyHYZ70X880l7SpJx0IEw4B9qA
 FQAGiQtfnH2YRzrdId7Hp6nZyShD9tmFFvyskcWzWaYlHIZoOV4M6RwnM2T7MXWe1ZSV
 F9ZjIPpCrUmZTIVZcFe6jSw3vh4TxoxDcxyT5dguqN7PQ1f/wv3im5gJsJV9qlpgAmkq
 Dd3w==
X-Gm-Message-State: AOJu0Yyv/sMttXPOJOtcL1kMcX9didtqZNbBNjw3dmiR1mtfFxL37NAP
 WvH8GX6Hkcxm1aPd52gbOVrxng==
X-Google-Smtp-Source: AGHT+IHlnN6OAR2AtFHZSXd+aUtqD0EMfqrIbUJAlF0p38RGanXiIBpJqlDYz8U9z/wURCr3vYm9vQ==
X-Received: by 2002:adf:e391:0:b0:31f:eed7:2fd9 with SMTP id
 e17-20020adfe391000000b0031feed72fd9mr2617845wrm.57.1696435404829; 
 Wed, 04 Oct 2023 09:03:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5bcc:9741:3ed2:97f5?
 ([2a01:e0a:982:cbb0:5bcc:9741:3ed2:97f5])
 by smtp.gmail.com with ESMTPSA id
 v17-20020a5d4a51000000b00323287186b2sm4341478wrs.29.2023.10.04.09.03.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 09:03:24 -0700 (PDT)
Message-ID: <d45fa973-3ea1-4d97-a285-f7f85e67e614@linaro.org>
Date: Wed, 4 Oct 2023 18:03:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 0/8] Support USB for Meson A1
Content-Language: en-US, fr
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com,
 sjg@google.com, lukma@denx.de, seanga2@gmail.com, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
References: <20231003112838.41503-1-avromanov@salutedevices.com>
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
In-Reply-To: <20231003112838.41503-1-avromanov@salutedevices.com>
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

On 03/10/2023 13:28, Alexey Romanov wrote:
> Hello!
> 
> This patchset adds USB stack support for Amlogic A1 SoC's
> series. Made reset / phy / dwc3 drivers more flexible and
> added support for A1 board.
> 
> V2:
> 
> - Made power domain for PHY optional.
> - Add missing CLKID_USB_PHY gate.
> - Drop patch with USB stack initialization in board-a1.c.
> Instead of, enable CONFIG_DM_USB_GADGET for AD401 board.
> - Support A1 in g12a_child_pre_probe/post_remove functions
> in dwc3 driver.
> 
> 
> Alexey Romanov (7):
>    dt-bindings: reset: add Meson A1 reset bindings
>    reset: add support for Amlogic A1 family
>    phy: get rid of raw hex values
>    phy: move clk enable/disable in init/exit
>    phy: support Amlogic A1 family
>    dwc3: add support for Amlogic A1 family
>    ad401: enable USB stack
> 
> Igor Prusov (1):
>    a1: clk: Add missing USB_PHY_IN and USB_PHY gates
> 
>   configs/ad401_defconfig                       |   3 +
>   drivers/clk/meson/a1.c                        |   6 +
>   drivers/phy/Kconfig                           |   2 +-
>   drivers/phy/meson-g12a-usb2.c                 | 235 ++++++++++++++++--
>   drivers/reset/reset-meson.c                   |  42 +++-
>   drivers/usb/dwc3/dwc3-meson-g12a.c            |  73 +++++-
>   .../reset/amlogic,meson-a1-reset.h            |  76 ++++++
>   7 files changed, 403 insertions(+), 34 deletions(-)
>   create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-reset.h
> 

The PHY and DWC3 patches don't apply cleanly, could you rebase on top of:
https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commits/u-boot-amlogic

Thanks,
Neil
