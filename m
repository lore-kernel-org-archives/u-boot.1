Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3C4C46CCD
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 11:36:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09ED2876B4;
	Tue, 19 Dec 2023 12:33:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="druXYnQB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81D4486F1E; Tue, 19 Dec 2023 11:13:12 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ED3C871C3
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 11:13:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BJAD4Ht095474;
 Tue, 19 Dec 2023 04:13:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1702980784;
 bh=VNV7C3nfSnXd+iR83CpF8av0mz84N7Fxn4+Th9ov1qc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=druXYnQBqBa8YyaQl1Kk6sqWQL6roFdKcKAzwfopMvV8j9Ob5RonyaW1zsUAMs3yx
 YLORlMTpesonoYrAeD552psSOdtd+QaxSfxRTDcsuU7SLWFJP/1OajIBJUqY9A096/
 Q/a6SryF/+NwlwnaJYbAfWKl0geRIxwdGg7ELYS8=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BJAD41G039348
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Dec 2023 04:13:04 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Dec 2023 04:13:04 -0600
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Dec 2023 04:13:04 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
 by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BJAD4On089311;
 Tue, 19 Dec 2023 04:13:04 -0600
Received: from localhost (dhcp-10-24-69-31.dhcp.ti.com [10.24.69.31])
 by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 3BJAD3iV018907;
 Tue, 19 Dec 2023 04:13:03 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: Maxime Ripard <mripard@kernel.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Nishanth Menon
 <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 MD Danish Anwar <danishanwar@ti.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH 09/16] arm: dts: k3-am65: Add cfg reg region to ringacc
 node
Date: Tue, 19 Dec 2023 15:42:10 +0530
Message-ID: <20231219101225.3443978-18-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219101225.3443978-1-danishanwar@ti.com>
References: <20231219101225.3443978-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Tue, 19 Dec 2023 12:33:18 +0100
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

Add register range of ringacc cfg node to k3-am65* dtsi files. This is
normally under Device Management firmware control but some entities like
bootloader have to access directly and thus required to be present in
DT.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 arch/arm/dts/k3-am65-main.dtsi | 5 +++--
 arch/arm/dts/k3-am65-mcu.dtsi  | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/k3-am65-main.dtsi b/arch/arm/dts/k3-am65-main.dtsi
index 691c9978e6..7f10520236 100644
--- a/arch/arm/dts/k3-am65-main.dtsi
+++ b/arch/arm/dts/k3-am65-main.dtsi
@@ -603,8 +603,9 @@
 			reg =	<0x0 0x3c000000 0x0 0x400000>,
 				<0x0 0x38000000 0x0 0x400000>,
 				<0x0 0x31120000 0x0 0x100>,
-				<0x0 0x33000000 0x0 0x40000>;
-			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
+				<0x0 0x33000000 0x0 0x40000>,
+				<0x0 0x31080000 0x0 0x40000>;
+			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
 			ti,num-rings = <818>;
 			ti,sci-rm-range-gp-rings = <0x1>; /* GP ring range */
 			ti,sci = <&dmsc>;
diff --git a/arch/arm/dts/k3-am65-mcu.dtsi b/arch/arm/dts/k3-am65-mcu.dtsi
index d7111aa8b2..b7f0456de7 100644
--- a/arch/arm/dts/k3-am65-mcu.dtsi
+++ b/arch/arm/dts/k3-am65-mcu.dtsi
@@ -129,8 +129,9 @@
 			reg =	<0x0 0x2b800000 0x0 0x400000>,
 				<0x0 0x2b000000 0x0 0x400000>,
 				<0x0 0x28590000 0x0 0x100>,
-				<0x0 0x2a500000 0x0 0x40000>;
-			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
+				<0x0 0x2a500000 0x0 0x40000>,
+				<0x0 0x28440000 0x0 0x40000>;
+			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target", "cfg";
 			ti,num-rings = <286>;
 			ti,sci-rm-range-gp-rings = <0x1>; /* GP ring range */
 			ti,sci = <&dmsc>;
-- 
2.34.1

