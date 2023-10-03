Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F98E75434
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 08:12:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E66F8746E;
	Tue,  3 Oct 2023 10:11:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CCNnCrAW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06B3E86BE1; Tue,  3 Oct 2023 10:11:06 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0BFE87452
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 10:11:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j-keerthy@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3938B26C011572;
 Tue, 3 Oct 2023 03:11:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696320662;
 bh=5gvurzg9J2WlJrg+M4Bf/ydq7PfU6c6CgJfim2Kp+ec=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=CCNnCrAWysJuM81mXK0x5Oos1DsYfeucMv/OuwEbit+jZxXBMCz2p7W/Be4FDkJdM
 VkeF1ySEAyteQ5ft4q/BPCRmQczFwVbwsbkil4ot8QbQkruAzJQnAfyNVGczvUyDyu
 f/Yqvk1u7XPyIuwuUbSa6Bi9sZoat8u9GSlDr7/w=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3938B2FL125670
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 3 Oct 2023 03:11:02 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Oct 2023 03:11:01 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Oct 2023 03:11:01 -0500
Received: from keerthy.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3938AhEH110453;
 Tue, 3 Oct 2023 03:10:59 -0500
From: Keerthy <j-keerthy@ti.com>
To: <u-boot@lists.denx.de>, <u-kumar1@ti.com>
CC: <j-keerthy@ti.com>, <n-francis@ti.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>
Subject: [PATCH RFC 07/10] configs: j721s2_evm_r5_defconfig: Enable ESM & PMIC
 ESM configs
Date: Tue, 3 Oct 2023 13:40:35 +0530
Message-ID: <20231003081038.24299-8-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231003081038.24299-1-j-keerthy@ti.com>
References: <20231003081038.24299-1-j-keerthy@ti.com>
MIME-Version: 1.0
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

Enable ESM & PMIC ESM configs

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 configs/j721s2_evm_r5_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configs/j721s2_evm_r5_defconfig b/configs/j721s2_evm_r5_defconfig
index 1e66ac23d0..b9ac56f34d 100644
--- a/configs/j721s2_evm_r5_defconfig
+++ b/configs/j721s2_evm_r5_defconfig
@@ -112,6 +112,8 @@ CONFIG_DM_MAILBOX=y
 CONFIG_K3_SEC_PROXY=y
 CONFIG_FS_LOADER=y
 CONFIG_SPL_FS_LOADER=y
+CONFIG_ESM_K3=y
+CONFIG_ESM_PMIC=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_SPL_MMC_HS400_SUPPORT=y
 CONFIG_MMC_SDHCI=y
@@ -142,6 +144,11 @@ CONFIG_PINCTRL_SINGLE=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_TI_POWER_DOMAIN=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_TPS65941=y
+CONFIG_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_TPS65941=y
 CONFIG_REMOTEPROC_TI_K3_ARM64=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_SERIAL=y
-- 
2.17.1

