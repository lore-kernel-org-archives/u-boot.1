Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369C1C4706C
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 19:17:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3B5B878C9;
	Tue,  9 Jan 2024 20:17:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Aoki+fZE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B663B8790F; Tue,  9 Jan 2024 20:17:30 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F8CA8785F
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 20:17:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 409JHMe5008314;
 Tue, 9 Jan 2024 13:17:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704827842;
 bh=9OO99fGizrR76X4Dh7UQFv0PjyRHQ1vesd1NTwLCZNM=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Aoki+fZE2IOspUFmHzGR5ZS7heeITu4ZN0wrK6A6VlW11dyxWw8DatlVsNnQXIOS7
 wU5RmDB2EPp2syfo/OlJ1EWMnOhMBgQb+0v5+nZUQ4isbGfgtsBqC6Hzkh5nwaJGgd
 dYZksXz6fVeLPuRBnZfRxtrDrzcNoLcAQcforpN8=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 409JHM6X028771
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 9 Jan 2024 13:17:22 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Jan 2024 13:17:22 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Jan 2024 13:17:22 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 409JHMCk074751;
 Tue, 9 Jan 2024 13:17:22 -0600
Date: Tue, 9 Jan 2024 13:17:22 -0600
From: Nishanth Menon <nm@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: <trini@konsulko.com>, <michael@amarulasolutions.com>,
 <dario.binacchi@amarulasolutions.com>, <afd@ti.com>, <vigneshr@ti.com>,
 <praneeth@ti.com>, <srk@ti.com>, <r-gunasekaran@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 0/4] arm: mach-k3: am64: Add NAND configuration
Message-ID: <20240109191722.wkd2px7mveylz6ue@cautious>
References: <20240109122605.51951-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240109122605.51951-1-rogerq@kernel.org>
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

On 14:26-20240109, Roger Quadros wrote:
> Hi,
> 
> AM64-EVM [1] supports NAND via expansion card.
> 
> This series fixes the GPMC memory and NAND drivers
> and provides NAND configuration for AM642 platform.
> 
> The extension card support and NAND DT overlay is
> still missing so NAND is not yet functional just with
> this series.
> 
> It was tested with NAND overlay [2] manually applied to base
> AM64-EVM DT.
> 
> CI test results are available at
> https://github.com/u-boot/u-boot/pull/460
> 
> [1] https://www.ti.com/tool/TMDS64EVM
> [2] https://lore.kernel.org/all/20230923080046.5373-2-rogerq@kernel.org/
> 
> Roger Quadros (4):
>   memory: ti-gpmc: Fix build
>   mtd: rawnand: omap_gpmc: Use DT provided IO address
>   arm: mach-k3: am642: Define NAND boot device
>   configs: am64x_evm_a53_defconfig: Enable NAND
> 
>  arch/arm/mach-k3/am642_init.c            |  3 +++
>  arch/arm/mach-k3/include/mach/am64_spl.h |  1 +
>  configs/am64x_evm_a53_defconfig          | 32 ++++++++++++++++++++++++
>  drivers/memory/ti-gpmc.c                 |  2 +-
>  drivers/mtd/nand/raw/omap_gpmc.c         | 19 ++++++++++----
>  5 files changed, 51 insertions(+), 6 deletions(-)

Please update am64x documentation as well. People will need to know
how to actually build, flash and use it.

> 
> 
> base-commit: c2c598e87cfe56f5991730762c00733c5aa9a994
> prerequisite-patch-id: e0465f3e924302d1c4bd47f2129b4eb3bd9faead
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
