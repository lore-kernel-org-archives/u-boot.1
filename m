Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6425CEACD5
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 14:43:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5069A891FE;
	Tue,  1 Oct 2024 16:43:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="repu1GH9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26E94891FE; Tue,  1 Oct 2024 16:43:07 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1140588D1C
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 16:43:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-37ce9644daaso1653683f8f.3
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 07:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727793783; x=1728398583; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=JDwyQtU+hUDnhHvQbMDLAbTxtQniTGBWI6mtWhDKI4s=;
 b=repu1GH9fyxtQdNQ24esTGBrj7o+biRjCZSR4yNx7TotIAVPGwY5WQgGk65JIvzP6t
 w7hRtyvegPKvGpaqFf7Nu2sFgujr9YDl3mJ4TuQX7miC8r8F9E/UwiaKRP14qMAjtz2L
 S8if8zmseltbD6LGcM3TwZ/DL7PvlJri3KN+8emyyGv5l/wRWE8QSsChUr4xdYNr+x6+
 Xm8mDxGnDK7NJpqlmXvk8LkWAWRqMAKQyaEEpV3wuziEcKI8ppXYEUV9dkPBNq1GcZsg
 HTG4gcEBOtt1w/UxXxOszjgGuss2Wa/eTY/6DCR3UQki8AV7onJaWuWEbC24cm9Axvgk
 hKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727793783; x=1728398583;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=JDwyQtU+hUDnhHvQbMDLAbTxtQniTGBWI6mtWhDKI4s=;
 b=MkwF6YSG3nuV+8RKrmmy//Fv0IxP1kxWBy4sFoaSAQ98sCoWaBPTYzC7LIiUlBY2j9
 BTcshOz/WXlVlD594qvdnmlZb7oCFSYoVqoNEWFgbodP+Tq1FYhbJosV8l6/nhqoOjUV
 sWAMK0YkLOTfyqR7DK/pJ9PC05NTGgDO5aRxnkdPFYhgeTV8yox3I2gy4fCaQv5AMSLR
 lS0d0jmgHm/kaShp7OkT2lH66A0qpw2TobC4pqLUpEkDr4ep1z/XiHB2UjtfuMTE8CZe
 GAuGSVYRL7p1R4S4dSk8ZpHkpxGoS0/2vgYmorLOgpRS6s8rLg+XB2QcwNT381Kvzicx
 svcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGrpt4+s2tA8K98dBj1E+vQ2w6pg+CH0rgIxoU9XlUCZCyVSwyBacpc/KauOwp5UJ/p9MA9nI=@lists.denx.de
X-Gm-Message-State: AOJu0YzdImLGc+Whu9YvOJdD8+Uqqjh4OkdQWUZjcyc7TkYMJNUz9rRI
 w6Yz4u0uA6zZUCxmth6Kz0WeULiBysJXKhiH+ejzAhHd6UVr/HGDJoDjFy1DrcI=
X-Google-Smtp-Source: AGHT+IEh4hQhIV275Pysy1P7zje3FxSvG9karfD2zgBC6AGssuSCNUy+CwE8BVU3Pc//8QSaLEip5A==
X-Received: by 2002:a05:6000:4d2:b0:378:a935:482 with SMTP id
 ffacd0b85a97d-37cd5b0dca9mr7755781f8f.58.1727793783423; 
 Tue, 01 Oct 2024 07:43:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f9b2:9800:19f8:2888?
 ([2a01:e0a:982:cbb0:f9b2:9800:19f8:2888])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f57dec11bsm136940895e9.23.2024.10.01.07.43.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2024 07:43:02 -0700 (PDT)
Message-ID: <1b12b2ba-9f4a-4535-8ab3-134975fd3a25@linaro.org>
Date: Tue, 1 Oct 2024 16:43:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 0/3] dwc3: gadget: properly fix cache operations
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20240724-u-boot-dwc3-gadget-dcache-fixup-v2-0-65836d699a71@linaro.org>
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
In-Reply-To: <20240724-u-boot-dwc3-gadget-dcache-fixup-v2-0-65836d699a71@linaro.org>
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

Hi,

On 24/07/2024 17:48, Neil Armstrong wrote:
> We experience huge problems with cache handling on Qualcomm
> systems, and it appears the dcache handling in the DWC3 gadget
> code is quite wrong and causes operational issues.
> 
> This serie fixes the dcache operations on unaligned data,
> and properly invalidate buffers when reading back data from
> hardware.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v2:
> - Fix typo in drivers/usb/dwc3/core.h and rewrite patch 1 commit message
> - Link to v1: https://lore.kernel.org/r/20240719-u-boot-dwc3-gadget-dcache-fixup-v1-0-58a5f026ea8e@linaro.org
> 
> ---
> Neil Armstrong (3):
>        usb: dwc3: allocate setup_buf with dma_alloc_coherent()
>        usb: dwc3: fix dcache flush range calculation
>        usb: dwc3: invalidate dcache on buffer used in interrupt handling
> 
>   drivers/usb/dwc3/core.h   |  2 ++
>   drivers/usb/dwc3/ep0.c    |  6 ++++--
>   drivers/usb/dwc3/gadget.c | 10 ++++++----
>   drivers/usb/dwc3/io.h     | 13 ++++++++++++-
>   4 files changed, 24 insertions(+), 7 deletions(-)
> ---
> base-commit: 3f772959501c99fbe5aa0b22a36efe3478d1ae1c
> change-id: 20240719-u-boot-dwc3-gadget-dcache-fixup-ea1e92758663
> 
> Best regards,

Gentle ping, those fixes are quite important to make USB Gadget reliable
on Qualcomm platforms,

Thanks,
Neil
