Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA45C2BA1A
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 21:14:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D2C7884B5;
	Wed, 19 Jun 2024 23:14:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1AC18848F; Wed, 19 Jun 2024 23:14:02 +0200 (CEST)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3CCC87D83
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 23:14:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139]
 helo=tharvey.pdc.gateworks.com)
 by finn.localdomain with esmtp (Exim 4.95)
 (envelope-from <tharvey@gateworks.com>) id 1sK2cx-00ELRn-FL;
 Wed, 19 Jun 2024 21:13:59 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Fabio Estevam <festevam@gmail.com>,
	u-boot@lists.denx.de
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] imx8m{m,p}_venice: add NVMe to boot devices
Date: Wed, 19 Jun 2024 14:13:58 -0700
Message-Id: <20240619211358.2068366-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add nvme device 0 to available boot devices.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 include/configs/imx8mm_venice.h | 1 +
 include/configs/imx8mp_venice.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/configs/imx8mm_venice.h b/include/configs/imx8mm_venice.h
index 046d5685d04d..66816618b0cb 100644
--- a/include/configs/imx8mm_venice.h
+++ b/include/configs/imx8mm_venice.h
@@ -23,6 +23,7 @@
 	func(MMC, mmc, 2) \
 	func(USB, usb, 0) \
 	func(USB, usb, 1) \
+	func(NVME, nvme, 0) \
 	func(DHCP, dhcp, na)
 #include <config_distro_bootcmd.h>
 #define CFG_EXTRA_ENV_SETTINGS \
diff --git a/include/configs/imx8mp_venice.h b/include/configs/imx8mp_venice.h
index 47413ecd7fbf..81144300885f 100644
--- a/include/configs/imx8mp_venice.h
+++ b/include/configs/imx8mp_venice.h
@@ -17,6 +17,7 @@
 	func(MMC, mmc, 1) \
 	func(MMC, mmc, 2) \
 	func(USB, usb, 0) \
+	func(NVME, nvme, 0) \
 	func(DHCP, dhcp, na)
 #include <config_distro_bootcmd.h>
 #define CFG_EXTRA_ENV_SETTINGS \
-- 
2.25.1

