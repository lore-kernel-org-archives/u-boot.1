Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A47CC52D7C
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 06:11:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 855D588969;
	Tue, 13 Aug 2024 08:10:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="t4IKhZ0C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A738088979; Tue, 13 Aug 2024 08:10:53 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AA748890D
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 08:10:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47D6AoF1042740;
 Tue, 13 Aug 2024 01:10:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723529450;
 bh=wf76VHdwtxgvXLZnxlw8/MoEwot8M7F4nQbKh0fwr74=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=t4IKhZ0C44G3QbrFXEVB93echbP6vL788nJdK+Q7EDFCdFcBCC+/CdMeGuD7X9KKa
 +zDtTE23LFIDj5cFtwRqYfRWDLWZUqnN9F3jJhod37YQpcFo/pvEuI9LLVeRPT3uPo
 8LD/hAp49xI3FdDeMTx0sWXehyrJqgeWlrsaEfLo=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47D6AoKp007407
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 13 Aug 2024 01:10:50 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Aug 2024 01:10:49 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Aug 2024 01:10:49 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47D6AgHh016562;
 Tue, 13 Aug 2024 01:10:46 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 13 Aug 2024 11:40:41 +0530
Subject: [PATCH v3 1/7] power: pmic: tps65941: Add DM_PMIC dependency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240813-b4-upstream-j721s2-avs-v3-1-5115d93cdeb2@ti.com>
References: <20240813-b4-upstream-j721s2-avs-v3-0-5115d93cdeb2@ti.com>
In-Reply-To: <20240813-b4-upstream-j721s2-avs-v3-0-5115d93cdeb2@ti.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723529443; l=883;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=PTybQMXiDJX8wf3TtS8++uihnmvJr4kd1kARvff49FU=;
 b=rzC4NEemXC3mvDB831DYmMV9t2eWb8XNPi1R9rS61UrvtMvqCuHMSLYSm93tPsv9Lt3iMm7du
 yu3Ye7LEtQ2DX7PAdkb27nE+JBLHgRKlos5nRgC61iIsG6E5SBv/Yht
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

This Kconfig depends on DM_PMIC but hadn't be explicitly stated which
could cause config related issues.

Adds the dependency in Kconfig for tps65941.

Fixes: 6b86dd0c1ead ("power: pmic: tps65941: Add support for tps65941 family of PMICs")
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 drivers/power/pmic/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/pmic/Kconfig b/drivers/power/pmic/Kconfig
index 562c1a3b122a..bbcbcee4c355 100644
--- a/drivers/power/pmic/Kconfig
+++ b/drivers/power/pmic/Kconfig
@@ -394,6 +394,7 @@ config SPL_PMIC_LP87565
 
 config PMIC_TPS65941
 	bool "Enable driver for Texas Instruments TPS65941 PMIC"
+	depends on DM_PMIC
 	help
 	The TPS65941 is a PMIC containing a bunch of SMPS & LDOs.
 	This driver binds the pmic children.

-- 
2.46.0

