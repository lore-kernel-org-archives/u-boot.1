Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1A7C25B4F
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 07:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D682F886E9;
	Wed,  8 May 2024 09:26:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JOlZI1Nn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD6B088719; Wed,  8 May 2024 09:26:48 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BD84886E9
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 09:26:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4487QilK120999;
 Wed, 8 May 2024 02:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715153204;
 bh=MXIgRPIP4WonxtNXNyyi65v/NWwA1NIZZVnnF1Rasq4=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=JOlZI1Nn68CZ3yRJgk5wa/T35cMKMyjsRhVZEOrlAp79zv30WqCKYcvP+SY+d5wK7
 5EUkpO+jWTfkLMHXHe8NAB6/zbiUQhdAjBBArxX5A8efC24a/WRPudDkyl5Tm+8qi2
 fgXuu3vtGCMltqwTXF6AAJ5/K8vQZt686TUgTYuE=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4487QiWW104020
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 8 May 2024 02:26:44 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 8
 May 2024 02:26:43 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 8 May 2024 02:26:43 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4487QRJw015339;
 Wed, 8 May 2024 02:26:40 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Wed, 8 May 2024 12:56:28 +0530
Subject: [PATCH 4/6] arch: arm: dts: k3-am68-sk-r5: Sync with J721s2 R5
 file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240508-b4-upstream-j721s2-of-upstream-v1-4-ed0933172410@ti.com>
References: <20240508-b4-upstream-j721s2-of-upstream-v1-0-ed0933172410@ti.com>
In-Reply-To: <20240508-b4-upstream-j721s2-of-upstream-v1-0-ed0933172410@ti.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Alper Nebi
 Yasak <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishanth
 Menon <nm@ti.com>, Andrew Davis <afd@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Aniket Limaye <a-limaye@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715153187; l=1094;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=9lvf1QXotPguqvgpJVOFV7vZ//HxRxaIXADYNzYMF0k=;
 b=hPmE+p38pTnNYJ1IgM3CC39D75ZoP7ZIdzmcxFbbivymj+yECwMaHRMCjE+vSYxkvXcBRdsQZ
 xgQcRGsv+wWA+bJk+7UaGMc0p2oRDkTm5BLoVM9BSNVW2xPHjcBm3vZ
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

Update the file with the required nodes from J721s2 R5 file to start
using k3-am68-sk-r5 file for AM68.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 arch/arm/dts/k3-am68-sk-r5-base-board.dts | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/k3-am68-sk-r5-base-board.dts b/arch/arm/dts/k3-am68-sk-r5-base-board.dts
index 695aadc287bd..038b08dc3e01 100644
--- a/arch/arm/dts/k3-am68-sk-r5-base-board.dts
+++ b/arch/arm/dts/k3-am68-sk-r5-base-board.dts
@@ -24,7 +24,8 @@
 		compatible = "ti,am654-rproc";
 		reg = <0x0 0x00a90000 0x0 0x10>;
 		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
-				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>;
+				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>,
+				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
 		resets = <&k3_reset 202 0>;
 		clocks = <&k3_clks 61 1>;
 		assigned-clocks = <&k3_clks 61 1>, <&k3_clks 202 0>;
@@ -54,10 +55,12 @@
 
 &secure_proxy_mcu {
 	bootph-pre-ram;
+	status = "okay";
 };
 
 &secure_proxy_sa3 {
 	bootph-pre-ram;
+	status = "okay";
 };
 
 &cbass_mcu_wakeup {

-- 
2.43.2

