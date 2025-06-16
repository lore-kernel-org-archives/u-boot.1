Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694A0C71159
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 16:42:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A688D82A0A;
	Mon, 16 Jun 2025 18:42:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jtCi6NE9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3F8782B18; Mon, 16 Jun 2025 18:42:49 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDF1A81E18
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 18:42:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-408d7e2ad03so3114553b6e.1
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 09:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750092166; x=1750696966; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Xg5d4gkklUYYOgvuk+8lLD4/M2/08lzrzyrmWIWwnSU=;
 b=jtCi6NE9I9qWTY0jzVeov4YmIuC/p0aakJskFhOHYkVVIYky9vK65I0wy/Mov+fLUK
 YeufSC8sjemvydMOk9obI/FVsEtHDeB601tcalT+PN6yfDoNAUzyUB7yzc31m4R+WXT+
 /ExLi/5ax60ab2ZNiQJrpdUdfbOoEwt+aPUls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750092166; x=1750696966;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xg5d4gkklUYYOgvuk+8lLD4/M2/08lzrzyrmWIWwnSU=;
 b=PxHXBfdBmaSQWn2ABbhAQd8u3zesWqhlcvJcXqIma/BjZeRNyWg+7T2yPajbC7aD0Z
 DyqzEH7PzUvG53x9ZfbkGxsviX8Lv2QH8hr5pkkLmB7i9Yp3aboyEc/OQaDIgR4qTqm0
 fvrckc3PzwK/YkBloUobeUQWj013+rcN878w+c7GzRKoJhIpucCQVyZ1hp7pdyz4tVSN
 gCUnS1yCib8GkNdNyahcTEpOVGCCoNA2OQ2SeYJ9OoVhp7qA7zDdNNhWGZDb04W9i5G/
 Z77t+TAxb+t6R4Ra22ln64SKuar+7xg5pel4EvrCsn5/hoPbejKOd4IT9oj+q5K/IQ8J
 qaaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYgJOOEEjk9MiiR1SzN7eAgzUcYakKtcvZxfPo2KB7p4OHdD2/nfvv3Ekx+i9AR+KQbgpM4BY=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7rqHf1Ibkws//vd2b5jQCxJUWsNJUsyVCW8y7CV5MgDMY8MlD
 HXI1fyE7EON5Vk3fIIyhMDGqflZE/O6DmuIk/l9Tf+oTeDPmcxh/Awd9+7+qMxqBgyFjXIyaxRF
 3GNxmOFg=
X-Gm-Gg: ASbGncuQTeC3mF4vf02OSrvg6igHiZ1tRW6mlIO5X5AlvYtvMMZH+X/z7c8V2LnSJeN
 iNwIuojkpVam+7zfduU9XX+tUk7nxBl2sOgiG6fPVgjj6oGgkwqerRYQIndtqXe5cv4RIKpON9E
 QA/BHCnF/E+Q7XoqovS+Qa17FqYsQcRYER7MX6tZRXkZIiF41Yrj7dBpttBpnksId+WDN7ivzjx
 e5eb1QT+IPZjz/nr8by8Y8Hhqe8Zm4cqtJI/RyOsfQ831xNRra8bMNOUJo+A0eKr27oBew096lC
 SVe0j0/talPSKc2MUwOFtIITVP6UlOxsODYz4PRwLdQdOu9Y9/DE3/y4d9/dtfaX3cxibJmAw3t
 2DMDkM8qlzYEBSIePGYqjKww=
X-Google-Smtp-Source: AGHT+IGtEJ3peR5sF1Vtq/dCTSKahXCCDZT/b/NOXN87QlMSUGXHWjvmQmEp4uxkqsAzWvCnSSoCPQ==
X-Received: by 2002:a05:6808:1693:b0:3f6:abbf:bb88 with SMTP id
 5614622812f47-40a7c1c46e6mr5934863b6e.29.1750092166411; 
 Mon, 16 Jun 2025 09:42:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40a741bd6fbsm1534632b6e.47.2025.06.16.09.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 09:42:45 -0700 (PDT)
Date: Mon, 16 Jun 2025 10:42:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, mikko.rapeli@linaro.org,
 Jagan Teki <jagan@amarulasolutions.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] arm: io.h: Fix io accessors for KVM
Message-ID: <20250616164243.GH1382132@bill-the-cat>
References: <20250616075035.1144220-1-ilias.apalodimas@linaro.org>
 <c7d2a64f-1415-4481-9c2c-072e0abb2698@linaro.org>
 <CAC_iWjJxE_XSbHAZcxf2bVssnyqesT5td3XxAAvs80-PSMQOjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ud5AuIYAqzDh+T07"
Content-Disposition: inline
In-Reply-To: <CAC_iWjJxE_XSbHAZcxf2bVssnyqesT5td3XxAAvs80-PSMQOjQ@mail.gmail.com>
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


--Ud5AuIYAqzDh+T07
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 04:11:32PM +0300, Ilias Apalodimas wrote:
> Hi Jerome,
>=20
> [...]
>=20
> >
> > If I'm not mistaken, this patch is doing two things that are unrelated:
> > (1) fix the KVM issue and
> > (2) get rid of the __arch_*() macros in favor of the __raw_*() macros
>=20
> I can split it, but I don't see much point since we redefine the raw_macr=
os.

For point 2, I'm not sure it's worth splitting, no.

> > IMO this should be two separate patches.
> >
> > >
> > >  /*
> > >   * The compiler seems to be incapable of optimising constants
> > > diff --git a/drivers/spi/fsl_dspi.c b/drivers/spi/fsl_dspi.c
> > > index f2393c041f44..545561ad1169 100644
> > > --- a/drivers/spi/fsl_dspi.c
> > > +++ b/drivers/spi/fsl_dspi.c
> > > @@ -123,8 +123,10 @@ static uint dspi_read32(uint flags, uint *addr)
> > >
> > >  static void dspi_write32(uint flags, uint *addr, uint val)
> > >  {
> > > -     flags & DSPI_FLAG_REGMAP_ENDIAN_BIG ?
> > > -             out_be32(addr, val) : out_le32(addr, val);
> > > +     if (flags & DSPI_FLAG_REGMAP_ENDIAN_BIG)
> > > +             out_be32(addr, val);
> > > +     else
> > > +             out_le32(addr, val);
> > >  }
> >
> > Unrelated change
>=20
> Due to the the new do {} while(0) macro this doesn't compile, so it
> needs to go together.

It can be done first as what the driver does now is valid but
clever-for-clever-sake, and cleaning this up is valid before the new
macros.

--=20
Tom

--Ud5AuIYAqzDh+T07
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhQSXgACgkQFHw5/5Y0
tyxE3Qv/dD5GgDLkv/JHrqUtnLZZCJ8LoO+8SoerFhBZFP4CDkzTArlus/Nj/5Zl
7swZQV9DJDl+903m3sRJ5MeeM+Or/H9H9HQov5+yDckhVSbMRJAYgop/3HD67EGK
wnCzVMH15X5hvNlT7HMSmZIaPAkgnPlDViGz3nvEzx+tlSkTRq4EvtmBgEH7psJl
EVw0bP5PwTGrv35JbsmUteA5XFKCu9qiCvdLUyGXx4vPYMxLJWT7qwss8LidxeT2
NqGu8FoY5J2ShkuFjbQI/kfV/5VxvWu1zT19meJcCQuvRvEZ3scO5qZGu0AnC06J
1f5DJ8joP952MtDmdrH5LUFx8zPH9yof7actsUSxfgY7EkVnqEXaUyj09cJvlVFU
yA4nG9aAepRndTolCDQFVRmCNcZaj2kF0TN0II4bxt6/P/UGnQdOk6SjxYTOdPoD
Up5/vlq2X0et+FW1Cy/eO2LDeHvVSDlJmHAYSDTpeR3p7ChUFFtisRc94WCi6HaJ
f+3BvKl7
=tGss
-----END PGP SIGNATURE-----

--Ud5AuIYAqzDh+T07--
