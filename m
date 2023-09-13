Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0861CEEB58F
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 04:40:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A948386D93;
	Wed, 13 Sep 2023 06:39:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="F3qVubr7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84AD786D31; Wed, 13 Sep 2023 06:39:55 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F051286E4E
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 06:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38D4dmOM030031;
 Tue, 12 Sep 2023 23:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694579988;
 bh=gVt5flY4PEPOyc2teDm6dVX9OA+iGKappG16a5II/Cg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=F3qVubr7QFUTssUIqy/6aVaQWp9yEylNMEa6T+xkDWIaqNkjIYAectKJIguiwl6n/
 zElcqvWddXxjA6Tqt87VdHJm2fezDPHZgY4clESNai8Z7QSH/Cz86GcTYLkjN47TFX
 jhrGmQizg/Ch+74w+1o7hC8tXDJEFQs97pKFJR7E=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38D4dmta102913
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Sep 2023 23:39:48 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Sep 2023 23:39:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Sep 2023 23:39:48 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38D4dZNc028334;
 Tue, 12 Sep 2023 23:39:45 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <jh80.chung@samsung.com>, <lukma@denx.de>, 
 <seanga2@gmail.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <a-nandan@ti.com>, Udit Kumar
 <u-kumar1@ti.com>
Subject: [PATCH v3 3/3] config: j7200: remove not needed power config
Date: Wed, 13 Sep 2023 10:09:30 +0530
Message-ID: <20230913043930.1316130-4-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913043930.1316130-1-u-kumar1@ti.com>
References: <20230913043930.1316130-1-u-kumar1@ti.com>
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

Fixes: 02dff65efe70 ("configs: j7200_evm_r5: Add initial support")

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
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

