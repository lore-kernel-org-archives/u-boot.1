Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3F4EE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 11:20:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85B7A86DA2;
	Mon, 11 Sep 2023 13:20:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XL5mmKKa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4582B86DB6; Mon, 11 Sep 2023 13:20:35 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2704C86D92
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 13:20:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38BBKT1j122754;
 Mon, 11 Sep 2023 06:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694431229;
 bh=xfh/Hgwxy5IiG8q2t+ToETC8U9iskrQKGhNQelqOJOE=;
 h=From:To:CC:Subject:Date;
 b=XL5mmKKarMYuFllF3g88338R6oGRZEBePwzwxiGXgIh1WEPgxGfvNg+0lrtPMGj+J
 3Gnd4MJXGpVlmdhRwYtvyCXVLczaIN9I3sXRv5Gn+3BFPW8glvuMzuNlOQKEcBzxSp
 zU5zEOkyJ8MfcXzS4WJUDdVB3e3bn8jAaagO0MTU=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38BBKTZk093083
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 11 Sep 2023 06:20:29 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 06:20:29 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 06:20:29 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38BBKQef018474;
 Mon, 11 Sep 2023 06:20:27 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <a-nandan@ti.com>, Udit Kumar
 <u-kumar1@ti.com>
Subject: [PATCH] config: j7200: removed not needed power config
Date: Mon, 11 Sep 2023 16:49:46 +0530
Message-ID: <20230911111946.749270-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

For J7200, R5/SPL TI_SCI_POWER_DOMAIN should be
disabled as DM is a separate binary like other
SOC of J7* family.

Fixes: 02dff65efe7 (configs: j7200_evm_r5: Add initial support)

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
Boot logs
https://gist.github.com/uditkumarti/04f053efa73eae8be53666d9a31033c2

 configs/j7200_evm_r5_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/j7200_evm_r5_defconfig b/configs/j7200_evm_r5_defconfig
index 6d240b16cb..9e744ba434 100644
--- a/configs/j7200_evm_r5_defconfig
+++ b/configs/j7200_evm_r5_defconfig
@@ -126,7 +126,6 @@ CONFIG_SPL_PINCTRL=y
 # CONFIG_SPL_PINCTRL_GENERIC is not set
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_TI_SCI_POWER_DOMAIN=y
 CONFIG_TI_POWER_DOMAIN=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_TPS65941=y
-- 
2.34.1

