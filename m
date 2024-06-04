Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D544FC25B7E
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 06:09:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 195408845A;
	Tue,  4 Jun 2024 08:09:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wWQgK2xq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA0EA88459; Tue,  4 Jun 2024 08:09:28 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8754C88464
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 08:09:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45469MZG017893;
 Tue, 4 Jun 2024 01:09:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717481362;
 bh=yCuzpcs53Yxv+RWp2FqcIFRRmrHR2MgBdLO73lh/8Is=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=wWQgK2xq5kgG6TtMoKUFyZyj064brmwTZP4lN7lmPZXYRwbWduKt5sEyS1x1MZTCT
 0EeSOv34WeL+k6SRUoEzp5UxLERherfANKPzbcbN/AMDmxOUXzi1NzSg0NwrkYR7vl
 vEJyhahg91cRRKSeGSliXLO/JVDpIaArfkviAEz4=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45469MaA109648
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 4 Jun 2024 01:09:22 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Jun 2024 01:09:22 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Jun 2024 01:09:22 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45469BfF022510;
 Tue, 4 Jun 2024 01:09:19 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 4 Jun 2024 11:39:11 +0530
Subject: [PATCH v3 2/4] arch: arm: dts: k3-j721s2-r5: Override ospi and fss
 for 32-bit mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240604-b4-upstream-j721s2-ospi-support-v3-2-738aa77d9202@ti.com>
References: <20240604-b4-upstream-j721s2-ospi-support-v3-0-738aa77d9202@ti.com>
In-Reply-To: <20240604-b4-upstream-j721s2-ospi-support-v3-0-738aa77d9202@ti.com>
To: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>, "Tom
 Rini" <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>, Prasanth Mantena
 <p-mantena@ti.com>, Jon Humphreys <j-humphreys@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717481351; l=1089;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=ijbGORsZEicer7Cxzsd3oytgoGU01bvBlNt+J+PG2n8=;
 b=zDiax6FdyTT3nIi4aXrzOkydZs2JsT5EH26dOTHc/lXT/CQiMML520GyFpGnJlWiosnCvcZgK
 RkkrYwv0aLrC0CDesMKCvc3o8kCmpQiYreplXV7LjB7T9DOPtpvQ2d8
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

R5 being a 32-bit processor can't understand the 64-bit mapping being
done in ospi node. Override the ospi node for 32-bit register ranges and
the fss node ( the parent node of ospi ) to map the ranges for the
updated child node correctly.

Reviewed-by: Apurva Nandan <a-nandan@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm/dts/k3-j721s2-r5.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/dts/k3-j721s2-r5.dtsi b/arch/arm/dts/k3-j721s2-r5.dtsi
index eb0df42583a3..dbea6b9d0113 100644
--- a/arch/arm/dts/k3-j721s2-r5.dtsi
+++ b/arch/arm/dts/k3-j721s2-r5.dtsi
@@ -79,3 +79,16 @@
 &mcu_udmap {
 	ti,sci = <&dm_tifs>;
 };
+
+&ospi0 {
+		reg = <0x0 0x47040000 0x0 0x100>,
+			  <0x0 0x50000000 0x0 0x8000000>;
+};
+
+&fss {
+	/* fss node has 64 bit address regions mapped to it and since the ospi
+	 * nodes is being override, override the fss node ranges as well
+	 */
+	ranges = <0x0 0x47000000 0x0 0x47000000 0x0 0x00068400>,
+			 <0x0 0x50000000 0x0 0x50000000 0x0 0x08000000>;
+};

-- 
2.45.1

