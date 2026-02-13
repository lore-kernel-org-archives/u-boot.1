Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B87EDF176
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 16:11:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8B3B83015;
	Fri, 13 Feb 2026 17:11:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f3okLDsl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A64D83AA9; Fri, 13 Feb 2026 17:11:29 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AFD782A9E
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 17:11:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4638e238094so587950b6e.3
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 08:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770999086; x=1771603886; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wlPGzh5S7I2aY4ae/TCvL/1numjRiiEU7uywbn3/6ZE=;
 b=f3okLDsluYXs1FmpuM4B/DGeoYgAsbH3mvJFyWUDOd7BJqCcXzycJo5zNL6tQek//f
 OO6VDPEAIg3SvAXkaIkwXFK+YL0zvo16vott42/AI4hB6rjp/OpfKVbXwJ6jK4PwIsmh
 DhS+mdkfUREzF2cUMCnu7Z1s7x6uuAQET4mmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770999086; x=1771603886;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wlPGzh5S7I2aY4ae/TCvL/1numjRiiEU7uywbn3/6ZE=;
 b=fwgsVWp/LIOcxMicOMgQvJqMXsYwcrStoEY7x05DfZwTAVP1AN/8E0q32J4b+kMP4J
 hLTDrDYnDl30FrHrTJXbMlaYJkiIbnUmZdmnx413TSAmzFLQZTIeQDcQTGla2wK+SJNf
 6VwCC+gnpFDWxpADwJ5aI05cBsnenvtZhe9zpEDpw6Yr4RYB1fQL8nVYM0h7Nr2VkDjF
 TMjbI/UNrZAw7YjhTmtVfvvucnb8B+ZT0Mb+s81i71T+HXaN8zA8psu+oB7R95s3+uKl
 8f3UhRyWTCJer+s8HztiT56pvY6TcNk/pkTwNGC9+31vT6KatVEFBaeCJQqRhkUs1P17
 6n4Q==
X-Gm-Message-State: AOJu0YyGwkxtaNsYRbpg3u9uIwBycSdLExzNS3ImamA9m+VtCyXBmx31
 awVMg0tk9ZtB1Yz5NzUbg8w38fmWiTxil8qn/74eLydAC2bJEXQ3Cuf/L5sws+x5pAM=
X-Gm-Gg: AZuq6aIkX5xM5FR0n8xyiY4gVcxeafTlfjFL169FAosqaZlwsQjrxQMAjrALueqxQhc
 fdpCDJZQT08zpWcXtWfgRvpmky6NAJDntUy+7qRzKJxC8efkPvMT80bHa61vUc2J+Fm2dP5HGFR
 jZfmTLHrGHnHI46QD/6OZPi4bA1lrppOcn2WBcvASvYJzT3OZnutxYJygW71C21Y81nYoPTy6Oe
 ITkqHQ/0Rit4pWTg9J94EDO8/TT76jCmuNfGMjlKp2ANACYVPxXRMt6QA+l8xyLrkPCVS5O/UOq
 cfmjlw761C5mtPNNwZn0dr/V2lOcF98A0LtIR04oI+S/+Hm+5msaPqpHLydwmV4Rnf/EX6Lqerh
 Ms20OuI+fPMZcFyIMaVpLLP5d75/kU1zS2tMAJPe3vnfcUoHEkxIl0U0HHDBoUpWZCuWoRr8KKV
 tOuuH+odYqPg2AjOj4T/9sAKsnIu9ZKjWxLUKraz1HaBDr6Uk6E8KEu23wdUDrivTPa03kGEjyP
 KbvVpDCtD4lvQ9f+PxXpOliO8tyHPR3tLTg9a723rA1f6Qb8uoeEXeMT3q7ZA==
X-Received: by 2002:a05:6808:1911:b0:45f:a12:5c88 with SMTP id
 5614622812f47-4639f2278a2mr1365161b6e.49.1770999085763; 
 Fri, 13 Feb 2026 08:11:25 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4636b0cf66dsm4618346b6e.19.2026.02.13.08.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 08:11:25 -0800 (PST)
Date: Fri, 13 Feb 2026 10:11:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Christoph Reiter <christoph.reiter@evk.biz>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 "vigneshr@ti.com" <vigneshr@ti.com>,
 "tudor.ambarus@linaro.org" <tudor.ambarus@linaro.org>
Subject: Re: [PATCH] mtd: spi-nor-ids:  Add Fujitsu MB85RS256TY FRAM
Message-ID: <20260213161123.GA2375281@bill-the-cat>
References: <DU2PR09MB5294504C1221EF029607D88C8E3EA@DU2PR09MB5294.eurprd09.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EhPFW6oJMKhsnDc4"
Content-Disposition: inline
In-Reply-To: <DU2PR09MB5294504C1221EF029607D88C8E3EA@DU2PR09MB5294.eurprd09.prod.outlook.com>
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


--EhPFW6oJMKhsnDc4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 05:53:58AM +0000, Christoph Reiter wrote:

> This part is an FRAM, but can be used through the spi-nor generic code.
>=20
> Signed-off-by: Christoph Reiter mailto:christoph.reiter@evk.biz
> ---
>  drivers/mtd/spi/Kconfig       |  6 ++++++
>  drivers/mtd/spi/spi-nor-ids.c | 13 +++++++++++++
>  2 files changed, 19 insertions(+)

Sorry for the delay. For ease of future re-syncs these should be in the
upstream linux kernel first, and then brought to U-Boot, thanks.

--=20
Tom

--EhPFW6oJMKhsnDc4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaY9NKgAKCRAr4qD1Cr/k
CgofAQDsw7ohOX2KNLcpOu1YtU/je3OjT0gydy4p7gOdNRmQVgD+L9/bWzV+v/Aa
SCA0qXjh8bb6Lf/NifeQOdhz1PJxcgg=
=tyMJ
-----END PGP SIGNATURE-----

--EhPFW6oJMKhsnDc4--
