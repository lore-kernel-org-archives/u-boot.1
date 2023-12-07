Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98B9C4167B
	for <u-boot@archiver.kernel.org>; Thu,  7 Dec 2023 16:52:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5497B87250;
	Thu,  7 Dec 2023 17:52:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hGWo/YfE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89D938747A; Thu,  7 Dec 2023 17:52:26 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4954F87207
 for <u-boot@lists.denx.de>; Thu,  7 Dec 2023 17:52:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=reidt@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B7GqMjf006401;
 Thu, 7 Dec 2023 10:52:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701967942;
 bh=eWJIRTBHFewRO3E+bVZtbe94HmIJdf9F2rFmK849YUI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=hGWo/YfEgCeUtuuxXR44igPw93QSquY3PJSS+ajejvFf3NXcSyqfwI3yujGpF5QlG
 BkEfSGVficVkX6XcEysyfxuIYxpDZEHHmKAG18D1dveKLhSpI91K4LPYSYORxR+afe
 OYSBjimYUiF5MySIkSuIUBesOn3PC1qvyIEQzDAA=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B7GqM2d087236
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 7 Dec 2023 10:52:22 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Dec 2023 10:52:21 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Dec 2023 10:52:22 -0600
Received: from localhost (reidt-hp-z2.dhcp.ti.com [128.247.81.215])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B7GqLeJ030126;
 Thu, 7 Dec 2023 10:52:21 -0600
From: Reid Tonking <reidt@ti.com>
To: <trini@konsulko.com>
CC: <nm@ti.com>, <m-chawdhry@ti.com>, <u-boot@lists.denx.de>,
 <u-kumar1@ti.com>, <bb@ti.com>, <a-nandan@ti.com>, <vishalm@ti.com>, Reid
 Tonking <reidt@ti.com>
Subject: [PATCH v3 2/2] arm: dts: k3-j7200-r5-common-proc-board: Set parent
 clock for clock ID 323
Date: Thu, 7 Dec 2023 10:52:11 -0600
Message-ID: <20231207165211.2319475-3-reidt@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207165211.2319475-1-reidt@ti.com>
References: <20231207165211.2319475-1-reidt@ti.com>
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

Previously, dynamic frequency scaling supported rates only through fixed
divison.

This virtual clock mux configuration enables more varied rates on A72
clock ID 202 by setting up the required register.

Reviewed-by: Udit Kumar <u-kumar1@ti.com>
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

