Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D5AEC36018
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 18:09:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDD0082F65;
	Mon,  7 Apr 2025 20:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z0DE6fAw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 948A982F65; Mon,  7 Apr 2025 20:09:55 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E62F82F08
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 20:09:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39c13fa05ebso2713232f8f.0
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 11:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744049393; x=1744654193; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=/BBr9Eqj0CgaulkWm3OcCjircStlF2tOK9Hj8wZu2ro=;
 b=Z0DE6fAwvtceLqBvJ+203Qo0D+z3NtG7gC3Xeaz+ITDiFY1lig3v3NNvCQh9EDAxB8
 MdlP5m6yioc/TA3/Sv7EMNO6BoeNFGrsx8Rga2vkarfwTcCbLm6SLCJu0aLBGfUP86fz
 PvNV0cnKpi0w6E/fpl5XW5Z1cu2i2n60Cg+sIEaDqyM8aONT1UIvQXjwrkh79YjttJGa
 kob+bquDzD2YSi8fYNf51AKbRWLU5vo6A/Yp6RW2qV3We0LjgrfOc7G0PlueEgscw1ky
 vkjAAp7P4EwTx9d4itK80BS7mBGtzRHoJ7BhFS/KThUBbEgtG411o6HlXyCXPE6BWcvh
 +J3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744049393; x=1744654193;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/BBr9Eqj0CgaulkWm3OcCjircStlF2tOK9Hj8wZu2ro=;
 b=AMzp5L3D02kFLG3qGPPzgqkK6e5rkGyMBlfLzZfamzC9bAiy8p3rp24YsPb/76OEXc
 mjomR2h1fi97RMfcwuDTty/7FYWDErCmZMAIvmJ8qVVt4VxNRI1OsQ5akrtnSBbFnWwk
 T1zIqk6E1jQhSOM7CDStasIyQ4J+cmnKSrHBcHSWRWlOOhhDbU3mI290Zof1lBFKb/3r
 xA24Wh1FqQ4QyHUgn4SmgL7vKyNXnZjMYMZUNRIgGZVr6NDmf3JVdGWWcmGDIXvX77YM
 KYSq+KgsRlkr97Fper/phvHKZxL+hl31rmDwEpnmN2bQLcktoRSYjPOo+85QwuzdTIDw
 5pjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0VaP+HyhQnlBJVrmC5Gi3fJAMo/IdA+BYrnTBPsVAaKDyyXiXY9ZJjFewoj+UzCjCw5sx2yg=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0lNagrXLYbc1BbukK3CuUELz6bMnPqbuA4dIItpsXkOUmTnlE
 V2OrWmnLD4Z95kxvcEd3r9lv+T/VKHNqnAJaJGzVJNDoh2Dd9vpwUOi2j3HVqj3fAN1DzZGJg3v
 P
X-Gm-Gg: ASbGncv6gYVHTT7iuogVqTje/gM3OxkpeVphppMA+lnpkEXn5oP7GoYy1URFL1yOlmG
 05WvSeQw8LYzcB/KAGvr2G2hdpLjhbEXNBZfymE2u8RSDXx2KuYnDzZt1WIt/IgJlG8xahkQITY
 JgTkb7mfcYUqxmnKTUbAJGz1kTM2zznUAMGhi1qfIdaobtCYhpMu4KQecCoiiPOlG/JPQDTGeha
 UzLan8QHwpLuKCCI/Mb0d6xwtAWkgaiuZybnjzk+UXkDut7+wiZGReGUHAgWYC5CWMbN7exp8fn
 SVoboJHm1xDIxqKbxDv4ue/wVTVuaY+Wue1mtmARK+WWfQj6Z2JjIigjA6xw5WgfraxrII6rrEP
 6+DDAiJiL0qVIZ3ecRg5gpA==
X-Google-Smtp-Source: AGHT+IGg67eZa7U/TiAZxOY0E5CA6Ea9IjxRfqoZKRsU7gUzTL5M+QCP16TLwur6/U888JCNWSvT+w==
X-Received: by 2002:a05:6000:4387:b0:39c:2665:2ce7 with SMTP id
 ffacd0b85a97d-39cba93d7d9mr11836130f8f.53.1744049392910; 
 Mon, 07 Apr 2025 11:09:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f2a4:b974:cba3:a605?
 ([2a01:e0a:3d9:2080:f2a4:b974:cba3:a605])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30226ea8sm12677394f8f.81.2025.04.07.11.09.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 11:09:52 -0700 (PDT)
Message-ID: <7dd418b8-91a2-461d-8b2f-680e23855479@linaro.org>
Date: Mon, 7 Apr 2025 20:09:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 10/13] board: dragonboard410c: Use BOOTSTD instead of
 DISTRO_DEFAULTS
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Sam Day <me@samcday.com>
References: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
 <20250407-db410c-fixes-v1-10-524aefbc8bb4@linaro.org>
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
In-Reply-To: <20250407-db410c-fixes-v1-10-524aefbc8bb4@linaro.org>
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

On 07/04/2025 18:59, Stephan Gerhold wrote:
> Reduce the environment size by using standard boot instead of distro boot.
> It uses faster bootdevs first by default (eMMC -> SD -> USB -> Network), so
> set "boot_targets" to keep the current ordering (USB -> SD -> eMMC ->
> Network). Perhaps this should be changed for consistency, but for now this
> keeps the behavior similar to before.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>   board/qualcomm/dragonboard410c/dragonboard410c.env |  1 +
>   configs/dragonboard410c_defconfig                  |  3 ++-
>   include/configs/dragonboard410c.h                  | 11 -----------
>   3 files changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.env b/board/qualcomm/dragonboard410c/dragonboard410c.env
> index 0032dc3592a1021e4bb422357867cc26b4b30551..71f929b646cc305cf5223cd3462fe2350bc8093e 100644
> --- a/board/qualcomm/dragonboard410c/dragonboard410c.env
> +++ b/board/qualcomm/dragonboard410c/dragonboard410c.env
> @@ -1,3 +1,4 @@
>   /* SPDX-License-Identifier: GPL-2.0+ */
>   initrd_high=0xffffffffffffffff
>   fastboot=fastboot -l $fastboot_addr_r usb 0
> +boot_targets=usb mmc1 mmc0 pxe
> diff --git a/configs/dragonboard410c_defconfig b/configs/dragonboard410c_defconfig
> index da1ec4bfc60cdf4a2a9077efb081383b5b39301a..62fc42c9460d075fd27c3e2823eb8eea2a559772 100644
> --- a/configs/dragonboard410c_defconfig
> +++ b/configs/dragonboard410c_defconfig
> @@ -16,7 +16,7 @@ CONFIG_IDENT_STRING="\nQualcomm-DragonBoard 410C"
>   CONFIG_REMAKE_ELF=y
>   # CONFIG_ANDROID_BOOT_IMAGE is not set
>   CONFIG_FIT=y
> -CONFIG_DISTRO_DEFAULTS=y
> +CONFIG_BOOTSTD_FULL=y
>   CONFIG_OF_BOARD_SETUP=y
>   CONFIG_USE_PREBOOT=y
>   CONFIG_SYS_CBSIZE=512
> @@ -35,6 +35,7 @@ CONFIG_CMD_USB=y
>   CONFIG_BOOTP_BOOTFILESIZE=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_CMD_TIMER=y
> +CONFIG_CMD_SYSBOOT=y
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_SYS_MMC_ENV_PART=2
> diff --git a/include/configs/dragonboard410c.h b/include/configs/dragonboard410c.h
> index 00102cd5c4f54236366e4b6380a9c9537f9b4614..c31c6c57c1a4bebde740bc3fe535ca9610af043e 100644
> --- a/include/configs/dragonboard410c.h
> +++ b/include/configs/dragonboard410c.h
> @@ -18,15 +18,4 @@
>   #define PHYS_SDRAM_1_SIZE		SZ_1G
>   #define CFG_SYS_SDRAM_BASE		PHYS_SDRAM_1
>   
> -/* Environment */
> -#define BOOT_TARGET_DEVICES(func) \
> -	func(USB, usb, 0) \
> -	func(MMC, mmc, 1) \
> -	func(MMC, mmc, 0) \
> -	func(DHCP, dhcp, na)
> -
> -#include <config_distro_bootcmd.h>
> -
> -#define CFG_EXTRA_ENV_SETTINGS BOOTENV
> -
>   #endif
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
