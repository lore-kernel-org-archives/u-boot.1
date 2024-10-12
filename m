Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DACD1A428
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 05:50:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6C4488C9C;
	Sat, 12 Oct 2024 07:50:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ARORrSEi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E171088D94; Sat, 12 Oct 2024 07:50:18 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D086188B64
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 07:50:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49C5oChR017118;
 Sat, 12 Oct 2024 00:50:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728712212;
 bh=jtiWAHIpLVm1oSNKKKVV+DfC8v1Bdd+B3UUa1/Ot6Wk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=ARORrSEiOjz6sk/8WBFTPkddyGFGtGJ6C30YOaxB8pTwo46sPsfqkZzMK7Az2PXwc
 Y1DJu2icni28LSeT9A7dBsMTRCD+AU/0XaPPpqymi9hFaqVlw5MxUk8WV5NrAf+OZb
 +oPKld6dy4sqclcc/xq45UGmG5BSdzfXXjvnl+Bo=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49C5oCxb084291
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 12 Oct 2024 00:50:12 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 12
 Oct 2024 00:50:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 12 Oct 2024 00:50:11 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49C5oAMs017685;
 Sat, 12 Oct 2024 00:50:11 -0500
Date: Sat, 12 Oct 2024 11:20:10 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <n-francis@ti.com>, 
 <a-limaye@ti.com>, <seanga2@gmail.com>, <sjg@chromium.org>,
 <marex@denx.de>, <john@phrozen.org>, <ansuelsmth@gmail.com>,
 <sumit.garg@linaro.org>, <u-boot@lists.denx.de>, <vigneshr@ti.com>,
 <srk@ti.com>
Subject: Re: [PATCH v2 1/2] pci: Add TI K3 Cadence PCIe Controller
Message-ID: <b2abe750-3bbe-4c95-8bf1-b1567cb2bb1a@ti.com>
References: <20241011130258.3452687-1-s-vadapalli@ti.com>
 <20241011130258.3452687-2-s-vadapalli@ti.com>
 <20241012011503.GC14210@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241012011503.GC14210@bill-the-cat>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On Fri, Oct 11, 2024 at 07:15:03PM -0600, Tom Rini wrote:

Hello Tom,

> On Fri, Oct 11, 2024 at 06:32:57PM +0530, Siddharth Vadapalli wrote:
> > Add support for the Cadence PCIe Controller present on TI's K3 SoCs.
> > This driver is an adaptation of the Linux driver.
> > 
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > ---
> >  drivers/pci/Kconfig        |   6 +
> >  drivers/pci/Makefile       |   1 +
> >  drivers/pci/pcie_cdns_ti.c | 851 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 858 insertions(+)
> >  create mode 100644 drivers/pci/pcie_cdns_ti.c
> 
> Please update MAINTAINERS somewhere for this.
> 
> > +#define CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED		0x0
> > +#define  CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_32BITS		0x4
> > +#define  CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_32BITS	0x5
> > +#define  CDNS_PCIE_LM_BAR_CFG_CTRL_MEM_64BITS		0x6
> > +#define  CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS	0x7
> 
> Here and maybe elsewhere, why the inconsistent indentation?

Thank you for reviewing the patch. I will add the MAINTAINERS entry and
make the indentation consistent in the v3 series.

Regards,
Siddharth.
