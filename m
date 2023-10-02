Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96FCE784AC
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 14:09:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 205E386DC3;
	Mon,  2 Oct 2023 16:09:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jMPnZWAU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA5D186DF4; Mon,  2 Oct 2023 16:09:01 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7197786D20
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 16:08:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-d90da64499cso865344276.0
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 07:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696255737; x=1696860537; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=np6Az4CnztScjjSTcGYl8uRUnhaNEqZUvjbQ/knefEE=;
 b=jMPnZWAUpgtyx/KldEPKelf/bRsn1fIvfpf8glyxOe18w/ebFsLxjysnkugEQruuqS
 KmUPkBvDTeDq+qLuqueOCF87qQ6CDvBMDOwjoX9Gw3jBxm2I5/YLjAtajw7ktWWyNevg
 q2bmwTs05b6s0Z69y3mKcK2gXKid7zZuR+k/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696255737; x=1696860537;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=np6Az4CnztScjjSTcGYl8uRUnhaNEqZUvjbQ/knefEE=;
 b=HpAMoyPvIf7CQELwD0vs9rF/3dZBTWu7w2qy7qyjm6Kt+0UMGNyOWqtjO7nKKFCh17
 ATGu1NofYrU169udJAxpFZ776R1QJ60SEjp2TMyT5q85IMBrouFcirh42n6NFOBoGfxi
 DmKzw2yyCCIB2fdu8wBWx2fyC1Hp6gUNenIjM304q36DF8n3XI/Hvme4XvGcNklxRdag
 YEbD2p/NA9jfQBH6JchPxaXwWeoyiuiPT7o4PFNDhJbLvnfLEbvF7f8jviXU9pszQVk5
 YRjS7jztqKMYlxPcXaglVtV3phGjaB5EGJUSwoP11wJnSwxoYlN46/5l9kIwwNE/qKfr
 Epmg==
X-Gm-Message-State: AOJu0YyV/JizIqOpfRJeIZ46LL2mBH9knqrAKesFMVu/SRYRZFHzB0ez
 E6xL5VQF4n8ceTJoFZu5DbuKPA==
X-Google-Smtp-Source: AGHT+IEpmRqZDC0zbfrqUSFHb4iFQUGIbodlDtelNZl49G8qX2kTxn9aWibP9yXEp4QZWcBLRtw1ng==
X-Received: by 2002:a5b:249:0:b0:d85:df88:a7c4 with SMTP id
 g9-20020a5b0249000000b00d85df88a7c4mr10508339ybp.18.1696255737092; 
 Mon, 02 Oct 2023 07:08:57 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-92a5-a961-a832-88f6.res6.spectrum.com.
 [2603:6081:7b00:6400:92a5:a961:a832:88f6])
 by smtp.gmail.com with ESMTPSA id
 d23-20020a25e617000000b00d800eb5ac2asm6918937ybh.65.2023.10.02.07.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 07:08:56 -0700 (PDT)
Date: Mon, 2 Oct 2023 10:08:54 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Subject: Re: [PATCH] scripts/Makefile.lib: also consider
 $(CONFIG_SYS_BOARD)-u-boot.dtsi
Message-ID: <20231002140854.GU305624@bill-the-cat>
References: <40c79f7b-205d-0b48-7ee2-e052eaa1317f@prevas.dk>
 <20230503135158.GY1134230@bill-the-cat>
 <20230503145438.GB1134230@bill-the-cat>
 <0f2df366-65ca-664f-1f90-0c2aeafce8f1@prevas.dk>
 <68f445de-c903-c3a1-906f-2cf7b5675d08@prevas.dk>
 <20230925181940.GH305624@bill-the-cat>
 <08e35aab-309c-a8e1-931e-7ab142beb593@prevas.dk>
 <CAPnjgZ3jO5s3HZRjXdG-dVLNmGYnyCWnpvzRKpKhBCRQqWH33Q@mail.gmail.com>
 <20230929160230.GP305624@bill-the-cat>
 <CAPnjgZ29hTMrzey1eZreTKhEVXWvi50JWBw-kUKC2VUYgXLYsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ouNSWE++tkHLI9Ni"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ29hTMrzey1eZreTKhEVXWvi50JWBw-kUKC2VUYgXLYsw@mail.gmail.com>
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


--ouNSWE++tkHLI9Ni
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 01, 2023 at 07:17:27PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 29 Sept 2023 at 10:02, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Sep 29, 2023 at 09:15:00AM -0600, Simon Glass wrote:
> > > Hi Rasmus,
> > >
> > > On Mon, 25 Sept 2023 at 13:05, Rasmus Villemoes
> > > <rasmus.villemoes@prevas.dk> wrote:
> > > >
> > > > On 25/09/2023 20.19, Tom Rini wrote:
> > > > > On Mon, Sep 25, 2023 at 10:27:43AM +0200, Rasmus Villemoes wrote:
> > > > >> On 04/05/2023 14.35, Rasmus Villemoes wrote:
> > > > >>> On 03/05/2023 16.54, Tom Rini wrote:
> > > > >>
> > > > >>>> The one last problem now is on stm32mp15_dhcor_basic which is a
> > > > >>>> defconfig missing one from OF_LIST but including it in the its=
 file, so
> > > > >>>> the above is the patch we need.
> > > > >>>>
> > > > >>
> > > > >> Hi Tom
> > > > >>
> > > > >> Can I persuade you to try something like
> > > > >> https://source.denx.de/u-boot/u-boot/-/commit/a05e0d0e6b9103542a=
1076f9cab0005f400fa072
> > > > >> again, but leaving the .dtbo targets in there?
> > > > >>
> > > > >> I could send a patch, but it's entirely mechanical, and not real=
ly meant
> > > > >> for being applied until we know if there's more to be cleaned up.
> > > > >
> > > > > So what ended up being the problem I think is the case Simon poin=
ted out
> > > > > where we do take the output from "make all" and concatenate one o=
f the
> > > > > dtbs that was generated with u-boot.img or so, and it works.  But=
 maybe
> > > > > that should just list all of the valid DTBs that it needs in the
> > > > > defconfig to start with? I don't quite know, it was a case I hadn=
't
> > > > > considered at the time.
> > > > >
> > > >
> > > > Re-reading the thread, I can't see where that was mentioned.
> > > >
> > > > But yes, if some boards (still) need that, and have more than one
> > > > possible .dtb, the board can't set an OF_LIST different from the de=
fault
> > > > consisting of DEFAULT_DEVICE_TREE because changing OF_LIST requires
> > > > SPL_LOAD_FIT || MULTI_DTB_FIT.
> > > >
> > > > How do we figure out if such boards even exist?
> > >
> > > Honestly at this point I've forgotten what this is all about.
> > >
> > > Perhaps the easiest approach is to create a new Kconfig to control
> > > whether a board-level .dtsi is included in the list of wildcard
> > > searches. Then you can enable it for your board without affecting
> > > others.
> >
> > That's getting things backwards, from what this cleanup does.  Today we
> > have messy lists of "build these device trees" and then don't use most
> > of them, and some of the list is just Wrong (listing dts files as an
> > output).  With the series to handle dtbo files, we could remove
> > virtually all of that, and the only use cases that don't Just Work still
> > are the ones I forget which board you mentioned (I think it was Samsung
> > tho?) where the defconfig doesn't list all of the device trees, just one
> > of them, and the other 5 that we build can also be easily used.  Does
> > that ring a bell?
>=20
> Yes it does...but what is the problem here?

Messy and unused and incorrect Makefile content.

> The DT files for an SoC are supposed to be buildable without needing
> to have the context of a particular board.

They're still buildable, without an explicit rule, they just need to
(like they can now) be built explicitly.

> I don't know what the point of the dtbo files is...is that for using
> overlays somehow at runtime?

I think that side-tracked you from my question.

> The defconfig does not need to mention all the DTs...we just need to
> make sure they get built.

Why?  This is the use case that I don't understand and isn't obvious.

> Is this another instance of something that needs cleaning up, like the
> config fragments?

No, this isn't like the config fragments.

> I am find with making the boards list the DTs that they can run with,
> if there is an easy way of doing that. CONFIG_SPL_OF_LIST is just for
> SPL, I think.

Yes, every board except for some use case you've described before as far
as I know lists the device trees that they use in the defconfig.  Which
is why there's an impetus to clean up arch/*/dts/Makefile as 95% of
those lines can just be removed.

--=20
Tom

--ouNSWE++tkHLI9Ni
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUazvYACgkQFHw5/5Y0
tyzegAv/TAWaBxJtC2HLiJIfobURzJczyXCFwPzN6j8UXyqfoiHO5HijwsC2XIFe
b2ZJnVNg24vhsQm30OkumbSEIFYE/c76yPMjaD5ZUIzZqYPGT2TxYLYmVTzeP9Ih
XsJWoBV+htRgBdC4mjtQC98V5WbFEIGGOqr1WRwTZgWAIRLgO/dcuOcsTYETgubC
wmL73+y14EsZ5eargp/vlZ8Rdmt8Wd6ftLQqHxIxGEh5QI8RshZV6IGu/MlNnE2R
r33Z3WELLpPbIlWUfo4pw6g+Tj4+yBXJqcoQcOJy7OoMIqAWvOnIHInWnTdPsezW
wg2Ry2xN6bSP0FjWWpecompk5mWhUcfh6shJPOG1XQ+WMOVSB1MUt+3UyQjbnR9X
qC5hm2n2ITo7QWj1+0XZX5jk6bR9glhozaWX7ZAuQ20ZJc9btpMwbqIPkMSj/fo/
caBR4rhe7uByaY+ZPiMeRP51/23rI98EhnD6BmwQMxrPvq0m5qud/SjBeaK510/4
GWU2TZa0
=klGB
-----END PGP SIGNATURE-----

--ouNSWE++tkHLI9Ni--
