Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B3DCDE025
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 16:56:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A720888D63;
	Thu, 26 Sep 2024 18:56:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="U1sI4kqE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7C4188C94; Thu, 26 Sep 2024 18:56:41 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CB6A889DA
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 18:56:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-6e232e260c2so8757057b3.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 09:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1727369798; x=1727974598;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eq5lMmNJ3UipQb961q6niTGgs6bT1KgmGIJX8vHg8ng=;
 b=U1sI4kqEQc4mwSzaW5gKpxSHNBuG1NwxhSRPsV8/4/JtSFyeZ21HsCKAWaAMiDGtPB
 pHLb88V0/8ed2y4q2jO8PkpbCGaXSPDm3IbUqxbmG1Qbu1/sy3QIgL12uf3whaVgpV7I
 lJECpFzyhi0EDysrr+6Z0Calz/X0BBwJ7Dwx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727369798; x=1727974598;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eq5lMmNJ3UipQb961q6niTGgs6bT1KgmGIJX8vHg8ng=;
 b=UlDsdJYxfv/Ru/PVcLbf2fDZcCjqUfT70m5505VqGrhxpnVUZ0lNH6s/CeGYdybcbM
 UHXHLB7UnZ5H5QczddngLxAUZ3xa9j4ZTZaCesh80Cd61C/3TYEwKa814kzoy2b5tzq/
 RAwF0nF642ZnSAdzRCsTvQyUaG30KH8sz1W9xE/xugYHr/zvl+1Mv87n4VsnOAQ5Eegv
 zhKXe3iCnQC+qDVoB1Ra42Jc9na5q8MQ2JwPX+c3Ab0gbg2ZdyJAKQ62E5+9rZOFf1Ul
 mP4NmetlYquM8JFb/KmUmrUyUDrXRO6Kunb7UWuIwxsF4FcpL2No/sDec6tGVHFoQpoR
 YAHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvKJhU7WVlTd86LdKAwNGcZ40FosGXMX/oKg3hQcpdIOLXt72IeC2wt3APGxtNDdgz4fy13TE=@lists.denx.de
X-Gm-Message-State: AOJu0YxaEWDizQ4N+9oJx7oBCTBTQNUgqxmsDFsVAplTF68DW17YEADX
 0Oxf7ojz6ZPurLgSzQeIBfCd8lhy76t9KaCdPlBvug/BIOiK7DQTgQAKwwYeVhjqs3AFC85VukK
 E6l16qyevTFflTzQjTpN7WnHFzdvLQXlPoP6X0w==
X-Google-Smtp-Source: AGHT+IFX2SuIRZ/w4IOLljhRgXARKoKOmuKSc/tXfbXbuNWsRDcjH1xvxa7w4rCIucWw6/MzdBIDtcD+dx8E9GkNl40=
X-Received: by 2002:a05:690c:3241:b0:6dd:b920:1cb5 with SMTP id
 00721157ae682-6e24758582fmr1334087b3.25.1727369798081; Thu, 26 Sep 2024
 09:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240825122617.3708982-1-dario.binacchi@amarulasolutions.com>
 <CANV2PTN_+9rZu0=XrNE+AUO3YRPCUjSHZy-Oe8WcXb_M-MiVTw@mail.gmail.com>
 <7a25850c-6082-4490-867b-126b480ba757@linaro.org>
 <20240826150146.GG2479150@bill-the-cat>
In-Reply-To: <20240826150146.GG2479150@bill-the-cat>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Thu, 26 Sep 2024 18:56:27 +0200
Message-ID: <CABGWkvo9NgtrgmeQw63i+4EdhCpAcJ+rVpbXQrSM9h8atXZf6Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] bootm: adjust the print format
To: Tom Rini <trini@konsulko.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de, 
 linux-amarula@amarulasolutions.com, Eddie James <eajames@linux.ibm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hello Tom,

On Mon, Aug 26, 2024 at 5:01=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Mon, Aug 26, 2024 at 02:26:10PM +0100, Caleb Connolly wrote:
> >
> >
> > On 25/08/2024 19:36, E Shattow wrote:
> > > On Sun, Aug 25, 2024 at 5:26=E2=80=AFAM Dario Binacchi
> > > <dario.binacchi@amarulasolutions.com> wrote:
> > > >
> > > > All three addresses printed are in hexadecimal format, but only the
> > > > first two have the "0x" prefix. The patch aligns the format of the
> > > > "end" address with the other two by adding the "0x" prefix.
> > > >
> > > > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > > > ---
> > > >
> > > >   boot/bootm.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/boot/bootm.c b/boot/bootm.c
> > > > index 480f8e6a0e6e..951e549f19ff 100644
> > > > --- a/boot/bootm.c
> > > > +++ b/boot/bootm.c
> > > > @@ -703,7 +703,7 @@ static int bootm_load_os(struct bootm_headers *=
images, int boot_progress)
> > > >
> > > >                  /* Handle BOOTM_STATE_LOADOS */
> > > >                  if (relocated_addr !=3D load) {
> > > > -                       printf("Moving Image from 0x%lx to 0x%lx, e=
nd=3D%lx\n",
> > > > +                       printf("Moving Image from 0x%lx to 0x%lx, e=
nd=3D0x%lx\n",
> > > >                                 load, relocated_addr,
> > > >                                 relocated_addr + image_size);
> > > >                          memmove((void *)relocated_addr, load_buf, =
image_size);
> > > > --
> > > > 2.43.0
> > > >
> > >
> > >  From U-Boot documentation, alpha-numeric input is assumed to be
> > > hexadecimal except when it is not, and generally does not accept "0x"
> > > prefix on input. So the correct action would be to make this
>
> While there was some point in history where I'm sure we got confused by
> "0x" input I don't think that's true anymore (and everything should be
> using some strto function that works as expected, not a custom parser).
> So the docs should be updated there.
>
> > > consistent over the whole U-Boot code base, or remove the "0x"
> > > prefixes (not add more of them) ?
> >
> > Most(?) U-Boot commands accept the 0x prefix. I don't think stripping i=
t is
> > sensible, I myself have gotten confused many times over hex values that=
 lack
> > the leading 0x in U-Boot output.
> >
> > Maybe unavailable in SPL (not sure) but I prefer the "%#lx" format whic=
h
> > prepends the 0x automatically.
>
> That we assume input is hex is just what it is these days. Output really
> ought to be prefixed with 0x because that's just common convention (and
> whatever we assumed people would Just Know 25+ years ago may not be true
> today). Since updating this output really shouldn't change our ABI, it's
> conceptually fine with me but we don't use "%#lx" a lot and so I don't
> know if tiny-printf handles it and so that might not be the right call
> for SPL code and so lets not change this patch.
>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> --
> Tom

Can this patch be merged?
I've seen both Review tags and conflicting opinions, and I haven't understo=
od
whether it can be accepted or not.

Thanks and regards,
Dario

--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
