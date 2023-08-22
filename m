Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DABEEE49A4
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 13:13:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46874864BB;
	Tue, 22 Aug 2023 15:13:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Nfe4fPKx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4B53864BC; Tue, 22 Aug 2023 15:13:12 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E7118649D
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 15:13:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-d62bdd1a97dso4446572276.3
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 06:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692709988; x=1693314788;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dN7ESNNauQjNbOUxoB5GkBj5JCZNlQoUmjt5BiBvpmw=;
 b=Nfe4fPKxFPArNZVqnAKlb9tLxahDNRZNAk1XmX+X+zZNv5q9HpjeAcoMi3XQuKFvyq
 eEo00z2LBTBTym7gbwliRz5Qgll7ZmY/4InQuAW0OunCs8VX0AdSv2uCGCxWd9GQBxMk
 lMNjWCXAeC6iJsAW6GYJSqWE9wHePCuc3TP90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692709988; x=1693314788;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dN7ESNNauQjNbOUxoB5GkBj5JCZNlQoUmjt5BiBvpmw=;
 b=jZyqSGKn4dhzizrvXt5xprlUSSYPGlltIZQz+oFm1eQC915sqOUTfOqIXhjoH2uShN
 9N/TAT7Edyb1RqnsMVo9FVr9WvKeYvwhPm5A6LE+F2c1Y4Bh4OgDPucV4hHhOkTpOSyA
 UDNUGYQFjAtMCl5vFR05xSLr43xQwj7oADX1oXXT/IXZOgC45u8up6oX4d+dkEITJrFf
 bWRhNTRXBSKvSjEtaEZZMPbMPuDW4mwe3bdyTnGEnOojcLkLVLij47CGikyRSPtABYF6
 abtIXZY/Nx1cPa/1HJSelIMdY7bd17w0DppMGeFGTCktIZRjazyJG/PUF5/PUGj09IcP
 X+hA==
X-Gm-Message-State: AOJu0YwGI1jLheAYQCko64GS69Fbzy3y3AFF/e6/cVSrMTKw0oPd4V14
 Ri9O9UCcrCegM8BziTLoxB8ofg==
X-Google-Smtp-Source: AGHT+IHewAqiJa8SBHfqSXa2aZC5UeND3QaH1a0Wv4rySjl02jGcEXQO4c5xDgjOM/9gnVM8Xg3T2Q==
X-Received: by 2002:a25:c7d0:0:b0:cfe:49a5:5aed with SMTP id
 w199-20020a25c7d0000000b00cfe49a55aedmr9310695ybe.7.1692709988108; 
 Tue, 22 Aug 2023 06:13:08 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1e1c-d9ab-fd6c-7414.res6.spectrum.com.
 [2603:6081:7b00:6400:1e1c:d9ab:fd6c:7414])
 by smtp.gmail.com with ESMTPSA id
 w7-20020a25ac07000000b00d77928cdcf6sm186286ybi.15.2023.08.22.06.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 06:13:07 -0700 (PDT)
Date: Tue, 22 Aug 2023 09:13:05 -0400
From: Tom Rini <trini@konsulko.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, u-boot@lists.denx.de
Subject: Re: [GIT PULL] ARM: tegra: Changes for v2023.10-rc1
Message-ID: <20230822131305.GM3953269@bill-the-cat>
References: <20230818133923.286332-1-thierry.reding@gmail.com>
 <20230818164943.GZ1515023@bill-the-cat>
 <0C415156-B22C-4B86-94C6-1D03ED4287ED@gmail.com>
 <20230818170447.GA1515023@bill-the-cat>
 <5DFCCFFB-D137-4530-8AF9-C72071842A60@gmail.com>
 <ZORmfDblupZkjoh-@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WZWLKPw/jhXvAAk9"
Content-Disposition: inline
In-Reply-To: <ZORmfDblupZkjoh-@orome>
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


--WZWLKPw/jhXvAAk9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 22, 2023 at 09:40:44AM +0200, Thierry Reding wrote:
> On Tue, Aug 22, 2023 at 08:16:29AM +0300, Svyatoslav Ryhel wrote:
> >=20
> >=20
> > 18 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80. 20:04:47 GMT+03:00=
, Tom Rini <trini@konsulko.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(=
-=D0=BB=D0=B0):
> > >On Fri, Aug 18, 2023 at 08:02:30PM +0300, Svyatoslav Ryhel wrote:
> > >>=20
> > >>=20
> > >> 18 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80. 19:49:43 GMT+03=
:00, Tom Rini <trini@konsulko.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=B2(-=D0=BB=D0=B0):
> > >> >On Fri, Aug 18, 2023 at 03:39:22PM +0200, Thierry Reding wrote:
> > >> >
> > >> >> From: Thierry Reding <treding@nvidia.com>
> > >> >>=20
> > >> >> Hi Tom,
> > >> >>=20
> > >> >> The following changes since commit 68c07fc5fdf34f0926cf06fc0c4ebd=
6f2f3afe19:
> > >> >>=20
> > >> >>   Merge https://source.denx.de/u-boot/custodians/u-boot-usb (2023=
-06-21 14:42:50 -0400)
> > >> >>=20
> > >> >> are available in the Git repository at:
> > >> >>=20
> > >> >>   git@source.denx.de:u-boot/custodians/u-boot-tegra.git tags/tegr=
a-for-2023.10-rc1
> > >> >
> > >> >FYI, in your .git/config you can do:
> > >> >	url =3D https://source.denx.de/u-boot/custodians/u-boot-tegra.git
> > >> >	pushurl =3D git@source.denx.de:u-boot/custodians/u-boot-tegra.git
> > >> >
> > >> >And this part looks "nicer".  Not a big deal, just an FYI.
> > >> >
> > >> >> for you to fetch changes up to bdf9dead86f06c7d6980c399a4a6339430=
b531ec:
> > >> >>=20
> > >> >>   board: htc: endeavoru: add One X support (2023-06-30 15:20:37 +=
0200)
> > >> >>=20
> > >> >> This passes CI successfully:
> > >> >>=20
> > >> >>   https://source.denx.de/u-boot/custodians/u-boot-tegra/-/pipelin=
es/17411
> > >> >>=20
> > >> >> Thanks,
> > >> >> Thierry
> > >> >>=20
> > >> >> ----------------------------------------------------------------
> > >> >> ARM: tegra: Changes for v2023.10-rc1
> > >> >>=20
> > >> >> This adds support for various new Tegra30 boards (ASUS, LG and HT=
C) and
> > >> >> has some other minor enhancements, such as enabling the poweroff =
command
> > >> >> on several Tegra210 and Tegra186 boards.
> > >> >>=20
> > >> >> ----------------------------------------------------------------
> > >> >> Jonas Schw=C3=B6bel (1):
> > >> >>       configs: tegra-common-post: make PXE and DHCP boot targets =
optional
> > >> >>=20
> > >> >> Svyatoslav Ryhel (6):
> > >> >>       configs: tegra-common-post: add GPIO keyboard as STDIN devi=
ce
> > >> >>       ARM: tegra: add SoC UID calculation function
> > >> >>       board: asus: transformer: add ASUS Transformer T30 family s=
upport
> > >> >>       board: asus: grouper: add Google Nexus 7 (2012) support
> > >> >>       board: lg: x3: add Optimus 4X HD and Optimus Vu support
> > >> >>       board: htc: endeavoru: add One X support
> > >> >>=20
> > >> >> Thierry Reding (2):
> > >> >>       ARM: tegra: Enable poweroff command on Jetson TX1 and Jetso=
n Nano
> > >> >>       ARM: tegra: Enable poweroff command on Jetson TX2
> > >> >>=20
> > >> >> Tomasz Maciej Nowak (1):
> > >> >>       ARM: dts: trimslice: sync SPI node with Linux dts
> > >> >
> > >> >Since I'm not sure if this is v8 or v9, given when v9 was posted, I=
've
> > >> >applied this PR now, as I had said I wanted this in.  I do have two
> > >> >requests for you Svyatoslav, however.  First, if there's changes th=
at
> > >> >are missing in master, please post those ASAP and we'll get them in=
, for
> > >> >v2023.10.=20
> > >>=20
> > >> Patches Thierry applied are v8, while v9 has significant improvement=
s.
> > >
> > >OK, I've updated patchwork to try and reflect this too.
> > >
> >=20
> > Merged patches are not the most recent I have sent. How to fix this?
>=20
> Usually once something has been merged it's difficult to back it out. So
> unless Tom can (and is willing to) somehow redo the merge with the
> newest patches, you're going to have to rebase what you have and send
> out as follow-up patches.

I would hope that locally, doing a git diff between master with this PR
applied and a branch with v9 on it instead would yield a set of changes
that are easy to turn in to a follow up patch or series of patches. I
really don't want to revert the merge and bring in a new PR instead.

--=20
Tom

--WZWLKPw/jhXvAAk9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTktFkACgkQFHw5/5Y0
tyyeigv/RmZV9g8vTElnQTRlCbq1jLZQW4jxmOOekg+6/HHIXzr0LU9td4eJlv5u
04u1r9TFyk87Tq7uZF+E+ofhvAOUDjETOJtoTplEFUjvVsUznjNZeQbuNAeI3Kvb
jUq7aZclpLD12Cvm65p0iYevfkmutI74AzUn7ImFHxMjPthyWVdTz/Q9Bdc6IYKG
nFRUkxvv1/+91yQD27CTQInG2z7BEQdqIYusvujNHkBoQzjG5lFGpSe4F0bC1+NR
EfyEr4aHCmvYO0bxQKT+nMqWENUuJanNl83QiyXSyLl9Ff2qdVQ22AZXdfGY2TjJ
8w3BB5Ass2Z3zjRf01Cjh13L04IN+PcWEinduWWa3CuYhN+qzStMNrrEMhqcks0W
7uhSTidfe2lnTV74PNalBc8afuDsCySE8PGU/yFAhdk3FEKO0waLG0fiGC3l/7ve
xasomCF/bBVG/QEV0Nels+VIBZ2ExGjV8sCNQEUqy4kN5E555Twem+Ajon97fwPh
06LI+lCF
=YEIQ
-----END PGP SIGNATURE-----

--WZWLKPw/jhXvAAk9--
