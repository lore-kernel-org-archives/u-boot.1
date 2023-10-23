Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A61C001E0
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 16:57:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 200628791F;
	Mon, 23 Oct 2023 18:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NOnME2Fa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 223E18792C; Mon, 23 Oct 2023 18:57:47 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1EE9878EC
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 18:57:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5a90d6ab962so24660837b3.2
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 09:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698080263; x=1698685063; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ilulq1JOvI6fHf8Koz1Bz3cAXfVg/rsjaUrckcztf+A=;
 b=NOnME2FaW8fSX+y5YFfvLsF6bvP2uY/mS7Qwd2Gqr/JIEezzIwU4PxshFJYM7RGDoN
 scBZTgQTfdnmLu0oQwEgKR9EJ9firPQONOvnMYeW2xGW+ij5IzsG5BGFXQ7lNT2tzRXP
 2o/jviPIJOCDWr0J8IIMnE29SkgnEa/wQPVuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698080263; x=1698685063;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ilulq1JOvI6fHf8Koz1Bz3cAXfVg/rsjaUrckcztf+A=;
 b=xLNjxZipM4Vqj9TO3IP/uSJsZJTGG6yt8uJ5ipDTi8SUy7pOXG0E3nZZdZ80g/O2Ej
 /YXc1wfmMKN5dyxvTfGevTCFQTlpVO7LFS71p0mI410/laqGha6EdezAkU2tPDlqU07x
 E7sWPKnjzet5HSPcpk6NgDqMXz311JrL3NyCWbwfrVyRgPynaXD7j0T1sNCRfaZNawNB
 Qn2uRyHKJOANwvBRlJg5dYlGWY5rSmKYpDb1kcohizYdTmb4pDxyJs7CK6zClUKV/WBu
 eQIVmADHIJ7OL8vuV8g3+XB3SgthVb9sG4ReLkqkVX0xHmVjB3LhEy0R57n1soCDehPM
 0wNA==
X-Gm-Message-State: AOJu0YzRoMaI3WCMfLcoKy2Jx9ZgRSRullpyN+1Dy6QIKgDBDPH3W5f3
 XGeCfW6aYohHAg9Q427+xemGhQ==
X-Google-Smtp-Source: AGHT+IFZ3RNDfqIkT+xSYa/m177Mt8Fiw0D4IOyQTedaVi1Gb48SRwmsUXIYwWrHbWrpXtinnCdeaQ==
X-Received: by 2002:a0d:dfca:0:b0:5a8:2078:48e5 with SMTP id
 i193-20020a0ddfca000000b005a8207848e5mr9296638ywe.31.1698080263642; 
 Mon, 23 Oct 2023 09:57:43 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-3cd1-c3ac-4562-deca.res6.spectrum.com.
 [2603:6081:7b00:6400:3cd1:c3ac:4562:deca])
 by smtp.gmail.com with ESMTPSA id
 t78-20020a0dea51000000b005a7e6a68f0fsm3259020ywe.25.2023.10.23.09.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 09:57:43 -0700 (PDT)
Date: Mon, 23 Oct 2023 12:57:41 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v3 1/1] efi_loader: expose the device-tree file name
Message-ID: <20231023165741.GM496310@bill-the-cat>
References: <20231022084733.113326-1-heinrich.schuchardt@canonical.com>
 <20231022155543.GC496310@bill-the-cat>
 <4c4fee5a-82ab-46e2-a450-f874b2a9ad5c@canonical.com>
 <20231022170812.GD496310@bill-the-cat>
 <36e1a60c-3aa9-4f06-9920-c7b0a1d12c19@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NZhzTYm1pBiSiQeI"
Content-Disposition: inline
In-Reply-To: <36e1a60c-3aa9-4f06-9920-c7b0a1d12c19@canonical.com>
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


--NZhzTYm1pBiSiQeI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 22, 2023 at 11:31:52PM +0200, Heinrich Schuchardt wrote:
> On 10/22/23 19:08, Tom Rini wrote:
> > On Sun, Oct 22, 2023 at 06:34:08PM +0200, Heinrich Schuchardt wrote:
> > > On 10/22/23 17:55, Tom Rini wrote:
> > > > On Sun, Oct 22, 2023 at 10:47:33AM +0200, Heinrich Schuchardt wrote:
> > > >=20
> > > > > Forward and backward compatibility of Linux kernel device-trees is
> > > > > sometimes missing. One solution approach is to load a kernel spec=
ific
> > > > > device-tree. This can either be done via a U-Boot scripts (like t=
he one
> > > > > generated by Debian package flash-kernel or by a boot loader like=
 GRUB.
> > > > > The boot loader approach currently requires to know the device-tr=
ee name
> > > > > before first boot which makes it unusable for generic images.
> > > > >=20
> > > > > Expose the device-tree file name as EFI variable FdtFile.
> > > > > This will allow bootloaders to load a kernel specific device-tree.
> > > > >=20
> > > > > The variable will not be exposed on ACPI based systems or if the
> > > > > environment variable fdtfile is not defined.
> > > > >=20
> > > > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical=
=2Ecom>
> > > > > ---
> > > > > v3:
> > > > > 	Add documentation
> > > > > v2:
> > > > > 	Use a unique GUID to enable future U-Boot independent
> > > > > 	standardization.
> > > > > 	Do not try to add the variable on ACPI based systems.
> > > > > ---
> > > > >    doc/develop/uefi/uefi.rst  | 17 +++++++++++++++++
> > > > >    include/efi_loader.h       |  5 +++++
> > > > >    lib/efi_loader/efi_setup.c | 30 ++++++++++++++++++++++++++++++
> > > > >    3 files changed, 52 insertions(+)
> > > > >=20
> > > > > diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> > > > > index fb16ac743a..a81d09ae81 100644
> > > > > --- a/doc/develop/uefi/uefi.rst
> > > > > +++ b/doc/develop/uefi/uefi.rst
> > > > > @@ -916,6 +916,23 @@ So our final format of the FilePathList[] is=
::
> > > > >        Loaded image - end node (0xff) - VenMedia - initrd_1 - [en=
d node (0x01) - initrd_n ...] - end node (0xff)
> > > > > +EFI variable FdtFile
> > > > > +~~~~~~~~~~~~~~~~~~~~
> > > > > +
> > > > > +Ideally U-Boot would always expose a device-tree that can be use=
d for booting
> > > > > +any operating systems. Unfortunately operating systems like Linu=
x sometimes
> > > > > +break forward and backward compatibility. In this case there is =
a need to load
> > > > > +an operating system version specific device-tree.
> > > > > +
> > > > > +U-Boot has an environment variable fdtfile identifying the devic=
e-tree file to
> > > > > +load. The content of this variable is exposed as EFI variable Fd=
tfile, vendor
> > > > > +GUID d45dde69-3bd6-40e0-90d5-6b606aa57730. It contains the devic=
e-tree path
> > > > > +name as a NUL terminated ASCII string.
> > > > > +
> > > > > +On 32bit ARM this is currently only a file name, e.g. 'imx6dl-wa=
ndboard.dtb'.
> > > > > +On other architectures the file name is preceded by the vendor d=
irectory, e.g.
> > > > > +'rockchip/rk3326-odroid-go2.dtb'.
> > > >=20
> > > > The Linux Kernel has split 32bit ARM up by directory now, too.
> > >=20
> > > Since Linux v6.5. That is why I wrote "currently". Once we migrate the
> > > values of $fdtfile in U-Boot we may want to change
> > > distro_efi_try_bootflow_files() to search both with and without vendor
> > > directory.
> > >=20
> > > Are there already plans for that migration?
> >=20
> > Right, v6.5 is out and has this change and v6.6 will be out soon enough,
> > so the documentation we're adding here and now should be worded such
> > that doesn't get stuck on these specifics.
>=20
> Should I add a sentence:
>=20
> Linux v6.5 has added vendor directories on 32bit ARM and U-Boot is expect=
ed
> to follow suit.

No, please re-word the section to be more generic.  Some architectures
use vendor directories, some don't.  I really don't know what we're
going to do in U-Boot.

--=20
Tom

--NZhzTYm1pBiSiQeI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU2pgIACgkQFHw5/5Y0
tywUXAv/dz1Rrd1emyd3SaT1LKB2F401KNL/QaZ2rg2MZdaq0boYRzlNZAvFgI69
XRfVWGqzywQ9o8q47mPNLiquJv2SK/Mtq1awcyPa+v1BSoAV2CiDw2v8MY8OD80M
ZhipGs+msRRg+ZbDw66BVa5Zxh2JQ4rE8nZKNpQKWUqDc4aaxVbcosOWODlUY4Hp
+O8npCRlM3kIxlLGMbCaDiu8/HBV+tIOJhILBYV8r7dEA5Y0Gxe6rYRFqutYEBIO
CRaD9CMImGEVe0JNrV+7cTWva005Ka5udKa62siZHRFSccsdf7eUIEeMAwWee015
yK2YluCHMDTbjGL/vu5KYhWa4oSjAfmQa2U8VA5xc0pOhrDGjwyYufWVizl19MY0
Pq26kEzFpgnXJeJRQP4ZJ5DcWPsKLV7dHPb0qLVDrCiL/4folXFalP1+RSSG1bWJ
nf5Jf4vSx4SIKGtUPOQ2Ymf+7WTo19ubK0Au3s5MJQZ5UOt6GUntcz6GHZ5PhNta
iC8yO7ak
=E6Uz
-----END PGP SIGNATURE-----

--NZhzTYm1pBiSiQeI--
