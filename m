Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429A6606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 05:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OrgYrnDe;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=e63z0C3y
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1FAB3606F6;
	Thu, 29 Oct 2026 05:10:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id whvrtAUUynHf; Thu, 29 Oct 2026 05:10:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3A3F2606CA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250619;
	b=E3RSiJ088JLP7zvKjgsULnb92f6ZG9Zvc7umSywptuvZOUfkJtZoUImVd088yNocL5t+
	 7wVrNNAiu0/J9XWtpKyCjCkX9tEzE8fd+TVWpTIMzA1i8CU+zhOcI86sGxPfhHC6t78Wd
	 YnVJie4UwXfA0fCNEqAfYBrn2koXnseB4fsO8evgfhYPQLCD+oC68sY0+pxyZO8RVmE0G
	 xa7y269PkqtK9Q3r8t923lVWCFuVpvjgIMxjLKvuIjo0NjIBk2WUdfa/MGebKoOAABERB
	 b1DekT476HOyU0f4EfPO6fpb1yDkd6tSgmG6mrUCKsghb9fEgYsBijDEYSY4EfMARTw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793250619;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=GHeW/u7n7v3G53bWOkUDvm/viplTZDcnBj4HksyoRc8=;
	b=FYUXKG1+xCHh+sqmEZcdXPn8LFuAn0uXciwWHUTxLbAY8RvVsdw7JWSjJSYuG4uMZQJ1
	 L7bDaX0SDknoRaZNYWgVkqGphrkkJ9FQt5VeuxxbMPB6mr0HRy87Wz9rILKAfVXmLBfGb
	 OP7CwYM/rLYedjjThApBJd4b5tDa8djsagg+QmMKurh6Yu8qeioeNXkdmf3FKLO9Bo+mf
	 JUEy6tARey5OR54Ae4JMXxwlM48iBs3051k1m9djmHpQ3AN9QsKraluv1Yz1fz3IVSd9w
	 hOQyS+bwiFvABgsNNW+BkZmiLgwbAGAJgOS4VNvcfPxyfvbCdFk0wQQ6BEIUMmQKfVg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=e63z0C3y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793250619;
	bh=GHeW/u7n7v3G53bWOkUDvm/viplTZDcnBj4HksyoRc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OrgYrnDe9bW//SW77wooqnmJTlDGssrp3HBZVm3BDGWUvFwGl5WiVwW96tAgNjWS5
	 9kN+h4QM5YYqHyIoetee4eUayjffSqx9joI6dB5bUfVGEafySRBBO71wfJHTgAXLVY
	 8FIFI7II2mSDpKJVwB6XCqIQvTlikhGl53ptzxsDduIz8kJK8uPAq4jj0suB/uMj0e
	 ZgQMuv8jLkukWGFEjPJxCJ4W5UkwOHC3gvUjBUNElAWNKYi8GTpNrh7rCMznweXNN7
	 dE3DqjC5k5x+d/AhoDjL11aBxlllyCg0nS1SOvhrLT62gv0xW5zrcclftqcDz+wZoc
	 j+XIS668LOy/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3A3F2606CA;
	Thu, 29 Oct 2026 05:10:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A5BC12E5
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:10:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8B444606C2
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:10:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hfFZ5fwos11K for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 05:10:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 60656606F6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250613;
 b=HVJJHn0BgEOvlbCZogJvkGkhmxk9YO6j/iplbnuqZLnlMwvtjONUDjEwal9N4tPG3zOJ
 qeRzdIaUtw9kAjErCRa9gPLlqrCDKqP+FsDNlud4Mloscy5L7Yt7ujOsDDQO2j4DjJJ5Z
 lolh0DqHlK6I2tBxobT97pbhbqLXoaXbKYihPiftZihO8ZSjNDuUWzENyNeb6udRcgMqc
 Ko+Nc0AVI5sbazT0vStWGAW+ewWCCtRI4WLLFJ492hQ1Uzy1oKvvkgcCV1mCCAyE4EEwT
 WdryEvlchTSC26n/wXrlz0AUbGKyZ/QcNVSYlfP8FBOHhDCyQpXWJeHMDbp4zthb+Hg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793250613;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=GHeW/u7n7v3G53bWOkUDvm/viplTZDcnBj4HksyoRc8=;
 b=ctcGEWu5lNxlSCaXWJeBikbBGDFO8d0Ygz731kiggkoRSRQPZIf5s9wmPDTSI1v4CHtD
 npoX1tsp8hPzvjGaiZwDsTRrpPQx94geGfGSIERu4gE+ckLHwzWSG3Xv7P3RXbJ//4vpb
 fIjx3siZeta+S4Dq7Aac0mtpKhTYiujmTwzdMKJkStM+RjVMYFYxOtUGDzH8gAIoebaGL
 jXkje+AC8RNaGdgUnvAJEQ5ZX4wgb/ZNBklrJoJngnnt1ZYp5voWpSFlJ75LvzXD2A3w0
 br/4hcd+6s7AmfbdW42/Hp998X/PKVQPHTrZMrfC8rXBdHwigjqnPDbY4vIhj6kJ9Iw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=e63z0C3y; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=e63z0C3y
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 60656606F6
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:10:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793250607; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fxiqNsH9kla0AkS2SsS3gF5gih8tsLW2SbzWLz5O8pNg30Tx7jspcsONqygGEVTx9ADBOro28gmJjj0BgTt1dPlPP45TB3cKRFfYroaVjrFCulEWawvN/gsGuYCztCs7UQ82KTVtAdJsW/K2c1k+BX0xo2Xreu2oh08KBcEkwOA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793250607;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=GHeW/u7n7v3G53bWOkUDvm/viplTZDcnBj4HksyoRc8=; 
 b=SUozLlQ4oeVkc4njXjF31pMtJ25rHTatNs+0O8hxHT8s4ZBqndgZ98xgYldXM4xOSZnqydAQtLvXX5AoeVH9qTZ60bJKek2ZGeRncV2zaABHX+1zBLxSLNfzD/P3bYtJ5/XLkOZe2bD1vbrsg4yC3AoQrb4CQPbw4inQkESHe3g=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256;
 b=e63z0C3y60bNo7kvG6h+myoifTGyO6eWBK+lpIxX6NlTkCoXvdodLeoMyudh+eSlu5090Qa/8Qx7GYEVkLUNWhR0eGfyPiyRuGrtHPwvOATJ8cmDx/ZQrdip4h33Kr0ZTUnxJDxe2AzkgKjUEJ0u/m4jzw0CAVSlTn3vBfFVA0w=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=GHeW/u7n7v3G53bWOkUDvm/viplTZDcnBj4HksyoRc8=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793250605399907.4178474449976;
 Wed, 28 Oct 2026 22:10:05 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 14/20] timer: Add loongarch_timer driver
Date: Thu, 29 Oct 2026 05:07:31 +0000
Message-ID: <20261029050738.1107663-15-me@ziyao.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029050738.1107663-1-me@ziyao.cc>
References: <20261029050738.1107663-1-me@ziyao.cc>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
2.56.0

