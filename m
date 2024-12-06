Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45FFE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 14:33:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 147E78960E;
	Fri,  6 Dec 2024 15:33:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="scoev6m8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5F5C89615; Fri,  6 Dec 2024 15:33:35 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B16AA8960D
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 15:33:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-434a2033562so20510905e9.1
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 06:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733495613; x=1734100413; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WUq4UbIDjYyZPh6PWYxrWkO+INO9wLZ94vRtt/L9bSc=;
 b=scoev6m8Mf5MvgeC7nXZV3m4/t9pevwQOxs7pfCzUgyJ451HbiuWMoArcXe7x5o3TZ
 YDqVyVLKgfONWdjAs/13AvadJoqQnh8Cb4TLb3afNuHMugxlK/xd0p0tCCEfoZCR7XPJ
 6E9LBDWQXEMSlEh1YMvGIYQPz4k0PEKpfcPYsxcZRyvLILruZcS9IH8753FW0ggqdrgs
 5F/6LIB9yK4AWqKioWeynbVialY2Iq2FJQI2hdPvaBvH0nAcrWLIzxWyBi/5N+DOnpxh
 xNFuL8BGQXmnsMbgmhzIoFBjcZ36ghycP11Wvnx3rZsOvNp8FVEaw88gdnjYBk80RlfJ
 YjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733495613; x=1734100413;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WUq4UbIDjYyZPh6PWYxrWkO+INO9wLZ94vRtt/L9bSc=;
 b=Fan13Njw1kBvCYh54UtQfAyWbJ0M76lCDz6t5GEw1ekkaBuweqwG6z9iddE60dAMoR
 3MYshqZEZrbXNRjdAW98pTMHk5tZB0HUbsdo8kWyJyFP2JuZ2MyiY3R4gfbuPYI9b9iw
 hD87kcJoy/ANfI/c6xTUWEVspyD0RYgHJVZf+VVCGYfxhAaR/scC38gCctb6pa8vJAHW
 BeaaCtRV01hku9WhnJagx6Z8Xsro6FnTG+5RujbdrO7YmGVqFqEEc5ph2h9AdrTLrDRI
 5eSevTFZFXtwxFFPcfXSBL1VsnZ1bp2ANUycsKiJRHA87//mqWZ6zMtv18Vm7whTcCSR
 /BuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW23Z4DNjwIia/cg1PuGYmxd7SUBh9wiRgrEycPVvL/UGBOPSat+2Y1ARHHTvLfSSZ3YvwV1ek=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0n8ev1F4zFaI0AyuP5EY+zDa4UeUmxE+r58T/YS+aF2HBn69H
 DBAgPpVpg9CAKOMNaGOKnWvsz2AYZrABbb3Y4kr9Mi6j2wby7npOCDOBf6cI+A8=
X-Gm-Gg: ASbGncvGGM/Gj+70qPwFvJo6D67g42T3NSJuiTuYwQORw22P/j9tO6sSIpG6N95TOCR
 KkAwCoAjq1aYrw/7IeUnfpQThuUdR786qTOd1sYrfQVB2KH3bcbA19JsJSIiUIP2tUSx4KLmgQw
 KAbpXGG7IAademVNb2ig4oKTYqykLkhylRIOqnE5dPkwDDa3M9uffDJQ2/AlAKx0g44dU3yoQob
 VJ9M0hfc3EG5J0eJZNZCchOEWhvpZ9PyoFwv7kfAUe2vZp+JgCeObnB1lXGY/d7J0m2tdTxoH31
 BZpj8+ITrr8m6HmM7ygoku0YJDg=
X-Google-Smtp-Source: AGHT+IGce93v4m5FjfLzgOzDVv6w5OivFXzqqNMi03s7/x8J4I9mb/o/vrWpmO0qR14kR2WjGCAFaA==
X-Received: by 2002:a05:600c:4f86:b0:434:a902:415b with SMTP id
 5b1f17b1804b1-434ddeb5523mr33035405e9.10.1733495613077; 
 Fri, 06 Dec 2024 06:33:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:59a:bb7b:8cad:cb79?
 ([2a01:e0a:3cb:7bb0:59a:bb7b:8cad:cb79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-386219096cdsm4777173f8f.81.2024.12.06.06.33.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 06:33:32 -0800 (PST)
Message-ID: <43c4500c-be1b-4def-bdec-cf1c5ee48e33@linaro.org>
Date: Fri, 6 Dec 2024 15:33:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mbedtls: remove MBEDTLS_HAVE_TIME
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, xypron.glpk@gmx.de
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>, Javier Tia <javier.tia@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
References: <20241206105647.2548249-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241206105647.2548249-1-ilias.apalodimas@linaro.org>
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



On 12/6/24 11:56, Ilias Apalodimas wrote:
> When MbedTLS TLS features were added MBEDTLS_HAVE_TIME was defined as part
> of enabling https:// support. However that pointed to the wrong function
> which could crash if it received a NULL pointer.
> 
> Looking closer that function is not really needed, as it only seems to
> increase the RNG entropy by using 4b of the current time and date. 
> The reason that was enabled is that lwIP was unconditionally requiring it,
> although it's configurable and can be turned off.
> 
> Since lwIP doesn't use that field anywhere else, make it conditional and
> disable it from our config.
> 
> Fixes: commit a564f5094f62 ("mbedtls: Enable TLS 1.2 support")
> Reported-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c | 2 ++
>  lib/mbedtls/mbedtls_def_config.h                     | 3 ---
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c b/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
> index 6643b05ee94d..46421588fef8 100644
> --- a/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
> +++ b/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
> @@ -692,7 +692,9 @@ altcp_tls_set_session(struct altcp_pcb *conn, struct altcp_tls_session *session)
>    if (session && conn && conn->state) {
>      altcp_mbedtls_state_t *state = (altcp_mbedtls_state_t *)conn->state;
>      int ret = -1;
> +#ifdef MBEDTLS_HAVE_TIME
>      if (session->data.MBEDTLS_PRIVATE(start))
> +#endif

Should this part be sent upstream? Maybe as a followup patch in [1]?

[1] https://github.com/lwip-tcpip/lwip/pull/47

>        ret = mbedtls_ssl_set_session(&state->ssl_context, &session->data);
>      return ret < 0 ? ERR_VAL : ERR_OK;
>    }
> diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_config.h
> index d27f017d0847..1d2314e90e4d 100644
> --- a/lib/mbedtls/mbedtls_def_config.h
> +++ b/lib/mbedtls/mbedtls_def_config.h
> @@ -92,9 +92,6 @@
>  
>  /* Generic options */
>  #define MBEDTLS_ENTROPY_HARDWARE_ALT
> -#define MBEDTLS_HAVE_TIME
> -#define MBEDTLS_PLATFORM_MS_TIME_ALT
> -#define MBEDTLS_PLATFORM_TIME_MACRO rtc_mktime
>  #define MBEDTLS_PLATFORM_C
>  #define MBEDTLS_SSL_CLI_C
>  #define MBEDTLS_SSL_TLS_C

Acked-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
