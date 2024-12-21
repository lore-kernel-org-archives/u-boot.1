Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCEEE77188
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 02:53:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34787804B6;
	Sat, 21 Dec 2024 03:52:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ou/4IcWl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 906D38048D; Sat, 21 Dec 2024 03:52:55 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CD7180423
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 03:52:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BL2qjZd083381;
 Fri, 20 Dec 2024 20:52:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734749565;
 bh=FYO1VPhoub0yYUZ5si3PQayLh8M+shznn43iR4IDyEc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Ou/4IcWlHdc6k0ZB7swoOvUveQRYbe9EJugfqJXqQogqZLGue0DtzzDSuC3axFr6r
 PaoLF1dRSnHjj8/63XV+rPXJ6DTqx8TaqFqjjOixQJMaaSfsJ7iSOCnxz5dd/NN8ZI
 lX4p5/dlk5A5KeCqIX1sJvveKrKelzmTP5QSi9qI=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BL2qjNt082269
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 20 Dec 2024 20:52:45 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 20
 Dec 2024 20:52:45 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 20 Dec 2024 20:52:45 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BL2qTBu084516;
 Fri, 20 Dec 2024 20:52:40 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <vigneshr@ti.com>, <bb@ti.com>, <trini@konsulko.com>, <lukma@denx.de>,
 <n-francis@ti.com>, <mkorpershoek@baylibre.com>, <afd@ti.com>,
 <glaroque@baylibre.com>, <sjoerd@collabora.com>,
 <martyn.welch@collabora.com>, <rasmus.villemoes@prevas.dk>,
 <caleb.connolly@linaro.org>, <j-humphreys@ti.com>, <rogerq@kernel.org>,
 <nm@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 2/3] configs: am62x_r5_usbdfu: extend for AM62Px
Date: Sat, 21 Dec 2024 08:22:22 +0530
Message-ID: <20241221025229.361625-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241221025229.361625-1-s-vadapalli@ti.com>
References: <20241221025229.361625-1-s-vadapalli@ti.com>
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

Disable configs which are not required for USB DFU functionality, in
order to allow reusing this fragment for AM62Px SoC.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---
v2:
https://patchwork.ozlabs.org/project/uboot/patch/20241218124542.3519447-3-s-vadapalli@ti.com/
Changes since v2:
- Collected Reviewed-by tag.

v1:
https://patchwork.ozlabs.org/project/uboot/patch/20241217131658.2920799-4-s-vadapalli@ti.com/
Changes since v1:
- Collected Reviewed-by tag.

 configs/am62x_r5_usbdfu.config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/am62x_r5_usbdfu.config b/configs/am62x_r5_usbdfu.config
index 772bb2ab935..f094ed127e6 100644
--- a/configs/am62x_r5_usbdfu.config
+++ b/configs/am62x_r5_usbdfu.config
@@ -26,3 +26,6 @@ CONFIG_SPL_DFU=y
 # CONFIG_CMD_MMC is not set
 # CONFIG_CMD_FAT is not set
 # CONFIG_MMC_SDHCI is not set
+# CONFIG_SPL_MTD is not set
+# CONFIG_DMA_CHANNELS is not set
+# CONFIG_TI_K3_NAVSS_UDMA is not set
-- 
2.43.0

