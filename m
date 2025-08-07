Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE35C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 11:38:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20E1D84509;
	Thu,  7 Aug 2025 13:38:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A68B384509; Thu,  7 Aug 2025 13:38:23 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 266CF833AD
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 13:38:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 577BcHim077382
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
 for <u-boot@lists.denx.de>; Thu, 7 Aug 2025 19:38:17 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Aug
 2025 19:38:17 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <u-boot@lists.denx.de>
CC: <ycliang@andestech.com>, <randolph@andestech.com>, <tim609@andestech.com>
Subject: [PATCH 1/6] riscv: board: Add Andes Voyager board Kconfig support
Date: Thu, 7 Aug 2025 19:38:07 +0800
Message-ID: <20250807113807.361649-1-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 577BcHim077382
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

The Voyager is Andes' first RISC-V development board.
It is built around Qilai SoC, which includes Andes AX45MP quad-core cluster.

Introduce the Kconfig entry for the Voyager board.

Signed-off-by: Randolph Sheng-Kai Lin <randolph@andestech.com>
Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 arch/riscv/Kconfig              |  4 +++
 board/andestech/voyager/Kconfig | 44 +++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)
 create mode 100644 board/andestech/voyager/Kconfig

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 8c6feae5735..04eb0e6f23c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -11,6 +11,9 @@ choice
 config TARGET_ANDES_AE350
 	bool "Support Andes ae350"
 
+config TARGET_ANDES_VOYAGER
+	bool "Support Andes Voyager Board"
+
 config TARGET_BANANAPI_F3
 	bool "Support BananaPi F3 Board"
 
@@ -101,6 +104,7 @@ config SPL_ZERO_MEM_BEFORE_USE
 
 # board-specific options below
 source "board/andestech/ae350/Kconfig"
+source "board/andestech/voyager/Kconfig"
 source "board/aspeed/ibex_ast2700/Kconfig"
 source "board/canaan/k230_canmv/Kconfig"
 source "board/emulation/qemu-riscv/Kconfig"
diff --git a/board/andestech/voyager/Kconfig b/board/andestech/voyager/Kconfig
new file mode 100644
index 00000000000..b2e212c3fee
--- /dev/null
+++ b/board/andestech/voyager/Kconfig
@@ -0,0 +1,44 @@
+if TARGET_ANDES_VOYAGER
+
+config SYS_CPU
+	default "andes"
+
+config SYS_BOARD
+	default "voyager"
+
+config SYS_VENDOR
+	default "andestech"
+
+config SYS_SOC
+	default "qilai"
+
+config SYS_CONFIG_NAME
+	default "voyager"
+
+config ENV_SIZE
+	default 0x2000 if ENV_IS_IN_SPI_FLASH
+
+config ENV_OFFSET
+	default 0x1F0000 if ENV_IS_IN_SPI_FLASH
+
+config SPL_TEXT_BASE
+	default 0x400800000
+
+config SPL_OPENSBI_LOAD_ADDR
+	default 0x400000000
+
+config SYS_FDT_BASE
+	hex
+	default 0x81E0000 if OF_SEPARATE
+
+config BOARD_SPECIFIC_OPTIONS # dummy
+	def_bool y
+	select RISCV_ANDES
+	select SUPPORT_SPL
+	select BINMAN if SPL
+	imply SMP
+	imply SPL_RAM_SUPPORT
+	imply SPL_RAM_DEVICE
+	imply OF_HAS_PRIOR_STAGE
+
+endif
-- 
2.34.1

