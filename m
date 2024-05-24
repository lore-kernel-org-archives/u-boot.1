Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4279BC25B7A
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 12:23:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF4458861D;
	Fri, 24 May 2024 14:23:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qL1YTm4L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C19B88653; Fri, 24 May 2024 14:23:45 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFE3988552
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 14:23:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-68185f92bfdso553406a12.0
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 05:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716553421; x=1717158221; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J2EfccaKJgIjXintmdQgR4l/6tP9Ikuh8d/cW1jM1PM=;
 b=qL1YTm4LYIfqPywxpUAnFGNhfRa00yQIBlOojn6O/XxK4BsdPjw0aJ2h6SKAaYpFzu
 xvov8Rg0m4aWgnFuOCeBpClv+ACXOw6FJJcqJXDgWhJ+u100kuRjb7pDPlPXKOZht0BK
 IlRr1TqBeqxSGbce5b3+M+E9PzRd6f/2eaVxoP9mklIdeEWI9PqXEsB+oPJwgGaCxgro
 YHk+BbQ6Pf8jYPBSfnGPtwqss0PPQC7hbFSUlgaYo7+DOQhZDvm0DINARW6mKDC0/jEv
 H/rVWoe9E5cIAW0YaS/qyadYCd6rafyQHGsgiC9mJGAP71wey6SYOBoPU3Vb2qp5ynXF
 0o0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716553421; x=1717158221;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J2EfccaKJgIjXintmdQgR4l/6tP9Ikuh8d/cW1jM1PM=;
 b=UAeo1I1MKOIi70BYOMgRG8akrcYwLbHukKT6u5GXIxXo82Ua6/nhpgFv1rf++25JcV
 +XyIq+93QPsngla/4dogtshA9dv3pOvUhQx8x/l0pnQM33bW+Vr6kBq0vuFy+eSIMmNC
 WRQXsQ+tMcZ8W1W30TyuMteb45rVbNEzFoDHzBCVm9axhFijbh1hP/2oYOqiKAVXJ4yA
 yxYXk6vkMSPh31QyQlb5cySfDVa3TfjXm4nq0LbA6Dnr7qRNLHeXAhn7/xhiMMdAS4tQ
 +dHdn5w7Hk6kb95H1u/uQ5MkOXs7+NodGbBcs+ueCtWs1eV1XPOcO+CxuMckCX3eTgGK
 BZwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPeupElCZEwCJ7jWZTchlyzJgypHFBw8q5UUVoUS4DFrC7WqI0rB8C3nhNK+5udo4tgQbCcBerHykzfCjb70OhjeThFQ==
X-Gm-Message-State: AOJu0YxI6a7pmhi2ep1mh1dLwO4ltmq1DOwg4fumRfPkXkcFQjFVEn0y
 fE0PPMemtYRUdX/pUYGDN8Zp0UMS0Vpajrwk4KA+4q30KDzqxmDwDxZY1j8Be6V12vAiyU6vXt0
 zQdLI7244Z/LRJ9NZ2Z88gBYTrQhIKOhtIgM5UA==
X-Google-Smtp-Source: AGHT+IExILH1Ir7u0SpjFlM1vQjo/cYIHWYUsc/Lq2uNaaPDvbbCBiJO1/HwY7zrIyMl2jwhTlCdEyUyb2mkA/qmUuA=
X-Received: by 2002:a17:90a:bc85:b0:2b2:6ede:5ce0 with SMTP id
 98e67ed59e1d1-2bf5f70f2d7mr1856591a91.39.1716553421360; Fri, 24 May 2024
 05:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240426-b4-dynamic-uuid-v1-0-e8154e00ec44@linaro.org>
 <20240426-b4-dynamic-uuid-v1-1-e8154e00ec44@linaro.org>
 <CAC_iWj+WsO_dx84UHpv02b9cxNtzHYeCjZLP5VyVw9AbXet-yg@mail.gmail.com>
 <6f354bbf-3062-4a2d-b0a5-b8559fbfe26a@linaro.org>
In-Reply-To: <6f354bbf-3062-4a2d-b0a5-b8559fbfe26a@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 24 May 2024 15:23:05 +0300
Message-ID: <CAC_iWjLR5Bg8qh6Q402oe1YXfW6-z4VsO0UFYFyWrrOjRXnOAg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] lib: uuid: add UUID v5 support
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de
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

On Fri, 24 May 2024 at 15:20, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
>
>
> On 24/05/2024 08:01, Ilias Apalodimas wrote:
> > [...]
> >
> >>   #include <dm/uclass.h>
> >>   #include <rng.h>
> >> +#include <u-boot/sha1.h>
> >>
> >>   int uuid_str_valid(const char *uuid)
> >>   {
> >>          int i, valid;
> >> @@ -368,8 +369,40 @@ void uuid_bin_to_str(const unsigned char *uuid_bin, char *uuid_str,
> >>                  }
> >>          }
> >>   }
> >>
> >> +#if CONFIG_IS_ENABLED(UUID_GEN_V5)
> >> +void gen_uuid_v5(struct uuid *namespace, struct uuid *uuid, ...)
> >> +{
> >> +       sha1_context ctx;
> >> +       va_list args;
> >> +       const u8 *data;
> >> +       u8 hash[SHA1_SUM_LEN];
> >> +
> >> +       sha1_starts(&ctx);
> >> +       /* Hash the namespace UUID as salt */
> >> +       sha1_update(&ctx, (char *)namespace, UUID_BIN_LEN);
> >> +       va_start(args, uuid);
> >
> > Should we use sha1 here? Is it described somewhere in UUIDv5 requirements?
> > If not I'd rather have a sha256
>
> The spec says sha1 yeah, this doesn't need to be cryptographically
> secure (the inputs are generally known) but just not have collisions.
>
> That said, we don't need to be spec compliant - just consistent. So I'm
> fine either way. I'd err on the side of what's fastest to compute (if
> that even matters here).

Ok, that's fine, we can stick to the spec

Cheers
/Ilias
> >
> >> +
> >> +       while ((data = va_arg(args, const u8 *)))
> >> +               sha1_update(&ctx, (char *)data, va_arg(args, int));
> >
> > sha1_update second argument is an unsigned int
>
> Ah thanks.
> >
> >> +
> >> +       va_end(args);
> >> +       sha1_finish(&ctx, hash);
> >> +
> >> +       /* Truncate the hash into output UUID and convert it to big endian */
> >> +       cpu_to_be32_array((u32 *)uuid, (u32 *)hash, 4);
> >> +
> >> +       /* Configure variant/version bits */
> >> +       clrsetbits_be16(&uuid->time_hi_and_version,
> >> +                       UUID_VERSION_MASK,
> >> +                       5 << UUID_VERSION_SHIFT);
> >> +       clrsetbits_8(&uuid->clock_seq_hi_and_reserved,
> >> +                    UUID_VARIANT_MASK,
> >> +                    UUID_VARIANT << UUID_VARIANT_SHIFT);
> >> +}
> >> +#endif
> >> +
> >>   #if defined(CONFIG_RANDOM_UUID) || defined(CONFIG_CMD_UUID)
> >>   void gen_rand_uuid(unsigned char *uuid_bin)
> >>   {
> >>          u32 ptr[4];
> >>
> >> --
> >> 2.44.0
> >>
> >
> > Thanks
> > /Ilias
>
> --
> // Caleb (they/them)
