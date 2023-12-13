Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E3A7C4167B
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 23:05:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C754878BA;
	Thu, 14 Dec 2023 00:05:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qv/A5IZW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5062F878C9; Thu, 14 Dec 2023 00:05:51 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E37F7878B7
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 00:05:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-1fb37f25399so4923961fac.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 15:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702508747; x=1703113547; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EpQi3O6B8HkwQfryFIdVZ0DHUbQsbbpQiS2ESym4dW4=;
 b=qv/A5IZWOVuxVmrd3zHCeaKczEWMg7FK9Sm7o7SwlqVLvu27ICKIjrG7xQRkEeV+uo
 AB5n8r/6mfeqlGPKMqe2EzEsj1Va13fKjeB2mcVkVrD5+qrxDzc/MbwY1NyTC+1iub9+
 IZUlBnA6eUozoorFWZVpyEF3cf1wYzetbrL8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702508747; x=1703113547;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EpQi3O6B8HkwQfryFIdVZ0DHUbQsbbpQiS2ESym4dW4=;
 b=LmliLP2Bo2B3YIJahVo8Fsqze3xdCnTOvBx3eTdwMP5LXCn7iLa6qnpUE130yvJIj2
 ez88ExVVt4a/Wq5tAidQoghFZjFjmfpm809TpPZiwCYgg0pORmh0wCCJyQki/XagPpUi
 q671R9P3bycoRo0kqyzvmtMZxgWUmSdj/iJebU9t00A9r1Ry/wxNMNmTTb69+PV1eEcU
 XDmz9hqi/RoCcWadzxJXQjjboDGqqIgy4G3NG3Qtnv5k4aSqzKsvI15keoeRbNjg+omW
 yrCWNjRZRxp29eIu9OAI+RqfwE4PWcf+rIQfygJt1B++e0T6ZC4oFKjCku/kL3xGmo/A
 9TEQ==
X-Gm-Message-State: AOJu0YyO9V5Qw96IWUC6C/xyzh3zMQE7nSL5CeA9BmqNoEs5HQX20wXJ
 Qibz00VEKY4w4N0tDnG9tg10tA==
X-Google-Smtp-Source: AGHT+IHXZ/QTHoRyadzBwpBG6Cvm6qC37i8AzPyY+2ZANcqJG8Ov9RLoxnIP0BYYQ9g5wkYPLzO57Q==
X-Received: by 2002:a05:6870:3e09:b0:1fb:1480:b2a0 with SMTP id
 lk9-20020a0568703e0900b001fb1480b2a0mr10586783oab.8.1702508747422; 
 Wed, 13 Dec 2023 15:05:47 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 p187-20020a815bc4000000b005e2539e73efsm1339281ywb.26.2023.12.13.15.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Dec 2023 15:05:46 -0800 (PST)
Date: Wed, 13 Dec 2023 18:05:45 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, sean.anderson@seco.com,
 neil.armstrong@linaro.org, heinrich.schuchardt@canonical.com,
 mark.kettenis@xs4all.nl, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2 v3] smbios: Fallback to the default DT if sysinfo
 nodes are missing
Message-ID: <20231213230545.GM2513409@bill-the-cat>
References: <20231207091850.17776-1-ilias.apalodimas@linaro.org>
 <20231207091850.17776-3-ilias.apalodimas@linaro.org>
 <CAPnjgZ2hMB0uTTd7tKZ2bGHkPiKM8j+Dz47nXKwiXH6vWHF8tQ@mail.gmail.com>
 <20231213201655.GF2513409@bill-the-cat>
 <CAPnjgZ3G_3iUcHoOFGGYQ5Dxho5HwqcH=TqwS3j-NoNcBCEdkA@mail.gmail.com>
 <20231213205634.GK2513409@bill-the-cat>
 <CAPnjgZ2hV25e1zjrNqKqd-doO9A1L9H58oToDANOSEQr5jwexA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nBmLYDS4QJRV2Bcx"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2hV25e1zjrNqKqd-doO9A1L9H58oToDANOSEQr5jwexA@mail.gmail.com>
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


--nBmLYDS4QJRV2Bcx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 03:22:25PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 13 Dec 2023 at 13:56, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Dec 13, 2023 at 01:41:04PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 13 Dec 2023 at 13:17, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Dec 13, 2023 at 12:51:33PM -0700, Simon Glass wrote:
> > > > > Hi Ilias,
> > > > >
> > > > > On Thu, 7 Dec 2023 at 02:19, Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > In order to fill in the SMBIOS tables U-Boot currently relies o=
n a
> > > > > > "u-boot,sysinfo-smbios" compatible node.  This is fine for the =
boards
> > > > > > that already include such nodes.  However with some recent EFI =
changes,
> > > > > > the majority of boards can boot up distros, which usually rely =
on
> > > > > > things like dmidecode etc for their reporting.  For boards that
> > > > > > lack this special node the SMBIOS output looks like:
> > > > > >
> > > > > > System Information
> > > > > >         Manufacturer: Unknown
> > > > > >         Product Name: Unknown
> > > > > >         Version: Unknown
> > > > > >         Serial Number: Unknown
> > > > > >         UUID: Not Settable
> > > > > >         Wake-up Type: Reserved
> > > > > >         SKU Number: Unknown
> > > > > >         Family: Unknown
> > > > > >
> > > > > > This looks problematic since most of the info are "Unknown".  T=
he DT spec
> > > > > > specifies standard properties containing relevant information l=
ike
> > > > > > 'model' and 'compatible' for which the suggested format is
> > > > > > <manufacturer,model>. Unfortunately the 'model' string found in=
 DTs is
> > > > > > usually lacking the manufacturer so we can't use it for both
> > > > > > 'Manufacturer' and 'Product Name' SMBIOS entries reliably.
> > > > > >
> > > > > > So let's add a last resort to our current smbios parsing.  If n=
one of
> > > > > > the sysinfo properties are found, scan for those information in=
 the
> > > > > > root node of the device tree. Use the 'model' to fill the 'Prod=
uct
> > > > > > Name' and the first value of 'compatible' for the 'Manufacturer=
', since
> > > > > > that always contains one.
> > > > > >
> > > > > > pre-patch:
> > > > > > Handle 0x0001, DMI type 1, 27 bytes
> > > > > > System Information
> > > > > >         Manufacturer: Unknown
> > > > > >         Product Name: Unknown
> > > > > >         Version: Unknown
> > > > > >         Serial Number: 100000000bb24ceb
> > > > > >         UUID: 30303031-3030-3030-3061-613234636435
> > > > > >         Wake-up Type: Reserved
> > > > > >         SKU Number: Unknown
> > > > > >         Family: Unknown
> > > > > > [...]
> > > > > >
> > > > > > and post patch:
> > > > > > Handle 0x0001, DMI type 1, 27 bytes
> > > > > > System Information
> > > > > >         Manufacturer: raspberrypi
> > > > > >         Product Name: Raspberry Pi 4 Model B Rev 1.1
> > > > > >         Version: Unknown
> > > > > >         Serial Number: 100000000bb24ceb
> > > > > >         UUID: 30303031-3030-3030-3061-613234636435
> > > > > >         Wake-up Type: Reserved
> > > > > >         SKU Number: Unknown
> > > > > >         Family: Unknown
> > > > > > [...]
> > > > > >
> > > > > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > > > ---
> > > > > > Simon, I'll work with tou on the refactoring you wanted and
> > > > > > remove the EFI requirement of SMBIOS in !x86 platforms.
> > > > > > Since this code has no tests, I'll add some once the refactoring
> > > > > > is done
> > > > > >
> > > > > > Changes since v2:
> > > > > > - Spelling mistakes
> > > > > > - rebase on top of patch #1 changes
> > > > > > Changes since v1:
> > > > > > - Tokenize the DT node entry and use the appropriate value inst=
ead of
> > > > > >   the entire string
> > > > > > - Removed Peters tested/reviewed-by tags due to the above
> > > > > >  lib/smbios.c | 94 ++++++++++++++++++++++++++++++++++++++++++++=
+++++---
> > > > > >  1 file changed, 89 insertions(+), 5 deletions(-)
> > > > >
> > > > > Can we add a Kconfig to enable this?
> > > >
> > > > Why? This is the default option that we want moving forward in orde=
r to
> > > > get the fields populated.
> > >
> > > The model name is fine. The manufacturer is in lower case (using the
> > > DT vendor name), so not in the right format.
> > >
> > > It only populates two fields, so far as I can tell.
> >
> > Maybe we need to turn this discussion on its head slightly. What do you
> > want to do to get SMBIOS fields to be widely populated with
> > generally-correct information? What we have been doing has seen very
> > little adoption so we need something else.
>=20
> Well, who or what is actually using this info? Is the problem just
> that it doesn't actually matter, so no one bothers? I'm just not sure.

Users are using this information. Peter has explained that Fedora has
been carrying Ilias' original version of this patch since it was posted
so that bug reports say (something close enough and that can be tracked
down) what device they're on, rather than "Unknown" / "Unknown Product".

> The fact that on ARM you cannot pass it to the kernel without EFI
> might be inhibiting its usefulness, too? Usefulness is the key
> question for me.

I'm setting aside the discussion of how one will tell the kernel where
the SMBIOS is, outside of EFI as it's not a U-Boot problem and belongs
on other lists.

> Anyway, my suggestion (once we understand why we care about SMBIOS
> tables) is patches like we just saw from rockpro64, perhaps even with
> a few more fields filled out. This series seems like a backup for
> board maintainers that don't care, which is fine, but we should at
> least be able to disable it.

The issue is that this series adds, for free, useful and sufficiently
correct information in the common cases. The "for free" is a huge
feature too. Drawing on the rockpro64 patch, I would suggest seeing if
/version (or /hardware-rev or whatever) is something Rob is interested
in adding so it can be something filled out or not and then pulled from
DT instead of a new set of DT nodes that look a whole lot like the
existing DT nodes and properties that already exist.

--=20
Tom

--nBmLYDS4QJRV2Bcx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV6OMUACgkQFHw5/5Y0
tywyRQv/Y3duOQWYNMLp6tQdkF9C8qBwfF+r9SQ0Qlwh/FWpr05GtfjIDYb74+ay
OpryoAOjHivZVVOVt5ydyv1ZtrBxHCFVMCRjvgZ0Uc+gF2Q+lmQbCmaEDT5ztvnz
dds6dST0n7VdzSTU5kKcHHxAul2u6WHoon8xWlK0Ne+mHHM4foq/akCVmwuVAztS
aEPDvxoytFIae6xNL7emT3bWibJEYvAhp8Ho6Fw8xGusbRgAHXSjEJ9sLj1ZHGOi
eg3Cd3EVAj1A9IAhVvdujjaBl5JtiUoV5urUYW3ym4LKOCDZ0PyvWbxTRFSadKj2
ygwSmVgFjjqXzGuVUOTN1Q37QBl1CoysnHeAjQ0eJCGuMbd5Pu52NNkNa/jqn6Ec
T7GVWYEmPm+CATobVtrlb6UcCele9O9wX54G76UhljT5opfyKtqS2KM+pskFvkqc
0Ilra+s381o4THKgKiRc6Wgy5jKsvNlIryypwhVGpx2HX/qV7qSFVBECDy0gfN26
OfuEHsZJ
=KNLg
-----END PGP SIGNATURE-----

--nBmLYDS4QJRV2Bcx--
