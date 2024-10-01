Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3D4CEB2CD
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 00:24:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4759588F77;
	Tue,  1 Oct 2024 02:24:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S32feTHj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 936E688F83; Tue,  1 Oct 2024 02:24:50 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E5038897F
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 02:24:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7a99eee4a5bso442793185a.0
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 17:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727742287; x=1728347087; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AtvU0WWYeMwPb7Enn1rfpTks8ZcKwy9B3OZG6x8Q2Gw=;
 b=S32feTHjnqlLw1wcsICFV1qUNNMOaKPFaG7UTK1O4zAF8LEG5yRdBjHVEhiil+spfk
 wG4JgYbAMVwv8Jt9QLQrfuEqeKdjmmJQILW8DqedKS6UA0UN8O0u7SgzGK90KurTjRUA
 d49yReuTxl4IO5+1eg0QXSknUfOA4XE/uWyWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727742287; x=1728347087;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AtvU0WWYeMwPb7Enn1rfpTks8ZcKwy9B3OZG6x8Q2Gw=;
 b=T55X5mSjPgTzEyv4iU8gGHwnQlWrB3AFizCKvGz06VNkB2Sden+64m+a+m6ym5nkMZ
 uoWJRYcUI4s5D+nvjHh8uv7Qrq7OLmWml8iLiAtk7ECh1DkXaEZLELETfUZ/qxny+g3R
 SBwnNFwCNulKIkDwGp7Ejg24G2UVZST8GmxEDk7bdToC3YcTv/v7urjmX4vs/CF6T453
 DuXtkf3BHRjlsCeb3Jt6l7RLbn7x9XKW3b6OCzojhkmQpvZmIDFDM5oNOB+RAv9Lezua
 sR9z1gxH3KBvy9tmAU4rhjaLpobZX6BaM/f7r6nfZwovpyqxXvYQIiSlGIX6JD1iecx3
 ZXWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2GioCGVUEz2Xp2uetWhBo3UsnUJZ9MI3AVUxIrRoysTDnc3InCb8SvCYvITBk3BM8jh7QpCg=@lists.denx.de
X-Gm-Message-State: AOJu0YzTP86awl/wGPc5xcaunk/5j1eoOxqvhVuTys6e7cbCr3SA5a6+
 I3D1lCQOazQNAKGU5keaQ0/FyM8Wr018IlRJKZOBny/1kOyEutdt1mUwXji+A4A=
X-Google-Smtp-Source: AGHT+IEyEj/SyaEp5/cfDq/Hhx61ujnIN4Lk7DklSPNKilH4U3PyzwFQrkZmwaQu7tlkT66kCopH2Q==
X-Received: by 2002:a05:620a:24cf:b0:7a9:be53:fe3b with SMTP id
 af79cd13be357-7ae37838c24mr2212487085a.14.1727742287081; 
 Mon, 30 Sep 2024 17:24:47 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae37829d45sm455537685a.77.2024.09.30.17.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 17:24:45 -0700 (PDT)
Date: Mon, 30 Sep 2024 18:24:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v6 08/12] efi_loader: Disable ANSI output for tests
Message-ID: <20241001002442.GC4737@bill-the-cat>
References: <20240926215950.1265143-1-sjg@chromium.org>
 <20240926215950.1265143-9-sjg@chromium.org>
 <08596845-c0b1-4557-9993-cde57420560d@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pnUSAqhgFf5/HBQK"
Content-Disposition: inline
In-Reply-To: <08596845-c0b1-4557-9993-cde57420560d@gmx.de>
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


--pnUSAqhgFf5/HBQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 01, 2024 at 01:38:56AM +0200, Heinrich Schuchardt wrote:
> On 26.09.24 23:59, Simon Glass wrote:
> > We don't want ANSI characters written in tests since it is a pain to
> > check the output with ut_assert_nextline() et al.
> >=20
> > Provide a way to tests to request that ANSI characters not be sent.
> >=20
> > Add a proper function comment while we are here, to encourage others.
> >=20
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>=20
> Please, consider prior review before resubmitting patches.
>=20
> As responded to all prior submissions:
>=20
> We want to test the code running on actual machines.
> We don't want to have sandbox code everywhere.
>=20
> I cannot see any test that is not passing due to the current behavior.

The pytests for the EFI selftests are unreliable for me, on Raspberry Pi
3, more often in 32bit mode than 64bit mode, but I feel like I see it
there too. And when they fail, the console log is full of ANSI escape
sequences. Is this specific test a test you run regularly on real
hardware?

--=20
Tom

--pnUSAqhgFf5/HBQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb7QUMACgkQFHw5/5Y0
tyzPPAv8CN60vREHMKo2tta79vg4sDh50BWJM/Ef9nP5zLGoZcCO14rgj8b6mtma
K0jpTLI3oLd82+pdsMCgeB0TysC8E5ncBb+e/vWdHWT+hPa4dBxTuKeEXGSsxFeV
L4JL0iuyvSXE/i6KMamnyIVZeM8TewyR3K+yXoFgU+xI7x5aMKxfhd02YKzyz1KP
jrXM9LaVu2OSGb2PP5qY8W9FpSViLlL/UXBIsW8ZSmdF9edHXFS/KPyHbNwTmwSC
zBNt0DUKIQtxDzvAVWlIGH8crPS5FJ8q8W5nS/z9ay/N078fHV4uxsAuAjg6AXHu
RcvDy3CvncDcq576LYi0vOPf/n1V/+MqG+VFiv1OX0KvLbzhREAH1TmcBeGVvr3U
wlquhJVuIOoagtkSWkApoBS3hyNuLls9YXauOgUzlEkGYLAbP7+W0AzLHLv9+0tZ
xPU8ORGoACxfl/X5GQrNAQ+XqIZxRsPxIass8qcgh/Azz/nY40S4iYq4fEPb76Tv
4mFIX5EE
=bh++
-----END PGP SIGNATURE-----

--pnUSAqhgFf5/HBQK--
