Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5398CA0FED
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 08:20:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 893F283807;
	Fri,  5 Sep 2025 10:19:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IVT8XV2A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0528B83390; Fri,  5 Sep 2025 10:19:33 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD66E83900
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 10:19:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5858JOmr3211794;
 Fri, 5 Sep 2025 03:19:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757060364;
 bh=jZhv0Kh+PNcNRgetONtmT6IUGunxtYzvacE8pXtiCFg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=IVT8XV2AG/NReaRTfZH7A+Jj8r+OIyK5qByToFCbsAR9kGcOPxvRojzuimM/e6HrH
 uWNViXK1LDx4x+rytGljbushT0co9CO8rrRnilQxe8PVpcM9O5gf+KltHukWTuxvog
 ZlgLXHvD/cysbnQOJliX28zLZ28zPPdCAR6u3Yjo=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5858JO1Z1502299
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 5 Sep 2025 03:19:24 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 5
 Sep 2025 03:19:23 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 5 Sep 2025 03:19:23 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5858JMBH445408;
 Fri, 5 Sep 2025 03:19:23 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <d-gole@ti.com>, <b-padhi@ti.com>,
 <vigneshr@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <a-nandan@ti.com>, <afd@ti.com>, <bb@ti.com>,
 <u-kumar1@ti.com>, <devarsht@ti.com>, <ilias.apalodimas@linaro.org>
Subject: [PATCH -next v6 10/10] mach-k3: add carveouts for TFA and optee
Date: Fri, 5 Sep 2025 13:49:01 +0530
Message-ID: <20250905081902.489345-11-anshuld@ti.com>
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

K3 platforms have reserved memory regions for TFA and OPTEE which should
be unmapped for U-Boot.

Therefore this patch adds the necessary fdt fixups to properly set the
load address for TFA/OPTEE and unmaps both by mmu_unmap_reserved_mem.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/common.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 9c2fe92cf25..71fc7d31abe 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -31,6 +31,7 @@
 #include <dm/uclass-internal.h>
 #include <dm/device-internal.h>
 #include <asm/armv8/mmu.h>
+#include <mach/k3-common-fdt.h>
 #include <mach/k3-ddr.h>
 
 #define PROC_BOOT_CTRL_FLAG_R5_CORE_HALT	0x00000001
@@ -263,6 +264,7 @@ void board_prep_linux(struct bootm_headers *images)
 
 void enable_caches(void)
 {
+	void *fdt = (void *)gd->fdt_blob;
 	int ret;
 
 	ret = mem_map_fix_dram_banks(K3_MEM_MAP_FIRST_BANK_IDX, K3_MEM_MAP_LEN,
@@ -273,6 +275,30 @@ void enable_caches(void)
 
 	mmu_setup();
 
+	if (CONFIG_K3_ATF_LOAD_ADDR >= CFG_SYS_SDRAM_BASE) {
+		ret = fdt_fixup_reserved(fdt, "tfa", CONFIG_K3_ATF_LOAD_ADDR,
+					 0x80000);
+		if (ret)
+			debug("%s: Failed to perform tfa fixups (%s)\n",
+			      __func__, fdt_strerror(ret));
+		ret = mmu_unmap_reserved_mem("tfa");
+		if (ret)
+			debug("%s: Failed to unmap tfa rsvd mem (%s)\n",
+			      __func__, fdt_strerror(ret));
+	}
+
+	if (CONFIG_K3_OPTEE_LOAD_ADDR >= CFG_SYS_SDRAM_BASE) {
+		ret = fdt_fixup_reserved(fdt, "optee",
+					 CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
+		if (ret)
+			debug("%s: Failed to perform optee fixups (%s)\n",
+			      __func__, fdt_strerror(ret));
+		ret = mmu_unmap_reserved_mem("optee");
+		if (ret)
+			debug("%s: Failed to unmap optee rsvd mem (%s)\n",
+			      __func__, fdt_strerror(ret));
+	}
+
 	icache_enable();
 	dcache_enable();
 }
-- 
2.50.1

