Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFBEC2BD09
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 13:47:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C44187E13;
	Wed,  3 Jul 2024 15:46:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="GencGfDy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7142088784; Wed,  3 Jul 2024 07:42:46 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AFFF88784
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 07:42:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1719985364; x=1722577364;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yU+tB6MuisxVx8CwMi7FQha0maWeVomsSbNmg92hF6A=;
 b=GencGfDyuUmXRiQjQTzxIH4GYd55LSBelRPg2Oalcx/oH+dkxplhSV2MpXqVNZFw
 W8J2xp4VEj9/pqG4PG+DSqEkrzLvo4q7ZO62fV8VQZn9mMfpZffVkOFrEj3iTXVO
 /jAjj/hCEapEiRVK6Zl8WDkNlI6Jdcvg9atiyF3ReVU=;
X-AuditID: ac14000a-03251700000021bc-7b-6684e4d41ca7
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id B7.7D.08636.4D4E4866;
 Wed,  3 Jul 2024 07:42:44 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 3 Jul 2024
 07:42:41 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, <trini@konsulko.com>, 
 <m.othacehe@gmail.com>, <joe.hershberger@ni.com>, <w.egorov@phytec.de>,
 <t.remmet@phytec.de>
CC: <d-gole@ti.com>, <festevam@gmail.com>, <mkorpershoek@baylibre.com>,
 <sjg@chromium.org>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 6/9] include: env: phytec: Add common mmc boot for K3 SoMs
Date: Tue, 2 Jul 2024 22:41:59 -0700
Message-ID: <20240703054202.2812540-7-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240703054202.2812540-1-d.schultz@phytec.de>
References: <20240703054202.2812540-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsWyRpKBR/fKk5Y0g2dtQhYtaz0sHl71t/i0
 8zGrxYyb09gsXhyby27xbcs2RoupkzazW7zd28lu0f1O3YHT4/2NVnaP2Q0XWTx2zrrL7vHq
 wCp2j7N3djB69He3sHpcP7OdyeP4je1MARxRXDYpqTmZZalF+nYJXBkNrddZCy5yVJw9tpOp
 gXEpexcjB4eEgInEsUe1XYxcHEICS5gkrj3sZoRw7jFK/F0zn6mLkZODTUBL4s6WucwgCRGB
 dYwSc69sYgJxmAWaGCUmtlwGqxIW8JJo2tfFBmKzCKhInP4xkQXE5hWwkpi7fAE7iC0hIC8x
 89J3MJtTwFpi8u/nzCBnCAHVLPxjDlEuKHFy5hOwVmag8uats5khbAmJgy9egNlCAgoSs7dN
 ZoQZOe3ca2YIO1Ri65ftTBMYhWYhGTULyahZSEYtYGRexSiUm5mcnVqUma1XkFFZkpqsl5K6
 iREUPyIMXDsY++Z4HGJk4mA8xCjBwawkwiv1vjlNiDclsbIqtSg/vqg0J7X4EKM0B4uSOO/q
 juBUIYH0xJLU7NTUgtQimCwTB6dUA2N8zDIGsZbP/04Hz3+QvkTCx/yWVCXHLl1l562zbvf7
 hM4MOfZLx/tVXOK6FUp621tDd2U4Lq6+/bp3nuWS6Qmhytvytpov37ifgb8r0l72WuV6dasp
 ghUv+VapLtq8nP3dutyXzEu4Vi9Ln+w7lSNnzrOHDDNurrwxzbefV85Ld2v49wUML38psRRn
 JBpqMRcVJwIAg7prAI0CAAA=
X-Mailman-Approved-At: Wed, 03 Jul 2024 15:46:48 +0200
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

This environment include can be used to boot from a
MMC device for PHYTEC's K3-based SoMs.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 include/env/phytec/k3_mmc.env | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 include/env/phytec/k3_mmc.env

diff --git a/include/env/phytec/k3_mmc.env b/include/env/phytec/k3_mmc.env
new file mode 100644
index 00000000000..e1208a6eea1
--- /dev/null
+++ b/include/env/phytec/k3_mmc.env
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2024 PHYTEC Messtechnik GmbH
+ * Author: Daniel Schultz <d.schultz@phytec.de>
+ */
+
+/* Logic for TI K3 based SoCs to boot from a MMC device. */
+
+mmcargs=setenv bootargs console=${console} earlycon=${earlycon}
+	root=/dev/mmcblk${mmcdev}p${mmcroot} rootwait rw
+loadimage=load mmc ${mmcdev}:${mmcpart} ${loadaddr} Image
+loadfdt=load mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
+mmcboot=run mmcargs;
+	mmc dev ${mmcdev};
+	mmc rescan;
+	run loadimage;
+	run loadfdt;
+	booti ${loadaddr} - ${fdt_addr_r}
-- 
2.25.1

