Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71385CCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 17:09:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD08882E34;
	Mon, 20 Oct 2025 19:09:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Rq4seygo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35F47831D5; Mon, 20 Oct 2025 19:09:18 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FA3E82C84
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 19:09:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id CC7831A154B;
 Mon, 20 Oct 2025 17:09:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 86673606D5;
 Mon, 20 Oct 2025 17:09:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 04BA6102F237C; 
 Mon, 20 Oct 2025 19:08:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760980149; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=kk3hGrMBqdjAPhhjq5FhoWG6+QnQ1uMySslMGwfTDJA=;
 b=Rq4seygoav3JCHNJtLunw5a2DJhaDgnA03pWblT4jTIVugsdXqQO+kWCkMLFsMTpeR71z2
 UXQuVxfEYGPqSuJjJFy6xtMETvpEezOgT0PWPstMkjZSWn4XUERFAfwlrKj1YnZmbP3hZ2
 bKWFF94A8Wu7m+voy7DK4koaQ9d4oqSteItZZ5SI1aIphcLTyH2hYLfmdB0g7uBD4Gwq8a
 EC/LIDyBBVStd5DJ+F4pPav5iq2cb/PXPG4X3+JRsHvIo9+ZhTBVUc7ab6VcW6v/ZjA4mY
 4QnBiu09LDGKy3+ElJQazgVkip+6xMtIrmBA8C1k781FQItSmkMXH4gabj4yDw==
Date: Mon, 20 Oct 2025 19:08:54 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Hans de Goede
 <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>, Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot
 Team" <uboot-imx@nxp.com>, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH v3 00/20] Convert extension support to UCLASS and adds
 its support to boot flows
Message-ID: <20251020190854.4b318829@kmaincent-XPS-13-7390>
In-Reply-To: <20251020160527.GY6688@bill-the-cat>
References: <20251013-feature_sysboot_extension_board-v3-0-04067b7422a5@bootlin.com>
 <CAFLszThGVL1powrtDa+niBuxU-b_3YDs6TQ96igx-cj-PGvf=g@mail.gmail.com>
 <20251019162234.GQ6688@bill-the-cat>
 <20251020115009.532a1a99@kmaincent-XPS-13-7390>
 <20251020141548.GS6688@bill-the-cat>
 <20251020143729.GW6688@bill-the-cat>
 <20251020171613.76ffddac@kmaincent-XPS-13-7390>
 <20251020160527.GY6688@bill-the-cat>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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

On Mon, 20 Oct 2025 10:05:27 -0600
Tom Rini <trini@konsulko.com> wrote:

> On Mon, Oct 20, 2025 at 05:23:45PM +0200, Kory Maincent wrote:
> > On Mon, 20 Oct 2025 08:37:29 -0600
> > Tom Rini <trini@konsulko.com> wrote:
> >  =20
> > > On Mon, Oct 20, 2025 at 08:15:48AM -0600, Tom Rini wrote: =20
> > > > On Mon, Oct 20, 2025 at 11:50:09AM +0200, Kory Maincent wrote:   =20
> > > > > On Sun, 19 Oct 2025 10:48:37 -0600
> > > > > Tom Rini <trini@konsulko.com> wrote:
> > > > >    =20
> > > > > > On Sun, Oct 19, 2025 at 02:05:51PM +0100, Simon Glass wrote:   =
=20
> > > > > > > Hi Kory,
> > > > > > >=20
> > > > > > > On Mon, 13 Oct 2025 at 14:32, Kory Maincent (TI.com)
> > > > > > > <kory.maincent@bootlin.com> wrote:     =20
> > > > > > > >
> > > > > > > > This series converts the extension board framework to use
> > > > > > > > UCLASS as requested by Simon Glass, then adds extension sup=
port
> > > > > > > > to pxe_utils and bootmeth_efi (not tested) to enable extens=
ion
> > > > > > > > boards devicetree load in the standard boot process.
> > > > > > > >
> > > > > > > > I can't test the imx8 extension scan enabled by the
> > > > > > > > imx8mm-cl-iot-gate_defconfig as I don't have this board.
> > > > > > > > I also can't test the efi bootmeth change as I don't have s=
uch
> > > > > > > > board.     =20
> > > > > > >=20
> > > > > > > You can test this with sandbox, using one of the bootmeth tes=
ts,
> > > > > > > perhaps. Let me know if you need help with this.     =20
> > > > > >=20
> > > > > > But the question is, does the real hardware platform work
> > > > > > before/after this, not does the sandbox test still work
> > > > > > before/after this.   =20
> > > > >=20
> > > > > It seems the bootlflow scan is not working on the sandbox on next
> > > > > branch. Is this issue known?   =20
> > > >=20
> > > > Is it fine on master? The next branch will be out of date until it
> > > > re-opens with -rc2 being released (2 weeks from today).   =20
> > >=20
> > > ... out of sync local calendar, 3 weeks from today, not 2. =20
> >=20
> > bootstd test suit is not working on master with the sandbox_defconfig:
> > https://termbin.com/un0p
> >=20
> > Noticeable things are;
> > test/boot/bootdev.c:160, bootdev_test_any(): 0 =3D=3D bootdev_find_by_a=
ny(seq,
> > &dev, &mflags): Expected 0x0 (0), got 0xffffffed (-19) Test:
> > bootdev_test_any: bootdev.c (flat tree) test/boot/bootdev.c:160,
> > bootdev_test_any(): 0 =3D=3D bootdev_find_by_any(seq, &dev, &mflags): E=
xpected
> > 0x0 (0), got 0xffffffed (-19) Test 'bootdev_test_any' failed 2 times
> >=20
> > And a nice segfault:
> > Test: bootflow_set_arg: bootflow.c
> > Test: bootflow_system: bootflow.c
> > [3]    569337 segmentation fault (core dumped)  ./u-boot
> >=20
> > Maybe things are missing to run sandbox_defconfig on my computer?
> > With the sandbox64_defconfig there is not core dump anymore but there is
> > still the failed line:
> > Test 'bootdev_test_bootable' failed 2 times
> >=20
> > And the uboot is reboot infinitely during the bootflow test:
> > ./u-boot -T -c "ut bootstd"
> > https://termbin.com/alu5 =20
>=20
> I see the same thing you do when running them outside of pytest, but
> they're also fine within pytest.
> https://docs.u-boot.org/en/latest/develop/pytest/usage.html should help
> get you started, and you can just run all of the ut tests under that.

Weird I got errors also within pytest.
See the html test log attached generated by the following command:
./test/py/test.py --bd sandbox -k bootstd

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
