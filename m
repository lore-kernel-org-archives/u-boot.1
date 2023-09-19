Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E36CD3437
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 06:08:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DA4486A24;
	Tue, 19 Sep 2023 08:08:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IUL/gsAK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48AD386A2F; Tue, 19 Sep 2023 08:07:59 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44A9086A09
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 08:07:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38J67o1u029834;
 Tue, 19 Sep 2023 01:07:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695103670;
 bh=2Q6ztbztJVh39i7Kv0J9SEGGW+znLdMw4kZXRaP6fd8=;
 h=From:To:CC:Subject:Date;
 b=IUL/gsAKcNl5yFHUs6IkjDflQQ3Yp5qaFyOelWNeS5ZM5Hmx0xJqVqchU6t3Ov0kN
 k2ZZ/iaf8L247jP83xjmsxerZDe1i94K2znBU1lhSjvDzVh53II+rcbSSc5NGw3CWv
 0b7vaKG6pi3tUiXxpmROEWWbW45srORSP1J2yors=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38J67o02026398
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Sep 2023 01:07:50 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Sep 2023 01:07:49 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Sep 2023 01:07:49 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38J67l85067118;
 Tue, 19 Sep 2023 01:07:47 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <seanga2@gmail.com>
CC: <u-boot@lists.denx.de>, <lukma@denx.de>, <bb@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Keerthy <j-keerthy@ti.com>
Subject: [PATCH] clk: ti: Notify AVS driver upon setting clock rate
Date: Tue, 19 Sep 2023 11:36:49 +0530
Message-ID: <20230919060649.2518147-1-u-kumar1@ti.com>
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

AVS is enabled at R5 SPL stage, where clk-k3 is used
instead if clk-sci driver.

clk-k3 driver to notify AVS driver upon setting clock rate
so that voltage is changed accordingly.

Fixes: e0aa873bc7cd ("clk: clk-ti-sci: Notify AVS driver upon setting clock rate")

Cc: Keerthy <j-keerthy@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 drivers/clk/ti/clk-k3.c  | 5 +++++
 drivers/clk/ti/clk-sci.c | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/ti/clk-k3.c b/drivers/clk/ti/clk-k3.c
index ba925fa3c4..8016c3784a 100644
--- a/drivers/clk/ti/clk-k3.c
+++ b/drivers/clk/ti/clk-k3.c
@@ -11,6 +11,7 @@
 #include <errno.h>
 #include <soc.h>
 #include <clk-uclass.h>
+#include <k3-avs.h>
 #include "k3-clk.h"
 
 #define PLL_MIN_FREQ	800000000
@@ -339,6 +340,10 @@ static ulong ti_clk_set_rate(struct clk *clk, ulong rate)
 		}
 	}
 
+	if (IS_ENABLED(CONFIG_K3_AVS0))
+		k3_avs_notify_freq(data->map[clk->id].dev_id,
+				   data->map[clk->id].clk_id, rate);
+
 	return new_rate;
 }
 
diff --git a/drivers/clk/ti/clk-sci.c b/drivers/clk/ti/clk-sci.c
index 74df5a397b..298fa9dc8b 100644
--- a/drivers/clk/ti/clk-sci.c
+++ b/drivers/clk/ti/clk-sci.c
@@ -17,7 +17,6 @@
 #include <dm/device_compat.h>
 #include <linux/err.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
-#include <k3-avs.h>
 
 /**
  * struct ti_sci_clk_data - clock controller information structure
@@ -94,10 +93,6 @@ static ulong ti_sci_clk_set_rate(struct clk *clk, ulong rate)
 
 	debug("%s(clk=%p, rate=%lu)\n", __func__, clk, rate);
 
-#ifdef CONFIG_K3_AVS0
-	k3_avs_notify_freq(clk->id, clk->data, rate);
-#endif
-
 	ret = cops->set_freq(sci, clk->id, clk->data, 0, rate, ULONG_MAX);
 	if (ret) {
 		dev_err(clk->dev, "%s: set_freq failed (%d)\n", __func__, ret);
-- 
2.34.1

