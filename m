Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0140CD6EC05
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 12:46:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3670889409;
	Fri, 29 Nov 2024 13:45:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mmiRtwCK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09B6A891AB; Fri, 29 Nov 2024 12:32:09 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C80D58921B
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 12:32:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4ATBVqX7891922
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 29 Nov 2024 05:31:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732879912;
 bh=UCrLnweZsO5Q8yYDaD5ekiu+JBplj2t4MPuhCurzPXQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=mmiRtwCKRy9F3e//JzTSy0TeUAwW8SfhAtOSW8eQ2Gwm4qVlHcJE/vj6CBrAgP6z9
 1PP5cTGUOmrKltKRKn1F0+iUu0QFva5QW8DXysRqOvEvPWHXgiJVacxsilXpjJRKLQ
 idrx7raCd6Z3MaAIbdxcg0qCaMYFnGGVyEamuTPc=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ATBVqUS040662;
 Fri, 29 Nov 2024 05:31:52 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Nov 2024 05:31:52 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Nov 2024 05:31:51 -0600
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [172.24.227.92])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ATBVabP106135;
 Fri, 29 Nov 2024 05:31:47 -0600
From: Anurag Dutta <a-dutta@ti.com>
To: <trini@konsulko.com>, <a-dutta@ti.com>, <sjg@chromium.org>,
 <marex@denx.de>, <jonas@kwiboo.se>, <kever.yang@rock-chips.com>,
 <william.zhang@broadcom.com>, <a-limaye@ti.com>, <u-kumar1@ti.com>,
 <vaishnav.a@ti.com>, <sumit.garg@linaro.org>,
 <quentin.schulz@cherry.de>, <p-mantena@ti.com>,
 <ilias.apalodimas@linaro.org>, <afd@ti.com>, <nm@ti.com>,
 <avromanov@salutedevices.com>, <michael@amarulasolutions.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 2/8] mtd: HBMC-AM654: Changed syscon API to mux APIs
Date: Fri, 29 Nov 2024 17:01:30 +0530
Message-ID: <20241129113136.383277-3-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241129113136.383277-1-a-dutta@ti.com>
References: <20241129113136.383277-1-a-dutta@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Fri, 29 Nov 2024 13:45:54 +0100
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

The syscon APIs were used for selecting the state of the mux
device because the mmio-mux driver in u-boot did not support
the mux functionality when the parent device is not a syscon.
Change to mux APIs which utilizes the reg-mux driver to select the
state of the multiplexer.

Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 drivers/mtd/hbmc-am654.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/hbmc-am654.c b/drivers/mtd/hbmc-am654.c
index 599beda30d..98988a8e24 100644
--- a/drivers/mtd/hbmc-am654.c
+++ b/drivers/mtd/hbmc-am654.c
@@ -5,8 +5,8 @@
 
 #include <asm/io.h>
 #include <dm.h>
+#include <mux.h>
 #include <regmap.h>
-#include <syscon.h>
 #include <dm/device_compat.h>
 
 #define FSS_SYSC_REG	0x4
@@ -52,9 +52,13 @@ static int am654_hyperbus_calibrate(struct udevice *dev)
 
 static int am654_select_hbmc(struct udevice *dev)
 {
-	struct regmap *regmap = syscon_get_regmap(dev_get_parent(dev));
+	struct mux_control *mux_ctl;
+	int ret;
 
-	return regmap_update_bits(regmap, FSS_SYSC_REG, 0x2, 0x2);
+	ret = mux_get_by_index(dev, 0, &mux_ctl);
+	if (!ret)
+		ret = mux_control_select(mux_ctl, 1);
+	return ret;
 }
 
 static int am654_hbmc_bind(struct udevice *dev)
-- 
2.34.1

