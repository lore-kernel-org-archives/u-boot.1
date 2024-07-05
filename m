Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13881C3271E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 04:52:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F15078860C;
	Fri,  5 Jul 2024 06:51:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dvijnYGO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 122268897B; Fri,  5 Jul 2024 06:51:11 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85D7B885F1
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 06:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4654okB2034946;
 Thu, 4 Jul 2024 23:50:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1720155046;
 bh=U9p7paioLzpKEEXCnotCgD99K3zUJdoyo0MId4V9fCg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=dvijnYGOgGHrHwFxBuuKcvpIuYq2frQy2vAMA2awbdkwsZk00g2ZGjjFRtSNkyoY8
 j5dCrY7NjavRfhVdhKoSN+Q4L+g/8AkYgJ8h38REj4icpyrOGqazM7FGJ0xJ0OXq/W
 bdjCDkHML7XjJsD24jk6jZAiUHOyMg+JiyFucd+c=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4654okCP114164
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 4 Jul 2024 23:50:46 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Jul 2024 23:50:46 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Jul 2024 23:50:46 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4654oj57112417;
 Thu, 4 Jul 2024 23:50:46 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Michal Simek <michal.simek@amd.com>, Bryan Brattlof <bb@ti.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>, MD Danish Anwar
 <danishanwar@ti.com>, Udit Kumar <u-kumar1@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>,
 Andreas Dannenberg <dannenberg@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar <devarsht@ti.com>, "Sean
 Anderson" <seanga2@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 "Nikhil M Jain" <n-jain1@ti.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Wadim Egorov <w.egorov@phytec.de>, Chintan
 Vankar <c-vankar@ti.com>, "Sjoerd Simons" <sjoerd@collabora.com>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Dhruva Gole <d-gole@ti.com>, "Simon
 Glass" <sjg@chromium.org>, Roger Quadros <rogerq@kernel.org>, Maxime Ripard
 <mripard@kernel.org>, Nishanth Menon <nm@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <srk@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v3 08/10] configs: am62: Enable configs required for Ethboot
Date: Fri, 5 Jul 2024 10:20:28 +0530
Message-ID: <20240705045030.1141934-9-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240705045030.1141934-1-c-vankar@ti.com>
References: <20240705045030.1141934-1-c-vankar@ti.com>
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

From: Kishon Vijay Abraham I <kishon@ti.com>

Enable config options needed to support Ethernet boot on AM62x SK.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v2:
https://lore.kernel.org/r/20240425120822.2048012-9-c-vankar@ti.com/

Changes from v2 to v3:
- No changes.

 configs/am62x_evm_a53_ethboot_defconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 configs/am62x_evm_a53_ethboot_defconfig

diff --git a/configs/am62x_evm_a53_ethboot_defconfig b/configs/am62x_evm_a53_ethboot_defconfig
new file mode 100644
index 0000000000..1f9ad63571
--- /dev/null
+++ b/configs/am62x_evm_a53_ethboot_defconfig
@@ -0,0 +1,12 @@
+#include <configs/am62x_evm_a53_defconfig>
+
+CONFIG_SPL_STACK_R_ADDR=0x83000000
+CONFIG_SPL_SIZE_LIMIT=0x80000
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_DMA=y
+CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_ETH=y
+CONFIG_SPL_NET=y
+CONFIG_SPL_NET_VCI_STRING="AM62X U-Boot A53 SPL"
+CONFIG_SPL_SYSCON=y
-- 
2.34.1

