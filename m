Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13813C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 11:44:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FFDC87C5B;
	Wed, 31 Jan 2024 12:44:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rSYcrrSU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C004B87887; Wed, 31 Jan 2024 07:02:45 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB2548798B
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 07:02:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40V62gpM125705;
 Wed, 31 Jan 2024 00:02:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706680962;
 bh=pNlIHLGMQhB7h4EpKvSgSDfQTjLy2f5+q9JORQS4IKs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=rSYcrrSUbJvUn5EIVVaDV3S1z5X9iIHbZVKFLCJYvOV3tNkElQaVcxIAEekTRMTNV
 PXZWmOy7n1Uj0JL+nUVzrY/bKSC0sKLD30S2Xm4K3fj+6zas2IKuhdumQ90VwZYyUL
 +Q/j8oi5wM9OGfwXn3yBB1keqWVb2XtzWwrmD57c=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40V62gjp002182
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 31 Jan 2024 00:02:42 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 00:02:41 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 00:02:41 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40V62Utf062916;
 Wed, 31 Jan 2024 00:02:40 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <vigneshr@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 05/10] drivers: ram: Kconfig: Add CONFIG_K3_INLINE_ECC
Date: Wed, 31 Jan 2024 11:32:08 +0530
Message-ID: <20240131060213.1128024-6-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131060213.1128024-1-s-k6@ti.com>
References: <20240131060213.1128024-1-s-k6@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 31 Jan 2024 12:44:04 +0100
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
 drivers/ram/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/ram/Kconfig b/drivers/ram/Kconfig
index 5b07e9203014..dd034fa65281 100644
--- a/drivers/ram/Kconfig
+++ b/drivers/ram/Kconfig
@@ -107,6 +107,17 @@ config IMXRT_SDRAM
 	  to support external memories like sdram, psram & nand.
 	  This driver is for the sdram memory interface with the SEMC.
 
+config K3_INLINE_ECC
+	bool "Enable TI Inline ECC support"
+	depends on K3_DDRSS
+	default n
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

