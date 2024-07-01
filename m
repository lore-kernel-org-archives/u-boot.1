Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3073C3065A
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 05:19:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E9D188661;
	Mon,  1 Jul 2024 07:19:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YEMtHRku";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30B6B8865F; Mon,  1 Jul 2024 07:19:10 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 046E288661
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 07:19:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4615J3jd005293;
 Mon, 1 Jul 2024 00:19:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1719811143;
 bh=IxDKAIK/ArvRhwcdmH/mHmkmpdHcoFdCbrsS+o0ZZQY=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=YEMtHRku+iAETebbZtPkgZJW7jEp4kd8JQ/5/xeMsJPim50YNFZoT7d9itdL4+/lO
 ZQ3D9QGK5m19FoDoS43UB/9EaZmt7MQNl2GGirQWtBX1UcEbbi3ol8V3ODX8qFFNVp
 5hIm88bKgzHxtnZkud3Gdo727pFV0Q0JsS2Wd2kY=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4615J3Lp075613
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 1 Jul 2024 00:19:03 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 1
 Jul 2024 00:19:02 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 1 Jul 2024 00:19:02 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4615IpvX059517;
 Mon, 1 Jul 2024 00:18:59 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Mon, 1 Jul 2024 10:48:50 +0530
Subject: [PATCH v2 2/4] board: ti: am62p|j722s: Add ti_set_fdt_env for fdtfile
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240701-b4-upstream-streamline-platform-v2-2-7539ff066b58@ti.com>
References: <20240701-b4-upstream-streamline-platform-v2-0-7539ff066b58@ti.com>
In-Reply-To: <20240701-b4-upstream-streamline-platform-v2-0-7539ff066b58@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, Tom
 Rini <trini@konsulko.com>, Vaishnav Achath <vaishnav.a@ti.com>, Jayesh
 Choudhary <j-choudhary@ti.com>, Joe Hershberger <joe.hershberger@ni.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishanth
 Menon <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Dhruva Gole <d-gole@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719811131; l=1433;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=4uIGy/Rfl7Z7ScXcTO2QsCUMzUlk40jVQidx1LIztsw=;
 b=PrCoWajSxtaTHl9JGmGJbM5L84cx2wZwYbeb+hpa2iaftJ+ThJ678m/lyrzx1lHpoDBZQmyqq
 rftM36LhdcyC0893sim3yWnt63zpB2iDJojLrXjk8RT0fMQoDp3uaSG
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

stdboot and legacy boot now depend on fdtfile and fdtfile is populated
based on evm code now. Populate fdtfile by calling ti_set_fdt_env in
board files.

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

