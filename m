Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F76CFA749
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 06:25:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04C6B89095;
	Fri,  4 Oct 2024 08:25:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eLiy32Xc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 484578907B; Fri,  4 Oct 2024 08:24:59 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ABD4882B7
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 08:24:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4946Otbf112792;
 Fri, 4 Oct 2024 01:24:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728023095;
 bh=N9P2VcGy9UIv8XgwOMRmhP8S/jSDbzYM/jSjFt29F5M=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=eLiy32XcmBK9K6mD9XW+/nH2UlFNkm9MtGJMB9mJn3SZ0II6eY348xQ2Q/RxnjSLV
 t/ZAG7ZosiTC0ZanazQflQvEUHxjP+p2uOWxb9BfDbJzPDDzQj2T3HJ3wdZb2FablL
 WLp3Jb0+9W+c6Y27ihNNgY2uAiOIDS3sXdX/hsrA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4946Ot1q020436
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 4 Oct 2024 01:24:55 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 4
 Oct 2024 01:24:55 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 4 Oct 2024 01:24:54 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4946OVZ3100112;
 Fri, 4 Oct 2024 01:24:51 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Fri, 4 Oct 2024 11:54:34 +0530
Subject: [PATCH v4 6/7] arm: dts: j721s2: Add VTM node in R5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241004-b4-upstream-j721s2-avs-v4-6-6d71c6bab9f4@ti.com>
References: <20241004-b4-upstream-j721s2-avs-v4-0-6d71c6bab9f4@ti.com>
In-Reply-To: <20241004-b4-upstream-j721s2-avs-v4-0-6d71c6bab9f4@ti.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728023071; l=958;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=EHVNMl7+9MDr8tYB8Y4dhFCr1HundAvvwBqWvviHn7w=;
 b=nTKeywu0bMtnYIy88BskbIDAX++WHbgDBf8tHiJu30tKvhhvwGNdGsS1bfPbd2748SA7EUiBZ
 y9vrfkO8uhzAwMfE1RytX8gronYnjBRr53shbLTlr0bGVOpoFt3JDXE
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

Add bootph-pre-ram property to VTM node and the pmic node.

Reviewed-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---

Notes:
    Patches are posted to Linux [0]
    
    [0]: https://lore.kernel.org/linux-arm-kernel/20240814-b4-upstream-bootph-all-v4-0-f2b462000f25@ti.com/#

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
2.46.0

