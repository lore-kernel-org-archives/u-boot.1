Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C89C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 06:10:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C65A8823A;
	Mon, 15 Apr 2024 08:08:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35A6A8824E; Mon, 15 Apr 2024 08:08:24 +0200 (CEST)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4271388195
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:08:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4VHxYd4YBtz9t0b;
 Mon, 15 Apr 2024 08:08:21 +0200 (CEST)
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b2GjEVnidyEl; Mon, 15 Apr 2024 08:08:21 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4VHxYL0vfWz9t0H;
 Mon, 15 Apr 2024 08:08:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 1BC938B770;
 Mon, 15 Apr 2024 08:08:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id lCzqJuK0bF7H; Mon, 15 Apr 2024 08:08:06 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [172.25.230.108])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id ED4B38B779;
 Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Jean-Michel CASAUBON <jean-michel.casaubon@csgroup.eu>,
 DUBOIS Hugo <hugo.dubois.ext@csgroup.eu>, florent.trinh-thai@csgroup.eu,
 Tom Rini <trini@konsulko.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	u-boot@lists.denx.de
Subject: [PATCH v2 16/17] board: cssi: Load FPGA on MCR3000 board
Date: Mon, 15 Apr 2024 08:07:29 +0200
Message-ID: <2ad3e3a14b9cad484681889e7cb66335a85a6234.1713160866.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713160866.git.christophe.leroy@csgroup.eu>
References: <cover.1713160866.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Unlike CMPC885 and CMPCPRO boards, the FPGA of MCR3000 board doesn't
load code automatically but needs to be loaded by software through SPI.

Until now it was loaded later by Linux, but we'd like U-boot to have
access to some information that require the FPGA, like board address
in racks.

So, implemented the load of FPGA in U-boot.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
To avoid spamming your email boxes, the code isn't included in
the emailed patch but will be present in the PULL request
---
 arch/powerpc/dts/mcr3000.dts   |  6 ++++-
 board/cssi/mcr3000/fpga_code.h | 10 +++++++
 board/cssi/mcr3000/mcr3000.c   | 48 ++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 board/cssi/mcr3000/fpga_code.h

diff --git a/arch/powerpc/dts/mcr3000.dts b/arch/powerpc/dts/mcr3000.dts
index f678951e22..aa46007b8d 100644
--- a/arch/powerpc/dts/mcr3000.dts
+++ b/arch/powerpc/dts/mcr3000.dts
@@ -33,12 +33,16 @@
 			#size-cells = <0>;
 			cell-index = <0>;
 			compatible = "fsl,mpc8xx-spi";
-			gpios = <&csspi 2 0>;
+			gpios = <&csspi 2 0
+				 &csspi 0 0>;
 
 			temp@0 {
 				reg = <0>;
 				compatible = "ti,lm74";
 			};
+			fpga@1 {
+				reg = <1>;
+			};
 		};
 	};
 
diff --git a/board/cssi/mcr3000/fpga_code.h b/board/cssi/mcr3000/fpga_code.h
new file mode 100644
index 0000000000..0d710ba41f
--- /dev/null
+++ b/board/cssi/mcr3000/fpga_code.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2010 CS Systemes d'Information
+ *
+ * uCORE FPGA code for MCR3000 board
+ */
+
+u32 fpga_code[] = {
+	0xdeadbeef,
+};
diff --git a/board/cssi/mcr3000/mcr3000.c b/board/cssi/mcr3000/mcr3000.c
index 537d7fa124..15a2d0d946 100644
--- a/board/cssi/mcr3000/mcr3000.c
+++ b/board/cssi/mcr3000/mcr3000.c
@@ -13,12 +13,15 @@
 #include <mpc8xx.h>
 #include <fdt_support.h>
 #include <serial.h>
+#include <spi.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <dm/uclass.h>
 #include <wdt.h>
 #include <linux/delay.h>
 
+#include "fpga_code.h"
+
 DECLARE_GLOBAL_DATA_PTR;
 
 #define SDRAM_MAX_SIZE			(32 * 1024 * 1024)
@@ -107,6 +110,49 @@ int dram_init(void)
 	return 0;
 }
 
+static int load_fpga(void)
+{
+	immap_t __iomem *immr = (immap_t __iomem *)CONFIG_SYS_IMMR;
+	struct udevice *master;
+	struct spi_slave *slave;
+	int ret;
+
+	ret = uclass_get_device(UCLASS_SPI, 0, &master);
+	if (ret)
+		return ret;
+
+	ret = _spi_get_bus_and_cs(0, 1, 10000000, 0, "spi_generic_drv",
+				  "generic_0:0", &master, &slave);
+	if (ret)
+		return ret;
+
+	ret = spi_claim_bus(slave);
+
+	printf("FPGA Init ... ");
+
+	clrbits_be32(&immr->im_cpm.cp_pbdat, 0x20000);
+	while ((in_be32(&immr->im_cpm.cp_pbdat) & 0x8000))
+		;
+	setbits_be32(&immr->im_cpm.cp_pbdat, 0x20000);
+	while (!(in_be32(&immr->im_cpm.cp_pbdat) & 0x8000))
+		;
+
+	printf("Loading ... ");
+
+	ret = spi_xfer(slave, sizeof(fpga_code) * BITS_PER_BYTE, fpga_code, NULL, 0);
+
+	spi_release_bus(slave);
+
+	if ((in_be32(&immr->im_cpm.cp_pbdat) & 0x4000)) {
+		printf("Done\n");
+	} else {
+		printf("FAILED\n");
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 int misc_init_r(void)
 {
 	immap_t __iomem *immr = (immap_t __iomem *)CONFIG_SYS_IMMR;
@@ -121,6 +167,8 @@ int misc_init_r(void)
 	setbits_be32(&immr->im_cpm.cp_pbdir, 0xf);
 	clrbits_be32(&immr->im_cpm.cp_pbdat, 0x1);
 
+	load_fpga();
+
 	/* if BTN_ACQ_AL is pressed then bootdelay is changed to 60 second */
 	if ((in_be16(&iop->iop_pcdat) & 0x0004) == 0)
 		env_set("bootdelay", "60");
-- 
2.43.0

