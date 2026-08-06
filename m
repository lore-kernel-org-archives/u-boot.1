Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A24AC5AC7A
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 11:00:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D409060812;
	Thu,  6 Aug 2026 11:00:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vp-rdeP9xPIQ; Thu,  6 Aug 2026 11:00:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 14D1060815
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786014050;
	bh=mhGZLpBLgb5UeQ/06X3FSYNDSPn7g7XpH2CgeIk2W+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FuJpFavRWnsl+1J0S25ItWkt9UqO2+sImk4jlnms3/hSp9Xt1wopW+KIcOnEZyUsW
	 phaQTjDhyUq9OEEGuznVMeuTjLFdHIfHfgz6YP2EEAMXOTuJARaet6IdinodaZ9T0Z
	 cvsSG4z39wi6nYJM94nqSxN0gXzTbFD47/zoKLZPzLxwtDFuBSYgnYAdg33lIuHldX
	 rzMlhqdR08YPfFjwu/fELg5WxRwKQtQCWGYdwaaxGgzV75p9ql519El1nqJhLCgh7F
	 YgolvLHIE/WtRyzK49J3W87okZwm0OLdqGuoj3KfCcKn2YoE2BS1cGre5CFXA3kQ0z
	 uAJEL+iaGIBlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 14D1060815;
	Thu,  6 Aug 2026 11:00:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 80AD62B6
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 10:18:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 72CDD40207
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 10:18:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZV6sfjGqnYE4 for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 10:18:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.128.54;
 helo=mail-wm1-f54.google.com; envelope-from=tanurelinux@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6DBE540167
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6DBE540167
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6DBE540167
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 10:18:17 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49802c418b5so19376615e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 03:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786011495; x=1786616295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mhGZLpBLgb5UeQ/06X3FSYNDSPn7g7XpH2CgeIk2W+8=;
 b=fbRJYX3ySUYJWl6gPuRvLb26dH2tiYVkmwDUuQpI2zODfBDDmrW+TcPmrPmnPhZ5is
 nu5hm6Wq3fX0qgzEwd7NllJRadwPe31bcrb8X4VGVTjuwAAkZBUtujsYH6CLHMb8WFTt
 q/RsTBHLB48OUnNinmn264JMxjpycovsihz1NcrUMFHaOeXdOwFoi49VwhKqodFFQ6/F
 9HNmt5A9WoHno8cQ8V1nY1ltAmW3U3xVXur94gl/xmE8YA2mmdNufpV352dLQZOauJPW
 B1uLfxGaWNV0Pk/vcUGn77iwudUsrzkHHX4x4+PMlaSrtzcukjTbQMWnxhvZUCmw2o/H
 HTpg==
X-Gm-Message-State: AOJu0YyDTb7mxqz1qDAGJx/pdTI3H6J+r8gzT6su2x2EsABwTAPDd3J6
 qbR9As+6KTRUBR+CYRIClB1TGt64XVHgakor7j++qCdx6dqp5Ds5FegPJjUkMA==
X-Gm-Gg: AR+sD11io1rNaHUO1hDgqrQEosTrAUJfCopMDBGH5zMvs13WHQmBhWckrPgYLJh/97F
 OVfLEktLkbHOYK9S3RG1Ltr6BkkDvpHXQusjU8UypQScdPlkuoTvrrT6WpLkLG6zk45gcUxg+LK
 RBlumilCr+HDtu3snC+w8zwvzEnxjCbQUagFPpD7ogRRPlcDDZR5rvnfrPdti/p/tutFak2H7Wj
 SFCWylZIPJ/JQg8ooM8vIPAATKWjgO7q6yuojXuh+JLhVAQ3UyE9JJpqeHEFqJReu9Ssx688D93
 taAgcz5U+rDW4FNf/Da8Cc1UXEUfUD3YVhXJSEdI9oCxiCfIaQj1fl6+bPlz5GOHvhXOtp/BPIW
 b83rdh4I73IUakxC9ETxrhs6aYrT2YWPZEfr8IzJP9dAUtsaCKP1AcJ6l8x5s8oJNpyJyIssYn2
 DZaeBDfIwdfkPhlGCXdJkVHRM0PQbgzxc+IdbgCboyMxWmmVcwxer+nxBQilSbJarCNQ7eSRsKt
 Qg8whYk8gheOBkoRpKBGpqAOj8=
X-Received: by 2002:a05:600c:1f86:b0:499:52ab:a50c with SMTP id
 5b1f17b1804b1-49952aba5b3mr74323785e9.1.1786011495312; 
 Thu, 06 Aug 2026 03:18:15 -0700 (PDT)
Received: from threads.localdomain ([83.106.158.114])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4994e988687sm108654725e9.3.2026.08.06.03.18.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 03:18:14 -0700 (PDT)
From: Lucas Tanure <tanure@linux.com>
To: u-boot@lists.u-boot-project.org
Cc: neil.armstrong@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 funderscore@postmasteros.org, u-boot-amlogic@groups.io,
 Lucas Tanure <tanure@linux.com>
Subject: [PATCH 3/4] board: amlogic: add Khadas VIM4 support
Date: Thu,  6 Aug 2026 11:18:08 +0100
Message-ID: <20260806101809.72526-4-tanure@linux.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806101809.72526-1-tanure@linux.com>
References: <20260806101809.72526-1-tanure@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Aug 2026 11:00:31 +0000
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=fail (p=none dis=none)
 header.from=linux.com
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

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
 .../amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi | 22 +++++++++++++++
 board/amlogic/vim4/MAINTAINERS                |  7 +++++
 board/amlogic/vim4/Makefile                   |  4 +++
 board/amlogic/vim4/vim4.c                     | 14 ++++++++++
 configs/khadas-vim4_defconfig                 | 27 +++++++++++++++++++
 5 files changed, 74 insertions(+)
 create mode 100644 arch/arm/dts/amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi
 create mode 100644 board/amlogic/vim4/MAINTAINERS
 create mode 100644 board/amlogic/vim4/Makefile
 create mode 100644 board/amlogic/vim4/vim4.c
 create mode 100644 configs/khadas-vim4_defconfig

diff --git a/arch/arm/dts/amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi b/arch/arm/dts/amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi
new file mode 100644
index 00000000000..dde2cd804e3
--- /dev/null
+++ b/arch/arm/dts/amlogic-t7-a311d2-khadas-vim4-u-boot.dtsi
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2026 Lucas Tanure <tanure@linux.com>
+ */
+
+/ {
+	chosen {
+		stdout-path = "serial0:921600n8";
+	};
+
+	soc {
+		bootph-all;
+	};
+};
+
+&uart_a {
+	bootph-all;
+};
+
+&xtal {
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
index 00000000000..10a64c07a88
--- /dev/null
+++ b/configs/khadas-vim4_defconfig
@@ -0,0 +1,27 @@
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
+CONFIG_SYS_PROMPT="kvim4> "
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

