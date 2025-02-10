Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED19EC0219D
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 11:23:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5721805C2;
	Mon, 10 Feb 2025 12:23:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WxPWP+sl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96536801F5; Mon, 10 Feb 2025 12:23:17 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43C22805C2
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 12:23:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51ABN5qA032330
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 10 Feb 2025 05:23:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739186585;
 bh=sIgcR/j82tiYpXOkTEYQYRzItbk+6atP4sgmT9RDIg4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=WxPWP+sl//Lf6klR+NjJGO7uE+cEYGhuETLU545i1L0EseD9J72CjEqKPKR3dPo5V
 VNrryxTG5jgHZEm/SiHldo2mKppa2Bszo1p8zizzltqtjANsM6DKdPNOEDaR9GiEdG
 egb4J8sEEz9mN1cYkXZmrP65c9bvICgoPfBTQRo0=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51ABN5PY126489;
 Mon, 10 Feb 2025 05:23:05 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Feb 2025 05:23:05 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Feb 2025 05:23:04 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51ABMdb5047041; 
 Mon, 10 Feb 2025 05:22:59 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <bb@ti.com>, <vaishnav.a@ti.com>, 
 <j-choudhary@ti.com>, <mkorpershoek@baylibre.com>, <rogerq@kernel.org>,
 <hnagalla@ti.com>, <glaroque@baylibre.com>, <nm@ti.com>,
 <n-francis@ti.com>, <m-chawdhry@ti.com>, <jm@ti.com>,
 <devarsht@ti.com>, <sjg@chromium.org>, <afd@ti.com>,
 <j-humphreys@ti.com>, <quentin.schulz@cherry.de>,
 <sjoerd@collabora.com>, <martyn.welch@collabora.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v4 3/7] configs: am62x_r5_usbdfu: extend for AM62Px
Date: Mon, 10 Feb 2025 16:52:26 +0530
Message-ID: <20250210112239.2639009-4-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250210112239.2639009-1-s-vadapalli@ti.com>
References: <20250210112239.2639009-1-s-vadapalli@ti.com>
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

v3:
https://patchwork.ozlabs.org/project/uboot/cover/20241221025229.361625-1-s-vadapalli@ti.com/

Changes since v3:
- Collected Reviewed-by tags.

Regards,
Siddharth.

 configs/am62x_r5_usbdfu.config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/am62x_r5_usbdfu.config b/configs/am62x_r5_usbdfu.config
index 772bb2ab93..f094ed127e 100644
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

