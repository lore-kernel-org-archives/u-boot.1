Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAB9C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 22:48:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55C3A81F45;
	Wed, 16 Apr 2025 00:48:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XBuOOX2u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C22F082C4C; Wed, 16 Apr 2025 00:48:03 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39A1C803CC
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 00:48:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6041e84715eso4221083eaf.1
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 15:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744757280; x=1745362080; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=q/b3PsacZrQF5B6lDxRwk59pyEoMknrnX/9UARz8KYg=;
 b=XBuOOX2uQ/vRUykNVda0fmIHZyJe8dYhuR1mmqwc9fbAkCmId09Tq9KPPG78x7e7Hl
 HeBN1Lr2F+1dlvVF7VuGRJ6njjJ9c4YJ15RMjZGCGr0mUDq589/X3ZFoca6uWZeCjpUI
 hv5htaCebESFJPohT5B9hNhIm9JM5tuiz44ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744757280; x=1745362080;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q/b3PsacZrQF5B6lDxRwk59pyEoMknrnX/9UARz8KYg=;
 b=YIx/LoTb8BaAUDk3RO2CW/KmpqkpMl7o0EYYZaGAP2AnXqafbVlvYMaAHDm5aHBEe9
 V4v3SX4kp8CjphIANEYdRU3A1aDOjbXksHaV3LK49mgBqeuO2ig0fhy/Vmohko5+EoAA
 o2GpEMOsanE8pLyRDgCYDKRL6djSb1K79rMDrTM1OIteSoxpsr/Ter9ks4DfAjiF4L6C
 q6X6OPRp8eCuPSuUbuXpCtVPuBwddk0FTfFAxMVUBWcyDJ4945FO8UAXuJHgwYYGUUcr
 sZ2Pd9HiAL5hUigSAzYO36o9biXWd0d3I2iACCQ1t8yY8qvmjZ/FYPmXkb8mw4ufY6Zw
 cgjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhaolKRn8+MT4WhotfZLsgU3HE65/Ram916a8/tkwjXQVCX9+ZeFBGntuRk+TaZdtekK02L9Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yw8InjbQrV/D3YnfC3MU/cknt3/xu82F1pFFLdafGsTBCBHK12C
 D2dJ6T72CEmdtSIcD5ef46nFl4UX4BrQ6s1Hg+RSxomvWZEdaf2EsOBLXaiJ67lvGR3QTxOyZpM
 I
X-Gm-Gg: ASbGnct/CD4ykd24GNFpVQypikgF+JagfMHzedHCXPwQUFZca+40qvKapSK5m2ZWxS4
 afHJ3BEue8EF/qecI53zKvgvdPBkJddC/Sb9b0VG3DYVasvntSUEo+yx3GNJn7pIlWFgmQ/6h0q
 x0MKZn3PvNMSWqEZhAVLBDakN9vqh94Wom2F3+UjwCGOvntExMipi132YadMUKdMSAT2UcqShi+
 W8vpAa0mV9jyWlVbFjccaxUDFF9qqcjCSO62h9sUb0kfeySee3zIuIu+PO4Zakj1RKUG+6UiiXn
 7v9/m4McC9kIT6VABylVcjAaEUDt2i4LEhncm88+9sMOwqyTyLzw5qp224MdgWHQYSNQam4IQOi
 YbQ==
X-Google-Smtp-Source: AGHT+IGcr2x8uLTAER1W16cKFlHDX8WAvNeEKxsQvlePfHcCv8tb5uBG4dxTeYsYzSfJyDH+syWmbw==
X-Received: by 2002:a05:6820:4c17:b0:602:15e6:4559 with SMTP id
 006d021491bc7-604a5c54836mr522791eaf.6.1744757279883; 
 Tue, 15 Apr 2025 15:47:59 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-604a5bbac4fsm102459eaf.17.2025.04.15.15.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 15:47:59 -0700 (PDT)
Date: Tue, 15 Apr 2025 16:47:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Sukrut Bellary <sbellary@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Bajjuri Praneeth <praneeth@ti.com>,
 Raghavendra Vignesh <vigneshr@ti.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] arm: dts: am335x: Add nodes for lcdc, panel and
 backlight
Message-ID: <20250415224757.GO5495@bill-the-cat>
References: <20250319202516.3300444-1-sbellary@baylibre.com>
 <20250319202516.3300444-4-sbellary@baylibre.com>
 <20250324172009.GB93000@bill-the-cat> <Z+MEeuDZNr7z0mZh@dev-linux>
 <Z/7hyM22GguAlnx+@dev-linux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ODduhHoCt53kUpnH"
Content-Disposition: inline
In-Reply-To: <Z/7hyM22GguAlnx+@dev-linux>
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


--ODduhHoCt53kUpnH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 03:46:32PM -0700, Sukrut Bellary wrote:
> On Tue, Mar 25, 2025 at 12:31:06PM -0700, Sukrut Bellary wrote:
> > On Mon, Mar 24, 2025 at 11:20:09AM -0600, Tom Rini wrote:
> > > On Wed, Mar 19, 2025 at 01:25:16PM -0700, Sukrut Bellary wrote:
> > >=20
> > > > For AM335x EVM[1], enable nodes required to enable the support for =
LCD
> > > > and PWM backlight.
> > > > This is required for the splash screen support.
> > > >=20
> > > > [1] AM335x EVM - https://www.ti.com/tool/TMDXEVM3358
> > > >=20
> > > > Signed-off-by: Sukrut Bellary <sbellary@baylibre.com>
> > > > ---
> > > >  arch/arm/dts/am335x-evm.dts | 15 ++++++++++++++-
> > > >  1 file changed, 14 insertions(+), 1 deletion(-)
> > >=20
> > > Can you see how hard moving to OF_UPSTREAM here is first please? Than=
ks.
> > >
> >=20
> > Sure, I will check.
> > Thanks.
>=20
> I checked OF_UPSTREAM for AM335x.
> For the panel driver, timings are fetched differently in the u-boot and k=
ernel.
> For OF_UPSTREAM, we need to change the lcdc panel driver in u-boot to be =
in
> sync with kernel dts or see if we can reuse the simple_panel driver.
>=20
> We plan to take care of OF_UPSTREAM later.
> So, For now, can we split this series into two as
> 1. Enable Auxillary PWM using eCAP and pin muxing(These are independent
> of OF_UPSTREAM)
> 2. Handle dts changes once we have OF_UPSTREAM for AM33xx.
> If this is ok, I will post the patches per pt.1

Yes, that's fine, thanks.

--=20
Tom

--ODduhHoCt53kUpnH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf+4hYACgkQFHw5/5Y0
tyyuEAv0DuW6DfxSGiGhaDKHpX5Cj6gBevBqyr/86y33J9364nWOVbPf/GP7XwCt
Wp78rqC6Ks0yQCZ4dVktv9nsapUdwYgizaFeAOIZlatpwkQ/LbUncpKIeYETlawn
PcfcuGjxlsAmSBJrpTJMWxA1qcNkzsQSn6WYE+2fJrb6ToufhjqDCTEr7xz2TUkc
KpWl7LmeT/PIIWdK2rITt/vqSe2spTYLmuVVcTiNl2o8y1ElUTWoWScN6+GcGt9d
fwmHXWK5BQwIhV5AC/++kvo9vMdEiEhnoeTu3NeElffY5jdPQ7vyKW37Qh8Q6RnP
/yrg87XOnpXBnh7ku5+zjbbE+e6K20YaUUiwqef7rUYJH0Wvb2iduiLn+K/7AVhE
ir2QQdR250p4B72NvogpG1C9YFfUtlbG4J3GZOdjO86YUa8DMU20sBk5fhQKgYK4
3RoTR+0iCS7eM79qPLluDL4MIoaceqG9TMU2WcBtTtDmucPGMFmvDz6BD+cM2uen
F+hZD2w=
=pBca
-----END PGP SIGNATURE-----

--ODduhHoCt53kUpnH--
