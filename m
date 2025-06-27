Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C41C7EE2A
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 05:56:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EF5482B34;
	Fri, 27 Jun 2025 07:55:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Zf7HwPbY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47FF882E34; Fri, 27 Jun 2025 07:55:57 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E029A82B34
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 07:55:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55R5tnKA2643593;
 Fri, 27 Jun 2025 00:55:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1751003749;
 bh=NeGl9dn6RJWZ/4CvG7s7tH0oTE6UUV4vFiIk90f1nZw=;
 h=From:To:CC:Subject:Date;
 b=Zf7HwPbYfQoxMsoHGEkWvTm4c/TsrJ6QAVI+p+r7UpO+7JulnyWIBinzg7viNA1HT
 as8EKPIJeiTiQr/Io1cPI4JqOkr5Hu5tzXLlMWWz8MvbpYSRl9xNeppHqUPISd48VV
 RwaKAgdjw1Lq0dM8HLq4swot/y3X08Fz1cfUcT8s=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55R5tngT2685287
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 27 Jun 2025 00:55:49 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 27
 Jun 2025 00:55:49 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 27 Jun 2025 00:55:49 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com [172.24.227.4])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55R5tkIO2293270;
 Fri, 27 Jun 2025 00:55:47 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <rfried.dev@gmail.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>,
 <s-vadapalli@ti.com>
Subject: [PATCH] pci_endpoint: pci_cdns_ti_ep: Fix the include path for header
 file
Date: Fri, 27 Jun 2025 11:25:46 +0530
Message-ID: <20250627055546.3706770-1-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
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

The commit under fixes tag includes "pcie-cadence.h" using angle
brackets. Since the header file is not in standard include path change
it to double quotes to ensure proper inclusion and avoid build issues,
especially on older compilers.

Fixes: a4a0edc6046 ("pci_endpoint: Add TI K3 Cadence PCIe Endpoint Controller driver")
Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
This patch is based on commit
f2220962f9c Merge patch series "sandbox: enable CONFIG_CMD_BOOTEFI_SELFTEST by default"

 drivers/pci_endpoint/pcie_cdns_ti_ep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci_endpoint/pcie_cdns_ti_ep.c b/drivers/pci_endpoint/pcie_cdns_ti_ep.c
index 59c17d0f1e4..661b6ba5b55 100644
--- a/drivers/pci_endpoint/pcie_cdns_ti_ep.c
+++ b/drivers/pci_endpoint/pcie_cdns_ti_ep.c
@@ -19,9 +19,10 @@
 #include <power-domain.h>
 #include <regmap.h>
 #include <syscon.h>
-#include <pcie-cadence.h>
 #include <pci_ep.h>
 
+#include "pcie-cadence.h"
+
 #define PCIE_USER_CMD_STATUS_REG_OFFSET	0x4
 #define LINK_TRAINING_ENABLE			BIT(0)
 
-- 
2.34.1

