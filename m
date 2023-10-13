Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99D8CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 10:29:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69FD386B95;
	Fri, 13 Oct 2023 12:29:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rvJ1SJz7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3D6A86E15; Fri, 13 Oct 2023 12:29:51 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C969864F3
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 12:29:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39DATimY074920;
 Fri, 13 Oct 2023 05:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697192984;
 bh=snC6LfD0xO+7dnijre24CmC0lOqrImfiwuBgBeNrdnI=;
 h=From:To:CC:Subject:Date;
 b=rvJ1SJz7QoFJe/+Kjn0uIkFQ+nAF07iYSkn8vKW9B7NrJJg6+tjRC9ZKHS5R9ofRn
 yd2L6ulZd+yQkOyRqRTmaZUB7FHTCDUlDETEdoeQzMvfhXKfLoxFpHydG/Clln1Q71
 wpzeUrq3YPMYvBf3V/e3Uo5reupR49JTjb8PGgdM=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39DATid1021815
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 13 Oct 2023 05:29:44 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 13
 Oct 2023 05:29:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 13 Oct 2023 05:29:44 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39DATfKn013405;
 Fri, 13 Oct 2023 05:29:42 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <nm@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>, 
 <m-chawdhry@ti.com>
Subject: [PATCH] arm: dts: k3-j721e-mcu-wakeup: Add MCU domain ESM instance
Date: Fri, 13 Oct 2023 15:59:41 +0530
Message-ID: <20231013102941.548209-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
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

Currently J721E defines only the main_esm in DTS. Add node for mcu_esm
as well.

According to J721E TRM (12.11.2.2 ESM Environment) [1], we see that the
interrupt line from ESMi (main_esm) is routed to MCU_ESM (mcu_esm). This
is MCU_ESM0_LVL_IN_95 with interrupt ID 95. Configure mcu_esm
accordingly so that errors from main_esm are routed to mcu_esm and
handled.

[1] https://www.ti.com/lit/zip/spruil1

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
Upstream kernel effort:
https://lore.kernel.org/lkml/20230926142810.602384-1-n-francis@ti.com/

 arch/arm/dts/k3-j721e-mcu-wakeup.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/dts/k3-j721e-mcu-wakeup.dtsi b/arch/arm/dts/k3-j721e-mcu-wakeup.dtsi
index 05d6ef127b..fa8af20c78 100644
--- a/arch/arm/dts/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm/dts/k3-j721e-mcu-wakeup.dtsi
@@ -671,4 +671,11 @@
 		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
 		#thermal-sensor-cells = <1>;
 	};
+
+	mcu_esm: esm@40800000 {
+		compatible = "ti,j721e-esm";
+		reg = <0x00 0x40800000 0x00 0x1000>;
+		ti,esm-pins = <95>;
+		bootph-pre-ram;
+	};
 };
-- 
2.34.1

