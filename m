Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B641BC369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 17:53:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D7748070C;
	Thu,  1 May 2025 19:53:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rXh9JAC7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E9D58081A; Thu,  1 May 2025 19:53:21 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EFF28059D
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 19:53:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 541HrGIG3669851
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 May 2025 12:53:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746121996;
 bh=EAEFiCeq392/ZhrdC3M6fSL9sBV4082CIAUDSA7Oc+8=;
 h=From:To:CC:Subject:Date;
 b=rXh9JAC7yxggvm2CHUqJxgC2vqRYTMA8twotQW/jkk0AMFjhE6Wogo1IDf2DrzEid
 nBlLooFLcUH5F5jaWQBlnr2HZKgdRa0fLHCcT1JfAzF24C0VyF92cuK6wX/FrbKGsf
 430YvjmI1v3ApJdIwZDJ3JKRakX0QjZ4nhCPCueM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 541HrG0r044988
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 1 May 2025 12:53:16 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 May 2025 12:53:16 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 May 2025 12:53:16 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.198])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 541HrC46017385;
 Thu, 1 May 2025 12:53:13 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <n-francis@ti.com>, <vigneshr@ti.com>, <j-choudhary@ti.com>, 
 <francesco.dolcini@toradex.com>, <vaishnav.a@ti.com>,
 <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH] configs: j722s_evm_r5_defconfig: Enable PMIC config
Date: Thu, 1 May 2025 23:23:08 +0530
Message-ID: <20250501175308.2653413-1-u-kumar1@ti.com>
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

In kernel device tre commit 714d54917147: ("arm64: dts: ti: k3-j722s-evm:
Enable PMIC") adds pmic support.

Above commit of kernel get synched in u-boot by sha ab06a533f08e:("Squashed
'dts/upstream/' changes from 8531b4b4988c..955176a4ff59").

Now, PMIC DT is available in u-boot for J722S EVM,
So enable PMIC in defconfig as well.

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
Bootlogs
https://gist.github.com/uditkumarti/0d4c5577ecbe2f61bfe8690792f3fe57

 configs/j722s_evm_r5_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configs/j722s_evm_r5_defconfig b/configs/j722s_evm_r5_defconfig
index 40db0da9f62..d34a718a00b 100644
--- a/configs/j722s_evm_r5_defconfig
+++ b/configs/j722s_evm_r5_defconfig
@@ -127,3 +127,9 @@ CONFIG_ESM_K3=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_MISC=y
 CONFIG_SPL_LIB_RATIONAL=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_TPS65941=y
+CONFIG_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_TPS65941=y
+CONFIG_SPL_I2C=y
-- 
2.34.1

