Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C8DE77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 13:18:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB5568021A;
	Tue, 17 Dec 2024 14:17:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xqZvdaC5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 421A580243; Tue, 17 Dec 2024 14:17:35 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38F47801CE
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 14:17:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BHDHKwK007647
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 17 Dec 2024 07:17:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734441440;
 bh=CsH1WgM2FLCKzPFzQm0It0S3eGaX+B9xG2Q8A4puZzk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=xqZvdaC5QRMNh1PPG9eW3z9bU+yEFN6JuXoa3roIjbTdB96smbixtZG87Xl3NNn0V
 /sQOKZ0fbwhmNwVBhCDHUa/7u7fr0zT7UTdpWpcvHk3UzhfEiQapzTZWfTyACVK91w
 nbwe9b0ny5v/Uda8Ui2bOJbcTysm6+fjF5EjmZDQ=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BHDHKm6007677;
 Tue, 17 Dec 2024 07:17:20 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 17
 Dec 2024 07:17:19 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 17 Dec 2024 07:17:19 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BHDGxZO085338;
 Tue, 17 Dec 2024 07:17:15 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <vigneshr@ti.com>, <bb@ti.com>, <trini@konsulko.com>, <lukma@denx.de>,
 <n-francis@ti.com>, <mkorpershoek@baylibre.com>, <afd@ti.com>,
 <glaroque@baylibre.com>, <sjoerd@collabora.com>,
 <martyn.welch@collabora.com>, <rasmus.villemoes@prevas.dk>,
 <caleb.connolly@linaro.org>, <j-humphreys@ti.com>, <rogerq@kernel.org>,
 <nm@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 3/4] configs: am62x_r5_usbdfu: extend for AM62Px
Date: Tue, 17 Dec 2024 18:46:31 +0530
Message-ID: <20241217131658.2920799-4-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241217131658.2920799-1-s-vadapalli@ti.com>
References: <20241217131658.2920799-1-s-vadapalli@ti.com>
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
---
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

