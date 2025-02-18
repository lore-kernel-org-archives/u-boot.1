Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E9DC021AD
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 16:28:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4885D80BA8;
	Tue, 18 Feb 2025 17:28:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q02JYHqv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DF0380BAE; Tue, 18 Feb 2025 17:28:56 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51A4680646
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 17:28:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-220ecbdb4c2so115770665ad.3
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 08:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739896133; x=1740500933; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kN9gI17llIulxGjCWn5kp7xAoM4htbsnpdvUOFbKQGA=;
 b=q02JYHqvQ99LdlLaBlIfcASlQ9q3eYBEyMjSzTPh3WH//hJ86CrH1N6gM0KafiTDRn
 KLNOdoOlKYeJIdU1RdwTBDt1/F44rJprkKmBj8//xh4VoI0vdva/5mdxGwmT3cOg3l+r
 oPug9N+dkE8x1c5z08V7B9UzYkvTDBvYHtHxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739896133; x=1740500933;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kN9gI17llIulxGjCWn5kp7xAoM4htbsnpdvUOFbKQGA=;
 b=lvCP7we+ARBbkaBEyjHA5mGp4k6uYJzzW8b5oBB3A2mbXN1nlqI3pvqbXY0yUMAuP3
 oCK/ymZ1NZJ9Bv8qJ0Esg3lgtVGxyQBmdIBXCPY2nKxWfxNCXMBl7lEWCkSjARddO5CQ
 +U7Sxn9p1/M0ehSE9zsRzyr1+REmsRY4Ep8n/3Ib5XQhafQ/I8nSmkcSqvNcL8Uo66TM
 pOsuN19lNrkrjh/i5nIwMrEuW49LZI/5VtCxKFdphjhnOsjwYE1n4Zw/+v/7fpjRttYr
 7z+i6ZfwIXHNFLfyAR8jkJMcfNa0DSNvVVmk3yGiHe4g0CKsgi+lfhnYuXgExFYlnXsr
 oFVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkSXZGu2gj2gAbpK3zFWLsXdzgJkCJLYxlRv+3eoteH8slp7znEoq0pZ2fJGouDf2LRp1bkTs=@lists.denx.de
X-Gm-Message-State: AOJu0YzFJ32V2K3hCJvJgtRpOjLHn+bNPJ8XEfnIzsZ55E/F2xiEUAQM
 4RUbRIHAbn/cbUUKBDaEjh61vcSA8K/yiUxi6U8kpSg5u4FYDbPdfFJqbec10Gs=
X-Gm-Gg: ASbGncsTVDkrV8HhTmQkEfx6Lcw3oIGegBhgA8XFl3atF2fQY69Qex45I09zLq1pa9z
 iEmDjkvMQov+sR5fA+9GIq9+3i4P57Wtn2gku23bnXbgQTQ2G5oiE586fEXWNMDKCIHj5ApgBS6
 7jQTztKOTLLhqQQHYIp55S+ILfAx/At7OmF65eOcd2kJHQXJjkxqxoVGCtUUayU1aQazUC/C/ZU
 7u3aHh02JHrxVkXOfXHlVxHno8tYHtdxfgEL7Xp+OKaLYxrikm5y3zxaN1nWoi9528F9lSbrGM1
 AdLQv6CcQdrWEQ==
X-Google-Smtp-Source: AGHT+IEeseSi5KTlyK23j9Oq/JLo/czv+Dn3lJ8BizhcAa1fRDGiTKp4JGdB76iqM/TyCNnOe9Ii+w==
X-Received: by 2002:a05:6a20:158a:b0:1ee:cb08:d0a3 with SMTP id
 adf61e73a8af0-1eecb08d345mr4331340637.21.1739896132860; 
 Tue, 18 Feb 2025 08:28:52 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb57c5e0c4sm9413181a12.16.2025.02.18.08.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 08:28:52 -0800 (PST)
Date: Tue, 18 Feb 2025 10:28:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Frank Li <Frank.li@nxp.com>
Cc: dinesh.maniyam@intel.com, u-boot@lists.denx.de, Marek <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Wang Jie <dave.wang@rock-chips.com>,
 Tingting Meng <tingting.meng@intel.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Boon Khai <boon.khai.ng@intel.com>, Alif <alif.zakuan.yuslaimi@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: Re: [PATCH 01/10] dt-bindings: i3c: Add YAML schema for Cadence I3C
 controller
Message-ID: <20250218162847.GG1233568@bill-the-cat>
References: <20250218025705.50051-1-dinesh.maniyam@intel.com>
 <20250218025705.50051-2-dinesh.maniyam@intel.com>
 <Z7S0LcUSb5y8Nr4u@lizhi-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Bqoj8g+smUrZrLzN"
Content-Disposition: inline
In-Reply-To: <Z7S0LcUSb5y8Nr4u@lizhi-Precision-Tower-5810>
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


--Bqoj8g+smUrZrLzN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 11:24:13AM -0500, Frank Li wrote:
> On Tue, Feb 18, 2025 at 10:56:56AM +0800, dinesh.maniyam@intel.com wrote:
> > From: Dinesh Maniyam <dinesh.maniyam@intel.com>
> >
> > Add a YAML device tree binding schema for the Cadence I3C controller,
>=20
> Cadence or snps? compatible string said snps.
>=20
> > defining required and optional properties for proper integration
> > and validation with dt-schema.
> >
> > Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
> > ---
> >  .../i3c/cdns,i3c-master.yaml                  |  51 +++++
> >  doc/device-tree-bindings/i3c/i3c.yaml         | 186 ++++++++++++++++++
> >  2 files changed, 237 insertions(+)
> >  create mode 100644 doc/device-tree-bindings/i3c/cdns,i3c-master.yaml
>=20
> file name should be one of compatible string.
>=20
> >  create mode 100644 doc/device-tree-bindings/i3c/i3c.yaml
>=20
> Where doc/device-tree-bindings/i3c?
>=20
> in kernel, and already have i3c.yaml
> Documentation/devicetree/bindings/i3c/
>=20
> stop here, fix file path firsly.

We don't need this in U-Boot at all because we already have it:
dts/upstream/Bindings/i3c/cdns,i3c-master.yaml

--=20
Tom

--Bqoj8g+smUrZrLzN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme0tTMACgkQFHw5/5Y0
tyzzKgwAluyObcIs4zRXon00XbLHSbdOJ7IkTdI5Q7LbicJm1hiF61sTtZ01YDV8
rsS6GPjGRSIxL5Inj7+qUSieIXcjHele6eEkrT2hleXMlVW/Oh07KDqbyMzq7KJi
qwMj59epdR8pupXtgBD5wOtUF1zI6SeSK24RAlVhAPRA8LUpqnMhxiIc8wUGPtlu
S7ivMned6Zkd5CMlE6wC9kNttQ/B2drEbdncZ8JcQjeboLilIwvIKbxGO8lLpzEz
qRw2mfOKLNQ74/lrBsWqNk0BANlgM7JgbhfBAPJHsjS/J82myO+hCtDzXrs8uCC5
sOYbqmhNdalJT15UehhqkjU8zcV9kPQQFWyXxn7xJwqmpeg5g1ubTiCFt+G2GajF
uStFD2qOtmDfiBawK2b9EYLThFau14K0lOvh8xBkyzc/zzV3iWbgwMiiK5Pw8ZlU
A/u/Ftg9LuhEq+76RN1bABWPquUBDr7P+neiAhvYbBSd5wMG1gmh2hleq81mFmcx
FJHkfRnZ
=9FUs
-----END PGP SIGNATURE-----

--Bqoj8g+smUrZrLzN--
