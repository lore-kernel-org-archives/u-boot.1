Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490E0C4707B
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 20:23:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EF7F87729;
	Tue,  9 Jan 2024 21:23:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Vm4lFLiG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83D48877BA; Tue,  9 Jan 2024 21:23:05 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EB0780245
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 21:23:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 409KMqL6078121;
 Tue, 9 Jan 2024 14:22:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704831772;
 bh=K65VPJEPmVjxDpIDyqnZUBkKsh4h4ivB1p5ztDIpH40=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Vm4lFLiGCek6Lj38NYjEiz8Dapy4SlKUVjJsupdLCg8KXVu+C5e+JIDONQQ8ql5/O
 ApihfWRN+HYRP03iXZhyA9iH/9v8HXbtsW/BoBvwrWSM7Gio3ejsOioTVMTaJNCHLW
 Yqt/hlpQUIeZcaBn0JSztcY2jFG3alwYA5WmpRPg=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 409KMqWl008235
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 9 Jan 2024 14:22:52 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Jan 2024 14:22:51 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Jan 2024 14:22:51 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 409KMptF050778;
 Tue, 9 Jan 2024 14:22:51 -0600
Date: Tue, 9 Jan 2024 14:22:51 -0600
From: Nishanth Menon <nm@ti.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Tom Rini <trini@konsulko.com>, Roger Quadros <rogerq@kernel.org>,
 <michael@amarulasolutions.com>, <dario.binacchi@amarulasolutions.com>,
 <afd@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>, <srk@ti.com>,
 <r-gunasekaran@ti.com>, <u-boot@lists.denx.de>, Francesco Dolcini
 <francesco.dolcini@toradex.com>
Subject: Re: [PATCH 4/4] configs: am64x_evm_a53_defconfig: Enable NAND
Message-ID: <20240109202251.hajv7d7apqg62z2g@nimbly>
References: <20240109122605.51951-1-rogerq@kernel.org>
 <20240109122605.51951-5-rogerq@kernel.org>
 <20240109191859.ljtnotdn4voabwko@animate>
 <20240109195400.GY1610741@bill-the-cat>
 <20240109200053.GA94696@francesco-nb>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240109200053.GA94696@francesco-nb>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 21:00-20240109, Francesco Dolcini wrote:
> On Tue, Jan 09, 2024 at 02:54:00PM -0500, Tom Rini wrote:
> > On Tue, Jan 09, 2024 at 01:18:59PM -0600, Nishanth Menon wrote:
> > > On 14:26-20240109, Roger Quadros wrote:
> > > >  CONFIG_CMD_PMIC=y
> > > >  CONFIG_CMD_REGULATOR=y
> > > > +CONFIG_CMD_MTDPARTS=y
> > > > +CONFIG_MTDIDS_DEFAULT="nand0=omap2-nand.0"
> > > > +CONFIG_MTDPARTS_DEFAULT="mtdparts=omap2-nand.0:2m(NAND.tiboot3),2m(NAND.tispl),2m(NAND.tiboot3.backup),4m(NAND.u-boot),256k(NAND.u-boot-env),256k(NAND.u-boot-env.backup),-(NAND.file-system)"
> > > 
> > > Why not handle this as device tree partitions?
> > 
> > I honestly forget what the preferred way of defining and passing NAND
> > partition information is these days. It might even be the funny case
> > that passing as cmdline args is "best" rather than fixed-partitions
> > binding?
> 
> According to past discussions [1] doing the fixup in U-Boot is not advised.
> 
> Using the command line or having the partition fixed in the DT are both
> valid options.
> 
> [1] https://lore.kernel.org/all/20230206224838.75963-1-francesco@dolcini.it/

yup - also why I wonder why we cant depend on DT.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
