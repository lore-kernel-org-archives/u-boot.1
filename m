Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F698C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 13:42:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C678487620;
	Sat,  9 Dec 2023 14:42:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f/joqjQm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 170E287633; Sat,  9 Dec 2023 14:42:54 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E025B8761C
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 14:42:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-db548cd1c45so2881925276.2
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 05:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702129370; x=1702734170; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=u85tWqGREQ+SH7Nq3IJhpAJkAqwDPD29rXxBn82TRic=;
 b=f/joqjQmLaYJYHJMEr89z+454/MSVZmejf1XfKhHmcvUi71MEhDn4Z3751ND2i3OLa
 XnYbc8facqGad2xkKukZjGlfMwiicwGTB0PEGlreB/DIvLY5imk0qw05Zm6CFRol8aUJ
 RneKaRX6fMeW9J6pSwGGM4x8mzs0MD1bhaqwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702129370; x=1702734170;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u85tWqGREQ+SH7Nq3IJhpAJkAqwDPD29rXxBn82TRic=;
 b=a8QZwXNxV0B0QToOSZ6nVSlGTh0j6yD8waadQa2ymOF/8LgdFlqzQ625a8mnKLe2LV
 8tRBHIhgmqYd110BFVg/KGtoOTauT3HnhaQSx3p5Tmo9OsgBn+r7CsivXp9zD600yHVz
 CMPJOukycINR+Dbav7bf32rWtLsaF8/cYlfSczQDyfoHB1tvZT93wT14Xa9GCczc86Ef
 QWw+lV8mJYOZqNGKERWpMwult1dDHrqlb3RI59WA3pCaWz3DYjROHnGOqMnxYdFc7YYk
 e7WVNqQpoeGkZP71qrFd6f121hpM3v3MYojry9IeMtWMjjPbPaLCY7FXiWx66wDkxY1J
 35NQ==
X-Gm-Message-State: AOJu0YyOI9AnPJosle3v/mWmxcHz0Sp1VNCCEPzVpRLmMfk7GVHbSn7T
 Nf7ccEwQMDvMhqqQtG89QoTAbQ==
X-Google-Smtp-Source: AGHT+IHPBQw+Czv5A33uNESmFgORDMQohma4A2i8g4K5xPzieef6kcfAtVZzWEmzg6AdbY56NfRJGA==
X-Received: by 2002:a25:b28e:0:b0:db7:dacf:2f33 with SMTP id
 k14-20020a25b28e000000b00db7dacf2f33mr1050996ybj.122.1702129370614; 
 Sat, 09 Dec 2023 05:42:50 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 i20-20020a056902069400b00da076458395sm1263647ybt.43.2023.12.09.05.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 05:42:49 -0800 (PST)
Date: Sat, 9 Dec 2023 08:42:48 -0500
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Mario Six <mario.six@gdsys.cc>, Nikhil M Jain <n-jain1@ti.com>
Subject: Re: [PATCH v2 1/9] cmd: bdinfo: Optionally use getopt and implement
 bdinfo -a
Message-ID: <20231209134248.GB2513409@bill-the-cat>
References: <20231007214106.15744-1-marek.vasut+renesas@mailbox.org>
 <fd74b3b4-4229-4048-bef4-e095ffed59b8@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2pHDMeI6Ju8/FUoA"
Content-Disposition: inline
In-Reply-To: <fd74b3b4-4229-4048-bef4-e095ffed59b8@mailbox.org>
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


--2pHDMeI6Ju8/FUoA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 02, 2023 at 05:33:34PM +0100, Marek Vasut wrote:

> On 10/7/23 23:40, Marek Vasut wrote:
> > Add optional support for getopt() and in case this is enabled via
> > GETOPT configuration option, implement support for 'bdinfo -a'.
> > The 'bdinfo -a' behaves exactly like bdinfo and prints 'all' the
> > bdinfo information. This is implemented in preparation for other
> > more fine-grained options.
> >=20
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > ---
> > Cc: Bin Meng <bmeng.cn@gmail.com>
> > Cc: Mario Six <mario.six@gdsys.cc>
> > Cc: Nikhil M Jain <n-jain1@ti.com>
> > Cc: Simon Glass <sjg@chromium.org>
> > ---
> > V2: Add RB from Simon
>=20
> I see this series marked as Superseded in patchwork , why is that so ?
>=20
> Is there anything preventing this series from being applied , Tom ?

Dunno why I did that, sorry. Reviewing now.

--=20
Tom

--2pHDMeI6Ju8/FUoA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV0btgACgkQFHw5/5Y0
tywEIwv+PI0AnKoFBUVGMu/v8fFl7VOu8H/WkMkaZCKVr5MUaiAkNAEATYKToMOG
OBqxDYlFv2EbbStzXCITN3UfPFHw5cT8dLy+K2h8Hkyo2Qy2yCY5bNUOPBBNFefR
aB0qRs6KEEKGEi4971Febczqh1QkfPuG9WL0a/8GR2THDYsdS3IjyEZbZrD6HmsY
5lQRkbVppmJziYUBzegE47GpR9QgYuGI9PIc4Gh03PDHKNF7Elu4dKls5d/jCrR5
J90sS4Z2kHa/9Nm+v4/NcOuzVpxmm+1o7Hx5iitlw20TxL290eIVVfA4L2pGCkXq
ad7bfb9QkgTfbl/mEzxF+qPP7WrzMp1UDNMGUNpxwN4HLOMlf050+bfZMCtShp+H
p1q3owTipL+XDDufdVu9vg1oFFIrsenWyWSQ/hUAJ1YrArbzZ0uI+hgVyE9xU8kL
tph2hG/VsijcMdDmOqOTFXiAuw5nzE7g3FljoG7Xah5RynrPT6VeSquLfLu0yel7
vbMYkeyu
=XhpI
-----END PGP SIGNATURE-----

--2pHDMeI6Ju8/FUoA--
