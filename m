Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC2EC19F32
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 17:14:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C36B5812BF;
	Thu, 27 Feb 2025 18:14:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="h9raW+iA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 339BE81417; Thu, 27 Feb 2025 18:14:47 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F42A8121A
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 18:14:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51RHEg3S2405948
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 27 Feb 2025 11:14:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740676482;
 bh=LNf507rfmxcZ2rLqmMdsyXd7BH3wx9Yi07uq6FATBwU=;
 h=From:Date:Subject:To:CC;
 b=h9raW+iAL1iALicsb87BkN+LFRAmgN87igHA2XM7RdgY04zTUjLsBNmMBamarOejK
 qSsHWvNgTPehq754T0sgKQUGyraDqbIbuFTo4xjnZezBiaoFK4K60vl+q4uw3Fe+UB
 /LtI8K3Y/MVXaZkWcJjIpfuE7Qm6UFG7ihnf8tY0=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51RHEgSZ013044;
 Thu, 27 Feb 2025 11:14:42 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Feb 2025 11:14:42 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Feb 2025 11:14:41 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51RHEfVa121020;
 Thu, 27 Feb 2025 11:14:41 -0600
From: Bryan Brattlof <bb@ti.com>
Date: Thu, 27 Feb 2025 11:14:41 -0600
Subject: [PATCH] mach-k3: common_fdt: create a reserved memory node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250227-reserved-memory-v1-1-638a6328884c@ti.com>
X-B4-Tracking: v=1; b=H4sIAICdwGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyNz3aJUoI6y1BTd3NTc/KJKXQvTNNMUEwPLVLNEcyWgroKi1LTMCrC
 J0bG1tQBWO4UkYQAAAA==
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.13.0
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

Some device trees may not have a reserved-memory node. Rather than
exiting early we should create a new reserved-memory node along with
the memory carveout for the firmware we (U-Boot) have placed.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/mach-k3/common_fdt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-k3/common_fdt.c b/arch/arm/mach-k3/common_fdt.c
index 4a01671156687..361b0c0b31b09 100644
--- a/arch/arm/mach-k3/common_fdt.c
+++ b/arch/arm/mach-k3/common_fdt.c
@@ -122,10 +122,8 @@ int fdt_fixup_reserved(void *blob, const char *name,
 
 	/* Find reserved-memory */
 	nodeoffset = fdt_subnode_offset(blob, 0, "reserved-memory");
-	if (nodeoffset < 0) {
-		debug("Could not find reserved-memory node\n");
-		return 0;
-	}
+	if (nodeoffset < 0)
+		goto add_carveout;
 
 	/* Find existing matching subnode and remove it */
 	fdt_for_each_subnode(subnode, blob, nodeoffset) {
@@ -154,6 +152,7 @@ int fdt_fixup_reserved(void *blob, const char *name,
 		}
 	}
 
+add_carveout:
 	struct fdt_memory carveout = {
 		.start = new_address,
 		.end = new_address + new_size - 1,

---
base-commit: b78f8677cde8b1dde31b66f5b780f2e9b62fba7f
change-id: 20250227-reserved-memory-85f5d409e6a7

Best regards,
-- 
Bryan Brattlof <bb@ti.com>

