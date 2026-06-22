Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B340CD4F26
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 06:59:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D493849BD;
	Tue, 23 Jun 2026 08:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="0nV+Gp+v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A71D6849BA; Mon, 22 Jun 2026 21:43:36 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C662848EB
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 21:43:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=62683ec8b=Charles.Perry@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1782157414; x=1813693414;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=WkVMqIh5A1GdO+UsVUsLLb76pLAZW5W7zGf81KQ581I=;
 b=0nV+Gp+vlriU+Xicar4mcRqU+s9k0iF0I+OakVfK9rzX07E+JyVzshCV
 27f+/Kya8DebjdZN6GB61RL/HWMtUXoI0c8/+SW6/FbO5ATizs0fLLsfE
 E506VfgZ8pglHX5mO5gIXehKeNtIRuTkrNxa3cbF71vM8J0lVvJaLjLZr
 uh0U+/8Pw4tbVvyeZp5PJerPGzx5/LrEBTFROOnsEx3sBu1UVAZTVaqJN
 iSqfiL8mVMyD5Q/PKNsOCxDwETvT2XimGEKrytxSkvZd6E/iBZFMgmp1a
 ftYKVHESVXSPAwv3WWwXNjIx9y1tFszJARuZ//U5bYRVENzw2O76SfnXy w==;
X-CSE-ConnectionGUID: NYlbG8noR/ONL3P1tXBknQ==
X-CSE-MsgGUID: xUQ+t7cPS5OE4q11Z5ay/w==
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; d="scan'208";a="58667736"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 12:43:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 22 Jun 2026 12:43:32 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 22 Jun 2026 12:43:31 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <u-boot@lists.denx.de>
CC: Charles Perry <charles.perry@microchip.com>, Rick Chen
 <rick@andestech.com>, Leo <ycliang@andestech.com>, Tom Rini
 <trini@konsulko.com>, Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: [PATCH] riscv: remove log_debug() in enable_caches()
Date: Mon, 22 Jun 2026 12:43:07 -0700
Message-ID: <20260622194308.70639-1-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:59:38 +0200
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

log_debug() cannot be used before log_init() has been called. Remove the
log_debug() statement in enable_caches() since it is called after
log_init() in initcall_run_r().

This fixes a bug where a RISC-V system which does not have the "zicbom"
extension (such as PIC64-HPSC/HX) would get lost in an infinite loop in
log_dispatch().

Fixes: 9e859849e2ca ("riscv: cache: Add CBO instructions")
Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
 arch/riscv/lib/cache.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/lib/cache.c b/arch/riscv/lib/cache.c
index 31aa30bc7d72..ac5136fa6bec 100644
--- a/arch/riscv/lib/cache.c
+++ b/arch/riscv/lib/cache.c
@@ -149,8 +149,6 @@ __weak int dcache_status(void)
 __weak void enable_caches(void)
 {
 	zicbom_block_size = riscv_get_cbom_block_size();
-	if (!zicbom_block_size)
-		log_debug("Zicbom not initialized.\n");
 }
 
 int __weak pgprot_set_attrs(phys_addr_t addr, size_t size, enum pgprot_attrs perm)
-- 
2.47.3

