Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C66F8A145
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 09:13:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 541828407E;
	Thu, 16 Apr 2026 11:13:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="DnI8i+Hb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC3D9840AB; Thu, 16 Apr 2026 11:13:18 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6176B83FC0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 11:13:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id E8C164E42A1B;
 Thu, 16 Apr 2026 09:13:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id BEA145FDEB;
 Thu, 16 Apr 2026 09:13:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7B2EE1045A134; 
 Thu, 16 Apr 2026 11:13:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776330794; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Hr/6bwfdm7JG9SG1kqDYIgQzp6wx33C0sXuR0s9EFgU=;
 b=DnI8i+HbECc4V+xAZFD0a6ap6aQVQ/5wpTeeibPP00rTWQylWqRhVB+db0YDRbA0vr6o80
 BCEeY/itl9sw8CGBRfrzipmw0jUU4m/9ZnZKNAk7QyZSU17YHiiKkIZikMlV2M4QZ5JQu/
 /Pkmx0yFd30yp5OpQ8Ol7x8GQpz5XfJEm7MTZIZ4KQsOHNU3dZwxsVwb9oIGD7dzOkPHQM
 O4/VewUw9w7XWLUdp1xSSVqGowzD5wnk5LD7Ng/LDtO6q/tvaZx1fdpkY6vv3P2anHprtL
 L3/ZOoHGyZvydjsFQ3ljZ1MXiYBL58oR85of2xE9PhfW1aMU9syxFnqserLGMQ==
Date: Thu, 16 Apr 2026 11:13:02 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Cc: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>, Tom Rini
 <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Parvathi Pudi <parvathi@couthit.com>,
 Basharath Hussain Khaja <basharath@couthit.com>, Paul Barker
 <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, Simon Glass
 <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Tien
 Fong Chee <tien.fong.chee@altera.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Johan Jonker <jbx6244@gmail.com>, Brian Sune
 <briansune@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>, Bernhard
 Messerklinger <bernhard.messerklinger@at.abb.com>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>, Parth Pancholi
 <parth.pancholi@toradex.com>, Jonas =?UTF-8?B?U2Nod8O2YmVs?=
 <jonasschwoebel@yahoo.de>, Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH v6 00/14] arm: am335x: Switch to upstream devicetree
Message-ID: <20260416111302.45a7e1fb@kmaincent-XPS-13-7390>
In-Reply-To: <20260416110631.6f89a2e9@kmaincent-XPS-13-7390>
References: <20260415-topic-am33-evm-oftree-v2026-01-v6-0-94cde349bb01@baylibre.com>
 <20260416110631.6f89a2e9@kmaincent-XPS-13-7390>
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

On Thu, 16 Apr 2026 11:06:49 +0200
Kory Maincent <kory.maincent@bootlin.com> wrote:

> On Wed, 15 Apr 2026 18:02:21 +0200
> "Markus Schneider-Pargmann (TI)" <msp@baylibre.com> wrote:
>=20
> > The series is split into two logical groups:
> >=20
> > - Patches 1-3: Fixes for am335x-evm to boot and support the LCD panel
> >   with the current u-boot devicetree.
> > - Patches 4-14: Make upstream devicetree working with uboot. This
> >   adds tick-timer, adds compatibility of the board code for different
> >   USB probing, makes SPL smaller and updates the defconfig.
> >=20
> > The series has been tested on am335x-evm. Note that I don't have all
> > other boards built with the am335x_*evm_*defconfig, so tests are
> > appreciated. buildman reports builds are working. =20
>=20
> Your patch series breaks the scan of extension boards (cape).
> =3D> extension scan =20
> Found 0 extension board(s).
>=20
> While I should have:
> =3D> extension scan =20
> BeagleBone Cape: Beaglebone green hdmi cape (0x57)
> Found 1 extension board(s).
> =3D> extension list =20
> Extension 0: Beaglebone green hdmi cape
> 	Manufacturer: 		Seeed
> 	Version: 		00A0
> 	Devicetree overlay: 	BB-GREEN-HDMI-00A0.dtbo
> 	Other information: =09

After I bisect, I have located the breakage on patch 13.=20

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
