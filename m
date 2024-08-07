Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924DAC3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 11:04:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCB3288B81;
	Wed,  7 Aug 2024 13:04:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723028665;
	bh=nWnLflveHdoOlHp4m3k50erl1qOzlEt6LEf9Du1LSkg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FQct2YzPTkNHRTMmqRSc5cafzEn3tQZjskOp8yezitSqQKEk/3Zz4n0V1WOO481g1
	 OcDJOKZ+FY1Ni9atUTUG4ytNBHT+9oxgNcG75JEl6wuNkMh7AX71ieR695snXXv+BF
	 +4qIGdpZcSVT/IeenfiF87qnaFvPjM5I2NZs+/ZHz64OpgSdgqeNARtRegsqidZ3ni
	 uoVCFFaOscfQ3H7pT3mlRZktt21xaYzCjji62E1opbEJBW+ugfDhvw00Yie5cUAtMP
	 6AE0tov5eJ/xceiUgUzCW4kv77AeLsHe6w00Z+Ib4nSSEXVePHSE4B3sPa4HzXP2jv
	 CuODC5eakqOcg==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 949C188B87;
 Wed,  7 Aug 2024 13:04:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723028665;
 bh=nWnLflveHdoOlHp4m3k50erl1qOzlEt6LEf9Du1LSkg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=yF4/A6sZiLByQ4JOlhDUgRkw3m1nl2bEuQ858ZgJTCxrgrV4sQ10/BBVbBoVTo/0q
 wXNxbt38EyRMuDTFC6LUbEE63tuSDmlz3lsEMZUdkAGWKFedjphR/IQYHx4lBzUbsF
 rE86OeSoSMmzISEfp4Cqf8XsSvoVPomQajGBCvYLK5glJdAlVDm1OQpfNtm2zCcg2r
 4erI0q/VWAtrKI+XeSLdek9fvboazdIFvsnqdGSuORYp4T7mc9mYXJv1m9Uh6E8vBz
 Ws6yz/izTyeCA4pBEBPh1ziwMJSRz0OvgtNuec7td1DrCdhPruoPEC1SyfV4Zrm8N0
 wjh9UUGTFT3Pw==
Date: Wed, 7 Aug 2024 13:04:23 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Teresa Remmet <T.Remmet@phytec.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Cem Tenruh
 <C.Tenruh@phytec.de>, "Martyn Welch" <martyn.welch@collabora.com>, Simon
 Glass <sjg@chromium.org>, "Fabio Estevam" <festevam@gmail.com>
Subject: Re: [PATCH v3] config: Add 'update_bootimg' command to update
 flash.bin on Phytec's imx8mm
Message-ID: <20240807130423.601a1e47@wsk>
In-Reply-To: <dd54f3f8-7d80-4d0c-9eaa-639e45ddfdcf@phytec.de>
References: <20240806081131.4065425-1-lukma@denx.de>
 <dd54f3f8-7d80-4d0c-9eaa-639e45ddfdcf@phytec.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VUoKrMy_bBBoWPugg.GBypq";
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

--Sig_/VUoKrMy_bBBoWPugg.GBypq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Benjamin,

> Hi Lukasz,
>=20
> On 06.08.24 10:11, Lukasz Majewski wrote:
> > This command allows easy update on SD card or eMMC of the flash.bin
> > generated (with binman) during u-boot build.
> >
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> > Changes for v2:
> > - Remove 'update_mmc_part' variable
> > - Change path for hostname
> > - Use full version of dhcp command (${loadaddr} added)
> >
> > Changes for v3:
> > - Remove +1 when calculating the size of binary to be written
> > ---
> >   include/configs/phycore_imx8mm.h | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> >
> > diff --git a/include/configs/phycore_imx8mm.h
> > b/include/configs/phycore_imx8mm.h index ce6dc87c69..361e665676
> > 100644 --- a/include/configs/phycore_imx8mm.h
> > +++ b/include/configs/phycore_imx8mm.h
> > @@ -29,6 +29,16 @@
> >   	"mmcdev=3D" __stringify(CONFIG_SYS_MMC_ENV_DEV) "\0" \
> >   	"mmcpart=3D1\0" \
> >   	"mmcroot=3D2\0" \
> > +	"update_offset=3D0x42\0" \
> > +	"update_filename=3Dflash.bin\0" \
> > +	"hostname=3D/srv/tftp/\0" \
> > +	"update_bootimg=3D"
> > 	\
> > +		"mmc dev ${mmcdev} ; "		\
> > +		"if dhcp ${loadaddr}
> > ${hostname}/${update_filename} ; then "	\ =20
>=20
> The dhcp and tftp command should take the filepath from the tftp=20
> directory and get the tftp directory automatically not the absolute
> path. So this will try to get the file from=20
> /path_to_tftp_folder/srv/tftp/flash.bin and will fail

And that is why you do have the ${hostname}/${update_filename}, so when
you have several exported directories - you can specify which one
without the need to modify the 'update_bootimg' command.

> because it
> can't find it. So you can drop the ${hostname}.

I would prefer to keep the ${hostname}/${update_filename} part.

> Also drop the initialization of ${hostname} above since it is no
> longer needed.
>=20
> Should be like this:
>=20
> dhcp ${loadaddr} ${update_filename}
>=20

IMHO the line shall be:

dhcp ${loadaddr} ${hostname}/${update_filename}

> > +		"setexpr fw_sz ${filesize} / 0x200 ; "	/*
> > SD block size */ \
> > +		"setexpr fw_sz ${fw_sz} ; " =20
> I think you can drop this line since it does not do anything.
>=20

Ok.

> Benjamin
> > 				\
> > +		"mmc write ${loadaddr} ${update_offset} ${fw_sz} ;
> > "	\
> > +		"fi\0" \
> >   	"mmcautodetect=3Dyes\0" \
> >   	"mmcargs=3Dsetenv bootargs console=3D${console} " \
> >   		"root=3D/dev/mmcblk${mmcdev}p${mmcroot} rootwait
> > rw\0" \ =20
>=20
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/VUoKrMy_bBBoWPugg.GBypq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmazVLcACgkQAR8vZIA0
zr3xkAf/Ym1Issqs8Zc8S/JJJLakf5U3ykQwKHgIm6+s2g1OujL5Eggts0Pg7+2D
p/eohWglxOE7OhiQWg/unobCfFwVcL6rcpELJ5I1kAfGharobbYt9htQElD6IKJJ
E2T9A4Jb5uAFkSk5Sj84b3XkNZdrobTauapJ/XYpU4pl0Dg7a8nojh/MJHhp3RXq
JRxc/JZlT2m/8qlEp4Pl13SCaz0yeY1t8uGk4Q+M9AdEiFmHSqpyIzJNG0bA5gyg
wIgN++FrGSMhzSL1kF82FfNeDuzpoADXmW4EIBfJ5GIDzrNKHmTWHVQWRTQW1MnJ
jGcS5U0Na9nXjN6sLLJkajaIAjNGCg==
=zjaZ
-----END PGP SIGNATURE-----

--Sig_/VUoKrMy_bBBoWPugg.GBypq--
