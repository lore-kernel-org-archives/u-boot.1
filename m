Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB06C369D5
	for <u-boot@archiver.kernel.org>; Sun, 27 Apr 2025 07:03:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 726DD8210F;
	Sun, 27 Apr 2025 09:03:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fW0/q+MH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3725A8210F; Sun, 27 Apr 2025 09:03:41 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2678B82075
 for <u-boot@lists.denx.de>; Sun, 27 Apr 2025 09:03:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53R73Zc82524956
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 27 Apr 2025 02:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745737415;
 bh=RGzK3R89YEBdI4A6JbcyBIWGE5i4mEFtvHrtIvqG52A=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=fW0/q+MHWI4rr1VDhBTg6W0CZUt7wkZFYb1t+7pXY3wFq4TKOjDlGLNFEmeVg7h/P
 R+WJPhUVG49Z4L2385ClZGkxw+v2e9bT2+sHYWn5mo/OKXy+6qq3Has68DihNMRqx9
 QzJBsKD4C2VDI3Syvptlknt2psATQ03G/W8STCTg=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53R73ZIK038411
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 27 Apr 2025 02:03:35 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 27
 Apr 2025 02:03:35 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 27 Apr 2025 02:03:35 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.198])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53R73OuC011250;
 Sun, 27 Apr 2025 02:03:33 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>, <eballetbo@redhat.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <b-padhi@ti.com>, <n-francis@ti.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>
Subject: [v3 PATCH 3/4] board: ti: j784s4: Initialize the ESM & PMIC ESM
Date: Sun, 27 Apr 2025 12:33:22 +0530
Message-ID: <20250427070323.590449-4-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250427070323.590449-1-u-kumar1@ti.com>
References: <20250427070323.590449-1-u-kumar1@ti.com>
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

From: Keerthy <j-keerthy@ti.com>

Initialize the ESM & PMIC ESM. This allows things like
the watchdog to reset the board when tripped.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 board/ti/j784s4/evm.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
index c6e46b7ee0e..c8d01bf0ca8 100644
--- a/board/ti/j784s4/evm.c
+++ b/board/ti/j784s4/evm.c
@@ -7,6 +7,7 @@
  *
  */
 
+#include <dm.h>
 #include <efi_loader.h>
 #include <init.h>
 #include <spl.h>
@@ -67,4 +68,27 @@ int board_late_init(void)
 
 void spl_board_init(void)
 {
+	struct udevice *dev;
+	int ret;
+
+	if (IS_ENABLED(CONFIG_ESM_K3)) {
+		const char * const esms[] = {"esm@700000", "esm@40800000", "esm@42080000"};
+
+		for (int i = 0; i < ARRAY_SIZE(esms); ++i) {
+			ret = uclass_get_device_by_name(UCLASS_MISC, esms[i],
+							&dev);
+			if (ret) {
+				printf("MISC init for %s failed: %d\n", esms[i], ret);
+				break;
+			}
+		}
+	}
+
+	if (IS_ENABLED(CONFIG_ESM_PMIC) && ret == 0) {
+		ret = uclass_get_device_by_driver(UCLASS_MISC,
+						  DM_DRIVER_GET(pmic_esm),
+						  &dev);
+		if (ret)
+			printf("ESM PMIC init failed: %d\n", ret);
+	}
 }
-- 
2.34.1

