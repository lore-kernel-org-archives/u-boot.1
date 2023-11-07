Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB112C4167B
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 12:41:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C858387210;
	Tue,  7 Nov 2023 13:41:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AsP6Erti";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DA9F871F5; Tue,  7 Nov 2023 13:41:18 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35DE48719F
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 13:41:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2c514cbbe7eso79405031fa.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 04:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699360873; x=1699965673; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o1eZJ05zkmdBDK3BZIVlzxC7Z+q8fBUto/BVLVg6NaQ=;
 b=AsP6ErtihrfYoikZGKh42rKzJVhrGEX0zHna9ae6on2qJexQJ3gHOp4s4GqM0h++KW
 GaUh39Fd5RMTwiyiZw1K9vD0dbi7UXQ9aFEdV/Lumfrw/ossM6xzPRlQHZ0onbiHz7CU
 bwBCzUNXsJXAJQhDLYmKyw2VbJH7oYe+xnztJDzm8HlDh6uNB8SZvnSxQffTvIjbK9ig
 ZApgXTA1i5g+o6a5AuX6RGrgP9o6u327ksXF72YGMxHgDGWmKf8U0SKl6jhIYKZxWFsm
 4d4QACqi+JULMwFAx9Masj8W/7n5NW46Hzcna5Bzq+iMqos5697d5JHQ9shGgT8XeBE3
 U4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699360873; x=1699965673;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o1eZJ05zkmdBDK3BZIVlzxC7Z+q8fBUto/BVLVg6NaQ=;
 b=F8EJ8Knu6ENJmemflIOs85RhO51UfT1blJa9NQP72iDoBlSvBblTyDZ3lOLBP+h/jm
 bSgRiJnmKBxiQUNXIpTl7o92ulhpGfyb5cJ4k7/SERh3iWaEuoLSVc+AoSQFPelXNbq8
 4YofYQVw75jT8AG0JGH7A9+d/fBLeqHUpyC8PS+NKoKZlT3IceRBqedIZfIWQoOO3fKL
 m96IBye7WxsJ9Y5+tnIrAj792Jr6K1IlmkTF9Da9YK6fPgSynebvLyZtKBvOAOkvWBm4
 wgQ/mSDqq8V8bDxyJE4sEoc++wPEYJIrO3LkT8k0kfqcuya9h8fJb3jwV/VastE26NU3
 4ZmQ==
X-Gm-Message-State: AOJu0Yy3cE7cvGAx+NEEZr+5M92uoHTQjn3ElqSlYhPfrdBSWhO+h14j
 hLUTM7xeEWaiOWOVV7E6XzvuQQ==
X-Google-Smtp-Source: AGHT+IHe2wn+XX7ZyZx8wmCWKjkz1JKATSQ9lMuz0/tFRYPPLhraEXMefovIiFqhDH7lVQgra+ZULA==
X-Received: by 2002:a05:6512:3ba8:b0:509:3785:fd98 with SMTP id
 g40-20020a0565123ba800b005093785fd98mr18498740lfv.44.1699360873363; 
 Tue, 07 Nov 2023 04:41:13 -0800 (PST)
Received: from lion.localdomain (host-92-25-138-185.as13285.net.
 [92.25.138.185]) by smtp.gmail.com with ESMTPSA id
 v11-20020a5d610b000000b0032d09f7a713sm2285333wrt.18.2023.11.07.04.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 04:41:12 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 07 Nov 2023 12:40:59 +0000
Subject: [PATCH v4 1/7] clk/qcom: move from mach-snapdragon
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231107-b4-qcom-clk-v4-1-82bbaf1a796d@linaro.org>
References: <20231107-b4-qcom-clk-v4-0-82bbaf1a796d@linaro.org>
In-Reply-To: <20231107-b4-qcom-clk-v4-0-82bbaf1a796d@linaro.org>
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
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhlQvg7T9n2s7Z7bFS1nfK95c9im2991e67rTE1Y/6eZVy
 J7zUEWro5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAExk6TmG/86zp035d3fF4bfa
 kbO/L7wVf+FB0b0DT7/8DkhfkPp+HnM0I8OUKUd7e87NeGy8euJR1o4PVsJ102V+rv6r7X16V/q
 9c26VAA==
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

