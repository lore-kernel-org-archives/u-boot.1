Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A67109C057
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 18:26:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5889683DA7;
	Wed, 25 Mar 2026 19:26:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QBsxOJXt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B29583F14; Wed, 25 Mar 2026 19:26:25 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5871380077
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 19:26:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d1872504cbso73863a34.0
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 11:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774463182; x=1775067982; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=d3vt0plxIOlJxMdKRhIHHoH5wxnMbZYRcq9oQ5la1As=;
 b=QBsxOJXteB03v/hXO0Dbu0dyB+trvjVbLbPVSfEZdSmozhedOaWV8ycWpjv64kNAsE
 kqml6AaAAS/PrJg2Bonl//dWzo96muXJXDrYRq9GBfL1zLibCYZIbOmojY3RwQaohSSe
 JBzWK7n/TMmruwv9p86qt0CYAjWtwCa3LdXE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774463182; x=1775067982;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d3vt0plxIOlJxMdKRhIHHoH5wxnMbZYRcq9oQ5la1As=;
 b=brx8jJDEwFaDj3uDE8l5n9zrhuNpY5V/vnBtp+e8wkXy++6TlFWju7qQ0AlIUePCzd
 7zWy++6R6V3wNwG+IqAQCDWFILJD5Evto86Bk2UROby6jgBfIZa+q+yAYRb9e6yRq4ih
 ndH019psPdi0QZV4e5dghynb3zRh9Jaqk69OW/HyP53UsLjWhc4CL98VcbjD6aEbmZXd
 Axzs6+JHRsyzznEUtxKuNsMiqILfj817jonT0rsp21UrWKK23DplJ8oeiEY3jw4Sy2FC
 nSvUnNI5/5YBjFtZFSaEkDEU3t139JWgwkSY6Zw/dy4wiG33vnrZFde1VZWYhdIZGMZd
 FOHw==
X-Gm-Message-State: AOJu0YwkgQaI15pZRo6jBhgcZV9pBOPomM00vBZvXoZR2H3uR4dVkhHh
 /BtRcxhwTlmVGD42v0f728jPGRT76RnLHNLGsNitlmnFgXDGfe9pksPJb3PMiMGkRlI=
X-Gm-Gg: ATEYQzxMzruPQAfG+lPeKQdEW3+lpCk9PO2AVT0o1pC5qLEhH16kuKc3wkaG/VbVqOY
 TU245NfrveQ5oYyQGdJ+kvr+kJovmRbLsdCQrHi2spKu+1PTnQzElu0k/bmW5NJ9rl25+fqMJxE
 Jlkkad/J5zxgr7za+//FlZpNKCw66CPUiPh1//CSthNNEwzcV9VRdW5g37LAWUJWdLmmnSZZHFU
 lFkhV04i0kejssFnA0mMWK8gBUynumqTFzSqFzThBYvgdqCFTNVoqixPwUiAT8oFCYbFlM+599L
 qquktO3Y9rcgj5I3k0p6jhjEyQBKPti7WwlkbIcrWltHvcdHrlucHhjDKjWWtJvwGuEe1slg6bw
 DxMAE5+j525An6312i4hPYQU+Zs6/zraV1+JClWxHNsfkfgFwMICxjXDUg+OvMPHW9KwY2MaIum
 JfxXjJjUmGhg76hIRTtcODbEwpwd0hASPWyQnYvjers7nfyVHG2aJp1ZUziHenuv/0+YTWJfLCw
 ErAjCBrFRjfDWWKrWJdnb0KKCOTc0iHkpm5lMHtupGhkF2U
X-Received: by 2002:a05:6830:6a12:b0:7d7:bf59:2238 with SMTP id
 46e09a7af769-7d9d4df422fmr2650870a34.4.1774463181966; 
 Wed, 25 Mar 2026 11:26:21 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d9e6fde23esm375471a34.9.2026.03.25.11.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 11:26:21 -0700 (PDT)
Date: Wed, 25 Mar 2026 12:26:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>
Subject: Re: [PATCH] kbuild: Use relative paths in generated .incbin directives
Message-ID: <20260325182619.GV502704@bill-the-cat>
References: <20260325130811.447377-1-sjg@chromium.org>
 <20260325165420.GT502704@bill-the-cat>
 <CAFLszTgZpg-anG1J5kyiYk2JJ3dDiiyvuk5AV_PO+ri_b552tA@mail.gmail.com>
 <20260325171540.GU502704@bill-the-cat>
 <CAFLszTh3NgpY1VQer2wN9-feOvM8khXaFyp+ePhTpqowGK_qrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u0QaSU2tmctKcN4/"
Content-Disposition: inline
In-Reply-To: <CAFLszTh3NgpY1VQer2wN9-feOvM8khXaFyp+ePhTpqowGK_qrQ@mail.gmail.com>
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


--u0QaSU2tmctKcN4/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 11:57:17AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 25 Mar 2026 at 11:15, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Mar 25, 2026 at 11:12:00AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 25 Mar 2026 at 10:54, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Mar 25, 2026 at 07:08:09AM -0600, Simon Glass wrote:
> > > > > The generated .S files for fonts, splash screens and EFI apps use
> > > > > .incbin with the full prerequisite path. When building with O=3D =
this
> > > > > bakes an absolute path into the .S file. If the build directory is
> > > > > later used on a different machine (e.g. in a container), the asse=
mbler
> > > > > cannot find the source file.
> > > > >
> > > > > Use $(src)/$(notdir $<) instead of $< so the .incbin directive co=
ntains
> > > > > a source-relative path like drivers/video/fonts/nimbus_sans_l_reg=
ular.ttf
> > > > > rather than an absolute one. Add -Wa,-I$(srctree) to the assembler
> > > > > flags so the assembler can resolve these paths.
> > > > >
> > > > > The DTB and DTBO rules are left unchanged since their prerequisit=
es are
> > > > > generated files in the build directory.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > >  scripts/Makefile.lib | 7 ++++---
> > > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > >
> > > > This is generic kbuild infrastructure now. Is there a fix we're mis=
sing
> > > > from upstream, a change we haven't pulled in yet (as we need to keep
> > > > syncing upwards) or a problem upstream too? Thanks!
> > >
> > > Linux does this with DTB files in quiet_cmd_wrap_S_dtb:
> > >
> > > echo '.incbin "$<" ';
> > >
> > > But Linux only uses generated files in the build directory, never
> > > actual source files. The font/splash/EFI .incbin rules are U-Boot
> > > additions that aren't in the upstream kbuild. So Linux doesn't have
> > > this problem.
> >
> > Shouldn't we be generating these files in to the build directory too?
>=20
> These are actually source files, e.g.
> drivers/video/fonts/nimbus_sans_l_regular.ttf

So, the first thing then is that S_ttf is a local U-Boot rule. Lets
start by moving this out of scripts/Makefile.lib to
scripts/Makefile.lib-u-boot as that will make future re-sync work easier
(and is something we've talked about in the re-sync threads, splitting
U-Boot specific stuff out to new files). Then 2/2 of that series can be
this change, thanks.

--=20
Tom

--u0QaSU2tmctKcN4/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCacQoxwAKCRAr4qD1Cr/k
CnoxAQDMMoyz12LcrLI9hzT/dfrWYsiJ1Tu8vvFojMXQBUZF/wD/W2u0Debiw0GQ
X5KHa/sDdOfGmfOAEzK6a8pgmGUq+Qs=
=NlVX
-----END PGP SIGNATURE-----

--u0QaSU2tmctKcN4/--
