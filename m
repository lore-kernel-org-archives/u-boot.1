Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EDFC021BC
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 19:56:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75EBC805C3;
	Mon, 24 Feb 2025 20:56:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OjChvDdc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3244D80F53; Mon, 24 Feb 2025 20:56:37 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5AC180017
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 20:56:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38f3486062eso4127769f8f.0
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 11:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740426994; x=1741031794; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=bwvUk1RWrm4erN25UD64pYDI3YDfF3MLkVkls2sIwEI=;
 b=OjChvDdczDiOX+MXhKRzq5x2zz7jaco4rh1sn38RUL4rpE8DlaoO6UMMExWtlAh5ql
 n0WGUNMLJhsLyb8Nr9kUWPrh5d+jQxPUqKrXvfPFpw0JbWRarzpX5brWbD0zOsmK9AfB
 p9fa4HeavmBZPeuwoeXRkHD+Cio54je1mvbvE/JPTos+K1hiltSur+GKsOo6Wzqg6oGB
 ZpJXVKhkckL1ZwM3EvWAdnwilywnOiUkTEYOG5hDOXnymTNbpnXFdX0y+WimVbl753MM
 +39t6y/ExOS3ffbs9hIcNkCGDynDiOTdMoXp1abyev8HQX81MI3vLf5TAvArB6ct6bg9
 NZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740426994; x=1741031794;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=bwvUk1RWrm4erN25UD64pYDI3YDfF3MLkVkls2sIwEI=;
 b=CLZ4ADVTglcbdqCwpTO5vGtfHlLgI2ILBzmdyx2PgFR4itjLjAO1mE8hxCeu4xuyhL
 lrurbNINsHmlAg0NTDzwcRnIoZJYR2PtAi7P3l11qt3BJoyMV857HyUsWX3Jp65NQYcH
 fRiHwrG0T5W2fVahF9zhdcHECJZ31HHgdF7mlWOQsSbUy/bjw0hFoUCQOmWEYg+cj4Gn
 YVjwzMi93PW43Qg34yV/nK0cPl3sN5yqfNTBfFo5cwmtyg1tcwqV5pvVTNATDG2h1hQz
 7C2SBufE1JqfmcjWMxbdBqkMRJUyeKhP2BdojcW6lepCo2DWq3G+IvLxVl4DGsuZI/8v
 v8gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZyrfCHrd6ShBrGFPOjlteOlFXrnCyEbDYYddMOORWqwL5xknH983nbicp0TOvv1thPa7N+5s=@lists.denx.de
X-Gm-Message-State: AOJu0YznhQn2VZXbDqFIGlRn+d9j1QLVpMCfvmIND1XMcx6Y8YGWuRi+
 N/jGwq5EItWuA1ub9BbTKZRKo7lz2XxiGPk1mMKJk48wWGIhHEywaeSR57uUMHg=
X-Gm-Gg: ASbGncsXHhi2MssslbOO2VoHYHSDQZRKsgggprkbAGtdWYihH54OHyETxQIcU15GJAi
 aLkCsdMpHdPrRnq5+vfpoBTfzvPFDV+pBJClxV2aFKEiSQZZmmxPWr42lmv3ZC7Jevc+zeLqsE9
 mycl9o2dEgOCeLpcLMMhN50KY9jG21GDkabYA/9VKtT+OvwCXL/kEyu7ES9PSesU/MnGThSePDm
 F/zPGVo/a+s+kfsp57wflL3snpR92lVX1FbrcNxZTTCVih58Q+Bdj2X6Lplc18G42e2kOu9BbeP
 7zjV0feGCTVZXND+r78Gk0CvhUQ+x00dS7p6D4DoU6h7qwjZBTfRJX7sRQQrp1K9vJInGZg2bv5
 4AAI=
X-Google-Smtp-Source: AGHT+IE6MFbjryKVqt6zCs+qur7im8vi2dNaPZ6wftqBwuCDCpH2IDT7TKwO0DyMxAaVrO90VAbQmQ==
X-Received: by 2002:a5d:464a:0:b0:38d:c364:d516 with SMTP id
 ffacd0b85a97d-38f6f0dccfemr10377936f8f.54.1740426994260; 
 Mon, 24 Feb 2025 11:56:34 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:825b:5392:ef70:cc0b?
 ([2a01:e0a:982:cbb0:825b:5392:ef70:cc0b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02ce60asm117880235e9.7.2025.02.24.11.56.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2025 11:56:33 -0800 (PST)
Message-ID: <b251b3a1-8bd5-4814-b3b9-64b8d23dc682@linaro.org>
Date: Mon, 24 Feb 2025 20:56:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/2] tools: mkimage: Add Amlogic Boot Image type
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>
Cc: Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20250103215904.2590769-1-jonas@kwiboo.se>
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
In-Reply-To: <20250103215904.2590769-1-jonas@kwiboo.se>
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

Jonas, f_,

On 03/01/2025 22:58, Jonas Karlman wrote:
> Add support for creating an Amlogic Boot Image that pass CHK in BL1 on
> Amlogic AArch64 SoCs.
> 
> The first patch add the new amlimage type. The second patch add a eMMC
> relocation workaround that can be used to generate a boot image that can
> be booted from both eMMC and SD-card on GXBB.
> 
> The amlimage type and the eMMC relocation workaround is loosely based on
> my prior work, aml_chksum, a small tool that can write boot image
> headers with updated offsets and checksums, see [1].
> 
> This has been tested booting a very limited U-Boot SPL on boards with
> e.g. S905, S922X, S905X3 and A311D SoCs.
> 
> [1] https://github.com/Kwiboo/u-boot/commit/6d0a17632922077a2e64b13ae1a6bdf0024b718f

Is this serie ready to be taken ? what's missing ?

Neil

> 
> Jonas Karlman (2):
>    tools: mkimage: Add Amlogic Boot Image type
>    tools: amlimage: Add support for GXBB eMMC header
> 
>   MAINTAINERS                    |   1 +
>   boot/image.c                   |   1 +
>   include/image.h                |   1 +
>   tools/Makefile                 |   1 +
>   tools/amlimage-gxbb-relocate.c |  79 +++++++++
>   tools/amlimage.c               | 283 +++++++++++++++++++++++++++++++++
>   6 files changed, 366 insertions(+)
>   create mode 100644 tools/amlimage-gxbb-relocate.c
>   create mode 100644 tools/amlimage.c
> 

