Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83CFC282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 12:38:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0A0381A04;
	Fri, 14 Mar 2025 13:38:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="s3tu/EDG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1010481A0C; Fri, 14 Mar 2025 13:38:42 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66F318198F
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 13:38:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52ECcba21679210
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Mar 2025 07:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741955917;
 bh=CqD/pltuvGR86goy23vMGrMT2u6GewzSpdCESn45vz8=;
 h=From:To:CC:Subject:Date;
 b=s3tu/EDGHY6BdtpH1HqQZIyDU2npSUuStOcVeVlV/cm62sXtF2NEwaecgsYp6H72a
 1ULgPIbVquOn1voA2SwYFQh8hfKBgRiRbcpT1B3AMjD4+fgFO6a02qg7zsqvVAMnaG
 qHY4jADH0HsuPf0OTpFYPBgeq4uWZWc68I2+UVy4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52ECcbFn024812
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 14 Mar 2025 07:38:37 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Mar 2025 07:38:36 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Mar 2025 07:38:37 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.198])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52ECcXcC039610;
 Fri, 14 Mar 2025 07:38:34 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>
CC: <n-francis@ti.com>, <u-boot@lists.denx.de>, <nm@ti.com>,
 <m-chawdhry@ti.com>, <j-keerthy@ti.com>, <m-shah@ti.com>,
 <a-limaye@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH] configs: am68_sk_r5: Enable AVS config
Date: Fri, 14 Mar 2025 18:08:24 +0530
Message-ID: <20250314123824.2886341-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
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

Enable AVS config

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
Test logs
https://gist.github.com/uditkumarti/9b30461e66aa27e4a813a65f1c552e51#file-gistfile1-txt-L298

Following print was added to see AVS voltage setting at
diff --git a/drivers/misc/k3_avs.c b/drivers/misc/k3_avs.c
index 0774e0a4c9e..ed1a5768147 100644
--- a/drivers/misc/k3_avs.c
+++ b/drivers/misc/k3_avs.c
@@ -142,7 +142,7 @@ static int k3_avs_program_voltage(struct k3_avs_privdata *priv,

                vd2->flags |= VD_FLAG_INIT_DONE;
        }
-
+       printf("Finally setting voltage \n");
        return regulator_set_value(vd->supply, volt);
 }


 configs/am68_sk_r5_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/am68_sk_r5_defconfig b/configs/am68_sk_r5_defconfig
index 097bed62061..d6ef89c7b84 100644
--- a/configs/am68_sk_r5_defconfig
+++ b/configs/am68_sk_r5_defconfig
@@ -6,7 +6,6 @@ CONFIG_SOC_K3_J721S2=y
 CONFIG_TARGET_J721S2_R5_EVM=y
 
 CONFIG_ESM_K3=n
-CONFIG_K3_AVS0=n
 CONFIG_ESM_PMIC=n
 CONFIG_DM_REGULATOR_TPS65941=n
 CONFIG_PMIC_TPS65941=n
-- 
2.34.1

