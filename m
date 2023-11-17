Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97643C54FB9
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 22:38:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 608B2870D5;
	Fri, 17 Nov 2023 23:38:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="H40WqRlV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B67486F2A; Fri, 17 Nov 2023 23:38:41 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6CAA8708C
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 23:38:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AHMcVGN126618;
 Fri, 17 Nov 2023 16:38:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700260711;
 bh=THBPTh/wDQPAw9j8h0gzZr071U4KdfjByKAuZruHFv8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=H40WqRlVV2vPEdfvIzb5Gslu3Hdu4zOGPzV+BEen1ECouH0Mu1KQQnI4KEw5oGul6
 cs8mK8rhCIUKbwle5SKkaUVH0WjWTzou/XDiRnhq4hAZkdAaOLc1mkAOkvHcQH9ubr
 YZm1K+N2q09kkCrDXM703GOAFBx1ZcIOnD10/vEk=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AHMcVBV052316
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 17 Nov 2023 16:38:31 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 17
 Nov 2023 16:38:31 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 17 Nov 2023 16:38:31 -0600
Received: from lelv0327.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AHMcUtw021675; 
 Fri, 17 Nov 2023 16:38:31 -0600
From: Andrew Davis <afd@ti.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>
CC: Andrew Davis <afd@ti.com>
Subject: [PATCH 2/3] configs: keystone2: Do not include hardware.h
Date: Fri, 17 Nov 2023 16:38:28 -0600
Message-ID: <20231117223829.346652-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231117223829.346652-1-afd@ti.com>
References: <20231117223829.346652-1-afd@ti.com>
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

This is a hacky way to have this file included in all source files that
include common.h, instead just include from the files that need it.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/memory/ti-aemif.c            | 1 +
 drivers/soc/ti/keystone_serdes.c     | 1 +
 include/configs/ti_armv7_keystone2.h | 1 -
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index c4bc88c1510..41325eb0f94 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -7,6 +7,7 @@
  */
 
 #include <common.h>
+#include <asm/arch/hardware.h>
 #include <asm/ti-common/ti-aemif.h>
 
 #define AEMIF_WAITCYCLE_CONFIG		(KS2_AEMIF_CNTRL_BASE + 0x4)
diff --git a/drivers/soc/ti/keystone_serdes.c b/drivers/soc/ti/keystone_serdes.c
index 2ece1a8f647..0e1bf8ff39d 100644
--- a/drivers/soc/ti/keystone_serdes.c
+++ b/drivers/soc/ti/keystone_serdes.c
@@ -8,6 +8,7 @@
 
 #include <errno.h>
 #include <common.h>
+#include <asm/io.h>
 #include <asm/ti-common/keystone_serdes.h>
 #include <linux/bitops.h>
 
diff --git a/include/configs/ti_armv7_keystone2.h b/include/configs/ti_armv7_keystone2.h
index 637e9e4369e..b36207cb5d1 100644
--- a/include/configs/ti_armv7_keystone2.h
+++ b/include/configs/ti_armv7_keystone2.h
@@ -52,7 +52,6 @@
 #include <configs/ti_armv7_common.h>
 
 /* we may include files below only after all above definitions */
-#include <asm/arch/hardware.h>
 #include <asm/arch/clock.h>
 #ifndef CONFIG_SOC_K2G
 #define CFG_SYS_HZ_CLOCK		ks_clk_get_rate(KS2_CLK1_6)
-- 
2.39.2

