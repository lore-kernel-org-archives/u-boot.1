Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8962606A323
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RtJHDmgM;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=Ya3NTzA8
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A74C440D96;
	Thu, 12 Nov 2026 11:57:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PwEUmRhvunXx; Thu, 12 Nov 2026 11:57:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A17F740D0C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794484630;
	b=FEiBnR+9ANVCkOgwYpaaRcrhImdbO8WRrMQki1vpP3vglMkF2o8HEtbkF0RlD0qZrs1r
	 XSFn5v6ZgHX68OZH4MFfemIxr1WnkfVKMB53CFOhe2wnyb7P6JXVMGppvBGGr392mFzlh
	 LL82lxJy89QYhhUIqwjGIjzZA4bKkON0IXCVAk8Ka2TKyvfzuHs9SmWXMy1zKW4HCKEPe
	 MyXGZtDgO9TkD6cfseLIriKwVyf+TwV81GsZ/BctyaerzpJgNh0RLywx2hOvGmzTAoOYm
	 EcJNGcWNwBwePfrLNSTrG8XEFm5d6/93kFU/A1rU2XjQ1Gt9jbsDX033Hijn827Zlbw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794484630;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=hwNa7Z+qv5u24kzzn63bU8H3eiYfCtoQPUgmk9xViso=;
	b=rdRSTGXnwbXi4DerCZHh1f/mRNTb6ERPrblWORKx17818NUxq8IFcsWcuypIqG3mfSkC
	 dP2f7923YaVT8ofjw6PjYN1svpGnxu3jprHcGbtcbG4RgEhu8Dqp5kacBAcVSVzZafH64
	 9eOev2fx5uztr7YjArGP15f3AzNGiFNdiy7vmvGRTjggkJXmSgv5hb4TpVspSJLLbovfD
	 JJkO0OlkALnWmfZ+cuSTbMKzljIB/kXBQ6QP1P3PE74oh5YgiCbia9sEbZBYTwSkaVWOz
	 86v7WeBLka3y9hBz8OfK739RkWZ3yE/t73Bpc5eRw/UXg2D8hSakBBMMV83Id2Xv54Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794484630;
	bh=hwNa7Z+qv5u24kzzn63bU8H3eiYfCtoQPUgmk9xViso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RtJHDmgMlYfYVwNapx2kvduiQwgG+pOdenB9Kt4Fl8VyQiXlRgdubhRHAzPl9lvq1
	 WjBlJKWWvial4G122pX3qKYMjoxkvCS+JwXY3KnaEJhZjP87Co8R4/xFofWzKsK6aZ
	 d9lPV/OkepAINudRtEcrrIV9pdMltekj/LmwNPofPyuTTa0M1DfTnf9rCnxt2uS+kS
	 J2o3AuteXC3leNoCjAe4LwK+HeDiVVwPlQ7CYcz8N4XxV0uDDr3WMK6eQPZoR2c96J
	 aoJLyCW2C1f4Ajv6tsjCYOQvCMYOKUH1vCgHeow+DR5PJM8cXuXTsjWQCUiLReDxGC
	 gG9px1XlkPaFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A17F740D0C;
	Thu, 12 Nov 2026 11:57:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C5FCC235
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:57:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B7B868144C
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:57:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FTANUaIr_sXS for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 11:57:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 018488144A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=Ya3NTzA8
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 018488144A
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:57:08 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=Ya3NTzA8y/UTbua3pyvS1YMVEU30PeTnnsg1KMPobk/kPHtMIFvkGIRtd5QADbFRRfUQoC8QJABy23HeeVv4xwDxlpIDH1TETKZ9KajUvwXdf/L6USst4meVBVw2SapaxNwpAtnW2pXpVybpINKD4HCfGBEXY6QXMU2LYe43Tiw=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=hwNa7Z+qv5u24kzzn63bU8H3eiYfCtoQPUgmk9xViso=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794484622400221.89336768109956; 
 Thu, 12 Nov 2026 03:57:02 -0800 (PST)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 14/20] timer: Add loongarch_timer driver
Date: Thu, 12 Nov 2026 11:54:32 +0000
Message-ID: <20261112115438.1837663-15-me@ziyao.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112115438.1837663-1-me@ziyao.cc>
References: <20261112115438.1837663-1-me@ziyao.cc>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Implement a timer driver for LoongArch architecture timer. It's synced
in hardware for every core in a system, and frequency information can be
gathered from CPUCFG instruction.

It is not described in fdt, thus a DRVINFO is declared for it. During
probing, stability of the timer frequency is checked through CPUCFG, and
the probing would fail if it isn't constant.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

No changes since v5

Changed from v4:
- Convert base_freq to unsigned long before calculating timer frequency
  to avoid possible overflow

No changes since v3

Changed from v2
- include div64.h for definition of lldiv()
- Rename loongarch_timer_bind() to loongarch_timer_probe(), to correctly
  reflect that it's used in the probe() callback
- Bail out with -ENODEV when missing LLFTP support, which means there
  isn't a timer with stable frequency

No changes from v1
---
 drivers/timer/Kconfig           |   8 ++
 drivers/timer/Makefile          |   1 +
 drivers/timer/loongarch_timer.c | 132 ++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+)
 create mode 100644 drivers/timer/loongarch_timer.c

diff --git a/drivers/timer/Kconfig b/drivers/timer/Kconfig
index 2b9123020533..12d93274f0f6 100644
--- a/drivers/timer/Kconfig
+++ b/drivers/timer/Kconfig
@@ -353,4 +353,12 @@ config GOLDFISH_TIMER
 	  It uses the Goldfish RTC hardware to provide a nanosecond-resolution
 	  timer, commonly found in QEMU virt machines.
 
+config LOONGARCH_TIMER
+	bool "LoongArch CPU timer support"
+	depends on TIMER
+	depends on LOONGARCH
+	help
+	  Select this to enable support for the timer found on
+	  LoongArch CPUs.
+
 endmenu
diff --git a/drivers/timer/Makefile b/drivers/timer/Makefile
index d8b3f2b65d4c..0b70b915bfeb 100644
--- a/drivers/timer/Makefile
+++ b/drivers/timer/Makefile
@@ -37,3 +37,4 @@ obj-$(CONFIG_IMX_GPT_TIMER)	+= imx-gpt-timer.o
 obj-$(CONFIG_XILINX_TIMER)	+= xilinx-timer.o
 obj-$(CONFIG_STARFIVE_TIMER)	+= starfive-timer.o
 obj-$(CONFIG_GOLDFISH_TIMER)	+= goldfish_timer.o
+obj-$(CONFIG_LOONGARCH_TIMER)	+= loongarch_timer.o
diff --git a/drivers/timer/loongarch_timer.c b/drivers/timer/loongarch_timer.c
new file mode 100644
index 000000000000..8be3459595cd
--- /dev/null
+++ b/drivers/timer/loongarch_timer.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <asm/loongarch.h>
+#include <div64.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <errno.h>
+#include <timer.h>
+
+static u64 notrace loongarch_timer_get_count(struct udevice *dev)
+{
+	u32 hi, lo;
+
+	if (IS_ENABLED(CONFIG_64BIT))
+		return drdtime();
+
+	do {
+		hi = rdtimeh();
+		lo = rdtimel();
+	} while (hi != rdtimeh());
+
+	return ((u64)hi << 32) | lo;
+}
+
+static int loongarch_timer_get_freq_cpucfg(unsigned int *freq)
+{
+	unsigned int res;
+	unsigned int base_freq;
+	unsigned int cfm, cfd;
+
+	res = read_cpucfg(LOONGARCH_CPUCFG2);
+	if (!(res & CPUCFG2_LLFTP))
+		return -ENODEV;
+
+	base_freq = read_cpucfg(LOONGARCH_CPUCFG4);
+	res = read_cpucfg(LOONGARCH_CPUCFG5);
+	cfm = res & 0xffff;
+	cfd = (res >> 16) & 0xffff;
+
+	if (!base_freq || !cfm || !cfd)
+		return -EINVAL;
+
+	*freq = (unsigned long)base_freq * cfm / cfd;
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_TIMER_EARLY)
+/**
+ * timer_early_get_rate() - Get the timer rate before driver model
+ */
+unsigned long notrace timer_early_get_rate(void)
+{
+	unsigned int freq;
+	int ret = loongarch_timer_get_freq_cpucfg(&freq);
+
+	if (ret)
+		panic("Failed to read timer frequency from cpucfg: %d\n", ret);
+
+	return freq;
+}
+
+/**
+ * timer_early_get_count() - Get the timer count before driver model
+ *
+ */
+u64 notrace timer_early_get_count(void)
+{
+	return loongarch_timer_get_count(NULL);
+}
+#endif
+
+#if CONFIG_IS_ENABLED(BOOTSTAGE)
+ulong timer_get_boot_us(void)
+{
+	int ret;
+	u64 ticks = 0;
+	u32 rate;
+
+	ret = dm_timer_init();
+	if (!ret) {
+		rate = timer_get_rate(gd->timer);
+		timer_get_count(gd->timer, &ticks);
+	} else {
+		ret = loongarch_timer_get_freq_cpucfg(&rate);
+		if (ret)
+			panic("failed to read timer frequency from cpucfg: %d\n", ret);
+
+		ticks = loongarch_timer_get_count(NULL);
+	}
+
+	/* Below is converted from time(us) = (tick / rate) * 1000000 */
+	return lldiv(ticks * 1000, (rate / 1000));
+}
+#endif
+
+static int loongarch_timer_probe(struct udevice *dev)
+{
+	struct timer_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+	unsigned int rate;
+	int ret;
+
+	ret = loongarch_timer_get_freq_cpucfg(&rate);
+	if (ret < 0) {
+		dev_err(dev, "failed to read timer frequency from cpucfg: %d\n",
+			ret);
+		return ret;
+	}
+
+	uc_priv->clock_rate = rate;
+
+	return 0;
+}
+
+static const struct timer_ops loongarch_timer_ops = {
+	.get_count = loongarch_timer_get_count,
+};
+
+U_BOOT_DRIVER(loongarch_timer) = {
+	.name = "loongarch_timer",
+	.id = UCLASS_TIMER,
+	.probe = loongarch_timer_probe,
+	.ops = &loongarch_timer_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
+
+U_BOOT_DRVINFO(loongarch_timer) = {
+	.name = "loongarch_timer",
+};
-- 
2.56.0

