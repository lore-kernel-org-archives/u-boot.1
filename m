Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F3FEE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 16:43:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DE3186E8D;
	Mon, 11 Sep 2023 18:42:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="LNsNEda4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0024D86E3E; Mon, 11 Sep 2023 18:35:57 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D605286D00
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 18:35:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 5E159120011;
 Mon, 11 Sep 2023 19:35:51 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 5E159120011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1694450151;
 bh=FRezlXX/ajuyacb5SmiweCmxfubnpMgA74OsBOOWCNg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=LNsNEda4uFosxtPVe/x5rEWpLq3TLy0HoeTffkzIehD2StHMD5XtXvMu8Uxe4JsrY
 cFVpQL7f57RfEV7uOevhlen8adYfc7VgUJI4yCtfjSOFuRYwe4vgJ6d6QtjgcaooZl
 lmvl6cJZhXiwqvnBtfptHzsfCYHDhF6bSVJFixMr2mF1BQLg6V4WpLSx8pf4/KTXVK
 Pdc9f/7VVoXPos0SEonlyNLueuDqiCHFD98fF8i9CckIUFNJ2605IsZX7sBdFnaaGI
 D/LtbV5ZaWMm7ZJbK6JZYF7YFun/XWZk7sYbr7Ho1W4oiD4+vD9TaTLO928VSIiKKT
 rX0IZLHlebwxg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Mon, 11 Sep 2023 19:35:51 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 11 Sep 2023 19:35:50 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <narmstrong@baylibre.com>, <sjg@google.com>, 
 <takahiro.akashi@linaro.org>, <ilias.apalodimas@linaro.org>,
 <post@lespocky.de>, <marex@denx.de>, <msuchanek@suse.de>,
 <sughosh.ganu@linaro.org>, <jh80.chung@samsung.com>,
 <paul.barker@sancloud.com>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
 <kernel@sberdevices.ru>, Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v2 6/8] drivers: introduce Meson Secure Monitor driver
Date: Mon, 11 Sep 2023 19:35:34 +0300
Message-ID: <20230911163536.20735-7-avromanov@salutedevices.com>
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
 {Tracking_from_domain_doesnt_match_to},
 p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1; salutedevices.com:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
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

This patch adds an implementation of the Meson Secure Monitor
driver based on UCLASS_SM.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 MAINTAINERS           |   1 +
 drivers/sm/Kconfig    |   7 ++
 drivers/sm/Makefile   |   1 +
 drivers/sm/meson-sm.c | 198 ++++++++++++++++++++++++++++++++++++++++++
 include/meson/sm.h    |  19 ++++
 5 files changed, 226 insertions(+)
 create mode 100644 drivers/sm/meson-sm.c
 create mode 100644 include/meson/sm.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c64427782..bdc364fd4c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -158,6 +158,7 @@ F:	drivers/net/phy/meson-gxl.c
 F:	drivers/adc/meson-saradc.c
 F:	drivers/phy/meson*
 F:	drivers/mmc/meson_gx_mmc.c
+F:	drivers/sm/meson-sm.c
 F:	drivers/spi/meson_spifc.c
 F:	drivers/pinctrl/meson/
 F:	drivers/power/domain/meson-gx-pwrc-vpu.c
diff --git a/drivers/sm/Kconfig b/drivers/sm/Kconfig
index 6cc6d55578..b4cc3f768e 100644
--- a/drivers/sm/Kconfig
+++ b/drivers/sm/Kconfig
@@ -1,2 +1,9 @@
 config SM
 	bool "Enable Secure Monitor driver support"
+
+config MESON_SM
+	bool "Amlogic Secure Monitor driver"
+	depends on SM
+	default n
+	help
+	  Say y here to enable the Amlogic secure monitor driver.
diff --git a/drivers/sm/Makefile b/drivers/sm/Makefile
index af5f475c2b..da81ee898a 100644
--- a/drivers/sm/Makefile
+++ b/drivers/sm/Makefile
@@ -2,3 +2,4 @@
 
 obj-y += sm-uclass.o
 obj-$(CONFIG_SANDBOX) += sandbox-sm.o
+obj-$(CONFIG_MESON_SM) += meson-sm.o
diff --git a/drivers/sm/meson-sm.c b/drivers/sm/meson-sm.c
new file mode 100644
index 0000000000..25adaf4560
--- /dev/null
+++ b/drivers/sm/meson-sm.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2023 SberDevices, Inc.
+ *
+ * Author: Alexey Romanov <avromanov@salutedevices.com>
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <regmap.h>
+#include <sm.h>
+#include <sm-uclass.h>
+#include <stdlib.h>
+#include <syscon.h>
+#include <asm/ptrace.h>
+#include <asm/system.h>
+#include <meson/sm.h>
+#include <linux/bitfield.h>
+#include <linux/err.h>
+#include <linux/sizes.h>
+
+struct meson_sm_cmd {
+	u32 smc_id;
+};
+
+#define SET_CMD(index, id)	\
+	[index] = {		\
+		.smc_id = (id),	\
+	}
+
+struct meson_sm_data {
+	u32 cmd_get_shmem_in;
+	u32 cmd_get_shmem_out;
+	unsigned int shmem_size;
+	struct meson_sm_cmd cmd[];
+};
+
+struct meson_sm_priv {
+	void *sm_shmem_in;
+	void *sm_shmem_out;
+	const struct meson_sm_data *data;
+};
+
+static unsigned long __meson_sm_call(u32 cmd, const struct pt_regs *args)
+{
+	struct pt_regs r = *args;
+
+	r.regs[0] = cmd;
+	smc_call(&r);
+
+	return r.regs[0];
+};
+
+static u32 meson_sm_get_cmd(const struct meson_sm_data *data,
+			    u32 cmd_index)
+{
+	struct meson_sm_cmd cmd;
+
+	if (cmd_index >= MESON_SMC_CMD_COUNT)
+		return 0;
+
+	cmd = data->cmd[cmd_index];
+	return cmd.smc_id;
+}
+
+static int meson_sm_call(struct udevice *dev, u32 cmd_index, s32 *retval,
+			 struct pt_regs *args)
+{
+	struct meson_sm_priv *priv = dev_get_priv(dev);
+	u32 cmd, ret;
+
+	cmd = meson_sm_get_cmd(priv->data, cmd_index);
+	if (!cmd)
+		return -ENOENT;
+
+	ret = __meson_sm_call(cmd, args);
+	if (retval)
+		*retval = ret;
+
+	return 0;
+}
+
+static int meson_sm_call_read(struct udevice *dev, void *buffer, size_t size,
+			      u32 cmd_index, struct pt_regs *args)
+{
+	struct meson_sm_priv *priv = dev_get_priv(dev);
+	s32 nbytes;
+	int ret;
+
+	if (!buffer || size > priv->data->shmem_size)
+		return -EINVAL;
+
+	ret = meson_sm_call(dev, cmd_index, &nbytes, args);
+	if (ret)
+		return ret;
+
+	if (nbytes < 0 || nbytes > size)
+		return -ENOBUFS;
+
+	/* In some cases (for example GET_CHIP_ID command),
+	 * SMC doesn't return the number of bytes read, even
+	 * though the bytes were actually read into sm_shmem_out.
+	 * So this check is needed.
+	 */
+	ret = nbytes;
+	if (!nbytes)
+		nbytes = size;
+
+	memcpy(buffer, priv->sm_shmem_out, nbytes);
+
+	return ret;
+}
+
+static int meson_sm_call_write(struct udevice *dev, void *buffer, size_t size,
+			       u32 cmd_index, struct pt_regs *args)
+{
+	struct meson_sm_priv *priv = dev_get_priv(dev);
+	s32 nbytes;
+	int ret;
+
+	if (!buffer || size > priv->data->shmem_size)
+		return -EINVAL;
+
+	memcpy(priv->sm_shmem_in, buffer, size);
+
+	ret = meson_sm_call(dev, cmd_index, &nbytes, args);
+	if (ret)
+		return ret;
+
+	if (nbytes <= 0 || nbytes > size)
+		return -EIO;
+
+	return nbytes;
+}
+
+static int meson_sm_probe(struct udevice *dev)
+{
+	struct meson_sm_priv *priv = dev_get_priv(dev);
+	struct pt_regs regs = { 0 };
+
+	priv->data = (struct meson_sm_data *)dev_get_driver_data(dev);
+	if (!priv->data)
+		return -EINVAL;
+
+	priv->sm_shmem_in =
+		(void *)__meson_sm_call(priv->data->cmd_get_shmem_in, &regs);
+
+	if (!priv->sm_shmem_in)
+		return -ENOMEM;
+
+	priv->sm_shmem_out =
+		(void *)__meson_sm_call(priv->data->cmd_get_shmem_out, &regs);
+
+	if (!priv->sm_shmem_out)
+		return -ENOMEM;
+
+	pr_debug("meson sm driver probed\n"
+		 "shmem_in addr: 0x%p, shmem_out addr: 0x%p\n",
+		 priv->sm_shmem_in,
+		 priv->sm_shmem_out);
+
+	return 0;
+}
+
+static const struct meson_sm_data meson_sm_gxbb_data = {
+	.cmd_get_shmem_in  = 0x82000020,
+	.cmd_get_shmem_out = 0x82000021,
+	.shmem_size = SZ_4K,
+	.cmd = {
+		SET_CMD(MESON_SMC_CMD_EFUSE_READ,  0x82000030),
+		SET_CMD(MESON_SMC_CMD_EFUSE_WRITE, 0x82000031),
+		SET_CMD(MESON_SMC_CMD_CHIP_ID_GET, 0x82000044),
+		SET_CMD(MESON_SMC_CMD_PWRDM_SET,   0x82000093),
+	},
+};
+
+static const struct udevice_id meson_sm_ids[] = {
+	{
+		.compatible = "amlogic,meson-gxbb-sm",
+		.data = (ulong)&meson_sm_gxbb_data,
+	},
+	{ }
+};
+
+static const struct sm_ops sm_ops = {
+	.sm_call = meson_sm_call,
+	.sm_call_read = meson_sm_call_read,
+	.sm_call_write = meson_sm_call_write,
+};
+
+U_BOOT_DRIVER(meson_sm) = {
+	.name = "meson_sm",
+	.id = UCLASS_SM,
+	.of_match = meson_sm_ids,
+	.probe = meson_sm_probe,
+	.priv_auto = sizeof(struct meson_sm_priv),
+	.ops = &sm_ops,
+};
diff --git a/include/meson/sm.h b/include/meson/sm.h
new file mode 100644
index 0000000000..fbaab1f1ee
--- /dev/null
+++ b/include/meson/sm.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2023 SberDevices, Inc.
+ *
+ * Author: Alexey Romanov <avromanov@salutedevices.com>
+ */
+
+#ifndef __MESON_SM_CMD_H__
+#define __MESON_SM_CMD_H__
+
+enum meson_smc_cmd {
+	MESON_SMC_CMD_EFUSE_READ,  /* read efuse memory */
+	MESON_SMC_CMD_EFUSE_WRITE, /* write efuse memory */
+	MESON_SMC_CMD_CHIP_ID_GET, /* readh chip unique id */
+	MESON_SMC_CMD_PWRDM_SET,   /* do command at specified power domain */
+	MESON_SMC_CMD_COUNT,
+};
+
+#endif
-- 
2.25.1

