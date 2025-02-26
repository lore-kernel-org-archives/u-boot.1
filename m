Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC76C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 22:36:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 609A98118A;
	Wed, 26 Feb 2025 23:36:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xpCb+uZd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B93C2811D8; Wed, 26 Feb 2025 23:36:11 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32EB981110
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 23:36:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51QMZpV61674809
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Feb 2025 16:35:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740609352;
 bh=l63otCyMIpw6Y7KTt2G4aWabniJLHATgAHMdFINvlR0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=xpCb+uZdgS0F3hyBy8RS7J/4GL0elL+WJLHSgSWp5Rh+tM/BeibsbbRFK+vdIPqek
 vWvR/YnTZyww49Evty+lXuHA4U2HfY34jaWIGnNEHVPEBczi7NM1mggoYp2IAKi6jx
 F1ZpnpAgYIllJSKLBv9P0ra7a2yWVqrfenD5h5cQ=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51QMZpwo111023
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 26 Feb 2025 16:35:51 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Feb 2025 16:35:51 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Feb 2025 16:35:51 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.79.44])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51QMZpGL064939;
 Wed, 26 Feb 2025 16:35:51 -0600
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
Subject: [PATCH v4 1/3] xilinx: dfu: Fill directly update_info.dfu_string
Date: Wed, 26 Feb 2025 16:35:45 -0600
Message-ID: <20250226223547.393611-2-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226223547.393611-1-j-humphreys@ti.com>
References: <20250226223547.393611-1-j-humphreys@ti.com>
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
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

