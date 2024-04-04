Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46010CD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 09:03:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9ECF88427;
	Thu,  4 Apr 2024 11:01:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lPbKRiJt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C095588433; Thu,  4 Apr 2024 11:01:11 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAF6B88427
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 11:01:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43490wh8126710;
 Thu, 4 Apr 2024 04:00:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712221258;
 bh=IzbI94yMBnFO+t3qvWg4RtHBOmcPRtmS9XfOUo+Y/1o=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=lPbKRiJtrWCVhW+IfK9wMLwicAlf2/ok0qKameFXWODp3BLtIn6hQXXGnifGZal+D
 tXrzD3BJwQiKa5WoIA+Y+khQJ3HtU/DI1w/4UV2mv9+T+wYzyrGS5pF21kDlitiHVG
 bNR3/ZKwZ62LYxVXQng5Y4nzznz+16p28X5aMmJI=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43490wtD062238
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 4 Apr 2024 04:00:58 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Apr 2024 04:00:58 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Apr 2024 04:00:58 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com
 [172.24.227.252])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43490vCg058249;
 Thu, 4 Apr 2024 04:00:58 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <jh80.chung@samsung.com>,
 <lukma@denx.de>, <seanga2@gmail.com>, <vaishnav.a@ti.com>,
 <n-francis@ti.com>, <u-kumar1@ti.com>, <j-choudhary@ti.com>,
 <sumit.garg@linaro.org>
CC: <vigneshr@ti.com>, <nm@ti.com>, <afd@ti.com>, <bb@ti.com>,
 <rogerq@kernel.org>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH 12/15] firmware: ti_sci_static_data: Add static DMA channel
Date: Thu, 4 Apr 2024 14:30:36 +0530
Message-ID: <20240404090039.87458-13-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240404090039.87458-1-j-choudhary@ti.com>
References: <20240404090039.87458-1-j-choudhary@ti.com>
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

Include the static DMA channel data for using DMA at SPL stage
for J722S SoC family.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 drivers/firmware/ti_sci_static_data.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci_static_data.h b/drivers/firmware/ti_sci_static_data.h
index 9662bd95f2..3370f80231 100644
--- a/drivers/firmware/ti_sci_static_data.h
+++ b/drivers/firmware/ti_sci_static_data.h
@@ -85,7 +85,7 @@ static struct ti_sci_resource_static_data rm_static_data[] = {
 #endif /* CONFIG_SOC_K3_J721S2 */
 
 #if IS_ENABLED(CONFIG_SOC_K3_AM625) || IS_ENABLED(CONFIG_SOC_K3_AM62A7) || \
-	IS_ENABLED(CONFIG_SOC_K3_AM62P5)
+	IS_ENABLED(CONFIG_SOC_K3_AM62P5) || IS_ENABLED(CONFIG_SOC_K3_J722S)
 static struct ti_sci_resource_static_data rm_static_data[] = {
 	/* BC channels */
 	{
-- 
2.25.1

