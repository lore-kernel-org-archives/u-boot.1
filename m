Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A763C4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 22:23:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E831F87A80;
	Mon, 30 Oct 2023 23:23:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LFApF6mc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9A8987928; Mon, 30 Oct 2023 23:23:33 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2F1C87961
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 23:23:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4083f61322fso39116035e9.1
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 15:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698704609; x=1699309409; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=f/llm2YSVGpSIyImV6iiL9GAKivN7QCKkwaWdjVpn+k=;
 b=LFApF6mcqD5XzoBPX3YYoaNY1Mgx78XMKU8+pmaDg7TKBxOzWK9waZ3fufsHL8fVe4
 7PHSHn5IR+M0h3Zm4ObtV09WKoGfa2kH7tnftRv9put2k5i9/HX+H5FydIAZFtCyqv6V
 AQbnK0j6GmZwCPt4aEA0MwyF7v8R95+aYnx3h30sZpAYRpXtNv4Wjzu/CiT40+S20qU/
 uIhnW2tbZRN56uskyzcUKotwQ+8b9kuN4qlGnvVptmw6zzZHjqu93IAkbmD62ZBzNk3T
 1+8SP3UdA2ZT2uU4R50fxszUOK/L7JWSwNB9PgLZrDgOke1Vm+Y7mrN5ygDbHif1+RvI
 jLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698704609; x=1699309409;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f/llm2YSVGpSIyImV6iiL9GAKivN7QCKkwaWdjVpn+k=;
 b=UfzmqzI/6TzKqDYz8DvDStYPUWbtmzbfdCCYblSx28DlzHE6dGVxi67ysh+LcEHD0m
 0ANNcIflVh4QBgxZgp7Wk2odb5bPTtwPgX6VoJHeeIFSDSfi1MdsL4JjeH7AincZW5o1
 TfpxeO31NzY+rlj6t2ky/0uIFky6gSXyrclxkz/SXyjbN9x/G4LKKb3GronMR5Uu5Sqq
 bqHFLozwFMyMvBLMgsB3faFzJ6JpBiGtF3YnmHyP9/Wk3L60OvP+pJIvdGPjfpCEl96L
 1HL0JWe5LqRULTjO7c+nFHbKSjFAt8UNgmwMxMgYAKnh/AoalHx4CrbC1oVRP/1w+4ij
 H4eg==
X-Gm-Message-State: AOJu0YxHYRCbsKYbSykEK/pmpHxiq97TeLlVS5+j7AgHJ1PHKvA9y5Us
 3DMQgRaHGbsvGFJKZuTRRy0rPw==
X-Google-Smtp-Source: AGHT+IGtPLw+7Cgf2fn3qnMuxFeyqPMOTw+Y2/o0tGd07naEkGBDXyyj/JPpsDogmOXeg+ytN1L7HQ==
X-Received: by 2002:a05:600c:46cf:b0:406:52f1:7e6f with SMTP id
 q15-20020a05600c46cf00b0040652f17e6fmr9838637wmo.12.1698704609241; 
 Mon, 30 Oct 2023 15:23:29 -0700 (PDT)
Received: from lion.localdomain (host-92-25-138-185.as13285.net.
 [92.25.138.185]) by smtp.gmail.com with ESMTPSA id
 n20-20020a05600c465400b0040588d85b3asm6651wmo.15.2023.10.30.15.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 15:23:28 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 30 Oct 2023 22:23:23 +0000
Subject: [PATCH v2 1/7] clk/qcom: move from mach-snapdragon
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-b4-qcom-clk-v2-1-6572bc2be690@linaro.org>
References: <20231024-b4-qcom-clk-v2-0-6572bc2be690@linaro.org>
In-Reply-To: <20231024-b4-qcom-clk-v2-0-6572bc2be690@linaro.org>
To: Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Luka Perkov <luka.perkov@sartura.hr>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.13-dev-46309
X-Developer-Signature: v=1; a=openpgp-sha256; l=9435;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=3G3wt5UFWyHDEsQ9T7bknktXs8f9KMmMfwSgWZGT4so=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlQHnXu3vGV1GTfXlR598//KycfHLO7/sNX1ujpriSd//
 6PZlXeudZSyMAhyMMiKKbKIn1hm2bT2sr3G9gUXYOawMoEMYeDiFICJtDQwMqx6eTPh+ueL28wv
 ikbeu+Pz95vpX/cl81hdLXq6JF6uX97D8D8w8INO5xOJKb89Tc7euM2285r6LRbTkkcLps+uPbu
 IMS0ZAA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Clock drivers don't belong here, move them to the right place and
declutter mach-snapdragon a bit.

To de-couple these drivers from specific "target" platforms, add
additional config options to enable each clock driver gated behind a
common CLK_QCOM option and enable them by default for the respective
targets. This will make future work easier as we move towards a generic
Qualcomm target.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/Kconfig                   |  4 ++
 arch/arm/mach-snapdragon/Makefile                  |  5 ---
 drivers/clk/Kconfig                                |  1 +
 drivers/clk/Makefile                               |  1 +
 drivers/clk/qcom/Kconfig                           | 44 ++++++++++++++++++++++
 drivers/clk/qcom/Makefile                          |  9 +++++
 .../clk/qcom}/clock-apq8016.c                      |  2 +-
 .../clk/qcom}/clock-apq8096.c                      |  3 +-
 .../clk/qcom/clock-qcom.c                          |  2 +-
 .../clk/qcom/clock-qcom.h                          |  0
 .../clk/qcom}/clock-qcs404.c                       |  2 +-
 .../clk/qcom}/clock-sdm845.c                       |  2 +-
 12 files changed, 65 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 0e073045be54..eaf75abf4bd5 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -16,6 +16,7 @@ config SDM845
 	bool "Qualcomm Snapdragon 845 SoC"
 	default n
 	select LINUX_KERNEL_IMAGE_HEADER
+	imply CLK_QCOM_SDM845
 
 config LNX_KRNL_IMG_TEXT_OFFSET_BASE
 	default 0x80000000
@@ -27,6 +28,7 @@ config TARGET_DRAGONBOARD410C
 	bool "96Boards Dragonboard 410C"
 	select BOARD_LATE_INIT
 	select ENABLE_ARM_SOC_BOOT0_HOOK
+	imply CLK_QCOM_APQ8016
 	help
 	  Support for 96Boards Dragonboard 410C. This board complies with
 	  96Board Open Platform Specifications. Features:
@@ -40,6 +42,7 @@ config TARGET_DRAGONBOARD410C
 
 config TARGET_DRAGONBOARD820C
 	bool "96Boards Dragonboard 820C"
+	imply CLK_QCOM_APQ8096
 	help
 	  Support for 96Boards Dragonboard 820C. This board complies with
 	  96Board Open Platform Specifications. Features:
@@ -73,6 +76,7 @@ config TARGET_STARQLTECHN
 config TARGET_QCS404EVB
 	bool "Qualcomm Technologies, Inc. QCS404 EVB"
 	select LINUX_KERNEL_IMAGE_HEADER
+	imply CLK_QCOM_QCS404
 	help
 	  Support for Qualcomm Technologies, Inc. QCS404 evaluation board.
 	  Features:
diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index cbaaf23f6b56..497ee35cf7d3 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -2,20 +2,15 @@
 #
 # (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
 
-obj-$(CONFIG_SDM845) += clock-sdm845.o
 obj-$(CONFIG_SDM845) += sysmap-sdm845.o
 obj-$(CONFIG_SDM845) += init_sdm845.o
-obj-$(CONFIG_TARGET_DRAGONBOARD820C) += clock-apq8096.o
 obj-$(CONFIG_TARGET_DRAGONBOARD820C) += sysmap-apq8096.o
-obj-$(CONFIG_TARGET_DRAGONBOARD410C) += clock-apq8016.o
 obj-$(CONFIG_TARGET_DRAGONBOARD410C) += sysmap-apq8016.o
 obj-y += misc.o
-obj-y += clock-snapdragon.o
 obj-y += dram.o
 obj-y += pinctrl-snapdragon.o
 obj-y += pinctrl-apq8016.o
 obj-y += pinctrl-apq8096.o
 obj-y += pinctrl-qcs404.o
 obj-y += pinctrl-sdm845.o
-obj-$(CONFIG_TARGET_QCS404EVB) += clock-qcs404.o
 obj-$(CONFIG_TARGET_QCS404EVB) += sysmap-qcs404.o
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index bfd23a990469..017dd260a544 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -254,6 +254,7 @@ source "drivers/clk/meson/Kconfig"
 source "drivers/clk/microchip/Kconfig"
 source "drivers/clk/mvebu/Kconfig"
 source "drivers/clk/owl/Kconfig"
+source "drivers/clk/qcom/Kconfig"
 source "drivers/clk/renesas/Kconfig"
 source "drivers/clk/sunxi/Kconfig"
 source "drivers/clk/sifive/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 26bf429acbc0..dd974742b6c8 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_CLK_MPFS) += microchip/
 obj-$(CONFIG_CLK_MVEBU) += mvebu/
 obj-$(CONFIG_CLK_OCTEON) += clk_octeon.o
 obj-$(CONFIG_CLK_OWL) += owl/
+obj-$(CONFIG_CLK_QCOM) += qcom/
 obj-$(CONFIG_CLK_RENESAS) += renesas/
 obj-$(CONFIG_$(SPL_TPL_)CLK_SCMI) += clk_scmi.o
 obj-$(CONFIG_CLK_SIFIVE) += sifive/
diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
new file mode 100644
index 000000000000..a884f077d9b9
--- /dev/null
+++ b/drivers/clk/qcom/Kconfig
@@ -0,0 +1,44 @@
+if ARCH_SNAPDRAGON || ARCH_IPQ40XX
+
+config CLK_QCOM
+	bool
+	depends on CLK && DM_RESET
+	def_bool n
+
+menu "Qualcomm clock drivers"
+
+config CLK_QCOM_APQ8016
+	bool "Qualcomm APQ8016 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Snapdragon APQ8016 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
+config CLK_QCOM_APQ8096
+	bool "Qualcomm APQ8096 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Snapdragon APQ8096 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
+config CLK_QCOM_QCS404
+	bool "Qualcomm QCS404 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Snapdragon QCS404 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
+config CLK_QCOM_SDM845
+	bool "Qualcomm SDM845 GCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the Global Clock Controller
+	  on the Snapdragon 845 SoC. This driver supports the clocks
+	  and resets exposed by the GCC hardware block.
+
+endmenu
+
+endif
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
new file mode 100644
index 000000000000..44d55583596d
--- /dev/null
+++ b/drivers/clk/qcom/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# (C) Copyright 2023 Linaro
+
+obj-y += clock-qcom.o
+obj-$(CONFIG_CLK_QCOM_SDM845) += clock-sdm845.o
+obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
+obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
+obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
diff --git a/arch/arm/mach-snapdragon/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
similarity index 98%
rename from arch/arm/mach-snapdragon/clock-apq8016.c
rename to drivers/clk/qcom/clock-apq8016.c
index 23a37a1714dc..90f2a93d9ed5 100644
--- a/arch/arm/mach-snapdragon/clock-apq8016.c
+++ b/drivers/clk/qcom/clock-apq8016.c
@@ -13,7 +13,7 @@
 #include <errno.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
-#include "clock-snapdragon.h"
+#include "clock-qcom.h"
 
 /* GPLL0 clock control registers */
 #define GPLL0_STATUS_ACTIVE BIT(17)
diff --git a/arch/arm/mach-snapdragon/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
similarity index 98%
rename from arch/arm/mach-snapdragon/clock-apq8096.c
rename to drivers/clk/qcom/clock-apq8096.c
index 66184596d562..d5388c69aefe 100644
--- a/arch/arm/mach-snapdragon/clock-apq8096.c
+++ b/drivers/clk/qcom/clock-apq8096.c
@@ -13,7 +13,8 @@
 #include <errno.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
-#include "clock-snapdragon.h"
+
+#include "clock-qcom.h"
 
 /* GPLL0 clock control registers */
 #define GPLL0_STATUS_ACTIVE		BIT(30)
diff --git a/arch/arm/mach-snapdragon/clock-snapdragon.c b/drivers/clk/qcom/clock-qcom.c
similarity index 99%
rename from arch/arm/mach-snapdragon/clock-snapdragon.c
rename to drivers/clk/qcom/clock-qcom.c
index 0ac45dce9a92..5667abeb89a4 100644
--- a/arch/arm/mach-snapdragon/clock-snapdragon.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -13,7 +13,7 @@
 #include <errno.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
-#include "clock-snapdragon.h"
+#include "clock-qcom.h"
 
 /* CBCR register fields */
 #define CBCR_BRANCH_ENABLE_BIT  BIT(0)
diff --git a/arch/arm/mach-snapdragon/clock-snapdragon.h b/drivers/clk/qcom/clock-qcom.h
similarity index 100%
rename from arch/arm/mach-snapdragon/clock-snapdragon.h
rename to drivers/clk/qcom/clock-qcom.h
diff --git a/arch/arm/mach-snapdragon/clock-qcs404.c b/drivers/clk/qcom/clock-qcs404.c
similarity index 99%
rename from arch/arm/mach-snapdragon/clock-qcs404.c
rename to drivers/clk/qcom/clock-qcs404.c
index 3357b54c30c0..80218af73ef6 100644
--- a/arch/arm/mach-snapdragon/clock-qcs404.c
+++ b/drivers/clk/qcom/clock-qcs404.c
@@ -11,7 +11,7 @@
 #include <errno.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
-#include "clock-snapdragon.h"
+#include "clock-qcom.h"
 
 #include <dt-bindings/clock/qcom,gcc-qcs404.h>
 
diff --git a/arch/arm/mach-snapdragon/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
similarity index 98%
rename from arch/arm/mach-snapdragon/clock-sdm845.c
rename to drivers/clk/qcom/clock-sdm845.c
index d6df0365afca..95a057b82986 100644
--- a/arch/arm/mach-snapdragon/clock-sdm845.c
+++ b/drivers/clk/qcom/clock-sdm845.c
@@ -15,7 +15,7 @@
 #include <asm/io.h>
 #include <linux/bitops.h>
 #include <dt-bindings/clock/qcom,gcc-sdm845.h>
-#include "clock-snapdragon.h"
+#include "clock-qcom.h"
 
 #define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
 

-- 
2.42.0

