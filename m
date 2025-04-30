Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83CCC3ABA9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 14:58:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DCE48215F;
	Wed, 30 Apr 2025 16:58:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WUyjzC+k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B37682BA1; Wed, 30 Apr 2025 16:58:08 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37B658215F
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 16:58:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e5e63162a0so11045443a12.3
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 07:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746025086; x=1746629886; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dXrn6uAORWC0kFHU+hAiId/YfqMcs+j2y8P/IViAPVM=;
 b=WUyjzC+kl7liSkhZpjUBDriLen96AZFUenaPH+hvtjoD1NYFkXE6MEWdwm0rOwZ446
 HybY+51x5FU9SGAi1CGM2Veyqyw7saO0XzHj3OjuiI1UiqvQie8N1GDx9MScO456oi2j
 o+lK2hZ8Itqgege3Mr2S3NO4z/1rCKgCbB8yt4+KTyGksL8uYwIFcZGiCVLROQeWpyqM
 iqm62cfeX1Rzy4eu0vnX62l2/hbhSRlX32ji1mq18/+nLActS+jrsvoPW1oZ9uwLbeOf
 8jP1mYNWsI42QJcHVvThT5q9VbHzOKA4toT20dnHaW2obQhvI1CPAzSpRlc+gncFq3Hi
 CRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746025086; x=1746629886;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dXrn6uAORWC0kFHU+hAiId/YfqMcs+j2y8P/IViAPVM=;
 b=RKe+3bJX/iokf2uLTFFSFx80mMwiKPzJzYZXiIXjaH+4jrQAfsbgSZUVJKvk3HKTjj
 v2efdxktWfMWA0jMO8+kk/t+4ipM8Yh9Y43uR4SgIB40nwg5Xtdpw3rjXdOxl1Ro5eOX
 s8dGpl2Zngx11bg+BrcVKWU6Ijr1wVg/5y1OI6HO8CpiHNF0Kas+HMmDgb5yYBqDcKyq
 omE2utHdjtNiFzZ8IurRQ3k/QvsYsHNcgV1JLtACkes1wPa3/S1WBjRN8Fn/ANzIMVEb
 0uAjjBctofKmE0u14xdTb2CwXT9gW8JrI5h5Ha+X7VLzCig9LJYEQltxIfZ9n/5UAUD3
 jrcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxW5RaOYjDYkvt9oae41grKS/vexZAc8cZQsKqpSqQ0so4LorY4q1fpV3y21uI9kORx5DSp9M=@lists.denx.de
X-Gm-Message-State: AOJu0Ywll7mCxyPdtzWPERfi3Ffinj5j+MOdQAcZhADBEruhaAHEoai7
 fn7JNej3jgVGyC9Eu7iYCuJac/DeCMhkkG2vVUe2LG5nlM5mwv+sKUb8x9wq6qc=
X-Gm-Gg: ASbGncvvyEibudOB0T/u4QVISu9XvHvgV7AqTLshLW2Fe9Hp1863uCZtSrDJI52rBvO
 BxL3mYFgYKLNEYBlKy8zEfbKty/VnIGCLOxcrWs5eVkZhoCzNh7Ok2bkyFps5kH+igVkI66dhut
 XkcBBFpB8kDFvzWml/wCX/3Hc8LGaq1xKe7HXgp+J3Ro4mfzDCBl/W6LxJw0iCm+dUG/ZiAwVpI
 9s2BOhQL6JbVeQkFFCMnoFknd91+cjfcpsBFYuAqNccISn/DU2McTn9SlaIlhpS1BGoZufaPABU
 DhDRS1x/PR6skGf9RCECTKHhlee+RyKdjyUrnN/dI6carqXg9fMCtM/xQY6NzBJH4kHzt8qsNGD
 ghPMEkyOOgKkLAmCppcXN
X-Google-Smtp-Source: AGHT+IF7CleV8vDeAB2p3UzsmqgGDACRSggsmP63iVZKmT91g6wih68y/kfIhoKhihj/nRbmTqV9Ww==
X-Received: by 2002:a05:6402:26d4:b0:5f6:c4ed:e270 with SMTP id
 4fb4d7f45d1cf-5f89ab6617dmr3225508a12.3.1746025085424; 
 Wed, 30 Apr 2025 07:58:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:b269:e2f0:3646:3c73?
 ([2a01:e0a:3cb:7bb0:b269:e2f0:3646:3c73])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f7038323c1sm8764466a12.68.2025.04.30.07.58.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 07:58:05 -0700 (PDT)
Message-ID: <51f0400b-d720-4a34-b338-14222c8cc4b5@linaro.org>
Date: Wed, 30 Apr 2025 16:58:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: Move env_get_ip() out of the header file
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>
References: <20250430144014.1698011-1-sjg@chromium.org>
 <20250430144014.1698011-2-sjg@chromium.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250430144014.1698011-2-sjg@chromium.org>
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



On 4/30/25 16:40, Simon Glass wrote:
> This function requires access to env.h but it is a lot to include just
> for the env_get() function. It eventually pulls in linux/byteorder which
> causes a conflict with exfat which has its own byteorder functions.
> 
> Move the function to a C file instead.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>  include/net-common.h | 6 +-----
>  net/net-common.c     | 6 ++++++
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net-common.h b/include/net-common.h
> index f2613a41ad8..64b475b7292 100644
> --- a/include/net-common.h
> +++ b/include/net-common.h
> @@ -4,7 +4,6 @@
>  #define __NET_COMMON_H__
>  
>  #include <asm/cache.h>
> -#include <env.h>
>  #include <hexdump.h>
>  #include <linux/if_ether.h>
>  #include <linux/sizes.h>
> @@ -464,10 +463,7 @@ int update_tftp(ulong addr, char *interface, char *devstring);
>   *	0 to 255
>   * Return: IP address, or 0 if invalid
>   */
> -static inline struct in_addr env_get_ip(char *var)
> -{
> -	return string_to_ip(env_get(var));
> -}
> +struct in_addr env_get_ip(char *var);
>  
>  int net_init(void);
>  
> diff --git a/net/net-common.c b/net/net-common.c
> index 45288fe5f80..9ff06b165df 100644
> --- a/net/net-common.c
> +++ b/net/net-common.c
> @@ -1,4 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <env.h>
>  #include <net-common.h>
>  
>  void copy_filename(char *dst, const char *src, int size)
> @@ -25,3 +26,8 @@ int wget_request(ulong dst_addr, char *uri, struct wget_http_info *info)
>  	wget_info = info ? info : &default_wget_info;
>  	return wget_with_dns(dst_addr, uri);
>  }
> +
> +struct in_addr env_get_ip(char *var)
> +{
> +	return string_to_ip(env_get(var));
> +}

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
