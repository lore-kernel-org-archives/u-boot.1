Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63AE0CDB474
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 02:58:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B7B786A4C;
	Fri, 13 Oct 2023 03:59:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="e4m7TCTe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4775D86CE5; Fri, 13 Oct 2023 03:33:13 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B042885423
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 03:28:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39D1S6I5129259;
 Thu, 12 Oct 2023 20:28:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697160486;
 bh=y580FiCRsNgazpHKX8SulE69/MwIPOan7nZ1xXN/TLw=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=e4m7TCTeiDVlez2e5FUMivBrCjg2NCaK8q1EUONRRYFoUTSDj86rQrtaPcK2E509g
 X6LNrqOm9kdqX31C6FHu02ZCUwzNEnxwf9+FwAvgLs4F8NZmmX4TpA3GVP6NFz2cg4
 88wOa9l9gqCixH0O+NGcdS/2Qu4OjNzkSfilOT9c=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39D1S6mc008246
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 12 Oct 2023 20:28:06 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 12
 Oct 2023 20:28:06 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 12 Oct 2023 20:28:06 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39D1S6FL093275;
 Thu, 12 Oct 2023 20:28:06 -0500
Date: Thu, 12 Oct 2023 20:28:06 -0500
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Hari
 Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson
 <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 05/11] arch: mach-k3: introduce basic files to support
 the am62px SoC family
Message-ID: <20231013012806.cpxe5qnsztcyasv5@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20231012230616.2101992-13-bb@ti.com>
 <20231012230616.2101992-18-bb@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20231012230616.2101992-18-bb@ti.com>
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

On October 12, 2023 thus sayeth Bryan Brattlof:
> Introduce the basic functions and definitions needed to properly
> initialize TI's am62p family of SoCs
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>  arch/arm/mach-k3/Kconfig                      |   6 +-
>  arch/arm/mach-k3/Makefile                     |   2 +
>  arch/arm/mach-k3/am62p5_init.c                | 261 ++++++++++++++++++
>  arch/arm/mach-k3/am62px/clk-data.c            |  10 +
>  arch/arm/mach-k3/am62px/dev-data.c            |  50 ++--

These clk and dev file changes should have gone into 02/11 where I added 
everything else.

~Bryan

>  arch/arm/mach-k3/arm64-mmu.c                  |   5 +-
>  .../arm/mach-k3/include/mach/am62p_hardware.h |  83 ++++++
>  arch/arm/mach-k3/include/mach/am62p_spl.h     |  49 ++++
>  arch/arm/mach-k3/include/mach/hardware.h      |   4 +
>  arch/arm/mach-k3/include/mach/spl.h           |   4 +
>  10 files changed, 447 insertions(+), 27 deletions(-)
>  create mode 100644 arch/arm/mach-k3/am62p5_init.c
>  create mode 100644 arch/arm/mach-k3/include/mach/am62p_hardware.h
>  create mode 100644 arch/arm/mach-k3/include/mach/am62p_spl.h
> 
