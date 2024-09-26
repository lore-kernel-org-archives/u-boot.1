Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00EEECDE03E
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:42:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C5C288F89;
	Fri, 27 Sep 2024 00:42:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gu0PYMCe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AB9E88F89; Fri, 27 Sep 2024 00:42:38 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C42CD87B77
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:42:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7a9c3a4e809so126768285a.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727390555; x=1727995355; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZwaqaSi+zUhc4Wi9jwGvpxQPOl4EAzBw4UAe4DsPIc4=;
 b=gu0PYMCeXvnAvaW/6oonjfAbF8+luCpQg86lb8ZDqGMBXkdWaSGmH6SKtotqp2P0vb
 jvmefjZ1a5LBD0lXzLFpJH+EReLr5+eBx13Il8q8soHBqCXIAQRCXT5oAQRTMoy8DaX9
 PzgW7qYKoBGl778wFxrc5jxQ+rkUSsn0lhYqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390555; x=1727995355;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZwaqaSi+zUhc4Wi9jwGvpxQPOl4EAzBw4UAe4DsPIc4=;
 b=jml5mKNld1nOB73jZ8UQCurljLS/NQ/Oy3vRerpfcqDd/daB7pcehn/YUOQW4ZQ50H
 TNnORT+XP9uo80257x/7V8KSU6umSXsZbpoZK39xc+qCgoVK3wlx7eQZzWsDvhFE9LM2
 J7X1iCC4EBB0HK75J9lArHYfLUtN0umECSiUZeHVO0TbWKLryU8clabJlJHGtbXYX+OM
 w8cXZ8Yyztb5BPLY7/vm8hUHbv6ZL15DGruIsfz9Hbtk5R939mMtrSj0RYvwScTOTmyw
 dZ7o+mivC6TOV+PXx+/shfUmJyGuZWBBbw0/+y3VI5WQHJeYLcVm1BxRxvIM/INslFYU
 74tA==
X-Gm-Message-State: AOJu0Yw+shHIM5Do9wnhdbh9yRWRSbKdaO5MZ6LCkxccQbaY9RbvQrdy
 Q/oXFsi+RXTz0Hxc9uBtU3SmyfCv4jLzydolPadD9j1pB/sU0NlT6+E+dgaerBQ=
X-Google-Smtp-Source: AGHT+IEjumU0Egysrex3P+WSjSSskPvzZYMDoEIjCV3wqK0bio9qR8K2XZ6UYTxJIGuzBVfwwA8tqg==
X-Received: by 2002:a05:620a:4087:b0:7a9:b2d6:7fa5 with SMTP id
 af79cd13be357-7ae3782e4c4mr186964485a.26.1727390554606; 
 Thu, 26 Sep 2024 15:42:34 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae377bc95fsm32525285a.21.2024.09.26.15.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:42:33 -0700 (PDT)
Date: Thu, 26 Sep 2024 16:42:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, jagan@amarulasolutions.com,
 git@amd.com
Subject: Re: [PATCH v14 0/8] spi-nor: Add parallel and stacked memories support
Message-ID: <20240926224230.GK4252@bill-the-cat>
References: <20240926045508.1492638-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7PqBkX0P50UIEhDo"
Content-Disposition: inline
In-Reply-To: <20240926045508.1492638-1-venkatesh.abbarapu@amd.com>
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


--7PqBkX0P50UIEhDo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 10:25:00AM +0530, Venkatesh Yadav Abbarapu wrote:

> This series adds support for Xilinx qspi parallel and
> stacked memeories.
>=20
> In parallel mode, the current implementation assumes that a maximum
> of two flashes are connected. The QSPI controller splits the data
> evenly between both the flashes so, both the flashes that are connected
> in parallel mode should be identical.
> During each operation SPI-NOR sets 0th bit for CS0 & 1st bit for CS1 in
> nor->flags.
>=20
> In stacked mode the current implementation assumes that a maximum of two
> flashes are connected and both the flashes are of same make but can differ
> in sizes. So, except the sizes all other flash parameters of both the fla=
shes
> are identical.
>=20
> Spi-nor will pass on the appropriate flash select flag to low level drive=
r,
> and it will select pass all the data to that particular flash.
>=20
> Write operation in parallel mode are performed in page size * 2 chunks as
> each write operation results in writing both the flashes. For doubling the
> address space each operation is performed at addr/2 flash offset, where a=
ddr
> is the address specified by the user.
>=20
> Similarly for read and erase operations it will read from both flashes, so
> size and offset are divided by 2 and send to flash.

Size-wise, this seems OK. There might be room for a little improvement
in the "we don't need this" case, but it can be left for later, if it's
really possible to tweak it more and it's an issue down the line. I
intend to grab this for next in about a week, unless there's further
feedback.

--=20
Tom

--7PqBkX0P50UIEhDo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb1408ACgkQFHw5/5Y0
tyyE5wwAjcNSeuqA1ajbLibnMx6mKPlk+KNbtfz1/Fv5MF3cdyHAxOwnGgBDEPHg
++jlYu508N4aEPhi3/DYF+42ymlrKiffkc67K1Qm4jIu/kf2/1nVAGsH5FeOrk3z
t4GwREuuRJPLprHMuI1WQHh+BEespm4/fZtAUBdk3I2t599h+RP2VwFkzQYUz3Ad
pJT//EYvymf1ok1wFwYyT6juJdgy26kbL5sQ+mn55oEelWvWGj+9nVQFBdFOqqxH
9AQ/08KLh/AVZb37xJotgJKiwj99KVY6FyGtWQKCd5vp+ZzScoWWcH75zK8BveFI
mGgzsWii82anRBl06hRlqAnnRn5FNEHXuDmr6zjC2omidQaaaRY1zHEdalTtzT2O
iICIw2103L2SAopO32263BFQ0JJ8MAqie/5kKCuMoHZRQXjM+Fla8x1JJEtJ+Qca
n5y+YoBa/jXozaLDStWWYUnGKg7bXPZtV1kNWOqwapJHqx3SK8z6CxqN/6+CJxTC
PDCRNFkM
=w5dT
-----END PGP SIGNATURE-----

--7PqBkX0P50UIEhDo--
