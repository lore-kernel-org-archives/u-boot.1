Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56995C5DF8C
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 08:44:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F16748116F;
	Fri, 21 Aug 2026 08:44:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4gbzojDEebWs; Fri, 21 Aug 2026 08:44:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787301871;
	bh=c+JOqmX5gjh346J6Ra2hFBDv7MW/8wjydOBQvXqpDq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u+Yb2Cw7jykdz1e0dYVaUKJTVjS/yvAZuoqXLBLXesvQUQ0yFVj6eGlFhgsJtgeJX
	 TYW8K4Wx6ZuYQFuOvrzL+X+0OxcITliuqOr8AWbp11f31FrUNKQGw+hj1AmotkpAJV
	 ohglgg9ldiWBG42qWfSlwoYXMlFIr8YfLKsFjMLUC8oUsd0WtvGG0zK7SE5eg0V61C
	 WkAsiTsELz6wwqh+aCtVUNzBsxPCnG9tMFkDfQvS83qwVoWLzElvH7tvBt5txLFKuF
	 w0+DCTxZQEpTLA67yC5fDLNFV9NiUhorLtX2/Zq7GJ0RdrqxGr/ZSvPMyOLowdI31/
	 sbX4NYKIpjlNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 251078116B;
	Fri, 21 Aug 2026 08:44:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 46E75476
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:44:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2D42B8114E
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:44:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2wzpn8w29PIs for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:44:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=ITOdVI8j
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1988481154
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:44:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787301861; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fy0C84aR3NcuXPVh2cnjMSsJm4A5lVTzTGw8vFI2ddxVffVm0dP8CbD59Fkvhs5kNqLW3ogW2OmKZcuRqEv697mhGIpNDm4fdU/vOW6ACMxyszdy0iB8D+nHYawCeMz7u4A1PXWjpWJFPrRXG0STN9QBfz4JA1No5uz/mBY9AWg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787301861;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=c+JOqmX5gjh346J6Ra2hFBDv7MW/8wjydOBQvXqpDq4=; 
 b=Wyf9hv2jhUm4rxmpGHcr/fmsmDLFUQkwzeuwwuTZ8U09Uygx2VryAzpnVVVyb6evte+fQ/WfEvDNZ+deTPjh8Xjt09yhPUZyNd9OKi3hWrFjs6NGXXM4+hV58TgXPduG6sqm9F58VF7q04QcFgZ9dggQdbV9c/xAuLjzbDUzOf0=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787301861; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=c+JOqmX5gjh346J6Ra2hFBDv7MW/8wjydOBQvXqpDq4=;
 b=ITOdVI8j+1o8qWEdKgxY7glb4qgvH17iy4K3+Jls2OKzjGbLq3O7TLe5pmKdTmSO
 EDV+OwRfG+xFhxLMZOvQQMsjyKzey9o52XZVTKT3DaYpPtZXVlVwZ3lymiNg/LXvpUB
 KRstsYlm1lOfvZfaSHCLtXhC9Z1y0NEY+k36y+iY=
Received: by mx.zohomail.com with SMTPS id 178730185936555.33463115234417;
 Fri, 21 Aug 2026 01:44:19 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v3 13/19] timer: Add loongarch_timer driver
Date: Fri, 21 Aug 2026 08:42:13 +0000
Message-ID: <20260821084219.1703743-14-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821084219.1703743-1-me@ziyao.cc>
References: <20260821084219.1703743-1-me@ziyao.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Implement a timer driver for LoongArch architecture timer. It's synced
in hardware for every core in a system, and frequency information can be
gathered from CPUCFG instruction.

It is not described in fdt, thus a DRVINFO is declared for it. During
probing, stability of the timer frequency is checked through CPUCFG, and
the probing would fail if it isn't constant.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
---

Changed from v2
- include div64.h for definition of lldiv()
- Rename loongarch_timer_bind() to loongarch_timer_probe(), to correctly
  reflect that it's used in the probe() callback
- Bail out with -ENODEV when missing LLFTP support, which means there
  isn't a timer with stable frequency

No changes from v1

 drivers/timer/Kconfig           |   8 ++
 drivers/timer/Makefile          |   1 +
 drivers/timer/loongarch_timer.c | 132 ++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+)
 create mode 100644 drivers/timer/loongarch_timer.c

diff --git a/drivers/timer/Kconfig b/drivers/timer/Kconfig
index 500a25638a96..6feb53328147 100644
--- a/drivers/timer/Kconfig
+++ b/drivers/timer/Kconfig
@@ -348,4 +348,12 @@ config GOLDFISH_TIMER
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
index 000000000000..c294112abe19
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
+	*freq = base_freq * cfm / cfd;
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
2.55.0

