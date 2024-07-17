Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5788CC3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 05:13:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8398988A3A;
	Wed, 17 Jul 2024 07:12:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="enr4wnbc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8AEC88A31; Wed, 17 Jul 2024 07:12:06 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C71C288A2F
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 07:12:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1721193124; x=1723785124;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UHUhXDvR3ToEXxANNESbPEnDUGxA+dfYCck/JBYozug=;
 b=enr4wnbc5rbD61DHceGBNrNxL7gNkIn08Mknn8vQjsmXoFV7f6Te6kOJB5YU5PbK
 BhMyTn1tKvLA0aKgu63yhOloTPZJliKfvu/NdLzxha9VX1uObwglDHMC1qOgXwt7
 Zye20Kh/GLXvaLe5UaXRWBHffXOQJW8vTWExuUH2VKU=;
X-AuditID: ac14000a-03e52700000021bc-f3-669752a4d8e8
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 44.8B.08636.4A257966;
 Wed, 17 Jul 2024 07:12:04 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 17 Jul
 2024 07:12:02 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <upstream@lists.phytec.de>
CC: <w.egorov@phytec.de>, <t.remmet@phytec.de>, <d-gole@ti.com>, Daniel
 Schultz <d.schultz@phytec.de>
Subject: [PATCH v2 6/9] include: env: phytec: Add common mmc boot for K3 SoMs
Date: Tue, 16 Jul 2024 22:11:31 -0700
Message-ID: <20240717051134.1538180-7-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240717051134.1538180-1-d.schultz@phytec.de>
References: <20240717051134.1538180-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsWyRpKBR3dJ0PQ0g64z2hYtaz0spk7azG7x
 dm8nu0X3O3UHFo9XB1axe5y9s4PRo7+7hdXj+I3tTAEsUVw2Kak5mWWpRfp2CVwZrRNaWQoa
 OStu7cptYLzA3sXIySEhYCLxYvoaVhBbSGAJk0RrT24XIxeQfZ9RYmr3a7AEm4CWxJ0tc5lB
 bBEBH4mjrZtZuhg5OJgF0iVWrUoDCQsL+EocfnKSFSTMIqAqsaQHrJNXwEri9Z9XUKvkJWZe
 +g5mcwpYSyy+eJsdpFwIqObwg0CIckGJkzOfsIDYzEDlzVtnM0PYEhIHX7xghrhSQWL2tsmM
 MCOnnXvNDGGHSmz9sp1pAqPQLCSjZiEZNQvJqAWMzKsYhXIzk7NTizKz9QoyKktSk/VSUjcx
 goJbhIFrB2PfHI9DjEwcjIcYJTiYlUR4JzBOSxPiTUmsrEotyo8vKs1JLT7EKM3BoiTOu7oj
 OFVIID2xJDU7NbUgtQgmy8TBKdXAyPfRM0OI+Wrtmp9pkqwKcjckPl7deG8R3zMprvNfVpRo
 Jzyzf7B694XsnF/pnFqCdzryM2dPC6z82fLI8o6ty/nLtmvv6H08lX4kXPjclb+VarekLs70
 YKx8LPCi4Orf9kPXZq8UrxJITvhub/XyHvO34vrIXTd8mU84zr2n684eo5S0sGiqhxJLcUai
 oRZzUXEiAOp7Dt5cAgAA
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
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
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

