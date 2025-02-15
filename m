Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C9DC021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 14:51:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2132D80EBB;
	Sat, 15 Feb 2025 15:51:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IWJEV+oj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDF1680EEB; Sat, 15 Feb 2025 15:51:13 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9016980C6F
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 15:51:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6fb609bfca6so2217137b3.0
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 06:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739631070; x=1740235870; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gzrwleTeU8XwQMIYTbmhJfHvvSp/jmyFLEcEIdusTgQ=;
 b=IWJEV+oji07EIZtD0Bc7d39FmI+GLSKV+vVBDnbq3DAzdOsbjH+BxrmjOOREflDgyo
 J6Dy0m29S7SGue0eV1OjyKnjrjcmDv+I2F9C/9Q2Cn4rqh3OS6/LK4ktMxMcSZpV4UQP
 i1LuCuKokm12v4CIyQ4dwG2HdmQJyi8uClTFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739631070; x=1740235870;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gzrwleTeU8XwQMIYTbmhJfHvvSp/jmyFLEcEIdusTgQ=;
 b=Dcjk3b5hUx7kdOWbZ5B+QE2R8vShpeX0yVQvyCovIUInGPaPc2GKkOxsl6faORiFhB
 EEmeq9dJ5MjNCINI1LPfEShIEvJjO6AXLYgbm5DVouABNLbKIhpXQSK+eD9l/PLOD1Yl
 9P3/xPtuI28oRJmCScGxP1JpN6nNJyqxGqIzqDzfqmMBQ+eRc6CuxT12HV2gJEeViSDF
 ZLWO9rJLdvTKQrJRhVRjJlYsMQSHbEvPtKD6u7T474TMyJrsF8cO9eLL+Od6Yjmasx4t
 757bM3HbBjFtK4qRtkjbttuF2q1sMhiaPHCOmg9/bW+op5j6oknIh80+tpBQOmCyOzUz
 vdBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB+SBcl7gO9cBe6b5dDcar6CabqZLE+dGyB7IwtK9mSiqlHLtm9clIt45Ia/kfyh4CgJQc5xg=@lists.denx.de
X-Gm-Message-State: AOJu0Yyp3yq5Uz/5Q6azcf93l19ITX01Gn2mMTENTs6lggiHjIyLsGsF
 GLeBswJow3g1rzuNzfbxPB9i7icm7yCL8o5Kt0QSBXPc50YiUmCcr4uVhLCFljx3nzDz6Alw+TS
 tQ3w=
X-Gm-Gg: ASbGncspNc0LcJ4NTfibVdFmCML6QyaJ1DnEbmwVmK2lFzKR3mWlayAAJzuRmoe5r6B
 i+QLSzY4KkQ781vbZ1GSToyzLI/XidbdVfGqMSsEesgfi+iXoa+x04tZ05iac+lxEVG0oQejrBa
 G3b/Fm3eZtLgEvS8NRxTQOtW3dR4GK3ZftHqkg+61DtZljGP0xqjB/ffG9c/XTjwwJjfH98PPjY
 usH+/WYGgpaWzUBnLNI7+ClhhhCR7SJCCKKZIRYbTvvgKwBkHl/p9eBCeGQ+s86TJfYOJJmjP+2
 YXmwMMn1F8/s5A==
X-Google-Smtp-Source: AGHT+IEOy+xASvgXQeyYoEF3pdqKPm7B6gtW9KJevnnqhRCu6rK9Qv66TUSz3tUY76RQg7dWRvuvGg==
X-Received: by 2002:a05:690c:25c3:b0:6f9:4f93:c805 with SMTP id
 00721157ae682-6fb582a7776mr29084237b3.21.1739631070399; 
 Sat, 15 Feb 2025 06:51:10 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fb35d5870asm12399617b3.10.2025.02.15.06.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 06:51:09 -0800 (PST)
Date: Sat, 15 Feb 2025 08:51:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 07/32] scripts: Update build-efi to support arm64
Message-ID: <20250215145107.GP1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-8-sjg@chromium.org>
 <EF141676-AFAA-4E88-925D-D504426DDBCB@gmx.de>
 <CAFLszTiC1V3D+WeZStvjwRKhQv6xeGWHPC7xnFBrPn2NTtWMNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="n5FaLYfmaFCIT5hy"
Content-Disposition: inline
In-Reply-To: <CAFLszTiC1V3D+WeZStvjwRKhQv6xeGWHPC7xnFBrPn2NTtWMNg@mail.gmail.com>
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


--n5FaLYfmaFCIT5hy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 05:05:06AM -0700, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Sun, 9 Feb 2025 at 12:05, Heinrich Schuchardt <xypron.glpk@gmx.de> wro=
te:
> >
> > Am 3. Februar 2025 18:42:00 MEZ schrieb Simon Glass <sjg@chromium.org>:
> > >Provide a -A flag to select ARM instead of x86. For now, only the app
> > >is supported and only for 64-bit ARM.
> > >
> > >Signed-off-by: Simon Glass <sjg@chromium.org>
> > >---
> > >
> > > scripts/build-efi.py | 49 +++++++++++++++++++++++++++++++-------------
> > > 1 file changed, 35 insertions(+), 14 deletions(-)
> > >
> > >diff --git a/scripts/build-efi.py b/scripts/build-efi.py
> > >index 3a1bf180ade..1ba37e86e88 100755
> > >--- a/scripts/build-efi.py
> > >+++ b/scripts/build-efi.py
> > >@@ -48,6 +48,8 @@ def parse_args():
> > >         epilog=3D'Script for running U-Boot as an EFI app/payload')
> > >     parser.add_argument('-a', '--app', action=3D'store_true',
> > >                         help=3D'Package up the app')
> > >+    parser.add_argument('-A', '--arm', action=3D'store_true',
> >
> > Why have a flag per EFI architecture?
> >
> > Please add a parameterized flag instead.
> >
> > --arch i386
> > --arch x64
> > --arch arm
> > --arch aarch64
> > --arch riscv64
> >
> > and get rid of the bitness parameter.
>=20
> Tom has rejected this for the tree. I'll apply it to my tree and then
> deal with this comments with another patch. But I'm thinking a
> contrib/ directory would be better.

Please stop posting things that are only ever for your downstream fork.

--=20
Tom

--n5FaLYfmaFCIT5hy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmewqdsACgkQFHw5/5Y0
tyyMBgv/crDk6SqUFzsj/AcvH3OW4w5J5AX7Qq1hjlYtWDEIFAUp3BMEz/9+XQxa
zmmZCDX+NSs/piG+YUZReLM73Npkrm098/cnlqbhpQCKk9T238SzdE7EtKEvazgF
dtPE4R2SOnkh0nAA/NL+bPqwMYRu/aTmdCEr+sE9AogyhhDjObJC53g3WQSv68zC
h5hQwflulYvKFdiYGfBpWRNpoeVgzriPyUB+vzi8txhmmzdGhSVaBoHww+2gdnTV
WWbBint0LQ1N8Ok+f/tCMbD6RcPcuQJogr6lGtSU21ZQ2Pj2G/Z4gBkx5C35gqEZ
wsiuEVZr7s+/NTXt2ePeJ7Tb5GSlClkvVPnJov3R3xyIlUy7z2uLeMFnPM5keBIK
sTl5WsNhvF1W5jIRrv74rT37DbMXqneu+IacPhvB8BYn94Vf+8kYXEqjQY3GBihU
QSR8KV6LX854Axlwtq+W/q+hJsHbKSLgLmBYJYVUbI3FNbjR8MQ5kCztxsycLtez
GEg+XH3+
=+jUv
-----END PGP SIGNATURE-----

--n5FaLYfmaFCIT5hy--
