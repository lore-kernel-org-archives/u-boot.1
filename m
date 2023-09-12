Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE3BBCA0EC3
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 13:07:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79B5C86FA5;
	Tue, 12 Sep 2023 15:07:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="G9cvyzHM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53E0786EE8; Tue, 12 Sep 2023 15:07:55 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26E588609B
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 15:07:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38CD7ldN059171;
 Tue, 12 Sep 2023 08:07:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694524067;
 bh=3SYWStg5IUWTraeJ10swTfyD7jguDTXDvXGRH3OwjKw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=G9cvyzHMp+vZ3Qyoqs/xdZXUeDcvwJ7H5cZCTR7JtR4392r5EaNQ2X7nI3kUWl5xu
 QGn3JMl3BSN7J+tFPZnxIX246rOdMLcrn4iNMoyQtH08gqoqY4b7Bw37JRnrGqntfq
 d2twRnlJ2KhJIKWS+9K+7rNJ3s+ZPTXyw2nrDKUA=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38CD7lV3090092
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Sep 2023 08:07:47 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Sep 2023 08:07:47 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Sep 2023 08:07:47 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38CD7L8G084808;
 Tue, 12 Sep 2023 08:07:44 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <jh80.chung@samsung.com>, <lukma@denx.de>, 
 <seanga2@gmail.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <a-nandan@ti.com>, Udit Kumar
 <u-kumar1@ti.com>
Subject: [PATCH v2 2/3] clk: ti: Add support to enable configs conditionally
Date: Tue, 12 Sep 2023 18:36:45 +0530
Message-ID: <20230912130645.1202325-3-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912130645.1202325-1-u-kumar1@ti.com>
References: <20230912130645.1202325-1-u-kumar1@ti.com>
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

