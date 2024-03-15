Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D637CC54E67
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 19:47:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0FC288018;
	Fri, 15 Mar 2024 20:47:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="haK6Awdx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D2D287D08; Fri, 15 Mar 2024 20:26:15 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E894D88018
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 20:26:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-36668066e0aso13478095ab.2
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 12:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710530768; x=1711135568; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ljy83cp5QDQZ68slM3+y0kskOwNii/vtyavRbJz3R8I=;
 b=haK6AwdxhcJI1FVH+9bhNNXG6+iCpkffoAdyOFFlaWeAyGaZwsDk2OVZMA6JqCKZyl
 2OIzzFX3b6D5aZY9B9bypKmsMfr0WppvFLs1TyHHbOQXOT8l56JMnSPcebGw3vEJCDhf
 Rc73aCiuOFztyx40/4+qnBGmVMpjIz4aUOc8/bu2tIu3kGu3R2hzvB6h60Ip1p77eDZT
 PPJsx/2TdhyGbut2etv3DIfhUUjM1/SM36fbMN0TAv5Sh89pRvLjmyCvqiPS6SVA/Thq
 RbfUbC6VVSeUD6cYnzgSlRVvQOhIgP64MnYx/KNJAgC604on+QMo0MoBhYu+CrLpHg/+
 cxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710530768; x=1711135568;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ljy83cp5QDQZ68slM3+y0kskOwNii/vtyavRbJz3R8I=;
 b=A72eKZCuc50k6UpM4f+CDuH8gT17m4Kyj/PM7NsM7iDdI6ZZyZo4/St1ZvPBNvlddh
 VVVdMmilAXp7kNMtU1XYMeNG8fnJNrFX2FDLixyRJiiNz5Y1REtTDETeETrxJcLKAa2+
 yVboKexPPap8NAiVrvykRWMn+86QjCRthgP4VIJGWhYW/N21yv3t/H0s7bBUg12NJIKT
 gG90cihAaYYULciBuW/XNtfpjA4sPuaVEcKcX2dzr967IBxgbCsY7unF8pdo7yW0MBa9
 HEk9oEyIarwAixqumn7cayrBgMyLWotBAqvWydN8VokuAldp6DvzafEdEbfzKy2Vr3TY
 qoIA==
X-Gm-Message-State: AOJu0Yylp5+u0DY1O8zbkyAM1Fekw/CGNm0OftjDyxx92UTbdmg6Rnza
 bbFPKrzIb98qRiFM99HNZCEr78E1d2AVJRBCh4WnQ0c+6c0xoMknruNKnPILx/M=
X-Google-Smtp-Source: AGHT+IGm5PeTyexY2t5sdy8jQBrVo6Kf4WVH4AZkU8rv5ABeBzDuerXVJYI4OqL+3LUDnvDNPZFUIA==
X-Received: by 2002:a92:ce05:0:b0:366:7b23:763f with SMTP id
 b5-20020a92ce05000000b003667b23763fmr5267581ilo.9.1710530768037; 
 Fri, 15 Mar 2024 12:26:08 -0700 (PDT)
Received: from james-x399.localdomain (97-118-232-75.hlrn.qwest.net.
 [97.118.232.75]) by smtp.gmail.com with ESMTPSA id
 o8-20020a056e02068800b0036528f00c44sm884264ils.61.2024.03.15.12.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 12:26:07 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Stefan Roese <sr@denx.de>,
 "Polak, Leszek" <LPolak@arri.de>
Subject: [PATCH 1/1] xilinx: zynq: add FDT_FIXUP_PARTITIONS support
Date: Fri, 15 Mar 2024 13:25:26 -0600
Message-Id: <20240315192528.464849-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 15 Mar 2024 20:47:10 +0100
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

There are situations where we may want to let U-Boot modify the FDT
nand partitions for the kernel, such as when supporting multiple
sizes of NAND chips.

Lets also refactor xilinx common board support to have a
ft_common_board_setup which gets called by the ft_board_setup for each
specific board so that we can add non-common functionality to each
ft_board_setup like FDT_FIXUP_PARTITIONS as needed.

This pattern is modeled after the one used by tdx-common.c.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 board/xilinx/common/board.c     |  2 +-
 board/xilinx/common/board.h     |  2 ++
 board/xilinx/mbv/board.c        |  9 +++++++++
 board/xilinx/versal-net/board.c |  7 +++++++
 board/xilinx/versal/board.c     |  7 +++++++
 board/xilinx/zynq/board.c       | 17 +++++++++++++++++
 board/xilinx/zynqmp/zynqmp.c    |  7 +++++++
 board/xilinx/zynqmp_r5/board.c  |  8 ++++++++
 8 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index 9641ed307b..629ba2b902 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -686,7 +686,7 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 
 #ifdef CONFIG_OF_BOARD_SETUP
 #define MAX_RAND_SIZE 8
-int ft_board_setup(void *blob, struct bd_info *bd)
+int ft_common_board_setup(void *blob, struct bd_info *bd)
 {
 	size_t n = MAX_RAND_SIZE;
 	struct udevice *dev;
diff --git a/board/xilinx/common/board.h b/board/xilinx/common/board.h
index 64d657673e..73f576952a 100644
--- a/board/xilinx/common/board.h
+++ b/board/xilinx/common/board.h
@@ -18,4 +18,6 @@ bool board_detection(void);
 char *soc_name_decode(void);
 
 bool soc_detection(void);
+
+int ft_common_board_setup(void *blob, struct bd_info *bd);
 #endif /* BOARD_XILINX_COMMON_BOARD_H */
diff --git a/board/xilinx/mbv/board.c b/board/xilinx/mbv/board.c
index ccf4395d6a..d8af1eaa90 100644
--- a/board/xilinx/mbv/board.c
+++ b/board/xilinx/mbv/board.c
@@ -5,7 +5,16 @@
  * Michal Simek <michal.simek@amd.com>
  */
 
+#include "../common/board.h"
+
 int board_init(void)
 {
 	return 0;
 }
+
+#ifdef CONFIG_OF_BOARD_SETUP
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	return ft_common_board_setup(blob, bd);
+}
+#endif
diff --git a/board/xilinx/versal-net/board.c b/board/xilinx/versal-net/board.c
index 990ca1650a..bd674e6739 100644
--- a/board/xilinx/versal-net/board.c
+++ b/board/xilinx/versal-net/board.c
@@ -371,3 +371,10 @@ int dram_init(void)
 void reset_cpu(void)
 {
 }
+
+#ifdef CONFIG_OF_BOARD_SETUP
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	return ft_common_board_setup(blob, bd);
+}
+#endif
diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
index 8c2e614ad8..944ef2d822 100644
--- a/board/xilinx/versal/board.c
+++ b/board/xilinx/versal/board.c
@@ -320,3 +320,10 @@ enum env_location env_get_location(enum env_operation op, int prio)
 		return ENVL_NOWHERE;
 	}
 }
+
+#ifdef CONFIG_OF_BOARD_SETUP
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	return ft_common_board_setup(blob, bd);
+}
+#endif
diff --git a/board/xilinx/zynq/board.c b/board/xilinx/zynq/board.c
index 6c36591001..1ca1984c49 100644
--- a/board/xilinx/zynq/board.c
+++ b/board/xilinx/zynq/board.c
@@ -13,10 +13,12 @@
 #include <env.h>
 #include <env_internal.h>
 #include <fdtdec.h>
+#include <fdt_support.h>
 #include <fpga.h>
 #include <malloc.h>
 #include <memalign.h>
 #include <mmc.h>
+#include <mtd_node.h>
 #include <watchdog.h>
 #include <wdt.h>
 #include <zynqpl.h>
@@ -201,3 +203,18 @@ void set_dfu_alt_info(char *interface, char *devstr)
 	puts("DFU alt info setting: done\n");
 }
 #endif
+
+#ifdef CONFIG_OF_BOARD_SETUP
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+#ifdef CONFIG_FDT_FIXUP_PARTITIONS
+	static const struct node_info nodes[] = {
+		{ "arm,pl353-nand-r2p1", MTD_DEV_TYPE_NAND, },
+	};
+
+	fdt_fixup_mtdparts(blob, nodes, ARRAY_SIZE(nodes));
+#endif
+
+	return ft_common_board_setup(blob, bd);
+}
+#endif
diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index ba49eb7be2..cd06396df0 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -700,3 +700,10 @@ unsigned int spl_spi_get_uboot_offs(struct spi_flash *flash)
 	return offset;
 }
 #endif
+
+#ifdef CONFIG_OF_BOARD_SETUP
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	return ft_common_board_setup(blob, bd);
+}
+#endif
diff --git a/board/xilinx/zynqmp_r5/board.c b/board/xilinx/zynqmp_r5/board.c
index 5c5a2e9386..a512577260 100644
--- a/board/xilinx/zynqmp_r5/board.c
+++ b/board/xilinx/zynqmp_r5/board.c
@@ -6,6 +6,7 @@
 #include <common.h>
 #include <fdtdec.h>
 #include <init.h>
+#include "../common/board.h"
 
 int board_init(void)
 {
@@ -24,3 +25,10 @@ int dram_init(void)
 
 	return 0;
 }
+
+#ifdef CONFIG_OF_BOARD_SETUP
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	return ft_common_board_setup(blob, bd);
+}
+#endif
-- 
2.34.1

