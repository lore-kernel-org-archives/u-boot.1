Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA26ED19501
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 16:28:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21EC083BFE;
	Mon, 26 Jan 2026 17:28:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YX6inxC2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EBD283BFE; Mon, 26 Jan 2026 17:28:03 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5B7A83B86
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 17:28:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7cfd71761b1so2514788a34.1
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 08:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769444879; x=1770049679; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9i5deomFkLH8CKPUabD46Rr6hVC/anubj/FkjyRtrDQ=;
 b=YX6inxC29I2PdANy0e5QcWtBF/7qIF8HhYEbA3okZdccnOoJnej4kW4y/DWAwsdsrB
 5xrqUqkcwyEQBd5GZIDI9R21lak3Kyd/zInfSRnbNwcPpvjg8S5LXdotLA29fwizuUbf
 3g7X1CNo9I1EMCzRt6SsEX08uEur19X51RbPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769444879; x=1770049679;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9i5deomFkLH8CKPUabD46Rr6hVC/anubj/FkjyRtrDQ=;
 b=Ns+sOOFeOd1Kw+5QKE+S4LSo1kEegvdaF3xWP1v7Rl2G42JEq69oqXwteU1UBodW74
 BflKV5hpiLMStIdnIKE7RsKelRu9B5lkgUOlBPN+KsYQ58/26LEPLl8RcRXiLdi7+f+e
 guZ5csHZ7E0EHqDmn8QbNNgnwrBEeaSdj/euyNuM4Yz01CvOfuljcGfjk+o78pMLFR/6
 nYipnKINNiS/PM0eBM2VOTPdAbGAoLhZVQnKnYZAGM0UpOnPFxHf8sSmkR3P1h5opsay
 BZi7dsgCTu4D4kbuGamfcEWj5LVH5SErKp1GXqFDdEBtN+Vx5b2E+OKzZJhyJPP47DW8
 /R6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1LpxKOWtjPFScyd1TRdQQu/OGOuWXP56BFv6EO5bVjEX2T9cHOmLXJ8JHjRtvqelqhZ6n+Tw=@lists.denx.de
X-Gm-Message-State: AOJu0YzY/BkAMsE9kINYkJOM/WEPoyubxSYerhGqcBsZp1D9Hc0LvoC6
 E2CA+l3A1OQxslYMG1YyyZwfSJw1YhgCg3wiM5d8JxcmlZbkRPSYQ4lobhH4QCTi9NA=
X-Gm-Gg: AZuq6aL5qf2gqs+ZUdI1/+WcW1QXiHBeMv5ZweX1Kgkkt0FeajYsvtSPnj2qj6AKSD+
 u85/m/cvUC7Rbh+taVPOA4KgtWz9FGo871gObMCnGwr6qRVQfKALzglSlgNrMqiYYxXM9RFtQU0
 Wnz5C6Q/Oa2xvzozf957YcTh89krpbnGcsEEU2leW44z30rES9t/SckS2E7VJS7cDWduUO8/Rzr
 W8NvXuSUKn2h/A5qyhQw6NFM+pYQeSq6iiEcdglGqbBv9CNYwkorhMeWnAMxjPEeUD+eIcB45fv
 3Jxr/u9ehbjpD5OE95jRaj2UcAnipPFP3hoiTyk3JFXbBnuD6jaWfYIUQtJxhirozMmzWe6tdFy
 134vK6jxT2jjrha9wshXycLn9BAQBmZPxyqkS/ZnQazQ3XtFkF72UiDnDZNYkOX7K0MY1V1Zhx4
 m+/jn0367hz7c1839bljmuGQJqseu4mF9+LboH4RMP/qC9t+fNbcBxGyAvf+8KMQIx9xhfDukyP
 lfVS0m4uyamNedT2Enb0xEdzigf+2Z1zkHWuYU=
X-Received: by 2002:a05:6830:6c17:b0:7cf:d075:2674 with SMTP id
 46e09a7af769-7d17078116cmr2531750a34.15.1769444879509; 
 Mon, 26 Jan 2026 08:27:59 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d15b3d31d4sm8028811a34.21.2026.01.26.08.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 08:27:58 -0800 (PST)
Date: Mon, 26 Jan 2026 10:27:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: marek.vasut@mailbox.org, u-boot@lists.denx.de, sjg@chromium.org,
 ilias.apalodimas@linaro.org, Fabio Estevam <festevam@nabladev.com>
Subject: Re: [PATCH] arm: spl: Fix DTB offset after binman symbol table
Message-ID: <20260126162756.GU3416603@bill-the-cat>
References: <20260123161907.392211-1-festevam@gmail.com>
 <20260123201202.GO3416603@bill-the-cat>
 <CAOMZO5DVFO=A6g1CWOrRbqy4VNgL+VcUw0Q5pgELXm30puGz4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cTQuyU3WgLMThSMB"
Content-Disposition: inline
In-Reply-To: <CAOMZO5DVFO=A6g1CWOrRbqy4VNgL+VcUw0Q5pgELXm30puGz4w@mail.gmail.com>
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


--cTQuyU3WgLMThSMB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 09:13:27PM -0300, Fabio Estevam wrote:
> Hi Tom,
>=20
> On Fri, Jan 23, 2026 at 5:12=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
>=20
> > I've been talking with Ilias for the last few hours. This still isn't
> > right, it just happens to work in some cases, but not others. What's
> > going on is that while we always have u-boot-nodtb.bin 8-byte aligned
> > because while the BSS itself may end 8 byte aligned, we actually care
> > about the size of the BSS being 8 byte aligned. Can you please try:
> >
> > diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds
> > index d780a5060774..dae8a1ec665b 100644
> > --- a/arch/arm/cpu/u-boot-spl.lds
> > +++ b/arch/arm/cpu/u-boot-spl.lds
> > @@ -58,6 +58,7 @@ SECTIONS
> >         _end =3D .;
> >
> >         .bss __rel_dyn_start (OVERLAY) : {
> > +               . =3D ALIGN(8);
> >                 __bss_start =3D .;
> >                 *(.bss*)
> >                  . =3D ALIGN(8);
> >
> > And see if it works at run time? hexdump'ing looks good. If so, I'll do
> > something more broad to catch the SPL_SEPARATE_BSS=3Dn case, and add the
> > ASSERTS that are missing.
>=20
> This fixes the boot on RV1103, thanks!
>=20
> When you send a formal patch, feel free to add:
>=20
> Reported-by: Fabio Estevam <festevam@gmail.com>
> Tested-by: Fabio Estevam <festevam@gmail.com>

After talking more with Ilias, we're going to handle this in two-steps.
Step one gets more platforms booting today. It's *slightly* different
than what I posted here, however it's binary identical (I just checked
and got the same checksum as this patch produces, build-testing
sonoff-ihost-rv1126). So I'll add your tags to the commit.

--=20
Tom

--cTQuyU3WgLMThSMB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXeWBQAKCRAr4qD1Cr/k
CuOYAPsEKJjAHijSGn/JjHjgA0AJLp+vB6zQdtvVHMV9KEHplgD7Bl9Vpm9Bj4Hn
zwryWM5woQYYXx2XAujRddR74znM/Ag=
=KD56
-----END PGP SIGNATURE-----

--cTQuyU3WgLMThSMB--
