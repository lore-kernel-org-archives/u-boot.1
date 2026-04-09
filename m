Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E93FE9DE5F
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 08:00:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC7B4839D5;
	Thu,  9 Apr 2026 10:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YkThGUwX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D92B83CF5; Thu,  9 Apr 2026 10:00:51 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A72B783693
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 10:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so8319045e9.2
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 01:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775721647; x=1776326447; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Om2xywcxI3fHwkTpaTy/n/Yzf0/yCJWYXd+MLwqqrf8=;
 b=YkThGUwXpclijFJ/ru8mHieU2ASAMyEg63KqOw6kSTBRsTrNtKd0KaWRTOGpbHpkTZ
 mOgAyHdcwWYffhbEfizBe/jCqFi0Y2QAVZ+Kv/VZhtGyNaQYdAePys0Rkv6xr4WJosBO
 adIdLG1KRHcvLdD7o3l6lugD2AsRJU4ZbVpQL/TkcPdogbRBNFyZFfcpUfU2Cp0W32xx
 PS/viQ1oecbqFxuV3ssqkpo+rBjfiQhg7DDzH9Kp66vSPz0pDMbf7xf14B5wsqg+mjN3
 hpNh//iBW8oRMqfb/XY01LEBnVdO0IGQouZYMyOn1Ak0Fv6VDHWW0Ply0z9EDvg+W5a4
 AXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775721647; x=1776326447;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Om2xywcxI3fHwkTpaTy/n/Yzf0/yCJWYXd+MLwqqrf8=;
 b=R4eT9Axc4pUHiZippAJk6iyhpveExNO5zL5op3vMrh7FXVMsid+YdLZrZ5CvwkAy8I
 dM3HPr4X5xGxJdknagEHWOPx0yHX3ZIaaukMhikCLCh4aZXy0dPVLJgoGhu78BMfsQDM
 a/z+aQWnMf5nNQM1J0E9SETQ2XgRIGVNfzzYVvU7tdJMBJeQbS6SxiA4pnWxkLHzpgog
 bVoyKJN6t9WL3pRVk1uofTuzc7jWTZmpH5H53jr2Jf2P4q7C5hy7ucY/9KRHv+J6cUCS
 zKn+GFHaRLoiWLMZeICmK9dyHAYzu+Si8wGo29YCzFVr/XXals5+dhYOjgKIjVHtGRno
 HwZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6Xh3AcLU6xBz/3vKu0i1zPS01EFOzjs9QuVvzrKO9pFuWb1xEJ0hXwK4zQisAHFWpsA2zJJY=@lists.denx.de
X-Gm-Message-State: AOJu0YzU0aSrmRg1oF5Yzs2IUWNDFF3jH4mdL2niYnfCYAS0im0M0oaR
 hdlfLqtV4xY90wMl1MwuNMvAjGZ7xZ8RUKHOIv4SjPMAHOhgDfgbZXLPWPBQj+HdgLk=
X-Gm-Gg: AeBDieth4HELL4KV88hiTDRmmMv8SYSDhlC1jPvb9xFbzosUqa5lBMuGXtpedNr/miX
 5C5HsqTU+wC86dm7JTwsnBrGOfSNAE3FssDX3gIHcUdESBaLO7KtJaPVVvMY11RxgvfMsaaVspW
 kEw42AaZb98/eK4O1zJSr6MPfu+OGnDdj892aevEWS9aWSuCmearp5iVFvgminAE2/5jaV4m/bU
 NZeyNrKqE1HrBc1RcV9EMlOjhRAXPcreNvlx8KjIW93hSpyXi9Um8WkJCJS3SlWGVokZREb1/16
 u/5xZkceACjP6ENUKn2Wpo3ElNgmysi1KhzejTAuoTsmx+hkjJRTtcMFCProITzilD6iR/k0rvu
 b8NbfPrm2ErGcRiaKyusQgHqCxDvd02Hd0cV6ULvpi31N3AkgcdnDWaQAS49UvPqd9YUFv8Pvgq
 +MxZC+xH2PpM7mYE4fjwMiotxagL5OXbfhKWOOm1dWZf1g8/rPexj1XI/6d5kq3sGNe2X3ZPA97
 AS2Esc=
X-Received: by 2002:a05:600c:a47:b0:485:4eaf:eb53 with SMTP id
 5b1f17b1804b1-48899781357mr356705255e9.19.1775721646839; 
 Thu, 09 Apr 2026 01:00:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:70d5:8219:5bd4:e213?
 ([2a01:e0a:106d:1080:70d5:8219:5bd4:e213])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e2c5253sm58880667f8f.9.2026.04.09.01.00.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 01:00:46 -0700 (PDT)
Message-ID: <3ecb2179-64e6-4937-9c43-11caaa03a1b0@linaro.org>
Date: Thu, 9 Apr 2026 10:00:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/4] arm: mach-meson: move reset_cpu to spl only
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org>
 <20260408-b4-amlogic-sysreset-capsules-v1-1-6f3386eb5124@postmarketos.org>
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
In-Reply-To: <20260408-b4-amlogic-sysreset-capsules-v1-1-6f3386eb5124@postmarketos.org>
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

On 4/8/26 22:30, Ferass El Hafidi wrote:
> This is in preparation of enabling SYSRESET across all Amlogic boards by
> default. SYSRESET brings its own reset_cpu implementation which will
> conflict with the one defined in board-common.c. SPL however will not
> have SYSRESET enabled (due to overhead in the final image, as we have
> very little space to work with), and thus will still need that reset_cpu
> to be defined, so move it to spl.c so it is only built for SPL.
> 
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>   arch/arm/mach-meson/board-common.c | 14 --------------
>   arch/arm/mach-meson/spl.c          | 10 ++++++++++
>   2 files changed, 10 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/mach-meson/board-common.c b/arch/arm/mach-meson/board-common.c
> index a5afc2d75c0..24dcafd30ac 100644
> --- a/arch/arm/mach-meson/board-common.c
> +++ b/arch/arm/mach-meson/board-common.c
> @@ -154,17 +154,3 @@ int board_late_init(void)
>   
>   	return meson_board_late_init();
>   }
> -
> -void reset_cpu(void)
> -{
> -#if CONFIG_SPL_BUILD
> -	/*
> -	 * We do not have BL31 running yet, so no PSCI.
> -	 * Instead, let the watchdog reset the board.
> -	 */
> -	for (;;)
> -		;
> -#else
> -	psci_system_reset();
> -#endif
> -}
> diff --git a/arch/arm/mach-meson/spl.c b/arch/arm/mach-meson/spl.c
> index 28a63f39d36..ec566849667 100644
> --- a/arch/arm/mach-meson/spl.c
> +++ b/arch/arm/mach-meson/spl.c
> @@ -121,3 +121,13 @@ void board_init_f(ulong dummy)
>   	clrbits_32(GX_WDT_CTRL_REG, (1 << 18) | (1 << 25));
>   #endif
>   }
> +
> +void reset_cpu(void)
> +{
> +	/*
> +	 * We do not have BL31 running yet, so no PSCI.
> +	 * Instead, let the watchdog reset the board.
> +	 */
> +	for (;;)
> +		;
> +}
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
