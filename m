Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34B1E70713
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 10:50:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A623B86530;
	Thu, 21 Sep 2023 12:50:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mYrJkHty";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32044869F4; Thu, 21 Sep 2023 12:50:06 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCC7786199
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 12:50:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38LAnxY2096485;
 Thu, 21 Sep 2023 05:49:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695293399;
 bh=h7oT5zvcPBP53LichrdJKrjxrEWbu35OMt3UomVhd6Y=;
 h=From:Date:Subject:To:CC;
 b=mYrJkHtymv89PyO1L2mFU5GoFVFUfHGqiwnPJFb44fscOWTEuJU+GaztFIYWILODq
 WHOTE2UWArYQ0ClhL8Kb3EVktdqAwfmmbzL8bnNIdZAIfeeri40uLwzZVW7fR2qBd6
 aQb/BTWoUxs0gAYfbC4H1l1zouvdFPmeXkdwAhIs=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38LAnxxn021240
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Sep 2023 05:49:59 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Sep 2023 05:49:59 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Sep 2023 05:49:59 -0500
Received: from [127.0.1.1] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38LAnuJT027021;
 Thu, 21 Sep 2023 05:49:57 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Thu, 21 Sep 2023 16:19:56 +0530
Subject: [PATCH v2] env: ti: ti_common.env: Fix get_overlaystring for FIT Image
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230921-b4-upstream-overlaystring-v2-1-22e0b71e3334@ti.com>
X-B4-Tracking: v=1; b=H4sIANMfDGUC/33NQQqDMBCF4avIrDvFRI3aVe9RXJg46kA1kthQE
 e/eVOi2y+/B/LODJ8fk4Zbs4CiwZztHyEsCZmzngZC7aJCpzNJaFKhzfC1+ddROaAO5Z7tF8Ty
 gTEuSla5M0WuI94ujnt9n+9FEj+xX67bzVRDf9Vet/1SDQIG5KRRVnVKizO4rX42doDmO4wMsF
 A7dvwAAAA==
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695293396; l=1837;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=holXJGRWR9VOCiOQkezwpFZA/2XLHL1c78AwIGQaBCQ=;
 b=wghFF+Wd3Yd1umz8B9LkeFDqnFXwANSsI0N60OiJOE8ei/PjfigsUs4n7CwE0MOe+QprrwBTt
 znOOy43+ynhDesTkj49NubA62EeOFN9trihv367Tky8Mq9zScEfe075
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
Changes in v2:
- Fix tabs
- Link to v1: https://lore.kernel.org/r/20230919-b4-upstream-overlaystring-v1-1-4c56e8d66173@ti.com
---
 include/env/ti/ti_common.env | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/env/ti/ti_common.env b/include/env/ti/ti_common.env
index e87a41a6590b..bc554fe7ca6d 100644
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
+		if test ${boot_fit} -eq 1;
+			then
+				setexpr name_fit_overlay gsub / _ conf-${overlay};
+				setenv overlaystring ${overlaystring}'#'${name_fit_overlay};
+			else
+				setenv overlaystring ${overlaystring}'#'${overlay};
+		fi;
 	done;
 get_fit_config=setexpr name_fit_config gsub / _ conf-${fdtfile}
 run_fit=run get_fit_config; bootm ${addr_fit}#${name_fit_config}${overlaystring}

---
base-commit: 2fe4b54556ea6271237b35de68dc458bfceab94c
change-id: 20230915-b4-upstream-overlaystring-207e28b8c5fb

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

