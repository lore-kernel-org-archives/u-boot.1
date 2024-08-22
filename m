Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC107C3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 05:40:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F202188E6F;
	Thu, 22 Aug 2024 07:40:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="frzK6S5j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0EFD88E6D; Thu, 22 Aug 2024 07:40:54 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E7FB88E6F
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 07:40:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47M5elME018534;
 Thu, 22 Aug 2024 00:40:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1724305247;
 bh=RO0I4X5/3nqrFPBAB86ToqFY2/BcAXi06aquDG21NB8=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=frzK6S5jTXDF2cPj7JXE9Af97cY1z1d2DX5lrfJwDpTHGXnvK2beYdo4Ah24hPFsX
 DJAN2S9T7B/OxHDHoSfZ1zXHoonudRa+L4JIoTEQpSXaZ04khrtwLK+6tWo6aLtm4V
 Yi6MSgzLOGdblrwgMkfPQCZ3EemwUsa08CDgUKys=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47M5elGE078271
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 22 Aug 2024 00:40:47 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Aug 2024 00:40:47 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Aug 2024 00:40:46 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47M5ejUm066327;
 Thu, 22 Aug 2024 00:40:46 -0500
Date: Thu, 22 Aug 2024 11:10:45 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <n-francis@ti.com>, <nm@ti.com>, 
 <a-limaye@ti.com>, <marcel.ziswiler@toradex.com>, <seanga2@gmail.com>,
 <sjg@chromium.org>, <marex@denx.de>, <john@phrozen.org>,
 <ansuelsmth@gmail.com>, <sumit.garg@linaro.org>,
 <u-boot@lists.denx.de>, <vigneshr@ti.com>, <srk@ti.com>
Subject: Re: [RFC PATCH 1/2] pci: Add TI K3 Cadence PCIe Controller
Message-ID: <bafd58e2-97cc-4679-88ee-9aa4e0a3dd66@ti.com>
References: <20240821145908.3408573-1-s-vadapalli@ti.com>
 <20240821145908.3408573-2-s-vadapalli@ti.com>
 <20240821180020.GP1626301@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240821180020.GP1626301@bill-the-cat>
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

On Wed, Aug 21, 2024 at 12:00:20PM -0600, Tom Rini wrote:
> On Wed, Aug 21, 2024 at 08:29:07PM +0530, Siddharth Vadapalli wrote:
> 

[...]

> > +
> > +#include <asm/global_data.h>
> > +#include <asm/gpio.h>
> > +#include <clk-uclass.h>
> > +#include <dm.h>
> > +#include <dm/device_compat.h>
> > +#include <generic-phy.h>
> > +#include <linux/bitops.h>
> > +#include <linux/delay.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/log2.h>
> > +#include <log.h>
> > +#include <pci.h>
> > +#include <power-domain.h>
> > +#include <regmap.h>
> > +#include <syscon.h>
> 
> Please audit this list to make sure you need everything because..
> 
> > +
> > +DECLARE_GLOBAL_DATA_PTR;
> 
> You don't reference gd in this code at all, so don't need this.

I missed dropping this. I had checked that the rest of the includes are
required, but I will re-check when I post the v2 patch.

> 
> So please also make sure the giant list of defines is needed.

During the development of this driver, I had committed the changes with
around 15 commits that had the defines added only when needed. Therefore
I am positive that they are required. I squashed those commits into a
single one which is this patch. Nevertheless, I will double check before
posting the v2 patch.

> > +#define usleep_range(a, b) udelay((b))
> 
> Per checkpatch.pl.conf:
> # Not Linux, so we don't recommend usleep_range() over udelay()

Sure, I will switch to udelay().

Thank you for reviewing this patch and providing feedback. I will implement
your suggestions in the v2 patch.

Regards,
Siddharth.
