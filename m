Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D63AC54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 14:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE47E88076;
	Wed, 20 Mar 2024 15:51:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jLi9VVNv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D678488079; Wed, 20 Mar 2024 15:51:30 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A06C588033
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 15:51:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6e6ae6b56ecso25154a34.3
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 07:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710946287; x=1711551087; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=muD9Oeg4Bkspxs+DBaslspq/DZyMwhj93lX0Ww3IYsg=;
 b=jLi9VVNvA1N70IBteSCIgmOzi5tBLIfm5mP5HfsJ1Z7KIpdtI6b2FLH5qJNy7cTR6k
 MmyHxkhRVUe9yZkdlIK3hP0BTV91/BOaLXwEBwYhmmoK73ufIUSB3pUg/5jD27skiXge
 R2ArVASYPIv/UB+cu3QkD9bRWCRo+meYq56y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710946287; x=1711551087;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=muD9Oeg4Bkspxs+DBaslspq/DZyMwhj93lX0Ww3IYsg=;
 b=cFPSg5uaJF0tGXEKRt44dZIDb6XE+Kck/CwgI8Z0DU9BzG8/WbiHr/lj9E/xjvKtag
 9+lpz+CEwuQIHeZVn19HNIFYrg5Dk3MOYPPcmA1nn9FT7ddpPOL1YvDjLOPrSAGEATfi
 g6KnB4Evf6YgDVEibRKMfd6x7RLv0ocL7/BVm3qh4bzRjHFVywpB8og253TRaoqmoGC/
 jWCjAY8z2uGHjoXj3i6oIc/yTcdewmm4eB8PFCXaXStaslWPfOoYwj3AS3RrcOwVfYaw
 LZwQJMO50y8R/vPrulwlBkqZbOYLpEFzUE6Mi4wlRmEYzHH/ogp3KgsduiWBAoTg97iR
 vpuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfzzWL9g6Kellwl7L4/xaD/stasOjJ6MubEqvjTJ82xkkjkeWzc+mKoQ2GcSKudCvQWbqIWORWF7QoZiJab+iup17UXw==
X-Gm-Message-State: AOJu0YwsTA9bD94bbRm6wgUcGenMbVbK1OQMMR3SV0DyYIgb0Dx43W1d
 PXaP1DAHcd9P2116VoBDsDdFh+pUzVAqBefEsnTYOozek39oIAdc2Y+tR+Ls8wo=
X-Google-Smtp-Source: AGHT+IFLQPxnZhP2/0FYqSTKc8UeLLnPATuZ1j/v+/z/TPFKHKTU8Vn0tD+KUbGQLqS4y+jR0DafQA==
X-Received: by 2002:a05:6870:d611:b0:220:de23:85f7 with SMTP id
 a17-20020a056870d61100b00220de2385f7mr2308296oaq.48.1710946286891; 
 Wed, 20 Mar 2024 07:51:26 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a37e30c000000b00789e72b27fbsm5066022qki.120.2024.03.20.07.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 07:51:26 -0700 (PDT)
Date: Wed, 20 Mar 2024 10:51:23 -0400
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <seanga2@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>, peng.fan@nxp.com, ye.li@nxp.com,
 u-boot@lists.denx.de, marcel.ziswiler@toradex.com,
 francesco.dolcini@toradex.com, hiago.franco@toradex.com,
 joao.goncalves@toradex.com
Subject: Re: [PATCH 1/2] clk: clk-imx8qxp: Add LPUART IPG entries
Message-ID: <20240320145123.GV3442575@bill-the-cat>
References: <20240308201316.1721909-1-festevam@gmail.com>
 <CAOMZO5Aa_EaTtL9r7k0P7CaJQ0fixGLJSR3WvxHAD2=5RJdncQ@mail.gmail.com>
 <20240319190450.GI3442575@bill-the-cat>
 <569b832f-8fcc-9515-40ae-5590b1456f02@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UgsxS7Fw0PX7WX6d"
Content-Disposition: inline
In-Reply-To: <569b832f-8fcc-9515-40ae-5590b1456f02@gmail.com>
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


--UgsxS7Fw0PX7WX6d
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 10:41:51AM -0400, Sean Anderson wrote:
> On 3/19/24 15:04, Tom Rini wrote:
> > On Mon, Mar 18, 2024 at 09:14:53PM -0300, Fabio Estevam wrote:
> > > Hi Tom and Sean,
> > >=20
> > > On Fri, Mar 8, 2024 at 5:13=E2=80=AFPM Fabio Estevam <festevam@gmail.=
com> wrote:
> > > >=20
> > > > Since commit cc7df0b9e8bc ("serial: lpuart: Enable IPG clock")
> > > > the colibri-imx8qxp board no longer boots.
> > > >=20
> > > > The reason is that the imx8qxp clock driver does not handle the
> > > > LPUART IPG clocks inside get_rate(), set_rate() and enable() functi=
ons.
> > > >=20
> > > > Fix the boot regression by adding the LPUART IPG entries.
> > > >=20
> > > > Fixes: cc7df0b9e8bc ("serial: lpuart: Enable IPG clock")
> > > > Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > > Signed-off-by: Fabio Estevam <festevam@gmail.com>
> > >=20
> > > Please consider applying this series to 2024.04.
> > >=20
> > > It fixes a boot regression on imx8qxp and imx8qm.
> >=20
> > Fine with me, Sean?
> >=20
>=20
> Acked-by: Sean Anderson <seanga2@gmail.com>
>=20
> Can you pick this up directly, Tom? Thanks.

In my dont-forget bundle now.

--=20
Tom

--UgsxS7Fw0PX7WX6d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmX69+cACgkQFHw5/5Y0
tyxVJwv/cb+lyYkVTaFAtPeF52njGsfSuOcAaIOzoH2eUKkKGG1CFrj9PUhxc/CL
GdH1wT8gHlk2vtAIg7m87jzbxvkjsM20BH6xyFmcHaY6D8HeojZTzyLdzFg6k3I9
EA9t8c8zc2hQhswdYRdIe+7g5D9YFxFq5qKqrUDzX2i+WL3tyOcq5ixysWlDQn95
aAX25ALVzyYKuejkyv7m5jjtz9NUHMFwZFbynbXYdAmSYWHDT+3FoMMYunfmJ6MN
Ajec9IhJ5B0O9bSty/YzHXV12nc3DSrof37sN7Zo9sAxXmS/6N2pdzid+HNoLBHR
EYKkAD2+324y4TBSX7ITtBKWQKL1OU71nYGXq8uG43DgjJYaVdLgCIAncMqMBOsf
eKgCTP7RGJdcpxT2ZLS2izUYhevttwVeWehO+kHDx1YgA4y/ot5XGr6MaE/sjQo8
pFDJUhyLfZw3ll/Hp/USoK7eB2QKkiMo9F+nBigOdDonxAnN/Fek2nnIWG5RmtRo
bU4XeUBl
=N7xM
-----END PGP SIGNATURE-----

--UgsxS7Fw0PX7WX6d--
