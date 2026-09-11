Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F78EC88E4C
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 10:48:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D843B812BE;
	Fri, 11 Sep 2026 10:48:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SYk8s6ASSCYW; Fri, 11 Sep 2026 10:48:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2FAF38125D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789123698;
	b=TfHr80h4eG90fEgjsPuYCuD/ZOEHsYENzwxhwotyEtYNW4jMdgKvfDMlPMj3HOKs/f7u
	 snNZ23kdMPmxRbJeRuHImCqYT502s+9eNAax86piTVf44DxQxfOMbezp1gjgPzDX1evMU
	 1WcN38iJQPSeWMrjxwi6IM1wUC0vRECnzTaZfhhYYm3GI9oxAI5ffc+/LRUaG/yfjTPgm
	 WSil4tWIvil89iYJ9g0P6G7Sb/63KyELdX/HJZzKFelut8Gv+ejwfOGtIlF2nW+TN9+V4
	 woixUjNAzIlWxTRXuJvpt20X9WIHvDqbFm9iTWeRJupjgU8AvUyXemfovm8QzU4B3Og==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789123698;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=vNfMPUcyun39PabwWZ9YPgLuFFzHS96SYhMVnEtNZPo=;
	b=CztUUBzacClkJHI5CN3Nr5gdUonJuxJaheuSFnOfGtyeifyJM5EXagg/1V3mD1b/VcwL
	 wac6CRvUg1/RsT5P5vfCMG9EU4GNYBATeBSZT99WLJF2r/2/vgRT0jdB2V9CsVvV0pvtf
	 CkfXeQXyYUYsB26TpLJXlwnOvxCHT9AuR5xGQQPSRDN2nwempuqjsTFMvKDeU2iC0q/9h
	 Pap1l1izhonxy+4hyusnzh2jKf1b3rCDSMIODNQ1uMvyMz7qxVvflMhXKvHQPQhYNuN10
	 usVWhG+B8xD0Culzq8xMN0L5zTLZIne0+fg1n/aBg6IoOXOrKiYWs6u7wqX9MPDXSAw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789123698;
	bh=vNfMPUcyun39PabwWZ9YPgLuFFzHS96SYhMVnEtNZPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KFaERZmIvuXqC0m4ZFYihXUNkoizj2WFR6Tlm2xMGQJ3poSDob7WjBqZOjCIfD4eI
	 NgEa+606rvNBafF5gbrCLccEx3RKG2vXmHLpxtXabBYTPeOPEL3llVk3gEC/P2xLRe
	 Km7YYU6LyaqBLyi4O0D8HIHpUQ87UtBVPPiBI5eXYGLkEGwSQTRezfE+dDeE0hRHXZ
	 vyRqSklY20K4cq1mQGYRDjIxWYhPQW36NaNv5cFSiK+1JdlGIP9Oi0Kh+zoe1ODRvx
	 fy/evCglw9yE1Y1ZUI3bB265Ak7nnaJx3/dC1LusCA1oYSs83qh1c/ztw8AYmIfcwY
	 7qNxI8KW0FR9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2FAF38125D;
	Fri, 11 Sep 2026 10:48:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5DD1149D
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:48:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4386F40461
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:48:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I7e7t0ox_ZeQ for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 10:48:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5654040460
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789123695;
 b=C9fKNC7jtgiXVLc/l//0XWTIHEdFvqKqiyq97TJikC5GTvagh/UBAuXf80JurBYgDdXm
 tXs1Se0MDBzfkXFzKoTEi16CXCO1kt0IrWlBQ5b+2Pfyvy0FnNoleafU3fU9LljBOOyq5
 wPLNrD1yOelnEpXs57LAyNUFdz7Gppr4ktino5r9alA3dc72ezgB1ctDfPub1ow0RcZ2a
 h2AT7Y6FtwU/xoxA9nmhB+uVzz4m10wcF0ERKaoPtB+ngD7DS42iBKwK3zwqngWn1hS6d
 KhO4n7Y2gsss0DDrgyPO3bKeswNqIrMXvcQCqwybBaiDrQciRjQZAaOjleT+Izt2xBA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789123695;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=vNfMPUcyun39PabwWZ9YPgLuFFzHS96SYhMVnEtNZPo=;
 b=aikB6tdlt7q6WSsI6tL1zWpx9lfMGaY2yOvhVtMNSIla3OELu7eQG5a2Dtvk3eUpIyjc
 nBsIQRcW66J4+mCq1Xvwz5QdLiAEWcMAfGJQL9+bxUZqdvK2BJCm4Dfs9mJr9mzHoVVZJ
 sdUphTrVZW6pCBKOPMBsrF8YaavTUlIAxKPAMFJtCRXRWnPOe6VrQ9BzAgI7uhq2PgybG
 A3wdviubU4vWSnFddVO2paP/5JHG+8SKQJYGhjTkNg4lOUqk8RlHwLCtPHWqLKBFv5Vsn
 GiIqRMfX1Kg8kbYdv1/yh8j7AaXpkvTY5h2mJGKi0dgKSU4NVsLTosG+g8WEAgPbAYg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=GzfXN8iq; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=GzfXN8iq
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5654040460
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:48:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789123688; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=m0C+fMdxjbFIQ2BrF3h4AbAp0cYUTriKseVzPPIXbFQxTts08ZcSeCeyEZvkiopktEw3fJQk98xxGWjegLBUrHqpoT4Lu5UTJhhhe6OlokRM6bDp3RaXEiOfjIdWNO0u769i0eZsA6zK2uP0nhTkONWx+tBWm2RoPfqwFBEySKE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789123688;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=vNfMPUcyun39PabwWZ9YPgLuFFzHS96SYhMVnEtNZPo=; 
 b=Kwl95NMBIFv24sBavYos1TwYD8MtPRQFqpDU4gwSti453NH59eIZ7osX/w2+e4oXFXUbDIZNrehotjMoxQJnmHTpr6EIswO8DpDiPXeZGodvtuup7z8ZRqoL2TqTD9tb/mfAvOU6rTEAY0e6kTwh5UHALcG/Kf8k+wXBplFqQY0=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789123688; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=vNfMPUcyun39PabwWZ9YPgLuFFzHS96SYhMVnEtNZPo=;
 b=GzfXN8iqicdkb3PW13iyZawfbfOZdhgIrCDwB6ND/wh1iJH5O0Zj/AJfLH7hpzpz
 IU2kXi4I2Cgga4HP6sEj57ZAoWkxneQNpQwLAT3+a2fIhDTHRhZ63geA9TmVFNRWC+S
 WNN2XXddE86zFuBYI3F6PoBkOeHezwy07PASy+FY=
Received: by mx.zohomail.com with SMTPS id 1789123686125868.2406804214248;
 Fri, 11 Sep 2026 03:48:06 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v4 13/19] timer: Add loongarch_timer driver
Date: Fri, 11 Sep 2026 10:45:58 +0000
Message-ID: <20260911104604.2910944-14-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911104604.2910944-1-me@ziyao.cc>
References: <20260911104604.2910944-1-me@ziyao.cc>
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

No changes since v3

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

