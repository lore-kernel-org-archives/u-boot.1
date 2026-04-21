Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D01AF94CA0
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 19:15:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1EBC83FFA;
	Tue, 21 Apr 2026 21:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="E3mCdmjU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F3BA841C8; Tue, 21 Apr 2026 17:48:29 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C3E883E76
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 17:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-33-72-241.ip43.fastwebnet.it [93.33.72.241])
 by mail11.truemail.it (Postfix) with ESMTPA id 1EC031F910;
 Tue, 21 Apr 2026 17:48:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1776786506;
 bh=EotSNyddUJqWrGg72dsAwkoWEI2PzXsFVu4NpZ4eRl8=; h=From:To:Subject;
 b=E3mCdmjUDwMcCcD/+iobMfHBd1xZ6OLIpebzaWSJbGdMl6hc413PdVZYxbgawqjHK
 sdCteACx4gAXhTFdA4WPjFvUn/40olV/PtzM2Mx9Ucg5gFLhP99dU3qI/6H7ngCwVi
 Ge3lWmksm84SnH5Bl3H2MK/ttRzcdA45hXrbPLOqOerMBaYrmtN3DNHgoRlj8RtSAU
 9CyuK2WiBoaIOrarTgFOyJofJAZfx66F43P27SGav9oU51JEot5W66ESApaq6URTYD
 8wyG+IKW05xt6XDE1qklzwLDVKCZWWkNLcUQX0eW5NNQtfsmTyyYPNNGqtK3owgEa4
 DzpnPK+v8dg3g==
Date: Tue, 21 Apr 2026 17:48:13 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Simon Glass <sjg@chromium.org>, Fedor Ross <fedor.ross@ifm.com>,
 =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Primoz Fiser <primoz.fiser@norik.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 =?iso-8859-1?Q?J=E9r=E9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, Jacky Bai <ping.bai@nxp.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Wadim Egorov <w.egorov@phytec.de>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Tim Harvey <tharvey@gateworks.com>, Anshul Dalal <anshuld@ti.com>,
 Franz Schnyder <franz.schnyder@toradex.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Joseph Guo <qijian.guo@nxp.com>, Ji Luo <ji.luo@nxp.com>,
 Marek Vasut <marex@nabladev.com>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v2 0/5] imx: Switch watchdog addressing from macros to
 devicetree
Message-ID: <20260421154813.GA95800@francesco-nb>
References: <20260421-wdt-v1-0-0bd01ec6a7c4@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421-wdt-v1-0-0bd01ec6a7c4@nxp.com>
X-Mailman-Approved-At: Tue, 21 Apr 2026 21:14:52 +0200
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

Hello Alice

On Tue, Apr 21, 2026 at 10:01:26PM +0800, alice.guo@oss.nxp.com wrote:
> CI: https://github.com/u-boot/u-boot/pull/935/checks
> 
> Changes for v2:
> - Iterate all watchdog nodes in device tree instead of wdog alias
> - Delete non-DM implementation of the ULP watchdog driver
> 

Please be aware of https://lore.kernel.org/all/20260416084535.1490476-1-ghidoliemanuele@gmail.com/

In case it gets merged before this series.

Francesco

