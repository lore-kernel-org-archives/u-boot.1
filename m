Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB92C021AA
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 07:21:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD0ED801DE;
	Fri, 21 Feb 2025 08:21:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f1N9F9sg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FC4F807C4; Fri, 21 Feb 2025 08:21:33 +0100 (CET)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 643378007D
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 08:21:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-86715793b1fso486110241.0
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 23:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740122490; x=1740727290; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YA/uPzQdGmH7uSZD90AqZEns7CX9xpAxirl/T5O0X2Q=;
 b=f1N9F9sg3+S0KgIah8ZPru0qIxTZzS76FB4HPHsOyaVSiZN3uouy5hPJ29CGuupPpg
 Hn+jVyWDMr6X8qABY0E2Pk0HN4Xv2S94f5iA0SjH2XXm/cT65hx/9WKQtVxuqEHcNYz+
 G+K2qb13aQkOnomy4In+i8YhXKSsXVQPPDt5caxob5at676Qvb0xCGg/9bReRiP9SSyb
 dxrmbSjuIbwO9hbae+nklgvU9RBpGgZdJ/kpnLAiLvjtA3IUbSp2OkQXO3Yu+SC2AGsL
 YWf8gKH4dZ48wVbmaVKPpC1cfPGgDOAq3hBakRHBuEqbYm1evspjQCcq5kYH5xVAtycY
 rZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740122490; x=1740727290;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YA/uPzQdGmH7uSZD90AqZEns7CX9xpAxirl/T5O0X2Q=;
 b=L//7WlL5nG6eY82pDHVGEy8bng+nvhOlGbDqKD8pu2AMm1Ib3Td0W8/C2d4YIBXVsH
 tdv0yypvuMCXYmHLRuDVLkCGTC+5u9tG2qKH4pBgWFB7E6oPBDQlgxjtkXfWPiWZVZG+
 Flsc88MT3GLPU6lccRDWE/kPsvhJP4vqh0D0DmgVnr51A6wzTT3ty3XkCi60ezD+y9Wc
 CAB4/L3wx/icdGInR8rXKPMFxAi+zhC1R05IDk1gQBxNTezu6cmM4E07tvKikF1LX0eH
 8rnDb8ZvFOQcKXVD/9XkMABbFKNtInWSt9vo35StTyBA/EOeWAZd39X+VgdcC8w+1V0+
 Q8Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6kSlKrtPAsCAc8JA9WBIaC3kK32MmMSnRICUIk8SeOArimZug7sUz+ganjKgPUIkkubzzr/Y=@lists.denx.de
X-Gm-Message-State: AOJu0YzOvVQw6CYqgRqW2Jh/47pdj84B9pvSX2TbwCKmObVGUD8pzbzP
 2h0HBRRw2dhdJJtQ17rTnsiKs1Ju5dt6+nSBM8pJdk7QG2zXOZj2a8SQxOIJctm986eUGE/dpG3
 VX0+l+Skejqc/TCnREowEBQGTVJhWZbvLoNZa1A==
X-Gm-Gg: ASbGncsSaCavhjJV8+z693jK7Xko7tr2OZlaqZwnR1Nk8cQrSi8eFwi2YjfgeTtTzZ1
 BMAx2lpnWSPsDtPlf1YSYJBCJwXjgADpkZMeMVn62naGPbsTRxo3FqENqs1URtcF+BRiAh2HDrq
 aCQiiEDa1n
X-Google-Smtp-Source: AGHT+IGFl7yakj0N2QT6LoK8G2qKdQ4qQ6UD96r/QW6rWKuP0AaAFBtU9Kguj+hLbcM/kq4XztzbUocGJJUZr7u9+oc=
X-Received: by 2002:a05:6102:390a:b0:4bb:c76d:39ec with SMTP id
 ada2fe7eead31-4bfc028681amr1209387137.21.1740122490313; Thu, 20 Feb 2025
 23:21:30 -0800 (PST)
MIME-Version: 1.0
References: <20250220095654.121634-1-sughosh.ganu@linaro.org>
 <20250220095654.121634-7-sughosh.ganu@linaro.org>
 <654e629d-5e64-42ef-820e-ef86babc60d3@canonical.com>
In-Reply-To: <654e629d-5e64-42ef-820e-ef86babc60d3@canonical.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 21 Feb 2025 12:51:19 +0530
X-Gm-Features: AWEUYZnJxpz2raTUpm4w-u8I55MLJkG1l6LzM7uLH16b5QIkQXDDSe6igozSMgE
Message-ID: <CADg8p95h3sDAfYmbeEcDDPnsHr8wCUbEtH-fC62prqReUwvhtA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] lmb: optimise the lmb allocation functions
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Udit Kumar <u-kumar1@ti.com>, u-boot@lists.denx.de
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

On Thu, 20 Feb 2025 at 16:20, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 20.02.25 10:56, Sughosh Ganu wrote:
> > The actual logic to allocate a region of memory is in the
> > _lmb_alloc_base() function. The lmb_alloc() API function calls
> > lmb_alloc_base(), which then calls _lmb_alloc_base() to do the
> > allocation. Instead, call the _lmb_alloc_base() directly from both the
> > allocation API's, and move the error message to the _lmb_alloc_base().
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V1: New patch
> >
> >   lib/lmb.c | 16 ++++++----------
> >   1 file changed, 6 insertions(+), 10 deletions(-)
> >
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index 874063fc1f5..6bfc0dbc9ce 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -758,26 +758,22 @@ static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
> >                       base = ALIGN_DOWN(res_base - size, align);
> >               }
> >       }
> > +
> > +     log_err("Failed to allocate 0x%lx bytes below 0x%lx\n", (ulong)size,
> > +             (ulong)max_addr);
>
> Printing such a line is not expected in an EFI application. It would
> mess up the output of menus in EFI applications like GRUB.
>
> I think this line should be debug output.

Okay, I will change it to a log_debug(). Since this was getting
printed in the current code, I thought of simply moving it to a more
apt place.

-sughosh

>
> Best regards
>
> Heinrich
>
> > +
> >       return 0;
> >   }
> >
> >   phys_addr_t lmb_alloc(phys_size_t size, ulong align)
> >   {
> > -     return lmb_alloc_base(size, align, LMB_ALLOC_ANYWHERE, LMB_NONE);
> > +     return _lmb_alloc_base(size, align, LMB_ALLOC_ANYWHERE, LMB_NONE);
> >   }
> >
> >   phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr,
> >                          uint flags)
> >   {
> > -     phys_addr_t alloc;
> > -
> > -     alloc = _lmb_alloc_base(size, align, max_addr, flags);
> > -
> > -     if (alloc == 0)
> > -             printf("ERROR: Failed to allocate 0x%lx bytes below 0x%lx.\n",
> > -                    (ulong)size, (ulong)max_addr);
> > -
> > -     return alloc;
> > +     return _lmb_alloc_base(size, align, max_addr, flags);
> >   }
> >
> >   phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags)
>
