Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58751C30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 05:20:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19C548841E;
	Tue,  2 Jul 2024 07:20:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dyljPWzu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9BC48871C; Tue,  2 Jul 2024 07:20:32 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AFD7883D9
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 07:20:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4625KSED063532;
 Tue, 2 Jul 2024 00:20:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1719897628;
 bh=vUlPIQ2dPOv8BWO0RRKaF13Cln7YGxuuIwvoUwetfe0=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=dyljPWzuytaEJkfZAa7CoQhjnz+pZ/06KvjEoaHpMS7RYTFfIrRNRdVPIAHePwCr9
 JesGzXK8/axP6dCqU8OwjechhITkzGQOA45grYVaSsxSlUQlXXJ/bk8HS7iEwcm/+O
 AEDQnRRBs0bO0xrkF72bgrUzvCKhlg9hJs7ZYcoE=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4625KSEs025336
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 2 Jul 2024 00:20:28 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Jul 2024 00:20:28 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Jul 2024 00:20:28 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4625KKsK070700;
 Tue, 2 Jul 2024 00:20:25 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 2 Jul 2024 10:50:01 +0530
Subject: [PATCH v3 1/4] board: ti: am62p|j722s: Add ti_set_fdt_env for fdtfile
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240702-b4-upstream-streamline-platform-v3-1-0ebd7bbd31d5@ti.com>
References: <20240702-b4-upstream-streamline-platform-v3-0-0ebd7bbd31d5@ti.com>
In-Reply-To: <20240702-b4-upstream-streamline-platform-v3-0-0ebd7bbd31d5@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, Tom
 Rini <trini@konsulko.com>, Vaishnav Achath <vaishnav.a@ti.com>, Jayesh
 Choudhary <j-choudhary@ti.com>, Joe Hershberger <joe.hershberger@ni.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishanth
 Menon <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Dhruva Gole <d-gole@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719897620; l=1492;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=xXSFpHKx0+MO1hJQBgocDWD1NhUXeFozu0V0pj1XnvY=;
 b=hpiMRdYC2VMKxKOAjl95h51bvRw28dpYwOMppHIZNpkeKHD6m/OiNXziyKWiCCfaMmI/BrvOW
 fs++vZqu4VkBQwFyG5I0O4UzEyhJ506mCx/TzU+8yCP0P51O8blvVT6
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

stdboot and legacy boot depend on fdtfile. Since findfdt is getting
deprecated, move the rest of k3 platforms dependent on findfdt to
ti_set_fdt_env.

Populate fdtfile by calling ti_set_fdt_env in board files.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 board/ti/am62px/evm.c | 9 +++++++++
 board/ti/j722s/evm.c  | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/board/ti/am62px/evm.c b/board/ti/am62px/evm.c
index 1a2c46c462b4..7362fa4520a3 100644
--- a/board/ti/am62px/evm.c
+++ b/board/ti/am62px/evm.c
@@ -13,6 +13,7 @@
 #include <env.h>
 #include <fdt_support.h>
 #include <spl.h>
+#include "../common/fdt_ops.h"
 
 struct efi_fw_image fw_images[] = {
 	{
@@ -61,3 +62,11 @@ int dram_init_banksize(void)
 {
 	return fdtdec_setup_memory_banksize();
 }
+
+#if IS_ENABLED(CONFIG_BOARD_LATE_INIT)
+int board_late_init(void)
+{
+	ti_set_fdt_env(NULL, NULL);
+	return 0;
+}
+#endif
diff --git a/board/ti/j722s/evm.c b/board/ti/j722s/evm.c
index 515aaa818783..29e06a5442fe 100644
--- a/board/ti/j722s/evm.c
+++ b/board/ti/j722s/evm.c
@@ -12,6 +12,7 @@
 #include <env.h>
 #include <fdt_support.h>
 #include <spl.h>
+#include "../common/fdt_ops.h"
 
 int board_init(void)
 {
@@ -27,3 +28,11 @@ int dram_init_banksize(void)
 {
 	return fdtdec_setup_memory_banksize();
 }
+
+#if IS_ENABLED(CONFIG_BOARD_LATE_INIT)
+int board_late_init(void)
+{
+	ti_set_fdt_env(NULL, NULL);
+	return 0;
+}
+#endif

-- 
2.45.1

