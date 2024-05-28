Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9C9C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 13:13:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C61BA884E7;
	Tue, 28 May 2024 15:13:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="F4CdqwgZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCCCE88349; Tue, 28 May 2024 15:13:19 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B3E3884CE
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 15:13:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44SDDE3f062869;
 Tue, 28 May 2024 08:13:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716901994;
 bh=Z4engCxWqGeNd3e+LtTbLbPzO1EGp2oNKcy2tJzwwCg=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=F4CdqwgZR+Xoole/0xddBBlYEp86i5kDxfQFo//bqly1Z/yFaDBnu4KQqOgRIkw9G
 60EXsaj1YVtuEINve+9Pxojx1W152xmtUvM8n4On7LUb2YbrAVDGQAb2L8dVRplrNs
 v01ws84n+u+THViVndZ/XTV/mA0Qyos1+Sfg/FMY=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44SDDEkJ052283
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 28 May 2024 08:13:14 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 08:13:14 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 08:13:14 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44SDD25e099882;
 Tue, 28 May 2024 08:13:11 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 28 May 2024 18:42:56 +0530
Subject: [PATCH v2 2/4] arch: arm: dts: k3-j721s2-r5: Override ospi and fss
 for 32-bit mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240528-b4-upstream-j721s2-ospi-support-v2-2-b2e372ebcdd7@ti.com>
References: <20240528-b4-upstream-j721s2-ospi-support-v2-0-b2e372ebcdd7@ti.com>
In-Reply-To: <20240528-b4-upstream-j721s2-ospi-support-v2-0-b2e372ebcdd7@ti.com>
To: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>, "Tom
 Rini" <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>, Prasanth Mantena
 <p-mantena@ti.com>, Apurva Nandan <a-nandan@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716901982; l=1089;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=Ey5QAkMhGgZY3grA1qkl4TVVquMYYC3zUvy1Ir5J5gc=;
 b=y53p20jcAIKWGadghDrZFUTREH1yobTLdQVL/5U6nX4+h+4D79hg325Jx4zDRNCtF4OKHeHXW
 bzO2EmxnajZCFxdg+2qC7S22282/E97raS1zIIEvjaAUSEW5kexo8ma
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
2.43.2

