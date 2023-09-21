Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4935CE70717
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 11:26:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 864CC86BED;
	Thu, 21 Sep 2023 13:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="ZIKhIfLQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D19D86AE6; Thu, 21 Sep 2023 10:14:10 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDB4886AA8
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 10:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 23620100009;
 Thu, 21 Sep 2023 11:14:05 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 23620100009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1695284045;
 bh=DkbqgCqXAUMpBpPdnCdc5PhhZnXehQGLEKz/eSP4Agc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=ZIKhIfLQA6fkzuTTyP/XFy0tQ9A4Fnz0BIWEpcpunNDCp/+F8Do0YO/5piuLtNLfj
 i48mq97Icb1Um+E1l827AWHMvj8yqD/Rt72a9UeBSL0trQDAfMv53lsB20+gY2Eumu
 HHUJoIDA1IaNi9w7he4xNqxUvI6A/jkDl+JSsuO/wvVo0yvTg4ALRV0PiwxmS0ty+W
 pKSFxE5VaXuN+7xEolelUnKQQVCyLVs70GtFMqtLMBypcbPKAFB+YihqbmbUhA3S5x
 poUD6TClB2ocS5kSkIeKZrgm8HR1l994oESbJ/381/zyVth4DdC9IYGkdiAe766klh
 z3TQkGv1A7fEw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 21 Sep 2023 11:14:04 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 21 Sep 2023 11:14:04 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <narmstrong@baylibre.com>, <sjg@google.com>, 
 <takahiro.akashi@linaro.org>, <ilias.apalodimas@linaro.org>,
 <post@lespocky.de>, <marex@denx.de>, <msuchanek@suse.de>,
 <sughosh.ganu@linaro.org>, <jh80.chung@samsung.com>,
 <paul.barker@sancloud.com>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
 <kernel@sberdevices.ru>, Alexey Romanov <avromanov@salutedevices.com>, Simon
 Glass <sjg@chromium.org>
Subject: [PATCH v3 2/8] sandbox: add sandbox sm uclass driver
Date: Thu, 21 Sep 2023 11:13:35 +0300
Message-ID: <20230921081346.22157-3-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921081346.22157-1-avromanov@salutedevices.com>
References: <20230921081346.22157-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180016 [Sep 21 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 534 534
 808c2ea49f7195c68d40844e073217da4fa0d1e3,
 {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 100.64.160.123:7.1.2;
 salutedevices.com:7.1.1;
 p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s,
 ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/09/21 07:22:00 #21937862
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 21 Sep 2023 13:25:12 +0200
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

This patch adds sandbox secure monitor driver.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 drivers/sm/Makefile     |  1 +
 drivers/sm/sandbox-sm.c | 76 +++++++++++++++++++++++++++++++++++++++++
 include/sandbox-sm.h    | 18 ++++++++++
 3 files changed, 95 insertions(+)
 create mode 100644 drivers/sm/sandbox-sm.c
 create mode 100644 include/sandbox-sm.h

diff --git a/drivers/sm/Makefile b/drivers/sm/Makefile
index 9f4683ba06..af5f475c2b 100644
--- a/drivers/sm/Makefile
+++ b/drivers/sm/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 obj-y += sm-uclass.o
+obj-$(CONFIG_SANDBOX) += sandbox-sm.o
diff --git a/drivers/sm/sandbox-sm.c b/drivers/sm/sandbox-sm.c
new file mode 100644
index 0000000000..109ddb2af5
--- /dev/null
+++ b/drivers/sm/sandbox-sm.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2023 SberDevices, Inc.
+ *
+ * Author: Alexey Romanov <avromanov@salutedevices.com>
+ */
+
+#include <common.h>
+#include <sm.h>
+#include <sm-uclass.h>
+#include <sandbox-sm.h>
+#include <asm/ptrace.h>
+#include <dm/device.h>
+#include <linux/sizes.h>
+
+static u8 test_buffer[SZ_4K];
+
+static int sandbox_sm_call(struct udevice *dev, u32 cmd_index, s32 *smc_ret,
+			   struct pt_regs *args)
+{
+	if (cmd_index >= SANDBOX_SMC_CMD_COUNT)
+		return -EINVAL;
+
+	if (smc_ret)
+		*smc_ret = 0;
+
+	return 0;
+}
+
+static int sandbox_sm_call_read(struct udevice *dev, void *buffer, size_t size,
+				u32 cmd_index, struct pt_regs *args)
+{
+	if (cmd_index >= SANDBOX_SMC_CMD_COUNT || !buffer)
+		return -EINVAL;
+
+	if (size > sizeof(test_buffer))
+		return -EINVAL;
+
+	memcpy(buffer, test_buffer, size);
+
+	return size;
+}
+
+static int sandbox_sm_call_write(struct udevice *dev, void *buffer, size_t size,
+				 u32 cmd_index, struct pt_regs *args)
+{
+	if (cmd_index >= SANDBOX_SMC_CMD_COUNT || !buffer)
+		return -EINVAL;
+
+	if (size > sizeof(test_buffer))
+		return -EINVAL;
+
+	memcpy(test_buffer, buffer, size);
+
+	return size;
+}
+
+static const struct udevice_id sandbox_sm_ids[] = {
+	{
+		.compatible = "sandbox,sm",
+	},
+	{},
+};
+
+static const struct sm_ops sandbox_sm_ops = {
+	.sm_call = sandbox_sm_call,
+	.sm_call_read = sandbox_sm_call_read,
+	.sm_call_write = sandbox_sm_call_write,
+};
+
+U_BOOT_DRIVER(sm) = {
+	.name = "sm",
+	.id = UCLASS_SM,
+	.of_match = sandbox_sm_ids,
+	.ops = &sandbox_sm_ops,
+};
diff --git a/include/sandbox-sm.h b/include/sandbox-sm.h
new file mode 100644
index 0000000000..91c30d501d
--- /dev/null
+++ b/include/sandbox-sm.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2023 SberDevices, Inc.
+ *
+ * Author: Alexey Romanov <avromanov@salutedevices.com>
+ */
+
+#ifndef __SANDBOX_SM_H__
+#define __SANDBOX_SM_H__
+
+enum sandbox_smc_cmd {
+	SANDBOX_SMC_CMD_READ_MEM,
+	SANDBOX_SMC_CMD_WRITE_MEM,
+	SANDBOX_SMC_CMD_COMMON,
+	SANDBOX_SMC_CMD_COUNT,
+};
+
+#endif
-- 
2.25.1

