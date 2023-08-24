Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBCFC27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 14:42:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2976A8667A;
	Thu, 24 Aug 2023 16:42:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83D99865AF; Thu, 24 Aug 2023 16:42:44 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B942E866CF
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 16:42:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.int.toradex.com (31-10-206-125.static.upc.ch
 [31.10.206.125])
 by mail11.truemail.it (Postfix) with ESMTPA id EA5E52072A;
 Thu, 24 Aug 2023 16:42:40 +0200 (CEST)
Date: Thu, 24 Aug 2023 16:42:39 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Nishanth Menon <nm@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 Emanuele Ghidoli <ghidoliemanuele@gmail.com>, u-boot@lists.denx.de,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Neha Malcom Francis <n-francis@ti.com>, Bryan Brattlof <bb@ti.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [PATCH v1 1/2] verdin-am62: add u-boot update wrappers
Message-ID: <ZOdsX2VMNf20ioFR@francesco-nb.int.toradex.com>
References: <20230824080850.1755724-1-ghidoliemanuele@gmail.com>
 <20230824080850.1755724-2-ghidoliemanuele@gmail.com>
 <ZOc8244kvlGRpHpj@francesco-nb.int.toradex.com>
 <20230824121057.zb6ugqbbmm6theny@rematch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824121057.zb6ugqbbmm6theny@rematch>
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

Hello Nishanth,

On Thu, Aug 24, 2023 at 07:10:57AM -0500, Nishanth Menon wrote:
> On 13:19-20230824, Francesco Dolcini wrote:
> > On Thu, Aug 24, 2023 at 10:08:49AM +0200, Emanuele Ghidoli wrote:
> > > From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > > 
> > > Add update_tiboot3, update_tispl and update_uboot wrappers to update
> > > R5 SPL, A53 SPL and A53 U-boot respectively.
> > > 
> > > Usage example:
> > > > tftpboot ${loadaddr} tiboot3-am62x-gp-verdin.bin
> > > > run update_tiboot3
> > > 
> > > > tftpboot ${loadaddr} tispl.bin
> > > > run update_tispl
> > > 
> > > > tftpboot ${loadaddr} u-boot.img
> > > > run update_uboot
> > > 
> > > Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > 
> > Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Should you update documentation to indicate the usage?

Yeah, probably we could add it. I would not remove the existing direct
command usage since this is adding just env variables that could be
removed from the env even at runtime.

In general the reason for these commands is that our users are
accustomed to have a "guided" way to update u-boot without having to dig
into the documentation. They are just convenient.

Marcel: what do you think?

Francesco

