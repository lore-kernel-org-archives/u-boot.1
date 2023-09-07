Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF26EE14D4
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 09:22:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EB1F86564;
	Thu,  7 Sep 2023 11:22:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FzBGi0bN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8EF886569; Thu,  7 Sep 2023 11:22:09 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44385863ED
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 11:22:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3879M25J104743;
 Thu, 7 Sep 2023 04:22:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694078522;
 bh=HDIruSG6SZ7kzZp7ERvGa8ZRT6uPxnAGwiClIxnw5Fg=;
 h=From:To:CC:Subject:Date;
 b=FzBGi0bNhof6si5BqL0f2aMx3J+gk3H0zIX9rMIvcJILsYegNsaxCU44SmzVyYt2I
 uYJX+Ff9n7Shp7sa7alpt00qYQKG2kJgLsmYKJsmZWL6B9bdP0IsUU5/cougk3GOs3
 sYpJ5wkeIC6mzY+0hujDdM40dhvB4WZazEPjOzhM=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3879M1sk027922
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 7 Sep 2023 04:22:01 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Sep 2023 04:22:01 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Sep 2023 04:22:01 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3879LweE079180;
 Thu, 7 Sep 2023 04:21:59 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <jagan@amarulasolutions.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>, Udit Kumar
 <u-kumar1@ti.com>, Apurva Nandan <a-nandan@ti.com>
Subject: [RESEND PATCH] spi: cadence_qspi: Select flash subnode at runtime
Date: Thu, 7 Sep 2023 14:51:43 +0530
Message-ID: <20230907092143.4110817-1-u-kumar1@ti.com>
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
Fig 3.1, Page 18 has details of two flashes connected with one controller.

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

