Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7304C25B79
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 15:37:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88ADF8889D;
	Wed, 22 May 2024 17:35:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="lm893cqy";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="I0p087HQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2DE488897; Wed, 22 May 2024 17:35:35 +0200 (CEST)
Received: from wfhigh8-smtp.messagingengine.com
 (wfhigh8-smtp.messagingengine.com [64.147.123.159])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D7B48888B
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 17:35:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfhigh.west.internal (Postfix) with ESMTP id CFE201800132;
 Wed, 22 May 2024 11:35:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Wed, 22 May 2024 11:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716392131;
 x=1716478531; bh=yFk4y9nrxj8qXvfM1UImgJEXeDGhg0pkvSHCg2jKqZU=; b=
 lm893cqydiyRFkJscz2DKPS+YT1psGnSllDvyfUVz+G15XpQyT4OaH0zgHPuIwY3
 8IG4LM+KdvvVgX8nZXQIPZz4nKrWMNvj1dlAPH/O1wL4CSk0LDSI8iOKBqTZJ0PZ
 betFLWoFKZL1pSAplmay4QmjfnaK7PAI2jW0R/L4JBxXx8EZlqobzP0I7ZFjEZAs
 /VQsxGllVQU1GU5MiShBKpR02OFA2hUimoffuqxGPDdoYZ9NOGQz7jLuVFOFDB7k
 TpyQPVJUd0NXRvV1qmCtkU3TUFfl5qM9V8iw/M+J8d4Xq5Dgk1SQHsUqOAkJU/ve
 szU4DFTgqcLYhQvFlLXIXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716392131; x=
 1716478531; bh=yFk4y9nrxj8qXvfM1UImgJEXeDGhg0pkvSHCg2jKqZU=; b=I
 0p087HQrKK5Xw6wAE8KmH2Ax39eqrIbSlvkRBA8Tzqoy4H0oZZScv0cz/Y/uT1wd
 au5lkkGyESvhBqBmLniAZBhBWnRiKaNFMrFmuCh43F+lfauUhqfPacCQCVZRNRTe
 cTXVk3vlRXY2ex2Y4R8uP8TPlVDrBTmRE3dHG6ZRyVzNvTngejklo+Hw62D8To0o
 xI0ZElye/aUqHxCGnk5pR/gaN8/8x70TkDhJ2GcFjiuKBbAST/5BPIAp97lMm4G4
 B8lEi/nZ10KEdLCiuny5WGL3ZsL/wpNm5QUTwMgA1VtUHTGu6OZConPC5znS99b/
 MZttynnM64Son1ZNa+LNQ==
X-ME-Sender: <xms:wxBOZkYfcWwMMtuYfeSZPXgY_7C66WCGpZiIQJYQR2kdzUPHSbg--w>
 <xme:wxBOZvZQwZ6XzinuJ_wuE_MbtxagPsTGKzF8pYFIcIZlb6bqs5wBF58l3mPYd-GWy
 1bcI5J5J-KC5ZoAGgQ>
X-ME-Received: <xmr:wxBOZu_UNDVDR9IFS1CxHBxTA-c28C7vOiJoZ9mQctOwKy0mUty96JA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeigedgvdefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:wxBOZurPBPJWmWR2Dkdnjvkw0wTu3SLEHSvqv--MLl0UQxgyxa5BWA>
 <xmx:wxBOZvqG1DIHhtF5yBqymHNVgrT3ZHXvRQLwWUI7De8yrSLNxVGXbw>
 <xmx:wxBOZsSwIFF-l2m1vKOGNaEZNlShTOlU7wR883ES-5QN3n5FWSvzug>
 <xmx:wxBOZvrsCElKfsJOpm1otr836jySNyPkmFdY4_RlONgGLQwkqLUJLw>
 <xmx:wxBOZgfiHIKYtcFzsQ2VyjxPR98iBJu1vzPWS0ekVod1WXTAv9XmhYTq>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 11:35:30 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 22 May 2024 16:34:56 +0100
Subject: [PATCH 13/16] timer: Add loongarch_timer driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-loongarch-v1-13-1407e0b69678@flygoat.com>
References: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
In-Reply-To: <20240522-loongarch-v1-0-1407e0b69678@flygoat.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4126;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=w3O6McbACadWE3Uk+5OBAe9YV8rsQ6cMZ6k75IFSZs0=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjQ/geXL54bP/7x74czJqqu2vGpntr/AE+Kjd3L25vfTp
 tUt2HpZpqOUhUGMi0FWTJElRECpb0PjxQXXH2T9gZnDygQyhIGLUwAmEv2CkeGm4D+naPXesA/n
 ZJJOBa99dnFhgcfW+gkTn+2c+izCbGkmUMXTt5bXrrF0pAkKx95LX97MXJvx6e+/+2y3upeftH/
 0gQsA
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

Implement a timer driver for LoongArch architecture driver.

It's synced in hardware for every core in a system, and frequency
information can be gathered from CPUCFG instruction.

It is not described in fdt, thus I have to declare a DRVINFO
for it.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/timer/Kconfig           |   8 +++
 drivers/timer/Makefile          |   1 +
 drivers/timer/loongarch_timer.c | 112 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+)

diff --git a/drivers/timer/Kconfig b/drivers/timer/Kconfig
index 60519c3b536c..e85c74a537ad 100644
--- a/drivers/timer/Kconfig
+++ b/drivers/timer/Kconfig
@@ -340,4 +340,12 @@ config STARFIVE_TIMER
 	  Select this to enable support for the timer found on
 	  Starfive SoC.
 
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
index b93145e8d437..632d7ac8fd83 100644
--- a/drivers/timer/Makefile
+++ b/drivers/timer/Makefile
@@ -35,3 +35,4 @@ obj-$(CONFIG_MCHP_PIT64B_TIMER)	+= mchp-pit64b-timer.o
 obj-$(CONFIG_IMX_GPT_TIMER)	+= imx-gpt-timer.o
 obj-$(CONFIG_XILINX_TIMER)	+= xilinx-timer.o
 obj-$(CONFIG_STARFIVE_TIMER)	+= starfive-timer.o
+obj-$(CONFIG_LOONGARCH_TIMER)	+= loongarch_timer.o
diff --git a/drivers/timer/loongarch_timer.c b/drivers/timer/loongarch_timer.c
new file mode 100644
index 000000000000..4b9f9307511f
--- /dev/null
+++ b/drivers/timer/loongarch_timer.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <dm.h>
+#include <errno.h>
+#include <timer.h>
+#include <asm/loongarch.h>
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
+static unsigned int loongarch_timer_get_freq_cpucfg(void)
+{
+	unsigned int res;
+	unsigned int base_freq;
+	unsigned int cfm, cfd;
+
+	res = read_cpucfg(LOONGARCH_CPUCFG2);
+	if (!(res & CPUCFG2_LLFTP))
+		return 0;
+
+	base_freq = read_cpucfg(LOONGARCH_CPUCFG4);
+	res = read_cpucfg(LOONGARCH_CPUCFG5);
+	cfm = res & 0xffff;
+	cfd = (res >> 16) & 0xffff;
+
+	if (!base_freq || !cfm || !cfd)
+		return 0;
+
+	return (base_freq * cfm / cfd);
+}
+
+#if IS_ENABLED(CONFIG_TIMER_EARLY)
+/**
+ * timer_early_get_rate() - Get the timer rate before driver model
+ */
+unsigned long notrace timer_early_get_rate(void)
+{
+	return loongarch_timer_get_freq_cpucfg();
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
+		rate = loongarch_timer_get_freq_cpucfg();
+		ticks = loongarch_timer_get_count(NULL);
+	}
+
+	/* Below is converted from time(us) = (tick / rate) * 10000000 */
+	return lldiv(ticks * 1000, (rate / 1000));
+}
+#endif
+
+static int loongarch_timer_bind(struct udevice *dev)
+{
+	struct timer_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+	u32 rate;
+
+	rate = loongarch_timer_get_freq_cpucfg();
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
+	.probe = loongarch_timer_bind,
+	.ops = &loongarch_timer_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
+
+U_BOOT_DRVINFO(loongarch_timer) = {
+	.name = "loongarch_timer",
+};

-- 
2.43.0

