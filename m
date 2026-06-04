Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848D6CD6E75
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 17:21:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B11684975;
	Thu,  4 Jun 2026 19:21:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IlOfIUdV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B39FC849A1; Thu,  4 Jun 2026 19:21:22 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 897AA8493A
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 19:21:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7e6da33a561so749005a34.3
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 10:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780593679; x=1781198479; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S7nhtSdT35rkxqfbuuK/OE9slicDCB3poYdOWirEbXc=;
 b=IlOfIUdVgSS38QD2PNXAY1B/suLUkjqcfVpGB4kZ4p1VfVxIknVQWsfQNtD5zPc2M8
 LhXDzTTJ1WCjMvTIE3KNUBVTFDm6Kb+EHQLwgMvL5fgnUeh/22KuLUBN4J1Pyt8P86hM
 Ds0mJ3tShoJDXKmLROLZj/qcbHMg3p8l9WHKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780593679; x=1781198479;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S7nhtSdT35rkxqfbuuK/OE9slicDCB3poYdOWirEbXc=;
 b=fA+yQ7d+RFG2/zM1VfSVTzraAoDpMt1qMPXtE7BxrEi3XGCxF8VWEfMR+vZmD4eWXU
 9DyIMoYoy5C4xaK/DSzKAmUAqUADKuouB+h367m2JJLximxU4Yfw1w80bXd0pSs6trLU
 390W7gh8WG6mDtGdCtQraKaBgwh3BEiuDaue4t8VQFfaDYCPvIUXA8zCNoL2f1fz+2vf
 sEVQOI9CnqyXe7xmbmEbwkc1pSpyxBC8YJmkjeD2j7+mBKkSiJ0SIHZokft3b1VTrkHh
 FYkgQiJeHobDvAc4OdkANVxF1+Wg5WaoOUDRr4ndF6AveOqZa9YinzAwUq5dcuBExvD1
 ue3A==
X-Gm-Message-State: AOJu0YwYruQTLUoHfMo1fZLqiaWBlSzxuiL2aj79x7EpYOpRdRKts2kR
 ZYmxWmoDNcs2BxcFTdCJfiZOKb8DSDbCC4d4/KnCOMZCLvjEyQHnqOBGVJaHJDSPUlM=
X-Gm-Gg: Acq92OGoHrJl/2BnEpOqyqUmRe0zmyG+VpDkAi+0kRnnWwVkzCCv5kJ/0AaIkU+019s
 wjhNtPwouozc4sL5hkBqWbl98MwRY59hBffm4iEKyK5IhjfbJkobeZIPE92zsw4JiXHVW4CE9jg
 HDQ6VHqXKNmv7zOekBCyWgaiprfZE9vRaLdQQs9o3xYvYSMsTQ3HRyN+61J02HA86S1fVmCexvC
 Jh5aFcxYlGkpyKq97ANcycRzr3q5agY8AlZczm9F7ItpvPSXD7sCoe6iDE1npR/yrj4hZos51JO
 iANZvJA0x+J8qYG49UsgA8SxwylRNJQcszCucLUTGLTu/12lWucrqfDsTvp9xxbOFbhT7JkyJaf
 OUhbL4pQ+an4Dp5wKYNJs63BjJanFwty4EwUlzj7T7hABE0XCO2pVo/xv6NH7xLtgXS86tUPsZC
 d9y7mEZiw2n6X4gHYOWMuLXQpNnCNFjp1zw0pcm37DUT+HbOgkeYjg+Dc1A+c1qEXLd1RAdtd0L
 KVSz9CRP0fkZI7+RehtjBUysjbaP/+2vnYLV63B5Wbt3AnMG+7cfNG6mmETBw==
X-Received: by 2002:a05:6820:7144:b0:69d:d865:92a1 with SMTP id
 006d021491bc7-69e68c60f15mr9094eaf.46.1780593679094; 
 Thu, 04 Jun 2026 10:21:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-440d8465e00sm5090445fac.15.2026.06.04.10.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 10:21:18 -0700 (PDT)
Date: Thu, 4 Jun 2026 11:21:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Alexey Charkov <alchark@flipper.net>
Cc: u-boot@lists.denx.de, "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Martin Schwan <m.schwan@phytec.de>, Daniel Golle <daniel@makrotopia.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH 0/7] pxe_utils: small fixups, implement BLS type 1 boot
 on top of them
Message-ID: <20260604172115.GV627328@bill-the-cat>
References: <20260604-bls-v1-0-4ce6d1ee4711@flipper.net>
 <20260604160547.GR627328@bill-the-cat>
 <CAKTNdwEt+CpeN8JssJr_JFowXi8yt8QPFg77=OKG0BeOri43MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sQ3RUBjqdhxFcETF"
Content-Disposition: inline
In-Reply-To: <CAKTNdwEt+CpeN8JssJr_JFowXi8yt8QPFg77=OKG0BeOri43MQ@mail.gmail.com>
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


--sQ3RUBjqdhxFcETF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04, 2026 at 09:16:58PM +0400, Alexey Charkov wrote:
> On Thu, Jun 4, 2026 at 8:05=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
> >
> > On Thu, Jun 04, 2026 at 07:31:05PM +0400, Alexey Charkov wrote:
> >
> > > Add support for the Boot Loader Specification (BLS) type 1 boot entri=
es,
> > > as generated by default by systemd's kernel-install when loader=3Dbls.
> > >
> > > Given that the format of BLS entries is pretty much the same as PXEli=
nux,
> > > reuse the existing library for the parsing logic.
> > >
> > > BLS type 2 entries are out of scope, as they are effectively just EFI
> > > applications and should be booted as such.
> > >
> > > This implementation is also only allowing a single top-sorting entry =
to
> > > boot, as the standard boot infrastruture currently doesn't support
> > > multiple entries per partition-bootmeth tuple. I have a proposed exte=
nsion
> > > to enable that and will post it separately as RFC - that enables the =
use
> > > of `bootflow menu` to select the kernel to boot without jumping throu=
gh
> > > several menus with different behavior as is currently required with
> > > extlinux.conf.
> > >
> > > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> >
> > This is good to see, thanks for posting it. One concern I have is that
> > out of 1529 platforms, this would be enabled on 1392 of them. And the
> > size growth is around 1.5 kilobytes. Is there some smaller percentage of
> > platforms this should be "default y" for ? Or is the expectation that
> > something like Debian will be configuring for this moving forward, so
> > yes even something like PowerPC platforms be using this? Thanks!
>=20
> Well this is the config format that systemd's kernel-install produces
> out of the box, and it doesn't require EFI support unlike UKI (a.k.a.
> BLS type 2). So one could argue that any system shipping with systemd
> benefits directly. In my view, that makes it more accessible for end
> users than e.g. bootmeth_extlinux, which is also "default y" but I
> could only find a suitable config generator for it with device tree
> support in Debian (not in Fedora, nor in Gentoo out of my extremely
> representative sample of N=3D3 distros).
>=20
> Happy to make it conditional on whatever platforms find this helpful
> though, or drop "default y" altogether. I personally only care about
> ARM, and Rockchip in particular :)

Right. What I'm asking is, do you know how many distros are planning to
adopt BLS type 1 support by default? And since you're on Rockchip, why
not just use BLS type 2?

--=20
Tom

--sQ3RUBjqdhxFcETF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaiG0BwAKCRAr4qD1Cr/k
ClqNAQDAWx2iR0ffp2hUWaNx4JSweC4X9uiJjvvj9fNhS7uRyQEAhfwNuS2Eh6RV
OflAGLeqeYr2VkuC68Q5hPgYggC/Ogo=
=js57
-----END PGP SIGNATURE-----

--sQ3RUBjqdhxFcETF--
