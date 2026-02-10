Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EDAEA8126
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 15:15:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BCFF83D6C;
	Tue, 10 Feb 2026 16:15:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UaOgMkZI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA22783CF2; Tue, 10 Feb 2026 16:15:21 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B5AF83D6C
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 16:15:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-8c5349ba802so564463585a.1
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 07:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770736518; x=1771341318; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R3yhfcNB9frKr3i5X4XuSasRfDFx463dexB+2cYK78g=;
 b=UaOgMkZIndk2NYXTLHxgaoihMhUefXW8IMx/L7iovjn7ui0nS2csbO8CtRjhnsRNGv
 HvSDjPjV5bfgGIb5H71qhJcCqrQVZL7Ld4WmUf177lnpx1vpCzR0+yHplJiPw0kr/OsB
 2DJL0M9zJ7owFC9aCaSL4BzGqx9bXbe+YOSCXdK/alGMKXpiHWXSFnwFjbfRjt7Jo0VG
 PUKpsQrZh5FyDgT5h0G57zlQq1LFBAuTFWy/KYfnQPqwQOPJtdDfvNxHOzOBJuOjdJzy
 yGPgjHIeZeZyNHxDgjnbQndBDNFLBQO+ZjPNjX3ttoB8b1PuJBA42uTeBo0MPI0yARRz
 mj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770736518; x=1771341318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R3yhfcNB9frKr3i5X4XuSasRfDFx463dexB+2cYK78g=;
 b=uTTaTJ72Vne4YnZrtyBNwLxuoxej7GMDn7rjtnivcxdFf8B0KWCufK42hxGvRDaMcq
 XrPY8tUMvqcuahlzkV+3tLDAULTArbwV0K4VUwxF2gBYFz2V6iUfuCRfAv4ATR9C/uX4
 89uuVZhv3lENypuMfVWhMJFrxn7sPUM8/DjpHC9yoAH8RGctMzSuNEG9LNNE8xiFujuF
 PEwg8oDMeGTiHZuP4QW7bmANQOLBA2KJRNMgadv8WXW87U+AIwv2Nhqu4cLM1iiCNAIR
 ejqawcQsHG9rYrVOmI8jGowQ1HAMiXcnFEf/zWG7VT4lXbnkwMMGj3YC8twmvLM+lyHe
 7RQg==
X-Gm-Message-State: AOJu0YxeMVNzrt4zN8vCXVB89t3AdN4uodgoisD9xYqwicqj3RmlAA9j
 MXbbAYjoVQ52GV108EFScNvd1bsEXbOwLIzDukhTigj11rt0e3clC/AcKYWHDA==
X-Gm-Gg: AZuq6aIcBRuMFqthEPEZrxdMRqFjqt1aGSSsEq0uC+BFJiURHgDC223nQPRNXmxXqB0
 AR2JJbrUjp+UgCGjF3Ofe+vEe0wbKyVPVTXvDiz4+wHJ20/8+7izX4raVvcnl1fMQub+aUf0C/r
 8sj/6PzVfy5XmQVMC2pBX3/ahOHrMUiFYxIg58IhwaZ145g74Jrx/Pw0S4PE9d+W2YPJWM7m4MZ
 GUGEXW/i7EYdxR0nzJpLvDtJqg5bDwhW9VQNcxhSxngCktFMhllDNHbpmldi0OHGr7SSggDw0jY
 2gVdR19cH5PHeLoD/97Tem1IqGl4Yn5zL/ZnYcDnIv16ReAQtLewEJxsleifgkZiGnQo1CkY+bz
 edvBD0NVk50tY/zkS8Ps37aSbN0qCrhHOqGBBjmQeFjPGn4Q5jl9BvIBYUBK5WhRhAvMLGJ2E00
 9bKq2EXu87gGKSx1LeWm2OckC+D0szIeeNUy9FzzC92fxRrpNaLRjE0GmYmSHKgDzkrD7aPNvym
 /77zvQHM/JNlprDxRSorg==
X-Received: by 2002:a05:620a:4441:b0:8c6:a707:1b52 with SMTP id
 af79cd13be357-8caedfb1a4fmr1891065085a.4.1770736517425; 
 Tue, 10 Feb 2026 07:15:17 -0800 (PST)
Received: from ubuntu.localdomain (174-138-202-16.cpe.distributel.net.
 [174.138.202.16]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8953c057751sm101019286d6.43.2026.02.10.07.15.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 07:15:17 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH v2 02/16] spacemit: k1: enable SPL with debug UART
Date: Tue, 10 Feb 2026 10:14:45 -0500
Message-Id: <20260210151459.2348758-3-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260210151459.2348758-1-raymondmaoca@gmail.com>
References: <20260210151459.2348758-1-raymondmaoca@gmail.com>
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
 arch/riscv/cpu/k1/Kconfig     |  2 ++
 arch/riscv/dts/Makefile       |  1 +
 arch/riscv/dts/k1-spl.dts     | 25 +++++++++++++++++++++++++
 arch/riscv/dts/k1.dtsi        |  2 +-
 board/spacemit/k1/Makefile    |  2 ++
 board/spacemit/k1/spl.c       | 24 ++++++++++++++++++++++++
 configs/spacemit_k1_defconfig | 21 ++++++++++++++++++++-
 include/configs/k1.h          |  7 +++++--
 8 files changed, 80 insertions(+), 4 deletions(-)
 create mode 100644 arch/riscv/dts/k1-spl.dts
 create mode 100644 board/spacemit/k1/spl.c

diff --git a/arch/riscv/cpu/k1/Kconfig b/arch/riscv/cpu/k1/Kconfig
index 4b621158334..011fc89557e 100644
--- a/arch/riscv/cpu/k1/Kconfig
+++ b/arch/riscv/cpu/k1/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
 # Copyright (C) 2024, Kongyang Liu <seashell11234455@gmail.com>
+# Copyright (C) 2025-2026, RISCstar Ltd.
 
 if ARCH_K1
 
@@ -9,6 +10,7 @@ config SPACEMIT_K1
 	select BINMAN
 	select ARCH_EARLY_INIT_R
 	select SYS_CACHE_SHIFT_6
+	select SUPPORT_SPL
 	imply CPU
 	imply CPU_RISCV
 	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index 9b347fc3b50..e942ef95142 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0+
 
+dtb-$(CONFIG_ARCH_K1) += k1-spl.dtb
 dtb-$(CONFIG_TARGET_ANDES_AE350) += ae350_32.dtb ae350_64.dtb
 dtb-$(CONFIG_TARGET_ANDES_VOYAGER) += qilai-voyager.dtb
 dtb-$(CONFIG_TARGET_BANANAPI_F3) += k1-bananapi-f3.dtb
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
index 0bdc3c800f0..d794170bc5b 100644
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
@@ -23,3 +35,10 @@ CONFIG_PINCTRL_SINGLE=y
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

