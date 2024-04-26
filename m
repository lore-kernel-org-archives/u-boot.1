Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5746CC04FFE
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 15:52:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 680CF88634;
	Fri, 26 Apr 2024 17:52:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X4hVogtE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 822A1885B4; Fri, 26 Apr 2024 17:52:07 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A65788634
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 17:52:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5aa2551d33dso1511297eaf.0
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 08:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714146724; x=1714751524; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EqfAXILdqkZCSogyxWQsNtLU6BACWb0gMGcyiJMMSMA=;
 b=X4hVogtENHgkWW+6FU3Nn9j31AmX34peY1GiXkZ3NcncA2+5wrKG3ItPNbWolRWokQ
 iPIKk+/yPLXHezAIii8XtKfq9+xsDczqx8P1Lft5odRnr5vZY8dmibH2ZMWjUdPCyMD8
 Y8u+jdJdq2WD+YM2OMr/modfaEkT2oSvHKqcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714146724; x=1714751524;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EqfAXILdqkZCSogyxWQsNtLU6BACWb0gMGcyiJMMSMA=;
 b=amTtRmgY82oDLtLaQ17ET0Cp6sVGmYrRVHt2Mo4Utwuwu2VJ46BtwHih2NYoCtP3WW
 2/QTGo/EtRsFxxpaVSIxl2kfE/07RrRinnlCJboyVxCGrcOyaqMgPjPkd2j8Cf2yumIl
 fyvqxuuE61Ly0Wc7QArAYJ/q/VpqYgaRVbsyFqjCgwteKzT9DTNplbq0YhzQQCWyTkWx
 7foHtZIkek3VKTinK/LnguS74bnBWnLYt5w2VJXaibSy/bGNRSDyPLzFDkoIYS/La1h4
 WAuj78dGnGKyoD8cf482E8Ramw062DM1COQtHAx1BK92/HUuOSUXoS6NtrVhZi2mSIVr
 s8Xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUat461kRo5VgYmCb5+a9d1x/2tpe/g6tUJege7GuCrFoN28VCcGXEPHFnlYwQXM/q/sAIZcZcwca6/53yYpy6i+u/FPg==
X-Gm-Message-State: AOJu0YxsEz0YCrmqVYH4lHO5Xb9CwHQhb2rXuGLn7kyeP4jO72iefH6P
 5cE1XBdcfZoTjwrg3moOz/LusAMvBl57dG5n6CgglFtPiisDLnZfOlDaT5Qu3G8=
X-Google-Smtp-Source: AGHT+IHNbXb4ig/AdQG+dopdCdbSr0ibxovWaHSPA0qUAleEJFu3Dsf+SfyUje5vfJdesIb3QLYdgg==
X-Received: by 2002:a05:6358:d587:b0:18a:e9ac:bdf1 with SMTP id
 ms7-20020a056358d58700b0018ae9acbdf1mr2730461rwb.17.1714146723677; 
 Fri, 26 Apr 2024 08:52:03 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 qh30-20020a0562144c1e00b0069b50de8fd8sm6804683qvb.24.2024.04.26.08.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 08:52:03 -0700 (PDT)
Date: Fri, 26 Apr 2024 09:52:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>
Cc: Kyungmin Park <kmpark@infradead.org>, u-boot@lists.denx.de,
 John Watts <contact@jookia.org>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH] ubi: Depend on MTD
Message-ID: <20240426155200.GL1054907@bill-the-cat>
References: <20240411-mtd-v1-1-fe300f6ab657@jookia.org>
 <CAOf5uwmcrh6M-GGYwZVk3D4LzZRnk8fE+88JJgtOAHJ_X2=P2Q@mail.gmail.com>
 <74dc9d77-9316-4c14-5d52-9b496cad2a76@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7qWgUl5bO5GPyDEX"
Content-Disposition: inline
In-Reply-To: <74dc9d77-9316-4c14-5d52-9b496cad2a76@denx.de>
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


--7qWgUl5bO5GPyDEX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 07:18:18AM +0200, Heiko Schocher wrote:
> Hello Tom,
>=20
> On 11.04.24 08:09, Michael Nazzareno Trimarchi wrote:
> > Hi
> >=20
> > On Thu, Apr 11, 2024 at 7:06=E2=80=AFAM John Watts <contact@jookia.org>=
 wrote:
> > >=20
> > > UBI required MTD to build correctly, add it as a Kconfig dependency.
> > >=20
> > > Signed-off-by: John Watts <contact@jookia.org>
> > > ---
> > > While working with UBI on my SPI NAND patch series I found it was
> > > possible to enable it without enabling the MTD subsystem.
> > > Add a Kconfig option to solve this.
> > > ---
> > >   drivers/mtd/ubi/Kconfig | 1 +
> > >   1 file changed, 1 insertion(+)
>=20
> Seems I am too dummy to find this patch in Patchwork, nor is it
> applied in master ... can you pick it up, or should I do this and
> send you a pull request?

It's over at
https://patchwork.ozlabs.org/project/uboot/patch/20240411-mtd-v1-1-fe300f6a=
b657@jookia.org/
currently but you can take it up and send it to me if you like.

--=20
Tom

--7qWgUl5bO5GPyDEX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYrzaAACgkQFHw5/5Y0
tyyDpgwAtxAb2tMsrbP47PC4HedXqWxwtqWd2y0jIRy9lNaSqXAD1Ns/gPoRYj+Q
6oanbVP9UHVmDtVTBD9RQhmn+cfd5jD80lIT4l1IHv5+zWs3WtcKWQSw7RoOuyRj
azomzh9NNIKduUL/+3KJL/0hFRjayUKKBp5hsUoGPSUP++Dhn9+8oii6th9tYNrZ
y0lkYEPOhkttU5kVgDVheDUxQ/x+O3TVrjpGlFRdoJ7BKM8B5tSQNl2csByRbIBK
c8hQZW6uYQ9+9ufKEKJEkdw0SyfM12KM37b6bDDOoO/pN/W1ULl7HgdnPqyLfvqj
6JuBfiS+D8VHSUQ+5nJ1U8Q+jY7ctzxpW2pWi4RWWf3fngG10MT5F2BQfuSnMg+H
ltgPH2+oLBYr6uQW8H7LyD0YIunmegc/jAvv/xufteGQIa9hYef/DM1NDQgWp9Rb
+ruREQDFfb6NIyDaZmoOUa9SuCMtqkkVH1+9kc0N23f7K/1YMNawSNUAR9lTl3oz
U11IQyZi
=sPyD
-----END PGP SIGNATURE-----

--7qWgUl5bO5GPyDEX--
