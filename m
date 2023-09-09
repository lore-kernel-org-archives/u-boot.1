Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB7AEE57CD
	for <u-boot@archiver.kernel.org>; Sat,  9 Sep 2023 23:20:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E949D86ADC;
	Sun, 10 Sep 2023 01:20:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fmc3ZrTi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 797A486AE2; Sun, 10 Sep 2023 01:20:24 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6474386AD9
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 01:20:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-58fc4d319d2so31986417b3.1
 for <u-boot@lists.denx.de>; Sat, 09 Sep 2023 16:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694301620; x=1694906420; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QW8PDV9vs//Ncov6gDIsxIRsQ1AOhmnJ6hpnwtb+Qbc=;
 b=fmc3ZrTiC36MWVOinZrKbENQSY4AO7dhwiL8gjC7QRlA9utKV9/EjFFz1TcpvgfG+C
 URvMu0yTeIDKX/qwaw5WmwGDBDhaL3CC638BwVjg5BuBbBTV4NL3WpLJJXBlIoX6vy9G
 TfeyaxYL9FW/FMWyjlYsoKHBm3EQ61/ZiV4lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694301620; x=1694906420;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QW8PDV9vs//Ncov6gDIsxIRsQ1AOhmnJ6hpnwtb+Qbc=;
 b=L6Z++YUzU2bQJ/i7SgVrtkKA4nyEIN6ncC/FrSGmbWbPk2ezZ818JYuVOKUzKMWPO3
 pCzGrrm6N3PMc4DbLn0yJ8b49vgujfm4/reVoPMlBtvcLYtIGQXNYPR3JVqcVC8lHa4d
 eNQr+baf+LKbf5OGokwomKvxl7FlKvssJH25KDl2F3bM8nUcwWUegHvIWOOjsI3Ka2GA
 Veawg6loHGXzBg8fDyfRoC8B9SFGHB2gRCM774vq38gc0duqoQQk2RXbdasP4s+JP8jC
 Xztugr/tLoCZQtOGSOAgGb4AHKK8tS1NVdZxt0aFdcfbyoWnMnLJkM7x6j/f6DDTpDAu
 RWEg==
X-Gm-Message-State: AOJu0Yx2mylkXxxM2/tCwOX2DstoK/Rt/MGVsKPnj+gIOQXytwHN+tyR
 WoV7EQlTW8oYg2k5M8IiaNo7oDrLWyts/mMsdgd1pw==
X-Google-Smtp-Source: AGHT+IGFhYAuyi/n5hfMY42NWe3vojmDygy/MPEm1bzDT1gQvT9i5ycOShke/EvySGShr8Xaecslkg==
X-Received: by 2002:a0d:d80d:0:b0:586:9d8e:8322 with SMTP id
 a13-20020a0dd80d000000b005869d8e8322mr5916567ywe.2.1694301620022; 
 Sat, 09 Sep 2023 16:20:20 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1687-83fa-3eda-ba26.res6.spectrum.com.
 [2603:6081:7b00:6400:1687:83fa:3eda:ba26])
 by smtp.gmail.com with ESMTPSA id
 j189-20020a0df9c6000000b0054f50f71834sm1145407ywf.124.2023.09.09.16.20.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 16:20:19 -0700 (PDT)
Date: Sat, 9 Sep 2023 19:20:17 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PULL] u-boot-sh/next_ufs
Message-ID: <20230909232017.GT305624@bill-the-cat>
References: <20230909121459.5143-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kRIE74FniFce8Iz3"
Content-Disposition: inline
In-Reply-To: <20230909121459.5143-1-marek.vasut+renesas@mailbox.org>
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


--kRIE74FniFce8Iz3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 09, 2023 at 02:14:59PM +0200, Marek Vasut wrote:

> The following changes since commit 515e0af77b25fba24ef6a3c72afee6ae3c7398=
25:
>=20
>   Merge branch '2023-09-06-assorted-CI-updates' into next (2023-09-06 18:=
47:18 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git next_ufs
>=20
> for you to fetch changes up to fad9d9b70113bda05b5339d0193adc4edd3ca0e9:
>=20
>   ufs: ufs-renesas: Drop include common.h (2023-09-09 04:56:50 +0200)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--kRIE74FniFce8Iz3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT8/bEACgkQFHw5/5Y0
tyy6XQv9EEhcpD6BwrCZYhiJBokui/xtLj9vmobH4HrI9nOiI4GVBuS9qmLoYnPc
ishds719E3QZz0fXEs7lFTA8dtbnFZ4Xf2Fz4MjwayyLZle4WaB29fntUZykJeky
46arxIAmgTL0vEUfa8uCJBUThAB7BWZsvCFnojx3Y4EUpU+xSs8vf9dPQJvvgA+3
U26GucQ+bHM0tR25vfkMzUTtADMM8RMORAPvEB4SlN2bx5ZKA5z3XsxRdj9l/u7V
bJTYzcssN00GpcCuVvtMxRR5I+U7Jon39WRXOWYebdE2Q3vuhU+Rx2SrROzHHaUn
y4BNR1pkb0y+U7M1avDRVDn8AMMFqTtAXna07i5qthIhryC96d1ZTceOjWB4GlAO
DEhVBWfBkcyQtnuydOmSSa+6ON64u1ZD2l/JxpkPX0Y56NqEPENofH2+Wq5Ibn5b
TggJJbw/oJ6YnqJr8al7NHxYoGJ6wol/uFJ8S/+oRdn7JTKqbtFXAj1dscyKaRrb
GrFdwScM
=fIkf
-----END PGP SIGNATURE-----

--kRIE74FniFce8Iz3--
