Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D584C71153
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 04:21:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 134C4864CE;
	Tue, 29 Aug 2023 06:21:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pXK/CMOY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71DED864D7; Tue, 29 Aug 2023 06:21:18 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3904864D2
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 06:21:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37T4LBFo093401;
 Mon, 28 Aug 2023 23:21:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693282871;
 bh=v+xbFYfCcfHSSpUAWcYxPVWcvet0mBWN4QAPN/k7iSw=;
 h=From:To:CC:Subject:Date;
 b=pXK/CMOY8sPXDP38aEXqsbjUuuIiMa99Ii3IfIIMh0xLi9fKkHofdRe/Vx/gvllAl
 EwBl5uvqW9u/IO6XkNzHdBxY6Aao60d1bGwZvYwfVsUTXRGaeYo1YjLPmxcsUy99PI
 BLyLnnYeNaNrSoP3ODuxtXpiYHhJlFZKVFHsnJ8k=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37T4LBKA099517
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 28 Aug 2023 23:21:11 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Aug 2023 23:21:11 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Aug 2023 23:21:10 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37T4L8hq086570;
 Mon, 28 Aug 2023 23:21:09 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <jagan@amarulasolutions.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <vigneshr@ti.com>, Udit Kumar <u-kumar1@ti.com>, Apurva
 Nandan <a-nandan@ti.com>
Subject: [PATCH] spi: cadence_qspi: Select flash subnode at runtime
Date: Tue, 29 Aug 2023 09:51:06 +0530
Message-ID: <20230829042106.1371621-1-u-kumar1@ti.com>
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

Currently spi driver gets flash parameter from first subnode.

Few boards have more than one flash with different parameters
and selection of flash is done by on board switch settings.
In such case, uboot needs to be recompiled with updated
device tree to align with board switch settings.

This patch allows to select flash node at runtime.

Boards those are supporting multiple flashes
needs to implement cadence_qspi_get_subnode function and return correct
flash node.

Cc: Apurva Nandan <a-nandan@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
One of such platform is J721S2 EVM
link https://www.ti.com/lit/pdf/spruj67
Fig 3.1, Page 18 has details of two flashes connected with
one controller.

 drivers/spi/cadence_qspi.c | 7 ++++++-
 drivers/spi/cadence_qspi.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index cc3a54f295..7a02ceed10 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -40,6 +40,11 @@ __weak int cadence_qspi_versal_flash_reset(struct udevice *dev)
 	return 0;
 }
 
+__weak ofnode  cadence_qspi_get_subnode(struct udevice *dev)
+{
+	return dev_read_first_subnode(dev);
+}
+
 static int cadence_spi_write_speed(struct udevice *bus, uint hz)
 {
 	struct cadence_spi_priv *priv = dev_get_priv(bus);
@@ -401,7 +406,7 @@ static int cadence_spi_of_to_plat(struct udevice *bus)
 	plat->is_dma = dev_read_bool(bus, "cdns,is-dma");
 
 	/* All other parameters are embedded in the child node */
-	subnode = dev_read_first_subnode(bus);
+	subnode = cadence_qspi_get_subnode(bus);
 	if (!ofnode_valid(subnode)) {
 		printf("Error: subnode with SPI flash config missing!\n");
 		return -ENODEV;
diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index 1c59d1a9d9..12825f8911 100644
--- a/drivers/spi/cadence_qspi.h
+++ b/drivers/spi/cadence_qspi.h
@@ -304,6 +304,7 @@ int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
 int cadence_qspi_apb_wait_for_dma_cmplt(struct cadence_spi_priv *priv);
 int cadence_qspi_apb_exec_flash_cmd(void *reg_base, unsigned int reg);
 int cadence_qspi_versal_flash_reset(struct udevice *dev);
+ofnode cadence_qspi_get_subnode(struct udevice *dev);
 void cadence_qspi_apb_enable_linear_mode(bool enable);
 
 #endif /* __CADENCE_QSPI_H__ */
-- 
2.34.1

