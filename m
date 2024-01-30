Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92759C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 13:07:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6C3C87DBE;
	Tue, 30 Jan 2024 14:06:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Q2zsGhCC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 761DF87D74; Tue, 30 Jan 2024 14:06:38 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 976C387D86
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 14:06:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40UD6LJK076173;
 Tue, 30 Jan 2024 07:06:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706619981;
 bh=jWKK9LtyjxGLN/iapkY8ahV9JoAkmtkRCo+zw11p3fs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Q2zsGhCCp2fqU4TQVnvei9WFz+L6l/wlllchlph7IUS+Op/zX3VzhfkiN8tGJrJA7
 HkTOA+4bcv6B6St+fGkeOfCTck4+Jz2ymb5ejUIIYOibi+YGaA2qNIIoFMnMrNioCZ
 kTE+Br+BHwAxqUPCZgg3Niopp2Gjw+gi3RCerYuk=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40UD6LPY092886
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 30 Jan 2024 07:06:21 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jan 2024 07:06:21 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jan 2024 07:06:21 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40UD6LQx098262;
 Tue, 30 Jan 2024 07:06:21 -0600
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Kamlesh Gurudasani <kamlesh@ti.com>, Sinthu Raja <sinthu.raja@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Roger Quadros <rogerq@kernel.org>, Simon Glass
 <sjg@chromium.org>, Andrew Davis <afd@ti.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Bryan Brattlof <bb@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 <u-boot@lists.denx.de>, Jon Humphreys <j-humphreys@ti.com>,
 Nishanth Menon <nm@ti.com>
Subject: [PATCH V3 07/11] board: ti: j721e: Set fdtfile from C code instead of
 findfdt script
Date: Tue, 30 Jan 2024 07:06:11 -0600
Message-ID: <20240130130615.670783-8-nm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130130615.670783-1-nm@ti.com>
References: <20240130130615.670783-1-nm@ti.com>
MIME-Version: 1.0
Organization: Texas Instruments, Inc.
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

We now can provide a map and have the standard fdtfile variable set from
code itself. This allows for bootstd to "just work".

While at this, replace findfdt in environment with a warning as it is no
longer needed.

Reviewed-by: Jonathan Humphreys <j-humphreys@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes in V3:
- none other than picking up reviews.

V2: https://lore.kernel.org/r/20240109191506.3820908-7-nm@ti.com

 board/ti/j721e/evm.c     |  8 ++++++++
 board/ti/j721e/j721e.env | 10 ----------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index b77cffc5ef56..9dc3ed6dfffa 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -16,6 +16,7 @@
 #include <dm.h>
 
 #include "../common/board_detect.h"
+#include "../common/fdt_ops.h"
 
 #define board_is_j721e_som()	(board_ti_k3_is("J721EX-PM1-SOM") || \
 				 board_ti_k3_is("J721EX-PM2-SOM"))
@@ -353,6 +354,12 @@ static int probe_daughtercards(void)
 #endif
 
 #ifdef CONFIG_BOARD_LATE_INIT
+static struct ti_fdt_map ti_j721e_evm_fdt_map[] = {
+	{"j721e", "k3-j721e-common-proc-board.dtb"},
+	{"j721e-sk", "k3-j721e-sk.dtb"},
+	{"j7200", "k3-j7200-common-proc-board.dtb"},
+	{ /* Sentinel. */ }
+};
 static void setup_board_eeprom_env(void)
 {
 	char *name = "j721e";
@@ -372,6 +379,7 @@ static void setup_board_eeprom_env(void)
 
 invalid_eeprom:
 	set_board_info_env_am6(name);
+	ti_set_fdt_env(name, ti_j721e_evm_fdt_map);
 }
 
 static void setup_serial(void)
diff --git a/board/ti/j721e/j721e.env b/board/ti/j721e/j721e.env
index cb27bf5e2b24..38bfd7d49634 100644
--- a/board/ti/j721e/j721e.env
+++ b/board/ti/j721e/j721e.env
@@ -7,16 +7,6 @@
 #include <env/ti/k3_rproc.env>
 #endif
 
-default_device_tree=ti/k3-j721e-common-proc-board.dtb
-findfdt=
-	setenv name_fdt ${default_device_tree};
-	if test $board_name = j721e; then
-		setenv name_fdt ti/k3-j721e-common-proc-board.dtb; fi;
-	if test $board_name = j7200; then
-		setenv name_fdt ti/k3-j7200-common-proc-board.dtb; fi;
-	if test $board_name = j721e-eaik || test $board_name = j721e-sk; then
-		setenv name_fdt ti/k3-j721e-sk.dtb; fi;
-	setenv fdtfile ${name_fdt}
 name_kern=Image
 console=ttyS2,115200n8
 args_all=setenv optargs earlycon=ns16550a,mmio32,0x02800000
-- 
2.43.0

