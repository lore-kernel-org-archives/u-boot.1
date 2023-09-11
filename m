Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF46EEE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 16:42:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8613C86E3A;
	Mon, 11 Sep 2023 18:42:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="QwTgLG+/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DDC186E51; Mon, 11 Sep 2023 18:35:51 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9033A86E3A
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 18:35:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id EAFE1100015;
 Mon, 11 Sep 2023 19:35:45 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru EAFE1100015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1694450145;
 bh=IGtNQDaCRzrahgHolmZfcOvstG/UUE+40mRb2JGIXMA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=QwTgLG+/qi9sQdC6VAYyledMnoxbT5HtIhVnQLBdYiQEsScc9t0Yda0uiLK0nPgFF
 nnB/QTkwWeB9UUJbKYZ4y5JxsCWpB8aRoO2Rq9u8WpmNVhF4ucLJ4LknbMYjAsgk/6
 bV+kv8tFKKD/sduqQmXq8+nxJgxydD30uFp2Y5LQPaKbeDvDxTW/7iv/vdeQp1idWu
 KHA8UrU78Md7m6dHyoU8AbosZN3N8mRT37LdFVA0ETReECoTFJPVp7wZbdpPr8nXkp
 rGV4oWAPcEnTGngtcqDjH8rxdaWJsAPM6Jz31H0WUzD1xD+yZvrlQ7XS55pm1JnD1p
 6DRv3yjbTU79g==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Mon, 11 Sep 2023 19:35:45 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 11 Sep 2023 19:35:45 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <narmstrong@baylibre.com>, <sjg@google.com>, 
 <takahiro.akashi@linaro.org>, <ilias.apalodimas@linaro.org>,
 <post@lespocky.de>, <marex@denx.de>, <msuchanek@suse.de>,
 <sughosh.ganu@linaro.org>, <jh80.chung@samsung.com>,
 <paul.barker@sancloud.com>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
 <kernel@sberdevices.ru>, Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v2 1/8] drivers: introduce Secure Monitor uclass
Date: Mon, 11 Sep 2023 19:35:29 +0300
Message-ID: <20230911163536.20735-2-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230911163536.20735-1-avromanov@salutedevices.com>
References: <20230911163536.20735-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 179783 [Sep 11 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 530 530
 ecb1547b3f72d1df4c71c0b60e67ba6b4aea5432,
 {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1; 127.0.0.199:7.1.2;
 salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/09/11 06:02:00 #21866861
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Mon, 11 Sep 2023 18:42:19 +0200
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

At the moment, we don't have a common API for working with
SM, only the smc_call() function. This approach is not generic
and difficult to configure and maintain.

This patch adds UCLASS_SM with the generic API:

- sm_call()
- sm_call_write()
- sm_call_read()

These functions operate with struct pt_regs, which describes
Secure Monitor arguments.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/Kconfig        |  2 ++
 drivers/Makefile       |  1 +
 drivers/sm/Kconfig     |  2 ++
 drivers/sm/Makefile    |  3 ++
 drivers/sm/sm-uclass.c | 55 ++++++++++++++++++++++++++++++++
 include/dm/uclass-id.h |  1 +
 include/sm-uclass.h    | 72 ++++++++++++++++++++++++++++++++++++++++++
 include/sm.h           | 67 +++++++++++++++++++++++++++++++++++++++
 8 files changed, 203 insertions(+)
 create mode 100644 drivers/sm/Kconfig
 create mode 100644 drivers/sm/Makefile
 create mode 100644 drivers/sm/sm-uclass.c
 create mode 100644 include/sm-uclass.h
 create mode 100644 include/sm.h

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 75ac149d31..72e6405322 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -112,6 +112,8 @@ source "drivers/scsi/Kconfig"
 
 source "drivers/serial/Kconfig"
 
+source "drivers/sm/Kconfig"
+
 source "drivers/smem/Kconfig"
 
 source "drivers/sound/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 6f1de58e00..b7bd3633b1 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -124,3 +124,4 @@ obj-$(CONFIG_DM_RNG) += rng/
 endif
 
 obj-y += soc/
+obj-y += sm/
diff --git a/drivers/sm/Kconfig b/drivers/sm/Kconfig
new file mode 100644
index 0000000000..6cc6d55578
--- /dev/null
+++ b/drivers/sm/Kconfig
@@ -0,0 +1,2 @@
+config SM
+	bool "Enable Secure Monitor driver support"
diff --git a/drivers/sm/Makefile b/drivers/sm/Makefile
new file mode 100644
index 0000000000..9f4683ba06
--- /dev/null
+++ b/drivers/sm/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-y += sm-uclass.o
diff --git a/drivers/sm/sm-uclass.c b/drivers/sm/sm-uclass.c
new file mode 100644
index 0000000000..78af857026
--- /dev/null
+++ b/drivers/sm/sm-uclass.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2023 SberDevices, Inc.
+ *
+ * Author: Alexey Romanov <avromanov@salutedevices.com>
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <errno.h>
+#include <sm-uclass.h>
+
+static const struct sm_ops *get_sm_ops(struct udevice *dev)
+{
+	return (const struct sm_ops *)dev->driver->ops;
+}
+
+int sm_call(struct udevice *dev, u32 cmd, s32 *ret, struct pt_regs *args)
+{
+	const struct sm_ops *ops = get_sm_ops(dev);
+
+	if (ops->sm_call)
+		return ops->sm_call(dev, cmd, ret, args);
+
+	return -EPROTONOSUPPORT;
+}
+
+int sm_call_read(struct udevice *dev, void *buffer, size_t size,
+		 u32 cmd, struct pt_regs *args)
+{
+	const struct sm_ops *ops = get_sm_ops(dev);
+
+	if (ops->sm_call_read)
+		return ops->sm_call_read(dev, buffer, size, cmd,
+					 args);
+
+	return -EPROTONOSUPPORT;
+}
+
+int sm_call_write(struct udevice *dev, void *buffer, size_t size,
+		   u32 cmd, struct pt_regs *args)
+{
+	const struct sm_ops *ops = get_sm_ops(dev);
+
+	if (ops->sm_call_write)
+		return ops->sm_call_write(dev, buffer, size, cmd,
+					  args);
+
+	return -EPROTONOSUPPORT;
+}
+
+UCLASS_DRIVER(sm) = {
+	.name           = "sm",
+	.id             = UCLASS_SM,
+};
diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
index 376f741cc2..545c9352a8 100644
--- a/include/dm/uclass-id.h
+++ b/include/dm/uclass-id.h
@@ -80,6 +80,7 @@ enum uclass_id {
 	UCLASS_MDIO,		/* MDIO bus */
 	UCLASS_MDIO_MUX,	/* MDIO MUX/switch */
 	UCLASS_MEMORY,		/* Memory Controller device */
+	UCLASS_SM,		/* Secure Monitor driver */
 	UCLASS_MISC,		/* Miscellaneous device */
 	UCLASS_MMC,		/* SD / MMC card or chip */
 	UCLASS_MOD_EXP,		/* RSA Mod Exp device */
diff --git a/include/sm-uclass.h b/include/sm-uclass.h
new file mode 100644
index 0000000000..c114484044
--- /dev/null
+++ b/include/sm-uclass.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2023 SberDevices, Inc.
+ *
+ * Author: Alexey Romanov <avromanov@salutedevices.com>
+ */
+
+#ifndef __SM_UCLASS_H__
+#define __SM_UCLASS_H__
+
+#include <asm/types.h>
+#include <asm/ptrace.h>
+
+struct udevice;
+
+/**
+ * struct sm_ops - The functions that a SM driver must implement.
+ *
+ * @sm_call: Request a secure monitor call with specified command.
+ *
+ * @sm_call_read: Request a secure monitor call and retrieve data
+ * from secure-monitor (depends on specified command).
+ *
+ * @sm_call_write: Request a secure monitor call and send data
+ * to secure-monitor (depends on specified command).
+ *
+ * The individual methods are described more fully below.
+ */
+struct sm_ops {
+	/**
+	 * sm_call - generic SMC call to the secure-monitor
+	 *
+	 * @dev:	Pointer to UCLASS_SM device
+	 * @cmd_index:	Index of the SMC function ID
+	 * @smc_ret:	Returned value from secure world
+	 * @args:	SMC arguments
+	 *
+	 * @return:	0 on success, a negative value on error
+	 */
+	int (*sm_call)(struct udevice *dev, u32 cmd, s32 *smc_ret,
+		       struct pt_regs *args);
+
+	/**
+	 * sm_call_write - send data to secure-monitor
+	 *
+	 * @dev:	Pointer to UCLASS_SM device
+	 * @buffer:	Buffer containing data to send
+	 * @size:	Size of the buffer
+	 * @cmd:	Index of the SMC function ID
+	 * @args:	SMC arguments
+	 *
+	 * @return:	size of sent data on success, a negative value on error
+	 */
+	int (*sm_call_write)(struct udevice *dev, void *buffer,
+			     size_t size, u32 cmd, struct pt_regs *args);
+
+	/**
+	 * sm_call_read - retrieve data from secure-monitor
+	 *
+	 * @dev:	Pointer to UCLASS_SM device
+	 * @buffer:	Buffer to store the retrieved data
+	 * @size:	Size of the buffer
+	 * @cmd:	Index of the SMC function ID
+	 * @args:	SMC arguments
+	 *
+	 * @return:	size of read data on success, a negative value on error
+	 */
+	int (*sm_call_read)(struct udevice *dev, void *buffer,
+			    size_t size, u32 cmd, struct pt_regs *args);
+};
+
+#endif /* __SM_UCLASS_H__ */
diff --git a/include/sm.h b/include/sm.h
new file mode 100644
index 0000000000..afa9c89055
--- /dev/null
+++ b/include/sm.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2023 SberDevices, Inc.
+ *
+ * Author: Alexey Romanov <avromanov@salutedevices.ru>
+ */
+
+#ifndef __SM_H__
+#define __SM_H__
+
+/*
+ * NOTE: UCLASS_SM is designed with the idea that
+ * each driver should convert @cmd to some raw
+ * value, which is known only for driver, and set this
+ * value to the first element of the @args->regs array.
+ * Therefore, it is necessary to pass the remaining
+ * arguments starting at index = 1. Anyway, driver
+ * implementation may vary, so, please, check the specific
+ * implementation of the driver you are using.
+ */
+
+#include <asm/types.h>
+#include <asm/ptrace.h>
+
+struct udevice;
+
+/**
+ * sm_call - generic SMC call to the secure-monitor
+ *
+ * @dev:	Pointer to UCLASS_SM device
+ * @cmd_index:	Index of the SMC function ID
+ * @smc_ret:	Returned value from secure world
+ * @args:	SMC arguments
+ *
+ * @return:	0 on success, a negative value on error
+ */
+int sm_call(struct udevice *dev, u32 cmd, s32 *ret, struct pt_regs *args);
+
+/**
+ * sm_call_read - retrieve data from secure-monitor
+ *
+ * @dev:	Pointer to UCLASS_MESON_SM device
+ * @buffer:	Buffer to store the retrieved data
+ * @size:	Size of the buffer
+ * @cmd:	Index of the SMC function ID
+ * @args:	SMC arguments
+ *
+ * @return:	size of read data on success, a negative value on error
+ */
+int sm_call_read(struct udevice *dev, void *buffer, size_t size,
+		 u32 cmd, struct pt_regs *args);
+
+/**
+ * sm_call_write - send data to secure-monitor
+ *
+ * @dev:	Pointer to UCLASS_SM device
+ * @buffer:	Buffer containing data to send
+ * @size:	Size of the buffer
+ * @cmd:	Index of the SMC function ID
+ * @args:	SMC arguments
+ *
+ * @return:	size of sent data on success, a negative value on error
+ */
+int sm_call_write(struct udevice *dev, void *buffer, size_t size,
+		  u32 cmd, struct pt_regs *args);
+
+#endif /* __SM_H__ */
-- 
2.25.1

