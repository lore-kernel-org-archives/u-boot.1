Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CA8C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 17:35:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F92D87B1F;
	Mon,  8 Jan 2024 18:33:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EPBElzhU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5E8687AF6; Mon,  8 Jan 2024 18:33:26 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AB4987AC5
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 18:33:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 408HX9RZ030052;
 Mon, 8 Jan 2024 11:33:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704735189;
 bh=W1TYdmdoe2iRe5cuPACv1+njiePH8C9tC/vWxmGAgWI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=EPBElzhUBorKq3wZd03sAEYWwMoLZlXccFjZWl+k0WUz6P4fER2ICPsMvrl8/Li12
 OJdxjAWmkWvUI0SPPJl5qtU2rZn28i/2gzd33Yx3Mdw7IWPHj+1BWawiy8rwCM07lC
 l1UCJH7ozPRcCaL7WhU0AoHmFAMAQsutDhbDfR0s=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 408HX9Q8006923
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 8 Jan 2024 11:33:09 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Jan 2024 11:33:08 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Jan 2024 11:33:08 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 408HX8kf045335;
 Mon, 8 Jan 2024 11:33:08 -0600
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
Subject: [PATCH 04/10] board: ti: am64x: Set fdtfile from C code instead of
 findfdt script
Date: Mon, 8 Jan 2024 11:32:55 -0600
Message-ID: <20240108173301.2692332-5-nm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108173301.2692332-1-nm@ti.com>
References: <20240108173301.2692332-1-nm@ti.com>
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

We now can provide a map and have the standard fdtfile variable set from
code itself. This allows for bootstd to "just work".

While at this, replace findfdt in environment with a warning as it is no
longer needed.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 board/ti/am64x/am64x.env | 9 ---------
 board/ti/am64x/evm.c     | 8 ++++++++
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/board/ti/am64x/am64x.env b/board/ti/am64x/am64x.env
index efd736b99be4..9a8812d4ee54 100644
--- a/board/ti/am64x/am64x.env
+++ b/board/ti/am64x/am64x.env
@@ -2,14 +2,6 @@
 #include <env/ti/mmc.env>
 #include <env/ti/k3_dfu.env>
 
-findfdt=
-	if test $board_name = am64x_gpevm; then
-		setenv name_fdt ti/k3-am642-evm.dtb; fi;
-	if test $board_name = am64x_skevm; then
-		setenv name_fdt ti/k3-am642-sk.dtb; fi;
-	if test $name_fdt = undefined; then
-		echo WARNING: Could not determine device tree to use; fi;
-	setenv fdtfile ${name_fdt}
 name_kern=Image
 console=ttyS2,115200n8
 args_all=setenv optargs earlycon=ns16550a,mmio32,0x02800000 ${mtdparts}
@@ -43,7 +35,6 @@ get_fit_usb=load usb ${bootpart} ${addr_fit}
 usbboot=setenv boot usb;
 	setenv bootpart 0:2;
 	usb start;
-	run findfdt;
 	run init_usb;
 	run get_kern_usb;
 	run get_fdt_usb;
diff --git a/board/ti/am64x/evm.c b/board/ti/am64x/evm.c
index a6dcff2eb434..e2f506d2c6ea 100644
--- a/board/ti/am64x/evm.c
+++ b/board/ti/am64x/evm.c
@@ -16,6 +16,7 @@
 #include <env.h>
 
 #include "../common/board_detect.h"
+#include "../common/fdt_ops.h"
 
 #define board_is_am64x_gpevm() (board_ti_k3_is("AM64-GPEVM") || \
 				board_ti_k3_is("AM64-HSEVM"))
@@ -180,6 +181,12 @@ int checkboard(void)
 }
 
 #ifdef CONFIG_BOARD_LATE_INIT
+static struct ti_fdt_map ti_am64_evm_fdt_map[] = {
+	{"am64x_gpevm", "k3-am642-evm.dtb"},
+	{"am64x_skevm", "k3-am642-sk.dtb"},
+	{ /* Sentinel. */ }
+};
+
 static void setup_board_eeprom_env(void)
 {
 	char *name = "am64x_gpevm";
@@ -197,6 +204,7 @@ static void setup_board_eeprom_env(void)
 
 invalid_eeprom:
 	set_board_info_env_am6(name);
+	ti_set_fdt_env(name, ti_am64_evm_fdt_map);
 }
 
 static void setup_serial(void)
-- 
2.43.0

