Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5913CD2F7EF
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 06:37:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B45A988EAE;
	Thu, 17 Oct 2024 08:37:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jdTXu7WN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6C6288EF7; Thu, 17 Oct 2024 08:37:40 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A26A88EE3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 08:37:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49H6bXnB042403;
 Thu, 17 Oct 2024 01:37:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1729147053;
 bh=kiIEgL0gbTO+/E63yHnTmTlQOzY6zl5GqUMT7O+n0Wg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=jdTXu7WNzpeAmwFWKyzkO/LipZamFw6h2LUb2PE/M+5AGs+YPocGo0e634qZgpaUh
 M/v2v/F7F68nMkwK3GetWQ/+ywqh5+iPZtdC9XZ2T532jhqPG8q094luV1vHlT/Ci2
 1MpfEKgtmDTQ6KBSD8bXyCzyWYdnJ5VE5eLt+Bp4=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49H6bXoR095258;
 Thu, 17 Oct 2024 01:37:33 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Oct 2024 01:37:33 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Oct 2024 01:37:33 -0500
Received: from PSDKL-Workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [172.24.227.91])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49H6bFOU090460;
 Thu, 17 Oct 2024 01:37:31 -0500
From: Aniket Limaye <a-limaye@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>
CC: <u-kumar1@ti.com>, <reidt@ti.com>, <m-chawdhry@ti.com>, <nm@ti.com>,
 Aniket Limaye <a-limaye@ti.com>
Subject: [PATCH 1/6] arm: dts: k3-j7200-r5-common: Add msmc clk to a72 node
Date: Thu, 17 Oct 2024 11:59:08 +0530
Message-ID: <20241017062911.2241167-2-a-limaye@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017062911.2241167-1-a-limaye@ti.com>
References: <20241017062911.2241167-1-a-limaye@ti.com>
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

Define the MSMC clk in the a72 node

Signed-off-by: Reid Tonking <reidt@ti.com>
Signed-off-by: Aniket Limaye <a-limaye@ti.com>
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

