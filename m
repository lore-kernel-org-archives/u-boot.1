Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A3F5C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 09:38:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C27D786FB1;
	Thu, 25 Jul 2024 11:38:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aydoi4gJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDC6887919; Thu, 25 Jul 2024 11:38:45 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE8EA86D4C
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 11:38:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46P9cfAT122238;
 Thu, 25 Jul 2024 04:38:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1721900321;
 bh=lQywY5RWqO9wqypphTrXLCgK1H6mFlR6eGWLP4pF5R4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=aydoi4gJSBcyeJg/AQfXpniLUo0TldWJ/HjUsezcVPk9FcabAwwVOgt5yrLBBHPAW
 gVhh1om/Z4KXgm2UGenZRS7BdLa2HaaH4yCmAHC1a6egwvDE0Z/tz4oeL8yvPGbmMo
 YIAf9qtc4yiMQuKptxmIuWjdLsivyVIBVUsLLyMQ=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46P9cfUp021106
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 25 Jul 2024 04:38:41 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Jul 2024 04:38:41 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Jul 2024 04:38:41 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46P9ad8S066876;
 Thu, 25 Jul 2024 04:38:37 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Tom Rini <trini@konsulko.com>, Nishant Menon <nm@ti.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>,
 <c-shilwant@ti.com>, <m-chawdhry@ti.com>, <vigneshr@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>,
 Vibhore Vardhan <vibhore@ti.com>, Vishal Mahaveer <vishalm@ti.com>,
 Sebin Francis <sebin.francis@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, <t.remmet@phytec.de>,
 <mkorpershoek@baylibre.com>, Daniel Schultz <d.schultz@phytec.de>,
 Dhruva Gole <d-gole@ti.com>
Subject: [PATCH V7 1/7] MAINTAINERS: Include the TI docs under ARM TI
Date: Thu, 25 Jul 2024 15:05:41 +0530
Message-ID: <20240725093546.4193107-2-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240725093546.4193107-1-d-gole@ti.com>
References: <20240725093546.4193107-1-d-gole@ti.com>
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

Add entry for the TI boards documentation under ARM TI

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a6e47e8a2179..d9af2aac6251 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -732,6 +732,7 @@ F:	arch/arm/mach-omap2/
 F:	arch/arm/include/asm/arch-omap*/
 F:	arch/arm/include/asm/ti-common/
 F:	board/ti/
+F:	doc/board/ti/
 F:	drivers/dma/ti*
 F:	drivers/dma/ti*/
 F:	drivers/firmware/ti_sci.*
-- 
2.34.1

