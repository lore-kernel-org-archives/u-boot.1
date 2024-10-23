Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA5CCF5388
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 13:02:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 866E489222;
	Wed, 23 Oct 2024 15:02:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KKgwyRSj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE5DA89268; Wed, 23 Oct 2024 15:02:23 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A447488DEF
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 15:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=a-limaye@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49ND2Gh0030257;
 Wed, 23 Oct 2024 08:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1729688536;
 bh=+is1OuRpUc4AVRjhNo12hzNhwnTMiTSRz90RBTrfkk8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=KKgwyRSjF/S4V8Nzqq2xVUA+2wevYqCIeI40B019PYZw6s3qxGkoIHr/iiwFASHU9
 jScgMxpKhHEWiPZCU63C3Oe1+ONB5aRK/F+i6saU9bA2r6K56KI77Jw6qYXp1nsppi
 i8+/KkA+7x9iyMawUm3teOo4KXh6Kmoy5zjb/z4I=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49ND2Gni017183
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Oct 2024 08:02:16 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Oct 2024 08:02:16 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Oct 2024 08:02:16 -0500
Received: from PSDKL-Workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [172.24.227.91])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49ND2BQ0037622;
 Wed, 23 Oct 2024 08:02:14 -0500
From: Aniket Limaye <a-limaye@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>
CC: <u-kumar1@ti.com>, <reidt@ti.com>, <m-chawdhry@ti.com>, <nm@ti.com>,
 Aniket Limaye <a-limaye@ti.com>
Subject: [PATCH v2 1/5] arm: dts: k3-j7200-r5-common: Add msmc clk to a72 node
Date: Wed, 23 Oct 2024 18:27:09 +0530
Message-ID: <20241023130033.1826413-2-a-limaye@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241023130033.1826413-1-a-limaye@ti.com>
References: <20241023130033.1826413-1-a-limaye@ti.com>
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
v2:
- Update commit msg to justify location of msmc clk in DT
- Link to v1: https://lore.kernel.org/u-boot/20241017062911.2241167-2-a-limaye@ti.com/
---
 arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
index f096b102793..759a1e83456 100644
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
+		clocks = <&k3_clks 61 1>, <&k3_clks 4 1>, <&k3_clks 202 2> ;
+		clock-names = "gtc", "msmc", "core";
+		assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>, <&k3_clks 4 1>, <&k3_clks 323 0>;
+		assigned-clock-parents= <0>, <0>, <0>, <&k3_clks 323 2>;
+		assigned-clock-rates = <2000000000>, <200000000>, <1000000000>;
 		ti,sci = <&dmsc>;
 		ti,sci-proc-id = <32>;
 		ti,sci-host-id = <10>;
-- 
2.34.1

