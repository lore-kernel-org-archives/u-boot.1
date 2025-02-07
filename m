Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A62C02196
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 09:41:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C327080737;
	Fri,  7 Feb 2025 10:41:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="r90nc6qv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F10780737; Fri,  7 Feb 2025 10:41:07 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B962B801DE
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 10:41:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-436a39e4891so12397755e9.1
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 01:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738921264; x=1739526064; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=j3nUU+29q6AgiovIVVAvNrV0zSiXjoQuGXkY5ZYoKgU=;
 b=r90nc6qvwlKrM0Sc6DqBEWuP9UsHzZADVeOaV8J1bvdsC31LMf8bqMvJoowil50n+d
 OrXe0Vq0FIHJQdJqnUYP5oIQzcFlRVCtvn3CqSceMj1loeqx/COrbBt9hG7uRw8vSm5c
 YuLfBHNZUcO4TcgACxTK23SgYGvKKQ+PmWQDHzb6Z6Lv+4Cfd4lPNq859pzuRMV5LeBQ
 sW/31LoICbK9fwDbe8XXGm77IPAmaX1O4XCUDjubA6SRcSxJFAe5+8t7XkpVQzQoGqUK
 JVgCAGjMUBqbcFQtbteK2jJtkRKvEXzMJaGMA3q/VFjxd/fNM5g63N8ZGEBLjELgXlJx
 rO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738921264; x=1739526064;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=j3nUU+29q6AgiovIVVAvNrV0zSiXjoQuGXkY5ZYoKgU=;
 b=nSF5az9xw7NBMdCSa89aBY9e/vucQF1PgM8Gyhi+dFzKhaLePDqWR0K41uJEgJ/dj0
 FFBcLSmKiljNHvDfDOYf2B4Q7iGg0XKNyyPXBt0SstFKY/bS1EM/1IPPFgJf/OAnJU3g
 6yhj8ml61OXKMzy4CRpOiw/SCKVrh1saiSmusRAq4riGN/GIOb0YYakcHzHNCRm80Jew
 Wi/A39kFQw0NGdC56/s1zzMi9HHVAFfp/koSV59B0DEOqjoObp4pBlfnvq82wAhMm4Dn
 R2KKH1zq4PeaAIfucpe4BGEMbOwMoxjn8q7Kg1RID/9H/VZ8tbCpLKOmCWjpt09JAJPW
 UFiQ==
X-Gm-Message-State: AOJu0YyRGwVpgUqhiKTW8UWd2NgRfi/1itHjpgIgihMdxAMH6FpOVwp7
 bgu42NavjM8w+oaJBcxgHSugP4+LKT+KL/JB8IdWGQhTEGK48FrOZkUMOcto0Ak=
X-Gm-Gg: ASbGncuxS/xTFxoBrHscUeQKfcG7mzN+FHnsI8MfqlhUY2udAVinrGKvnfJSuBS09zv
 rWQvLT+tRSMiB+iqk6YH5We94bug1V4ThVv4zuEi+jjnPKnJRTnukkVSHuOgO1AzrrQ5xNTwj2O
 pyiUr+/GJwPV7zonI5ib94/lay7MX1qX5sdsKKkFjV9bNDT33V2iAqCMtSWA+SR7MQaWAHINIjP
 FdZdn854bWs4OjUMonBm0B0qIZ+Yvqe0PFp+nBqnOB8E4b7CTe2fA+YV6Ao8OJ+VxF4tt/rkpfG
 QdQlSKafUfGq0fPbj2GPdAMdR+E70Yz79jpv5WEpCexNtwATCxjQcpRDneKWq+fMhRSd
X-Google-Smtp-Source: AGHT+IE2Q4SEGWeHARpLNcAPC85KNFN207jPscVy+GT1koR+Qii+IS7jSnxRIW1rz/gdQFtpGLkYtA==
X-Received: by 2002:a05:600c:3109:b0:434:f297:8e85 with SMTP id
 5b1f17b1804b1-4392498a204mr22820835e9.10.1738921264054; 
 Fri, 07 Feb 2025 01:41:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5b26:96be:712e:30cd?
 ([2a01:e0a:982:cbb0:5b26:96be:712e:30cd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390daf3c70sm83796475e9.26.2025.02.07.01.41.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2025 01:41:03 -0800 (PST)
Message-ID: <bd71eab8-93fd-429e-813b-ca9cc45d5a6b@linaro.org>
Date: Fri, 7 Feb 2025 10:41:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 2/2] board: remove capsule update support in
 set_dfu_alt_info()
To: Jonathan Humphreys <j-humphreys@ti.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Udit Kumar <u-kumar1@ti.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Santhosh Kumar K <s-k6@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Daniel Schultz
 <d.schultz@phytec.de>, Viacheslav Bocharov <adeep@lexina.in>,
 Aashvij Shenai <a-shenai@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Tom Rini <trini@konsulko.com>, Robert Nelson <robertcnelson@gmail.com>,
 Nishanth Menon <nm@ti.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Lukasz Majewski <lukma@denx.de>, s-vadapalli@ti.com
Cc: u-boot@lists.denx.de
References: <20250206154719.3032322-1-j-humphreys@ti.com>
 <20250206154719.3032322-3-j-humphreys@ti.com>
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
In-Reply-To: <20250206154719.3032322-3-j-humphreys@ti.com>
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

On 06/02/2025 16:47, Jonathan Humphreys wrote:
> Now that capsule update sets the dfu_alt_info environment variable
> explicitly, there is no need to support it in the set_dfu_alt_info()
> function. Decouple SET_DFU_ALT_INFO from EFI_CAPSULE_FIRMWARE_FIT and
> EFI_CAPSULE_FIRMWARE_RAW. For many boards, this was the only use of
> set_dfu_alt_info() so remove the function entirely.
> 
> Fixes: a9e6f01a941f ("efi: Define set_dfu_alt_info() for boards with UEFI capsule update enabled")
> 
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>   board/beagle/beagleboneai64/beagleboneai64.c       | 8 --------
>   board/beagle/beagleplay/beagleplay.c               | 8 --------
>   board/libre-computer/aml-a311d-cc/aml-a311d-cc.c   | 2 --
>   board/libre-computer/aml-s805x-ac/aml-s805x-ac.c   | 2 --
>   board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c | 2 --

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org> # for board/libre-computer/*

>   board/phytec/common/k3/board.c                     | 8 --------
>   board/ti/am62px/evm.c                              | 8 --------
>   board/ti/am62x/evm.c                               | 8 --------
>   board/ti/am64x/evm.c                               | 8 --------
>   board/ti/j721e/evm.c                               | 8 --------
>   board/ti/j784s4/evm.c                              | 8 --------
>   lib/efi_loader/Kconfig                             | 2 --
>   lib/efi_loader/efi_firmware.c                      | 5 -----
>   13 files changed, 77 deletions(-)
> 
> diff --git a/board/beagle/beagleboneai64/beagleboneai64.c b/board/beagle/beagleboneai64/beagleboneai64.c
> index e8d07f1f95f..99eb8972cf3 100644
> --- a/board/beagle/beagleboneai64/beagleboneai64.c
> +++ b/board/beagle/beagleboneai64/beagleboneai64.c
> @@ -45,14 +45,6 @@ struct efi_capsule_update_info update_info = {
>   	.images = fw_images,
>   };
>   
> -#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
> -void set_dfu_alt_info(char *interface, char *devstr)
> -{
> -	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> -		env_set("dfu_alt_info", update_info.dfu_string);
> -}
> -#endif
> -
>   int board_init(void)
>   {
>   	return 0;
> diff --git a/board/beagle/beagleplay/beagleplay.c b/board/beagle/beagleplay/beagleplay.c
> index fae69b37585..78635810585 100644
> --- a/board/beagle/beagleplay/beagleplay.c
> +++ b/board/beagle/beagleplay/beagleplay.c
> @@ -41,14 +41,6 @@ struct efi_capsule_update_info update_info = {
>   	.images = fw_images,
>   };
>   
> -#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
> -void set_dfu_alt_info(char *interface, char *devstr)
> -{
> -	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> -		env_set("dfu_alt_info", update_info.dfu_string);
> -}
> -#endif
> -
>   int board_init(void)
>   {
>   	return 0;
> diff --git a/board/libre-computer/aml-a311d-cc/aml-a311d-cc.c b/board/libre-computer/aml-a311d-cc/aml-a311d-cc.c
> index e45cfd5d8a3..24363d21ab0 100644
> --- a/board/libre-computer/aml-a311d-cc/aml-a311d-cc.c
> +++ b/board/libre-computer/aml-a311d-cc/aml-a311d-cc.c
> @@ -31,8 +31,6 @@ void set_dfu_alt_info(char *interface, char *devstr)
>   {
>   	if (strcmp(interface, "ram") == 0)
>   		env_set("dfu_alt_info", "fitimage ram 0x08080000 0x4000000");
> -	else if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> -		env_set("dfu_alt_info", update_info.dfu_string);
>   }
>   #endif
>   
> diff --git a/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c b/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
> index 94cf5b4361f..42442f26acc 100644
> --- a/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
> +++ b/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
> @@ -38,8 +38,6 @@ void set_dfu_alt_info(char *interface, char *devstr)
>   {
>   	if (strcmp(interface, "ram") == 0)
>   		env_set("dfu_alt_info", "fitimage ram 0x08080000 0x4000000");
> -	else if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> -		env_set("dfu_alt_info", update_info.dfu_string);
>   }
>   #endif
>   
> diff --git a/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c b/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c
> index f641db5a494..5223f1c8ab8 100644
> --- a/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c
> +++ b/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c
> @@ -31,8 +31,6 @@ void set_dfu_alt_info(char *interface, char *devstr)
>   {
>   	if (strcmp(interface, "ram") == 0)
>   		env_set("dfu_alt_info", "fitimage ram 0x08080000 0x4000000");
> -	else if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> -		env_set("dfu_alt_info", update_info.dfu_string);
>   }
>   #endif
>   
> diff --git a/board/phytec/common/k3/board.c b/board/phytec/common/k3/board.c
> index 9d833456810..58859f279f1 100644
> --- a/board/phytec/common/k3/board.c
> +++ b/board/phytec/common/k3/board.c
> @@ -82,14 +82,6 @@ void configure_capsule_updates(void)
>   }
>   #endif
>   
> -#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
> -void set_dfu_alt_info(char *interface, char *devstr)
> -{
> -	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> -		env_set("dfu_alt_info", update_info.dfu_string);
> -}
> -#endif
> -
>   #if IS_ENABLED(CONFIG_ENV_IS_IN_FAT) || IS_ENABLED(CONFIG_ENV_IS_IN_MMC)
>   int mmc_get_env_dev(void)
>   {
> diff --git a/board/ti/am62px/evm.c b/board/ti/am62px/evm.c
> index 75359fa1614..379d1a5b316 100644
> --- a/board/ti/am62px/evm.c
> +++ b/board/ti/am62px/evm.c
> @@ -41,14 +41,6 @@ struct efi_capsule_update_info update_info = {
>   	.images = fw_images,
>   };
>   
> -#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
> -void set_dfu_alt_info(char *interface, char *devstr)
> -{
> -	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> -		env_set("dfu_alt_info", update_info.dfu_string);
> -}
> -#endif
> -
>   int board_init(void)
>   {
>   	return 0;
> diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
> index 279ceba9554..3051a0a27a1 100644
> --- a/board/ti/am62x/evm.c
> +++ b/board/ti/am62x/evm.c
> @@ -74,14 +74,6 @@ struct efi_capsule_update_info update_info = {
>   	.images = fw_images,
>   };
>   
> -#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
> -void set_dfu_alt_info(char *interface, char *devstr)
> -{
> -	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> -		env_set("dfu_alt_info", update_info.dfu_string);
> -}
> -#endif
> -
>   int board_init(void)
>   {
>   	return 0;
> diff --git a/board/ti/am64x/evm.c b/board/ti/am64x/evm.c
> index 6a17737d266..35fd30dbceb 100644
> --- a/board/ti/am64x/evm.c
> +++ b/board/ti/am64x/evm.c
> @@ -54,14 +54,6 @@ struct efi_capsule_update_info update_info = {
>   	.images = fw_images,
>   };
>   
> -#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
> -void set_dfu_alt_info(char *interface, char *devstr)
> -{
> -	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> -		env_set("dfu_alt_info", update_info.dfu_string);
> -}
> -#endif
> -
>   int board_init(void)
>   {
>   	return 0;
> diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
> index 1fa78ff7b30..0525f6e6f97 100644
> --- a/board/ti/j721e/evm.c
> +++ b/board/ti/j721e/evm.c
> @@ -65,14 +65,6 @@ struct efi_capsule_update_info update_info = {
>   	.images = fw_images,
>   };
>   
> -#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
> -void set_dfu_alt_info(char *interface, char *devstr)
> -{
> -	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> -		env_set("dfu_alt_info", update_info.dfu_string);
> -}
> -#endif
> -
>   int board_init(void)
>   {
>   	return 0;
> diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
> index d317f3eccbb..c6e46b7ee0e 100644
> --- a/board/ti/j784s4/evm.c
> +++ b/board/ti/j784s4/evm.c
> @@ -40,14 +40,6 @@ struct efi_capsule_update_info update_info = {
>   	.images = fw_images,
>   };
>   
> -#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
> -void set_dfu_alt_info(char *interface, char *devstr)
> -{
> -	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
> -		env_set("dfu_alt_info", update_info.dfu_string);
> -}
> -#endif
> -
>   int board_init(void)
>   {
>   	return 0;
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index d4f6b56afaa..1be11aed901 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -304,7 +304,6 @@ config EFI_CAPSULE_FIRMWARE_FIT
>   	depends on EFI_CAPSULE_FIRMWARE_MANAGEMENT
>   	select UPDATE_FIT
>   	select DFU
> -	select SET_DFU_ALT_INFO
>   	select EFI_CAPSULE_FIRMWARE
>   	help
>   	  Select this option if you want to enable firmware management protocol
> @@ -316,7 +315,6 @@ config EFI_CAPSULE_FIRMWARE_RAW
>   	depends on SANDBOX || (!SANDBOX && !EFI_CAPSULE_FIRMWARE_FIT)
>   	select DFU_WRITE_ALT
>   	select DFU
> -	select SET_DFU_ALT_INFO
>   	select EFI_CAPSULE_FIRMWARE
>   	help
>   	  Select this option if you want to enable firmware management protocol
> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
> index 1a1cf3b55e1..3286c21a2b7 100644
> --- a/lib/efi_loader/efi_firmware.c
> +++ b/lib/efi_loader/efi_firmware.c
> @@ -56,11 +56,6 @@ struct fmp_state {
>   	u32 last_attempt_status; /* not used */
>   };
>   
> -__weak void set_dfu_alt_info(char *interface, char *devstr)
> -{
> -	env_set("dfu_alt_info", update_info.dfu_string);
> -}
> -
>   /**
>    * efi_firmware_get_image_type_id - get image_type_id
>    * @image_index:	image index

