Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9534CC197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 18:42:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D010874F3;
	Thu, 16 Nov 2023 19:42:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FnN3UtD7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64A5F8269F; Thu, 16 Nov 2023 19:42:35 +0100 (CET)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB13C874ED
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 19:42:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-45d94e7759eso425669137.1
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 10:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700160149; x=1700764949; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ckO4ZddomYlkx0paK6BNcO/SP03t9BOTf1PGkaeQ7oY=;
 b=FnN3UtD7fVyFDl1k2F19xgU/YCG6EyvTcwhbIGaiL8I30absQMSt9shHdog8f7Jx9F
 B0GnpwjlGz2EW2UgIiOEaBdkI5DFobTZGfwD6TRBtKklgNQnzBdmyCpFu/uP3UOIRbFy
 bcixE3wSodT17BNQAu2QLkTY2eg3b8nsVsikw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700160149; x=1700764949;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ckO4ZddomYlkx0paK6BNcO/SP03t9BOTf1PGkaeQ7oY=;
 b=aVBLPBrnGt3cyV4MKyre7V9sUZiF6YNZv5JdWCr7q8iTcOQUa+SjNtnqLFzr1cN46C
 WUF/UKUCBI0KhbhkJcn5ZHtrZk6RDlQhhIJ4bPhRU2uah3KgO2MP5FDaZi0MkOGMOjD1
 1WpRQdUdEp3O+NgXUmQG0U49Ti6Aaljh9wjL5epX2PJsXLSXkg06K+QshUEHzP229cD5
 yHESzvDbdw4hF3ggMMuHUsXUykzp/iUql00W0rfm10cn8zIdQjnRRcRHi07O9HWAkDFM
 ulDKRAKwt17WRe83/Z1cJQ8C+0hkccg0iuBMMVj5htIwztC8O9WMg6LULV9VkhsrPTwZ
 zezA==
X-Gm-Message-State: AOJu0Yxi8eIFwwG2D1YRLM8O88g5GWcsDozXl+CKd6ECIx1I6szfZUpv
 wWXsSihaGhCbYuTKTJbaW2qjXg==
X-Google-Smtp-Source: AGHT+IEyLNAPsUypzBzN76Hn+ILCDqDuznoh7Yiv6sMrSJC5QniQ71XV2fx24iPxJfS4/Sb9K1Xq7g==
X-Received: by 2002:a67:ac07:0:b0:462:7164:cad with SMTP id
 v7-20020a67ac07000000b0046271640cadmr2312199vse.32.1700160148895; 
 Thu, 16 Nov 2023 10:42:28 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-31e8-20a7-2ee8-ec91.res6.spectrum.com.
 [2603:6081:7b00:6400:31e8:20a7:2ee8:ec91])
 by smtp.gmail.com with ESMTPSA id
 k9-20020ad44509000000b0066d132b1c8bsm1549237qvu.102.2023.11.16.10.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 10:42:28 -0800 (PST)
Date: Thu, 16 Nov 2023 13:42:26 -0500
From: Tom Rini <trini@konsulko.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: "festevam@gmail.com" <festevam@gmail.com>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>,
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>, Stefano Babic <sbabic@denx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH v1 2/2] imx: spl_imx_romapi: fix emmc fast boot mode case
Message-ID: <20231116184226.GF170968@bill-the-cat>
References: <20231026073220.244387-1-marcel@ziswiler.com>
 <20231026073220.244387-3-marcel@ziswiler.com>
 <f9ce2b20-1fa1-408c-9ae6-4dd382c9c999@prevas.dk>
 <6ab14ae1-7044-4663-98e4-919b9d1757b9@denx.de>
 <899b50aa96b802275035f9ee40f46b461f8bfb46.camel@toradex.com>
 <86ddb623945da5a507fb4632375f7cb70361ac58.camel@toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AdHGEf4wmgHLAlq/"
Content-Disposition: inline
In-Reply-To: <86ddb623945da5a507fb4632375f7cb70361ac58.camel@toradex.com>
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


--AdHGEf4wmgHLAlq/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 10:57:27AM +0000, Marcel Ziswiler wrote:
> Hi Tom
>=20
> On Thu, 2023-11-02 at 08:09 +0100, Marcel Ziswiler wrote:
> > Hi Stefano
> >=20
> > On Thu, 2023-10-26 at 10:36 +0200, Stefano Babic wrote:
> > > On 26.10.23 10:29, Rasmus Villemoes wrote:
> > > > On 26/10/2023 09.32, Marcel Ziswiler wrote:
> > > > > From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > > >=20
> > > > > This fixes a regression in the eMMC fast boot mode case where the=
 buffer
> > > > > was missing 464 bytes.
> > > > >=20
> > > > > The code figures out how many bytes must at least be fetched to h=
onor
> > > > > the current read, rounds that up to the ss->pagesize [which is a =
no-op
> > > > > in the USB download case because that has ->pagesize=3D=3D1], fet=
ches that
> > > > > many bytes, but then recorded the original upper bound as the new=
 end of
> > > > > the valid data. However, this did not take into account the round=
ing up
> > > > > to the ss->pagesize. Fix this by recording the actual bytes downl=
oaded.
> > > > >=20
> > > > > Fixes: 4b4472438f5a ("imx: spl_imx_romapi: avoid tricky use of sp=
l_load_simple_fit() to get full FIT
> > > > > size")
> > > > > Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > > >=20
> > > >=20
> > > > Thanks for reporting and fixing this, and sorry for the trouble.
> > > >=20
> > > > Acked-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> > > >=20
> > >=20
> > > And thanks for all your work - I will apply this fix soon.
> >=20
> > Any news on applying this fix? Note that master still stays broken as o=
f today.
>=20
> And two weeks later still broken!

I've put this in my not to forget queue for the next -rc.

> Anyway, I feel i.MX maintainership seems rather stalled at times most of =
the time. I don't want to criticise
> anybody knowing how busy our trade can get. However, if it helps the caus=
e Toradex would be ready to step up.
> Let me know what you think. Thanks!

I would be happy to see an additional custodian for the imx tree, if
that's agreeable with Stefano.

--=20
Tom

--AdHGEf4wmgHLAlq/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVWYpIACgkQFHw5/5Y0
tyy2GgwAhRd511zqMBiPOpmCOZ/ygbmurEknPLCBqL57RpbDLcQuUJZRQDAo5lXH
94zH2GMs635qNxi7sSWzopphIVDjNxgmcYtodjhFaO4sn4o744eNsa5CTB9t/ynE
elv0so7BYGD4qPMPXB+8yCrLmw04STOrdE84NnQFSyMyoRO8Eg+7+jtENUeJC85t
woQZsIAXuSADp2cbrB4mhUtePXt4Pm/rk7551EXq099bmDo4Uwsofc2HuRkLZ0wm
4yR4vkpS5N/DujLVknpc8FKvsvHzvzugYbJ1qMy/LXHkF0phNxIvs+zjV1P3YzbZ
YGBM1EXUDKPeLvQuQ6yNGEnDE2A6A70ROKKchpSCiEmH1fivda1uT101qGklcQyG
uwqHIuFbF0RgjncnkdJVdH8aW4DQNNrjqvVppAEeJbNIniF0Cj42IbEjAmLpWlRC
tydEEm6zXN5S7jc5EZjTqkB7OTYj/LHHPixQoHxQEfkqDpAL/1ZvRcTM0ZXMW4Hm
7acC2oV6
=kGL3
-----END PGP SIGNATURE-----

--AdHGEf4wmgHLAlq/--
