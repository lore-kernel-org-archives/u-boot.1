Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60110CCF2C9
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 10:52:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1CF45606CF;
	Sun, 18 Oct 2026 10:52:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mFI3544J-DDu; Sun, 18 Oct 2026 10:52:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C2A1E6067A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792320766;
	b=HZcHByAnju1J5KuZ8ro9USC+u+LOUmEiBnvXa1M9xQuGe3Fr55bRAQmmcIMSBRHOTwHi
	 4JKRuSJ7hzQu5WENBarZ8+213K9kI6GXc3eEjwpdme1LOdI1g7s0+UnExzKbw1/It4P0E
	 /LOu+cPTnLicNm/zX/UVpREufDHRMjKAPGg7XeOD9pW7+/B+qu8GU09UGHxD3c80JrxO8
	 P3Cgt1tsjOqkxc+UFDyAa9t2W07mxBv7gLr0h2NjU32A/FVq/lwbZUx/saQsmmBjQaA/y
	 HgFfH7ugjAhVs9qVhYKm5xLw5ijp86FDOLAPB4hvde3AnGc7M9box7S+vx6eWGoJpaA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792320766;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=twqBL5vKcXFJblOiPfO0b/Db4hwswBZ3N07s2TWpVxE=;
	b=Yd/pOip6ILkoAlN7gHmK75tyl4FQw8ygRjwj6peNrmvwra359kEkbcuSiMsQGxvqyj0L
	 ysUafM0+vx1PXX5pSQIlDFrgfOK013YIPzLHVZVXMO4UuOWW2VBx4KLAIuOnDRqyo8vSD
	 IM4vtloYut+Sat/vZsrip0u4P9T9LhXAdcV3bcwExRWuVgVbjiOO61hGOLfkFYLgH1iWR
	 t4yiLekMETdaLaEBPJzpDZXnFF+7vdToGVJOgYf0rwzLdV3wS1r04cHtopl4AyJ1ezWNJ
	 A8ZREOhKNspp0V8YoBwFhjpHOwpwTkARDhTR9rIO/UmHS3UGFcfoDOvoI19+9HZiL1w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792320766;
	bh=twqBL5vKcXFJblOiPfO0b/Db4hwswBZ3N07s2TWpVxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1PDstQaLdA+536e7kPZkgLCYBWerDhXSvREBbg6gSZWGVJSVDdcIeOzgt99dyckxd
	 YVuzzWvM422C8hegga2zIK1LzzARJhLWhqLNBKZ5gi9nR8R+Gflkhltu1SaByUs104
	 3sLgJbn5vAINvMJSdt4rn7qTdZfHZg1nxDF0u+Y8t0TLSHgHeTbIAm6H/Tv4H3JDbp
	 586Lj5b24sIpfq21FdsAh0HP9rR+KWjOIWTjirtIXTTg8z62S9SHvgcS/L4EJOcMKU
	 uNLFssef0XsUypwL0rTei+Ms/6E44orKYQyn8vohzvpDF2BIHtNhvRMmhPEhUcUpUb
	 7G8vIpwMjhxIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2A1E6067A;
	Sun, 18 Oct 2026 10:52:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A1004769
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 10:52:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 932388121F
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 10:52:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZjnjUaxyZQPc for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 10:52:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B793E811E7
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.228
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792320763;
 b=bFxkYHf2eK4ysydG6Ov6p47lGVwLXXIaVz2O0ul1Vu4nFKXPFyNhJFjbTGGVqBYdWcZ1
 2H3cQojrVT3cywECA2Gh/7FLWiS/vdm/S94qk1TEgbeQndfeoKuPMALVVMUw1kUYnvTiP
 ZdohtPtgRh2+se9Z3XlU4NVog1v0O9ivud8TGcXqB4s35ME1PKPGkJ2wSVHeFhyfjnIUA
 Udl4K0wPPkfmnKu7DHJQacJc0jYhDKO2sVGEvezHPJHu/9hpuiWt9a8f+JsSxkAmN1+NT
 OFFhg93U0gvZFa3DSCwAFceoNsQezCgjGUfJpbgBKIqae6sDnvjHodTLBTjUesdkFEg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792320763;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=twqBL5vKcXFJblOiPfO0b/Db4hwswBZ3N07s2TWpVxE=;
 b=aDEId/zAphaiq5UP4dAPTCxT0oXErKfUQGaei/F4mBdTuMM8jT6AX5Bc+J9D5+2OPg8I
 xNSCeCCbdmwqyOmBOQ03FqsJlWSfOOJ1cG1kclNCI/09M3l5novll+0osfb9w3cTWWE6Q
 s1oaIlm9TXt3l7/Oe9azk3hyNNrwA+kY3YSJDacCKuJSpu0g4TMTdRgVXbWF06Jzx4ua4
 54j4rQrEC4si4HwWuzD9nDPFfjjiRX3t5eAXYn8g2Hajt/oqIkhYcaYY2vSHf1bLKs0K3
 nGfgm5dkC4kIr/NN/kkplJV0qJAk1eYaJBjtu13bbAdxG/nQL1fFyjyAxictiu/LSHQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=A7h5TNHs; 
 arc=none smtp.remote-ip=185.136.64.228
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.228;
 helo=mta-64-228.siemens.flowmailer.net;
 envelope-from=fm-294854-202610181052390c7667a747000207c9-rzc9c1@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=A7h5TNHs
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B793E811E7
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 10:52:41 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 202610181052390c7667a747000207c9
 for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 12:52:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=twqBL5vKcXFJblOiPfO0b/Db4hwswBZ3N07s2TWpVxE=;
 b=A7h5TNHs/FHDqdyhiBhk0BTbox1DRoQ3EBQ5eKO4ZE3YayD6OecUTglbeksOvLTuporyG7
 Eo6Lq17JAuFtKQrpdl3e3M14o6Yvk7SXuAjnATzMHwTuWX5+Z/4q16xxePhC6+SzeGXGJHu9
 COxceRVC4Aqtw/0ynbchNvKvDaz8V8DTva29ADgDtE3pnOawd4AR6EMJ6UElhzQ7fnsifU+o
 mpYDtJPbt30RJrQnXaeKRswc8f10dOLOVELNrPdEbUsU5TFCAdEnCBzQwaiFs6Uz4gVmnnGL
 AxnK8Q553yoRfHvbMxjl6Z1eplEWfj5sfq0QSRMvGfW2Gieu7wQEdyjA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Stefan Roese <stefan.roese@mailbox.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Subject: [PATCH v4 1/3] watchdog: Add support for i6300esb
Date: Sun, 18 Oct 2026 12:52:34 +0200
Message-ID: <ac8707e106b9fc91326ce64d983e9b12cd0a61a3.1792320756.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1792320756.git.jan.kiszka@siemens.com>
References: <cover.1792320756.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
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

From: Jan Kiszka <jan.kiszka@siemens.com>

While the real hardware might be in the museum now, this allows to test
watchdog integrations against QEMU virtual machines (-device i6300esb).

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Tested-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com> # qemu-riscv64 S-mode
---
 drivers/watchdog/Kconfig        |   9 ++
 drivers/watchdog/Makefile       |   1 +
 drivers/watchdog/i6300esb-wdt.c | 153 ++++++++++++++++++++++++++++++++
 3 files changed, 163 insertions(+)
 create mode 100644 drivers/watchdog/i6300esb-wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 3c56c541505..225e23ce247 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -494,4 +494,13 @@ config WDT_FTWDT010
 	help
 	  Faraday Technology ftwdt010 watchdog is an architecture independent
 	  watchdog. It is usually used in SoC chip design.
+
+config WDT_I6300ESB
+	bool "Intel 6300ESB Watchdog"
+	depends on WDT && PCI
+	help
+	  Hardware driver for the watchdog timer built into the Intel
+	  6300ESB controller hub. Also emulated by QEMU, thus useful for
+	  testing watchdog functionality in virtual systems.
+
 endmenu
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 84faefdb4c2..cfe3f3dac5a 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -58,3 +58,4 @@ obj-$(CONFIG_WDT_TEGRA) += tegra_wdt.o
 obj-$(CONFIG_WDT_XILINX) += xilinx_wwdt.o
 obj-$(CONFIG_WDT_ADI) += adi_wdt.o
 obj-$(CONFIG_WDT_QCOM) += qcom-wdt.o
+obj-$(CONFIG_WDT_I6300ESB) += i6300esb-wdt.o
diff --git a/drivers/watchdog/i6300esb-wdt.c b/drivers/watchdog/i6300esb-wdt.c
new file mode 100644
index 00000000000..b12329569dc
--- /dev/null
+++ b/drivers/watchdog/i6300esb-wdt.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) Siemens AG, 2026
+ *
+ * Based on Linux i6300esb.c
+ * (c) Copyright 2004 Google Inc.
+ * (c) Copyright 2005 David Härdeman <david@2gen.com>
+ */
+
+#include <div64.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <pci.h>
+#include <wdt.h>
+#include <asm/io.h>
+
+/* PCI configuration registers */
+#define ESB_CONFIG_REG  0x60            /* Config register                   */
+#define ESB_LOCK_REG    0x68            /* WDT lock register                 */
+
+/* Memory mapped registers */
+#define ESB_TIMER1_REG(w) ((w)->base + 0x00)/* Timer1 value after each reset */
+#define ESB_TIMER2_REG(w) ((w)->base + 0x04)/* Timer2 value after each reset */
+#define ESB_RELOAD_REG(w) ((w)->base + 0x0c)/* Reload register               */
+
+/* Lock register bits */
+#define ESB_WDT_ENABLE  (0x01 << 1)   /* Enable WDT                        */
+#define ESB_WDT_LOCK    (0x01 << 0)   /* Lock (nowayout)                   */
+
+/* Reload register bits */
+#define ESB_WDT_RELOAD  (0x01 << 8)    /* prevent timeout                   */
+
+/* Magic constants */
+#define ESB_UNLOCK1     0x80            /* Step 1 to unlock reset registers  */
+#define ESB_UNLOCK2     0x86            /* Step 2 to unlock reset registers  */
+
+struct i6300_wdt {
+	void *base;
+};
+
+static void unlock_timer_regs(struct i6300_wdt *wdt)
+{
+	writew(ESB_UNLOCK1, ESB_RELOAD_REG(wdt));
+	writew(ESB_UNLOCK2, ESB_RELOAD_REG(wdt));
+}
+
+static int i6300esb_wdt_reset(struct udevice *dev)
+{
+	struct i6300_wdt *wdt = dev_get_priv(dev);
+
+	unlock_timer_regs(wdt);
+	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG(wdt));
+
+	return 0;
+}
+
+static int i6300esb_wdt_start(struct udevice *dev, u64 ms, ulong flags)
+{
+	struct i6300_wdt *wdt = dev_get_priv(dev);
+	u32 val;
+
+	/*
+	 * Scale to ns, then divide by 983040 ns, the period of the timer
+	 * (30 ns PCI bus tick * 2^15). This is timer 1 (IRQ). Timer 2
+	 * (reboot) is set to immediate expiry.
+	 */
+	val = lldiv(ms * 1000000ULL, 983040);
+
+	unlock_timer_regs(wdt);
+	writel(val, ESB_TIMER1_REG(wdt));
+
+	unlock_timer_regs(wdt);
+	writel(0, ESB_TIMER2_REG(wdt));
+
+	i6300esb_wdt_reset(dev);
+
+	dm_pci_write_config8(dev, ESB_LOCK_REG, ESB_WDT_ENABLE);
+
+	return 0;
+}
+
+static int i6300esb_wdt_stop(struct udevice *dev)
+{
+	u8 val;
+
+	/* First, reset timers as suggested by the docs */
+	i6300esb_wdt_reset(dev);
+	/* Then disable the WDT */
+	dm_pci_write_config8(dev, ESB_LOCK_REG, 0x0);
+	dm_pci_read_config8(dev, ESB_LOCK_REG, &val);
+
+	/* Returns 0 if the timer was disabled, -EBUSY otherwise */
+	return (val & ESB_WDT_ENABLE) ? -EBUSY : 0;
+}
+
+static int i6300esb_wdt_probe(struct udevice *dev)
+{
+	struct wdt_uc_plat *plat = dev_get_uclass_plat(dev);
+	struct i6300_wdt *wdt = dev_get_priv(dev);
+	u8 val;
+
+	plat->max_timeout_ms = 1030792;
+
+	wdt->base = dm_pci_map_bar(dev, PCI_BASE_ADDRESS_0, 0, 0,
+				   PCI_REGION_TYPE, PCI_REGION_MEM);
+	if (!wdt->base)
+		return -EINVAL;
+
+	/*
+	 * Config register:
+	 * Bit    5 : 0 = Enable WDT_OUTPUT
+	 * Bit    2 : 0 = set the timer frequency to the PCI clock
+	 * divided by 2^15 (approx 1KHz).
+	 * Bits 1:0 : 11 = WDT_INT_TYPE Disabled.
+	 * The watchdog has two timers, it can be setup so that the
+	 * expiry of timer1 results in an interrupt and the expiry of
+	 * timer2 results in a reboot. We set it to not generate
+	 * any interrupts as there is not much we can do with it
+	 * right now.
+	 */
+	dm_pci_write_config16(dev, ESB_CONFIG_REG, 0x0003);
+
+	/* Check that the WDT isn't already locked */
+	dm_pci_read_config8(dev, ESB_LOCK_REG, &val);
+	if (val & ESB_WDT_LOCK)
+		dev_warn(dev, "nowayout already set\n");
+
+	/* Set the timer to watchdog mode and disable it for now */
+	dm_pci_write_config8(dev, ESB_LOCK_REG, 0x00);
+
+	return 0;
+}
+
+static const struct wdt_ops i6300esb_wdt_ops = {
+	.start	= i6300esb_wdt_start,
+	.stop	= i6300esb_wdt_stop,
+	.reset	= i6300esb_wdt_reset,
+};
+
+U_BOOT_DRIVER(i6300esb_wdt) = {
+	.name	= "i6300esb_wdt",
+	.id	= UCLASS_WDT,
+	.probe	= i6300esb_wdt_probe,
+	.priv_auto = sizeof(struct i6300_wdt),
+	.ops	= &i6300esb_wdt_ops,
+};
+
+static struct pci_device_id i6300esb_wdt_supported[] = {
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ESB_9) },
+	{ },
+};
+
+U_BOOT_PCI_DEVICE(i6300esb_wdt, i6300esb_wdt_supported);
-- 
2.47.3

