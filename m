Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC54C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 08:52:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86A1587243;
	Tue, 14 Nov 2023 09:52:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LSfak8kn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19F1C8726A; Tue, 14 Nov 2023 09:52:30 +0100 (CET)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8877687266
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 09:52:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so4261642a12.1
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 00:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699951946; x=1700556746; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t+W0ciOA2vOXq/CX4WHhQamLFPXxNRJat+RDJES8J0A=;
 b=LSfak8knjCCnc3OXnvpxRdlGq0dgdtVNamFcx26jajAQhA4RHE9i4spnvvPTOqrDzm
 kNhAMc+u9c7s5uK1Vx1ynOtz/oZxNweoTqw1fxuUPO0DQ3cbPVu5HQqYXHNV56R0NIhn
 /ZQV8q0mro7eBLnA9lJV1q7G8LKFgX9i1fqkhoyzxkMgPMhPkpYrUr7BkaP0JRh3MhqY
 /h4QrmPm1cwLp/HCXlnWiU70ziJvmY/ktsMM2b43cMnYQ1uqU1Cx2RCFbuRelr/sySWz
 m1WFxMOvRAGAQwoQnUImPz6yFZRPyJUG8dANHO9kchXFastKDvY66OrSJZ45ywv09+Ph
 WN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699951946; x=1700556746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t+W0ciOA2vOXq/CX4WHhQamLFPXxNRJat+RDJES8J0A=;
 b=OUESkDQ9Qk/0pAHLzmKrXiNuptR0/vfxj6N3iZeC/zRSzauQh15aET8LmoT7TvdE78
 TPDnoXIjqR8CkWRyZvSQm0lugFOfqL0MrO/OGT+faIpTK01PLolupayMn2TEDiYYQCZg
 SKRYpjl6i6V5csRE+4uUtGONOn4ttbYe7GQYMnfKWr2l1bhSbdeQwuFu4YQTiRvQORGl
 JLuHMnBDCn5TpUS+Vxjn6TtanxSkKodmRaSArv0RrKRscMmfAf/qZyuklwu30oaFh2or
 Bv7zCxwihvsisqBiKRzcVpQHCBVdTdGTcebtU9+gTQBHoE7nqpANs4F56ktVSwlvsUGB
 bWYA==
X-Gm-Message-State: AOJu0YxC0Zrdtey1BINACGAp5WAg7tMW9UJs6LppvG13w8XAfKlMtWnZ
 9QVylKoz0qAdlom+LH07oOA=
X-Google-Smtp-Source: AGHT+IHnGYxtinNbm+z4SwK9biYf2QQbtxqRHZeEECq9DwgVRNNPAHlWrqFzW1JdBxjreDA7CR6Vcg==
X-Received: by 2002:a05:6a20:2593:b0:140:f6c4:aa71 with SMTP id
 k19-20020a056a20259300b00140f6c4aa71mr10468993pzd.8.1699951945759; 
 Tue, 14 Nov 2023 00:52:25 -0800 (PST)
Received: from cs20-buildserver.lan ([180.217.145.22])
 by smtp.gmail.com with ESMTPSA id
 fh23-20020a056a00391700b006be0bd6a4d8sm778696pfb.36.2023.11.14.00.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 00:52:25 -0800 (PST)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, jim.t90615@gmail.com,
 trini@konsulko.com, YSCHU@nuvoton.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 4/4] board: nuvoton: update console environment variable
Date: Tue, 14 Nov 2023 16:51:59 +0800
Message-Id: <20231114085159.3739887-5-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231114085159.3739887-1-JJLIU0@nuvoton.com>
References: <20231114085159.3739887-1-JJLIU0@nuvoton.com>
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

If CONFIG_SYS_SKIP_UART_INIT is enabled, calculate the
current baud rate and update the "console" environment
variable.

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
Changes for v2:
   --- rename file
   --- modify board_set_console to void function
---
 board/nuvoton/arbel_evb/Kconfig     |  1 +
 board/nuvoton/arbel_evb/arbel_evb.c |  7 +++
 board/nuvoton/common/Kconfig        |  9 ++++
 board/nuvoton/common/Makefile       |  1 +
 board/nuvoton/common/uart.c         | 71 +++++++++++++++++++++++++++++
 board/nuvoton/common/uart.h         | 11 +++++
 board/nuvoton/poleg_evb/Kconfig     |  1 +
 board/nuvoton/poleg_evb/poleg_evb.c |  8 ++++
 8 files changed, 109 insertions(+)
 create mode 100644 board/nuvoton/common/Kconfig
 create mode 100644 board/nuvoton/common/Makefile
 create mode 100644 board/nuvoton/common/uart.c
 create mode 100644 board/nuvoton/common/uart.h

diff --git a/board/nuvoton/arbel_evb/Kconfig b/board/nuvoton/arbel_evb/Kconfig
index 33c589f1fb..ed1c1ad8ee 100644
--- a/board/nuvoton/arbel_evb/Kconfig
+++ b/board/nuvoton/arbel_evb/Kconfig
@@ -15,4 +15,5 @@ config SYS_MEM_TOP_HIDE
 	help
 	  Reserve memory for ECC/GFX/OPTEE/TIP/CP.
 
+source "board/nuvoton/common/Kconfig"
 endif
diff --git a/board/nuvoton/arbel_evb/arbel_evb.c b/board/nuvoton/arbel_evb/arbel_evb.c
index 59e1a42564..8fc56c1839 100644
--- a/board/nuvoton/arbel_evb/arbel_evb.c
+++ b/board/nuvoton/arbel_evb/arbel_evb.c
@@ -7,6 +7,7 @@
 #include <dm.h>
 #include <asm/io.h>
 #include <asm/arch/gcr.h>
+#include "../common/uart.h"
 
 #define SR_MII_CTRL_SWR_BIT15	15
 
@@ -90,3 +91,9 @@ int dram_init_banksize(void)
 	return 0;
 }
 
+int last_stage_init(void)
+{
+	board_set_console();
+
+	return 0;
+}
diff --git a/board/nuvoton/common/Kconfig b/board/nuvoton/common/Kconfig
new file mode 100644
index 0000000000..61de7bc5f8
--- /dev/null
+++ b/board/nuvoton/common/Kconfig
@@ -0,0 +1,9 @@
+if ARCH_NPCM
+
+config SYS_SKIP_UART_INIT
+	bool "Skip UART initialization"
+	depends on NPCM_SERIAL
+	help
+	  Select this if the UART you want to use is already
+	  initialized by the time U-Boot starts its execution.
+endif
diff --git a/board/nuvoton/common/Makefile b/board/nuvoton/common/Makefile
new file mode 100644
index 0000000000..8fd83b229b
--- /dev/null
+++ b/board/nuvoton/common/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SYS_SKIP_UART_INIT)	+= uart.o
diff --git a/board/nuvoton/common/uart.c b/board/nuvoton/common/uart.c
new file mode 100644
index 0000000000..3b8badd67a
--- /dev/null
+++ b/board/nuvoton/common/uart.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2023 Nuvoton Technology Corp.
+ */
+
+#include <common.h>
+#include <clk.h>
+#include <dm.h>
+#include <env.h>
+#include <serial.h>
+#include <linux/delay.h>
+
+#define UART_DLL	0x0
+#define UART_DLM	0x4
+#define UART_LCR	0xc
+#define LCR_DLAB	BIT(7)
+
+void board_set_console(void)
+{
+	const unsigned long baudrate_table[] = CFG_SYS_BAUDRATE_TABLE;
+	struct udevice *dev = gd->cur_serial_dev;
+	unsigned int baudrate, max_delta;
+	void __iomem *uart_reg;
+	struct clk clk;
+	char string[32];
+	u32 uart_clk;
+	u8 dll, dlm;
+	u16 divisor;
+	int ret, i;
+
+	if (!dev)
+		return;
+
+	uart_reg = dev_read_addr_ptr(dev);
+	ret = clk_get_by_index(dev, 0, &clk);
+	if (ret)
+		return;
+
+	uart_clk = clk_get_rate(&clk);
+	setbits_8(uart_reg + UART_LCR, LCR_DLAB);
+	dll = readb(uart_reg + UART_DLL);
+	dlm = readb(uart_reg + UART_DLM);
+	clrbits_8(uart_reg + UART_LCR, LCR_DLAB);
+	divisor = dll | (dlm << 8);
+	baudrate =  uart_clk / ((16 * (divisor + 2)));
+	for (i = 0; i < ARRAY_SIZE(baudrate_table); ++i) {
+		max_delta = baudrate_table[i] / 20;
+		if (abs(baudrate - baudrate_table[i]) < max_delta) {
+			/* The baudrate is supported */
+			gd->baudrate = baudrate_table[i];
+			break;
+		}
+	}
+
+	if (i == ARRAY_SIZE(baudrate_table)) {
+		/* current baudrate is not suitable, set to default */
+		divisor = DIV_ROUND_CLOSEST(uart_clk, 16 * gd->baudrate) - 2;
+		setbits_8(uart_reg + UART_LCR, LCR_DLAB);
+		writeb(divisor & 0xff, uart_reg + UART_DLL);
+		writeb(divisor >> 8, uart_reg + UART_DLM);
+		clrbits_8(uart_reg + UART_LCR, LCR_DLAB);
+		udelay(100);
+		printf("\r\nUART(source %u): change baudrate from %u to %u\n",
+		       uart_clk, baudrate, uart_clk / ((16 * (divisor + 2))));
+	}
+
+	debug("Set env baudrate=%u\n", gd->baudrate);
+	snprintf(string, sizeof(string), "ttyS0,%un8", gd->baudrate);
+	env_set("console", string);
+
+}
diff --git a/board/nuvoton/common/uart.h b/board/nuvoton/common/uart.h
new file mode 100644
index 0000000000..9cc895251b
--- /dev/null
+++ b/board/nuvoton/common/uart.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2023 Nuvoton Technology Corp.
+ */
+
+#ifndef _NUVOTON_UART_H
+#define _NUVOTON_UART_H
+
+void board_set_console(void);
+
+#endif /* _NUVOTON_COMMON_H */
diff --git a/board/nuvoton/poleg_evb/Kconfig b/board/nuvoton/poleg_evb/Kconfig
index d3f4c1dd81..6f7f1ef157 100644
--- a/board/nuvoton/poleg_evb/Kconfig
+++ b/board/nuvoton/poleg_evb/Kconfig
@@ -22,4 +22,5 @@ config TARGET_POLEG_EVB
 
 endchoice
 
+source "board/nuvoton/common/Kconfig"
 endif
diff --git a/board/nuvoton/poleg_evb/poleg_evb.c b/board/nuvoton/poleg_evb/poleg_evb.c
index 2052af6649..7421911a41 100644
--- a/board/nuvoton/poleg_evb/poleg_evb.c
+++ b/board/nuvoton/poleg_evb/poleg_evb.c
@@ -10,6 +10,7 @@
 #include <asm/io.h>
 #include <asm/arch/gcr.h>
 #include <asm/mach-types.h>
+#include "../common/uart.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -53,3 +54,10 @@ int dram_init(void)
 
 	return 0;
 }
+
+int last_stage_init(void)
+{
+	board_set_console();
+
+	return 0;
+}
-- 
2.25.1

