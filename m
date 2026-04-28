Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09207FF886C
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 08:43:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E08884255;
	Tue, 28 Apr 2026 10:43:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="b5WBs4Rc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E5E4842C7; Tue, 28 Apr 2026 10:43:06 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4507583693
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 10:43:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 69F79C5CD52;
 Tue, 28 Apr 2026 08:43:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D6127601D0;
 Tue, 28 Apr 2026 08:43:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AE9BE10728563; 
 Tue, 28 Apr 2026 10:42:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777365780; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=jNknIGGN3FvXWUMVpEK1hvdz6Tq5Ntxrt/d3X4qqdb8=;
 b=b5WBs4Rcg1G5cgtZSZoYfhlC1MolD2BB8nlYKwhCJhLOHipFzrd50/lDRTigTKU25MWaVa
 9peatDxnZVNQEHAYglAXwWX8uFqGuOegHCNMoK4SVoG4nNEIGkwpWY1ytjyg8OU2PkssmH
 qeuvBKv5sV8WQ8Q4sdGYIV4jZVHwsHDMixhXuir7m7RzbdJVbM8StWXdR6ReZ8VRDdX42w
 DBNZmOUQxWynhnSdwW6Q6m9/hgVQeHHOdofevMfx6PkGOt5FWa9jdmWIT7TJTU245E3vp3
 Trtfqxbl6ArZiUtj2VtTlk1PpbxxPOxovdqZjdc/yGSwaqz2KcU8KaFk2E1Rzg==
Date: Tue, 28 Apr 2026 10:42:52 +0200
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
 <jonasschwoebel@yahoo.de>, Paul Kocialkowski <contact@paulk.fr>, Andre
 Przywara <andre.przywara@arm.com>, Paresh Bhagat <p-bhagat@ti.com>, Ion
 Agorria <ion@agorria.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v7 00/14] arm: am335x: Switch to upstream devicetree
Message-ID: <20260428104252.6aebf748@kmaincent-XPS-13-7390>
In-Reply-To: <20260427-topic-am33-evm-oftree-v2026-01-v7-0-7e6cd1a805a1@baylibre.com>
References: <20260427-topic-am33-evm-oftree-v2026-01-v7-0-7e6cd1a805a1@baylibre.com>
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

On Mon, 27 Apr 2026 11:01:16 +0200
"Markus Schneider-Pargmann (TI)" <msp@baylibre.com> wrote:

> The series is split into two logical groups:
>=20
> - Patches 1-3: Fixes for am335x-evm to boot and support the LCD panel
>   with the current u-boot devicetree.
> - Patches 4-14: Make upstream devicetree working with uboot. This
>   adds tick-timer, adds compatibility of the board code for different
>   USB probing, makes SPL smaller and updates the defconfig.
>=20
> The series has been tested on am335x-evm. Note that I don't have all
> other boards built with the am335x_*evm_*defconfig, so tests are
> appreciated. buildman reports builds are working.

Tested-by: Kory Maincent <kory.maincent@bootlin.com>
For the BeagleBone Green Eco.

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
