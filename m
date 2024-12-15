Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF9EE7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 16:51:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 373D58004F;
	Sun, 15 Dec 2024 17:51:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fb7+BqRp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D82C680040; Sun, 15 Dec 2024 17:51:13 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63AD080050
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 17:51:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b6fc3e9e4aso216093085a.2
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 08:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734281470; x=1734886270; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DF/i7CGg/SzJHxX7tArwK8oDMkJGI6ZTLqd2ORqXOK8=;
 b=fb7+BqRp9iw6nE9XG9sj7UKz1hFBkrfzhTzPoKm3JWuwS+M5EkRdInF2Lbfnp8EoU9
 IWr2BjD2yr22517rurcgzc538hKRIBrsd6uDdmP0V7/95MaWrYPdlJrsRZWOTPppLWEw
 HtxKYusL/E0NZbTd0v7paTUds/ejQQp5XOyGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734281470; x=1734886270;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DF/i7CGg/SzJHxX7tArwK8oDMkJGI6ZTLqd2ORqXOK8=;
 b=p/s92ta3ojJ0NI+ErhVCmdb04XFxI08AQ30VWtQHeDj6bi7OmfPBR86iMEJWIvn2pJ
 dkiqNuZtPoYNkVYHCR+YbBGu/PfdyynAImMubuRPQ6P74PfIwtik8L6XlAulugqnCC1i
 r8bC9j170vTroynU/9tHhXeg92BULIOhJrk/QwCzaT5NPGna6s4N3Wu93Ftr2Ng9+pow
 v1f8vfY8HClDXmiS2wtOoJgD/mU61nag5a+/ZVsgNo/VsosuIO0s7P9Q3Qxo+gClaTzD
 S5FkHzsWtjcwGHAOhV5vxEUEGFvEE455eiCVAERJigJuo8GgKYOzUR5HpiFr49FNI/4e
 uLtw==
X-Gm-Message-State: AOJu0YxENBaDswyG+ejhmdaI/g3QprWLYmneuPrcid2bhRaSJuVvEyYS
 BTVzQwn4TGOcZns9B4BtdueFd9GQVu3Ogw51FIdgbZyTS7s0cj7JtKdTcpTOWo8NLa0v/3y7wx1
 BzWM=
X-Gm-Gg: ASbGnctZ/ZVqosJ/K6B+xi0Brlj+DEtx47zKPwmq4PPf0zwDQo4dMwo+525qiYn+Usc
 lm71GqDF5jedGJcD7x/BmP9oDc1x9qG/0ZQewQzlNkHDZOzhx/Fr609rm3txKGktVhfY1GMklsp
 hpSuGQa9o+BD88ZV3Olkj8hWjA3uDRFjCdD5sgz5s8RP+LMegpu0jMIzWAK/xee6knH6COkJzhU
 Tp5eJrPkeeOFR5zM4A1vkzfmZEzENw6KrT0F8mPhDYQdbvVWU+oIe6x
X-Google-Smtp-Source: AGHT+IG5JMmkjx0kfBJje/7F3yzdQv6mdbdPTGqg5U9Ak9tAqUj1QoKNZlqL3/OKekMEWWB02/mnZA==
X-Received: by 2002:a05:620a:4554:b0:7b6:6365:1b72 with SMTP id
 af79cd13be357-7b6fbecc52dmr1467977885a.3.1734281470259; 
 Sun, 15 Dec 2024 08:51:10 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b7047d08a0sm150439185a.33.2024.12.15.08.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 08:51:09 -0800 (PST)
Date: Sun, 15 Dec 2024 10:51:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: U-Boot-Denx <u-boot@lists.denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: Re: Pull request for u-boot-nand-20241212
Message-ID: <20241215165106.GE1505244@bill-the-cat>
References: <CAOf5uwnqcLbVH6Chd_rKc_Q5aEe0jC+-Z5g_K_nQD8wF+qmDOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="U+6G1cITY2xT/5LY"
Content-Disposition: inline
In-Reply-To: <CAOf5uwnqcLbVH6Chd_rKc_Q5aEe0jC+-Z5g_K_nQD8wF+qmDOw@mail.gmail.com>
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


--U+6G1cITY2xT/5LY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 03:46:22PM +0100, Michael Nazzareno Trimarchi wrote:
> Hi Tom
>=20
> The following changes since commit 9452fb7484118822b878ad445237d111b7b1a2=
8d:
>=20
>   Merge branch 'master' of
> https://source.denx.de/u-boot/custodians/u-boot-sh (2024-12-11
> 12:50:29 -0600)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-nand-flash.git
> mike/u-boot-nand-20241212
>=20
> for you to fetch changes up to 65ac40c1e99826b346c5e3b829143902494415e2:
>=20
>   nand: Add a watch command (2024-12-12 19:28:07 +0100)
>=20
> Small addition to uboot-nand. Nothing relevant for now. Anyway
> a nice new command coming from Miquel Raynal and small changes.
>=20
> The patches pass the pipeline CI:
> https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/pipelines/23=
837

This doesn't seem like the level of fixes only we should aim for, for
master at this point in the cycle so I'm going to take this to -next
after the next -rc release, thanks.

--=20
Tom

--U+6G1cITY2xT/5LY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdfCPoACgkQFHw5/5Y0
tywVcgwAi8b/2Wj7NIF/5BnYqJdhh/tBLo5SjowJXj9BigFLZmMajf5nxUDrJYZC
Eoq1Hs7ZlbESQ2EHFFC39TUrRVgiZ4AaO9RRWAqZagYuAEmawsyISPVFm3VIgpE8
UlLt47Gjq2tw8eNsjUuYAFwIxWKrPk7HrIwqXRLrnfKlkGm6dw7qXn4JoIoehJl/
LzHi+/oQ07yTy2BsAw9UjbJPd9snEuLGVKG3WpbpvyRDfPn922vZjnY4ThJSfbsJ
ZuoYPu7+FPSt8xOiE6M2LJHosGc3Q8Orvil8C3M1WwfYy2qRwfZYBNokYkx0fTk3
SiiR0etrD8H/THwjJAlqtBS6mmF6gbzrMorbRgSjytZDFtob7gfEA5JORelPGlw1
T2dA8IvN4wdD46VfK63ngGbpKXCJs8bTuWBrTRvWHyrQ5l+ZnfFOcu3U/T5ChZuG
94lEQyPyfwXC7J9UZ6FR9pOzQX2QPPE5MVb5IwmIuFnG4GgNKO2pGDKL52XF/jf9
cJhrhpPQ
=YOxk
-----END PGP SIGNATURE-----

--U+6G1cITY2xT/5LY--
