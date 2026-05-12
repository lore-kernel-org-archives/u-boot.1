Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B492CD4855
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 08:13:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F71383E76;
	Tue, 12 May 2026 10:12:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="BZQ6lEA1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 690D8803C6; Tue, 12 May 2026 10:06:50 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68970801A9
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 10:06:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 04009206FC;
 Tue, 12 May 2026 10:06:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1778573207;
 bh=nX3leiENPhdwoWMRu4kDX2hJBUXZ2UtLnJJaMpjbC3g=; h=From:To:Subject;
 b=BZQ6lEA1G9NTwjHNYxhiyFkRlZxUlSKTq8DeqJtM5kUihlZeF2wKSiVxIMNicDL9x
 TEziXJLvkLmY/1W9lCa4oWqH8jC9WMCpWLzxRwcvGOVlTdLtqzhom3Eu5F5WB5Kmxi
 bq93+GG92JRWWif177nL8BrjnZlp64WQ08EihxkJKPaOABMLYFy873dp8rwpYoJzIn
 RdIuDKVWDfKJqNkcdu2OONOEtuT/p90ZMSOCNP7QzN0DKoxndj+WtvD3tENvi+ZkqU
 LEoijzUNfN9Wum+HsjJgbpVAoKcxTil4kJqErVSmplRR+2CD3oKmDpDGJru44gZebq
 3dJy12v2zUgrg==
Date: Tue, 12 May 2026 10:06:42 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Joseph Guo <qijian.guo@nxp.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Francesco Valla <francesco@valla.it>, Ye Li <ye.li@nxp.com>,
 Primoz Fiser <primoz.fiser@norik.com>, Jacky Bai <ping.bai@nxp.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Brian Sune <briansune@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 Hai Pham <hai.pham.ud@renesas.com>, David Lechner <dlechner@baylibre.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>,
 Ion Agorria <ion@agorria.com>, Paul Kocialkowski <contact@paulk.fr>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 David Zang <davidzangcs@gmail.com>, Simon Glass <sjg@chromium.org>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>,
 =?iso-8859-1?Q?J=E9r=E9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Stefan Roese <stefan.roese@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Lukasz Majewski <lukma@denx.de>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Wadim Egorov <w.egorov@phytec.de>, Martin Schwan <m.schwan@phytec.de>,
 Tim Harvey <tharvey@gateworks.com>, Simona Toaca <simona.toaca@nxp.com>,
 Franz Schnyder <franz.schnyder@toradex.com>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v3 8/9] arm: dts: imx: Enable watchdog driver model support
Message-ID: <20260512080642.GA24873@francesco-nb>
References: <20260512-wdt-v1-0-0b9e1993557b@nxp.com>
 <20260512-wdt-v1-8-0b9e1993557b@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512-wdt-v1-8-0b9e1993557b@nxp.com>
X-Mailman-Approved-At: Tue, 12 May 2026 10:12:36 +0200
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

On Tue, May 12, 2026 at 11:10:15AM +0800, alice.guo@oss.nxp.com wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> Enable CONFIG_WDT for boards using ULP watchdog to allow reset_cpu() to
> use watchdog driver model instead of hardcoded base addresses.
> 
> Remove wdog3 status = "disabled" overrides from U-Boot device tree
> overlays, as the watchdog device needs to be accessible for driver
> model based reset functionality.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com> # Toradex boards

