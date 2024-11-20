Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03208D711B1
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 15:22:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC403891F5;
	Wed, 20 Nov 2024 16:22:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="pDAlwkBH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1B5C88E63; Wed, 20 Nov 2024 16:22:18 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88D4788E63
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 16:22:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DB6F63F370
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 15:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732116135;
 bh=SMFuaK67JMWqeyWdHzCiG4z0gy6PBqj6R/xZtp4S9Ms=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=pDAlwkBH74kvQ9PgkVQag9y00UkPLnx+ZU1OSNIiJAfe4ELiFhcJb4oIAICNfDqI9
 ZRc1mlh3m0J2WHaDQKiK+w4Jcr6YHF0gD7UUVgtUnd3JUXfH3xDdr9155NOsrO49p8
 zYxChM7HPoxBnv5BVAFPrVdzuF9FwtISqVhOnLXxaWXfS1T0mqy4TmKQtOtB3YUpyG
 nbrSLGY0GMMdgKbg0QTUg6PdDinAVw4nkjtv7ylPflmyYw3egZx8KRH0/vBeR3p8F2
 EkEBLXd4ZL9qNNLRzDgBObbyhJY1QZ/fp6HBVlRaBTh7eRjdFSceg4ioNW66Ft5SXb
 kiz2ZYo/SQ4ZQ==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43154a0886bso32152565e9.0
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 07:22:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732116135; x=1732720935;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SMFuaK67JMWqeyWdHzCiG4z0gy6PBqj6R/xZtp4S9Ms=;
 b=lMDgJl5KX9AouVWd5NINiOWUYutCARL1LWkKxHvUusIDljtXxLLIUTUp7f3bHqrzSy
 hEinrO/7Mgf0UUvBCdmRxbT4/S02j1slYi9yJi43QGXVtYcv/jA3/j7jl6rD4fAN6xaH
 JdDUjg3r3ytKn2vQk6Mxa1O5VQw6GMB9slfDUQsLZhM1J4PXi60UxvUWMBNeWFE5xuGT
 b6/cVJXcsThiXN/82TdTPs9R27Xuc6cz/hGkLtjlROCV1Yty+eR+Do8uVRebUaC36qA0
 J7xED9SvmEGG9jMLwsmPvGtfeGLOT84PpectiNKkR8Vft3MDQz8yWzQN6OQgn0zrxJK8
 s+8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1IPOdq1fBXMcdeUMPNOzLkeEwcgaujAoU52bLKra1zYvxwTup/zZP5KNLNtmq/tXvsNxUnGw=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1JKDgrs6gDeXXjBxEKJZI5mfIRbeCmQHUKDx64/+SZdrY/DGm
 hkvFPjY3ndHOWNB5IrOCdEWfPws8U/Mdz/ij3B2I/0pUUp2GZlBH7s/zwlH8dLmUH0Iadm/eNZR
 BVpYMkqH0G/4w8frOjfgQhr/dbDjoRskuwrw3trgxsMymom6rNxcKc7UlN08qJ7C0JyI=
X-Received: by 2002:a05:600c:870f:b0:42d:a024:d6bb with SMTP id
 5b1f17b1804b1-4334f0213d3mr25021015e9.20.1732116135233; 
 Wed, 20 Nov 2024 07:22:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8wHHp2BPEk4zLioZQug5nr8Wn1gBPgmrejbecvuhJ0yN7hoqqTOlPtd3NXFDdXyuwqqElLg==
X-Received: by 2002:a05:600c:870f:b0:42d:a024:d6bb with SMTP id
 5b1f17b1804b1-4334f0213d3mr25020785e9.20.1732116134893; 
 Wed, 20 Nov 2024 07:22:14 -0800 (PST)
Received: from [192.168.103.101]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432f643b299sm38580155e9.0.2024.11.20.07.22.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2024 07:22:13 -0800 (PST)
Message-ID: <413fa162-4748-4426-a50c-b41de7d75bf9@canonical.com>
Date: Wed, 20 Nov 2024 16:22:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/14] efi_loader: device_path: add efi_dp_from_ipv4
To: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de
References: <20241118210908.51196-1-adrianox@gmail.com>
 <20241118210908.51196-4-adrianox@gmail.com>
 <eed3b936-a54d-4881-8f2e-534bcef34535@canonical.com>
 <CAMGU2hX1WtZ4xzMUiMCcGGDm2Kjzx-OPOJs=bmqngHkBZci1cA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAMGU2hX1WtZ4xzMUiMCcGGDm2Kjzx-OPOJs=bmqngHkBZci1cA@mail.gmail.com>
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

On 20.11.24 15:55, Adriano Córdova wrote:
> 
> 
> El mar, 19 nov 2024 a las 6:50, Heinrich Schuchardt 
> (<heinrich.schuchardt@canonical.com 
> <mailto:heinrich.schuchardt@canonical.com>>) escribió:
> 
>     On 18.11.24 22:08, Adriano Cordova wrote:
>      > Add efi_dp_from_ipv4 to form a device path from an ipv4 address.
>      >
>      > Signed-off-by: Adriano Cordova <adrianox@gmail.com
>     <mailto:adrianox@gmail.com>>
>      > ---
>      >
>      > Changes in v4:
>      > - Fixed memcpy mistake
>      >
>      > Changes in v3:
>      > - Removed some unnecessary void* casts.
>      > - Changed sizeof(struct efi_device_path_ipv4) to sizeof(*ipv4dp)
>      >    in efi_dp_from_ipv4.
>      >
>      >   lib/efi_loader/efi_device_path.c | 38 +++++++++++++++++++++++++
>     +++++++
>      >   1 file changed, 38 insertions(+)
>      >
>      > diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/
>     efi_device_path.c
>      > index ee387e1dfd..cdeea4791f 100644
>      > --- a/lib/efi_loader/efi_device_path.c
>      > +++ b/lib/efi_loader/efi_device_path.c
>      > @@ -974,6 +974,44 @@ struct efi_device_path __maybe_unused
>     *efi_dp_from_eth(void)
>      >       return start;
>      >   }
>      >
> 
>     A function description is missing.
> 
>      > +struct efi_device_path *efi_dp_from_ipv4(struct efi_ipv4_address
>     *ip,
>      > +                                      struct efi_ipv4_address *mask,
>      > +                                      struct efi_ipv4_address *srv)
>      > +{
>      > +     struct efi_device_path *dp1, *dp2;
>      > +     efi_uintn_t ipv4dp_len;
>      > +     struct efi_device_path_ipv4 *ipv4dp;
>      > +     char *pos;
>      > +
>      > +     ipv4dp_len = sizeof(*ipv4dp);
>      > +     ipv4dp = efi_alloc(ipv4dp_len + sizeof(END));
> 
>     ipv4dp is a small structure and is freed below.
>     Allocating it on the stack would reduce the code size.
> 
> 
> But as it is a device path it has to be allocated contiguously to the END
> node, see the next lines. It is then passed to efi_dp_concat where this is
> important.

struct {
	struct efi_device_path_ipv4 ipv4dp;
	struct efi_device_path end;
} dp;

should give you a variable of adequate size.

Best regards

Heinrich

> 
> 
>      > +     if (!ipv4dp) {
>      > +             log_err("Out of memory\n");
> 
>     Writing messages inside a protocol implementation should be avoided.
> 
>      > +             return NULL;
>      > +     }
>      > +
>      > +     ipv4dp->dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
>      > +     ipv4dp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_IPV4;
>      > +     ipv4dp->dp.length = ipv4dp_len;
>      > +     ipv4dp->protocol = 6;
>      > +     if (ip)
>      > +             memcpy(&ipv4dp->local_ip_address, ip, sizeof(*ip));
>      > +     if (mask)
>      > +             memcpy(&ipv4dp->subnet_mask, mask, sizeof(*mask));
>      > +     if (srv)
>      > +             memcpy(&ipv4dp->remote_ip_address, srv, sizeof(*srv));
>      > +     pos = (void *)(uintptr_t)ipv4dp + ipv4dp_len;
> 
>     Here you
> 
>     1 - convert ipv4dp to uintptr_t
>     2 - convert the uintptr_t value to void *
>     3 - add an offset to the void * value
> 
>     In the C standard adding an offset to a void * value results in
>     undefined behavior. Unfortunately U-Boot code uses it a lot.
> 
>     pos = (char *)ipv4dp + ipv4dp_len;
> 
>     is all it takes to have a defined behavior here.
> 
>     Best regards
> 
>     Heinrich
> 
> 
> It was originally a char *, I will change it back
> 
>      > +     memcpy(pos, &END, sizeof(END));
>      > +
>      > +     dp1 = efi_dp_from_eth();
>      > +     dp2 = efi_dp_concat(dp1, (const struct efi_device_path
>     *)ipv4dp, 0);
>      > +
>      > +     efi_free_pool(ipv4dp);
>      > +     efi_free_pool(dp1);
>      > +
>      > +     return dp2;
>      > +}
>      > +
>      >   /* Construct a device-path for memory-mapped image */
>      >   struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
>      >                                       uint64_t start_address,
> 
> 
> Best,
> Adriano

