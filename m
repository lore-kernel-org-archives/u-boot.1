Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A175FD711BC
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 16:07:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AE5A89241;
	Wed, 20 Nov 2024 17:07:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="W5f1aNWj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38BAD89241; Wed, 20 Nov 2024 17:07:31 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07BA889001
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 17:07:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5E9393F339
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 16:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732118848;
 bh=ZX/WtpMUyLpFd1tRLONFkUDDD9d1TjR0rSXK+M1G2xo=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=W5f1aNWj8vSHfzMgrc6FCAY20K6o3H1Mc8MQqQfBkz3pQRi8IqY/e/vlWsUib0pIY
 vp/KVfJP4xkVyaoEgaIXxDkzu8QWlOu+ub3Kb4fqaOGu38CNslpinL6KbFhTJ9chmI
 rPhYHv+3EL9qO1kdjrq5pVNjiBxIyrKpF5XR/KTFqQ6REGv4Rqi8hy66/y5rg/mq41
 gDnJxF6cPBoYDk0VKGcurEltnZISH3l10GTDrHzHBWgH5hsQnYSQpH8DJ8hhzuL7mQ
 gOSQHmnRVEb1bc9qc+L9WC1fikDMVXew7P5ywBI/DW5SVzsZr7yiKrZwllDMZ0uKGQ
 XnsreBCzJMu0g==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4314c6ca114so41063555e9.1
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 08:07:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732118848; x=1732723648;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZX/WtpMUyLpFd1tRLONFkUDDD9d1TjR0rSXK+M1G2xo=;
 b=JfajD3Rw2ADc86CRcEvDFVIvxWb6dDjxwXr6SwPB2ew9Q4NtHphuGdxdoVD81A2YtY
 /Cm+8uBUV3hl2I/9nL5sSv59lYF5/k/9DgBO2yEO7wcRHPLjyB8WVuMdkuj1az2GUGwZ
 pjntbGdRl90iucu8UCE1SiKjeI++lpzv8/B4gMt51QQdsw0nXx35VpkUMYLSXCxLS2oj
 8umLv4TfnkENVN2WB4aPd1/PaCbYWOtMlPUBnDKEHmDd0Luc0GCwUHsUQy7a/Zuga+ci
 feC9nNOtkRc4bUCX2W2RbmPKoRgqBZ0TvB0XVCRPV3O/SOVhFNw48GFo6SPWbJ41gU/d
 GfIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJLe/UI3eux+fyrjIRAQThKD096sHWaAVYtHBEgkuvzUI2hI0mLgJwtt2hejiPhtbs+lMHdBs=@lists.denx.de
X-Gm-Message-State: AOJu0YzQQJkZLuvKT8nB1w07/Q1R+o3QeKB5DawaU6nMQzMp41t8Cb2O
 I0XCCBGraXdEjqzQRGhOpc6tnntNw3Rz08uP1Gq3tYUIT3MrFpC3TKB/s2qmPS49cPnGQbJA8v8
 DA6ON7/9Bi0FthyNC8+pdq8lVURnEPF03HEKQXTki0TRiOGqabVsu9qT0Ol1VHjZp1eM=
X-Received: by 2002:a05:600c:5125:b0:430:582f:3a9d with SMTP id
 5b1f17b1804b1-4334f01f731mr27250255e9.26.1732118847788; 
 Wed, 20 Nov 2024 08:07:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHX0ypKYIZpTapejI+julxvy1G5VYUIQ84uEYcchggDMKOjzv7GGeTcPGe5pWsyQtxDwgMQDQ==
X-Received: by 2002:a05:600c:5125:b0:430:582f:3a9d with SMTP id
 5b1f17b1804b1-4334f01f731mr27249695e9.26.1732118847293; 
 Wed, 20 Nov 2024 08:07:27 -0800 (PST)
Received: from [192.168.103.101]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b0139b22sm24666045e9.0.2024.11.20.08.07.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2024 08:07:26 -0800 (PST)
Message-ID: <b0ed71d8-09da-4c9f-ab0b-f356db2fda09@canonical.com>
Date: Wed, 20 Nov 2024 17:07:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/14] efi_loader: device_path: add support for HTTP
 device path
To: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
References: <20241118210908.51196-1-adrianox@gmail.com>
 <20241118210908.51196-8-adrianox@gmail.com>
 <d3e50c54-4d39-4930-a6f1-b29ba60bfd19@canonical.com>
 <CAMGU2hWJ07OaWJtavxt-dauKQ=WoH5ipuTp2HecKdmKJ4X1M9Q@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAMGU2hWJ07OaWJtavxt-dauKQ=WoH5ipuTp2HecKdmKJ4X1M9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 20.11.24 15:52, Adriano Córdova wrote:
> 
> 
> El mar, 19 nov 2024 a las 7:14, Heinrich Schuchardt 
> (<heinrich.schuchardt@canonical.com 
> <mailto:heinrich.schuchardt@canonical.com>>) escribió:
> 
>     On 18.11.24 22:09, Adriano Cordova wrote:
>      > Add efi_dp_from_http to form a device path from HTTP. The
>      > device path is the concatenation of the device path returned
>      > by efi_dp_from_ipv4 together with an URI node and an END node.
>      >
>      > Signed-off-by: Adriano Cordova <adrianox@gmail.com
>     <mailto:adrianox@gmail.com>>
>      > ---
>      > Changes in v4:
>      > - Reworked an if-else
>      >
>      > Changes in v3:
>      > - Moved argument checks in efi_dp_from_http to the beginning of
>     the function
>      >   include/efi_loader.h             |  1 +
>      >   lib/efi_loader/efi_device_path.c | 52 +++++++++++++++++++++++++
>     +++++++
>      >   2 files changed, 53 insertions(+)
>      >
>      > diff --git a/include/efi_loader.h b/include/efi_loader.h
>      > index 612bc42816..96b204dfc3 100644
>      > --- a/include/efi_loader.h
>      > +++ b/include/efi_loader.h
>      > @@ -872,6 +872,7 @@ struct efi_device_path
>     *efi_dp_part_node(struct blk_desc *desc, int part);
>      >   struct efi_device_path *efi_dp_from_file(const struct
>     efi_device_path *dp,
>      >                                        const char *path);
>      >   struct efi_device_path *efi_dp_from_eth(void);
>      > +struct efi_device_path *efi_dp_from_http(const char *server);
>      >   struct efi_device_path *efi_dp_from_mem(uint32_t mem_type,
>      >                                       uint64_t start_address,
>      >                                       size_t size);
>      > diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/
>     efi_device_path.c
>      > index cdeea4791f..9ee03062ac 100644
>      > --- a/lib/efi_loader/efi_device_path.c
>      > +++ b/lib/efi_loader/efi_device_path.c
>      > @@ -1012,6 +1012,58 @@ struct efi_device_path
>     *efi_dp_from_ipv4(struct efi_ipv4_address *ip,
>      >       return dp2;
>      >   }
>      >
> 
>     A function description is missing.
>     Please,
> 
>      > +struct efi_device_path *efi_dp_from_http(const char *server)
>      > +{
>      > +     struct efi_device_path *dp1, *dp2;
>      > +     struct efi_device_path_uri *uridp;
>      > +     efi_uintn_t uridp_len;
>      > +     char *pos;
>      > +     char tmp[128];
>      > +     struct efi_ipv4_address ip;
>      > +     struct efi_ipv4_address mask;
>      > +
>      > +     if ((server && strlen("http://") + strlen(server) + 1  >
>     sizeof(tmp)) ||
>      > +         (!server && IS_ENABLED(CONFIG_NET_LWIP)))
>      > +             return NULL;
>      > +
>      > +     efi_net_get_addr(&ip, &mask, NULL);
>      > +
>      > +     dp1 = efi_dp_from_ipv4(&ip, &mask, NULL);
> 
>     This seems to be the only usage of efi_dp_from_ipv4(). So we should
>     make
>     it static.
> 
>     dp1 is expected to be NULL if we are out of memory. This error needs to
>     be handled.
> 
>      > +
>      > +     strcpy(tmp, "http://");
> 
>     @Ilias:
>     Linaro sent a patch series for supporting https.
>     Will that go in after this series?
> 
>      > +
>      > +     if (server) {
>      > +             memcpy(tmp + strlen("http://"), server,
>     strlen(server) + 1);
> 
>     Please, use strcat() to simplify this line.
> 
>      > +     }
>      > +#if !IS_ENABLED(CONFIG_NET_LWIP)
> 
>     Please use 'else if' instead of '#if'.
> 
>     Best regards
> 
>     Heinrich
> 
> 
> Hi Heinrich,
> I can't use 'else if' as the symbol net_server_ip is only defined in 
> legacy net

Understood.

@Jerome
Should the function ip_to_string be() moved to net/net-common.c in 
future to implement the missing commands in lwIP?

Best regards

Heinrich

> 
> Best,
> Adriano
> 
> 
>      > +     else {
>      > +             ip_to_string(net_server_ip, tmp + strlen("http://"));
>      > +     }
>      > +#endif
>      > +
>      > +     uridp_len = sizeof(struct efi_device_path) + strlen(tmp) + 1;
>      > +     uridp = efi_alloc(uridp_len + sizeof(END));
>      > +     if (!uridp) {
>      > +             log_err("Out of memory\n");
>      > +             return NULL;
>      > +     }
>      > +     uridp->dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
>      > +     uridp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_URI;
>      > +     uridp->dp.length = uridp_len;
>      > +     debug("device path: setting uri device path to %s\n", tmp);
>      > +     memcpy(uridp->uri, tmp, strlen(tmp) + 1);
>      > +
>      > +     pos = (char *)uridp + uridp_len;
>      > +     memcpy(pos, &END, sizeof(END));
>      > +
>      > +     dp2 = efi_dp_concat(dp1, (const struct efi_device_path
>     *)uridp, 0);
>      > +
>      > +     efi_free_pool(uridp);
>      > +     efi_free_pool(dp1);
>      > +
>      > +     return dp2;
>      > +}
>      > +
>      >   /* Construct a device-path for memory-mapped image */
>      >   struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
>      >                                       uint64_t start_address,
> 

