Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41DAAC28B30
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 10:38:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20E6A8144F;
	Mon, 10 Mar 2025 11:37:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rP1N2BBn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1349E8142D; Mon, 10 Mar 2025 11:37:34 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5C9F81430
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 11:37:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52AAbQHw858108
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Mar 2025 05:37:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741603046;
 bh=i1N6NMKv4uDNhPvOLApok4WODEzBF6iiJN5ZdqFg6D4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=rP1N2BBn3NC3iOi5UGF8zuDpCHBejU8Rn/lGab09WUYqXFKFlADYGg3N/khMPi9qH
 8edK5mY5MAjXH++lGn0x5s8HMRW4QFnNM5tud5fvUCewa/wUiALrFLrln3aczX2GSH
 EbC3vfbxXBTwv4uKXALugx09rdAwhcH7c7D0ZTBY=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52AAbQUP125382
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Mar 2025 05:37:26 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Mar 2025 05:37:26 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Mar 2025 05:37:26 -0500
Received: from psdkl-workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [10.24.72.128])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52AAb6kM072804;
 Mon, 10 Mar 2025 05:37:22 -0500
From: Aniket Limaye <a-limaye@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <hs@denx.de>, <marek.vasut+renesas@mailbox.org>,
 <neil.armstrong@linaro.org>, <caleb.connolly@linaro.org>,
 <virag.david003@gmail.com>, <stefan.agner@toradex.com>,
 <w.egorov@phytec.de>, <j-keerthy@ti.com>, <u-kumar1@ti.com>,
 Aniket Limaye <a-limaye@ti.com>
Subject: [PATCH v2 4/4] drivers: i2c: Kconfig: Add
 CONFIG_SYS_I2C_OMAP24XX_REPEATED_START
Date: Mon, 10 Mar 2025 16:06:47 +0530
Message-ID: <20250310103702.1464782-5-a-limaye@ti.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310103702.1464782-1-a-limaye@ti.com>
References: <20250310103702.1464782-1-a-limaye@ti.com>
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

Add a Kconfig option to disable sending Stop conditions between multiple
i2c_msgs within a single xfer. Enable this config by default for ARCH_K3
platforms.

Signed-off-by: Aniket Limaye <a-limaye@ti.com>
---

v2:
- CONFIG_I2C_REPEATED_START -> CONFIG_SYS_I2C_OMAP24XX_REPEATED_START
- Link to v1: https://lore.kernel.org/u-boot/20250304220546.866602-4-a-limaye@ti.com/

---
 drivers/i2c/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
index cdae6825736..41bac5db5a5 100644
--- a/drivers/i2c/Kconfig
+++ b/drivers/i2c/Kconfig
@@ -503,6 +503,15 @@ config SYS_I2C_OMAP24XX
 	help
 	  Add support for the OMAP2+ I2C driver.
 
+config SYS_I2C_OMAP24XX_REPEATED_START
+	bool "Enable I2C repeated start"
+	depends on SYS_I2C_OMAP24XX
+	default y if ARCH_K3
+	help
+	  Enable support for repeated start. Updates driver defaults to not
+	  send a Stop condition and issue Repeated Start (Sr) for subsequent
+	  i2c msgs.
+
 config SYS_I2C_RCAR_I2C
 	bool "Renesas R-Car I2C driver"
 	depends on (RCAR_GEN2 || RCAR_64) && DM_I2C
-- 
2.48.1

