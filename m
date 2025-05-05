Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C13C3ABB6
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 12:23:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C722881F7B;
	Mon,  5 May 2025 14:23:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WK04CdFY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8217C82076; Mon,  5 May 2025 14:23:04 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8136880BAE
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 14:23:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so25733265e9.1
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 05:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746447782; x=1747052582; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Qw1o0kQZsUQOauA+UqMWbpUZ9haQAYXV2ru0h4zUjlA=;
 b=WK04CdFYV4ugSuNVn7mS7X/zRETcsK12BRI8cf76+lflmJ2BYE+7RYi5a6OA4pASW0
 zbmrfqINzCNq+ufXkm6BtrUORDPLayVGY8QDzwuWaAyvtQU1I4LMloIaS+80fZSMFYXb
 +Zsaxo/G8+I1BLwST7al3wzu5c19EhUaX6C7ryArJhnH28ojwXL80Z/X8cMTvs9jPO8F
 RO3TUcI9yIX8qQp+9SDLRKiFWGNAE2a6cIUGyqPLtKTRJHIdTVmb78fJ+yvaHlGKI5bv
 nhT+sKmlipifpEiCWrQsOPrOh/Vcbq0+qv7HVb6JyF3mV2Sfds9SJHcyalulI+3L4xwa
 ohCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746447782; x=1747052582;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Qw1o0kQZsUQOauA+UqMWbpUZ9haQAYXV2ru0h4zUjlA=;
 b=iRBqvHfMzo0crNaXoYWyLkv2QnkfPdc+ViqjZwsAR2dDsqbv2wYPqQMiobI26FejmT
 TYjedpit4KhoyHtK4pbh95Jp4sge1HdsHwGtpdlD1hLkMl4yo8nwgaaZOf8K2MzHEPgg
 6rZ0L25dSvM1996zSudLfCo4I0dp8qFTNoPrrv+qL/XH2AoV6qKMGslgIqzR/9ejiPQn
 rQkTA5Wdmyoex4VvhCmPCcZxiGmKqr9RNY8C2obqDpnnWxJ80fgbJ6xiSWlang2itXSZ
 nVWc4YO42P9rhNDP7SYdC6fHk0KNioQ2bmOZAtbrm9uKMV9hNakvj2L6mzsigpSkC5kD
 AGoA==
X-Gm-Message-State: AOJu0Ywxdd/99CEO3YNQX5LOJqEKI1T/onQy+J21nNhqCoVIyFKH8hiz
 u2ByRjUig464bXRT9yYY2fp9SMzVFVFnNPPzBe0LGMIDFOJF2CG/0RJnvzKWHJQ=
X-Gm-Gg: ASbGncsufdNWwE4faGl0XPL8y/xrXbcOtOqgYMqL7C+qiJVNpaT+vucBhGb64MQGyEA
 XOlaeYKtzYbTCSJ83AjMa5w5zgGNz6c8b2FYDTwiLaP62b7caALyrR2hlf8QbEbLfgIlb9GIvlg
 2GmLnhLuCY9bQXSb7lKfxMmlg3NKj1RI3vNAVgpr8XXU/S3tx3pwp+ACWmIYV2OWuMaioueFXOT
 Bg9fRxAQlp7EyZdUzKyyDzU+Jkl8C2/Hh20jOJKDWN2Wx1chtwOz/yketnT05p5LUA6Lq8dqJjX
 /9k2yifiv57BU/CiqJ/1GfSgU/YbIcCvJgqjmdUy59JTLQP/yDNwsFBFJ+NytUhxGh0rd4Ce5Eu
 LATbocci99TxddWsdJA==
X-Google-Smtp-Source: AGHT+IE5ct+TPRA1/gys26ETqro8PcQhEjEF4nrfZQ2vnRkAp71glA5zT1jGD2p3f5tg5hCSbd+Vrg==
X-Received: by 2002:a05:600c:500d:b0:43d:ed:ad07 with SMTP id
 5b1f17b1804b1-441bbf3b4b3mr102716905e9.29.1746447781940; 
 Mon, 05 May 2025 05:23:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:88d3:1ad7:3ae1:56e3?
 ([2a01:e0a:3d9:2080:88d3:1ad7:3ae1:56e3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae3b57sm10470595f8f.36.2025.05.05.05.23.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 05:23:01 -0700 (PDT)
Message-ID: <7d4d5363-92be-4cc9-8cbd-ead679cb08fb@linaro.org>
Date: Mon, 5 May 2025 14:23:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 2/5] mach-snapdragon: Enhance android image handling
 memory footprint
To: gchan9527@gmail.com, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Simon Glass
 <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250505-android-boot-v2-0-92dcb5bf59c8@gmail.com>
 <20250505-android-boot-v2-2-92dcb5bf59c8@gmail.com>
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
In-Reply-To: <20250505-android-boot-v2-2-92dcb5bf59c8@gmail.com>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 05/05/2025 11:17, George Chan via B4 Relay wrote:
> From: George Chan <gchan9527@gmail.com>
> 
> In order to unzipped kernel from androidboot img, extra memory for
> loadaddr is needed. So once fastboot is enabled fastboot memory also
> share with loadaddr.
> 
> That can balance with memory constrain soc and android usecase.
> 
> Signed-off-by: George Chan <gchan9527@gmail.com>
> ---
>   arch/arm/mach-snapdragon/board.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index deae4d32378..3ee0933d962 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -500,8 +500,12 @@ int board_late_init(void)
>   	status |= env_set_hex("ramdisk_addr_r", addr_alloc(SZ_128M));
>   	status |= env_set_hex("kernel_comp_addr_r", addr_alloc(KERNEL_COMP_SIZE));
>   	status |= env_set_hex("kernel_comp_size", KERNEL_COMP_SIZE);
> -	if (IS_ENABLED(CONFIG_FASTBOOT))
> -		status |= env_set_hex("fastboot_addr_r", addr_alloc(FASTBOOT_BUF_SIZE));
> +	if (IS_ENABLED(CONFIG_FASTBOOT)) {
> +		addr = addr_alloc(FASTBOOT_BUF_SIZE);
> +		status |= env_set_hex("fastboot_addr_r", addr);
> +		/* override loadaddr for memory rich soc */
> +		status |= env_set_hex("loadaddr", addr);

I wouldn't make it conditional on fastboot

> +	}
>   	status |= env_set_hex("scriptaddr", addr_alloc(SZ_4M));
>   	status |= env_set_hex("pxefile_addr_r", addr_alloc(SZ_4M));
>   	addr = addr_alloc(SZ_2M);
> 


Anyway

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
