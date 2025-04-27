Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA1FC369D8
	for <u-boot@archiver.kernel.org>; Sun, 27 Apr 2025 07:04:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A97E820B7;
	Sun, 27 Apr 2025 09:03:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HKEOOwVv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E204C82075; Sun, 27 Apr 2025 09:03:43 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F7A2810EB
 for <u-boot@lists.denx.de>; Sun, 27 Apr 2025 09:03:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53R73XKZ2524952
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 27 Apr 2025 02:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745737413;
 bh=k5+6VgkhPU88xFpkZlG2LXqkewxprHosusDq7t+ZktA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=HKEOOwVvtU+t7yiSxbb4zeL+juUudjcx1smFORpNM/nRwJEPsll20WodJ/94PELwZ
 Rj6Qlgky1tk/cO82q76lucj1UXy5RE6t7fNFtglrLRKmTrw8hMp6i6O8iReSUsUZGk
 95O1RcK6lYZw16weI7xYZOImaUOLgOgL41Z9ktxg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53R73Xgs100826
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 27 Apr 2025 02:03:33 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 27
 Apr 2025 02:03:32 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 27 Apr 2025 02:03:32 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (udit-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.198])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53R73OuB011250;
 Sun, 27 Apr 2025 02:03:30 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <trini@konsulko.com>, <eballetbo@redhat.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <b-padhi@ti.com>, <n-francis@ti.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>
Subject: [v3 PATCH 2/4] arm: dts: k3-am69-r5-evm: Add the PMIC ESM node
Date: Sun, 27 Apr 2025 12:33:21 +0530
Message-ID: <20250427070323.590449-3-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250427070323.590449-1-u-kumar1@ti.com>
References: <20250427070323.590449-1-u-kumar1@ti.com>
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

From: Andrew Halaney <ahalaney@redhat.com>

Add the PMIC ESM node which is responsible for triggering the PMIC
reset.

Suggested-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 arch/arm/dts/k3-am69-r5-sk.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/dts/k3-am69-r5-sk.dts b/arch/arm/dts/k3-am69-r5-sk.dts
index 9c6e324ba29..e8362647c5d 100644
--- a/arch/arm/dts/k3-am69-r5-sk.dts
+++ b/arch/arm/dts/k3-am69-r5-sk.dts
@@ -10,3 +10,10 @@
 #include "k3-j784s4-ddr.dtsi"
 #include "k3-am69-sk-u-boot.dtsi"
 #include "k3-j784s4-r5.dtsi"
+
+&tps659413 {
+	esm: esm {
+		compatible = "ti,tps659413-esm";
+		bootph-pre-ram;
+	};
+};
-- 
2.34.1

