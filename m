Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F202DCAC5AC
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 07:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 491828206E;
	Fri, 26 Sep 2025 09:26:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wXxe40NK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDDA5830B4; Fri, 26 Sep 2025 09:26:02 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FD518144A
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 09:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46e33b260b9so17099515e9.2
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 00:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758871560; x=1759476360; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZZB9rVh4qA2DK2QX/n0nHqZAT/C1DuxKmiEFu2QL5jE=;
 b=wXxe40NKCLnjI8WHJKSRFOpP7aRF81mlcjYYUm89BYfq26tqUuif2aIh4gRAxz3HRr
 ff7PyjEuzJujgO2822b8pRGNU+ngIr+gK94ZDT8L0qTwKbGEwexi5JvXghPuMv7IvixM
 vAWAXaGk6sKiWYB5FGQguL0n91YO4EaSQ6hUxMM/kPp8IODAZqdF9UHlj149FGFhW0y4
 LjMd9BDb0xpvI+N+AoGHOixXncyDZjkDNSxSv0EcPacRdtyLfQ1Frq3k4di7JeK12GiK
 Ty5QQVHWpsDrmrLv3rKMZ1HZ+0aVCoT/ZPKiR6rgP58UASuxXT4vGOnvFzgs8l5eHUkh
 9Pag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758871560; x=1759476360;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZZB9rVh4qA2DK2QX/n0nHqZAT/C1DuxKmiEFu2QL5jE=;
 b=Sq2mYQjnGJnlBn0LUV4UNnlDa7daO+dq+VT+gXUIX/s0YTxXmOae3keah+Mrk94O5C
 gwOFEVD8cbD47cCixuhv2Ohc0WvzhnxYw7qLCse5eunFGICIFZRM2sFuc1t2Ve49vg84
 lhh6mVFMG58tr76OS3dybg3xwacN/GaOrroqcqBHERu8rSz0ob1TZygliFQjOXyLost8
 l/wcYqEiLRpcI+t6hqWR0noL0SGOwvgUrOAQI+XLJmfWheLj6logMOvlPJNDpcyTlbjz
 DGJfz1o0FMjqReIDm+6FfVD3e6V3D41y05dTfrzkIakinJT1RUCWHOvxH/d07z2IEfll
 Ys3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5TWF6wMDbHLcAAocaZD6srZuTcgBlmxaMlD5egXRbrkcltslG0IY38xN2r+xRCjbrqmF2+x0=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3DgkaccT+3LV+lyGrXNqHM+0nHbA6/jNik7UyOb62NGoWKASg
 awqkeHMG8uSuxNU/1qZjHOQjm9jHqLZbdNCSRYhl70aYpqkkU+QYQQhnOFMyHU93MI54daPGb7d
 +HjMOHaU=
X-Gm-Gg: ASbGnctoC3RnZldbXZNZN9aN7EWjVozIuu2OMLH2YyF8IVxJ3BKzYJn5KBPz/eu3XpM
 t0U8UrFTIhtN14a9aRrY7Vjtq4G0yIKYVLByJDXK8cMcC2zfpvJKzFK2vTvJ+5ze6aOABsekwhM
 5M7PwJu8aPbdbTSVYZnZN8askAxj40gxIkOHXJnVGmo70e2VaVZcS1qouhRrVqvhTjG0phD8J1W
 wUD3D69gtc7KmqIw+jwm6sqGlLcVBnCUjP5YSEBiEtc03ZRMZudyhdHn/yciyED2vyhLqO3pUHY
 ml6SxKatOHk10Jf5VXQ0sajnzS/IVMCRvoiZj6OOWvPFIVMl80n2tRbvcW+KO+MjjfE/l6Ydn8x
 AY6JgYoZZnuz5J5d8DgMYUs54QIPjDt78mQ0IAShZXJda1fGrFk4DOpcHDx1OMOeBmGpvOIFC/9
 g=
X-Google-Smtp-Source: AGHT+IHaUKHOgE5hG2NphIR+hMHpP5/qkgWZ1Rs5V5uK5sooln3pzGjlVuxWZFraZXAMkbN0WE5F/w==
X-Received: by 2002:a05:600c:3f0e:b0:46e:36ba:9253 with SMTP id
 5b1f17b1804b1-46e36ba93b7mr48343065e9.15.1758871559629; 
 Fri, 26 Sep 2025 00:25:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:c93:82d7:a602:f31d?
 ([2a01:e0a:3cb:7bb0:c93:82d7:a602:f31d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e33b6da3dsm32666385e9.0.2025.09.26.00.25.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 00:25:59 -0700 (PDT)
Message-ID: <633f3a6a-0ce2-45b4-abfe-9070d6f5c0a7@linaro.org>
Date: Fri, 26 Sep 2025 09:25:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] net: Remove BOOTP_VENDOREX support
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250925204414.3561033-1-trini@konsulko.com>
 <20250925204414.3561033-3-trini@konsulko.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250925204414.3561033-3-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 9/25/25 22:44, Tom Rini wrote:
> It has been over a decade since we had a platform that implemented the
> bootp vendor extension support hook. Remove this option due to lack of
> use.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  cmd/Kconfig |  4 ----
>  net/bootp.c | 13 -------------
>  net/bootp.h |  4 ----
>  3 files changed, 21 deletions(-)
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 29de857ba7c2..d4f34f4bc290 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1890,10 +1890,6 @@ config BOOTP_BOOTPATH
>  	  Even though the config is called BOOTP_BOOTPATH, it stores the
>  	  path in the variable 'rootpath'.
>  
> -config BOOTP_VENDOREX
> -	bool "Support vendor extensions from BOOTP/DHCP server"
> -	depends on CMD_BOOTP
> -
>  config BOOTP_BOOTFILESIZE
>  	bool "Request & store 'bootfilesize' from BOOTP/DHCP server"
>  	depends on CMD_BOOTP
> diff --git a/net/bootp.c b/net/bootp.c
> index 19e7453daed1..a28d11cb3683 100644
> --- a/net/bootp.c
> +++ b/net/bootp.c
> @@ -491,9 +491,6 @@ static int dhcp_extended(u8 *e, int message_type, struct in_addr server_ip,
>  #endif
>  	int clientarch = -1;
>  
> -#if defined(CONFIG_BOOTP_VENDOREX)
> -	u8 *x;
> -#endif
>  #if defined(CONFIG_BOOTP_SEND_HOSTNAME)
>  	char *hostname;
>  #endif
> @@ -584,12 +581,6 @@ static int dhcp_extended(u8 *e, int message_type, struct in_addr server_ip,
>  
>  	e = add_vci(e);
>  
> -#if defined(CONFIG_BOOTP_VENDOREX)
> -	x = dhcp_vendorex_prep(e);
> -	if (x)
> -		return x - start;
> -#endif
> -
>  	*e++ = 55;		/* Parameter Request List */
>  	 cnt = e++;		/* Pointer to count of requested items */
>  	*cnt = 0;
> @@ -977,10 +968,6 @@ static void dhcp_process_options(uchar *popt, uchar *end)
>  			}
>  			break;
>  		default:
> -#if defined(CONFIG_BOOTP_VENDOREX)
> -			if (dhcp_vendorex_proc(popt))
> -				break;
> -#endif
>  			printf("*** Unhandled DHCP Option in OFFER/ACK:"
>  			       " %d\n", *popt);
>  			break;
> diff --git a/net/bootp.h b/net/bootp.h
> index 47c743479e73..14f5af68e150 100644
> --- a/net/bootp.h
> +++ b/net/bootp.h
> @@ -24,10 +24,6 @@
>  #if defined(CONFIG_CMD_DHCP)
>  /* Minimum DHCP Options size per RFC2131 - results in 576 byte pkt */
>  #define OPT_FIELD_SIZE 312
> -#if defined(CONFIG_BOOTP_VENDOREX)
> -extern u8 *dhcp_vendorex_prep(u8 *e); /*rtn new e after add own opts. */
> -extern u8 *dhcp_vendorex_proc(u8 *e); /*rtn next e if mine,else NULL  */
> -#endif
>  #else
>  #define OPT_FIELD_SIZE 64
>  #endif

Acked-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
