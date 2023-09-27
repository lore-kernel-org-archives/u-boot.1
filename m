Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEBAE80AA4
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 13:43:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E986486D38;
	Wed, 27 Sep 2023 15:43:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tq-group.com header.i=@tq-group.com header.b="itcEvkqn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A13586DDE; Wed, 27 Sep 2023 15:43:40 +0200 (CEST)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CB9B86D20
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 15:43:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=matthias.schiffer@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1695822218; x=1727358218;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=NjegQrVvmy8Sx280KqdboXTEIUyVL15AW38/r2ygKrk=;
 b=itcEvkqn48KV854GSdY213rbLuZnQTueB4L1JKy9WUAKTiPHZ5tPBRxJ
 swrGsL0Z7xGL5Db5Hm+338nxCI/PqCqAuUJRAlDJK6RGaqdL8fYstXrav
 6ujSjKRKhsng6jHr4mLD+5bqhJVr2Ym0OA4bAzWUzOm2t2AphF/hF6KWL
 DhD9WIrUSoeQBcV1yTuT3+8gNmvgz8hhp2c8K64myJoxK15ceks+spizo
 SBHWo9lG+3HosljmEnWHgS7Eljfq1Q2RfnAhCeHNX9FAeLErOu1KBbQfp
 skktg7o3Kv+W+yG4Gr82OhMLN5Crok717UuN8fc+Vd7QDNJzURWpoCo5o Q==;
X-IronPort-AV: E=Sophos;i="6.03,181,1694728800"; d="scan'208";a="33178995"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
 by mx1.tq-group.com with ESMTP; 27 Sep 2023 15:43:37 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.20])
 by vtuxmail01.tq-net.de (Postfix) with ESMTPA id B8B15280075;
 Wed, 27 Sep 2023 15:43:37 +0200 (CEST)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Andrew Davis <afd@ti.com>,
	Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, u-boot@ew.tq-group.com,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH] arm: mach-k3: common: fix compile warnings with PHYS_64BIT on
 32bit
Date: Wed, 27 Sep 2023 15:43:14 +0200
Message-Id: <20230927134314.379254-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Use uintptr_t instead of phys_addr_t where appropriate, so passing the
addresses to writel() doesn't result in compile warnings when PHYS_64BIT
is set for 32bit builds (which is actually a useful configuration, as
the K3 SoC family boots from an R5 SPL, which may pass bank information
based on gd->bd->bi_dram to fdt_fixup_memory_banks() etc., so PHYS_64BIT
is needed for fixing up the upper bank).

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 arch/arm/mach-k3/common.c | 4 ++--
 arch/arm/mach-k3/common.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index a35110429b2..9b90b2fa11c 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -83,10 +83,10 @@ void k3_sysfw_print_ver(void)
 	       ti_sci->version.firmware_revision, fw_desc);
 }
 
-void mmr_unlock(phys_addr_t base, u32 partition)
+void mmr_unlock(uintptr_t base, u32 partition)
 {
 	/* Translate the base address */
-	phys_addr_t part_base = base + partition * CTRL_MMR0_PARTITION_SIZE;
+	uintptr_t part_base = base + partition * CTRL_MMR0_PARTITION_SIZE;
 
 	/* Unlock the requested partition if locked using two-step sequence */
 	writel(CTRLMMR_LOCK_KICK0_UNLOCK_VAL, part_base + CTRLMMR_LOCK_KICK0);
diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
index 9bd9ad6d1a0..eabb44f6204 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -38,7 +38,7 @@ void remove_fwl_configs(struct fwl_data *fwl_data, size_t fwl_data_size);
 int load_firmware(char *name_fw, char *name_loadaddr, u32 *loadaddr);
 void k3_sysfw_print_ver(void);
 void spl_enable_dcache(void);
-void mmr_unlock(phys_addr_t base, u32 partition);
+void mmr_unlock(uintptr_t base, u32 partition);
 bool is_rom_loaded_sysfw(struct rom_extended_boot_data *data);
 enum k3_device_type get_device_type(void);
 void ti_secure_image_post_process(void **p_image, size_t *p_size);
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

