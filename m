Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5B0E743C0
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 04:05:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3ABF86E76;
	Fri, 29 Sep 2023 06:04:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A821C86E84; Fri, 29 Sep 2023 06:04:58 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E0F686E61
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 06:04:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peterlin@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 38T44QRD032751;
 Fri, 29 Sep 2023 12:04:26 +0800 (+08)
 (envelope-from peterlin@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Fri, 29 Sep 2023 12:04:24 +0800
From: Yu Chien Peter Lin <peterlin@andestech.com>
To: <u-boot@lists.denx.de>, <rick@andestech.com>, <ycliang@andestech.com>,
 <peterlin@andestech.com>, <randolph@andestech.com>
CC: <twarren@nvidia.com>, <sjg@chromium.org>, <saproj@gmail.com>,
 <william.zhang@broadcom.com>, <andre.przywara@arm.com>,
 <clamor95@gmail.com>, <patrice.chotard@foss.st.com>,
 <jonasschwoebel@yahoo.de>, <bmeng@tinylab.org>,
 Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2] riscv: andesv5: Prefer using the generic RISC-V timer
 driver in S-mode
Date: Fri, 29 Sep 2023 12:03:07 +0800
Message-ID: <20230929040307.2977669-1-peterlin@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 38T44QRD032751
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

The Andes PLMT driver directly accesses the mtime MMIO region,
indicating its intended use in the M-mode boot stage. However,
since U-Boot proper (S-mode) also uses the PLMT driver, we need
to specifically mark the region as readable through PMPCFGx (or
S/U-mode read-only shared data region for Smepmp) in OpenSBI.

Granting permission for this case doesn't make sense. Instead,
we should use the generic RISC-V timer driver to read the mtime
through the TIME CSR. Therefore, we add the SPL_ANDES_PLMT_TIMER
config, which ensures that the PLMT driver is linked exclusively
against M-mode U-Boot or U-Boot SPL binaries.

Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
Reviewed-by: Samuel Holland <samuel@sholland.org>
---
Changes v1 -> v2:
- Drop imply conditions for *ANDES_PLMT_TIMER
- Add Samuel's RB-tag
---
 arch/riscv/cpu/andesv5/Kconfig | 3 ++-
 drivers/timer/Kconfig          | 9 ++++++++-
 drivers/timer/Makefile         | 2 +-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/cpu/andesv5/Kconfig b/arch/riscv/cpu/andesv5/Kconfig
index 82bb5a2a53..57177b7b64 100644
--- a/arch/riscv/cpu/andesv5/Kconfig
+++ b/arch/riscv/cpu/andesv5/Kconfig
@@ -4,8 +4,9 @@ config RISCV_NDS
 	imply CPU
 	imply CPU_RISCV
 	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
+	imply ANDES_PLMT_TIMER
+	imply SPL_ANDES_PLMT_TIMER
 	imply ANDES_PLICSW if (RISCV_MMODE || SPL_RISCV_MMODE)
-	imply ANDES_PLMT_TIMER if (RISCV_MMODE || SPL_RISCV_MMODE)
 	imply V5L2_CACHE
 	imply SPL_CPU
 	imply SPL_OPENSBI
diff --git a/drivers/timer/Kconfig b/drivers/timer/Kconfig
index 915b2af160..157298a941 100644
--- a/drivers/timer/Kconfig
+++ b/drivers/timer/Kconfig
@@ -59,7 +59,14 @@ config ALTERA_TIMER
 
 config ANDES_PLMT_TIMER
 	bool
-	depends on RISCV_MMODE || SPL_RISCV_MMODE
+	depends on RISCV_MMODE
+	help
+	  The Andes PLMT block holds memory-mapped mtime register
+	  associated with timer tick.
+
+config SPL_ANDES_PLMT_TIMER
+	bool
+	depends on SPL_RISCV_MMODE
 	help
 	  The Andes PLMT block holds memory-mapped mtime register
 	  associated with timer tick.
diff --git a/drivers/timer/Makefile b/drivers/timer/Makefile
index 1ca74805fd..1f5c16fdf3 100644
--- a/drivers/timer/Makefile
+++ b/drivers/timer/Makefile
@@ -4,7 +4,7 @@
 
 obj-y += timer-uclass.o
 obj-$(CONFIG_ALTERA_TIMER)	+= altera_timer.o
-obj-$(CONFIG_ANDES_PLMT_TIMER) += andes_plmt_timer.o
+obj-$(CONFIG_$(SPL_)ANDES_PLMT_TIMER) += andes_plmt_timer.o
 obj-$(CONFIG_ARC_TIMER)	+= arc_timer.o
 obj-$(CONFIG_ARM_TWD_TIMER)	+= arm_twd_timer.o
 obj-$(CONFIG_AST_TIMER)	+= ast_timer.o
-- 
2.40.1

