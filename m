Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D24BCE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 19:49:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37BFC8913C;
	Fri,  6 Dec 2024 20:49:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TM1KrtZv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B503E89065; Fri,  6 Dec 2024 20:49:23 +0100 (CET)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E8988913C
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 20:49:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-85c4b4cf73aso200407241.2
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 11:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733514560; x=1734119360; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zOJ3E9JTk/x7JubGp8mtbEwa4WbsUIJw0Rgd4MsstO4=;
 b=TM1KrtZvHfUSx0ufyyMrGqRrX9UtKKlhP4AZhfzPply8f94ccMEhyqWPay58RlQ3b0
 hK5/Fkm2A6VIXQNFJ2MLOc/70eyPSGrymmP5ICT3x7we0rYPqU2m4RvZqBUREwvBYOZv
 OlcG0xvs39ZOoj4Q84q6FEvxOUf0qM0VaDQao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733514560; x=1734119360;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zOJ3E9JTk/x7JubGp8mtbEwa4WbsUIJw0Rgd4MsstO4=;
 b=oYTp0e4rmNeT/H1+HQ42HMTDSE8hsyrcqPbFbyS8vU1hkupyRO0Km1jP8CMaFPwLy/
 cy6E6O344k7JvsYYCEDtyi5MoacrH6yo8Ns/QO2EaOh8RuTIdBOZOvQx+LVs8W0Vn+V3
 Vn9ZapQYsXwoej3KajhqzF+UI4JxWTzSn8Osl5anAF58eGni2lNz2fQNxOjR7COzxL91
 +6wmQGhYAXBr4UdP4AenYgDCFq4e4RYRQGn9HoF1w/Zt+ezMClgREWBd610mn8XXqMcQ
 +jd3gBVN6W6XjeED2PF7+utEMViNbflctFtNAMuezxL34GuDeuj7ZmLzQJlL3Z2WQnYy
 Xqhw==
X-Gm-Message-State: AOJu0YwfE1MSwsXdL7N5AOgOQeE+sorYT+Ma3w5MYQ+wvBp8p+gFHypy
 St4v+9BRjXGjsWX5PYE+W3bzSeQdLnHIlToDl9qNmVuf3XEvAQS/qBCZ+AFH1ME=
X-Gm-Gg: ASbGncuXSOT0JfO82FwiZcvj1cCkfy50IyeN3b3iE0md9BfOVuLeZXFWLJRzPZ/SSWA
 XJCtZfsLZoeu2APRFNP5PUcRjXa4jWbi/rw7uZ0VocSZDekHkOGhVnFMSeE8kZyVhqz/32k35ng
 v0bdIsIe7Pz0d5yz7kD3WeHoWCu8cbdTyi/anOr6Tn2v4M/v3fEhDlu3JcsHd8UxiphwTnB/cEK
 G+m5iw6bc/dKYSQBBOVpHtYAOhG5fnnrK95G83mg5aAC6U0lQ==
X-Google-Smtp-Source: AGHT+IE1c8l7Cikc0ozz1W2MrD/7faB7obZPTXbZGTzcRZHIq+yTg+PzicFK6DoDfeDUqd3gbYYvNg==
X-Received: by 2002:a05:6102:292b:b0:4af:c24c:1a5e with SMTP id
 ada2fe7eead31-4afcaa1008bmr5449742137.5.1733514560250; 
 Fri, 06 Dec 2024 11:49:20 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6b5a83cd7sm204131885a.93.2024.12.06.11.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 11:49:19 -0800 (PST)
Date: Fri, 6 Dec 2024 13:49:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 Jonas Karlman <jonas@kwiboo.se>, Marek Vasut <marex@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Sumit Garg <sumit.garg@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: Re: [PATCH 2/3] fdt: Allow expanding the devicetree during relocation
Message-ID: <20241206194915.GY2457179@bill-the-cat>
References: <20241206131113.2865416-1-sjg@chromium.org>
 <20241206131113.2865416-3-sjg@chromium.org>
 <20241206141310.GP2457179@bill-the-cat>
 <CAFLszThS0mDMe=ujRDPFDDrhM_9p=o=v5oBbpsQTAbDNfU5Qpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MBJwl60CjXfUv7H5"
Content-Disposition: inline
In-Reply-To: <CAFLszThS0mDMe=ujRDPFDDrhM_9p=o=v5oBbpsQTAbDNfU5Qpg@mail.gmail.com>
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


--MBJwl60CjXfUv7H5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2024 at 12:18:07PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 6 Dec 2024 at 07:13, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Dec 06, 2024 at 06:11:12AM -0700, Simon Glass wrote:
> >
> > [snip]
> > > A comment in that function says that we assume there is space after t=
he
> > > existing fdt to use for padding, with the padding size set to
> > > CONFIG_SYS_FDT_PAD
> > >
> > > However, there is no guarantee that this space is available. If using
> > > the control FDT, then global_data is immediately above it, so expandi=
ng
> > > the FDT and adding FDT properties will cause U-Boot to fail.
> >
> > This sounds like a generic issue and should be fixed outside of a "Pi"
> > series.
>=20
> Yes and I know you keep asking for multiple smaller series, but I've
> explained that keeping track of all that for months at a time is too
> challenging for me.

Yes, and it's also too challenging to review for the rest of us.

> > > diff --git a/dts/Kconfig b/dts/Kconfig
> > > index 41a758e83a6..360611edd01 100644
> > > --- a/dts/Kconfig
> > > +++ b/dts/Kconfig
> > > @@ -219,6 +219,17 @@ config OF_OMIT_DTB
> > >         This is used for boards which normally provide a devicetree v=
ia a
> > >         runtime mechanism (such as OF_BOARD), to avoid confusion.
> > >
> > > +config OF_EXPAND
> > > +     hex # "Amount to allow the control FDT to expand"
> >
> > No "# ..." because the help explains what to do here, if needed.
>=20
> OK
>=20
> >
> > > +     default SYS_FDT_PAD if OF_LIBFDT
> > > +     default 0
> >
> > A "default 0" is almost always wrong.
>=20
> In this case it is correct, since it means not to add any extra space
> for the FDT.

Which is still wrong? Because we don't allow for this particular device
tree in memory to be read-only and so the question is "Do you want to
break things on some platforms or not?".

> > > +     help
> > > +       Some boards make use of the control FDT to boot an OS, thus w=
hen
> > > +       image_setup_libfdt() adds extra things to the end of the FDT,=
 there
> > > +       needs to be enough space.
> > > +
> > > +       Set this to the number of bytes of extra space required for t=
he FDT.
> >
> > We should just use SYS_FDT_PAD directly and not add a new option.
>=20
> I thought I read somewhere that fdt_high =3D=3D -1 should not be used. So
> for most boards, this padding is not needed?

That's also true, and gets back to why putting multiple patches in a
single series is a Bad Idea. The function in question isn't doing some
check for if we've disabled device tree relocation for the OS, it's
early on, it's reserving our control fdt, yes? And then the problem ends
up being later on, we use the control fdt for the OS, and modify it, but
haven't ensured there's enough space for said modifications to not stomp
on something else? That is a much bigger generic problem, no?

--=20
Tom

--MBJwl60CjXfUv7H5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdTVTsACgkQFHw5/5Y0
tyzOsQwArNCqAyUULiI6hAZnq1bluvZz9SpK3dhWRMAFriv7aEITQrBZnraxC2BF
2/vRmOsRBPNr5xuIrkMwZ5L9hXoQR1A3R9jLIfX+2N1gPslGvr3it/k1ljg5V8Y6
dcZfmmJ/E9IqTXEtzdh1iIdz3FCo5H0ZiXp2tQQdG2e2Ij00LHbLKlSf4uLML7HK
wjSAS8iZlQcXIMZA9YNJ4K53GMETIp1yj9nv2DIPL9BrlmU1XZFdzxBGXarfOkvI
Uu9dxpilbamOpPwgjJGjV+enM6q5EF9lYlM09MQatOqVvuDbqx/CduAv8YCJZNJS
FEImuypZpYoX/yYUbclcnWs6MZuwajCp9H8h462E8QPOmbMseNP+vY8Rg9NXMR9K
qBX1ei3i2hddX4RdkRBWeON41e4NAKpyUuQQIgkG9gR6cZ2AWC0FcXdaq5jLIHms
ZmeN5pkounlpGaWz7pq1OQsLSi5Ux4TmJOK6Vm3wGLpES91DW++oLV/WJttcGA2J
uuiy/oaw
=HYfV
-----END PGP SIGNATURE-----

--MBJwl60CjXfUv7H5--
