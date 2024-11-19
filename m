Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336EFD62072
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 10:35:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4C6389559;
	Tue, 19 Nov 2024 11:35:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wbVz8yik";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF6EC8955F; Tue, 19 Nov 2024 11:35:03 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81C8289557
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 11:34:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2ea379ef02fso548163a91.3
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 02:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732012495; x=1732617295; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hHY+WgbJ9XgveL9feZmU5kszyeFbKpJQrtWYY5EVrlI=;
 b=wbVz8yikj76Aqb2YWO0/TWBkz9VYePZ16HSypDhbCIlj7xKJEwx5HAG3d5EfblROX6
 kF9CIA+UhQTbn1M/djZcN5SQPkcg9xzp1UY3YIqgm+LNveMhUJyIiLjM98koawNFe57D
 O924xSQzhhLuXvCQFrs6ehe2FD//SOwFekn2BTaCoQQSpid9EENo+ri3iX0tI6vaVEyx
 SGA0eBf1XzgIYw5ORwbv4WK/jLfl1MUBC5KGuvJ4y3v3SaW7x4v416N8bgnZdLbXvZmI
 C7TZ+Jal8cbOI+rIvHKeazzC6yo6upcjffKxYTZGueaYdQu7oAslAmfxdw/uP8hG20C6
 uHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732012495; x=1732617295;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hHY+WgbJ9XgveL9feZmU5kszyeFbKpJQrtWYY5EVrlI=;
 b=PR1d56/Bt2Mna4VgE2BohgL7ak9VqY4vU4eftO0Ff5iKLPCfleR5b6U0dvjiD5C1QY
 C6W4shLnsN3N3uewzkWl5UzjVYTlaf4HZZSKhVkG7X/VP9zqYQ2Dp6cai5F9fciawaWB
 cU6CxG6fAVTOAMETo3wxuztxPZZIryVLlfZSr5PnZPbwuZxLfWge/x3CDdd9Cyizc7NI
 +8Dy7W04bZ39SnwtbekLp9GfXZo8W5ZuopoFnwDVr+cBmHQBpxjNmlmaTnMAxTCOY9p1
 MD5It5u93gexnbJec1RudHrigttAXOCxsMJC0p5o/xYS95uEYr5PpzWJRaQbKmG8Ud29
 RIkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZv05/HtUkWy9KiI3Eb6H9h6Hh5j2M3L9t7os/BLX+DVZ/RffLdIbmSYiGZOMmOpvKwa3/5xg=@lists.denx.de
X-Gm-Message-State: AOJu0YwoJDLczpu2A4VpYAxZ6PQgeyYecwgD/4LPe1hdHDQKT5HjsH5L
 sBty9goR5YTJcoJL0jLpaC9/dTzRQG1hQDDiJIE5eDoZrGKG0xuvlJ3bqtkH6pv4lurRCoGUfCK
 t6HU7yq17fIV2f0jLASm8vI2eplTItl99LkKsFg==
X-Google-Smtp-Source: AGHT+IHJ7INMDtNovumSGMLUgThemKqfteLdqbDHY2k4pasSHcb0JX0mVSqMRv4FGIdlutXCvXTj2aVGJXTmIiWvqhU=
X-Received: by 2002:a17:90b:5108:b0:2ea:8aac:6ab6 with SMTP id
 98e67ed59e1d1-2ea8aac6c28mr6219116a91.4.1732012495054; Tue, 19 Nov 2024
 02:34:55 -0800 (PST)
MIME-Version: 1.0
References: <20241118210908.51196-1-adrianox@gmail.com>
 <20241118210908.51196-4-adrianox@gmail.com>
 <eed3b936-a54d-4881-8f2e-534bcef34535@canonical.com>
In-Reply-To: <eed3b936-a54d-4881-8f2e-534bcef34535@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 19 Nov 2024 12:34:19 +0200
Message-ID: <CAC_iWjKYyZq5DCMdaZoa8K9ySLYwqxjWaySepep6hamLdVBK9A@mail.gmail.com>
Subject: Re: [PATCH v4 03/14] efi_loader: device_path: add efi_dp_from_ipv4
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Adriano Cordova <adrianox@gmail.com>, joe.hershberger@ni.com,
 rfried.dev@gmail.com, jerome.forissier@linaro.org, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 19 Nov 2024 at 11:50, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 18.11.24 22:08, Adriano Cordova wrote:
> > Add efi_dp_from_ipv4 to form a device path from an ipv4 address.
> >
> > Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> > ---
> >
> > Changes in v4:
> > - Fixed memcpy mistake
> >
> > Changes in v3:
> > - Removed some unnecessary void* casts.
> > - Changed sizeof(struct efi_device_path_ipv4) to sizeof(*ipv4dp)
> >    in efi_dp_from_ipv4.
> >
> >   lib/efi_loader/efi_device_path.c | 38 ++++++++++++++++++++++++++++++++
> >   1 file changed, 38 insertions(+)
> >
> > diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
> > index ee387e1dfd..cdeea4791f 100644
> > --- a/lib/efi_loader/efi_device_path.c
> > +++ b/lib/efi_loader/efi_device_path.c
> > @@ -974,6 +974,44 @@ struct efi_device_path __maybe_unused *efi_dp_from_eth(void)
> >       return start;
> >   }
> >
>
> A function description is missing.
>
> > +struct efi_device_path *efi_dp_from_ipv4(struct efi_ipv4_address *ip,
> > +                                      struct efi_ipv4_address *mask,
> > +                                      struct efi_ipv4_address *srv)
> > +{
> > +     struct efi_device_path *dp1, *dp2;
> > +     efi_uintn_t ipv4dp_len;
> > +     struct efi_device_path_ipv4 *ipv4dp;
> > +     char *pos;
> > +
> > +     ipv4dp_len = sizeof(*ipv4dp);
> > +     ipv4dp = efi_alloc(ipv4dp_len + sizeof(END));
>
> ipv4dp is a small structure and is freed below.
> Allocating it on the stack would reduce the code size.
>
> > +     if (!ipv4dp) {
> > +             log_err("Out of memory\n");
>
> Writing messages inside a protocol implementation should be avoided.
>
> > +             return NULL;
> > +     }
> > +
> > +     ipv4dp->dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
> > +     ipv4dp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_IPV4;
> > +     ipv4dp->dp.length = ipv4dp_len;
> > +     ipv4dp->protocol = 6;
> > +     if (ip)
> > +             memcpy(&ipv4dp->local_ip_address, ip, sizeof(*ip));
> > +     if (mask)
> > +             memcpy(&ipv4dp->subnet_mask, mask, sizeof(*mask));
> > +     if (srv)
> > +             memcpy(&ipv4dp->remote_ip_address, srv, sizeof(*srv));
> > +     pos = (void *)(uintptr_t)ipv4dp + ipv4dp_len;
>
> Here you
>
> 1 - convert ipv4dp to uintptr_t
> 2 - convert the uintptr_t value to void *
> 3 - add an offset to the void * value
>
> In the C standard adding an offset to a void * value results in
> undefined behavior. Unfortunately U-Boot code uses it a lot.

It's a known support gcc extension that treats void* similar to char*.
Do you think it's worth changing all of the callsites we have?


Thanks
/Ilias
>
> pos = (char *)ipv4dp + ipv4dp_len;
>
> is all it takes to have a defined behavior here.
>
> Best regards
>
> Heinrich
>
> > +     memcpy(pos, &END, sizeof(END));
> > +
> > +     dp1 = efi_dp_from_eth();
> > +     dp2 = efi_dp_concat(dp1, (const struct efi_device_path *)ipv4dp, 0);
> > +
> > +     efi_free_pool(ipv4dp);
> > +     efi_free_pool(dp1);
> > +
> > +     return dp2;
> > +}
> > +
> >   /* Construct a device-path for memory-mapped image */
> >   struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
> >                                       uint64_t start_address,
>
