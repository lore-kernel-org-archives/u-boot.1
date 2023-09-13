Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058DBCA0ED1
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 04:40:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12F0F86E54;
	Wed, 13 Sep 2023 06:39:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kLMo+o0A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1363586E4E; Wed, 13 Sep 2023 06:39:49 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C32E86D31
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 06:39:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38D4dgvK033726;
 Tue, 12 Sep 2023 23:39:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694579982;
 bh=whyJEhELj7QjZGq/AR958YllGRocCw7/z1TkwooMiS0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=kLMo+o0AGvrbu6yZTTUwlf7lfdt+XBLYetCJOt3ezr0gVh3wZdsgQ9I5Hy7ReTdbo
 h/lZud1qnD9CewK8cs2qR5573/8CULqHoVKoVezLvbH14Mc20grkzNQ4KBgLAMk2ID
 75t9Wme0suyR7lucCVmSej1kzSznqIb8uFnvdltM=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38D4dgj8017155
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Sep 2023 23:39:42 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Sep 2023 23:39:42 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Sep 2023 23:39:42 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38D4dZNa028334;
 Tue, 12 Sep 2023 23:39:39 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <jh80.chung@samsung.com>, <lukma@denx.de>, 
 <seanga2@gmail.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <a-nandan@ti.com>, Udit Kumar
 <u-kumar1@ti.com>
Subject: [PATCH v3 1/3] power: domain: ti: Enable single config for power
 domain
Date: Wed, 13 Sep 2023 10:09:28 +0530
Message-ID: <20230913043930.1316130-2-u-kumar1@ti.com>
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

TI SOC has two power domain TI_SCI_POWER_DOMAIN and
TI_POWER_DOMAIN. These are mutually exclusive.
So adding rule to select one, in case defconfig enabled both.

Suggested-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
Reviewed-by: Nishanth Menon <nm@ti.com>
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

