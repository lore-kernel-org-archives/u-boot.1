Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E02CDB482
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 16:49:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48DC086E0E;
	Fri, 13 Oct 2023 18:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xQC9NGOD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38B8E86B95; Fri, 13 Oct 2023 18:49:38 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF8D286E0E
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 18:49:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39DGnSx2047026;
 Fri, 13 Oct 2023 11:49:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697215768;
 bh=dTLcZmCO+d6jaHKifaGCmfgAbekFMiPPKy0Ofeyizac=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=xQC9NGODejmT3iJDhTTHtzDEBTHAXsLc+RWVvbLOjDW4TuPYjcKwCglIHvaeGf/73
 jFFAs/wHV9U/7J0CTJpiIoXgncOJ4gUMxMYpSm/6W7q3rPPmDIwIIIC6+r77IZVx86
 MqhCVYNamrW77plMDLStbmiFFQYhWK7Qt6BfNzjw=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39DGnSIE011348
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 13 Oct 2023 11:49:28 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 13
 Oct 2023 11:49:27 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 13 Oct 2023 11:49:27 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39DGnRrJ023455;
 Fri, 13 Oct 2023 11:49:27 -0500
Date: Fri, 13 Oct 2023 11:49:27 -0500
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon
 Chung <jh80.chung@samsung.com>,
 UBoot Mailing List <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 06/11] board: ti: introduce basic board files for the
 am62px family
Message-ID: <20231013164927.xn53gnwszct3x2va@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20231012230616.2101992-13-bb@ti.com>
 <20231012230616.2101992-19-bb@ti.com>
 <20231013125025.GH3119521@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20231013125025.GH3119521@bill-the-cat>
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

Hey Tom!

On October 13, 2023 thus sayeth Tom Rini:
> On Thu, Oct 12, 2023 at 06:06:23PM -0500, Bryan Brattlof wrote:
> 
> > Introduce the basic files needed to support the am62px family of SoCs
> > 
> > Co-developed-by: Hari Hagalla <hnagalla@ti.com>
> > Signed-off-by: Hari Hagalla <hnagalla@ti.com>
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> [snip]
> > diff --git a/board/ti/am62px/evm.c b/board/ti/am62px/evm.c
> > new file mode 100644
> > index 0000000000000..44793cbed6536
> > --- /dev/null
> > +++ b/board/ti/am62px/evm.c
> > @@ -0,0 +1,30 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Board specific initialization for AM62Px platforms
> > + *
> > + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> > + *
> > + */
> > +
> > +#include <asm/arch/hardware.h>
> > +#include <asm/io.h>
> > +#include <common.h>
> > +#include <dm/uclass.h>
> > +#include <env.h>
> > +#include <fdt_support.h>
> > +#include <spl.h>
> > +
> > +int board_init(void)
> > +{
> > +	return 0;
> > +}
> > +
> > +int dram_init(void)
> > +{
> > +	return fdtdec_setup_mem_size_base();
> > +}
> > +
> > +int dram_init_banksize(void)
> > +{
> > +	return fdtdec_setup_memory_banksize();
> > +}
> 
> Similar to what I said about another platform yesterday, lets split this
> up in to "base.c" and "evm.c".  The good news is that so far, I think
> all of this should just be in base.c instead.  Second, here and
> elsewhere don't add common.h but instead add what you need.  And
> finally, for all of the new files please audit what headers you're
> adding.  7 headers for 5 function prototypes is a bit much.  Thanks.
> 

Yeah I can clean this up :)

> -- 
> Tom


