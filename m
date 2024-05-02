Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198D4C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:44:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 158F788D39;
	Thu,  2 May 2024 03:34:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bZq/VRjn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C447F88C64; Thu,  2 May 2024 03:33:15 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE68C88CA0
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:33:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-61816fc256dso75800937b3.0
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613588; x=1715218388; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h1GA7PTyB1gH3CDYkPVrcouzQF1n1+B00F9/v0ZUje8=;
 b=bZq/VRjnCu8AORuSG/AACsDMySPezrHM9Ng5biEBhcVtM47rNF6iXRmnIRdm8aEPZA
 4BrgC2Mc1bqxtmL3+m5zrlqbt4S3wUZMwgHrpbHyaAJ/zt7arxSWz/khviwhWCmcstMi
 EQd6Ezwn0X4gd9WF1y46NiD6AE4vN2ZJe93BQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613588; x=1715218388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h1GA7PTyB1gH3CDYkPVrcouzQF1n1+B00F9/v0ZUje8=;
 b=S4RwntjC8jWGPZNvYMFiovS8HnXVGoBrx9M55A5Pl82PY+0zP4WiMqVYjMS4CbOHsI
 gjTdmEI22SGaoWuPreR87IhxrhCDjfhEjnarXVWCqtXmsgUeLTJavh6osmDth7J15mlA
 Inbw2FuEOZM3bthZwwLYDDm68HwHdXp7YYQih6qDCsztwNc9F58tk2cbuuoqoI3Ushbp
 b4wRv4We5e7FYb9RGNTxEOGc8RHZ92yB6bEdDJ+xm5DOwS++xo1v4dxe60tmAoIn26hn
 jDLXBOXTvgHPTf6+7WI+fXEpslQ6jYVnxiYnSaaynuelFdZyrI08bxLTJQCYH+5r+xm3
 uSEw==
X-Gm-Message-State: AOJu0YwNbTZoXHYiEnKyr5sIJ9chUmGNE+O5GQbL/3/xp1ctBTXlvKAn
 i5ybBEj7VIuzY/zHEmqAyasLhjQ63yOb2lqOTz7TJ3kuCjuXzn7ozSTalcBFtChMoY/bcrjP1tI
 ZnTTMvdrf
X-Google-Smtp-Source: AGHT+IFQZ98mQdwyGuUz5HleF5wWt0iFiFFU38EY6hLsqn+HDWZNxiY5jBIIFe6mzkrk5g+pu+cGTg==
X-Received: by 2002:a05:690c:b82:b0:61b:91e3:f954 with SMTP id
 ck2-20020a05690c0b8200b0061b91e3f954mr4905633ywb.8.1714613588511; 
 Wed, 01 May 2024 18:33:08 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:33:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>, Mark Kettenis <kettenis@openbsd.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 liuhao <liuhao@phytium.com.cn>, shuyiqi <shuyiqi@phytium.com.cn>,
 Minda Chen <minda.chen@starfivetech.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Dai Okamura <okamura.dai@socionext.com>,
 Michal Simek <michal.simek@amd.com>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Moritz Fischer <moritzf@google.com>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Sergei Antonov <saproj@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Sam Edwards <cfsworks@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Johan Jonker <jbx6244@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jon Lin <jon.lin@rock-chips.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Maksim Kiselev <bigunclemax@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Mathew McBride <matt@traverse.com.au>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Mason Huo <mason.huo@starfivetech.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: [PATCH 48/81] pci: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:31:05 -0600
Message-Id: <20240502013138.2383421-48-trini@konsulko.com>
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
Cc: Stefan Roese <sr@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Heiko Schocher <hs@denx.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Mark Kettenis <kettenis@openbsd.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: liuhao <liuhao@phytium.com.cn>
Cc: shuyiqi <shuyiqi@phytium.com.cn>
Cc: Minda Chen <minda.chen@starfivetech.com>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Dai Okamura <okamura.dai@socionext.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Moritz Fischer <moritzf@google.com>
Cc: This contributor prefers not to receive mails <noreply@example.com>
Cc: Sergei Antonov <saproj@gmail.com>
Cc: Nikhil M Jain <n-jain1@ti.com>
Cc: Sam Edwards <cfsworks@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Jon Lin <jon.lin@rock-chips.com>
Cc: Eugen Hristev <eugen.hristev@collabora.com>
Cc: Maksim Kiselev <bigunclemax@gmail.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Mathew McBride <matt@traverse.com.au>
Cc: Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: Mason Huo <mason.huo@starfivetech.com>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 drivers/pci/pci-aardvark.c                 | 1 -
 drivers/pci/pci-emul-uclass.c              | 1 -
 drivers/pci/pci-rcar-gen2.c                | 2 +-
 drivers/pci/pci-rcar-gen3.c                | 1 -
 drivers/pci/pci-uclass.c                   | 1 -
 drivers/pci/pci_auto.c                     | 2 +-
 drivers/pci/pci_auto_common.c              | 1 -
 drivers/pci/pci_common.c                   | 1 -
 drivers/pci/pci_compat.c                   | 1 -
 drivers/pci/pci_ftpci100.c                 | 1 -
 drivers/pci/pci_mpc85xx.c                  | 1 -
 drivers/pci/pci_mvebu.c                    | 1 -
 drivers/pci/pci_rom.c                      | 2 +-
 drivers/pci/pci_sandbox.c                  | 1 -
 drivers/pci/pci_sh7751.c                   | 2 +-
 drivers/pci/pci_tegra.c                    | 1 -
 drivers/pci/pci_x86.c                      | 1 -
 drivers/pci/pcie_apple.c                   | 1 -
 drivers/pci/pcie_brcmstb.c                 | 1 -
 drivers/pci/pcie_dw_common.c               | 1 -
 drivers/pci/pcie_dw_meson.c                | 1 -
 drivers/pci/pcie_dw_mvebu.c                | 3 ++-
 drivers/pci/pcie_dw_rockchip.c             | 1 -
 drivers/pci/pcie_dw_sifive.c               | 1 -
 drivers/pci/pcie_dw_ti.c                   | 1 -
 drivers/pci/pcie_ecam_generic.c            | 1 -
 drivers/pci/pcie_ecam_synquacer.c          | 1 -
 drivers/pci/pcie_fsl.c                     | 2 +-
 drivers/pci/pcie_fsl_fixup.c               | 1 -
 drivers/pci/pcie_imx.c                     | 1 -
 drivers/pci/pcie_intel_fpga.c              | 1 -
 drivers/pci/pcie_iproc.c                   | 1 -
 drivers/pci/pcie_layerscape.c              | 1 -
 drivers/pci/pcie_layerscape_ep.c           | 2 +-
 drivers/pci/pcie_layerscape_fixup.c        | 1 -
 drivers/pci/pcie_layerscape_fixup_common.c | 2 +-
 drivers/pci/pcie_layerscape_gen4.c         | 2 +-
 drivers/pci/pcie_layerscape_gen4_fixup.c   | 1 -
 drivers/pci/pcie_layerscape_rc.c           | 1 -
 drivers/pci/pcie_mediatek.c                | 1 -
 drivers/pci/pcie_phytium.c                 | 1 -
 drivers/pci/pcie_plda_common.c             | 1 -
 drivers/pci/pcie_rockchip.c                | 1 -
 drivers/pci/pcie_starfive_jh7110.c         | 1 -
 drivers/pci/pcie_uniphier.c                | 1 -
 drivers/pci/pcie_xilinx.c                  | 1 -
 46 files changed, 10 insertions(+), 46 deletions(-)

diff --git a/drivers/pci/pci-aardvark.c b/drivers/pci/pci-aardvark.c
index af0e55cd2f2c..f5db4bdb7605 100644
--- a/drivers/pci/pci-aardvark.c
+++ b/drivers/pci/pci-aardvark.c
@@ -25,7 +25,6 @@
  *
  */
 
-#include <common.h>
 #include <dm.h>
 #include <pci.h>
 #include <asm/io.h>
diff --git a/drivers/pci/pci-emul-uclass.c b/drivers/pci/pci-emul-uclass.c
index a0b8afb87a01..166ee9fcd431 100644
--- a/drivers/pci/pci-emul-uclass.c
+++ b/drivers/pci/pci-emul-uclass.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <fdtdec.h>
 #include <log.h>
diff --git a/drivers/pci/pci-rcar-gen2.c b/drivers/pci/pci-rcar-gen2.c
index b81eb3536896..12c31e74087f 100644
--- a/drivers/pci/pci-rcar-gen2.c
+++ b/drivers/pci/pci-rcar-gen2.c
@@ -5,7 +5,7 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/io.h>
 #include <clk.h>
 #include <dm.h>
diff --git a/drivers/pci/pci-rcar-gen3.c b/drivers/pci/pci-rcar-gen3.c
index 1252ef74c581..76878246f1e0 100644
--- a/drivers/pci/pci-rcar-gen3.c
+++ b/drivers/pci/pci-rcar-gen3.c
@@ -15,7 +15,6 @@
  * Author: Phil Edworthy <phil.edworthy@renesas.com>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <clk.h>
 #include <dm.h>
diff --git a/drivers/pci/pci-uclass.c b/drivers/pci/pci-uclass.c
index 1a48256de036..6571e653049d 100644
--- a/drivers/pci/pci-uclass.c
+++ b/drivers/pci/pci-uclass.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_PCI
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <init.h>
diff --git a/drivers/pci/pci_auto.c b/drivers/pci/pci_auto.c
index 01230360bad2..90f818864457 100644
--- a/drivers/pci/pci_auto.c
+++ b/drivers/pci/pci_auto.c
@@ -8,7 +8,7 @@
  * Copyright (c) 2021  Maciej W. Rozycki <macro@orcam.me.uk>
  */
 
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/drivers/pci/pci_auto_common.c b/drivers/pci/pci_auto_common.c
index 2f4aff01049a..cfa818ed8218 100644
--- a/drivers/pci/pci_auto_common.c
+++ b/drivers/pci/pci_auto_common.c
@@ -11,7 +11,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/drivers/pci/pci_common.c b/drivers/pci/pci_common.c
index a18251297fd0..a57cf11cc537 100644
--- a/drivers/pci/pci_common.c
+++ b/drivers/pci/pci_common.c
@@ -9,7 +9,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <env.h>
 #include <errno.h>
diff --git a/drivers/pci/pci_compat.c b/drivers/pci/pci_compat.c
index 9dddca8efe07..8233925e525e 100644
--- a/drivers/pci/pci_compat.c
+++ b/drivers/pci/pci_compat.c
@@ -4,7 +4,6 @@
  *
  * Copyright (C) 2014 Google, Inc
  */
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
diff --git a/drivers/pci/pci_ftpci100.c b/drivers/pci/pci_ftpci100.c
index a1775445005a..43275b3d6a22 100644
--- a/drivers/pci/pci_ftpci100.c
+++ b/drivers/pci/pci_ftpci100.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-#include <common.h>
 #include <pci.h>
 #include <dm.h>
 #include <asm/io.h>
diff --git a/drivers/pci/pci_mpc85xx.c b/drivers/pci/pci_mpc85xx.c
index 249cfe66466b..c07feba79768 100644
--- a/drivers/pci/pci_mpc85xx.c
+++ b/drivers/pci/pci_mpc85xx.c
@@ -4,7 +4,6 @@
  * Heiko Schocher, DENX Software Engineering, hs@denx.de.
  *
  */
-#include <common.h>
 #include <asm/bitops.h>
 #include <pci.h>
 #include <dm.h>
diff --git a/drivers/pci/pci_mvebu.c b/drivers/pci/pci_mvebu.c
index 83559550e6fb..77815513b768 100644
--- a/drivers/pci/pci_mvebu.c
+++ b/drivers/pci/pci_mvebu.c
@@ -10,7 +10,6 @@
  * Pali Rohár <pali@kernel.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/drivers/pci/pci_rom.c b/drivers/pci/pci_rom.c
index 438583aa0179..78e5de937cdf 100644
--- a/drivers/pci/pci_rom.c
+++ b/drivers/pci/pci_rom.c
@@ -24,7 +24,6 @@
 
 #define LOG_CATEGORY UCLASS_PCI
 
-#include <common.h>
 #include <bios_emul.h>
 #include <bloblist.h>
 #include <bootstage.h>
@@ -36,6 +35,7 @@
 #include <pci.h>
 #include <pci_rom.h>
 #include <spl.h>
+#include <time.h>
 #include <vesa.h>
 #include <video.h>
 #include <acpi/acpi_s3.h>
diff --git a/drivers/pci/pci_sandbox.c b/drivers/pci/pci_sandbox.c
index ca44d002371e..fed0850458d9 100644
--- a/drivers/pci/pci_sandbox.c
+++ b/drivers/pci/pci_sandbox.c
@@ -4,7 +4,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <fdtdec.h>
 #include <log.h>
diff --git a/drivers/pci/pci_sh7751.c b/drivers/pci/pci_sh7751.c
index c1be56ce7a08..3cd01e9b94a2 100644
--- a/drivers/pci/pci_sh7751.c
+++ b/drivers/pci/pci_sh7751.c
@@ -5,7 +5,7 @@
  * (C) 2007,2008 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
  */
 
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <pci.h>
 #include <asm/processor.h>
diff --git a/drivers/pci/pci_tegra.c b/drivers/pci/pci_tegra.c
index d6374a58e330..bb8832c6ab96 100644
--- a/drivers/pci/pci_tegra.c
+++ b/drivers/pci/pci_tegra.c
@@ -11,7 +11,6 @@
 
 #define pr_fmt(fmt) "tegra-pcie: " fmt
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/drivers/pci/pci_x86.c b/drivers/pci/pci_x86.c
index 8d036930e73b..ab76166451c7 100644
--- a/drivers/pci/pci_x86.c
+++ b/drivers/pci/pci_x86.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2015 Google, Inc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <pci.h>
 #include <asm/pci.h>
diff --git a/drivers/pci/pcie_apple.c b/drivers/pci/pcie_apple.c
index 21bafba3b0ee..6a8e715d4b6e 100644
--- a/drivers/pci/pcie_apple.c
+++ b/drivers/pci/pcie_apple.c
@@ -16,7 +16,6 @@
  * Author: Marc Zyngier <maz@kernel.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <dm/devres.h>
diff --git a/drivers/pci/pcie_brcmstb.c b/drivers/pci/pcie_brcmstb.c
index cd45f0bee9b7..f978c64365c3 100644
--- a/drivers/pci/pcie_brcmstb.c
+++ b/drivers/pci/pcie_brcmstb.c
@@ -12,7 +12,6 @@
  * Copyright (C) 2020 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
  */
 
-#include <common.h>
 #include <errno.h>
 #include <dm.h>
 #include <dm/ofnode.h>
diff --git a/drivers/pci/pcie_dw_common.c b/drivers/pci/pcie_dw_common.c
index 74fb6df412c7..0673e516c6fe 100644
--- a/drivers/pci/pcie_dw_common.c
+++ b/drivers/pci/pcie_dw_common.c
@@ -8,7 +8,6 @@
  * Copyright (C) 2018 Texas Instruments, Inc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <pci.h>
diff --git a/drivers/pci/pcie_dw_meson.c b/drivers/pci/pcie_dw_meson.c
index f953797908b8..bb78e7874b14 100644
--- a/drivers/pci/pcie_dw_meson.c
+++ b/drivers/pci/pcie_dw_meson.c
@@ -9,7 +9,6 @@
  * Copyright (c) 2021 Rockchip, Inc.
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <generic-phy.h>
diff --git a/drivers/pci/pcie_dw_mvebu.c b/drivers/pci/pcie_dw_mvebu.c
index c41f3f153044..43b919175c92 100644
--- a/drivers/pci/pcie_dw_mvebu.c
+++ b/drivers/pci/pcie_dw_mvebu.c
@@ -10,10 +10,11 @@
  *   - drivers/pci/pcie_xilinx.c
  */
 
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <log.h>
 #include <pci.h>
+#include <time.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm-generic/gpio.h>
diff --git a/drivers/pci/pcie_dw_rockchip.c b/drivers/pci/pcie_dw_rockchip.c
index bc4635f67136..1bad51fb3eb5 100644
--- a/drivers/pci/pcie_dw_rockchip.c
+++ b/drivers/pci/pcie_dw_rockchip.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2021 Rockchip, Inc.
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <generic-phy.h>
diff --git a/drivers/pci/pcie_dw_sifive.c b/drivers/pci/pcie_dw_sifive.c
index fac3f1823724..6285edf4b037 100644
--- a/drivers/pci/pcie_dw_sifive.c
+++ b/drivers/pci/pcie_dw_sifive.c
@@ -14,7 +14,6 @@
 #include <asm/io.h>
 #include <asm-generic/gpio.h>
 #include <clk.h>
-#include <common.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <generic-phy.h>
diff --git a/drivers/pci/pcie_dw_ti.c b/drivers/pci/pcie_dw_ti.c
index 4195a02de390..78a5d0358651 100644
--- a/drivers/pci/pcie_dw_ti.c
+++ b/drivers/pci/pcie_dw_ti.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018 Texas Instruments, Inc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <pci.h>
diff --git a/drivers/pci/pcie_ecam_generic.c b/drivers/pci/pcie_ecam_generic.c
index f5bc6e3d92d6..3cb2bbbccb44 100644
--- a/drivers/pci/pcie_ecam_generic.c
+++ b/drivers/pci/pcie_ecam_generic.c
@@ -7,7 +7,6 @@
  * Copyright (C) 2016 Imagination Technologies
  */
 
-#include <common.h>
 #include <dm.h>
 #include <pci.h>
 #include <linux/ioport.h>
diff --git a/drivers/pci/pcie_ecam_synquacer.c b/drivers/pci/pcie_ecam_synquacer.c
index e3e22891088e..fc855dfca4eb 100644
--- a/drivers/pci/pcie_ecam_synquacer.c
+++ b/drivers/pci/pcie_ecam_synquacer.c
@@ -8,7 +8,6 @@
  * Copyright (C) 2021 Linaro Ltd.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <pci.h>
 #include <log.h>
diff --git a/drivers/pci/pcie_fsl.c b/drivers/pci/pcie_fsl.c
index ec917ee7d5b8..18af23c9504e 100644
--- a/drivers/pci/pcie_fsl.c
+++ b/drivers/pci/pcie_fsl.c
@@ -6,7 +6,7 @@
  * Author: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <malloc.h>
 #include <mapmem.h>
diff --git a/drivers/pci/pcie_fsl_fixup.c b/drivers/pci/pcie_fsl_fixup.c
index f4e227895d17..9187e7af7461 100644
--- a/drivers/pci/pcie_fsl_fixup.c
+++ b/drivers/pci/pcie_fsl_fixup.c
@@ -6,7 +6,6 @@
  * Author: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
  */
 
-#include <common.h>
 #ifdef CONFIG_OF_BOARD_SETUP
 #include <dm.h>
 #include <fdt_support.h>
diff --git a/drivers/pci/pcie_imx.c b/drivers/pci/pcie_imx.c
index 78f2c7d6bcdf..11c4ccbfc555 100644
--- a/drivers/pci/pcie_imx.c
+++ b/drivers/pci/pcie_imx.c
@@ -17,7 +17,6 @@
  * those too in order to have a single modern PCIe iMX driver.
  */
 
-#include <common.h>
 #include <init.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/drivers/pci/pcie_intel_fpga.c b/drivers/pci/pcie_intel_fpga.c
index 60195cfe1b6e..959fd3690869 100644
--- a/drivers/pci/pcie_intel_fpga.c
+++ b/drivers/pci/pcie_intel_fpga.c
@@ -6,7 +6,6 @@
  *
  */
 
-#include <common.h>
 #include <dm.h>
 #include <pci.h>
 #include <asm/global_data.h>
diff --git a/drivers/pci/pcie_iproc.c b/drivers/pci/pcie_iproc.c
index d6d3a9e20250..360ef1b011f2 100644
--- a/drivers/pci/pcie_iproc.c
+++ b/drivers/pci/pcie_iproc.c
@@ -4,7 +4,6 @@
  *
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <generic-phy.h>
diff --git a/drivers/pci/pcie_layerscape.c b/drivers/pci/pcie_layerscape.c
index 3c7c4ca18e8b..1be33095b9ce 100644
--- a/drivers/pci/pcie_layerscape.c
+++ b/drivers/pci/pcie_layerscape.c
@@ -5,7 +5,6 @@
  * Layerscape PCIe driver
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/drivers/pci/pcie_layerscape_ep.c b/drivers/pci/pcie_layerscape_ep.c
index 83f7eebd6277..3520488b3453 100644
--- a/drivers/pci/pcie_layerscape_ep.c
+++ b/drivers/pci/pcie_layerscape_ep.c
@@ -4,7 +4,7 @@
  * Layerscape PCIe EP driver
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/arch/fsl_serdes.h>
 #include <dm.h>
 #include <asm/global_data.h>
diff --git a/drivers/pci/pcie_layerscape_fixup.c b/drivers/pci/pcie_layerscape_fixup.c
index c5198353957b..ec4a7e7b6574 100644
--- a/drivers/pci/pcie_layerscape_fixup.c
+++ b/drivers/pci/pcie_layerscape_fixup.c
@@ -5,7 +5,6 @@
  * Layerscape PCIe driver
  */
 
-#include <common.h>
 #include <dm.h>
 #include <init.h>
 #include <log.h>
diff --git a/drivers/pci/pcie_layerscape_fixup_common.c b/drivers/pci/pcie_layerscape_fixup_common.c
index 095874a92763..f37e37f6b153 100644
--- a/drivers/pci/pcie_layerscape_fixup_common.c
+++ b/drivers/pci/pcie_layerscape_fixup_common.c
@@ -7,10 +7,10 @@
  *
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/soc.h>
+#include <linux/errno.h>
 #include <linux/libfdt.h>
 #include <fdt_support.h>
 #include "pcie_layerscape_fixup_common.h"
diff --git a/drivers/pci/pcie_layerscape_gen4.c b/drivers/pci/pcie_layerscape_gen4.c
index 021c975869fd..57dc91f2faef 100644
--- a/drivers/pci/pcie_layerscape_gen4.c
+++ b/drivers/pci/pcie_layerscape_gen4.c
@@ -6,7 +6,7 @@
  * Author: Hou Zhiqiang <Minder.Hou@gmail.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <log.h>
 #include <asm/arch/fsl_serdes.h>
 #include <pci.h>
diff --git a/drivers/pci/pcie_layerscape_gen4_fixup.c b/drivers/pci/pcie_layerscape_gen4_fixup.c
index b2a45bf105c8..60c4338bcdb5 100644
--- a/drivers/pci/pcie_layerscape_gen4_fixup.c
+++ b/drivers/pci/pcie_layerscape_gen4_fixup.c
@@ -7,7 +7,6 @@
  *
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <pci.h>
diff --git a/drivers/pci/pcie_layerscape_rc.c b/drivers/pci/pcie_layerscape_rc.c
index 6a5bf88da234..e7913d43a8be 100644
--- a/drivers/pci/pcie_layerscape_rc.c
+++ b/drivers/pci/pcie_layerscape_rc.c
@@ -4,7 +4,6 @@
  * Layerscape PCIe driver
  */
 
-#include <common.h>
 #include <asm/arch/fsl_serdes.h>
 #include <pci.h>
 #include <asm/global_data.h>
diff --git a/drivers/pci/pcie_mediatek.c b/drivers/pci/pcie_mediatek.c
index f0f34b5d1197..04d8cc29afd5 100644
--- a/drivers/pci/pcie_mediatek.c
+++ b/drivers/pci/pcie_mediatek.c
@@ -7,7 +7,6 @@
  *	   Honghui Zhang <honghui.zhang@mediatek.com>
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <generic-phy.h>
diff --git a/drivers/pci/pcie_phytium.c b/drivers/pci/pcie_phytium.c
index 3bd1f5cd6d91..94de89bcad7b 100644
--- a/drivers/pci/pcie_phytium.c
+++ b/drivers/pci/pcie_phytium.c
@@ -7,7 +7,6 @@
  * Copyright (C) 2019
  */
 
-#include <common.h>
 #include <dm.h>
 #include <pci.h>
 #include <asm/global_data.h>
diff --git a/drivers/pci/pcie_plda_common.c b/drivers/pci/pcie_plda_common.c
index cd74bb471163..622a5cee1099 100644
--- a/drivers/pci/pcie_plda_common.c
+++ b/drivers/pci/pcie_plda_common.c
@@ -6,7 +6,6 @@
  *
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <pci.h>
diff --git a/drivers/pci/pcie_rockchip.c b/drivers/pci/pcie_rockchip.c
index 624841e9d8b8..19f9e58a640d 100644
--- a/drivers/pci/pcie_rockchip.c
+++ b/drivers/pci/pcie_rockchip.c
@@ -11,7 +11,6 @@
  * Bits taken from Linux Rockchip PCIe host controller.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <generic-phy.h>
diff --git a/drivers/pci/pcie_starfive_jh7110.c b/drivers/pci/pcie_starfive_jh7110.c
index 903a544d37f6..569fbfd35c81 100644
--- a/drivers/pci/pcie_starfive_jh7110.c
+++ b/drivers/pci/pcie_starfive_jh7110.c
@@ -7,7 +7,6 @@
  *
  */
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <pci.h>
diff --git a/drivers/pci/pcie_uniphier.c b/drivers/pci/pcie_uniphier.c
index f2edea9899a4..d1170b576bcd 100644
--- a/drivers/pci/pcie_uniphier.c
+++ b/drivers/pci/pcie_uniphier.c
@@ -5,7 +5,6 @@
  */
 
 #include <clk.h>
-#include <common.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <generic-phy.h>
diff --git a/drivers/pci/pcie_xilinx.c b/drivers/pci/pcie_xilinx.c
index 3db460b5f936..a674ab04beee 100644
--- a/drivers/pci/pcie_xilinx.c
+++ b/drivers/pci/pcie_xilinx.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2016 Imagination Technologies
  */
 
-#include <common.h>
 #include <dm.h>
 #include <pci.h>
 #include <linux/bitops.h>
-- 
2.34.1

