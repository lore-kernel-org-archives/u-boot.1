Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FD0C25B7E
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 07:37:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8AE688096;
	Tue, 28 May 2024 09:37:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="C32DTmwD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48DA4883FB; Tue, 28 May 2024 09:37:36 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B266687F31
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 09:37:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44S7bUMe100999;
 Tue, 28 May 2024 02:37:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716881850;
 bh=02pDd0JXDce2Mq6Kk4TlQryMgZ/o3qxC7oR0tGiWzjs=;
 h=From:To:CC:Subject:Date;
 b=C32DTmwDWHaXMMnjxuwdIuP7Ybq1UXiPLeFFznXCTgYifLyz8e59Wj3HY/MIgSAxU
 5dk3l9EB8Im7g/k39lJsPP1M0h6UXpZArzRQLP8s96q+plfn2Dh462841k8hCFZuxn
 /LlZguc1OL6h3+7rpp2eWYbbm8JB4Ey3O0/+1sb0=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44S7bU2N015766
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 28 May 2024 02:37:30 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 02:37:30 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 02:37:30 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44S7bRse005794;
 Tue, 28 May 2024 02:37:28 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <nm@ti.com>, <m-chawdhry@ti.com>,
 <sjg@chromium.org>, <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH] arm: dts: k3-j721e-r5-common-proc-board: Set parent clock for
 clock ID 342
Date: Tue, 28 May 2024 13:07:27 +0530
Message-ID: <20240528073727.4057843-1-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
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
Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
Boot logs:
https://gist.github.com/nehamalcom/138d25fe32d4d80af3e0e4c19c1b18e0

 arch/arm/dts/k3-j721e-r5-common-proc-board.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/k3-j721e-r5-common-proc-board.dts b/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
index 9655ca21d02..25e4b4c7663 100644
--- a/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
+++ b/arch/arm/dts/k3-j721e-r5-common-proc-board.dts
@@ -28,7 +28,8 @@
 				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
 		resets = <&k3_reset 202 0>;
 		clocks = <&k3_clks 61 1>;
-		assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>;
+		assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>, <&k3_clks 342 0>;
+		assigned-clock-parents= <0>, <0>, <&k3_clks 342 2>;
 		assigned-clock-rates = <2000000000>, <200000000>;
 		ti,sci = <&dmsc>;
 		ti,sci-proc-id = <32>;
-- 
2.34.1

