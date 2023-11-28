Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A7EC4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 16:28:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F12E87701;
	Tue, 28 Nov 2023 17:28:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pzHWLgGt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6826687741; Tue, 28 Nov 2023 17:28:55 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E9B0876DE
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 17:28:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5cc589c0b90so57068617b3.2
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 08:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701188932; x=1701793732; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OpUjyHN8SrWp8rAlVl38Cyx1xuOHW5ojwLDlWkyOsRc=;
 b=pzHWLgGt9Va/J+4dcgyqhBi1nnuG4owIrkPv3QXrQKWf9nxY2qkYo+Og8WsFpcnP8q
 SbDL/nyEn5ebaiRiLbUpqOliaLC/rzzfsqKTpPxOt/2EYpX4jdC44ITOcu+8J/KEULFq
 k+6dBO4vg+ELZyzaQKLp/vtVnG0f+32e/rcfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701188932; x=1701793732;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OpUjyHN8SrWp8rAlVl38Cyx1xuOHW5ojwLDlWkyOsRc=;
 b=S255Gczk7ncRkrmXYUqm+0SEvUUNyCCPynM4LzS4kuieNIGxmOuSUbNHFWkUnxIHUb
 J1qsnl/66E7DpYisaZopkqSq0F2HOyVgZPLsfYl3xZ5gQxyqZVcz0QYt5XIdymtskMh8
 3tVTIkgvYZ2JytggRhToceBR2n9EUGvBCy+hK98SGKGdBvmYGr7KD+9CwUbAy1jOZN/Q
 nn7Hq42TwSKWF2rUiP9T4MTG9kGSE2MXTkFEOXsB5Q+QUd3teIiieg6hDZd2qKy+e32P
 vdbccfOAzsmxnGOk/aPqtnBRHTJk0B6pO2iAa1EIGmJQPhBr7Zq7s2PpObzsAdoekc54
 rJSA==
X-Gm-Message-State: AOJu0YzA0vaOs5KY1Ggivl3SlZEapDM6owYlFhfVCdc8A7s4c+j+F5Ls
 C250q6ZqUF/rC8upi6LqTug1e7B4r5tcv8zOcVdbpA==
X-Google-Smtp-Source: AGHT+IHKPYakt7XDTjCBclIr9KVuwgIasTxlaU0cbFGjJnikNLr78GnzkMh7t+WtOGXT3fngiegiUw==
X-Received: by 2002:a81:62d5:0:b0:5cd:2f3a:a59d with SMTP id
 w204-20020a8162d5000000b005cd2f3aa59dmr11323266ywb.36.1701188931766; 
 Tue, 28 Nov 2023 08:28:51 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4f9d-49d7-ae37-6b11.res6.spectrum.com.
 [2603:6081:7b00:6400:4f9d:49d7:ae37:6b11])
 by smtp.gmail.com with ESMTPSA id
 g16-20020a81ae50000000b005d0d6fe6635sm1052621ywk.99.2023.11.28.08.28.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Nov 2023 08:28:51 -0800 (PST)
Date: Tue, 28 Nov 2023 11:28:49 -0500
From: Tom Rini <trini@konsulko.com>
To: Minkyu Kang <mk7.kang@samsung.com>
Cc: u-boot@lists.denx.de, promsoft@gmail.com
Subject: Re: Please pull u-boot-samsung master
Message-ID: <20231128162849.GZ2513409@bill-the-cat>
References: <CGME20231128031606epcas1p4a03b83245075b91119b523dda9899537@epcas1p4.samsung.com>
 <2c9801da21a9$39c76750$ad5635f0$@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VsdwX7nfpNFHA54b"
Content-Disposition: inline
In-Reply-To: <2c9801da21a9$39c76750$ad5635f0$@samsung.com>
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


--VsdwX7nfpNFHA54b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 12:16:06PM +0900, Minkyu Kang wrote:

> Dear Tom,
>=20
> The following changes since commit 17e9db18f17b6cad278694d4a61df95e96bdf4=
f5:
>=20
>   Merge tag 'doc-2024-01-rc3' of
> https://source.denx.de/u-boot/custodians/u-boot-efi (2023-11-11 09:22:54
> -0500)
>=20
> are available in the git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-samsung.git master
>=20
> for you to fetch changes up to 470682ace1e03a6573d6eef9a00b524d608ddfa7:
>=20
>   configs: Remove unneeded SYS_CONFIG_NAME from a*y17lte defconfigs
> (2023-11-27 18:57:35 +0900)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--VsdwX7nfpNFHA54b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVmFTcACgkQFHw5/5Y0
tyzTegwAsNjFjtL1g7c0F0mgtIou7jjSpGbTGpo/ztMccAdUN/LxdQy1E9axSua5
4H8/O52SLLqBP6WRwv8sHngi7PZK3iREktWAYwS0A864z3PPsNU45DLd6YhwjbAs
C5pYONt/18SWk04Gtk8qUXVIqSEAbB537n5kr2IsSjmAqsukN0RYVCVCqNWyD8rT
mpiQotJDvqMJG5vt1GkxmZ9LcYKEbPTiMMACnKuhg7sdE3VLKs0Tnuc2O9d8+zf9
N4MppMCnmLPtxmM1zAmv5OSOecn6vuu3g+uHkXSAB61YHaaOKxLTjBYmVT4zvjj5
UmFtB4dxPWC2TC1pji/d/GMAyEvOOPSyz507j/5nPBVzyi19GI/PO0mkBdJRg1b1
Cc9FgmxghRwrEGlrrtmWLFeDg/4XlZ4J9LUkbhJEAmgP/qEw2p8LtI2z+UQUXjuq
Lyi0A2aIPyO/PnXMiTBIcwo+AH2esSiVsPlHUtudEZ+NcZx/Uly/oEGtWP7CXcLZ
o815cqEX
=Uk93
-----END PGP SIGNATURE-----

--VsdwX7nfpNFHA54b--
