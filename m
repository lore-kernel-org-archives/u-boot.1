Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96ED2D3A672
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 16:36:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D001F8887A;
	Tue, 29 Oct 2024 17:36:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BMxj6LdX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 511CD88E81; Tue, 29 Oct 2024 17:36:49 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 337818857C
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 17:36:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6d18dff41cdso16679696d6.0
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 09:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730219806; x=1730824606; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TkYUAWQontgHuVf56xMZra4BkkM8CN5V96LdS/wAmec=;
 b=BMxj6LdX9gJ9XOFcO+/hmutEMgfDY1d8rIF1GgIDx1G5ANAlpEmIKx7o5J0zwxdCRK
 6/E4ZRpAyT2cYJ3p82KGguVyCmMO7M0wZtn4sjMMa0paGLM6Hc5c04tK0hyg0HjN7Jar
 vjUSRjl5awou826x5lLyFpmnjaYsQDa6EBiyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730219806; x=1730824606;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TkYUAWQontgHuVf56xMZra4BkkM8CN5V96LdS/wAmec=;
 b=TD40Slr5VFZ+9LdqLnSdP+ToZYye1HJ+WQlrfY/ETAnh8WoOK6GValxMDdJBBbrBPF
 0YNhtS9Q/dYCvk/wLPSDb7RA8cb4XM2yAhEGQGzovL0dz7tiJEJWiEyu7KJSmJjlwnWT
 dkI3i7bkAGYHa3aEwsy+MyI3vfACou/NnsSQjJHCC3eaIbwxN/W7bxn9vts5PQM4D6Sk
 HXUKB+AlvIo5bZN+T43qqL6HX0jj8vu3tX/l/eygNpxdo+Q61irEE7ZUOuBZgnn1y4Ns
 ZhP0sXDPUJOW2D8Z9fRR+n6l1eQD1rVPDXzkpKqV/rlBicjCSFGUcub73amYq4Qr3un+
 42TA==
X-Gm-Message-State: AOJu0Yxloib3HC0J3Vs6J44NqlKW/HxcBrKSPnDDBczWcj8XE5Ecioao
 Tpis4SkPyn/s6iQmaOBIq6RYMFPcY6/f7vt6GOZHnElN7X9EKYUFHWkbB32hfKU=
X-Google-Smtp-Source: AGHT+IGcJp0aYQvnDaOFhpEgpbrpJu9YOJPWOKVQ6VKq7uy5SSLptWxT1glBT0OA6pzGeisQmS7DnQ==
X-Received: by 2002:a05:6214:319f:b0:6d1:7630:fd01 with SMTP id
 6a1803df08f44-6d1856f3a86mr151305266d6.25.1730219805845; 
 Tue, 29 Oct 2024 09:36:45 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d1798a8448sm43465476d6.38.2024.10.29.09.36.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 09:36:45 -0700 (PDT)
Date: Tue, 29 Oct 2024 10:36:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH 03/21] bloblist: test: doc: Move into the common suite
Message-ID: <20241029163642.GA4959@bill-the-cat>
References: <20241028124130.32072-1-sjg@chromium.org>
 <20241028124130.32072-4-sjg@chromium.org>
 <20241028193310.GS4959@bill-the-cat>
 <CAFLszTgHHgBPByBdBxGWPpJ0tTkoTfZ=aN3MY80mFBR+CujvLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RExodshF3OsyVBWr"
Content-Disposition: inline
In-Reply-To: <CAFLszTgHHgBPByBdBxGWPpJ0tTkoTfZ=aN3MY80mFBR+CujvLw@mail.gmail.com>
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


--RExodshF3OsyVBWr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 04:45:40PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 28 Oct 2024 at 20:33, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Oct 28, 2024 at 01:41:08PM +0100, Simon Glass wrote:
> >
> > > There is no particular need for bloblist to have its own test suite.
> > > Move it into the common suite instead.
> > >
> > > Add the missing help for 'common' and update the docs.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > This feels both like churn and weird. I would think "common" tests are
> > for things that are kinda legacy and too catch-all to have their own
> > subgroup.
>=20
> It's just chosen so that the test for common/ is in test/common - i.e.
> it makes it easier for people to find it.

Then I really don't understand renaming bloblist from something
descriptive to common which is not.

> BTW this series removes all tests from test/*.c and moves them into
> appropriate subdirs. Some of the tests are quite old so have just sat
> there all these years.

This is good, yes. But perhaps needs a bit more thought then about how
strong a mapping between filename/directory structure and test suite
name there needs to be.

--=20
Tom

--RExodshF3OsyVBWr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmchDxIACgkQFHw5/5Y0
tyznlQv/SSd83E1FzY4WQ820kmJIcdPaGOJSFQn+j1/jB+1kKPBuPelpzUOJHIGc
DyfGOPQd2jZ8lDVCaH5MZ4QrpPx5lBMK+usoVpgusM/a0xnM662oyIJ9jO6I2v+K
8vhjTRGbW04nHsqXVDknUNOx42I2gi2pyxGKrj4gOSQ4vIiUjARFM2CAmbi+Ud1n
xbusMNWk3VPkvyLdY+rd/g//1nt+K0pEQgrsF2tIhG92md7P4355ddihnlig9uVC
0H4OZTILOou4db/tEKapo42USoDXQxFtoRjtKySy3PRBZAG95Sy6cQmdxANzQSab
yxm2zrrBqTawhto9dyDNxDlTS6u9v9Ieqt/mmkCDVCNNtj/Rp2d2MoYyrgomJt+2
rvyRR3mlc4heAQuOLvImbe9xBiiFlIqUqVsBFDQMkXtXhHwsYTMkXxGphGToS1xa
mGEYg0G+/S7eMQWyuql+Lzf8HvymWOIOzWB4nNTee7eICEWEGvsV+Em5+S6aTHsX
ZLoFuZeo
=blH9
-----END PGP SIGNATURE-----

--RExodshF3OsyVBWr--
