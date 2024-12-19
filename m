Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490F6E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 16:36:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92CD180196;
	Thu, 19 Dec 2024 17:36:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G59tF2M5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07E368021A; Thu, 19 Dec 2024 17:36:13 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D32C8007D
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 17:36:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b6ed0de64aso87696785a.0
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 08:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734626169; x=1735230969; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gU4vDSN+e58JigYoRz2Rbqy7tn7I97w44EBh2hPgLqY=;
 b=G59tF2M5NgC7iVtr1/MX0tqrunA1XnE7Yxx/mr/IczTuG3RFURWPmGNMLM5YswwamE
 ZPt5sGkOVBNkeeYCCr78gpzolT2L6s5xn4ASA2nCG4u/xZ6VUTfyoM0E6zP4RtwVG9L1
 p/Ioxi+XwEXYBLNtc09KVGqZEzwUmINOLTa+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734626169; x=1735230969;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gU4vDSN+e58JigYoRz2Rbqy7tn7I97w44EBh2hPgLqY=;
 b=VpJK2pXMuYFX+D2C6FtRoEFlBk7jZw28JaijC60dGbuTuE18iXiuugQjU1fp7zuUTC
 tY7jRuKjtc9jWYx3E36YGz9+I0+snjWMdW/bJ1Wx/nuMrwvRYguMopxUtYM6d2RBuZWX
 6LcNPXaqMh+t0Pd6go16hlrl5g/8etwaJ3YpVK8km80/x4Jzn/8y/G4hplHtpaePI+7E
 6yUVlrAJva+O/jiRKSxcK+jIoZjsdNpGAllgjM60BoOZH9VMMrM15VBQfAXRqvgWrvRR
 PresBlNJm9FyltWWcKhCJ+kp0QRxUhl57R8a7xTy8brNqZgc3EI06mht3yadfHNNSgOR
 DbCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVrmIOoxtfWiibi73eiKF7IJ0nFs7NxxyKlcnL8SciLkf0MRZcB5fCm/gPs8v6PSOdBFShAuk=@lists.denx.de
X-Gm-Message-State: AOJu0YytJynRnYYU8vCsL3CrcgRiMjKpIv6PtzVnlOlZHlGwOIrX/oJ1
 lz+2Rz2LyUxwWsJxzG9leGRDwq7PowZAD/nbVLqg8/DWO1T9BmEF6yhlKS24osw=
X-Gm-Gg: ASbGncuKMvUyEWblwKFIa3MNhI1j48+hAtt80Q3cuaLySOkOnZ+I/GH/M7DfOuI5J7k
 7sTes3srPttYbt7fiPzbjmf8ouM3XPwMo/ES8GKltT81kDNDOzFo+4kAcQiWw6DKJhWfyctpSLE
 +PQC3VMuZX2g5J2p/RQ9XJWqYLDM3JqXvtaJ8r3iqJVID2bK/txn84fRxeMCgFr+Ccz+Ra8Op4L
 /2otg5j+ucwfdHZ9dcw314gAESyG4pbpQdWX5GEJDwVYbJkRO2h8+Wp
X-Google-Smtp-Source: AGHT+IGDG5S9r1ZjDbUe3xZYqkqEvk4yrdZbZmi9Z+QpnTiv+QgxzaUFZcpFvuVcuDqdbaoycevNTA==
X-Received: by 2002:a05:620a:1925:b0:7b6:cf18:66d1 with SMTP id
 af79cd13be357-7b9aaaaff64mr462267185a.21.1734626168979; 
 Thu, 19 Dec 2024 08:36:08 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac2df7a0sm62618485a.47.2024.12.19.08.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 08:36:07 -0800 (PST)
Date: Thu, 19 Dec 2024 10:36:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Levi Yun <yeoreum.yun@arm.com>
Subject: Re: [PATCH 2/2] tpm: get tpm event log from bloblist
Message-ID: <20241219163604.GV1505244@bill-the-cat>
References: <CAFLszTiVmZGxETFkngDbsv0PCLN_bVv7ox6MFiAoGGN2v7tbKQ@mail.gmail.com>
 <CAEfUkUL1EyJ6si_N6k6Ku1ZM9dWF6uHYXrQ14dueUeTEYzSRNQ@mail.gmail.com>
 <CAFLszThWQ2pOQux_Hsa2M=ArBR7f+R2GHeB2d4CB6k4MxShR4w@mail.gmail.com>
 <CAEfUkUKA9raUu0dANWf25aw6kBzu-DKshctQxVre57bEiN94kA@mail.gmail.com>
 <CAFLszTh4hjCHAoqkr+zdeBeq5rCoaO3aSjBVvFyCYVLoccPSUw@mail.gmail.com>
 <CAEfUkUJ8MrFoS3k9svxNoiYsZq51SS_=+TpKKeH=x2jPXRjPtQ@mail.gmail.com>
 <CAFLszTgaSGEhRbdwhn=SjPkH1-tEW63D8+H2_1ZUtsfxWfZBRg@mail.gmail.com>
 <20241216183014.GH1505244@bill-the-cat>
 <CAFLszTg3YgBABRqFOmzaz5KT1ipqmuFxTd1NX1x2yQz2rNgjZw@mail.gmail.com>
 <CAEfUkUJsdH=YjcN4V8Fe8Vfa2Sdb4PQJZxKe6y9RaRXcJgX_=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FmBZFesq+pCIHlZR"
Content-Disposition: inline
In-Reply-To: <CAEfUkUJsdH=YjcN4V8Fe8Vfa2Sdb4PQJZxKe6y9RaRXcJgX_=Q@mail.gmail.com>
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


--FmBZFesq+pCIHlZR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 10:37:37AM -0500, Raymond Mao wrote:
> Hi Simon,
>=20
> On Thu, 19 Dec 2024 at 10:08, Simon Glass <sjg@chromium.org> wrote:
>=20
> > Hi,
> >
> > On Mon, 16 Dec 2024 at 11:30, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Dec 16, 2024 at 10:37:30AM -0700, Simon Glass wrote:
> > > > Hi Raymond,
> > > >
> > > > On Mon, 16 Dec 2024 at 10:24, Raymond Mao <raymond.mao@linaro.org>
> > wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > On Mon, 16 Dec 2024 at 10:43, Simon Glass <sjg@chromium.org> wrot=
e:
> > > > >>
> > > > >> Hi Raymond,
> > > > >>
> > > > >> On Mon, 16 Dec 2024 at 08:29, Raymond Mao <raymond.mao@linaro.or=
g>
> > wrote:
> > > > >> >
> > > > >> > Hi Simon,
> > > > >> >
> > > > >> > On Mon, 16 Dec 2024 at 10:20, Simon Glass <sjg@chromium.org>
> > wrote:
> > > > >> >>
> > > > >> >> Hi Raymond,
> > > > >> >>
> > > > >> >> On Mon, 16 Dec 2024 at 07:52, Raymond Mao <
> > raymond.mao@linaro.org> wrote:
> > > > >> >> >
> > > > >> >> > Hi Simon,
> > > > >> >> >
> > > > >> >> > On Sun, 15 Dec 2024 at 19:25, Simon Glass <sjg@chromium.org>
> > wrote:
> > > > >> >> >>
> > > > >> >> >> Hi Raymond,
> > > > >> >> >>
> > > > >> >> >> On Fri, 13 Dec 2024 at 15:56, Raymond Mao <
> > raymond.mao@linaro.org> wrote:
> > > > >> >> >> >
> > > > >> >> >> > Get tpm event log from bloblist instead of FDT when
> > bloblist is
> > > > >> >> >> > enabled and valid from previous boot stage.
> > > > >> >> >> >
> > > > >> >> >> > Note:
> > > > >> >> >> > This patch depends on:
> > > > >> >> >> > [PATCH 1/2] bloblist: Introduce BLOBLIST_PRIOR_STAGE opt=
ions
> > > > >> >> >> >
> > https://lore.kernel.org/u-boot/20241212151142.1562825-1-trini@konsulko.=
com/
> > > > >> >> >> >
> > > > >> >> >> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > > >> >> >> > ---
> > > > >> >> >> >  lib/tpm_tcg2.c | 7 +++++++
> > > > >> >> >> >  1 file changed, 7 insertions(+)
> > > > >> >> >> >
> > > > >> >> >> > diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
> > > > >> >> >> > index 7f868cc883..acaf0acb88 100644
> > > > >> >> >> > --- a/lib/tpm_tcg2.c
> > > > >> >> >> > +++ b/lib/tpm_tcg2.c
> > > > >> >> >> > @@ -19,6 +19,7 @@
> > > > >> >> >> >  #include <linux/unaligned/generic.h>
> > > > >> >> >> >  #include <linux/unaligned/le_byteshift.h>
> > > > >> >> >> >  #include "tpm-utils.h"
> > > > >> >> >> > +#include <bloblist.h>
> > > > >> >> >> >
> > > > >> >> >> >  int tcg2_get_pcr_info(struct udevice *dev, u32
> > *supported_pcr, u32 *active_pcr,
> > > > >> >> >> >                       u32 *pcr_banks)
> > > > >> >> >> > @@ -672,6 +673,12 @@ __weak int
> > tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
> > > > >> >> >> >         *addr =3D NULL;
> > > > >> >> >> >         *size =3D 0;
> > > > >> >> >> >
> > > > >> >> >> > +       if (CONFIG_IS_ENABLED(BLOBLIST_PRIOR_STAGE) &&
> > !bloblist_maybe_init()) {
> > > > >> >> >>
> > > > >> >> >> Please drop the second term...the bloblist is inited by
> > U-Boot already.
> > > > >> >> >>
> > > > >> >> >
> > > > >> >> > As an independent library, from the tpm library's angle,
> > whether the bloblist init was already called or not is agnostic.
> > > > >> >> > I think this is the purpose of the "maybe" function.
> > > > >> >>
> > > > >> >> No. U-Boot does init at the start. We don't want each subsyst=
em
> > > > >> >> 'maybe' initing each other subsystem that it uses. If you wan=
t to
> > > > >> >> check whether bloblist is available, you can use the GD flag.
> > > > >> >>
> > > > >> >
> > > > >> > OK. I can use the gd instead.
> > > > >> >
> > > > >> >>
> > > > >> >> >
> > > > >> >> >>
> > > > >> >> >> Also please drop the first term. If you find it in the
> > bloblist, just use it.
> > > > >> >> >>
> > > > >> >> >
> > > > >> >> > I think here we should have the same logic as the existing =
one
> > in fdtdec:
> > > > >> >> > If bloblist is not enabled or errors observed, do a fallback
> > to the original process.
> > > > >> >> > At least I want to keep the same logic in different places
> > before everything is ready from TF-A to U-boot.
> > > > >> >>
> > > > >> >> Yes, your second line is right. But PRIOR_STAGE doesn't exist,
> > nor
> > > > >> >> should it. Nor do you need it, since you can just check the
> > bloblist
> > > > >> >> for what you want. If you don't find it, fall back.
> > > > >> >>
> > > > >> >
> > > > >> > Since Firmware Handoff is still an experimental feature and not
> > mandatory yet (at least now),
> > > > >> > I put everything under PRIOR_STAGE to allow users to disable it
> > by their own decisions.
> > > > >> > I saw PRIOR_STAGE in one of Tom's recent patches so I have add=
ed
> > a dependency claim in my commit message.
> > > > >>
> > > > >> Yes, but even if Tom does pick his patch, which I object to, by =
the
> > > > >> time your code is called, there will be a bloblist.
> > > > >>
> > > > >> So the end result of your test is to allow the user to ignore any
> > TPM
> > > > >> log in the bloblist. If that's what you want (which seems fine to
> > me),
> > > > >> add a Kconfig for it.
> > > > >>
> > > > >
> > > > > Per my understanding of PRIOR_STAGE, it means we have a bloblist
> > from the previous stage and we want to use it (as a Transfer List).
> > > > > If this is the case, it is not for DT only but can be applied for
> > eventlog or anything for Firmware Handoff in the future.
> > > > > That is the reason I use PRIOR_STAGE here, I don't think we need =
to
> > add another kconfig.
> > > >
> > > > Who knows what it is supposed to mean...anyway, it should not be us=
ed
> > > > like that. The devicetree is special in that we want to get it from
> > > > the bloblist very early, if available. Nothing else (so far) in the
> > > > bloblist has this constraint, certainly not the TPM log.
> > >
> > > Raymond is exactly right, and the device tree is not special.
> >
> > That is quite wrong IMO. Devicetree is special because we need it
> > early and it might come from bloblist before the bloblist has been set
> > up by U-Boot. It also controls the whole operation of U-Boot. There is
> > nothing else in U-Boot quite like the devicetree.
> >
> > > The
> > > specialness is "do we have a valid bloblist upon entry or not". Which
> > > means that also no, this series (since it happens late enough) should=
n't
> > > care about if the previous stage had created it or not, merely as you
> > > said if the tag for the TPM (or other blob) is found.
> >
> > I would feel more comfortable having the discussions about what
> > previous stages need to pass U-Boot a bloblist once we have that
> > situation. This particular patch seems clear enough, and well
> > motivated. It just needs to drop the conditions.
> >
> I think we still need a condition here indicating that the kconfig of
> "handoff via bloblist" is enabled.
> And this "handoff via bloblist" kconfig should mean to handoff everything
> via bloblist, including DT.

There's at least two sets of challenges here. One, being solved by
vexpress64 right now, is that we didn't have CONFIG_BLOBLIST_PASSAGE as
an actual option. And in that case, there's no U-Boot before full U-Boot
and the bloblist exists for us. Two, U-Boot is what is creating the
bloblist. The contentious parts are *when* it's created and *where* it
resides prior to full U-Boot seeing it.

In both cases, full U-Boot will copy the bloblist to where it likes.

And this is separate from "bloblist has device tree or we hang()".

--=20
Tom

--FmBZFesq+pCIHlZR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdkS3EACgkQFHw5/5Y0
tyxL4wv/QRRjE4Iyxp/nfJDyNX5+lgRLa84C5MsSmJJRBcjQ9ogq1wzUowhTm9d9
10HPV6Sk8ympzCk+ubk68tcu1i7hTtea4jlX60rtCLCzrq+KFmohiK3D6+P3fXxo
mOf/r+uwKLhwLqVntkIA7mg/HkUlSbA+mtuD6uduVMOKznQrODqUsl82trwAlgoz
z25j4MSlG9PYp9IBSWQWfvKbxJBHqWXPfXizXHWfWARyIt2sUdWUJRR/WMSWENAl
Kq/t0xSQK3CFGSllGEdoZqG1cKc27kaoMm38grDqSJVYLYaTFTm4cUanI8QVW+7g
f/Wbh+MrAsLxCp6qS370yM2K2LDL290AmovQsT0/G43TosBf4iUlq7yCOzmQFfbl
PFurPnyG7ZjTXrGo9qqI15yzZ2f79eRprk0AtTrFC9u3AYv7Plr8zIAvxBpQgKzr
BqPr/L0QdsbGaMyO2HLv+tnsLVOI3q6wJOtRfD9/rQAbiVqTf26fBfOBQKfLww3O
k4HGMvlm
=LPje
-----END PGP SIGNATURE-----

--FmBZFesq+pCIHlZR--
