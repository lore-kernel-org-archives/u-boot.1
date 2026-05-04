Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FB3FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 04:54:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6A3983FEC;
	Mon,  4 May 2026 06:54:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="y+qnYKn/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3B7483FEC; Mon,  4 May 2026 06:54:22 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EEB584374
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 06:54:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-38-214-193.ip72.fastwebnet.it [93.38.214.193])
 by mail11.truemail.it (Postfix) with ESMTPA id DF2ED2558B;
 Mon,  4 May 2026 06:54:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1777870457;
 bh=S+gwXvR6NkoUmu/rwWpvNoj+2F3n684CiCDVeCQQ6lw=; h=From:To:Subject;
 b=y+qnYKn/yQt5zOxG4KEBMRdgqzdFsGaHd52d6jmXbZvORZ0y5Hqfwos8uNZaWp4aK
 RfFn9ODr0VizIePXsC1Q3aJHUeJVXTgv0gT2jRKCh59KiTK+bl6x8Rt4T77PgtxLRQ
 ve0R3LBka8zZUknoKYapmPBX+Wy0xRJnIGiNknsoF43AYiUwPghm2ttpxWvHhiJRLs
 w55qAe0Uj1Go3ItXGCEcOpAafswnW2GMZdmm0+WC+IrUBMz1KUa+4lfoxgJTjdv57F
 JHX8h4iyTJUdyaWWJj42BDZn2KYONpxXAg9AdbAgIhA5nJMQ8suSAngE/AfwltBnZ5
 dwotxqSL1pPUA==
Date: Mon, 4 May 2026 06:54:10 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>,
 Andrew Davis <afd@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Bryan Brattlof <bb@ti.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Franz Schnyder <franz.schnyder@toradex.com>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Peng Fan <peng.fan@nxp.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Tom Rini <trini@konsulko.com>, Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH 1/6] toradex: Quote fdtfile in preboot test
Message-ID: <20260504045410.GA5052@francesco-nb>
References: <20260503204936.3151124-1-sjg@chromium.org>
 <20260503204936.3151124-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503204936.3151124-2-sjg@chromium.org>
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

Hello Simon,

On Sun, May 03, 2026 at 02:49:19PM -0600, Simon Glass wrote:
> The 15 Toradex defconfigs (apalis-imx8, apalis_imx6, the colibri
> imx6/imx6ull/imx7/imx8x/vf families, the toradex-smarc-imx8mp/imx95
> boards and the verdin am62/am62p/imx8mm/imx8mp boards) all carry the
> same preboot expression:
> 
>     test -n ${fdtfile} || setenv fdtfile ...

Thanks for the patch.

This was already sent weeks ago, see https://lore.kernel.org/all/20260331-fix-test-cmd-empty-v1-1-56cb93fc8f43@toradex.com/


Francesco

