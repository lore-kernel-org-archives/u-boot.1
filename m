Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D8DE7719A
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 04:25:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 649498007D;
	Mon, 13 Jan 2025 05:25:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XaAuRIPo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3D9880141; Mon, 13 Jan 2025 05:25:37 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF66980027
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 05:25:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 50D4PX7A005489;
 Sun, 12 Jan 2025 22:25:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1736742333;
 bh=4eIJ79ybHY36xC5QdZ3T16LSxvHIbaYEDKJ7jQvAZYk=;
 h=From:To:CC:Subject:Date;
 b=XaAuRIPo1zDrLnaCv1pncTpc5ME076FzrSx6ZopWHEquA8QVU2egnPmQPW4/D+PFR
 bqzsZ7whjbJ7mBtxp2p8a5VR2EsEIbSzBE8dnK1qTmtL7Pe1cZ2ma2Tvfewx/Jswq+
 +KpdzUbTtRtNkvnDMVnJg84wTKV8mK4MQVOG03rE=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50D4PXnm026316
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 12 Jan 2025 22:25:33 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 12
 Jan 2025 22:25:32 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 12 Jan 2025 22:25:32 -0600
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.6])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50D4PTev002677;
 Sun, 12 Jan 2025 22:25:30 -0600
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>, <bb@ti.com>
CC: <nm@ti.com>, <afd@ti.com>, <u-boot@lists.denx.de>, <vigneshr@ti.com>, Udit
 Kumar <u-kumar1@ti.com>, Neha Malcom Francis <n-francis@ti.com>
Subject: [PATCH] arch: arm: mach-k3: Delete tifs node in DT fixup
Date: Mon, 13 Jan 2025 09:55:24 +0530
Message-ID: <20250113042524.219522-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
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

Delete tifs DT node as part of fixup.

TISCI API reported msmc_size, does not include 64KB reserved size for
tifs aka MSMC comms memory, see documentation[0].

As part of fixup, original code uses TISCI API reported msmc_size as
size for SRAM DT node.

tifs node is similar to l3-cache, which should hold address above
msmc_size, and should be deleted before passing control to OS.

[0] https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/general/core.html?highlight=msmc#tisci-msg-query-msmc

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
RFC was sent to k.org with https://lore.kernel.org/all/20230506100826.1525641-1-u-kumar1@ti.com/
So planning to go ahead with option 1.

Changelog:
Changes in v3:
- Collected R/B of v2
- Updated commit message typo

Changes since v2:
- moved tifs check above l3 as

v2: https://lore.kernel.org/all/20230420081128.3617214-1-u-kumar1@ti.com/
v1: https://lore.kernel.org/all/20230419061352.3156023-1-u-kumar1@ti.com/

 arch/arm/mach-k3/common_fdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-k3/common_fdt.c b/arch/arm/mach-k3/common_fdt.c
index 3bdedd7b50..4a01671156 100644
--- a/arch/arm/mach-k3/common_fdt.c
+++ b/arch/arm/mach-k3/common_fdt.c
@@ -65,6 +65,7 @@ static int fdt_fixup_msmc_ram(void *blob, char *parent_path, char *node_name)
 		      subnode, addr, size);
 		if (addr + size > msmc_size ||
 		    !strncmp(fdt_get_name(blob, subnode, &len), "sysfw", 5) ||
+		    !strncmp(fdt_get_name(blob, subnode, &len), "tifs", 4)  ||
 		    !strncmp(fdt_get_name(blob, subnode, &len), "l3cache", 7)) {
 			fdt_del_node(blob, subnode);
 			debug("%s: deleting subnode %d\n", __func__, subnode);
-- 
2.34.1

