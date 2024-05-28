Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D874C25B7C
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 13:13:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37197884EF;
	Tue, 28 May 2024 15:13:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Zwr3IwdC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 954DE884EF; Tue, 28 May 2024 15:13:22 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8176B884D2
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 15:13:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44SDDIsN062884;
 Tue, 28 May 2024 08:13:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716901998;
 bh=57SfqpmDFON5CHBD3hhdMInqeHhv7onMebRiMieau14=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=Zwr3IwdC+BFewLT4dYNgWM4TnU9RFuviUiVSjjX1oNnn9D2gOcNB0c76ApsHItgQK
 EqnyAjsN0ae8cbKW/RK1v7wDlQc1Nmt7VQiHa3mo8BJ9tRtlq04BruOKgL7hGFgTiO
 e/HMOOd9wVUJc8cWe0r0vVYtfINPW8Xr2fHcnSaA=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44SDDI2f003303
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 28 May 2024 08:13:18 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 08:13:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 08:13:18 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44SDD25f099882;
 Tue, 28 May 2024 08:13:15 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 28 May 2024 18:42:57 +0530
Subject: [PATCH v2 3/4] arch: arm: dts: k3-j721s2-*-u-boot.dtsi: Enable the
 ospi0 node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240528-b4-upstream-j721s2-ospi-support-v2-3-b2e372ebcdd7@ti.com>
References: <20240528-b4-upstream-j721s2-ospi-support-v2-0-b2e372ebcdd7@ti.com>
In-Reply-To: <20240528-b4-upstream-j721s2-ospi-support-v2-0-b2e372ebcdd7@ti.com>
To: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>, "Tom
 Rini" <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>, Prasanth Mantena
 <p-mantena@ti.com>, Apurva Nandan <a-nandan@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716901982; l=676;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=u52sdt57LhsnIldVTq88+X0oG7scpp0f2Mzz/Yr7Wr8=;
 b=c1RvYqROVS7mmiWI0JkertsYpTPETZ4ON+yKwGNI1a8oPbLWwdAprh+uPSUKHmVA1+VCWRcE5
 hr66bF2gjyrBeKKdv5ntHhD0k8xhybOuKxSWEsgObY8VCI7mlKFUPDf
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

Enable ospi0 node for all boot stages

Reviewed-by: Apurva Nandan <a-nandan@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi b/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
index 91a82b3b7ca6..54eb9b4072c7 100644
--- a/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
+++ b/arch/arm/dts/k3-j721s2-common-proc-board-u-boot.dtsi
@@ -102,7 +102,9 @@
 };
 
 &ospi0 {
-	status = "disabled";
+	flash@0 {
+		bootph-all;
+	};
 };
 
 &ospi1 {

-- 
2.43.2

