Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61543E668A0
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 05:16:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00B98894CB;
	Sun, 24 Nov 2024 06:16:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SCZFLtdJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C32B9894D7; Sun, 24 Nov 2024 06:16:04 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6427E894CA
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 06:16:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AO5FuTT058831;
 Sat, 23 Nov 2024 23:15:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732425356;
 bh=/w5yVjl+t+Jnp/g1xNXs8+WX2YnggB4Os4D77y+jGvg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=SCZFLtdJat2xXN888jEZxPDS6LeBgvodlY2YPAj6/th0757ShxERF5feyB3IVD6v5
 M+yPtFh/cv1UxRfKfxkUgkF019FhGKyAOHnuU74O2oFBia3/hTA0HtK54s7No8hoLG
 PHIKopyUwcrL0hRlyzFJpjSRx8bOA1VStQW9etHs=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AO5FuIW023647
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 23 Nov 2024 23:15:56 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 23
 Nov 2024 23:15:55 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 23 Nov 2024 23:15:55 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AO5FkDo129179;
 Sat, 23 Nov 2024 23:15:51 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <vigneshr@ti.com>, <bb@ti.com>, <trini@konsulko.com>, <j-humphreys@ti.com>,
 <m-chawdhry@ti.com>, <rogerq@kernel.org>, <nm@ti.com>,
 <sjg@chromium.org>, <devarsht@ti.com>, <ilias.apalodimas@linaro.org>,
 <afd@ti.com>, <u-kumar1@ti.com>, <sabiya.d@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 1/5] board: ti: am64x: evm: Set "dfu_alt_info" only if
 interface is SPI Flash
Date: Sun, 24 Nov 2024 10:45:30 +0530
Message-ID: <20241124051545.382397-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124051545.382397-1-s-vadapalli@ti.com>
References: <20241124051545.382397-1-s-vadapalli@ti.com>
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

Commit 5b84d2de5e6c ("board: am64x: Define capsule update firmware info")
updated the "dfu_alt_info" variable to support use-cases with SPI Flash.
However, this breaks use-cases where the interface is not SPI Flash ("sf").
Fix this by setting "dfu_alt_info" only when the interface is "sf".

Fixes: 5b84d2de5e6c ("board: am64x: Define capsule update firmware info")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 board/ti/am64x/evm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/board/ti/am64x/evm.c b/board/ti/am64x/evm.c
index 00b8317d6b..e8132b8aa9 100644
--- a/board/ti/am64x/evm.c
+++ b/board/ti/am64x/evm.c
@@ -56,7 +56,13 @@ struct efi_capsule_update_info update_info = {
 #if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
 void set_dfu_alt_info(char *interface, char *devstr)
 {
-	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
+	/*
+	 * Since the EFI Capsule support is enabled only for SPI Flash,
+	 * update the "dfu_alt_info" environment variable only if the
+	 * interface happens to be "sf" (SPI Flash).
+	 */
+	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) &&
+	    (strcmp(interface, "sf") == 0))
 		env_set("dfu_alt_info", update_info.dfu_string);
 }
 #endif
-- 
2.43.0

