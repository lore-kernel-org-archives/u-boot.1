Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DD3C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 23:46:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 277F988CCE;
	Wed, 24 Apr 2024 01:46:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B631488CCF; Wed, 24 Apr 2024 01:46:27 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 8689788CCD
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 01:46:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 569FD339;
 Tue, 23 Apr 2024 16:46:52 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60A773F7BD;
 Tue, 23 Apr 2024 16:46:23 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH] sysreset: psci: drop reliance on SPL support
Date: Wed, 24 Apr 2024 00:46:04 +0100
Message-Id: <20240423234604.10674-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
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

At the moment enabling CONFIG_SYSRESET_PSCI *selects* SPL_ARM_PSCI_FW,
even though this is a platform design property, so nothing any driver
should enforce. Some platforms load the PSCI runtime (TF-A) only in the
SPL, so PSCI is naturally not available during SPL runtime.

Spit CONFIG_SYSRESET_PSCI up into an SPL and a U-Boot proper version,
and let the former *depend* on SPL_ARM_PSCI_FW.

This allows to enable CONFIG_SYSRESET_PSCI on platforms without SPL PSCI
support.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/sysreset/Kconfig  | 8 +++++++-
 drivers/sysreset/Makefile | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/sysreset/Kconfig b/drivers/sysreset/Kconfig
index 49c0787b26d..62fe9eb6220 100644
--- a/drivers/sysreset/Kconfig
+++ b/drivers/sysreset/Kconfig
@@ -119,11 +119,17 @@ config SYSRESET_PALMAS
 config SYSRESET_PSCI
 	bool "Enable support for PSCI System Reset"
 	depends on ARM_PSCI_FW
-	select SPL_ARM_PSCI_FW if SPL
 	help
 	  Enable PSCI SYSTEM_RESET function call.  To use this, PSCI firmware
 	  must be running on your system.
 
+config SYSRESET_SPL_PSCI
+	bool "Enable support for PSCI System Reset in SPL"
+	depends on SPL_ARM_PSCI_FW
+	help
+	  Enable PSCI SYSTEM_RESET function call in the SPL. To use this, PSCI
+	  firmware must be running on your system before the SPL.
+
 config SYSRESET_SBI
 	bool "Enable support for SBI System Reset"
 	depends on RISCV_SMODE && SBI_V02
diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
index e0e732205df..8d992ae0930 100644
--- a/drivers/sysreset/Makefile
+++ b/drivers/sysreset/Makefile
@@ -14,7 +14,7 @@ obj-$(CONFIG_SYSRESET_MPC83XX) += sysreset_mpc83xx.o
 obj-$(CONFIG_SYSRESET_MICROBLAZE) += sysreset_microblaze.o
 obj-$(CONFIG_SYSRESET_OCTEON) += sysreset_octeon.o
 obj-$(CONFIG_$(SPL_TPL_)SYSRESET_PALMAS) += sysreset_palmas.o
-obj-$(CONFIG_SYSRESET_PSCI) += sysreset_psci.o
+obj-$(CONFIG_$(SPL_TPL_)SYSRESET_PSCI) += sysreset_psci.o
 obj-$(CONFIG_SYSRESET_SBI) += sysreset_sbi.o
 obj-$(CONFIG_SYSRESET_SOCFPGA) += sysreset_socfpga.o
 obj-$(CONFIG_SYSRESET_SOCFPGA_SOC64) += sysreset_socfpga_soc64.o
-- 
2.35.8

