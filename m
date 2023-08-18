Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9123FC71159
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 17:04:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1DBE86E54;
	Fri, 18 Aug 2023 19:04:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aDycvXfO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A63D86E92; Fri, 18 Aug 2023 19:04:54 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4E8E86E1D
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 19:04:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-589a9fc7fc6so11560777b3.1
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 10:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692378289; x=1692983089;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sRWA+EbTxpWs2bhgzaWfh++zEu25QI5rU6zxBvuAnGE=;
 b=aDycvXfO1hP3JDxrjIDeXtoNRC9OVycDbpoTbvmSMHXLSEsq10r2/OAF8lMOg4cv0B
 Oe8feKIYWZFe3Ytx72g0hZCPZ2Md0R0jjU4mEtKNCxHEQO2/0bY6i/Dd9LnWfcUZDQG5
 +l0mgx7a3h7UcuAh4i8dX7Wi9iL7ugC8SiMI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378289; x=1692983089;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sRWA+EbTxpWs2bhgzaWfh++zEu25QI5rU6zxBvuAnGE=;
 b=YA682gcZ4vVZOd9RVFUrK2rbWMkpwA6KFqJBeoiK7LoElQG3nbiiz/NjJr8/ebYzrY
 BzFm+eZT4RXnt+lcac8Ap9rh1K9P0cTQBEN/I3kUWVMN51dSiok26yFR2BRzoQ8qgbRP
 DCCUxaRp/NDygKFRzNYZ9VM40Ohkl9ycFNuIFVg3NqpAPEyUazk7Qui0q7jX5PCcErFw
 imI6GM8g5jFxCkFgDwE3XW6KscaiITdinBXBZWFoS9LJzrRElvwGeHEE7d6K93IOtVSh
 fk+O/IZhEq7uPqSnftVwQoCdK80+eHWgHi5HsclIL/hva2nV6DTJD/F5nN/QQrZt/0TV
 K5AQ==
X-Gm-Message-State: AOJu0YyHvRiOzQkJRdMhVmMEUMsWUE+Uzb9MCqewvM0yjLEpnrQTGV7Z
 J+Hh7O8mbIElUH7IxVJswsvPx5MhkFt8pGqvQmE2EQ==
X-Google-Smtp-Source: AGHT+IFMvbEvmDxsabIueIb1kOg15/6q7rvtMvTd5OQvJcJHxwsYuMBpDt/NQb+Rjqng8yR9LPmdKg==
X-Received: by 2002:a81:5fc5:0:b0:58c:57c1:138a with SMTP id
 t188-20020a815fc5000000b0058c57c1138amr3513991ywb.19.1692378289565; 
 Fri, 18 Aug 2023 10:04:49 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-38f7-b1b8-9b5e-5709.res6.spectrum.com.
 [2603:6081:7b00:6400:38f7:b1b8:9b5e:5709])
 by smtp.gmail.com with ESMTPSA id
 g129-20020a0df687000000b00577374e8abasm600031ywf.87.2023.08.18.10.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:04:49 -0700 (PDT)
Date: Fri, 18 Aug 2023 13:04:47 -0400
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, u-boot@lists.denx.de
Subject: Re: [GIT PULL] ARM: tegra: Changes for v2023.10-rc1
Message-ID: <20230818170447.GA1515023@bill-the-cat>
References: <20230818133923.286332-1-thierry.reding@gmail.com>
 <20230818164943.GZ1515023@bill-the-cat>
 <0C415156-B22C-4B86-94C6-1D03ED4287ED@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="X+3sw5UvzRIf8hJb"
Content-Disposition: inline
In-Reply-To: <0C415156-B22C-4B86-94C6-1D03ED4287ED@gmail.com>
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


--X+3sw5UvzRIf8hJb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2023 at 08:02:30PM +0300, Svyatoslav Ryhel wrote:
>=20
>=20
> 18 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80. 19:49:43 GMT+03:00, =
Tom Rini <trini@konsulko.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(-=
=D0=BB=D0=B0):
> >On Fri, Aug 18, 2023 at 03:39:22PM +0200, Thierry Reding wrote:
> >
> >> From: Thierry Reding <treding@nvidia.com>
> >>=20
> >> Hi Tom,
> >>=20
> >> The following changes since commit 68c07fc5fdf34f0926cf06fc0c4ebd6f2f3=
afe19:
> >>=20
> >>   Merge https://source.denx.de/u-boot/custodians/u-boot-usb (2023-06-2=
1 14:42:50 -0400)
> >>=20
> >> are available in the Git repository at:
> >>=20
> >>   git@source.denx.de:u-boot/custodians/u-boot-tegra.git tags/tegra-for=
-2023.10-rc1
> >
> >FYI, in your .git/config you can do:
> >	url =3D https://source.denx.de/u-boot/custodians/u-boot-tegra.git
> >	pushurl =3D git@source.denx.de:u-boot/custodians/u-boot-tegra.git
> >
> >And this part looks "nicer".  Not a big deal, just an FYI.
> >
> >> for you to fetch changes up to bdf9dead86f06c7d6980c399a4a6339430b531e=
c:
> >>=20
> >>   board: htc: endeavoru: add One X support (2023-06-30 15:20:37 +0200)
> >>=20
> >> This passes CI successfully:
> >>=20
> >>   https://source.denx.de/u-boot/custodians/u-boot-tegra/-/pipelines/17=
411
> >>=20
> >> Thanks,
> >> Thierry
> >>=20
> >> ----------------------------------------------------------------
> >> ARM: tegra: Changes for v2023.10-rc1
> >>=20
> >> This adds support for various new Tegra30 boards (ASUS, LG and HTC) and
> >> has some other minor enhancements, such as enabling the poweroff comma=
nd
> >> on several Tegra210 and Tegra186 boards.
> >>=20
> >> ----------------------------------------------------------------
> >> Jonas Schw=C3=B6bel (1):
> >>       configs: tegra-common-post: make PXE and DHCP boot targets optio=
nal
> >>=20
> >> Svyatoslav Ryhel (6):
> >>       configs: tegra-common-post: add GPIO keyboard as STDIN device
> >>       ARM: tegra: add SoC UID calculation function
> >>       board: asus: transformer: add ASUS Transformer T30 family support
> >>       board: asus: grouper: add Google Nexus 7 (2012) support
> >>       board: lg: x3: add Optimus 4X HD and Optimus Vu support
> >>       board: htc: endeavoru: add One X support
> >>=20
> >> Thierry Reding (2):
> >>       ARM: tegra: Enable poweroff command on Jetson TX1 and Jetson Nano
> >>       ARM: tegra: Enable poweroff command on Jetson TX2
> >>=20
> >> Tomasz Maciej Nowak (1):
> >>       ARM: dts: trimslice: sync SPI node with Linux dts
> >
> >Since I'm not sure if this is v8 or v9, given when v9 was posted, I've
> >applied this PR now, as I had said I wanted this in.  I do have two
> >requests for you Svyatoslav, however.  First, if there's changes that
> >are missing in master, please post those ASAP and we'll get them in, for
> >v2023.10.=20
>=20
> Patches Thierry applied are v8, while v9 has significant improvements.

OK, I've updated patchwork to try and reflect this too.

> Second, on Monday after I release -rc3 and merge that in to
> >next, in the next branch we allow for (and encourage!) config fragments
>=20
> I will apply fragments move in the next patchset for t20/t30 devices
> which will be send once this pathes are applied. This is acceptable
> for you?

Yes, I think this will be fine, thanks!

--=20
Tom

--X+3sw5UvzRIf8hJb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTfpKsACgkQFHw5/5Y0
tywUkQv+O6GQjBnUly3E9EHL0M7urfv8ZhoRRfbBS8NYv61Y0N0m1w8KO2oY5GjP
86Xipvv/lS5BCQMas2bS1qcacrSctN94jaU00bhjtztz3hkKFZ+5E1m+W0YvJSEz
PcmWI8w3lyWLrWtctRM6x9BOhSkJDcIA9qOeMqxjPOihFMvOSqu8IB/JFsm2jaR6
at38urlyhZ4btvp4jCrII1F6T2OFC4ullO1wMHeqJU+695bsusBHdsKX19cnflmG
KWKVmF6Kq8MJ1k7pabZyDVoU9s5q9NDcFQWwr/kweIzbuU04fzN7/iAfnTaK3M97
fcxKy2siLnYjC7v4C/0N7R/3yCSH3YW5+dOd7qg/D8spXwu0ZlbgEDUBMXnIYifn
gWXfLPBDpmlVk/+i5n6XM7I8ABehT2ccRn2t8ysVYSQrXq7ehvyRrMrUvWsbvCat
jQpSoa3Eol2mlY5ytufgM5IeeStuaSE/+MXSIAQF/gPuNoxYtJHLEh2dSP4JIMmf
q+buGvN9
=3bru
-----END PGP SIGNATURE-----

--X+3sw5UvzRIf8hJb--
