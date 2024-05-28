Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF21C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 08:13:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FD6088433;
	Tue, 28 May 2024 10:13:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="E5uzhFFq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6881C87F8D; Tue, 28 May 2024 10:13:12 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4458188441
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 10:13:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44S8D8ZK119419;
 Tue, 28 May 2024 03:13:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716883988;
 bh=5wQHAPIpFpliRhGtZVFwAKaLmOStu+kuRGZCef/jA0M=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=E5uzhFFqsh4PVy3aiQYoqHFMht2TFyRjIEs4Q201jUXNKhpOa2Nl6BWQRfh/DAWJr
 pViPrlrWymEUmHc3yaVCW+DEsrUyTXdUWVkvj/+Ofw3z96utfXOxKxOs1x4jE4qNSN
 3v2tkH47znyEzJXc7B5KgTRpAvDWleiBwhtEKzXo=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44S8D89m119145
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 28 May 2024 03:13:08 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 03:13:08 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 03:13:08 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44S8Cxum066670;
 Tue, 28 May 2024 03:13:04 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 28 May 2024 13:43:00 +0530
Subject: [PATCH v2 1/7] power: pmic: tps65941: Add DM_PMIC dependency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240528-b4-upstream-j721s2-avs-v2-1-df940f2309d0@ti.com>
References: <20240528-b4-upstream-j721s2-avs-v2-0-df940f2309d0@ti.com>
In-Reply-To: <20240528-b4-upstream-j721s2-avs-v2-0-df940f2309d0@ti.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716883980; l=830;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=lH0cyqErapk1tBmUF1kT1uZt8qASNEEuOdtjw/C1mf4=;
 b=Iqhb6vDoIofr4CYn9QZiVTDNE7uwTAZbZuDIzXeShM78Rr/gAoAzwI2J7B3Eb5rlLjCjD/Yvm
 jNq9nLRXaQnCv934hbH5g7pXP4D0d0txHSor9xCZFVXzkoMFT+w4yOw
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
2.43.2

