Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45F4C4167B
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 21:31:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D86EA876C4;
	Sun,  3 Dec 2023 22:31:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Iy9DTVKw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C1A487539; Sun,  3 Dec 2023 22:31:24 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1906E876C4
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 22:31:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5d40c728fc4so18807187b3.1
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 13:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701639080; x=1702243880; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SjtTwZojIov/0UGGEIbJlkCSAS11Hn3uIpQ0Fxuz6xM=;
 b=Iy9DTVKwft3wke9TvSq3lp/AHKFcyuD6YsYaPXZknWQ4DfCSjNn0wtuhY/+gw/sjyI
 BAajETiGzq8rZnwZDww9xv0FgEYAzHgmY45m+QcMGGKFOVTINdLV0e5w0I/j9HJgujJw
 dMPwO20QNMOVO4wHhk2j5h8LZo1rREtu+9fCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701639080; x=1702243880;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SjtTwZojIov/0UGGEIbJlkCSAS11Hn3uIpQ0Fxuz6xM=;
 b=tiXiMn1XetMq0A4Kgiid0c3BY6xn2T3gqctj+ckYr1JkxXIyGk054Rtg5PUB32HsDS
 WYMGoKL//gKvOg14NUYQZcD+/S+hDB5mkvGCASe/vc0eIKTemnqrjfXbSKgh+ISSlVmv
 MmYTAIT5jYeAwVNcpmLl25D+VKrsS5q0uhp6/cbX/brdQVJKvTFT+zb3cwqEvXD7SZBC
 t/Vc8m0WRbzy10NC+BmgZpEHx08OObIi5lNfdfVDaIrO/Pe75c1V8Tmaw1QIw0nL93uO
 fddfS01Kc1409bRFHmOvxaau70UVNcrGZ/VxZZxheKSb+w+NrfAay8qGuznWp/PvRAy4
 LKEw==
X-Gm-Message-State: AOJu0YwbhgGW6kdQ+1UXbLalfw67fwv32zVzE1nhnpbcGCf9ntpmlBl4
 w+C4++ZJpOVeJ6lBqlDqWK2X0g==
X-Google-Smtp-Source: AGHT+IG4sDjnUmx3sPdK9GyH6jJX6N9k4MgrRDKOf/b6ufKca72q/ZU9qBC8wqstTfT6RsjAgg1hKA==
X-Received: by 2002:a81:914d:0:b0:5d7:5267:6ae with SMTP id
 i74-20020a81914d000000b005d7526706aemr1576200ywg.11.1701639080273; 
 Sun, 03 Dec 2023 13:31:20 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-d911-24f0-9d18-22cd.res6.spectrum.com.
 [2603:6081:7b00:6400:d911:24f0:9d18:22cd])
 by smtp.gmail.com with ESMTPSA id
 q8-20020a815c08000000b005d0494763c1sm2805066ywb.140.2023.12.03.13.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 13:31:19 -0800 (PST)
Date: Sun, 3 Dec 2023 16:31:18 -0500
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PULL] u-boot-sh/master-rpc-off
Message-ID: <20231203213118.GV2513409@bill-the-cat>
References: <20231202190907.62645-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fRICIp957zRhthpY"
Content-Disposition: inline
In-Reply-To: <20231202190907.62645-1-marek.vasut+renesas@mailbox.org>
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


--fRICIp957zRhthpY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 02, 2023 at 08:08:40PM +0100, Marek Vasut wrote:

> The following changes since commit 43f2873fa98b1da6eb56d756315c7bd7db63db=
27:
>=20
>   MAINTAINERS: Step up as co-maintainer of Tegra SOC platform (2023-11-28=
 11:23:02 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master-rpc-off
>=20
> for you to fetch changes up to 13bdb6a269108d3f9b953bf4b73079d66ecc37af:
>=20
>   ARM: dts: renesas: Disable RPC driver on R8A779G0 V4H White Hawk board =
(2023-12-02 17:16:01 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--fRICIp957zRhthpY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVs86YACgkQFHw5/5Y0
tyy+QQv9Gtvv5XjDLtiWjzdq874cRaXNGl7F+kz3XXMZzJIsMyWbbdq7ytTl6GhR
J5zlWelKmM2UaCzEuYnhMF//x3oZBTyCow8FIgSRNwUgo3B3XtEAqMmkoCjBLW2h
SddN4plx2ifaM5T1rGWh1UKkcFeln3iMQUJov8y8uK/1VBD603i1orAGvkWFnWMP
E9FohX4/lvCLmGm2NLGcJIzKhZTxwX1VFoVQp29X8rnvXoY3JcZuVYejyZObhJ17
F+ADSZA03tU8mXtS+o/+wg76kObaWnUToI5zYrKtmUdCITR3KSnfQ6yTA97foFcS
fZ5KnvCP3k6Q6kSrUJuJCiAJgvSzMgR2EuZLVfSCJ6OOj3WpZp4AZqK9mlz3iru5
rIeFdctqhVb5h7+4zNfxTrbermsTJ93iXQOEoW2IVO2lvDSWz8ZLXusw0ibSFI6x
Gprd4ObAYJEsFaBrd6VKqxE1566E1tQC/hmwzAMXrJpMSHTIn3GFAN+gPZMi+HZi
fJhxx/0n
=tmFq
-----END PGP SIGNATURE-----

--fRICIp957zRhthpY--
