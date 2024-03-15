Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33DBCC54E67
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 17:02:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40F028801F;
	Fri, 15 Mar 2024 18:02:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kLalDsWd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCBFC87CB7; Fri, 15 Mar 2024 18:02:11 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60D1687FBF
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 18:02:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33ec8f13c62so1400059f8f.0
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 10:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710522120; x=1711126920; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=c3d5qWjUsAW9TzOWNf5ZOW8pOoZgMH+/Qb4sItDRNJo=;
 b=kLalDsWd1ajtYUM8Mw4eWe6FH8Y6G2HIQ7Ug4X8zFvdi/If+x1qFfaIET5VjboANhr
 ucrBT1c4M2VFaCBRKSALbRr2SU2wo2iDHiBlfdAVFBI4m9UBYSx+KkyYrCCfmnoq7ITM
 VoRJXfxDLvwuT/bNg1TMJoSZvnaFVhKQ9HVoTHa1S5J98R3lg0tcUk3CWSmzgsIlyDIt
 K+MeSxe7QrqgtH5qYPo1rbE9GH9Yw3u3s3qRFoNJm3NwGp4rKbgDkBs3B0vI2Nr1bCnN
 9Jt8T+f+v7LTrxBBNBg0EiFDId8GJh7VNFzCZkBBtZCXwD6kd59sKieUS2rb/l0bi0c8
 IGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710522120; x=1711126920;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=c3d5qWjUsAW9TzOWNf5ZOW8pOoZgMH+/Qb4sItDRNJo=;
 b=sQrBnBM8MasgkPP6/CdjP2O7XQmVhMVMF4QyJG0pthB457o0LV0NlwNo9udnQwx3yf
 9JehtpCQxHop+mJlCU6vdfCl3kpZXBDZrEKqUJiUvn1t3t/uMPYFGVtMFarFkR83hHdH
 1lqnU/kPcn8te5jYI7OP/ez3ZUw4AbVxAF6QXEnsjL2arUkviSitDUGkNt/GGJWUjGz9
 pgHa49469QrBU+gVlJIHyJU0TQZVAkGLFhCQC8QCfQpd7/tq73t0PBxORMVbUKskp6B9
 e7O1cm4ZGyhiVHI+avX9Qs+P+M7yPnolFYsTKOejJqf99QpNljW82bnX7fhq+Umm2FxP
 RlQA==
X-Gm-Message-State: AOJu0YxjqGPir27Kw7GdIH7YuYkgUaCRl5DqOy9yTmr+XEY/ML6z+Ro8
 01ivSzZX8db2NaVkj/ff7gqjnnQ1DV9JxUwF68JLS5f5hCwwywduldnDSkDla+g=
X-Google-Smtp-Source: AGHT+IG/zYMLIqfawNALBF5t8aXBQTCUzM0Em0ooSkb5OdIM6RQONayzHPm73UaZI8YMj2lXuYdZzQ==
X-Received: by 2002:a05:6000:bc7:b0:33e:c6a1:1a39 with SMTP id
 dm7-20020a0560000bc700b0033ec6a11a39mr2817847wrb.65.1710522120085; 
 Fri, 15 Mar 2024 10:02:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a633:992a:92cc:9c3?
 ([2a01:e0a:982:cbb0:a633:992a:92cc:9c3])
 by smtp.gmail.com with ESMTPSA id
 t7-20020a05600001c700b0033e239040d8sm3589283wrx.84.2024.03.15.10.01.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Mar 2024 10:01:59 -0700 (PDT)
Message-ID: <85294877-07f9-47b8-aa0d-b6902bc5e063@linaro.org>
Date: Fri, 15 Mar 2024 18:01:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 0/5] Qualcomm DWC3 USB support
Content-Language: en-US, fr
To: Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
References: <20240315-b4-qcom-usb-v2-0-5467ec27cb26@linaro.org>
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
In-Reply-To: <20240315-b4-qcom-usb-v2-0-5467ec27cb26@linaro.org>
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

On 15/03/2024 16:05, Caleb Connolly wrote:
> This series enables support for Qualcomm platforms in the DWC3 driver,
> adds support for arbitrary sector sizes to the USB mass storage gadget,
> and fixes an issue with the CDC ACM driver where it wouldn't initialise
> the USB device.
> 
> Additionally, it fixes a syntax bug in the Qualcomm SMMU driver, and
> makes USB_DWC3_GADGET select DM_USB_GADGET to fix compilation with
> gadget mode.
> 
> This is part of a larger series enabling DWC3 USB support on Qualcomm
> platforms, a feature branch with all patches can be found at [1].
> 
> [1]: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/tree/b4/qcom-livetree
> 
> ---
> Changes in v2:
> - Drop custom set/clrbits implementation in qcom dwc3 glue.
> - Additional minor cleanup based on Marek's comments.
> - Link to v1: https://lore.kernel.org/r/20240131-b4-qcom-usb-v1-0-6438b2a2285e@linaro.org
> 
> ---
> Caleb Connolly (5):
>        usb: dwc3-generic: implement Qualcomm wrapper
>        usb: dwc3: select DM_USB_GADGET
>        usb: gadget: CDC ACM: call usb_gadget_initialize
>        usb: gadget: UMS: support multiple sector sizes
>        iommu: qcom-smmu: fix debugging
> 
>   cmd/usb_mass_storage.c              |   4 --
>   drivers/iommu/qcom-hyp-smmu.c       |   2 +-
>   drivers/usb/dwc3/Kconfig            |   1 +
>   drivers/usb/dwc3/dwc3-generic.c     |  81 ++++++++++++++++++++++++++++-
>   drivers/usb/gadget/f_acm.c          |   9 ++++
>   drivers/usb/gadget/f_mass_storage.c | 101 ++++++++++++++++++++----------------
>   drivers/usb/gadget/storage_common.c |  12 +++--
>   include/usb_mass_storage.h          |   1 -
>   8 files changed, 156 insertions(+), 55 deletions(-)
> ---
> base-commit: e03a71b2cefd86ba58df166d4ea820a215ebb655
> 
> // Caleb (they/them)
> 

LGTM

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
