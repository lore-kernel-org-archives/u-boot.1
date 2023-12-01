Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CD9C4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 21:33:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20A7587186;
	Fri,  1 Dec 2023 22:33:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="b7BWc/5N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CAB28761B; Fri,  1 Dec 2023 22:33:28 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B8E787186
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 22:33:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=reidt@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B1LXOTn046115;
 Fri, 1 Dec 2023 15:33:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701466404;
 bh=pkEDjwriwLzddiAMbgfB7dCknkWdM7IvCUboUKUE7cc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=b7BWc/5N1GHe+jprm3X5GFx2jLqfV+6PepsyczHmS6sLqRHCq7T4jg3a5IwmsIfR5
 DVwtoF1A1EnZdS/DVSHtEKGOmsxCWFjYyP0T30ByEHlw4bl3twDquE/sMWvKHbzwVE
 h+kouI7grbSsmXvhK2bJNcZOlzOjTrd/8G5cVGOk=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B1LXORL031146
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 1 Dec 2023 15:33:24 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Dec 2023 15:33:24 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Dec 2023 15:33:24 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B1LXOLj128163;
 Fri, 1 Dec 2023 15:33:24 -0600
From: Reid Tonking <reidt@ti.com>
To: <trini@konsulko.com>
CC: <nm@ti.com>, <u-boot@lists.denx.de>, <m-chawdhry@ti.com>,
 <u-kumar1@ti.com>, <bb@ti.com>, <a-nandan@ti.com>, <vishalm@ti.com>, Reid
 Tonking <reidt@ti.com>
Subject: [PATCH 2/2] arm: dts: k3-j7200-r5-common-proc-board: Set parent clock
 for clock ID 323
Date: Fri, 1 Dec 2023 15:33:20 -0600
Message-ID: <20231201213320.1876892-3-reidt@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201213320.1876892-1-reidt@ti.com>
References: <20231201213320.1876892-1-reidt@ti.com>
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

From: Apurva Nandan <a-nandan@ti.com>

This virtual clock mux configuration enables the use of dynamic frequency
scaling on A72 clock ID 202 by setting up the required register.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
Signed-off-by: Reid Tonking <reidt@ti.com>
---
 arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
index f0a73605020..018faaa13b6 100644
--- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
+++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
@@ -24,7 +24,8 @@
 				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
 		resets = <&k3_reset 202 0>;
 		clocks = <&k3_clks 61 1>;
-		assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>;
+		assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>, <&k3_clks 323 0>;
+		assigned-clock-parents= <0>, <0>, <&k3_clks 323 2>;
 		assigned-clock-rates = <2000000000>, <200000000>;
 		ti,sci = <&dmsc>;
 		ti,sci-proc-id = <32>;
-- 
2.34.1

