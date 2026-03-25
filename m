Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7AA2109E527
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 22:33:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9633583F6D;
	Wed, 25 Mar 2026 23:32:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TGr2szc0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7641583A1B; Wed, 25 Mar 2026 23:32:55 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C1AB83A41
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 23:32:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-8cfd44fa075so59902885a.0
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 15:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774477972; x=1775082772; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ikpV2FclKujxJS7XPp5wl1ihJnSQAjleLdz1MTj3Vpw=;
 b=TGr2szc0LgnutrRLQcdqyqP3DuliiV3O4P2XBzj3JxMQlhKO+yhHnKOh03m2Kjsm45
 ilIPmkZKX8dcxycaBisJw3sgup1AIgWI4pczyHOjsKauRmg2kNfRmpUlGkxS2Rv4L8aV
 +z1pfmAtY03F8UvtWCDVftVeDp0uvREk6x7GG1sy3YiY31vyip0DQC7M7SpFMLs3tOAn
 5ByBY+j1OcHXuNcwUDx7fcWi1Jtn9Y0JyXdQngLYwAbP546MRS6ut1RGEtScgkcCt3DX
 2OW9aN1QaFS3m4k4jij/ONSVLCvC1v0EIWeZEeYST5c24fgXxFh2Q5iOhuq+/GVsGGr1
 wkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774477972; x=1775082772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ikpV2FclKujxJS7XPp5wl1ihJnSQAjleLdz1MTj3Vpw=;
 b=V4wB1MpUNxFR8HcpFvJ7OuUqeyaZsNUjcO16w54CXdJEcqXmGxKRIdHCiTWMxaDlLh
 sBma7600r5hOlq9tJL5RFrkZo06n3ZAKUxz5SUBJ0mrCHWkk2KVWE3Km6z+AJtC+3Pl1
 6177QayFrZN2iyrfwrncahmRc4vGXWaWev5kRU7CU1QbXotc1rYjhIr/viKNFaVZz5jx
 bG01gqclP4YwD95Xh5jW969Owjc4MnCJcSk3LD42/UQCGOc/ddVPEeyWjlVci4cZK84t
 HGcBPKeoLu5pd6blOkykI5qBa2HSdqyf60vd/WMSrpWVNOYcN0anoal61lho6U5aTtih
 Q17Q==
X-Gm-Message-State: AOJu0YyjmUxPzKLH2S3ysUc3asoxMh7qYoD6wkiqUe2UM11Dl/+dgAiT
 lPM8QaxHHczq5VhRgykg0hbIY7/y1iDLi6e86Fx+MSs7HKcmkwNfPQgVSHEontMP
X-Gm-Gg: ATEYQzwk/mD1i0wfmkYmfMn7/0B4FslDw6BAbyVT3aaflI0UeV/0V6uspmVGRxhQ99C
 vyeEl43cvQDozDwa1xwiJ+rTvtWeEzARMGWKLTsCu1LvQ0KxTmPz8ypN9lQA1/Ruod3UJ6i/aZN
 Uw7RTHkFv841QeXV+piH8g56TnBDPfFXPbdGKOQYjJLB/yTsDxx7o+0mZrX3kqeqI2JToG2DRET
 bGQqT5BJtIcg2Cn3wNBVDV/pmF1WB93VyRcskba2jjRp22oGgmXxm607R9qJ9yZB8czj6n/Q9Zz
 6ffIv5PX3F7upNO334spxh/LaJ/pvwZMuK7qwCtAq6182SlBXyNw+oikBTuwl3kbSfUXfFhhKa7
 MMuxzqqc1qWq1TDsP9Fxn1VUs3tpfii9FN0PIN3LoUu3rFFZaWctmWhbJzfR3BYYJmh1+Nq8SJz
 5BAJmNlPS6h1V7sqs/HCwibBE25fxzPaXWMUwq9CtYiwY+e6IuCxH+RilnN3zrV4RuELyYOjxAS
 DOcq9mvO2o=
X-Received: by 2002:a05:620a:4403:b0:8cd:9653:61d8 with SMTP id
 af79cd13be357-8d001039552mr741633885a.55.1774477971888; 
 Wed, 25 Mar 2026 15:32:51 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-124-85.cpe.distributel.net.
 [173.206.124.85]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d00e39fc17sm101540185a.5.2026.03.25.15.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 15:32:51 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH v3 02/16] spacemit: k1: enable SPL with debug UART
Date: Wed, 25 Mar 2026 18:32:18 -0400
Message-Id: <20260325223232.1553212-3-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260325223232.1553212-1-raymondmaoca@gmail.com>
References: <20260325223232.1553212-1-raymondmaoca@gmail.com>
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

From: Raymond Mao <raymond.mao@riscstar.com>

Add SPL support featuring debug UART output for early boot
diagnostics on K1 SoC.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
Changes in v3:
- Adapt to TARGET_SPACEMIT_K1 Kconfig change in patch 01

 arch/riscv/cpu/k1/Kconfig     |  2 ++
 arch/riscv/dts/Makefile       |  2 +-
 arch/riscv/dts/k1-spl.dts     | 25 +++++++++++++++++++++++++
 arch/riscv/dts/k1.dtsi        |  2 +-
 board/spacemit/k1/Makefile    |  2 ++
 board/spacemit/k1/spl.c       | 24 ++++++++++++++++++++++++
 configs/spacemit_k1_defconfig | 21 ++++++++++++++++++++-
 include/configs/k1.h          |  7 +++++--
 8 files changed, 80 insertions(+), 5 deletions(-)
 create mode 100644 arch/riscv/dts/k1-spl.dts
 create mode 100644 board/spacemit/k1/spl.c

diff --git a/arch/riscv/cpu/k1/Kconfig b/arch/riscv/cpu/k1/Kconfig
index 3701bf2b5da..b155535658d 100644
--- a/arch/riscv/cpu/k1/Kconfig
+++ b/arch/riscv/cpu/k1/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
 # Copyright (C) 2024, Kongyang Liu <seashell11234455@gmail.com>
+# Copyright (C) 2025-2026, RISCstar Ltd.
 
 if TARGET_SPACEMIT_K1
 
@@ -9,6 +10,7 @@ config SPACEMIT_K1
 	select BINMAN
 	select ARCH_EARLY_INIT_R
 	select SYS_CACHE_SHIFT_6
+	select SUPPORT_SPL
 	imply CPU
 	imply CPU_RISCV
 	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index bfb18341c61..61a7acabd27 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -9,7 +9,7 @@ dtb-$(CONFIG_TARGET_LICHEERV_NANO) += sg2002-licheerv-nano-b.dtb
 dtb-$(CONFIG_TARGET_QEMU_VIRT) += qemu-virt32.dtb qemu-virt64.dtb
 dtb-$(CONFIG_TARGET_OPENPITON_RISCV64) += openpiton-riscv64.dtb
 dtb-$(CONFIG_TARGET_SIPEED_MAIX) += k210-maix-bit.dtb
-dtb-$(CONFIG_TARGET_SPACEMIT_K1) += k1-bananapi-f3.dtb
+dtb-$(CONFIG_TARGET_SPACEMIT_K1) += k1-bananapi-f3.dtb k1-spl.dtb
 dtb-$(CONFIG_TARGET_XILINX_MBV) += xilinx-mbv32.dtb
 dtb-$(CONFIG_TARGET_XILINX_MBV) += xilinx-mbv64.dtb
 dtb-$(CONFIG_TARGET_XILINX_MBV) += xilinx-binman.dtb
diff --git a/arch/riscv/dts/k1-spl.dts b/arch/riscv/dts/k1-spl.dts
new file mode 100644
index 00000000000..c7196c2d722
--- /dev/null
+++ b/arch/riscv/dts/k1-spl.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (C) 2023-2026 Spacemit, Inc
+ * Copyright (C) 2025-2026 RISCstar Ltd.
+ */
+
+/dts-v1/;
+#include "k1.dtsi"
+#include "binman.dtsi"
+
+/ {
+	model = "spacemit k1 spl";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&soc {
+	bootph-all;
+	serial@d4017000 {
+		status = "okay";
+		bootph-pre-ram;
+	};
+};
diff --git a/arch/riscv/dts/k1.dtsi b/arch/riscv/dts/k1.dtsi
index a633e43da32..9c203eb4b79 100644
--- a/arch/riscv/dts/k1.dtsi
+++ b/arch/riscv/dts/k1.dtsi
@@ -318,7 +318,7 @@
 		};
 	};
 
-	soc {
+	soc: soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
 		#address-cells = <2>;
diff --git a/board/spacemit/k1/Makefile b/board/spacemit/k1/Makefile
index 2168698402b..f9cbf4b0e06 100644
--- a/board/spacemit/k1/Makefile
+++ b/board/spacemit/k1/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
 # Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+# Copyright (c) 2025-2026, RISCstar Ltd.
 
 obj-y := board.o
+obj-$(CONFIG_SPL_BUILD) += spl.o
diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
new file mode 100644
index 00000000000..e15cf5f1abf
--- /dev/null
+++ b/board/spacemit/k1/spl.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025-2026, RISCstar Ltd.
+ */
+
+#include <spl.h>
+
+void board_init_f(ulong dummy)
+{
+	int ret;
+
+	ret = spl_early_init();
+	if (ret)
+		panic("spl_early_init() failed:%d\n", ret);
+
+	riscv_cpu_setup();
+
+	preloader_console_init();
+}
+
+u32 spl_boot_device(void)
+{
+	return BOOT_DEVICE_NONE;
+}
diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 09928046012..3cf199e4032 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -3,7 +3,19 @@ CONFIG_SYS_MALLOC_LEN=0x1000000
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x1000000
-CONFIG_DEFAULT_DEVICE_TREE="k1-bananapi-f3"
+CONFIG_DEFAULT_DEVICE_TREE="k1-spl"
+CONFIG_SPL=y
+CONFIG_SPL_TEXT_BASE=0xc0801000
+CONFIG_SPL_MAX_SIZE=0x33000
+CONFIG_SPL_BSS_START_ADDR=0xc0837000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_STACK=0xc0840000
+CONFIG_SPL_SIZE_LIMIT=0x31000
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x08000000
+CONFIG_STACK_SIZE=0x100000
 CONFIG_SYS_BOOTM_LEN=0xa000000
 CONFIG_SYS_LOAD_ADDR=0x200000
 CONFIG_ARCH_RV64I=y
@@ -22,3 +34,10 @@ CONFIG_PINCTRL_SINGLE=y
 CONFIG_RESET_SPACEMIT_K1=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_BASE=0xd4017000
+CONFIG_DEBUG_UART_CLOCK=14700000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_DEBUG_UART_NS16550=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+# CONFIG_DEBUG_SBI_CONSOLE is not set
diff --git a/include/configs/k1.h b/include/configs/k1.h
index 97cf4d72df0..e0b05c50b70 100644
--- a/include/configs/k1.h
+++ b/include/configs/k1.h
@@ -1,13 +1,16 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+ * Copyright (C) 2025-2026, RISCstar Ltd.
  *
  */
 
 #ifndef __CONFIG_H
 #define __CONFIG_H
 
-#define CFG_SYS_SDRAM_BASE         0x0
-#define CFG_SYS_NS16550_IER        0x40 /* UART Unit Enable */
+#define CFG_SYS_SDRAM_BASE	    0x0
+
+#define CFG_SYS_NS16550_CLK	    14700000
+#define CFG_SYS_NS16550_IER	    0x40 /* UART Unit Enable */
 
 #endif /* __CONFIG_H */
-- 
2.25.1

