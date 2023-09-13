Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE96CA0ED1
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 04:40:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C43586EE5;
	Wed, 13 Sep 2023 06:39:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZD5GUbMd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B7EC86EA2; Wed, 13 Sep 2023 06:39:52 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD48F86D31
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 06:39:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38D4djl3045798;
 Tue, 12 Sep 2023 23:39:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694579985;
 bh=KS6j2qK+89xdb3UNkWlq0X/OIbc4TelcYcQUIotrzyU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ZD5GUbMd2koluP2sz4f0h6Kap381UN04Xu9+d9NzUs6sDvGyE6yn4wRTsqabv86EW
 SG609YPJyWCC7hnqxkBkDcJZdLto/iOsBO4B+7KDBdoqtAgRsgMuIS5DzXppfSrWZf
 MgBl0+p5yJ+gwyJ7L8opMEsqa2wSj1MlJP+Q1DoE=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38D4djgW017171
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Sep 2023 23:39:45 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Sep 2023 23:39:45 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Sep 2023 23:39:45 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38D4dZNb028334;
 Tue, 12 Sep 2023 23:39:42 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <jh80.chung@samsung.com>, <lukma@denx.de>, 
 <seanga2@gmail.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <a-nandan@ti.com>, Udit Kumar
 <u-kumar1@ti.com>
Subject: [PATCH v3 2/3] clk: ti: Add support to enable configs conditionally
Date: Wed, 13 Sep 2023 10:09:29 +0530
Message-ID: <20230913043930.1316130-3-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913043930.1316130-1-u-kumar1@ti.com>
References: <20230913043930.1316130-1-u-kumar1@ti.com>
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

TI SOC has two clock domains CLK_TI_SCI and
CLK_K3. These are mutually exclusive.

Adding conditional check for CLK_TI_SCI
and CLK_K3 along with other associated configs options.

Suggested-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
Reviewed-by: Nishanth Menon <nm@ti.com>
---
 drivers/clk/ti/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/ti/Kconfig b/drivers/clk/ti/Kconfig
index fbcdefd889..a21359d6b2 100644
--- a/drivers/clk/ti/Kconfig
+++ b/drivers/clk/ti/Kconfig
@@ -36,7 +36,7 @@ config CLK_TI_MUX
 
 config CLK_TI_SCI
 	bool "TI System Control Interface (TI SCI) clock driver"
-	depends on CLK && TI_SCI_PROTOCOL && OF_CONTROL
+	depends on CLK && TI_SCI_PROTOCOL && OF_CONTROL && !CLK_K3
 	help
 	  This enables the clock driver support over TI System Control Interface
 	  available on some new TI's SoCs. If you wish to use clock resources
@@ -44,13 +44,13 @@ config CLK_TI_SCI
 
 config CLK_K3_PLL
 	bool "PLL clock support for K3 SoC family of devices"
-	depends on CLK && LIB_RATIONAL
+	depends on CLK && LIB_RATIONAL && !CLK_TI_SCI
 	help
 	  Enables PLL clock support for K3 SoC family of devices.
 
 config SPL_CLK_K3_PLL
 	bool "PLL clock support for K3 SoC family of devices"
-	depends on CLK && LIB_RATIONAL && SPL
+	depends on CLK && LIB_RATIONAL && SPL && !CLK_TI_SCI
 	help
 	  Enables PLL clock support for K3 SoC family of devices.
 
@@ -62,6 +62,6 @@ config CLK_K3
 
 config SPL_CLK_K3
 	bool "Clock support for K3 SoC family of devices"
-	depends on CLK && SPL
+	depends on CLK && SPL && !CLK_TI_SCI
 	help
 	  Enables the clock translation layer from DT to device clocks.
-- 
2.34.1

