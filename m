Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C7D105A591
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 12:48:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C234784239;
	Thu, 12 Mar 2026 13:47:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Aoc5/ihe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AFE7840A2; Thu, 12 Mar 2026 10:18:50 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E55383BC8
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 10:18:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0A07043A33;
 Thu, 12 Mar 2026 09:18:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D21C2BC87;
 Thu, 12 Mar 2026 09:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773307126;
 bh=cLRPa66S39BwcZZ9TCeenXrUN4VM9flpUa013TOFnq0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Aoc5/iheJExbtjGnlgw72Uk/ZeTaJvklbZmHeXrLzSL+nq6+51+Pkr/UvjE9f7pjG
 LJWXmEJrHOnsoAEb1BVGf2Aq5CrleOZzqHqEF+jKr47UKBHk/eY/3kOnMqpF8Yyg05
 KfI8B8V2qCoNjZcwlbsboUXS2ztWgqBMuIwOlT7tFOuEsft6gLWIR0xpehA2RQskSL
 Mx3B4fU7p+NBL5d4piXAgEQyT90jPB0g4TzggLNTF/6u0QNrS+gPaIQ42ncRyOycdB
 DuR//eel9l0B+8H2PtuWM7wQciHa0YLlgeSNPYhZ7Dpcqpg7TRJGoauOhuspELAxiq
 TY9OTql3xkF4A==
Date: Thu, 12 Mar 2026 14:48:34 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: Fabio Estevam <festevam@gmail.com>, alice.guo@oss.nxp.com,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>, Ji Luo <ji.luo@nxp.com>,
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, Jacky Bai <ping.bai@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Frank Li <Frank.Li@nxp.com>, Niko Mauno <niko.mauno@vaisala.com>,
 Adam Ford <aford173@gmail.com>, Joseph Guo <qijian.guo@nxp.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 David Zang <davidzangcs@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Fedor Ross <fedor.ross@ifm.com>, Shawn Guo <shawnguo@kernel.org>,
 Marek Vasut <marex@nabladev.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Primoz Fiser <primoz.fiser@norik.com>,
 Simon Glass <sjg@chromium.org>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v3 11/13] arm64: dts: freescale: Add i.MX952 EVK basic
 device tree
Message-ID: <abKE6hcrcPGew977@sumit-xelite>
References: <20260302-imx952-v1-0-069d6167c0cb@nxp.com>
 <20260302-imx952-v1-11-069d6167c0cb@nxp.com>
 <CAOMZO5Dz9PNPWqqBOvwquvQYmh+Oy24KQ79d5qcxKn8EbyH1ew@mail.gmail.com>
 <20260305150634.GF1388590@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260305150634.GF1388590@bill-the-cat>
X-Mailman-Approved-At: Thu, 12 Mar 2026 13:47:43 +0100
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

On Thu, Mar 05, 2026 at 09:06:34AM -0600, Tom Rini wrote:
> On Thu, Mar 05, 2026 at 11:00:11AM -0300, Fabio Estevam wrote:
> > Hi Alice,
> > 
> > On Mon, Mar 2, 2026 at 3:41 AM <alice.guo@oss.nxp.com> wrote:
> > >
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Add i.MX952 EVK basic device tree, with UART1, SDHC[1,2] supported.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> > >
> > > [ upstream commit: a5aa8551d0046ec701e8962f83361165ccf640a4 ]
> > >
> > > (cherry picked from commit bf18a0f083bdf73f806a3afb9b606b2cb0fcafb3)
> > > ---
> > >  dts/upstream/src/arm64/freescale/imx952-evk.dts | 217 ++++++++++++++++++++++++
> > >  1 file changed, 217 insertions(+)
> > 
> > Shouldn't we add this temporarily to arch/arm/dts instead?
> > 
> > Then, when it reaches dts/upstream, we can move to OF_UPSTREAM.
> > 
> > Tom, what is your preference?
> 
> This was a correctly done cherry-pick with our script
> (bf18a0f083bdf73f806a3afb9b606b2cb0fcafb3 is the commit in
> devicetree-rebasing) and may go in dts/upstream.

Yeah we should rather motivate people to do proper cherry picks rather
than patching arch/arm/dts since one would then have to undo arch/arm/dts
once the DT is synced again.

-Sumit
