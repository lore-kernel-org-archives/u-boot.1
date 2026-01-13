Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AD3D2D10A
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 14:35:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 902D1800AB;
	Tue, 13 Jan 2026 15:35:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U7UYarFA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCBB183015; Tue, 13 Jan 2026 15:23:25 +0100 (CET)
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com
 [IPv6:2607:f8b0:4864:20::a30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D2B482B20
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 15:23:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mateuslima.ti@gmail.com
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-56373f07265so2922028e0c.0
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 06:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768314202; x=1768919002; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M7Gp4GqfoAgQizVtHxJGbpjKoqiS85j4/7xjKmedIEw=;
 b=U7UYarFAM0pPV77P3WLTeQ0xNX6QsYyIzhxTEsM+5OaCLY8KkSykn/wkKJkZZtKjjN
 NYCw9xZrSRQbpEOTRe6+NWeiGYcghziyidetcaW7ZAJcWyiGbApfaroknE6+1LavEN8Y
 5MmuL6MGcG6uy2Zc4TELoTbbxwOzn5UDof9B9IvchsokR7qwQxbuKbb7KPT6VYGXiPLa
 1IhxnO7xs6u81Vfb0KBpKhNoeOf4bWsjYSTiamC9koX7AX82JO2IpdagCwonMzzTZ9LW
 SfR2y6eRiFXazAwe8sHoU1cYbKQr1XqzQ9KCo4YWebIwS8k8UlnQvy5MPc7dI+AjlRCh
 N6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768314202; x=1768919002;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M7Gp4GqfoAgQizVtHxJGbpjKoqiS85j4/7xjKmedIEw=;
 b=HFQ+hJAelMPpHRk8C/oMmXFIQ7nBSScsbvQU5kYFvM1tGKlgWAJ2VxkTx/dPYjM2G5
 wza3eBrx3Afs0liHwRqj2vvzyuY4k52oayTRH/Ci0uOlIn+8KWvECSo5RErpoRbIKNmR
 c82YEoGvnGjmHPao2JTHL1Di7CyDjMOTva4+OzELIMQ5rAhLxxjgW+P5tcJOn4FEYfAi
 ZozWVTHht4lJAbnYFpMvp2NlAilsw8x9s/hrNpv6hgWXmLGinrI4themYpSNsuGOS2yv
 oYw8xgY9gW6qpT2Rs7kqb8VMIi+T8FtPts4WX6Ky3YmgI1YviJ5pVljKqr8pbDL+HOx7
 5ycA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjZ1I8G2C42i+o5j7nqV4VK4GeEZfUh9vuTvMlhDbk83DvqT90r9XD/gdMfyI2rA854M8sKWE=@lists.denx.de
X-Gm-Message-State: AOJu0YzXOxfOdsOEv5SJCNhyA752E0dkoC99+WDcOBZLn3iCDhmC3sWP
 VEQZ7JgzlKUgs6mVslCuFk6jYi+q2pkq+TTTjrF6jEatymBN2OAIGh9H
X-Gm-Gg: AY/fxX6F2Gc0+NlFnOhdby0FF5SpKmCb4QJmvhhWrZlC+HMKirJjIjXGsRHhMkBjXw8
 hpYsUMMKHkRL27flpH0MIixiVSYkEZtrpNveHTxYmIXvKSd9OLzhUq9Ng23cW8Cm6+c/EORDxRZ
 D2CkCDJz4IHOJhCfiAGLW7x0+3yRajyD+T7vsMk7R0F241D7cauFlT1qIxdZkxbDyepWxFxDtej
 ZE4hORNod1v03qJ2G4pShsOHF8o7VBDaT5ZWKCQ0Y5iJDhF22Q5spGm/pxF2hBQ8WLhPrXByQLi
 FGQZxJ7qwfP1stQQxJKkLhSx+IAPcM9MZ+9nf6Hu5Ya0tZdgPMT2z7wHLcMKag8kZsgrx41uefq
 rks81PvSFSBhpJq+7JxO4ApflAOQEYqkrzTQzoaZ91ibljk6x3V+ynJ+jl3EzDR/OSTm9P3Rk67
 IM1FASKes/8G0eqnCPgRV+UKc9ggeyqfnrtLdgt1UfMlJMlA==
X-Google-Smtp-Source: AGHT+IFNGfxIKtZvrZP8i9P9wBDHj4aJ08arxNw2dPFNnZAuqUrN3U4R5GP7fhGr7+5CacjO2Hf+4w==
X-Received: by 2002:a05:6122:208a:b0:55a:be72:7588 with SMTP id
 71dfb90a1353d-56347fc9897mr7928335e0c.11.1768314202304; 
 Tue, 13 Jan 2026 06:23:22 -0800 (PST)
Received: from ped-6489-Latitude-3550.mobit.com.br ([177.22.36.222])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5637f6ce00esm7677112e0c.0.2026.01.13.06.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 06:23:21 -0800 (PST)
From: Mateus Lima Alves <mateuslima.ti@gmail.com>
To: peng.fan@oss.nxp.com,
	alison.wang@nxp.com
Cc: Mateus Lima Alves <mateuslima.ti@gmail.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2] armv7: Add CPLD support via IFC to the ls1021a-iot board.
Date: Tue, 13 Jan 2026 11:23:01 -0300
Message-ID: <20260113142303.441190-1-mateuslima.ti@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 13 Jan 2026 15:35:20 +0100
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

This patch adds CPLD support via IFC to the ls1021a-iot board.

Signed-off-by: Mateus Lima Alves <mateuslima.ti@gmail.com>
---
Changes since v1:
Reselected CONFIG_CMD_MII in file configs/ls1021aiot_sdcard_defconfig.
---
 board/freescale/ls1021aiot/ls1021aiot.c |  5 ++++
 configs/ls1021aiot_sdcard_defconfig     |  1 +
 drivers/misc/Kconfig                    |  6 ++++-
 include/configs/ls1021aiot.h            | 34 +++++++++++++++++++++++++
 4 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/board/freescale/ls1021aiot/ls1021aiot.c b/board/freescale/ls1021aiot/ls1021aiot.c
index 4eff0a3fee0..52a3c3abdb4 100644
--- a/board/freescale/ls1021aiot/ls1021aiot.c
+++ b/board/freescale/ls1021aiot/ls1021aiot.c
@@ -21,6 +21,7 @@
 #include <asm/sections.h>
 #include <fsl_csu.h>
 #include <fsl_immap.h>
+#include <fsl_ifc.h>
 #include <netdev.h>
 #include <fsl_mdio.h>
 #include <tsec.h>
@@ -120,6 +121,10 @@ int board_early_init_f(void)
 
 #endif
 
+#ifdef CONFIG_FSL_IFC
+	init_early_memctl_regs();
+#endif
+
 	arch_soc_init();
 
 	return 0;
diff --git a/configs/ls1021aiot_sdcard_defconfig b/configs/ls1021aiot_sdcard_defconfig
index 6b32150e408..78b81c1895e 100644
--- a/configs/ls1021aiot_sdcard_defconfig
+++ b/configs/ls1021aiot_sdcard_defconfig
@@ -106,3 +106,4 @@ CONFIG_FSL_QSPI=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
+CONFIG_FSL_IFC=y
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index dde773ab6b1..229a50f266f 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -694,7 +694,11 @@ config ESM_PMIC
 	  typically to reboot the board in error condition.
 
 config FSL_IFC
-	bool
+	bool "Freescale Integrated Flash Controller"
+	help
+	  This driver is for the Integrated Flash Controller(IFC) module
+	  available in Freescale SoCs. This controller allows to handle
+	  devices such as NOR, NAND, FPGA and ASIC etc.
 
 config SL28CPLD
 	bool "Enable Kontron sl28cpld multi-function driver"
diff --git a/include/configs/ls1021aiot.h b/include/configs/ls1021aiot.h
index 971a393817a..59acf00b8e5 100644
--- a/include/configs/ls1021aiot.h
+++ b/include/configs/ls1021aiot.h
@@ -44,6 +44,40 @@
 #define CFG_SYS_DDR_SDRAM_BASE	0x80000000UL
 #define CFG_SYS_SDRAM_BASE		CFG_SYS_DDR_SDRAM_BASE
 
+/* CPLD */
+
+#define CFG_SYS_CPLD_BASE              0x7fb00000
+#define CPLD_BASE_PHYS                 CFG_SYS_CPLD_BASE
+
+#define CFG_SYS_FPGA_CSPR_EXT          (0x0)
+#define CFG_SYS_FPGA_CSPR              (CSPR_PHYS_ADDR(CPLD_BASE_PHYS) | \
+                                        CSPR_PORT_SIZE_8 | \
+                                        CSPR_MSEL_GPCM | \
+                                        CSPR_V)
+#define CFG_SYS_FPGA_AMASK             IFC_AMASK(64 * 1024)
+#define CFG_SYS_FPGA_CSOR              (CSOR_NOR_ADM_SHIFT(4) | \
+                                        CSOR_NOR_NOR_MODE_AVD_NOR | \
+                                        CSOR_NOR_TRHZ_80)
+
+/* CPLD Timing parameters for IFC GPCM */
+#define CFG_SYS_FPGA_FTIM0             (FTIM0_GPCM_TACSE(0xf) | \
+                                        FTIM0_GPCM_TEADC(0xf) | \
+                                        FTIM0_GPCM_TEAHC(0xf))
+#define CFG_SYS_FPGA_FTIM1             (FTIM1_GPCM_TACO(0xff) | \
+                                        FTIM1_GPCM_TRAD(0x3f))
+#define CFG_SYS_FPGA_FTIM2             (FTIM2_GPCM_TCS(0xf) | \
+                                        FTIM2_GPCM_TCH(0xf) | \
+                                        FTIM2_GPCM_TWP(0xff))
+#define CFG_SYS_FPGA_FTIM3             0x0
+#define CFG_SYS_CSPR0_EXT              CFG_SYS_FPGA_CSPR_EXT
+#define CFG_SYS_CSPR0                  CFG_SYS_FPGA_CSPR
+#define CFG_SYS_AMASK0                 CFG_SYS_FPGA_AMASK
+#define CFG_SYS_CSOR0                  CFG_SYS_FPGA_CSOR
+#define CFG_SYS_CS0_FTIM0              CFG_SYS_FPGA_FTIM0
+#define CFG_SYS_CS0_FTIM1              CFG_SYS_FPGA_FTIM1
+#define CFG_SYS_CS0_FTIM2              CFG_SYS_FPGA_FTIM2
+#define CFG_SYS_CS0_FTIM3              CFG_SYS_FPGA_FTIM3
+
 /*
  * Serial Port
  */
-- 
2.43.0

