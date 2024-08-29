Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB50C7EE3A
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 08:35:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D16A88B23;
	Thu, 29 Aug 2024 10:35:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JqcdSYBH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B850C88B59; Thu, 29 Aug 2024 10:35:15 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB627889FF
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 10:35:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47T8ZAe7129572;
 Thu, 29 Aug 2024 03:35:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1724920511;
 bh=4rt1LZFDSdDF3JxtdmV4IlAQMbPFgHZBsrRE0LsMZPg=;
 h=From:To:CC:Subject:Date;
 b=JqcdSYBHCYvfWNWTHSuDL5nIX/IVKdXfFGqqFW9LOefkoXONaqS65n6mLY7OvEJBc
 4XQtAQqi4V3m1/nhIKbntyHmBM7an1dhK3kyjsKw/ZwfwFg0fF1jmWuC6Kn3YGfjFS
 1bOVJTfO7AZVzz2mkGMwpGSMOARsmgOVNA/B4hM8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47T8ZAu5130127
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 29 Aug 2024 03:35:10 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 29
 Aug 2024 03:35:10 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 29 Aug 2024 03:35:10 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.18])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47T8Z7m3044292;
 Thu, 29 Aug 2024 03:35:08 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>
CC: <nm@ti.com>, <u-boot@lists.denx.de>, <n-francis@ti.com>, <bb@ti.com>, Udit
 Kumar <u-kumar1@ti.com>, Andreas Dannenberg <dannenberg@ti.com>
Subject: [PATCH] ram: k3-ddrss: Handle error properly in lpddr4_start
Date: Thu, 29 Aug 2024 14:04:53 +0530
Message-ID: <20240829083453.647044-1-u-kumar1@ti.com>
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

In lpddr4_start function error returned by lpddr4_enablepiinitiator
may go undetected due to overwrite of return code.
Add support to handle error in above case.

Reported-by: Andreas Dannenberg <dannenberg@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 drivers/ram/k3-ddrss/lpddr4.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ram/k3-ddrss/lpddr4.c b/drivers/ram/k3-ddrss/lpddr4.c
index 11ef242a37..9f9abfeca4 100644
--- a/drivers/ram/k3-ddrss/lpddr4.c
+++ b/drivers/ram/k3-ddrss/lpddr4.c
@@ -155,10 +155,11 @@ u32 lpddr4_start(const lpddr4_privatedata *pd)
 	u32 result = 0U;
 
 	result = lpddr4_startsf(pd);
-	if (result == (u32)0) {
+	if (result == (u32)0)
 		result = lpddr4_enablepiinitiator(pd);
+	if (result == (u32)0)
 		result = lpddr4_startsequencecontroller(pd);
-	}
+
 	return result;
 }
 
-- 
2.34.1

