Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64364C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 15:36:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B265F87083;
	Mon,  6 Nov 2023 16:36:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AhajBoHi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ADD9870A5; Mon,  6 Nov 2023 16:36:37 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E7DA86F1F
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 16:36:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-778a47bc09aso304726685a.3
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 07:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699284994; x=1699889794; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9sVDHS9QRIh+UuPDbMz3t9hYTTwY6A+L3mD34kduUhY=;
 b=AhajBoHiQjzB578iCTN6Kit9y2Sdgks7iDv0lGMa5a2wk/N96fXrq8YHUdsVqLAF4l
 Fit+qwLFnFFpkYZ9mlc/0kGantqKixz7NU6+W8lbBCY9yDTsiZMDib21ErWrmoPZrvZC
 vHMTxQ8320zdAQdm0tIQrx2j9IYAuEmPe/ZfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699284994; x=1699889794;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9sVDHS9QRIh+UuPDbMz3t9hYTTwY6A+L3mD34kduUhY=;
 b=mPZ+wNT9oq+kXG24qfZLlvw5w1y4924yfWiAYgFsIpRsCTko/2Ge2LLnpyE8+4dQ84
 XJY7JxcyW+TrVs5i9R8a7iAWdKYPykn18nHs3nNLNdYleDpJjZs9Snr/wSBj5Vm17pYB
 OblMO9J4X+1t01YhzOirnEm2VwuuottAZwvjfug+hqGkLy8sWIwmLfMI5/RuepUNdiBW
 ski1gcZ2hkSMi2lzbeympocgEWwhXf7GT7VRF1OvWg3z7zR6nmdelimN6sEGIJX488Es
 fQhQwUbyJyVyjs7dFkro5ppWzblm1dBZdQ4IZRsOXNw018iQvysPQ0wNrltDoygXgqbR
 62DA==
X-Gm-Message-State: AOJu0YyL/O2QcQ60u1Nw9/FqGPQtxb2LsYento8fculSCrVWX2v/oPhY
 3dPExbrFeVtZVkxG+Y5l/yLB+Q==
X-Google-Smtp-Source: AGHT+IGWNG60KitC2xKw3D72ZxLog6nbdlpaWLrZNAQ0bOfl4ZWCIXQTHZegLmc6dtboOnDuTwwQAw==
X-Received: by 2002:a05:620a:47b2:b0:77a:148a:3d64 with SMTP id
 dt50-20020a05620a47b200b0077a148a3d64mr30487701qkb.45.1699284993750; 
 Mon, 06 Nov 2023 07:36:33 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 w12-20020a05620a094c00b00767dcf6f4adsm3348738qkw.51.2023.11.06.07.36.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 07:36:33 -0800 (PST)
Date: Mon, 6 Nov 2023 10:36:31 -0500
From: Tom Rini <trini@konsulko.com>
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 09/12] x86: Enable SSE in 64-bit mode
Message-ID: <20231106153631.GI496310@bill-the-cat>
References: <20231002011450.462468-1-sjg@chromium.org>
 <20231002011450.462468-5-sjg@chromium.org>
 <CAEUhbmWi9phnvS1U=z1O+8t7kK5mV=JLw8=YJ4A_u3tcrPSXGw@mail.gmail.com>
 <CAPnjgZ1CsWJa2Ta8fgbGmXZsvpg_BMFDRJmjqPqu6d+7z-TXxg@mail.gmail.com>
 <CAEUhbmUD9E+DkA4jq1tLMSi2ZmBLmOnB8x7jU74fL=J3YYNk-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kpAQMeKRvqTQf16j"
Content-Disposition: inline
In-Reply-To: <CAEUhbmUD9E+DkA4jq1tLMSi2ZmBLmOnB8x7jU74fL=J3YYNk-A@mail.gmail.com>
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


--kpAQMeKRvqTQf16j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2023 at 06:26:15PM +0800, Bin Meng wrote:
> + Tom,
>=20
> Hi Simon,
>=20
> On Mon, Nov 6, 2023 at 12:29=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Bin,
> >
> > On Sun, 5 Nov 2023 at 14:05, Bin Meng <bmeng.cn@gmail.com> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Mon, Oct 2, 2023 at 9:15=E2=80=AFAM Simon Glass <sjg@chromium.org>=
 wrote:
> > > >
> > > > This is needed to support Truetype fonts. In any case, the compiler
> > > > expects SSE to be available in 64-bit mode. Enable it.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> > > > ---
> > > >
> > > > (no changes since v1)
> > > >
> > > >  arch/x86/config.mk        |  1 -
> > > >  arch/x86/cpu/x86_64/cpu.c | 11 +++++++++++
> > > >  2 files changed, 11 insertions(+), 1 deletion(-)
> > > >
> > >
> > > I didn't suggest we enable SSE for x86. This is the wrong approach.
> > >
> > > We should rewrite the Truetype support codes to avoid using float/dou=
ble types.
> > >
> > > This way the Truetype codes can be used on any other architectures
> > > without the need for the compiler to emit explicit floating
> > > instructions.
> >
> > I am not aware of any such library. At present, enabling truetype on
> > coreboot64 causes a hang.
> >
>=20
> If that's the case, we will have to either:
>=20
> - Switch all U-Boot builds' to use software float (e.g. -msoft-float)
> which unfortunately depends on the compiler runtime intrinsics.
> - Introduce a Kconfig option for hard float enabling and let each
> architecture to decide whether it implements it or not, and update
> Truetype to depend on the hard float.

We generally do -msoft-float already, so introducing that for x86, and
some Kconfig logic to ensure that no one else steps on this particular
bug sounds reasonable.

--=20
Tom

--kpAQMeKRvqTQf16j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVJB/8ACgkQFHw5/5Y0
tyzDzQv8CA8YJTbsRxCEE1pOVExYeMsGim77mFsHT3gCMBVGbwp8F+kT7ipWx1U+
H6LagPCkKJpnGb+v27TQpikkWsdLpiNZ5Uyu3YmrajyLHdHav9TeLxi55lOeHTVk
026d0y8s54JDH+lSgkGKNKqWB5N4ZfRPT2N3jTXqH/Opvd19ufNYDyyFeUGXVLa9
BW4rZDq/xWDQAwcYE+esT+ksDNEWTa+lIq/cyql5WAgWsoPIyO0KyxuahQfLRqga
3qMrr71gQx/5R0UEb89alxDEMxkLbJRrClIj8TJ2mm987n1mMn9lGUOAHfmklGuT
+UofTgyaZ7CyB+iiJNbJ07qVS/MR4396QxLUcHX1032hVJjoB3ocUonNi6/ChD5F
BBxvbU6+X+fg5s0K0HPjBBanwtTeF0frw86SbvOfhqLLv6ftWxLVL/KDaOzFC1i9
LzoGMoACWVpu5JHBumE/TvN1X7U3Vdb0t8OXmUd0fQJkOAy7cmYmaQTZ2n5qrK7O
r5yN0xIb
=dvBH
-----END PGP SIGNATURE-----

--kpAQMeKRvqTQf16j--
