Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BB3C4706C
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 20:01:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B679E87729;
	Tue,  9 Jan 2024 21:01:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F40DC877F9; Tue,  9 Jan 2024 21:01:05 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A996F87509
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 21:01:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
 by mail11.truemail.it (Postfix) with ESMTPA id 94869201D7;
 Tue,  9 Jan 2024 21:01:02 +0100 (CET)
Date: Tue, 9 Jan 2024 21:00:53 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Tom Rini <trini@konsulko.com>
Cc: Nishanth Menon <nm@ti.com>, Roger Quadros <rogerq@kernel.org>,
 michael@amarulasolutions.com, dario.binacchi@amarulasolutions.com,
 afd@ti.com, vigneshr@ti.com, praneeth@ti.com, srk@ti.com,
 r-gunasekaran@ti.com, u-boot@lists.denx.de,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH 4/4] configs: am64x_evm_a53_defconfig: Enable NAND
Message-ID: <20240109200053.GA94696@francesco-nb>
References: <20240109122605.51951-1-rogerq@kernel.org>
 <20240109122605.51951-5-rogerq@kernel.org>
 <20240109191859.ljtnotdn4voabwko@animate>
 <20240109195400.GY1610741@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109195400.GY1610741@bill-the-cat>
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

On Tue, Jan 09, 2024 at 02:54:00PM -0500, Tom Rini wrote:
> On Tue, Jan 09, 2024 at 01:18:59PM -0600, Nishanth Menon wrote:
> > On 14:26-20240109, Roger Quadros wrote:
> > >  CONFIG_CMD_PMIC=y
> > >  CONFIG_CMD_REGULATOR=y
> > > +CONFIG_CMD_MTDPARTS=y
> > > +CONFIG_MTDIDS_DEFAULT="nand0=omap2-nand.0"
> > > +CONFIG_MTDPARTS_DEFAULT="mtdparts=omap2-nand.0:2m(NAND.tiboot3),2m(NAND.tispl),2m(NAND.tiboot3.backup),4m(NAND.u-boot),256k(NAND.u-boot-env),256k(NAND.u-boot-env.backup),-(NAND.file-system)"
> > 
> > Why not handle this as device tree partitions?
> 
> I honestly forget what the preferred way of defining and passing NAND
> partition information is these days. It might even be the funny case
> that passing as cmdline args is "best" rather than fixed-partitions
> binding?

According to past discussions [1] doing the fixup in U-Boot is not advised.

Using the command line or having the partition fixed in the DT are both
valid options.

[1] https://lore.kernel.org/all/20230206224838.75963-1-francesco@dolcini.it/

Francesco

