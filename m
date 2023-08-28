Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09ABC83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 16:11:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED9F4864B3;
	Mon, 28 Aug 2023 18:11:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P97fI31P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79ADA8649F; Mon, 28 Aug 2023 18:11:33 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5AD286423
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 18:11:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-58fb8963617so40052087b3.3
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 09:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693239089; x=1693843889;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AMPX0qcN5vJl12avfs6/f748ejQ5GApMkOBOi7MnsBg=;
 b=P97fI31PGVzikUvllzdVLUl35axf0/f1ARAe6V1j/5jhgd8P0V+ZaZJikBjoT8oFC9
 mDW/V0sJlJVXE1Q1P8My0IsCk4H+A8mH4yd5eIL8jsmZ1nrBexRCVUWoZmnzRmPiwfPp
 /AU3mVdPHAUmkCQ+IznOc/wFk1uZPBkpkSOGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693239089; x=1693843889;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AMPX0qcN5vJl12avfs6/f748ejQ5GApMkOBOi7MnsBg=;
 b=Dj9RyhM8Gu+E3fu2DvD0qQi10DdQb/M5mKPbpr8PO6rrQf3+IlhP0YGbnfxtXEvQUl
 9DGJ/WhrCs7wQMta8QjZXECZXp7o/1pCxfnHy504a0XyLFoTBkQOf2d6SiNX0HwToLQj
 l9agKOa/TylJh/lg6+Bar5ogVD4bC0Fs9oFpCs9ZFo5tZ7dVBsaSmo6Pf9pAyrTaSgu9
 5Z9MHJkwMDU8nt2SKfx5BFX73Vw2GEtTBA1Z9mF77YR/ZfRjnRjyqXj3dZuijd7jZV0n
 C7RoMJTew/Z6pIJZhZlVVng016eIe938Nm/MhRo8j+Xeg36h7dXRosQUdG6zzrBE3oOv
 LAag==
X-Gm-Message-State: AOJu0YxnZliU33TwEG9hQfsfU6jYRP+j1tOuiV1X3i5VAGBcM37/6zFN
 YiIUktTSh7rfAmB9h1a0b9bdBQ==
X-Google-Smtp-Source: AGHT+IFX0rLGr7BYylPkNdMgfM72waV0jHyxR1vvycOOv7dcHl9V7soMFZ3+sUtZ+UBgQrjO1ypCgg==
X-Received: by 2002:a0d:c246:0:b0:56c:f68f:d824 with SMTP id
 e67-20020a0dc246000000b0056cf68fd824mr29087396ywd.45.1693239089368; 
 Mon, 28 Aug 2023 09:11:29 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-c01a-9a8d-1e42-2ea4.res6.spectrum.com.
 [2603:6081:7b00:6400:c01a:9a8d:1e42:2ea4])
 by smtp.gmail.com with ESMTPSA id
 m10-20020a81710a000000b0058bcea54fc2sm2209895ywc.57.2023.08.28.09.11.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 09:11:28 -0700 (PDT)
Date: Mon, 28 Aug 2023 12:11:27 -0400
From: Tom Rini <trini@konsulko.com>
To: Alvaro Fernando =?iso-8859-1?Q?Garc=EDa?= <alvarofernandogarcia@gmail.com>
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, nd@arm.com
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
Message-ID: <20230828161127.GH3953269@bill-the-cat>
References: <20230821210927.GL3953269@bill-the-cat>
 <20230824092731.GA56529@e130802.arm.com>
 <CAJei4s+35_NVRHrVFq2y3vPXmPucaTpiwqAJzzkKAHiC=6P0qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aun24lecRX96jR8h"
Content-Disposition: inline
In-Reply-To: <CAJei4s+35_NVRHrVFq2y3vPXmPucaTpiwqAJzzkKAHiC=6P0qw@mail.gmail.com>
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


--aun24lecRX96jR8h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2023 at 01:09:17PM -0300, Alvaro Fernando Garc=C3=ADa wrote:
> Hello,
>=20
> El jue, 24 ago. 2023 06:27, Abdellatif El Khlifi <
> abdellatif.elkhlifi@arm.com> escribi=C3=B3:
>=20
> > Hi Tom,
> >
> > > Here's the latest report
> > >
> > > ---------- Forwarded message ---------
> > > From: <scan-admin@coverity.com>
> > > Date: Mon, Aug 21, 2023 at 4:30=E2=80=AFPM
> > > Subject: New Defects reported by Coverity Scan for Das U-Boot
> > > To: <tom.rini@gmail.com>
> > >
> > >
> > > Hi,
> > >
> > > Please find the latest report on new defect(s) introduced to Das
> > > U-Boot found with Coverity Scan.
> > >
> > > 4 new defect(s) introduced to Das U-Boot found with Coverity Scan.
> > >
> > >
> > > New defect(s) Reported-by: Coverity Scan
> > > Showing 4 of 4 defect(s)
> > >
> > >
> > > ** CID 464361:  Control flow issues  (DEADCODE)
> > > /drivers/firmware/arm-ffa/arm-ffa-uclass.c: 148 in ffa_print_error_lo=
g()
> >
> > Well received, I started working on that.
> > I'll provide a fix  after coming back fom holidays (mid September)
> >
> > Cheers,
> > Abdellatif
> >
>=20
> Is there something I could do to help with this?

Everyone is free to work on these issues, yes.

--=20
Tom

--aun24lecRX96jR8h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTsxygACgkQFHw5/5Y0
tyyuAQv+P63iMF/FiCjczzbB3jGD0B8NnnyhuwIN5ZryfG997fbOPavR4EjtCFMl
n1kF8rm6RTXSsDf7cRG6bO8e5NVBee9ig/ruEsro8s6FDuI5QYnL6ZUGNCoVRTaR
016PPe0yY0A1ZsxZpdJqoBSZIBzsz+ZpM+FlBiFO4F4T6UapSpjbDc0V+3aY11Hr
eCNwMG74Q+v6+uqF5gAQudEKMVkmjVgqsvx9e32Fgro0CFuT1TaHDxgKW4s+PB0Q
O1CznE+9RVg2d3sv0NdzlwQC8/AxLkW/jL2i4KjQX8ujVFSGG5jKtA00QKWfPjcf
nuMeH/qxkgzyM//tHLCFyaVgB67nwCRv3Z+JQe8ec58imvTbaBatC2Mu6auKJQ8o
br8oDVS9eN9zWVfAlLOiTAYStwqNGLfgXPlbjLB8AcXff4Xcw8IL5xoORC9/rbOB
MXlZ4Z7/a/MyRHTLCO6JEjSMqmVISiqtLCXBIwrk6YwFy7nH6mR8poBkxssEn/Jg
90UXwIhQ
=90FY
-----END PGP SIGNATURE-----

--aun24lecRX96jR8h--
