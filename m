Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E27C48BF5
	for <u-boot@archiver.kernel.org>; Fri, 16 Feb 2024 23:18:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B93CC87E0F;
	Sat, 17 Feb 2024 00:18:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="evSOB5Kv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C5FC87E16; Sat, 17 Feb 2024 00:18:19 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D97F987E0F
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 00:18:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B534F40A15
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 23:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1708125492;
 bh=98oHK2ITfedIUgZ5tTVnFUSK/Ou5EE1tCYMra4puHSY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=evSOB5KvsqO110aSEU6MbUwwaX9ohTlGqpyQNwyFK5MnIYc+rUEfNorRGO+FNJUP2
 0F7aClgKPAeFl1glkZJLOG7qm+ofvtUi3lREckz4/zhkf/m9Rd8mexpAp4A+cU27jT
 Qs9rHzE/iPtbq7KocF5qTbxu5YlHyUzO2LOJQE/1AYHVp5jDYXh/CrlOg7/rIvKWRT
 K4oskBM9JBSZNhUZDsVTA/L47Kv/vo1N4Q4yl9y1IsGn/11aj1exe3lyw+1oiWRG4F
 bLbjbVe89Kp0VVvcOd/aXNg6OfSAQT8q0I1291bvV+8tnXtJo7QL07+OFSfmT1sW48
 RIpSK0u8IejBA==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-41082621642so13770905e9.1
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 15:18:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708125492; x=1708730292;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=98oHK2ITfedIUgZ5tTVnFUSK/Ou5EE1tCYMra4puHSY=;
 b=n8S+CupV4223G4T7rGptEpMGRByr1+R0U9wwxJt30jtPHvgL4KlNFavMESvt3v7dSu
 l4pF0D85qIly9d80HU8Pq/ANYygX2VtsfflUULIsG1mmLpWlhBm/Yx/CCYQJYRxu4NUU
 k1eMr0Y7yHC6wyRtRloB83t51LarfLQEPjoPhjnNwIM9qatBj5ZNUMsKgYdqzsW0w/o/
 K4D7aqcCABmQYRIZqEls238QJ/iMzP22y8vLwIiVHPyzEQvmQHxg+uy6YsuVFqcbIwo1
 lbsDVs1U8YDyHG+HV5V63GkR3BSpOHu5sxE3gREcDwYFvWa9TADcW9UrLJP59iAlqdYy
 DW3Q==
X-Gm-Message-State: AOJu0Yxr0J1GpKsASLmVxhwOebvTBQa9UakbhwtJv3FdhneVY1tNcGBr
 MZ58HXiBrIig8nbOixcChcKzhzKvP+RIQRL6i9Mn3ADee47OMAM1uNh89nT1Z9UsA5PZpuduTG2
 7VvdjMnJdQhRm/SoXN/SAvRzVLrVGWmlUao8wog4QLZlo+yPMqbLluQ8jYtYX9on+8BI=
X-Received: by 2002:a05:600c:1f8d:b0:410:c5a9:a24a with SMTP id
 je13-20020a05600c1f8d00b00410c5a9a24amr4631887wmb.20.1708125492004; 
 Fri, 16 Feb 2024 15:18:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkWGwx0gZA8s4nbkK3uVcNWzplwJH+DxylS7qzQuuYItNfv9YCxgoK/WYVGcTbfPkFqyS5zg==
X-Received: by 2002:a05:600c:1f8d:b0:410:c5a9:a24a with SMTP id
 je13-20020a05600c1f8d00b00410c5a9a24amr4631874wmb.20.1708125491625; 
 Fri, 16 Feb 2024 15:18:11 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 v16-20020a05600c215000b004104bc8d841sm3501495wml.13.2024.02.16.15.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 15:18:11 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Lukasz Majewski <lukma@denx.de>,
	Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] clk: sifive: avoid declaring static variables in includes
Date: Sat, 17 Feb 2024 00:18:04 +0100
Message-ID: <20240216231804.141470-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The existing code is unnecessarily convoluted:

Arrays __prci_init_clocks_fu[5|7]40  are initialized with data.
In separate includes fu[5|7]40-prci.h the size of the arrays is provided as
constants.

By moving the structures prci_clk_fu[5|7]40 to the respective code modules
we can directly use ARRAY_SIZE() to access the size of the data used for
initialization.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/clk/sifive/fu540-prci.c  |  7 ++++++-
 drivers/clk/sifive/fu540-prci.h  | 22 ----------------------
 drivers/clk/sifive/fu740-prci.c  |  7 ++++++-
 drivers/clk/sifive/fu740-prci.h  | 22 ----------------------
 drivers/clk/sifive/sifive-prci.c |  3 +--
 drivers/clk/sifive/sifive-prci.h |  4 ++++
 6 files changed, 17 insertions(+), 48 deletions(-)
 delete mode 100644 drivers/clk/sifive/fu540-prci.h
 delete mode 100644 drivers/clk/sifive/fu740-prci.h

diff --git a/drivers/clk/sifive/fu540-prci.c b/drivers/clk/sifive/fu540-prci.c
index ceb2c6fab0d..e55a26ab8fd 100644
--- a/drivers/clk/sifive/fu540-prci.c
+++ b/drivers/clk/sifive/fu540-prci.c
@@ -58,7 +58,7 @@ static const struct __prci_clock_ops sifive_fu540_prci_tlclksel_clk_ops = {
 };
 
 /* List of clock controls provided by the PRCI */
-struct __prci_clock __prci_init_clocks_fu540[] = {
+static struct __prci_clock __prci_init_clocks_fu540[] = {
 	[PRCI_CLK_COREPLL] = {
 		.name = "corepll",
 		.parent_name = "hfclk",
@@ -83,3 +83,8 @@ struct __prci_clock __prci_init_clocks_fu540[] = {
 		.ops = &sifive_fu540_prci_tlclksel_clk_ops,
 	},
 };
+
+const struct prci_clk_desc prci_clk_fu540 = {
+	.clks = __prci_init_clocks_fu540,
+	.num_clks = ARRAY_SIZE(__prci_init_clocks_fu540),
+};
diff --git a/drivers/clk/sifive/fu540-prci.h b/drivers/clk/sifive/fu540-prci.h
deleted file mode 100644
index 113301107da..00000000000
--- a/drivers/clk/sifive/fu540-prci.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2020-2021 SiFive, Inc.
- * Zong Li
- * Pragnesh Patel
- */
-
-#ifndef __SIFIVE_CLK_FU540_PRCI_H
-#define __SIFIVE_CLK_FU540_PRCI_H
-
-#include "sifive-prci.h"
-
-#define NUM_CLOCK_FU540	4
-
-extern struct __prci_clock __prci_init_clocks_fu540[NUM_CLOCK_FU540];
-
-static const struct prci_clk_desc prci_clk_fu540 = {
-	.clks = __prci_init_clocks_fu540,
-	.num_clks = ARRAY_SIZE(__prci_init_clocks_fu540),
-};
-
-#endif /* __SIFIVE_CLK_FU540_PRCI_H */
diff --git a/drivers/clk/sifive/fu740-prci.c b/drivers/clk/sifive/fu740-prci.c
index 5edc864e4bd..4274b215d2f 100644
--- a/drivers/clk/sifive/fu740-prci.c
+++ b/drivers/clk/sifive/fu740-prci.c
@@ -102,7 +102,7 @@ static const struct __prci_clock_ops sifive_fu740_prci_pcieaux_clk_ops = {
 };
 
 /* List of clock controls provided by the PRCI */
-struct __prci_clock __prci_init_clocks_fu740[] = {
+static struct __prci_clock __prci_init_clocks_fu740[] = {
 	[FU740_PRCI_CLK_COREPLL] = {
 		.name = "corepll",
 		.parent_name = "hfclk",
@@ -156,3 +156,8 @@ struct __prci_clock __prci_init_clocks_fu740[] = {
 		.pwd = &__prci_pcieaux_data,
 	}
 };
+
+const struct prci_clk_desc prci_clk_fu740 = {
+	.clks = __prci_init_clocks_fu740,
+	.num_clks = ARRAY_SIZE(__prci_init_clocks_fu740),
+};
diff --git a/drivers/clk/sifive/fu740-prci.h b/drivers/clk/sifive/fu740-prci.h
deleted file mode 100644
index b74f0789061..00000000000
--- a/drivers/clk/sifive/fu740-prci.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2020-2021 SiFive, Inc.
- * Zong Li
- * Pragnesh Patel
- */
-
-#ifndef __SIFIVE_CLK_FU740_PRCI_H
-#define __SIFIVE_CLK_FU740_PRCI_H
-
-#include "sifive-prci.h"
-
-#define NUM_CLOCK_FU740		9
-
-extern struct __prci_clock __prci_init_clocks_fu740[NUM_CLOCK_FU740];
-
-static const struct prci_clk_desc prci_clk_fu740 = {
-	.clks = __prci_init_clocks_fu740,
-	.num_clks = ARRAY_SIZE(__prci_init_clocks_fu740),
-};
-
-#endif /* __SIFIVE_CLK_FU740_PRCI_H */
diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
index c8fb6002907..603a176d06a 100644
--- a/drivers/clk/sifive/sifive-prci.c
+++ b/drivers/clk/sifive/sifive-prci.c
@@ -34,8 +34,7 @@
 #include <linux/math64.h>
 #include <dt-bindings/clock/sifive-fu740-prci.h>
 
-#include "fu540-prci.h"
-#include "fu740-prci.h"
+#include "sifive-prci.h"
 
 /*
  * Private functions
diff --git a/drivers/clk/sifive/sifive-prci.h b/drivers/clk/sifive/sifive-prci.h
index 5ce33d61846..b391698081d 100644
--- a/drivers/clk/sifive/sifive-prci.h
+++ b/drivers/clk/sifive/sifive-prci.h
@@ -320,4 +320,8 @@ unsigned long sifive_prci_hfpclkplldiv_recalc_rate(struct __prci_clock *pc,
 
 int sifive_prci_clock_enable(struct __prci_clock *pc, bool enable);
 
+/* Clock driver data */
+extern const struct prci_clk_desc prci_clk_fu540;
+extern const struct prci_clk_desc prci_clk_fu740;
+
 #endif /* __SIFIVE_CLK_SIFIVE_PRCI_H */
-- 
2.43.0

