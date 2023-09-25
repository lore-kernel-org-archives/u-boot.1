Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370BCCE7A89
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 06:23:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 961F486B26;
	Mon, 25 Sep 2023 08:23:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iidVH9DJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F07886B1D; Mon, 25 Sep 2023 08:23:51 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38AC486B10
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 08:23:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38P6NkBF113704;
 Mon, 25 Sep 2023 01:23:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695623026;
 bh=zg3cFsOVh3rCdZPHJAPreHG4dcaJ07Aki2WqLZESR80=;
 h=From:Date:Subject:To:CC;
 b=iidVH9DJ6qdfmLK9hAAavFyEFe9GHuCpVX6PQqU0lHDHVfLDTE8zZL+HJSWigLCH2
 C9/pddRHZ4UcxSFwuLoM4iW6oGMcugFge9HoK55NN/ndSLT38M4w2iWv7uGqu4gaUN
 X/zS39gPF6uErrOiQG7uYE8MAqMXtLt2Ho0JVygw=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38P6NksP110102
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 25 Sep 2023 01:23:46 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Sep 2023 01:23:45 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Sep 2023 01:23:45 -0500
Received: from [127.0.1.1] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38P6NhEo022757;
 Mon, 25 Sep 2023 01:23:43 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Mon, 25 Sep 2023 11:53:42 +0530
Subject: [PATCH v3] env: ti: ti_common.env: Fix get_overlaystring for FIT Image
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230925-b4-upstream-overlaystring-v3-1-47bd6b973cfd@ti.com>
X-B4-Tracking: v=1; b=H4sIAG0nEWUC/33NTQqDMBCG4auUrJuSTPztqvcoXZg46kA1kthQE
 e/eKLR05fL9YJ5ZmEdH6Nn1tDCHgTzZIYY6n5jpqqFFTnVsBgKUKGXKdcJfo58cVj23Ad2zmmP
 R0HIQOUKhC5M2msX70WFD792+P2J35Cfr5v1VkNv6VcsDNUgueWLSDIs6y2SubhNdjO3ZRgb4Y
 0AeMRAZABQ6l6iUSn7Muq4fUs5n/QYBAAA=
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695623023; l=2231;
 i=m-chawdhry@ti.com; s=20230324; h=from:subject:message-id;
 bh=AaB78HGUdSkmx7xq2EwhrQ05GPh7x46AiTtC6txxmr8=;
 b=ca6fwDHpxWM3KWMUeUtECr/Z4Ks2ribqoZgp4ESW8yJxlxmE8lD/ekSxK9gklGCEFiLMlv3LP
 5+x9xbuDGQyCI3wVaZxsng5ZDGuSIZhz+AXCqPjch01ypgxoaXi8oCN
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
Changes in v3:
- Refactor to remove dependency on boot_fit ( Andrew )
- Rename it to get_fit_overlaystring as it is not used anywhere else
- Link to v2: https://lore.kernel.org/r/20230921-b4-upstream-overlaystring-v2-1-22e0b71e3334@ti.com
---
 include/env/ti/ti_common.env | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/env/ti/ti_common.env b/include/env/ti/ti_common.env
index e87a41a6590b..f5d84216e3ce 100644
--- a/include/env/ti/ti_common.env
+++ b/include/env/ti/ti_common.env
@@ -15,10 +15,10 @@ boot_fit=0
 addr_fit=0x90000000
 name_fit=fitImage
 update_to_fit=setenv loadaddr ${addr_fit}; setenv bootfile ${name_fit}
-get_overlaystring=
-	for overlay in $name_overlays;
-	do;
-	setenv overlaystring ${overlaystring}'#'${overlay};
+get_fit_overlaystring=
+	for overlay in $name_overlays; do;
+		setexpr name_fit_overlay gsub / _ conf-${overlay};
+		setenv overlaystring ${overlaystring}'#'${name_fit_overlay};
 	done;
 get_fit_config=setexpr name_fit_config gsub / _ conf-${fdtfile}
 run_fit=run get_fit_config; bootm ${addr_fit}#${name_fit_config}${overlaystring}
@@ -28,7 +28,7 @@ bootcmd_ti_mmc=
 	run main_cpsw0_qsgmii_phyinit; run boot_rprocs;
 #endif
 	if test ${boot_fit} -eq 1;
-		then run get_fit_${boot}; run get_overlaystring; run run_fit;
+		then run get_fit_${boot}; run get_fit_overlaystring; run run_fit;
 	else;
 		run get_kern_${boot}; run get_fdt_${boot}; run get_overlay_${boot}; run run_kern;
 	fi;

---
base-commit: 2fe4b54556ea6271237b35de68dc458bfceab94c
change-id: 20230915-b4-upstream-overlaystring-207e28b8c5fb

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>

