Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722F3C3064D
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 08:23:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47512885A0;
	Fri, 28 Jun 2024 10:23:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uY50WcLY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A59B87F13; Fri, 28 Jun 2024 10:23:50 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2ADA8851E
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 10:23:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45S8NhYI024004;
 Fri, 28 Jun 2024 03:23:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1719563023;
 bh=Q5cBqyCUZxXLZIMxmcG4Uy35uvTURlU2gMCE75GxKPs=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=uY50WcLYh9zYwPRayguNvQx3fNzaycX84xaeYcMNg1fT2s+qBSL4yRlhwBi1qZoJJ
 9tbFdgpu/oBFtM01Z9cmCAtk1+an25t+y6r8kzjWnq6HN7bMsnlT0hXghZThev8bIJ
 AaGlVV1NwkW1t1gHPRwc/jTx7+uIeVWQxEXOEJWg=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45S8NhLg096857
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 28 Jun 2024 03:23:43 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jun 2024 03:23:43 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jun 2024 03:23:43 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45S8NZY2119300;
 Fri, 28 Jun 2024 03:23:40 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Fri, 28 Jun 2024 13:53:28 +0530
Subject: [PATCH 1/3] include: env: ti: mmc: Change name_fdt usage to
 fdtfile
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240628-b4-upstream-streamline-platform-v1-1-17659af992c1@ti.com>
References: <20240628-b4-upstream-streamline-platform-v1-0-17659af992c1@ti.com>
In-Reply-To: <20240628-b4-upstream-streamline-platform-v1-0-17659af992c1@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, Tom
 Rini <trini@konsulko.com>, Vaishnav Achath <vaishnav.a@ti.com>, Jayesh
 Choudhary <j-choudhary@ti.com>, Joe Hershberger <joe.hershberger@ni.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishanth
 Menon <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Dhruva Gole <d-gole@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719563016; l=1146;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=jESB+8d0NLaiGx+wBhysB9lqWBU3x6gWYsDzw7HbM8s=;
 b=5DssePJdrgoKOZ3Mtb/UKLIgUkzOnvWNJ0mOpbXXdLCghPh0VVD40SGa8Y2v3NhMef/Kd9+ui
 iCZ0sS3xkztCrWSUONK4jjomCCLHtEtTPTrKQhMxYXnRIduSdUO3dc+
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

name_fdt is kept for backward compatibility but it depends on EEPROM
detection logic and some of the platforms like J7AHP/AM69 don't have
that anymore which causes boot failure.

Replacing name_fdt usage to fdtfile as fdtfile is populated based on
CONFIG_DEFAULT_DEVICE_TREE.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 include/env/ti/mmc.env | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/env/ti/mmc.env b/include/env/ti/mmc.env
index 0256a2d2aaca..037a09010ce4 100644
--- a/include/env/ti/mmc.env
+++ b/include/env/ti/mmc.env
@@ -16,7 +16,7 @@ importbootenv=echo Importing environment from mmc${mmcdev} ...;
 loadbootenv=fatload mmc ${mmcdev} ${loadaddr} ${bootenvfile}
 loadimage=load ${devtype} ${bootpart} ${loadaddr} ${bootdir}/${bootfile}
 loadfdt=load ${devtype} ${bootpart} ${fdtaddr} ${bootdir}/dtb/${fdtfile}
-get_fdt_mmc=load mmc ${bootpart} ${fdtaddr} ${bootdir}/dtb/${name_fdt}
+get_fdt_mmc=load mmc ${bootpart} ${fdtaddr} ${bootdir}/dtb/${fdtfile}
 envboot=if mmc dev ${mmcdev}; then
 	if mmc rescan; then
 		echo SD/MMC found on device ${mmcdev};

-- 
2.45.1

