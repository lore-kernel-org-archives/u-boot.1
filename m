Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB1DE75435
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 08:11:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B96387228;
	Tue,  3 Oct 2023 10:11:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XH0YoDUR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A24C87272; Tue,  3 Oct 2023 10:11:02 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6931A87235
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 10:10:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j-keerthy@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3938At2C023473;
 Tue, 3 Oct 2023 03:10:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696320655;
 bh=9og3PYRNGIcSqKPPGr2KXl0EYDoXtVFbUkXrYnFmK+A=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=XH0YoDURgd+hQ+GO2DSouPqVKU69wqLRpGxKzqabu2PBq8C5CsGwtBWxKOKBp4vaz
 2AvY0xxE59mD9iXNzqraTyTYNbKC5oKTlaNTLqKlRz539AGneAQVr7Do8y+Oa9VAeJ
 0+kqaxvAUYAQMLxId/a/2aEol8TjFlRJwGSHf/QM=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3938Atkf042085
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 3 Oct 2023 03:10:55 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Oct 2023 03:10:54 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Oct 2023 03:10:54 -0500
Received: from keerthy.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3938AhEE110453;
 Tue, 3 Oct 2023 03:10:53 -0500
From: Keerthy <j-keerthy@ti.com>
To: <u-boot@lists.denx.de>, <u-kumar1@ti.com>
CC: <j-keerthy@ti.com>, <n-francis@ti.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>
Subject: [PATCH RFC 04/10] arm64: dts: ti: k3-j721e: Add MCU domain ESM
 instance
Date: Tue, 3 Oct 2023 13:40:32 +0530
Message-ID: <20231003081038.24299-5-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231003081038.24299-1-j-keerthy@ti.com>
References: <20231003081038.24299-1-j-keerthy@ti.com>
MIME-Version: 1.0
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

Patch adds the ESM instance for MCU domian of j721e.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/dts/k3-j721e-mcu-wakeup.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/dts/k3-j721e-mcu-wakeup.dtsi b/arch/arm/dts/k3-j721e-mcu-wakeup.dtsi
index 22166c7942..66fdd6443f 100644
--- a/arch/arm/dts/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm/dts/k3-j721e-mcu-wakeup.dtsi
@@ -408,4 +408,11 @@
 			ti,loczrama = <1>;
 		};
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
2.17.1

