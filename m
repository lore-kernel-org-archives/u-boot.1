Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2359AC25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 08:14:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABF2888466;
	Tue, 28 May 2024 10:13:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hqqhW5Wb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35AC488479; Tue, 28 May 2024 10:13:32 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 217B68843A
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 10:13:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44S8DSdC119459;
 Tue, 28 May 2024 03:13:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716884008;
 bh=CNcIAYrnbLIXHvdEO0LB0KstQpqNlDCOTx0yoUiFJJ4=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=hqqhW5Wbzy8O1yTv4mtxtqv37yDgP91XlWvuN5FmI8RQO1bXFyTv9jpGCtHUelyJA
 GJoDyrGpHD4ugbR5DjGnHS5N4m+Ca4VNdcZeznl3NhP1RxYujh59MXtWqigrdONAAJ
 KNBgpMqm2AFjKhIszPcgAV4Z1l8M2PNvWXkQ1Jag=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44S8DSRX119295
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 28 May 2024 03:13:28 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 03:13:28 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 03:13:28 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44S8Cxur066670;
 Tue, 28 May 2024 03:13:25 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 28 May 2024 13:43:05 +0530
Subject: [PATCH v2 6/7] arm: dts: j721s2: Add VTM node in R5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240528-b4-upstream-j721s2-avs-v2-6-df940f2309d0@ti.com>
References: <20240528-b4-upstream-j721s2-avs-v2-0-df940f2309d0@ti.com>
In-Reply-To: <20240528-b4-upstream-j721s2-avs-v2-0-df940f2309d0@ti.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716883980; l=750;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=3NpOvcJBaCx5wX1rQiSQTAOzO3F1xhgzn/9tl6tjSEM=;
 b=wt1lWcaiABPd6dBY6YE+45zvVAfypbt0xVHfnIUgGnpTIKBwN8Gz7z1qRrfgpZ11PqAOEr2pY
 aN4mLzx0yc7A3Awb16bcWLH5Y/XhDhoi/6ARtZp8YVbiCbvInclEakh
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

Add bootph-pre-ram property to VTM node and the pmic node.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm/dts/k3-j721s2-r5-common-proc-board.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts b/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
index e92b1917df4e..506ad9b7910d 100644
--- a/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
+++ b/arch/arm/dts/k3-j721s2-r5-common-proc-board.dts
@@ -10,3 +10,12 @@
 #include "k3-j721s2-ddr.dtsi"
 #include "k3-j721s2-common-proc-board-u-boot.dtsi"
 #include "k3-j721s2-r5.dtsi"
+
+&tps659411 {
+	bootph-pre-ram;
+};
+
+&wkup_vtm0 {
+	bootph-pre-ram;
+	vdd-supply-2 = <&bucka1234>;
+};

-- 
2.43.2

