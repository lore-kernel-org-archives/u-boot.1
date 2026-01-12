Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F67D2503F
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 07:56:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DFB683C14;
	Mon, 12 Jan 2026 08:56:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="ZtMFcjqL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55F5083C2B; Mon, 12 Jan 2026 08:56:43 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DE0183B85
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 08:56:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id 0E3C81FAAE;
 Mon, 12 Jan 2026 08:56:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1768204600;
 bh=PHCs0iNyflG7x6+oRCtz4NEb6YJJHbVOD9mrmwPAxWA=; h=From:To:Subject;
 b=ZtMFcjqLE2oKc1b2piFxvFBSFhZ2YShLVNxAavEFQ89Q14nmtZiluhyX42oliU+zC
 efs0sezywO5g1AwEcsa1CDAcDRmFKi2fMG5j3wC3xPk0zafy80891LW33xXLTk7uzh
 ZHOXXFe7jReWJyvUAITn+3eqoPXKk4T0evYZON6RduaATjTaw4UtnRofeuGb9ZTIPj
 ZnR+M9vhZeeFZ6gJq7D6XfYoV9wx+tjWtLEHIEPvMh9+PUInewDWZQRtLFV86x6wB7
 3i35p4wwhSw61CsH4mobf3Bte0g4XVeV3sq7W78hNgFpfrICcr0iw4AQPEEUGiiMdm
 YShixlWprrFgQ==
Date: Mon, 12 Jan 2026 08:56:36 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, trini@konsulko.com,
 u-boot@lists.denx.de, nm@ti.com, vigneshr@ti.com, kristo@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH] arm64: dts: ti: k3-*: Replace rgmii-rxid with rgmii-id
 for CPSW ports
Message-ID: <20260112075636.GA105765@francesco-nb>
References: <20251025073802.1790437-1-s-vadapalli@ti.com>
 <20260112074948.GA101138@francesco-nb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112074948.GA101138@francesco-nb>
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

On Mon, Jan 12, 2026 at 08:49:56AM +0100, Francesco Dolcini wrote:
> +Tom +U-Boot ML
> 
> Hello Siddharth,
> 
> On Sat, Oct 25, 2025 at 01:07:59PM +0530, Siddharth Vadapalli wrote:
> > The MAC Ports across all of the CPSW instances (CPSW2G, CPSW3G, CPSW5G and
> > CPSW9G) present in various K3 SoCs only support the 'RGMII-ID' mode. This
> > correction has been implemented/enforced by the updates to:
> > a) Device-Tree binding for CPSW [0]
> > b) Driver for CPSW [1]
> > c) Driver for CPSW MAC Port's GMII [2]
> > 
> > To complete the transition from 'RGMII-RXID' to 'RGMII-ID', update the
> > 'phy-mode' property for all CPSW ports by replacing 'rgmii-rxid' with
> > 'rgmii-id'.
> > 
> > [0]: commit 9b357ea52523 ("dt-bindings: net: ti: k3-am654-cpsw-nuss: update phy-mode in example")
> > [1]: commit ca13b249f291 ("net: ethernet: ti: am65-cpsw: fixup PHY mode for fixed RGMII TX delay")
> > [2]: commit a22d3b0d49d4 ("phy: ti: gmii-sel: Always write the RGMII ID setting")
> 
> What about U-Boot?
> I just noticed this in today U-Boot master:
> 
>   RGMII mode without internal TX delay unsupported; please fix your Device Tree
> 
> and I think this is coming from the DTS update from Linux to U-Boot.
> 
> Can you look into that?

Ok, I think that the issue is that the U-Boot code was updated
correctly, but now we need the v6.19 DT in U-Boot, and as of now we have
6.18 DT.

Tom: are you planning to sync the U-Boot DT to Linux v6.19 before the next
U-Boot release?


Francesco
