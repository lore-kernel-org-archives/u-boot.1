Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718EF606A31C
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 02:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=U8guBjI4;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=eP3aGvWb
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15C1C60F12;
	Fri, 13 Nov 2026 02:35:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tTs_0fbh6MfY; Fri, 13 Nov 2026 02:34:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1ED4A60EF4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794537271;
	b=Ue1yAQQQsdi/sxGkm6l07boaYqkg5Wg9m1NWGC7Xfn/lsl3i4PVA9Ny7CFakLJ6CDGNz
	 vUzJczQn1VRDBjtlUia3MC+bKIrzEb2u+EdI7YGkKBgRQhuZqGSolE/hFMAl71PJ5j9v7
	 iOVgWrUj0WDCIu1pD7iEFBfZAnf4e9bkN4Axtna39sC8XihqcgtHsU/sPOaHwQa6JHAfi
	 vU4pgFTPwz1MS6Ny2I7D0Ic8oi3UknjL2cM9DLKTVzmaJOqKuCLlxFtUjtte5l/EGY0y1
	 91ZURNsy9O5+Hc1gKwvUCyv1ZQ0nXiG4HslNx6UxpHjWkKshRlsaEMjESGPHdhlV64g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794537271;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-GPT-Reason:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JegGuDxiB/9FVj/KFjqOEHB6ZxdKIQzVTV/a7Fb1BMg=;
	b=DGNah+CwvvFQjLR43cGC3nUNnTi9JB3x5t0yKgNwDTogGw/aEjqeIkHSLGye7PICHDGI
	 jvNrMOxtVZF8txF1sy07SoqOzWjocbpQehT6MyEQfgSUgu39IuL0bN2QN8kGSa6BfQlad
	 OrqLtXZLUfHESvhovBe3+lnWKij1TrDIDDasI0vxYC/HcYxaKfwvuAL90frnhUyr6rJNU
	 PRX4/g4rS0RWX9hUdbzel7vvGRCxsU+cNMUXUrF0gvHGEIDHOtTDH3zH+RDvn+b95zzF5
	 Zcu8g7dTOrzqiP3IYIFcQu3y1yeYTMvtl4qwz7tJ4yxZ89ARxCkPI6Md3bF0vzHDJYQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794537271;
	bh=JegGuDxiB/9FVj/KFjqOEHB6ZxdKIQzVTV/a7Fb1BMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U8guBjI42vE6xSi+OuukAP/CaymcXC8r+yP21Ckak01k9Y4RVKG4VBC7cPMSjEGL+
	 w4Gb2V0FxHLokVF7SyXo0zX6zDOomNHXPN4kNSoyRvbmmOOxvPz1yCwEm3/BFSrxIm
	 ETuS1DCQy45PBQKVfPEG70oIEb571y/88xPt8dzF/jZwL031VHhMUASPxwvDbrprtg
	 Sttj4MR/tMQrUjq6RnHOdqmK6RiNoq/tJ7juWvl0Ek87R2e+Ai+fvKMgOckGND76uI
	 hZQ8Q763UxQHHGBU7Jz4ybIGoQEVjeZNqkmq1yqrmxNt7DMup90L5xgnq5lauj3kER
	 IG1unZ+Sy1uNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1ED4A60EF4;
	Fri, 13 Nov 2026 02:34:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B929E2E5
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:34:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9EB73815FA
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:34:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fqd4plEH7MeT for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 02:34:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A5D558151E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=119.15.109.137
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=119.15.109.137;
 helo=www.nmnhosting.com; envelope-from=alastair@d-silva.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org
 header.a=rsa-sha256 header.s=2025a header.b=eP3aGvWb
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A5D558151E
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 02:34:26 +0000 (UTC)
Received: from Hawking.lan (hawking.lan [10.0.1.4])
 by www.nmnhosting.com (Postfix) with ESMTP id 556174C8C4;
 Fri, 13 Nov 2026 13:34:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a; 
 t=1794537258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JegGuDxiB/9FVj/KFjqOEHB6ZxdKIQzVTV/a7Fb1BMg=;
 b=eP3aGvWbyS4j6MZrs94L647PRImAmRO/bsM7ZiLNjptgOaEMu+286XSEJ/4jsrE2lksgeH
 hQhvkPp1A//siHNER3foATVF6pHWwSPNvHSSTXylRaFeiJ9PssiYB1s/1OMEu3r5oLacGE
 z83we36ENIgsmsuxADETloM40eThJdtisb+DgH+6a6/XsNxVjkCD4JQTvOcFj8aBBepfYG
 cEf07OpQyuWb9i3LQkjAlwTciL3TBpdwrWDe0GOW3vf8yVCBaTiE2FlCfTeBKPgbFOUuTJ
 0/rHQOjuNFfE/kRCL1bX6fGhA+Ql57Max7cc+YoKkYo8waAod+OPGu20dfWU+A==
X-GPT-Reason: legitimate; the email is a technical software development
 update (kernel patch) that aligns perfectly with the recipient's
 personal mailbox (alastair@d-silva.org); the sender domain (d-silva.org)
 matches the recipient's domain exactly; there are no phishing markers,
 urgency tactics, or suspicious links, and the content is purely
 functional regarding DRAM driver development.
From: Alastair D'Silva <alastair@d-silva.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Enzo Adriano <enzo.adriano.code@gmail.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH 19/26] sunxi: dram: a733: Add Allwinner A733 LPDDR5 DRAM driver
Date: Fri, 13 Nov 2026 13:32:29 +1100
Message-ID: <20261113023236.569054-20-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113023236.569054-1-alastair@d-silva.org>
References: <20261113023236.569054-1-alastair@d-silva.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the SPL LPDDR5 dual-channel uMCTL2 and Synopsys DesignWare DDR PHY
driver for the Allwinner A733 (sun60iw2p1) SoC, together with U-Boot
proper's board_add_ram_info() speed/generation reporting.

Features:
- Invokes build_pmu_fw.py via Kbuild during SPL build (supporting
  ARC_CROSS_COMPILE, PMU_FW, and BINMAN_ALLOW_MISSING) and places the
  one-time initialization tables and PMU ICCM image in .init.rodata.
- Scales PLL_DDR and PMU message-block data rate from CONFIG_DRAM_CLK
  (defaulting to 1800 MHz WCK / 3600 MT/s LPDDR5).
- Attempts dual-rank training first with automatic fallback to
  single-rank training, and probes exact capacity (including 3/4-density
  6 Gb / 12 Gb dies) via JEDEC JESD209-5 Mode Register 8 (MR8).
- Guards the A733 reference / Orange Pi 4 Pro CA/DQ lane swizzle map
  behind CONFIG_DRAM_SUN60I_A733_PIN_SWIZZLE.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/arm/include/asm/arch-sunxi/dram.h        |    2 +
 arch/arm/mach-sunxi/Kconfig                   |   21 +-
 arch/arm/mach-sunxi/Makefile                  |   37 +
 arch/arm/mach-sunxi/dram_sun60i_a733.c        | 1303 +++++++++++++++++
 arch/arm/mach-sunxi/dram_sun60i_a733_tables.h |  941 ++++++++++++
 5 files changed, 2303 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-sunxi/dram_sun60i_a733.c
 create mode 100644 arch/arm/mach-sunxi/dram_sun60i_a733_tables.h

diff --git a/arch/arm/include/asm/arch-sunxi/dram.h b/arch/arm/include/asm/arch-sunxi/dram.h
index 59e2e980bfa..58587a713eb 100644
--- a/arch/arm/include/asm/arch-sunxi/dram.h
+++ b/arch/arm/include/asm/arch-sunxi/dram.h
@@ -37,6 +37,8 @@
 #include <asm/arch/dram_suniv.h>
 #elif defined(CONFIG_MACH_SUN55I_A523)
 #include <asm/arch/dram_sun55i_a523.h>
+#elif defined(CONFIG_DRAM_SUN60I_A733)
+/* A733 DRAM registers are private to dram_sun60i_a733.c */
 #else
 #include <asm/arch/dram_sun4i.h>
 #endif
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index b7ee14c6678..f3f70b277b1 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -62,6 +62,21 @@ config DRAM_SUN55I_A523
 	help
 	  Select this DRAM controller driver for A523/T527 SoCs.
 
+config DRAM_SUN60I_A733
+	bool
+	help
+	  Select this LPDDR5 DRAM controller and Synopsys DDR PHY driver for
+	  Allwinner A733/T736 SoCs.
+
+config DRAM_SUN60I_A733_PIN_SWIZZLE
+	bool "Allwinner A733 LPDDR5 CA/DQ pin swizzle"
+	depends on DRAM_SUN60I_A733
+	help
+	  Program the CA0..CA6 and DQ0..DQ7 lane permutation used on boards
+	  such as the Orange Pi 4 Pro. Disable this option on boards that use
+	  a non-swizzled or custom PCB trace mapping to the LPDDR5 memory
+	  package.
+
 if DRAM_SUN50I_H616 || DRAM_SUN50I_A133 || DRAM_SUN55I_A523
 config DRAM_SUNXI_DX_ODT
 	hex "DRAM DX ODT parameter"
@@ -741,10 +756,12 @@ config DRAM_CLK
 	default 744 if MACH_SUN50I_H6
 	default 720 if MACH_SUN50I_H616 || MACH_SUN50I_A133
 	default 1200 if MACH_SUN55I_A523
+	default 1800 if DRAM_SUN60I_A733
 	help
 	  Set the dram clock speed, valid range 240 - 480 (prior to sun9i),
 	  must be a multiple of 24. For the sun9i (A80), the tested values
-	  (for DDR3-1600) are 312 to 792.
+	  (for DDR3-1600) are 312 to 792. For sun60i (A733 LPDDR5), the WCK
+	  clock defaults to 1800 MHz (3600 MT/s).
 
 if MACH_SUN5I || MACH_SUN7I
 config DRAM_MBUS_CLK
@@ -760,6 +777,7 @@ config DRAM_ZQ
 	depends on !MACH_SUN50I_H616
 	depends on !MACH_SUN50I_A133
 	depends on !MACH_SUN55I_A523
+	depends on !DRAM_SUN60I_A733
 	default 123 if MACH_SUN4I || MACH_SUN5I || MACH_SUN6I || \
 		       MACH_SUN8I_A23 || MACH_SUN8I_A33 || MACH_SUN8I_A83T
 	default 127 if MACH_SUN7I
@@ -774,6 +792,7 @@ config DRAM_ODT_EN
 	bool "sunxi dram odt enable"
 	depends on !MACH_SUN50I_H616
 	depends on !MACH_SUN55I_A523
+	depends on !DRAM_SUN60I_A733
 	default y if MACH_SUN8I_A23
 	default y if MACH_SUNXI_H3_H5
 	default y if MACH_SUN8I_R40
diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
index ff475d8fff5..8bee03524bf 100644
--- a/arch/arm/mach-sunxi/Makefile
+++ b/arch/arm/mach-sunxi/Makefile
@@ -26,6 +26,7 @@ endif
 obj-$(CONFIG_MACH_SUN9I)	+= clock_sun9i.o gtbus_sun9i.o
 obj-$(CONFIG_SUN50I_GEN_H6)	+= clock_sun50i_h6.o
 obj-$(CONFIG_SUNXI_GEN_NCAT2)	+= clock_sun50i_h6.o
+obj-$(CONFIG_DRAM_SUN60I_A733)	+= dram_sun60i_a733.o
 ifndef CONFIG_ARM64
 obj-y	+= timer.o
 endif
@@ -50,4 +51,40 @@ obj-$(CONFIG_DRAM_SUN50I_A133)	+= dram_sun50i_a133.o
 obj-$(CONFIG_DRAM_SUN50I_A133)	+= dram_timings/
 obj-$(CONFIG_MACH_SUN55I_A523)	+= dram_sun55i_a523.o dram_dw_helpers.o
 obj-$(CONFIG_DRAM_SUN55I_A523)	+= dram_timings/
+
+ifdef CONFIG_DRAM_SUN60I_A733
+ifdef CONFIG_XPL_BUILD
+PMU_FW_DIR := $(srctree)/arch/arm/mach-sunxi/pmu
+PMU_FW_SRCS := \
+	$(PMU_FW_DIR)/pmu_primitives.c \
+	$(PMU_FW_DIR)/pmu_clock.c \
+	$(PMU_FW_DIR)/pmu_telemetry.c \
+	$(PMU_FW_DIR)/pmu_cbt.c \
+	$(PMU_FW_DIR)/pmu_deskew.c \
+	$(PMU_FW_DIR)/pmu_eye.c \
+	$(PMU_FW_DIR)/pmu_train.c
+PMU_FW_HDRS := \
+	$(PMU_FW_DIR)/sunxi_pmu_abi.h \
+	$(PMU_FW_DIR)/dwc_ddrphy_pmu_regs.h \
+	$(PMU_FW_DIR)/pmu_fw.h \
+	$(PMU_FW_DIR)/pmu.ld
+
+quiet_cmd_pmu_fw = PMUFW   $@
+      cmd_pmu_fw = $(PYTHON3) -B $(PMU_FW_DIR)/build_pmu_fw.py \
+		   $(if $(ARC_CROSS_COMPILE),--cross-compile $(ARC_CROSS_COMPILE)) \
+		   $(if $(PMU_FW),--pmu-fw $(PMU_FW)) \
+		   $(if $(filter 1 y,$(BINMAN_ALLOW_MISSING) $(ALLOW_MISSING)),--allow-missing) \
+		   --src-dir $(PMU_FW_DIR) \
+		   --ld-script $(PMU_FW_DIR)/pmu.ld \
+		   --out $@ $(PMU_FW_SRCS)
+
+$(obj)/dram_sun60i_a733_pmu_fw.h: $(PMU_FW_DIR)/build_pmu_fw.py $(PMU_FW_SRCS) $(PMU_FW_HDRS) $(PMU_FW) FORCE
+	$(call if_changed,pmu_fw)
+
+targets += dram_sun60i_a733_pmu_fw.h
+clean-files += dram_sun60i_a733_pmu_fw.h
+CFLAGS_dram_sun60i_a733.o += -I$(obj)
+$(obj)/dram_sun60i_a733.o: $(obj)/dram_sun60i_a733_pmu_fw.h
+endif
+endif
 endif
diff --git a/arch/arm/mach-sunxi/dram_sun60i_a733.c b/arch/arm/mach-sunxi/dram_sun60i_a733.c
new file mode 100644
index 00000000000..e228c7fe1d8
--- /dev/null
+++ b/arch/arm/mach-sunxi/dram_sun60i_a733.c
@@ -0,0 +1,1303 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Allwinner sun60i A733 / T736 DRAM Controller and Synopsys DDR PHY driver
+ *
+ * (C) Copyright 2026 Alastair D'Silva <alastair@d-silva.org>
+ */
+
+#include <hang.h>
+#include <init.h>
+#include <log.h>
+#include <stdio.h>
+#include <asm/arch/dram.h>
+#include <asm/barriers.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+#include <linux/build_bug.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/sizes.h>
+#include <linux/types.h>
+
+#include "pmu/sunxi_pmu_abi.h"
+
+#define CCU_PLL_DDR_CTRL_REG		0x02002020UL
+#define CCU_DRAM0_CLK_REG		0x02002c00UL
+#define UMCTL2_CH0_BASE			0x0a110000UL
+#define UMCTL2_MSTR_OFFSET		0x000UL
+#define UMCTL2_MSTR_LPDDR5		BIT(19)
+
+#ifdef CONFIG_XPL_BUILD
+#include "dram_sun60i_a733_pmu_fw.h"
+
+#ifdef SUN60I_A733_PMU_FW_MISSING
+unsigned long sunxi_dram_init(void)
+{
+	(void)sun60i_a733_pmu_imem;
+	pr_err("DRAM: ARC PMU firmware missing\n");
+	return 0;
+}
+#else
+#include "dram_sun60i_a733_tables.h"
+
+/* ========================================================================= */
+/* 1. Register Sequencer & Aperture Boundaries                               */
+/* ========================================================================= */
+
+#define SUNXI_MMIO_MIN_ADDR		0x02000000UL
+#define SUNXI_MMIO_MAX_ADDR		0x40000000UL
+
+#define CCU_PLL_DDR_LOCK_BIT		BIT(28)
+#define CCU_PLL_DDR_OUTPUT_GATE		BIT(27)
+#define CCU_MBUS_CLK_REG		0x02002580UL
+#define CCU_MBUS_BGR_REG		0x02002584UL
+#define CCU_DRAM_MUX_CLK_REG		0x02002588UL
+#define CCU_DRAM0_BGR_REG		0x02002c0cUL
+
+#define PRCM_MEM_ISOLATION_REG		0x07010250UL
+
+#define UMCTL2_CH0_APERTURE_BASE	0x0a100000UL
+#define UMCTL2_CH0_APERTURE_END		0x0a500000UL
+#define UMCTL2_CH1_BASE			0x0a510000UL
+#define UMCTL2_CH_STRIDE		0x00400000UL
+#define UMCTL2_STAT_OFFSET		0x014UL
+#define UMCTL2_MRCTRL0_OFFSET		0x080UL
+#define UMCTL2_MRCTRL1_OFFSET		0x084UL
+#define UMCTL2_PWRCTL_OFFSET		0x180UL
+#define UMCTL2_SWCTL_OFFSET		0xc80UL
+#define UMCTL2_SWSTAT_OFFSET		0xc84UL
+#define UMCTL2_DERATEINT_OFFSET		0xc9cUL
+
+#define UMCTL2_MSTR_RANKS_SHIFT		24
+#define UMCTL2_MSTR_RANKS_MASK		0x0fU
+
+#define DRAMC_SYS_CFG_REG		0x0a020010UL
+#define DRAMC_CH_EN_REG			0x0a020014UL
+#define DRAMC_MR_DATA_CH0_REG		0x0a02002cUL
+#define DRAMC_MR_DATA_CH1_REG		0x0a020040UL
+#define DRAMC_CH0_PORT_CFG_REG		0x0a02021cUL
+#define DRAMC_CH0_PORT_EN_REG		0x0a020220UL
+#define DRAMC_CH1_PORT_CFG_REG		0x0a020224UL
+#define DRAMC_CH1_PORT_EN_REG		0x0a020228UL
+
+/* ========================================================================= */
+/* 2. Synopsys PHY & Controller Apertures                                    */
+/* ========================================================================= */
+
+#define SUNXI_UMCTL2_CH0_STAT		(UMCTL2_CH0_BASE + UMCTL2_STAT_OFFSET)
+#define SUNXI_UMCTL2_CH1_STAT		(UMCTL2_CH1_BASE + UMCTL2_STAT_OFFSET)
+
+#define SUNXI_PRCM_CH0_DMC_CLK_REG	0x07010310UL
+#define SUNXI_PRCM_CH0_DMC_FEAT_REG	0x07010314UL
+#define SUNXI_PRCM_CH1_DMC_CLK_REG	0x07410310UL
+#define SUNXI_PRCM_CH1_DMC_FEAT_REG	0x07410314UL
+
+#define SUNXI_DRAM_PHY_APB_BASE		0x0a900000UL
+#define SUNXI_DRAM_PHY_APB_END		0x0ab00000UL
+#define PHY_SLICE_STRIDE		0x2000UL
+#define PHY_LANE_STRIDE			0x0200UL
+
+#define PHY_DBYTE0_BASE			0x0a920000UL
+#define PHY_DBYTE_CLK_GATE_OFF		0x001eUL
+#define PHY_DBYTE0_DQ_SWIZZLE_BASE	0x0a920100UL
+#define PHY_DBYTE_RX_EN_OFF		0x0112UL
+#define PHY_DBYTE_TX_EN_OFF		0x0114UL
+#define PHY_DBYTE_COMP_EN_OFF		0x0116UL
+#define PHY_DBYTE_RX_BIAS_OFF		0x0118UL
+#define PHY_DBYTE_RFIFO_OFF		0x0146UL
+#define PHY_DBYTE_LCDL_OFF		0x0162UL
+#define PHY_DBYTE_STAT_OFF		0x016aUL
+
+#define PHY_PIE_PTR_LO_BASE		0x0a940248UL
+#define PHY_PIE_PTR_HI_BASE		0x0a940316UL
+#define PHY_AC0_SWIZZLE_BASE		0x0a960120UL
+#define PHY_PIE_ZERO_SRAM_BASE		0x0a982000UL
+#define PHY_PIE_INIT_SRAM_BASE		0x0a982010UL
+#define PHY_PIE_SEQ_SRAM_BASE		0x0a982710UL
+#define PHY_PIE_LANE_DELAY_BASE		0x0a9e0048UL
+#define PHY_PIE_LANE_DELAY_INIT		0x5a3cU
+#define PHY_ACSM_SRAM_BASE		0x0aa2005cUL
+#define PHY_PUB_POST_PMU_CFG_REG	0x0aa80100UL
+
+#ifdef DEBUG
+#define A733_DRAM_CH0_BASE		0x40000000UL
+#define A733_DRAM_CH1_BASE		0xc0000000UL
+#define A733_DRAM_TEST_WORDS		4096
+
+static const uintptr_t sparse_probe_addrs[] __section(".init.rodata") = {
+	0x40000000UL, /* Ch0 Base */
+	0x40800000UL, /* +8 MiB */
+	0x44000000UL, /* +64 MiB, FIT image load aperture */
+	0x4a000000UL, /* +160 MiB, U-Boot text base aperture */
+	0x50000000UL, /* +256 MiB */
+	0xc0000000UL, /* Ch1 Base */
+};
+#endif
+
+/* ========================================================================= */
+/* SECTION 1: Hardware Register Sequencer & State Polling                    */
+/* ========================================================================= */
+
+/**
+ * mctl_poll_reg32() - Poll a 32-bit MMIO register until masked bits match
+ * @addr: Physical address of status register to poll
+ * @mask: Bitmask to apply to the register value
+ * @expected: Expected masked value
+ * @timeout_us: Maximum poll iterations (1 us per iteration)
+ * @desc: Diagnostic description logged on timeout
+ * @trig_addr: Trigger register address logged on timeout
+ *
+ * Return: 0 on success, or -ETIMEDOUT on timeout.
+ */
+static int mctl_poll_reg32(uintptr_t addr, u32 mask, u32 expected,
+			   int timeout_us, const char *desc,
+			   uintptr_t trig_addr)
+{
+	for (; timeout_us > 0; timeout_us--) {
+		if ((readl((void __iomem *)addr) & mask) == expected)
+			return 0;
+		udelay(1);
+	}
+
+	pr_err("DRAM: %s timeout at 0x%08lx\n", desc,
+	       (unsigned long)trig_addr);
+	return -ETIMEDOUT;
+}
+
+/**
+ * mctl_sync_hardware_state() - Synchronize hardware state after a register write
+ * @addr: Physical MMIO address that was just written
+ * @val: 32-bit value that was written to @addr
+ *
+ * Polls hardware status registers or inserts required settling delays when
+ * specific control registers (PLL_DDR, uMCTL2 SWCTL/MRCTRL0/DFIMISC, or PRCM
+ * memory isolation) are written during table replay.
+ *
+ * Return: 0 on success, or negative errno on poll failure.
+ */
+static int mctl_sync_hardware_state(uintptr_t addr, u32 val)
+{
+	/* CCU PLL_DDR lock before output gate enable */
+	if (addr == CCU_PLL_DDR_CTRL_REG &&
+	    (val & 0xe0000000U) == 0xe0000000U &&
+	    !(val & CCU_PLL_DDR_OUTPUT_GATE)) {
+		udelay(20);
+		return mctl_poll_reg32(CCU_PLL_DDR_CTRL_REG, CCU_PLL_DDR_LOCK_BIT,
+				       CCU_PLL_DDR_LOCK_BIT, 100000,
+				       "PLL_DDR lock", addr);
+	}
+
+	/* uMCTL2 SWCTL -> SWSTAT quasi-dynamic register update ack */
+	if ((addr == UMCTL2_CH0_BASE + UMCTL2_SWCTL_OFFSET ||
+	     addr == UMCTL2_CH1_BASE + UMCTL2_SWCTL_OFFSET) && val == 1U) {
+		return mctl_poll_reg32(addr - UMCTL2_SWCTL_OFFSET + UMCTL2_SWSTAT_OFFSET,
+				       0x01U, 0x01U, 10000, "SWCTL handshake", addr);
+	}
+
+	/* uMCTL2 PWRCTL self-refresh exit to Normal Operating Mode */
+	if ((addr == UMCTL2_CH0_BASE + UMCTL2_PWRCTL_OFFSET ||
+	     addr == UMCTL2_CH1_BASE + UMCTL2_PWRCTL_OFFSET) && val == 0U) {
+		uintptr_t stat_addr = addr - UMCTL2_PWRCTL_OFFSET +
+				      UMCTL2_STAT_OFFSET;
+		int ret;
+
+		ret = mctl_poll_reg32(stat_addr, 0x03U << 4, 0U, 100000,
+				      "Self-refresh exit", addr);
+		if (ret)
+			return ret;
+		return mctl_poll_reg32(stat_addr, 0x03U, 0x01U, 100000,
+				       "Normal mode entry", addr);
+	}
+
+	/* uMCTL2 MRCTRL0 Mode Register command completion */
+	if ((addr == UMCTL2_CH0_BASE + UMCTL2_MRCTRL0_OFFSET ||
+	     addr == UMCTL2_CH1_BASE + UMCTL2_MRCTRL0_OFFSET) &&
+	    (val & BIT(31))) {
+		return mctl_poll_reg32(addr, BIT(31), 0U, 10000,
+				       "MR command trigger", addr);
+	}
+
+	/* PRCM memory isolation release settle delay */
+	if (addr == PRCM_MEM_ISOLATION_REG) {
+		mdelay(2);
+		return 0;
+	}
+
+	return 0;
+}
+
+/**
+ * mctl_write_single_reg() - Write a single MMIO register and synchronize state
+ * @addr: Physical MMIO address
+ * @val: Value to write (16-bit for DDR PHY APB, 32-bit otherwise)
+ */
+static int mctl_write_single_reg(uintptr_t addr, u32 val)
+{
+	if (addr < SUNXI_MMIO_MIN_ADDR || addr >= SUNXI_MMIO_MAX_ADDR)
+		return -EINVAL;
+
+	if (addr >= SUNXI_DRAM_PHY_APB_BASE && addr < SUNXI_DRAM_PHY_APB_END)
+		writew((u16)val, (void __iomem *)addr);
+	else
+		writel(val, (void __iomem *)addr);
+
+	return mctl_sync_hardware_state(addr, val);
+}
+
+/**
+ * mctl_write_regs() - Replay an array of width- and broadcast-tagged MMIO writes
+ * @regs: Pointer to array of struct sunxi_dram_reg descriptors
+ * @count: Number of descriptors in @regs
+ *
+ * Writes each 16- or 32-bit register entry (expanding PHY_BCAST_DBYTE,
+ * PHY_BCAST_AC, and PHY_BCAST_9LANE broadcast tags across the corresponding
+ * PHY slices and lanes) and invokes mctl_sync_hardware_state() after each write.
+ *
+ * Return: 0 on success, or negative errno on sync timeout.
+ */
+static int mctl_write_regs(const struct sunxi_dram_reg *regs, u32 count)
+{
+	u32 i;
+	int ret;
+
+	if (!regs || !count)
+		return 0;
+
+	for (i = 0; i < count; i++) {
+		u32 raw_addr = regs[i].addr;
+		uintptr_t base = raw_addr & ~PHY_BCAST_MASK;
+		u32 val = regs[i].val;
+		unsigned int s, l;
+
+		if (raw_addr & PHY_BCAST_9LANE) {
+			for (s = 0; s < 4; s++) {
+				for (l = 0; l < 9; l++) {
+					ret = mctl_write_single_reg(base + s * PHY_SLICE_STRIDE +
+								    l * PHY_LANE_STRIDE, val);
+					if (ret)
+						return ret;
+				}
+			}
+		} else if (raw_addr & PHY_BCAST_DBYTE) {
+			for (s = 0; s < 4; s++) {
+				ret = mctl_write_single_reg(base + s * PHY_SLICE_STRIDE, val);
+				if (ret)
+					return ret;
+			}
+		} else if (raw_addr & PHY_BCAST_AC) {
+			for (s = 0; s < 2; s++) {
+				ret = mctl_write_single_reg(base + s * PHY_SLICE_STRIDE, val);
+				if (ret)
+					return ret;
+			}
+		} else {
+			ret = mctl_write_single_reg(base, val);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * mctl_write_regs_offset() - Replay an array of MMIO register writes with channel offset
+ * @regs: Pointer to array of struct sunxi_dram_reg descriptors
+ * @count: Number of descriptors in @regs
+ * @ch_offset: Address offset added to controller registers (0x0a100000..0x0a4fffff)
+ * @rank_mask: Active rank bitmask (0x03 for dual-rank, 0x01 for single-rank)
+ *
+ * Writes each register entry, adding @ch_offset to uMCTL2/port addresses while
+ * leaving global PHY/CCU addresses unchanged, and invokes
+ * mctl_sync_hardware_state() after each write.
+ *
+ * Return: 0 on success, or negative errno on sync timeout.
+ */
+static int mctl_write_regs_offset(const struct sunxi_dram_reg *regs, u32 count,
+				  uintptr_t ch_offset, u8 rank_mask)
+{
+	u32 i;
+	int ret;
+
+	for (i = 0; i < count; i++) {
+		uintptr_t addr = regs[i].addr;
+		u32 val = regs[i].val;
+
+		if (addr == UMCTL2_CH0_BASE + UMCTL2_MSTR_OFFSET)
+			val = (val & ~(UMCTL2_MSTR_RANKS_MASK << UMCTL2_MSTR_RANKS_SHIFT)) |
+			      ((u32)rank_mask << UMCTL2_MSTR_RANKS_SHIFT);
+		else if (addr == UMCTL2_CH0_BASE + UMCTL2_DERATEINT_OFFSET)
+			val = ((u32)rank_mask << 8) | rank_mask;
+
+		if (addr >= UMCTL2_CH0_APERTURE_BASE &&
+		    addr < UMCTL2_CH0_APERTURE_END)
+			addr += ch_offset;
+
+		if (addr >= SUNXI_DRAM_PHY_APB_BASE &&
+		    addr < SUNXI_DRAM_PHY_APB_END)
+			writew((u16)val, (void __iomem *)addr);
+		else
+			writel(val, (void __iomem *)addr);
+
+		ret = mctl_sync_hardware_state(addr, val);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+/**
+ * mctl_write_mr_all() - Issue a JEDEC Mode Register Write across both channels and ranks
+ * @mr_type: MRCTRL0 command type (0 for MRW, 1 for VRCG/FSP control)
+ * @mr_addr: Mode Register number (e.g. 14, 15, 16)
+ * @mr_val: 8-bit Mode Register payload
+ *
+ * Writes @mr_val to @mr_addr on active ranks of both Channel 0 and
+ * Channel 1 via uMCTL2 MRCTRL0/MRCTRL1 and polls for completion.
+ *
+ * Return: 0 on success, or negative errno on sync timeout.
+ */
+static int mctl_write_mr_all(u32 mr_type, u8 mr_addr, u8 mr_val)
+{
+	unsigned int ch, rank;
+	int ret;
+
+	for (ch = 0; ch < 2; ch++) {
+		uintptr_t base = (ch == 0) ? UMCTL2_CH0_BASE : UMCTL2_CH1_BASE;
+		uintptr_t mrctrl0 = base + UMCTL2_MRCTRL0_OFFSET;
+		uintptr_t mrctrl1 = base + UMCTL2_MRCTRL1_OFFSET;
+		u32 ch_mstr = readl((void __iomem *)(base + UMCTL2_MSTR_OFFSET));
+		u32 rank_mask = (ch_mstr >> UMCTL2_MSTR_RANKS_SHIFT) &
+				UMCTL2_MSTR_RANKS_MASK;
+
+		for (rank = 0; rank < 2; rank++) {
+			u32 ctrl0 = (BIT(rank) << 4) | (mr_type & 1U);
+			u32 ctrl1 = ((u32)mr_addr << 8) | mr_val;
+
+			if (!(rank_mask & BIT(rank)))
+				continue;
+
+			writel(ctrl0, (void __iomem *)mrctrl0);
+			writel(ctrl1, (void __iomem *)mrctrl1);
+			writel(ctrl0 | BIT(31), (void __iomem *)mrctrl0);
+			ret = mctl_sync_hardware_state(mrctrl0, ctrl0 | BIT(31));
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+/* ========================================================================= */
+/* SECTION 2: Synopsys DDR PHY & PMU Initializer                             */
+/* ========================================================================= */
+
+/**
+ * mctl_pmu_load_sram() - Load a 16-bit image into a 64 KiB PMU SRAM aperture
+ * @sram_base: Physical base address of the PMU IMEM or DMEM aperture
+ * @data: Pointer to array of 16-bit halfwords to load
+ * @count: Number of halfwords in @data
+ *
+ * Switches the PHY APB mux to host access and writes all 32,768 halfwords
+ * (64 KiB) of the target ICCM or DCCM SRAM to initialize hardware parity bits
+ * and zero any trailing words.
+ */
+static void mctl_pmu_load_sram(uintptr_t sram_base, const u16 *data,
+			       size_t count)
+{
+	size_t i;
+
+	writew(0x0000,
+	       (void __iomem *)(SUNXI_DRAM_PHY_CTRL_BASE + PMU_REG_APB_MUX));
+
+	for (i = 0; i < count; i++)
+		writew(data[i], (void __iomem *)(sram_base + i * 2));
+	for (; i < 0x8000; i++)
+		writew(0x0000, (void __iomem *)(sram_base + i * 2));
+}
+
+/**
+ * mctl_pmu_log_error() - Log PMU training failure diagnostics from DMEM
+ * @msg: Error summary prefix string
+ * @status: 32-bit PMU status word read from the mailbox registers
+ *
+ * Stalls the ARC core, switches the PHY APB mux back to host ARM access, and
+ * reads the active training mode and assertion code from DMEM.
+ */
+static void mctl_pmu_log_error(const char *msg, u32 status)
+{
+	uintptr_t ctrl = SUNXI_DRAM_PHY_CTRL_BASE;
+	uintptr_t dmem = SUNXI_DRAM_PHY_DMEM_BASE;
+	size_t assert_off = offsetof(struct pmu_message_block, assert_code);
+	size_t mode_off = offsetof(struct pmu_message_block, train_mode);
+	u32 assert_code;
+	u16 mode;
+
+	writew(0x0001, (void __iomem *)(ctrl + PMU_REG_RESET));
+	writew(0x0000, (void __iomem *)(ctrl + PMU_REG_APB_MUX));
+
+	assert_code = (u32)readw((void __iomem *)(dmem + assert_off)) |
+		      ((u32)readw((void __iomem *)(dmem + assert_off + 2)) << 16);
+	mode = readw((void __iomem *)(dmem + mode_off));
+
+	pr_err("DRAM: %s, status = 0x%08x (mode=0x%04x, assert=0x%08x)\n",
+	       msg, status, mode, assert_code);
+}
+
+/**
+ * mctl_pmu_run_training() - Hand over APB, trigger ARC EM4 PMU, and await completion
+ * @log_err: Log training failures at error level (false for speculative probes)
+ *
+ * Description: Switches the PHY APB mux to the PMU microsequencer, releases
+ * the ARC core from reset, and services the 4-phase Synopsys mailbox handshake
+ * across any intermediate streaming messages until terminal completion or
+ * fatal error.
+ *
+ * Return: 0 on successful training completion, or negative errno on failure.
+ */
+static int mctl_pmu_run_training(bool log_err)
+{
+	uintptr_t ctrl = SUNXI_DRAM_PHY_CTRL_BASE;
+	u32 status = 0;
+	int timeout;
+
+	/* Hand over APB to PMU Microsequencer and release ARC reset */
+	writew(0x0001, (void __iomem *)(ctrl + PMU_REG_APB_MUX));
+	writew(0x0009, (void __iomem *)(ctrl + PMU_REG_RESET));
+	writew(0x0001, (void __iomem *)(ctrl + PMU_REG_RESET));
+	writew(0x0001, (void __iomem *)(ctrl + PMU_REG_RESET));
+	writew(0x0000, (void __iomem *)(ctrl + PMU_REG_RESET));
+	writew(0x0001, (void __iomem *)(ctrl + PMU_REG_HANDOFF_1));
+	writew(0x0001, (void __iomem *)(ctrl + PMU_REG_MAILBOX_INT));
+
+	/* Wait for training to begin (bit 0 of PMU_REG_POLL_STAT == 1) */
+	for (timeout = 100000; timeout > 0; timeout--) {
+		if (readw((void __iomem *)(ctrl + PMU_REG_POLL_STAT)) & 0x01)
+			break;
+		udelay(1);
+	}
+	if (!timeout) {
+		if (log_err)
+			mctl_pmu_log_error("PMU training start timeout", 0);
+		else
+			goto err_stall;
+		return -ETIMEDOUT;
+	}
+
+	/* Service 4-phase PMU mailbox messages until terminal completion */
+	timeout = 5000000;
+	while (timeout > 0) {
+		if (!(readw((void __iomem *)(ctrl + PMU_REG_POLL_STAT)) & 0x01)) {
+			status = (u32)readw((void __iomem *)(ctrl + PMU_REG_STATUS_LO)) |
+				 ((u32)readw((void __iomem *)(ctrl + PMU_REG_STATUS_HI)) << 16);
+
+			/* Acknowledge message (DctWriteProt = 0) and await release */
+			writew(0x0000, (void __iomem *)(ctrl + PMU_REG_HANDOFF_1));
+			while (!(readw((void __iomem *)(ctrl + PMU_REG_POLL_STAT)) & 0x01)) {
+				if (--timeout <= 0) {
+					if (log_err)
+						mctl_pmu_log_error("PMU mailbox ack timeout",
+								   status);
+					else
+						goto err_stall;
+					return -ETIMEDOUT;
+				}
+				udelay(1);
+			}
+			writew(0x0001, (void __iomem *)(ctrl + PMU_REG_HANDOFF_1));
+
+			if (status == PMU_STATUS_SUCCESS) {
+				writew(0x0001, (void __iomem *)(ctrl + PMU_REG_RESET));
+				return 0;
+			}
+			if (status == PMU_STATUS_FATAL_ERROR) {
+				if (log_err)
+					mctl_pmu_log_error("PMU training failed",
+							   status);
+				else
+					goto err_stall;
+				return -EIO;
+			}
+			debug("DRAM: PMU mailbox msg 0x%08x\n", status);
+			udelay(1);
+			timeout--;
+			continue;
+		}
+		udelay(1);
+		timeout--;
+	}
+
+	if (log_err)
+		mctl_pmu_log_error("PMU training completion timeout", 0);
+err_stall:
+	if (!log_err) {
+		writew(0x0001, (void __iomem *)(ctrl + PMU_REG_RESET));
+		writew(0x0000, (void __iomem *)(ctrl + PMU_REG_APB_MUX));
+	}
+	return (status == PMU_STATUS_FATAL_ERROR) ? -EIO : -ETIMEDOUT;
+}
+
+/**
+ * mctl_phy_dump_slices() - Dump trained PHY slice delay registers for debug
+ *
+ * Temporarily switches the PHY APB mux to host access, logs key trained delay
+ * registers across all four data slices, and restores the mux state.
+ */
+static void mctl_phy_dump_slices(void)
+{
+#ifdef DEBUG
+	uintptr_t ctrl = SUNXI_DRAM_PHY_CTRL_BASE;
+	unsigned int i;
+
+	writew(0x0000, (void __iomem *)(ctrl + PMU_REG_APB_MUX));
+	udelay(10);
+	for (i = 0; i < 4; i++) {
+		uintptr_t base = PHY_DBYTE0_BASE + (i * PHY_SLICE_STRIDE);
+
+		debug("Slice %u: CLK1E=0x%04x RxEn=0x%04x TxEn=0x%04x CompEn=0x%04x RxBias=0x%04x LCDL162=0x%04x STAT16A=0x%04x RFIFO=0x%04x\n",
+		      i,
+		      readw((void __iomem *)(base + PHY_DBYTE_CLK_GATE_OFF)),
+		      readw((void __iomem *)(base + PHY_DBYTE_RX_EN_OFF)),
+		      readw((void __iomem *)(base + PHY_DBYTE_TX_EN_OFF)),
+		      readw((void __iomem *)(base + PHY_DBYTE_COMP_EN_OFF)),
+		      readw((void __iomem *)(base + PHY_DBYTE_RX_BIAS_OFF)),
+		      readw((void __iomem *)(base + PHY_DBYTE_LCDL_OFF)),
+		      readw((void __iomem *)(base + PHY_DBYTE_STAT_OFF)),
+		      readw((void __iomem *)(base + PHY_DBYTE_RFIFO_OFF)));
+	}
+	writew(0x0001, (void __iomem *)(ctrl + PMU_REG_APB_MUX));
+	udelay(10);
+#endif
+}
+
+/**
+ * mctl_umctl2_wait_normal_mode() - Wait for a uMCTL2 channel to enter Normal Mode
+ * @stat_reg: Physical address of the channel's UMCTL2 STAT register
+ * @ch: Channel index (0 or 1) for error reporting
+ *
+ * Return: 0 when operating_mode[1:0] == 0x01, or -ETIMEDOUT on timeout.
+ */
+static int mctl_umctl2_wait_normal_mode(uintptr_t stat_reg, unsigned int ch)
+{
+	int timeout;
+
+	for (timeout = 100000; timeout > 0; timeout--) {
+		if ((readl((void __iomem *)stat_reg) & 0x03U) == 0x01U)
+			return 0;
+		udelay(1);
+	}
+
+	pr_err("DRAM: Channel %u uMCTL2 failed to enter Normal Mode\n", ch);
+	return -ETIMEDOUT;
+}
+
+/**
+ * mctl_phy_load_pin_swizzle() - Program AC and DBYTE pin swizzle maps into the PHY
+ *
+ * Programs the board-specific CA0..CA6 pin permutation into AC slices 0..1
+ * and the DQ0..DQ7 pin permutation into DBYTE slices 0..3 prior to PMU
+ * training execution.
+ */
+static void mctl_phy_load_pin_swizzle(void)
+{
+	uintptr_t ctrl = SUNXI_DRAM_PHY_CTRL_BASE;
+	unsigned int ac, slice, pin;
+
+	if (!IS_ENABLED(CONFIG_DRAM_SUN60I_A733_PIN_SWIZZLE))
+		return;
+
+	writew(0x0001, (void __iomem *)(ctrl + PMU_REG_APB_MUX));
+	writew(0x0000, (void __iomem *)(ctrl + PMU_REG_APB_MUX));
+
+	for (ac = 0; ac < 2; ac++) {
+		uintptr_t ac_base = PHY_AC0_SWIZZLE_BASE +
+				    ac * PHY_SLICE_STRIDE;
+
+		for (pin = 0; pin < 7; pin++)
+			writew(dram_ac_pin_swizzle[ac][pin],
+			       (void __iomem *)(ac_base + pin * 2));
+	}
+
+	for (pin = 0; pin < 8; pin++) {
+		for (slice = 0; slice < 4; slice++) {
+			uintptr_t dq_addr = PHY_DBYTE0_DQ_SWIZZLE_BASE +
+					    slice * PHY_SLICE_STRIDE + pin * 2;
+
+			writew(dram_dq_pin_swizzle[slice][pin],
+			       (void __iomem *)dq_addr);
+		}
+	}
+
+	writew(0x0001, (void __iomem *)(ctrl + PMU_REG_APB_MUX));
+}
+
+/**
+ * mctl_load_pie_table() - Stream sparse non-zero entries into a PIE SRAM window
+ * @base: Physical base address of the target PIE SRAM aperture
+ * @total_words: Total number of 16-bit halfwords in the aperture
+ * @words: Ordered array of sparse non-zero (offset, value) entries
+ * @num_words: Number of entries in @words
+ *
+ * Writes @total_words consecutive 16-bit halfwords starting at @base,
+ * inserting non-zero values from @words at their matching byte offsets and
+ * zero-filling all other locations.
+ */
+static void mctl_load_pie_table(uintptr_t base, u32 total_words,
+				const struct sunxi_pie_word *words,
+				size_t num_words)
+{
+	size_t w = 0;
+	u32 i;
+
+	for (i = 0; i < total_words; i++) {
+		u16 byte_off = (u16)(i * 2);
+		u16 val = 0x0000;
+
+		if (w < num_words && words[w].off == byte_off) {
+			val = words[w].val;
+			w++;
+		}
+
+		writew(val, (void __iomem *)(base + byte_off));
+	}
+}
+
+/**
+ * mctl_apply_pie_config() - Program PIE sequencer, ACSM SRAM, and PHY CSRs
+ *
+ * Initializes the PHY Init Engine (PIE) instruction tables, streams the ACSM
+ * command sequence SRAM image, programs the FSP pointer tables and lane
+ * calibration registers, and triggers the post-training PIE state machine.
+ */
+static int mctl_apply_pie_config(void)
+{
+	unsigned int i, lane, reg;
+	int ret;
+
+	ret = mctl_write_regs(dram_pie_head_regs,
+			      ARRAY_SIZE(dram_pie_head_regs));
+	if (ret)
+		return ret;
+	mctl_load_pie_table(PHY_PIE_INIT_SRAM_BASE, 176, dram_pie_init,
+			    ARRAY_SIZE(dram_pie_init));
+	ret = mctl_write_regs(dram_pie_phy_setup_regs,
+			      ARRAY_SIZE(dram_pie_phy_setup_regs));
+	if (ret)
+		return ret;
+	mctl_load_pie_table(PHY_PIE_ZERO_SRAM_BASE, 8, NULL, 0);
+	mctl_load_pie_table(PHY_PIE_SEQ_SRAM_BASE, 2256, dram_pie_seq,
+			    ARRAY_SIZE(dram_pie_seq));
+
+	for (i = 0; i < ARRAY_SIZE(dram_acsm_sram); i++)
+		writew(dram_acsm_sram[i],
+		       (void __iomem *)(PHY_ACSM_SRAM_BASE + i * 2));
+
+	ret = mctl_write_regs(dram_acsm_ctrl_regs,
+			      ARRAY_SIZE(dram_acsm_ctrl_regs));
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(dram_pie_ptrs) / 2; i++) {
+		writew(dram_pie_ptrs[i * 2],
+		       (void __iomem *)(PHY_PIE_PTR_LO_BASE + i * 2));
+		writew(dram_pie_ptrs[i * 2 + 1],
+		       (void __iomem *)(PHY_PIE_PTR_HI_BASE + i * 2));
+	}
+
+	ret = mctl_write_regs(dram_pie_patch_regs,
+			      ARRAY_SIZE(dram_pie_patch_regs));
+	if (ret)
+		return ret;
+	mctl_load_pie_table(PHY_PIE_INIT_SRAM_BASE, 176, dram_pie_init,
+			    ARRAY_SIZE(dram_pie_init));
+	ret = mctl_write_regs(dram_pie_pre_lane_regs,
+			      ARRAY_SIZE(dram_pie_pre_lane_regs));
+	if (ret)
+		return ret;
+
+	for (lane = 0; lane < 9; lane++) {
+		uintptr_t lane_base = PHY_PIE_LANE_DELAY_BASE +
+				      lane * PHY_LANE_STRIDE;
+
+		for (reg = 0; reg < 8; reg++)
+			writew(PHY_PIE_LANE_DELAY_INIT,
+			       (void __iomem *)(lane_base + reg * 2));
+	}
+
+	return mctl_write_regs(dram_pie_tail_regs,
+			       ARRAY_SIZE(dram_pie_tail_regs));
+}
+
+/**
+ * mctl_apply_post_pmu_config() - Apply post-PMU uMCTL2 timing, QoS, and MR handoff
+ * @rank_mask: Active rank bitmask (0x03 for dual-rank, 0x01 for single-rank)
+ *
+ * Programs the post-training uMCTL2 timing updates across Channel 0 and
+ * Channel 1, configures MBUS/RAXI QoS ports, and issues the final LPDDR5 Mode
+ * Register handoff sequence (MR16, MR14, MR15) across all ranks.
+ *
+ * Return: 0 on success, or negative errno on sync timeout.
+ */
+static int mctl_apply_post_pmu_config(u8 rank_mask)
+{
+	uintptr_t ctrl = SUNXI_DRAM_PHY_CTRL_BASE;
+	int ret;
+
+	ret = mctl_write_regs_offset(dram_post_pmu_ch_regs,
+				     ARRAY_SIZE(dram_post_pmu_ch_regs),
+				     0x00000000UL, rank_mask);
+	if (ret)
+		return ret;
+
+	writew(0x0000, (void __iomem *)(ctrl + PMU_REG_APB_MUX));
+	writew(0x0003, (void __iomem *)PHY_PUB_POST_PMU_CFG_REG);
+	writew(0x0000, (void __iomem *)PHY_PUB_POST_PMU_CFG_REG);
+	writew(0x0001, (void __iomem *)(ctrl + PMU_REG_APB_MUX));
+
+	ret = mctl_write_regs_offset(dram_post_pmu_ch_regs,
+				     ARRAY_SIZE(dram_post_pmu_ch_regs),
+				     UMCTL2_CH_STRIDE, rank_mask);
+	if (ret)
+		return ret;
+
+	ret = mctl_write_regs(dram_post_pmu_tail_regs,
+			      ARRAY_SIZE(dram_post_pmu_tail_regs));
+	if (ret)
+		return ret;
+
+	writew(0x0000, (void __iomem *)(ctrl + PMU_REG_APB_MUX));
+	ret = mctl_write_mr_all(0U, 16, 0x05);
+	if (ret)
+		return ret;
+	ret = mctl_write_mr_all(1U, 14, 0x00);
+	if (ret)
+		return ret;
+	ret = mctl_write_mr_all(1U, 15, 0x00);
+	if (ret)
+		return ret;
+	ret = mctl_write_mr_all(0U, 16, 0x04);
+	if (ret)
+		return ret;
+	writew(0x0001, (void __iomem *)(ctrl + PMU_REG_APB_MUX));
+
+	return 0;
+}
+
+/**
+ * mctl_ccu_init() - Configure CCU PLL_DDR, MBUS, DRAMC ports, and PRCM isolation
+ *
+ * Resets and ungates the DRAM0 and MBUS bus interfaces, locks PLL_DDR at
+ * 1800 MHz (3600 MT/s LPDDR5 WCK), enables dual-channel DRAMC AXI ports, and
+ * releases PRCM DRAM power isolation.
+ *
+ * Return: 0 on success, or negative errno on sync timeout.
+ */
+static int mctl_ccu_init(void)
+{
+	u32 pll_n = clamp((u32)CONFIG_DRAM_CLK / 24U, 1U, 256U) - 1U;
+	u32 n_bits = pll_n << 8;
+	int ret;
+
+	/* Reset MBUS and DRAM0 bus gates before reconfiguring PLL_DDR */
+	writel(0x08000000, (void __iomem *)CCU_DRAM_MUX_CLK_REG);
+	writel(0x00000000, (void __iomem *)CCU_MBUS_BGR_REG);
+	writel(0x00000000, (void __iomem *)CCU_DRAM0_BGR_REG);
+	writel(0x00010000, (void __iomem *)CCU_DRAM0_BGR_REG);
+	writel(0x00010001, (void __iomem *)CCU_DRAM0_BGR_REG);
+
+	writel(0x00000100, (void __iomem *)DRAMC_SYS_CFG_REG);
+	writel(0x00002600, (void __iomem *)DRAMC_SYS_CFG_REG);
+
+	/* Program PLL_DDR (24 MHz * (N + 1)), poll lock, then ungate */
+	writel(0x10000000, (void __iomem *)CCU_PLL_DDR_CTRL_REG);
+	writel(0x08000000, (void __iomem *)CCU_DRAM0_CLK_REG);
+	writel(0x11000000U | n_bits, (void __iomem *)CCU_PLL_DDR_CTRL_REG);
+	writel(0xd1000000U | n_bits, (void __iomem *)CCU_PLL_DDR_CTRL_REG);
+	ret = mctl_write_single_reg(CCU_PLL_DDR_CTRL_REG, 0xf1000000U | n_bits);
+	if (ret)
+		return ret;
+	writel(0xf9000000U | n_bits, (void __iomem *)CCU_PLL_DDR_CTRL_REG);
+
+	/* Enable DRAM0 and MBUS clocks */
+	writel(0x08000003, (void __iomem *)CCU_DRAM0_CLK_REG);
+	writel(0x89000000, (void __iomem *)CCU_DRAM_MUX_CLK_REG);
+	writel(0x00010000, (void __iomem *)CCU_MBUS_BGR_REG);
+	writel(0x00010001, (void __iomem *)CCU_MBUS_BGR_REG);
+	writel(0xcb000000, (void __iomem *)CCU_MBUS_CLK_REG);
+	writel(0x88000003, (void __iomem *)CCU_DRAM0_CLK_REG);
+
+	/* Enable dual-channel DRAMC and AXI host ports */
+	writel(0x00002728, (void __iomem *)DRAMC_SYS_CFG_REG);
+	writel(0x00000003, (void __iomem *)DRAMC_CH_EN_REG);
+	writel(0x00000103, (void __iomem *)DRAMC_CH0_PORT_CFG_REG);
+	writel(0x000013ff, (void __iomem *)DRAMC_CH0_PORT_EN_REG);
+	writel(0x00000103, (void __iomem *)DRAMC_CH1_PORT_CFG_REG);
+	writel(0x000013ff, (void __iomem *)DRAMC_CH1_PORT_EN_REG);
+	writel(0x00000107, (void __iomem *)DRAMC_CH0_PORT_CFG_REG);
+	writel(0x00000107, (void __iomem *)DRAMC_CH1_PORT_CFG_REG);
+
+	/* Release PRCM DRAM power isolation */
+	return mctl_write_single_reg(PRCM_MEM_ISOLATION_REG, 0x00000001);
+}
+
+/**
+ * mctl_pre_pmu_init() - Program CCU PLL_DDR, dual-channel uMCTL2, and PHY init
+ * @rank_mask: Active rank bitmask (0x03 for dual-rank, 0x01 for single-rank)
+ *
+ * Configures the CCU DDR PLL and MBUS clocks, replicates the uMCTL2 controller
+ * timing and QoS configuration across Channel 0 (0x0a100000) and Channel 1
+ * (0x0a500000), and programs the pre-PMU Synopsys PHY registers.
+ *
+ * Return: 0 on success, or negative errno on sync timeout.
+ */
+static int mctl_pre_pmu_init(u8 rank_mask)
+{
+	int ret;
+
+	ret = mctl_ccu_init();
+	if (ret)
+		return ret;
+	ret = mctl_write_regs_offset(dram_umctl2_ch_regs,
+				     ARRAY_SIZE(dram_umctl2_ch_regs),
+				     0x00000000UL, rank_mask);
+	if (ret)
+		return ret;
+	ret = mctl_write_regs_offset(dram_umctl2_ch_regs,
+				     ARRAY_SIZE(dram_umctl2_ch_regs),
+				     UMCTL2_CH_STRIDE, rank_mask);
+	if (ret)
+		return ret;
+	return mctl_write_regs(dram_phy_init_regs, ARRAY_SIZE(dram_phy_init_regs));
+}
+
+/**
+ * mctl_phy_init() - Initialize the Synopsys DDR PHY and run ARC EM4 PMU training
+ * @rank_mask: Active rank bitmask (0x03 for dual-rank, 0x01 for single-rank)
+ *
+ * Description: Programs pre-training controller and PHY registers, loads the
+ * ARC EM4 PMU firmware into IMEM and training parameter block into DMEM, runs
+ * the PMU microsequencer training handshake, applies post-training PIE and
+ * uMCTL2 configuration, and waits for both channels to enter Normal Mode.
+ *
+ * Return: 0 on successful training and normal mode entry, or negative errno.
+ */
+static int mctl_phy_init(u8 rank_mask, bool log_err)
+{
+	struct pmu_message_block msg = dram_pmu_msg_block;
+	int ret;
+
+	BUILD_BUG_ON(sizeof(msg) != 0x106);
+	BUILD_BUG_ON(ARRAY_SIZE(sun60i_a733_pmu_imem) > 0x8000);
+	BUILD_BUG_ON(CONFIG_DRAM_CLK % 24 != 0);
+
+	msg.dram_rate_mts = clamp((u32)CONFIG_DRAM_CLK / 24U, 1U, 256U) * 48U;
+	msg.ch0_rank_en = rank_mask;
+	msg.ch1_rank_en = rank_mask;
+	if (!IS_ENABLED(CONFIG_DRAM_SUN60I_A733_PIN_SWIZZLE))
+		msg.dq_swap_en = 0;
+
+	ret = mctl_pre_pmu_init(rank_mask);
+	if (ret)
+		return ret;
+
+	mctl_pmu_load_sram(SUNXI_DRAM_PHY_IMEM_BASE, sun60i_a733_pmu_imem,
+			   ARRAY_SIZE(sun60i_a733_pmu_imem));
+
+	ret = mctl_write_regs(dram_phy_pre_dmem_regs,
+			      ARRAY_SIZE(dram_phy_pre_dmem_regs));
+	if (ret)
+		return ret;
+	mctl_pmu_load_sram(SUNXI_DRAM_PHY_DMEM_BASE,
+			   (const u16 *)&msg,
+			   sizeof(msg) / sizeof(u16));
+
+	mctl_phy_load_pin_swizzle();
+
+	ret = mctl_pmu_run_training(log_err);
+	if (ret)
+		return ret;
+
+	writew(0x0000,
+	       (void __iomem *)(SUNXI_DRAM_PHY_CTRL_BASE + PMU_REG_APB_MUX));
+	ret = mctl_apply_pie_config();
+	if (ret)
+		return ret;
+	ret = mctl_apply_post_pmu_config(rank_mask);
+	if (ret)
+		return ret;
+	mctl_phy_dump_slices();
+
+	ret = mctl_umctl2_wait_normal_mode(SUNXI_UMCTL2_CH0_STAT, 0);
+	if (ret)
+		return ret;
+
+	return mctl_umctl2_wait_normal_mode(SUNXI_UMCTL2_CH1_STAT, 1);
+}
+
+/* ========================================================================= */
+/* SECTION 3: Memory Diagnostics & Dynamic Capacity Probing                  */
+/* ========================================================================= */
+
+/**
+ * mctl_read_mr() - Read a JEDEC Mode Register from an active LPDDR5 rank
+ * @ch: Controller channel index (0 or 1)
+ * @rank: Rank index within @ch (0 or 1)
+ * @mr_addr: Mode Register number (e.g. 5 for Manufacturer ID, 8 for Density/IO)
+ * @val: Pointer to store 8-bit Mode Register value
+ *
+ * Issues a Mode Register Read (MRR) command via the channel's uMCTL2 MRCTRL0
+ * and MRCTRL1 registers, waits for the MR transaction bit (bit 31) to clear,
+ * and extracts the 8-bit MR response from the DRAMC MR data register.
+ *
+ * Return: 0 on success, or -ETIMEDOUT on poll timeout.
+ */
+static int mctl_read_mr(unsigned int ch, unsigned int rank, u8 mr_addr, u8 *val)
+{
+	uintptr_t base = (ch == 0) ? UMCTL2_CH0_BASE : UMCTL2_CH1_BASE;
+	uintptr_t mr_data_reg = (ch == 0) ? DRAMC_MR_DATA_CH0_REG :
+					    DRAMC_MR_DATA_CH1_REG;
+	u32 rank_sel = BIT(rank) << 4;
+	u32 ctrl0 = rank_sel | 0x01U;
+	int ret;
+
+	writel(ctrl0, (void __iomem *)(base + UMCTL2_MRCTRL0_OFFSET));
+	writel((u32)mr_addr << 8,
+	       (void __iomem *)(base + UMCTL2_MRCTRL1_OFFSET));
+	writel(ctrl0 | BIT(31),
+	       (void __iomem *)(base + UMCTL2_MRCTRL0_OFFSET));
+	ret = mctl_poll_reg32(base + UMCTL2_MRCTRL0_OFFSET, BIT(31), 0U, 10000,
+			      "MR read", base + UMCTL2_MRCTRL0_OFFSET);
+	if (ret)
+		return ret;
+
+	udelay(10);
+
+	*val = (u8)((readl((void __iomem *)mr_data_reg) >> 8) & 0xffU);
+	return 0;
+}
+
+/**
+ * mctl_mr8_rank_size_mb() - Decode JEDEC LPDDR5 MR8 into rank capacity in MiB
+ * @mr8: Raw 8-bit JEDEC Mode Register 8 (JESD209-5) value
+ *
+ * Decodes the die density code (bits [5:2]) and I/O width (bits [7:6]) from
+ * MR8. Handles both power-of-two dies and non-power-of-two 3/4-density dies
+ * (such as 6 Gb, 12 Gb, and 24 Gb) as well as x8 byte-mode ranks where two
+ * dies populate a 16-bit channel.
+ *
+ * Return: Rank capacity in MiB, or 0 if @mr8 is invalid.
+ */
+static unsigned long mctl_mr8_rank_size_mb(u8 mr8)
+{
+	u8 type = mr8 & 0x03U;
+	u8 density_code = (mr8 >> 2) & 0x0fU;
+	u8 io_width = (mr8 >> 6) & 0x03U;
+	unsigned long die_mb;
+
+	if (mr8 == 0x00U || mr8 == 0xffU || type > 2U || io_width > 1U ||
+	    density_code > 8U)
+		return 0;
+
+	die_mb = ((density_code & 1U) ? 384UL : 256UL) <<
+		 (density_code >> 1);
+
+	/* In x8 byte mode (io_width == 1), two x8 dies form one 16-bit rank */
+	if (io_width == 1U)
+		die_mb <<= 1;
+
+	return die_mb;
+}
+
+/**
+ * sun60i_a733_get_dram_size() - Dynamically detect total physical DRAM capacity
+ *
+ * Description: Queries the active channel mask and uMCTL2 MSTR register to
+ * determine the active LPDDR5 ranks, then reads JEDEC Mode Register 8 (MR8)
+ * from each populated channel and rank to compute exact capacity (including
+ * non-power-of-two 3/4-density dies such as 6 Gb and 12 Gb). Falls back to
+ * U-Boot's standard get_ram_size() address-aliasing probe if MR8 probing
+ * yields 0.
+ *
+ * Return: Total detected DRAM capacity in bytes.
+ */
+static unsigned long sun60i_a733_get_dram_size(void)
+{
+	u32 ch0_mstr = readl((void __iomem *)(UMCTL2_CH0_BASE + UMCTL2_MSTR_OFFSET));
+	u32 ch_mask = readl((void __iomem *)DRAMC_CH_EN_REG) & 0x03U;
+
+	if (ch0_mstr & UMCTL2_MSTR_LPDDR5) {
+		unsigned long total_mb = 0;
+		unsigned int ch, rank;
+
+		if (!ch_mask)
+			ch_mask = 0x01U;
+
+		for (ch = 0; ch < 2; ch++) {
+			uintptr_t ch_base = (ch == 0) ? UMCTL2_CH0_BASE : UMCTL2_CH1_BASE;
+			u32 mstr = readl((void __iomem *)(ch_base + UMCTL2_MSTR_OFFSET));
+			u32 rank_mask = (mstr >> UMCTL2_MSTR_RANKS_SHIFT) &
+					UMCTL2_MSTR_RANKS_MASK;
+
+			if (!(ch_mask & BIT(ch)))
+				continue;
+
+			for (rank = 0; rank < 2; rank++) {
+				u8 mr8;
+
+				if (!(rank_mask & BIT(rank)))
+					continue;
+
+				if (mctl_read_mr(ch, rank, 8, &mr8) < 0)
+					continue;
+
+				total_mb += mctl_mr8_rank_size_mb(mr8);
+			}
+		}
+
+#ifdef DEBUG
+		{
+			u8 mr5 = 0, mr8_r0 = 0;
+
+			mctl_read_mr(0, 0, 5, &mr5);
+			mctl_read_mr(0, 0, 8, &mr8_r0);
+			debug("DRAM: MR5 mfg_id=0x%02x, MR8 rank0=0x%02x -> %lu MiB\n",
+			      mr5, mr8_r0, total_mb);
+		}
+#endif
+
+		if (total_mb > 0)
+			return total_mb << 20;
+	}
+
+	return get_ram_size((long *)CFG_SYS_SDRAM_BASE, SZ_4G);
+}
+
+#ifdef DEBUG
+/**
+ * a733_test_channel_aperture() - Verify a 16 KiB test window on one DRAM channel
+ * @base: Physical base address of the channel test aperture
+ * @seed: 32-bit pattern seed added to the word index
+ * @label: Channel label ("Ch0" or "Ch1") for error reporting
+ *
+ * Return: Number of word readback mismatches detected.
+ */
+static unsigned int a733_test_channel_aperture(uintptr_t base, u32 seed,
+					       const char *label)
+{
+	unsigned int errors = 0;
+	unsigned int i;
+
+	for (i = 0; i < A733_DRAM_TEST_WORDS; i++) {
+		u32 exp = seed + i;
+		u32 act = readl((void __iomem *)(base + (i * 4)));
+
+		if (act != exp) {
+			errors++;
+			if (errors <= 5)
+				printf("  %s mismatch @ 0x%08lx: exp 0x%08x, act 0x%08x\n",
+				       label, (unsigned long)(base + (i * 4)),
+				       exp, act);
+		}
+	}
+
+	return errors;
+}
+
+/**
+ * a733_dump_and_test_dram() - Run post-training dual-channel DRAM verification
+ * @dram_size: Total detected physical DRAM capacity in bytes
+ * @phase: Diagnostic phase label for debug/error logging
+ *
+ * Executes a sparse address probe across key physical apertures followed by
+ * a 16 KiB dual-channel pattern write and readback verification across
+ * Channel 0 (0x40000000) and Channel 1 (0xc0000000, if populated).
+ */
+static void a733_dump_and_test_dram(unsigned long dram_size, const char *phase)
+{
+	unsigned int probe_errors = 0;
+	unsigned int ch0_errors = 0, ch1_errors = 0;
+	unsigned int i;
+
+	debug("DRAM test [%s]: Starting memory diagnostics...\n",
+	      phase ? phase : "unspecified");
+
+	/* 1. Single-Word Sparse Probe Test across target addresses within bounds */
+	for (i = 0; i < ARRAY_SIZE(sparse_probe_addrs); i++) {
+		uintptr_t addr = sparse_probe_addrs[i];
+		u32 pat = 0xa5a50000U | ((u32)(addr >> 16) & 0xffffU);
+		u32 val;
+
+		if (addr >= CFG_SYS_SDRAM_BASE + dram_size)
+			continue;
+
+		writel(pat, (void __iomem *)addr);
+		dsb();
+		isb();
+
+		val = readl((void __iomem *)addr);
+		if (val != pat) {
+			probe_errors++;
+			printf("  Probe [0x%08lx]: FAIL (exp 0x%08x, act 0x%08x)\n",
+			       (unsigned long)addr, pat, val);
+		} else {
+			debug("  Probe [0x%08lx]: PASS (0x%08x)\n",
+			      (unsigned long)addr, val);
+		}
+	}
+
+	/* 2. Dual-Aperture Pattern Test (16 KiB Ch0 + 16 KiB Ch1 if in bounds) */
+	for (i = 0; i < A733_DRAM_TEST_WORDS; i++) {
+		writel(0x01234567U + i,
+		       (void __iomem *)(A733_DRAM_CH0_BASE + (i * 4)));
+		if (CFG_SYS_SDRAM_BASE + dram_size > A733_DRAM_CH1_BASE + (i * 4)) {
+			writel(0xfedcba98U + i,
+			       (void __iomem *)(A733_DRAM_CH1_BASE + (i * 4)));
+		}
+	}
+
+	dsb();
+	isb();
+
+	ch0_errors = a733_test_channel_aperture(A733_DRAM_CH0_BASE,
+						0x01234567U, "Ch0");
+	if (CFG_SYS_SDRAM_BASE + dram_size > A733_DRAM_CH1_BASE) {
+		ch1_errors = a733_test_channel_aperture(A733_DRAM_CH1_BASE,
+							0xfedcba98U, "Ch1");
+	}
+
+	if (probe_errors || ch0_errors || ch1_errors) {
+		printf("DRAM test [%s]: Probe errors=%u, Ch0 16KB errors=%u, Ch1 16KB errors=%u -> FAIL\n",
+		       phase ? phase : "unspecified",
+		       probe_errors, ch0_errors, ch1_errors);
+	} else {
+		debug("DRAM test [%s]: Probe errors=0, Ch0 16KB errors=0, Ch1 16KB errors=0 -> PASS\n",
+		      phase ? phase : "unspecified");
+	}
+}
+#else
+static inline void a733_dump_and_test_dram(unsigned long dram_size __maybe_unused,
+					   const char *phase __maybe_unused)
+{
+}
+#endif
+
+/* ========================================================================= */
+/* SECTION 4: DMC Clocks & Master DRAM Initialization                        */
+/* ========================================================================= */
+
+/**
+ * sun60i_a733_dmc_clock_setup() - Configure PRCM DMC channel clocks and resets
+ *
+ * Configures dual-channel mode, sets the PRCM DMC feature registers for
+ * LPDDR5 operation, and sequences reset deassertion and clock gating for
+ * DRAM Channels 0 and 1.
+ */
+static void sun60i_a733_dmc_clock_setup(void)
+{
+	void __iomem *ch0_clk = (void __iomem *)SUNXI_PRCM_CH0_DMC_CLK_REG;
+	void __iomem *ch1_clk = (void __iomem *)SUNXI_PRCM_CH1_DMC_CLK_REG;
+	void __iomem *ch0_feat = (void __iomem *)SUNXI_PRCM_CH0_DMC_FEAT_REG;
+	void __iomem *ch1_feat = (void __iomem *)SUNXI_PRCM_CH1_DMC_FEAT_REG;
+
+	/* Step 1: Configure dual-channel mode */
+	clrsetbits_le32(ch0_clk, 0x3f3fU, 0x2728U);
+	writel(readl(ch0_clk), ch1_clk);
+
+	/* Step 2: Configure DRAM memory type */
+	clrsetbits_le32(ch0_feat, 0x03U, 0x03U);
+	writel(readl(ch0_feat), ch1_feat);
+
+	/* Step 3: Pulse channel resets and enable clock */
+	clrsetbits_le32(ch0_clk, 0x13U, 0x14U);
+	writel(readl(ch0_clk), ch1_clk);
+	udelay(1);
+
+	clrsetbits_le32(ch0_clk, 0x01U, 0x02U);
+	writel(readl(ch0_clk), ch1_clk);
+	udelay(1);
+
+	setbits_le32(ch0_clk, 0x03U);
+	writel(readl(ch0_clk), ch1_clk);
+	udelay(1);
+}
+
+/**
+ * sunxi_dram_init - Top-level DRAM subsystem initialization and bringup
+ *
+ * Return: Total operational DRAM capacity in bytes (hangs on training failure).
+ */
+unsigned long sunxi_dram_init(void)
+{
+	unsigned long dram_size;
+	int ret;
+
+	/* Allow LPDDR5 VDD1/VDD2/VDDQ rails configured by SPL PMIC init to settle */
+	mdelay(10);
+
+	/* PRCM DMC Channel Clock Setup */
+	sun60i_a733_dmc_clock_setup();
+
+	/* Try dual-rank training first, falling back to single-rank */
+	ret = mctl_phy_init(0x03, false);
+	if (ret) {
+		debug("DRAM: Dual-rank training failed (%d), retrying single-rank\n",
+		      ret);
+		sun60i_a733_dmc_clock_setup();
+		ret = mctl_phy_init(0x01, true);
+	}
+	if (ret) {
+		pr_err("DRAM: Synopsys PHY training failed (%d)\n", ret);
+		hang();
+	}
+
+	dram_size = sun60i_a733_get_dram_size();
+
+	/* Optional Debug Diagnostics */
+	a733_dump_and_test_dram(dram_size, "Normal DRAM Read/Write Test");
+
+	return dram_size;
+}
+#endif /* !SUN60I_A733_PMU_FW_MISSING */
+#else /* !CONFIG_XPL_BUILD */
+/**
+ * sun60i_a733_dram_type_name() - Read active DRAM generation name from uMCTL2
+ *
+ * Description: Inspects the active DRAM type bit in the Channel 0 uMCTL2 MSTR
+ * register and returns a human-readable string.
+ *
+ * Return: Human-readable DRAM generation string.
+ */
+static const char *sun60i_a733_dram_type_name(void)
+{
+	u32 mstr = readl((void __iomem *)(UMCTL2_CH0_BASE + UMCTL2_MSTR_OFFSET));
+
+	if (mstr & UMCTL2_MSTR_LPDDR5)
+		return "LPDDR5";
+
+	return "Unknown";
+}
+
+/**
+ * board_add_ram_info() - Report trained DRAM type and effective data rate
+ * @use_default: Unused default-configuration flag
+ */
+void board_add_ram_info(int use_default __maybe_unused)
+{
+	u32 pll = readl((void __iomem *)CCU_PLL_DDR_CTRL_REG);
+	u32 n = ((pll >> 8) & 0xffU) + 1U;
+	u32 m_out = ((pll >> 20) & 0x07U) + 1U;
+	u32 p_in = ((pll >> 1) & 0x01U) + 1U;
+	u32 pll_freq_mhz = (24U * n) / (p_in * m_out);
+	u32 dram_clk_reg = readl((void __iomem *)CCU_DRAM0_CLK_REG);
+	u32 m_dram = (dram_clk_reg & 0x1fU) + 1U;
+	u32 ck_mhz = pll_freq_mhz / m_dram;
+	u32 rate_mts = ck_mhz * 8U;
+
+	printf(" (%s, %u MT/s)",
+	       sun60i_a733_dram_type_name(),
+	       rate_mts);
+}
+#endif /* CONFIG_XPL_BUILD */
diff --git a/arch/arm/mach-sunxi/dram_sun60i_a733_tables.h b/arch/arm/mach-sunxi/dram_sun60i_a733_tables.h
new file mode 100644
index 00000000000..8dfb33f63f3
--- /dev/null
+++ b/arch/arm/mach-sunxi/dram_sun60i_a733_tables.h
@@ -0,0 +1,941 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Allwinner A733 LPDDR5 uMCTL2, Synopsys PHY, and PIE initialization tables
+ *
+ * (C) Copyright 2026 Alastair D'Silva <alastair@d-silva.org>
+ */
+
+#ifndef _DRAM_SUN60I_A733_TABLES_H
+#define _DRAM_SUN60I_A733_TABLES_H
+
+#include <linux/compiler_attributes.h>
+
+/**
+ * struct sunxi_dram_reg - DRAM initialization MMIO register write entry
+ * @addr: Target physical MMIO address
+ * @val: Value to write (16-bit for DDR PHY APB 0x0a900000..0x0aafffff, 32-bit otherwise)
+ */
+struct sunxi_dram_reg {
+	u32 addr;
+	u32 val;
+};
+
+static const struct sunxi_dram_reg dram_umctl2_ch_regs[] __section(".init.rodata") = {
+	{ 0x0a110380, 0x80013414 },
+	{ 0x0a100c00, 0x000000ff },
+	{ 0x0a200c00, 0x000000ff },
+	{ 0x0a300c00, 0x000000ff },
+	{ 0x0a400c00, 0x000000ff },
+	{ 0x0a110b84, 0x00000001 },
+	{ 0x0a110184, 0x00000002 },
+	{ 0x0a110000, 0x03081008 },
+	{ 0x0a110c9c, 0x00000303 },
+	{ 0x0a110010, 0x00000001 },
+	{ 0x0a11018c, 0x00000000 },
+	{ 0x0a110180, 0x00000800 },
+	{ 0x0a110508, 0xc0000000 },
+	{ 0x0a110280, 0x80000000 },
+	{ 0x0a110288, 0x00000001 },
+	{ 0x0a110300, 0x00c000c0 },
+	{ 0x0a110308, 0x00000001 },
+	{ 0x0a110500, 0x00000000 },
+	{ 0x0a110518, 0x25000000 },
+	{ 0x0a110208, 0x00000001 },
+	{ 0x0a110510, 0x00010015 },
+	{ 0x0a130018, 0x02020200 },
+	{ 0x0a130014, 0x1f020202 },
+	{ 0x0a130010, 0x00000101 },
+	{ 0x0a13000c, 0x003f0909 },
+	{ 0x0a13002c, 0x00000808 },
+	{ 0x0a130028, 0x08080808 },
+	{ 0x0a130024, 0x08080808 },
+	{ 0x0a130020, 0x08080808 },
+	{ 0x0a13001c, 0x1f1f1f08 },
+	{ 0x0a130004, 0x00003f17 },
+	{ 0x0a110220, 0x0a090e01 },
+	{ 0x0a110224, 0x00000000 },
+	{ 0x0a100000, 0x1f090f13 },
+	{ 0x0a100004, 0x0004041d },
+	{ 0x0a100008, 0x070d1011 },
+	{ 0x0a10000c, 0x000a1b24 },
+	{ 0x0a100010, 0x0904030a },
+	{ 0x0a100014, 0x02030706 },
+	{ 0x0a100018, 0x00000006 },
+	{ 0x0a10001c, 0x00000002 },
+	{ 0x0a100024, 0x0002040d },
+	{ 0x0a100030, 0x00030000 },
+	{ 0x0a100034, 0x0a100002 },
+	{ 0x0a100038, 0x001200af },
+	{ 0x0a10005c, 0x00180006 },
+	{ 0x0a100060, 0x000e120c },
+	{ 0x0a100064, 0x00001f04 },
+	{ 0x0a100078, 0x00556262 },
+	{ 0x0a100080, 0x00000000 },
+	{ 0x0a100d00, 0x00000001 },
+	{ 0x0a110d00, 0xc00100db },
+	{ 0x0a110510, 0x00010014 },
+	{ 0x0a100d04, 0x0000090b },
+	{ 0x0a100d08, 0x00001221 },
+	{ 0x0a100d0c, 0x00400005 },
+	{ 0x0a1005a0, 0x00020202 },
+	{ 0x0a1005a4, 0x00000201 },
+	{ 0x0a1005a8, 0x001c0003 },
+	{ 0x0a1005ac, 0x005800a0 },
+	{ 0x0a1005b0, 0x00000097 },
+	{ 0x0a1005b8, 0x00000147 },
+	{ 0x0a100580, 0x032f0217 },
+	{ 0x0a100584, 0x00070303 },
+	{ 0x0a100588, 0x00182f17 },
+	{ 0x0a100590, 0x10080411 },
+	{ 0x0a100594, 0x040c000f },
+	{ 0x0a100600, 0x00000036 },
+	{ 0x0a100604, 0x00ab00ab },
+	{ 0x0a100608, 0x04290000 },
+	{ 0x0a100650, 0x00000075 },
+	{ 0x0a100800, 0x000e0a96 },
+	{ 0x0a100804, 0x01700100 },
+	{ 0x0a100808, 0x0000000e },
+	{ 0x0a100a80, 0x00001f74 },
+	{ 0x0a100b00, 0x07c0c3e2 },
+	{ 0x0a100b04, 0x1024100a },
+	{ 0x0a100b08, 0x00000033 },
+	{ 0x0a100b80, 0x00170000 },
+	{ 0x0a110b84, 0x00000000 },
+	{ 0x0a110c80, 0x00000000 },
+	{ 0x0a110510, 0x00010004 },
+	{ 0x0a110c80, 0x00000001 },
+	{ 0x0a110c80, 0x00000000 },
+	{ 0x0a110510, 0x00010014 },
+	{ 0x0a110c80, 0x00000001 },
+};
+
+static const struct sunxi_dram_reg dram_phy_init_regs[] __section(".init.rodata") = {
+	{ 0x0a020010, 0x0000273c },
+	{ 0x0a020010, 0x0000273e },
+	{ 0x0a020010, 0x0000273f },
+	{ 0x0a940094, 0x0402 },
+	{ 0x0a940096, 0x123e },
+	{ 0x0a940110, 0x0101 },
+	{ 0x0a9400c0, 0x0002 },
+	{ 0x0a94014a, 0x0001 },
+	{ 0x0aaa006c, 0x0000 },
+	{ 0x0a94017a, 0x00ff },
+	{ 0x0a940600, 0x0808 },
+	{ 0x0a940606, 0x0009 },
+	{ 0x0a940604, 0x0026 },
+	{ 0x0a940650, 0x0000 },
+	{ 0x0a940602, 0x0003 },
+	{ 0x0a940616, 0x0000 },
+	{ 0x0a96015c, 0x0080 },
+	{ 0x0a96015a, 0x0080 },
+	{ 0x0a960158, 0x0080 },
+	{ 0x0a96215c, 0x0080 },
+	{ 0x0a96215a, 0x0080 },
+	{ 0x0a962158, 0x0080 },
+	{ 0x0aa8010c, 0x0000 },
+	{ 0x0a920146, 0x0b3f },
+	{ 0x0a922146, 0x0b33 },
+	{ 0x0a924146, 0x0b3f },
+	{ 0x0a926146, 0x0b33 },
+	{ 0x0aa801e2, 0x6000 },
+	{ 0x0aa801e4, 0x00a9 },
+	{ 0x0aa801e6, 0x8000 },
+	{ 0x0aa801e8, 0x0005 },
+	{ 0x0aa801ea, 0x4000 },
+	{ 0x0aa801ec, 0x0002 },
+	{ 0x0aa801ee, 0xf000 },
+	{ 0x0aa801f2, 0x6000 },
+	{ 0x0aa801f4, 0x00a9 },
+	{ 0x0aa801f6, 0x8000 },
+	{ 0x0aa801f8, 0x0000 },
+	{ 0x0aa801fa, 0x4000 },
+	{ 0x0aa801fc, 0x0000 },
+	{ 0x0aa801fe, 0xf000 },
+	{ 0x0aa211fe, 0x000f },
+	{ 0x0a920126, 0x0000 },
+	{ 0x0a922126, 0x0000 },
+	{ 0x0a924126, 0x0000 },
+	{ 0x0a926126, 0x0000 },
+	{ 0x0a9400a2, 0x0003 },
+};
+
+/*
+ * Address Tag Encoding for mctl_write_regs():
+ *   Bit 31 (PHY_BCAST_DBYTE): Replicate entry across DBYTE slices 0..3 (+ s * 0x2000)
+ *   Bit 30 (PHY_BCAST_AC):    Replicate entry across AC slices 0..1 (+ ac * 0x2000)
+ *   Bit 29 (PHY_BCAST_9LANE): Replicate entry across DBYTE 0..3 and lanes 0..8 (+ l * 0x200)
+ */
+#define PHY_BCAST_DBYTE		BIT(31)
+#define PHY_BCAST_AC		BIT(30)
+#define PHY_BCAST_9LANE		BIT(29)
+#define PHY_BCAST_MASK		(PHY_BCAST_DBYTE | PHY_BCAST_AC | PHY_BCAST_9LANE)
+
+static const struct sunxi_dram_reg dram_phy_pre_dmem_regs[] __section(".init.rodata") = {
+	{ 0x0aa21004, 0x0001 },
+	{ 0x0a940098, 0x2a8b },
+	{ 0x0a94009a, 0x0000 },
+	{ 0x0a940004, 0x0002 },
+	{ 0x0a940000, 0x0002 },
+	{ 0x0aa21002, 0x002c },
+	{ 0x0aa21012, 0x6800 },
+	{ PHY_BCAST_DBYTE | 0x0a9200bc, 0x0366 },
+	{ PHY_BCAST_DBYTE | 0x0a9200c0, 0x0366 },
+	{ PHY_BCAST_DBYTE | 0x0a9200c4, 0x0366 },
+	{ PHY_BCAST_DBYTE | 0x0a9200c8, 0x0366 },
+	{ PHY_BCAST_DBYTE | 0x0a9200be, 0x0366 },
+	{ PHY_BCAST_DBYTE | 0x0a9200c2, 0x0366 },
+	{ PHY_BCAST_DBYTE | 0x0a9200c6, 0x0366 },
+	{ PHY_BCAST_DBYTE | 0x0a9200ca, 0x0366 },
+	{ PHY_BCAST_DBYTE | 0x0a92000a, 0x0000 },
+	{ PHY_BCAST_DBYTE | 0x0a920016, 0x0000 },
+	{ 0x0a94000e, 0x0000 },
+	{ 0x0a940026, 0x002c },
+	{ PHY_BCAST_AC | 0x0a960070, 0x0003 },
+	{ PHY_BCAST_AC | 0x0a960072, 0x0003 },
+	{ PHY_BCAST_AC | 0x0a960074, 0x0003 },
+	{ PHY_BCAST_DBYTE | 0x0a920070, 0x0003 },
+	{ PHY_BCAST_DBYTE | 0x0a920074, 0x0003 },
+	{ PHY_BCAST_DBYTE | 0x0a920076, 0x0003 },
+	{ PHY_BCAST_DBYTE | 0x0a920012, 0x0000 },
+	{ PHY_BCAST_DBYTE | 0x0a92006e, 0x0000 },
+	{ PHY_BCAST_DBYTE | 0x0a920008, 0x0000 },
+	{ PHY_BCAST_DBYTE | 0x0a920006, 0x0000 },
+	{ 0x0a940008, 0x01c2 },
+	{ PHY_BCAST_AC | 0x0a9600a0, 0x0035 },
+	{ PHY_BCAST_AC | 0x0a9600a2, 0x0035 },
+	{ PHY_BCAST_AC | 0x0a9600a4, 0x0035 },
+	{ PHY_BCAST_AC | 0x0a9600a6, 0x0035 },
+	{ PHY_BCAST_9LANE | 0x0a92009c, 0x0035 },
+	{ PHY_BCAST_9LANE | 0x0a92009e, 0x0035 },
+	{ PHY_BCAST_9LANE | 0x0a9200a0, 0x0035 },
+	{ PHY_BCAST_9LANE | 0x0a9200a2, 0x0035 },
+	{ PHY_BCAST_AC | 0x0a960060, 0x0000 },
+	{ PHY_BCAST_AC | 0x0a960062, 0x0000 },
+	{ PHY_BCAST_AC | 0x0a96006a, 0x0000 },
+	{ PHY_BCAST_DBYTE | 0x0a920060, 0x0000 },
+	{ PHY_BCAST_DBYTE | 0x0a92006a, 0x0000 },
+	{ PHY_BCAST_DBYTE | 0x0a92006c, 0x0000 },
+	{ PHY_BCAST_AC | 0x0a960078, 0x0005 },
+	{ PHY_BCAST_DBYTE | 0x0a920078, 0x0005 },
+	{ PHY_BCAST_DBYTE | 0x0a92007a, 0x0005 },
+	{ PHY_BCAST_DBYTE | 0x0a92007c, 0x0005 },
+	{ 0x0a940006, 0x0001 },
+	{ 0x0a940002, 0x1122 },
+	{ 0x0a940012, 0x0000 },
+	{ 0x0a940010, 0x0000 },
+	{ 0x0a9401b2, 0x0001 },
+	{ 0x0a940028, 0x1301 },
+	{ 0x0aa21014, 0x1300 },
+	{ PHY_BCAST_DBYTE | 0x0a920080, 0x0f0f },
+	{ PHY_BCAST_DBYTE | 0x0a920084, 0x0f0f },
+	{ 0x0aa2101a, 0x0000 },
+	{ PHY_BCAST_DBYTE | 0x0a920086, 0x0000 },
+	{ PHY_BCAST_DBYTE | 0x0a920088, 0x0f0f },
+	{ PHY_BCAST_DBYTE | 0x0a92008a, 0x0f0f },
+	{ PHY_BCAST_AC | 0x0a960080, 0x0f0f },
+	{ PHY_BCAST_AC | 0x0a960082, 0x0f0f },
+	{ PHY_BCAST_AC | 0x0a960084, 0x0e0e },
+	{ PHY_BCAST_AC | 0x0a960086, 0x0e0e },
+	{ PHY_BCAST_AC | 0x0a960660, 0x0033 },
+	{ 0x0a940662, 0x0033 },
+	{ PHY_BCAST_DBYTE | 0x0a920090, 0x0e00 },
+	{ PHY_BCAST_DBYTE | 0x0a920094, 0x0e00 },
+	{ PHY_BCAST_DBYTE | 0x0a920096, 0x0e00 },
+	{ PHY_BCAST_DBYTE | 0x0a920098, 0x0800 },
+	{ PHY_BCAST_DBYTE | 0x0a92009a, 0x0800 },
+	{ PHY_BCAST_AC | 0x0a960090, 0x0c00 },
+	{ PHY_BCAST_AC | 0x0a960092, 0x0c00 },
+	{ PHY_BCAST_AC | 0x0a960094, 0x0e00 },
+	{ PHY_BCAST_AC | 0x0a960096, 0x0e00 },
+	{ PHY_BCAST_AC | 0x0a960066, 0x0000 },
+	{ PHY_BCAST_AC | 0x0a960068, 0x0000 },
+	{ PHY_BCAST_AC | 0x0a96005c, 0x0000 },
+	{ PHY_BCAST_DBYTE | 0x0a920066, 0x0000 },
+	{ PHY_BCAST_DBYTE | 0x0a92005c, 0x0000 },
+	{ PHY_BCAST_DBYTE | 0x0a92005e, 0x0000 },
+	{ 0x0a94002a, 0x0000 },
+	{ 0x0aa2100c, 0x0000 },
+	{ PHY_BCAST_DBYTE | 0x0a9201d0, 0x0000 },
+	{ PHY_BCAST_DBYTE | 0x0a9201d2, 0x0035 },
+	{ PHY_BCAST_DBYTE | 0x0a920002, 0x0000 },
+	{ 0x0a940024, 0xa1a1 },
+	{ 0x0a94002e, 0x0040 },
+	{ 0x0a940014, 0x0040 },
+	{ 0x0a94030c, 0x00a1 },
+	{ 0x0a94030e, 0x0040 },
+	{ 0x0a940020, 0x0050 },
+	{ 0x0a940022, 0x000f },
+	{ 0x0aa21016, 0x000f },
+	{ 0x0aa21018, 0x000f },
+	{ PHY_BCAST_DBYTE | 0x0a92014a, 0x0001 },
+	{ PHY_BCAST_DBYTE | 0x0a920028, 0x3232 },
+	{ PHY_BCAST_DBYTE | 0x0a92001e, 0x0986 },
+	{ 0x0a94006a, 0x0c08 },
+	{ 0x0a94006c, 0x0c08 },
+	{ 0x0a94006e, 0x0414 },
+	{ 0x0a940070, 0x1918 },
+	{ 0x0a940072, 0x0c10 },
+	{ 0x0a940074, 0x0c10 },
+	{ 0x0a940076, 0x041c },
+	{ 0x0a940078, 0x2920 },
+	{ 0x0a94007a, 0x0c04 },
+	{ 0x0a94007c, 0x0c04 },
+	{ 0x0a94007e, 0x0410 },
+	{ 0x0a940080, 0x1114 },
+	{ 0x0a940058, 0x082f },
+	{ 0x0a94005a, 0x082f },
+	{ 0x0a940060, 0x082f },
+	{ 0x0a94005c, 0x0817 },
+	{ 0x0a94005e, 0x0817 },
+	{ 0x0a940018, 0x0000 },
+	{ 0x0a940036, 0x0000 },
+	{ PHY_BCAST_DBYTE | 0x0a92000e, 0x0000 },
+	{ 0x0aa80100, 0x0003 },
+	{ 0x0a940094, 0x0402 },
+	{ 0x0a940096, 0x123e },
+	{ 0x0a940098, 0x2a8b },
+	{ 0x0a110c80, 0x00000000 },
+	{ 0x0a110510, 0x00010014 },
+	{ 0x0a110c80, 0x00000001 },
+	{ 0x0a510c80, 0x00000000 },
+	{ 0x0a510510, 0x00010014 },
+	{ 0x0a510c80, 0x00000001 },
+	{ 0x02002c00, 0x88000003 },
+	{ 0x0aaa0000, 0x0000 },
+};
+
+static const struct pmu_message_block dram_pmu_msg_block __section(".init.rodata") = {
+	.pstate_flags    = 0x30,
+	.dram_rate_mts   = 3600,
+	.pll_ratio       = 4,
+	.dfi_freq_ratio  = 4,
+	.sequence_ctrl   = PMU_SEQ_FULL_TRAIN,
+	.post_threshold  = 0xff,
+	.cal_ctrl        = 0x0002,
+	.ch0_dq_width    = 16,
+	.ch0_rank_en     = 0x03,
+	.ch1_dq_width    = 16,
+	.ch1_rank_en     = 0x03,
+	.mr1             = { 0x80, 0x80, 0x80, 0x80 },
+	.mr2             = { 0x88, 0x88, 0x88, 0x88 },
+	.mr3             = { 0x06, 0x06, 0x06, 0x06 },
+	.mr10            = { 0x54, 0x54, 0x54, 0x54 },
+	.mr11            = { 0x13, 0x13, 0x13, 0x13 },
+	.mr12            = { 0x44, 0x44, 0x44, 0x44 },
+	.mr14            = { 0x2e, 0x2e, 0x2e, 0x2e },
+	.mr15            = { 0x2e, 0x2e, 0x2e, 0x2e },
+	.mr17            = { 0x06, 0x2e, 0x06, 0x2e },
+	.mr18            = { 0x1c, 0x1c, 0x1c, 0x1c },
+	.mr19            = { 0x10, 0x10, 0x10, 0x10 },
+	.mr20            = { 0x02, 0x02, 0x02, 0x02 },
+	.mr28            = { 0x04, 0x04, 0x04, 0x04 },
+	.mr41            = { 0x60, 0x60, 0x60, 0x60 },
+	.pll_gate_ch     = { 0x002e, 0x0050 },
+	.dq_swap_en      = 0x01,
+	.lane_err_mask   = 0x0f,
+	.ca_vref_rank1   = 0x33,
+	.ca_vref_rank0   = 0x2f,
+};
+
+/*
+ * CA0..CA6 and DQ0..DQ7 lane permutations used on the Orange Pi 4 Pro PCB routing.
+ */
+static const u8 dram_ac_pin_swizzle[2][7] __section(".init.rodata") = {
+	{ 3, 6, 4, 0, 2, 5, 1 },
+	{ 3, 0, 6, 4, 2, 5, 1 },
+};
+
+static const u8 dram_dq_pin_swizzle[4][8] __section(".init.rodata") = {
+	{ 4, 3, 5, 7, 0, 1, 6, 2 },
+	{ 3, 2, 1, 0, 5, 7, 6, 4 },
+	{ 1, 4, 5, 2, 7, 6, 0, 3 },
+	{ 6, 7, 3, 0, 4, 5, 1, 2 },
+};
+
+/**
+ * struct sunxi_pie_word - Sparse non-zero 16-bit PIE SRAM entry
+ * @off: Byte offset from the target PIE SRAM base address
+ * @val: Non-zero 16-bit value to write at @base + @off
+ */
+struct sunxi_pie_word {
+	u16 off;
+	u16 val;
+};
+
+static const struct sunxi_dram_reg dram_pie_head_regs[] __section(".init.rodata") = {
+	{ 0x0aaa0000, 0x0000 },
+	{ 0x0aa211e0, 0x0039 },
+	{ 0x0aa211e2, 0x00a8 },
+	{ 0x0aa211e4, 0x0000 },
+	{ 0x0aa211e6, 0x0058 },
+	{ 0x0aa211e8, 0x000b },
+	{ 0x0aa211ea, 0x0000 },
+	{ 0x0aa211ec, 0x00b0 },
+	{ 0x0aa211ee, 0x0000 },
+};
+
+static const struct sunxi_pie_word dram_pie_init[] __section(".init.rodata") = {
+	{ 0x0000, 0xc9d8 }, { 0x0008, 0xc808 }, { 0x0016, 0x2b00 }, { 0x0020, 0xc958 },
+	{ 0x0028, 0xce08 }, { 0x0036, 0x2b00 }, { 0x0040, 0xc0d8 }, { 0x0048, 0xc048 },
+	{ 0x0056, 0x2b00 }, { 0x0060, 0xc158 }, { 0x0068, 0xc448 }, { 0x0076, 0x2b00 },
+	{ 0x0080, 0xc1d8 }, { 0x0088, 0xc308 }, { 0x0096, 0x2b00 }, { 0x00a0, 0xc558 },
+	{ 0x00a8, 0xea08 }, { 0x00b6, 0x2b00 }, { 0x00c0, 0xc5d8 }, { 0x00c8, 0xc108 },
+	{ 0x00d6, 0x2b00 }, { 0x00e0, 0x48d8 }, { 0x00e8, 0x4308 }, { 0x00f0, 0x88d8 },
+	{ 0x00f8, 0x9708 }, { 0x0106, 0x2b00 }, { 0x0110, 0xca58 }, { 0x0118, 0xc108 },
+	{ 0x0126, 0x2b00 }, { 0x0130, 0xcb58 }, { 0x0138, 0xc008 }, { 0x0146, 0x2b00 },
+	{ 0x0150, 0xd4d8 }, { 0x0158, 0xf008 },
+};
+
+static const struct sunxi_dram_reg dram_pie_phy_setup_regs[] __section(".init.rodata") = {
+	{ 0x0a94002a, 0x0000 },
+	{ PHY_BCAST_AC | 0x0a960094, 0x0000 },
+	{ PHY_BCAST_AC | 0x0a960096, 0x0000 },
+	{ 0x0a940098, 0x080f },
+	{ 0x0a94009a, 0x0000 },
+	{ 0x0a940082, 0x0001 },
+	{ 0x0aa21004, 0x0001 },
+	{ 0x0a94008a, 0x0002 },
+	{ PHY_BCAST_DBYTE | 0x0a9200ae, 0x0000 },
+	{ PHY_BCAST_DBYTE | 0x0a92001e, 0x0988 },
+	{ 0x0aa21006, 0x0004 },
+	{ 0x0aa21008, 0x0082 },
+	{ 0x0aa2100a, 0x0001 },
+	{ 0x0aa21206, 0x0000 },
+	{ 0x0aa21216, 0x0002 },
+	{ 0x0aa21022, 0x0000 },
+	{ 0x0aa21024, 0xff00 },
+	{ 0x0a9400e4, 0x0003 },
+	{ 0x0aa2101c, 0x0003 },
+	{ 0x0a9400e6, 0x0003 },
+	{ 0x0aa2101e, 0x0003 },
+	{ 0x0a940094, 0x0e3e },
+	{ 0x0a940096, 0x0e3e },
+	{ 0x0a940098, 0x280b },
+	{ 0x0aaa0000, 0x0000 },
+};
+
+static const struct sunxi_pie_word dram_pie_seq[] __section(".init.rodata") = {
+	{ 0x0000, 0xc028 }, { 0x0006, 0x0010 }, { 0x0016, 0x0400 }, { 0x0030, 0xc858 },
+	{ 0x0036, 0x0010 }, { 0x0038, 0xe088 }, { 0x003e, 0x0010 }, { 0x0040, 0xe038 },
+	{ 0x0046, 0x0010 }, { 0x0048, 0xc858 }, { 0x004e, 0x0010 }, { 0x0050, 0xc088 },
+	{ 0x0056, 0x0010 }, { 0x0060, 0xc028 }, { 0x0066, 0x0010 }, { 0x0076, 0x0400 },
+	{ 0x0090, 0xc858 }, { 0x0096, 0x0010 }, { 0x0098, 0xe208 }, { 0x009e, 0x0010 },
+	{ 0x00a0, 0xe038 }, { 0x00a6, 0x0010 }, { 0x00a8, 0xc858 }, { 0x00ae, 0x0010 },
+	{ 0x00b0, 0xc208 }, { 0x00b6, 0x0010 }, { 0x00c0, 0xce58 }, { 0x00c6, 0x0010 },
+	{ 0x00c8, 0xc208 }, { 0x00ce, 0x0010 }, { 0x00e0, 0xc370 }, { 0x00e6, 0x0010 },
+	{ 0x00f0, 0xc040 }, { 0x00f6, 0x0010 }, { 0x00fe, 0x0010 }, { 0x0100, 0xd2d8 },
+	{ 0x0106, 0x0010 }, { 0x0108, 0xe008 }, { 0x010e, 0x0010 }, { 0x0116, 0x5b00 },
+	{ 0x0120, 0xc0f0 }, { 0x0126, 0x0010 }, { 0x0130, 0xcfd8 }, { 0x0136, 0x0010 },
+	{ 0x0138, 0xc008 }, { 0x013e, 0x0010 }, { 0x0146, 0x2b00 }, { 0x0150, 0xd058 },
+	{ 0x0156, 0x0010 }, { 0x0158, 0xc008 }, { 0x015e, 0x0010 }, { 0x0166, 0x2b00 },
+	{ 0x0170, 0xd0d8 }, { 0x0176, 0x0010 }, { 0x0178, 0xc088 }, { 0x017e, 0x0010 },
+	{ 0x0186, 0x2b00 }, { 0x0190, 0xd158 }, { 0x0196, 0x0010 }, { 0x0198, 0xc008 },
+	{ 0x019e, 0x0010 }, { 0x01a6, 0x5b00 }, { 0x01b0, 0x402c }, { 0x01b2, 0x0d00 },
+	{ 0x01b4, 0x0001 }, { 0x01b6, 0x0400 }, { 0x01b8, 0x4050 }, { 0x01ba, 0x0800 },
+	{ 0x01c6, 0x0400 }, { 0x01d6, 0x0400 }, { 0x01d8, 0x4050 }, { 0x01da, 0x0803 },
+	{ 0x01e6, 0x7f00 }, { 0x01ee, 0x0400 }, { 0x01f0, 0x407c }, { 0x01f6, 0x0400 },
+	{ 0x0206, 0x0400 }, { 0x020c, 0x0001 }, { 0x0216, 0x0400 }, { 0x0230, 0x802c },
+	{ 0x0232, 0x0d00 }, { 0x0234, 0x0001 }, { 0x0236, 0x0410 }, { 0x0238, 0x8050 },
+	{ 0x023a, 0x0800 }, { 0x023e, 0x0010 }, { 0x0246, 0x0400 }, { 0x0256, 0x0400 },
+	{ 0x0258, 0x8050 }, { 0x025a, 0x0803 }, { 0x025e, 0x0010 }, { 0x0266, 0x7f00 },
+	{ 0x026e, 0x0400 }, { 0x0270, 0x807c }, { 0x0276, 0x0410 }, { 0x0286, 0x0400 },
+	{ 0x028c, 0x0001 }, { 0x0296, 0x0400 }, { 0x02b0, 0x402c }, { 0x02b2, 0x0d00 },
+	{ 0x02b4, 0x0001 }, { 0x02b8, 0x4050 }, { 0x02ba, 0x0800 }, { 0x02d8, 0x4050 },
+	{ 0x02da, 0x0803 }, { 0x02f8, 0x4050 }, { 0x02fa, 0x0800 }, { 0x0306, 0x6b00 },
+	{ 0x030e, 0x0400 }, { 0x0318, 0x407c }, { 0x0334, 0x0001 }, { 0x0346, 0x4b00 },
+	{ 0x034e, 0x1800 }, { 0x0358, 0x802c }, { 0x035a, 0x0d00 }, { 0x035c, 0x0001 },
+	{ 0x035e, 0x0010 }, { 0x0360, 0x8050 }, { 0x0362, 0x0800 }, { 0x0366, 0x0010 },
+	{ 0x0380, 0x8050 }, { 0x0382, 0x0803 }, { 0x0386, 0x0010 }, { 0x03a0, 0x8050 },
+	{ 0x03a2, 0x0800 }, { 0x03a6, 0x0010 }, { 0x03b6, 0x6b00 }, { 0x03be, 0x0400 },
+	{ 0x03c0, 0x807c }, { 0x03c6, 0x0010 }, { 0x03dc, 0x0001 }, { 0x03e6, 0x7b00 },
+	{ 0x03ee, 0x2000 }, { 0x03f0, 0x402c }, { 0x03f2, 0x0d00 }, { 0x03f4, 0x0001 },
+	{ 0x03f8, 0x5198 }, { 0x03fa, 0x0803 }, { 0x0406, 0x3b00 }, { 0x0410, 0x5218 },
+	{ 0x0412, 0x0803 }, { 0x0426, 0x6b00 }, { 0x042e, 0x0400 }, { 0x0430, 0x407c },
+	{ 0x044c, 0x0001 }, { 0x0456, 0x1b00 }, { 0x0468, 0x802c }, { 0x046a, 0x0d00 },
+	{ 0x046c, 0x0001 }, { 0x046e, 0x0010 }, { 0x0470, 0x9198 }, { 0x0472, 0x0803 },
+	{ 0x0476, 0x0010 }, { 0x0486, 0x2b00 }, { 0x0498, 0x9218 }, { 0x049a, 0x0803 },
+	{ 0x049e, 0x0010 }, { 0x04a6, 0x6b00 }, { 0x04ae, 0x0400 }, { 0x04b8, 0x807c },
+	{ 0x04be, 0x0010 }, { 0x04d4, 0x0001 }, { 0x04e6, 0x0b00 }, { 0x04ee, 0x0400 },
+	{ 0x0500, 0x401c }, { 0x0502, 0x00d0 }, { 0x0504, 0x0001 }, { 0x0508, 0x4060 },
+	{ 0x050a, 0x0084 }, { 0x0516, 0x0b00 }, { 0x051e, 0x0800 }, { 0x0520, 0x407c },
+	{ 0x0538, 0x4000 }, { 0x053c, 0x0001 }, { 0x0548, 0x402c }, { 0x054a, 0x0d00 },
+	{ 0x054c, 0x0001 }, { 0x0550, 0x4020 }, { 0x0552, 0x0803 }, { 0x0566, 0x2b00 },
+	{ 0x056e, 0x0800 }, { 0x0578, 0x407c }, { 0x0594, 0x0001 }, { 0x05a0, 0x801c },
+	{ 0x05a2, 0x00d0 }, { 0x05a4, 0x0001 }, { 0x05a6, 0x0010 }, { 0x05a8, 0x8060 },
+	{ 0x05aa, 0x0084 }, { 0x05ae, 0x0010 }, { 0x05b6, 0x0b00 }, { 0x05be, 0x0800 },
+	{ 0x05c0, 0x807c }, { 0x05c6, 0x0010 }, { 0x05d8, 0x8000 }, { 0x05dc, 0x0001 },
+	{ 0x05de, 0x0010 }, { 0x05e8, 0x802c }, { 0x05ea, 0x0d00 }, { 0x05ec, 0x0001 },
+	{ 0x05ee, 0x0010 }, { 0x05f0, 0x8020 }, { 0x05f2, 0x0803 }, { 0x05f6, 0x0010 },
+	{ 0x0606, 0x2b00 }, { 0x060e, 0x0800 }, { 0x0618, 0x807c }, { 0x061e, 0x0010 },
+	{ 0x0634, 0x0001 }, { 0x0640, 0x402c }, { 0x0642, 0x0d00 }, { 0x0644, 0x0001 },
+	{ 0x0648, 0x4050 }, { 0x064a, 0x0803 }, { 0x0656, 0x1b00 }, { 0x0670, 0x4050 },
+	{ 0x0672, 0x0803 }, { 0x0676, 0x5a00 }, { 0x0696, 0x0100 }, { 0x06a0, 0x4050 },
+	{ 0x06a2, 0x0803 }, { 0x06b6, 0x6b00 }, { 0x06be, 0x0400 }, { 0x06c0, 0x407c },
+	{ 0x06d6, 0x3b00 }, { 0x06ec, 0x0001 }, { 0x06f0, 0x5758 }, { 0x06f8, 0x4208 },
+	{ 0x0706, 0x4b00 }, { 0x0718, 0x401c }, { 0x071a, 0x00d0 }, { 0x071c, 0x0001 },
+	{ 0x0720, 0x4060 }, { 0x0722, 0x0084 }, { 0x0736, 0x7b00 }, { 0x0740, 0x407c },
+	{ 0x0758, 0x4000 }, { 0x075c, 0x0001 }, { 0x0768, 0x402c }, { 0x076a, 0x0d00 },
+	{ 0x076c, 0x0001 }, { 0x0770, 0x4020 }, { 0x0772, 0x0803 }, { 0x0786, 0x2b00 },
+	{ 0x078e, 0x0800 }, { 0x0798, 0x407c }, { 0x07b0, 0x4000 }, { 0x07b4, 0x0001 },
+	{ 0x07c0, 0x5758 }, { 0x07c8, 0x4008 }, { 0x07e0, 0x802c }, { 0x07e2, 0x0d00 },
+	{ 0x07e4, 0x0001 }, { 0x07e6, 0x0010 }, { 0x07e8, 0x8050 }, { 0x07ea, 0x0803 },
+	{ 0x07ee, 0x0010 }, { 0x07f6, 0x1b00 }, { 0x0810, 0x8050 }, { 0x0812, 0x0803 },
+	{ 0x0816, 0x5a10 }, { 0x0836, 0x0100 }, { 0x0840, 0x8050 }, { 0x0842, 0x0803 },
+	{ 0x0846, 0x0010 }, { 0x0856, 0x6b00 }, { 0x085e, 0x0400 }, { 0x0860, 0x807c },
+	{ 0x0866, 0x0010 }, { 0x0876, 0x3b00 }, { 0x088c, 0x0001 }, { 0x0890, 0x9758 },
+	{ 0x0896, 0x0010 }, { 0x0898, 0x8208 }, { 0x089e, 0x0010 }, { 0x08a6, 0x4b00 },
+	{ 0x08b8, 0x801c }, { 0x08ba, 0x00d0 }, { 0x08bc, 0x0001 }, { 0x08be, 0x0010 },
+	{ 0x08c0, 0x8060 }, { 0x08c2, 0x0084 }, { 0x08c6, 0x0010 }, { 0x08d6, 0x7b00 },
+	{ 0x08e0, 0x807c }, { 0x08e6, 0x0010 }, { 0x08f8, 0x8000 }, { 0x08fc, 0x0001 },
+	{ 0x08fe, 0x0010 }, { 0x0908, 0x802c }, { 0x090a, 0x0d00 }, { 0x090c, 0x0001 },
+	{ 0x090e, 0x0010 }, { 0x0910, 0x8020 }, { 0x0912, 0x0803 }, { 0x0916, 0x0010 },
+	{ 0x0926, 0x2b00 }, { 0x092e, 0x0800 }, { 0x0938, 0x807c }, { 0x093e, 0x0010 },
+	{ 0x0950, 0x8000 }, { 0x0954, 0x0001 }, { 0x0956, 0x0010 }, { 0x0960, 0x9758 },
+	{ 0x0966, 0x0010 }, { 0x0968, 0x8008 }, { 0x096e, 0x0010 }, { 0x0980, 0xc068 },
+	{ 0x0986, 0x0010 }, { 0x0990, 0xd2d8 }, { 0x0996, 0x0010 }, { 0x0998, 0xe008 },
+	{ 0x099e, 0x0010 }, { 0x09a6, 0x5b00 }, { 0x09b0, 0xc0f0 }, { 0x09b6, 0x0010 },
+	{ 0x09c0, 0xcfd8 }, { 0x09c6, 0x0010 }, { 0x09c8, 0xc008 }, { 0x09ce, 0x0010 },
+	{ 0x09d6, 0x2b00 }, { 0x09e0, 0xd058 }, { 0x09e6, 0x0010 }, { 0x09e8, 0xc008 },
+	{ 0x09ee, 0x0010 }, { 0x09f6, 0x2b00 }, { 0x0a00, 0xd0d8 }, { 0x0a06, 0x0010 },
+	{ 0x0a08, 0xc088 }, { 0x0a0e, 0x0010 }, { 0x0a16, 0x2b00 }, { 0x0a20, 0xd158 },
+	{ 0x0a26, 0x0010 }, { 0x0a28, 0xc008 }, { 0x0a2e, 0x0010 }, { 0x0a36, 0x5b00 },
+	{ 0x0a40, 0x402c }, { 0x0a42, 0x0d00 }, { 0x0a44, 0x0001 }, { 0x0a46, 0x0400 },
+	{ 0x0a48, 0x4050 }, { 0x0a4a, 0x0800 }, { 0x0a56, 0x0400 }, { 0x0a58, 0x4050 },
+	{ 0x0a5a, 0x0803 }, { 0x0a66, 0x6f00 }, { 0x0a6e, 0x0400 }, { 0x0a70, 0x407c },
+	{ 0x0a76, 0x0400 }, { 0x0a86, 0x0400 }, { 0x0a8c, 0x0001 }, { 0x0a96, 0x0400 },
+	{ 0x0ab0, 0x802c }, { 0x0ab2, 0x0d00 }, { 0x0ab4, 0x0001 }, { 0x0ab6, 0x0410 },
+	{ 0x0ab8, 0x8050 }, { 0x0aba, 0x0800 }, { 0x0abe, 0x0010 }, { 0x0ac6, 0x0400 },
+	{ 0x0ac8, 0x8050 }, { 0x0aca, 0x0803 }, { 0x0ace, 0x0010 }, { 0x0ad6, 0x6f00 },
+	{ 0x0ade, 0x0400 }, { 0x0ae0, 0x807c }, { 0x0ae6, 0x0410 }, { 0x0af6, 0x0400 },
+	{ 0x0afc, 0x0001 }, { 0x0b06, 0x0400 }, { 0x0b20, 0x402c }, { 0x0b22, 0x0d00 },
+	{ 0x0b24, 0x0001 }, { 0x0b28, 0x4050 }, { 0x0b2a, 0x0800 }, { 0x0b38, 0x4050 },
+	{ 0x0b3a, 0x0803 }, { 0x0b48, 0x4050 }, { 0x0b4a, 0x0800 }, { 0x0b56, 0x4b00 },
+	{ 0x0b5e, 0x0400 }, { 0x0b68, 0x407c }, { 0x0b84, 0x0001 }, { 0x0b96, 0x4b00 },
+	{ 0x0b9e, 0x1800 }, { 0x0ba8, 0x802c }, { 0x0baa, 0x0d00 }, { 0x0bac, 0x0001 },
+	{ 0x0bae, 0x0010 }, { 0x0bb0, 0x8050 }, { 0x0bb2, 0x0800 }, { 0x0bb6, 0x0010 },
+	{ 0x0bc0, 0x8050 }, { 0x0bc2, 0x0803 }, { 0x0bc6, 0x0010 }, { 0x0bd0, 0x8050 },
+	{ 0x0bd2, 0x0800 }, { 0x0bd6, 0x0010 }, { 0x0be6, 0x4b00 }, { 0x0bee, 0x0400 },
+	{ 0x0bf0, 0x807c }, { 0x0bf6, 0x0010 }, { 0x0c0c, 0x0001 }, { 0x0c16, 0x5b00 },
+	{ 0x0c1e, 0x2000 }, { 0x0c20, 0x402c }, { 0x0c22, 0x0d00 }, { 0x0c24, 0x0001 },
+	{ 0x0c28, 0x5198 }, { 0x0c2a, 0x0803 }, { 0x0c36, 0x1b00 }, { 0x0c40, 0x5218 },
+	{ 0x0c42, 0x0803 }, { 0x0c56, 0x4b00 }, { 0x0c5e, 0x0400 }, { 0x0c60, 0x407c },
+	{ 0x0c7c, 0x0001 }, { 0x0c86, 0x1b00 }, { 0x0c98, 0x802c }, { 0x0c9a, 0x0d00 },
+	{ 0x0c9c, 0x0001 }, { 0x0c9e, 0x0010 }, { 0x0ca0, 0x9198 }, { 0x0ca2, 0x0803 },
+	{ 0x0ca6, 0x0010 }, { 0x0cc8, 0x9218 }, { 0x0cca, 0x0803 }, { 0x0cce, 0x0010 },
+	{ 0x0cd6, 0x4b00 }, { 0x0cde, 0x0400 }, { 0x0ce8, 0x807c }, { 0x0cee, 0x0010 },
+	{ 0x0d04, 0x0001 }, { 0x0d16, 0x0b00 }, { 0x0d1e, 0x0400 }, { 0x0d30, 0x401c },
+	{ 0x0d32, 0x00d0 }, { 0x0d34, 0x0001 }, { 0x0d38, 0x4060 }, { 0x0d3a, 0x0084 },
+	{ 0x0d46, 0x0b00 }, { 0x0d4e, 0x0800 }, { 0x0d50, 0x407c }, { 0x0d68, 0x4000 },
+	{ 0x0d6c, 0x0001 }, { 0x0d78, 0x402c }, { 0x0d7a, 0x0d00 }, { 0x0d7c, 0x0001 },
+	{ 0x0d80, 0x4020 }, { 0x0d82, 0x0803 }, { 0x0d96, 0x2b00 }, { 0x0d9e, 0x0800 },
+	{ 0x0da8, 0x407c }, { 0x0dc4, 0x0001 }, { 0x0dd0, 0x801c }, { 0x0dd2, 0x00d0 },
+	{ 0x0dd4, 0x0001 }, { 0x0dd6, 0x0010 }, { 0x0dd8, 0x8060 }, { 0x0dda, 0x0084 },
+	{ 0x0dde, 0x0010 }, { 0x0de6, 0x0b00 }, { 0x0dee, 0x0800 }, { 0x0df0, 0x807c },
+	{ 0x0df6, 0x0010 }, { 0x0e08, 0x8000 }, { 0x0e0c, 0x0001 }, { 0x0e0e, 0x0010 },
+	{ 0x0e18, 0x802c }, { 0x0e1a, 0x0d00 }, { 0x0e1c, 0x0001 }, { 0x0e1e, 0x0010 },
+	{ 0x0e20, 0x8020 }, { 0x0e22, 0x0803 }, { 0x0e26, 0x0010 }, { 0x0e36, 0x2b00 },
+	{ 0x0e3e, 0x0800 }, { 0x0e48, 0x807c }, { 0x0e4e, 0x0010 }, { 0x0e64, 0x0001 },
+	{ 0x0e70, 0x402c }, { 0x0e72, 0x0d00 }, { 0x0e74, 0x0001 }, { 0x0e78, 0x4050 },
+	{ 0x0e7a, 0x0803 }, { 0x0ea0, 0x4050 }, { 0x0ea2, 0x0803 }, { 0x0ea6, 0x5a00 },
+	{ 0x0eb6, 0x0100 }, { 0x0ec0, 0x4050 }, { 0x0ec2, 0x0803 }, { 0x0ed6, 0x4b00 },
+	{ 0x0ede, 0x0400 }, { 0x0ee0, 0x407c }, { 0x0ef6, 0x3b00 }, { 0x0f0c, 0x0001 },
+	{ 0x0f10, 0x5758 }, { 0x0f18, 0x4208 }, { 0x0f26, 0x4b00 }, { 0x0f38, 0x401c },
+	{ 0x0f3a, 0x00d0 }, { 0x0f3c, 0x0001 }, { 0x0f40, 0x4060 }, { 0x0f42, 0x0084 },
+	{ 0x0f56, 0x7b00 }, { 0x0f60, 0x407c }, { 0x0f78, 0x4000 }, { 0x0f7c, 0x0001 },
+	{ 0x0f88, 0x402c }, { 0x0f8a, 0x0d00 }, { 0x0f8c, 0x0001 }, { 0x0f90, 0x4020 },
+	{ 0x0f92, 0x0803 }, { 0x0fa6, 0x2b00 }, { 0x0fae, 0x0800 }, { 0x0fb8, 0x407c },
+	{ 0x0fd0, 0x4000 }, { 0x0fd4, 0x0001 }, { 0x0fe0, 0x5758 }, { 0x0fe8, 0x4008 },
+	{ 0x1000, 0x802c }, { 0x1002, 0x0d00 }, { 0x1004, 0x0001 }, { 0x1006, 0x0010 },
+	{ 0x1008, 0x8050 }, { 0x100a, 0x0803 }, { 0x100e, 0x0010 }, { 0x1030, 0x8050 },
+	{ 0x1032, 0x0803 }, { 0x1036, 0x5a10 }, { 0x1046, 0x0100 }, { 0x1050, 0x8050 },
+	{ 0x1052, 0x0803 }, { 0x1056, 0x0010 }, { 0x1066, 0x4b00 }, { 0x106e, 0x0400 },
+	{ 0x1070, 0x807c }, { 0x1076, 0x0010 }, { 0x1086, 0x3b00 }, { 0x109c, 0x0001 },
+	{ 0x10a0, 0x9758 }, { 0x10a6, 0x0010 }, { 0x10a8, 0x8208 }, { 0x10ae, 0x0010 },
+	{ 0x10b6, 0x4b00 }, { 0x10c8, 0x801c }, { 0x10ca, 0x00d0 }, { 0x10cc, 0x0001 },
+	{ 0x10ce, 0x0010 }, { 0x10d0, 0x8060 }, { 0x10d2, 0x0084 }, { 0x10d6, 0x0010 },
+	{ 0x10e6, 0x7b00 }, { 0x10f0, 0x807c }, { 0x10f6, 0x0010 }, { 0x1108, 0x8000 },
+	{ 0x110c, 0x0001 }, { 0x110e, 0x0010 }, { 0x1118, 0x802c }, { 0x111a, 0x0d00 },
+	{ 0x111c, 0x0001 }, { 0x111e, 0x0010 }, { 0x1120, 0x8020 }, { 0x1122, 0x0803 },
+	{ 0x1126, 0x0010 }, { 0x1136, 0x2b00 }, { 0x113e, 0x0800 }, { 0x1148, 0x807c },
+	{ 0x114e, 0x0010 }, { 0x1160, 0x8000 }, { 0x1164, 0x0001 }, { 0x1166, 0x0010 },
+	{ 0x1170, 0x9758 }, { 0x1176, 0x0010 }, { 0x1178, 0x8008 }, { 0x117e, 0x0010 },
+	{ 0x1190, 0xc068 }, { 0x1196, 0x0010 },
+};
+
+static const u16 dram_acsm_sram[] __section(".init.rodata") = {
+	0x0010, 0x0400, 0x080e, 0x000b, 0x0480, 0x0809, 0x0009, 0x0308,
+	0x0c09, 0x0028, 0x8160, 0x087c, 0x0098, 0x0820, 0x0c7e, 0x0002,
+	0x0001, 0x0078, 0x000a, 0x0370, 0x0839, 0x0018, 0x8160, 0x083c,
+	0x0009, 0x0150, 0x0839, 0x0070, 0x0392, 0x0039, 0x0078, 0x039a,
+	0x0039, 0x0e09, 0x0100, 0x0839, 0x0002, 0x0001, 0x0038, 0x0000,
+	0x0100, 0x0839, 0x0000, 0x0398, 0x0839, 0x0e19, 0x0100, 0x0839,
+	0x0002, 0x0001, 0x0038, 0x0000, 0x0100, 0x0839, 0x0000, 0x0390,
+	0x0839, 0x0078, 0x039a, 0x0039, 0x0e29, 0x0100, 0x0839, 0x0002,
+	0x0001, 0x0038, 0x0000, 0x0100, 0x0839, 0x0070, 0x0392, 0x0039,
+	0x0000, 0x00f0, 0x0909, 0x0018, 0x8160, 0x08bc, 0x0008, 0x013a,
+	0x00b9, 0x024b, 0x0100, 0x08b9, 0x0002, 0x0001, 0x00b8, 0x0000,
+	0x0100, 0x08b9, 0x0020, 0x0004, 0x00b8, 0x0020, 0x0004, 0x00b8,
+	0x0005, 0x0000, 0x00b8, 0x0479, 0xc7f8, 0x08bc, 0x0000, 0x0000,
+	0x00b8, 0x0000, 0x00a8, 0x08b9, 0x0009, 0xc9c0, 0x0cbc, 0x0000,
+	0x0000, 0x00b8, 0x025b, 0x0100, 0x0cb9, 0x0020, 0x0004, 0x00b8,
+	0x0020, 0x0004, 0x00b8, 0x0020, 0x0004, 0x00b8, 0x0020, 0x0004,
+	0x00b8, 0x0010, 0x0400, 0x089e, 0x0008, 0x0370, 0x0839, 0x0000,
+	0x00f0, 0x0909, 0x033b, 0x0100, 0x08b9, 0x0000, 0x0100, 0x08b9,
+	0x023b, 0x0100, 0x0c99, 0x0002, 0x0150, 0x0839, 0x1800, 0x8660,
+	0x0839, 0x0000, 0x02a0, 0x0809, 0x0008, 0x1880, 0x0839, 0x0000,
+	0x82b0, 0x0838, 0x0018, 0x00e0, 0x0809, 0x0000, 0x00e0, 0x0869,
+	0x000f, 0x07c0, 0x0839, 0x000a, 0x0510, 0x0839, 0x000a, 0x0700,
+	0x0849, 0x000a, 0x0700, 0x0859, 0x000a, 0x0708, 0x0859, 0x0002,
+	0x0708, 0x0849, 0x0ff8, 0x8410, 0x0839, 0x7ff8, 0x8498, 0x0838,
+	0x0010, 0x8160, 0x083c, 0x0000, 0x07c8, 0x0809, 0x0000, 0x0001,
+	0x0008, 0x0000, 0x045a, 0x0089, 0x0000, 0x8018, 0x0808, 0x0000,
+	0x8020, 0x0808, 0x0479, 0xc7f8, 0x080c, 0x0000, 0x0000, 0x0008,
+	0x0000, 0x8018, 0x0808, 0x0000, 0x8020, 0x0808, 0x0009, 0xc9c0,
+	0x0c0c, 0x0000, 0x00a8, 0x08c9, 0x0029, 0x8160, 0x087c, 0x00b8,
+	0x0820, 0x0c7e, 0x0001, 0x0000, 0x0078, 0x0000, 0x0001, 0x0078,
+	0x00d8, 0x0820, 0x0c7e, 0x0001, 0x0000, 0x0078, 0x0000, 0x0001,
+	0x0078, 0x00f8, 0x0820, 0x0c7e, 0x0001, 0x0000, 0x0078, 0x0000,
+	0x0001, 0x0078, 0x0000, 0x0700, 0x0849, 0x0000, 0x0618, 0x0809,
+	0x3ff8, 0x84b8, 0x0808, 0x0000, 0x0000, 0x0008, 0x0008, 0xc870,
+	0x0c0c, 0x0018, 0x0710, 0x0849, 0x0000, 0x0004, 0x0048, 0x0000,
+	0x0004, 0x0048, 0x0010, 0x0710, 0x0849, 0x0000, 0x0004, 0x0048,
+	0x0000, 0x0710, 0x0849, 0x0000, 0x0004, 0x0048, 0x0000, 0x0004,
+	0x0018, 0x0000, 0x0004, 0x0018, 0x0000, 0x0004, 0x0018, 0x0000,
+	0x8410, 0x0809, 0x0000, 0x8498, 0x0808, 0x0005, 0x0510, 0x0809,
+	0x0198, 0x1000, 0x0809, 0x0009, 0x03c0, 0x0809, 0x0010, 0x0510,
+	0x0809, 0x0000, 0x03c0, 0x0809, 0x0018, 0x0004, 0x0008, 0x0002,
+	0x0510, 0x0809, 0x0002, 0x1000, 0x0809, 0x0068, 0x801a, 0x0008,
+	0x0068, 0x8022, 0x0008, 0x0479, 0xc7f8, 0x080c, 0x0000, 0x0000,
+	0x0008, 0x0068, 0x801a, 0x0008, 0x0068, 0x8022, 0x0008, 0x0009,
+	0xc9c0, 0x0c0c, 0x0000, 0xc870, 0x0c0c, 0x0000, 0x02a0, 0x0809,
+	0x0010, 0x8160, 0x089c, 0x0002, 0x07c8, 0x0809, 0x0000, 0x0001,
+	0x0008, 0x0040, 0x1932, 0x0129, 0x000a, 0xc140, 0x080c, 0x0098,
+	0x193a, 0x0129, 0x0090, 0x1932, 0x0329, 0x0090, 0x193a, 0x0329,
+	0x0088, 0x1882, 0x0009, 0x0000, 0xc140, 0x080c, 0x0010, 0x0400,
+	0x080e, 0x000b, 0x0370, 0x08f9, 0x023b, 0x0100, 0x0cf9, 0x0000,
+	0x02a0, 0x0809, 0x7800, 0x8660, 0x0809, 0x000b, 0x0370, 0x0809,
+	0x000d, 0x07c0, 0x0809, 0x0000, 0x82b0, 0x0818, 0x0000, 0x82b0,
+	0x0868, 0x0479, 0xc7f8, 0x091c, 0x0000, 0x0000, 0x0118, 0x0038,
+	0x80a2, 0x0118, 0x0009, 0xc9c0, 0x0d1c, 0x0000, 0x0000, 0x0118,
+	0x0008, 0x0508, 0x0809, 0x0005, 0x07c0, 0x0809, 0x0008, 0x82b0,
+	0x0868, 0x0008, 0x82b0, 0x0818, 0x0008, 0x82b0, 0x0888, 0x0010,
+	0x0510, 0x0809, 0x0000, 0x00a8, 0x08c9, 0x0008, 0x1900, 0x0c09,
+	0x0002, 0x0000, 0x0008, 0x0000, 0x0508, 0x0809, 0x0002, 0x07c8,
+	0x0829, 0x000a, 0x03c8, 0x0c29, 0x0199, 0x03d0, 0x0c19, 0x0003,
+	0x0000, 0x0018, 0x0038, 0x0004, 0x0018, 0x0199, 0x03d0, 0x0c09,
+	0x0000, 0x0000, 0x0008, 0x0009, 0x0150, 0x0809, 0x0009, 0xc800,
+	0x0c0c, 0x0018, 0x8160, 0x08cc, 0x0008, 0x013a, 0x00c9, 0x024b,
+	0x0100, 0x08c9, 0x0002, 0x0001, 0x00c8, 0x0000, 0x0100, 0x08c9,
+	0x0020, 0x0004, 0x00c8, 0x0020, 0x0004, 0x00c8, 0x0005, 0x0000,
+	0x00c8, 0x0479, 0xc7f8, 0x08cc, 0x0000, 0x0000, 0x00c8, 0x0030,
+	0x00aa, 0x00c9, 0x0009, 0xc9c0, 0x0ccc, 0x0000, 0x0000, 0x00c8,
+	0x0479, 0xc7f8, 0x08bc, 0x0000, 0x0000, 0x00b8, 0x0030, 0x00aa,
+	0x00b9, 0x0009, 0xc9c0, 0x0cbc, 0x0000, 0x0000, 0x00b8, 0x025b,
+	0x0100, 0x0cc9, 0x0020, 0x0004, 0x00c8, 0x0020, 0x0004, 0x00c8,
+	0x0020, 0x0004, 0x00a8, 0x0004, 0x0000, 0x00c8, 0x0009, 0xc800,
+	0x0c6c, 0x026f, 0x0100, 0x0c19, 0x0008, 0x0004, 0x0018, 0x027f,
+	0x0100, 0x0c19, 0x0479, 0xc7f8, 0x080c, 0x0000, 0x0000, 0x0008,
+	0x0058, 0x008a, 0x0009, 0x0009, 0xc9c0, 0x0c0c, 0x0000, 0x0000,
+	0x0008, 0x0018, 0x8160, 0x086c, 0x1008, 0x853b, 0x0868, 0x0c00,
+	0x8588, 0x0868, 0x0008, 0x85a8, 0x0868, 0x0008, 0x85c8, 0x0868,
+	0x0000, 0x8050, 0x0868, 0x0060, 0x0138, 0x0869, 0x0018, 0x8510,
+	0x0868, 0x0018, 0x02c8, 0x0869, 0x0010, 0x8520, 0x0868, 0x1ff8,
+	0x85d8, 0x0c68, 0x0000, 0xfdf0, 0x0868, 0x0008, 0x85f0, 0x0868,
+	0x0008, 0xa5f0, 0x0868, 0x0298, 0x0100, 0x0869, 0x0002, 0x0001,
+	0x0068, 0x0000, 0x0100, 0x0869, 0x0000, 0x85f0, 0x0868, 0x0000,
+	0xa5f0, 0x0868, 0x033b, 0x0100, 0x08c9, 0x0000, 0x0100, 0x08c9,
+	0x1ff8, 0x85d8, 0x0c68, 0x0008, 0x8df0, 0x0868, 0x0008, 0xadf0,
+	0x0868, 0x02a8, 0x0100, 0x0869, 0x0002, 0x0001, 0x0068, 0x0000,
+	0x0100, 0x0869, 0x0000, 0x8df0, 0x0868, 0x0000, 0xadf0, 0x0868,
+	0x0010, 0x02c8, 0x0869, 0x0028, 0x0004, 0x0068, 0x000a, 0x0500,
+	0x0c69, 0x0000, 0x8520, 0x0868, 0x0008, 0x8530, 0x0808, 0x02ba,
+	0x0100, 0x0869, 0x0002, 0x0001, 0x0068, 0x0002, 0x0100, 0x0869,
+	0x0000, 0x8530, 0x0808, 0x0000, 0x8510, 0x0868, 0x0000, 0x02c8,
+	0x0869, 0x0008, 0x8050, 0x0868, 0x0030, 0x0004, 0x0068, 0x0008,
+	0x8520, 0x0868, 0x0000, 0x8328, 0x086b, 0x02ca, 0x0100, 0x0869,
+	0x0002, 0x0001, 0x0068, 0x0004, 0x0100, 0x0869, 0x0ff8, 0x8328,
+	0x086b, 0x0009, 0x0500, 0x0c29, 0x0000, 0x8520, 0x0868, 0x0008,
+	0x03c8, 0x0c29, 0x0000, 0x0150, 0x0809, 0x0002, 0x0370, 0x0809,
+	0x0000, 0x0400, 0x080e, 0x0010, 0x0004, 0x0118, 0x0020, 0x82b0,
+	0x0808, 0x0479, 0xc7f8, 0x080c, 0x0000, 0x0000, 0x0008, 0x0060,
+	0x008a, 0x0009, 0x0009, 0xc9c0, 0x0c0c, 0x0000, 0x0000, 0x0008,
+	0x0008, 0x02a0, 0x0809, 0x0048, 0xc822, 0x000c, 0x0048, 0xcc32,
+	0x000c, 0x0009, 0xc800, 0x0c0c, 0x0000, 0x8168, 0x080c, 0x0479,
+	0xc7f8, 0x091c, 0x0000, 0x0000, 0x0118, 0x9190, 0x80a1, 0x0918,
+	0x0009, 0xc9c0, 0x0d1c, 0x0000, 0x0000, 0x0118, 0x0018, 0x00f0,
+	0x0909, 0x0008, 0x0300, 0x0819, 0x0010, 0x8160, 0x080c, 0x0008,
+	0x07c8, 0x0801, 0x0008, 0x0000, 0x0008, 0x0008, 0x1880, 0x0809,
+	0x0010, 0x8160, 0x083c, 0x1800, 0x8660, 0x0839, 0x4000, 0x8668,
+	0x0839, 0x0000, 0x00f0, 0x0909, 0x000f, 0x07c0, 0x0809, 0x0000,
+	0x02a0, 0x0809, 0x0008, 0x0618, 0x0809, 0x0000, 0x84b8, 0x0808,
+	0x0ff8, 0x8410, 0x0809, 0x7ff8, 0x8498, 0x0808, 0x0000, 0x07c8,
+	0x0809, 0x0008, 0x8168, 0x080c, 0x0000, 0x0001, 0x0008, 0x0000,
+	0x0004, 0x0008, 0x0000, 0x0004, 0x0008, 0x0018, 0x0300, 0x0809,
+	0x0000, 0x0480, 0x0809, 0x0008, 0x0510, 0x0809, 0x7800, 0x8660,
+	0x0809, 0x0018, 0x00f0, 0x0909, 0x0008, 0x07c8, 0x0801, 0x0010,
+	0x0400, 0x080e, 0x0008, 0x0150, 0x0809, 0x0009, 0x0370, 0x0809,
+	0x0018, 0x8160, 0x080c, 0x0008, 0xc800, 0x0c0c, 0x0008, 0xc888,
+	0x0c04, 0x0020, 0x8302, 0x000b, 0x0018, 0x8582, 0x0008, 0x9000,
+	0x8539, 0x0808, 0x0000, 0x8588, 0x0808, 0x0040, 0x85c8, 0x0808,
+	0x0000, 0xfdf0, 0x0808, 0x0800, 0xc5f0, 0x0808, 0x1ff8, 0xfdd8,
+	0x0c08, 0x0018, 0xfda8, 0x0808, 0x0040, 0x8520, 0x08d8, 0x0080,
+	0x8520, 0x08e8, 0x030a, 0x0100, 0x08d9, 0x032a, 0x0100, 0x08e9,
+	0x0000, 0x0001, 0x0008, 0x0000, 0x0100, 0x0809, 0x1ff8, 0xfdd8,
+	0x0c08, 0x0008, 0xfda8, 0x0808, 0x0140, 0x8520, 0x08d8, 0x0180,
+	0x8520, 0x08e8, 0x030a, 0x0100, 0x08d9, 0x032a, 0x0100, 0x08e9,
+	0x0000, 0x0001, 0x0008, 0x0000, 0x0100, 0x0809, 0x0002, 0x8520,
+	0x0808, 0x0009, 0x0500, 0x0c09, 0x0010, 0x82b0, 0x0808, 0x0000,
+	0x8520, 0x0808, 0x0008, 0x03c8, 0x0c09, 0x0000, 0x0150, 0x0809,
+	0x0002, 0x0370, 0x0809, 0x0000, 0x0400, 0x080e, 0x0008, 0xc848,
+	0x0c0c, 0x0000, 0xc890, 0x0804, 0x0020, 0x8302, 0x000b, 0x0018,
+	0x8582, 0x0008, 0x0000, 0x82b0, 0x0808, 0x1000, 0x8539, 0x0808,
+	0x0000, 0x8588, 0x0808, 0x0040, 0x85c8, 0x0808, 0x07f8, 0xfdf0,
+	0x0808, 0x0800, 0xc5f0, 0x0808, 0x0080, 0x8088, 0x080b, 0x1ff8,
+	0xfdd8, 0x0c08, 0x0018, 0xfda8, 0x0808, 0x0200, 0x8520, 0x08d8,
+	0x0400, 0x8520, 0x08e8, 0x02da, 0x0100, 0x08d9, 0x02ea, 0x0100,
+	0x08e9, 0x0002, 0x0001, 0x0008, 0x0000, 0x0100, 0x0809, 0x1ff8,
+	0xfdd8, 0x0c08, 0x0008, 0xfda8, 0x0808, 0x0a00, 0x8520, 0x08d8,
+	0x0c00, 0x8520, 0x08e8, 0x02da, 0x0100, 0x08d9, 0x02ea, 0x0100,
+	0x08e9, 0x0000, 0x0001, 0x0008, 0x0000, 0x0100, 0x0809, 0x0009,
+	0x0500, 0x0c09, 0x0010, 0x82b0, 0x0808, 0x0000, 0x8520, 0x0808,
+	0x0008, 0x03c8, 0x0c09, 0x0000, 0x0150, 0x0809, 0x0002, 0x0370,
+	0x0809, 0x0000, 0x0400, 0x080e, 0x0008, 0xc848, 0x0c0c, 0x0000,
+	0xc890, 0x0804, 0x1008, 0x853b, 0x0808, 0x0c00, 0x8588, 0x0808,
+	0x0008, 0x85a8, 0x0808, 0x0008, 0x85c8, 0x0808, 0x0060, 0x0138,
+	0x0809, 0x0018, 0x00c8, 0x0809, 0x0000, 0x00a4, 0x0809, 0x0000,
+	0x8510, 0x0808, 0x02fa, 0x0100, 0x08d9, 0x031a, 0x0100, 0x08e9,
+	0x0002, 0x0001, 0x0008, 0x0002, 0x0100, 0x0809, 0x0202, 0x8510,
+	0x0c08, 0x0050, 0x00a2, 0x0009, 0x0000, 0x0000, 0x0008, 0x0000,
+	0x0000, 0x0008, 0x0000, 0x0000, 0x0008, 0x0000, 0x00c8, 0x0809,
+	0x000b, 0x0508, 0x0809, 0x0008, 0x1900, 0x0c09, 0x0002, 0x0000,
+	0x0008, 0x0000, 0x0508, 0x0809, 0x0009, 0x0500, 0x0c09, 0x0010,
+	0x82b0, 0x0808, 0x0000, 0x8520, 0x0808, 0x0008, 0x03c8, 0x0c09,
+	0x0000, 0x0150, 0x0809, 0x0002, 0x0370, 0x0809, 0x0000, 0x0400,
+	0x080e, 0x0008, 0xc848, 0x0c0c, 0x0000, 0xc890, 0x0804, 0x0020,
+	0x8302, 0x000b, 0x0018, 0x8582, 0x0008, 0x1000, 0x8539, 0x0808,
+	0x0000, 0x8588, 0x0808, 0x0040, 0x85c8, 0x0808, 0x0008, 0xfdf0,
+	0x0808, 0x0080, 0x8088, 0x080b, 0x0000, 0x03b8, 0x0869, 0x1ff8,
+	0xfdd8, 0x0c08, 0x0018, 0xfda8, 0x0808, 0x0040, 0x8520, 0x08d8,
+	0x0080, 0x8520, 0x08e8, 0x02da, 0x0100, 0x08d9, 0x02ea, 0x0100,
+	0x08e9, 0x0002, 0x0001, 0x0008, 0x0000, 0x0100, 0x0809, 0x1ff8,
+	0xfdd8, 0x0c08, 0x0008, 0xfda8, 0x0808, 0x0140, 0x8520, 0x08d8,
+	0x0180, 0x8520, 0x08e8, 0x02da, 0x0100, 0x08d9, 0x02ea, 0x0100,
+	0x08e9, 0x0000, 0x0001, 0x0008, 0x0000, 0x0100, 0x0809, 0x0009,
+	0x0500, 0x0c09, 0x0010, 0x82b0, 0x0808, 0x0000, 0x8520, 0x0808,
+	0x0008, 0x03c8, 0x0c09, 0x0000, 0x0150, 0x0809, 0x0002, 0x0370,
+	0x0809, 0x0000, 0x0400, 0x080e, 0x0008, 0xc848, 0x0c0c, 0x0000,
+	0xc890, 0x0804,
+};
+
+static const struct sunxi_dram_reg dram_acsm_ctrl_regs[] __section(".init.rodata") = {
+	{ 0x0aaa01ce, 0x0600 },
+	{ 0x0aa20038, 0x0000 },
+	{ 0x0aa20040, 0x0077 },
+	{ 0x0aa20048, 0x0082 },
+	{ 0x0aa2004a, 0x002b },
+	{ 0x0aa2004c, 0x002b },
+	{ 0x0aa20056, 0x010e },
+	{ 0x0aa20e10, 0x0125 },
+	{ 0x0aa20e00, 0x014c },
+	{ 0x0aa20e02, 0x016e },
+	{ 0x0aa20e04, 0x018d },
+	{ 0x0aa20e06, 0x012b },
+	{ 0x0aa20e08, 0x0000 },
+	{ 0x0aa20e0a, 0x0000 },
+	{ 0x0aa20e0c, 0x0000 },
+	{ 0x0aa20e0e, 0x0000 },
+	{ 0x0a940314, 0x0000 },
+};
+
+static const u16 dram_pie_ptrs[] __section(".init.rodata") = {
+	0x0001, 0x0016, 0x0039, 0x004e, 0x0001, 0x0016, 0x0039, 0x004e,
+	0x0017, 0x0027, 0x004f, 0x005f, 0x0017, 0x0027, 0x004f, 0x005f,
+	0x0028, 0x0038, 0x0060, 0x0070, 0x0028, 0x0038, 0x0060, 0x0070,
+	0x0080, 0x0080, 0x0080, 0x0080, 0x0080, 0x0080, 0x0080, 0x0080,
+	0x0071, 0x0074, 0x0077, 0x007a, 0x0071, 0x0074, 0x0077, 0x007a,
+	0x0075, 0x0076, 0x007b, 0x007c, 0x0075, 0x0076, 0x007b, 0x007c,
+	0x007d, 0x007e, 0x007d, 0x007e, 0x007d, 0x007e, 0x007d, 0x007e,
+	0x007f, 0x007f, 0x007f, 0x007f, 0x007f, 0x007f, 0x007f, 0x007f,
+	0x0080, 0x007f, 0x0080, 0x007f, 0x0080, 0x007f, 0x0080, 0x007f,
+	0x0081, 0x0093, 0x0081, 0x0093, 0x010a, 0x011b, 0x010a, 0x011b,
+	0x0094, 0x009b, 0x0094, 0x009b, 0x011c, 0x0122, 0x011c, 0x0122,
+	0x009c, 0x00af, 0x009c, 0x00af, 0x0123, 0x0132, 0x0123, 0x0132,
+	0x00b0, 0x00c0, 0x00b0, 0x00c0, 0x0133, 0x0143, 0x0133, 0x0143,
+	0x00c1, 0x00ca, 0x00c1, 0x00ca, 0x0144, 0x014d, 0x0144, 0x014d,
+	0x00cb, 0x00d4, 0x00cb, 0x00d4, 0x014e, 0x0157, 0x014e, 0x0157,
+	0x00d5, 0x00df, 0x00d5, 0x00df, 0x0158, 0x0161, 0x0158, 0x0161,
+	0x00e0, 0x00ee, 0x00e0, 0x00ee, 0x0162, 0x0170, 0x0162, 0x0170,
+	0x00ef, 0x00f9, 0x00ef, 0x00f9, 0x0171, 0x017a, 0x0171, 0x017a,
+	0x00fa, 0x0108, 0x00fa, 0x0108, 0x017b, 0x0189, 0x017b, 0x0189,
+	0x0109, 0x0109, 0x0109, 0x0109, 0x018a, 0x018a, 0x018a, 0x018a,
+};
+
+static const struct sunxi_dram_reg dram_pie_patch_regs[] __section(".init.rodata") = {
+	{ 0x0a982c26, 0x0b00 },
+	{ 0x0a982c2e, 0x0000 },
+	{ 0x0a982c76, 0x0b00 },
+	{ 0x0a982c7e, 0x0000 },
+	{ 0x0a982cc6, 0x0b00 },
+	{ 0x0a982cce, 0x0000 },
+	{ 0x0a982d16, 0x0b00 },
+	{ 0x0a982d1e, 0x0000 },
+	{ 0x0a982e46, 0x0b00 },
+	{ 0x0a982e4e, 0x0000 },
+	{ 0x0a982e96, 0x0b00 },
+	{ 0x0a982e9e, 0x0000 },
+	{ 0x0a982fe6, 0x0b00 },
+	{ 0x0a982fee, 0x0000 },
+	{ 0x0a983036, 0x0b00 },
+	{ 0x0a98303e, 0x0000 },
+	{ 0x0a983456, 0x5b00 },
+	{ 0x0a98345e, 0x0000 },
+	{ 0x0a9834a6, 0x7b00 },
+	{ 0x0a9834ae, 0x0400 },
+	{ 0x0a9834f6, 0x5b00 },
+	{ 0x0a9834fe, 0x0000 },
+	{ 0x0a983546, 0x7b00 },
+	{ 0x0a98354e, 0x0400 },
+	{ 0x0a983666, 0x5b00 },
+	{ 0x0a98366e, 0x0000 },
+	{ 0x0a9836b6, 0x7b00 },
+	{ 0x0a9836be, 0x0400 },
+	{ 0x0a9837f6, 0x5b00 },
+	{ 0x0a9837fe, 0x0000 },
+	{ 0x0a983846, 0x7b00 },
+	{ 0x0a98384e, 0x0400 },
+};
+
+static const struct sunxi_dram_reg dram_pie_pre_lane_regs[] __section(".init.rodata") = {
+	{ 0x0aa80002, 0x5061 },
+	{ 0x0aa80004, 0x7098 },
+	{ 0x0aa80006, 0x0000 },
+	{ 0x0aa80000, 0xbedc },
+	{ 0x0aa8000c, 0xb0db },
+	{ 0x0aa8000e, 0x0000 },
+	{ 0x0aa20e18, 0x0000 },
+	{ 0x0aa20e1a, 0x07ff },
+	{ 0x0aa20e1c, 0x0668 },
+	{ 0x0aa20e1e, 0x7910 },
+	{ 0x0aa20e20, 0x355e },
+	{ 0x0aa20e22, 0xcbb5 },
+	{ 0x0aa20e26, 0xffff },
+	{ 0x0aa20e28, 0x0710 },
+	{ 0x0aa20e2a, 0x7800 },
+	{ 0x0aa21820, 0xffff },
+	{ 0x0aa21824, 0xff10 },
+	{ 0x0aa20e24, 0x2ee8 },
+	{ 0x0aa21822, 0xffff },
+	{ 0x0aa20e2c, 0xffdf },
+	{ 0x0aa20e2e, 0x6f10 },
+	{ 0x0aa20e30, 0x6f10 },
+	{ 0x0aa20e32, 0x2868 },
+	{ 0x0aa20e34, 0x2868 },
+	{ 0x0aa20e36, 0xfeef },
+	{ 0x0aa21208, 0xe400 },
+	{ 0x0aa2130c, 0xe400 },
+	{ 0x0aa21240, 0x0000 },
+	{ 0x0aa21242, 0x0000 },
+	{ 0x0aa21244, 0x0000 },
+	{ 0x0aa21246, 0x0000 },
+	{ 0x0aa21248, 0xff00 },
+	{ 0x0aa2124a, 0xff00 },
+	{ 0x0aa2124c, 0xff00 },
+	{ 0x0aa2124e, 0xff00 },
+	{ 0x0aa21260, 0x4000 },
+	{ 0x0aa21262, 0x2000 },
+	{ 0x0aa21264, 0xff00 },
+	{ 0x0aa21266, 0xff00 },
+	{ 0x0aa21214, 0x0000 },
+	{ 0x0aa21218, 0x0000 },
+	{ 0x0aa2121a, 0x0001 },
+	{ 0x0a9401e0, 0x27f7 },
+	{ 0x0a9401e2, 0x2108 },
+	{ 0x0a9401e4, 0x2108 },
+	{ PHY_BCAST_DBYTE | 0x0a920172, 0x0001 },
+	{ PHY_BCAST_DBYTE | 0x0a920162, 0x0180 },
+	{ PHY_BCAST_DBYTE | 0x0a920174, 0x0001 },
+	{ PHY_BCAST_DBYTE | 0x0a920144, 0x0000 },
+	{ PHY_BCAST_DBYTE | 0x0a92016a, 0x0001 },
+};
+
+static const struct sunxi_dram_reg dram_pie_tail_regs[] __section(".init.rodata") = {
+	{ 0x0a9e00ca, 0x01ff },
+	{ 0x0a9400fc, 0x0033 },
+	{ 0x0a9401de, 0xffff },
+	{ 0x0aa21220, 0x0002 },
+	{ 0x0a940620, 0x0001 },
+	{ 0x0a940622, 0x0001 },
+	{ 0x0aa80100, 0x0002 },
+	{ 0x0aaa0006, 0x0000 },
+	{ 0x0aaa0000, 0x0001 },
+	{ 0x0aaa0000, 0x0000 },
+	{ 0x0aa80100, 0x0003 },
+	{ 0x0aa80100, 0x0000 },
+	{ 0x0aaa0000, 0x0001 },
+};
+
+static const struct sunxi_dram_reg dram_post_pmu_ch_regs[] __section(".init.rodata") = {
+	{ 0x0a110b84, 0x00000001 },
+	{ 0x0a110c80, 0x00000000 },
+	{ 0x0a100d04, 0x0000090b },
+	{ 0x0a100d08, 0x00001221 },
+	{ 0x0a100008, 0x070d1011 },
+	{ 0x0a100060, 0x000e120c },
+	{ 0x0a100024, 0x0002040d },
+	{ 0x0a100584, 0x00070303 },
+	{ 0x0aaa0000, 0x0000 },
+	{ 0x0aaa0000, 0x0001 },
+	{ 0x0a100588, 0x00152f17 },
+	{ 0x0a110c80, 0x00000001 },
+	{ 0x0a110b84, 0x00000000 },
+};
+
+static const struct sunxi_dram_reg dram_post_pmu_tail_regs[] __section(".init.rodata") = {
+	{ 0x0a110c80, 0x00000000 },
+	{ 0x0a510c80, 0x00000000 },
+	{ 0x0a110510, 0x00011015 },
+	{ 0x0a510510, 0x00011015 },
+	{ 0x0a110510, 0x00011035 },
+	{ 0x0a510510, 0x00011035 },
+	{ 0x0a110c80, 0x00000001 },
+	{ 0x0a510c80, 0x00000001 },
+	{ 0x07010250, 0x00000001 },
+	{ 0x0a110c80, 0x00000000 },
+	{ 0x0a510c80, 0x00000000 },
+	{ 0x0a110510, 0x00011015 },
+	{ 0x0a510510, 0x00011015 },
+	{ 0x0a110180, 0x00000000 },
+	{ 0x0a510180, 0x00000000 },
+	{ 0x0a110510, 0x00011014 },
+	{ 0x0a510510, 0x00011014 },
+	{ 0x0a110c80, 0x00000001 },
+	{ 0x0a510c80, 0x00000001 },
+	{ 0x0a110c80, 0x00000000 },
+	{ 0x0a510c80, 0x00000000 },
+	{ 0x0a110208, 0x00000000 },
+	{ 0x0a510208, 0x00000000 },
+	{ 0x0a110510, 0x00015014 },
+	{ 0x0a510510, 0x00015014 },
+	{ 0x0a110c80, 0x00000001 },
+	{ 0x0a510c80, 0x00000001 },
+	{ 0x02024818, 0x00008002 },
+	{ 0x0202481c, 0xffffffff },
+	{ 0x0a030018, 0x00008002 },
+	{ 0x0a040018, 0x00008002 },
+	{ 0x0a030068, 0xffffffff },
+	{ 0x0a040068, 0xffffffff },
+	{ 0x02024838, 0x00000002 },
+	{ 0x0202448c, 0x00000002 },
+	{ 0x0202468c, 0x00000002 },
+	{ 0x02023a04, 0xffffffff },
+	{ 0x02023c04, 0xffffffff },
+	{ 0x02023e04, 0xffffffff },
+	{ 0x02024004, 0xffffffff },
+	{ 0x02024204, 0xffffffff },
+	{ 0x02024490, 0x10102010 },
+	{ 0x02024494, 0x08081008 },
+	{ 0x02024690, 0x10102010 },
+	{ 0x02024694, 0x08081008 },
+};
+
+#endif /* _DRAM_SUN60I_A733_TABLES_H */
-- 
2.53.0

