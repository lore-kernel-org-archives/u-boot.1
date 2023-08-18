Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4504EE498B
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 17:50:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6501A86F70;
	Fri, 18 Aug 2023 19:50:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dCBeifTl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF2A986F70; Fri, 18 Aug 2023 19:50:07 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFD8686F75
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 19:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-58df8cab1f2so11797437b3.3
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 10:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692381003; x=1692985803;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qibZG2Z+42e7jPIdu2VYLiHynb1FksWXwb0ZtdVZi8Q=;
 b=dCBeifTlCMUWJGAr/HTNVaLyrQbAUhmMjc5mda52M+YYYEoQfyyvYvAyYCQpoKuV/7
 G7fUDtVu/ZvqPkveErM5Cw5BN9PuDSLwur3G02vOwmyUuilNroUluBNX7iTxJn0ZoTIE
 8mNf4FyEXpnQlxAi7wXmQbX7d15GFhGiCvfPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692381003; x=1692985803;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qibZG2Z+42e7jPIdu2VYLiHynb1FksWXwb0ZtdVZi8Q=;
 b=JKn27X24xYuzBPiZqrUsfYZfErtcUI/ESIGv1AHnB26O2ezPwHQzpbOggYeA7sQQVC
 ayj/HHJlT14RayGsxDlu+HY/kFjyppDKq1hmrw1Ez5iuH9sUEzECsxWODzClldSE9W2T
 lE6KzUxD5MuREaR7n5s9IinmtPlpoliHmHattqkWyNmCKXDTkMf8zmCtnEf+k/jUlKOH
 TarNak7M7fHEA19k9cFEgNz/z/xM6DjMG0SBSJVUicK3DMxQoZougXDOJhSgPbnmPpi/
 7ykb5/HJOc3sCqv3iHBqWZzfO17du/n7d+jJWX7GxJYmd+4lnscYV+RSE1KkrY/5IpTm
 O3yg==
X-Gm-Message-State: AOJu0Yyi+7W/S/8YdHDOVozpD+ttEwNf4+9cOoaC4nXHo9PK7A/MKGDw
 e9VrENzMRQYZWjIDsw43rzT5miJhp4uJZ/ohnnNCxA==
X-Google-Smtp-Source: AGHT+IHd3mCOd3zd2xFqmgKSohyMXxBF6MBDg5TLVSLQHFK3fBT0iZ9mai2V+Iliu2Gz3cDqpd3bGw==
X-Received: by 2002:a81:a046:0:b0:581:2887:22be with SMTP id
 x67-20020a81a046000000b00581288722bemr3746187ywg.37.1692381003489; 
 Fri, 18 Aug 2023 10:50:03 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-38f7-b1b8-9b5e-5709.res6.spectrum.com.
 [2603:6081:7b00:6400:38f7:b1b8:9b5e:5709])
 by smtp.gmail.com with ESMTPSA id
 s3-20020a0de903000000b00589c103d00asm629052ywe.79.2023.08.18.10.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:50:03 -0700 (PDT)
Date: Fri, 18 Aug 2023 13:50:01 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] gpio: pca953x: Add TI TCA9554 support
Message-ID: <20230818175001.GJ1515023@bill-the-cat>
References: <20230806233605.88116-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pN7fJeizpxZj8g5U"
Content-Disposition: inline
In-Reply-To: <20230806233605.88116-1-marek.vasut+renesas@mailbox.org>
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


--pN7fJeizpxZj8g5U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2023 at 01:36:05AM +0200, Marek Vasut wrote:

> Add support for TI TCA9554, which is compatible with PCA9554 .
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Applied to u-boot/next, thanks!

--=20
Tom

--pN7fJeizpxZj8g5U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTfr0kACgkQFHw5/5Y0
tyw4RAv/bsgE6gRmDUuDaL0Si4n/RJM9g1t8A7fOzrSFrY00zUd88762cvMV5WO4
55AE0+rEwX4ug6DpPMGvn/+VaN4El2LivoAyCbDfcAs6MCJn8+BsqZP01+k6cu7T
V5zKI/vtsRcvlF9pWYfiMG/QuW0P4sFtNcWLF0DgOcwXhf6ZhH+KR8Lol7m07dWq
XnP/CtRuXCGzJugPethAkZ2sR+WsZLlVWN9DMWYaelHjyQPZYpI67bC/TAIPG8Do
wJeDrUQWRMv7CBz9RnXLRAkLknLbomlUngXfw0qIDOcjYakGHRW9wvb97cb6eOzr
+yz/cuWPl0sKt91G5n5Apl61vDbqzU4dtf4WkWcIzFzEYr01midvww0BxJjFAv0E
zUSnAjgpPMbxdHMrFasF1lY5oqLwpHlMVNqDCFQHfk410X7WtMfRKgTKyt5Qw+dA
hkfSFrIDNmH/Hoq3H+L9tNHXSY3QDH64cCIcHud+fgEMW/DfvHUuqFKXASopCeDq
d74EgvJU
=cNxa
-----END PGP SIGNATURE-----

--pN7fJeizpxZj8g5U--
