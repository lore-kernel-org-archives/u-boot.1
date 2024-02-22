Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33145C48BF8
	for <u-boot@archiver.kernel.org>; Thu, 22 Feb 2024 06:46:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6100787CCC;
	Thu, 22 Feb 2024 07:46:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hHkoXncs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11C3B87E03; Thu, 22 Feb 2024 07:46:08 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9496876F3
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 07:46:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41M6k0tl031441
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 00:46:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708584360;
 bh=epAOX5a2tst/LAUfVBjcK2Mhc/CMCI/qDvqvW3KaIIk=;
 h=From:To:CC:Subject:Date;
 b=hHkoXncsCd1LrQP4ezSjCSm0Yd/JWqZ/qcfpOh8egytXRT6jjc1TyeE0aZyCdJ+Ya
 +soJbueSPIQuT5kJUy7RbC9bYuiyYEyWSl/nP822tksyjSvscOlB/YK9Kj4V8iR4kd
 uFy9xN8cK0iB3i8LAcUlyl/zAK3yfESxL/M7w3tk=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41M6k0s2095651
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <u-boot@lists.denx.de>; Thu, 22 Feb 2024 00:46:00 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 00:45:59 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 00:45:59 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41M6jvxp087354;
 Thu, 22 Feb 2024 00:45:58 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <u-boot@lists.denx.de>, <afd@ti.com>, <nm@ti.com>
CC: <kamlesh@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH] arch: mach-k3: fix mapping higher DDR addresses as device
 memory
Date: Thu, 22 Feb 2024 12:15:56 +0530
Message-ID: <20240222064556.1051458-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

From: Sekhar Nori <nsekhar@ti.com>

An entry in memory map table for MMU configuration is spilling over and
inadvertently mapping DDR available at higher address (above 4GB address
space) as device memory (nGnRnE).

Fix this by adjusting entry size. Tested on AM62A SK by enabling
CONFIG_CMD_TIME. Before this patch:

=> time crc32 0x881000000 0x20000000
crc32 for 881000000 ... 8a0ffffff ==> 5a7a5760

time: 1 minutes, 14.715 seconds

After patch:

=> time crc32 0x881000000 0x20000000
crc32 for 881000000 ... 8a0ffffff ==> 3df1ce02

time: 2.711 seconds

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
[n-francis@ti.com: rebased on next, retested on all devices inc. commit]
Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
Cc: Andrew Davis <afd@ti.com>
---
Boot logs:
https://gist.github.com/nehamalcom/7b101ea8b97f5a9433a553ef881166a1

 arch/arm/mach-k3/arm64-mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/arm64-mmu.c b/arch/arm/mach-k3/arm64-mmu.c
index b4308205b2..0e07b1b7ce 100644
--- a/arch/arm/mach-k3/arm64-mmu.c
+++ b/arch/arm/mach-k3/arm64-mmu.c
@@ -41,7 +41,7 @@ struct mm_region k3_mem_map[] = {
 	}, {
 		.virt = 0x500000000UL,
 		.phys = 0x500000000UL,
-		.size = 0x400000000UL,
+		.size = 0x380000000UL,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
 			 PTE_BLOCK_NON_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-- 
2.34.1

