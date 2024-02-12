Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3895C4829C
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 16:56:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18AFE875FC;
	Mon, 12 Feb 2024 17:56:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m86lLweN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2167876A9; Mon, 12 Feb 2024 17:56:39 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68C138718A
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 17:56:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-dc25e12cc63so3632991276.0
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 08:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707756996; x=1708361796; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fY6zzsvoYQMn81kjZAksD5twwmfNppud1GYq+S92jXY=;
 b=m86lLweN0wjiKOqD6mfBi6IodktInSLG4901fQRgjOmgKx8SocNWsqZF/GvaRNtfqw
 q5I9QuW4oNx2O5swdUxkDcUUPwR1L+eafUZ+wzh2Q2YCM+8MpqSHH0iDTUDotnfEveDJ
 SnVun1NQ2rvkZMsEAh2mgFZ2ncEwFE8+5RZco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707756996; x=1708361796;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fY6zzsvoYQMn81kjZAksD5twwmfNppud1GYq+S92jXY=;
 b=mDUhe6cq7YVKmTuCCnt7RI9q9Kn/IZ+NypsLK1hmPCV1fC3ExiGaaRLnkTNvRDTE3N
 E7kFdxL4+6I+jpQgyDm6LrX0AOYGb5xBGSr4WR2Ej2yevOcnQob502wAUwhGaL1SrUih
 2ZYBBXToY9GVxPSUKrEt5N+7AgRBMj9wYVAeW682YkAmq21Z8F8gRonGOpFDbx9aljAN
 9t/AcTMopkkVpigSGnQY5M2Eb1iY8Lg+N9BdC/be4F4iLmPgydxMR1Gl3wd1BbrZakLx
 HUiGuTIBUNZYmCJ+DG3/ssW/qswawTw3nnYCs1bSczWXSC7qC02st7Qck4lHzf3RovTj
 0+TQ==
X-Gm-Message-State: AOJu0YzI8nNy9gT/pBH9zZNK63/3W1G4HY/A8s8CKdwgUZQFVN3lwDTJ
 U0mFHe8fnv6bqDVhDG4zrxzHKeof8Oj7tOhVFODP93WqGCIqLPnfSA/PX7NS9ZA=
X-Google-Smtp-Source: AGHT+IExF3SqyTCEh8ViKG0FIkcs3iLV508QpKESf1sznjHc9FTBMq3QpS1sOJbNp3MXXoIhz7CblA==
X-Received: by 2002:a25:7242:0:b0:dc6:d258:c694 with SMTP id
 n63-20020a257242000000b00dc6d258c694mr63238ybc.19.1707756994611; 
 Mon, 12 Feb 2024 08:56:34 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUDBOeiGUozlNft14J7aMZEVic4nf4TrfHYD/P3ZcOEKSVJeSo+aEw2oM+WkeqVwdajdH1hDhpyql2mWnuyDz7xm4sx153R
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 v16-20020a2583d0000000b00dc6e5ea9152sm1220354ybm.29.2024.02.12.08.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Feb 2024 08:56:33 -0800 (PST)
Date: Mon, 12 Feb 2024 11:56:31 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Igor Opaniuk <igor.opaniuk@gmail.com>
Subject: Re: [PATCH] doc/develop/codingstyle.rst: Clarify include section
Message-ID: <20240212165631.GH3040305@bill-the-cat>
References: <20240209143520.2724221-1-trini@konsulko.com>
 <CAByghJYCzN4Nm0mThc1QXMKk8KSPRZwwL2pp4ucLv7iwJsMSJg@mail.gmail.com>
 <20240212161909.GF3040305@bill-the-cat>
 <ca87001b-2713-4fdc-8d93-9bfc7008bb02@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/6M+xZywRdt8XRkd"
Content-Disposition: inline
In-Reply-To: <ca87001b-2713-4fdc-8d93-9bfc7008bb02@gmx.de>
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


--/6M+xZywRdt8XRkd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 05:52:03PM +0100, Heinrich Schuchardt wrote:
> On 12.02.24 17:19, Tom Rini wrote:
> > On Sun, Feb 11, 2024 at 06:53:47PM +0100, Igor Opaniuk wrote:
> > > Hi Tom,
> > >=20
> > > On Fri, Feb 9, 2024 at 3:52=E2=80=AFPM Tom Rini <trini@konsulko.com> =
wrote:
> > > >=20
> > > > Rework the section about includes slightly. We should not be using
> > > > common.h anywhere, so remove that from examples and ask people to s=
end
> > > > patches removing it when found. Doing this also means we need to re=
word
> > > > other parts of this section. Be clearer about using alphabetical
> > > > ordering.
> > > >=20
> > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > ---
> > > >   doc/develop/codingstyle.rst | 23 +++++++++++------------
> > > >   1 file changed, 11 insertions(+), 12 deletions(-)
> > > >=20
> > > > diff --git a/doc/develop/codingstyle.rst b/doc/develop/codingstyle.=
rst
> > > > index b25bfbd271f0..cdf5aedfcbb0 100644
> > > > --- a/doc/develop/codingstyle.rst
> > > > +++ b/doc/develop/codingstyle.rst
> > > > @@ -108,30 +108,29 @@ expected size, or that particular members app=
ear at the right offset.
> > > >   Include files
> > > >   -------------
> > > >=20
> > > > -You should follow this ordering in U-Boot. The common.h header (wh=
ich is going
> > > > -away at some point) should always be first, followed by other head=
ers in order,
> > > > -then headers with directories, then local files:
> > > > +You should follow this ordering in U-Boot. In all cases, they shou=
ld be listed
> > > > +in alphabetical order. First comes headers which are located direc=
tly in our
> > > > +top-level include diretory. This excludes the common.h header file=
 which is to
> > > > +be removed. Second are headers within subdirectories, Finally dire=
ctory-local
> > > > +includes should be listed. See this example:
> > > >=20
> > > >   .. code-block:: C
> > > >=20
> > > > -   #include <common.h>
> > > >      #include <bootstage.h>
> > > >      #include <dm.h>
> > > >      #include <others.h>
> > > >      #include <asm/...>
> > > > -   #include <arm/arch/...>
> > > > +   #include <asm/arch/...>
> > > >      #include <dm/device_compat.h>
> > > >      #include <linux/...>
> > > >      #include "local.h"
> > > >=20
> > > > -Within that order, sort your includes.
> > > > -
> > > > -It is important to include common.h first since it provides basic =
features used
> > > > -by most files, e.g. CONFIG options.
> > > > -
> > > >   For files that need to be compiled for the host (e.g. tools), you=
 need to use
> > > > -``#ifndef USE_HOSTCC`` to avoid including common.h since it includ=
es a lot of
> > > > -internal U-Boot things. See common/image.c for an example.
> > > > +``#ifndef USE_HOSTCC`` to avoid including U-Boot specific include =
files.  See
> > > > +common/image.c for an example.
> > > > +
> > > > +If you encounter ccode which still uses <common.h> a patch to remo=
ve that and
> > > nitpick: s/ccode/code/g
> >=20
> > Whoops, Heinrich can you please fix when applying?
> >=20
>=20
> Hello Tom,
>=20
> I am missing here some text about the includes that are automatically
> included, e.g.
>=20
> linux/kconfig.h
> include/generated/autoconf.h
>=20
> Maybe you could describe this in a future patch.

Yeah, that would be good as there's in turn a few places we do have to
manually include those files.

> We still have 4107 files including common.h. Should we have a Migration
> warning in Makefile?

checkpatch.pl already marks this as an error for new patches. In some
other threads I've talked with Simon about not wanting to script the
removal as there's some style to it (in short, the linux kernel doesn't
enforce direct #include of everything needed in every C file, so we
aren't either, so it's a matter of pulling common.h out and fixing
fallout rather than adding say errno.h everywhere first).

--=20
Tom

--/6M+xZywRdt8XRkd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXKTbgACgkQFHw5/5Y0
tyxMLgwAsTwa5qCLKHpiwon4uIVte1yPG0Q6l0mq/QWuq//2Ib2QJfxTeIbRatA7
w6QUbg9Mrk53fGiNVZSLaa1mq3n/syUcG7CVxrIFZhfP+0JKmfRkcfCUcDtssA48
puGl9VUYtLcwwAoc1vIuz6VZcWTg744QOMKssmgf965hOEPgCr7F4ATyIuAQH3si
GPB4JU/wkRKRFfAxGdXLuW62S2ThytVgOffEgBVULv7d8Y8XyrshuGYJwh8oC89L
G4kSxUFV8VISuo4lxAtTswQIrsCx4xA43zpzbyDE1nnYri11N6q3+6SJwMkj25EA
eIPdu9g7hH0hs6rJ2B8Llt76teBqXzswHPxo9NHQ+P3z0GQVczjZ51xlIILwNm+p
qFFsrY7UZRXeYu8sQemQYDFW8FovL7jVwG0ho5613mjoasyki24LUq0pbqIpMAwt
qfDYuKMdTKjnhlWX7ZqQg3eA+SYmVtfSv85usq82UR2GnIRtak4ebR6AR14Y1lPK
UqWjBjyU
=qPVu
-----END PGP SIGNATURE-----

--/6M+xZywRdt8XRkd--
