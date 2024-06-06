Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF47C27C5F
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 15:44:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C9BB881A1;
	Thu,  6 Jun 2024 17:44:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tGWf4OFl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E03E88395; Thu,  6 Jun 2024 17:44:43 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBC3A87F5C
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 17:44:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-250aa4e8306so620530fac.0
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 08:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717688679; x=1718293479; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=r9cRrJaln06TgkhT0XlYmPiX9aMFbLQJ/Y9VvVmifPU=;
 b=tGWf4OFlejj2KXZ+7NO7FPnuw8y5GEO6lPik+J7Hfs3IcrgmTA53C/r+Pdc0n/Z8nW
 5nYLz9ZDR1BDjGTW/iAzFub/1owXwscYv5hbj4s7sOOodTAa4vrV3i3hoIkQZJJppY4p
 NVOpbuxqzz+Gs5ZwBn+11N3iZxRLvJc7C1E9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717688679; x=1718293479;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r9cRrJaln06TgkhT0XlYmPiX9aMFbLQJ/Y9VvVmifPU=;
 b=Anx0mzNdI5Yzbr25ad8fRoJ1HHXZnGgyUmwfbSCANqVkMJUitN7UbsdSEwUoGJLM/+
 vS2SlJ63Q2dygSXx3Qb/dfHoDn4SfbLd0elZKUJYO15MNfBKLZgBltDs8DcJUoYneHBm
 4oSlBKDeqNOYLrpX/9KZe4BD+hlHxzel0iGG0Hk2kJfgbxobwOWl4ltswJiHbDwOrdB4
 TI0ayFgfWhrnFyFOR0D4i0ajG49UkmrwsP0cwgWg9NmTXBaGYwqOJZsb/R3UPXVck7Uc
 X18wxCR4OyibwxvCTfmw1NbsqIxU2D+xu6CuArt/fDjRVKnQzRMxvipNvWWl8K6IdZSC
 BCdA==
X-Gm-Message-State: AOJu0Ywt/XfG0xKsPuHMihs2A+8XL2btkQaaVHVs287mnqpbyf6Df5AC
 1FNq2xSRZtf1P5nu8KtRMlHn1T1qUX1FcL1nkT4qshTUpw4oP06QqZCoqkZpsUI=
X-Google-Smtp-Source: AGHT+IHxhMb5c5NOq9Y9i6RKE6mn1WzRUwd6L1kx1Zro4VqlrAb/s58vR/AHsg/q0+DSg/VPnXJOiA==
X-Received: by 2002:a05:6870:2247:b0:24f:dd36:7b24 with SMTP id
 586e51a60fabf-25121c7e051mr7226344fac.2.1717688679536; 
 Thu, 06 Jun 2024 08:44:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2544812d776sm410182fac.56.2024.06.06.08.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 08:44:38 -0700 (PDT)
Date: Thu, 6 Jun 2024 09:44:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH 9/9] Revert "arm: am335x: Enable SPL_OF_CONTROL on some
 configs"
Message-ID: <20240606154436.GA68077@bill-the-cat>
References: <20240605032521.1142768-1-sjg@chromium.org>
 <20240605032521.1142768-10-sjg@chromium.org>
 <20240605144224.GR68077@bill-the-cat>
 <CAFLszThEeXFtqf-Yk+_WbJ2GJtkFdC-R-_nWH2HAE9rjn0d8ag@mail.gmail.com>
 <20240605201509.GW68077@bill-the-cat>
 <CAFLszTisz7GUBzSYS9doV2vfPfM14=-v7ADsPbrALYZkuqrtiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nCQ8zUkDd6/02pQx"
Content-Disposition: inline
In-Reply-To: <CAFLszTisz7GUBzSYS9doV2vfPfM14=-v7ADsPbrALYZkuqrtiA@mail.gmail.com>
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


--nCQ8zUkDd6/02pQx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 09:04:17AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 5 Jun 2024 at 14:15, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Jun 05, 2024 at 02:08:54PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 5 Jun 2024 at 08:42, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Jun 04, 2024 at 09:25:21PM -0600, Simon Glass wrote:
> > > >
> > > > > This is a partial revert which makes boneblack_vboot boot again.
> > > > >
> > > > > This reverts commit f4b64e9736e73ceec14d51600bed9a8ac48f9fe8.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > >  configs/am335x_boneblack_vboot_defconfig | 1 -
> > > > >  1 file changed, 1 deletion(-)
> > > > >
> > > > > diff --git a/configs/am335x_boneblack_vboot_defconfig b/configs/a=
m335x_boneblack_vboot_defconfig
> > > > > index d473a1a793b..3ec4abddd77 100644
> > > > > --- a/configs/am335x_boneblack_vboot_defconfig
> > > > > +++ b/configs/am335x_boneblack_vboot_defconfig
> > > > > @@ -40,7 +40,6 @@ CONFIG_SYS_I2C_EEPROM_ADDR_LEN=3D2
> > > > >  # CONFIG_CMD_SETEXPR is not set
> > > > >  CONFIG_BOOTP_DNS2=3Dy
> > > > >  CONFIG_OF_CONTROL=3Dy
> > > > > -CONFIG_SPL_OF_CONTROL=3Dy
> > > > >  CONFIG_ENV_OVERWRITE=3Dy
> > > > >  CONFIG_ENV_IS_IN_MMC=3Dy
> > > > >  CONFIG_SYS_REDUNDAND_ENVIRONMENT=3Dy
> > > >
> > > > So, this change was a while ago. But I did it because some of the
> > > > drivers, tho I forget which ones exactly, really were not functional
> > > > without SPL_OF_CONTROL enabled. That said, does am335x_evm_defconfig
> > > > work in your configuration? I think we have to keep am335x_evm_spib=
oot
> > > > because it's so radically different from how the rest of the possib=
le
> > > > options boot, but I'm not sure we need a vboot defconfig? Or if we =
do,
> > > > it should be updated to use the #include logic these days.
> > >
> > > I don't actually have an am335x_evm board, which is why I'm using bbb.
> > > We only have the vboot version, since the non-vboot was removed a
> > > while back.
> > >
> > > In any case, with this patch, bbb boots again.
> >
> > Yes, the am335x_evm build supports all of the TI (or associated, like
> > beagleboard) platforms. Please give it a try.
>=20
> Yes, that works. So what should we do with the boneblack config? We
> really should have something that boots.

We should delete it and make sure the vboot docs are still up to date /
correct.

--=20
Tom

--nCQ8zUkDd6/02pQx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZh2WEACgkQFHw5/5Y0
tyyahAwAmnHNqOX2UY9moLw8szqYNdUf6AuBkg206WYTL3LoBy+ctdzL14St2zh+
tW6qYdv018KOGWfTm+degxdjFE1wkJZZETRDVtjCXgGIgNwf3RY2Evm6CEetvpG9
Wyz0cutCXYDt4Esa6KDZeNS1H9jiyOGVqknpoT2dZ6o2q0rGWWKXhXE0XQsAj29o
DiZeMo9wmEHV9EP64/59TuVwOo6tBJiJ/DvpHMzYlP38TxqBnsji9f74qpq1VymQ
1RNtdzLRsNgygkCD6At/F9UgSDMAaQjP7pV98LNLvUL2MMxBcPgNX5voaRCHvnDB
1JxZVDyUPtYNyH9ilgfgDlKOsGGuRg9yMOjI9tNHvaqzlsTAWMj/8K7ODJ7OSFfo
FelCGg5uFjWYMmWEQ8ZFd7Ok8Uud8pvkZPqTMIyDjGqEF/2Dtq24zBzoW0pmNPQ8
sqqxKyUAa92l60SFFGJNs4qLRmYlDK0bn0AQDW3fJDkxPE3U3y402HtBswQ6f5nV
QpaYxUhQ
=DYhk
-----END PGP SIGNATURE-----

--nCQ8zUkDd6/02pQx--
