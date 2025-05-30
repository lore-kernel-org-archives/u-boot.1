Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7481C5B549
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 07:48:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 298B08312C;
	Fri, 30 May 2025 09:48:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n5hRVP/A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E86128319C; Fri, 30 May 2025 09:48:02 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED658830EA
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 09:48:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso13817375e9.2
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 00:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748591280; x=1749196080; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p7cM6c4TnpzNIVO+LSRx5tzBKbS2gnr0tegm+noAr54=;
 b=n5hRVP/AcBP0Yy+BpSGzpgD12oIS0peV8eL959YS9y2sUaEykTHm4CrJsx5VXZxmVu
 IG8qG+CikEY2FH7DjCcyJFLRi/YeokELOfURuYl7Dy/V80/7eB+b5yWxwQ5ukgMzT40c
 8sBzoVFHnU8OQJ+p1T+XruAh1RrgTIViQQw6t1YxsmE57I+/0jnGg2/0n9t7yB12K7fO
 X1HUlghJFSA8KYCK50VlVf9p5M6iUKPYLt5VtctRoKYkER14mVGIUJXg7M+o1FYyx8wC
 l5yprh2pLTVmkwfGB8zUgbXIu0lqmRlGLeEQ2tOGPmwwmsoUPb0OaEKqY4E9LaL5vZ6c
 cEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748591280; x=1749196080;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p7cM6c4TnpzNIVO+LSRx5tzBKbS2gnr0tegm+noAr54=;
 b=dBPFWlsYo49ynWSoAwgNGpVQS3WFvijLwqJJzpm62Nf4ro0I1wzAzJyVj8fp43O3Mc
 wr2nzW/rroPAi26NSMAxtc8CGYWUOl2BlJW7zLU+HQEbISQYuaIzZkKgbMHpFMSKIN/s
 E/8PKdZuL1VDORf25/q8Wlp9lYvgEVtdLVNWkkullF7FH/j4GAfVPVwSW69cmcRhJJgZ
 ApTjUBb+5MwJedwf0R54Z6KMhDBnHNNGKoJVpMDcmRuquLJ77xWWqO+WLx2uNCFNpzG7
 M75hi+3AdAxvM8Bk5G03J98bbaQoNT3ZlYOstAS0JzL5zaUmJYf/dfNpmDSMhKF2h21m
 XKxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlw1SMkeJ9bj9dg+kaWMqoTIzhG5V5usq3cO/ZsIKw1fKV2GCZbPzKOagM624Leo6zYyB/4fg=@lists.denx.de
X-Gm-Message-State: AOJu0YxBCWUktjyjgi/3vtMKwuegcHyhBacjeOFLVUfubr0yhm53Ow50
 yoNBpoz1c8Nx+4kV+68X+g/vlSv71i0teXPjxaBkOpgSe1WOm/dZJnGmu8Jm3VR3wh0=
X-Gm-Gg: ASbGncvDOx2SEI0wFxxndXln3gk0J33UhYHhRUWWkfpkfr2J4Zry2nrmZW+O2ZHBtSk
 8qG/G1ZInNaMyebFeL+wE8PA3VLr2txQYlViK/CheoLk7rSr1+WalN0GxKko+lSZuPkfzKhZH1n
 N42gNyQPbIUQ5dAh/7tQa7LNIIFQ9Og1sTsJHZckNpv1U9NsC7ywVRb94Pkd3nKctmWObkF445Q
 lH08fclrZskSuFALWREb7CtMA4UeOPXGSPIvNQTZvAdgsddTsX5ZN+6ZGNAeI8u+jfSh7qSpjln
 erXEwj6xqwCC6hqWrimDBFEhnbHDllOcuDXuBT8syeGIT8eMHUsfKGAYGJSHnTG3+OFhpuHw/lY
 6dzIakKOEFtJRkv3b0oVqmKOULzKALWzC5UbkQRWvmg==
X-Google-Smtp-Source: AGHT+IFr6BfBizTF3LFJYFyj4Rf+h5cApFtSS6Tcv/LWsouXu8Rd1HDHsEZetA4u+MDAfgjUe8o7+g==
X-Received: by 2002:a05:600c:5250:b0:43c:fd27:a216 with SMTP id
 5b1f17b1804b1-450d8875db2mr8672505e9.23.1748591280354; 
 Fri, 30 May 2025 00:48:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:7f33:7a3a:e910:a0c4?
 ([2a01:e0a:3cb:7bb0:7f33:7a3a:e910:a0c4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009748fsm4041701f8f.80.2025.05.30.00.47.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 May 2025 00:48:00 -0700 (PDT)
Message-ID: <ae5f24b5-f339-46ce-8d25-9823c5cbe9e9@linaro.org>
Date: Fri, 30 May 2025 09:47:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] net: lwip: enable IP_FRAG and IP_REASSEMBLY
To: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250529214910.984024-1-tharvey@gateworks.com>
 <20250529214910.984024-2-tharvey@gateworks.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250529214910.984024-2-tharvey@gateworks.com>
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



On 5/29/25 23:49, Tim Harvey wrote:
> Enable IP_FRAG and IP_REASSEMBLY to allow packets larger than MTU.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  lib/lwip/u-boot/lwipopts.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/lwip/u-boot/lwipopts.h b/lib/lwip/u-boot/lwipopts.h
> index edac74ff7a21..1818a445dc5e 100644
> --- a/lib/lwip/u-boot/lwipopts.h
> +++ b/lib/lwip/u-boot/lwipopts.h
> @@ -72,8 +72,8 @@
>  
>  #define IP_FORWARD                      0
>  #define IP_OPTIONS_ALLOWED              1
> -#define IP_REASSEMBLY                   0
> -#define IP_FRAG                         0
> +#define IP_REASSEMBLY                   1
> +#define IP_FRAG                         1
>  #define IP_REASS_MAXAGE                 3
>  #define IP_REASS_MAX_PBUFS              4
>  #define IP_FRAG_USES_STATIC_BUF         0

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
