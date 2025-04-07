Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDB8C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 18:10:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0C0A82F85;
	Mon,  7 Apr 2025 20:10:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wg9T4kV+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0D058303E; Mon,  7 Apr 2025 20:10:48 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD27582F08
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 20:10:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43ed8d32a95so25553315e9.3
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 11:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744049446; x=1744654246; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=XZqHPI3EL+TbF/joJGr//eWNUhjgVFvVZuux+scIBIo=;
 b=wg9T4kV+jZYkW6O8HCFUvoX1AzXgg9qGuI+5J8RzziMyKoM4lNI+gSQCNNvK2IF0NJ
 2bvYQhtGAxMuDUB3cxyDpGUtgGpeM4h8fQtmy8DjDYmjivPt4lS2ZxZBGEmDqPfeAwE6
 gzrcqVnjY1girOsgsciVWlnYNpIs974q1b6d5iaqJc7XIUNBJOMXYf0jqmovdrc4FJIJ
 TFnnp7FCYOEaZf/t4dEn1okoKPNgIm9VzSixapVv41QaSxCvI7UcPN3cWKpMIOWD25Uf
 g0Ws6xThzUDn8Zu8IoVLGazLkVV8d1Gfw9t/dVfGxNoj/uiKfexLcIriZpxUV/J8h0P7
 CFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744049446; x=1744654246;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XZqHPI3EL+TbF/joJGr//eWNUhjgVFvVZuux+scIBIo=;
 b=FL9fpAZu7OzsegdcJakPFQqBXPMb3znOJyrZgjcHP76uRF4LLFtmZtKtMekxKw+TxD
 tjjtGqSM+uOuofJAVuSgEOcdYIVM/zHqRWGcT8y6QSi2BzL0sLDVSnQkRG7vDOudnywZ
 Dt224wrsbOrEl1zVvPY4vnCpUXKzfYVT1RC0TIwkLQ8kLi5zGzscdqz5qN7paEWZsN94
 tlYrEFMrs+R1ZG5Oqb+gC66LZVxf03edq/2W+mqxeaievilG2KzxStv4OQn8aucVd3Zu
 ze15rWSV1C6y4m5X15qhzg2dsIOjm61YIbI4SeSKcLerjmjK5eREQeQYVnaDA3hGXrG+
 mnFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb7BmWcmVEz5ZBAOAACuRQ6SBcXJfL7xzFfXp0F11teOBfcFySNHoiehW22o/WIUPzx/f8gn4=@lists.denx.de
X-Gm-Message-State: AOJu0YzRNpUmWWg/JEPnmkFxxz/wbqFvo9gwA8IU+u9JkRgneFV2/Pk2
 sKaopGA7RnnoL2xTl13OoeyCmL6j58NIdUZ8280LQPDyqf9Dc1jusYRICVxRBDY=
X-Gm-Gg: ASbGncsaZfXhRZ8IxcKYpsvDmEdAQHixxTcIfsVQOthf7XKk4xviVG1aWJU8KlM69Xp
 RuGsk1qYReReobi4M2N3pB3Dls986GOZph7n2wCpZ0f9KTEZyIR/xXKqvVSX/XXDMOF1rgJo6wU
 xtMe3/WcFgaIMqR92Q1dU63D3o6FjLPbLCscSRy5YEqSeWb3bqfIVCwD/zFAnLASyCWfGB/VulW
 pQM8SEkhkjfGNHWzBz+MV1pTMTESDrgWMnEJS4xFpp7rVReFtQd2AhSGrwEE37UHWFpBNgWTuLG
 LUbCg+R9434YAdvoQr8Q6Ypz5f8qdaftxmZSIhtTdUC14ty02lwkg9PJgGJwTWqnLx5Xevk9nCL
 ZdNGIppT4h1GEA+GSFCL2XuWnUb9AKXUp
X-Google-Smtp-Source: AGHT+IHptasGgcu6etfHtt8iJnwRw2qAc4B+IaiuoXIqmu+BVV0NWpt+rzV4Wrex1oW5ySxt+7wATw==
X-Received: by 2002:a05:600c:510d:b0:43c:fe90:1279 with SMTP id
 5b1f17b1804b1-43ecf9c36f6mr94066085e9.21.1744049446176; 
 Mon, 07 Apr 2025 11:10:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f2a4:b974:cba3:a605?
 ([2a01:e0a:3d9:2080:f2a4:b974:cba3:a605])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30226f2bsm12927970f8f.96.2025.04.07.11.10.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 11:10:45 -0700 (PDT)
Message-ID: <a4dd32cd-32dc-4f21-8ff1-87584d32b96d@linaro.org>
Date: Mon, 7 Apr 2025 20:10:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 12/13] board: dragonboard410c: Use button_cmd instead of
 custom code
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Sam Day <me@samcday.com>
References: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
 <20250407-db410c-fixes-v1-12-524aefbc8bb4@linaro.org>
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
In-Reply-To: <20250407-db410c-fixes-v1-12-524aefbc8bb4@linaro.org>
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
> Simplify the board code by using the new BUTTON_CMD functionality, instead
> of implementing this separately using C code. This allows disabling or
> customizing this functionality if wanted.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>   board/qualcomm/dragonboard410c/dragonboard410c.c   | 22 ----------------------
>   board/qualcomm/dragonboard410c/dragonboard410c.env |  2 ++
>   configs/dragonboard410c_defconfig                  |  2 +-
>   3 files changed, 3 insertions(+), 23 deletions(-)
> 
> diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
> index 697e3c9b08b5c874912eb66ff4f0b3d32deaae01..4698b9d5e3e47a9b0389d9f6bafab9dd6db56a41 100644
> --- a/board/qualcomm/dragonboard410c/dragonboard410c.c
> +++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
> @@ -51,28 +51,6 @@ static void msm_generate_mac_addr(u8 *mac)
>   	put_unaligned_be32(msm_board_serial(), &mac[2]);
>   }
>   
> -/* Check for vol- button - if pressed - stop autoboot */
> -int misc_init_r(void)
> -{
> -	struct udevice *btn;
> -	int ret;
> -	enum button_state_t state;
> -
> -	ret = button_get_by_label("vol_down", &btn);
> -	if (ret < 0) {
> -		printf("Couldn't find power button!\n");
> -		return ret;
> -	}
> -
> -	state = button_get_state(btn);
> -	if (state == BUTTON_ON) {
> -		env_set("preboot", "setenv preboot; run fastboot");
> -		printf("vol_down pressed - Starting fastboot.\n");
> -	}
> -
> -	return 0;
> -}
> -
>   int qcom_late_init(void)
>   {
>   	char serial[16];
> diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.env b/board/qualcomm/dragonboard410c/dragonboard410c.env
> index 71f929b646cc305cf5223cd3462fe2350bc8093e..38399d65c640ee18261529ee3101b268700fa004 100644
> --- a/board/qualcomm/dragonboard410c/dragonboard410c.env
> +++ b/board/qualcomm/dragonboard410c/dragonboard410c.env
> @@ -2,3 +2,5 @@
>   initrd_high=0xffffffffffffffff
>   fastboot=fastboot -l $fastboot_addr_r usb 0
>   boot_targets=usb mmc1 mmc0 pxe
> +button_cmd_0_name=vol_down
> +button_cmd_0=run fastboot
> diff --git a/configs/dragonboard410c_defconfig b/configs/dragonboard410c_defconfig
> index 414dda6778c95eb3fdcd6ef522d8c7d0ef9219fa..449d48a3c004117b832ad620d49beb681a9bda68 100644
> --- a/configs/dragonboard410c_defconfig
> +++ b/configs/dragonboard410c_defconfig
> @@ -14,6 +14,7 @@ CONFIG_OF_LIBFDT_OVERLAY=y
>   CONFIG_SYS_LOAD_ADDR=0x80080000
>   CONFIG_IDENT_STRING="\nQualcomm-DragonBoard 410C"
>   CONFIG_REMAKE_ELF=y
> +CONFIG_BUTTON_CMD=y
>   CONFIG_FIT=y
>   CONFIG_BOOTSTD_FULL=y
>   CONFIG_OF_BOARD_SETUP=y
> @@ -22,7 +23,6 @@ CONFIG_SYS_CBSIZE=512
>   CONFIG_SYS_PBSIZE=548
>   # CONFIG_DISPLAY_CPUINFO is not set
>   # CONFIG_DISPLAY_BOARDINFO is not set
> -CONFIG_MISC_INIT_R=y
>   CONFIG_SYS_PROMPT="dragonboard410c => "
>   CONFIG_CMD_MD5SUM=y
>   CONFIG_CMD_MEMINFO=y
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
