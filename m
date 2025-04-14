Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B8DC369B5
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 09:13:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C68198205B;
	Mon, 14 Apr 2025 11:13:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ACY0qNsu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EFB482075; Mon, 14 Apr 2025 11:13:04 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE5E582054
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 11:13:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4394a823036so40499075e9.0
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 02:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744621981; x=1745226781; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=JBeMbwmsWE0Iu+c8BRIILAMa2/usFqrgsMaeWVpIz0s=;
 b=ACY0qNsukBmHe9TVJyEBn5IfwiqDNjF11cmK/+MFReoLmCbbTN7o7unpnRqUAKZEiL
 uDD6irTbyzw2SroiVJu57j1Fzzjzs2Vw+geIT+JUltzbaRgEpDORBxA1gk/6db8/z9ay
 8iCvVIIxnWzAKZaoOZzaz1SozojCdwHLeYHHrvR3dfyJfW8UEwdDqZKjObQzKN2KmMtC
 gj6lMty4scwJk6Mt/Fxa72fUTQsyYKTmEpO8zRl6uhmuYT91JSJFoRA1WPlRfD5Hj4yx
 Hl04cC9pwmKzhU4ibPAm3+kMbc8pumhAyqrPLp2WLYqCQgYJXRK1UQGDTZJyBYu7lq4J
 iKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744621981; x=1745226781;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=JBeMbwmsWE0Iu+c8BRIILAMa2/usFqrgsMaeWVpIz0s=;
 b=Eaz45yAyu74j0N6niAXOhJGh2dnWrNsp9oYRzJ8UGpPOc/fLi/laBHlCwXMP8C1SiR
 UxFvkuyBriI5KABTNiqYKfa+iJtwJYLvqRBUeb12pGtk7cptZhu5seEm+/1eSprdr1dP
 JizOBojpd20q4j9o4JzsOn8HktUTYaHoLKnnTQVoD25AlyyUFqLNBNG4PhEOQ7sw4UWN
 TB6e/IButkajfzYcGBmDbhDY4WLp9WpKwACzEv2MW53xBb/plx+yNJKswhrXsBRT/MGo
 b9e/R9vwGARFWkCNMYkrZF3VKtxOVwXLSTLRFKU5uFDTtnnboGNKnmo7yE9K9MeFCT8O
 Kc+w==
X-Gm-Message-State: AOJu0YxxqjRXTH8PRv0BuNEwm3bmUZBwQ7OTNmMG9s2TfyLfMZMlSGVU
 uLlL8YupgI/KCZEo7bzqot4XLqEoNKR3tZ3Yss3eMEZGm58WAg+dKnQHUB2dwUs=
X-Gm-Gg: ASbGncuBH7gRk53WnO3op3Th5v65JDQx6Hv1AssYDzSbo4QaK4/HW49O4IoaBuU/KNr
 UzkOXdR3xQcY+ItOrhXq2fQVG2FDG1O/1FK091eQHTUQxfvnaMbMPcYpcPrOaXZmKZTxl0yARyM
 o0QY8pPEhqPMIP0Mp5yAX/4yFs+KAAp6ztE8dv3bhKMhYB73KnYCCHdf2OK0S3euh15a0lOHMUU
 kk0Hf/gDakhdQlVFfqV7G7Jtqq87fSO4ri1LimcQpoyxRV2HR6o4VyG4ug+P7AY+Yt6WazZh4MB
 ysMSb1CMH/G9mGU+m/s4tzZliQRix4vq5SuQrlf0Qae4Ks0SHkKV8WuQ0L4ibHcIgQzZZbIkvNT
 u17WZh5oEALYJBqvGbw==
X-Google-Smtp-Source: AGHT+IFdNsL4gUyZ8Z0ZSptfzXQMoNMhy/fV0YUJb3YIfH4kPp9qnu/99Uho4dYbQmvTgj+CKgvKWQ==
X-Received: by 2002:a05:600c:3d86:b0:43c:f87c:24d3 with SMTP id
 5b1f17b1804b1-43f569710bdmr13614025e9.20.1744621981136; 
 Mon, 14 Apr 2025 02:13:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:bf8a:3473:5c13:9743?
 ([2a01:e0a:3d9:2080:bf8a:3473:5c13:9743])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233a273fsm168297035e9.9.2025.04.14.02.13.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Apr 2025 02:13:00 -0700 (PDT)
Message-ID: <34a1d183-406d-41e0-8c62-99940b4892ed@linaro.org>
Date: Mon, 14 Apr 2025 11:13:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFT v2 0/3] fastboot: add support for generic block
 flashing
To: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Dmitrii Merkurev <dimorinny@google.com>
References: <20250409-topic-fastboot-blk-v2-0-c676f21d414f@linaro.org>
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
In-Reply-To: <20250409-topic-fastboot-blk-v2-0-c676f21d414f@linaro.org>
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

Hi Mattijs,

On 09/04/2025 09:58, neil.armstrong@linaro.org wrote:
> This serie permits using any block device as target
> for fastboot by moving the generic block logic into
> a common set of helpers and also use them as generic
> backend.
> 
> The erase logic has been extended to support software
> erase since only 2 block drivers exposes the erase
> operation.
> 
> Tests are welcome to make sure this series doesn't
> introduce any regressions on the emmc backend.

Could you get an eye on this v2 ?

Thanks,
Neil

> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v2:
> - Dropped applied virtio erase patch
> - Reorganize patches, introducing helpers first, using them in mmc afterwards
> - Added soft-erase logic
> - Added move helpers to handle the partitions erase & flash from emmc
> - Fixed const var on last patch
> - Link to v1: https://lore.kernel.org/all/20240306185921.1854109-1-dimorinny@google.com/
> 
> ---
> Dmitrii Merkurev (3):
>        fastboot: blk: introduce fastboot block flashing support
>        fastboot: blk: switch emmc to use the block helpers
>        fastboot: integrate block flashing back-end
> 
>   drivers/fastboot/Kconfig      |  20 ++-
>   drivers/fastboot/Makefile     |   4 +-
>   drivers/fastboot/fb_block.c   | 313 ++++++++++++++++++++++++++++++++++++++++++
>   drivers/fastboot/fb_command.c |   8 ++
>   drivers/fastboot/fb_common.c  |  16 ++-
>   drivers/fastboot/fb_getvar.c  |   8 +-
>   drivers/fastboot/fb_mmc.c     | 210 ++--------------------------
>   include/fb_block.h            | 104 ++++++++++++++
>   8 files changed, 477 insertions(+), 206 deletions(-)
> ---
> base-commit: f892a7f397a66d8d09f418d1e0e06dfb48bac27d
> change-id: 20250408-topic-fastboot-blk-c5e14cd59224
> 
> Best regards,

