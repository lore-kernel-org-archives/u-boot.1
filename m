Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B165D3C93E
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 04:42:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA88889256;
	Mon, 21 Oct 2024 06:41:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wkSHMFaE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0C5E891FE; Mon, 21 Oct 2024 06:41:24 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA073892D3
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 06:41:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49L4fLQ5016120;
 Sun, 20 Oct 2024 23:41:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1729485681;
 bh=6brhlQQqTGK9XAfQjgk97L3RVofuTANTugFnJDAKpI8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=wkSHMFaEc2Tq42PSP08gK2zP9HexoV12/monHHLjIqkLBJryZVoeu0YaX+9i3mB7j
 lcrUHG6PMOGd3pApkWVSpE/V+KbiI66JiUhrj4j5xov6hazI7qZ5CdSbr66/2jNlfL
 Tv/o+9fZmISg/ypupuzoZ4bCJKpyujeimH+9B10Q=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49L4fLPc005548
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 20 Oct 2024 23:41:21 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 20
 Oct 2024 23:41:20 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 20 Oct 2024 23:41:20 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49L4f2tw059251;
 Sun, 20 Oct 2024 23:41:18 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <m-chawdhry@ti.com>, <nm@ti.com>, <u-kumar1@ti.com>, 
 <vigneshr@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <w.egorov@phytec.de>, <n-francis@ti.com>,
 <s-k6@ti.com>
Subject: [PATCH v4 5/8] drivers: ram: Kconfig: Add CONFIG_K3_INLINE_ECC
Date: Mon, 21 Oct 2024 10:10:21 +0530
Message-ID: <20241021044024.835846-6-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021044024.835846-1-s-k6@ti.com>
References: <20241021044024.835846-1-s-k6@ti.com>
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

From: Neha Malcom Francis <n-francis@ti.com>

Add CONFIG_K3_INLINE_ECC so that ECC functions can be compiled into R5 SPL
only when the config has been enabled.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 drivers/ram/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/ram/Kconfig b/drivers/ram/Kconfig
index f7e357f24da7..533d0c629a64 100644
--- a/drivers/ram/Kconfig
+++ b/drivers/ram/Kconfig
@@ -116,6 +116,16 @@ config IMXRT_SDRAM
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

