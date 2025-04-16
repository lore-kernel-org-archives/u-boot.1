Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29EC2C369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 12:08:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C39082E34;
	Wed, 16 Apr 2025 14:08:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CIdr+ZmM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A78C182E86; Wed, 16 Apr 2025 14:08:46 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97BA182E27
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 14:08:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53GC8cYx307353
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Apr 2025 07:08:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744805319;
 bh=UgbObvk550iH1u5LVLThCiyLrmRkc7irfv3LpwLY66Q=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=CIdr+ZmMDEhh7Xw7Z7+M7Nd3Ehux+RNF0HbLVXB6we4K1dsbBRFwM/OItm/ZDHziP
 hRwOAylIDIXmmfNlrBMpDbKE6S1Bv7Qhk26TwbDO/ANzYSQBlewpkSrwyeXtc0Bu0O
 Oa7w4o7FKezBXA/wcC0gv2ath3ZBtJ78x6eLi92s=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53GC8cFY011091
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Apr 2025 07:08:38 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Apr 2025 07:08:38 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Apr 2025 07:08:38 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com [172.24.227.4])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53GC8Uiv127831;
 Wed, 16 Apr 2025 07:08:35 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <vigneshr@ti.com>, <trini@konsulko.com>, <j-humphreys@ti.com>, <jm@ti.com>,
 <sjg@chromium.org>, <s-k6@ti.com>, <n-francis@ti.com>,
 <rogerq@kernel.org>, <danishanwar@ti.com>, <s-vadapalli@ti.com>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <srk@ti.com>
Subject: [PATCH 1/3] pci: pcie_cdns_ti: Include linux/sizes.h header
Date: Wed, 16 Apr 2025 17:38:28 +0530
Message-ID: <20250416120830.138965-2-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250416120830.138965-1-h-salunke@ti.com>
References: <20250416120830.138965-1-h-salunke@ti.com>
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

Driver uses macro SZ_4G to configure inbound base address register.
The macro is used without including the header file in which it is
defined. Fix this.

Fixes: 59ad5480098 ("pci: Add TI K3 Cadence PCIe Controller")
Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 drivers/pci/pcie_cdns_ti.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pcie_cdns_ti.c b/drivers/pci/pcie_cdns_ti.c
index 41469a186a3..e5bcc6eb53e 100644
--- a/drivers/pci/pcie_cdns_ti.c
+++ b/drivers/pci/pcie_cdns_ti.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/log2.h>
+#include <linux/sizes.h>
 #include <power-domain.h>
 #include <regmap.h>
 #include <syscon.h>
-- 
2.34.1

