Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07DAC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 10:31:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1805D86BF1;
	Fri,  2 Aug 2024 12:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1722594704;
	bh=WMEBsyPqFRVWjyp7YDBhfQBYswz21c1rc246ndzYtdM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HRhfnCv7ySbP4U51rjNiTeDhcBQLNty3j9bQK8wRwsz9JejjPbguasjXbcThalH+P
	 UQz4uBogmNamSY651XhQTjE6m/xz81c++l1n7sJSyWDhHR9jQOWqW2yDfKNiYYiXzC
	 gdbdynpGVjNSeDE2x6ovkkrl5t6xpN9dqLQhdkbSb3YTe9QYdYwle0XwHCS/w30xoR
	 4nLXp5YDPgUaX5aooJsiQyBVH8YfjNSIeqao1uUoyTXxTYSKJ5k4w6Cs3AYlRGoVqT
	 SeFr/fPPGvBHfOlTLioUslk2jNf+X4kfsS+gTM1hlPibWvKFOs8TasNC4h4ZmniTYP
	 CQYYGebYZhEzQ==
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D984C831A1;
 Fri,  2 Aug 2024 12:31:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1722594703;
 bh=WMEBsyPqFRVWjyp7YDBhfQBYswz21c1rc246ndzYtdM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=RkBf3/qe7jALDUgaM6rxzjX1TXGadUsZTAjlxJ6eY7g/MjR3kuufl+EZkhhNRANYW
 VKWCT2JwnNwRQk8/MNMpqPsHURda7+BACIgONIODDanvcjkzxVYPjZCPTv72ajnGew
 00Gdo594dHPssoRP8Viz0TALODkjMq5ijXp2L51SmI9nwsE6j+rN9ad1bIYIYVZCRQ
 24z5cRU/fwwr99Cf68x3R6UR3XZ4HGF5NRzni2aRJKY90fcwRYosaiGpcmOnV4a1lM
 CIpWKGmtBv7W0pUC6oGuSZHq1gYkBDwJ+ZilduAtv1eNAcBZTzfdNUE5iMMwHV7M0O
 TguPejpj/JkOQ==
Date: Fri, 2 Aug 2024 12:31:41 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Teresa Remmet <T.Remmet@phytec.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Cem Tenruh
 <C.Tenruh@phytec.de>, "Martyn Welch" <martyn.welch@collabora.com>, Simon
 Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/2] config: Add 'update_bootimg' command to update
 flash.bin on Phytec's imx8mm
Message-ID: <20240802123141.2133daf4@wsk>
In-Reply-To: <71f5fc5c-296e-40e7-b849-3d860e39184f@phytec.de>
References: <20240801125416.1582652-1-lukma@denx.de>
 <71f5fc5c-296e-40e7-b849-3d860e39184f@phytec.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GPjYPp/v=0LI95GujTuooRC";
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

--Sig_/GPjYPp/v=0LI95GujTuooRC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Benjamin,

> Hi Lukasz,
>=20
> On 01.08.24 14:54, Lukasz Majewski wrote:
> > This command allows easy update on SD card (hence the
> > update_mmc_part=3D1) of the flash.bin generated during u-boot build.
> >
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >   include/configs/phycore_imx8mm.h | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> >
> > diff --git a/include/configs/phycore_imx8mm.h
> > b/include/configs/phycore_imx8mm.h index ce6dc87c69..fdeb11933f
> > 100644 --- a/include/configs/phycore_imx8mm.h
> > +++ b/include/configs/phycore_imx8mm.h
> > @@ -29,6 +29,17 @@
> >   	"mmcdev=3D" __stringify(CONFIG_SYS_MMC_ENV_DEV) "\0" \
> >   	"mmcpart=3D1\0" \
> >   	"mmcroot=3D2\0" \
> > +	"update_mmc_part=3D1\0" \ =20
>=20
> You define the update_mmc_part variable here, but do not use it=20
> anywhere. You use the mmcdev variable later which is good, because
> the function then works not only for SD-Card, but also for eMMC.
>=20
> In the commit description you say it is for updating SD-Card, which=20
> would be mmc dev 1, but the name of the variable would indicate that
> is is for a partition.
> As I understand it you want to update just the U-Boot, which is not=20
> inside any partition, so you would not need this variable.

Yes, for updating u-boot it is not required. I will remove it.

>=20
> > +	"update_offset=3D0x42\0" \
> > +	"update_filename=3Dflash.bin\0" \
> > +	"hostname=3D/tftpboot/lukma/\0" \ =20
> We adivse to use /srv/tftp=C2=A0 as tftp dir in our BSP documentation. But
> I don't think you need that variable at all, because the dhcp command=20
> should find the tftp dir automatically.

I can follow your documentation adn add /srv/tftp

> > +	"update_bootimg=3D"
> > 	\
> > +		"mmc dev ${mmcdev} ; "		\
> > +		"if dhcp ${hostname}/${update_filename} ; then
> > "	\ =20
>=20
> Does this work? For me it does not. As far as I know the syntax of
> this command is "dhcp <loadaddr> <filename>". So I would expect this
> to be: dhcp ${loadaddr} ${update_filename}
>=20

When you don't provide the <loadaddr> the one from ${loadaddr} is used
by default.

However, yes - the latter - i.e. one with ${loadaddr} is more readable
and shall be used.

> > +		"setexpr fw_sz ${filesize} / 0x200 ; "	/*
> > SD block size */ \
> > +		"setexpr fw_sz ${fw_sz} + 1 ; "
> > 		\ =20
> Why do you add one here? Is this important for something?

Yes, it is. The / division is only giving you the value without
reminder. As the filesize can be not aligned to 0x200 you wouldn't
flash the whole binary.

> For me it=20
> works also without the one.

Sometimes it works, sometimes not - it depends if you crop the relevant
part.

> It is also described in our BSP documentation without adding one. See:
> https://phytec.github.io/doc-bsp-yocto/bsp/imx8/imx8mp/mainline-head.html=
#flash-emmc-u-boot-image-via-network-from-running-u-boot=20
>=20

If you are 100% sure that all the time the size of the binary is
aligned to 0x200, then you can omit the 1 as well.

> (This is for our imx8mp mainline release but is the same for imx8mm
> with another offset).
>=20
> Benjamin
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

--Sig_/GPjYPp/v=0LI95GujTuooRC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmastY0ACgkQAR8vZIA0
zr00hQgAp00ckECh3dg9Kka/RjmENT49TU9SiJzw+bYTh0LE/w1DdyBJOnAIBgYj
jFg8WLpQQJrhkRxpTTzSgmYbPRrlsuc/lV3WK5S8J3+CMZSMv4qqpBdNxvYn8bEy
+IiICoMhAr473e9s8K5cXZzhSCTUQ+y5ySRuez1Wz0JktuyPVMYNYR9Qb2OKii/e
4eEv5IC1HqtD4a0tt6QXbmCp/4na4hLO7goPjhrmcvTBBVzhEUdLxn0lcXTJDcaM
hMrPGWBdYwwZhHgCJdcH4O+720dooMC0EGfPaGgvD44FVIGllG6XmJIyCtJI/ES2
QBmLNAcYC8BAhIxohJBsDq8+46/ShA==
=1ilw
-----END PGP SIGNATURE-----

--Sig_/GPjYPp/v=0LI95GujTuooRC--
