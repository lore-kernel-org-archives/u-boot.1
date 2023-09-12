Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE81CA0ECA
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 13:07:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25DEF8619A;
	Tue, 12 Sep 2023 15:07:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GZtQk/gy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 284D686F63; Tue, 12 Sep 2023 15:07:48 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F8B886983
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 15:07:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38CD7gCf053189;
 Tue, 12 Sep 2023 08:07:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694524062;
 bh=iPAr60OCzyMPy88qi2PEQwlEHBVdJGbGLwS5Wt4yK18=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=GZtQk/gy3aMGFEdHiAyse9/eNA+09D62j9uCBn2abWetcaRQPKyR1TcCckAXbCFKH
 9F5KUtHZnT1pRQ2CFRzcaNszgO9s0GTCu9jqArxL2fWF8TaBXqOradLe4icesV4Yv6
 E3bMnaC5s6VF11NktsnISdsPUmgVPErjPqn0dEjo=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38CD7gnB090063
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Sep 2023 08:07:42 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Sep 2023 08:07:40 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Sep 2023 08:07:40 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38CD7L8F084808;
 Tue, 12 Sep 2023 08:07:38 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <jh80.chung@samsung.com>, <lukma@denx.de>, 
 <seanga2@gmail.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <a-nandan@ti.com>, Udit Kumar
 <u-kumar1@ti.com>
Subject: [PATCH v2 1/3] power: domain: ti: Enable single config for power
 domain
Date: Tue, 12 Sep 2023 18:36:44 +0530
Message-ID: <20230912130645.1202325-2-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912130645.1202325-1-u-kumar1@ti.com>
References: <20230912130645.1202325-1-u-kumar1@ti.com>
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

TI SOC has two power domain TI_SCI_POWER_DOMAIN and
TI_POWER_DOMAIN. These are mutually exclusive.
So adding rule to select one, in case defconfig enabled both.

Suggested-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 drivers/power/domain/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
index 411c210756..30c358fb88 100644
--- a/drivers/power/domain/Kconfig
+++ b/drivers/power/domain/Kconfig
@@ -92,7 +92,7 @@ config TEGRA186_POWER_DOMAIN
 
 config TI_SCI_POWER_DOMAIN
 	bool "Enable the TI SCI-based power domain driver"
-	depends on POWER_DOMAIN && TI_SCI_PROTOCOL
+	depends on POWER_DOMAIN && TI_SCI_PROTOCOL && !TI_POWER_DOMAIN
 	help
 	  Generic power domain implementation for TI devices implementing the
 	  TI SCI protocol.
-- 
2.34.1

