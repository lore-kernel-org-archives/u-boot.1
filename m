Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F353CD4A5F4
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 13:47:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7608D8397A;
	Sun, 18 Jan 2026 14:47:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l6Mu2wms";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0E84833C6; Sat, 17 Jan 2026 20:04:02 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A18682BF2
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 20:04:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-88a367a1dbbso51247976d6.0
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 11:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768676639; x=1769281439; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iAYL9YGvJVkbl4OZqFJclC/51QxXGO4KwvTmruem3sc=;
 b=l6Mu2wmsz90ZFA1YS8GO+gUKgG2Nargxq73fUNd3oo64rUhcieZ+5YBJzxlLwK+miX
 uEs+bnAhQrWWh4+qXSdUM/tTIBTOfJKjcUrUwzpfL2mxrRSdfGIpmswor0q22N4lu0lV
 Xt5mYsk6S1VwB7EDpadCmLYLh6p+pHFkTc+yUoiO7wtI/hAk/ODAqxlKKCX/D2pI3W1a
 goQ8D68YVPRyFWTNFAKv5kIYDsM/zag9606bdnEUgSTe5lBgoFhtnBjU9lM158Q5cgyB
 1Wt28wzKTjhdxGwVWAPEIZo8PbhFKhQFNIq5EjTX/CdylU+Zqfl5xXeoAVykOtZeaXPf
 WEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768676639; x=1769281439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iAYL9YGvJVkbl4OZqFJclC/51QxXGO4KwvTmruem3sc=;
 b=A0XSRTpF4oVdw/j4Jk1VU2SGJHrJJhr/In9K4gOflyLt1b0YyEGUoM4Y0eKlsZrwBp
 8SqGuq5ZWZocc/V+5kWbJWHzYrxq9vFy2G3shWnZHz7j6wfjNi1BYa9G6FqZHiOxEgMU
 bRGzG0pSkeQNT+DsCw4snbePxGx8CKVem4d8T+f7UHee92H9EqwCJhWT4RM8rBGUw8YU
 MrlTv9Tb94+kNMT4K0uytfNN9O2jU0te5dCOBhBn61vcbb1bFWGsvLr1rDeGOr0/f/zU
 /UWRiE+IgG9AOzBbmGzCPt6mRgFrqiXik+7bAmz3x+nl8nmfbY/j9kOc2rR2mRXPh0rt
 uYYQ==
X-Gm-Message-State: AOJu0YzNHXfPqr3vAMjukdcBWHgvfIkjjSj80XLXoxmlSr6gVW02ZhL4
 ezFyD28GgmCr/Wmc5jIDtZqhe5unEnRXeQVlPYHkPI0+ONOyV6zVOHCTz7GAmA==
X-Gm-Gg: AY/fxX6Cy5rXigOD+x2EGTk7GtRjD2VOBenHf88N6EqC/GbZn3D8PiauZoy9sqELcbn
 rpR462/J9dC6W/l7hX0tP/0wINJHSkZkKKrkwf7VMmzcxlEbPbc/6JqxWHu1oiB3Q6blkdzpiFg
 u2EIvUoSZgySDYkCv4DgYbH9XhKTVRZrqM/Zd9QvatmAZzv4s49KzPHfk+cRy73eAdTi/Fvw0AM
 +k1Gp61mbZyh7zLgu0ve3J4811BDrLl3ByGdth7k4sMU+CL+2Ye6oa7S8TWpBaHGL5juQshXWuA
 E6IbAs/SH+eiFt8QUHWA5SAwIYbwYB4fK6foWYBZuY1f4D88AE8GIByXrC/8xbP8oO/OTXi3QEU
 n9KSMru7/HF1BtIoLwQJV1MUnUFpGps4Ryfm9CYBh12UwIMO2ZGMgaULojIM/dm/3X2LbPTubbc
 aWf5rUtXQv7eOQkpua4upr2NlCLmNdkRY8g0rhYMyahR/l0LWrOLi5KMz1nGGUI0w5syg1tVg=
X-Received: by 2002:ac8:5713:0:b0:4f1:b9b4:6a7a with SMTP id
 d75a77b69052e-502a1e5d147mr90226421cf.27.1768676638767; 
 Sat, 17 Jan 2026 11:03:58 -0800 (PST)
Received: from ubuntu.localdomain (174-138-202-16.cpe.distributel.net.
 [174.138.202.16]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502a1ef9347sm44340261cf.25.2026.01.17.11.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jan 2026 11:03:58 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, Raymond Mao <raymond.mao@riscstar.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Heiko Schocher <hs@nabladev.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Conor Dooley <conor.dooley@microchip.com>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 Michal Simek <michal.simek@amd.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Yixun Lan <dlan@gentoo.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Aniket Limaye <a-limaye@ti.com>,
 Angelo Dureghello <angelo.dureghello@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Henrik Grimler <henrik@grimler.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Samuel Holland <samuel@sholland.org>,
 Justin Klaassen <justin@tidylabs.net>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Heiko Stuebner <heiko@sntech.de>, Joseph Chen <chenjh@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>
Subject: [PATCH 02/17] spacemit: k1: enable SPL with debug UART
Date: Sat, 17 Jan 2026 14:01:36 -0500
Message-Id: <20260117190231.977686-3-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260117190231.977686-1-raymondmaoca@gmail.com>
References: <20260117190231.977686-1-raymondmaoca@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 18 Jan 2026 14:47:30 +0100
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
 arch/riscv/cpu/k1/Kconfig  |  2 ++
 arch/riscv/dts/Makefile    |  1 +
 arch/riscv/dts/k1-spl.dts  | 26 ++++++++++++++++++++++++++
 arch/riscv/dts/k1.dtsi     |  2 +-
 board/spacemit/k1/Makefile |  2 ++
 board/spacemit/k1/spl.c    | 24 ++++++++++++++++++++++++
 configs/k1_defconfig       | 21 ++++++++++++++++++++-
 include/configs/k1.h       |  2 ++
 8 files changed, 78 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/dts/k1-spl.dts
 create mode 100644 board/spacemit/k1/spl.c

diff --git a/arch/riscv/cpu/k1/Kconfig b/arch/riscv/cpu/k1/Kconfig
index 4b621158334..4f7a07fd8ee 100644
--- a/arch/riscv/cpu/k1/Kconfig
+++ b/arch/riscv/cpu/k1/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
 # Copyright (C) 2024, Kongyang Liu <seashell11234455@gmail.com>
+# Copyright (C) 2025-2026, RISCStar Ltd.
 
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
index 00000000000..6018ea1e452
--- /dev/null
+++ b/arch/riscv/dts/k1-spl.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (C) 2023-2026 Spacemit, Inc
+ * Copyright (C) 2025-2026 RISCStar Ltd.
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
+		bootph-all;
+	};
+};
+
+&soc {
+	bootph-all;
+	serial@d4017000 {
+		status = "okay";
+		bootph-all;
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
index 2168698402b..7bce47bac8c 100644
--- a/board/spacemit/k1/Makefile
+++ b/board/spacemit/k1/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 #
 # Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
+# Copyright (c) 2025-2026, RISCStar Ltd.
 
 obj-y := board.o
+obj-$(CONFIG_SPL_BUILD) += spl.o
diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
new file mode 100644
index 00000000000..11a097389f1
--- /dev/null
+++ b/board/spacemit/k1/spl.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025-2026, RISCStar Ltd.
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
diff --git a/configs/k1_defconfig b/configs/k1_defconfig
index 0bdc3c800f0..f1a16735943 100644
--- a/configs/k1_defconfig
+++ b/configs/k1_defconfig
@@ -3,7 +3,19 @@ CONFIG_SYS_MALLOC_LEN=0x1000000
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x1000000
-CONFIG_DEFAULT_DEVICE_TREE="k1-bananapi-f3"
+CONFIG_DEFAULT_DEVICE_TREE="k1-spl"
+CONFIG_SPL=y
+CONFIG_SPL_TEXT_BASE=0xC0801000
+CONFIG_SPL_MAX_SIZE=0x33000
+CONFIG_SPL_BSS_START_ADDR=0xC0837000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_STACK=0xC0840000
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
+CONFIG_DEBUG_UART_BASE=0xD4017000
+CONFIG_DEBUG_UART_CLOCK=14700000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_DEBUG_UART_NS16550=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+# CONFIG_DEBUG_SBI_CONSOLE is not set
diff --git a/include/configs/k1.h b/include/configs/k1.h
index 97cf4d72df0..6a26fdfcebe 100644
--- a/include/configs/k1.h
+++ b/include/configs/k1.h
@@ -7,6 +7,8 @@
 #ifndef __CONFIG_H
 #define __CONFIG_H
 
+#define CFG_SYS_NS16550_CLK	    14700000
+
 #define CFG_SYS_SDRAM_BASE         0x0
 #define CFG_SYS_NS16550_IER        0x40 /* UART Unit Enable */
 
-- 
2.25.1

