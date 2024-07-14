Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1612C3DA42
	for <u-boot@archiver.kernel.org>; Sun, 14 Jul 2024 15:09:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E51488403;
	Sun, 14 Jul 2024 17:08:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P+4JbOPb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2A2488498; Sun, 14 Jul 2024 17:08:57 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA138882CE
 for <u-boot@lists.denx.de>; Sun, 14 Jul 2024 17:08:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-70af8062039so2397289b3a.0
 for <u-boot@lists.denx.de>; Sun, 14 Jul 2024 08:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720969732; x=1721574532; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9nHoctLpQhfiBmWOwc16apzP4IWB7y6AU54kJVkayFY=;
 b=P+4JbOPbwJ6IDzYYm5kPFUcrlAk6k3m3WEuZcMeJp5cw4DiB2cD6yJU1BBTYFG0FKq
 pDrHhyuuEFeHGp0CNAaZ6jtHFdBE/ySg4IwU7okxf8DXTdV2mDw9NUXL6ZhzLkabSuhS
 T9TwsBx52TXk7fp2s2s9tvR/wRYUyHK01PjHmg0YFGD2bffoIPyY0PY8JrxEnnzkjyDw
 VcQLDvWXxcEWOOleL/q0wmRI6ZXfv1aRLx9tWSBMBOeqrYRIZx9jLWrNsgs7OeIspwMz
 VWm+OYalwc6Wm9DCl/x3Kjt9prUHygtj2qivdPWobJZBXGRu4TzCFrhxiGhO4M3+xru5
 cQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720969732; x=1721574532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9nHoctLpQhfiBmWOwc16apzP4IWB7y6AU54kJVkayFY=;
 b=Xl4jnlanqwHepomPcZsTkfESz3tm7dpLQBfMl3aNuPW/l4wDRqMSvn3jjozeDCYPmD
 OOyOcy3vHibMrF496r0zKWgI+t8aSw4+aDI2cMfNwO6YgSPHZPJ+GlKdTpZexh4s+AmS
 n15QTEXp19Dl8VBo9gJ4zpVKlpQKBTCpv5iuSCsKlQv5i441rn42SXliLqgWymy0TRmS
 2xkHMBpP05DuoCggFWnKElSqqecmX4JSNmU7AOKH21BP3cmFkxFsMqYFlrqLBmWK1Z/e
 dJXwJHlLxcRwWT2i5ORui0EQ5hl7lI17ir7DaGLlPbm5gZNIY7I8Upcx3qsysofE/f08
 fvGQ==
X-Gm-Message-State: AOJu0Yx6Ti1cEKSazUte/xqUYkyzMi8+diV6Axzj3mbe+ZWKnaNbjBZW
 XWj8Ng77M5rHpgw9w+SA46afQtr6/ukRp0JJg4hXjcfThFk0mXW6UR34c9/z
X-Google-Smtp-Source: AGHT+IFL2GuSnkEPjA+P3EWGPIDBNjcparcFJKGnoTqGjnFgYQHjJUEK6B7yzVqXqgp2EKdIGzwT2g==
X-Received: by 2002:a05:6a00:1401:b0:70a:ff09:f151 with SMTP id
 d2e1a72fcca58-70b43584ffcmr17518992b3a.20.1720969731722; 
 Sun, 14 Jul 2024 08:08:51 -0700 (PDT)
Received: from localhost.localdomain ([117.135.90.188])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7ebc4637sm2686529b3a.88.2024.07.14.08.08.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jul 2024 08:08:51 -0700 (PDT)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, Bin Meng <bmeng@tinylab.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Leo <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>,
 Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>
Subject: [PATCH 1/2] riscv: spacemit: bananapi_f3: initial support added
Date: Sun, 14 Jul 2024 23:08:24 +0800
Message-ID: <20240714150828.736-2-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240714150828.736-1-seashell11234455@gmail.com>
References: <20240714150828.736-1-seashell11234455@gmail.com>
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

Add basic support for SpacemiT's Banana Pi F3 board

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>

---

 arch/riscv/Kconfig                     |   5 +
 arch/riscv/cpu/k1/Kconfig              |  18 ++
 arch/riscv/cpu/k1/Makefile             |   6 +
 arch/riscv/cpu/k1/cpu.c                |   9 +
 arch/riscv/cpu/k1/dram.c               |  39 +++
 arch/riscv/dts/Makefile                |   1 +
 arch/riscv/dts/k1-bananapi-f3.dts      |  20 ++
 arch/riscv/dts/k1.dtsi                 | 375 +++++++++++++++++++++++++
 board/spacemit/bananapi_f3/Kconfig     |  25 ++
 board/spacemit/bananapi_f3/MAINTAINERS |   6 +
 board/spacemit/bananapi_f3/Makefile    |   5 +
 board/spacemit/bananapi_f3/board.c     |   9 +
 configs/bananapi_f3_defconfig          |  20 ++
 include/configs/bananapi_f3.h          |  15 +
 14 files changed, 553 insertions(+)
 create mode 100644 arch/riscv/cpu/k1/Kconfig
 create mode 100644 arch/riscv/cpu/k1/Makefile
 create mode 100644 arch/riscv/cpu/k1/cpu.c
 create mode 100644 arch/riscv/cpu/k1/dram.c
 create mode 100644 arch/riscv/dts/k1-bananapi-f3.dts
 create mode 100644 arch/riscv/dts/k1.dtsi
 create mode 100644 board/spacemit/bananapi_f3/Kconfig
 create mode 100644 board/spacemit/bananapi_f3/MAINTAINERS
 create mode 100644 board/spacemit/bananapi_f3/Makefile
 create mode 100644 board/spacemit/bananapi_f3/board.c
 create mode 100644 configs/bananapi_f3_defconfig
 create mode 100644 include/configs/bananapi_f3.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index fa3b016c52..211f19a585 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -11,6 +11,9 @@ choice
 config TARGET_ANDES_AE350
 	bool "Support Andes ae350"
 
+config TARGET_BANANAPI_F3
+	bool "Support BananaPi F3 Board"
+
 config TARGET_MICROCHIP_ICICLE
 	bool "Support Microchip PolarFire-SoC Icicle Board"
 
@@ -88,6 +91,7 @@ source "board/sifive/unleashed/Kconfig"
 source "board/sifive/unmatched/Kconfig"
 source "board/sipeed/maix/Kconfig"
 source "board/sophgo/milkv_duo/Kconfig"
+source "board/spacemit/bananapi_f3/Kconfig"
 source "board/starfive/visionfive2/Kconfig"
 source "board/thead/th1520_lpi4a/Kconfig"
 source "board/xilinx/mbv/Kconfig"
@@ -99,6 +103,7 @@ source "arch/riscv/cpu/fu540/Kconfig"
 source "arch/riscv/cpu/fu740/Kconfig"
 source "arch/riscv/cpu/generic/Kconfig"
 source "arch/riscv/cpu/jh7110/Kconfig"
+source "arch/riscv/cpu/k1/Kconfig"
 
 # architecture-specific options below
 
diff --git a/arch/riscv/cpu/k1/Kconfig b/arch/riscv/cpu/k1/Kconfig
new file mode 100644
index 0000000000..79c9fefb66
--- /dev/null
+++ b/arch/riscv/cpu/k1/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2024, Kongyang Liu <seashell11234455@gmail.com>
+
+config SPACEMIT_K1
+	bool
+	select BINMAN
+	select ARCH_EARLY_INIT_R
+	select SYS_CACHE_SHIFT_6
+	imply CPU
+	imply CPU_RISCV
+	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
+	imply RISCV_ACLINT if RISCV_MMODE
+	imply SPL_RISCV_ACLINT if SPL_RISCV_MMODE
+	imply CMD_CPU
+	imply SPL_CPU
+	imply SPL_OPENSBI
+	imply SPL_LOAD_FIT
diff --git a/arch/riscv/cpu/k1/Makefile b/arch/riscv/cpu/k1/Makefile
new file mode 100644
index 0000000000..da12e0f64e
--- /dev/null
+++ b/arch/riscv/cpu/k1/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+
+obj-y += dram.o
+obj-y += cpu.o
diff --git a/arch/riscv/cpu/k1/cpu.c b/arch/riscv/cpu/k1/cpu.c
new file mode 100644
index 0000000000..233a6a3d64
--- /dev/null
+++ b/arch/riscv/cpu/k1/cpu.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+ */
+
+int cleanup_before_linux(void)
+{
+	return 0;
+}
diff --git a/arch/riscv/cpu/k1/dram.c b/arch/riscv/cpu/k1/dram.c
new file mode 100644
index 0000000000..41a596eef4
--- /dev/null
+++ b/arch/riscv/cpu/k1/dram.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+ */
+
+#include <asm/global_data.h>
+#include <config.h>
+#include <linux/sizes.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int dram_init(void)
+{
+	gd->ram_base = CFG_SYS_SDRAM_BASE;
+	/* TODO get ram size from ddr controller */
+	gd->ram_size = SZ_4G;
+	return 0;
+}
+
+int dram_init_banksize(void)
+{
+	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+	gd->bd->bi_dram[0].size = min_t(phys_size_t, gd->ram_size, SZ_2G);
+
+	if (gd->ram_size > SZ_2G && CONFIG_NR_DRAM_BANKS > 1) {
+		gd->bd->bi_dram[1].start = 0x100000000;
+		gd->bd->bi_dram[1].size = gd->ram_size - SZ_2G;
+	}
+
+	return 0;
+}
+
+phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
+{
+	if (gd->ram_size > SZ_2G)
+		return SZ_2G;
+
+	return gd->ram_size;
+}
diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index 17cda483e1..71267f96f8 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 dtb-$(CONFIG_TARGET_ANDES_AE350) += ae350_32.dtb ae350_64.dtb
+dtb-$(CONFIG_TARGET_BANANAPI_F3) += k1-bananapi-f3.dtb
 dtb-$(CONFIG_TARGET_MICROCHIP_ICICLE) += mpfs-icicle-kit.dtb
 dtb-$(CONFIG_TARGET_MILKV_DUO) += cv1800b-milkv-duo.dtb
 dtb-$(CONFIG_TARGET_QEMU_VIRT) += qemu-virt32.dtb qemu-virt64.dtb
diff --git a/arch/riscv/dts/k1-bananapi-f3.dts b/arch/riscv/dts/k1-bananapi-f3.dts
new file mode 100644
index 0000000000..542049d9d3
--- /dev/null
+++ b/arch/riscv/dts/k1-bananapi-f3.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
+ */
+
+#include "k1.dtsi"
+#include "binman.dtsi"
+
+/ {
+	model = "Banana Pi BPI-F3";
+	compatible = "bananapi,bpi-f3", "spacemit,k1";
+
+	chosen {
+		stdout-path = "serial0";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/riscv/dts/k1.dtsi b/arch/riscv/dts/k1.dtsi
new file mode 100644
index 0000000000..b301f45fd5
--- /dev/null
+++ b/arch/riscv/dts/k1.dtsi
@@ -0,0 +1,375 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
+ */
+
+/dts-v1/;
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	model = "SpacemiT K1";
+	compatible = "spacemit,k1";
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart2;
+		serial2 = &uart3;
+		serial3 = &uart4;
+		serial4 = &uart5;
+		serial5 = &uart6;
+		serial6 = &uart7;
+		serial7 = &uart8;
+		serial8 = &uart9;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		timebase-frequency = <24000000>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu_0>;
+				};
+				core1 {
+					cpu = <&cpu_1>;
+				};
+				core2 {
+					cpu = <&cpu_2>;
+				};
+				core3 {
+					cpu = <&cpu_3>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu_4>;
+				};
+				core1 {
+					cpu = <&cpu_5>;
+				};
+				core2 {
+					cpu = <&cpu_6>;
+				};
+				core3 {
+					cpu = <&cpu_7>;
+				};
+			};
+		};
+
+		cpu_0: cpu@0 {
+			compatible = "spacemit,x60", "riscv";
+			device_type = "cpu";
+			reg = <0>;
+			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
+					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
+					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
+					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
+					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
+			riscv,cbom-block-size = <64>;
+			riscv,cbop-block-size = <64>;
+			riscv,cboz-block-size = <64>;
+			mmu-type = "riscv,sv39";
+
+			cpu0_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		cpu_1: cpu@1 {
+			compatible = "spacemit,x60", "riscv";
+			device_type = "cpu";
+			reg = <1>;
+			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
+					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
+					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
+					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
+					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
+			riscv,cbom-block-size = <64>;
+			riscv,cbop-block-size = <64>;
+			riscv,cboz-block-size = <64>;
+			mmu-type = "riscv,sv39";
+
+			cpu1_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		cpu_2: cpu@2 {
+			compatible = "spacemit,x60", "riscv";
+			device_type = "cpu";
+			reg = <2>;
+			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
+					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
+					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
+					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
+					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
+			riscv,cbom-block-size = <64>;
+			riscv,cbop-block-size = <64>;
+			riscv,cboz-block-size = <64>;
+			mmu-type = "riscv,sv39";
+
+			cpu2_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		cpu_3: cpu@3 {
+			compatible = "spacemit,x60", "riscv";
+			device_type = "cpu";
+			reg = <3>;
+			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
+					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
+					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
+					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
+					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
+			riscv,cbom-block-size = <64>;
+			riscv,cbop-block-size = <64>;
+			riscv,cboz-block-size = <64>;
+			mmu-type = "riscv,sv39";
+
+			cpu3_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		cpu_4: cpu@4 {
+			compatible = "spacemit,x60", "riscv";
+			device_type = "cpu";
+			reg = <4>;
+			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
+					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
+					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
+					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
+					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
+			riscv,cbom-block-size = <64>;
+			riscv,cbop-block-size = <64>;
+			riscv,cboz-block-size = <64>;
+			mmu-type = "riscv,sv39";
+
+			cpu4_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		cpu_5: cpu@5 {
+			compatible = "spacemit,x60", "riscv";
+			device_type = "cpu";
+			reg = <5>;
+			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
+					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
+					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
+					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
+					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
+			riscv,cbom-block-size = <64>;
+			riscv,cbop-block-size = <64>;
+			riscv,cboz-block-size = <64>;
+			mmu-type = "riscv,sv39";
+
+			cpu5_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		cpu_6: cpu@6 {
+			compatible = "spacemit,x60", "riscv";
+			device_type = "cpu";
+			reg = <6>;
+			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
+					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
+					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
+					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
+					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
+			riscv,cbom-block-size = <64>;
+			riscv,cbop-block-size = <64>;
+			riscv,cboz-block-size = <64>;
+			mmu-type = "riscv,sv39";
+
+			cpu6_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		cpu_7: cpu@7 {
+			compatible = "spacemit,x60", "riscv";
+			device_type = "cpu";
+			reg = <7>;
+			riscv,isa = "rv64imafdcv_zicbom_zicbop_zicboz_zicntr_zicond_zicsr_zifencei_zihintpause_zihpm_zfh_zba_zbb_zbc_zbs_zkt_zvfh_zvkt_sscofpmf_sstc_svinval_svnapot_svpbmt";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "v", "zicbom",
+					       "zicbop", "zicboz", "zicntr", "zicond", "zicsr",
+					       "zifencei", "zihintpause", "zihpm", "zfh", "zba",
+					       "zbb", "zbc", "zbs", "zkt", "zvfh", "zvkt",
+					       "sscofpmf", "sstc", "svinval", "svnapot", "svpbmt";
+			riscv,cbom-block-size = <64>;
+			riscv,cbop-block-size = <64>;
+			riscv,cboz-block-size = <64>;
+			mmu-type = "riscv,sv39";
+
+			cpu7_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+	};
+
+	soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&plic>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		dma-noncoherent;
+		ranges;
+
+		uart0: serial@d4017000 {
+			compatible = "spacemit,k1-uart", "snps,dw-apb-uart";
+			reg = <0x0 0xd4017000 0x0 0x100>;
+			interrupts = <42>;
+			clock-frequency = <14857000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart2: serial@d4017100 {
+			compatible = "spacemit,k1-uart", "snps,dw-apb-uart";
+			reg = <0x0 0xd4017100 0x0 0x100>;
+			interrupts = <44>;
+			clock-frequency = <14857000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart3: serial@d4017200 {
+			compatible = "spacemit,k1-uart", "snps,dw-apb-uart";
+			reg = <0x0 0xd4017200 0x0 0x100>;
+			interrupts = <45>;
+			clock-frequency = <14857000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart4: serial@d4017300 {
+			compatible = "spacemit,k1-uart", "snps,dw-apb-uart";
+			reg = <0x0 0xd4017300 0x0 0x100>;
+			interrupts = <46>;
+			clock-frequency = <14857000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart5: serial@d4017400 {
+			compatible = "spacemit,k1-uart", "snps,dw-apb-uart";
+			reg = <0x0 0xd4017400 0x0 0x100>;
+			interrupts = <47>;
+			clock-frequency = <14857000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart6: serial@d4017500 {
+			compatible = "spacemit,k1-uart", "snps,dw-apb-uart";
+			reg = <0x0 0xd4017500 0x0 0x100>;
+			interrupts = <48>;
+			clock-frequency = <14857000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart7: serial@d4017600 {
+			compatible = "spacemit,k1-uart", "snps,dw-apb-uart";
+			reg = <0x0 0xd4017600 0x0 0x100>;
+			interrupts = <49>;
+			clock-frequency = <14857000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart8: serial@d4017700 {
+			compatible = "spacemit,k1-uart", "snps,dw-apb-uart";
+			reg = <0x0 0xd4017700 0x0 0x100>;
+			interrupts = <50>;
+			clock-frequency = <14857000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart9: serial@d4017800 {
+			compatible = "spacemit,k1-uart", "snps,dw-apb-uart";
+			reg = <0x0 0xd4017800 0x0 0x100>;
+			interrupts = <51>;
+			clock-frequency = <14857000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		plic: interrupt-controller@e0000000 {
+			compatible = "spacemit,k1-plic", "sifive,plic-1.0.0";
+			reg = <0x0 0xe0000000 0x0 0x4000000>;
+			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>,
+					      <&cpu1_intc 11>, <&cpu1_intc 9>,
+					      <&cpu2_intc 11>, <&cpu2_intc 9>,
+					      <&cpu3_intc 11>, <&cpu3_intc 9>,
+					      <&cpu4_intc 11>, <&cpu4_intc 9>,
+					      <&cpu5_intc 11>, <&cpu5_intc 9>,
+					      <&cpu6_intc 11>, <&cpu6_intc 9>,
+					      <&cpu7_intc 11>, <&cpu7_intc 9>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			riscv,ndev = <159>;
+		};
+
+		clint: timer@e4000000 {
+			compatible = "spacemit,k1-clint", "sifive,clint0";
+			reg = <0x0 0xe4000000 0x0 0x10000>;
+			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
+					      <&cpu1_intc 3>, <&cpu1_intc 7>,
+					      <&cpu2_intc 3>, <&cpu2_intc 7>,
+					      <&cpu3_intc 3>, <&cpu3_intc 7>,
+					      <&cpu4_intc 3>, <&cpu4_intc 7>,
+					      <&cpu5_intc 3>, <&cpu5_intc 7>,
+					      <&cpu6_intc 3>, <&cpu6_intc 7>,
+					      <&cpu7_intc 3>, <&cpu7_intc 7>;
+		};
+	};
+};
diff --git a/board/spacemit/bananapi_f3/Kconfig b/board/spacemit/bananapi_f3/Kconfig
new file mode 100644
index 0000000000..0082a0d2af
--- /dev/null
+++ b/board/spacemit/bananapi_f3/Kconfig
@@ -0,0 +1,25 @@
+if TARGET_BANANAPI_F3
+
+config SYS_BOARD
+	default "bananapi_f3"
+
+config SYS_VENDOR
+	default "spacemit"
+
+config SYS_CPU
+	default "k1"
+
+config SYS_CONFIG_NAME
+	default "bananapi_f3"
+
+config TEXT_BASE
+	default 0x00200000
+
+config SPL_OPENSBI_LOAD_ADDR
+	default 0x00000000
+
+config BOARD_SPECIFIC_OPTIONS
+	def_bool y
+	select SPACEMIT_K1
+
+endif
diff --git a/board/spacemit/bananapi_f3/MAINTAINERS b/board/spacemit/bananapi_f3/MAINTAINERS
new file mode 100644
index 0000000000..fc0f8487e6
--- /dev/null
+++ b/board/spacemit/bananapi_f3/MAINTAINERS
@@ -0,0 +1,6 @@
+BananaPi F3
+M:	Kongyang Liu <seashell11234455@gmail.com>
+S:	Maintained
+F:	board/spacemit/bananapi_f3/
+F:	configs/bananapi_f3_defconfig
+F:	doc/board/spacemit/bananapi_f3.rst
diff --git a/board/spacemit/bananapi_f3/Makefile b/board/spacemit/bananapi_f3/Makefile
new file mode 100644
index 0000000000..a087013f5c
--- /dev/null
+++ b/board/spacemit/bananapi_f3/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+
+obj-y := board.o
diff --git a/board/spacemit/bananapi_f3/board.c b/board/spacemit/bananapi_f3/board.c
new file mode 100644
index 0000000000..eaa47be173
--- /dev/null
+++ b/board/spacemit/bananapi_f3/board.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+ */
+
+int board_init(void)
+{
+	return 0;
+}
diff --git a/configs/bananapi_f3_defconfig b/configs/bananapi_f3_defconfig
new file mode 100644
index 0000000000..ce197d60bd
--- /dev/null
+++ b/configs/bananapi_f3_defconfig
@@ -0,0 +1,20 @@
+CONFIG_RISCV=y
+CONFIG_SYS_MALLOC_LEN=0x1000000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x1000000
+CONFIG_DEFAULT_DEVICE_TREE="k1-bananapi-f3"
+CONFIG_SYS_LOAD_ADDR=0x200000
+CONFIG_TARGET_BANANAPI_F3=y
+CONFIG_ARCH_RV64I=y
+CONFIG_RISCV_SMODE=y
+CONFIG_FIT=y
+CONFIG_SYS_BOOTM_LEN=0xa000000
+CONFIG_SUPPORT_RAW_INITRD=y
+CONFIG_SYS_CBSIZE=256
+CONFIG_SYS_PBSIZE=276
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_PROMPT="bananapi_f3# "
+CONFIG_ENV_OVERWRITE=y
+CONFIG_SYS_NS16550=y
+CONFIG_SYS_NS16550_MEM32=y
diff --git a/include/configs/bananapi_f3.h b/include/configs/bananapi_f3.h
new file mode 100644
index 0000000000..872c2014a4
--- /dev/null
+++ b/include/configs/bananapi_f3.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+ *
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#include <linux/serial_reg.h>
+
+#define CFG_SYS_SDRAM_BASE         0x0
+#define CFG_SYS_NS16550_IER        UART_IER_UUE
+
+#endif /* __CONFIG_H */
-- 
2.41.0

