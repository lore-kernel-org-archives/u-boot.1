Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00236CF9C7E
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 15:14:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0790488B79;
	Wed, 25 Sep 2024 17:14:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gc/o7s+6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5794B88BB6; Wed, 25 Sep 2024 17:14:14 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FAD688B5F
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 17:14:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48PFDxX6067041;
 Wed, 25 Sep 2024 10:13:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1727277239;
 bh=N2LNhVopaydg+IzU0fAmR8NGpVJOZn1BXPRpulKoUvU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=gc/o7s+692ZVsidRr9fOV/ya96NQlwalu55D2NzFr8frbR2s97bP9rhIjabQ5nqJW
 YVZcVuR8bWdu5XOyVTkQI/s7FMfnFyxGZIn6aZ8P9iouOCIaV8PGzRh2Fsmn2MTySu
 DwUm1axexcKLaO1zvprpPWq2BsXYpbf7myQx1UG8=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48PFDxZB112003;
 Wed, 25 Sep 2024 10:13:59 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 25
 Sep 2024 10:13:58 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 25 Sep 2024 10:13:58 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48PFDwp3001429;
 Wed, 25 Sep 2024 10:13:58 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <bb@ti.com>
CC: <sjg@chromium.org>, <agust@denx.de>, <praneeth@ti.com>, <nm@ti.com>,
 <vigneshr@ti.com>, <s-jain1@ti.com>, <r-donadkar@ti.com>,
 <j-humphreys@ti.com>, <ilias.apalodimas@linaro.org>,
 <xypron.glpk@gmx.de>, <akashi.tkhro@gmail.com>,
 <mkorpershoek@baylibre.com>, <eajames@linux.ibm.com>,
 <caleb.connolly@linaro.org>, <quentin.schulz@cherry.de>,
 <martinstolpe@gmail.com>, <iivanov@suse.de>, <n-jain1@ti.com>,
 <devarsht@ti.com>
Subject: [PATCH 2/3] boot: fdt_simplefb: Remove conditional compilation checks
 for VIDEO Kconfig
Date: Wed, 25 Sep 2024 20:43:53 +0530
Message-ID: <20240925151354.480704-3-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240925151354.480704-1-devarsht@ti.com>
References: <20240925151354.480704-1-devarsht@ti.com>
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

CONFIG_VIDEO conditional compilation checks are no longer needed since
FDT_SIMPLEFB Kconfig now depends on VIDEO Kconfig.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 boot/fdt_simplefb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/boot/fdt_simplefb.c b/boot/fdt_simplefb.c
index 53415548459a..fbb67f281a04 100644
--- a/boot/fdt_simplefb.c
+++ b/boot/fdt_simplefb.c
@@ -103,7 +103,6 @@ static int fdt_simplefb_enable_existing_node(void *blob)
 	return fdt_simplefb_configure_node(blob, off);
 }
 
-#if IS_ENABLED(CONFIG_VIDEO)
 int fdt_simplefb_enable_and_mem_rsv(void *blob)
 {
 	int ret;
@@ -118,4 +117,3 @@ int fdt_simplefb_enable_and_mem_rsv(void *blob)
 
 	return fdt_add_fb_mem_rsv(blob);
 }
-#endif
-- 
2.39.1

