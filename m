Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A82C25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 05:06:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 040CD88574;
	Thu, 23 May 2024 07:05:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IpBisZDo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D41C58856D; Thu, 23 May 2024 07:05:52 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1B3C88522
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 07:05:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44N55nuv007012;
 Thu, 23 May 2024 00:05:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716440749;
 bh=NIVfcHoUHX3QX+bqy9yuJCOAmbqVq8c6C8krSt6lpkw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=IpBisZDob92u2+NOPHJQgg24PFKusY8YaHlf39B35EaKo0A3negnh8RzT551tFz/A
 0kbg59g5+n1VctW7nm1ZpUnj615UuRZxtnMJ6Dcu9NaYcQ3bfMWR5cL8cd3pki53j9
 FtRH7EoUirNisrk6S+XTPxIXj7KoA5C38VFRnqWk=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44N55nhA068830
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 23 May 2024 00:05:49 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 May 2024 00:05:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 May 2024 00:05:48 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44N55UHB018652;
 Thu, 23 May 2024 00:05:46 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <vigneshr@ti.com>, <bb@ti.com>,
 <u-kumar1@ti.com>, <m-chawdhry@ti.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <s-k6@ti.com>
Subject: [PATCH v3 5/8] drivers: ram: Kconfig: Add CONFIG_K3_INLINE_ECC
Date: Thu, 23 May 2024 10:34:27 +0530
Message-ID: <20240523050430.455201-6-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523050430.455201-1-s-k6@ti.com>
References: <20240523050430.455201-1-s-k6@ti.com>
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

From: Neha Malcom Francis <n-francis@ti.com>

Add CONFIG_K3_INLINE_ECC so that ECC functions can be compiled into R5 SPL
only when the config has been enabled.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 drivers/ram/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/ram/Kconfig b/drivers/ram/Kconfig
index 9838a2798f92..5cee93fe68c8 100644
--- a/drivers/ram/Kconfig
+++ b/drivers/ram/Kconfig
@@ -107,6 +107,16 @@ config IMXRT_SDRAM
 	  to support external memories like sdram, psram & nand.
 	  This driver is for the sdram memory interface with the SEMC.
 
+config K3_INLINE_ECC
+	bool "Enable TI Inline ECC support"
+	depends on K3_DDRSS
+	help
+	  Enable Inline ECC support on K3 platforms. 1/9th of the SDRAM space
+	  is used for ECC storage and the rest 8/9th is available for system
+	  use. Enabling ECC increases boot time as the ECC protected regions
+	  need to be primed with a predefined value prior to enabling ECC
+	  check.
+
 source "drivers/ram/aspeed/Kconfig"
 source "drivers/ram/cadence/Kconfig"
 source "drivers/ram/octeon/Kconfig"
-- 
2.34.1

