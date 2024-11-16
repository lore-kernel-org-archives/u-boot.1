Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D36D68BE3
	for <u-boot@archiver.kernel.org>; Sat, 16 Nov 2024 07:17:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CC07892AB;
	Sat, 16 Nov 2024 08:16:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hD3T/L3F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF50A896E6; Sat, 16 Nov 2024 08:16:53 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 492AE891B1
 for <u-boot@lists.denx.de>; Sat, 16 Nov 2024 08:16:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AG7Gm9A3309142
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 16 Nov 2024 01:16:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1731741408;
 bh=m/xEDAiStY/lDa+eq6kU9J8TGyskF85gAGCqJYZ0hqk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=hD3T/L3FJEPEHK7K60C3OK8gLEwHdYTWtk8+7/94z4C0V7a6G0UIoHfGgWoD7hc3n
 D/oxE0WRYIkiLIaogDwAarAwzTPzqbAYtaW0xyugO9yArqL4YdLXXeZ0s/fNNfuga9
 O7dTnes4y9/vWyBFDZMF01Onkst9yiDqpnJRav/I=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AG7GmbB060589
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 16 Nov 2024 01:16:48 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 16
 Nov 2024 01:16:48 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 16 Nov 2024 01:16:48 -0600
Received: from PSDKL-Workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [172.24.227.91])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AG7Gg62129041;
 Sat, 16 Nov 2024 01:16:46 -0600
From: Aniket Limaye <a-limaye@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>
CC: <u-kumar1@ti.com>, <reidt@ti.com>, <m-chawdhry@ti.com>, <nm@ti.com>,
 <n-francis@ti.com>, Aniket Limaye <a-limaye@ti.com>
Subject: [PATCH v3 1/5] arm: dts: k3-j7200-r5-common: Add msmc clk to a72 node
Date: Sat, 16 Nov 2024 12:45:15 +0530
Message-ID: <20241116071615.839623-2-a-limaye@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241116071615.839623-1-a-limaye@ti.com>
References: <20241116071615.839623-1-a-limaye@ti.com>
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

From: Reid Tonking <reidt@ti.com>

The j7200 SOC has a single DDR controller and hence no need for
configuring the MSMC interleaver. Hence we do not have an explicit node
for MSMC in j7200 DT, unlike j721s2/j784s4.

Also, MSMC clk id is described under A72SS0_CORE0 Device in TISCI
documentation [0].

Considering the above, define the MSMC clk in the a72 node.

[0]: https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j7200/clocks.html#clocks-for-a72ss0-core0-device

Signed-off-by: Reid Tonking <reidt@ti.com>
Signed-off-by: Aniket Limaye <a-limaye@ti.com>

---
v3:
- Add msmc clock at the end to preserve current ordering of core and gtc
  clocks
- Link to v2: https://lore.kernel.org/u-boot/20241023130033.1826413-2-a-limaye@ti.com/

v2:
- Update commit msg to justify location of msmc clk in DT
- Link to v1: https://lore.kernel.org/u-boot/20241017062911.2241167-2-a-limaye@ti.com/

---
 arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
index f096b102793..15b13719b53 100644
--- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
+++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
@@ -23,11 +23,11 @@
 				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>,
 				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
 		resets = <&k3_reset 202 0>;
-		clocks = <&k3_clks 61 1>, <&k3_clks 202 2>;
-		clock-names = "gtc", "core";
-		assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>, <&k3_clks 323 0>;
-		assigned-clock-parents= <0>, <0>, <&k3_clks 323 2>;
-		assigned-clock-rates = <2000000000>, <200000000>;
+		clocks = <&k3_clks 61 1>, <&k3_clks 202 2>, <&k3_clks 4 1> ;
+		clock-names = "gtc", "core", "msmc";
+		assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>, <&k3_clks 4 1>, <&k3_clks 323 0>;
+		assigned-clock-parents= <0>, <0>, <0>, <&k3_clks 323 2>;
+		assigned-clock-rates = <2000000000>, <200000000>, <1000000000>;
 		ti,sci = <&dmsc>;
 		ti,sci-proc-id = <32>;
 		ti,sci-host-id = <10>;
-- 
2.47.0

