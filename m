Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1646CCFA02
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 19:30:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 585A3838CE;
	Sun,  2 Nov 2025 20:30:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WPa/X/Yf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 351E2830A0; Sun,  2 Nov 2025 20:30:32 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89E85830A0
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 20:30:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-30cce892b7dso1988077fac.1
 for <u-boot@lists.denx.de>; Sun, 02 Nov 2025 11:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762111828; x=1762716628; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GuEGvjvSbAMRykaa7oTABvC5g2I1jS+g7JDtKH9gxnk=;
 b=WPa/X/YfqPDdVwgCpu4EY7zFKojW+4RISJB0n+jQeZWP06xuXtJKXgs4NkCsNZ+Dok
 6AfnTT4c9syWjXuNapmEalTTvMhoF/XbS/434s2P9ZeIMxGXj9UQoSGDHXkANQoc8vA/
 qiEPnf2zgNGVOnj9M8EMFD0XafENqmUIbdVOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762111828; x=1762716628;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GuEGvjvSbAMRykaa7oTABvC5g2I1jS+g7JDtKH9gxnk=;
 b=qaAOadszuN22eDoOI2BliwoTHfZajtZgtFoOKQ6ziwAeOpTZiZkBj37UXOaYTmchJL
 TIiDM2H0xTg5onFPdzRJ8Ufi0ONs8ikKft+/X2vwBRyaghlxyumfot57ur64HbC60hs0
 NL2rLfGcxWT4PwjLkTzIJl6NL92oVEG3LBwDwwGZFc/0H/iUj8M0yGd8EfTgfIhJGGTu
 rvF+/wddSBEnt7W3oRxYllbeHuUiBIs8vb5zryPYiGRrQAEmzNF7W6LlPscm/7DKHoeW
 RbsHuEexgHAGF4vx/OdKLVzUg2mGtoXUmSeovrRop6xCmr0c6s8JDORceQP7n1UILEYa
 Nifw==
X-Gm-Message-State: AOJu0Yx1BQWUvnIHfQB+KHzIl0AavdYHveqLf30CYbZuCDKDlF49LjM7
 NMsDGwfgA1P7icFNDW3Kxt8bJoIa4q/aB/ySBoxYxB/nvZenmNki2IcmXWg87bZacy8Gl7eFG1H
 xajTSe22rCQ==
X-Gm-Gg: ASbGncujMw/Gy4CI+qzlnOkmyn1QvyLnwbj1yQAmn/9nAj+rQWWPiCLoAZ1W0yEkdjd
 8CHu8aevtJLCLUgCqNTcC6PHmPFxhe3D43L6h00gPNHBVZEeVFyWfy86+rvzN/Jb5xsliuC4MCg
 Ga8fIfqEDJheTcHWi+YBtZIIGzXDbHSYOMvtUcg4dsQ9AuDwAPgTAn0QkFAUxDkk7NMX2tRnyEr
 FJTtwbNOlB6uPzWFCrsgkojzPMUHNv7fNyNNYQwKIe6HXQaeQ+IOSqKgOYcNuYaKzmvvNIKA/TL
 SE8R0Oi7fnYDw46dlR2qBI+b4/8CuEeTMgZP6WOF75zRdSHh15wcMbpYJLzSe/yg2l3M4rdLrNN
 Gtd8qve5uDp+r0Bv35v/CPzgRqVAmZ8bjUaegHF1D6jESrD1xZlR8HC1cnbF7lhdsP2x6WPn/ME
 VDBWZbCXMI/6tdW/cEV2rPECn1Of50EfBz200HURC0/fqCIMsGcA==
X-Google-Smtp-Source: AGHT+IFP11iBGRlc0uDQZegWu+kPPnBRfx8pEEYN1RAjSbIWHNSK1ZGZwuXNw95W7Cn9r4Ki/fxljQ==
X-Received: by 2002:a05:6808:1798:b0:43f:5d93:3e3d with SMTP id
 5614622812f47-44f95f7ce7bmr5350333b6e.35.1762111828262; 
 Sun, 02 Nov 2025 11:30:28 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65695977b14sm1543467eaf.5.2025.11.02.11.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Nov 2025 11:30:27 -0800 (PST)
Date: Sun, 2 Nov 2025 13:30:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20251030
Message-ID: <20251102193025.GI6688@bill-the-cat>
References: <20251031014742.516268-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="k0RHRA2Phrr2J1Fc"
Content-Disposition: inline
In-Reply-To: <20251031014742.516268-1-festevam@gmail.com>
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


--k0RHRA2Phrr2J1Fc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 10:47:42PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/master, thanks.
>=20
> The following changes since commit e34d01d23e45e007368685ffa6dfd674b6dd7b=
17:
>=20
>   Merge tag 'u-boot-ufs-20251029' of https://source.denx.de/u-boot/custod=
ians/u-boot-ufs (2025-10-29 07:41:43 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20251030
>=20
> for you to fetch changes up to 087277fc76baa0bdd6275ab365891d9058612e1e:
>=20
>   imx8mp_evk: Fix typo on maintainer's name (2025-10-30 12:40:47 -0300)
>=20
> u-boot-imx-master-20251030

Applied to u-boot/master, thanks!

--=20
Tom

--k0RHRA2Phrr2J1Fc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQexUAAKCRAr4qD1Cr/k
CsKiAQCKXtCa0nVrjVzn6OkC49cr3Puo9mNEqIC6ZtPl4wg6FAD/f4yuWATr4J/T
4vPKa7at32n0e3CE2odkLw/C+KGMAQw=
=AyHT
-----END PGP SIGNATURE-----

--k0RHRA2Phrr2J1Fc--
