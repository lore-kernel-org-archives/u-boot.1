Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0845C4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 16:19:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2591A87ED6;
	Mon, 12 Feb 2024 17:19:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="migZDLm8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 334E287ED6; Mon, 12 Feb 2024 17:19:15 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DBCB875FA
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 17:19:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6049e8a54b5so33884097b3.0
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 08:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707754751; x=1708359551; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SQGC5jGobw0gDVFbubI6lf0GJmrR7gey23w7EaIug4A=;
 b=migZDLm8qZOCYsRpaz7/ZOeqh2kxjVlcg3Cqx86xhecSBmrU8ainvkvgZ+fHINHpUw
 UpwETS7Fvz7Zy9I1SmFddA7/SlqIICmGH/4hRb1/UIovrLf1C/CGrFzvGpsKBhTfietp
 iX6dohBSMKHbuDEozfOmzyaO+des+A1UZJxaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707754751; x=1708359551;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SQGC5jGobw0gDVFbubI6lf0GJmrR7gey23w7EaIug4A=;
 b=NQ58epjFmQZsssCKW2LN7tB2t7GmOzNvTfM/+1nNDi32uSQrGfmn8SviDEKRWeHF7L
 9O/kJN8uUJQYi2uHIXYDFEhe974lxsgxcB7yWS9lwCZtJOJw8dE5s9DYajFBA1PiEr7X
 i245e91Hea+Q2AOT9eYjN4+KKAST66lUB5n9SfdYy55Q7ti/kTAQY31zLynf8/hOpAf0
 iNqI3srVd078eNiZX3gsRBNNkQzB3NOmwQfVMQK+tPcvjmZPDiX2WMfpSlZpFOrfdgZE
 TUfSoXO3d4O1E3fhLuowSiViZ21kAbJFrQDxjYrrlJFLXB+6JfJJEzI77WkrWWQHczAq
 jEeQ==
X-Gm-Message-State: AOJu0YyigFtVJNSrBT/b7zIj+Q38UpSf1kvdnd7TiyKWmIxNmD/vF4oX
 i/agpDQJMejBwlaTlxQ8hfp20zA32YLx+N8KA3eSkvVnwtI+egtWhxi41c5fH+g=
X-Google-Smtp-Source: AGHT+IHV1ZWx54/vrhnRbs9ajeGfGq/8fws83QKrkVNNg2WOt8J1dSjC/Da8e5p4Dh+FAq1GVpr8ew==
X-Received: by 2002:a81:a18d:0:b0:5ff:409d:5a74 with SMTP id
 y135-20020a81a18d000000b005ff409d5a74mr6831851ywg.21.1707754751337; 
 Mon, 12 Feb 2024 08:19:11 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX+N1EcH0SxVm4FhGQQ/+lhVovyOX1tXNIJu3LywFrm0y62D+h323dKDLxzMmL+Ae1Bpj88tgCWkD8/6cJMr+4GDQo=
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 ej3-20020a05690c2a4300b006077929b97asm85325ywb.15.2024.02.12.08.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Feb 2024 08:19:10 -0800 (PST)
Date: Mon, 12 Feb 2024 11:19:09 -0500
From: Tom Rini <trini@konsulko.com>
To: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] doc/develop/codingstyle.rst: Clarify include section
Message-ID: <20240212161909.GF3040305@bill-the-cat>
References: <20240209143520.2724221-1-trini@konsulko.com>
 <CAByghJYCzN4Nm0mThc1QXMKk8KSPRZwwL2pp4ucLv7iwJsMSJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qg7qB94BK61oEP8s"
Content-Disposition: inline
In-Reply-To: <CAByghJYCzN4Nm0mThc1QXMKk8KSPRZwwL2pp4ucLv7iwJsMSJg@mail.gmail.com>
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


--qg7qB94BK61oEP8s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 11, 2024 at 06:53:47PM +0100, Igor Opaniuk wrote:
> Hi Tom,
>=20
> On Fri, Feb 9, 2024 at 3:52=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
> >
> > Rework the section about includes slightly. We should not be using
> > common.h anywhere, so remove that from examples and ask people to send
> > patches removing it when found. Doing this also means we need to reword
> > other parts of this section. Be clearer about using alphabetical
> > ordering.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> >  doc/develop/codingstyle.rst | 23 +++++++++++------------
> >  1 file changed, 11 insertions(+), 12 deletions(-)
> >
> > diff --git a/doc/develop/codingstyle.rst b/doc/develop/codingstyle.rst
> > index b25bfbd271f0..cdf5aedfcbb0 100644
> > --- a/doc/develop/codingstyle.rst
> > +++ b/doc/develop/codingstyle.rst
> > @@ -108,30 +108,29 @@ expected size, or that particular members appear =
at the right offset.
> >  Include files
> >  -------------
> >
> > -You should follow this ordering in U-Boot. The common.h header (which =
is going
> > -away at some point) should always be first, followed by other headers =
in order,
> > -then headers with directories, then local files:
> > +You should follow this ordering in U-Boot. In all cases, they should b=
e listed
> > +in alphabetical order. First comes headers which are located directly =
in our
> > +top-level include diretory. This excludes the common.h header file whi=
ch is to
> > +be removed. Second are headers within subdirectories, Finally director=
y-local
> > +includes should be listed. See this example:
> >
> >  .. code-block:: C
> >
> > -   #include <common.h>
> >     #include <bootstage.h>
> >     #include <dm.h>
> >     #include <others.h>
> >     #include <asm/...>
> > -   #include <arm/arch/...>
> > +   #include <asm/arch/...>
> >     #include <dm/device_compat.h>
> >     #include <linux/...>
> >     #include "local.h"
> >
> > -Within that order, sort your includes.
> > -
> > -It is important to include common.h first since it provides basic feat=
ures used
> > -by most files, e.g. CONFIG options.
> > -
> >  For files that need to be compiled for the host (e.g. tools), you need=
 to use
> > -``#ifndef USE_HOSTCC`` to avoid including common.h since it includes a=
 lot of
> > -internal U-Boot things. See common/image.c for an example.
> > +``#ifndef USE_HOSTCC`` to avoid including U-Boot specific include file=
s.  See
> > +common/image.c for an example.
> > +
> > +If you encounter ccode which still uses <common.h> a patch to remove t=
hat and
> nitpick: s/ccode/code/g

Whoops, Heinrich can you please fix when applying?

--=20
Tom

--qg7qB94BK61oEP8s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXKRP0ACgkQFHw5/5Y0
tyxO1AwApuvvPo912XWTkWu0iadNdWHphVQemF0IejYXQQx6Q6NGCdA0gw+fDW3r
2wzMCR33ZFeS6IoeaO6QZW9mTSM34VzLyZ/afG+nEnAnDCjCpRZLLZm5lc+mjYvh
K1gMlMQY35kK4OsjxWFpIQhD/tV+tOo8M21esHCbffCRAF9kvY/xrjoW8MjzhhLW
721E9rp2NIQsJSAcBC0seYvfbmed7vbAw3TMEhEWG5vCrAqKoOOHtkCQBL9PGy+3
BdLydgGzSnjGDTUbuAPVLmN3VY7i6LAMfrx+wTtOI6uMqu3EpOrmNQ/Vm/R8rXW+
QaNYTwJevyg0jnqgtvtlE39qGfWgdgFctM8y+aPac0QDdnBbVO/BF5gHg288Xo+x
Gnm00QPZNqU4qQTTGSClCFIfwJIxxT4/QIk8KhPhLWxd3rQ3bEIxZAMmYZZDrbqJ
hER8ukxSC1r9Ua3bXgA6AD13Z7Tm04DzqPSAoi+0bt9IfEjJbLez8UAO3MGITbR8
mlqGxoRc
=goSB
-----END PGP SIGNATURE-----

--qg7qB94BK61oEP8s--
