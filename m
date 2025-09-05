Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17304CA1015
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 08:19:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84E7A838A0;
	Fri,  5 Sep 2025 10:19:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nGGx3lc7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 215D583390; Fri,  5 Sep 2025 10:19:14 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E53F283390
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 10:19:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5858J9dJ3710708;
 Fri, 5 Sep 2025 03:19:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757060349;
 bh=30Ij8pxP+QsFKCtyEKCgjp7QzoHCHeb4Uef2I8ULcX0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=nGGx3lc7d7PVxNS2+5rlZkrzMYVWq+58wWItyFTSWHEMHOMEcJ4WRJ8NNQr72Jlns
 1m9OZC05Wp/BgIT2xfZmBgj2J6apSQimeE3fGBk9m3bDEOZ1BCNszYYFeSX46AeROK
 QT5myP63MgjB0rF0ZXS07jXIQarfeWLgPHzOiaQg=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5858J90X230673
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 5 Sep 2025 03:19:09 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 5
 Sep 2025 03:19:08 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 5 Sep 2025 03:19:08 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5858J74I445193;
 Fri, 5 Sep 2025 03:19:08 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <d-gole@ti.com>, <b-padhi@ti.com>,
 <vigneshr@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <a-nandan@ti.com>, <afd@ti.com>, <bb@ti.com>,
 <u-kumar1@ti.com>, <devarsht@ti.com>, <ilias.apalodimas@linaro.org>
Subject: [PATCH -next v6 02/10] mach-k3: use custom enable_cache
Date: Fri, 5 Sep 2025 13:48:53 +0530
Message-ID: <20250905081902.489345-3-anshuld@ti.com>
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

U-Boot's provided enable_caches enforces the following sequence:
icache_enable -> mmu_setup (as part of dcache_enable) -> dcache_enable

Whereas for K3 devices, we would like to add entries to the provided
static array (k3_mem_map) as per gd->bd->bi_dram and then call mmu_setup
to configure the MMU but also create carveouts for TFA/TEE before we
enable caches to prevent speculative accesses to the region. Thus the
following desired sequence:

add dram banks -> mmu_setup -> carveout TFA/TEE -> icache/dcache enable

Therefore this patch adds K3's own implementation of enable_cache for
ARM64, allowing for greater control over the cache enablement sequence.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/common.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index f8c53b286eb..9d6c6fea451 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -258,6 +258,12 @@ void board_prep_linux(struct bootm_headers *images)
 				 ROUND(images->os.end,
 				       CONFIG_SYS_CACHELINE_SIZE));
 }
+
+void enable_caches(void)
+{
+	icache_enable();
+	dcache_enable();
+}
 #endif
 
 void spl_enable_cache(void)
-- 
2.50.1

