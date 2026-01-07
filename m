Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0488C47BEB
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 00:15:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0294B83C08;
	Wed,  7 Jan 2026 01:14:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="O62pd9su";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F92583C4B; Wed,  7 Jan 2026 01:14:58 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE022839DE
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 01:14:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-3ec5df386acso1096096fac.1
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 16:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767744894; x=1768349694; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Eb+/J+RrZmmoLOkWmI6BxER9NDdGwzDNg6pdqXkVv4I=;
 b=O62pd9suhUUxO4/tWTuBUU83Hl405qaNK3SQDQ1mCh+TZnbV5OI3Io9Im8Y+WJK9yi
 9Wtjz+oWtEp10h6+lIAhcMkFR/j60QMZovHkYhw0R/qqFRgzATkbB2ycGRxGICEdPzZa
 j74YD9cr4Z8iYOxuzaBx/HG1xDclJyTJZIIJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767744894; x=1768349694;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eb+/J+RrZmmoLOkWmI6BxER9NDdGwzDNg6pdqXkVv4I=;
 b=puIikuw9CQmlZqEDxDETdZ7hY8z80DXt60nHNCWrQKlvXhLEqK6BYA4kRuBgeMKR/k
 bk2hKJPlkrppSsLusUucg+S+VSOpV4zlmv8S5IXOa5ORFBKAGXQgiYZKNAgqIOdfnsAy
 p5tdjz8zMubLdU011yMgcZ6SYNbVFYNixdJDJONX34OvznLmR//1QFaITwc1udhq8O4M
 xzYQCEtbL/IH3GwEncTDqdIADGUcAD2rETQkwCzbjs7HKEOgQP416pXt5tUYno2U6RhG
 1OsTrk5LMjZg0CeCphJl3d/CnwbH5lHph9LHeb7XtNXqKq+R+VA8f8lL/OZdvSQUWicB
 syhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9hxPIalAUHd/IwMkQYOTYOJZ2FRyR2eKxeFh2Kt1q26vBWnuQpCfI1VU94es85Fz1HOFxyug=@lists.denx.de
X-Gm-Message-State: AOJu0YwOuN4f/DFYAebP9Ui5herxm/tXEsCUNbqRIZuNTyypnXZyHrCg
 dg+7W8lopbPnckpa4m/8FeVRE61UGrS4KO8atia8CKHRXn99RGwcRKYACMr6qKRaZIA=
X-Gm-Gg: AY/fxX7I3Qq6lbKPKPqDSU4JVANCmVchBw5bdMYdp0NytesnbGPhU9qmZsKD+mO3Pqm
 VyM5phRNiEYZLlD2BerFYdPx8IS1dKOAJb2TK+wfQVGQC3ktPVWkbzBib1RKa/DrOPGPTYVjsA4
 OzL8LFNh/0TfcGhsjIWHc/iSCnDkZOgZ/1dSHJgO8MdeNMR2QzF5fHbBDF7sjyDTbjofnXy9jxL
 jxyRPHDM8QkjKOSmbI66Sk/13SEkmf5Gh/HxNWdZZYM6cLZZYl0HQ2dZOofb1BRcghkvgPEzlBW
 auDd1L5fK3Txkk+Yj+duofo+31y7x7a1Le6Bmk3KmOMro00nmO8k7EzSGZvGE0nEMN4E6jPO30O
 KPaTZFgDEVln1cJE6d1T+pXWKtPKx6Wb/ytQ/WrSyhZ94saFlAPxmnawnWZ2RcvXRW4mngiGBuQ
 9DkFktbd0AdzgVemxL2njkL0OQWhjbvcBrYMRFB7h2Ibrhl+opgHkxk+QIN3UsXcCqR0IVgzHzu
 wbL087mScNX6DiaS6PDcY4RgGx4JAF4bU69IdM0YexezcJmkA==
X-Google-Smtp-Source: AGHT+IHsJSEmdeyZcmkD7Rws/I1+Y8tTyjMeT5pySzZIhCwNUqo1w4U1ld2JHoh8Oo0f7UE4ahRNUw==
X-Received: by 2002:a05:6870:1989:b0:2e9:93c6:6e4a with SMTP id
 586e51a60fabf-3ffc0b652demr351083fac.38.1767744894547; 
 Tue, 06 Jan 2026 16:14:54 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa4de55ffsm2235270fac.2.2026.01.06.16.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 16:14:53 -0800 (PST)
Date: Tue, 6 Jan 2026 18:14:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, u-boot@lists.denx.de
Subject: Re: [PATCH] PCI: Add power sequencing driver for PCI slots
Message-ID: <20260107001451.GL3416603@bill-the-cat>
References: <20260106223409.748335-1-sean.anderson@linux.dev>
 <bafc0b79-9126-4cdc-92d1-dd6fe2f884ac@mailbox.org>
 <70d036ee-e61b-44bb-9160-697e4d3f75e1@linux.dev>
 <702afe1c-ef45-4628-a4b6-fb52440e996c@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7S0tTcmnX6I92msr"
Content-Disposition: inline
In-Reply-To: <702afe1c-ef45-4628-a4b6-fb52440e996c@mailbox.org>
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


--7S0tTcmnX6I92msr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 07, 2026 at 01:03:04AM +0100, Marek Vasut wrote:
> On 1/7/26 12:32 AM, Sean Anderson wrote:
> > On 1/6/26 18:14, Marek Vasut wrote:
> > > On 1/6/26 11:34 PM, Sean Anderson wrote:
> > > > Extend the PCI bridge driver to enable resources associated with PCI
> > > > slots like clocks, power rails, and resets. This is modeled off of =
the
> > > > PCI power control subsystem in Linux. The traditional compatible fo=
r PCI
> > > > slots in U-Boot is pci-bridge, but Linux uses the more-systematic
> > > > pciclass,0604 so add that as an option.
> > >=20
> > > Oh, nice :)
> > >=20
> > > > +static int __maybe_unused pci_bridge_probe(struct udevice *dev)
> > > > +{
> > > > +=A0=A0=A0 struct clk clk;
> > > > +=A0=A0=A0 struct gpio_desc perst;
> > > > +
> > > > +=A0=A0=A0 if (!clk_get_by_index(dev, 0, &clk)) {
> > > > +=A0=A0=A0=A0=A0=A0=A0 int ret =3D clk_enable(&clk);
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0 if (ret)
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return log_msg_ret("clk", ret);
> > >=20
> > > Should we use dev_err() instead ?
> >=20
> > I thought we weren't supposed to log by default in device drivers to re=
duce text size?
> Tom had a different take on it, lets wait for him. Me personally, I like =
the
> dev_* functions as they are compatible with Linux ones, which is nice and
> non-confusing.

I think consistency within a file is the first thing to worry about, and
so log_msg_ret(...) to match the rest of the file makes the most sense.

--=20
Tom

--7S0tTcmnX6I92msr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaV2leAAKCRAr4qD1Cr/k
Chg+AQCkCJUjbybni5UylM2RFpXRD7pQu18v+WzPSyqnC0PFLgD/UqxNfqGbGdUR
BBVJ04EnT7IgSn3wjnzUQEGq6hLVxQA=
=Jly8
-----END PGP SIGNATURE-----

--7S0tTcmnX6I92msr--
