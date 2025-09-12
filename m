Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335CDCAC58F
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 12:17:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E8B883496;
	Fri, 12 Sep 2025 14:16:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="G1xZtWYY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C77C8346A; Fri, 12 Sep 2025 14:16:34 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB8DC83443
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 14:16:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58CCGTKD600602;
 Fri, 12 Sep 2025 07:16:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757679389;
 bh=M7V4ZgaE71WliAhx49Bk5aH4jr/mYN6fetLRzUcY2uY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=G1xZtWYYHexMcZlzU2rp3fqeljhnS2UkLvmUJfMB/Nr3gnApsf/BSveQcn1XsOyfx
 G2fbD8T+Jm+LyCgUyjmwSF1p8VOgs0LCvO68PyX/F6sYyFMcejSL+lARhc9ZMII3Fz
 8A9ebOlbQWt07pZfd88qoBem38r0K/wQkNgHEqBg=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58CCGTp51965964
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 12 Sep 2025 07:16:29 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 12
 Sep 2025 07:16:28 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 07:16:28 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58CCGRA13886171;
 Fri, 12 Sep 2025 07:16:28 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <d-gole@ti.com>, <b-padhi@ti.com>,
 <vigneshr@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <bb@ti.com>, <u-kumar1@ti.com>,
 <devarsht@ti.com>, <ilias.apalodimas@linaro.org>
Subject: [PATCH -next v7 04/10] arm: armv8: invalidate dcache entries on
 dcache_enable
Date: Fri, 12 Sep 2025 17:46:11 +0530
Message-ID: <20250912121618.1074054-5-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912121618.1074054-1-anshuld@ti.com>
References: <20250912121618.1074054-1-anshuld@ti.com>
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

In dcache_enable, currently the dcache entries are only invalidated when
the MMU is not enabled. This causes issues when dcache_enable is called
with the MMU already configured, in such cases the existing dcache
entries are not flushed which might result in un-expected behavior.

This patch invalidates the cache entries on every call of dcache_enable
before enabling dcache (by setting CR_C). This makes dcache_enable
behave similar to icache_enable as well.

Reviewed-by: Dhruva Gole <d-gole@ti.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Anshul Dalal <anshuld@ti.com>
Tested-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/cpu/armv8/cache_v8.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 1c1e33bec24..6e662395a83 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -830,16 +830,15 @@ void flush_dcache_range(unsigned long start, unsigned long stop)
 void dcache_enable(void)
 {
 	/* The data cache is not active unless the mmu is enabled */
-	if (!(get_sctlr() & CR_M)) {
-		invalidate_dcache_all();
-		__asm_invalidate_tlb_all();
+	if (!mmu_status())
 		mmu_setup();
-	}
 
 	/* Set up page tables only once (it is done also by mmu_setup()) */
 	if (!gd->arch.tlb_fillptr)
 		setup_all_pgtables();
 
+	invalidate_dcache_all();
+	__asm_invalidate_tlb_all();
 	set_sctlr(get_sctlr() | CR_C);
 }
 
-- 
2.51.0

