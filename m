Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27050C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 08:19:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E66987A2F;
	Mon,  8 Jan 2024 09:19:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hdmygPCF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED4BC87A2F; Mon,  8 Jan 2024 09:19:00 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A169D8773E
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 09:18:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4088ItCu012051;
 Mon, 8 Jan 2024 02:18:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704701935;
 bh=zkP9rlGEioJvyq3d87Z7SoDgtnSyUBYsCo2e+GH11Lw=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=hdmygPCFHsBt4o0SmMFGXkJA8/8mhMInjsBalndlrsOXKMiXqd0gS/xOmPE70BhUW
 BJL4bbdztYTBXKdNG6wW6H1LW106AcRXyXLBGIM3MH9D3DDh30+/mPhKBZy3dd/N18
 RE/WEC7RA5X7t8aaN+fhzlApNGEnqHC4tRELWE1I=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4088Itib001342
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 8 Jan 2024 02:18:55 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Jan 2024 02:18:55 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Jan 2024 02:18:55 -0600
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4088IpIg030312;
 Mon, 8 Jan 2024 02:18:54 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Mon, 8 Jan 2024 13:48:48 +0530
Subject: [PATCH 1/2] include: env: ti: ti_common: Fix a missing semicolon
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240108-b4-upstream-fix-semicolon-v1-1-9437b3dc90ea@ti.com>
References: <20240108-b4-upstream-fix-semicolon-v1-0-9437b3dc90ea@ti.com>
In-Reply-To: <20240108-b4-upstream-fix-semicolon-v1-0-9437b3dc90ea@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704701931; l=829;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=9xmlUpUL50kvu1oMSpN9JhhsnLBWL8olAcmjzkcctFE=;
 b=jKr+SrhNkf3nKiD1C9RkyN2rCM3VNrxO55mkvf0xNMYLl08JvTLincIuZ0nhkaf0eIc+D0t0l
 QD+nbrYMZ3xCCS6XW9e1kbZkZOf3uEsV1RdcBvI5uauVXcX4gmg3Xjg
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

Fix a missing semicolon that leads to syntax error while booting j721s2.

    Importing environment from mmc1 ...
    syntax error at 'run'HUSH died!

Fixes: 0d72b0f2f83b ("include: env: ti: ti_common: Run main_cpsw0_qsgmii_phyinit conditionally")

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 include/env/ti/ti_common.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/env/ti/ti_common.env b/include/env/ti/ti_common.env
index f0f89a228767..5473f633aa7d 100644
--- a/include/env/ti/ti_common.env
+++ b/include/env/ti/ti_common.env
@@ -27,7 +27,7 @@ bootcmd_ti_mmc=
 #if CONFIG_CMD_REMOTEPROC
 	if test ${do_main_cpsw0_qsgmii_phyinit} -eq 1;
 		then run main_cpsw0_qsgmii_phyinit;
-	fi
+	fi;
 	run boot_rprocs;
 #endif
 	if test ${boot_fit} -eq 1;

-- 
2.43.0

