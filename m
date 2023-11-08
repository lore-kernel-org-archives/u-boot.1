Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895C8C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 00:23:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA9FE876D3;
	Wed,  8 Nov 2023 01:23:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iEO+bsNu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B505876DB; Wed,  8 Nov 2023 01:23:49 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FD5887689
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 01:23:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-d865854ef96so6507684276.2
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 16:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699403025; x=1700007825; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KOwFSHMBoyrjRBoPO8yyj6CNLsxvXZ1RE2+sHMv1FjE=;
 b=iEO+bsNuI7IHLR229ucNtKd638q/caqAqP45cyUFnF5fxVV60Fo2WNNzzdq/ixYKZN
 w9bW2nlihhLfIqqzExDKrzXDFYQs8DGecgM/dQxX6CKUPxTZxBRk6x9vvezf++nv4EXe
 a4R+qQct8xYyP6g9OmEhdBJ1IoLZlrDcQpSOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699403025; x=1700007825;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KOwFSHMBoyrjRBoPO8yyj6CNLsxvXZ1RE2+sHMv1FjE=;
 b=V9P3EImQwipH85222LkewW4N0GiOFOra1x+1idM1Rn1iCF+D3QSAfyNQgZ7Hmv+40R
 5qiF8F6E2qzphnoSiF4NU8/jeN70uG/08/rHsrYR+R2C015uEdS5QQ89Js3JT9Dn8O0F
 loDTwFJczpQxT0aSXrnMFfpG588Upf0TcdGr6YARkxn5QvA45xIJhW6rJtLT6RjL886I
 mPIgoOC1DMs87ZrXOhuzBrlh8gHQKrVBVIUjA7csSeKiBtjFRV8xvHIdN9n38LeslPbJ
 uOPznDVxxry0zeUQUCUzbJzxKKB2QLcnZvjZ5U1oigmsqaVIGSTWWrwBVdhi9//xlwrU
 K1Rg==
X-Gm-Message-State: AOJu0Yz7gnlRuzmr8fWfEOF/7rcJ13tymS3pdF20s/nX2y9BtmHo/1LG
 eKBwzk/PwtqnTYKwVD/5pkzlpw==
X-Google-Smtp-Source: AGHT+IHnpAI6dCbVy9x2Po7OIdvb21u9pQzTIdSHvocr1j+78zUrULhJVqr0RBVMu1VOvKx+Vd7uVw==
X-Received: by 2002:a25:2b01:0:b0:da0:84b2:5e3e with SMTP id
 r1-20020a252b01000000b00da084b25e3emr295772ybr.21.1699403025032; 
 Tue, 07 Nov 2023 16:23:45 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5409-8f3c-5603-0314.res6.spectrum.com.
 [2603:6081:7b00:6400:5409:8f3c:5603:314])
 by smtp.gmail.com with ESMTPSA id
 b141-20020a253493000000b00da02a2ef6afsm5844635yba.30.2023.11.07.16.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 16:23:44 -0800 (PST)
Date: Tue, 7 Nov 2023 19:23:42 -0500
From: Tom Rini <trini@konsulko.com>
To: Sean Edmond <seanedmond@linux.microsoft.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, joe.hershberger@ni.com,
 rfried.dev@gmail.com, sjg@chromium.org, ilias.apalodimas@linaro.org,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/3] net: Get pxe config file from dhcp option 209
Message-ID: <20231108002342.GE6601@bill-the-cat>
References: <20231024002159.74477-1-seanedmond@linux.microsoft.com>
 <20231024002159.74477-2-seanedmond@linux.microsoft.com>
 <9a42da8f-2d82-4470-82bd-ef872e72810a@gmx.de>
 <2ed00b42-66f9-4cca-a1a0-ee594840f0d1@linux.microsoft.com>
 <30e83c4b-32be-4e85-aee8-e8b87224a487@gmx.de>
 <b058f5a6-52e2-4e0c-a193-30e884b2463a@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iNvGcfA3Pz7yQcX6"
Content-Disposition: inline
In-Reply-To: <b058f5a6-52e2-4e0c-a193-30e884b2463a@linux.microsoft.com>
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


--iNvGcfA3Pz7yQcX6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 03:50:06PM -0800, Sean Edmond wrote:
>=20
> On 2023-11-04 12:53 a.m., Heinrich Schuchardt wrote:
> > On 11/4/23 03:03, Sean Edmond wrote:
> > >=20
> > > On 2023-10-23 10:54 p.m., Heinrich Schuchardt wrote:
> > > > On 10/24/23 02:21, seanedmond@linux.microsoft.com wrote:
> > > > > From: Sean Edmond <seanedmond@microsoft.com>
> > > > >=20
> > > > > Allow dhcp server pass pxe config file full path by using option =
209
> > > > >=20
> > > > > Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
> > > > > ---
> > > > > =A0 cmd/Kconfig |=A0 4 ++++
> > > > > =A0 cmd/pxe.c=A0=A0 | 10 ++++++++++
> > > > > =A0 net/bootp.c | 21 +++++++++++++++++++++
> > > > > =A0 3 files changed, 35 insertions(+)
> > > > >=20
> > > > > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > > > > index 5bc0a92d57..adbb1a6187 100644
> > > > > --- a/cmd/Kconfig
> > > > > +++ b/cmd/Kconfig
> > > > > @@ -1826,6 +1826,10 @@ config BOOTP_PXE_CLIENTARCH
> > > > > =A0=A0=A0=A0=A0 default 0x15 if ARM
> > > > > =A0=A0=A0=A0=A0 default 0x0 if X86
> > > > >=20
> > > > > +config BOOTP_PXE_DHCP_OPTION
> > > > > +=A0=A0=A0 bool "Request & store 'pxe_configfile' from BOOTP/DHCP=
 server"
> > > > > +=A0=A0=A0 depends on BOOTP_PXE
> > > >=20
> > > > Why should this be disabled by default?
> > > >=20
> > > > Do we really want a separate config variable?
> > > >=20
> > > I expect most won't use this option to get the file path (they'll use
> > > the default paths as per the PXE specification).=A0 It makes more sen=
se
> > > for me to keep it optional, like many of the other options?
> >=20
> > RFC 5701 seems to require this option. Hence we should make it default
> > yes. Boards that have a build size issue can opt out.
>=20
> The PXELINUX specification
> (https://wiki.syslinux.org/wiki/index.php?title=3DPXELINUX) doesn't state=
 that
> option 209 is required. In the abense of option 209, PXELINUX will try the
> following default configuration files (this example is provided on the wi=
ki
> link):
> =A0/mybootdir/pxelinux.cfg/b8945908-d6a6-41a9-611d-74a6ab80b83d
> =A0/mybootdir/pxelinux.cfg/01-88-99-aa-bb-cc-dd
> =A0/mybootdir/pxelinux.cfg/C0A8025B
> =A0/mybootdir/pxelinux.cfg/C0A8025
> =A0/mybootdir/pxelinux.cfg/C0A802
> =A0/mybootdir/pxelinux.cfg/C0A80
> =A0/mybootdir/pxelinux.cfg/C0A8
> =A0/mybootdir/pxelinux.cfg/C0A
> =A0/mybootdir/pxelinux.cfg/C0
> =A0/mybootdir/pxelinux.cfg/C
> =A0/mybootdir/pxelinux.cfg/default
>=20
> If 209 is requested/provided it tries the provided "config file" before t=
he
> default paths.=A0 RFC 5071 should be seen as an extension for PXELINUX (n=
ot a
> requirement).=A0 RFC 5071 only states "The Config File Option MUST be sup=
plied
> by the DHCP server if it appears on the Parameter Request List".

We also want to be careful about overall size growth on common options,
even if someone can opt-out. Those are usually last-ditch stop-gaps and
it's better to make sure we really need functionality X/Y/Z by default,
for everyone. Especially with all of the work going on to make HTTP(s)
based network installs a viable option, how much more do we want to
change the PXE case, for everyone. I'm personally somewhat looking for
the use case to be well defined for a "this must be default". Network
provisioning is a thing, yes, but for whom/what, and in turn how broadly
do we need this to be in the vast majority of our boards (since it would
come in via BOOT*DEFAULTS or DISTRO_DEFAULTS).

--=20
Tom

--iNvGcfA3Pz7yQcX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVK1Q4ACgkQFHw5/5Y0
tywTiwv/TB8UHqi/VS9Pdh582qM9vv/StJSfaTyRKv3aiVJXPHXkwg5LfTxV4TOk
1zEHL0qksiEgT+Mnk/KhS8l04v4iumJI709l3C1eoWb78qsuH35R6zBjJ+zNi8Ml
2xJHQKxhjaLyPE6IioCI7dcaZH8uxLP8bnzJeN7suSrYXAIGvFQmjc2T5CZ5XK10
u+gMLLHFW+tAAA3L+vdfzKQnA1q/rKUvE3fF6lObhySq7DuiKowsJdi3QT/2TvN9
jXmBg+5woNwL/7mxvC2dD30Ge3rEIwTwPI82t/I8x8Ixtdu55W7gDa5l+Ov7DQPe
XyCUYTfUkkVOpj9GwqClDKLIyyQ9GPjbZc+1MODSPW+awrrt1m2VziiiG3YcvFbC
/IYeD9uhmVylKlBNqmo+1ZYm173G8+h5CZD+n7WPRwtxic3FAdAoVc8wD+7NtdSg
P0fZ4U89s2vut95UDY+4RrtyKTyLL19jJUuGMsuN37qW/5A7IdTISb4DoAqrovWY
qFzrOM11
=GIuI
-----END PGP SIGNATURE-----

--iNvGcfA3Pz7yQcX6--
