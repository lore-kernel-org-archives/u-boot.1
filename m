Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC479D6ACE4
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 14:54:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C6DE89634;
	Wed, 27 Nov 2024 15:54:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="U6LQUmrM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EFFA89672; Wed, 27 Nov 2024 15:53:59 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D2F1895A0
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 15:53:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4ARErtev1013224
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Nov 2024 08:53:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732719235;
 bh=7uDQk552uJbnd8B8UMSowLeiMMosEDdVFBqX8hjaPpE=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=U6LQUmrMo7MoRRoVrp9g4JKDXjrHMg7yiQvhtSzmSLBSW2ztw1mJeAvJRlCU+xeOV
 oM9ljd2z1eN91Szn/ngwMi8sgjL13+7QJCCjgk1OeuIMoQ9hHiNZX5qBvteTgG9OyP
 DL7XJDzWnHTVJim3R9fGyC++oPEvUVjCanOVPpHQ=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4ARErtXa028394
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Nov 2024 08:53:55 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Nov 2024 08:53:55 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Nov 2024 08:53:55 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ARErlpD051687;
 Wed, 27 Nov 2024 08:53:52 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>
CC: <b-padhi@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
 <j-choudhary@ti.com>, <bb@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <j-keerthy@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 1/4] arm: dts: k3-j784s4-main: Add PBIST_14 node
Date: Wed, 27 Nov 2024 20:23:43 +0530
Message-ID: <20241127145346.2609868-2-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241127145346.2609868-1-n-francis@ti.com>
References: <20241127145346.2609868-1-n-francis@ti.com>
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

Add DT node for PBIST_14 that is responsible for triggering the PBIST
self-tests for the MAIN_R5_2_x cores.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi b/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi
index d4ac1c9872a..21e2777cd9d 100644
--- a/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-j784s4-main.dtsi
@@ -2782,4 +2782,16 @@
 		power-domains = <&k3_pds 269 TI_SCI_PD_EXCLUSIVE>;
 		status = "disabled";
 	};
+
+	bist_main14: bist@33c0000 {
+		compatible = "ti,j784s4-bist";
+		reg-names = "cfg", "ctrl_mmr";
+		reg = <0x00 0x033c0000 0x00 0x400>,
+			  <0x00 0x0010c1a0 0x00 0x01c>;
+		clocks = <&k3_clks 237 7>;
+		power-domains = <&k3_pds 237 TI_SCI_PD_EXCLUSIVE>;
+		bootph-pre-ram;
+		ti,bist-instance = <14>;
+		cores-under-test = <&main_r5fss2_core0>, <&main_r5fss2_core1>;
+	};
 };
-- 
2.34.1

