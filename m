Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CC5106289F
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 13:17:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B349084118;
	Wed, 11 Mar 2026 14:16:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="T1oQteM6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49D5183F6D; Wed, 11 Mar 2026 09:41:53 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E85A83FDE
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 09:41:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sgdfkk@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=+R
 RctQiDz10VO7hYlJBBD3FZic+A0WGqjtUyOAGP5Sw=; b=T1oQteM6ojbZjK4J4r
 +t12gBLeRlv/TVG7g1ITnF3MpFAGGrKGbRNyNoFp3tQq8o6jZLbW1H82zpQjCr8Z
 CId4exkyNxIHQ9e0nO55Sj2njQ0jlUcVI6Ru6I7nNFz5DSP/BjbhkJjVtZva5/FO
 RiYq1HbKKmnNXfVCQgxiOVHoo=
Received: from server-e.. (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id
 _____wAHLsa5KrFpe9OOAQ--.40770S5; 
 Wed, 11 Mar 2026 16:41:32 +0800 (CST)
From: sgdfkk@163.com
To: duhuanpeng@139.com,
	u-boot@lists.denx.de
Cc: chenhuacai@loongson.cn, jiaxun.yang@flygoat.com,
 Du Huanpeng <u74147@gmail.com>
Subject: [PATCH v6 3/7] mips: loongson: lowlevel debug serial
Date: Wed, 11 Mar 2026 16:41:25 +0800
Message-ID: <20260311084129.12809-4-sgdfkk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311084129.12809-1-sgdfkk@163.com>
References: <20260311084129.12809-1-sgdfkk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAHLsa5KrFpe9OOAQ--.40770S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxtw1UZrWrCw1fJr4kGFy3urg_yoW7XFy7pF
 1xAan5KF4DXw47KasYy3WkGrnxtrs5Jry7JFnrXF1ru3Z7t3Z5CF42kFn0vrW3JFZ5GrWF
 9ayavrW2gas7Zw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j9HUgUUUUU=
X-Originating-IP: [240e:3b0:4805:1b6:5ef3:fcff:feed:1d83]
X-CM-SenderInfo: xvjgwyrn6rljoofrz/xtbCwByA12mxKrzZNwAA3r
X-Mailman-Approved-At: Wed, 11 Mar 2026 14:15:12 +0100
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

From: Du Huanpeng <u74147@gmail.com>

set pin to uart alternate function and enable uart for lowlevel debug,
also future pinctrl driver can base on this code.

Signed-off-by: Du Huanpeng <u74147@gmail.com>
---
 arch/mips/mach-loongson/include/mach/serial.h |  16 +++
 arch/mips/mach-loongson/ls1c300/gpio.c        |  66 +++++++++++
 arch/mips/mach-loongson/ls1c300/serial.c      | 104 ++++++++++++++++++
 3 files changed, 186 insertions(+)
 create mode 100644 arch/mips/mach-loongson/include/mach/serial.h
 create mode 100644 arch/mips/mach-loongson/ls1c300/gpio.c
 create mode 100644 arch/mips/mach-loongson/ls1c300/serial.c

diff --git a/arch/mips/mach-loongson/include/mach/serial.h b/arch/mips/mach-loongson/include/mach/serial.h
new file mode 100644
index 00000000000..7afe5788cb7
--- /dev/null
+++ b/arch/mips/mach-loongson/include/mach/serial.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 MediaTek Inc.
+ *
+ * Author:  Gao Weijie <weijie.gao@mediatek.com>
+ *
+ * Copyright (C) 2022 Du Huanpeng <u74147@gmail.com>
+ */
+
+#ifndef __LSMIPS_SERIAL_H_
+#define __LSMIPS_SERIAL_H_
+
+void loongson_spl_serial_init(void);
+int gpio_set_alternate(int gpio, int func);
+
+#endif /* __LSMIPS_SERIAL_H_ */
diff --git a/arch/mips/mach-loongson/ls1c300/gpio.c b/arch/mips/mach-loongson/ls1c300/gpio.c
new file mode 100644
index 00000000000..7f160408382
--- /dev/null
+++ b/arch/mips/mach-loongson/ls1c300/gpio.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2022 Du Huanpeng <u74147@gmail.com>
+ */
+
+#include <linux/errno.h>
+#include <asm/bitops.h>
+
+#define CBUS_FIRST0	0xbfd011c0
+#define CBUS_SECOND0	0xbfd011d0
+#define CBUS_THIRD0	0xbfd011e0
+#define CBUS_FOURTHT0	0xbfd011f0
+#define CBUS_FIFTHT0	0xbfd01200
+
+#define CBUS_FIRST1	0xbfd011c4
+#define CBUS_SECOND1	0xbfd011d4
+#define CBUS_THIRD1	0xbfd011e4
+#define CBUS_FOURTHT1	0xbfd011f4
+#define CBUS_FIFTHT1	0xbfd01204
+
+#define CBUS_FIRST2	0xbfd011c8
+#define CBUS_SECOND2	0xbfd011d8
+#define CBUS_THIRD2	0xbfd011e8
+#define CBUS_FOURTHT2	0xbfd011f8
+#define CBUS_FIFTHT2	0xbfd01208
+
+#define CBUS_FIRST3	0xbfd011cc
+#define CBUS_SECOND3	0xbfd011dc
+#define CBUS_THIRD3	0xbfd011ec
+#define CBUS_FOURTHT3	0xbfd011fc
+#define CBUS_FIFTHT3	0xbfd0120c
+
+/*
+ * pinmux for debug uart and spl only, for others, please
+ * use a pinctrl driver and device-tree for pin muxing.
+ *
+ * @gpio: gpio number
+ * @func: alternate function 1 to 5, 0 for GPIO.
+ */
+
+int gpio_set_alternate(int gpio, int func)
+{
+	volatile void __iomem *addr;
+	int i;
+
+	if (gpio < 0 || gpio > 104)
+		return -ENODEV;
+	if (func < 0 || func > 5)
+		return -EINVAL;
+
+	if (func) {
+		i = func - 1;
+		addr = (void *)CBUS_FIRST0 + i * 16;
+		set_bit(gpio, addr);
+	} else {
+		/* GPIO, clear CBUS 1 ~ 5 */
+		i = 5;
+	}
+
+	while (i--) {
+		addr = (void *)CBUS_FIRST0 + 16 * i;
+		clear_bit(gpio, addr);
+	}
+
+	return 0;
+}
diff --git a/arch/mips/mach-loongson/ls1c300/serial.c b/arch/mips/mach-loongson/ls1c300/serial.c
new file mode 100644
index 00000000000..a7697574dad
--- /dev/null
+++ b/arch/mips/mach-loongson/ls1c300/serial.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2026 Du Huanpeng <u74147@gmail.com>
+ */
+
+#include <mach/serial.h>
+#include <linux/kernel.h>
+
+struct uart_pin_config {
+	char port;
+	char afunc;
+	char rx;
+	char tx;
+};
+
+struct uart_pin_config con[] = {
+#if CONFIG_CONS_INDEX == 0
+	{ 0, 2, 74, 75 },
+	{ 0, 3, 23, 24 },
+	{ 0, 3, 99, 100 },
+
+#elif CONFIG_CONS_INDEX == 1
+	{ 1, 1, 17, 18 },
+	{ 1, 1, 101, 102 },
+	{ 1, 2, 40, 41 },
+	{ 1, 4, 2, 3 },
+
+#elif CONFIG_CONS_INDEX == 2
+	{ 2, 2, 36, 37 },
+	{ 2, 2, 42, 43 },
+	{ 2, 3, 27, 28 },
+	{ 2, 3, 103, 104 },
+	{ 2, 4, 4, 5 },
+
+#elif CONFIG_CONS_INDEX == 3
+	{ 3, 2, 17, 18 },
+	{ 3, 2, 33, 34 },
+	{ 3, 2, 44, 45 },
+	{ 3, 4, 0, 1 },
+
+#elif CONFIG_CONS_INDEX == 4
+	{ 4, 5, 23, 24 },
+	{ 4, 5, 58, 59 },
+	{ 4, 5, 80, 79 },
+
+#elif CONFIG_CONS_INDEX == 5
+	{ 5, 5, 25, 26 },
+	{ 5, 5, 60, 61 },
+	{ 5, 5, 81, 78 },
+
+#elif CONFIG_CONS_INDEX == 6
+	{ 6, 5, 27, 46 },
+	{ 6, 5, 62, 63 },
+
+#elif CONFIG_CONS_INDEX == 7
+	{ 7, 5, 57, 56 },
+	{ 7, 5, 64, 65 },
+	{ 7, 5, 87, 88 },
+
+#elif CONFIG_CONS_INDEX == 8
+	{ 8, 5, 55, 54 },
+	{ 8, 5, 66, 67 },
+	{ 8, 5, 89, 90 },
+
+#elif CONFIG_CONS_INDEX == 9
+	{ 9, 5, 53, 52 },
+	{ 9, 5, 68, 69 },
+	{ 9, 5, 85, 86 },
+
+#elif CONFIG_CONS_INDEX == 10
+	{ 10, 5, 51, 50 },
+	{ 10, 5, 70, 71 },
+	{ 10, 5, 84, 82 },
+
+#elif CONFIG_CONS_INDEX == 11
+	{ 11, 5, 49, 48 },
+	{ 11, 5, 72, 73 },
+#endif /* CONFIG_CONS_INDEX */
+};
+
+#define UART2_RX	36
+#define UART2_TX	37
+#define AFUNC		2
+
+void loongson_spl_serial_init(void)
+{
+#if defined(CONFIG_SPL_SERIAL)
+	int pin_rx, pin_tx;
+	int afunc;
+
+	if (CONFIG_CONS_PIN < ARRAY_SIZE(con)) {
+		pin_rx = con[CONFIG_CONS_PIN].rx;
+		pin_tx = con[CONFIG_CONS_PIN].tx;
+		afunc = con[CONFIG_CONS_PIN].afunc;
+	} else {
+		pin_rx = UART2_RX;
+		pin_tx = UART2_TX;
+		afunc = AFUNC;
+	}
+
+	gpio_set_alternate(pin_rx, afunc);
+	gpio_set_alternate(pin_tx, afunc);
+#endif /* CONFIG_SPL_SERIAL */
+}
-- 
2.43.0

