Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405D8E71096
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 17:00:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53F4086898;
	Thu, 21 Sep 2023 19:00:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JbTeKKw8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88B26869F1; Thu, 21 Sep 2023 19:00:54 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34E8E864D4
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 19:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38LH0kT1010372;
 Thu, 21 Sep 2023 12:00:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695315646;
 bh=8Jza0T0eFx5ok1nfeLrfMN9pN6/PYoq26z//cZUmwPo=;
 h=From:To:CC:Subject:Date;
 b=JbTeKKw8BHx5mLG+M4VsJdOubrPO+t5DJnN44z8kNP3anOWVgA2mHq1pBxthyp3Wh
 AAzRXZJy6xubA5ezj08Ukj/jLb1Q6e8R+vXDJDTjnvQRDZBnkX4odfIg4N/L/w14t/
 HzzsfZbntdeJUdL0FnD1nPRTk+wwJmQKBaArUmEo=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38LH0kpj026602
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Sep 2023 12:00:46 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Sep 2023 12:00:46 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Sep 2023 12:00:46 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38LH0hfM039570;
 Thu, 21 Sep 2023 12:00:43 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <seanga2@gmail.com>
CC: <u-boot@lists.denx.de>, <lukma@denx.de>, <bb@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Keerthy <j-keerthy@ti.com>
Subject: [PATCH v4] clk: ti: clk-k3: Notify AVS driver upon setting clock rate
Date: Thu, 21 Sep 2023 22:30:38 +0530
Message-ID: <20230921170038.3213991-1-u-kumar1@ti.com>
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

Cc: Keerthy <j-keerthy@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
Boot logs with v4:
https://gist.github.com/uditkumarti/bab0ec09eadb4b167ec1ab93e08637a8

Change log:
Change in v4:
- changed if condition order as per review feedback
- splitted patch into two
- v3 link
https://lore.kernel.org/all/20230920120256.2901860-1-u-kumar1@ti.com/

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


 drivers/clk/ti/clk-k3.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/ti/clk-k3.c b/drivers/clk/ti/clk-k3.c
index ba925fa3c4..10f7240f77 100644
--- a/drivers/clk/ti/clk-k3.c
+++ b/drivers/clk/ti/clk-k3.c
@@ -11,6 +11,7 @@
 #include <errno.h>
 #include <soc.h>
 #include <clk-uclass.h>
+#include <k3-avs.h>
 #include "k3-clk.h"
 
 #define PLL_MIN_FREQ	800000000
@@ -242,7 +243,11 @@ static ulong ti_clk_set_rate(struct clk *clk, ulong rate)
 	const struct clk_ops *ops;
 	ulong new_rate, rem;
 	ulong diff, new_diff;
+	int freq_scale_up = rate >= ti_clk_get_rate(clk) ? 1 : 0;
 
+	if (IS_ENABLED(CONFIG_K3_AVS0) && freq_scale_up)
+		k3_avs_notify_freq(data->map[clk->id].dev_id,
+				   data->map[clk->id].clk_id, rate);
 	/*
 	 * We must propagate rate change to parent if current clock type
 	 * does not allow setting it.
@@ -339,6 +344,10 @@ static ulong ti_clk_set_rate(struct clk *clk, ulong rate)
 		}
 	}
 
+	if (IS_ENABLED(CONFIG_K3_AVS0) && !freq_scale_up)
+		k3_avs_notify_freq(data->map[clk->id].dev_id,
+				   data->map[clk->id].clk_id, rate);
+
 	return new_rate;
 }
 
-- 
2.34.1

