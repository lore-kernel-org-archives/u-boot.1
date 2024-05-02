Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A39C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:44:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8686588D3F;
	Thu,  2 May 2024 03:34:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BPZfzMZn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B90DC88C90; Thu,  2 May 2024 03:33:28 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB79388CAE
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:33:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4376e3fd7e4so42029911cf.2
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613602; x=1715218402; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ed7rFe9x7mPun+yG/tjHpMIOVzgoT29j3k1e1VtEEfE=;
 b=BPZfzMZnPJzTNPbXkOjl0EBzaVnPjvurRLz8x+95XT2rnmDU3lmOObiGmA+/jBqTgc
 wa5OLT4LU2XaKIhWyKs4hDMdpoJEG9Mo+tGXAeVeRA08DfTy5zHE9l1ZnoLjC0Au0Hr9
 XCtn4p3Ycy3Ogz4qALeu7OVzqFLz93WHnOLOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613602; x=1715218402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ed7rFe9x7mPun+yG/tjHpMIOVzgoT29j3k1e1VtEEfE=;
 b=R4JhksJHYGoMrPa5GmKyhh51chzWgwPeAeQMAWXv2hFd3/FHI0m5C8rN82Z7Ujo4s/
 kaiNGmRt8MSAoMOR0sRZYZgoaARzde9nPx95z0Iw4DjSJoM//G92D2rZTAqrXxEbHPks
 njGf9ulVUzdIz2grXDE33AnpdHHVZqOC94ZudVP79HlG37BphBfQUx8LNAKTtic7YF7L
 ChDDWEupMciHeG4HLj81npZ4M8tP0+Fzil/O+ZOELFJQvguC3MqLne1aW/I7dX9s5W6S
 XKTsdcK7EBmdZOJ6NxanirRecBw8CAfIIT5ZwCu38uTgpnNMxo13Hqb5shIbutjnkOpR
 7H0w==
X-Gm-Message-State: AOJu0YwFGy019gNCgIeFyxKN9cGJNOi2nON2iuYcmF4t63jjKNfpWw8C
 WnH6eCuiFFpJGWxabz+eJztwp6SKrG3gV2aPbqKpmJVLCjiwVCOPjnGDipghgArSrtASDuFKUN4
 qAEA0OD1H
X-Google-Smtp-Source: AGHT+IHEMCIODKBfm3afeHGJoCoz1zbx1x+pamDj1PHOzbH0VdiCnvopMx4Iy/q+cZ8f6HVsPUIuPg==
X-Received: by 2002:a05:622a:281:b0:43a:ed31:9f71 with SMTP id
 z1-20020a05622a028100b0043aed319f71mr4425375qtw.30.1714613601902; 
 Wed, 01 May 2024 18:33:21 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:33:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Michal Simek <michal.simek@amd.com>, Stephan Gerhold <stephan@gerhold.net>,
 Linus Walleij <linus.walleij@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@denx.de>,
 Marek Vasut <marex@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Bryan Brattlof <bb@ti.com>, Nishanth Menon <nm@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Igor Opaniuk <igor.opaniuk@foundries.io>,
 Roger Quadros <rogerq@kernel.org>, Apurva Nandan <a-nandan@ti.com>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Bhargav Raviprakash <bhargav.r@ltts.com>, Udit Kumar <u-kumar1@ti.com>,
 Dhruva Gole <d-gole@ti.com>, Eugen Hristev <eugen.hristev@collabora.com>,
 Joseph Chen <chenjh@rock-chips.com>, shengfei Xu <xsf@rock-chips.com>,
 William Wu <william.wu@rock-chips.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH 52/81] power: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:31:09 -0600
Message-Id: <20240502013138.2383421-52-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 May 2024 03:34:44 +0200
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

Remove <common.h> from this driver directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Stephan Gerhold <stephan@gerhold.net>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Marek Vasut <marex@denx.de>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Bryan Brattlof <bb@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>
Cc: Igor Opaniuk <igor.opaniuk@foundries.io>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Apurva Nandan <a-nandan@ti.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Bhargav Raviprakash <bhargav.r@ltts.com>
Cc: Udit Kumar <u-kumar1@ti.com>
Cc: Dhruva Gole <d-gole@ti.com>
Cc: Eugen Hristev <eugen.hristev@collabora.com>
Cc: Joseph Chen <chenjh@rock-chips.com>
Cc: shengfei Xu <xsf@rock-chips.com>
Cc: William Wu <william.wu@rock-chips.com>
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>
Cc: Etienne Carriere <etienne.carriere@foss.st.com>
---
 drivers/power/acpi_pmc/acpi-pmc-uclass.c         | 1 -
 drivers/power/acpi_pmc/pmc_emul.c                | 1 -
 drivers/power/acpi_pmc/sandbox.c                 | 1 -
 drivers/power/axp152.c                           | 2 +-
 drivers/power/axp209.c                           | 2 +-
 drivers/power/axp221.c                           | 1 -
 drivers/power/axp305.c                           | 1 -
 drivers/power/axp313.c                           | 1 -
 drivers/power/axp809.c                           | 1 -
 drivers/power/axp818.c                           | 1 -
 drivers/power/domain/apple-pmgr.c                | 1 -
 drivers/power/domain/bcm6328-power-domain.c      | 1 -
 drivers/power/domain/imx8-power-domain-legacy.c  | 1 -
 drivers/power/domain/imx8-power-domain.c         | 1 -
 drivers/power/domain/imx8m-power-domain.c        | 1 -
 drivers/power/domain/imx8mp-hsiomix.c            | 1 -
 drivers/power/domain/meson-ee-pwrc.c             | 1 -
 drivers/power/domain/meson-gx-pwrc-vpu.c         | 1 -
 drivers/power/domain/mtk-power-domain.c          | 1 -
 drivers/power/domain/power-domain-uclass.c       | 1 -
 drivers/power/domain/sandbox-power-domain-test.c | 1 -
 drivers/power/domain/sandbox-power-domain.c      | 1 -
 drivers/power/domain/tegra186-power-domain.c     | 1 -
 drivers/power/domain/ti-power-domain.c           | 1 -
 drivers/power/domain/ti-sci-power-domain.c       | 1 -
 drivers/power/domain/zynqmp-power-domain.c       | 1 -
 drivers/power/exynos-tmu.c                       | 3 ++-
 drivers/power/mt6323.c                           | 1 -
 drivers/power/pmic/ab8500.c                      | 1 -
 drivers/power/pmic/act8846.c                     | 1 -
 drivers/power/pmic/as3722.c                      | 1 -
 drivers/power/pmic/as3722_gpio.c                 | 1 -
 drivers/power/pmic/bd71837.c                     | 1 -
 drivers/power/pmic/da9063.c                      | 1 -
 drivers/power/pmic/fan53555.c                    | 1 -
 drivers/power/pmic/i2c_pmic_emul.c               | 1 -
 drivers/power/pmic/lp873x.c                      | 1 -
 drivers/power/pmic/lp87565.c                     | 1 -
 drivers/power/pmic/max77686.c                    | 1 -
 drivers/power/pmic/max8997.c                     | 1 -
 drivers/power/pmic/max8998.c                     | 1 -
 drivers/power/pmic/mc34708.c                     | 1 -
 drivers/power/pmic/mp5416.c                      | 1 -
 drivers/power/pmic/palmas.c                      | 1 -
 drivers/power/pmic/pca9450.c                     | 1 -
 drivers/power/pmic/pfuze100.c                    | 1 -
 drivers/power/pmic/pmic-uclass.c                 | 1 -
 drivers/power/pmic/pmic_hi6553.c                 | 1 -
 drivers/power/pmic/pmic_ltc3676.c                | 1 -
 drivers/power/pmic/pmic_mc34vr500.c              | 1 -
 drivers/power/pmic/pmic_pca9450.c                | 1 -
 drivers/power/pmic/pmic_pfuze100.c               | 1 -
 drivers/power/pmic/pmic_pfuze3000.c              | 1 -
 drivers/power/pmic/pmic_qcom.c                   | 1 -
 drivers/power/pmic/pmic_tps62362.c               | 1 -
 drivers/power/pmic/pmic_tps65217.c               | 1 -
 drivers/power/pmic/pmic_tps65218.c               | 1 -
 drivers/power/pmic/pmic_tps65910.c               | 1 -
 drivers/power/pmic/pmic_tps65910_dm.c            | 1 -
 drivers/power/pmic/rk8xx.c                       | 1 -
 drivers/power/pmic/rn5t567.c                     | 1 -
 drivers/power/pmic/s2mps11.c                     | 1 -
 drivers/power/pmic/s5m8767.c                     | 1 -
 drivers/power/pmic/sandbox.c                     | 1 -
 drivers/power/pmic/stpmic1.c                     | 1 -
 drivers/power/pmic/tps65090.c                    | 1 -
 drivers/power/pmic/tps65219.c                    | 1 -
 drivers/power/pmic/tps65941.c                    | 1 -
 drivers/power/power_core.c                       | 1 -
 drivers/power/power_dialog.c                     | 2 +-
 drivers/power/power_fsl.c                        | 2 +-
 drivers/power/power_i2c.c                        | 1 -
 drivers/power/power_spi.c                        | 1 -
 drivers/power/regulator/act8846.c                | 1 -
 drivers/power/regulator/anatop_regulator.c       | 1 -
 drivers/power/regulator/as3722_regulator.c       | 1 -
 drivers/power/regulator/bd71837.c                | 1 -
 drivers/power/regulator/da9063.c                 | 1 -
 drivers/power/regulator/fan53555.c               | 1 -
 drivers/power/regulator/fixed.c                  | 1 -
 drivers/power/regulator/gpio-regulator.c         | 1 -
 drivers/power/regulator/lp873x_regulator.c       | 1 -
 drivers/power/regulator/lp87565_regulator.c      | 1 -
 drivers/power/regulator/max77686.c               | 1 -
 drivers/power/regulator/npcm8xx_regulator.c      | 1 -
 drivers/power/regulator/palmas_regulator.c       | 1 -
 drivers/power/regulator/pbias_regulator.c        | 1 -
 drivers/power/regulator/pca9450.c                | 1 -
 drivers/power/regulator/pfuze100.c               | 1 -
 drivers/power/regulator/pwm_regulator.c          | 1 -
 drivers/power/regulator/regulator-uclass.c       | 1 -
 drivers/power/regulator/regulator_common.c       | 1 -
 drivers/power/regulator/rk8xx.c                  | 1 -
 drivers/power/regulator/s2mps11_regulator.c      | 1 -
 drivers/power/regulator/s5m8767.c                | 1 -
 drivers/power/regulator/sandbox.c                | 1 -
 drivers/power/regulator/scmi_regulator.c         | 1 -
 drivers/power/regulator/stm32-vrefbuf.c          | 1 -
 drivers/power/regulator/stpmic1.c                | 1 -
 drivers/power/regulator/tps62360_regulator.c     | 1 -
 drivers/power/regulator/tps65090_regulator.c     | 2 +-
 drivers/power/regulator/tps65219_regulator.c     | 1 -
 drivers/power/regulator/tps65910_regulator.c     | 1 -
 drivers/power/regulator/tps65941_regulator.c     | 1 -
 drivers/power/sy8106a.c                          | 1 -
 drivers/power/tps6586x.c                         | 2 +-
 106 files changed, 8 insertions(+), 106 deletions(-)

diff --git a/drivers/power/acpi_pmc/acpi-pmc-uclass.c b/drivers/power/acpi_pmc/acpi-pmc-uclass.c
index 34446a34e60d..c289cede15b8 100644
--- a/drivers/power/acpi_pmc/acpi-pmc-uclass.c
+++ b/drivers/power/acpi_pmc/acpi-pmc-uclass.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_ACPI_PMC
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <spl.h>
diff --git a/drivers/power/acpi_pmc/pmc_emul.c b/drivers/power/acpi_pmc/pmc_emul.c
index 8015031da859..8eff3d9fa7ac 100644
--- a/drivers/power/acpi_pmc/pmc_emul.c
+++ b/drivers/power/acpi_pmc/pmc_emul.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <pci.h>
diff --git a/drivers/power/acpi_pmc/sandbox.c b/drivers/power/acpi_pmc/sandbox.c
index 8cf03f737c08..ed1bb1980931 100644
--- a/drivers/power/acpi_pmc/sandbox.c
+++ b/drivers/power/acpi_pmc/sandbox.c
@@ -7,7 +7,6 @@
 
 #define LOG_CATEGORY UCLASS_ACPI_PMC
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <asm/io.h>
diff --git a/drivers/power/axp152.c b/drivers/power/axp152.c
index a93987c15382..5a62382ab86e 100644
--- a/drivers/power/axp152.c
+++ b/drivers/power/axp152.c
@@ -3,8 +3,8 @@
  * (C) Copyright 2012
  * Henrik Nordstrom <henrik@henriknordstrom.net>
  */
-#include <common.h>
 #include <command.h>
+#include <linux/errno.h>
 #include <asm/arch/pmic_bus.h>
 #include <axp_pmic.h>
 
diff --git a/drivers/power/axp209.c b/drivers/power/axp209.c
index 3447b9f0113a..6ae416982ebe 100644
--- a/drivers/power/axp209.c
+++ b/drivers/power/axp209.c
@@ -4,11 +4,11 @@
  * Henrik Nordstrom <henrik@henriknordstrom.net>
  */
 
-#include <common.h>
 #include <command.h>
 #include <asm/arch/pmic_bus.h>
 #include <axp_pmic.h>
 #include <linux/delay.h>
+#include <linux/errno.h>
 
 #ifdef CONFIG_AXP_ALDO3_VOLT_SLOPE_08
 #  define AXP209_VRC_SLOPE AXP209_VRC_LDO3_800uV_uS
diff --git a/drivers/power/axp221.c b/drivers/power/axp221.c
index d251c314b987..c22ca03f4694 100644
--- a/drivers/power/axp221.c
+++ b/drivers/power/axp221.c
@@ -9,7 +9,6 @@
  * (C) Copyright 2013 Oliver Schinagl <oliver@schinagl.nl>
  */
 
-#include <common.h>
 #include <command.h>
 #include <errno.h>
 #include <asm/arch/pmic_bus.h>
diff --git a/drivers/power/axp305.c b/drivers/power/axp305.c
index 049ef07f7467..0312ad9af763 100644
--- a/drivers/power/axp305.c
+++ b/drivers/power/axp305.c
@@ -9,7 +9,6 @@
  * (C) Copyright 2013 Oliver Schinagl <oliver@schinagl.nl>
  */
 
-#include <common.h>
 #include <command.h>
 #include <errno.h>
 #include <asm/arch/pmic_bus.h>
diff --git a/drivers/power/axp313.c b/drivers/power/axp313.c
index bbc9e911115f..09ecb5b1ec28 100644
--- a/drivers/power/axp313.c
+++ b/drivers/power/axp313.c
@@ -10,7 +10,6 @@
  * (C) Copyright 2013 Oliver Schinagl <oliver@schinagl.nl>
  */
 
-#include <common.h>
 #include <command.h>
 #include <errno.h>
 #include <asm/arch/pmic_bus.h>
diff --git a/drivers/power/axp809.c b/drivers/power/axp809.c
index d327a584ded0..9e38e1a74508 100644
--- a/drivers/power/axp809.c
+++ b/drivers/power/axp809.c
@@ -10,7 +10,6 @@
  * (C) Copyright 2013 Oliver Schinagl <oliver@schinagl.nl>
  */
 
-#include <common.h>
 #include <command.h>
 #include <errno.h>
 #include <asm/arch/pmic_bus.h>
diff --git a/drivers/power/axp818.c b/drivers/power/axp818.c
index 08286ea3b550..83ae6ecc138d 100644
--- a/drivers/power/axp818.c
+++ b/drivers/power/axp818.c
@@ -10,7 +10,6 @@
  * (C) Copyright 2013 Oliver Schinagl <oliver@schinagl.nl>
  */
 
-#include <common.h>
 #include <command.h>
 #include <errno.h>
 #include <asm/arch/pmic_bus.h>
diff --git a/drivers/power/domain/apple-pmgr.c b/drivers/power/domain/apple-pmgr.c
index 402c5b1fd188..bf9940621ee7 100644
--- a/drivers/power/domain/apple-pmgr.c
+++ b/drivers/power/domain/apple-pmgr.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2021 Mark Kettenis <kettenis@openbsd.org>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <dm.h>
 #include <dm/device-internal.h>
diff --git a/drivers/power/domain/bcm6328-power-domain.c b/drivers/power/domain/bcm6328-power-domain.c
index 80144dd97725..36b5a9337480 100644
--- a/drivers/power/domain/bcm6328-power-domain.c
+++ b/drivers/power/domain/bcm6328-power-domain.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2017 Álvaro Fernández Rojas <noltari@gmail.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <malloc.h>
 #include <power-domain-uclass.h>
diff --git a/drivers/power/domain/imx8-power-domain-legacy.c b/drivers/power/domain/imx8-power-domain-legacy.c
index c8ca2665752f..713a51d7807d 100644
--- a/drivers/power/domain/imx8-power-domain-legacy.c
+++ b/drivers/power/domain/imx8-power-domain-legacy.c
@@ -3,7 +3,6 @@
  * Copyright 2017 NXP
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/drivers/power/domain/imx8-power-domain.c b/drivers/power/domain/imx8-power-domain.c
index b45e468756bf..e8dcc057fee0 100644
--- a/drivers/power/domain/imx8-power-domain.c
+++ b/drivers/power/domain/imx8-power-domain.c
@@ -4,7 +4,6 @@
  */
 
 #define DEBUG
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/drivers/power/domain/imx8m-power-domain.c b/drivers/power/domain/imx8m-power-domain.c
index df5d7d695621..8b6870c86463 100644
--- a/drivers/power/domain/imx8m-power-domain.c
+++ b/drivers/power/domain/imx8m-power-domain.c
@@ -3,7 +3,6 @@
  * Copyright 2017 NXP
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <malloc.h>
diff --git a/drivers/power/domain/imx8mp-hsiomix.c b/drivers/power/domain/imx8mp-hsiomix.c
index 6188a04c45ed..455ad53ef525 100644
--- a/drivers/power/domain/imx8mp-hsiomix.c
+++ b/drivers/power/domain/imx8mp-hsiomix.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2022 Marek Vasut <marex@denx.de>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <clk.h>
 #include <clk-uclass.h>
diff --git a/drivers/power/domain/meson-ee-pwrc.c b/drivers/power/domain/meson-ee-pwrc.c
index 676fded8080a..20e9f32b3819 100644
--- a/drivers/power/domain/meson-ee-pwrc.c
+++ b/drivers/power/domain/meson-ee-pwrc.c
@@ -4,7 +4,6 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/drivers/power/domain/meson-gx-pwrc-vpu.c b/drivers/power/domain/meson-gx-pwrc-vpu.c
index 612660ce89f9..1c56e8508c32 100644
--- a/drivers/power/domain/meson-gx-pwrc-vpu.c
+++ b/drivers/power/domain/meson-gx-pwrc-vpu.c
@@ -6,7 +6,6 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/drivers/power/domain/mtk-power-domain.c b/drivers/power/domain/mtk-power-domain.c
index 3b84147d4814..2d1ba1855a5b 100644
--- a/drivers/power/domain/mtk-power-domain.c
+++ b/drivers/power/domain/mtk-power-domain.c
@@ -5,7 +5,6 @@
  */
 
 #include <clk.h>
-#include <common.h>
 #include <dm.h>
 #include <malloc.h>
 #include <power-domain-uclass.h>
diff --git a/drivers/power/domain/power-domain-uclass.c b/drivers/power/domain/power-domain-uclass.c
index f6286c70c1d7..938bd8cbc9ff 100644
--- a/drivers/power/domain/power-domain-uclass.c
+++ b/drivers/power/domain/power-domain-uclass.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_POWER_DOMAIN
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/drivers/power/domain/sandbox-power-domain-test.c b/drivers/power/domain/sandbox-power-domain-test.c
index 1bf52f1d861c..08c15ef342b3 100644
--- a/drivers/power/domain/sandbox-power-domain-test.c
+++ b/drivers/power/domain/sandbox-power-domain-test.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2016, NVIDIA CORPORATION.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <malloc.h>
 #include <power-domain.h>
diff --git a/drivers/power/domain/sandbox-power-domain.c b/drivers/power/domain/sandbox-power-domain.c
index 04a071044f3b..9dd490b14a3f 100644
--- a/drivers/power/domain/sandbox-power-domain.c
+++ b/drivers/power/domain/sandbox-power-domain.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2016, NVIDIA CORPORATION.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/drivers/power/domain/tegra186-power-domain.c b/drivers/power/domain/tegra186-power-domain.c
index 46da541b75a8..334c460c805f 100644
--- a/drivers/power/domain/tegra186-power-domain.c
+++ b/drivers/power/domain/tegra186-power-domain.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2016, NVIDIA CORPORATION.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/drivers/power/domain/ti-power-domain.c b/drivers/power/domain/ti-power-domain.c
index 8996c40ddc03..b059dd37376d 100644
--- a/drivers/power/domain/ti-power-domain.c
+++ b/drivers/power/domain/ti-power-domain.c
@@ -7,7 +7,6 @@
  */
 
 #include <asm/io.h>
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <power-domain-uclass.h>
diff --git a/drivers/power/domain/ti-sci-power-domain.c b/drivers/power/domain/ti-sci-power-domain.c
index 8d6abe13dbc6..0a9f498b97b1 100644
--- a/drivers/power/domain/ti-sci-power-domain.c
+++ b/drivers/power/domain/ti-sci-power-domain.c
@@ -8,7 +8,6 @@
  * Loosely based on Linux kernel ti_sci_pm_domains.c...
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/drivers/power/domain/zynqmp-power-domain.c b/drivers/power/domain/zynqmp-power-domain.c
index 5ee9e020fb3b..ac93934eb420 100644
--- a/drivers/power/domain/zynqmp-power-domain.c
+++ b/drivers/power/domain/zynqmp-power-domain.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2021, Xilinx. Inc.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <log.h>
diff --git a/drivers/power/exynos-tmu.c b/drivers/power/exynos-tmu.c
index 6d62f6cae40d..21c2fabce1b8 100644
--- a/drivers/power/exynos-tmu.c
+++ b/drivers/power/exynos-tmu.c
@@ -17,11 +17,12 @@
  * MA 02111-1307 USA
  */
 
-#include <common.h>
 #include <errno.h>
 #include <fdtdec.h>
 #include <log.h>
+#include <time.h>
 #include <tmu.h>
+#include <asm/io.h>
 #include <asm/arch/tmu.h>
 #include <asm/arch/power.h>
 
diff --git a/drivers/power/mt6323.c b/drivers/power/mt6323.c
index 354817a03780..dd6cbcf18206 100644
--- a/drivers/power/mt6323.c
+++ b/drivers/power/mt6323.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2019 Frank Wunderlich <frank-w@public-files.de>
  */
 
-#include <common.h>
 #include <command.h>
 #include <asm/io.h>
 #include <linux/delay.h>
diff --git a/drivers/power/pmic/ab8500.c b/drivers/power/pmic/ab8500.c
index 1f64f217c345..9ba096711e14 100644
--- a/drivers/power/pmic/ab8500.c
+++ b/drivers/power/pmic/ab8500.c
@@ -7,7 +7,6 @@
  * Copyright (C) ST-Ericsson SA 2010
  */
 
-#include <common.h>
 #include <dm.h>
 #include <regmap.h>
 #include <syscon.h>
diff --git a/drivers/power/pmic/act8846.c b/drivers/power/pmic/act8846.c
index 8f0f5a6d96e5..3058ef0f893d 100644
--- a/drivers/power/pmic/act8846.c
+++ b/drivers/power/pmic/act8846.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <fdtdec.h>
diff --git a/drivers/power/pmic/as3722.c b/drivers/power/pmic/as3722.c
index c7dd9705d189..9b0f4fb97363 100644
--- a/drivers/power/pmic/as3722.c
+++ b/drivers/power/pmic/as3722.c
@@ -5,7 +5,6 @@
 
 #define pr_fmt(fmt) "as3722: " fmt
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <fdtdec.h>
diff --git a/drivers/power/pmic/as3722_gpio.c b/drivers/power/pmic/as3722_gpio.c
index 987fbdf9bc08..52d8bd00b1fd 100644
--- a/drivers/power/pmic/as3722_gpio.c
+++ b/drivers/power/pmic/as3722_gpio.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2014 NVIDIA Corporation
  */
 
-#include <common.h>
 #include <dm.h>
 #include <asm/gpio.h>
 #include <linux/printk.h>
diff --git a/drivers/power/pmic/bd71837.c b/drivers/power/pmic/bd71837.c
index ee6ae78e5c4c..a5df2570fc3e 100644
--- a/drivers/power/pmic/bd71837.c
+++ b/drivers/power/pmic/bd71837.c
@@ -3,7 +3,6 @@
  * Copyright 2018 NXP
  */
 
-#include <common.h>
 #include <errno.h>
 #include <dm.h>
 #include <i2c.h>
diff --git a/drivers/power/pmic/da9063.c b/drivers/power/pmic/da9063.c
index ca95b82e6d01..7bd3df391421 100644
--- a/drivers/power/pmic/da9063.c
+++ b/drivers/power/pmic/da9063.c
@@ -4,7 +4,6 @@
  *  Martin Fuzzey  <martin.fuzzey@flowbird.group>
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <errno.h>
 #include <dm.h>
diff --git a/drivers/power/pmic/fan53555.c b/drivers/power/pmic/fan53555.c
index d556b9a5878a..95bf600cbc3f 100644
--- a/drivers/power/pmic/fan53555.c
+++ b/drivers/power/pmic/fan53555.c
@@ -3,7 +3,6 @@
  * (C) 2018 Theobroma Systems Design und Consulting GmbH
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <dm/device-internal.h>
diff --git a/drivers/power/pmic/i2c_pmic_emul.c b/drivers/power/pmic/i2c_pmic_emul.c
index f0a03742f87b..6e81b9c34279 100644
--- a/drivers/power/pmic/i2c_pmic_emul.c
+++ b/drivers/power/pmic/i2c_pmic_emul.c
@@ -4,7 +4,6 @@
  *  Przemyslaw Marczak  <p.marczak@samsung.com>
  */
 
-#include <common.h>
 #include <errno.h>
 #include <dm.h>
 #include <i2c.h>
diff --git a/drivers/power/pmic/lp873x.c b/drivers/power/pmic/lp873x.c
index fda5bc151642..2c8fa4ea312f 100644
--- a/drivers/power/pmic/lp873x.c
+++ b/drivers/power/pmic/lp873x.c
@@ -4,7 +4,6 @@
  * Keerthy <j-keerthy@ti.com>
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <errno.h>
 #include <dm.h>
diff --git a/drivers/power/pmic/lp87565.c b/drivers/power/pmic/lp87565.c
index 904e02c4d818..c2ff75bbcdcd 100644
--- a/drivers/power/pmic/lp87565.c
+++ b/drivers/power/pmic/lp87565.c
@@ -4,7 +4,6 @@
  * Keerthy <j-keerthy@ti.com>
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <errno.h>
 #include <dm.h>
diff --git a/drivers/power/pmic/max77686.c b/drivers/power/pmic/max77686.c
index 7e6f7d1966f1..bfe57b386d3d 100644
--- a/drivers/power/pmic/max77686.c
+++ b/drivers/power/pmic/max77686.c
@@ -4,7 +4,6 @@
  *  Przemyslaw Marczak  <p.marczak@samsung.com>
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <errno.h>
 #include <dm.h>
diff --git a/drivers/power/pmic/max8997.c b/drivers/power/pmic/max8997.c
index 504a63bf7431..4afa6c84ef82 100644
--- a/drivers/power/pmic/max8997.c
+++ b/drivers/power/pmic/max8997.c
@@ -4,7 +4,6 @@
  *  Jaehoon Chung <jh80.chung@samsung.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <i2c.h>
 #include <linux/printk.h>
diff --git a/drivers/power/pmic/max8998.c b/drivers/power/pmic/max8998.c
index d155474447f5..05669023753e 100644
--- a/drivers/power/pmic/max8998.c
+++ b/drivers/power/pmic/max8998.c
@@ -4,7 +4,6 @@
  *  Jaehoon Chung <jh80.chung@samsung.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <i2c.h>
diff --git a/drivers/power/pmic/mc34708.c b/drivers/power/pmic/mc34708.c
index 40d732224b6c..43badb5767a5 100644
--- a/drivers/power/pmic/mc34708.c
+++ b/drivers/power/pmic/mc34708.c
@@ -5,7 +5,6 @@
  *
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <fsl_pmic.h>
diff --git a/drivers/power/pmic/mp5416.c b/drivers/power/pmic/mp5416.c
index 6180adf77e2d..9d44f0ae655e 100644
--- a/drivers/power/pmic/mp5416.c
+++ b/drivers/power/pmic/mp5416.c
@@ -2,7 +2,6 @@
 /*
  * Copyright 2020 Gateworks Corporation
  */
-#include <common.h>
 #include <errno.h>
 #include <dm.h>
 #include <i2c.h>
diff --git a/drivers/power/pmic/palmas.c b/drivers/power/pmic/palmas.c
index e340a32279fb..f676bf641694 100644
--- a/drivers/power/pmic/palmas.c
+++ b/drivers/power/pmic/palmas.c
@@ -4,7 +4,6 @@
  * Keerthy <j-keerthy@ti.com>
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <errno.h>
 #include <dm.h>
diff --git a/drivers/power/pmic/pca9450.c b/drivers/power/pmic/pca9450.c
index 0bbe98cd8a29..07af6273d8ae 100644
--- a/drivers/power/pmic/pca9450.c
+++ b/drivers/power/pmic/pca9450.c
@@ -3,7 +3,6 @@
  * Copyright 2019 NXP
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <errno.h>
 #include <dm.h>
diff --git a/drivers/power/pmic/pfuze100.c b/drivers/power/pmic/pfuze100.c
index 15420acb4725..9e09805d251f 100644
--- a/drivers/power/pmic/pfuze100.c
+++ b/drivers/power/pmic/pfuze100.c
@@ -4,7 +4,6 @@
  * Peng Fan <Peng.Fan@freescale.com>
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <errno.h>
 #include <dm.h>
diff --git a/drivers/power/pmic/pmic-uclass.c b/drivers/power/pmic/pmic-uclass.c
index 0e2f5e1f4111..bb459816d143 100644
--- a/drivers/power/pmic/pmic-uclass.c
+++ b/drivers/power/pmic/pmic-uclass.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_PMIC
 
-#include <common.h>
 #include <fdtdec.h>
 #include <errno.h>
 #include <dm.h>
diff --git a/drivers/power/pmic/pmic_hi6553.c b/drivers/power/pmic/pmic_hi6553.c
index 80b9078cf8f0..05305013882d 100644
--- a/drivers/power/pmic/pmic_hi6553.c
+++ b/drivers/power/pmic/pmic_hi6553.c
@@ -4,7 +4,6 @@
  *  Peter Griffin <peter.griffin@linaro.org>
  */
 #include <asm/io.h>
-#include <common.h>
 #include <linux/delay.h>
 #include <power/pmic.h>
 #include <power/max8997_muic.h>
diff --git a/drivers/power/pmic/pmic_ltc3676.c b/drivers/power/pmic/pmic_ltc3676.c
index af94f37b0f10..145a631b6b24 100644
--- a/drivers/power/pmic/pmic_ltc3676.c
+++ b/drivers/power/pmic/pmic_ltc3676.c
@@ -4,7 +4,6 @@
  * Tim Harvey <tharvey@gateworks.com>
  */
 
-#include <common.h>
 #include <errno.h>
 #include <i2c.h>
 #include <power/pmic.h>
diff --git a/drivers/power/pmic/pmic_mc34vr500.c b/drivers/power/pmic/pmic_mc34vr500.c
index 9dd1c46ea220..0dfdfbdf3dca 100644
--- a/drivers/power/pmic/pmic_mc34vr500.c
+++ b/drivers/power/pmic/pmic_mc34vr500.c
@@ -4,7 +4,6 @@
  * Hou Zhiqiang <Zhiqiang.Hou@freescale.com>
  */
 
-#include <common.h>
 #include <errno.h>
 #include <i2c.h>
 #include <power/pmic.h>
diff --git a/drivers/power/pmic/pmic_pca9450.c b/drivers/power/pmic/pmic_pca9450.c
index 8c4d0a92306b..12500ba99901 100644
--- a/drivers/power/pmic/pmic_pca9450.c
+++ b/drivers/power/pmic/pmic_pca9450.c
@@ -3,7 +3,6 @@
  * Copyright 2019 NXP
  */
 
-#include <common.h>
 #include <errno.h>
 #include <i2c.h>
 #include <power/pmic.h>
diff --git a/drivers/power/pmic/pmic_pfuze100.c b/drivers/power/pmic/pmic_pfuze100.c
index 5115b55e49dc..a266709d8d07 100644
--- a/drivers/power/pmic/pmic_pfuze100.c
+++ b/drivers/power/pmic/pmic_pfuze100.c
@@ -4,7 +4,6 @@
  * Tim Harvey <tharvey@gateworks.com>
  */
 
-#include <common.h>
 #include <errno.h>
 #include <i2c.h>
 #include <power/pmic.h>
diff --git a/drivers/power/pmic/pmic_pfuze3000.c b/drivers/power/pmic/pmic_pfuze3000.c
index a6d97252bc9e..602c4744aa6c 100644
--- a/drivers/power/pmic/pmic_pfuze3000.c
+++ b/drivers/power/pmic/pmic_pfuze3000.c
@@ -4,7 +4,6 @@
  * Peng Fan <Peng.Fan@freescale.com>
  */
 
-#include <common.h>
 #include <errno.h>
 #include <i2c.h>
 #include <power/pmic.h>
diff --git a/drivers/power/pmic/pmic_qcom.c b/drivers/power/pmic/pmic_qcom.c
index f2ac6494811d..92d0a95859b0 100644
--- a/drivers/power/pmic/pmic_qcom.c
+++ b/drivers/power/pmic/pmic_qcom.c
@@ -4,7 +4,6 @@
  *
  * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
  */
-#include <common.h>
 #include <dm.h>
 #include <power/pmic.h>
 #include <spmi/spmi.h>
diff --git a/drivers/power/pmic/pmic_tps62362.c b/drivers/power/pmic/pmic_tps62362.c
index 6426d1488a5c..4f0e406d5606 100644
--- a/drivers/power/pmic/pmic_tps62362.c
+++ b/drivers/power/pmic/pmic_tps62362.c
@@ -4,7 +4,6 @@
  * Author: Felipe Balbi <balbi@ti.com>
  */
 
-#include <common.h>
 #include <i2c.h>
 #include <linux/errno.h>
 #include <power/pmic.h>
diff --git a/drivers/power/pmic/pmic_tps65217.c b/drivers/power/pmic/pmic_tps65217.c
index ccbf2235933d..bd44e0d9ae05 100644
--- a/drivers/power/pmic/pmic_tps65217.c
+++ b/drivers/power/pmic/pmic_tps65217.c
@@ -4,7 +4,6 @@
  * Texas Instruments, <www.ti.com>
  */
 
-#include <common.h>
 #include <i2c.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/drivers/power/pmic/pmic_tps65218.c b/drivers/power/pmic/pmic_tps65218.c
index 671749018041..49d07e95cd7c 100644
--- a/drivers/power/pmic/pmic_tps65218.c
+++ b/drivers/power/pmic/pmic_tps65218.c
@@ -4,7 +4,6 @@
  * Texas Instruments, <www.ti.com>
  */
 
-#include <common.h>
 #include <i2c.h>
 #include <linux/errno.h>
 #include <power/pmic.h>
diff --git a/drivers/power/pmic/pmic_tps65910.c b/drivers/power/pmic/pmic_tps65910.c
index e3de73082150..df9bb66a7f9c 100644
--- a/drivers/power/pmic/pmic_tps65910.c
+++ b/drivers/power/pmic/pmic_tps65910.c
@@ -4,7 +4,6 @@
  * Texas Instruments, <www.ti.com>
  */
 
-#include <common.h>
 #include <i2c.h>
 #include <power/tps65910.h>
 
diff --git a/drivers/power/pmic/pmic_tps65910_dm.c b/drivers/power/pmic/pmic_tps65910_dm.c
index ecf836eb0e65..de8d805566aa 100644
--- a/drivers/power/pmic/pmic_tps65910_dm.c
+++ b/drivers/power/pmic/pmic_tps65910_dm.c
@@ -3,7 +3,6 @@
  * Copyright (C) EETS GmbH, 2017, Felix Brack <f.brack@eets.ch>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/lists.h>
 #include <i2c.h>
diff --git a/drivers/power/pmic/rk8xx.c b/drivers/power/pmic/rk8xx.c
index 3a8261d1749f..12ff26a08558 100644
--- a/drivers/power/pmic/rk8xx.c
+++ b/drivers/power/pmic/rk8xx.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/lists.h>
 #include <errno.h>
diff --git a/drivers/power/pmic/rn5t567.c b/drivers/power/pmic/rn5t567.c
index 9d103dd84057..0124d84a7295 100644
--- a/drivers/power/pmic/rn5t567.c
+++ b/drivers/power/pmic/rn5t567.c
@@ -4,7 +4,6 @@
  * Stefan Agner <stefan.agner@toradex.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <fdtdec.h>
diff --git a/drivers/power/pmic/s2mps11.c b/drivers/power/pmic/s2mps11.c
index 5ff4f2052113..17780017035b 100644
--- a/drivers/power/pmic/s2mps11.c
+++ b/drivers/power/pmic/s2mps11.c
@@ -4,7 +4,6 @@
  *  Przemyslaw Marczak  <p.marczak@samsung.com>
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <errno.h>
 #include <dm.h>
diff --git a/drivers/power/pmic/s5m8767.c b/drivers/power/pmic/s5m8767.c
index eea072ae824f..799d00125409 100644
--- a/drivers/power/pmic/s5m8767.c
+++ b/drivers/power/pmic/s5m8767.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015 Google, Inc
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <errno.h>
 #include <dm.h>
diff --git a/drivers/power/pmic/sandbox.c b/drivers/power/pmic/sandbox.c
index 14b82455f5fb..ddc11d6df86f 100644
--- a/drivers/power/pmic/sandbox.c
+++ b/drivers/power/pmic/sandbox.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY	UCLASS_PMIC
 
-#include <common.h>
 #include <fdtdec.h>
 #include <errno.h>
 #include <dm.h>
diff --git a/drivers/power/pmic/stpmic1.c b/drivers/power/pmic/stpmic1.c
index 8701d4f971c9..c99a0c27b336 100644
--- a/drivers/power/pmic/stpmic1.c
+++ b/drivers/power/pmic/stpmic1.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018, STMicroelectronics - All Rights Reserved
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <i2c.h>
diff --git a/drivers/power/pmic/tps65090.c b/drivers/power/pmic/tps65090.c
index 2a04d5948a5e..ad2ab34719e5 100644
--- a/drivers/power/pmic/tps65090.c
+++ b/drivers/power/pmic/tps65090.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <fdtdec.h>
diff --git a/drivers/power/pmic/tps65219.c b/drivers/power/pmic/tps65219.c
index 9462afee77fd..0716af027a3a 100644
--- a/drivers/power/pmic/tps65219.c
+++ b/drivers/power/pmic/tps65219.c
@@ -4,7 +4,6 @@
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <errno.h>
 #include <dm.h>
diff --git a/drivers/power/pmic/tps65941.c b/drivers/power/pmic/tps65941.c
index 943d845086c3..c3490db2a089 100644
--- a/drivers/power/pmic/tps65941.c
+++ b/drivers/power/pmic/tps65941.c
@@ -4,7 +4,6 @@
  * Keerthy <j-keerthy@ti.com>
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <errno.h>
 #include <dm.h>
diff --git a/drivers/power/power_core.c b/drivers/power/power_core.c
index 4f7ba099cd91..1caf9f093468 100644
--- a/drivers/power/power_core.c
+++ b/drivers/power/power_core.c
@@ -9,7 +9,6 @@
  * (C) Copyright 2008-2009 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
 #include <command.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/drivers/power/power_dialog.c b/drivers/power/power_dialog.c
index ad7aaf35a9a0..a5c7ea34c4ae 100644
--- a/drivers/power/power_dialog.c
+++ b/drivers/power/power_dialog.c
@@ -4,7 +4,7 @@
  *  Lukasz Majewski <l.majewski@samsung.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <log.h>
 #include <power/pmic.h>
 #include <dialog_pmic.h>
diff --git a/drivers/power/power_fsl.c b/drivers/power/power_fsl.c
index 9dc930fb305a..a10a14a79616 100644
--- a/drivers/power/power_fsl.c
+++ b/drivers/power/power_fsl.c
@@ -4,7 +4,7 @@
  *  Lukasz Majewski <l.majewski@samsung.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <spi.h>
 #include <power/pmic.h>
 #include <fsl_pmic.h>
diff --git a/drivers/power/power_i2c.c b/drivers/power/power_i2c.c
index b67ac2f027b5..a871fc419872 100644
--- a/drivers/power/power_i2c.c
+++ b/drivers/power/power_i2c.c
@@ -10,7 +10,6 @@
  * (C) Copyright 2019 NXP
  */
 
-#include <common.h>
 #include <log.h>
 #include <linux/types.h>
 #include <power/pmic.h>
diff --git a/drivers/power/power_spi.c b/drivers/power/power_spi.c
index 1eaf9773ef8b..54427316ce42 100644
--- a/drivers/power/power_spi.c
+++ b/drivers/power/power_spi.c
@@ -9,7 +9,6 @@
  * (C) Copyright 2008-2009 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
 #include <linux/types.h>
 #include <power/pmic.h>
 #include <spi.h>
diff --git a/drivers/power/regulator/act8846.c b/drivers/power/regulator/act8846.c
index bdce97365dd0..d3e72da0d35a 100644
--- a/drivers/power/regulator/act8846.c
+++ b/drivers/power/regulator/act8846.c
@@ -8,7 +8,6 @@
  * zyw <zyw@rock-chips.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <power/act8846_pmic.h>
diff --git a/drivers/power/regulator/anatop_regulator.c b/drivers/power/regulator/anatop_regulator.c
index 096a1565d5a7..824a753db161 100644
--- a/drivers/power/regulator/anatop_regulator.c
+++ b/drivers/power/regulator/anatop_regulator.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2021 Linaro
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/drivers/power/regulator/as3722_regulator.c b/drivers/power/regulator/as3722_regulator.c
index ec0776b440bb..8d60965fe9ac 100644
--- a/drivers/power/regulator/as3722_regulator.c
+++ b/drivers/power/regulator/as3722_regulator.c
@@ -6,7 +6,6 @@
  * Placeholder regulator driver for as3722.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/drivers/power/regulator/bd71837.c b/drivers/power/regulator/bd71837.c
index 913ed88d45f7..59aec1a7313e 100644
--- a/drivers/power/regulator/bd71837.c
+++ b/drivers/power/regulator/bd71837.c
@@ -5,7 +5,6 @@
  * ROHM BD71837 regulator driver
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <linux/bitops.h>
diff --git a/drivers/power/regulator/da9063.c b/drivers/power/regulator/da9063.c
index 8df1abcf7885..5d566b06a522 100644
--- a/drivers/power/regulator/da9063.c
+++ b/drivers/power/regulator/da9063.c
@@ -4,7 +4,6 @@
  *  Martin Fuzzey  <martin.fuzzey@flowbird.group>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <linux/bitops.h>
 #include <power/da9063_pmic.h>
diff --git a/drivers/power/regulator/fan53555.c b/drivers/power/regulator/fan53555.c
index fa8d88f2e0dc..5cba58f91cac 100644
--- a/drivers/power/regulator/fan53555.c
+++ b/drivers/power/regulator/fan53555.c
@@ -3,7 +3,6 @@
  * (C) 2018 Theobroma Systems Design und Consulting GmbH
  */
 
-#include <common.h>
 #include <bitfield.h>
 #include <errno.h>
 #include <dm.h>
diff --git a/drivers/power/regulator/fixed.c b/drivers/power/regulator/fixed.c
index 590c288d6575..98c89bf2aff6 100644
--- a/drivers/power/regulator/fixed.c
+++ b/drivers/power/regulator/fixed.c
@@ -5,7 +5,6 @@
  *  Przemyslaw Marczak <p.marczak@samsung.com>
  */
 
-#include <common.h>
 #include <clk.h>
 #include <errno.h>
 #include <dm.h>
diff --git a/drivers/power/regulator/gpio-regulator.c b/drivers/power/regulator/gpio-regulator.c
index 74137b7b876f..38b22535c3dd 100644
--- a/drivers/power/regulator/gpio-regulator.c
+++ b/drivers/power/regulator/gpio-regulator.c
@@ -4,7 +4,6 @@
  * Keerthy <j-keerthy@ti.com>
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <errno.h>
 #include <dm.h>
diff --git a/drivers/power/regulator/lp873x_regulator.c b/drivers/power/regulator/lp873x_regulator.c
index c326f8efa471..c59d77118ada 100644
--- a/drivers/power/regulator/lp873x_regulator.c
+++ b/drivers/power/regulator/lp873x_regulator.c
@@ -6,7 +6,6 @@
  * Keerthy <j-keerthy@ti.com>
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <errno.h>
 #include <dm.h>
diff --git a/drivers/power/regulator/lp87565_regulator.c b/drivers/power/regulator/lp87565_regulator.c
index 6bbc831d2c8a..d622d9568156 100644
--- a/drivers/power/regulator/lp87565_regulator.c
+++ b/drivers/power/regulator/lp87565_regulator.c
@@ -6,7 +6,6 @@
  * Keerthy <j-keerthy@ti.com>
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <errno.h>
 #include <dm.h>
diff --git a/drivers/power/regulator/max77686.c b/drivers/power/regulator/max77686.c
index 3a2080399340..4e0ba12a0ef8 100644
--- a/drivers/power/regulator/max77686.c
+++ b/drivers/power/regulator/max77686.c
@@ -6,7 +6,6 @@
  *  Przemyslaw Marczak <p.marczak@samsung.com>
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <errno.h>
 #include <dm.h>
diff --git a/drivers/power/regulator/npcm8xx_regulator.c b/drivers/power/regulator/npcm8xx_regulator.c
index fcd1058cdf52..30d1b8945cb7 100644
--- a/drivers/power/regulator/npcm8xx_regulator.c
+++ b/drivers/power/regulator/npcm8xx_regulator.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2022 Nuvoton Technology Corp.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <asm/io.h>
 #include <dm/device_compat.h>
diff --git a/drivers/power/regulator/palmas_regulator.c b/drivers/power/regulator/palmas_regulator.c
index d615e9473403..2286eac93fbe 100644
--- a/drivers/power/regulator/palmas_regulator.c
+++ b/drivers/power/regulator/palmas_regulator.c
@@ -6,7 +6,6 @@
  * Keerthy <j-keerthy@ti.com>
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <errno.h>
 #include <dm.h>
diff --git a/drivers/power/regulator/pbias_regulator.c b/drivers/power/regulator/pbias_regulator.c
index cf4e2858443d..8f599cab6899 100644
--- a/drivers/power/regulator/pbias_regulator.c
+++ b/drivers/power/regulator/pbias_regulator.c
@@ -4,7 +4,6 @@
  * Jean-Jacques Hiblot <jjhiblot@ti.com>
  */
 
-#include <common.h>
 #include <errno.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/power/regulator/pca9450.c b/drivers/power/regulator/pca9450.c
index 7ca20d1f7f87..9faf1eab5f90 100644
--- a/drivers/power/regulator/pca9450.c
+++ b/drivers/power/regulator/pca9450.c
@@ -7,7 +7,6 @@
  * ROHM BD71837 regulator driver
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <linux/bitops.h>
diff --git a/drivers/power/regulator/pfuze100.c b/drivers/power/regulator/pfuze100.c
index 1d926689b3b0..bf3a7019411e 100644
--- a/drivers/power/regulator/pfuze100.c
+++ b/drivers/power/regulator/pfuze100.c
@@ -5,7 +5,6 @@
  * Peng Fan <peng.fan@nxp.com>
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <errno.h>
 #include <dm.h>
diff --git a/drivers/power/regulator/pwm_regulator.c b/drivers/power/regulator/pwm_regulator.c
index ca59f3ae3e18..ff738faadc52 100644
--- a/drivers/power/regulator/pwm_regulator.c
+++ b/drivers/power/regulator/pwm_regulator.c
@@ -7,7 +7,6 @@
  * Author: Lee Jones <lee.jones@linaro.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
index 77d101f262e2..66fd531da043 100644
--- a/drivers/power/regulator/regulator-uclass.c
+++ b/drivers/power/regulator/regulator-uclass.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_REGULATOR
 
-#include <common.h>
 #include <errno.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
index 0116fa01bbfe..e3565d32a019 100644
--- a/drivers/power/regulator/regulator_common.c
+++ b/drivers/power/regulator/regulator_common.c
@@ -4,7 +4,6 @@
  * Sven Schwermer <sven.svenschwermer@disruptive-technologies.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <asm/gpio.h>
diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
index 1bd4605d43a0..bf3af7815279 100644
--- a/drivers/power/regulator/rk8xx.c
+++ b/drivers/power/regulator/rk8xx.c
@@ -8,7 +8,6 @@
  * zyw <zyw@rock-chips.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/drivers/power/regulator/s2mps11_regulator.c b/drivers/power/regulator/s2mps11_regulator.c
index 987a1f9d8638..96de55065feb 100644
--- a/drivers/power/regulator/s2mps11_regulator.c
+++ b/drivers/power/regulator/s2mps11_regulator.c
@@ -4,7 +4,6 @@
  *  Jaehoon Chung <jh80.chung@samsung.com>
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <errno.h>
 #include <dm.h>
diff --git a/drivers/power/regulator/s5m8767.c b/drivers/power/regulator/s5m8767.c
index 23575831f382..0dcf0990802b 100644
--- a/drivers/power/regulator/s5m8767.c
+++ b/drivers/power/regulator/s5m8767.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2015 Google, Inc
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <errno.h>
 #include <dm.h>
diff --git a/drivers/power/regulator/sandbox.c b/drivers/power/regulator/sandbox.c
index 71ef0c5441af..80a68f5a30d5 100644
--- a/drivers/power/regulator/sandbox.c
+++ b/drivers/power/regulator/sandbox.c
@@ -4,7 +4,6 @@
  *  Przemyslaw Marczak  <p.marczak@samsung.com>
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <errno.h>
 #include <dm.h>
diff --git a/drivers/power/regulator/scmi_regulator.c b/drivers/power/regulator/scmi_regulator.c
index 9c72c35d039e..99f6506f1628 100644
--- a/drivers/power/regulator/scmi_regulator.c
+++ b/drivers/power/regulator/scmi_regulator.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_REGULATOR
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <scmi_agent.h>
diff --git a/drivers/power/regulator/stm32-vrefbuf.c b/drivers/power/regulator/stm32-vrefbuf.c
index c37998a4bac4..dd8a33f15bea 100644
--- a/drivers/power/regulator/stm32-vrefbuf.c
+++ b/drivers/power/regulator/stm32-vrefbuf.c
@@ -8,7 +8,6 @@
 
 #define LOG_CATEGORY UCLASS_REGULATOR
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <asm/io.h>
diff --git a/drivers/power/regulator/stpmic1.c b/drivers/power/regulator/stpmic1.c
index 4839d834316a..b5ffa1cd5895 100644
--- a/drivers/power/regulator/stpmic1.c
+++ b/drivers/power/regulator/stpmic1.c
@@ -4,7 +4,6 @@
  * Author: Christophe Kerello <christophe.kerello@st.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <linux/delay.h>
diff --git a/drivers/power/regulator/tps62360_regulator.c b/drivers/power/regulator/tps62360_regulator.c
index 7014b1982d00..9acc6b905497 100644
--- a/drivers/power/regulator/tps62360_regulator.c
+++ b/drivers/power/regulator/tps62360_regulator.c
@@ -4,7 +4,6 @@
  *      Tero Kristo <t-kristo@ti.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <i2c.h>
 #include <dm/device_compat.h>
diff --git a/drivers/power/regulator/tps65090_regulator.c b/drivers/power/regulator/tps65090_regulator.c
index fa15e61a10e0..2d414de14907 100644
--- a/drivers/power/regulator/tps65090_regulator.c
+++ b/drivers/power/regulator/tps65090_regulator.c
@@ -3,10 +3,10 @@
  * Copyright (c) 2015 Google, Inc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
+#include <time.h>
 #include <linux/delay.h>
 #include <power/pmic.h>
 #include <power/regulator.h>
diff --git a/drivers/power/regulator/tps65219_regulator.c b/drivers/power/regulator/tps65219_regulator.c
index f87d07e61fbf..b7124fed0245 100644
--- a/drivers/power/regulator/tps65219_regulator.c
+++ b/drivers/power/regulator/tps65219_regulator.c
@@ -5,7 +5,6 @@
  *
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <errno.h>
 #include <dm.h>
diff --git a/drivers/power/regulator/tps65910_regulator.c b/drivers/power/regulator/tps65910_regulator.c
index a4b9d449274b..562fd7db1908 100644
--- a/drivers/power/regulator/tps65910_regulator.c
+++ b/drivers/power/regulator/tps65910_regulator.c
@@ -3,7 +3,6 @@
  * Copyright (C) EETS GmbH, 2017, Felix Brack <f.brack@eets.ch>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <linux/printk.h>
diff --git a/drivers/power/regulator/tps65941_regulator.c b/drivers/power/regulator/tps65941_regulator.c
index 5809a53fa214..bc4d153fd844 100644
--- a/drivers/power/regulator/tps65941_regulator.c
+++ b/drivers/power/regulator/tps65941_regulator.c
@@ -6,7 +6,6 @@
  * Keerthy <j-keerthy@ti.com>
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <errno.h>
 #include <dm.h>
diff --git a/drivers/power/sy8106a.c b/drivers/power/sy8106a.c
index 45f47939869a..fb6028de71af 100644
--- a/drivers/power/sy8106a.c
+++ b/drivers/power/sy8106a.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2016
  * Jelle van der Waa <jelle@vdwaa.nl>
  */
-#include <common.h>
 #include <i2c.h>
 #include <sy8106a.h>
 
diff --git a/drivers/power/tps6586x.c b/drivers/power/tps6586x.c
index 37f1c459a637..4034a9b49dd0 100644
--- a/drivers/power/tps6586x.c
+++ b/drivers/power/tps6586x.c
@@ -4,12 +4,12 @@
  * (C) Copyright 2010,2011 NVIDIA Corporation <www.nvidia.com>
  */
 
-#include <common.h>
 #include <log.h>
 #include <tps6586x.h>
 #include <asm/io.h>
 #include <i2c.h>
 #include <linux/delay.h>
+#include <linux/errno.h>
 
 static struct udevice *tps6586x_dev;
 
-- 
2.34.1

