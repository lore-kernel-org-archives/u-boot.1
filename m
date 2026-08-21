Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B22C5DF89
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:17:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F41E761039;
	Fri, 21 Aug 2026 13:17:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 01APJm4XBt4C; Fri, 21 Aug 2026 13:17:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318082;
	bh=94JUQfT7Ei1J/+4ToB0rfBA9YujicOnrX4NdY/GL6Es=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aLUlJPTnY0UO4sr4LDTmKyqLgiWstH1AUC3wWhw4Ly39cwmdxjBG8yh9bf4KXxkHk
	 JG8idDSV5uT0fGnsKK+dr18GCI2/D+SgAWJitb09c+4oI14Qh6vw+D5AUGHdU8AuEw
	 ZYI14b2G3jYxthNRUA4SQKtCFV0MFOA4zcmVXyxJf1IL/yfSmWoZZwq4sZC+ECXCl4
	 TV0qEiLjipnAXpwCbPlNhBUuRzOidYU90xNGTZUdFn5wWP+TyXoDllMK4bZFwvigSF
	 XI9CPL3Hyk3zw/uFa/ELIeLvjXjhfd4mpe9yHZvf4T7Nj0KPQkNFQJQOVzK+HPItmS
	 DnaQ42QHw60Kw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29F6660E86;
	Fri, 21 Aug 2026 13:14:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EF0581B8
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:46:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D4A1860661
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:46:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qqEqgc3tlAil for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:46:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.221.48;
 helo=mail-wr1-f48.google.com; envelope-from=tanurelinux@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=linux.com
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6E1046061D
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:46:12 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-4813ea321cdso1309049f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:46:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787301970; x=1787906770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=94JUQfT7Ei1J/+4ToB0rfBA9YujicOnrX4NdY/GL6Es=;
 b=VTBYxQXhb54Ogm7TR+3IhIexjPIaaXEDXgafGjfAeS2iwfntT1buJrKKvkhGmXLxBQ
 O0tFqwWSDt5hxtiga25X/31WQCnyXvxLCmw8HnLsoGdHJiky2VKlncS5yRemxZ3ndDpt
 p+XAh2NPCtx39UATqZ8qRId6wkj0p0qWDvKPmmQEVEnIFtI78bSvkNzmJtz5xOnWOuTv
 pyQCRVtfrltWD7oIbqW+N64w2XRiNvGyWn/X1Eezp5b9mwld7tXIekedX/hGVsMllW4B
 kJ8nYrnfXHARVbXqCyOXm8wwFmyqlmVAIJQ4LY8gCkDtyJHARnIjExeSJiH093CZi6Vc
 F49A==
X-Gm-Message-State: AOJu0Yx7SWZZtm/qXgKo5A2Sx8+1R+tKphvoTQk0xm7nw6ZCctq38h27
 7D8aXJM9tNpbCo5GBbM4rkCdTHFkSJISRUrgG1u4vBZO9seNVlOXt+ZSNJwSKg==
X-Gm-Gg: AR+sD11kZHGsvVdbQyULkdDx7lbrtPYbDsvFOgeFV/gmWI+P6nRlX7WEr6KwhQr2DME
 XGPGcJOG4uGV9tu9kav6F3Adrf7m6dRuuqAxkj2RUzzriKPX3ejIS+guic3ehKMadTEvEYgbJZx
 fCYyXY8oyHx3jQRqL1efcmuwsMlmRBw/ldOHjZVezEJb47oLoYLUqYh4dXi6vAtk6wJEediT4pf
 JEpdUWYgY/TSDSEzX/CZgtEo2XHb3/QPO5quzvkFWAbKc2zXtC3AWRf/uvO5DpQ8nLvrUW/tAX7
 x7254W+OCAsUleK/Ot44bOKP9rXRnh37NXzy0hpJeXGYFyLO2Q/qu5B+Tl92R9a49bzsgROe1PI
 eiI0sT63qclrvu5XzAiriijrHMa5XXMpM7Xum70hM/QZb00rOLDhFnr6aywAYcHFKb9z5LwWe6j
 +AE66yRCMkiYl6akI6rszBWcZzPzN2Kq7V0Av0YuxHnFrN2ZyVJpggtX0XaApB7QY4FITjS499P
 NDM6XpSjarA6jPslTI6d5VceiY=
X-Received: by 2002:a05:600c:5490:b0:499:59fd:dbfc with SMTP id
 5b1f17b1804b1-499b913eb08mr36889765e9.1.1787301969984; 
 Fri, 21 Aug 2026 01:46:09 -0700 (PDT)
Received: from threads.localdomain ([83.106.158.114])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e747esm22978115e9.4.2026.08.21.01.46.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:46:09 -0700 (PDT)
From: Lucas Tanure <tanure@linux.com>
To: u-boot@lists.u-boot-project.org
Cc: neil.armstrong@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 funderscore@postmasteros.org, u-boot-amlogic@groups.io
Subject: [PATCH v2 3/4] board: amlogic: add Khadas VIM4 support
Date: Fri, 21 Aug 2026 09:46:02 +0100
Message-ID: <20260821084603.25974-4-tanure@linux.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821084603.25974-1-tanure@linux.com>
References: <20260821084603.25974-1-tanure@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:12:32 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add initial support for the Khadas VIM4 board (Amlogic A311D2, T7
family): UART console, DRAM (first bank), PSCI reset through BL31 and
the secure monitor. Storage, network and USB support come later.

The image is position independent with TEXT_BASE=0, so the same
u-boot.bin can be chainloaded from the vendor U-Boot for development
or packaged as BL33 into the vendor boot image.

The console runs at 921600 baud, the serial console convention on the
VIM4 (this is also how BL2 configures uart_a).

Assisted-by: Claude:claude-fable-5
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 .../amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi | 16 ++++++++++++
 arch/arm/dts/amlogic-t7-u-boot.dtsi           | 14 ++++++++++
 board/amlogic/vim4/MAINTAINERS                |  7 +++++
 board/amlogic/vim4/Makefile                   |  4 +++
 board/amlogic/vim4/vim4.c                     | 14 ++++++++++
 configs/khadas-vim4_defconfig                 | 26 +++++++++++++++++++
 6 files changed, 81 insertions(+)
 create mode 100644 arch/arm/dts/amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi
 create mode 100644 arch/arm/dts/amlogic-t7-u-boot.dtsi
 create mode 100644 board/amlogic/vim4/MAINTAINERS
 create mode 100644 board/amlogic/vim4/Makefile
 create mode 100644 board/amlogic/vim4/vim4.c
 create mode 100644 configs/khadas-vim4_defconfig

diff --git a/arch/arm/dts/amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi b/arch/arm/dts/amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi
new file mode 100644
index 00000000000..eaf9f073050
--- /dev/null
+++ b/arch/arm/dts/amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2026 Lucas Tanure <tanure@linux.com>
+ */
+
+#include "amlogic-t7-u-boot.dtsi"
+
+/ {
+	chosen {
+		stdout-path = "serial0:921600n8";
+	};
+};
+
+&xtal {
+	bootph-all;
+};
diff --git a/arch/arm/dts/amlogic-t7-u-boot.dtsi b/arch/arm/dts/amlogic-t7-u-boot.dtsi
new file mode 100644
index 00000000000..648685e1acf
--- /dev/null
+++ b/arch/arm/dts/amlogic-t7-u-boot.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2026 Lucas Tanure <tanure@linux.com>
+ */
+
+/ {
+	soc {
+		bootph-all;
+	};
+};
+
+&uart_a {
+	bootph-all;
+};
diff --git a/board/amlogic/vim4/MAINTAINERS b/board/amlogic/vim4/MAINTAINERS
new file mode 100644
index 00000000000..5e1ec98b571
--- /dev/null
+++ b/board/amlogic/vim4/MAINTAINERS
@@ -0,0 +1,7 @@
+VIM4
+M:	Lucas Tanure <tanure@linux.com>
+S:	Maintained
+L:	u-boot-amlogic@groups.io
+F:	board/amlogic/vim4/
+F:	configs/khadas-vim4_defconfig
+F:	arch/arm/dts/amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi
diff --git a/board/amlogic/vim4/Makefile b/board/amlogic/vim4/Makefile
new file mode 100644
index 00000000000..0cc4078c549
--- /dev/null
+++ b/board/amlogic/vim4/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0+
+# (C) Copyright 2026 Lucas Tanure <tanure@linux.com>
+
+obj-y	:= vim4.o
diff --git a/board/amlogic/vim4/vim4.c b/board/amlogic/vim4/vim4.c
new file mode 100644
index 00000000000..5db3deefe0e
--- /dev/null
+++ b/board/amlogic/vim4/vim4.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2026 Lucas Tanure <tanure@linux.com>
+ */
+
+#include <init.h>
+#include <asm/arch/eth.h>
+
+int misc_init_r(void)
+{
+	meson_generate_serial_ethaddr();
+
+	return 0;
+}
diff --git a/configs/khadas-vim4_defconfig b/configs/khadas-vim4_defconfig
new file mode 100644
index 00000000000..a9c22c44986
--- /dev/null
+++ b/configs/khadas-vim4_defconfig
@@ -0,0 +1,26 @@
+CONFIG_ARM=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_MESON=y
+CONFIG_TEXT_BASE=0x00000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SIZE=0x2000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="amlogic/amlogic-t7-a311d2-khadas-vim4"
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_MESON_T7=y
+CONFIG_SYS_LOAD_ADDR=0x10000000
+CONFIG_DEBUG_UART_BASE=0xfe078000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_IDENT_STRING=" khadas-vim4"
+CONFIG_DEBUG_UART=y
+CONFIG_OF_BOARD_SETUP=y
+# CONFIG_DISPLAY_CPUINFO is not set
+# CONFIG_DISPLAY_BOARDINFO is not set
+# CONFIG_CMD_BDI is not set
+# CONFIG_CMD_IMI is not set
+CONFIG_CMD_CACHE=y
+CONFIG_OF_CONTROL=y
+CONFIG_BAUDRATE=921600
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_SKIP_INIT=y
+CONFIG_MESON_SERIAL=y
-- 
2.55.0

