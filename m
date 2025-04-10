Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D79C369A4
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 08:54:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79F5C83AE4;
	Thu, 10 Apr 2025 10:54:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SvW1wwBP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 604A483AC6; Thu, 10 Apr 2025 10:54:33 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C04383AEF
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:54:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso5051795e9.2
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 01:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744275271; x=1744880071; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Cl58Wtvsszpc/fB0s78oPpDV2fzqZtFGxZb4TQiYnyE=;
 b=SvW1wwBPzZzVT17cLAywbufaZAIE77TLKx8KErrQtyClqoBzWQgkd3DR7meaMUqPDm
 Eyy8Ji97ygZlp/rzyDjccT1EGNqtYVNbZxGQL+0KarfmnflSQtnzfSf2ElSPoqbt+JVh
 e9rAryFynMXiVpsUeOydF4x41p8mVuRHCFWUS6iabbLglc3mNJYcSobgiaimTOf10K9G
 YT8hq+9q7JWqiTJlGCXXOgXS3TXBTpwfbAef/Po5Yz0ZIUxFSr2naRD2y7/CKSgqckVy
 za2vRi0GFCsEQL6/ycMfaIRNeLrHucmw3ksYXw/unhNqUQVPUqsK6lIPBI16NKh52A0v
 sDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744275271; x=1744880071;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Cl58Wtvsszpc/fB0s78oPpDV2fzqZtFGxZb4TQiYnyE=;
 b=ZDp90pBcrStHmOpX5bkQhbq/6wLdrYMLeXdis14ng7hEeanbDlSr9MQXrsTuNcT6Cx
 h2HHPWjnCgDnVF4XAQtA9YLeP3sf6FEHVmV8wBLoDtDeoyql7ZdW/tWrSVcNDj84Gzbj
 C8ckXM90qS/ArkePQ9pwTsHqi2w/1PWX2pNM+kbAWmgbEll90lcYwrgDdTkreq6VGMav
 zB1MP0XDh0uPQaR/1afitvRxx41O8DD88MQlrUubb7cS/mAgAcWXm39oSiB7jbaOH27J
 1uMdxEpk90IhmnuVZIHid+/S1r+gzHBYJDz83RxnLkuTuFSh4CBiCbsOuHUWVa5or3e0
 Wrfw==
X-Gm-Message-State: AOJu0YxfSg0E9z474gHlvNxvXXi8FGP8EvrK31aabE5IacgzeaC535Sm
 tjIfEK11SOvqVJWZu4axuP6we3qNQQBl/O1R5m0zZvXIIDiG4G/Bq7cJWqlT5ss=
X-Gm-Gg: ASbGncspdDxrCGuAI5Uq77oEGjLv+HFrzC894LtD+XkgnuySEKkldwgsECSGciVccMn
 N5tikcCnlXWtMjEfV6Tfo5TiT4AI4Co3no/cVLZ0mUm5pES1zUJBkWZfBuoYd3vBwz+zH0lOYpJ
 iOOaQSzp6CLh4iMycICiqgf2XKdw8KBTCQAyf22iN6Le3NmGatZx+T2clOYTbWM+AJWuTk3Sr0p
 gvR6jIiV0O3cjPATg7Y79QLpRbOqHsIW0zHaWFI4DS7Wg8MnEZjs9M5o0rY0Aj01tPw4QEA9AJv
 hPbMy0F6ZNK/pBLiW5Yl078YV7py6NVeuZqwCldigdQ/ECZjy4cEs4VuB2HiSfMTKqwUUn/ryWd
 p1/Xd852VNK5PJPut3dOahQwXZLgz
X-Google-Smtp-Source: AGHT+IEdqpEIsGSWqUEvLLFcOUI6hh9ftxvHd31jkZp9vGNa2bIiDkjKJlanhnWfHl+nWX0bYzGazA==
X-Received: by 2002:a05:600c:3d9b:b0:43d:23fe:e8a6 with SMTP id
 5b1f17b1804b1-43f2d7ae769mr16362305e9.5.1744275270664; 
 Thu, 10 Apr 2025 01:54:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:1a13:cd5d:5261:ebfe?
 ([2a01:e0a:3d9:2080:1a13:cd5d:5261:ebfe])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f233c824bsm43792565e9.24.2025.04.10.01.54.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 01:54:30 -0700 (PDT)
Message-ID: <28a39725-6176-48fa-80de-8265a44f46bc@linaro.org>
Date: Thu, 10 Apr 2025 10:54:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/6] mach-snapdragon: use EVT_OF_LIVE_INIT to apply DT
 fixups
To: Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
 <20250409-livetree-fixup-v1-2-76dfea80b07f@linaro.org>
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
In-Reply-To: <20250409-livetree-fixup-v1-2-76dfea80b07f@linaro.org>
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

On 09/04/2025 19:17, Caleb Connolly wrote:
> This will now apply fixups prior to devices being bound, which makes it
> possible to enable/disable devices and adjust more properties that might
> be read before devices probe.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/mach-snapdragon/board.c     |  1 -
>   arch/arm/mach-snapdragon/of_fixup.c  |  7 ++++++-
>   arch/arm/mach-snapdragon/qcom-priv.h | 14 --------------
>   3 files changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index deae4d323789eab75d5fe735159b4cd820c02c45..3ab75f0fce02ecffd476ebe2aa606b1a9024bbec 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -305,9 +305,8 @@ void __weak qcom_board_init(void)
>   
>   int board_init(void)
>   {
>   	show_psci_version();
> -	qcom_of_fixup_nodes();
>   	qcom_board_init();
>   	return 0;
>   }
>   
> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> index 1ea0c18c2f2789a8aa054cd95bb9e4308d6b3384..d4e24059212c552de7fa7555d2ab8a1ea4fc4cb2 100644
> --- a/arch/arm/mach-snapdragon/of_fixup.c
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -21,8 +21,9 @@
>   
>   #include <dt-bindings/input/linux-event-codes.h>
>   #include <dm/of_access.h>
>   #include <dm/of.h>
> +#include <event.h>
>   #include <fdt_support.h>
>   #include <linux/errno.h>
>   #include <stdlib.h>
>   #include <time.h>
> @@ -149,14 +150,18 @@ static void fixup_power_domains(void)
>   		func(__VA_ARGS__); \
>   		debug(#func " took %lluus\n", timer_get_us() - start); \
>   	} while (0)
>   
> -void qcom_of_fixup_nodes(void)
> +static int qcom_of_fixup_nodes(void)
>   {
>   	time_call(fixup_usb_nodes);
>   	time_call(fixup_power_domains);
> +
> +	return 0;
>   }
>   
> +EVENT_SPY_SIMPLE(EVT_OF_LIVE_INIT, qcom_of_fixup_nodes);
> +
>   int ft_board_setup(void *blob, struct bd_info __maybe_unused *bd)
>   {
>   	struct fdt_header *fdt = blob;
>   	int node;
> diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
> index 74d39197b89f4e769299b06214c26ee829ecdce0..4f398e2ba374f27811afd2ccf6e72037d0f9ee7f 100644
> --- a/arch/arm/mach-snapdragon/qcom-priv.h
> +++ b/arch/arm/mach-snapdragon/qcom-priv.h
> @@ -8,19 +8,5 @@ void qcom_configure_capsule_updates(void);
>   #else
>   void qcom_configure_capsule_updates(void) {}
>   #endif /* EFI_HAVE_CAPSULE_SUPPORT */
>   
> -#if CONFIG_IS_ENABLED(OF_LIVE)
> -/**
> - * qcom_of_fixup_nodes() - Fixup Qualcomm DT nodes
> - *
> - * Adjusts nodes in the live tree to improve compatibility with U-Boot.
> - */
> -void qcom_of_fixup_nodes(void);
> -#else
> -static inline void qcom_of_fixup_nodes(void)
> -{
> -	log_debug("Unable to dynamically fixup USB nodes, please enable CONFIG_OF_LIVE\n");
> -}
> -#endif /* OF_LIVE */
> -
>   #endif /* __QCOM_PRIV_H__ */
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
