Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15105C27C77
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 14:56:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5FDE88A43;
	Fri, 14 Jun 2024 16:55:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YFk1UEiG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B829788A05; Fri, 14 Jun 2024 16:55:14 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E14688A39
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 16:55:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3d1b33e9ac6so1523671b6e.1
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 07:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718376911; x=1718981711; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tf6UaS932XQ1MOgVfV8HWQdsiIxQAW/eD8RiGAeEOGk=;
 b=YFk1UEiGsuKLbz6f35Bm+pt8RuK71X9oSNvGDdtcANr2wffJGcNo2Pj2OzzgL+CYD/
 bSiOfB8RMxxd5/YuJbnLmhSnnEoxnW884gq3wThGjHxtxGubVXLFX4EGEj9Z2nlvUSG/
 rGryhAKT5MZOCXTP/PC+gyttiwNtj0TKPUwyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718376911; x=1718981711;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tf6UaS932XQ1MOgVfV8HWQdsiIxQAW/eD8RiGAeEOGk=;
 b=M6E4MuwzLsasoOd23xIH/WcYLe1fdbvZcSEhHCE82vNAXZ2mSbZZfb0xOEIxiga5eP
 STyHKB8Bi84dubD22/OscKs3w9jSLaMbBcI/e78e1Ju3VaNDO2Qoho2JhidTAd0QU7uk
 0Fa3LT17IxXhPmToGd2azHDqrLx96tpEmJK/cfXs5xY+06yn0uEfv2k3r98zny/BnB4k
 rn6Pajn5fsXjiT3hm4ZLS2hU9o1HVOS319V+BaXCHi/gdJpyfiPwW/mBiZK5v48hlm10
 eY22mYAvNmCrV8avBOOXjs3JoV+0h/0beYO4QG/IgYYVSXNM6EwmlWoWZjihA49w6XnT
 tmkA==
X-Gm-Message-State: AOJu0YzYxhcLJ4fk6cFkBoni5xvoKRJsp8Tz/IytK6RiHCK8FFEHsP80
 WaneaxdorYVG7NJpAv3ncqRFLzfatykI+wB+TlKyVMyR5rN0BeGvWVRloanaV+8=
X-Google-Smtp-Source: AGHT+IGJ+4a0XpzAJsqgSDj3Ep0r1ZP4Fr9CotUzPGvKkcS2GWsFt+WPi2JdvGqQfldxVx0hkYh2GQ==
X-Received: by 2002:a05:6808:3096:b0:3d2:2995:f92b with SMTP id
 5614622812f47-3d244ec0641mr2838911b6e.23.1718376910997; 
 Fri, 14 Jun 2024 07:55:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d2476e2fa4sm549413b6e.52.2024.06.14.07.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jun 2024 07:55:10 -0700 (PDT)
Date: Fri, 14 Jun 2024 08:55:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Marek Vasut <marex@denx.de>
Subject: Re: [PULL] Pull request for u-boot master / v2024.07 =
 u-boot-stm32-20240614
Message-ID: <20240614145508.GR68077@bill-the-cat>
References: <dcc64193-dc12-4deb-9224-48e60cee887c@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OowPoBMyDdVlg0rU"
Content-Disposition: inline
In-Reply-To: <dcc64193-dc12-4deb-9224-48e60cee887c@foss.st.com>
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


--OowPoBMyDdVlg0rU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 02:55:50PM +0200, Patrice CHOTARD wrote:

> Hi Tom
>=20
> Please pull the STM32 related fixes for u-boot/master, v2024.07: u-boot-s=
tm32-20240614
>=20
> CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipeline=
s/21116
>=20
> The following changes since commit ca6a992e09441d6cca73439c63c3735f86b36e=
a4:
>=20
>   cmd: sound: fix help text (2024-06-13 09:31:56 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm=
32-20240614
>=20
> for you to fetch changes up to 55df13d930f4f191f458a6454f4b8e614e19c215:
>=20
>   ARM: stm32: Fix livetree conversion on STM32MP15xx DHSOM (2024-06-14 13=
:25:06 +0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--OowPoBMyDdVlg0rU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZsWcwACgkQFHw5/5Y0
tyzxHQv/Xsth+1k9MzvklZldFDWe9uZx7FksCNuaAmBlfmOSmS0suvw41xvzcw5I
/qLzE4yar66w7Ec+4X/yttdnlIH7O0VmUo4cltotBFY5scJ73hDwnxFNaDb02125
CdbeZMjDehSIuKxSAZOGrTXYKZXBGmH/EgJbtUPPwz3863/NRE8IkrpRnMwTJcEH
LFniTKfdSaUsdaVQSNRC5DRptMAwOCFbLqwFXLYoXseKl+SK2ikRA9uzfPres9RL
3qRjcSCG9YV37Jaw7ABbUephfCNbBWjspRRUpk2zkDsFarL4KPDGMVkRApaFDsPj
GT+IhrO3bR8dd1fXWFC4vtPz3vea1BVJxKiDKhdAxpegYi4GM/PsSdgnWj3qrgWM
FY4qa+/0sPLGFiX779xmp+c6NsWRLtLxjlwr9rNRU0wFWfarqCKZe+myTszuqDjv
21A9cRHlMDez8ePTPvia/XTygBASH5g3ASmpanJUgJ5KpuJdCROwGj+uUdgIigWE
DwGsRP3w
=tbf6
-----END PGP SIGNATURE-----

--OowPoBMyDdVlg0rU--
