Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E0BC30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 04:52:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EA7C88969;
	Fri,  5 Jul 2024 06:51:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HwYEP48C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3487788969; Fri,  5 Jul 2024 06:51:13 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B58608896D
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 06:51:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4654on4G035096;
 Thu, 4 Jul 2024 23:50:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1720155049;
 bh=kluFjeAMYPun90VoFZN71N/e/3BWoKamlWNd1gZ49j8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=HwYEP48CKOp38zVFkIfeDL6PQOHnuva7i5/o7hNyu6McXJHhjPYuVDutf1AhW6lAJ
 Bl0pHG+wzJGW8kMp50dMMou794An16cuJhkm6ga5K1pWR6EdxMYX1P6TkDwgeR/GII
 c1qzGfohFOeRBVVvjSrD1cOW9nCfN8nfJnmT7pIk=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4654onL4024208
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 4 Jul 2024 23:50:49 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Jul 2024 23:50:49 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Jul 2024 23:50:49 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4654omOv032818;
 Thu, 4 Jul 2024 23:50:49 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Michal Simek <michal.simek@amd.com>, Bryan Brattlof <bb@ti.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>, MD Danish Anwar
 <danishanwar@ti.com>, Udit Kumar <u-kumar1@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>,
 Andreas Dannenberg <dannenberg@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar <devarsht@ti.com>, "Sean
 Anderson" <seanga2@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 "Nikhil M Jain" <n-jain1@ti.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Wadim Egorov <w.egorov@phytec.de>, Chintan
 Vankar <c-vankar@ti.com>, "Sjoerd Simons" <sjoerd@collabora.com>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Dhruva Gole <d-gole@ti.com>, "Simon
 Glass" <sjg@chromium.org>, Roger Quadros <rogerq@kernel.org>, Maxime Ripard
 <mripard@kernel.org>, Nishanth Menon <nm@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <srk@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v3 10/10] arch: arm: dts: k3-am62-sk-u-boot: Add missing
 "bootph-all" property to phy_gmii_sel node
Date: Fri, 5 Jul 2024 10:20:30 +0530
Message-ID: <20240705045030.1141934-11-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240705045030.1141934-1-c-vankar@ti.com>
References: <20240705045030.1141934-1-c-vankar@ti.com>
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

Add "bootph-all" property to CPSW MAC's PHY node phy_gmii_sel.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v2:
https://lore.kernel.org/r/20240425120822.2048012-11-c-vankar@ti.com/

Changes from v2 to v3:
- Since "phy_gmii_sel" with "bootph-all" property is merged at upstream
  Linux for am62x-sk-common with commit "ba50141137fa", this patch can be
  drop with next DT-Sync.

 arch/arm/dts/k3-am625-sk-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/k3-am625-sk-u-boot.dtsi b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
index 1fc0d407cb..18412688bb 100644
--- a/arch/arm/dts/k3-am625-sk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-sk-u-boot.dtsi
@@ -12,6 +12,10 @@
 	};
 };
 
+&phy_gmii_sel {
+	bootph-all;
+};
+
 &main_timer0 {
 	clock-frequency = <25000000>;
 };
-- 
2.34.1

