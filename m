Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE468C3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 03:46:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B754D869DD;
	Fri, 25 Aug 2023 05:46:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="n/BlAqIP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA71286993; Fri, 25 Aug 2023 03:20:07 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2EB18643B
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 03:20:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peteryin.openbmc@gmail.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3a81154c570so294599b6e.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 18:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692926403; x=1693531203;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=15Ba6h+3Fw6qezfZjMQdaHpppt+66vGriaPloE1OtT0=;
 b=n/BlAqIP/u+3E4KBHpUueR3LoHkCa+Dhf4L5fTIQpSsV+idQ/jpvUoYE2WEpFl7WZD
 yE9lUx/P3b16J2lUWRg321Isd3vYKRclm2S7FDfh2FhgGexZgNyQ2zqzwR4DRaYNTRWw
 rO5ptDfk9Kzk48AdKyQj/WDGxiDzurD6hrZGDerJodaCqFtgO5iHoc/MAVXvzbz2neKo
 F7yaRgn2NIHtJfSZ7ZaKadijcKmb7JKi8X5Wbb6G2yKy/y1i5PA9MslgIiWksCLzwe7g
 ncT1QtrapjN4G2pvcloGBmV1ibvje1URqrvXgkOltb/RX70F1ktcgrAkxuoRJfBK0uat
 tNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692926403; x=1693531203;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=15Ba6h+3Fw6qezfZjMQdaHpppt+66vGriaPloE1OtT0=;
 b=EtxOrNMAx8UiCNzyvcHaC8pEPMMyjoS2epsgKoxQcpmH+yPwbPqNpLl/GKUJ0Ce3Uy
 WYUTKd9rkcsZFNHIBfpGwbiin36hllSnC9wtbF6NzBlokH5tLKXWiLpUZCCysddf/UXc
 RaJEVp6JrS22/12CQ7GUPUP6i9CHlzjQGf4QnIfqruMdoiqxm9oABSHao+AAo9E3l8BI
 aHtpMD+il/FVxv+nWQ3rPRvJfCMjdBpAqG5OXmxdMFiG3zy+q/UngxmYvHKtBQx+5fIn
 rx3fZaGl2lt1WJ0vrRM7NVcE+x9hMe2nUWFMzN98zuRo+G3nM3Pzl5P2sq3hybVbEN84
 LI1g==
X-Gm-Message-State: AOJu0Yx+Sc9Xf42V6PRAphnL4QNxrB6P+tu0l3dsAtryDwxR5FkF/8Pe
 x6iGHDUM946wGOf/vsXcqNg=
X-Google-Smtp-Source: AGHT+IG7xcFG61rprTiOL5opjWE5FdMnW5QDOWIz2oyawLQwwKBr2n3twwoXm4owpTn+UCVbnLT2pw==
X-Received: by 2002:a05:6808:1785:b0:3a9:6400:62cb with SMTP id
 bg5-20020a056808178500b003a9640062cbmr1665803oib.57.1692926403479; 
 Thu, 24 Aug 2023 18:20:03 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local
 (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
 by smtp.gmail.com with ESMTPSA id
 i2-20020aa78b42000000b0068bc461b68fsm355995pfd.204.2023.08.24.18.20.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 18:20:02 -0700 (PDT)
From: peteryin <peteryin.openbmc@gmail.com>
To: albert.u.boot@aribaud.net,
	u-boot@lists.denx.de
Cc: peteryin <peter.yin@quantatw.com>
Subject: [PATCH 1/2] Title:Add board for Meta openbmc Minerva.
Date: Fri, 25 Aug 2023 09:17:31 +0800
Message-Id: <20230825011732.1606958-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 25 Aug 2023 05:46:38 +0200
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

From: peteryin <peter.yin@quantatw.com>

Create minerva initial file.

Signed-off-by: peteryin <peter.yin@quantatw.com>
---
 arch/arm/mach-aspeed/ast2600/Kconfig          |   8 ++
 board/aspeed/meta_ast2600/Kconfig             |  13 ++
 board/aspeed/meta_ast2600/Makefile            |   1 +
 .../meta_ast2600/meta_minerva_ast2600.c       | 130 ++++++++++++++++++
 4 files changed, 152 insertions(+)
 create mode 100644 board/aspeed/meta_ast2600/Kconfig
 create mode 100644 board/aspeed/meta_ast2600/Makefile
 create mode 100644 board/aspeed/meta_ast2600/meta_minerva_ast2600.c

diff --git a/arch/arm/mach-aspeed/ast2600/Kconfig b/arch/arm/mach-aspeed/ast2600/Kconfig
index f5852afa77..444990e2e3 100644
--- a/arch/arm/mach-aspeed/ast2600/Kconfig
+++ b/arch/arm/mach-aspeed/ast2600/Kconfig
@@ -51,6 +51,13 @@ config TARGET_QUALCOMM_DC_SCM_V1
 	  QUALCOMM-DC-SCM-V1 is a Qualcomm DC-SCM V1 board which is
 	  equipped with AST2600.
 
+config TARGET_META_MINERVA_AST2600
+	bool "META-MINERVA-AST2600"
+	depends on ASPEED_AST2600
+	help
+	  META-MINERVA-AST2600 is META openbmc minerva board for AST2600A3 chip.
+
+
 endchoice
 
 source "board/aspeed/evb_ast2600/Kconfig"
@@ -59,5 +66,6 @@ source "board/aspeed/slt_ast2600/Kconfig"
 source "board/aspeed/ast2600_ibm/Kconfig"
 source "board/aspeed/ast2600_intel/Kconfig"
 source "board/qualcomm/dc-scm-v1/Kconfig"
+source "board/aspeed/meta_ast2600/Kconfig"
 
 endif
diff --git a/board/aspeed/meta_ast2600/Kconfig b/board/aspeed/meta_ast2600/Kconfig
new file mode 100644
index 0000000000..adc5b58733
--- /dev/null
+++ b/board/aspeed/meta_ast2600/Kconfig
@@ -0,0 +1,13 @@
+if TARGET_META_MINERVA_AST2600
+
+config SYS_BOARD
+	default "meta_ast2600"
+
+config SYS_VENDOR
+	default "aspeed"
+
+config SYS_CONFIG_NAME
+	string "board configuration name"
+	default "meta_minerva_ast2600"
+
+endif
diff --git a/board/aspeed/meta_ast2600/Makefile b/board/aspeed/meta_ast2600/Makefile
new file mode 100644
index 0000000000..b5a526efa5
--- /dev/null
+++ b/board/aspeed/meta_ast2600/Makefile
@@ -0,0 +1 @@
+obj-y += meta_minerva_ast2600.o
diff --git a/board/aspeed/meta_ast2600/meta_minerva_ast2600.c b/board/aspeed/meta_ast2600/meta_minerva_ast2600.c
new file mode 100644
index 0000000000..d0b3720da3
--- /dev/null
+++ b/board/aspeed/meta_ast2600/meta_minerva_ast2600.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) ASPEED Technology Inc.
+ */
+#include <common.h>
+#include <asm/io.h>
+
+#define SCU_BASE                   (0x1e6e2000)
+#define ESPI_BASE                  (0x1e6ee000)
+#define LPC_BASE                   (0x1e789000)
+#define LPC_HICR5                  (LPC_BASE + 0x80)
+#define LPC_HICR6                  (LPC_BASE + 0x84)
+#define LPC_SNPWADR                (LPC_BASE + 0x90)
+#define LPC_HICRB                  (LPC_BASE + 0x100)
+#define LPC_PCCR0                  (LPC_BASE | 0x130)
+
+#define SCU_MUTI_FN_PIN_CTRL5      (SCU_BASE | 0x414)
+#define SCU_MUTI_FN_PIN_CTRL7      (SCU_BASE | 0x41C)
+#define SCU_MUTI_FN_PIN_CTRL9      (SCU_BASE | 0x434)
+#define SCU_MUTI_FN_PIN_CTRL15     (SCU_BASE | 0x454)
+#define SCU_PIN_CONTROL8_REG       (SCU_BASE | 0x430)
+#define SCU_HW_STRAP2_SET_REG      (SCU_BASE | 0x510)
+#define SCU_HW_STRAP2_CLR_REG      (SCU_BASE | 0x514)
+#define SCU_HW_STRAP3_REG          (SCU_BASE | 0x51C)
+
+#define ENABLE_GPIO_PASSTHROUGH    BIT(9)
+#define GPIO_BASE                  (0x1e780000)
+#define GPIO_ABCD_BASE_REG         (GPIO_BASE | 0x000)
+#define GPIO_ABCD_DATA_REG         (GPIO_ABCD_BASE_REG)
+#define GPIO_ABCD_DIR_REG          (GPIO_BASE | 0x004)
+
+#define GPIO_EFGH_BASE_REG         (GPIO_BASE | 0x020)
+#define GPIO_EFGH_DATA_REG         (GPIO_EFGH_BASE_REG)
+#define GPIO_EFGH_DIR_REG          (GPIO_BASE | 0x024)
+
+#define GPIO_IJKL_BASE_REG         (GPIO_BASE | 0x070)
+#define GPIO_IJKL_DATA_REG         (GPIO_IJKL_BASE_REG)
+#define GPIO_IJKL_DIR_REG          (GPIO_BASE | 0x074)
+
+#define GPIO_MNOP_BASE_REG         (GPIO_BASE | 0x078)
+#define GPIO_MNOP_DATA_REG         (GPIO_MNOP_BASE_REG)
+#define GPIO_MNOP_DIR_REG          (GPIO_BASE | 0x07C)
+#define GPIO_MNOP_CMD_SOURCE0      (GPIO_BASE | 0x0E0)
+#define GPIO_MNOP_CMD_SOURCE1      (GPIO_BASE | 0x0E4)
+
+#define GPIO_QRST_BASE_REG         (GPIO_BASE | 0x080)
+#define GPIO_QRST_DATA_REG         (GPIO_QRST_BASE_REG)
+#define GPIO_QRST_DIR_REG          (GPIO_BASE | 0x084)
+
+#define GPIO_UVWX_BASE_REG         (GPIO_BASE | 0x088)
+#define GPIO_UVWX_DATA_REG         (GPIO_UVWX_BASE_REG)
+#define GPIO_UVWX_DIR_REG          (GPIO_BASE | 0x08C)
+
+#define GPIO_NAME(base, pin)       (1 << (pin + (base - 'A') % 4 * 8))
+#define GPIO_GROUP(base, val)      (val << ((base - 'A') % 4 * 8))
+#define SIO_ADDR_4E                (0x4E)
+#define SIO_ADDR_2E                (0x2E)
+
+static void __maybe_unused el_espi_init(void)
+{
+	u32 value = 0;
+
+	//SCU514: SCU514: Hardware Strap2 Clear Register (default)
+	//SCU510 [6]:0 eSPI mode
+	setbits_le32(SCU_HW_STRAP2_CLR_REG, BIT(6));
+
+	//SCU434: Multi-function Pin Control #9 (default)
+	setbits_le32(SCU_MUTI_FN_PIN_CTRL9, 0xFF << 16);
+
+	//SCU454: Multi-function Pin Control #15
+	value  = readl(SCU_MUTI_FN_PIN_CTRL15);
+	value &= 0x00FFFFFF;  //Clear BIT[31:24]
+	value |= 0xAA000000;  //BIT[31:24] = LAD3ESPID3~0 Driving Strength
+	writel(value, SCU_MUTI_FN_PIN_CTRL15);
+
+	//ESPI000: Engine Control
+	setbits_le32(ESPI_BASE, 1 << 4);
+}
+
+// SNOOP SET
+void el_port80_init(u32 reg_dir, u32 reg_val,
+		    u32 cmd_source0, u32 cmd_source1)
+{
+	u32 value = 0;
+
+	//GPIO Output Settings
+	setbits_le32(reg_dir, reg_val);
+
+	//Command Source0 = 1
+	//Command Source1 = 0
+	setbits_le32(cmd_source0, BIT(8));
+	clrbits_le32(cmd_source1, BIT(8));
+
+	//SNPWADR(0x90): LPC Snoop Address Register
+	value  = readl(LPC_SNPWADR);
+	value &= 0xFFFF0000;  //BIT[15:0] - clear;
+	value |= 0x00000080;  //BIT[15:0] - set;
+	writel(value, LPC_SNPWADR);
+	//HICR5(0x80): Host Interface Control Register 5
+	value  = readl(LPC_HICR5);
+	value |= 1;       //Enable snooping address #0
+	value &= ~0xA;
+	writel(value, LPC_HICR5);
+
+	//HICRB(0x100): Host Interface Control Register B
+	//EnSNP0D: Enable ACCEPT response code for snoop #0 commands,
+	//defined in HICR5[0], in eSPI mode.
+	setbits_le32(LPC_HICRB, BIT(14));
+
+	writel(0, LPC_PCCR0);
+}
+
+//Super IO Settings
+void el_superio_decoder(uint8_t addr)
+{
+	//Enable LPC to decode SuperIO 0x2E/0x4E address
+	setbits_le32(SCU_HW_STRAP2_CLR_REG, BIT(2));
+
+	//SuperIO configuration address selection (0 = 0x2E(Default) / 1 = 0x4E)
+	if (addr == 0x4E)
+		setbits_le32(SCU_HW_STRAP2_SET_REG, BIT(2));
+}
+
+int board_early_init_f(void)
+{
+	clrbits_le32(SCU_HW_STRAP3_REG, ENABLE_GPIO_PASSTHROUGH);
+	el_espi_init();
+	el_superio_decoder(SIO_ADDR_2E);
+	return 0;
+}
-- 
2.25.1

