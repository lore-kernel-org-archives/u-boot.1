Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7BFC5320E
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 11:44:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ED9488993;
	Mon, 19 Aug 2024 13:44:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tuS2BcDQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C452188A21; Mon, 19 Aug 2024 13:44:24 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9D0B87DDF
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 13:44:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42817f1eb1fso33644595e9.1
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 04:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724067862; x=1724672662; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=nyu6JtrtwE4hC4h9HdV5FVRsMY6pT9OsY6xLxlHKk1A=;
 b=tuS2BcDQlgOH0yuAKDUxko3tX1jD8WH0c5U9e/GBiF5bxU4Y411jEFJPxt8DhMe1rs
 nIz0getaG9taqgSaRfwbGlif4NH/vQ2ptcgEYsesJb4GsRRGBadX3VjW2aLcomFAiuDu
 A/e73l/G5z2k573kaJvdrlqewt3b99W2U1UT3IGzRLDKwHk3bJpjkQMfaoRx+XAjZtGm
 d0zoVG90zVuJa8UPtihN/IOlr4qFDCJ12TjtdaTihCJzuQqDepZflsTqNXq0Zv9gBDsT
 JAtC9V23T3QNy8v3TVAzj3uWbkVSieX7v0Ht5BX9y3bKDQ6QHVGKRu8QQ1MbDZEQuxNg
 oLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724067862; x=1724672662;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nyu6JtrtwE4hC4h9HdV5FVRsMY6pT9OsY6xLxlHKk1A=;
 b=TdSO442DYmNwgmW00i4VKdTNKVx0XJ+zIAVkL5B/8hopRVJc+YyGgGfl83blKKD7NV
 A4OkKOo9rt73+1bG/r2fZqg9hwL7f0ll3Vz07Br2lAbjGv0ERwC8LwEMCsq+XNjQ/55P
 8s/XHKZSr++yUPV5q2Sz8ouX9074HrhvbjBmCV6lqgEtRO2YqKC6K5qYJLA5GhrVo2qR
 /NtC0QoV/Tmwwl030DpOyVgLoQYTY7DIJR9jvdOG/+V3zZXxEBUkRG+ag2l7Wken794P
 xuOW0L3+ZH9zQdBPJDEbbXaUR2QeukygUs+Xb+vH36tzpLfZ7tSuRmNhHGZzEcAdBJaT
 x0FA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXClc2BTLgNbMIlT1Us3NSz+KnxPhs6BNDALK3kEOYza7+FJX7791WeN47d62uzOn07HuT5oQEvquO5nd2fuF29WPGJA==
X-Gm-Message-State: AOJu0YwnC4lrXADmGSGRqKJPS7EG7qaD0ZltCNnapPyKL1l3AGUcR/Si
 QKm+4Px87UhNWeV91ljVHaBb1bTzpsAeKDT2O+7UCk3Th/Azz3oRz8LkV/auwZg=
X-Google-Smtp-Source: AGHT+IHXzCw3TiO5y35YXGuv8c9Cv3xEB5NWH8bThVsm7fmrvRynTeWp8Il6+kJYgM77kb6e+wcm+Q==
X-Received: by 2002:adf:ee0d:0:b0:371:8c61:577c with SMTP id
 ffacd0b85a97d-3719464ffdcmr8261985f8f.26.1724067861566; 
 Mon, 19 Aug 2024 04:44:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f54e:4b0a:5175:5727?
 ([2a01:e0a:982:cbb0:f54e:4b0a:5175:5727])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37189896c3asm10442434f8f.71.2024.08.19.04.44.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2024 04:44:21 -0700 (PDT)
Message-ID: <1e8aa539-da79-48f8-ace7-d7706790c2ec@linaro.org>
Date: Mon, 19 Aug 2024 13:44:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 00/11] mach-snapdragon: various improvements for newer
 boards
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20240809-b4-snapdragon-improvements-v1-0-7c353f3e8f74@linaro.org>
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
In-Reply-To: <20240809-b4-snapdragon-improvements-v1-0-7c353f3e8f74@linaro.org>
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

On 09/08/2024 01:59, Caleb Connolly wrote:
> Supporting the newer SM8550 and SM8650 SoCs unfortunately requires a
> bump in complexity for us. Qualcomm changed a lot about how the memory
> map is handed over to the "kernel", adding many holes, not mapping
> certain regions, and adding regions with 0 size. The SM8650 HDK has a
> whopping 14 memory regions, some as small as 44k.
> 
> Supporting this properly has proven to be a bit of a headache, but I
> think this implementation is "pretty good".
> 
> In addition, we set a valid fallback fdt_addr_r in the U-Boot
> environment, allocate a buffer for fastboot, and set the loadaddr
> variable too.
> 
> board_fdt_blob_setup() is refactored for readability and potential
> future expansion (e.g. if supporting multi-dtb FIT becomes desirable).
> 
> Finally, a function is proposed to allow for mapping new memory regions
> at runtime, and the cmd-db driver makes use of it to map itself, since
> SM8650 boards don't seem to include it in their memory map.
> 
> Tested on SM8650 HDK, SDM845 OnePlus 6, SM6115 RB2, SM8250 RB5.
> 
> ---
> Caleb Connolly (10):
>        mach-snapdragon: refactor board_fdt_blob_setup()
>        mach-snapdragon: parse memory ourselves
>        mach-snapdragon: set serial number
>        mach-snapdragon: allocate fastboot buffer dynamically
>        mach-snapdragon: populate fallback FDT
>        mach-snapdragon: set loadaddr
>        armv8: mmu: add a way to map additional regions
>        soc: qcom: cmd-db: use strncmp() instead of memcmp()
>        soc: qcom: cmd-db: map cmd-db region
>        qcom_defconfig: bump CONFIG_NR_DRAM_BANKS
> 
> Neil Armstrong (1):
>        mach-snapdragon: use 1MiB for get_page_table_size()
> 
>   arch/arm/cpu/armv8/cache_v8.c    |  25 +++++
>   arch/arm/include/asm/system.h    |  10 ++
>   arch/arm/mach-snapdragon/board.c | 203 ++++++++++++++++++++++++++++++++++-----
>   configs/qcom_defconfig           |   1 +
>   drivers/soc/qcom/cmd-db.c        |  11 ++-
>   5 files changed, 221 insertions(+), 29 deletions(-)
> ---
> change-id: 20240809-b4-snapdragon-improvements-fd6d714a7fbd
> base-commit: a2ce853383b18a2cf920268ee341f2585a11adef
> 
> // Caleb (they/them)
> 

Thanks for posting those :-)

Please add my:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

I'll rebase my tree and test it ASAP !

Neil
