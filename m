Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A9AC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 19:08:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1D40848BF;
	Thu,  2 Jul 2026 21:08:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="pq3pQMrL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 361898496E; Thu,  2 Jul 2026 21:08:19 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D598384857
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 21:08:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 98BF31FD17;
 Thu,  2 Jul 2026 21:08:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1783019296;
 bh=fmOSBYvNUGJQAmnNnqKw5nTmJmAkKD4fJJBXPo4ykcg=; h=From:To:Subject;
 b=pq3pQMrLThtLtAW9QVkjZJFKstIz0O0W2b+cwmiyKxMzaJGdQ8/d4D5owy/nQrdDg
 IMyGdMZfLTQ+YXiwKnQuRGViOQSUvDgyOZqN327vF3PBROnwm6bR2kpJ0blWW/5etY
 /HqH+X0niNiCrNpbZV/LFXsIf6xUBTx835To5kVkYiyLBCyy4p+IMzgwnEGyoo/edQ
 /pBZ1uvgDl2fgCVz4xjDm83snSC6m3PjHsUviOriRL4nbl0DCE9Xa5gzuvbcIPNhV2
 48DUKkTTu//QuYZIimaDB9PuwmG+IMSavCaXpNp+uiyf7UPWwBipIJID2m14lt3JVF
 Tu+ydiMX8wYuA==
Date: Thu, 2 Jul 2026 21:08:11 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Andrew Davis <afd@ti.com>
Cc: Paresh Bhagat <p-bhagat@ti.com>, u-boot@lists.denx.de,
 trini@konsulko.com, praneeth@ti.com, vigneshr@ti.com,
 u-kumar1@ti.com, msp@baylibre.com, v-singh1@ti.com, anshuld@ti.com,
 m-chawdhry@ti.com, joao.goncalves@toradex.com, bb@ti.com,
 n-francis@ti.com, sebin.francis@ti.com
Subject: Re: [PATCH v2 3/4] arm: mack-k3: Kconfig: Add DM firmware reserved
 memory configs
Message-ID: <20260702190811.GA255841@francesco-nb>
References: <20260701075021.3626094-1-p-bhagat@ti.com>
 <20260701075021.3626094-4-p-bhagat@ti.com>
 <7794bc90-b69c-48bc-a2a8-2ecdf8ae1459@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7794bc90-b69c-48bc-a2a8-2ecdf8ae1459@ti.com>
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

On Thu, Jul 02, 2026 at 01:12:08PM -0500, Andrew Davis wrote:
> On 7/1/26 2:50 AM, Paresh Bhagat wrote:
> > Add Kconfig options for DM firmware reserved memory for K3 SOCs that
> > support DM firmware (K3_DM_FW enabled)
> > - K3_DM_FW_RESERVED_ADDR: DM firmware address
> > - K3_DM_FW_RESERVED_SIZE: DM firmware reserved size
> > 
> > These configs will be used to fixup the kernel device tree's reserved
> > memory node for DM. Currently the fixup is only done for AM62A7 SoC, as
> > K3_DM_FW_RESERVED_SIZE is being used to update DM reserved memory from
> > 0xf0000 to 0x1f0000 as the current reserved carveout is insufficient to
> > accommodate the binary.
> > 
> > For other platforms, the addresses and sizes are based on the existing
> > device tree reserved memory. If needed for other SoCs, address and size
> > could be modified in Kconfig.
> > 
> > Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
> > ---
> >   arch/arm/mach-k3/Kconfig | 21 +++++++++++++++++++++
> >   1 file changed, 21 insertions(+)
> > 
> > diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> > index a32ed3a9683..1b6678e72b7 100644
> > --- a/arch/arm/mach-k3/Kconfig
> > +++ b/arch/arm/mach-k3/Kconfig
> > @@ -165,6 +165,27 @@ config K3_DM_FW
> >   	  bootloader, it makes RM and PM services not being available
> >   	  during R5 SPL execution time.
> > +config K3_DM_FW_RESERVED_ADDR
> > +	hex "Start address of DM firmware reserved memory region"
> > +	depends on !SOC_K3_AM642 && !SOC_K3_AM654
> > +	default 0x9c900000 if SOC_K3_AM62A7 || SOC_K3_AM62P5
> > +	default 0x9db00000 if SOC_K3_AM625
> > +	default 0xa0100000 if SOC_K3_J721E || SOC_K3_J7200 || SOC_K3_J721S2 || SOC_K3_J722S || SOC_K3_J784S4
> > +	help
> > +	  Start address of the DDR region reserved for DM firmware at runtime.
> > +	  Used only to fixup the kernel device-tree reserved-memory node.
> > +
> > +config K3_DM_FW_RESERVED_SIZE
> > +	hex "Reserved memory size for DM firmware"
> > +	depends on !SOC_K3_AM642 && !SOC_K3_AM654
> > +	default 0x1f00000 if SOC_K3_AM62A7
> > +	default 0xc00000 if SOC_K3_AM625
> > +	default 0x1e00000 if TARGET_VERDIN_AM62P_A53 || TARGET_VERDIN_AM62P_R5
> 
> Why is this one board different from the rest of the AM62P boards? I doubt
> the folks at Toradex have make a custom DM firmware, guessing they are just
> the first to notice our default DM firmware goes outside the current reserved
> memory size. This size likely needs to be made common for all AM62P.

You are right, we are not customizing anything on this regard.

Francesco

