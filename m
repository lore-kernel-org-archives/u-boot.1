Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43728CA1015
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 08:19:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EC3B838F0;
	Fri,  5 Sep 2025 10:19:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RFmVzGse";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37E75838D5; Fri,  5 Sep 2025 10:19:22 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F97983390
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 10:19:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5858JD4v3668926;
 Fri, 5 Sep 2025 03:19:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757060353;
 bh=3eGO5qk9KSey8Nflz+0xLVVqmIr3r+CtMbaLT2JtDSM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=RFmVzGsesvxIyPsAarWQkhPAddMtTwqX4P8qjPUKAssymxYX6ZKee2CJBPobYGOTj
 FNaOgWOpzoPQe3oDTusAxO8yuEeR6GOuc/XUir+hyjhiQ1aYsaRh3VFyNEMafqDRkE
 JhOJP12vWQwwNELYDZWk3DYdXTUOhx7ORKMO9x8k=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5858JDP61502085
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 5 Sep 2025 03:19:13 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 5
 Sep 2025 03:19:12 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 5 Sep 2025 03:19:12 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5858JBAk445287;
 Fri, 5 Sep 2025 03:19:11 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <d-gole@ti.com>, <b-padhi@ti.com>,
 <vigneshr@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <a-nandan@ti.com>, <afd@ti.com>, <bb@ti.com>,
 <u-kumar1@ti.com>, <devarsht@ti.com>, <ilias.apalodimas@linaro.org>
Subject: [PATCH -next v6 04/10] arm: armv8: invalidate dcache entries on
 dcache_enable
Date: Fri, 5 Sep 2025 13:48:55 +0530
Message-ID: <20250905081902.489345-5-anshuld@ti.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250905081902.489345-1-anshuld@ti.com>
References: <20250905081902.489345-1-anshuld@ti.com>
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

Signed-off-by: Anshul Dalal <anshuld@ti.com>
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
2.50.1

