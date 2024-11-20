Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92348D711CB
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 17:00:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF31D8925A;
	Wed, 20 Nov 2024 18:00:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RmeSIqL8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E687F89270; Wed, 20 Nov 2024 18:00:09 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9C128920C
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 18:00:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-53da5511f3cso7077877e87.3
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 09:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732122007; x=1732726807; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hADaI9A/qWHeYyKq5A4FawQ94WAThfq56mXwJoIfq5Y=;
 b=RmeSIqL8ah2dAjJYmjM37aoIMDJ1mlvaSYKomc/nuCxwxXP2Enfn7Onb6wIS/LT286
 fdPIlgan0SANyqlLY0dYoYNMJ3uONbWkyGFjITgMV84/5lUUaRVw1+7rmpwj8mE1gngn
 A/FN56xnsDLzhptSJ4cbYq4ijnBojyG+FxyLaYIN0j3kKT+bKVknjN4ae29pvfJE98Ha
 owEJzT4npzn0VWjatX2QHKyJWbzZkr6DQW09cpOsBxVJ6uY086CtcW04ZRkkmbYyIPEt
 TroZMsUa/z0Z+VkKv5ZxEDxHTFcCqTHJXirVQxukz2kJky2ACqlDMCdgM8wDfPj/6WTA
 xiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732122007; x=1732726807;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hADaI9A/qWHeYyKq5A4FawQ94WAThfq56mXwJoIfq5Y=;
 b=ZOwPO3aK5aZPi7wcAamBplONZ3iGPHIxP33QsHKdHVnS9kur5QZPaXyWL3ojclK4NY
 yITZ8tcY17JIQua+k1QSxy5oQEQaKOgSzKF//FN/XP/bb4WypqRynB74xWx/wokRNmm6
 l5lPx3g//5RT+Wx4YWlTD9rzQGEXoAvtb5+Jkp6rDswf2r/VjaIN++w9cxCn4drTLM0m
 gATjzlvQOknDIdV0LLy39QAzgiZncQXfg7qBTf9JOQZqgIFY6PQVxdkfNFjcn8chJD67
 PeSw0bNMIO4PZpXa6PRjIGeNPIGpJ9iT2pbSuZOn+MHAiqLRYpCTA5bGRMBTP7t57mAQ
 2AYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCURxbxjUdGL8UuyWUjcVV5+mKpaQ5X2U+ef0y3vXfqAOaDC2YNDv8wCWP9xiwpx+s3HWOF2VhQ=@lists.denx.de
X-Gm-Message-State: AOJu0YycCQOT3gYgmOELAbrzAQu3Y+UVoH77nCRtEOVk4ed0nweBPy2s
 p8eUFf9/emiql3OguVY5xZ377DAjRJ8vubTK65WUMq0BKCrwBAzTMKCU+svuuhA=
X-Google-Smtp-Source: AGHT+IFHBB3gJaOFH4NuSyIV+KFRoP9m06Tz4Dj2pcCkAncZhFFXnVAYYz5XOXfjQ0BtGrJp/EA54A==
X-Received: by 2002:a05:6512:2206:b0:53d:a06b:7b8d with SMTP id
 2adb3069b0e04-53dc136aa5emr1758490e87.43.1732122006936; 
 Wed, 20 Nov 2024 09:00:06 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:7856:e1d8:479c:9f33?
 ([2a01:e0a:3cb:7bb0:7856:e1d8:479c:9f33])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20e0432fdsm793896866b.138.2024.11.20.09.00.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2024 09:00:06 -0800 (PST)
Message-ID: <c776847f-7c70-49c0-8b3d-033d6f62a4c3@linaro.org>
Date: Wed, 20 Nov 2024 18:00:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/14] efi_loader: device_path: add support for HTTP
 device path
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 ilias.apalodimas@linaro.org, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de
References: <20241118210908.51196-1-adrianox@gmail.com>
 <20241118210908.51196-8-adrianox@gmail.com>
 <d3e50c54-4d39-4930-a6f1-b29ba60bfd19@canonical.com>
 <CAMGU2hWJ07OaWJtavxt-dauKQ=WoH5ipuTp2HecKdmKJ4X1M9Q@mail.gmail.com>
 <b0ed71d8-09da-4c9f-ab0b-f356db2fda09@canonical.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <b0ed71d8-09da-4c9f-ab0b-f356db2fda09@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 11/20/24 17:07, Heinrich Schuchardt wrote:
> On 20.11.24 15:52, Adriano Córdova wrote:
>>
>>
>> El mar, 19 nov 2024 a las 7:14, Heinrich Schuchardt (<heinrich.schuchardt@canonical.com <mailto:heinrich.schuchardt@canonical.com>>) escribió:
>>
>>     On 18.11.24 22:09, Adriano Cordova wrote:
>>      > Add efi_dp_from_http to form a device path from HTTP. The
>>      > device path is the concatenation of the device path returned
>>      > by efi_dp_from_ipv4 together with an URI node and an END node.
>>      >
>>      > Signed-off-by: Adriano Cordova <adrianox@gmail.com
>>     <mailto:adrianox@gmail.com>>
>>      > ---
>>      > Changes in v4:
>>      > - Reworked an if-else
>>      >
>>      > Changes in v3:
>>      > - Moved argument checks in efi_dp_from_http to the beginning of
>>     the function
>>      >   include/efi_loader.h             |  1 +
>>      >   lib/efi_loader/efi_device_path.c | 52 +++++++++++++++++++++++++
>>     +++++++
>>      >   2 files changed, 53 insertions(+)
>>      >
>>      > diff --git a/include/efi_loader.h b/include/efi_loader.h
>>      > index 612bc42816..96b204dfc3 100644
>>      > --- a/include/efi_loader.h
>>      > +++ b/include/efi_loader.h
>>      > @@ -872,6 +872,7 @@ struct efi_device_path
>>     *efi_dp_part_node(struct blk_desc *desc, int part);
>>      >   struct efi_device_path *efi_dp_from_file(const struct
>>     efi_device_path *dp,
>>      >                                        const char *path);
>>      >   struct efi_device_path *efi_dp_from_eth(void);
>>      > +struct efi_device_path *efi_dp_from_http(const char *server);
>>      >   struct efi_device_path *efi_dp_from_mem(uint32_t mem_type,
>>      >                                       uint64_t start_address,
>>      >                                       size_t size);
>>      > diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/
>>     efi_device_path.c
>>      > index cdeea4791f..9ee03062ac 100644
>>      > --- a/lib/efi_loader/efi_device_path.c
>>      > +++ b/lib/efi_loader/efi_device_path.c
>>      > @@ -1012,6 +1012,58 @@ struct efi_device_path
>>     *efi_dp_from_ipv4(struct efi_ipv4_address *ip,
>>      >       return dp2;
>>      >   }
>>      >
>>
>>     A function description is missing.
>>     Please,
>>
>>      > +struct efi_device_path *efi_dp_from_http(const char *server)
>>      > +{
>>      > +     struct efi_device_path *dp1, *dp2;
>>      > +     struct efi_device_path_uri *uridp;
>>      > +     efi_uintn_t uridp_len;
>>      > +     char *pos;
>>      > +     char tmp[128];
>>      > +     struct efi_ipv4_address ip;
>>      > +     struct efi_ipv4_address mask;
>>      > +
>>      > +     if ((server && strlen("http://") + strlen(server) + 1  >
>>     sizeof(tmp)) ||
>>      > +         (!server && IS_ENABLED(CONFIG_NET_LWIP)))
>>      > +             return NULL;
>>      > +
>>      > +     efi_net_get_addr(&ip, &mask, NULL);
>>      > +
>>      > +     dp1 = efi_dp_from_ipv4(&ip, &mask, NULL);
>>
>>     This seems to be the only usage of efi_dp_from_ipv4(). So we should
>>     make
>>     it static.
>>
>>     dp1 is expected to be NULL if we are out of memory. This error needs to
>>     be handled.
>>
>>      > +
>>      > +     strcpy(tmp, "http://");
>>
>>     @Ilias:
>>     Linaro sent a patch series for supporting https.
>>     Will that go in after this series?
>>
>>      > +
>>      > +     if (server) {
>>      > +             memcpy(tmp + strlen("http://"), server,
>>     strlen(server) + 1);
>>
>>     Please, use strcat() to simplify this line.
>>
>>      > +     }
>>      > +#if !IS_ENABLED(CONFIG_NET_LWIP)
>>
>>     Please use 'else if' instead of '#if'.
>>
>>     Best regards
>>
>>     Heinrich
>>
>>
>> Hi Heinrich,
>> I can't use 'else if' as the symbol net_server_ip is only defined in legacy net
> 
> Understood.
> 
> @Jerome
> Should the function ip_to_string be() moved to net/net-common.c in future to implement the missing commands in lwIP?

That would certainly be a good place for it, yes.

Thanks,
-- 
Jerome

> 
> Best regards
> 
> Heinrich
> 
>>
>> Best,
>> Adriano
>>
>>
>>      > +     else {
>>      > +             ip_to_string(net_server_ip, tmp + strlen("http://"));
>>      > +     }
>>      > +#endif
>>      > +
>>      > +     uridp_len = sizeof(struct efi_device_path) + strlen(tmp) + 1;
>>      > +     uridp = efi_alloc(uridp_len + sizeof(END));
>>      > +     if (!uridp) {
>>      > +             log_err("Out of memory\n");
>>      > +             return NULL;
>>      > +     }
>>      > +     uridp->dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
>>      > +     uridp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_URI;
>>      > +     uridp->dp.length = uridp_len;
>>      > +     debug("device path: setting uri device path to %s\n", tmp);
>>      > +     memcpy(uridp->uri, tmp, strlen(tmp) + 1);
>>      > +
>>      > +     pos = (char *)uridp + uridp_len;
>>      > +     memcpy(pos, &END, sizeof(END));
>>      > +
>>      > +     dp2 = efi_dp_concat(dp1, (const struct efi_device_path
>>     *)uridp, 0);
>>      > +
>>      > +     efi_free_pool(uridp);
>>      > +     efi_free_pool(dp1);
>>      > +
>>      > +     return dp2;
>>      > +}
>>      > +
>>      >   /* Construct a device-path for memory-mapped image */
>>      >   struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
>>      >                                       uint64_t start_address,
>>
> 
