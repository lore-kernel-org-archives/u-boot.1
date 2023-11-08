Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6CBC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 00:41:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF774876F9;
	Wed,  8 Nov 2023 01:40:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H5AYvUx3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47AA8876DD; Wed,  8 Nov 2023 01:40:54 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 485C4876F6
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 01:40:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-27db9fdec0dso5923295a91.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 16:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699404048; x=1700008848; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=opjCm2+7u+cdZDEcJE69PX72nKIigJdJRX5lfThnolY=;
 b=H5AYvUx3jX6+2sfR8172Piaiw1A72EGhOnJDP3Zg6aLz+LM4qjfjylJinSeyvKGstj
 DCUbT/n44oBRppYP9lAETpn/aIRBtUYR8RZ//FN2Jqu01ITbKHV4Eo4jY4XHNT5khjoW
 mWEy3U76eeDI59Ka3NpAHhGQwkrv4y/3jzg6fWNFY6AjqDdAeOAY+PtuDhTyh1THJelQ
 4iK0K70E8dg7fdGoYNGejDXFeo7TXrh1IKFm+zdAFDDE5EQ60K+9aFHaA/jc0HfMACxD
 rwt1y1B0g/rC2p6t6yjesVnvkSHW7dQF8KmQqmNlvSWlxGZGUFusUZw12M0gzMMR67g0
 aABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699404048; x=1700008848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=opjCm2+7u+cdZDEcJE69PX72nKIigJdJRX5lfThnolY=;
 b=UCT3I7G1mj0eRLK2ZOFi9GFMg3n73EbImhX4AfAtCSqubc6RA164u526GruNTo/He2
 QzSux3afFS9yY3TqQE5jIWgYDCC+pdDaC463MDOqBVChe7cc4s42JAsOgtx8seHs8V5a
 W2WBuC/TNS+j4vSG9coBC7Hp007Wyb/FrYkVnWBcW2KNRYVWm+OfNpIVg+D7PRDwKHdr
 3vgyrDgHXMwlqqvX18wCDZp+pjnvTfIuvZTgYBvLJW2tyqOWHDS/Vzrp9vD9Zp4HxF3u
 ghiEhoFYAix2vv95g5JZc8PQHwPGRpjZg7RMkiyKqgbD9PliaaCWnxsioD8D7cQdwNU0
 zqaQ==
X-Gm-Message-State: AOJu0Yx4mPh4VgEEkbyY9iVXejbHKD0kd7zrxmdCzOgvx+KOfRAozpTv
 NqhymYQQF6GAzN1+xzkLc/uZ1d37Ic4=
X-Google-Smtp-Source: AGHT+IG5wOVwKvcq+vM8c4sEMvimRNkO+AXDdILOVIpPh46DkEn5l7QNIUC7hnOzJKgHGNSd090EYg==
X-Received: by 2002:a17:90b:4c8f:b0:27c:e062:c464 with SMTP id
 my15-20020a17090b4c8f00b0027ce062c464mr346760pjb.37.1699404048551; 
 Tue, 07 Nov 2023 16:40:48 -0800 (PST)
Received: from cs20-buildserver.lan ([180.217.132.54])
 by smtp.gmail.com with ESMTPSA id
 mv21-20020a17090b199500b0028066f3c373sm384284pjb.17.2023.11.07.16.40.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 16:40:48 -0800 (PST)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, YSCHU@nuvoton.com--compose, KWLIU@nuvoton.com,
 jim.t90615@gmail.com, trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/4] board: nuvoton: update console environment variable
Date: Wed,  8 Nov 2023 08:40:25 +0800
Message-Id: <20231108004027.281383-3-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231108004027.281383-1-JJLIU0@nuvoton.com>
References: <20231108004027.281383-1-JJLIU0@nuvoton.com>
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
 board/nuvoton/arbel_evb/Kconfig |  1 +
 board/nuvoton/common/Kconfig    |  9 +++++
 board/nuvoton/common/Makefile   |  1 +
 board/nuvoton/common/common.c   | 71 +++++++++++++++++++++++++++++++++
 board/nuvoton/common/common.h   | 11 +++++
 board/nuvoton/poleg_evb/Kconfig |  1 +
 6 files changed, 94 insertions(+)
 create mode 100644 board/nuvoton/common/Kconfig
 create mode 100644 board/nuvoton/common/Makefile
 create mode 100644 board/nuvoton/common/common.c
 create mode 100644 board/nuvoton/common/common.h

diff --git a/board/nuvoton/arbel_evb/Kconfig b/board/nuvoton/arbel_evb/Kconfig
index 33c589f1fb..ed1c1ad8ee 100644
--- a/board/nuvoton/arbel_evb/Kconfig
+++ b/board/nuvoton/arbel_evb/Kconfig
@@ -15,4 +15,5 @@ config SYS_MEM_TOP_HIDE
 	help
 	  Reserve memory for ECC/GFX/OPTEE/TIP/CP.
 
+source "board/nuvoton/common/Kconfig"
 endif
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
index 0000000000..52e77185c4
--- /dev/null
+++ b/board/nuvoton/common/Makefile
@@ -0,0 +1 @@
+obj-y	+= common.o
diff --git a/board/nuvoton/common/common.c b/board/nuvoton/common/common.c
new file mode 100644
index 0000000000..6da9d93e80
--- /dev/null
+++ b/board/nuvoton/common/common.c
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
+int board_set_console(void)
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
+	/* If uart init is skipped, update the actual baudrate in boot arguments */
+	if (!IS_ENABLED(CONFIG_SYS_SKIP_UART_INIT))
+		return 0;
+	if (!dev)
+		return 0;
+	uart_reg = dev_read_addr_ptr(dev);
+	ret = clk_get_by_index(dev, 0, &clk);
+	if (ret)
+		return 0;
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
+	debug("Set env baudrate=%u\n", gd->baudrate);
+	snprintf(string, sizeof(string), "ttyS0,%un8", gd->baudrate);
+	env_set("console", string);
+
+	return 0;
+}
diff --git a/board/nuvoton/common/common.h b/board/nuvoton/common/common.h
new file mode 100644
index 0000000000..64a09670cb
--- /dev/null
+++ b/board/nuvoton/common/common.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2023 Nuvoton Technology Corp.
+ */
+
+#ifndef _NUVOTON_COMMON_H
+#define _NUVOTON_COMMON_H
+
+int board_set_console(void);
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
-- 
2.25.1

