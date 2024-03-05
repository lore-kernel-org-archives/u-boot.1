Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BA06C54E41
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 13:27:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1FE588059;
	Tue,  5 Mar 2024 14:27:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TPGW5R4A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57A5288059; Tue,  5 Mar 2024 14:27:46 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 410F387FA5
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 14:27:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3c1f5e14bdbso580659b6e.1
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 05:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709645261; x=1710250061; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ezy9AzvHF5+C84tn+m9V5PlWfXsA1VYgsmlzzrvDtps=;
 b=TPGW5R4A4HZkgoFncNFELA1E3GTGFhyc7vqHlORxi87dPpSvRRxqqME2R8V3E2rktX
 acS5ovrN1D7UJXA7qiHd/qLNe8Wfmzfr+WT5oTS/GpbeKiqrY/LnjD5+sAxQL5ImxgeR
 X3HexwB0ld648YT13w8fox0xWT0blc0bHvc0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709645261; x=1710250061;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ezy9AzvHF5+C84tn+m9V5PlWfXsA1VYgsmlzzrvDtps=;
 b=l02Ox+1Ox4OcceiIUvw/1e4VDSzt8dDqZzCPXPNfFwPGj1dYyRzw8h782TKJbDzqK+
 9CcbspXauD3yrke3iPZx4s/lsfSZgbyLsIkM38V9T7bIzd20shqGwHTMd7EPh18OEM6u
 IY/VhBLhms2aaWA8erV9EYLTHDWM+Ghtu2z7XoXwcK5ZnR/aHUazFrQu+HuEPQTl/E/G
 CUULXoj4xTl2D5MLqrGI6zaOnYsg9+INea+BxykQiJjvvaHm4bzXYBH0NVQDDOpL5uUt
 YQhJj07zhGc0Fop/kE3zmDpOITCmEqVoK1AJPst0zoLpC6cCThr8Ck2ynJAyqQbdPYIS
 MENA==
X-Gm-Message-State: AOJu0YwgXtqxpBv+EroF/l0QvDHqn920NvPf3mk9ciNnoXD+NgpHkuY5
 yycp+iZ2BjUlZBEOkrEAKINSm4REHqQIOwJQK9rPV36dHYjTYa9pTCZmt8Mtfh4=
X-Google-Smtp-Source: AGHT+IHEri1aaguEVt+T71g4hwi5Ngt3g/M4GIG6OwKB5J3Dy0eiV/fkcIacVQH0OLEnG0Luvl50Tw==
X-Received: by 2002:a05:6808:7cf:b0:3c1:9ac3:bf2b with SMTP id
 f15-20020a05680807cf00b003c19ac3bf2bmr1819819oij.5.1709645261103; 
 Tue, 05 Mar 2024 05:27:41 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1000.res6.spectrum.com.
 [2603:6081:7b00:7f::1000]) by smtp.gmail.com with ESMTPSA id
 x25-20020ac87319000000b0042f01e612bbsm494559qto.37.2024.03.05.05.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 05:27:40 -0800 (PST)
Date: Tue, 5 Mar 2024 08:27:38 -0500
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Maksim Kiselev <bigunclemax@gmail.com>, Philippe Coval <rzr@users.sf.net>,
 Ludwig Kormann <ludwig.kormann@ict42.de>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>, linux-sunxi@lists.linux.dev
Subject: Re: Pull request: u-boot-sunxi/master for v2024.04
Message-ID: <20240305132738.GA1523872@bill-the-cat>
References: <20240305111541.2369415-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9GJC/8RsugRDi4km"
Content-Disposition: inline
In-Reply-To: <20240305111541.2369415-1-andre.przywara@arm.com>
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


--9GJC/8RsugRDi4km
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 11:15:41AM +0000, Andre Przywara wrote:

> Hi Tom,
>=20
> please pull the sunxi/master branch, containing some fixes and smaller
> changes for 2024.04.
> One fix makes the reboot more robust on some older board, another one
> stabilises the initial clock setup on the A10/A20.
> Two patches make sure our DRAM init does not actually change the content
> of the DRAM array, which allows to use DRAM for Linux' pstore
> functionality.
> We get SPI support for U-Boot proper for one more SoC, that patch was
> lingering around for a while, and should not affect other SoCs, so I am
> merging this now.
> As an added bonus, we get the defconfig file for a new board, the DT was
> already synced from the kernel tree.
>=20
> The CI looked happy with changes, and I tested them on five different
> boards with different SoCs.
>=20
> Please pull!
>=20
> Cheers,
> Andre
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The following changes since commit eac52e4be4e234d563d6911737ee7ccdc0ada1=
f1:
>=20
>   Merge patch series "ARM: renesas: Rename R-Mobile to Renesas" (2024-03-=
02 14:30:25 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sunxi.git master
>=20
> for you to fetch changes up to f1e6a718ebab0682d80601db404e8d842767becf:
>=20
>   sunxi: restore modified memory (2024-03-05 01:16:56 +0000)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--9GJC/8RsugRDi4km
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXnHccACgkQFHw5/5Y0
tyxiPQv8DcGbBRYVi8GS5swJMrR4QNt/v528coyfijWn5NNLlzkC1Bj9Ls9RA9C6
VDIjuiLZSIJXIouUROlOui63/qe1ZcsvjE0Ucgc3AZnzscJ5Nl7IS8edhK6cnT68
4snPwIrdSVFZ3lL0G3dv94wbqGlQU7PDTZmX21A3XWMWgOwFPp3k5nEslI0H4NHl
DrzpsfuUO7bZW9nFHJv9wlv/A0Yiue9gs7CbNUj3jbc2bDnxZZODin0x5dsqC5JA
0oDYc85l9JpPJj2eAZdzJD2xTBGX2dtdfG7Aeh+lccdohf1no/Sdnsm7alBCE/v0
IBDkumTI0pGTaDvwkoIp9+ACP4MXX+jXoJqKz+EqKZBoCdpSOTmdu7vYOfuAdahU
3eveQ6GD90S+YCu8dwsswtkEu4lpiwd8gK+bf9IcDLu1DSfBnXy2oTiKDo0v744l
noFyxKOwtuwJbzsfbITcXP2i6epJuQzY+CyslQB0fS1D86dyJ+ohwjL+qGc9J9P5
Irp2VEMu
=Pfjw
-----END PGP SIGNATURE-----

--9GJC/8RsugRDi4km--
