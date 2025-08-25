Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A058CA0EFA
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 13:34:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13F0883020;
	Mon, 25 Aug 2025 15:33:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DNDvtps3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ADED83071; Mon, 25 Aug 2025 15:33:56 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 141E082DA1
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:33:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57PDXqLF1302005;
 Mon, 25 Aug 2025 08:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756128832;
 bh=pEyl3qZCeKdwcwEeEreTS0qFA4fWU1zIW6ys3KAU76A=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=DNDvtps3Zm0Q31BhS1UmjO1ENJJU+hzhn3/Q0b9KWgStBWKHe+y9mSGAa/aSa3czu
 juWI354zcp9j7bX76U/H23Stl4HnxGpSq9b+CMy96G1xyTd2o1cfliHCH1Ftk2girx
 9k/2B8zUTscFre2nU8iNDS6r4Z3ETj2nWcmv7vZo=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57PDXqCP1208390
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 25 Aug 2025 08:33:52 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 25
 Aug 2025 08:33:51 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 25 Aug 2025 08:33:51 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57PDXoSL3682023;
 Mon, 25 Aug 2025 08:33:51 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <u-kumar1@ti.com>
Subject: [PATCH v1 2/2] config: arch: k3: enable DMA_ADDR_T_64BIT
Date: Mon, 25 Aug 2025 19:02:32 +0530
Message-ID: <20250825133233.2475300-3-anshuld@ti.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825133233.2475300-1-anshuld@ti.com>
References: <20250825133233.2475300-1-anshuld@ti.com>
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

