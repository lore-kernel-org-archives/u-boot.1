Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30DCC4167B
	for <u-boot@archiver.kernel.org>; Sun,  5 Nov 2023 23:15:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8215086F9E;
	Mon,  6 Nov 2023 00:14:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="EXGmzoJM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16C8A86FA5; Mon,  6 Nov 2023 00:14:04 +0100 (CET)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE6D386F9F
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 00:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20231105231343epoutp01b18f008696ce86b22a41a8302fe4cf63~U3RCuT5av2807928079epoutp01Z
 for <u-boot@lists.denx.de>; Sun,  5 Nov 2023 23:13:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20231105231343epoutp01b18f008696ce86b22a41a8302fe4cf63~U3RCuT5av2807928079epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1699226023;
 bh=tmV0Pq2N7pDirIr90FpoLhFP12sPV3H5vvgb4sGP7fQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EXGmzoJMNPkKtB6q6jDjOsOprilAVirnwIM4mZLvygzFWhUDA1cjvTlpKKXMTa8eQ
 Xs+/y89s1WvolrgLCD5+tgU/m/tGSoQWx6MU6Dgfbt5ESOuBR9ND3zpICf3icAfFkp
 6vk9Yuuv36HHUV+57bXaqUsP322uBljw7FKq2DTw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20231105231342epcas2p41c9c376a916ae48bdfa86eb200cf19ad~U3RCTF5I90348703487epcas2p4A;
 Sun,  5 Nov 2023 23:13:42 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.99]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4SNqzV0tblz4x9Pt; Sun,  5 Nov
 2023 23:13:42 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
 epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 A7.17.09607.5A128456; Mon,  6 Nov 2023 08:13:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
 20231105231340epcas2p3622ab40737b5c1974435caa88e6a87b2~U3RAnMJjL2616426164epcas2p3p;
 Sun,  5 Nov 2023 23:13:40 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231105231340epsmtrp11708c08627a19b1d33841d34ca1193b5~U3RAmV2F03232932329epsmtrp1o;
 Sun,  5 Nov 2023 23:13:40 +0000 (GMT)
X-AuditID: b6c32a48-963ff70000002587-4c-654821a50f8c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 08.4A.18939.4A128456; Mon,  6 Nov 2023 08:13:40 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20231105231340epsmtip2ca442423708a6a817c3a1262655f89e2~U3RAXHkMk1111811118epsmtip2R;
 Sun,  5 Nov 2023 23:13:40 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, Stefan
 Roese <sr@denx.de>, Yanhong Wang <yanhong.wang@starfivetech.com>, Xingyu Wu
 <xingyu.wu@starfivetech.com>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH 2/4] watchdog: Add StarFive Watchdog driver
Date: Mon,  6 Nov 2023 08:13:16 +0900
Message-Id: <20231105231318.992857-3-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231105231318.992857-1-chanho61.park@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdljTTHepokeqwarbfBaX92tbvH1xltHi
 5LoPTBZv93ayWyyccZbJ4kfXI0aLx4deMzmwe+w5PYvZY96sEyweZ+/sYPTo27KK0eP2Wd4A
 1qhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygK5QU
 yhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BeYFesWJucWleel6eaklVoYGBkamQIUJ
 2Rl7v55kL/gXXPH4ak4D4zXXLkZODgkBE4mXq6czgdhCAjsYJaYtAYpzAdmfGCUe3elhhHPW
 tL5hhOlYOfU/G0RiJ6PE+5/fmCGcaUwSJz+cZwOpYhPQldjy/BVYh4jAKUaJdZeUQWxmAW2J
 zs9T2LsYOTiEBawltkxhAQmzCKhKPP3exQxi8wrYS+yduZoVpERCQF5i8QMJkDCngINE7+5t
 bBAlghInZz5hgZgoL9G8dTbYCRIC99gl+u6cYoI41EXi7covULawxKvjW9ghbCmJl/1t7BDz
 yyV2LEuC6G1hlGhu28MMUWMv8ePmFLAbmAU0Jdbv0ocoV5Y4cgtqLZ9Ex+G/UFN4JTrahCAa
 1SUObJ/OAmHLSnTP+Qz1iIdE69pISDhNZpSYe/c72wRGhVlInpmF5JlZCHsXMDKvYhRLLSjO
 TU8tNiowgUducn7uJkZwgtTy2ME4++0HvUOMTByMhxglOJiVRHgdvV1ShXhTEiurUovy44tK
 c1KLDzGaAkN6IrOUaHI+MEXnlcQbmlgamJiZGZobmRqYK4nz3mudmyIkkJ5YkpqdmlqQWgTT
 x8TBKdXAxNl2df3POP7zn9QbedqXfvQ1u1hzun9ahVSpUe49m+XGa/l/znqTJ/bac/sR9YJJ
 Ry+V634rFNyx9sGymmMLlQVaapyeKhRbL4jKjErYVnx4YsYTnr878yIeuEdKcf6bmzu1P6/r
 STOD5PRPXJt0w/Y/mRf+6HpYg8b5ggdrnT7mCR7a0L1Dtt9dk72PuTj+cJD8VN4//uEyqxj+
 6X7nnXIj9aSz2IsNAsuWKmy8m3rk++ZNAouqJNeVrwo8w19984Ya46GVlScSP/HtcH9ffkdH
 Rd/RovpW4E/umdFqL38r8HjdOn0unGn1LD6rp/ssFRquFd08sKMpiqmyc1WEnP6So/z+uqv3
 LHzA/W1fphJLcUaioRZzUXEiAECE7bcZBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsWy7bCSvO4SRY9Ug9+TdSwu79e2ePviLKPF
 yXUfmCze7u1kt1g44yyTxY+uR4wWjw+9ZnJg99hzehazx7xZJ1g8zt7ZwejRt2UVo8fts7wB
 rFFcNimpOZllqUX6dglcGXu/nmQv+Bdc8fhqTgPjNdcuRk4OCQETiZVT/7OB2EIC2xkl1l+X
 gYjLSjx7t4MdwhaWuN9yhLWLkQuoZhKTxMQdzSwgCTYBXYktz18xgiREBC4wSkzYMYsRJMEs
 oC3R+XkKUDcHh7CAtcSWKWD1LAKqEk+/dzGD2LwC9hJ7Z65mBSmREJCXWPxAAiTMKeAg0bt7
 G9Q99hI/vh6CKheUODnzCQvEdHmJ5q2zmScwCsxCkpqFJLWAkWkVo2hqQXFuem5ygaFecWJu
 cWleul5yfu4mRnAYawXtYFy2/q/eIUYmDsZDjBIczEoivI7eLqlCvCmJlVWpRfnxRaU5qcWH
 GKU5WJTEeZVzOlOEBNITS1KzU1MLUotgskwcnFINTDP/3+ew2zLL7ZJaMluzz3FhubedQgWr
 7tzMM93JKOuq5ttcf/LjkdbvSRKnZtetrJk3XdHvkMMcdnOJ+9P9F/n3Pp4a6r+S4e/XlW32
 ovm1ZkU3t8t+9C1ZK8T6eJLmqxYLJ86gypqPv07OPpvjNH/Dd5djRzSnp7Y5WGn2iofeF6v/
 rNmX+sEvP+cT4/mwuOWmHRsn3p3yQSLvzqd/z2z53hu8/X+H4dwqP2uTW0/LTdcqrNmv80k0
 9bXVq3OcN0VmvRbjLAqx31taPTXBeYECL7/yTZ27KzWcKq1eMB4+OtftyNmjrhpTg20ifHff
 jVZwUQo7/v264TsvCWcbzdNLD30Pvn/GyqPKT8D9gRJLcUaioRZzUXEiADy9VHPSAgAA
X-CMS-MailID: 20231105231340epcas2p3622ab40737b5c1974435caa88e6a87b2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231105231340epcas2p3622ab40737b5c1974435caa88e6a87b2
References: <20231105231318.992857-1-chanho61.park@samsung.com>
 <CGME20231105231340epcas2p3622ab40737b5c1974435caa88e6a87b2@epcas2p3.samsung.com>
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

Add to support StarFive watchdog driver. The driver is imported from
linux kernel's drivers/watchdog/starfive-wdt.c without jh7100 support
because there is no support of jh7100 SoC in u-boot yet.
Howver, this patch has been kept the variant coding style because JH7100
can be added later and have a consistency with the linux driver.

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 drivers/watchdog/Kconfig        |   7 +
 drivers/watchdog/Makefile       |   1 +
 drivers/watchdog/starfive_wdt.c | 329 ++++++++++++++++++++++++++++++++
 3 files changed, 337 insertions(+)
 create mode 100644 drivers/watchdog/starfive_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 07fc4940e918..569726119ca1 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -344,6 +344,13 @@ config WDT_STM32MP
 	  Enable the STM32 watchdog (IWDG) driver. Enable support to
 	  configure STM32's on-SoC watchdog.
 
+config WDT_STARFIVE
+	bool "StarFive watchdog timer support"
+	depends on WDT
+	imply WATCHDOG
+	help
+	  Enable support for the watchdog timer of StarFive JH7110 SoC.
+
 config WDT_SUNXI
 	bool "Allwinner sunxi watchdog timer support"
 	depends on WDT && ARCH_SUNXI
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index eef786f5e74e..5520d3d9ae8a 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_WDT_SBSA) += sbsa_gwdt.o
 obj-$(CONFIG_WDT_K3_RTI) += rti_wdt.o
 obj-$(CONFIG_WDT_SL28CPLD) += sl28cpld-wdt.o
 obj-$(CONFIG_WDT_SP805) += sp805_wdt.o
+obj-$(CONFIG_WDT_STARFIVE) += starfive_wdt.o
 obj-$(CONFIG_WDT_STM32MP) += stm32mp_wdt.o
 obj-$(CONFIG_WDT_SUNXI) += sunxi_wdt.o
 obj-$(CONFIG_WDT_TANGIER) += tangier_wdt.o
diff --git a/drivers/watchdog/starfive_wdt.c b/drivers/watchdog/starfive_wdt.c
new file mode 100644
index 000000000000..ee9ec4cdc3a4
--- /dev/null
+++ b/drivers/watchdog/starfive_wdt.c
@@ -0,0 +1,329 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Starfive Watchdog driver
+ *
+ * Copyright (C) 2022 StarFive Technology Co., Ltd.
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <reset.h>
+#include <wdt.h>
+#include <linux/iopoll.h>
+
+/* JH7110 Watchdog register define */
+#define STARFIVE_WDT_JH7110_LOAD	0x000
+#define STARFIVE_WDT_JH7110_VALUE	0x004
+#define STARFIVE_WDT_JH7110_CONTROL	0x008	/*
+						 * [0]: reset enable;
+						 * [1]: interrupt enable && watchdog enable
+						 * [31:2]: reserved.
+						 */
+#define STARFIVE_WDT_JH7110_INTCLR	0x00c	/* clear intterupt and reload the counter */
+#define STARFIVE_WDT_JH7110_IMS		0x014
+#define STARFIVE_WDT_JH7110_LOCK	0xc00	/* write 0x1ACCE551 to unlock */
+
+/* WDOGCONTROL */
+#define STARFIVE_WDT_ENABLE			0x1
+#define STARFIVE_WDT_EN_SHIFT			0
+#define STARFIVE_WDT_RESET_EN			0x1
+#define STARFIVE_WDT_JH7110_RST_EN_SHIFT	1
+
+/* WDOGLOCK */
+#define STARFIVE_WDT_JH7110_UNLOCK_KEY		0x1acce551
+
+/* WDOGINTCLR */
+#define STARFIVE_WDT_INTCLR			0x1
+#define STARFIVE_WDT_JH7100_INTCLR_AVA_SHIFT	1	/* Watchdog can clear interrupt when 0 */
+
+#define STARFIVE_WDT_MAXCNT			0xffffffff
+#define STARFIVE_WDT_DEFAULT_TIME		(15)
+#define STARFIVE_WDT_DELAY_US			0
+#define STARFIVE_WDT_TIMEOUT_US			10000
+
+/* module parameter */
+#define STARFIVE_WDT_EARLY_ENA			0
+
+struct starfive_wdt_variant {
+	unsigned int control;		/* Watchdog Control Resgister for reset enable */
+	unsigned int load;		/* Watchdog Load register */
+	unsigned int reload;		/* Watchdog Reload Control register */
+	unsigned int enable;		/* Watchdog Enable Register */
+	unsigned int value;		/* Watchdog Counter Value Register */
+	unsigned int int_clr;		/* Watchdog Interrupt Clear Register */
+	unsigned int unlock;		/* Watchdog Lock Register */
+	unsigned int int_status;	/* Watchdog Interrupt Status Register */
+
+	u32 unlock_key;
+	char enrst_shift;
+	char en_shift;
+	bool intclr_check;		/*  whether need to check it before clearing interrupt */
+	char intclr_ava_shift;
+	bool double_timeout;		/* The watchdog need twice timeout to reboot */
+};
+
+struct starfive_wdt_priv {
+	void __iomem *base;
+	struct clk *core_clk;
+	struct clk *apb_clk;
+	struct reset_ctl_bulk *rst;
+	const struct starfive_wdt_variant *variant;
+	unsigned long freq;
+	u32 count;			/* count of timeout */
+	u32 reload;			/* restore the count */
+};
+
+/* Register layout and configuration for the JH7110 */
+static const struct starfive_wdt_variant starfive_wdt_jh7110_variant = {
+	.control = STARFIVE_WDT_JH7110_CONTROL,
+	.load = STARFIVE_WDT_JH7110_LOAD,
+	.enable = STARFIVE_WDT_JH7110_CONTROL,
+	.value = STARFIVE_WDT_JH7110_VALUE,
+	.int_clr = STARFIVE_WDT_JH7110_INTCLR,
+	.unlock = STARFIVE_WDT_JH7110_LOCK,
+	.unlock_key = STARFIVE_WDT_JH7110_UNLOCK_KEY,
+	.int_status = STARFIVE_WDT_JH7110_IMS,
+	.enrst_shift = STARFIVE_WDT_JH7110_RST_EN_SHIFT,
+	.en_shift = STARFIVE_WDT_EN_SHIFT,
+	.intclr_check = false,
+	.double_timeout = true,
+};
+
+static int starfive_wdt_enable_clock(struct starfive_wdt_priv *wdt)
+{
+	int ret;
+
+	ret = clk_enable(wdt->apb_clk);
+	if (ret)
+		return ret;
+
+	ret = clk_enable(wdt->core_clk);
+	if (ret) {
+		clk_disable(wdt->apb_clk);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void starfive_wdt_disable_clock(struct starfive_wdt_priv *wdt)
+{
+	clk_disable(wdt->core_clk);
+	clk_disable(wdt->apb_clk);
+}
+
+/* Write unlock-key to unlock. Write other value to lock. */
+static void starfive_wdt_unlock(struct starfive_wdt_priv *wdt)
+{
+	writel(wdt->variant->unlock_key, wdt->base + wdt->variant->unlock);
+}
+
+static void starfive_wdt_lock(struct starfive_wdt_priv *wdt)
+{
+	writel(~wdt->variant->unlock_key, wdt->base + wdt->variant->unlock);
+}
+
+/* enable watchdog interrupt to reset/reboot */
+static void starfive_wdt_enable_reset(struct starfive_wdt_priv *wdt)
+{
+	u32 val;
+
+	val = readl(wdt->base + wdt->variant->control);
+	val |= STARFIVE_WDT_RESET_EN << wdt->variant->enrst_shift;
+	writel(val, wdt->base + wdt->variant->control);
+}
+
+/* waiting interrupt can be free to clear */
+static int starfive_wdt_wait_int_free(struct starfive_wdt_priv *wdt)
+{
+	u32 value;
+
+	return readl_poll_timeout(wdt->base + wdt->variant->int_clr, value,
+				  !(value & BIT(wdt->variant->intclr_ava_shift)),
+				  STARFIVE_WDT_TIMEOUT_US);
+}
+
+/* clear interrupt signal before initialization or reload */
+static int starfive_wdt_int_clr(struct starfive_wdt_priv *wdt)
+{
+	int ret;
+
+	if (wdt->variant->intclr_check) {
+		ret = starfive_wdt_wait_int_free(wdt);
+		if (ret)
+			return ret;
+	}
+	writel(STARFIVE_WDT_INTCLR, wdt->base + wdt->variant->int_clr);
+
+	return 0;
+}
+
+static inline void starfive_wdt_set_count(struct starfive_wdt_priv *wdt,
+					  u32 val)
+{
+	writel(val, wdt->base + wdt->variant->load);
+}
+
+/* enable watchdog */
+static inline void starfive_wdt_enable(struct starfive_wdt_priv *wdt)
+{
+	u32 val;
+
+	val = readl(wdt->base + wdt->variant->enable);
+	val |= STARFIVE_WDT_ENABLE << wdt->variant->en_shift;
+	writel(val, wdt->base + wdt->variant->enable);
+}
+
+/* disable watchdog */
+static inline void starfive_wdt_disable(struct starfive_wdt_priv *wdt)
+{
+	u32 val;
+
+	val = readl(wdt->base + wdt->variant->enable);
+	val &= ~(STARFIVE_WDT_ENABLE << wdt->variant->en_shift);
+	writel(val, wdt->base + wdt->variant->enable);
+}
+
+static inline void starfive_wdt_set_reload_count(struct starfive_wdt_priv *wdt,
+						 u32 count)
+{
+	starfive_wdt_set_count(wdt, count);
+
+	/* 7100 need set any value to reload register and could reload value to counter */
+	if (wdt->variant->reload)
+		writel(0x1, wdt->base + wdt->variant->reload);
+}
+
+static int starfive_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
+{
+	int ret;
+	struct starfive_wdt_priv *wdt = dev_get_priv(dev);
+
+	starfive_wdt_unlock(wdt);
+	/* disable watchdog, to be safe */
+	starfive_wdt_disable(wdt);
+
+	starfive_wdt_enable_reset(wdt);
+	ret = starfive_wdt_int_clr(wdt);
+	if (ret)
+		goto exit;
+
+	wdt->count = (timeout_ms / 1000) * wdt->freq;
+	if (wdt->variant->double_timeout)
+		wdt->count /= 2;
+
+	starfive_wdt_set_count(wdt, wdt->count);
+	starfive_wdt_enable(wdt);
+
+exit:
+	starfive_wdt_lock(wdt);
+	return ret;
+}
+
+static int starfive_wdt_stop(struct udevice *dev)
+{
+	struct starfive_wdt_priv *wdt = dev_get_priv(dev);
+
+	starfive_wdt_unlock(wdt);
+	starfive_wdt_disable(wdt);
+	starfive_wdt_lock(wdt);
+
+	return 0;
+}
+
+static int starfive_wdt_reset(struct udevice *dev)
+{
+	int ret;
+	struct starfive_wdt_priv *wdt = dev_get_priv(dev);
+
+	starfive_wdt_unlock(wdt);
+	ret = starfive_wdt_int_clr(wdt);
+	if (ret)
+		goto exit;
+
+	starfive_wdt_set_reload_count(wdt, wdt->count);
+
+exit:
+	starfive_wdt_lock(wdt);
+
+	return ret;
+}
+
+static const struct wdt_ops starfive_wdt_ops = {
+	.start = starfive_wdt_start,
+	.stop = starfive_wdt_stop,
+	.reset = starfive_wdt_reset,
+};
+
+static int starfive_wdt_probe(struct udevice *dev)
+{
+	struct starfive_wdt_priv *wdt = dev_get_priv(dev);
+	int ret;
+
+	ret = starfive_wdt_enable_clock(wdt);
+	if (ret)
+		return ret;
+
+	ret = reset_deassert_bulk(wdt->rst);
+	if (ret)
+		goto err_reset;
+
+	wdt->variant = (const struct starfive_wdt_variant *)dev_get_driver_data(dev);
+
+	wdt->freq = clk_get_rate(wdt->core_clk);
+	if (!wdt->freq) {
+		ret = -EINVAL;
+		goto err_get_freq;
+	}
+
+	return 0;
+
+err_get_freq:
+	reset_assert_bulk(wdt->rst);
+err_reset:
+	starfive_wdt_disable_clock(wdt);
+
+	return ret;
+}
+
+static int starfive_wdt_of_to_plat(struct udevice *dev)
+{
+	struct starfive_wdt_priv *wdt = dev_get_priv(dev);
+
+	wdt->base = (void *)dev_read_addr(dev);
+	if (!wdt->base)
+		return -ENODEV;
+
+	wdt->apb_clk = devm_clk_get(dev, "apb");
+	if (IS_ERR(wdt->apb_clk))
+		return -ENODEV;
+
+	wdt->core_clk = devm_clk_get(dev, "core");
+	if (IS_ERR(wdt->core_clk))
+		return -ENODEV;
+
+	wdt->rst = devm_reset_bulk_get(dev);
+	if (IS_ERR(wdt->rst))
+		return -ENODEV;
+
+	return 0;
+}
+
+static const struct udevice_id starfive_wdt_ids[] = {
+	{
+		.compatible = "starfive,jh7110-wdt",
+		.data = (ulong)&starfive_wdt_jh7110_variant
+	}, {
+		/* sentinel */
+	}
+};
+
+U_BOOT_DRIVER(starfive_wdt) = {
+	.name = "starfive_wdt",
+	.id = UCLASS_WDT,
+	.of_match = starfive_wdt_ids,
+	.priv_auto = sizeof(struct starfive_wdt_priv),
+	.probe = starfive_wdt_probe,
+	.of_to_plat = starfive_wdt_of_to_plat,
+	.ops = &starfive_wdt_ops,
+};
-- 
2.39.2

