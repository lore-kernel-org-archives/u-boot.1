Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA29C021A0
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 19:54:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAD6480F98;
	Thu, 13 Feb 2025 20:54:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Vb7IGGP4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15D3080F92; Thu, 13 Feb 2025 20:54:40 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEEA180F7C
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 20:54:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51DJsHtv806259
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Feb 2025 13:54:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739476457;
 bh=kakzyN72f5UfuZ7wH76msUdiSXWUe7gOLQd9ozzDgHk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Vb7IGGP4y8O9yC7yzw3E8DLXZa+ln2345ywJlIC2l4B+Y4FkgzIfqvb8HlQ7OHIZR
 ACoZvKGKURpwV8B+cr117S0NWUUpFN+zmtn+YI2vNAOCRQb4ss+NSSlbQ9pIAUNpFG
 JqIKyFl9mKpFlgJQzNT3WBeqrKSXZuYm1kdcgV2k=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51DJsHAE075510
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 13 Feb 2025 13:54:17 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Feb 2025 13:54:16 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Feb 2025 13:54:16 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.79.44])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51DJsGrt099869;
 Thu, 13 Feb 2025 13:54:16 -0600
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Raymond Mao <raymond.mao@linaro.org>, Caleb Connolly
 <caleb.connolly@linaro.org>, Adriano Cordova <adrianox@gmail.com>, Michal
 Simek <michal.simek@amd.com>, Udit Kumar <u-kumar1@ti.com>, Simon Glass
 <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>, Hari Nagalla
 <hnagalla@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Santhosh Kumar K
 <s-k6@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Daniel Schultz
 <d.schultz@phytec.de>, Neil Armstrong <neil.armstrong@linaro.org>, Aashvij
 Shenai <a-shenai@ti.com>, Roger Quadros <rogerq@kernel.org>, Jonathan
 Humphreys <j-humphreys@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Wadim
 Egorov <w.egorov@phytec.de>, Tom Rini <trini@konsulko.com>, Robert Nelson
 <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Lukasz Majewski
 <lukma@denx.de>, <s-vadapalli@ti.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v3 1/3] xilinx: dfu: Fill directly update_info.dfu_string
Date: Thu, 13 Feb 2025 13:53:49 -0600
Message-ID: <20250213195351.3518305-2-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213195351.3518305-1-j-humphreys@ti.com>
References: <20250213195351.3518305-1-j-humphreys@ti.com>
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

From: Michal Simek <michal.simek@amd.com>

Directly fill update_info.dfu_string to prepare platforms to switch
from using dfu_alt_info variable to dfu_string which contains description
for capsule update when switch is done.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---
 board/xilinx/versal/board.c  | 3 +++
 board/xilinx/zynq/board.c    | 3 +++
 board/xilinx/zynqmp/zynqmp.c | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
index b4483d00ad1..2c387630a61 100644
--- a/board/xilinx/versal/board.c
+++ b/board/xilinx/versal/board.c
@@ -8,6 +8,7 @@
 #include <cpu_func.h>
 #include <dfu.h>
 #include <env.h>
+#include <efi_loader.h>
 #include <fdtdec.h>
 #include <init.h>
 #include <env_internal.h>
@@ -438,5 +439,7 @@ void set_dfu_alt_info(char *interface, char *devstr)
 
 	env_set("dfu_alt_info", buf);
 	puts("DFU alt info setting: done\n");
+	update_info.dfu_string = strdup(buf);
+	debug("Capsule DFU: %s\n", update_info.dfu_string);
 }
 #endif
diff --git a/board/xilinx/zynq/board.c b/board/xilinx/zynq/board.c
index a852d5b8ed5..bd004b86a88 100644
--- a/board/xilinx/zynq/board.c
+++ b/board/xilinx/zynq/board.c
@@ -7,6 +7,7 @@
 #include <config.h>
 #include <debug_uart.h>
 #include <dfu.h>
+#include <efi_loader.h>
 #include <init.h>
 #include <log.h>
 #include <dm/uclass.h>
@@ -199,5 +200,7 @@ void set_dfu_alt_info(char *interface, char *devstr)
 
 	env_set("dfu_alt_info", buf);
 	puts("DFU alt info setting: done\n");
+	update_info.dfu_string = strdup(buf);
+	debug("Capsule DFU: %s\n", update_info.dfu_string);
 }
 #endif
diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index 820fb252a3f..8060d54428d 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -11,6 +11,7 @@
 #include <dfu.h>
 #include <env.h>
 #include <env_internal.h>
+#include <efi_loader.h>
 #include <init.h>
 #include <log.h>
 #include <net.h>
@@ -734,6 +735,8 @@ void set_dfu_alt_info(char *interface, char *devstr)
 
 	env_set("dfu_alt_info", buf);
 	puts("DFU alt info setting: done\n");
+	update_info.dfu_string = strdup(buf);
+	debug("Capsule DFU: %s\n", update_info.dfu_string);
 }
 #endif
 
-- 
2.34.1

