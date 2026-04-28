Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB365FF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 08:33:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D40A984150;
	Tue, 28 Apr 2026 10:33:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="GQUMA6Ft";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A7C384255; Tue, 28 Apr 2026 10:33:01 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 021F784119
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 10:32:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 75BAD4E42B5C;
 Tue, 28 Apr 2026 08:32:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 42016601D0;
 Tue, 28 Apr 2026 08:32:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D29781072853D; 
 Tue, 28 Apr 2026 10:32:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777365176; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Ke/sa5C7zqopBML9pkX3WZugjcabkBZAJWlJEs6lZpU=;
 b=GQUMA6FtLGK7Sf229gBaU9vHBIN7nTGYSbXU9shvJbC3mV3/laMI9fzFfbMB1Zdi3YZDvz
 kg6MdlJI4upgd0M1pX1EqP6PkkuzWSKTGQr7+zP1E+i0wFiT4fdP64aMJ18g0XyfFr+83E
 K4dbOeCL4GW1q4d6aKiWlTRBV2emX8Gomy26B8LYciYPTyYeuUu+HjmiKoVPAOd0Qn+Xkw
 1N1A4tw1rbFSziHQc71/Odvfwnnuyxa92lAxw8e4ydgxFV6wY/vaz6ksb3ZJxJINUqWPQ6
 FNaffTIUVHCczHep82Hly/6V9Ku7injq8ZYaOoCP5Fm2NuQoM5W84hivCp+SEQ==
Date: Tue, 28 Apr 2026 10:32:45 +0200
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
Subject: Re: [PATCH v7 12/14] configs: am335x_evm_defconfig: Switch to
 upstream devicetree
Message-ID: <20260428103245.70fd5a51@kmaincent-XPS-13-7390>
In-Reply-To: <20260427-topic-am33-evm-oftree-v2026-01-v7-12-7e6cd1a805a1@baylibre.com>
References: <20260427-topic-am33-evm-oftree-v2026-01-v7-0-7e6cd1a805a1@baylibre.com>
 <20260427-topic-am33-evm-oftree-v2026-01-v7-12-7e6cd1a805a1@baylibre.com>
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

On Mon, 27 Apr 2026 11:01:28 +0200
"Markus Schneider-Pargmann (TI)" <msp@baylibre.com> wrote:

> The upstream devicetree uses simple-pm-bus, so CONFIG_POWER_DOMAIN is
> required now. CONFIG_POWER_DOMAIN enables probing power domains, the PRM
> power domain driver is requierd as well now.
>=20
> CONFIG_PHANDLE_CHECK_SEQ is now needed as many device nodes are now
> named for example mmc@0.
>=20
> This switches all evm defconfig variants to use the upstream devicetree.
>=20
> Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
