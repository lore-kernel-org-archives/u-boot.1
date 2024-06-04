Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D26FBC25B7E
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 06:09:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F11188445;
	Tue,  4 Jun 2024 08:09:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VTtQxXle";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60AC188460; Tue,  4 Jun 2024 08:09:30 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48DD38844C
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 08:09:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45469Qih054012;
 Tue, 4 Jun 2024 01:09:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717481366;
 bh=kwhuiet0lK9LBb08CRcxpffZxrwUK9f3YyAmQFRaQPc=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=VTtQxXleNfH1QlYfa3xPR23dS44QSA2ysbRFa+wZrOR/BKtxW2gMosUBqmzBydFjy
 ijP+LHfpNeXUvgEmRXqAqMadwX5AupnnPlqi86NUR74GQLpFNGGkxPju/1BftCG9pA
 Uavi3+U7TMN3EF8XUDe+eyqJ4dwv+hmgCgWqfIdo=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45469QbB028589
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 4 Jun 2024 01:09:26 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Jun 2024 01:09:26 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Jun 2024 01:09:26 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45469BfG022510;
 Tue, 4 Jun 2024 01:09:23 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 4 Jun 2024 11:39:12 +0530
Subject: [PATCH v3 3/4] arch: arm: dts: k3-j721s2-*-u-boot.dtsi: Enable the
 ospi0 node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240604-b4-upstream-j721s2-ospi-support-v3-3-738aa77d9202@ti.com>
References: <20240604-b4-upstream-j721s2-ospi-support-v3-0-738aa77d9202@ti.com>
In-Reply-To: <20240604-b4-upstream-j721s2-ospi-support-v3-0-738aa77d9202@ti.com>
To: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>, "Tom
 Rini" <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>, Prasanth Mantena
 <p-mantena@ti.com>, Jon Humphreys <j-humphreys@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717481351; l=676;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=b+YO3cKZ2OiPKyWiMX08u2SU3wFsbRTyTyfHCRbRq1k=;
 b=TQf+YF2uXO0upBY+IOosdgwt9njArnrmeW9wVmLXOMywCQ+lp2Q+ZdAyER2ctGqgilgtv4bCk
 GAIRZ9SInIiBjpVkAOVtS19qWjngTo5yQwMrFEsUiaI2iXYfIET0dMK
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
2.45.1

