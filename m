Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435E3CCF9E0
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:33:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DB5B832AD;
	Mon, 27 Oct 2025 17:33:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Rgp6SBQb";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lTYM+kEC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E5E3836B4; Mon, 27 Oct 2025 17:33:24 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36E2C82E34
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:33:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cwJwK02N3z9stX;
 Mon, 27 Oct 2025 17:33:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761582801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZArRjOdz7ubNRMxAMzVOJaqJeHlxcuSY9oiPbuBQhpI=;
 b=Rgp6SBQbdZDkqbAPpiOYSSaQYofTyZy2WhyoRXHvJ92EA5EdkgteAwCtT604EEp557HGLL
 XBXcQEtmyajasbZTWj1fgtWFuSxHLwZ9YJbj5AMD3gMXXkMNTD5Q8TVH52J22m+9jrRxdq
 2NZ1DczdUaZmqr0ZZd5aXxh2dQggWc+iw0r6RCo9hJqRAvVzoVUSbaIF1BS7id2ijorZ0m
 QWyxWfixZIQuYpEilDPG0r/lZJ+tAXRsVWyAyFU+v1QK7QNwLnPLCwAGLZILeXnz1GPACM
 mDf7v7PAMWGLrNeMmo9fWwgr4CURB+u3z0JzTfih9POFjSE9PdAIku3soIyfyA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=lTYM+kEC;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761582798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZArRjOdz7ubNRMxAMzVOJaqJeHlxcuSY9oiPbuBQhpI=;
 b=lTYM+kECsSQS2geXCyXMDCgjDvfgc39aiy7U4EjdzQdeDAY+4fSLLV9JbbvxNIoEsY8fxk
 T7QYXYbGKtwiAjyMqZ/V7RgB0u7ujIO5Dm6FTf+b4Dn406iVRpdaOQL6tX4YV/ojZ3sMdE
 akuZlHZ9A8IswIplcmVck9DPteNCMdsEV35ezCJQE0PK7Vg57GC6ZiHVOoNQF8EPKEh8Nq
 YsQj+pvT+wWeJzYTIYqqBmLG0Gkjh9yZFoPpIQbL3va+KcAQVAAqsrqDh2qqJAhVS4rVxV
 MiCMQRUqZSZ2Ezb3hYQVfYgn9gkKBu461yaw0d4kYN8W29tiuXvtDb2Xmq4q+g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] clk: renesas: Introduce temporary compound clock for SCP
 compatibility
Date: Mon, 27 Oct 2025 17:33:07 +0100
Message-ID: <20251027163315.11032-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 17c4f2a41020f197d97
X-MBO-RS-META: ud5bx1jrymj95sbk1eqyrhtdh96t43pw
X-Rspamd-Queue-Id: 4cwJwK02N3z9stX
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

The current state of SCP on Renesas R-Car Gen5 is not yet final and
is still missing full clock control, the clock control is exposed as
separate enable/disable and rate controls.

Temporarily introduce custom local compound clock, which are used as
an adaptation layer between U-Boot clock tree and current state of
SCP, and which bind two SCP clock into a single compound clock, which
provides both enable/disable and rate controls.

This is mainly meant to be used by SD/eMMC controller, to allow the
driver to both turn its clock on and off, and also obtain the current
clock rate. This is going to be removed once the SCP clock protocol
solidifies.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/clk/renesas/Makefile         |  4 ++
 drivers/clk/renesas/compound-clock.c | 92 ++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+)
 create mode 100644 drivers/clk/renesas/compound-clock.c

diff --git a/drivers/clk/renesas/Makefile b/drivers/clk/renesas/Makefile
index 6c742553091..354035baf2d 100644
--- a/drivers/clk/renesas/Makefile
+++ b/drivers/clk/renesas/Makefile
@@ -26,3 +26,7 @@ obj-$(CONFIG_CLK_R8A779H0) += r8a779h0-cpg-mssr.o
 obj-$(CONFIG_CLK_R9A06G032) += r9a06g032-clocks.o
 obj-$(CONFIG_CLK_RZG2L) += rzg2l-cpg.o
 obj-$(CONFIG_CLK_R9A07G044) += r9a07g044-cpg.o
+
+# Temporary stub clock used for SCP compatibility.
+# This is going to be removed once SCP solidifies.
+obj-$(CONFIG_R8A78000) += compound-clock.o
diff --git a/drivers/clk/renesas/compound-clock.c b/drivers/clk/renesas/compound-clock.c
new file mode 100644
index 00000000000..499a2598833
--- /dev/null
+++ b/drivers/clk/renesas/compound-clock.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2025 Marek Vasut <marek.vasut+renesas@mailbox.org>
+ */
+
+#define LOG_CATEGORY UCLASS_CLK
+
+#include <clk-uclass.h>
+#include <dm.h>
+#include <dm/device-internal.h>
+#include <linux/clk-provider.h>
+#include <log.h>
+
+struct clk_compound_rate {
+	struct clk clk;		/* This clock */
+	struct clk mdlc;	/* MDLC parent module clock */
+	struct clk per;		/* Peripheral parent clock */
+};
+
+static struct clk_compound_rate *to_clk_compound_rate(struct clk *clk)
+{
+	return (struct clk_compound_rate *)dev_get_plat(clk->dev);
+}
+
+static int clk_compound_rate_enable(struct clk *clk)
+{
+	struct clk_compound_rate *cc = to_clk_compound_rate(clk);
+
+	return clk_enable(&cc->mdlc);
+}
+
+static int clk_compound_rate_disable(struct clk *clk)
+{
+	struct clk_compound_rate *cc = to_clk_compound_rate(clk);
+
+	return clk_disable(&cc->mdlc);
+}
+
+static ulong clk_compound_rate_get_rate(struct clk *clk)
+{
+	struct clk_compound_rate *cc = to_clk_compound_rate(clk);
+
+	return clk_get_rate(&cc->per);
+}
+
+static ulong clk_compound_rate_set_rate(struct clk *clk, ulong rate)
+{
+	return 0;	/* Set rate is not forwarded to SCP */
+}
+
+const struct clk_ops clk_compound_rate_ops = {
+	.enable		= clk_compound_rate_enable,
+	.disable	= clk_compound_rate_disable,
+	.get_rate	= clk_compound_rate_get_rate,
+	.set_rate	= clk_compound_rate_set_rate,
+};
+
+static int clk_compound_rate_of_to_plat(struct udevice *dev)
+{
+	struct clk_compound_rate *cc = (struct clk_compound_rate *)dev_get_plat(dev);
+	struct clk *clk = &cc->clk;
+	int ret;
+
+	clk->dev = dev;
+	clk->id = CLK_ID(dev, 0);
+	clk->enable_count = 0;
+
+	ret = clk_get_by_index(dev, 0, &cc->mdlc);
+	if (ret)
+		return ret;
+
+	ret = clk_get_by_index(dev, 1, &cc->per);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct udevice_id clk_compound_rate_match[] = {
+	{ .compatible = "renesas,compound-clock", },
+	{ /* sentinel */ }
+};
+
+U_BOOT_DRIVER(renesas_compound_clock) = {
+	.name = "compound-clock",
+	.id = UCLASS_CLK,
+	.of_match = clk_compound_rate_match,
+	.of_to_plat = clk_compound_rate_of_to_plat,
+	.plat_auto	= sizeof(struct clk_compound_rate),
+	.ops = &clk_compound_rate_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
-- 
2.51.0

