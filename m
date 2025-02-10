Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AE8C0219D
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 11:24:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B133803B5;
	Mon, 10 Feb 2025 12:23:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WTB4diyd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 226F580C6E; Mon, 10 Feb 2025 12:23:43 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD00A80C8F
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 12:23:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51ABNUnP116262
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Feb 2025 05:23:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739186610;
 bh=ukDPIWs76AcnNfAye5METLgVO/PllYlCDSUVbIfIXdA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=WTB4diydjX5Bv8O02gOV+WxrMnYxNkfLPzESX9INbb1N3FsVEjQp9fGD7MaHgztai
 PTww90G/Nw2AvbzM2SpS89Mhs/uzA1R5vM//x8A3hO9M/8jLdk/81u83kvhYbgskci
 oUmswQXvxq3/oMec5l7YRfPke0dIb06xmsPCBEgs=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51ABNUQ9006624
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Feb 2025 05:23:30 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Feb 2025 05:23:29 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Feb 2025 05:23:29 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51ABMdb9047041; 
 Mon, 10 Feb 2025 05:23:23 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <bb@ti.com>, <vaishnav.a@ti.com>, 
 <j-choudhary@ti.com>, <mkorpershoek@baylibre.com>, <rogerq@kernel.org>,
 <hnagalla@ti.com>, <glaroque@baylibre.com>, <nm@ti.com>,
 <n-francis@ti.com>, <m-chawdhry@ti.com>, <jm@ti.com>,
 <devarsht@ti.com>, <sjg@chromium.org>, <afd@ti.com>,
 <j-humphreys@ti.com>, <quentin.schulz@cherry.de>,
 <sjoerd@collabora.com>, <martyn.welch@collabora.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v4 7/7] configs: am62x_a53_usbdfu: enable USB MASS Storage
 command
Date: Mon, 10 Feb 2025 16:52:30 +0530
Message-ID: <20250210112239.2639009-8-s-vadapalli@ti.com>
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

The USB0 instance of USB on AM62 SoC when configured to operate in the
Gadget mode of operation can be used to mount an MMC/SD card on the USB
Host. Hence, enable support for the USB Mass Storage (ums) command.

Since this config fragment corresponds to USB DFU functionality which
configures the USB Controller in Gadget mode of operation, other SoCs
which include this fragment for DFU functionality can make use of the
USB MASS Storage functionality as well.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

This patch has been newly introduced in this series.

Regards,
Siddharth.

 configs/am62x_a53_usbdfu.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am62x_a53_usbdfu.config b/configs/am62x_a53_usbdfu.config
index 0d3c6df1e7..630845d80b 100644
--- a/configs/am62x_a53_usbdfu.config
+++ b/configs/am62x_a53_usbdfu.config
@@ -6,6 +6,7 @@ CONFIG_SPL_USB_GADGET=y
 CONFIG_SPL_DFU=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_SYSCON=y
 CONFIG_SPL_SYSCON=y
 CONFIG_DFU_MMC=y
-- 
2.43.0

