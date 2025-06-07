Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17034C61CE8
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 20:27:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33682807B1;
	Sat,  7 Jun 2025 22:27:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="VGcc0NFQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85515811AC; Sat,  7 Jun 2025 22:27:16 +0200 (CEST)
Received: from sonic305-21.consmr.mail.sg3.yahoo.com
 (sonic305-21.consmr.mail.sg3.yahoo.com [106.10.241.84])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA8D38059D
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 22:27:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jjvazha@yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1749328031; bh=CdtdT0AMSJfiWDnehEC982GxNtHtyszwMRvi8HbRl6Y=;
 h=Date:From:To:In-Reply-To:References:Subject:From:Subject:Reply-To;
 b=VGcc0NFQtb9lxtWSHgAs4Vsk7Knd4WmdUry3NWXQ6Ys9qU6L4qQTJz6Gkd0CBbriMBj6CtIz+mlCW3M47ZMI2t/YCJWAO0zBGcOPPGLVQWm7CUZeGdsCCWARDbWpnuLkmGRUHVMwuUE9MKWTIGoVo09Ai+lxGm8gwif4MQAlNwx9bbtfsMEfSXNofSHIGJhitA9Hxm1KeWJcQCIqm4tyxC8ngTADqY+UoupN8hWkI7oLo2Fbhn9J0lw62AXfA9oHqU4/bJTAQ/O9zjwaODsWDMfk6jMC/kuaQdzBk7Abh3CVX/iaDB87vrX1vMit/jXl63PM6sg08DWPvNU02ivF+w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1749328031; bh=sIfOOONUHbOvHTYRGzVG9y2BeCaQo2THgfilfj6epyu=;
 h=X-Sonic-MF:Date:From:To:Subject:From:Subject;
 b=SbpwG24wJJ/334awFnrI31l76CkMUK4+5JflZuEfkOflnQyxcFN91ue8v7plfcCmV8fWdUReXGKq6pxoSuGCR4yTEnpopDtwh3oiKGaJ7i7K2Nk0p83cHlIXIvXRcLPB6ISdL7IuaRcwfQQem/5Th5MlwiVK7uSSWHLJNwrg3491D6P5UUVP9qdD8IypeUBjCIbDJ7RV7NAUDcIDozz9/pjJjOPJnDaxApzrgwLyIqM18fcY5EVo8sXEsv+XpA6P44AJjN/Dk/dCqxK0UIQzKm00IH9PCuo2bitoDrkUT4+NAgXQLH9DknI2g9pmUBpFJBRtm0/7C7uCdgncixZuKQ==
X-YMail-OSG: wfElr7YVM1meY0iIyzfTL.cyY6MHuWhfLypB1lg4zDWcqzFoYKfmK8UDeJRpT6r
 a.n7pnDb18Jszpb_ufsYBEKhV2AOnPx2D9jOwFxhDrQKcaHES8avMWnZXsNuti_zMLxzCVc.qKb5
 9pMk29q3cyGGIV0hWejNLfjG6UxrNsUP8.mjme.5Lecmx3aQahu40veoiij87AAkNrPs1zWAtIR5
 xQ6a_6XwRJs.bDcku3mSa8XdvMyJflr7ahYEs3LUgv3r4oUhCKKG5x3lqlclMsozWnf9TKB5aCPb
 F4jxuJGUxKTyXSXluUCkH4UA2QfKZxJytim4_u6QdwIBAyOZCQB2Eh0Iuu9cVY.zvV.GXeHRbIsd
 1PisA6i_3yP3ygcbsMkOs6oJimnBCsFCrq5jxFgEd8cCpfvXrG08A3l6ljkx6tjg2HhPNSFxdEJe
 o.16JeE.W6QLImJFgmcFwVXvQa799PFRxkyhhQWAyJOfpx4ivY2W2a5Ks9o69qeKKnjaTY3Aj8Q8
 YEa9fIbduw4P7V.0Eg_5ty2UD1fxdGjhIvxLA.fP.NiE6Ua6T0U4L.s9RaTX0EjbuA2kAxEX0jX5
 wnzk1l04y5rPbBJAHy78m0wr21nhd.TRz2vH8y8qaB25_ReWdsHVQqaD4ipeQTrevAmCqGdP5vlz
 JKX7kj6aD3Y.LsER5Clb72gF8dISQvBMG4q05uwbIXB81SK_WiGdFhRWDrYLLbbyYBaE7vC5HCEx
 1PscNfd1xEkaS0DxsGXQB.BkDzNnQTp9zlHcWY2V0sxpuv17p6yw2iSycbYw9Gb6IIFa.zsmT6bA
 ct6B01YfpTW5tEYiMKIn9DeeaW37EYT9xS0mLkEMcZu3VA2pt.w5MGUmd7Elen.hw01oZlwJ8r3c
 Mg5TKUs0IDWL__Cg.dKRI0qVDOCFjy87HSjCikWKcrqhSC0F5o8zWsyT7OGedLA9bMfBkp2iF5Yi
 e.E_z7zcZQqs5gM4ugr4hiANVdbEvDZ3dQISpl8Tw4hDm3HAeGFgMpjQfaq1jHFiutT4pKDwIPhI
 9jcUNcPsXs_FJhIzW.9l501CznYBR1aE7WHn8LiPGHN5x6tcc4zNB96GBeU0pFJUf9e.FZ7merUa
 9n2aNrv_IIw0YI2Hr7w8SKuTCbUktm7H9L7OfIPYC_bSv05hS7stuyEKzGIH5JF2g8Y.7MTfawzS
 LgYSnuV_J7tsb2thcS0YHGRneWPsOJm4XsQQ47Qar46CAIIE0FVAGi_4JuW1c6i8YEVjTFer60Md
 GXA3QRISkWi0yYff5GloPt8ArpVW5VVE1LvMctGpQniq1AHH_.aqzAwIJfd8eKwQzZdEtjX.8b6X
 M4ue.JfhC.QEfSNQP19uLamrjdnwZx95ChclDwL28jt8RzHXvn7P96TU3anDWRZ7gpN9x_KDwKRY
 8Sxkpf96vzS_EWf9308cLY2tyCQwRgEfMPwuhy44dwNV6DnPKQfyZaiBhra7dfV6Ta_1806OAYP.
 cYkCjMZQBu2EZxI3Wx_oX2Wsi4EuFmlMQEs6FxF0_dbOF_MMNQdu9DJU58M9Mm7JelNShDXG8Een
 mhQRe4jkAc5h7GxzTIcah4LIawUkyF7o1AVNxEbzJv6ngqjr3DlIw3IeWN.QqojK9MkxXuik2H_6
 cCByVSMgTj93tNKS7BOgqUQdNAkfREchVEBdHJ419N2DweWQKHvrr0Swt1aF6eedieyWybrm8T2t
 oVmLB5nTnnh4G6gJKqnZDegMH14CIO7GPls2XpD9nPouWKk8XrjWsnynFX2H2LR3RMrguPOiayPj
 CR_rx9ynCnMD6lE.GYgrY9PeY8CwRcRHsBFeAss1pEDHBCkGvfTaqVwP6CWOWnqcc5K8pxYX5WPw
 Xe428hphMdaopc.0GQyX4oKZ0H8zc.NP9bhFQrUh3tvTN9Vob0RL16TfBzemEaX1wjcwQJZu4RPe
 J83WNKWqyqTs.zhTC8CRj5rNlugq3z1z1arlZCkr..O.TuTHQ12A6y3dLq9CtTsiPlnEL.Z0qDQs
 gmUXBiaTSzqpBzFe9oXN3RppsJyE6r0QCPwWLryUibQof.VjhISefYAW_tJady9tAC8bPPXx3Bv4
 gQ1wWoAIQs7QrNI2tpODn6sa7Wxu0fJV1l3FRbv8Kdb7RZLsgG1Khe_zl4tO02N8T5tt8l6kg5jp
 _2p6ruXE96zWxhBebzkCEFwjTdWInQ9TQ1km4mWw.Idtm3x.ules8mOfsPSUOx545O1lx3jt_PWL
 57ln6d1uPE68JRjxLzn68WNDaN7uC1goMwnm6Ve.vacfTLH.W9kHN8v1NeSoEayU7xDM36LDMs4m
 hXEbIUQ--
X-Sonic-MF: <jjvazha@yahoo.com>
X-Sonic-ID: 41cd1e2b-9d7f-4507-b7cc-2670e27c1fc5
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic305.consmr.mail.sg3.yahoo.com with HTTP; Sat, 7 Jun 2025 20:27:11 +0000
Date: Sat, 7 Jun 2025 20:27:09 +0000 (UTC)
From: Jojan <jjvazha@yahoo.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 Jonas Kvinge <jonaski@opensuse.org>
Message-ID: <1287835630.661385.1749328029886@mail.yahoo.com>
In-Reply-To: <3b7988777abfb62a51cd2afa92764dfcb9f4a134.camel@opensuse.org>
References: <294e9037fe8b9502b41a06e9ac9363f2d5204b07.camel@opensuse.org>
 <851157797.299472.1749160367219@mail.yahoo.com>
 <da35020455a4a086617a0588ba913b5ad3d2dcd9.camel@opensuse.org>
 <1801521580.655864.1749318986908@mail.yahoo.com>
 <3b7988777abfb62a51cd2afa92764dfcb9f4a134.camel@opensuse.org>
Subject: Re: Raspberry Pi Compute Module 5 support
MIME-Version: 1.0
X-Mailer: WebService/1.1.23956 YMailNorrin
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

 Sorry I mean 2712Raspebrry -P 4 , that the U-boot support as of now includ=
es , bcm2711.dtsi
bcm2711-rpi-4-b.dts:#include "bcm2711.dtsi"

However RPi-5 uses broadcom 2712 chips.These dts files are not available in=
 u-boot.Howver you can get it from other places and modify / inroduce in yo=
ur device tree source and configure correctly.


    On Saturday, June 7, 2025 at 11:19:28 AM PDT, Jonas Kvinge <jonaski@ope=
nsuse.org> wrote: =20
=20
 I've never heard of=C2=A0bcm7712, it's not
on=C2=A0https://github.com/raspberrypi/firmware/tree/master/boot
Or do you mean bcm2712?

I managed to get u-boot v2025.04 to load=C2=A0 by setting boot delay to -2,
same issue as described here:
https://lists.denx.de/pipermail/u-boot/2024-December/576043.html

What are the changes does the custodian version have that are needed?
It seems like it's not up to date with the new version u-boot.

Jonas

On Sat, 2025-06-07 at 17:56 +0000, Jojan wrote:
>=20
> =C2=A0
> Master is ok. But it won=E2=80=99t work as is. You need to have rpi5
> configuration and the dts files. I did it a year back. But since =C2=A0di=
d
> not have bcm7712 dts files, I took the dtb file from the raspberry pi
> images ( it has a pre built dtb file, and extracted dts)
>=20
> dtc -I dtb -O dts -o <output.dts> -i< input.dtb>
>=20
> =C2=A0
> =C2=A0
> =C2=A0
> =C2=A0On Saturday, June 7, 2025 at 03:26:31 AM PDT, Jonas Kvinge
> <jonaski@opensuse.org> wrote:=20
> =C2=A0
>=20
> =C2=A0
>=20
> =C2=A0
> Which branch? The master branch is 1 year old.
>=20
> On Thu, 2025-06-05 at 21:52 +0000, Jojan wrote:
> >=20
> > You need to take raspberry=C2=A0 ( custodian version)
> >=20
> >=20
> > Making sure you're not a bot!
> >=20
> > Making sure you're not a bot!
> >=20
> >=20
> >=20
> > =C2=A0
> > But it is still missing the device tree fro bcm7712 ( RPI 5 is
> > bcm7712)
> > But you can Dow load the dtb file from the pre built dtb file from
> > raspberry pi images
> >=20
> > and=C2=A0 use those=C2=A0 device tree sources ( using a dtc )
> >=20
> >=20
> >=20
> > =C2=A0
> > =C2=A0
> > =C2=A0
> > =C2=A0On Thursday, June 5, 2025 at 02:13:24 PM PDT, Jonas Kvinge
> > <jonaski@opensuse.org> wrote:=20
> > =C2=A0
> >=20
> > =C2=A0
> >=20
> > =C2=A0
> > Hi,
> > I'm trying to boot openSUSE Linux on an CM5 using a sourcekit io
> > board
> > (https://sourcekit.cc/#/).
> > u-boot seem to be stuck with the logo on the upper right corner, no
> > text.
> > I re-built u-boot using the latest source from git from the next
> > branch
> > and also set CONFIG_LOG in make menuconfig, but still no text.
> >=20
> > Is the CM5 supported by u-boot?
> >=20
> > Jonas
> > =C2=A0
> > =C2=A0
>=20
> =C2=A0
> =C2=A0
 =20
