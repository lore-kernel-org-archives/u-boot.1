Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F066DD75BBB
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 05:26:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 480E28966B;
	Thu, 21 Nov 2024 06:26:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732166771;
	bh=zicEErWZH85f2xgBzmrJhskgPuw03cATikMPq0g6sgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fQe5yTe0sv54PWxMXbqbSumD/D1hbNPZ6hGs/GnEmgWyzJWBJQm8u4YSzFBbgA3VT
	 BbMBW453u2LavP9bXdWK0Y/lNnd5mWvp5XCM/R1zPiPOfmBDM55Uw0S65ktPUFZ/ET
	 shAxodfxz+oUBkKFCkc8ESFvEf9mTh/fk5+Was2Jl0DuFv+tF+bI7nqiqUFGrvSrLj
	 jiWbe16hFd4ZVQonamoAMNmB39KCYNAG/CgoB1vRNksUBeOJ9Vb6kmvAbBptQfBkRW
	 iHNvGw9HB+4Q9djvLJKIkB34weOtk4TTk4moYelvpSNE4dquwXvU/rG5lN9wV4lcf/
	 eCWln9o8dtRQA==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E95B288C4C;
 Thu, 21 Nov 2024 06:26:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732166770;
 bh=zicEErWZH85f2xgBzmrJhskgPuw03cATikMPq0g6sgs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=g93stPsEXAtwqJohYuqR7vE16yoaKBCwffIBPt+7yghLASq8c2eckFdJ5mUv1mSo1
 spDs46s7/ch0YWjtWvA/IqBU0he7ipVnI1l+mqBh8iPEBcN5tq+TVT/UIx8wI6HcaF
 V+bJQpqOQXRf7ySzrYoBRel7vaWxIs04qrZW3CDooQ29FiynixBNeR9P79G1Ome5kh
 Yd6ZUwiFpjqI6vORGEJAg5XjpXwkVLSrjcPwPgLBFW8D2GzQuBMjUwBjt3ivntlBG/
 ZwlIK7HZEdU9IhwI1NIQSzeoFYl8/HW6goGwNqTSD+x7M2Q2CAPWOYVHLxA0+2y1Lu
 2AOwH+V8MfJnA==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Andrej Valek <andrej.valek@siemens.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 CL Wang <cl634@andestech.com>, Chanho Park <chanho61.park@samsung.com>,
 Fabio Estevam <festevam@denx.de>, Francesco Dolcini <francesco@dolcini.it>,
 Igor Opaniuk <igor.opaniuk@foundries.io>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Randolph <randolph@andestech.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 01/20] wdt: imx8qxp: add option to control external PMIC
 wdt via IMX8 SCU
Date: Thu, 21 Nov 2024 06:25:42 +0100
Message-Id: <20241121052601.72880-2-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241121052601.72880-1-hs@denx.de>
References: <20241121052601.72880-1-hs@denx.de>
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

Driver for a PMIC watchdog timer controlled via Siemens SCU firmware
extensions. Only useful on some Siemens i.MX8-based platforms as
special SCFW is needed which provides the needed SCU API.

Signed-off-by: Andrej Valek <andrej.valek@siemens.com>
Signed-off-by: Heiko Schocher <hs@denx.de>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>


---

Changes in v3:
- add Reviewed-by tag from Alexander
- add comments from Igor
  fix spelling issues
  depends on ARCH_IMX8 instead of IMX8 Kconfig symbol
- comment from Francesco and Stefan
  rename Kconfig symbol from WDT_SCU_PMIC to WDT_SIEMENS_PMIC
  rename scu_pmic_wdt.c to siemens_pmic_wdt.c

Changes in v2:
- work on comments from Stefan:
  - rename driver file from scu_wdt.c to scu_pmic_wdt.c
  - rename Kconfig symbol from CONFIG_WDT_IMX_SCU to CONFIG_WDT_SCU_PMIC
  - reworked Kconfig help text
  - add comment that TIMER_FUNC_CTRL_PMIC_WDOG is a siemens specific
    SCU API extension in their SCFW.
  - reworked commit message

 drivers/misc/imx8/scu_api.c         | 21 ++++++++++
 drivers/watchdog/Kconfig            |  7 ++++
 drivers/watchdog/Makefile           |  1 +
 drivers/watchdog/siemens_pmic_wdt.c | 59 +++++++++++++++++++++++++++++
 include/firmware/imx/sci/rpc.h      |  3 ++
 include/firmware/imx/sci/sci.h      |  1 +
 6 files changed, 92 insertions(+)
 create mode 100644 drivers/watchdog/siemens_pmic_wdt.c

diff --git a/drivers/misc/imx8/scu_api.c b/drivers/misc/imx8/scu_api.c
index 591d71b096a..edb6923151a 100644
--- a/drivers/misc/imx8/scu_api.c
+++ b/drivers/misc/imx8/scu_api.c
@@ -951,6 +951,27 @@ int sc_timer_set_wdog_window(sc_ipc_t ipc, sc_timer_wdog_time_t window)
 	return ret;
 }
 
+int sc_timer_control_pmic_wdog(sc_ipc_t ipc, u8 cmd)
+{
+	struct udevice *dev = gd->arch.scu_dev;
+	struct sc_rpc_msg_s msg;
+	int size = sizeof(struct sc_rpc_msg_s);
+	int ret;
+
+	RPC_VER(&msg) = SC_RPC_VERSION;
+	RPC_SVC(&msg) = (u8)SC_RPC_SVC_TIMER;
+	RPC_FUNC(&msg) = (u8)TIMER_FUNC_CTRL_PMIC_WDOG;
+	RPC_U8(&msg, 0U) = (u8)cmd;
+	RPC_SIZE(&msg) = 2U;
+
+	ret = misc_call(dev, SC_FALSE, &msg, size, &msg, size);
+	if (ret)
+		printf("%s: res:%d\n",
+		       __func__, RPC_R8(&msg));
+
+	return ret;
+}
+
 int sc_seco_authenticate(sc_ipc_t ipc, sc_seco_auth_cmd_t cmd,
 			 sc_faddr_t addr)
 {
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 0e45f0a0922..b39b2546e5c 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -351,6 +351,13 @@ config WDT_SBSA
 	   In the single stage mode, when the timeout is reached, your system
 	   will be reset by WS1. The first signal (WS0) is ignored.
 
+config WDT_SIEMENS_PMIC
+	bool "Enable PMIC Watchdog Timer support for Siemens platforms"
+	depends on ARCH_IMX8 && WDT
+	help
+	  Select this to enable the PMIC watchdog driver controlled via
+	  IMX8 SCU API found on Siemens platforms.
+
 config WDT_SL28CPLD
 	bool "sl28cpld watchdog timer support"
 	depends on WDT && SL28CPLD
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 0b107c008f7..9b6b1a8e8ad 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_WDT_OCTEONTX) += octeontx_wdt.o
 obj-$(CONFIG_WDT_OMAP3) += omap_wdt.o
 obj-$(CONFIG_WDT_SBSA) += sbsa_gwdt.o
 obj-$(CONFIG_WDT_K3_RTI) += rti_wdt.o
+obj-$(CONFIG_WDT_SIEMENS_PMIC) += siemens_pmic_wdt.o
 obj-$(CONFIG_WDT_SL28CPLD) += sl28cpld-wdt.o
 obj-$(CONFIG_WDT_SP805) += sp805_wdt.o
 obj-$(CONFIG_WDT_STARFIVE) += starfive_wdt.o
diff --git a/drivers/watchdog/siemens_pmic_wdt.c b/drivers/watchdog/siemens_pmic_wdt.c
new file mode 100644
index 00000000000..e7ca00de654
--- /dev/null
+++ b/drivers/watchdog/siemens_pmic_wdt.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for a PMIC watchdog timer controlled via Siemens SCU firmware
+ * extensions. Only useful on some Siemens i.MX8-based platforms as
+ * special NXP SCFW is needed which provides the needed SCU API.
+ *
+ * Copyright (C) 2024 Siemens AG
+ */
+
+#include <dm.h>
+#include <wdt.h>
+#include <firmware/imx/sci/sci.h>
+
+/* watchdog commands */
+#define CMD_START_WDT 0x55
+#define CMD_STOP_WDT  0x45
+#define CMD_PING_WDT  0x35
+
+static int scu_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
+{
+	/* start external watchdog via Timer API */
+	return sc_timer_control_pmic_wdog(-1, CMD_START_WDT);
+}
+
+static int scu_wdt_stop(struct udevice *dev)
+{
+	/* stop external watchdog via Timer API */
+	return sc_timer_control_pmic_wdog(-1, CMD_STOP_WDT);
+}
+
+static int scu_wdt_reset(struct udevice *dev)
+{
+	return sc_timer_control_pmic_wdog(-1, CMD_PING_WDT);
+}
+
+static int scu_wdt_probe(struct udevice *dev)
+{
+	debug("%s(dev=%p)\n", __func__, dev);
+	return 0;
+}
+
+static const struct wdt_ops scu_wdt_ops = {
+	.reset		= scu_wdt_reset,
+	.start		= scu_wdt_start,
+	.stop		= scu_wdt_stop,
+};
+
+static const struct udevice_id scu_wdt_ids[] = {
+	{ .compatible = "siemens,scu-wdt" },
+	{ }
+};
+
+U_BOOT_DRIVER(scu_wdt) = {
+	.name		= "scu_wdt",
+	.id		= UCLASS_WDT,
+	.of_match	= scu_wdt_ids,
+	.probe		= scu_wdt_probe,
+	.ops		= &scu_wdt_ops,
+};
diff --git a/include/firmware/imx/sci/rpc.h b/include/firmware/imx/sci/rpc.h
index 28adec2a8e1..ba5bf9a16fe 100644
--- a/include/firmware/imx/sci/rpc.h
+++ b/include/firmware/imx/sci/rpc.h
@@ -231,4 +231,7 @@ struct sc_rpc_msg_s {
 #define TIMER_FUNC_SET_SYSCTR_PERIODIC_ALARM 17U /* Index for sc_timer_set_sysctr_periodic_alarm() RPC call */
 #define TIMER_FUNC_CANCEL_SYSCTR_ALARM 18U /* Index for sc_timer_cancel_sysctr_alarm() RPC call */
 
+/* Siemens specific API extension */
+#define TIMER_FUNC_CTRL_PMIC_WDOG 20U  /*!< Index for sc_timer_ctrl_pmic_wdog() RPC call */
+
 #endif /* SC_RPC_H */
diff --git a/include/firmware/imx/sci/sci.h b/include/firmware/imx/sci/sci.h
index 7d8499f070a..b971b62836d 100644
--- a/include/firmware/imx/sci/sci.h
+++ b/include/firmware/imx/sci/sci.h
@@ -123,6 +123,7 @@ int sc_rm_set_master_sid(sc_ipc_t ipc, sc_rsrc_t resource, sc_rm_sid_t sid);
 
 /* Timer API */
 int sc_timer_set_wdog_window(sc_ipc_t ipc, sc_timer_wdog_time_t window);
+int sc_timer_control_pmic_wdog(sc_ipc_t ipc, u8 cmd);
 
 /* SECO API */
 int sc_seco_authenticate(sc_ipc_t ipc, sc_seco_auth_cmd_t cmd,
-- 
2.20.1

