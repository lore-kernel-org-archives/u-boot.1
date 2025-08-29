Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60538C8303F
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 05:35:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5394983487;
	Fri, 29 Aug 2025 07:35:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FkKg1oHS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CC42834E1; Fri, 29 Aug 2025 07:35:07 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ED4883443
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 07:35:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57T5Z2Oj2144046;
 Fri, 29 Aug 2025 00:35:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756445702;
 bh=60Ezt/4oLAdsEcIDtz20mdBsalI9FyEeaPfnjNiVyss=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=FkKg1oHSVfSHJGpRyvQt58RjwUxcRRlnVduWNSPB7SxyxVU+sRNvBuFZPe+d+nQIa
 hIhAbyyHe/UyQPuRyrK6KJdbyJWLDJMv1h+RTj0q9w8NlOiNLEevc2pvRUW9kkq7El
 FR1dQQMPHrO4fxNSmDJnjZJEIL/ydhgVrxgyDjp4=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57T5Z2hp315718
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 29 Aug 2025 00:35:02 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 29
 Aug 2025 00:35:02 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 29 Aug 2025 00:35:02 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57T5YqT51836809;
 Fri, 29 Aug 2025 00:34:59 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <hnagalla@ti.com>,
 <n-francis@ti.com>, <jm@ti.com>, <u-kumar1@ti.com>, <b-padhi@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 2/4] arm: dts: am57xx-idk-common-u-boot: Include IPU Early
 Boot changes
Date: Fri, 29 Aug 2025 11:04:49 +0530
Message-ID: <20250829053451.3615976-3-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829053451.3615976-1-b-padhi@ti.com>
References: <20250829053451.3615976-1-b-padhi@ti.com>
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

The dra7-ipu-common-early-boot.dtsi defines the necessary nodes required
for Early Boot of IPUs like memory carveouts, page table carveouts, MMU
configuration and timers. Include this file in
am57xx-idk-common-u-boot.dtsi to enable Early Boot on all AM57XX IDK
devices.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 arch/arm/dts/am57xx-idk-common-u-boot.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/am57xx-idk-common-u-boot.dtsi b/arch/arm/dts/am57xx-idk-common-u-boot.dtsi
index 31faec4afe6..57e4163511e 100644
--- a/arch/arm/dts/am57xx-idk-common-u-boot.dtsi
+++ b/arch/arm/dts/am57xx-idk-common-u-boot.dtsi
@@ -3,6 +3,7 @@
  * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
  */
 #include "omap5-u-boot.dtsi"
+#include "dra7-ipu-common-early-boot.dtsi"
 
 / {
 	xtal25mhz: xtal25mhz {
-- 
2.34.1

