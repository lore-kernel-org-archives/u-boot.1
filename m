Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFCFC4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 18:15:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FB388744F;
	Sat,  9 Dec 2023 19:15:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bUPWqbwb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C2FF87632; Sat,  9 Dec 2023 19:15:57 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0DA887215
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 19:15:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-db547d3631fso3381843276.1
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 10:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702145753; x=1702750553; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tyYjHmayoJb1IAW1gN6JovMi1Q53Qhh0dloct0BM7QU=;
 b=bUPWqbwb84jsSNHOoDyxrZ+GBhOACuBGV0K9xB5c650745J5OMtfDSiL00GoL1rXGo
 SMXjHXUTIojfbcwPQK+4vKyMJOISfnx0L2xVHjgT9zOjmhFblP3oQshqYuxZaHx4h0J1
 Arv9U751qB/ijFguilbzwutr/YR8xOMjaMzM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702145753; x=1702750553;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tyYjHmayoJb1IAW1gN6JovMi1Q53Qhh0dloct0BM7QU=;
 b=N08S0ZtKnn4g1ykQuQViXpKSY4Siu6bobvGBrhl8pPSjzqeYYUUaAzVZ/J3jqyT5Oz
 ZGBR7FOqIkOtMeVHSP4u2E8Cy/t9LI6ra52m9FTgztDNvCqFU4EocgfrCYNzsy+6VLYH
 gQWbWsEWUMsu8Zy9A0c3Es9zPnBGmD5iXoHS/DMvHk4NXrXHyXTC358FSr/2NXdGv1XD
 qgrZEz6g67mnd/n8874drnYM80NSsAMwdSjCOPdJhUmh9gNmsGhcqAQTyailjYz+N7nq
 Y+2SW5UO8pe8Ho6OWY7iBd7PBBCNaNkpNMPr5rpnl/GLo7X7cY0Bs/ZLnmquXM1eR0nM
 EUJw==
X-Gm-Message-State: AOJu0YwGcDQlnres3Tla/59kmEDL2bXFgwhY8TN7mp41AUn+Ag6uOE1U
 GH9uaapeE15FfwXHm97bbmIr5w==
X-Google-Smtp-Source: AGHT+IFIo0YQOVfzFHxQ548WvOqbnW1BAh5eTzj6Yasp9KCIDHqlK4BOUzQXD9WSoKLY4sctDRM5+g==
X-Received: by 2002:a25:dc53:0:b0:db9:8f6d:f499 with SMTP id
 y80-20020a25dc53000000b00db98f6df499mr1263404ybe.48.1702145753030; 
 Sat, 09 Dec 2023 10:15:53 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 13-20020a25040d000000b00d7f06aa25c5sm1421912ybe.58.2023.12.09.10.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 10:15:52 -0800 (PST)
Date: Sat, 9 Dec 2023 13:15:50 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Shantur Rathore <i@shantur.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v4 0/4] bootflow: bootmeth_efi: Fix network efi boot.
Message-ID: <20231209181550.GR2513409@bill-the-cat>
References: <20231119165501.1305136-1-i@shantur.com>
 <CAHc5_t3MwUvFdQQaZGeONxS-JNuB4mYXyU9YSexN8bCbQUTRYQ@mail.gmail.com>
 <CAPnjgZ3umb6g3O7r+bNtCpGihFHoq9Yp3Fnq9Hd-VkQvewX0oQ@mail.gmail.com>
 <CAHc5_t0+o5FvgpLUDAWLq6932fapzVDy=+47LQUcsAPT-3arWQ@mail.gmail.com>
 <CAPnjgZ0g2wgL=baD=LUmw2tK-E0tmUpoRaDE2oYNDLw0tum99Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oIUNHxQzOMOVjcfR"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0g2wgL=baD=LUmw2tK-E0tmUpoRaDE2oYNDLw0tum99Q@mail.gmail.com>
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


--oIUNHxQzOMOVjcfR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2023 at 08:54:51PM -0700, Simon Glass wrote:
> Hi Shantur,
>=20
> On Tue, 5 Dec 2023 at 04:13, Shantur Rathore <i@shantur.com> wrote:
> >
> > Hi Simon,
> >
> > On Tue, Dec 5, 2023 at 12:52=E2=80=AFAM Simon Glass <sjg@chromium.org> =
wrote:
> > >
> > > Hi Shantur,
> > >
> > > On Mon, 4 Dec 2023 at 05:38, Shantur Rathore <i@shantur.com> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Sun, Nov 19, 2023 at 4:56=E2=80=AFPM Shantur Rathore <i@shantur.=
com> wrote:
> > > > >
> > > > >
> > > > > Currently bootmeth_efi crashes while doing a network (dhcp) boot.
> > > > > This patch series fixes issues and both network and disk boot wor=
ks.
> > > > >
> > > > How can I help to get this patch series merged in?
> > >
> > > You can check patchwork [1] to see who it is assigned to. I don't see
> > > it in my queue though.
> > >
> > It's with Tom Rini I believe but with status Needs Review / ACK.
> >
> > https://patchwork.ozlabs.org/project/uboot/list/?series=3D382855
>=20
> OK, well it has a review so that tag may be out-of-date.

OK, so you're happy with it Simon, so I'll grab it for master shortly.

--=20
Tom

--oIUNHxQzOMOVjcfR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV0rtMACgkQFHw5/5Y0
tywEaAv+O9rEJGPS8rWG0bHtbeEozRbmcupWUEVuHZvsPQ+QNbRVz2WdCCu6Fq9p
ZZuVM+VVnxPG8NL3Jho0Huzuefp67W22Mm/aCVPmjWCV11tfr9weExJQ8m/ibyJn
4CYnhwEMkIGEjrjpoSSvWZ2ZalSceChLyxODSQ+YbBqeGX/B4dR/PhrSFavfa6Fw
AT8T1uUCV5HtuZkuoMebf+pi/b9mAeeSyYji4z8MhKKRWPMhcK8EwWjfu0S9Guht
N5ilyPFDIDx5F/h/b8M797cCkU+Zex8XaSCQupp86chv7FnRX8f7oCGKuaXMUeJl
AxLCmZeGtlomqVslCCsdnCUc2VuEFAE1wIsushn4B2GgTiNyxGdiB4VQMnGY5vMp
2W+KaJwWKEh+3GSGSdDpkgkuq6SGnrliU1BYneUUyUzqoPGZ/Z5yxm0rFrS3pf+I
qwySi28H1LWS317KoENfstNuUh01B1fp7ZYq0AeE+DGPYrmakLH33bg6vjBivRqG
jxoEb3Wl
=Q6rU
-----END PGP SIGNATURE-----

--oIUNHxQzOMOVjcfR--
