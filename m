Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4924FCCD193
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 15:23:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE1DD82C84;
	Mon, 20 Oct 2025 17:23:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="pfVY34qd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46C9A82E34; Mon, 20 Oct 2025 17:23:56 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9FDC807B1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 17:23:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 8BA0DC0AFDC;
 Mon, 20 Oct 2025 15:23:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 1F129606D5;
 Mon, 20 Oct 2025 15:23:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 94BF2102F23C5; 
 Mon, 20 Oct 2025 17:23:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760973832; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=AeIKYDcYaeASmVmhpGQZOUy75z/ooc7ZRLOPbDKW3BU=;
 b=pfVY34qdJ5KHQL/vAVKAd2B/cyjGCwvJ4uSO+P+9QMknbibilbnhWQ1mp1M66iFSGNa74y
 YM0sGlQSQB8lzyli9vavsu4Au29Zoc3OKm8Dtu90hqupaSQJ97NM154lOkgGl/AMGazNBU
 S9NVtuFF9UNE9WeKjUI/v193B06mjbMEQ2BSiMTQNBZochgjyx9LVVJ1Nx3jVyC2LnpCTm
 UqRb98osyxFXTzMzQ5JrlACiyxW7XIebAblss5Ey0a4FJ+YNgX7xMWpTCtJ6yCy/4GLPKH
 LKdk20F2VeT1QOBFWKWS8z0KUGODnzrnpNiZ3QljR8Bp0k2BR0ouF01c6yuXGw==
Date: Mon, 20 Oct 2025 17:23:45 +0200
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
Message-ID: <20251020171613.76ffddac@kmaincent-XPS-13-7390>
In-Reply-To: <20251020143729.GW6688@bill-the-cat>
References: <20251013-feature_sysboot_extension_board-v3-0-04067b7422a5@bootlin.com>
 <CAFLszThGVL1powrtDa+niBuxU-b_3YDs6TQ96igx-cj-PGvf=g@mail.gmail.com>
 <20251019162234.GQ6688@bill-the-cat>
 <20251020115009.532a1a99@kmaincent-XPS-13-7390>
 <20251020141548.GS6688@bill-the-cat>
 <20251020143729.GW6688@bill-the-cat>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
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

On Mon, 20 Oct 2025 08:37:29 -0600
Tom Rini <trini@konsulko.com> wrote:

> On Mon, Oct 20, 2025 at 08:15:48AM -0600, Tom Rini wrote:
> > On Mon, Oct 20, 2025 at 11:50:09AM +0200, Kory Maincent wrote: =20
> > > On Sun, 19 Oct 2025 10:48:37 -0600
> > > Tom Rini <trini@konsulko.com> wrote:
> > >  =20
> > > > On Sun, Oct 19, 2025 at 02:05:51PM +0100, Simon Glass wrote: =20
> > > > > Hi Kory,
> > > > >=20
> > > > > On Mon, 13 Oct 2025 at 14:32, Kory Maincent (TI.com)
> > > > > <kory.maincent@bootlin.com> wrote:   =20
> > > > > >
> > > > > > This series converts the extension board framework to use UCLAS=
S as
> > > > > > requested by Simon Glass, then adds extension support to pxe_ut=
ils
> > > > > > and bootmeth_efi (not tested) to enable extension boards device=
tree
> > > > > > load in the standard boot process.
> > > > > >
> > > > > > I can't test the imx8 extension scan enabled by the
> > > > > > imx8mm-cl-iot-gate_defconfig as I don't have this board.
> > > > > > I also can't test the efi bootmeth change as I don't have such
> > > > > > board.   =20
> > > > >=20
> > > > > You can test this with sandbox, using one of the bootmeth tests,
> > > > > perhaps. Let me know if you need help with this.   =20
> > > >=20
> > > > But the question is, does the real hardware platform work before/af=
ter
> > > > this, not does the sandbox test still work before/after this. =20
> > >=20
> > > It seems the bootlflow scan is not working on the sandbox on next bra=
nch.
> > > Is this issue known? =20
> >=20
> > Is it fine on master? The next branch will be out of date until it
> > re-opens with -rc2 being released (2 weeks from today). =20
>=20
> ... out of sync local calendar, 3 weeks from today, not 2.

bootstd test suit is not working on master with the sandbox_defconfig:
https://termbin.com/un0p

Noticeable things are;
test/boot/bootdev.c:160, bootdev_test_any(): 0 =3D=3D bootdev_find_by_any(s=
eq, &dev, &mflags): Expected 0x0 (0), got 0xffffffed (-19)
Test: bootdev_test_any: bootdev.c (flat tree)
test/boot/bootdev.c:160, bootdev_test_any(): 0 =3D=3D bootdev_find_by_any(s=
eq, &dev, &mflags): Expected 0x0 (0), got 0xffffffed (-19)
Test 'bootdev_test_any' failed 2 times

And a nice segfault:
Test: bootflow_set_arg: bootflow.c
Test: bootflow_system: bootflow.c
[3]    569337 segmentation fault (core dumped)  ./u-boot

Maybe things are missing to run sandbox_defconfig on my computer?
With the sandbox64_defconfig there is not core dump anymore but there is st=
ill
the failed line:
Test 'bootdev_test_bootable' failed 2 times

And the uboot is reboot infinitely during the bootflow test:
./u-boot -T -c "ut bootstd"
https://termbin.com/alu5

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
