Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BC3C27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 17:24:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FE078839A;
	Mon, 17 Jun 2024 19:24:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dxZ/wDh8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DFC688349; Mon, 17 Jun 2024 19:24:01 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FAB988254
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 19:23:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3c9c36db8eeso2525267b6e.0
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 10:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718645038; x=1719249838; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2OzR8KAWtfHlgbTzUTIiu2NIW7coa7ldeg+zMV5XsBg=;
 b=dxZ/wDh8ILtvWEMwV5qctbeVhLEjWNVKKNjvT41e1UiDcqE4QTnTKfeDDzlIoLBCh1
 HEciYJ1DoRFMJFnR9pzhZkVEmECruGgw/b9PtQD0/SSXG4cgtBJtFDqvwiB2h3US81lj
 yunkZ5BayeOyrWPBjsjw/BWtQBq/IkFE1gasI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718645038; x=1719249838;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2OzR8KAWtfHlgbTzUTIiu2NIW7coa7ldeg+zMV5XsBg=;
 b=LbTxbg31Ww/TdN8oSNSj2L0PaB46bPVSiBqanvXrGK9vry/sw4Ane8W4vLHfQ3CoH1
 bT+zyv2e2XnzBMk9brqXVe+AywDxRgy3VSf9V4sD7jGatxCZ+OneAFshDwb1yYdjRjcE
 eM/lhlFy/3I3IZQRTMK0Phpl08e2IFd2Mo5wKDYUFqXTahDbFHwXFQ5K0/wjvbMfK+xw
 sEkrXxbR6hOLl6Xw4Ge2uLRhxOpzdhXfXv7yI9y/iM9k8KRX+vvH5sIzZtben1Zlfg9C
 iwxTf4T1yG7IJnkailb2z+D5WRt7xgr3Ck3cQ4V/7qXXua3nNgsBk1Ma8tpFwI5odgc7
 /+iA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7INfneCg0EnkK9sX15aiuD/dLARJz0krHkjDU2rs3P7JRmIok3DLczWQlzTWrZ7x0kSirGBDloJ8cqu7J7dMMDfsUcw==
X-Gm-Message-State: AOJu0YzdSvN8ONDJEYXsqWGVNramY1cV6rmMJeD55fIky/qwBJKjMJLl
 Gf5VbxxJoO02yJq4kGN8MBJY1CKEtBwyGJpu7gh51ARigz/QRPtG0p5+Dh+aUYk=
X-Google-Smtp-Source: AGHT+IEm/JLb5QS+HM2Waaty8VB77pTOZAqjx2M6br/wBFo17noqtzew81Zi4icSwivN31nhAjayZA==
X-Received: by 2002:a05:6808:144c:b0:3d2:2181:a90d with SMTP id
 5614622812f47-3d24e9ebde5mr10630837b6e.56.1718645038042; 
 Mon, 17 Jun 2024 10:23:58 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d2476bba19sm1554167b6e.35.2024.06.17.10.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 10:23:57 -0700 (PDT)
Date: Mon, 17 Jun 2024 11:23:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 John Watts <contact@jookia.org>, Ravi Minnikanti <rminnikanti@marvell.com>,
 U-Boot-Denx <u-boot@lists.denx.de>
Subject: Re: [PULL] Pull request for u-boot-nand-20240617
Message-ID: <20240617172354.GB68077@bill-the-cat>
References: <CABGWkvp+-3fQu=miT-g=MeJzd91kJegEO8azoa20WKz0j+W5CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AtNKGanuOXWMI8bo"
Content-Disposition: inline
In-Reply-To: <CABGWkvp+-3fQu=miT-g=MeJzd91kJegEO8azoa20WKz0j+W5CA@mail.gmail.com>
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


--AtNKGanuOXWMI8bo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 04:34:19PM +0200, Dario Binacchi wrote:

> Hello Tom,
>=20
> The following changes since commit 2248c96ea1cf0b65377040d9f87ce7d8cf534c=
63:
>=20
>   Merge tag 'u-boot-stm32-20240614' of
> https://source.denx.de/u-boot/custodians/u-boot-stm (2024-06-14
> 08:13:54 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-nand-flash.git
> tags/u-boot-nand-20240617
>=20
> for you to fetch changes up to aad8aa56d96b1305ae5a9708b604b2f2a4e97c4e:
>=20
>   mtd: nand: pxa3xx: Incorrect bitflip return on page read (2024-06-17
> 09:43:45 +0200)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/pipelines/21=
158

Applied to u-boot/master, thanks!

--=20
Tom

--AtNKGanuOXWMI8bo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZwcSoACgkQFHw5/5Y0
tyyzmAwAiM9XMfN1suW+zSZmFcFQ4b725VlLMJUXC23NZvvB0Xxdvj5u8Aqd61J2
Q2J/HgKoGDNelYJdFdAQThukhWS7dh4uYjD/c2lZ84+3X+7yT8PDKQWrVk5V721E
8MtWfUzZh82UBc6BDcm75iYHXG1ETyMCA8isvrxwQ9HN48BzK7l9bn0bpQm9usIe
iNSYt8C8hJZ0oT6z+FH+0pRohDPLGQY8L3rDySXWG9lvO69g7rN+a92q4ZJmSbQ+
avnDx0o6SvxJq6YwM/kazZraJBGFDugOYB8nLZ6tua8l7jDJ8ww+r9LYJ/LFKKLn
l4QJMGxZRfm2yBWS2ZrIgAs1+ousmp1P0gX4JIHlpWxf3C65GzlO48aZSu13T6TC
qfAqiqaY8WCmcD1v7pCrKRHvLTzErJEsFIj/mdtrCek4OhXZfi14R0NrHTNynLZV
FTJ7lFhukaUZ+LP3BqfRHVNjdI/AZtSrwuxsjkb/2Df1CYwFEFwIt8fpwxVxjVH8
6QtwPdu5
=ij6+
-----END PGP SIGNATURE-----

--AtNKGanuOXWMI8bo--
