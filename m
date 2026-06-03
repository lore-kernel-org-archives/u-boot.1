Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1EDFCD6E4A
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 07:24:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AC4E83EF9;
	Wed,  3 Jun 2026 09:24:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="qWLi0s9m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D26F484855; Wed,  3 Jun 2026 09:24:14 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B67078341A
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 09:24:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id 6054723B07;
 Wed,  3 Jun 2026 09:24:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1780471452;
 bh=XrdpjX1rmmR/2GvzGqDyceb5sMu6lrLzH1xXe1JEKdY=; h=From:To:Subject;
 b=qWLi0s9m3M1RSWBIh3tR3ErimuRVMI3odvgIcfrf6Xmfe49VGpXJNJ/vEXZ5tleOY
 HndsvNhzU/VfXJ9+nWE6MXpPOiho+AYDZQSNd/bVDVpDixJKR3lgZVihKR/gRbRlHa
 GntbG+EwzudMlo6tYwFmtk4KLRDLySOEWe7d/UXQyF/y5pQVZSpRENKRILx/4Sfa5k
 dGw1Aqw/0ccbAiaxJWT8PCwbhwmZFZof+MBJtHlVX3KWc7UwxtPlaEMlxsK7lm075g
 OzizAp7jhQFlJyGoVP7nm+u5X6pvY7uKk/JRGpVH5XZ9MCR1sOMu7S0fP4lu7gcGrr
 IUDQIFrNZlwCg==
Date: Wed, 3 Jun 2026 09:24:07 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Simona Toaca <simona.toaca@oss.nxp.com>
Cc: "Kumar, Udit" <u-kumar1@ti.com>, uboot-imx@nxp.com,
 u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 festevam@gmail.com, peng.fan@nxp.com, alice.guo@nxp.com,
 ye.li@nxp.com, simona.toaca@nxp.com, viorel.suman@nxp.com,
 fedor.ross@ifm.com, marex@nabladev.com, joao.goncalves@toradex.com,
 ravi@prevas.dk, ping.bai@nxp.com, ji.luo@nxp.com,
 qijian.guo@nxp.com, "Francis, Neha" <n-francis@ti.com>,
 Siddhant.Kumar@synopsys.com
Subject: Re: [PATCH v4 1/4] imx9: Add support for saving DDR training data to
 NVM
Message-ID: <20260603072407.GA27913@francesco-nb>
References: <cover.1777536451.git.simona.toaca@nxp.com>
 <d9038d69963976399d8e8e26dbf84b98ee1f82da.1777536451.git.simona.toaca@nxp.com>
 <b3d0d4aa-9058-4d2f-bc1c-bfb51fa4ad04@ti.com>
 <istftwxw7nnvk2q6ef4zsfuhsemupbd6fyjwwso3pqf2nagdqw@m4qujx6w4noy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <istftwxw7nnvk2q6ef4zsfuhsemupbd6fyjwwso3pqf2nagdqw@m4qujx6w4noy>
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

Hello Simona,

On Tue, Jun 02, 2026 at 01:59:39PM +0300, Simona Toaca wrote:
> On Thu, May 28, 2026 at 10:55:23AM +0530, Kumar, Udit wrote:
> > On 4/30/2026 2:03 PM, Simona Toaca (OSS) wrote:
> > > From: Simona Toaca <simona.toaca@nxp.com>
> > > 
> > > DDR training data can be saved to NVM and be available
> > > to OEI at boot time, which will trigger QuickBoot flow.
> > > 
> > > U-Boot only checks for data integrity (CRC32), while
> > > OEI is in charge of authentication when it tries to
> > > load the data from NVM.
> > > 
> > >  
> [...]
> > > +#define DDRPHY_QB_PSTATES	0
> > > +#define DDRPHY_QB_PST_SIZE	(DDRPHY_QB_PSTATES * 4 * 1024)
> > 
> > [..]
> > Sorry for basic question, in case OEI layer changes format due to one of
> > other reason then how you are making sure, struct ddrphy_qb_state is
> > aligned
> > 
> > + * This structure needs to be aligned with the one in OEI.
> > 
> For now, the structure is stable. If anything changes, I will take care
> to update U-Boot accordingly.

Did you consider Emanuele's email in which he thinks that what we have today
should already be changed? 

And how do you handle a mix of U-Boot vs OEI version? How can you ensure
that those are compatible? To me this is a mess. You are building an ABI
between U-Boot and the OEI.

Francesco

