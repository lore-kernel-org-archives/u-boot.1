Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E6CC369AE
	for <u-boot@archiver.kernel.org>; Sat, 12 Apr 2025 17:04:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 704B182DB0;
	Sat, 12 Apr 2025 19:04:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uQV3E/EM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D607082DB0; Sat, 12 Apr 2025 19:04:18 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF49D82D0C
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 19:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53CH4DxS2385711
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 12 Apr 2025 12:04:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744477453;
 bh=gG7qh/vdaz6EVdrZxg162TorPcU1ma3Fkrn7bfp1ocs=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=uQV3E/EMZRLLu0zZYgr6KB8w5sTCY+CG3GLE0RsHleAY0/JEA6D0sYYDaPNOqOnmk
 zm6Qvdg3Ox2Up3BwOmCfB4UaxeDYbp5H9KTJfHSWUZ7eKK1UJSlbKS7yl70GDAwU1W
 AE96ZuOa6OHL9H6/fpRpHN/35lGS8gRojRV0XL7Y=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53CH4Dtb031622
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 12 Apr 2025 12:04:13 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 12
 Apr 2025 12:04:12 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 12 Apr 2025 12:04:12 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53CH4Cd5025584;
 Sat, 12 Apr 2025 12:04:12 -0500
Date: Sat, 12 Apr 2025 12:04:12 -0500
From: Bryan Brattlof <bb@ti.com>
To: Judith Mendez <jm@ti.com>
CC: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 0/5] More MMC fixes
Message-ID: <20250412170412.7empydbi3dtltjs5@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250408170527.2832563-1-jm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250408170527.2832563-1-jm@ti.com>
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

On April  8, 2025 thus sayeth Judith Mendez:
> This patch series fixes MMC_HS_52 mode in am654_sdhci
> driver, as well as HIGH_SPEED_ENA and UHS_MODE_SELECT
> for HS modes.
> 
> Also Disable eMMC HS400 mode for am62px device according
> to silicon errata i2458 [0] and add TI_COMMON_CMD_OPTIONS
> to K3 Sitara board a53 defconfigs. 
> 
> [0] https://www.ti.com/lit/er/sprz574a/sprz574a.pdf
> 
> Judith Mendez (5):
>   mmc: am654_sdhci: Add MMC_HS_52 to timing data
>   mmc: am654_sdhci: Fix HIGH_SPEED_ENA
>   mmc: am654_sdhci: Add am654_sdhci_set_control_reg
>   configs: am62px_evm_r5/a53_defconfig: Disable eMMC HS400
>   configs: am62*_evm_a53_defconfig: Add TI_COMMON_CMD_OPTIONS

This last patch wasn't applying cleanly for me :/ Just needs a simple 
fixup when we rebase. Other than that this series looks good to me!

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan
