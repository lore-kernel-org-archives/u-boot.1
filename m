Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD812C30659
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 08:24:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3CE888549;
	Fri, 28 Jun 2024 10:23:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xaO4ywEa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46A1688549; Fri, 28 Jun 2024 10:23:54 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93C64885A8
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 10:23:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45S8NljD002136;
 Fri, 28 Jun 2024 03:23:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1719563027;
 bh=qkbrKjLuBfSP7ypOpVLsHxM/EmKUqiSI5yqXPuMo44g=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=xaO4ywEaq1uw2Kh7vzJqD25UIJAFBb1DCr+IZnaZT+zKaUdA7ND+tRyaVtIxZW6Wn
 OdgU9RWwbFGcTo/FcReTuebtiGmoQR7LmccZ65ipZ1OpP5VxSxc1qyKcQWG3sRCjfV
 fcrZ3U+K0Ri5J2RwJm8B0aK2EmMmixhHlIf19U4w=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45S8Nl1j083023
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 28 Jun 2024 03:23:47 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jun 2024 03:23:47 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jun 2024 03:23:47 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45S8NZY3119300;
 Fri, 28 Jun 2024 03:23:43 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Fri, 28 Jun 2024 13:53:29 +0530
Subject: [PATCH 2/3] board: ti: am62p|j722s: Add ti_set_fdt_env for findfdt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240628-b4-upstream-streamline-platform-v1-2-17659af992c1@ti.com>
References: <20240628-b4-upstream-streamline-platform-v1-0-17659af992c1@ti.com>
In-Reply-To: <20240628-b4-upstream-streamline-platform-v1-0-17659af992c1@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, Tom
 Rini <trini@konsulko.com>, Vaishnav Achath <vaishnav.a@ti.com>, Jayesh
 Choudhary <j-choudhary@ti.com>, Joe Hershberger <joe.hershberger@ni.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishanth
 Menon <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Dhruva Gole <d-gole@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719563016; l=1433;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=THUm3WS7oPzjWD5eeQj7FFBiFBcUmqeAvJIdskYEWx8=;
 b=szBuBlWr8OWu0xCSfimZ9z7/edYYc+0LMRE0wOVgIVazYySFwAaBLVeHziJj6CopAMZG8l02d
 ++Del1SSJZ/Cu0emiO3E77b6wkTZupQdDrJZO0mseLCJJe34yFwKY4N
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

stdboot and legacy boot now depend on findfdt and findfdt is populated
based on evm code now. Populate findfdt by calling ti_set_fdt_env in
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

