Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4826E70717
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 11:26:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C93F86BFC;
	Thu, 21 Sep 2023 13:25:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="WHaKNL2s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECC0A8615A; Thu, 21 Sep 2023 10:14:10 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C194580282
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 10:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 565A910000B;
 Thu, 21 Sep 2023 11:14:07 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 565A910000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1695284047;
 bh=dlXj43g5n5wLSuDFsul5sPiBafXmfl3jqz49wuuBosg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=WHaKNL2sXIlp8g4AmElq983TMrQ7nN3IMU/ZlY6uxrZldCGH8Hivb2511SeibIZQr
 P+Z6TSz7vSWq6eqk49Ah1zrNHNTVhC+mKZRle3fULSYD70e7jarQPM0I7pA6mrZpwe
 u0EQX2r6cfA7scmtkjQJXwXPnK8z6j3GLeueXu5/WQfVCq2iD71qFzB3pJk7OlOYtM
 rcJpyZMShG44U+TfjZ9qSpJgBmPqQ4V2N792thoUHJcg7ZkOJrZk3BwwunMc1DS7dP
 1Bk8gBtN3asZtgzyEPr7CzKn/7UFH4GKMi1w9K4scsUU2rMG1raH2CnOC6s0XQBi5i
 6U145n/PsEFbQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 21 Sep 2023 11:14:07 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 21 Sep 2023 11:14:06 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <narmstrong@baylibre.com>, <sjg@google.com>, 
 <takahiro.akashi@linaro.org>, <ilias.apalodimas@linaro.org>,
 <post@lespocky.de>, <marex@denx.de>, <msuchanek@suse.de>,
 <sughosh.ganu@linaro.org>, <jh80.chung@samsung.com>,
 <paul.barker@sancloud.com>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
 <kernel@sberdevices.ru>, Alexey Romanov <avromanov@salutedevices.com>, Simon
 Glass <sjg@chromium.org>
Subject: [PATCH v3 4/8] sandbox: add tests for UCLASS_SM
Date: Thu, 21 Sep 2023 11:13:37 +0300
Message-ID: <20230921081346.22157-5-avromanov@salutedevices.com>
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

This patchs adds simple tests for Secure Monitor uclass.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 test/dm/Makefile |  1 +
 test/dm/sm.c     | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)
 create mode 100644 test/dm/sm.c

diff --git a/test/dm/Makefile b/test/dm/Makefile
index 7a79b6e1a2..30550a62ad 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -107,6 +107,7 @@ obj-$(CONFIG_DM_SPI) += spi.o
 obj-$(CONFIG_SPMI) += spmi.o
 obj-y += syscon.o
 obj-$(CONFIG_RESET_SYSCON) += syscon-reset.o
+obj-$(CONFIG_SM) += sm.o
 obj-$(CONFIG_SYSINFO) += sysinfo.o
 obj-$(CONFIG_SYSINFO_GPIO) += sysinfo-gpio.o
 obj-$(CONFIG_UT_DM) += tag.o
diff --git a/test/dm/sm.c b/test/dm/sm.c
new file mode 100644
index 0000000000..7ebb0c9c85
--- /dev/null
+++ b/test/dm/sm.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2023 SberDevices, Inc.
+ *
+ * Author: Alexey Romanov <avromanov@salutedevices.com>
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <sm.h>
+#include <sandbox-sm.h>
+#include <asm/ptrace.h>
+#include <dm/device-internal.h>
+#include <dm/test.h>
+#include <test/ut.h>
+#include <linux/sizes.h>
+
+static int dm_test_sm(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+	struct pt_regs regs;
+	char buffer[128] = { 0 };
+	char test_string[] = "secure-monitor";
+	int ret, val;
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_SM,
+		"secure-monitor", &dev));
+
+	ret = sm_call(dev, SANDBOX_SMC_CMD_COUNT, NULL, &regs);
+	ut_asserteq(ret, -EINVAL);
+
+	ret = sm_call(dev, SANDBOX_SMC_CMD_COMMON, &val, &regs);
+	ut_asserteq(ret, 0);
+	ut_asserteq(val, 0);
+
+	ret = sm_call_write(dev, buffer, sizeof(buffer),
+		SANDBOX_SMC_CMD_COUNT, &regs);
+	ut_asserteq(ret, -EINVAL);
+
+	ret = sm_call_write(dev, buffer, SZ_4K + 1,
+		SANDBOX_SMC_CMD_WRITE_MEM, &regs);
+	ut_asserteq(ret, -EINVAL);
+
+	ret = sm_call_write(dev, buffer, sizeof(buffer),
+		SANDBOX_SMC_CMD_COUNT, &regs);
+	ut_asserteq(ret, -EINVAL);
+
+	ret = sm_call_write(dev, buffer, SZ_4K + 1,
+		SANDBOX_SMC_CMD_READ_MEM, &regs);
+	ut_asserteq(ret, -EINVAL);
+
+	ret = sm_call_write(dev, test_string, sizeof(test_string),
+		SANDBOX_SMC_CMD_WRITE_MEM, &regs);
+	ut_asserteq(ret, sizeof(test_string));
+
+	ret = sm_call_read(dev, buffer, sizeof(buffer),
+		SANDBOX_SMC_CMD_READ_MEM, &regs);
+	ut_asserteq(ret, sizeof(buffer));
+
+	ut_asserteq_str(buffer, test_string);
+
+	return 0;
+}
+
+DM_TEST(dm_test_sm, UT_TESTF_SCAN_FDT);
-- 
2.25.1

