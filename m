Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EE7CCD1BC
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 11:46:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71BA48323A;
	Thu, 23 Oct 2025 13:46:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BwoS5/df";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDDC6835FE; Thu, 23 Oct 2025 13:46:17 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF7E782E34
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 13:46:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59NBkDJu523171;
 Thu, 23 Oct 2025 06:46:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761219973;
 bh=sN5BO/Ps1y5YhrsQix3Q4BE9A/RNcUomHsu0ZfTXN3o=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=BwoS5/dfMSrfXk6w3ESz2zkAaHZuS5KAfBD2mJFE/hZzV3P8eXQ4RqTZ5u32ynlxY
 xj/7g/TwN/1xQTAvYA+s2pIJLdp7S/L4r4irUKdhTD4qqXT4nX7qzer31y7obZy9Y+
 iGWCTfds/tUVnvX3DmBrF26xDDhtAViol1jAYzeM=
Received: from DLEE204.ent.ti.com (dlee204.ent.ti.com [157.170.170.84])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59NBkDsT2369039
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 23 Oct 2025 06:46:13 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Oct
 2025 06:46:12 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 23 Oct 2025 06:46:12 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com
 [172.24.231.157])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59NBk5hp2786743;
 Thu, 23 Oct 2025 06:46:09 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <a-nandan@ti.com>, <trini@konsulko.com>, <rfried.dev@gmail.com>,
 <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>,
 <u-kumar1@ti.com>, <s-vadapalli@ti.com>, <semen.protsenko@linaro.org>,
 <jm@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH 1/4] pci_endpoint: pci_cdns_ti_ep: Add delay after power
 domain reset
Date: Thu, 23 Oct 2025 17:16:01 +0530
Message-ID: <20251023114604.3655625-2-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023114604.3655625-1-h-salunke@ti.com>
References: <20251023114604.3655625-1-h-salunke@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Add a 1ms delay after powering on the PCIe power domain to ensure
the controller stabilizes before subsequent operations. This prevents
potential timing issues during PCIe endpoint initialization.

The delay allows sufficient time for the power domain to fully come
up and the hardware to be in a stable state before configuration
begins.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 drivers/pci_endpoint/pcie_cdns_ti_ep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci_endpoint/pcie_cdns_ti_ep.c b/drivers/pci_endpoint/pcie_cdns_ti_ep.c
index 661b6ba5b55..541616ab7d0 100644
--- a/drivers/pci_endpoint/pcie_cdns_ti_ep.c
+++ b/drivers/pci_endpoint/pcie_cdns_ti_ep.c
@@ -20,6 +20,7 @@
 #include <regmap.h>
 #include <syscon.h>
 #include <pci_ep.h>
+#include <linux/delay.h>
 
 #include "pcie-cadence.h"
 
@@ -90,7 +91,7 @@ static int pcie_cdns_reset(struct udevice *dev, struct power_domain *pci_pwrdmn)
 		dev_err(dev, "failed to power on: %d\n", ret);
 		return ret;
 	}
-
+	mdelay(1);
 	return 0;
 }
 
-- 
2.34.1

