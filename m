Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855AEE7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 05:03:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13589800A5;
	Sun, 15 Dec 2024 06:03:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CaDMFSY4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 219C9800AD; Sun, 15 Dec 2024 06:03:11 +0100 (CET)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4B9F80092
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 06:03:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pericycle.cc@gmail.com
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-725f3594965so2241225b3a.3
 for <u-boot@lists.denx.de>; Sat, 14 Dec 2024 21:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734238986; x=1734843786; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8RiJvP0Nnm7ySVrbrLJkGJv8zMrwgsmzH0aIQHHF0cU=;
 b=CaDMFSY4OCJOBV1DEEFFMj72a8do+kqD5B1tt2Ag6w08SWPoHHAxLo5cnoa+eaiQk2
 c6ZF8qay+xTO2pMLtlQPUMFnGknwYtMcoE3Ly++GEgKXZK/ugaSmAo2AhCtz2bFezWWu
 zgqqzFkFEia9JAze/cMShB4vf7mIUiLoHffRcCtW1wqi1yfj5v47uhAVGJdQusglmHta
 Ja2kSah8V6KEJNp1MlczZb+uUkGIEPCe4P+Gs9DcAAnsCI7FWQoyWpdmjxFAwB0VvPNl
 1u/PHhn2UHXnmnY7NgB/E0TbAydofg94FTHUq23rRuy15cQ+j0pAxpTlyA+X4b8TSLG+
 pMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734238986; x=1734843786;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8RiJvP0Nnm7ySVrbrLJkGJv8zMrwgsmzH0aIQHHF0cU=;
 b=YxvDOXHDFj0/E1zlKY2c7f3LnqXj+pi8ffRktz//rCoerqL++ZFox9qfgk9PdhA+Rr
 hcO5q9ZACgl3Pfh20lf4ZkLFmvxNoiffUO8ROwrm2P/PEdFY/2PHLhlpVIDwgmrlpd1P
 r1+hws0+yV+db+RpKMplUi46N2Fhf76KgbXtRXc7i3sUtUuruqgwuBzlnOV/3d9WKONV
 DCILOmXlArdWp33JIHYYj3OBCVyc8wvWvMuL9pfWZIjta14pxRD7uvuMGb7neQg8rLJZ
 EGhA/IFNnZyCoPbjxRH4tDHDMelIQh/Quin4KM1n51hpnYPzxYNitk0aYZ0dhuI0HLux
 clWQ==
X-Gm-Message-State: AOJu0Yw7mQD2AXzRq3ys88O+v8+nT5Go6+N41Tn3rZ6OkJd/2dgScqND
 roFWenf4k7W4MfyZHsBr+UZiz+Evg0NJTF5ExokdCLOpUbUPlIAV
X-Gm-Gg: ASbGncu+wYgmmCBJ0tlMiFevoZ5TrULD8XXj+2qdDTHYxQnUpCDKfpcisENI1NO4zFy
 PDQDvMiq29PqTw8nKtfEXCkf140Y4EVKXNAeFwFEBFc58n2vQIb5BND2YmT4EKAu5dkPRTtXMeq
 13d3/qy/1bs5ik2QVmd5ueSJS/mpUvh9UiXK0nGdeu6L21Ykz3UwXTB9zGTBepBKleldutAChet
 Tn0RAy3rkJDGECi+HH8AWkapjjxvoGq7pvD1KVGP5RA8yw359ow09ob5DK6Gj3gxcJQKuAwb3jV
 LuskwgkMqoApKc3s6b3A527e6w==
X-Google-Smtp-Source: AGHT+IG6uxL07hUXfjhs2CIV3/JaH2R+GwBtczHXYf8nP/RC0ukOh5inDPrXe1K8fHNovGQ0OIEiqg==
X-Received: by 2002:a05:6a21:9988:b0:1e1:b404:d854 with SMTP id
 adf61e73a8af0-1e1dfd65f1amr11242535637.23.1734238985880; 
 Sat, 14 Dec 2024 21:03:05 -0800 (PST)
Received: from per1cycle.per1cycle (n220246100016.netvigator.com.
 [220.246.100.16]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-801d5c38996sm1965638a12.80.2024.12.14.21.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Dec 2024 21:03:05 -0800 (PST)
From: Huan Zhou <pericycle.cc@gmail.com>
Date: Sun, 15 Dec 2024 13:02:41 +0800
Subject: [PATCH v8 1/2] riscv: spacemit: bananapi_f3: initial support added
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241215-pickup-bpif3-v8-1-c78b96b9927b@gmail.com>
References: <20241215-pickup-bpif3-v8-0-c78b96b9927b@gmail.com>
In-Reply-To: <20241215-pickup-bpif3-v8-0-c78b96b9927b@gmail.com>
To: u-boot@lists.denx.de
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, 
 Marcel Ziswiler <marcel@ziswiler.com>, Bin Meng <bmeng@tinylab.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, Yixun Lan <dlan@gentoo.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 =?utf-8?q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Kever Yang <kever.yang@rock-chips.com>, Leo <ycliang@andestech.com>, 
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Randolph <randolph@andestech.com>, Rick Chen <rick@andestech.com>, 
 Samuel Holland <samuel@sholland.org>, Sumit Garg <sumit.garg@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Yu Chien Peter Lin <peterlin@andestech.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Padmarao Begari <padmarao.begari@amd.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734238968; l=25049;
 i=pericycle.cc@gmail.com; s=20241109; h=from:subject:message-id;
 bh=vt4x+8+u4SCtG35nhFSOcFgzp5oqTSDIb7PyXnO5QVg=;
 b=YBYULLWMqtUP6yCOmFNqhj1yC3avbnfbqW9WKpOc6wa/S+HVh+oXHOIYBZt1u3kngu3VhYygY
 5e437BcL+uIAcNiVEwgGuXkolkjyFeCiXmO5P0V8khEQxnqiZEfOg+a
X-Developer-Key: i=pericycle.cc@gmail.com; a=ed25519;
 pk=Wd3eEYWh1pNETTTXjX4aeanCWrr201iLaYYW5G1BdbU=
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

From: Kongyang Liu <seashell11234455@gmail.com>

Add basic support for SpacemiT's Banana Pi F3 board.
Update the k1.dtsi align with mainline.
Note that the device tree files follow the mainline Linux source[1].

Links: https://patches.linaro.org/project/linux-serial/patch/20240730-k1-01-basic-dt-v5-8-98263aae83be@gentoo.org/ [1]

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
Signed-off-by: Huan Zhou <pericycle.cc@gmail.com>
Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
Reviewed-by: Yixun Lan <dlan@gentoo.org>
Tested-by: Marcel Ziswiler <marcel@ziswiler.com>
---
 arch/riscv/Kconfig                     |   5 +
 arch/riscv/cpu/k1/Kconfig              |  18 ++
 arch/riscv/cpu/k1/Makefile             |   6 +
 arch/riscv/cpu/k1/cpu.c                |   9 +
 arch/riscv/cpu/k1/dram.c               |  54 ++++
 arch/riscv/dts/Makefile                |   2 +
 arch/riscv/dts/k1-bananapi-f3.dts      |  25 ++
 arch/riscv/dts/k1.dtsi                 | 459 +++++++++++++++++++++++++++++++++
 board/spacemit/bananapi-f3/Kconfig     |  25 ++
 board/spacemit/bananapi-f3/MAINTAINERS |   6 +
 board/spacemit/bananapi-f3/Makefile    |   5 +
 board/spacemit/bananapi-f3/board.c     |   9 +
 configs/bananapi-f3_defconfig          |  20 ++
 include/configs/bananapi-f3.h          |  13 +
 14 files changed, 656 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 043d963f63445feff528e0b33c2c360886ca408f..05cdff28acf4048a426885d79e4b81792554cea7 100644
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
 
@@ -92,6 +95,7 @@ source "board/sifive/unleashed/Kconfig"
 source "board/sifive/unmatched/Kconfig"
 source "board/sipeed/maix/Kconfig"
 source "board/sophgo/milkv_duo/Kconfig"
+source "board/spacemit/bananapi-f3/Kconfig"
 source "board/starfive/visionfive2/Kconfig"
 source "board/thead/th1520_lpi4a/Kconfig"
 source "board/xilinx/mbv/Kconfig"
@@ -104,6 +108,7 @@ source "arch/riscv/cpu/fu740/Kconfig"
 source "arch/riscv/cpu/ast2700/Kconfig"
 source "arch/riscv/cpu/generic/Kconfig"
 source "arch/riscv/cpu/jh7110/Kconfig"
+source "arch/riscv/cpu/k1/Kconfig"
 
 # architecture-specific options below
 
diff --git a/arch/riscv/cpu/k1/Kconfig b/arch/riscv/cpu/k1/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..d9cd8dce96426bb4cbe9ff38385a4c66116fe341
--- /dev/null
+++ b/arch/riscv/cpu/k1/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
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
index 0000000000000000000000000000000000000000..bad4f4cf46fb6eb44053dc52df1837b58046c745
--- /dev/null
+++ b/arch/riscv/cpu/k1/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+
+obj-y += dram.o
+obj-y += cpu.o
diff --git a/arch/riscv/cpu/k1/cpu.c b/arch/riscv/cpu/k1/cpu.c
new file mode 100644
index 0000000000000000000000000000000000000000..41a4a1b95e6e4b6dd1580b5f714107cac6c1dc02
--- /dev/null
+++ b/arch/riscv/cpu/k1/cpu.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
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
index 0000000000000000000000000000000000000000..c477c15cbfb19f0e3a0ee72985b602f5bda352d7
--- /dev/null
+++ b/arch/riscv/cpu/k1/dram.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+ */
+
+#include <asm/global_data.h>
+#include <config.h>
+#include <fdt_support.h>
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
+
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	u64 start[CONFIG_NR_DRAM_BANKS];
+	u64 size[CONFIG_NR_DRAM_BANKS];
+	int i;
+
+	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
+		start[i] = gd->bd->bi_dram[i].start;
+		size[i] = gd->bd->bi_dram[i].size;
+	}
+
+	return fdt_fixup_memory_banks(blob, start, size, CONFIG_NR_DRAM_BANKS);
+}
diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index de356584bf1e54497b36020b53d840c634f7dfc0..e2905f5e0bae604096f333b3b6018a429a2cfd36 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 dtb-$(CONFIG_TARGET_ANDES_AE350) += ae350_32.dtb ae350_64.dtb
+dtb-$(CONFIG_TARGET_BANANAPI_F3) += k1-bananapi-f3.dtb
+dtb-$(CONFIG_TARGET_MICROCHIP_ICICLE) += mpfs-icicle-kit.dtb
 dtb-$(CONFIG_TARGET_MILKV_DUO) += cv1800b-milkv-duo.dtb
 dtb-$(CONFIG_TARGET_QEMU_VIRT) += qemu-virt32.dtb qemu-virt64.dtb
 dtb-$(CONFIG_TARGET_OPENPITON_RISCV64) += openpiton-riscv64.dtb
diff --git a/arch/riscv/dts/k1-bananapi-f3.dts b/arch/riscv/dts/k1-bananapi-f3.dts
new file mode 100644
index 0000000000000000000000000000000000000000..d2486f70906143ad1f2bde753f12dea5bab2e5ab
--- /dev/null
+++ b/arch/riscv/dts/k1-bananapi-f3.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
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
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x00000000 0x00000000 0x80000000>;
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
diff --git a/arch/riscv/dts/k1.dtsi b/arch/riscv/dts/k1.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..514be453dbaf6713cdf4ad5a5d653488297ebb83
--- /dev/null
+++ b/arch/riscv/dts/k1.dtsi
@@ -0,0 +1,459 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
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
+			i-cache-block-size = <64>;
+			i-cache-size = <32768>;
+			i-cache-sets = <128>;
+			d-cache-block-size = <64>;
+			d-cache-size = <32768>;
+			d-cache-sets = <128>;
+			next-level-cache = <&cluster0_l2_cache>;
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
+			i-cache-block-size = <64>;
+			i-cache-size = <32768>;
+			i-cache-sets = <128>;
+			d-cache-block-size = <64>;
+			d-cache-size = <32768>;
+			d-cache-sets = <128>;
+			next-level-cache = <&cluster0_l2_cache>;
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
+			i-cache-block-size = <64>;
+			i-cache-size = <32768>;
+			i-cache-sets = <128>;
+			d-cache-block-size = <64>;
+			d-cache-size = <32768>;
+			d-cache-sets = <128>;
+			next-level-cache = <&cluster0_l2_cache>;
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
+			i-cache-block-size = <64>;
+			i-cache-size = <32768>;
+			i-cache-sets = <128>;
+			d-cache-block-size = <64>;
+			d-cache-size = <32768>;
+			d-cache-sets = <128>;
+			next-level-cache = <&cluster0_l2_cache>;
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
+			i-cache-block-size = <64>;
+			i-cache-size = <32768>;
+			i-cache-sets = <128>;
+			d-cache-block-size = <64>;
+			d-cache-size = <32768>;
+			d-cache-sets = <128>;
+			next-level-cache = <&cluster1_l2_cache>;
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
+			i-cache-block-size = <64>;
+			i-cache-size = <32768>;
+			i-cache-sets = <128>;
+			d-cache-block-size = <64>;
+			d-cache-size = <32768>;
+			d-cache-sets = <128>;
+			next-level-cache = <&cluster1_l2_cache>;
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
+			i-cache-block-size = <64>;
+			i-cache-size = <32768>;
+			i-cache-sets = <128>;
+			d-cache-block-size = <64>;
+			d-cache-size = <32768>;
+			d-cache-sets = <128>;
+			next-level-cache = <&cluster1_l2_cache>;
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
+			i-cache-block-size = <64>;
+			i-cache-size = <32768>;
+			i-cache-sets = <128>;
+			d-cache-block-size = <64>;
+			d-cache-size = <32768>;
+			d-cache-sets = <128>;
+			next-level-cache = <&cluster1_l2_cache>;
+			mmu-type = "riscv,sv39";
+
+			cpu7_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		cluster0_l2_cache: l2-cache0 {
+			compatible = "cache";
+			cache-block-size = <64>;
+			cache-level = <2>;
+			cache-size = <524288>;
+			cache-sets = <512>;
+			cache-unified;
+		};
+
+		cluster1_l2_cache: l2-cache1 {
+			compatible = "cache";
+			cache-block-size = <64>;
+			cache-level = <2>;
+			cache-size = <524288>;
+			cache-sets = <512>;
+			cache-unified;
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
+
+		sec_uart1: serial@f0612000 {
+			compatible = "spacemit,k1-uart", "snps,dw-apb-uart";
+			reg = <0x0 0xf0612000 0x0 0x100>;
+			interrupts = <43>;
+			clock-frequency = <14857000>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "reserved"; /* for TEE usage */
+		};
+	};
+};
\ No newline at end of file
diff --git a/board/spacemit/bananapi-f3/Kconfig b/board/spacemit/bananapi-f3/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..f89fa9af2c7d92e87722a54c4df9216d76376de9
--- /dev/null
+++ b/board/spacemit/bananapi-f3/Kconfig
@@ -0,0 +1,25 @@
+if TARGET_BANANAPI_F3
+
+config SYS_BOARD
+	default "bananapi-f3"
+
+config SYS_VENDOR
+	default "spacemit"
+
+config SYS_CPU
+	default "k1"
+
+config SYS_CONFIG_NAME
+	default "bananapi-f3"
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
diff --git a/board/spacemit/bananapi-f3/MAINTAINERS b/board/spacemit/bananapi-f3/MAINTAINERS
new file mode 100644
index 0000000000000000000000000000000000000000..131bad03181021bb10b8f2189f00870f45f6dac1
--- /dev/null
+++ b/board/spacemit/bananapi-f3/MAINTAINERS
@@ -0,0 +1,6 @@
+BananaPi F3
+M:	Huan Zhou <pericycle.cc@@gmail.com>
+S:	Maintained
+F:	board/spacemit/bananapi-f3/
+F:	configs/bananapi-f3_defconfig
+F:	doc/board/spacemit/bananapi-f3.rst
diff --git a/board/spacemit/bananapi-f3/Makefile b/board/spacemit/bananapi-f3/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..2168698402b6d1d26988ca4e3a8e55367db51532
--- /dev/null
+++ b/board/spacemit/bananapi-f3/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+
+obj-y := board.o
diff --git a/board/spacemit/bananapi-f3/board.c b/board/spacemit/bananapi-f3/board.c
new file mode 100644
index 0000000000000000000000000000000000000000..2631cdd49e0eb4afde0efadb2f3014fd623f78f2
--- /dev/null
+++ b/board/spacemit/bananapi-f3/board.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+ */
+
+int board_init(void)
+{
+	return 0;
+}
diff --git a/configs/bananapi-f3_defconfig b/configs/bananapi-f3_defconfig
new file mode 100644
index 0000000000000000000000000000000000000000..6363620208757df185e3a11ee1260eb57256ac68
--- /dev/null
+++ b/configs/bananapi-f3_defconfig
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
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_SYS_CBSIZE=256
+CONFIG_SYS_PBSIZE=276
+CONFIG_HUSH_PARSER=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_SYS_NS16550=y
+CONFIG_SYS_NS16550_MEM32=y
diff --git a/include/configs/bananapi-f3.h b/include/configs/bananapi-f3.h
new file mode 100644
index 0000000000000000000000000000000000000000..97cf4d72df031079479da24c7703a64e4c509bf6
--- /dev/null
+++ b/include/configs/bananapi-f3.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+ *
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#define CFG_SYS_SDRAM_BASE         0x0
+#define CFG_SYS_NS16550_IER        0x40 /* UART Unit Enable */
+
+#endif /* __CONFIG_H */

-- 
2.39.5

