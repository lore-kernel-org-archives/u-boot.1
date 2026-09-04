Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F45C624D3
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 13:02:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51C0F40BBF;
	Fri,  4 Sep 2026 13:02:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wXD2zZBpbOZv; Fri,  4 Sep 2026 13:02:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1181640BD2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788526946;
	b=fChL+ejB++TykHv72Omjs3LahUoDODn8SrBMgUYZ5TOrOkPEYmC+sxHmDFRm4rKJ5ekO
	 7IIWw6PbYcpNFYmCYb+zXMzTiCKC7jDqWQIhCJYoZw06v4m30n4ppSWL1OO9UkE/yBTbt
	 vy6dfyPC8Jwp6KwLwwQdW+e4y+ArNF2AIaAZgcxr2Porq6ZggdaN+Kqk5Fyq0SR2r7cSv
	 no6pIaIYJZKMRtaQTZt9dGMAoWEF/01jER5axMiYdW7C1W9YzNt8yQ4lFM+ZQPv5IQXcy
	 +diV4T/qha0HMQ6jy02SZ/56jXBCCqDi3MTTfU/+AnMfaeScoH+V/rgYherqAsHrgBw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788526946;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=sLkn5p0JRcsyZ+qYNn+2IaO2Y4tzMwtHeobH/5FDL+Y=;
	b=bHLIdgET87ysykSUOuZ+h9wkZYUF73j9XhJtD9ahOpLw6SVvtBDpt3PzSELOH1lZsU4C
	 V+mlz6Vy/ppTSyR0f5whJwLw+n6rCkhqfmzFj4b7zvCTTm39JEGVS+x0/NtgQKt4R+8E4
	 71HVgKC883S0CqbK/lUzUvkrBXjdF3ppiGnAmLAnycA/A91j5cmeF9T/sK9p4TzpCdyGL
	 NTyqPRkaKq+inDspdCddBKdYgJiMn6qYnqfQEeSPv9wzVmtxPz9lusxSDFO4NFJSIqvk4
	 MuFC4lX8mAQQtGQZdt/UF8J0Pqj58TmBKVAlLCmLofJngSUo+EzGUVByx7xSzPwNyAQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=siemens.com;
	dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com header.a=rsa-sha256 header.s=fm2 header.b="gbtF2/sK";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788526946;
	bh=sLkn5p0JRcsyZ+qYNn+2IaO2Y4tzMwtHeobH/5FDL+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GtBeTADD7ooiyemYRP0qK/z3xPic5/Gr4OgS4XUvq+r2f24C/u2oi5AQv8udHRr2a
	 +5A6b2VlF/5SHxpebc1EapPC65fzgHRsxsXYL7j0NRtvesmzEbEsiw3BgZQb4oJ1+r
	 mwlnlmciHBHXFK2OYeC9VanJ2Ufx9dhwFuov8y6+eUZ+r9j3VrtV6YvrIwS/LPlLFQ
	 KfqVjtWJzK/lVb9QlakzaCR4b/hl2/dChlEXPS+W20+PGLS7URUoCgTUtm1xLV5P8x
	 q4mohAmGVYmbNnG3r1flFoFQe6wGcFQzrFp5eF5HdIETCWswyekY7RpPVGNEn0sJTs
	 2JTJhCAZN02OA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1181640BD2;
	Fri,  4 Sep 2026 13:02:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7EEB5F14
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:02:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 644EA40BAA
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:02:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 35zcyFQh7bCI for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 13:02:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8E25C40BB8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.136.64.226
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788526940;
 b=sB4uJQ4dgnIBaSUyXiqv4scce61D0ejT+Jr6Vu2zoUEQ9R8jhqKruIOhEh1hYOOaCi+U
 MqkqSDpQty+BzEp1OuAqg/SO02bBMdfulg+mQzuZuS06kJNr8YEBa1yLNpNy5DbGxXOKw
 nHy2GcqD7KLW83TU6PPEeqLIhif4A3rGwBSbLBQL5FzkPwFA636ydp92qunEXpuCKjVGe
 VJ+0M1kkQwKPwqcqjf0jy6JaBnWdARfZ0/ylTR+/0UXExMx20G7Jxhu3R3Q92cCnEz66a
 Ip4h4zO8Yawi5IsiKH/F5cjHkDyaar+w+/LNy6z0Z/mykxvBUA3wqmlombEfCJ+51zQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788526940;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
 bh=sLkn5p0JRcsyZ+qYNn+2IaO2Y4tzMwtHeobH/5FDL+Y=;
 b=myba7LMdtspIRGpsI+KpnshLZ0LtDnAMzY5JOWCD0HwSkkFd5F6VCkmmU6e9X7Ke6eK2
 ZsKlYcOp/tPa68pJfHz2FgXQlNKnv6f8HxrXFv/Um27Ps7hzbnTlyhNvMNtszyigzUcy4
 jY7POwb1Jf1jpND0aZcZVjSZo/hxRp6+1xGPtRlXFr7SVxSOS0spqO0rwxYvVnEwq4ysW
 H2fbfvsq3Juz3gXcHdvv3uY55JSzlkrRI9daqNm3S+lj9kI8lUjuTEZ+iUIb1FXJyER5u
 QXeh3uKYMLTk0QczVIV604l+O2zfx8/Qxk2o1KLpucPX4s0EuadRDWSwzEQUnoSFeTQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=siemens.com; 
 dkim=pass header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b="gbtF2/sK"; 
 arc=none smtp.remote-ip=185.136.64.226
X-Greylist: delayed 64 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 04 Sep 2026 13:02:19 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=jan.kiszka@siemens.com
 header.a=rsa-sha256 header.s=fm2 header.b=gbtF2/sK
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.136.64.226;
 helo=mta-64-226.siemens.flowmailer.net;
 envelope-from=fm-294854-20260904130112da94859b7b0002073d-vqi47n@rts-flowmailer.siemens.com;
 receiver=<UNKNOWN> 
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8E25C40BB8
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 13:02:18 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 20260904130112da94859b7b0002073d
 for <u-boot@lists.u-boot-project.org>;
 Fri, 04 Sep 2026 15:01:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=sLkn5p0JRcsyZ+qYNn+2IaO2Y4tzMwtHeobH/5FDL+Y=;
 b=gbtF2/sKQ9dHo12bHM756GkmkM1zaNl6oxCRlQIECkW9ONlIWo2bRGvQJanfJAB56tcCg5
 Eyl5GXeUl1a1V2VAnBO6n7bfAztD8Skm4plbUlIuJS/EbG8X6eEbOYw/niuPVvBxX+r6c6IK
 p8xn+BgO00xu0XG6o7SoVYeyUyz/q7FoptRCO23AbOxuR+Vd2+N8TLpN9hPv5Cqsx40Oo+DN
 wAiRS/YOAO613OSfAtygmcrIffGr9DOj+YuFMSn6RIBOJBg7DN3KTipUEiFl1xHmsjvDJAaW
 tL0lP8cMnU3bNqy52meg05hVL8TV2DzAqo1Ey4xyC8FRJ+dnQw+SgShA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Stefan Roese <stefan.roese@mailbox.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2 1/2] watchdog: Add support for i6300esb
Date: Fri,  4 Sep 2026 15:01:03 +0200
Message-ID: <d2d659169ff5dcfc8e72e03abe887afe20a685a7.1788526864.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1788526864.git.jan.kiszka@siemens.com>
References: <cover.1788526864.git.jan.kiszka@siemens.com>
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
 drivers/watchdog/i6300esb-wdt.c | 147 ++++++++++++++++++++++++++++++++
 3 files changed, 157 insertions(+)
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
index 00000000000..3a94971bfda
--- /dev/null
+++ b/drivers/watchdog/i6300esb-wdt.c
@@ -0,0 +1,147 @@
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
+static int i6300esb_wdt_start(struct udevice *dev, u64 ms, ulong flags)
+{
+	struct i6300_wdt *wdt = dev_get_priv(dev);
+	uint32_t val;
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
+	dm_pci_write_config8(dev, ESB_LOCK_REG, ESB_WDT_ENABLE);
+
+	return 0;
+}
+
+static int i6300esb_wdt_stop(struct udevice *dev)
+{
+	struct i6300_wdt *wdt = dev_get_priv(dev);
+	uint8_t val;
+
+	/* First, reset timers as suggested by the docs */
+	unlock_timer_regs(wdt);
+	writew(ESB_WDT_RELOAD, ESB_RELOAD_REG(wdt));
+	/* Then disable the WDT */
+	dm_pci_write_config8(dev, ESB_LOCK_REG, 0x0);
+	dm_pci_read_config8(dev, ESB_LOCK_REG, &val);
+
+	/* Returns 0 if the timer was disabled, non-zero otherwise */
+	return val & ESB_WDT_ENABLE;
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
+static int i6300esb_wdt_probe(struct udevice *dev)
+{
+	struct i6300_wdt *wdt = dev_get_priv(dev);
+	uint8_t val;
+
+	wdt->base = dm_pci_map_bar(dev, PCI_BASE_ADDRESS_0, 0, 0,
+				   PCI_REGION_TYPE, PCI_REGION_MEM);
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

