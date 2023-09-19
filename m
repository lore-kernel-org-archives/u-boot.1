Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD248CD3437
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 04:58:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBAAE86A09;
	Tue, 19 Sep 2023 06:58:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dzx4F04g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2C7086A1D; Tue, 19 Sep 2023 06:58:22 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6802F864F3
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 06:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38J4wHq9032020;
 Mon, 18 Sep 2023 23:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695099497;
 bh=B4xBfwSqjKN+BG6b55kr1mPZD9lEWBxGskH+MDEYJPg=;
 h=From:Date:Subject:To:CC;
 b=dzx4F04gfPBP40hWLoeeQZoF9Iu6fdW/Vtxs/p70sMonAw2BZa3zu6nlNxWIeHAlk
 1YC64bH0+/QNxiqKfm8mCOVebDjDJO+hvBlfzBw8JAkPw7yJsEUFPrP0GJ8rRqaAFa
 QYnz7tU9eswx5Fen0lREEjKxVk9G4ncFdpXn6B8A=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38J4wHsb115286
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 18 Sep 2023 23:58:17 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Sep 2023 23:58:16 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Sep 2023 23:58:16 -0500
Received: from [127.0.1.1] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38J4wEa7009959;
 Mon, 18 Sep 2023 23:58:15 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 19 Sep 2023 10:28:12 +0530
Subject: [PATCH] env: ti: ti_common.env: Fix get_overlaystring for FIT
 Image
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230919-b4-upstream-overlaystring-v1-1-4c56e8d66173@ti.com>
X-B4-Tracking: v=1; b=H4sIAGMqCWUC/x3MTQ5AMBBA4avIrE1SRfxcRSxaBpNQMkWIuLvG8
 lu894AnYfJQRw8Inex5dQFJHEE3GTcSch8MWulUVUmONsNj87uQWXA9SWZzB7EbUauCdGnLLh8
 shH4TGvj63037vh9z5tasawAAAA==
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695099494; l=1725;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=8UwRJmH4BLyVNP8LX/PrQJMRCuY1LqLNFLV3uC2ixps=;
 b=Kn64owNsl7T2UdSD39FOyYW08G4SY845zHgMYg4WBJms1n0en/z527Mih1nt+oK9MWhSS2Xwn
 msN9eu376sUAFg+LF1tT3UIPdnkqmPpiqjU2h7AsbZeknG7zu2DVzmT
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=Z51yAzxWCcDqKRLHiDBrUxIdXbB21R89ms8xgECdiak=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

After the refactor with conf- nodes in fitImage, overlaystring wasn't
didn't handle the new conf- nodes in FIT Booting. Fix get_overlaystring
to handle conf- nodes.

Fixes: 837833a724b7 ("environment: ti: Add get_fit_config command to get FIT config string")
Reported-by: Aniket Limaye <a-limaye@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Test Logs:
=> setenv name_overlays ti/k3-dt.dtbo ti/k3-dt1.dtbo
=> run get_overlaystring
=> printenv overlaystring
overlaystring=#conf-ti_k3-dt.dtbo#conf-ti_k3-dt1.dtbo
---
 include/env/ti/ti_common.env | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/env/ti/ti_common.env b/include/env/ti/ti_common.env
index e87a41a6590b..4d0590912614 100644
--- a/include/env/ti/ti_common.env
+++ b/include/env/ti/ti_common.env
@@ -16,9 +16,14 @@ addr_fit=0x90000000
 name_fit=fitImage
 update_to_fit=setenv loadaddr ${addr_fit}; setenv bootfile ${name_fit}
 get_overlaystring=
-	for overlay in $name_overlays;
-	do;
-	setenv overlaystring ${overlaystring}'#'${overlay};
+	for overlay in $name_overlays; do;
+    if test ${boot_fit} -eq 1;
+      then
+        setexpr name_fit_overlay gsub / _ conf-${overlay};
+        setenv overlaystring ${overlaystring}'#'${name_fit_overlay};
+      else
+        setenv overlaystring ${overlaystring}'#'${overlay};
+    fi;
 	done;
 get_fit_config=setexpr name_fit_config gsub / _ conf-${fdtfile}
 run_fit=run get_fit_config; bootm ${addr_fit}#${name_fit_config}${overlaystring}

---
base-commit: 2fe4b54556ea6271237b35de68dc458bfceab94c
change-id: 20230915-b4-upstream-overlaystring-207e28b8c5fb

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

