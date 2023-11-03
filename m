Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3810AC4167B
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 15:39:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F055787115;
	Fri,  3 Nov 2023 16:39:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hZRN31G3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FE1587467; Fri,  3 Nov 2023 16:39:39 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33BDA870F6
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 16:39:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40859dee28cso16441895e9.0
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 08:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699025971; x=1699630771; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o1eZJ05zkmdBDK3BZIVlzxC7Z+q8fBUto/BVLVg6NaQ=;
 b=hZRN31G3HUUfZzD/VKWK5BfSu1BJAGI3gVWJWEiHvTt++N3g1FQum3BfDm9t1oIwD2
 a74JYxcpkSixTgtd5Ki8DQ0l9+wxBH0e7O4/Q19G6BzMUNJ6zsCLgpYcMXinx7rMm28G
 37SQt/KCDqFomEpHlHh/oalYesD9w62FF7Y+97t3yoTIal/NuNbB6xg7JW+n9CYgxMuI
 dSrKP5kWAKtFkZQSLo/aG1yXbx9bhPYO+x14iz+MXo2GFiK838B47v8QIpjTixNDQ/qM
 uy96xiG+ruGqquJhk8TWnxO7XTwRSJ9rXJmpLlKDqu87R9wEj192lVnO0GSoxgF6fM7J
 Chcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699025971; x=1699630771;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o1eZJ05zkmdBDK3BZIVlzxC7Z+q8fBUto/BVLVg6NaQ=;
 b=P8r1vvsmMV6TEqzmPyY0/xw66GZlL9PuuB0Dfw4OVOqTFpp8+MyQSLjT/iqqrBeKVa
 SX5Q2psv1X8WlxaawXXG1CyWd+6DMO7wMilLGehbtVcAUOfzTbr6bQsTsNzN/PETSxFJ
 cjogJ35QIyWSq5HHEklzXQexn2QO2Pvrr0WfroKyrI8QWZB2FGoABX0gZaY/GmP/HDx9
 VfyUJ+k8Ad7Df1+VrmQ2+kOBiOzkL78uknnk3Ot9aLg3ha6OU5Yh9kiCP3G339ywYSpg
 gzm0N78jotkuzPQG4CW1EYGY6pG6u9uqZ/yi4AIler1fHQhcizt/Jt64kjutXxpzkRwa
 IS/Q==
X-Gm-Message-State: AOJu0Yxl4T5Cb4cKkWoZ9psU9+O+fb/V+yYtvgOUno9PbnUAOSgWvfF1
 1STYh6IC12sTQpV/RRH0gEzowA==
X-Google-Smtp-Source: AGHT+IHktrCGvAJjgZEZHOzA7a6NsimP6O1Pm5XDuEu/Upa8PZ4px1+STcOb3feeCFSJi3XlfNXUJg==
X-Received: by 2002:a05:600c:310d:b0:405:3a65:1b4c with SMTP id
 g13-20020a05600c310d00b004053a651b4cmr18510613wmo.6.1699025971571; 
 Fri, 03 Nov 2023 08:39:31 -0700 (PDT)
Received: from lion.localdomain (host-92-25-138-185.as13285.net.
 [92.25.138.185]) by smtp.gmail.com with ESMTPSA id
 fm15-20020a05600c0c0f00b00405391f485fsm2928334wmb.41.2023.11.03.08.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 08:39:31 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 03 Nov 2023 15:39:25 +0000
Subject: [PATCH v3 1/7] clk/qcom: move from mach-snapdragon
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231103-b4-qcom-clk-v3-1-8d2d460ece84@linaro.org>
References: <20231103-b4-qcom-clk-v3-0-8d2d460ece84@linaro.org>
In-Reply-To: <20231103-b4-qcom-clk-v3-0-8d2d460ece84@linaro.org>
To: Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Luka Perkov <luka.perkov@sartura.hr>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 u-boot@lists.denx.de, Sumit Garg <sumit.garg@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=9951;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=HwZLe9Re4u0qVTj3COJJt+sQ4sAllAAa6/DQN/VLZW8=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlRXEYPyQ/WWkpMvfCs8cs041MTnW5nx154oR5aWxdoKn
 zkMXqzqKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABNJ283IsMln6buMvI7t5fXd
 u1zMNi3Sytj77Iz57n/hdwQS1CxnLmf4Z9uuFPtW7K354/VLe+t+i/0LDVRcaiLPzlgndGXd8Vf
 vQwA=
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

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 MAINTAINERS                                        |  1 +
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
 13 files changed, 66 insertions(+), 10 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 091e6bb5084d..b483fa2ea95a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -572,6 +572,7 @@ M:	Neil Armstrong <neil.armstrong@linaro.org>
 R:	Sumit Garg <sumit.garg@linaro.org>
 S:	Maintained
 F:	arch/arm/mach-snapdragon/
+F:	drivers/clk/qcom/
 F:	drivers/gpio/msm_gpio.c
 F:	drivers/mmc/msm_sdhci.c
 F:	drivers/phy/msm8916-usbh-phy.c
diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 2fc1521e2d30..dde37eccc55e 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -15,6 +15,7 @@ config SPL_SYS_MALLOC_F_LEN
 config SDM845
 	bool "Qualcomm Snapdragon 845 SoC"
 	select LINUX_KERNEL_IMAGE_HEADER
+	imply CLK_QCOM_SDM845
 
 config LNX_KRNL_IMG_TEXT_OFFSET_BASE
 	default 0x80000000
@@ -26,6 +27,7 @@ config TARGET_DRAGONBOARD410C
 	bool "96Boards Dragonboard 410C"
 	select BOARD_LATE_INIT
 	select ENABLE_ARM_SOC_BOOT0_HOOK
+	imply CLK_QCOM_APQ8016
 	help
 	  Support for 96Boards Dragonboard 410C. This board complies with
 	  96Board Open Platform Specifications. Features:
@@ -39,6 +41,7 @@ config TARGET_DRAGONBOARD410C
 
 config TARGET_DRAGONBOARD820C
 	bool "96Boards Dragonboard 820C"
+	imply CLK_QCOM_APQ8096
 	help
 	  Support for 96Boards Dragonboard 820C. This board complies with
 	  96Board Open Platform Specifications. Features:
@@ -72,6 +75,7 @@ config TARGET_STARQLTECHN
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

