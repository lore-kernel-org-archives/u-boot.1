Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F2FFA1FD3
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 16:26:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94855842EF;
	Wed, 22 Apr 2026 18:26:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D4qaAxno";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46487842BF; Wed, 22 Apr 2026 18:26:38 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B09484262
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 18:26:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488d2079582so66728645e9.2
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 09:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776875195; x=1777479995; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=cuCeYogGpkN/LhhedCGAUq7c/dseD6cXD/qn9VdqF2U=;
 b=D4qaAxnoYqiAH004s/yR2r8KFGqksmAy9P5cgonV1sI5NCx3IcNxGNg0UE+45JUF9A
 ZNOAWGuVg89mAZArNkt/q6Cx4QTrOYwe7H/2b97YeY0VDxt6KTZsYdjtMXEzgDDNayCe
 mOyzxVLgQvY3yWWPsQXVixLCxajE9Z9FSV2ElxYdH96XMcPD3P7noz/rbjq4WutPt/b0
 WjaBJsEYrcIO9FKSYap63+HkiFOYuhqh6u7Zt32yMvikh0ZAbKFTqzzTWtaaMJ7cpCxY
 aVt2jb76ZccjJ+B7M4GQ+P6gn+E/hNWMRpiMFg6EiRnB2+a/LECr4HdkCsreU+Ztko9g
 l0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776875195; x=1777479995;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cuCeYogGpkN/LhhedCGAUq7c/dseD6cXD/qn9VdqF2U=;
 b=l6hqZi6gSfOcQPH0qAAE5ZrEmp/w2aM8CoPMc4C69Ds3/xgfj9BfVR6NFl13qYvYzq
 6TJ9q0Wv+5av4VpsOfdPGO+mIgQsVl0gpTbrajapx1u8zMxL4lAFDNfdjH65EyzJ4Ggo
 NdlvAPCkKxHdySmwDiGM8y3SH0fO3B+iqKfEvz9Zy8Fi6PAicIRvdZlHPvJONi1q/ROQ
 H4+UNpxVA6QL+SQ0YFigA/OhI6ve+gFAYHSwI3niiHNq2R/uDBM0PMCTHrZJ42Bafo6c
 LG8oiOPTxx7oAg5U+nUvhBhJJdTb8vW8MLcclBa8gBvHMEB1rDHQvWPAIM5sBQryiOTH
 ZTEg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/UoP65C5rg2dr+QL9FkA+yUlt/y83xu40YWTIgRQbaBob2RZ7NOJpgK2MLpF9Idxx9R11nChg=@lists.denx.de
X-Gm-Message-State: AOJu0YzSuF4mPYUpaVhnaW1RtYKkmv9Q93Jy4mUzMz/QXPhu88etw1e7
 QKohRsQgCcCs1f04Rvbh1UUIpTWmiL0xqr/XotqTkuAGG/K71LUtIBtBFg5o3d0tM4s=
X-Gm-Gg: AeBDieu87crjx6Ad+SaS3PTE2NmbTKNkN6lG0Wg2BxVMunvCb3JrA5AwTMS/foxN6Cd
 CRfVNAFpFN57rOOvrMYo/gAcWnUXf3UJjjsWaHU2VHTnMdXGjIuCnrz8VgHk9IeZbtBZaqyhAIB
 Ah8AsAEahmomLqo2G8xETopWO9tLky9B7YVhR7aYT7jjGUS3AceihqVaXaBAYwxNEyNtTgdiyxI
 yfUcsLbzZQrkPdyEMGReZTYWbeduX+PddQ3c8x/YEdnCJrjFxXiKCZvjeT2KYT6aAFnj+lxJK3Z
 3VzYY43WYh/WMAMVQ7JjpA3MWV5nvLmlhIbS2bNUeVJVgmoFr+KzzH4SpbJZSWCRdOFQ7qPPQaE
 6uR+/5hsIe+BUXNkcvx0Hn+iALxYwTPqxqhdHvF1FV+pTVWz9356WUuvL4oOplJYGrVpdmJ8iX+
 ajgDxIcg0vVi9O/2gBa1KPFsgwz0VNNkjQLuDYj2ShaAv30pfpULYtv11wMTznkAQtLna37K7PR
 B4tBSYGKjZ6jRz0WQ==
X-Received: by 2002:a05:600c:444a:b0:487:1520:d107 with SMTP id
 5b1f17b1804b1-488fb793580mr307763075e9.31.1776875194750; 
 Wed, 22 Apr 2026 09:26:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:7d92:9cde:4eb2:46d7?
 ([2a01:e0a:106d:1080:7d92:9cde:4eb2:46d7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a5d27d6casm4330665e9.27.2026.04.22.09.26.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 09:26:34 -0700 (PDT)
Message-ID: <48d4b6e1-b150-42cb-9949-d99a08fcdbcf@linaro.org>
Date: Wed, 22 Apr 2026 18:26:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 1/4] arm: mach-meson: provide reset_cpu only when
 SYSRESET is disabled
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260422-b4-amlogic-sysreset-capsules-v3-0-07b5ccc8f552@postmarketos.org>
 <20260422-b4-amlogic-sysreset-capsules-v3-1-07b5ccc8f552@postmarketos.org>
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
In-Reply-To: <20260422-b4-amlogic-sysreset-capsules-v3-1-07b5ccc8f552@postmarketos.org>
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

On 4/22/26 17:43, Ferass El Hafidi wrote:
> This is in preparation of enabling SYSRESET across all Amlogic boards by
> default. SYSRESET brings its own reset_cpu implementation which will
> conflict with the one defined in board-common.c.
> SPL however will not have SYSRESET enabled (due to overhead in the final
> image, as we have very little space to work with), and thus will still
> need that reset_cpu to be defined. Furthermore, some boards do not enable
> PSCI support in U-Boot, so they may still need this implementation.
> Guard reset_cpu inside #ifdef to only compile it in when SYSRESET is not
> enabled.
> 
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> ---
>   arch/arm/mach-meson/board-common.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-meson/board-common.c b/arch/arm/mach-meson/board-common.c
> index a5afc2d75c0..c34b81e5e78 100644
> --- a/arch/arm/mach-meson/board-common.c
> +++ b/arch/arm/mach-meson/board-common.c
> @@ -155,16 +155,14 @@ int board_late_init(void)
>   	return meson_board_late_init();
>   }
>   
> +#if defined(CONFIG_XPL) || !CONFIG_IS_ENABLED(SYSRESET)
>   void reset_cpu(void)
>   {
> -#if CONFIG_SPL_BUILD
>   	/*
>   	 * We do not have BL31 running yet, so no PSCI.
>   	 * Instead, let the watchdog reset the board.
>   	 */
>   	for (;;)
>   		;
> -#else
> -	psci_system_reset();
> -#endif
>   }
> +#endif
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
