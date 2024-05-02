Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76007C25B10
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 07:39:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C01DE88C82;
	Thu,  2 May 2024 09:39:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tLDVTYU7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 853E288C71; Thu,  2 May 2024 09:39:23 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8019988CF6
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 09:39:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41b782405bbso45494285e9.1
 for <u-boot@lists.denx.de>; Thu, 02 May 2024 00:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714635561; x=1715240361; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=7JTQNjccdYBM6/7Ss23ts6kd28ppsd2kA60yw50qhSA=;
 b=tLDVTYU7+5nF3aKxq6zOklalMI5K0b5fNRu1VugzyhUIAVzo6aHUbTJ8l44tYDdZq9
 3swqqDiPD2+02eWLAYPENN1zrNDXpOuk8xtMT1FEUw3SjO9KRbOBBGR+j3bAxukXl9gI
 BsuhmTqs+SO69dNTEbe7WlfilbCuWa4Wv0aqTcOHUz6Qb8uwl1PCizkiFTqRcLNS0bCf
 1N6OsFY9XnhWhuNjay21inSelziVd7OFIwIgmhI7/5Pl3vktKK+lTk2RRMMpB2C8hU5O
 XxZzbQLKSskqWiokRKfmt9kRouAawsKeqNS2tlBfkjKI6M1nij7qavsw4NFNMM9EpTQt
 PSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714635561; x=1715240361;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7JTQNjccdYBM6/7Ss23ts6kd28ppsd2kA60yw50qhSA=;
 b=mhSJE/d4ymFzr/iREvTFHD5Dq5IILu+kNrIeQJt7Z9fLh3pbH/POMB3IOB69mcWSHl
 ZMEVbzMWVPETEzyjPmMsh75BfKgUrra/JSj/2bokQ9YZwbmvusNMLsFQU01krN1bS1is
 oDTpdtTi/yGYSJt99Pmpar4t7h7HZDam2AMvP3QIPGvKdRdvV9zF4Phu09OEKDPzvgIk
 LTjplQHIWg3KTsMI3qBNGxltmuexJnb0FM/Uk+KbS3zGEhGPdKWmTY57f8O+LzTZ+PV6
 QsRpG4MVSBQkysqVR6fG+B2LUs2C/RnIS925A1GxdVfz0iyPjPCA69li6YA0CWfeOROo
 SRhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGWRAokwW+dc7lfRfSTpx/d9YFi4sZcJZr4UZnpoxMfugW+8juzAj7QDbz3cm3FWDUCpi/SufLJ91cIfSmocKnR+N0Yg==
X-Gm-Message-State: AOJu0YyYmsdet5a5YCHPGazstyvkNQTnYx3YzDZLH6h5YZrjRN/C96eV
 bJKi5FlZn0vc8bZO2snKWwQGJ8yEumFC9oGapJrpv1Xb8nSk0GbKn0dZa/pHZTI=
X-Google-Smtp-Source: AGHT+IG8Iah7UVjLqp3wTURaAugeCujtgoJq8RA1OFQPO0+g4vnMKi8J8UmMXivBkRZgUqNQxr6AwQ==
X-Received: by 2002:a05:600c:4fce:b0:41c:2313:da92 with SMTP id
 o14-20020a05600c4fce00b0041c2313da92mr952735wmq.4.1714635560829; 
 Thu, 02 May 2024 00:39:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:67e2:5e2:652b:4129?
 ([2a01:e0a:cad:2140:67e2:5e2:652b:4129])
 by smtp.gmail.com with ESMTPSA id
 c7-20020adfe707000000b0034d24477662sm562942wrm.8.2024.05.02.00.39.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 00:39:20 -0700 (PDT)
Message-ID: <cf027072-72af-41fa-9ecc-5f3c21b69519@linaro.org>
Date: Thu, 2 May 2024 09:39:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 19/33] arm: meson: Remove <common.h> and add needed
 includes
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: u-boot-amlogic@groups.io
References: <20240430133559.1836389-1-trini@konsulko.com>
 <20240430133559.1836389-19-trini@konsulko.com>
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
In-Reply-To: <20240430133559.1836389-19-trini@konsulko.com>
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

On 30/04/2024 15:35, Tom Rini wrote:
> Remove <common.h> from all mach-meson files and when needed add missing
> include files directly.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: u-boot-amlogic@groups.io
> ---
>   arch/arm/mach-meson/board-a1.c     | 2 +-
>   arch/arm/mach-meson/board-axg.c    | 1 -
>   arch/arm/mach-meson/board-common.c | 1 -
>   arch/arm/mach-meson/board-g12a.c   | 1 -
>   arch/arm/mach-meson/board-gx.c     | 1 -
>   arch/arm/mach-meson/board-info.c   | 1 -
>   arch/arm/mach-meson/sm.c           | 1 -
>   7 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-meson/board-a1.c b/arch/arm/mach-meson/board-a1.c
> index 967bb671822e..f848c0f068ed 100644
> --- a/arch/arm/mach-meson/board-a1.c
> +++ b/arch/arm/mach-meson/board-a1.c
> @@ -3,12 +3,12 @@
>    * (C) Copyright 2023 SberDevices, Inc.
>    */
>   
> -#include <common.h>
>   #include <asm/arch/a1.h>
>   #include <asm/arch/boot.h>
>   #include <asm/armv8/mmu.h>
>   #include <asm/io.h>
>   #include <linux/compiler.h>
> +#include <linux/errno.h>
>   #include <linux/sizes.h>
>   
>   phys_size_t get_effective_memsize(void)
> diff --git a/arch/arm/mach-meson/board-axg.c b/arch/arm/mach-meson/board-axg.c
> index fdf18752cdd0..6535539184cc 100644
> --- a/arch/arm/mach-meson/board-axg.c
> +++ b/arch/arm/mach-meson/board-axg.c
> @@ -4,7 +4,6 @@
>    * (C) Copyright 2018 Neil Armstrong <narmstrong@baylibre.com>
>    */
>   
> -#include <common.h>
>   #include <init.h>
>   #include <net.h>
>   #include <asm/arch/boot.h>
> diff --git a/arch/arm/mach-meson/board-common.c b/arch/arm/mach-meson/board-common.c
> index 7ceba7cede85..39774c43049a 100644
> --- a/arch/arm/mach-meson/board-common.c
> +++ b/arch/arm/mach-meson/board-common.c
> @@ -3,7 +3,6 @@
>    * (C) Copyright 2016 Beniamino Galvani <b.galvani@gmail.com>
>    */
>   
> -#include <common.h>
>   #include <cpu_func.h>
>   #include <fastboot.h>
>   #include <init.h>
> diff --git a/arch/arm/mach-meson/board-g12a.c b/arch/arm/mach-meson/board-g12a.c
> index d5a830fb1db8..dc4abe1e1074 100644
> --- a/arch/arm/mach-meson/board-g12a.c
> +++ b/arch/arm/mach-meson/board-g12a.c
> @@ -4,7 +4,6 @@
>    * (C) Copyright 2018 Neil Armstrong <narmstrong@baylibre.com>
>    */
>   
> -#include <common.h>
>   #include <init.h>
>   #include <log.h>
>   #include <net.h>
> diff --git a/arch/arm/mach-meson/board-gx.c b/arch/arm/mach-meson/board-gx.c
> index c3fbdfffeae8..0370ed57e205 100644
> --- a/arch/arm/mach-meson/board-gx.c
> +++ b/arch/arm/mach-meson/board-gx.c
> @@ -4,7 +4,6 @@
>    * (C) Copyright 2018 Neil Armstrong <narmstrong@baylibre.com>
>    */
>   
> -#include <common.h>
>   #include <init.h>
>   #include <net.h>
>   #include <asm/arch/boot.h>
> diff --git a/arch/arm/mach-meson/board-info.c b/arch/arm/mach-meson/board-info.c
> index d51d9b8f0645..b4058f593234 100644
> --- a/arch/arm/mach-meson/board-info.c
> +++ b/arch/arm/mach-meson/board-info.c
> @@ -4,7 +4,6 @@
>    * (C) Copyright 2019 Neil Armstrong <narmstrong@baylibre.com>
>    */
>   
> -#include <common.h>
>   #include <init.h>
>   #include <asm/global_data.h>
>   #include <asm/io.h>
> diff --git a/arch/arm/mach-meson/sm.c b/arch/arm/mach-meson/sm.c
> index 914fd11c9894..4d9f83d3b38d 100644
> --- a/arch/arm/mach-meson/sm.c
> +++ b/arch/arm/mach-meson/sm.c
> @@ -5,7 +5,6 @@
>    * Secure monitor calls.
>    */
>   
> -#include <common.h>
>   #include <dm.h>
>   #include <log.h>
>   #include <regmap.h>

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
