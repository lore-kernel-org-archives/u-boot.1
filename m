Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27ED2E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 10:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40A7980288;
	Fri, 13 Dec 2024 11:32:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KgZTntLo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1EC58010E; Fri, 13 Dec 2024 11:32:21 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FDF48021C
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 11:32:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BDAWIm43394508
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2024 04:32:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734085938;
 bh=6brhlQQqTGK9XAfQjgk97L3RVofuTANTugFnJDAKpI8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=KgZTntLog2Aj3OwIaPTq/VksTbKNwc0odY4uohdc6J0N7WpKO13uyOCCC6iWR+oBw
 EAPAGas1fN8wOL4uNVc74nXwGFIHp3pvsfQfga4tm5cpbFPEuv2Z8Uc48Gt3RDRfc9
 ZH9I4HW0OdlRpTeI1akG3VV7lhUodkZjYPoDl5TA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BDAWHA3007153
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 13 Dec 2024 04:32:18 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 13
 Dec 2024 04:32:17 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 13 Dec 2024 04:32:17 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BDAVpqB067253;
 Fri, 13 Dec 2024 04:32:14 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <bb@ti.com>, <m-chawdhry@ti.com>, <vaishnav.a@ti.com>, <j-choudhary@ti.com>
CC: <u-boot@lists.denx.de>, <w.egorov@phytec.de>, <n-francis@ti.com>,
 <s-k6@ti.com>
Subject: [PATCH v5 6/9] drivers: ram: Kconfig: Add CONFIG_K3_INLINE_ECC
Date: Fri, 13 Dec 2024 16:01:26 +0530
Message-ID: <20241213103129.332246-7-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213103129.332246-1-s-k6@ti.com>
References: <20241213103129.332246-1-s-k6@ti.com>
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

