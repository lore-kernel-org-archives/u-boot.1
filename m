Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4A0CE79D0
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 12:03:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66D7586A94;
	Wed, 20 Sep 2023 14:03:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="k08yk+Uz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15FA586A94; Wed, 20 Sep 2023 14:03:08 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6B8686479
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 14:03:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38KC30sj115990;
 Wed, 20 Sep 2023 07:03:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695211380;
 bh=vN6dI98p3tltgrXHEDZzSdk1LWIANEPIkP2EVqsCWB4=;
 h=From:To:CC:Subject:Date;
 b=k08yk+UzaJdswdcTR03RnrzEI5x2mbzCnDi3gLwUcm8X9ifdv8xrPRZ4T5mySU4zP
 X5mv/VVjyeum2SlMNVwtm3bvOCsoPMUyH4KAf8WsiVfeQkpRD3W+w/FHZ4QFFcPnxy
 z+LUNkkSh1LN+rkst+KNjc2PiWE+euht/FB0Qhjs=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38KC30F1066701
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 20 Sep 2023 07:03:00 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 20
 Sep 2023 07:03:00 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 20 Sep 2023 07:03:00 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38KC2vHQ072673;
 Wed, 20 Sep 2023 07:02:58 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <seanga2@gmail.com>
CC: <u-boot@lists.denx.de>, <lukma@denx.de>, <bb@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Keerthy <j-keerthy@ti.com>
Subject: [PATCH v3] clk: ti: Notify AVS driver upon setting clock rate
Date: Wed, 20 Sep 2023 17:32:56 +0530
Message-ID: <20230920120256.2901860-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

AVS is enabled at R5 SPL stage, on few platforms like J721E
and J7200 clk-k3 is used instead if clk-sci driver.

Add support in clk-k3 driver as well to notify AVS driver
on setting clock rate so that voltage is changed accordingly.

Also add support in clk-sci driver to do AVS notification
before or after clock setting based upon current rate and new clock
rate.

Cc: Keerthy <j-keerthy@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
Boot logs with v3:
https://gist.github.com/uditkumarti/12a753a822c0aec9ca3028648c29dfa8

Change log:
Change in v3:
- Updated AVS notification before/after clock setting based upon
new and current rate
- Added modifed notification in clk-sci driver as well
- v2 link
https://lore.kernel.org/all/20230919140408.2608521-1-u-kumar1@ti.com/

Changes in v2:
- Kept clk-sci.c as is because this is used by
AM64 and AM65 platforms
- v1 link
https://lore.kernel.org/all/20230919060649.2518147-1-u-kumar1@ti.com

 drivers/clk/ti/clk-k3.c  | 11 +++++++++++
 drivers/clk/ti/clk-sci.c | 11 ++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/ti/clk-k3.c b/drivers/clk/ti/clk-k3.c
index ba925fa3c4..e8d8f8adf3 100644
--- a/drivers/clk/ti/clk-k3.c
+++ b/drivers/clk/ti/clk-k3.c
@@ -11,6 +11,7 @@
 #include <errno.h>
 #include <soc.h>
 #include <clk-uclass.h>
+#include <k3-avs.h>
 #include "k3-clk.h"
 
 #define PLL_MIN_FREQ	800000000
@@ -242,7 +243,13 @@ static ulong ti_clk_set_rate(struct clk *clk, ulong rate)
 	const struct clk_ops *ops;
 	ulong new_rate, rem;
 	ulong diff, new_diff;
+	int set_avs_after_clock = 1;
 
+	if (rate >= ti_clk_get_rate(clk) && IS_ENABLED(CONFIG_K3_AVS0)) {
+		k3_avs_notify_freq(data->map[clk->id].dev_id,
+				   data->map[clk->id].clk_id, rate);
+		set_avs_after_clock = 0;
+	}
 	/*
 	 * We must propagate rate change to parent if current clock type
 	 * does not allow setting it.
@@ -339,6 +346,10 @@ static ulong ti_clk_set_rate(struct clk *clk, ulong rate)
 		}
 	}
 
+	if (set_avs_after_clock && IS_ENABLED(CONFIG_K3_AVS0))
+		k3_avs_notify_freq(data->map[clk->id].dev_id,
+				   data->map[clk->id].clk_id, rate);
+
 	return new_rate;
 }
 
diff --git a/drivers/clk/ti/clk-sci.c b/drivers/clk/ti/clk-sci.c
index 74df5a397b..1926843dcc 100644
--- a/drivers/clk/ti/clk-sci.c
+++ b/drivers/clk/ti/clk-sci.c
@@ -91,12 +91,14 @@ static ulong ti_sci_clk_set_rate(struct clk *clk, ulong rate)
 	const struct ti_sci_handle *sci = data->sci;
 	const struct ti_sci_clk_ops *cops = &sci->ops.clk_ops;
 	int ret;
+	u8 set_avs_after_clock = 1;
 
 	debug("%s(clk=%p, rate=%lu)\n", __func__, clk, rate);
 
-#ifdef CONFIG_K3_AVS0
-	k3_avs_notify_freq(clk->id, clk->data, rate);
-#endif
+	if (rate >= ti_sci_clk_get_rate(clk) && IS_ENABLED(CONFIG_K3_AVS0)) {
+		k3_avs_notify_freq(clk->id, clk->data, rate);
+		set_avs_after_clock = 0;
+	}
 
 	ret = cops->set_freq(sci, clk->id, clk->data, 0, rate, ULONG_MAX);
 	if (ret) {
@@ -104,6 +106,9 @@ static ulong ti_sci_clk_set_rate(struct clk *clk, ulong rate)
 		return ret;
 	}
 
+	if (set_avs_after_clock && IS_ENABLED(CONFIG_K3_AVS0))
+		k3_avs_notify_freq(clk->id, clk->data, rate);
+
 	return rate;
 }
 
-- 
2.34.1

