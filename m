Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C343D104950F
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 09:14:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DF5683FB6;
	Wed, 11 Mar 2026 10:14:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="dIxz6r6g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53C5A83FC0; Wed, 11 Mar 2026 10:14:30 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23ED783F93
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 10:14:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-38-171-16.ip71.fastwebnet.it [93.38.171.16])
 by mail11.truemail.it (Postfix) with ESMTPA id F22181FCF5;
 Wed, 11 Mar 2026 10:14:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1773220467;
 bh=cYWyM80SYAl7gSOSs2LFi/sJ1yMfPfUX7aQfkag/3Jk=; h=From:To:Subject;
 b=dIxz6r6gKvtS6MTn8XwWvYJ2aarNChhb3STgO3Sd3aOyPiMYjVc0br7R7x3sKpBFo
 3Yv95yOldKs8iqL3xJ1TZc3p7XBOcVCpFjgvJBXBsM+Se0xYVXsCI1RbAwZeWzmZy0
 QH1GcHf80AMxPMxarBpqkMinQw1nzlLWymzMuyxOzMm3SL81MTPVR56UicIuA21Xzf
 is8/ytL+xecmF80a7ePOxd+JlGpQ1rkcp6d62iaBy2Q2l0ND/55TJNK+h1QrvUVBRG
 j0NnnsZdrusrStxOtR7bMEzHOTrDTVY/VzdpZY7M2hkw9bnXjuDSewuME4I4FQTGAn
 ZfsWJJPjquTbA==
Date: Wed, 11 Mar 2026 10:14:19 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
 Simona Toaca <simona.toaca@oss.nxp.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com,
 peng.fan@nxp.com, alice.guo@nxp.com, ye.li@nxp.com,
 simona.toaca@nxp.com, viorel.suman@nxp.com, marex@nabladev.com,
 ravi@prevas.dk, fedor.ross@ifm.com,
 sebastien.szymanski@armadeus.com, joao.goncalves@toradex.com,
 ji.luo@nxp.com, semen.protsenko@linaro.org, sjg@chromium.org,
 tharvey@gateworks.com, ping.bai@nxp.com, qijian.guo@nxp.com
Subject: Re: [PATCH 4/5] board: nxp: imx9{4,5}_evk: Add qb save option in SPL
Message-ID: <20260311091419.GA6525@francesco-nb>
References: <cover.1773137310.git.simona.toaca@nxp.com>
 <bd23b79dc06f39a9f19ee3da956de450aad03aaf.1773137310.git.simona.toaca@nxp.com>
 <34d4475a-8353-47c9-86fe-36e67ceecb69@gmail.com>
 <llrc46dn7akdpro5bim3egfuuktyvwbrmb4odenspiz7tnwdme@3hc5leohkgzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <llrc46dn7akdpro5bim3egfuuktyvwbrmb4odenspiz7tnwdme@3hc5leohkgzr>
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

On Tue, Mar 10, 2026 at 05:27:45PM +0200, Simona Toaca wrote:
> On Tue, Mar 10, 2026 at 04:04:19PM +0100, Emanuele Ghidoli wrote:
> > On 3/10/26 12:54, Simona Toaca (OSS) wrote:
> > > From: Simona Toaca <simona.toaca@nxp.com>
> > > 
> > > Call qb save automatically in the board-specific
> > > spl_board_init(), if SPL_QB option is enabled. This
> > > makes sure qb_save is called before any image loading
> > > is done by the SPL.
> > > 
> > > Signed-off-by: Simona Toaca <simona.toaca@nxp.com>

...

> > > diff --git a/board/nxp/imx94_evk/spl.c b/board/nxp/imx94_evk/spl.c
> > > index cc5b7f9ef0f..1d25795eb17 100644
> > > --- a/board/nxp/imx94_evk/spl.c
> > > +++ b/board/nxp/imx94_evk/spl.c
> > > @@ -44,6 +45,9 @@ void spl_board_init(void)
> > >  	ret = ele_start_rng();
> > >  	if (ret)
> > >  		printf("Fail to start RNG: %d\n", ret);
> > > +
> > > +	if (IS_ENABLED(CONFIG_SPL_IMX_QB))
> > > +		spl_qb_save();
> > Does it write to MMC/NOR/SD at every boot? Is that necessary if a quick boot
> > was performed and the data has not changed?
> > >  }
> No, the qb() method calls qb_check, which returns true only if OEI
> saved valid data to volatile memory (meaning it has run Training flow).
> So, if Quickboot flow is run, the data in volatile memory is not valid,
> qb_check fails -> qb returns and does not write anything to the NVM.
> 
> Also, another thing to keep in mind is that after a successfull
> qb save, the data in volatile memory is invalidated -> qb check will
> fail as well even if OEI doesn't run (so on a warm reboot).

Do you think that this is something that should be generally enabled on
any i.MX95 boards? Emanuele?

Francesco

