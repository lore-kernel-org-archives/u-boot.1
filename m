Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79178C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 20:10:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFED8805C3;
	Mon, 24 Feb 2025 21:10:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fYvV6qkW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65AFA807B1; Mon, 24 Feb 2025 21:10:15 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A952F805C3
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 21:10:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2211acda7f6so108378235ad.3
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 12:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740427811; x=1741032611; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UR5MVNdjY7b4Wy3j9mCnTcptiF+wRcp2bDy3yZe+cas=;
 b=fYvV6qkWV/iLrT1jrnFR3MrEH17CdXprs+pVr+zF133646v7N3dj4qxvKIx7fz8TpV
 bQH8p9dtNZM4sgLCfWVRPypB6xSjbe59mmLo6vzW4PzJUmpNTvPp2XTkvNAO4ASNfywy
 V7gDcepLHbKkN8yTNQuyBoQtn1TjnL/EJH+oE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740427811; x=1741032611;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UR5MVNdjY7b4Wy3j9mCnTcptiF+wRcp2bDy3yZe+cas=;
 b=WSTfbDiooeASCklnW9m6G4JcYyAwyL+OqcYObHf8b/MczHO9/aAP+b2orzqjiNVWWj
 WtNbScy2LrazupC6Ah3WTEyyPpQepDwYmjGPjKs9NHqyz8RNT3L0B3Jyz/Mufu+15cHV
 cmIh3tiXXMlb3Q9sLk57aDH58ECkANwFsTPHx8d9qJv3LdG19KVpDGEnVrv5lqhwQtip
 dKh88mmVU5Jc02L4t3qH9+7K53QMh8bAhutAlyITOXIK+dGqoNIGqHE5wiUd6J3djEAJ
 ddCK1233QNLnmRgTBTbo/mr2aw//xi+IxfczBgTiCm/tnVCLYqPxRw3GnD3eCKnkuFbg
 lJ1g==
X-Gm-Message-State: AOJu0YzLHTZ+ULULoQWYIPpyTgx6sHNsxZ2Vw1U+kDSkChlvvMUxX9Vn
 kbLr7i38+ttxsiHlRZQLCxVRKkOTkB/+BVNxK3gU9NSn2m2SWRvnh3XXtYh5Wyw=
X-Gm-Gg: ASbGncux9A8JOjY7z2Fb+4hueZLQfL89ewXeNjnWmFI67Mjr3b2pJG+xVLA9DOHWMl/
 UAtEi9VGiWRcNXdrFyY0HmVwNpjFRHmIoYW107JTBlqxOLpNC+eDuxY47Sir+zjLuLoXEOjoqxF
 bvyB30oH1ufiTN/NYKv1Pyjf9nMT7Q+7mNCMT0Y55cKyPDiHDzfyh1Nsx/tcv/jK1Te62lWqKz8
 9NRRAI8PlAm73iR7DaK7ttZIwnSMKJLt6phhFJf0FrVZ5VlDjLj29CyHBVPyqEv5B7uArDqd12c
 aa+sx3WvQnsqFQa+hNfwJaIq
X-Google-Smtp-Source: AGHT+IHiJuLSJ2tO+O8eico1Z/3PxFez97o7VA2k8AeN6rwJelStencLqyhrSpQFlChxMlWrBdrDCg==
X-Received: by 2002:a17:902:d4d0:b0:21f:8453:7484 with SMTP id
 d9443c01a7336-2219ff61d6fmr237741885ad.30.1740427810807; 
 Mon, 24 Feb 2025 12:10:10 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7347a83cd78sm35049b3a.176.2025.02.24.12.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 12:10:10 -0800 (PST)
Date: Mon, 24 Feb 2025 14:10:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: u-boot@lists.denx.de, paul.henrysd+nodisclaimer@gmail.com, sjg@chromium.org
Subject: Re: [PATCH 0/6] Add preload_check_sign tool
Message-ID: <20250224201007.GH1233568@bill-the-cat>
References: <20250212093126.3722186-1-paul.henrys_ext@softathome.com>
 <174015949809.3526942.13114735137909191703.b4-ty@konsulko.com>
 <20250224163147.GA2318847@bill-the-cat>
 <7bbb19ec-edeb-4159-858e-d5738b563565@softathome.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8uYtYYN1zL9iem/x"
Content-Disposition: inline
In-Reply-To: <7bbb19ec-edeb-4159-858e-d5738b563565@softathome.com>
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


--8uYtYYN1zL9iem/x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 09:07:28PM +0100, Paul HENRYS wrote:
> Hi Tom,
>=20
> On 24/02/2025 17:31, Tom Rini wrote:
> > On Fri, Feb 21, 2025 at 11:38:18AM -0600, Tom Rini wrote:
> >=20
> > > On Wed, 12 Feb 2025 10:31:20 +0100, Paul HENRYS wrote:
> > >=20
> > > > This serie of patches adds a new tool to authenticate files signed
> > > > with a preload header.
> > > > This tool is also used in the tests to actually verify the
> > > > authenticity of the file signed with such a preload header.
> > > >=20
> > > > Paul HENRYS (6):
> > > >    rsa: Add rsa_verify_openssl() to use openssl for host builds
> > > >    image: Add an inline declaration of unmap_sysmem()
> > > >    boot: Add support of the pre-load signature for host tools
> > > >    tools: Add preload_check_sign to authenticate images with a pre-=
load
> > > >    configs: Enable the pre-load signature in tools-only_defconfig
> > > >    binman: Authenticate the image when testing the preload signature
> > > >=20
> > > > [...]
> > > Applied to u-boot/next, thanks!
> > Unfortunately this breaks macOS building:
> > https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D10614&view=
=3Dlogs&j=3D35eccd4a-c7e0-5052-1111-1aa0b6b36326&t=3De725091b-e4d8-5b5a-ef2=
2-f51d8214ad12
> >=20
> > And so I need to revert this from -next, sorry.
> >=20
> In the pipeline, I see you seem to be building against openssl 1.1:
>=20
> /usr/local/opt/*openssl@1.1*/include/openssl/x509.h:962:17: note:
> 'EVP_PKEY_get_attr' declared here
> X509_ATTRIBUTE *EVP_PKEY_get_attr(const EVP_PKEY *key, int loc);
>=20
>=20
> OpenSSL 1.1 is deprecated and I based the implementation on OpenSSL 3 API=
s.
> Should I update the implementation to also support OpenSSL 1.1 APIs?

I don't know enough about what is / isn't safe to assume people will do
for macOS to say for sure. We do this to setup the environment:
brew install make ossp-uuid

So if we should instead be saying something else to install a newer ssl
via brew (and update the flags in the build line), that's fine too.

--=20
Tom

--8uYtYYN1zL9iem/x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme80hQACgkQFHw5/5Y0
tyznAAv/Qaq6rd66F90AmesweGzOmVjdpp1u4fONSIIhj/E/Y3xnGKeafe4HdTun
9QPlVZN30MUe27PFZXH/ORuGZd5xWfHIKYpqoMYqTydjr8nGeZa4KofeFi49sx1X
PpbL2+WqcyJfUgmrP2weSRXWHVyKtY2z7LD2t1IuhmcSvxDoARdPCs3/ZjpxcHRh
4SvbVs8XyRxxgtST+yom7xq/jhu7GWctDStr3cutFN0EBpDInFutFYhR9BjEw7DY
lfhvmKgusQbPpcEVLKeRKweqYHEfkTKJP652wh5xy2+XR4cPqJnVE9iQb3tVn2OI
ftEyZccHbZTRw6zbLs//d1yVxsCEsK0nQEI5gsB89hmgCjrbN62m0oWEWg5FQstT
51Yam8keHo4PWANaHa0yv1Va/WklqhfZGXAt8elMhftI7QyhrdaaYe/UNr/cQFqS
QStL7uwGgEMDwVbvfy7XrZRyorlGKefJk24kjuTlfqRwkWSbrhig5ejFkHRGe3Xm
mObYWAyU
=lKMH
-----END PGP SIGNATURE-----

--8uYtYYN1zL9iem/x--
