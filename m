Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C386BCD5BC2
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 14:04:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 325B586B2C;
	Tue, 19 Sep 2023 16:04:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uMNOk309";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0CD886B58; Tue, 19 Sep 2023 16:04:24 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F11486ABB
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 16:04:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38JE4IKo034944;
 Tue, 19 Sep 2023 09:04:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695132258;
 bh=FdmOZry1c73zDsS5Wooh4Lht4INAcU3NYjeclIwIJEk=;
 h=From:To:CC:Subject:Date;
 b=uMNOk309jTvywRZJ4COjuNcRI2UCcw4kEm4US6GHNvtNdhXDkC4wRjAyv57UT+LnA
 VIF5Ev3J1iFi9jcVTeocbcuj6H1VSB1JaPJ9JfKUqAGnSJuR6+SKmLYglolJ+qdeck
 TAAHeYfZA0gF+Jp2XJCvUjIFEV9lyS8/hnCWQi18=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38JE4Icf042557
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Sep 2023 09:04:18 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Sep 2023 09:04:18 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Sep 2023 09:04:18 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38JE4FGl018227;
 Tue, 19 Sep 2023 09:04:16 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <seanga2@gmail.com>
CC: <u-boot@lists.denx.de>, <lukma@denx.de>, <bb@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Keerthy <j-keerthy@ti.com>
Subject: [PATCH v2] clk: ti: Notify AVS driver upon setting clock rate
Date: Tue, 19 Sep 2023 19:34:08 +0530
Message-ID: <20230919140408.2608521-1-u-kumar1@ti.com>
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
upon setting clock rate so that voltage is changed accordingly.

Cc: Keerthy <j-keerthy@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
Change log:
Changes in v2:
- Kept clk-sci.c as is because this is used by
AM64 and AM65 platforms
- v1 link
https://lore.kernel.org/all/20230919060649.2518147-1-u-kumar1@ti.com/

 drivers/clk/ti/clk-k3.c | 5 +++++
 1 file changed, 5 insertions(+)

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
 
-- 
2.34.1

