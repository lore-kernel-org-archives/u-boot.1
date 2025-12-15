Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3C9D59D99
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 09:11:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BCDA80050;
	Mon, 15 Dec 2025 10:11:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="E+NkPPRJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D25FE80077; Mon, 15 Dec 2025 10:11:19 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0F918003E
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 10:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 316F04E41C0B;
 Mon, 15 Dec 2025 09:11:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id EA1DB60664;
 Mon, 15 Dec 2025 09:11:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 971FD119418FF; Mon, 15 Dec 2025 10:11:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1765789870; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=IfCpU5iM5jyNcQsEod0xV8Baqz1N/RPlwM3gv3C/C0c=;
 b=E+NkPPRJbySmv++Psx7iGNAucusodZnHl47geVXktlr2Cdgvyqp/khY4AsaC+GhgdVI/U4
 4TY/5Owd7pSNBxu2gw5o3s41ig2yFpHgLskQ/MY0JAii4/Y+i8lYLEGLO/RGAARat4uZau
 9aEA32sGd1NPOP5qJz68cbX09Z6CeFsf/To+jLBQzBF3e365EMn+Bcdgub6KK1Xl8BJwea
 /NA4Oe4FDSlL2V6h9bhW6QxcHAdEDUo9C1frMdmcfLl/NKh4zaRje5p6flziRm/mZB49Fr
 QPfZ3nIyH+v6Jbf+RsuMgRygqnK2KmDAI8fBncQyVn1SWQFuoks4tQK2E0Ugkw==
Date: Mon, 15 Dec 2025 10:10:59 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever
 Yang <kever.yang@rock-chips.com>, Elaine Zhang <zhangqing@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>, Patrick
 Delaunay <patrick.delaunay@foss.st.com>, Udit Kumar <u-kumar1@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Paul Barker
 <paul.barker.ct@bp.renesas.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Martin Schwan <m.schwan@phytec.de>, Anshul Dalal
 <anshuld@ti.com>, Casey Connolly <casey.connolly@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>, Andre
 Przywara <andre.przywara@arm.com>, Ye Li <ye.li@nxp.com>, Hrushikesh
 Salunke <h-salunke@ti.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Alif Zakuan Yuslaimi
 <alif.zakuan.yuslaimi@altera.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Justin Klaassen
 <justin@tidylabs.net>, Samuel Holland <samuel@sholland.org>, Rui Miguel
 Silva <rui.silva@linaro.org>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 0/8] various Kconfig option changes
Message-ID: <20251215101059.03747c61@kmaincent-XPS-13-7390>
In-Reply-To: <20251212-kconfig-reorg-v1-0-72441d8cc53c@cherry.de>
References: <20251212-kconfig-reorg-v1-0-72441d8cc53c@cherry.de>
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

On Fri, 12 Dec 2025 19:13:12 +0100
Quentin Schulz <foss+uboot@0leil.net> wrote:

> This fixes a few prompts for xPL options, puts xPL options together
> again, fixes a missed dependency and removes an option with an
> unmeetable dependency.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
