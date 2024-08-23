Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCCEC5321E
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 21:49:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65A6488966;
	Fri, 23 Aug 2024 23:49:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kflCsX85";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06C43889D0; Fri, 23 Aug 2024 23:49:48 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94AA18891E
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 23:49:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7a4df9dc840so145405285a.2
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 14:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724449784; x=1725054584; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hUL7ybQ+G3f8gU/A1PsnywaxCwpKO6fsulpl55UeQP4=;
 b=kflCsX85HdCLQt/OhRAiSgItkS/xAC9txfQk71/gSaHXGBoCmdLXRB8i1Dv1S7NBM9
 nv4l+/fq1L6pPmjCJgZDa4tq7XjMpPRbPEhOOziWbb3c5V/SK6Qjs2/LFfS0EHMSGDaL
 +bDHQ254YO81YfM4q8V0IbHkIFiKcR8YDLj68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724449784; x=1725054584;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hUL7ybQ+G3f8gU/A1PsnywaxCwpKO6fsulpl55UeQP4=;
 b=IiW8ApUf1QNkVxnkZ79deVAitEJ9JKYD+3KEU/gdfcVhWflfFuw7+qQzEjuIlYRx0g
 udRS48KPhc8/lGWIAAftWpfiOsKLf1QzZpeEapSMys3jCNvNOMRvx8T1WnnaaDdlEiKV
 OX0ZCdtHhviUo1gFTVQvRLofkhMcCMafbpcUnITlj5HY3Ia93L4rNkzkNK9i1wPUoU81
 KnkOmYDoaDljZoXQGxCTvUVG1IU1D9th9jF44yRXjP2yIAgcWQC0m/N59u1b7vsK6kXD
 M1GxBx0PgMWohsDNIdisXnWodQ0YhGW/MF21LTO6hpEGYIkNw10xMh/b1e106C7oXukL
 Q0sg==
X-Gm-Message-State: AOJu0YxU9BFWKmp3veDmLWlPz8MuQyAMI3EtKwQQFQGnPsIpx/ejjtDd
 XK9en+1h6d8J4I1pI6Q218RXUq3X9MTO9UR4TGsKl3bcD+2kIej0wWD97XGP4Psfkf4Ej3mqZcH
 W
X-Google-Smtp-Source: AGHT+IF6YjNoUaEDBvqzANVpOD8JMV0fx27mY1BFI8bjpE3RKyNy5d6gyB1GwqJX6oalBmxsF6mXzg==
X-Received: by 2002:a05:620a:25c8:b0:79f:73d:d2e with SMTP id
 af79cd13be357-7a689700986mr308655185a.24.1724449783979; 
 Fri, 23 Aug 2024 14:49:43 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a67f3baf94sm218439385a.94.2024.08.23.14.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 14:49:43 -0700 (PDT)
Date: Fri, 23 Aug 2024 15:49:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 26/35] global_data: Reduce size of early-malloc vars
Message-ID: <20240823214940.GC2479150@bill-the-cat>
References: <20240821161927.695717-1-sjg@chromium.org>
 <20240821161927.695717-27-sjg@chromium.org>
 <20240823133450.GA1627158@bill-the-cat>
 <CAFLszThQKH-pM1nTNJv5HwLanc9tGL4ZgvPLzxWk48LmxHa+NQ@mail.gmail.com>
 <20240823210723.GY1626301@bill-the-cat>
 <CAFLszTirvuCkhb7BTj84Y3oNey34fmi=+V=fFTwb73rV428i=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HiBX1nq8MZ4bwKGI"
Content-Disposition: inline
In-Reply-To: <CAFLszTirvuCkhb7BTj84Y3oNey34fmi=+V=fFTwb73rV428i=Q@mail.gmail.com>
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


--HiBX1nq8MZ4bwKGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 03:44:45PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 23 Aug 2024 at 15:07, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Aug 23, 2024 at 02:30:04PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 23 Aug 2024 at 07:34, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Aug 21, 2024 at 10:19:18AM -0600, Simon Glass wrote:
> > > >
> > > > > The early malloc region is normally quite small and is certainly =
less
> > > > > than 4GB, so use a 32-bit value for the limit and pointer. Update=
 the
> > > > > comment for clarity while we are here.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > (no changes since v1)
> > > > >
> > > > >  arch/arm/lib/bdinfo.c             | 2 +-
> > > > >  common/board_r.c                  | 2 +-
> > > > >  common/malloc_simple.c            | 7 ++++---
> > > > >  common/spl/spl.c                  | 4 ++--
> > > > >  include/asm-generic/global_data.h | 6 +++---
> > > > >  5 files changed, 11 insertions(+), 10 deletions(-)
> > > >
> > > > This breaks booting on am64x_evm_a53 which is an odd platform that =
does
> > > > SPL->SPL->U-Boot.
> > >
> > > OK, I can repeat that on the Beagleplay in my lab. I sent a v3 patch.
> > > Thanks for bisecting.
> >
> > Oh good, beagleplay is run after the EVM in my loop and so I didn't see
> > it was broken there too.
> >
> > > I'd love to be able to push trees to gitlab and have them run on my
> > > lab. I think you said that the patches[1] break your lab, so let me
> > > know if there is anything I can fix.
> > >
> > > Regards,
> > > Simon
> > >
> > > [1] https://patchwork.ozlabs.org/project/uboot/list/?series=3D420392
> >
> > Well the good news is that I've got the tests running again here, and I
> > think I mostly understand where the challenges will be in updating this
> > lab to a newer labgrid version and so being able to migrate it to on top
> > of your patches. The challenge next will be time. Likely the next steps
> > will be splitting out your serieses in to test fixes and labgrid
> > implementation details.
>=20
> I just sent v3 of the u-boot-test-hooks series. That needs to be in
> for Labgrid to work.

Yes, thanks. It reminded me how far apart what you have is from what I
have, for labgrid.

> The only other series is [1] which makes the integration nicer, but is
> not necessary. That makes sense since we still want the lab to be able
> to test older commits.
>=20
> From that series patch [2] fixes a problem which breaks pytest runs,
> since without it, pytest gets a double echo of a few of the characters
> of the first command it sends. It is a pretty annoying problem which
> took a while to figure out. I tried very hard to fix it without
> patching U-Boot's pytest code, but I gave up. One thought I just had
> is that it is possible that setting up the terminal in the
> u-boot-test-console script might work most of the time, i.e. before
> calling Labgrid.

I know with previous iterations of all of the test cleanups and changes
you did, my non-labgrid lab also started failing immediately. Keeping in
mind that today I run all of the pytests on a few hardware platforms,
both with and without labgrid, I need to see what changes you've done
lead to what behavior changes here, and then eventually get things
boiled down to just the your labgrid implementation specific parts, and
see how to work with them, or if it's too far away from the rest of my
use case.

--=20
Tom

--HiBX1nq8MZ4bwKGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbJA+0ACgkQFHw5/5Y0
tywjKgv/WWp/x966mld/CuOzP9bTWDNO1SvWN/Sb1a/hQW05oWciC5WisRfDcZ2U
DaBXRpG/gEb1Ga91LjfLdjP4I13PyzpzeCB7iOEJmBfUeAkA5ww9dhEFFbPlxCgD
jxXiKM4fRiXZfWj0NeIyDyRC/Q66n58Uao7mSWBFjJxKzCtj5L5BkpUU/WrdwcUK
fsg3m0gc/Uw1x6tTlwGX3amfBgBQ3AUR4O90sDmPzbZYOirU2690JMEGl42/HP/S
VfMxBDvQVYhr5zPrH4g5bndAJL/VoOlT5FNbsQA7SvqF9DFC22bfn00p6RZO8haM
zntuLXo9i76FRwCKmgpn+UpOI8aiyJe5Gm3tfRbODI+z4xXSRsdZV7As9w7zJgB2
mhSUDbvj2HHVoHlz7Up1VAeH/z2pBli1uSKiLw/SNGyh8wuiZ51QqK6VeNfy4SWp
VBGlzFSUtmR1m5Edb10FIytgqtkBMt1R5z6iCVLSzE8EzHWHArW4Mp4+BWjt1aSh
M9YmI4E7
=agj9
-----END PGP SIGNATURE-----

--HiBX1nq8MZ4bwKGI--
