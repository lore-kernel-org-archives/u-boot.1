Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273ABCA1005
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 09:42:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37DC383AAC;
	Tue,  2 Sep 2025 11:42:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wOEsJPMH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8BFB83A92; Tue,  2 Sep 2025 11:42:13 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC3588329F
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 11:42:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5829g9s42956362;
 Tue, 2 Sep 2025 04:42:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756806129;
 bh=pEyl3qZCeKdwcwEeEreTS0qFA4fWU1zIW6ys3KAU76A=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=wOEsJPMHwRy6cP1NVXW9dPnWnR2+HTSz5ZR+7QTv5SDoiNIgZEEqROBekTp2FN/Az
 B2acUqfTi2Tdb6OdDg6nRYWTwZH4a048+uP3Hmn6yRv7RVAwP76YsLPI6k1goUDlsS
 G0pqnhQHWIff94sH4cviO2JPDwngbLsAQb5Ue1P0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5829g9ZN2188759
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 2 Sep 2025 04:42:09 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 2
 Sep 2025 04:42:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 2 Sep 2025 04:42:09 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5829g8l63870474;
 Tue, 2 Sep 2025 04:42:08 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <u-kumar1@ti.com>, <p-mantena@ti.com>
Subject: [PATCH v2 2/2] config: arch: k3: enable DMA_ADDR_T_64BIT
Date: Tue, 2 Sep 2025 15:10:36 +0530
Message-ID: <20250902094037.2121393-3-anshuld@ti.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250902094037.2121393-1-anshuld@ti.com>
References: <20250902094037.2121393-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

ARCH_K3 encompasses both 32 and 64-bit cores on the same SoC, though the
DMA addresses are always 64-bit in size.

With the current implementation, the R5 SPL uses a u32 for dma_addr_t
which leads to data overflow when functions such as k3_nav_*_pop_mem try
to write a 64-bit address to dma_addr_t variable.

In certain cases it leads to stack corruption which manifest as boot
failures on certain compilers, such as SPI boot on GCC 14.2 or 13.3.

Therefore this patch selects CONFIG_DMA_ADDR_T_64BIT for all ARCH_K3.

Fixes: ffcc66e8fec5 ("dma: ti: add driver to K3 UDMA")
Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 40368abc297..16db046f4b8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -833,6 +833,7 @@ config ARCH_K3
 	select FIT
 	select REGEX
 	select FIT_SIGNATURE if ARM64
+	select DMA_ADDR_T_64BIT
 	select LTO
 	imply TI_SECURE_DEVICE
 	imply DM_RNG if ARM64
-- 
2.50.1

