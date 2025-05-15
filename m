Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749C2C3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 11:39:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57FCE82B8E;
	Thu, 15 May 2025 13:38:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="feDEseKw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB80F82B7F; Thu, 15 May 2025 13:38:57 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BBDF82B20
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 13:38:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 54FBcpnh2849465
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 06:38:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1747309131;
 bh=DRF2kOiCbZv/Lz4GGojXMWxZaPi3wVgfRNq8dw66+hU=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=feDEseKw9/+EcnXt+4UpKRAx8JIby6UlCmf70lOkVpBqDYe/a2KgCl2E1H0ZJ3mV/
 bGLCwfBmXaAZCJuJEJLADW9QEaTsAoEj45fqknk91Ndiys2b0YJKF9v7IxyD/26rOv
 7hfZIzkCiI1D5WeB0ooZX05ywJ9t3fDcogrC7VBI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 54FBco2N035795
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 15 May 2025 06:38:51 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 May 2025 06:38:50 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 May 2025 06:38:50 -0500
Received: from [127.0.1.1] (uda0497581-hp.dhcp.ti.com [172.24.227.253])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54FBccg8059730;
 Thu, 15 May 2025 06:38:47 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Thu, 15 May 2025 17:08:35 +0530
Subject: [PATCH 2/4] arm: dts: k3-am625-phycore-r5*: Remove clocks from
 main_timer0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250515-b4-upstream-k3-pll-miss-v1-2-e38b89f027b8@ti.com>
References: <20250515-b4-upstream-k3-pll-miss-v1-0-e38b89f027b8@ti.com>
In-Reply-To: <20250515-b4-upstream-k3-pll-miss-v1-0-e38b89f027b8@ti.com>
To: Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Wadim Egorov <w.egorov@phytec.de>, Francesco
 Dolcini <francesco.dolcini@toradex.com>, Garrett Giordano
 <ggiordano@phytec.com>
CC: <u-boot@lists.denx.de>, Vishal Mahaveer <vishalm@ti.com>, Chandru
 Dhavamani <chandru@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747309118; l=1944;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=wzHrQ/hxCyETaB41zntCNMWCT85sYhrDgwNaT4tJCO4=;
 b=1QfxBKwN7dPNm5CXc/q5AQRQeHg3mvmglHzR876+ckxIdytfv7GFI9Zfny6QNPukkIlc/vyym
 BcEuPgrnT/WAD30qcBxP9Hyq4y3FPDNqipzdGBAqUQPjpmcWYnI5dWF
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

The commit 79d91e77f4c2 ("clk: ti: clk-k3-pll: Add additional robustness
steps to the PLL sequence") introduced a change which requires the
main_timer0 to not rely on it's own clocks which anyways was wrong.

Fix it by removing the clock dependency for it, also while at it, move
it from u-boot.dtsi to R5 as that is the only entity that should require
it as DM isn't up.

Fixes: 5d1aac358f3c ("arm: dts: k3-*-r5: Remove clocks from mcu_timer0")
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi | 5 -----
 arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts        | 8 ++++++++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi b/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
index c001e2c96e8c18f6de79190eda8468f60f1a0b8a..ee273563e8346b89ccefef60d2d72d3ba0304c7f 100644
--- a/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-phyboard-lyra-rdk-u-boot.dtsi
@@ -13,7 +13,6 @@
 / {
 	chosen {
 		stdout-path = "serial2:115200n8";
-		tick-timer = &main_timer0;
 	};
 
 	aliases {
@@ -96,10 +95,6 @@
 	bootph-all;
 };
 
-&main_timer0 {
-	clock-frequency = <25000000>;
-};
-
 &main_uart0 {
 	bootph-all;
 };
diff --git a/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts b/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
index 70154409b1275c01ea8722d5bd233ad3fac79078..7132fae36faa40266d573ece7d031b67ee0a507b 100644
--- a/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
+++ b/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
@@ -54,6 +54,14 @@
 	};
 };
 
+&main_timer0 {
+	/delete-property/ clocks;
+	/delete-property/ clocks-names;
+	/delete-property/ assigned-clocks;
+	/delete-property/ assigned-clock-parents;
+	clock-frequency = <25000000>;
+};
+
 &secure_proxy_sa3 {
 	/* We require this for boot handshake */
 	status = "okay";

-- 
2.34.1

