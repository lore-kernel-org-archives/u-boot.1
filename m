Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25CDCC6B3A
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 14:22:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8983B408EB;
	Thu, 15 Oct 2026 14:22:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b-rxgN2BICSx; Thu, 15 Oct 2026 14:22:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 79A41408AF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792074157;
	b=mqVF557epp2JNkOFE7f7URpB7R7+9x1OnCtbD/mrlqBJEEzhfE3/kPqnmUTt015bFsox
	 9tKNTylRxinaqv1oqE380/OShpqhzikoNbzxpUDJC7zP/xVbsnaRoN3kBVMrlDA5YUWsb
	 OVArZgvy4fUlon0BS65jGTCtU9QEKIyEuuUxgGiAu3rvUBNjWGRkiePRdQ5K3TN1hSAzV
	 Qne6tulST1Am+HBOzMlzom0lgVhsmnKmF/w3/4wl2Dfy3hbVA8dqJ5pxd5RllyXWj05cB
	 aG7uUryJz6yWLG/+w2itNNH8HTFg9vsKjArPjXkh+L+KYOQswnSu88LK9YiV/mCPDZw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792074157;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Flowmailer-Platform:Feedback-ID:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=p7Ptd9bNCxxP7YzKiqSKGKjc3P+PFLsos/dHGo5NBpc=;
	b=PIwAsG4EqsGViliDfB/yYfw9k0JN33kX54Rexsn1QuP2bn696Xap0IaLxniM6m5BNtqv
	 iH3Hws8ccc+xRzNBqNwXM3wTM5ObwxxGYKKq45fDKkUZUM3Lx5yP9H8DkfqKca6XVInTx
	 qtV38haWTNYg8faughvqyhllTdsjrprYOu7uw+tGDfNGLe/LeYZlPfcKbOg+7P8mFQGQj
	 WDAoWGCAczvWnBEuoXV+sx4a5jjx3ZoGv+g7+TJC6UiefsKFa3BR43kvhS8mDnVQviIqA
	 5jgHjrGHesWGXpDeN17u+Yh0NWAXVXl2wobBNDWICCH4j+h1XGN6aR5ZhO31CC7sF+A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=siemens.com;
	dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b=K7+SgbqI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792074157;
	bh=p7Ptd9bNCxxP7YzKiqSKGKjc3P+PFLsos/dHGo5NBpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gj5+cVJDCuCf58dPw6XAAZeThTlyHVpp4YXOeJrkbi20D5ctApK1Q88CTMAuKXArm
	 4qFvLMFT+m9T7nVSIqf+S3rR5vW4DKc8dkRh9hsx8F5WEWz+T+SnDAiPKZyMZDx6CE
	 AZbvCJ6/SyUdJ4eSpkVg3MmGno35sOELPRJoACwmccIXuS8E5o6ea09Zlq6yuvxjJS
	 jcFvvVC2klpvKKmty79HJTj0MlKmBaePaHW4QBanRNJH7kSIGJgmwtjIukV49Jl6he
	 MWPNYk36As8DGzD3Ykl/gmOxzB60D6JddvggE/Eg7BCjmrN6FN/fUX10S2k6nch3dD
	 oMRH+QmAkVZFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 79A41408AF;
	Thu, 15 Oct 2026 14:22:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CB624E4D
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 14:22:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B1836408B7
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 14:22:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id afEj3gwM5A8b for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 14:22:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5B6D0408AF
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.227
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792074154;
 b=hz9eKdFplww/itGT22AuAWBoImtKQNUsJG2sGk1VQ7SLLiPRVN2yn8nXNN/ZXk58UZwp
 0kq7mzyB166PBIF2pKX8Z3dJWG4dfWm4VGwunsnGaa/bzKeE8+mdvlCnzla6NJp7zuquw
 ixy7DFUhYqdnqZlSxVGuAGDFfyuSLg3tShYqqig7r/pFcpr/c3+/CYUFfcmZpvszR45oq
 xQ4MBKWb4/889d6pkh1amdOrRZpGg9QAt/Zq78kQB36toacqHV4kw4faWztlC2EVO5i3l
 Hu8MWjGyIItAObBtcYYa1QTTLWZJR/Q5sYdWFR8iH/m1KHi/K33Gr1oCrDtZbFwOtPg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792074154;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=p7Ptd9bNCxxP7YzKiqSKGKjc3P+PFLsos/dHGo5NBpc=;
 b=q/bpnma/j+w52G/V0M+aV1j3751bQ9je3DXkw065YV6CxgJRGaaa5Eep7fHtA9k0Q/i3
 GhCWiNfOhHDCZ/b2tiH3rFXOVJ38FFkX5kyigoX0NRDDnn2OiopTaVnmZVa3+U+PZq0WQ
 kPgddebeVfdt+6MzTznO7Cn4dtRv8GcbBD5rZqSIQpM+FjvZwILLi4TG3YEyDqfDRQ54V
 IdZKBVnYTLIKDxR6vXcSTuR2ISf6DjZlhuIVTR8o95fWlXkReOfwKcLSCBgkLDUjzmnCC
 HLgSBixwT9IwnxkAcD7JsgVrhb50S4A2If+pTPqMZQ0DNIF6Jo/eWOAV1VLMjjCO7Dw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=K7+SgbqI; 
 arc=none smtp.remote-ip=185.136.64.227
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.227;
 helo=mta-64-227.siemens.flowmailer.net;
 envelope-from=fm-294854-2026101514222955990be069000207fe-g0s7r2@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=K7+SgbqI
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5B6D0408AF
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 14:22:32 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 2026101514222955990be069000207fe
 for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 16:22:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=p7Ptd9bNCxxP7YzKiqSKGKjc3P+PFLsos/dHGo5NBpc=;
 b=K7+SgbqIkRb++OEIh+xo6RTR0IxXWJqqToeLer6fEzDllkU3nYqbMmwCFx2DaghQqb9QSa
 X1meGGPHU2nGjPFsE6slDjZlHic/DkuCgfwZU8W6yR8KOUx0V4/bQJRUPLz6fkgNVOfMXiVJ
 aUUxrbFlYfy5C062zd0ZXoNZR6w5U8DWHfwn0111KgbnUCzxGqRJfAMOnVW+5UYF398uZzlB
 NeBdxKZTuC1IeaJLL1XebhehslrWsk1zAkNTG+1tTQLAbRk/0ueE4n0+8lGhXfXaW5pcnADn
 OwOVQutbh6hOD7AJ98EfaMw1NBrdIg2HIEeiOnPKMgnM8AGC7fX0plZA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Stefan Roese <stefan.roese@mailbox.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v3 1/3] watchdog: Add support for i6300esb
Date: Thu, 15 Oct 2026 16:22:19 +0200
Message-ID: <55d5bbcd1c96c861ef3ef86f39312b48e56ce5a1.1792074141.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1792074141.git.jan.kiszka@siemens.com>
References: <cover.1792074141.git.jan.kiszka@siemens.com>
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
---
 drivers/watchdog/Kconfig        |   9 ++
 drivers/watchdog/Makefile       |   1 +
 drivers/watchdog/i6300esb-wdt.c | 152 ++++++++++++++++++++++++++++++++
 3 files changed, 162 insertions(+)
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
index 00000000000..a8cd32fa400
--- /dev/null
+++ b/drivers/watchdog/i6300esb-wdt.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) Siemens AG, 2026
+ *
+ * Based on Linux i6300esb.c
+ * (c) Copyright 2004 Google Inc.
+ * (c) Copyright 2005 David Härdeman <david@2gen.com>
+ */
+
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
+	val = ms * 1000000ULL / 983040;
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
+	if (wdt->base == NULL)
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

