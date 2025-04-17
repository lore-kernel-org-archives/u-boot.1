Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB59C369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 17:11:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51A4282E20;
	Thu, 17 Apr 2025 19:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HKEsBv03";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C139182E37; Thu, 17 Apr 2025 19:11:14 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A64982E08
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 19:11:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2295d78b433so13458395ad.2
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 10:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744909871; x=1745514671; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YrxHfc5Xef1K0ZdHVBln/8vSR4wd0HlwipLysN0sBpg=;
 b=HKEsBv035WUDFrOJTZJkVRiIH4sIswQvWVm8zequgwGf+ADKaWUUsxKqH8N/wVVmsH
 C70M+40w6y46fCkQBwmJi2O3ubZ6kGFSiIncYFcHd/PUZwUwGu16wJfHR4ozu6r8XH9q
 aWNia0ZQD7dDW/3k4CrHYRJovfxbGI+vy2JneZ93QbgJoMYjiMJmRUfmhUqI6q656jI4
 n63TU6rGUkAd87qirgeaXI+QUdSiENKZ6KzPLVFu+OaWn+tSOkGg8pzdi9Hzhu3lKYCk
 YvE7v1GW70rOpoV4BwNPuugWxQ61benwUD2GIAMouUuL9GKnLS4ULYNO3h9F4/57F8Fx
 eYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744909871; x=1745514671;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YrxHfc5Xef1K0ZdHVBln/8vSR4wd0HlwipLysN0sBpg=;
 b=xO1/tQKeiWdhw2ldd4F7pCsHsuzq5ZdgqSl74rh2p05jXpO0CefFuDu3fJJrTzjenZ
 Nd3pZ24+hUMBs+E6bOy/4gOT9qU2jdrKKro+eF7HIV24JR/0qcQwuC69ie8QShMeqijM
 1a8T9tdoa14baYjFxVlI2aFgCKr6kzshjKIzX+Ok+gThfPBdBq2/VjiIrS2ObIOUB01r
 GztyDgxXbAOTmV10sadVbatH9U4GhWJHADP/FPPtEWPfqP6uGHsf8tNMCxzkH4tvYF7M
 PNW4LTHeMlHmNAGl92+MnykEjXDBjaQmcBQWmx/U2/6eKGMhqSBvpsUzo3PEU246YRZk
 0n+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdWoAS7gyobIRc/V2rX849NEfolDXV0xGhjgyTvGZWRwUmhzX8OXSzwcQ8BZnVZNaftpD0Rd4=@lists.denx.de
X-Gm-Message-State: AOJu0YxRfG4AEdMNLSbpEBC+mGH7AZlaVXOsAMY2EY4F3+q2G7tmP7/q
 RK3MHNXxYDbVa03kIQ1z1bs4fML3Hcdu4WT25FJZw0nSrCDBww2i
X-Gm-Gg: ASbGncuNXyF1Nvu3ndAJkBnfgJt8usObQo9Qkod0zCeCa8BTTDNIK3X0Uvbju6n8bmK
 Ch6iA/GBRSx2zHFX3LmWKaP8VHMPAUtUbzC+75OJUc45JESsg96P9ZUHspoyESy4lTNBPhSsYVR
 RcwoXBAepdUHaWhustVYx42NjmxCnN3GbooKY2KaoP5tydqgjj4LIJ36V+VfiCfvTrmAOkEK1Tb
 MrNg2vkhd3lw5isMtMETdcUSPR0K/cq/1Wdv92SQGVqcvUSJ9SBddebucKSChFLpWRZRhEXRGP1
 O3fCArhwGzjLYTrJOke4okxYwNl68pdg+l5c8B/dgz14+3VofeZWhI4=
X-Google-Smtp-Source: AGHT+IHmgHK7A3Oec75tMNEJTxub4Qf5G8jxf5I15Yeev5g4B6/FA+rn0ZChSJVkyq6zLF/jdOmw5Q==
X-Received: by 2002:a17:902:ef44:b0:215:8d49:e2a7 with SMTP id
 d9443c01a7336-22c35990b95mr97851745ad.50.1744909870909; 
 Thu, 17 Apr 2025 10:11:10 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:579d:5312:b7a3:7e17])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bd9bd4sm2580855ad.51.2025.04.17.10.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 10:11:10 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 francesco.dolcini@toradex.com, aford173@gmail.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2] clk: fixed-rate: Use "clock-output-names" to name fixed
 clocks
Date: Thu, 17 Apr 2025 14:11:01 -0300
Message-Id: <20250417171101.2566447-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabio Estevam <festevam@denx.de>

Currently, fixed-rate clocks in U-Boot are named based on their devicetree
node names. For example, given the following node:

osc_24m: clock-osc-24m {
	compatible = "fixed-clock";
	#clock-cells = <0>;
	clock-frequency = <24000000>;
	clock-output-names = "osc_24m";
};

U-Boot registers the clock as "clock-osc-24m", derived from the node name,
ignoring the clock-output-names property.

This differs from Linux, which uses the clock-output-names property when
assigning clock names. As a result, clock consumers expecting names
like "osc_24m" (as defined in the property) may fail to resolve clocks
correctly in U-Boot.

Update the fixed-rate clock driver to check for the clock-output-names
property and use it as the clock name if present. If not, the fallback
remains the node name. This makes U-Boot behavior consistent with Linux.

One concrete impact is on i.MX8MP, where USB clock lookup failed following
commit b4734c9c333b ("clk: imx: Convert clock-osc-* back to osc_*").

With this change applied, fixed-clocks are correctly registered with their
expected names:

u-boot=> clk dump
 Rate               Usecnt      Name
------------------------------------------
 32768                0        |-- osc_32k
 24000000             5        |-- osc_24m

This change restores i.MX8MP USB functionality by ensuring the proper clock
names are used.

Fixes: b4734c9c333b ("clk: imx: Convert clock-osc-* back to osc_*")
Reported-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Fabio Estevam <festevam@denx.de>
Tested-by: Adam Ford <aford173@gmail.com> #imx8mp-beacon
---
Changes since v1:
- Included <dm/read.h> that defines dev_read_string_index() instead
of relying on indirect inclusion via <dm.h>.
- Removed superflous parenthesis around dev_read_string_index().
- Added Adam's Reviewed-by tag.

 drivers/clk/clk_fixed_rate.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/clk/clk_fixed_rate.c b/drivers/clk/clk_fixed_rate.c
index d1da05cc18a5..648e31b4fe14 100644
--- a/drivers/clk/clk_fixed_rate.c
+++ b/drivers/clk/clk_fixed_rate.c
@@ -9,6 +9,7 @@
 #include <dm.h>
 #include <log.h>
 #include <dm/device-internal.h>
+#include <dm/read.h>
 #include <linux/clk-provider.h>
 
 #define UBOOT_DM_CLK_FIXED_RATE "fixed_rate_clock"
@@ -35,6 +36,8 @@ void clk_fixed_rate_ofdata_to_plat_(struct udevice *dev,
 				    struct clk_fixed_rate *plat)
 {
 	struct clk *clk = &plat->clk;
+	const char *clk_name;
+
 	if (CONFIG_IS_ENABLED(OF_REAL))
 		plat->fixed_rate = dev_read_u32_default(dev, "clock-frequency",
 							0);
@@ -45,6 +48,16 @@ void clk_fixed_rate_ofdata_to_plat_(struct udevice *dev,
 
 	clk->dev = dev;
 	clk->enable_count = 0;
+
+	/*
+	 * If the "clock-output-names" property is present, use it
+	 * as the clock name, like it is done in Linux.
+	 * Otherwise, the original behavior will be preserved: the fixed clock
+	 * name will be its node name.
+	 *
+	 */
+	if (!dev_read_string_index(dev, "clock-output-names", 0, &clk_name))
+		dev->name = clk_name;
 }
 
 static ulong clk_fixed_rate_raw_get_rate(struct clk *clk)
-- 
2.34.1

