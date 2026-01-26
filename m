Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED4ED19502
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 17:42:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26ECD83BD2;
	Mon, 26 Jan 2026 18:42:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jI13S/sU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7234483E70; Mon, 26 Jan 2026 17:05:45 +0100 (CET)
Received: from mail-dl1-x1235.google.com (mail-dl1-x1235.google.com
 [IPv6:2607:f8b0:4864:20::1235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B03A83C04
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 17:05:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mateuslima.ti@gmail.com
Received: by mail-dl1-x1235.google.com with SMTP id
 a92af1059eb24-1233702afd3so6185930c88.0
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 08:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769443541; x=1770048341; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Hf6YklS9nQvv+j6/Uk48dAoRqlA0JvgTZVI0ibGRAk4=;
 b=jI13S/sUCVE79qNDPEiX6MaD+jnsYsxwOmYaF8to4TVeCqrn5v05YO63CWZcCV0QAO
 96ZwQov/D5jxicI5/KyAJhGcT1CCVBnmEUDaDoev6Un0FcHJjI55W9BYmczv/fOVuPaf
 gNgD5JZq4aVq4QAxrwfUY5VhLWcGbQCsudh15jBMIdyfReNjxPviAKC4AzepQwneZaKf
 Dw0L9+XTDFepVcPivkyt7qtRY3+D1UK5fcd4Jsqyes1BUg3iCDJtCYi364Lip4REH9nx
 jGhpKU1b8pzyhBnk6NtreaNAg3ff7Tu99Kzd2CautBUJNRTeiyAjQItm+cRvGEIJUm1S
 4grQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769443541; x=1770048341;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hf6YklS9nQvv+j6/Uk48dAoRqlA0JvgTZVI0ibGRAk4=;
 b=GdmGVXzYdLa4N5YMDYejntmLSIyV1FXmlKN5ktZfocxP9mQbi3AxlXswXNpPBaSj5G
 xl6rzyIZp7Q2vCSUPA1nYcqKg1psdLx298wZXk4cTqtu5gQMWhwVP1p0lvq7fXFxwjqd
 PtO1XwhIef2RurKYhPL7AvHY/2YjMgnGvNsFjJBTkAcHF9SzDjQSV5rXNnbv2St7df7y
 9ty/EPHve1uX0fRGDC4lI5Km45NbzcrQS2j2NEPKBfY6tE+k/buJ8LQ+2tJks70rMfC/
 eE8O7o7LJNjutPCkgAPRSzBLHyUST8iB2+EGfeU4100dQP0eoYyfW1Kd6XWQdhL0eaOg
 4T3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1i4hGG0H9rSMEW++Vn1cx84csUeq0MmSWQz8BAiluGUpXR5llgBEmaG+XSODAyHls2E09fco=@lists.denx.de
X-Gm-Message-State: AOJu0Yw88+QbH538T/3MsEOfJfKO638aza2a2l4smaGUNXfzN7BrRlC2
 eegexIOVUTMqTLVhOniODr9b1XDGQdc6SpLN8FVMGULt7C7+AVFG1trdwhy15g==
X-Gm-Gg: AZuq6aJyqUq6ttQM5B68HIWzVL4zF8NneSCP/KdiTZWw4Xd8yZr7geTnTKiEiKafj3C
 +E8EXynpWfkRTopXgY+pajtP8uN3/o3HEh+uSpH9655ZxtJooCkw+Hmtw0tVCCRY4XpjmKxG0v7
 /ZgbmYna/jFjtRJSqIf+6WeTk2RO6+pK4HRF9G6NGW5qZbS4nFn6OpJQLViefWVLug920DLFth6
 TpraFgLs+QvXBvNjDduuSmWKlyEbwb0GvxKTfMeKnJkdZjbHsIvtVCS8Zp0SaRQlNb/ky1WOW0a
 Cjut9Eqaeq7A6ySW1ykUw+bvMLWWCp7ZsDxU4HhV3r+l3KRZW1GCj7nU75hS22fZeuvpQiVZX9u
 WQc1QGYto1kq1v/A8VkWFJCu05RHoBn9JWlqdIoksVk6oNLdzAlHhNJu+x/J7naHe1bUJSl7kSw
 oZmBaqT3cKLrufDmCRhzRpXVM0oCkzVWRDnBg1EmfGjJB1Yye5NgNjh14f
X-Received: by 2002:a05:7022:69a7:b0:11e:3e9:3e8c with SMTP id
 a92af1059eb24-1248ec9dcc8mr3023048c88.49.1769443540547; 
 Mon, 26 Jan 2026 08:05:40 -0800 (PST)
Received: from ped-6489-Latitude-3550.mobit.com.br ([177.22.36.222])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1247d9a3f22sm20062079c88.13.2026.01.26.08.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 08:05:39 -0800 (PST)
From: Mateus Lima Alves <mateuslima.ti@gmail.com>
To: peng.fan@oss.nxp.com,
	alison.wang@nxp.com
Cc: Mateus Lima Alves <mateuslima.ti@gmail.com>,
	u-boot@lists.denx.de
Subject: [PATCH v3] armv7: Add CPLD support via IFC to the ls1021a-iot board.
Date: Mon, 26 Jan 2026 13:05:19 -0300
Message-ID: <20260126160521.250497-1-mateuslima.ti@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Jan 2026 18:42:09 +0100
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
Changes since v2:
Added dependency on the ARM architecture, given reports of PPC targets
with compilation errors.

---
 board/freescale/ls1021aiot/ls1021aiot.c |  5 ++++
 configs/ls1021aiot_sdcard_defconfig     |  1 +
 drivers/misc/Kconfig                    |  7 ++++-
 include/configs/ls1021aiot.h            | 34 +++++++++++++++++++++++++
 4 files changed, 46 insertions(+), 1 deletion(-)

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
index dde773ab6b1..be7fdab56d1 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -694,7 +694,12 @@ config ESM_PMIC
 	  typically to reboot the board in error condition.
 
 config FSL_IFC
-	bool
+	bool "Freescale Integrated Flash Controller"
+	depends on ARM
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

