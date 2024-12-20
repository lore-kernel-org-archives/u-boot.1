Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF3CE77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 21:53:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 975EC803B5;
	Fri, 20 Dec 2024 22:53:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AT6D9fwL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60841803DF; Fri, 20 Dec 2024 22:53:56 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2900C803A9
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 22:53:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BKLrlMo519327
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Dec 2024 15:53:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734731627;
 bh=qeq9TPRoRv8Frl8CPRxP64lHXca/z/gNkzquryz0+TQ=;
 h=From:To:CC:Subject:Date;
 b=AT6D9fwLwQd3KF+9EG1MXAh4lZUmTUzlOGAKG73mwT9w6umf/kL13XiSWGwkHcA/7
 7TsrZQyLmr5A+V380nyl308YzQqJCYKnXHGze0kMCno5shvpDI9sXvugv9JDuLXyP5
 9+w+nxA3oWgTP7pEfgtQ5jaCodydUU5tC/xkSjW4=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BKLrlw5013379
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 20 Dec 2024 15:53:47 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 20
 Dec 2024 15:53:47 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 20 Dec 2024 15:53:47 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.79.44])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BKLrlae052552;
 Fri, 20 Dec 2024 15:53:47 -0600
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Roger Quadros
 <rogerq@kernel.org>, Jonathan Humphreys <j-humphreys@ti.com>, Martyn Welch
 <martyn.welch@collabora.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Sjoerd Simons <sjoerd@collabora.com>, Tom Rini <trini@konsulko.com>,
 <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH] configs: am62x_evm_*: Set DFU buffer size to 256k
Date: Fri, 20 Dec 2024 15:53:34 -0600
Message-ID: <20241220215334.372542-1-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
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

OSPI flash writing was broken on am62x SKs as the OSPI flash device has a
256k sector size but was set to 20k. This breaks OSPI flash writes because
the current implementation of the SF DFU backend requires that the DFU data
buffer size be the same as the sector erase size, and the USB DFU config
fragment (for both A53 and R5) reduced the size of the DFU data buffer,
presumably so that it can fit into SPL's much smaller heap.

Change the SYS_DFU_DATA_BUF_SIZE to the erase sector size, which still fits
within the post-relocation heap size in SPL.

Fixes: dfc2dff5a844 ("configs: am62x_evm_*: Enable USB and DFU support")

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 configs/am62x_a53_usbdfu.config | 2 +-
 configs/am62x_r5_usbdfu.config  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/am62x_a53_usbdfu.config b/configs/am62x_a53_usbdfu.config
index 0d3c6df1e73..812f99ee70b 100644
--- a/configs/am62x_a53_usbdfu.config
+++ b/configs/am62x_a53_usbdfu.config
@@ -10,7 +10,7 @@ CONFIG_SYSCON=y
 CONFIG_SPL_SYSCON=y
 CONFIG_DFU_MMC=y
 CONFIG_DFU_RAM=y
-CONFIG_SYS_DFU_DATA_BUF_SIZE=0x5000
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x40000
 CONFIG_SYS_DFU_MAX_FILE_SIZE=0x800000
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
diff --git a/configs/am62x_r5_usbdfu.config b/configs/am62x_r5_usbdfu.config
index 772bb2ab935..efaae504c1a 100644
--- a/configs/am62x_r5_usbdfu.config
+++ b/configs/am62x_r5_usbdfu.config
@@ -1,7 +1,7 @@
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SYSCON=y
 CONFIG_SPL_SYSCON=y
-CONFIG_SYS_DFU_DATA_BUF_SIZE=0x5000
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x40000
 CONFIG_MISC=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
-- 
2.34.1

