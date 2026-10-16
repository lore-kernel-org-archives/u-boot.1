Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A17ECC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 06:57:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 43EDA812E4;
	Fri, 16 Oct 2026 06:57:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KwZsQhT1S3GQ; Fri, 16 Oct 2026 06:57:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6F3F281324
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792133867;
	b=pZ+cqkwN2J7TnBqZqkFBB5QTFxpPVVXLR1neepoFZosqdflZZnbmW/1QLJAGQ9q8tTOt
	 Aevr6nBsvIjMlE2DnN5TUH0MTsF8+7vN89dZWKhrzCGqKFnFljFDN5BhfwHRFFGmdz62t
	 auN+IzL/atqxjS8qigdu75dD3uBJX9+jdFiVoLVWKLrVvOjJNqFtmYneuRDKV3tXVi9ow
	 Xj5SMbigmm0lTnyHQEk3HhCff8VZBZbp/GAu0lGOcyyNNWOc4AhgYO/wQkEV2CW2YpK2e
	 HmjWRg7jHEe5fXYAZQpz8L30qg4eRhwtWawo1mpOEtRT6s8i0i7+nViq4BFKoalb0cQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792133867;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=s3NMhNS9c23D+cx44T8UGmZagl9AdtUlCSJQe2mJy8w=;
	b=iBzs+2rhjPiAgiyAjdFde0NUAlgdGgp5DvjTta+RYPyXpvJfLldwW7Y7WdMfjphsRg5F
	 seObqE11Og/6DcYxfM8NWRBB5RDhTzI/sj67p/Dj6URPjwiv9iCXSfCgSFRS7SonLgehM
	 T+wzZNIuMaX5qtJfNGTFSDsEp8XUiLEBve531xXOXf0ZmTiXyyiNvJtxVhHEw63A2oFVn
	 jaH60pXOggg1/QEGp/yC0e8o2fOBhfN6rSZ/UjnAWdqnAzawDwzzpdRjDnt4LOISJaxD+
	 UeSjcEpKSLO8cycuJhEU48TN97d1Tey8cx9AB4mOxTTHE5kIDZSO70KOKPv5s8Y4bUw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=N9fnozSd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792133867;
	bh=s3NMhNS9c23D+cx44T8UGmZagl9AdtUlCSJQe2mJy8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p/pTgN+5Eyl0dRxFzTO4rcWfeYjSbpkPOv2Fv6SF6pcv6A/aaB7bE4NE0WENMmQsJ
	 +KUOQF5shbpeEmDbQ4aHkUD2YGDvGjXfcyo4mh5XubIfyP+D8EDBx8Al1WBHVW6QSP
	 GnuiGqG0AJsSFGQ67PXLOqW2C65VAlXmVcD9dg4i7BGfUXENxBcb63oiUHXvEo7vnw
	 ooZ10giVwoEy6nF8JORUtmKL3cB/sNISGRkarLQpO2j8Mpt+2I+day7nieEKk0mqI3
	 7l7QbXi2f1rPl06K5+Bi5F0do9MiwyNDt8Pf5nRVGY4ABZSXfqG+9pY/cNwvmdw+xF
	 MZmapVXqNGRpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F3F281324;
	Fri, 16 Oct 2026 06:57:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A2331DE
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:57:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5C67081324
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:57:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eB0G5yatKmel for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 06:57:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8E153812E4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792133865;
 b=bd4YOxqi0U8WMQEYREc337x7DjOm/9ju71DL1g6a4n6flSIY31x0pjOv87e0JuwZ6grk
 GgkLxYXh4lEPPCwWItJcNgrCbp2UVYTbHdLihA7nNsrjYRM1ikaPfWLwsnrSXyMnGnZlS
 fm6fzeSZYUcOCS/r0Nn6VGnjjyHbZgP6O7rC7N8W4lCA8cYgc0P7Gv+B0FXcV1TMA6Ucd
 pvCJrWfxoQhO9hunqZNErUSoryZ4GylzQ+mYMRAJBzH99IyjSith/F2FqExPPVhbpWGPw
 mQDg9tu8SDnTA27yBfl1ydM0JXUe1oNYHL78dDJ0qbWnlU9sxPuMmATxmFuBpeb3IBg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792133865;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=s3NMhNS9c23D+cx44T8UGmZagl9AdtUlCSJQe2mJy8w=;
 b=fbX8O/AMNq6OG3gheBVwim0Vuh2GhO9w4I94vCBwV9fI+nC2CXBbNeMv1V0bVKZclQpb
 vxYBPcY01IC5WtmRcyOk6+TLZJIBiWaszR/dIhV0QuRIo5zgNacTqQTKqlM7K6ePybG7H
 0S0sVC4BIrlm66PHgzFkwgvYyF5Ak2uIljxkiPlL+OeHtOJymaX5CVEsNVvotoAI6f5W6
 kgsc7TGzq7SDzb3cmZtNKEmdYSq8QSFCDRNoKn9ALUkcrY6QxIaGkMzWmrvQCrdgg5IX9
 ztD19d7OhcKVC3a+pNx4rYOWjtYYIHjNClkkgZ4mKmLji0oNJt+QTLNTd3k/2zft2lQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=N9fnozSd; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=N9fnozSd
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8E153812E4
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 06:57:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1792133859; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Bl9yo1FDpDGp7h08fMycM3c+S0eWXIHGFcuW22KUdAwsXGQOZT1QXHbOiN2fzDoZJN0rII8OZGGcyeoy9z0+cgj0yAAN3qRD/dThQFEt8SJya0gspGa3d9kj2xYOyYPtSwZVa91q70Ji8R4Kx1jGD/vb1+57s/76gdUw0zjgHgk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1792133859;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=s3NMhNS9c23D+cx44T8UGmZagl9AdtUlCSJQe2mJy8w=; 
 b=M0zTgsT/BfCZl5wcNWiotlyu2sZGSjLz/BB8FE/Jx661LYInbfOQtnJOd0PCktjm1fAa0rNldtEcxaCNMu46xKQwP4NrhAOuVuUP4c74wEgm003TfCwZR4ktjW/NXb+jL9CZBEcnq+5fe5RcTEdnlHziZMyW+TldWHL0+6Vgfqs=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792133859; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=s3NMhNS9c23D+cx44T8UGmZagl9AdtUlCSJQe2mJy8w=;
 b=N9fnozSd0C81d5s93pZhwST9eMMHlwaI4rr1aLSE63Tv06rLUSEn868c1Pa6bM/l
 tqMlCAf2gn+QJpTxsShYInrKNpcBDR80BFeLB7oiOyndiJwGu8Gg1GVLqo4ZZg7GAAV
 /8WEf68P0Kc9sm8FjOaFgSyeQMJJhvElGebHOPTk=
Received: by smtp.zohomail.com with SMTPS id 1792133856769886.9280084629252;
 Thu, 15 Oct 2026 23:57:36 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v5 14/20] timer: Add loongarch_timer driver
Date: Fri, 16 Oct 2026 06:54:54 +0000
Message-ID: <20261016065500.137544-15-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016065500.137544-1-me@ziyao.cc>
References: <20261016065500.137544-1-me@ziyao.cc>
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
2.55.0

