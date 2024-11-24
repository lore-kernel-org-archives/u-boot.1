Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42E0E668A0
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 07:09:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC21988E96;
	Sun, 24 Nov 2024 08:08:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TwPkUDgf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95BF28760C; Sun, 24 Nov 2024 08:08:51 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75C0889507
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 08:08:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AO78gDP008854;
 Sun, 24 Nov 2024 01:08:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732432123;
 bh=M1/J5YunQRzaYemaJ09qGasQOSykZU/ML4dJkqVJkGc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=TwPkUDgfYRCHsBNvSVml/NJou34Tk6Aywnk/V9sUm2AFjd2riO/aoheqz5lQIOis+
 H4hbIXu/xywIsAmyhEH0pw7Dzqf6ltDVL+ncJY92gqqSBnpml9POQoCFj1ZO9Lb1hy
 3JwrTh5o5YBqm2m5cggRmG70XEepE5QCSvGSmq/k=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AO78gnj021167
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 24 Nov 2024 01:08:42 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 24
 Nov 2024 01:08:42 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 24 Nov 2024 01:08:42 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AO78Tf6107079;
 Sun, 24 Nov 2024 01:08:38 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <vigneshr@ti.com>, <bb@ti.com>, <trini@konsulko.com>, <j-humphreys@ti.com>,
 <m-chawdhry@ti.com>, <rogerq@kernel.org>, <nm@ti.com>,
 <sjg@chromium.org>, <devarsht@ti.com>, <ilias.apalodimas@linaro.org>,
 <afd@ti.com>, <u-kumar1@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 2/5] board: ti: j721e: evm: Set "dfu_alt_info" only if
 interface is Serial Flash
Date: Sun, 24 Nov 2024 12:37:56 +0530
Message-ID: <20241124070828.617558-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124070828.617558-1-s-vadapalli@ti.com>
References: <20241124070828.617558-1-s-vadapalli@ti.com>
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

Commit 9bd6cc292fa8 ("board: j721e: Define capsule update firmware info")
updated the "dfu_alt_info" variable to support use-cases with Serial Flash.
However, this breaks use-cases where interface is not Serial Flash ("sf").
Fix this by setting "dfu_alt_info" only when the interface is "sf".

Fixes: 9bd6cc292fa8 ("board: j721e: Define capsule update firmware info")
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v1:
https://patchwork.ozlabs.org/project/uboot/patch/20241124051545.382397-3-s-vadapalli@ti.com/
Changes since v1:
- Replaced "SPI Flash" with "Serial Flash" everywhere.

Regards,
Siddharth.

 board/ti/j721e/evm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index 6221be9dcf..ae24964ab9 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -67,7 +67,13 @@ struct efi_capsule_update_info update_info = {
 #if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
 void set_dfu_alt_info(char *interface, char *devstr)
 {
-	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
+	/*
+	 * Since the EFI Capsule support is enabled only for Serial Flash,
+	 * update the "dfu_alt_info" environment variable only if the
+	 * interface happens to be "sf" (Serial Flash).
+	 */
+	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) &&
+	    (strcmp(interface, "sf") == 0))
 		env_set("dfu_alt_info", update_info.dfu_string);
 }
 #endif
-- 
2.43.0

