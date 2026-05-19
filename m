Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DA9CD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 22:38:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13D45846CE;
	Tue, 19 May 2026 00:38:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="m/TkTZm4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F0E3846AE; Tue, 19 May 2026 00:28:21 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3AD18465A
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 00:28:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2baca4df358so15580825ad.2
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 15:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1779143297; x=1779748097;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bes8858C2Ml105BComB/0VQYO0WjE67Y18Il7i3EtwE=;
 b=m/TkTZm4EIQ14iurliacjx//8KX9xSAShjC08XdLKV8nGOltAMf8t/GGzJWMJswaiK
 HHwbzDQcRqIV3XC9BOBLrzHF9iInHUR66VBNMKO/JDhlyozfMyNbM6xb9kwX1xG0mr2X
 SdZ3YK/3JchBjmMtZYNG41gheR0JMjpCbybeY18q8e2fL/mWjG0IPnLXMghxRbNOYLkO
 5vj30yBvn0nKG+VJMWItN4KGo+otp/dI6PTst20gyL5O7oYu9lu8zrvmTHMJyOZxEUNv
 5pOyAvbPd+9EkeNk306QIGQHZeL5u3FLfo2Dd8asqxMCmKcZkjqXdsUdPa4mhtCUv0qj
 ptXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779143297; x=1779748097;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bes8858C2Ml105BComB/0VQYO0WjE67Y18Il7i3EtwE=;
 b=WZnDR8OvUs9gulpexyDrVn+tAPhsZ6Kg8aBPHYJheOX1OsAvQCCUrkZJ56moekmqzw
 /lmwsUTEAj08XU7JGrZbtgtS/MOlDI+tIfHYdvkhGOrS6q4r90JWnylhQ5++SQ5Hn7BC
 fdbKLB9APAReKC6Np/NLoEJVozRRBp4LgMtwUAblSaTJ//WBknsNZvfhFO2ZJnbU5uRV
 i12pjp3tBGDbbWcqEwzx3VxPO6/kXadZ0vXsojWJn6PC5296kQYfy2F4F11trhsybBhY
 IoSRft4lqCiPTvI86Jx0wkSVifosYpZrUNidCXmq2Onnx5bx0kO7xJok5wqcYGIEmERV
 E8xA==
X-Gm-Message-State: AOJu0YxQ6NnuqNg98lq/KMmQ6+9vfoO0aQLd9Ug6JuIF2uxDVO+XwGn5
 QoD2vVQRMLi6793uoi0wr7Vc/NnVeda3Kj7L9Hw6ybKUsgEz2dL9pnIn1gjzFs8R8MA=
X-Gm-Gg: Acq92OHLM8x6JxEjm9ck0Y549bTOl+AQ0oDg6r8AHxEoDiFmUfDJiKcgUh3ZFD5Go0v
 K7TTch0Fm0XmX5F5VFaN8xpDKetimWZK3COg5oWoby+Yr8jSHGXd1yluunzeZ9t8T4m3gcXZjpM
 gvT17JF8PwjMqnRUPncAF/YU4SlCyiQE7k8CedVg06uCg1YPpYJMHlqW7xu6ZCIlwxVop4QDYDa
 oVfMsgEwwToJbk467uDoNB/CG39CBz2ji8GuLSJ6gTDIgMp6DPZu3qP35ne4Sf8lj8oXOzcY4O9
 sSnk92QwxMiGR5vs1euDKsxT8SWOwKdsh0A4/DZZYCO1RtIp82a/gW92XjWp0jYhmu22Ihk3wWs
 qL0/qML96f/akkuBhrNB/jk9mns8ErYG06+xUgYhHRPJ3BSX86wY/0RDJGdJcNe3qkDfRqBQMg/
 g+2i5gCsMAUXVTAs4XFAPnKVxn6YaFGy40zmmHVQrpntbC+OGiHYdF3h4EOE39kgYX
X-Received: by 2002:a17:903:3c6b:b0:2ae:825b:49a5 with SMTP id
 d9443c01a7336-2bd7e415675mr171974605ad.0.1779143297407; 
 Mon, 18 May 2026 15:28:17 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::4072])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5bd5ef27sm206379265ad.8.2026.05.18.15.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 15:28:17 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 19 May 2026 06:26:20 -0400
Subject: [PATCH v4 02/14] spacemit: k1: enable SPL with debug UART
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-b4-k1-spl-bring-up-v4-2-3915a2a904c1@riscstar.com>
References: <20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com>
In-Reply-To: <20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com>
To: u-boot@lists.denx.de, Kongyang Liu <seashell11234455@gmail.com>, 
 Yixun Lan <dlan@gentoo.org>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Rick Chen <rick@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, u-boot-spacemit@groups.io, 
 Vincent Legoll <legoll@online.fr>, Huan Zhou <pericycle.cc@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Henrik Grimler <henrik@grimler.se>, 
 Kory Maincent <kory.maincent@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>, 
 Justin Klaassen <justin@tidylabs.net>, Guodong Xu <guodong.xu@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Guodong Xu <guodong@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Tue, 19 May 2026 00:38:07 +0200
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
Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v4:
- Reuse upstream BPI-F3 DT in both SPL and U-Boot proper phases
  via OF_UPSTREAM;
- Add SPL bootph-* markers in k1-bananapi-f3-u-boot.dtsi.
---
 arch/riscv/cpu/k1/Kconfig                 |  2 ++
 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi |  4 ++++
 board/spacemit/k1/Makefile                |  2 ++
 board/spacemit/k1/spl.c                   | 24 ++++++++++++++++++++++++
 configs/spacemit_k1_defconfig             | 16 ++++++++++++++++
 include/configs/k1.h                      |  6 ++++--
 6 files changed, 52 insertions(+), 2 deletions(-)

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
diff --git a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
index 9e1925eb68e..4e4d0e0c49e 100644
--- a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
+++ b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
@@ -28,3 +28,7 @@
 	clock-names = "osc", "vctcxo_1m", "vctcxo_3m", "vctcxo_24m",
 		      "pll1_d4", "pll1_d78_31p5", "pmua_aclk";
 };
+
+&uart0 {
+	bootph-pre-ram;
+};
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
index fae561bbf8a..29050ece278 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -4,17 +4,30 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x1000000
 CONFIG_DEFAULT_DEVICE_TREE="spacemit/k1-bananapi-f3"
+CONFIG_SPL_STACK=0xc083fb00
+CONFIG_SPL_TEXT_BASE=0xc0801000
+CONFIG_SPL_BSS_START_ADDR=0xc083fc00
+CONFIG_SPL_BSS_MAX_SIZE=0x400
 CONFIG_SYS_BOOTM_LEN=0xa000000
 CONFIG_SYS_LOAD_ADDR=0x200000
+CONFIG_SPL_SIZE_LIMIT=0x31000
+CONFIG_SPL=y
+CONFIG_DEBUG_UART_BASE=0xd4017000
+CONFIG_DEBUG_UART_CLOCK=14700000
 CONFIG_TARGET_SPACEMIT_K1=y
 CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
+CONFIG_STACK_SIZE=0x100000
 CONFIG_FIT=y
+CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
 # CONFIG_BOARD_INIT is not set
+CONFIG_SPL_MAX_SIZE=0x33000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_HUSH_PARSER=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
@@ -22,5 +35,8 @@ CONFIG_CLK_SPACEMIT=y
 CONFIG_CLK_SPACEMIT_K1=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
+CONFIG_DEBUG_UART_NS16550=y
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
diff --git a/include/configs/k1.h b/include/configs/k1.h
index 97cf4d72df0..15a40f2128f 100644
--- a/include/configs/k1.h
+++ b/include/configs/k1.h
@@ -1,13 +1,15 @@
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
+#define CFG_SYS_NS16550_CLK	    14700000
+#define CFG_SYS_NS16550_IER	    0x40 /* UART Unit Enable */
+#define CFG_SYS_SDRAM_BASE	    0x0
 
 #endif /* __CONFIG_H */

-- 
2.43.0

