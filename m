Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF331C4725D
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 12:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C183879F4;
	Fri, 12 Jan 2024 13:58:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="gw61Aiz3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4567879F5; Fri, 12 Jan 2024 13:58:21 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C3FA8309D
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 13:58:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sjoerd@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1705064298;
 bh=6Z70P6gFOicMquqvt1tjy7fdbZr4uIMPT4bRSK4vF4I=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=gw61Aiz3lZVfAFre4qdY91dTz/BF90KWuOEj7t1ZntmSovj124BWxARt+UT5urzS3
 cICOmkj8aEuQLPd7RISN1Xct4+qBGOyo41LtAKTGLsjQTVkUk9uVTfIAzJfvrcwb7x
 uDp8Dae7jtEwlafAEes/1mp6YoRTTgpkh0E8VoinevSvTxJcZW4eTVZMl1eohkHjDT
 WOsjCALO1diL0qiGBMd2tsv1SUusuI16Hzo/ciHVd0iGwwZg+MKaj0y770FhUiVnmK
 mGruOBysLptiYfhSNmWVAd6988BaFIv8AiTmPIOOd/CU3qMee8iHv4tEf2VlpouPLi
 X3Hu6KZdxUR0w==
Received: from beast.luon.net (cola.collaboradmins.com
 [IPv6:2a01:4f8:1c1c:5717::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: sjoerd)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id A514A37811D1;
 Fri, 12 Jan 2024 12:58:18 +0000 (UTC)
Received: by beast.luon.net (Postfix, from userid 1000)
 id 3FCB59F0867A; Fri, 12 Jan 2024 13:58:18 +0100 (CET)
Message-ID: <5ee4497041ca512a11daa4323ec2d36ade06128d.camel@collabora.com>
Subject: Re: [PATCH v4 7/7] doc: board: Add document for DFU boot on am62x SoCs
From: Sjoerd Simons <sjoerd@collabora.com>
To: Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Martyn Welch <martyn.welch@collabora.com>, Roger
 Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>,  Judith Mendez <jm@ti.com>, Marcel
 Ziswiler <marcel.ziswiler@toradex.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Neha Malcom Francis <n-francis@ti.com>, Nikhil
 M Jain <n-jain1@ti.com>, Robert Nelson <robertcnelson@gmail.com>
Date: Fri, 12 Jan 2024 13:58:18 +0100
In-Reply-To: <20240112123636.2h44vbdffrjlik5g@kindling>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
 <20240112085317.1866449-8-sjoerd@collabora.com>
 <20240112123636.2h44vbdffrjlik5g@kindling>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2-1 
MIME-Version: 1.0
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

On Fri, 2024-01-12 at 06:36 -0600, Nishanth Menon wrote:
> On 09:52-20240112, Sjoerd Simons wrote:
> >=20
> > +DFU based boot
> > +--------------
> > +
> > +To boot the board over DFU, ensure there is no SD card inserted
> > with a
> > +bootloader. Hold the USR switch while plugging into the Type C to
> > boot into DFU
> > +mode. After power-on the build artifacts needs to be uploaded one
> > by one with a
> > +tool like dfu-util.
>=20
> Don't we also need a wiped out emmc unfortunately?

Nope just not having an SD card without boot artifacts is enough (or to
keep things simple no SD card). the USR switch changes the bootmode to
have SD as primary, DFU as fallback, so what's on the eMMC is luckily
not relevant.

So i've been happily testing with the factory eMMC image untouched to
allow me to compare against the factory u-boot behaviour=20

>=20
> > +
> > +.. include::=C2=A0 ../ti/am62x_sk.rst
> > +=C2=A0=C2=A0=C2=A0 :start-after: .. am62x_evm_rst_include_start_dfu_bo=
ot
> > +=C2=A0=C2=A0=C2=A0 :end-before: .. am62x_evm_rst_include_end_dfu_boot
> > +
> > =C2=A0Debugging U-Boot
> > =C2=A0----------------
> > =C2=A0
> > diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
> > index b12dc85f06b..904a54cd5ff 100644
> > --- a/doc/board/ti/am62x_sk.rst
> > +++ b/doc/board/ti/am62x_sk.rst
> > @@ -105,6 +105,20 @@ Set the variables corresponding to this
> > platform:
> > =C2=A0
> > =C2=A0* 3.1 R5:
> > =C2=A0
> > +.. include::=C2=A0 ../ti/k3.rst
> > +=C2=A0=C2=A0=C2=A0 :start-after: .. k3_rst_include_start_build_steps_s=
pl_r5
> > +=C2=A0=C2=A0=C2=A0 :end-before: .. k3_rst_include_end_build_steps_spl_=
r5
> > +
> > +* 3.1.1 Alternatively build R5 for DFU boot:
> > +
> > +As the SPL size can get to big when building with support for
> > booting both from
> > +local storage *and* DFU an extra config fragment should be used to
> > enable DFU
> > +support (and disable storage support)
> > +
> > +.. prompt:: bash $
> > +
> > +=C2=A0 export UBOOT_CFG_CORTEXR=3D${UBOOT_CFG_CORTEXR}
> > am62x_r5_usbdfu.config
> > +
> > =C2=A0.. include::=C2=A0 ../ti/k3.rst
> > =C2=A0=C2=A0=C2=A0=C2=A0 :start-after: .. k3_rst_include_start_build_st=
eps_spl_r5
> > =C2=A0=C2=A0=C2=A0=C2=A0 :end-before: .. k3_rst_include_end_build_steps=
_spl_r5
> > @@ -251,6 +265,29 @@ https://www.ti.com/lit/pdf/spruiv7=C2=A0under the
> > `Boot Mode Pins` section.
> > =C2=A0
> > =C2=A0For SW2 and SW1, the switch state in the "ON" position =3D 1.
> > =C2=A0
> > +DFU based boot
> > +--------------
> > +
> > +To boot the board over DFU, set the switches to DFU mode and
> > connect to the
> > +USB Type C DRD Port on the board. After power-on the build
> > artifacts needs to be
> > +uploaded one by one with a tool like dfu-util.
> > +
> > +.. am62x_evm_rst_include_start_dfu_boot
> > +
> > +The initial ROM will have a DFU alt named `bootloader` for the
> > initial R5 spl
> > +upload. The next stages as exposed by u-boot have target alts
> > matching the name
> > +of the artifacts, for these a USB reset has to be done after each
> > upload.
> > +
> > +When using dfu-util the following commands can be used to boot to
> > a u-boot shell:
> > +
> > +.. prompt:: bash $
> > +
> > +=C2=A0 dfu-util -a bootloader -D tiboot3.bin
> > +=C2=A0 dfu-util -R -a tispl -D tispl.bin
> > +=C2=A0 dfu-util -R -a u-boot.img -D u-boot.img
> > +
> > +.. am62x_evm_rst_include_end_dfu_boot
> > +
> > =C2=A0Debugging U-Boot
> > =C2=A0----------------
> > =C2=A0
> > --=20
> > 2.43.0
> >=20
>=20

--=20
Sjoerd Simons
Collabora Ltd.
