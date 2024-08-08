Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA374C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 10:25:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6738788AF4;
	Thu,  8 Aug 2024 12:25:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723112727;
	bh=0bOlh8UEL/kLm9GXDoZiwbgKg0j6mCkVG0Qq0uwmgJI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PfQKO+FTFKLHfzZnJs2hqS6JIUVBhDOY506AjUGyOwdqKLVYFLq1DKHKZoaVuoXsJ
	 Wd6bjE9C1DSenDN1Z41wfWzkhlhK2Lsbrg5edLUf0XqUQO/DyhUqqCEW63aoid0rPy
	 C40iQn7UtTL3kcNopI3mc3SqcI9TBL1n9RkvuqW7vCGCkQWQys5a70IgBHn20fWv8/
	 R+wI2OszCcavfOpf4HVUctQQEZCKoUU4C/klldIerAeH6PvcoEmWJfie/+I26U28KU
	 dyRE4g6v3n5HlGWhj3Hj8JenURrHoSNZdSMXQjM5VPWeQIbiSFa4WvYbdWhS3qqiLZ
	 3ytI24WLEO61A==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id BDEC388A7D;
 Thu,  8 Aug 2024 12:25:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723112726;
 bh=0bOlh8UEL/kLm9GXDoZiwbgKg0j6mCkVG0Qq0uwmgJI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Ep+UZAP4zaWIKZpAtl4tF4aMGp3btiSVGdhwRC/i8ZTROnJOo+M7E+PZiywGjDjUA
 T9/fSRePhXOMOsZokOQCNuSjrZXFBqUirk2C27ujlrJ7E72UB+QNv3CGRRlnQyLCrO
 CLuV+f8MEj853NvNCn6YeeTgQWC197DwCmdjX69+rf9RYTnytsnKAt54FtMjn5/um4
 X5sYpXmMRKch8A9zlJfszqVqQKURwoDMolMervAlJIr3rosSVPTp4z0AQki34rqiA5
 qP97YHX6REmH7D9a8HcVmh2Kso6/OzqNMr7mxoCdsmePijAJAdAvw59tuKXmBTRc9B
 9tdK+bfCCdXdw==
Date: Thu, 8 Aug 2024 12:25:13 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Teresa Remmet <T.Remmet@phytec.de>
Cc: Benjamin Hahn <B.Hahn@phytec.de>, "sjg@chromium.org" <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, "festevam@gmail.com" <festevam@gmail.com>, Cem Tenruh
 <C.Tenruh@phytec.de>, "martyn.welch@collabora.com"
 <martyn.welch@collabora.com>
Subject: Re: [PATCH v3] config: Add 'update_bootimg' command to update
 flash.bin on Phytec's imx8mm
Message-ID: <20240808122513.124db960@wsk>
In-Reply-To: <fbd60aeea9413d7fa9f82ef952530e316e6b9e97.camel@phytec.de>
References: <20240806081131.4065425-1-lukma@denx.de>
 <dd54f3f8-7d80-4d0c-9eaa-639e45ddfdcf@phytec.de>
 <20240807130423.601a1e47@wsk>
 <fbd60aeea9413d7fa9f82ef952530e316e6b9e97.camel@phytec.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hQAfhQBStOfl4ZriUuVEQZu";
 protocol="application/pgp-signature"; micalg=pgp-sha512
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

--Sig_/hQAfhQBStOfl4ZriUuVEQZu
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Teresa,

> Hello Lukasz,
>=20
> Am Mittwoch, dem 07.08.2024 um 13:04 +0200 schrieb Lukasz Majewski:
> > Hi Benjamin,
> >  =20
> > > Hi Lukasz,
> > >=20
> > > On 06.08.24 10:11, Lukasz Majewski wrote: =20
> > > > This command allows easy update on SD card or eMMC of the
> > > > flash.bin
> > > > generated (with binman) during u-boot build.
> > > >=20
> > > > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > > > ---
> > > > Changes for v2:
> > > > - Remove 'update_mmc_part' variable
> > > > - Change path for hostname
> > > > - Use full version of dhcp command (${loadaddr} added)
> > > >=20
> > > > Changes for v3:
> > > > - Remove +1 when calculating the size of binary to be written
> > > > ---
> > > > =C2=A0 include/configs/phycore_imx8mm.h | 10 ++++++++++
> > > > =C2=A0 1 file changed, 10 insertions(+)
> > > >=20
> > > > diff --git a/include/configs/phycore_imx8mm.h
> > > > b/include/configs/phycore_imx8mm.h index ce6dc87c69..361e665676
> > > > 100644 --- a/include/configs/phycore_imx8mm.h
> > > > +++ b/include/configs/phycore_imx8mm.h
> > > > @@ -29,6 +29,16 @@
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"mmcdev=3D" __strin=
gify(CONFIG_SYS_MMC_ENV_DEV) "\0" \
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"mmcpart=3D1\0" \
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"mmcroot=3D2\0" \
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"update_offset=3D0x42\0"=
 \
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"update_filename=3Dflash=
.bin\0" \
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"hostname=3D/srv/tftp/\0=
" \
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"update_bootimg=3D"
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"mmc dev ${mmcdev} ; "=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"if dhcp ${loadaddr}
> > > > ${hostname}/${update_filename} ; then "=C2=A0\=C2=A0  =20
> > >=20
> > > The dhcp and tftp command should take the filepath from the tftp=20
> > > directory and get the tftp directory automatically not the
> > > absolute path. So this will try to get the file from=20
> > > /path_to_tftp_folder/srv/tftp/flash.bin and will fail =20
> >=20
> > And that is why you do have the ${hostname}/${update_filename}, so
> > when
> > you have several exported directories - you can specify which one
> > without the need to modify the 'update_bootimg' command. =20
>=20
> do I understand it correct that you just want to be able to define sub
> dirs with a variable?=20

Yes, correct.

> This does make sense but you should not pre-
> define them here.

Ok. I will remove the "hostname=3D/srv/tftp" environment variable.

>=20
> And I think the variable name $hostname is kind of miss leading.=C2=A0May=
be
> you can find some different name for it?

The ${hostname} is used in a few places already in that way. Maybe you
have better idea for this variable's name?

>=20
> Regards,
> Teresa
>=20
> >  =20
> > > because it
> > > can't find it. So you can drop the ${hostname}. =20
> >=20
> > I would prefer to keep the ${hostname}/${update_filename} part.
> >  =20
> > > Also drop the initialization of ${hostname} above since it is no
> > > longer needed.
> > >=20
> > > Should be like this:
> > >=20
> > > dhcp ${loadaddr} ${update_filename}
> > >  =20
> >=20
> > IMHO the line shall be:
> >=20
> > dhcp ${loadaddr} ${hostname}/${update_filename}
> >  =20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"setexpr fw_sz ${filesize} / 0x200 ; "=C2=A0=C2=A0/*
> > > > SD block size */ \
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"setexpr fw_sz ${fw_sz} ; "=C2=A0  =20
> > > I think you can drop this line since it does not do anything.
> > >  =20
> >=20
> > Ok.
> >  =20
> > > Benjamin =20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"mmc write ${loadaddr} ${update_offset} ${fw_sz}
> > > > ;
> > > > "=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0\
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"fi\0" \
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"mmcautodetect=3Dye=
s\0" \
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"mmcargs=3Dsetenv b=
ootargs console=3D${console} " \
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"root=3D/dev/mmcblk${mmcdev}p${mmcroot} rootw=
ait
> > > > rw\0" \=C2=A0  =20
> > >=20
> > >  =20
> >=20
> >=20
> >=20
> >=20
> > Best regards,
> >=20
> > Lukasz Majewski
> >=20
> > --
> >=20
> > DENX Software Engineering GmbH,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Managing =
Director: Erika Unter
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell,
> > Germany Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email:
> > lukma@denx.de =20
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/hQAfhQBStOfl4ZriUuVEQZu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAma0nQkACgkQAR8vZIA0
zr2Z1ggAqcuFuGC3P4SVudgMPb8/n1lunMryFti/5sKalj6ZAP51izHBInOM5j6O
i0P+N5i3l+xDSIFR5p9O/sYZJFmo80TpYeQ+T0EJUFyOgEtuGwWWpkmpfMxIJKwG
SWHz1Q6ibCe6px5QN+rge632mUk2Ly8HRypscQkGbaMmi+axwmf0sCSV+s8sg5Dr
7X3wcFSgIIc0DsfBfma8MFKFyGPWlup4FkikGAZINfeyopsHH4nQbEwapJHWu/5O
GPZQr6nD4B3+nX+dolDLUhHyLDiyOtUeVVI6VXA3Shl78rlp/hmwNSjjEbvODa1B
rPAzAkvgwgPnQ8xJwP/5QqpM9X8exQ==
=4UiT
-----END PGP SIGNATURE-----

--Sig_/hQAfhQBStOfl4ZriUuVEQZu--
