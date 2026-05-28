Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5127DCD5BD5
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 07:37:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 928238056B;
	Thu, 28 May 2026 09:37:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="P4UBeIz5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39B7A839A8; Thu, 28 May 2026 09:37:42 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C283803C6
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 09:37:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id CC6681F8CB;
 Thu, 28 May 2026 09:37:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1779953859;
 bh=E2qjl8Xh/3yfOTN41iSepYQ7CSMON/3ajVXNOSjMtg4=; h=From:To:Subject;
 b=P4UBeIz52YuQJSnwzwwCfJnQK+Y5pA1788szNXcJPqfqQtcjyjyN7Fa5vuhE5jCfS
 Z4G2jxdAN7BqD4MEnkQbqlJlHwE87uNxAav5Su+Y2c00TqnDmvbJMxp/5PH0U1f6pu
 tbqLSKeLEkjrFEb8gnamUZ4OxaQa77ns4QDtx8pLMM7m3FAiEH4aG1OkL08CfavcV+
 tt1eRYfBs+P16h9gVdZcHMnKySdwANpP2Na0sGmg3MlfuWTW2t2ndybGn24vk3/Z4x
 4j6Jm8KtcHUIvHnm0ZapI3AdBV2QXYusdIRb7KoioKvSjQFynWm9a/3pHsDGunerm8
 bvtrT3oU55Wpw==
Date: Thu, 28 May 2026 09:37:34 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Simona Toaca <simona.toaca@oss.nxp.com>
Cc: Emanuele Ghidoli <ghidoliemanuele@gmail.com>, uboot-imx@nxp.com,
 u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 festevam@gmail.com, peng.fan@nxp.com, alice.guo@nxp.com,
 ye.li@nxp.com, simona.toaca@nxp.com, viorel.suman@nxp.com,
 fedor.ross@ifm.com, marex@nabladev.com, joao.goncalves@toradex.com,
 ravi@prevas.dk, ping.bai@nxp.com, ji.luo@nxp.com, qijian.guo@nxp.com
Subject: Re: [PATCH v4 1/4] imx9: Add support for saving DDR training data to
 NVM
Message-ID: <20260528073734.GA17049@francesco-nb>
References: <cover.1777536451.git.simona.toaca@nxp.com>
 <d9038d69963976399d8e8e26dbf84b98ee1f82da.1777536451.git.simona.toaca@nxp.com>
 <bc9d68f2-da7a-470c-9841-f78da9c150dc@gmail.com>
 <nesqj4lgl65zv6ugh5fcott4ticwzdvur2drwyppkutvbtbyof@gq23nkzbmo24>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nesqj4lgl65zv6ugh5fcott4ticwzdvur2drwyppkutvbtbyof@gq23nkzbmo24>
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

On Wed, May 27, 2026 at 05:33:36PM +0300, Simona Toaca wrote:
> On Mon, May 25, 2026 at 10:59:00AM +0200, Emanuele Ghidoli wrote:
> > 
> > 
> > On 4/30/26 10:33, Simona Toaca (OSS) wrote:
> > > From: Simona Toaca <simona.toaca@nxp.com>
> > > 
> > > +/**
> > > + * This structure needs to be aligned with the one in OEI.
> > > + */
> > > +struct ddrphy_qb_state {
> > > +	u32 crc;		  /* Used for ensuring integrity in DRAM */
> > > +#define MAC_LENGTH		8 /* 256 bits, 32-bit aligned */
> > > +	u32 mac[MAC_LENGTH];	  /* For 95A0/1 use mac[0] to keep CRC32 value */
> > > +	u8 trained_vrefca_a0;
> > > +	u8 trained_vrefca_a1;
> [...]
> 
> > > +	u16 acsm[DDRPHY_QB_ACSM_SIZE];
> > > +	u16 pst[DDRPHY_QB_PST_SIZE];
> > > +};
> > 
> > Hi Simona,
> > 
> > Would you consider reserving a small u16 board-defined field at the
> > end of struct ddrphy_qb_state? Something like:
> > 
> > 	u16 board_ddr_config;	/* board-defined tag, opaque to U-Boot */
> > 
> > Use case: boards that carry multiple LPDDR configurations
> > (single-/dual-rank, different sizes, ...). At QuickBoot time the
> > boot code needs to know which configuration produced the persisted
> > PHY training data, in order to load the matching timing table
> > before DDRC init, in OEI. A 16-bit board-defined identifier is enough; the
> > value is opaque to U-Boot.
> >
> I am taking into consideration adding such a field into qb_state
> in the future, but for now we do not support a mechanism
> for deciding the dram timing at runtime.

The reality is that we are forking your OEI (AFAIK you do not take
patches) to support our boards and our use case. So we (Toradex) have it
already, and it is working 100% fine.

What is tricky here is that this structure is an ABI / contract between
the OEI firmware and U-Boot.

Just to anticipate your potential answer, our boards just work with
mainline U-Boot, so asking us to have a patch and fork U-Boot is not an
option.

Francesco

