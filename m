Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF049C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 08:54:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A17283AE3;
	Thu, 10 Apr 2025 10:54:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uomC/N5f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76C0D83AE4; Thu, 10 Apr 2025 10:54:22 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5450783AC6
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:54:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3912fdddf8fso1168446f8f.1
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 01:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744275260; x=1744880060; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=XwrZt3k3J1vIPiQnHE3Ozne+DvJeB1uTJ8/kpZWzaT4=;
 b=uomC/N5f5bbpASBuoC1Uun8xE0OJkBBrBmCdUvdkjqOLMbXmwwezMm8+DckY1ajrLj
 rToFfLrkXrVHz/A1yuaIcAntFiavGpJguAJXEbufOR9MIw/N9QUA4or/SODxmhpKKwfr
 uKj+kW8dSfCZ625j8vvq3AkxkY+5VJDb19odPZPUv5g7X1OPEOokDNfu6qOYsUapjijx
 pZzyUc9x7c26WfZ7faBwExvWo4raGKDjcjzJJ2rmDZWqKZUarGZfla7GPo7Us8JfPUJ5
 9K3ludJUwmEApUtjAFpvABtXc4sz7rU9M2wWkOBijsIYNKPIqMXSQyxfe0YgQIOqth6N
 vXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744275260; x=1744880060;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XwrZt3k3J1vIPiQnHE3Ozne+DvJeB1uTJ8/kpZWzaT4=;
 b=qwjM1axFbab3o0H2Wa0UuG9f/u9dRnIZ5IMZPV7xNUVNSd/c7IUd+79XB7S2jwDiF9
 i9z64QJcMLOgokJJ2t9HN9xvih6J/5VpPyhOXCW5kZMYJlMTFvprOIogrm5UEBswH3BW
 2+nwy1a8D2VTaQ/Et9Ybrehei4XCUuqyaEw9ky9deGnd1oAMYsst9Hrjz+6M43xrfsAW
 kFSWIRzrtXsNztnh2/ZQlzcVrvFV7h5E3mOHFrLunAqKLnoLCrjsILHyOGbG1GIrmLoV
 VQQ3EvCmBjxj00uCXMLi6TMh2Ojkg3B6tXoShhlHpYcHN7JtxnxbA9smEKOiIt6Nts3e
 rFlg==
X-Gm-Message-State: AOJu0YwbwTtFo766Tzb1HkKeDLio2gRKvm6CrxpD7Dsp99pY2iOho1OV
 X0nWFLDUYAUbwr8HAdPJdwkBOFcWruURkYVYO0gh3rxNLlwucpSpGGCu94k5DAw=
X-Gm-Gg: ASbGnctsJheVD/u13q55tO4Q4iL7jgMWa/YAD/zh7GGSbRmrQdjE5Ft+iIORnxUBuMD
 S0dNsm5s3i+WhoxwonmFnDLL6C2QL9NxTgTHC9YFTew8cmDPX5hIWuBDTH3e5xrm3UHzbR325FC
 +4NwBCV9ViDzudEy2/rrfZnyc96QlZJrvzB5E/huYz94MyV4UmEFDk34pl8i1ElnshiRX2X8eAQ
 smA/lCpX/s1bqann+7arEs3FEOH1qecQ6gCMm1q49d78FB3YilkwLs4utpYhWoyZM0DWphIM5w/
 1QgZAFtMtEYG28D0Hr9ZEAHdcLGpO48u2uUblnP6Z/Dq4JwTPQRt0DO2xP/GGdCO6qP9qsOg/e9
 439mPmjbApm5IxyJbxQ==
X-Google-Smtp-Source: AGHT+IFEe7oSmGsAKMm97g/4Y50wiT5syJUlYlO9zc/6rBqJbdCnQgHyjmRkuXavKR1N04ArT4rGcw==
X-Received: by 2002:a5d:5f93:0:b0:39c:2673:4f79 with SMTP id
 ffacd0b85a97d-39d8f632284mr1642644f8f.26.1744275259796; 
 Thu, 10 Apr 2025 01:54:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:1a13:cd5d:5261:ebfe?
 ([2a01:e0a:3d9:2080:1a13:cd5d:5261:ebfe])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d8936115asm4197520f8f.12.2025.04.10.01.54.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 01:54:19 -0700 (PDT)
Message-ID: <82b872f2-f3fb-4a7b-872d-dafe25ac06ee@linaro.org>
Date: Thu, 10 Apr 2025 10:54:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/6] event: signal when livetree has been built
To: Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
 <20250409-livetree-fixup-v1-1-76dfea80b07f@linaro.org>
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
In-Reply-To: <20250409-livetree-fixup-v1-1-76dfea80b07f@linaro.org>
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
> OF_LIVE offers a variety of benefits, one of them being that the live
> tree can be modified without caring about the underlying FDT. This is
> particularly valuable for working around U-Boot limitations like lacking
> USB superspeed support on Qualcomm platforms, no runtime OTG, or
> peripherals like the sdcard being broken (and displaying potentially
> worrying error messages).
> 
> Add an event to signal when the live tree has been built so that we can
> apply fixups to it directly before devices are bound.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   common/event.c  | 3 +++
>   include/event.h | 9 +++++++++
>   lib/of_live.c   | 3 +++
>   3 files changed, 15 insertions(+)
> 
> diff --git a/common/event.c b/common/event.c
> index dda569d447851f559a83f98fb7b1f3543156eab5..8d7513eb10b61919e1e784481dfdcc076be14986 100644
> --- a/common/event.c
> +++ b/common/event.c
> @@ -47,8 +47,11 @@ const char *const type_name[] = {
>   	"ft_fixup",
>   
>   	/* main loop events */
>   	"main_loop",
> +
> +	/* livetree has been built */
> +	"of_live_init",
>   };
>   
>   _Static_assert(ARRAY_SIZE(type_name) == EVT_COUNT, "event type_name size");
>   #endif
> diff --git a/include/event.h b/include/event.h
> index 75141a192a48b0931667632f41be8ff4d6139f7c..3fc673ba635ed45467aae8587705d37bef1c2a3f 100644
> --- a/include/event.h
> +++ b/include/event.h
> @@ -152,8 +152,17 @@ enum event_t {
>   	 * A non-zero return value causes the boot to fail.
>   	 */
>   	EVT_MAIN_LOOP,
>   
> +	/**
> +	 * @EVT_OF_LIVE_INIT:
> +	 * This event is triggered immediately after the live device tree has been
> +	 * built. This allows for machine specific fixups to be done to the live tree
> +	 * (like disabling known-unsupported devices) before DM init happens. This
> +	 * event is only available if OF_LIVE is enabled and is only used after relocation.
> +	 */
> +	EVT_OF_LIVE_INIT,
> +
>   	/**
>   	 * @EVT_COUNT:
>   	 * This constants holds the maximum event number + 1 and is used when
>   	 * looping over all event classes.
> diff --git a/lib/of_live.c b/lib/of_live.c
> index 90b9459ede313e492e28c8556c730f3bd8aaa9df..e1962b8f1fb9d8c2c87d04ca4e238a1e4d00376a 100644
> --- a/lib/of_live.c
> +++ b/lib/of_live.c
> @@ -10,8 +10,9 @@
>   
>   #define LOG_CATEGORY	LOGC_DT
>   
>   #include <abuf.h>
> +#include <event.h>
>   #include <log.h>
>   #include <linux/libfdt.h>
>   #include <of_live.h>
>   #include <malloc.h>
> @@ -334,8 +335,10 @@ int of_live_build(const void *fdt_blob, struct device_node **rootp)
>   		return ret;
>   	}
>   	debug("%s: stop\n", __func__);
>   
> +	event_notify_null(EVT_OF_LIVE_INIT);
> +
>   	return ret;
>   }
>   
>   void of_live_free(struct device_node *root)
> 

Looks good :-)

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
