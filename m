Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C2ACC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 17:01:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AB1C849D2;
	Wed,  8 Jul 2026 19:01:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PVvAR5ZI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BB23849F0; Wed,  8 Jul 2026 19:01:02 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB6B78496E
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 19:00:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-489795617e9so517659b6e.0
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 10:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783530058; x=1784134858; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qUChe9jiKtCQ3qDkVPzqDzwYva12jOcANi4qawVKa2E=;
 b=PVvAR5ZI8+AwG6XgpNiGjA43BohJtHDa6CHCwep7Ah04bVUdpIysXiVZFYLTcqIK0I
 gotCLt3srx1XEuskEKd+FdSCdou16Oto1dlN3Fng1yn46mGsoucBBFaiLmtzwE54yPL+
 kAmjtPqy2tdcNDFFte4D46ZZi4S7ae32wnI0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783530058; x=1784134858;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qUChe9jiKtCQ3qDkVPzqDzwYva12jOcANi4qawVKa2E=;
 b=TlcfVmCISVc2qghkAM7bJQGiF1P4Tjpld7x/pX9yiXEjHfZPShpq6clISzwoYWyXE0
 nYDIduqTVEiTcz42fnOXg0j4n121IWOUx07jq5gRSdFz5yfHp+qhE77dMYsgYu+BgZYw
 4Ml7nrAojYnFS6npEIOZFYgRxBdUrX4TjHXwkBp+fx65QdgRKvy97l3Xo1sCKgJOPggJ
 6JYqs1fTaXdB5fxaJOjKSoOUS13edhX9a31E1dZmTJfjxaoq+BNTLDISb2t2GeNQP521
 unmbNk+kEE0tP38gmWGvsbfv/88FORbBN34Fq5CI3DmG8m6sWEJH4/GW/1J4DWmJhwMc
 4f5g==
X-Gm-Message-State: AOJu0YwTojL9WYjDDMcIuvXZB3o0UX7R9UfUddTlpSuF5QDSrfwQF2II
 6Arx3Mc3nrDOutX0+qAoWzblqfSxa5DGfKzCrJwtTeKb3IENgZx/eU4MJhcJLoDkbpI=
X-Gm-Gg: AfdE7ckU86EpFQujU164R0F8FwZcHo0nkbAw8LUFyAEO3zULRxxPepv3vXuQqEP3TQD
 gVwXxzghf3ejUjBtrgF4b6h0SkR9G0K8BrpMcTRjqj25JnCF9mlofdzaRayrxQ6FYOD06wNRKQu
 vpSnSkcI0oF5YCQ2s2XPtGjoBEeQ5OHE+vc8GMPhDmm0cXmC5J9OeIgmVI6adupBXaV+Oe8DsyV
 irE9gW67CJmiuUUdMf5rng8JNbAd8snIS9WdFBeHTQM+S4+1rXFNm3v+phWUWTb/1VNwc1V/1B4
 T04XUaAlo0RWSebyY+2Y39w5PSc0WzvN9j3fHHGuw3FkklNZ/mtO6iAJprZolCbZeKCdjj0hxNH
 PEaD6REuOPutQ3tDCQiqNUwCngp1APNQUIK4OUIqBvZP5P9LRSqKaAJ65UvLSROE/OtwiG49Xbi
 PIMZwFaP26rBcvGZT54ptuqYxBmEZkPqaBBWm+w/lbLRof4cVT+Fqb2+tcUm1zBtnZbhsstHIW5
 Kxn5kg3O2r22KvJ3RriHgFpi6qJ2OpU18jijQ==
X-Received: by 2002:a05:6808:c3cb:b0:486:45c7:34c5 with SMTP id
 5614622812f47-4a20262ad2amr2460155b6e.17.1783530058342; 
 Wed, 08 Jul 2026 10:00:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1ad4ac92csm2150187b6e.5.2026.07.08.10.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 10:00:57 -0700 (PDT)
Date: Wed, 8 Jul 2026 11:00:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymondmaoca@gmail.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 1/7] lib/fdtdec.c: Disallow overriding the fdt address
 with mandatory passage
Message-ID: <20260708170055.GW749385@bill-the-cat>
References: <20260708013019.288985-1-trini@konsulko.com>
 <20260708013019.288985-2-trini@konsulko.com>
 <CAMDkj5xfkpW4eRi-ZMC-SNG8-af5gr96Jv0-Jj4QwFNH5jwp7w@mail.gmail.com>
 <20260708163204.GV749385@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7yX3/Ak7itUb++X/"
Content-Disposition: inline
In-Reply-To: <20260708163204.GV749385@bill-the-cat>
X-Clacks-Overhead: GNU Terry Pratchett
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


--7yX3/Ak7itUb++X/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026 at 10:32:04AM -0600, Tom Rini wrote:
> On Wed, Jul 08, 2026 at 12:26:04PM -0400, Raymond Mao wrote:
> > Hi Tom,
> >=20
> > On Tue, Jul 7, 2026 at 9:30=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
> > >
> > > When we have CONFIG_BLOBLIST_PASSAGE_MANDATORY don't allow the device
> > > tree address to be overridden. The device tree we're given is the one
> > > that must be used.
> > >
> >=20
> > The commit message does not explicitly mention this is only for
> > OF_BOARD. So I think we need to add
> > "!IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY)" to the next check as
> > well:
> >=20
> >          /* Allow the early environment to override the fdt address */
> >  -       if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
> >  +       if (!IS_ENABLED(CONFIG_XPL_BUILD) &&
> >  +           !IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY)) {
> >                  ulong addr;
> >=20
> > Or, state in the commit message that it is for OF_BOARD only.
> >=20
> > Regards,
> > Raymond
> >=20
> >=20
> > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > ---
> > > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > Cc: Raymond Mao <raymondmaoca@gmail.com>
> > > ---
> > >  lib/fdtdec.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> > > index b91e067106dd..ecb22a58b964 100644
> > > --- a/lib/fdtdec.c
> > > +++ b/lib/fdtdec.c
> > > @@ -1856,7 +1856,8 @@ int fdtdec_setup(void)
> > >         }
> > >
> > >         /* Allow the board to override the fdt address. */
> > > -       if (IS_ENABLED(CONFIG_OF_BOARD)) {
> > > +       if (IS_ENABLED(CONFIG_OF_BOARD) &&
> > > +           !IS_ENABLED(CONFIG_BLOBLIST_PASSAGE_MANDATORY)) {
> > >                 void *blob;
> > >
> > >                 blob =3D (void *)gd->fdt_blob;
>=20
> I might have to jump back to what the code looked like in January or so,
> to figure this out again. We never set OF_BOARD and
> BLOBLIST_PASSAGE_MANDATORY so this change here never matters. It might
> have been because I was doing this on top of the (now merged) rework of
> bloblist_init and bloblist_maybe_init. I'll look harder at this and post
> a v2, thanks!

I see now why I did this, and because vexpress64_fvp_bloblist fails to
build because it does enable OF_BOARD. So, there's two distinct problems
here. One of which is that CONFIG_BLOBLIST_PASSAGE_MANDATORY can be,
well, not mandatory in a few cases, and that's not intentional. With
that fixed, we can then do what the rest of this series does, and fix
OF_OMIT_DTB behavior. And then patch #2 that cleans up vexpress64 is
also standalone.

--=20
Tom

--7yX3/Ak7itUb++X/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak6CQwAKCRAr4qD1Cr/k
Co1DAQCwRSMgxzcUTOO5MNtv1qQ7Wa7qiz3sNay3yj6Wvn8LMwD9Fla29Dn9oTkY
aLEg6NcDqbBU5ui3Ov3MgrFMlSGJ0ww=
=brck
-----END PGP SIGNATURE-----

--7yX3/Ak7itUb++X/--
