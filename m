Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 475DFC52D7C
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 22:03:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D510288C55;
	Sat, 10 Aug 2024 00:03:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NEccqvOZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 996DB8641A; Sat, 10 Aug 2024 00:03:01 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7075D88C3D
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 00:02:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5d5d4d07babso1512013eaf.3
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 15:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723240978; x=1723845778; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CMHfVfSMeZwBFudjMxBbX+qrCe+KQOBHsHXF/dE7Yvo=;
 b=NEccqvOZxzXec1vez9ZeKVo2t6VgXO4TuJ6PMCV7kYSpn9s/mP8F17pSMD/MI63j9p
 HKi886yufox5JEFvDzP5cm8xakx+C0Q7YUUAW1yoDQXJoZ3b6UvFEivAcgeJTZSMx39K
 oEtWHw/k2rzTb506TntqskA5WifsamuVwF/Vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723240978; x=1723845778;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CMHfVfSMeZwBFudjMxBbX+qrCe+KQOBHsHXF/dE7Yvo=;
 b=Cli+3GAVcDCo5BFb/f1WUTJx5aiDuCJHI1c7/U29GAMd1wPMC2RXoaU5pJMdzYiqtr
 raWhFSZNwsVtzGIz1f60efgnim+wgDIbEbsIBsBDZ872i+4z53aU4mWuoNcBP2o+iC6Z
 X4GQt2xSqJUSlW5j4aaBpa46OuMWhTEZWgnTP+mRsQ1s9PKVn4VX9JY5CxTLhi7OFwY1
 fmvw73WJHROTGrM8N+od0TYTIOKrf7EQI8ea2Vt3fOboiY71H/6qQTPqm8E4os+wSFZM
 xfSxmZ+PZa0GKKwoNV+2DjirBIBEfOMslmjDYtS+2Nb6m74m7FVNfbXCmE/8hVKhnZg8
 Tgdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmRvAZtj5nWA9ojxh+9m4D1qStHygwZIoX+K78jJOhEFIFqYJWH9butGPjeXiPierNzcby43A=@lists.denx.de
X-Gm-Message-State: AOJu0YwA3nXnNajNbmUKsLXDDmA2xBrLdW7DEUXo267oQxLUmkOMJAcv
 y8SqUYj4O3r2tejjlDbElFrxR42lzawHnXtryvaRqO0r/VQZUnkJpX0g+/FgC7E=
X-Google-Smtp-Source: AGHT+IHiX7+No7DZJsuQ2LXLymw/n5Sq/xWDCyjxhy8hdLvIdnZRHbndLdZWtXTCeiLlKPDpNsgnuQ==
X-Received: by 2002:a05:6820:820:b0:5d5:a28b:f4a3 with SMTP id
 006d021491bc7-5d87d67c93fmr3417101eaf.7.1723240978206; 
 Fri, 09 Aug 2024 15:02:58 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-236.totalplay.net.
 [187.191.8.236]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5da3e71866dsm113252eaf.38.2024.08.09.15.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Aug 2024 15:02:57 -0700 (PDT)
Date: Fri, 9 Aug 2024 16:02:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH] cmd: add a fetch utility
Message-ID: <20240809220255.GC1626301@bill-the-cat>
References: <20240808163153.2069650-1-caleb.connolly@linaro.org>
 <0194AFA0-5D56-46F8-A385-D23AF7CDDD43@gmx.de>
 <c25c559d-97ab-4abf-bee3-77dc38802e71@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lTRhmW2WSliX30AV"
Content-Disposition: inline
In-Reply-To: <c25c559d-97ab-4abf-bee3-77dc38802e71@linaro.org>
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


--lTRhmW2WSliX30AV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 09, 2024 at 07:23:42PM +0200, Caleb Connolly wrote:
>=20
>=20
> On 09/08/2024 08:18, Heinrich Schuchardt wrote:
> >=20
> >=20
> > Am 8. August 2024 18:24:24 MESZ schrieb Caleb Connolly <caleb.connolly@=
linaro.org>:
> > > While U-Boot does a pretty good job at printing information at startup
> > > about what hardware it's running on, it can be hard to take pretty
> > > pictures of this to show off on the internet (by far the most
> > > important aspect of porting a device in 2024!).
> > >=20
> > > Add a small utility "ufetch" for displaying some information about U-=
Boot and
> > > the hardware it's running on in a similar fashion to the popular neof=
etch tool
> > > for *nix's [1].
> > >=20
> > > While the output is meant to be useful, it should also be pleasing to=
 look at
> > > and look good in screenshots. The ufetch command brings this to U-Boo=
t,
> > > featuring a colorful ASCII art version of the U-Boot logo and a fancy=
 layout.
> > >=20
> > > Finally, tireless device porters can properly show off their hard wor=
k and get
> > > the internet points they so deserve!
> > >=20
> > > Not everything is fully supported yet, but this seemed good enough fo=
r initial
> > > inclusion. Only one MMC device is detected, and other than SCSI other=
 storage
> > > devices aren't supported.
> >=20
> >=20
> > This command is not very generic. E.g. it supports SCSI drives but not =
SATA. Many boards have eMMC and SD-card. This lks more ike an RFC tan somet=
hing ready to merge.
>=20
> Honestly it didn't even occur to me to send an RFC since this is purely a
> vanity thing...
>=20
> I'll make it generic over UCLASS_BLK if possible for the next revision.
> >=20
> > Why don't you use a script or an EFI program to print whatever informat=
ion you need?
>=20
> Well , then you'd need to have a way to load the script or EFI binary, wh=
ich
> might not be possible for an early U-Boot port which doesn't have storage
> support yet (or at least, be a bunch of effort).
>=20
> The only motivation to have this in U-Boot is really because
>=20
> a) it's cute
> b) it motivates "reward oriented" people like myself to get U-Boot booting
> on new/interesting devices because now it can be really easily shown off.
>=20
> Maybe it's a cynical take, but I think stuff like this really has the
> potential to get more folks interested. Nobody likes doing the invisible
> background work, so why not bring some visibility to things?
>=20
> Assuming I did a bad job at conveying my intent in the patch description:
> the point here is not to convey useful debugging information to developer=
s,
> it's to show off, look pretty, and be amusing. Plenty of other U-Boot
> commands can convey information, this one is more like the 2048 port.

So, at the high level, yes, this is something that ought to get merged
as it's handy enough, but not intended to replace for example smbios
information.

--=20
Tom

--lTRhmW2WSliX30AV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma2kg8ACgkQFHw5/5Y0
tyzzWAwAnp49P07kUVXq/oRJGs0J63D3htP7pespZI+xh4+DRwu2xEHHIdwflv1e
d1rr/XoilV7/dV3fqvQHJO2wmrKGg+09W34ljiDP34ZROSRGaYyblBgYkPqqWyCq
ZnVh+VMol5Dhmpq7WX80NbZy89usosJPr4z8TXT9UgyXE6+Fava+7pAcNYVluxOs
8KgMgUG+7Kq92ltAKdA/vJIgH3uZZQjW/rLbsJU1Dr6CWW8dyWEC3vY+qCYSXsXJ
tLlK/lYKosr/HbikrrX+zX6NkPGI9LGtwHa1G2AqscUKTuJqnPbpHQkdl/2w6jj9
8PNbrGLYJcFlyk8DIQctU3RFnUjbNElgelgblSuMGJPnO9OPD85I/TzmVL17zgAp
qhge7hLyIad/3AjWSVaa89IOWfasm1fdtw+YiT3Gm0Hld/ftHu9GkH/mHnZfYGAR
0aoJemEtuCP8qYt8s0hOhpV+HlWhror86aemYgDCJnBpSmtnSp3HvvH5lGV7aPJ7
VQzU7kjO
=kMUR
-----END PGP SIGNATURE-----

--lTRhmW2WSliX30AV--
