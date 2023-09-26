Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEB5E7D242
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 07:17:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5AE386C2D;
	Tue, 26 Sep 2023 09:17:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="R4u1uca6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AE9386C32; Tue, 26 Sep 2023 09:17:09 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBA0686C1D
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 09:17:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 278983F70B; 
 Tue, 26 Sep 2023 07:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1695712625;
 bh=Eu80RTEXrYmByi1rKn2ZVMjSzRmmbO9bmrWZA2u/NBs=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=R4u1uca6zMnRmF7snzzvo+M8j2/2ih+2Cqczf8D6zeYw3CdxrKRV5/u7eK+PN1xup
 G0P+Z7pCJPkn4e0luxPDgUw9a64IX6pmu+3ySL773rtjGUTORvGUizlbOeuhdrzqxi
 khPaTSOJF7T/MK1FBXPM9N2h4XLSOfvbHo+v8ccogIt/yOoYBA7OgbAToboC5lJtgz
 B6mRT07AbY8mElAnLE+hzhsqkojtYBf3MIeYKrFbSmhGJVqeDaE1wG8xSMweFP8/PX
 Yby1U7coYhxoHu5cRnGQ0UzH2RNfnNVn/k7UvVNUnV+KYxs4FXAtiRauLR/G5/Pa6b
 p7GVUuso2uSYw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Anup Patel <apatel@ventanamicro.com>,
 Fei Wu <fei2.wu@intel.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] riscv: remove dram_init_banksize()
Date: Tue, 26 Sep 2023 09:16:34 +0200
Message-Id: <20230926071634.22016-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Remove dram_init_banksize() on the architecture level.

Limiting used RAM to under 4 GiB is only necessary for CPUs which have a
DMA issue. SoC specific code already exists for FU540, FU740, JH7110.

Not all RISC-V boards will have memory below 4 GiB.

A weak implementation of dram_init_banksize() exists in common/board_f.c.

See the discussion in
https://lore.kernel.org/u-boot/545fe813-cb1e-469c-a131-0025c77aeaa2@canonical.com/T/

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/cpu/generic/dram.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/riscv/cpu/generic/dram.c b/arch/riscv/cpu/generic/dram.c
index 94d8018407..1b51bae9b6 100644
--- a/arch/riscv/cpu/generic/dram.c
+++ b/arch/riscv/cpu/generic/dram.c
@@ -20,19 +20,3 @@ int dram_init_banksize(void)
 {
 	return fdtdec_setup_memory_banksize();
 }
-
-phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
-{
-	/*
-	 * Ensure that we run from first 4GB so that all
-	 * addresses used by U-Boot are 32bit addresses.
-	 *
-	 * This in-turn ensures that 32bit DMA capable
-	 * devices work fine because DMA mapping APIs will
-	 * provide 32bit DMA addresses only.
-	 */
-	if (gd->ram_top >= SZ_4G)
-		return SZ_4G - 1;
-
-	return gd->ram_top;
-}
-- 
2.40.1

