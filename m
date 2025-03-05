Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0520C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 12:27:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BED2807B1;
	Wed,  5 Mar 2025 13:27:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MtAfS9Vk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FCCA8083E; Wed,  5 Mar 2025 13:27:51 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEEB7800C1
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 13:27:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43bb6b0b898so31640855e9.1
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 04:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741177668; x=1741782468; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2Ex7C4nPY8L3XfUehj4PeYuakrKuI69lnBXzIKwpygo=;
 b=MtAfS9Vk1se4awBD0cwgtekwlRpLDzizfPYnNLRaMiifxkpvO0ADLUX03cuI7sefz8
 oURURyjH02fqGHIg/sok3EDmLJ6kXIOyBVnm+dfB3l8HzHvhxSBzOyNlQLewiK3Bl2Fh
 IvVLEVf+Be3wonBgA/kqKXeISxRuHaiq2r2jX/oRy61SpSRFTcuHCqoKp4Lr6E8fWowj
 NIfm37hVRJ9WUYk6q1cTSgTlPXv7IOycbcb0NTz24FD53ufCBJ6o75Zhn7KJARcNXKEK
 FxX5gphWXinarWjT86E54dfoNAImH0sYNjqQmPKwKjkX6/e+xbMLrVf4/Ai0Gz/3YXwp
 o+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741177668; x=1741782468;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2Ex7C4nPY8L3XfUehj4PeYuakrKuI69lnBXzIKwpygo=;
 b=l7WOJ8oJk9gvU+VmpbfIAS0pLCGUsggsNRVfZG8pg2sa3OaWMTImmQGoSxrkxnmYM6
 /bSrm08csgs3vsvOFd6lsNcm0qrhQwl2jsxt3Imy84JWJZ8XuZ7bvKNIHpAc4MBwUQA4
 EXMjFf7wAQoFhZYQzRv1P6RxnweDi0pcyfmnlF1L6rH04l2gFk3eJU+EMoDiWTX9i4Kr
 NPTE3oa5+wr3i0kT6u/059HYauoodNaW2IL2Hx6Zqge3Cr/gzMp7yILzExO77CN7KbVo
 E3MvimtTn87Pr0FGNQg5Br3EDNWRIDQX0VzDlfB6k7BgjiBKQRrMFryXgaNRSK/a49VU
 yZEQ==
X-Gm-Message-State: AOJu0Yw086Hkxr6A3vgRBbjSWz2nKkIS0erD8WW+u5MzTqq4B4Dnj1aa
 +UkNCaq2FZ0BwKSmCSFLp+Bq/luWITBBilNugdmVrpZYOtI7K2e8+Fjl0jrx/yE=
X-Gm-Gg: ASbGncu8V/XC0FKBZytULQu4g3FGm3oQBrZUNlbPghHj8duEhMQ5TLgFUU9JhkPJXz4
 bfPbBlXZgAYbZGnvy+RDVtv9HsjYOChlCosKJO3czqOWbxHX52YO6UhCnLT+s0m4sia2GR8DfOd
 xSDHgYFR0bLXVUvUZKyBdpLkVRZbw+GuJ0ULaWjxY2VLiDNpn7cWqB1x46LAD+E/AX9i3cmAFMT
 bVSyUzPqGObKjOIEAAQrqcONeHMBsgWBYrP6A8oypAvnsX1Ww07gBziTs5CYRBm45FlGs2EShJI
 WmQzAcajUqe953F4yzh8cWn+aoMMvEzd4FQZqs2HDtm3uKTxHNvH8D0Ea5ZcEA6oami2lUNMI1e
 ejzheKw4rDeKbO9Do9SenFUj0
X-Google-Smtp-Source: AGHT+IHsbBXsutApi6kyblBygisq+0aZcDP0woi5EfMLD9SY24Kzx2ZozVfyWJxP53L5iJx+9G/L9A==
X-Received: by 2002:a05:600c:510f:b0:439:9537:e96b with SMTP id
 5b1f17b1804b1-43bd29bced0mr22250605e9.14.1741177667744; 
 Wed, 05 Mar 2025 04:27:47 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:9358:6683:ed70:95ca?
 ([2a01:e0a:3cb:7bb0:9358:6683:ed70:95ca])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd426d32dsm16589845e9.7.2025.03.05.04.27.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 04:27:47 -0800 (PST)
Message-ID: <b04620b1-625c-4c93-98a4-9363ea8cb71d@linaro.org>
Date: Wed, 5 Mar 2025 13:27:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] lwip: tls: enforce checking of server certificates
 based on CA availability
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Javier Tia <javier.tia@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Simon Goldschmidt <goldsimon@gmx.de>
References: <cover.1740672437.git.jerome.forissier@linaro.org>
 <f9841a538eae301779e33c4dcf1d0ae126759909.1740672437.git.jerome.forissier@linaro.org>
 <CAC_iWj+Msh-W5zfZPoJ4q5DVnw_F4xHGPR-RzeT95oSE0ozwtw@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWj+Msh-W5zfZPoJ4q5DVnw_F4xHGPR-RzeT95oSE0ozwtw@mail.gmail.com>
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

Hi Ilias,

On 2/28/25 22:26, Ilias Apalodimas wrote:
> Hi Jerome
> 
> ++CC Simon for lwIP
> 
> On Thu, 27 Feb 2025 at 18:09, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> Instead of relying on some build time configuration to determine if
>> server certificates need to be checked against CA certificates, do it
>> based on the availability of such certificates. If no CA is configured
>> then no check can succeed; on the other hand if we have CA certs then
>> we should not ignore them. It is always possible to remove the CA certs
>> (via 'wget cacert 0 0') to force an HTTPS download that would fail
>> certificate validation
> 
> This looks correct, but we should at some point send those to lwIP as
> well instead of keeping them locally

I agree, but it seems upstream doesn't care much about contributions,
unfortunately. The patches I submitted got zero consideration until now
[1][2]. And the list of unacknowledged/unassigne patch is quite large
[3]. So I would not bother for now.

[1] https://savannah.nongnu.org/patch/?10462 (TFTP blocksize)
[2] https://savannah.nongnu.org/patch/?10480 (TFTP port binding)
[3] https://savannah.nongnu.org/patch/?group=lwip

> 
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Thanks!

-- 
Jerome

> 
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c        | 3 ++-
>>  .../lwip/src/include/lwip/apps/altcp_tls_mbedtls_opts.h     | 6 ------
>>  2 files changed, 2 insertions(+), 7 deletions(-)
>>
>> diff --git a/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c b/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
>> index 46421588fef..fa3d1d74fed 100644
>> --- a/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
>> +++ b/lib/lwip/lwip/src/apps/altcp_tls/altcp_tls_mbedtls.c
>> @@ -786,6 +786,7 @@ altcp_tls_create_config(int is_server, u8_t cert_count, u8_t pkey_count, int hav
>>    int ret;
>>    struct altcp_tls_config *conf;
>>    mbedtls_x509_crt *mem;
>> +  int authmode = have_ca ? MBEDTLS_SSL_VERIFY_REQUIRED : MBEDTLS_SSL_VERIFY_NONE;
>>
>>    if (TCP_WND < MBEDTLS_SSL_IN_CONTENT_LEN || TCP_WND < MBEDTLS_SSL_OUT_CONTENT_LEN) {
>>      LWIP_DEBUGF(ALTCP_MBEDTLS_DEBUG|LWIP_DBG_LEVEL_SERIOUS,
>> @@ -840,7 +841,7 @@ altcp_tls_create_config(int is_server, u8_t cert_count, u8_t pkey_count, int hav
>>      altcp_mbedtls_free_config(conf);
>>      return NULL;
>>    }
>> -  mbedtls_ssl_conf_authmode(&conf->conf, ALTCP_MBEDTLS_AUTHMODE);
>> +  mbedtls_ssl_conf_authmode(&conf->conf, authmode);
>>
>>    mbedtls_ssl_conf_rng(&conf->conf, mbedtls_ctr_drbg_random, &altcp_tls_entropy_rng->ctr_drbg);
>>  #if ALTCP_MBEDTLS_LIB_DEBUG != LWIP_DBG_OFF
>> diff --git a/lib/lwip/lwip/src/include/lwip/apps/altcp_tls_mbedtls_opts.h b/lib/lwip/lwip/src/include/lwip/apps/altcp_tls_mbedtls_opts.h
>> index e41301c061c..71aa5993935 100644
>> --- a/lib/lwip/lwip/src/include/lwip/apps/altcp_tls_mbedtls_opts.h
>> +++ b/lib/lwip/lwip/src/include/lwip/apps/altcp_tls_mbedtls_opts.h
>> @@ -100,12 +100,6 @@
>>  #define ALTCP_MBEDTLS_SESSION_TICKET_TIMEOUT_SECONDS  (60 * 60 * 24)
>>  #endif
>>
>> -/** Certificate verification mode: MBEDTLS_SSL_VERIFY_NONE, MBEDTLS_SSL_VERIFY_OPTIONAL (default),
>> - * MBEDTLS_SSL_VERIFY_REQUIRED (recommended)*/
>> -#ifndef ALTCP_MBEDTLS_AUTHMODE
>> -#define ALTCP_MBEDTLS_AUTHMODE                        MBEDTLS_SSL_VERIFY_OPTIONAL
>> -#endif
>> -
>>  #endif /* LWIP_ALTCP */
>>
>>  #endif /* LWIP_HDR_ALTCP_TLS_OPTS_H */
>> --
>> 2.43.0
>>
