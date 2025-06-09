Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7E8C61CE8
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 10:27:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8184A82B3D;
	Mon,  9 Jun 2025 12:27:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QnGdwLpn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E752F82B48; Mon,  9 Jun 2025 12:27:27 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAAF282B33
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 12:27:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 559AROnw1970950;
 Mon, 9 Jun 2025 05:27:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749464844;
 bh=jzi6sXIxa1YQDtMypv4fwxoZDOb6YzWZtFArI8LWpmo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=QnGdwLpn/WZZxcCNq3pUamIl520mOiEIM8QVdDEQLja7A5fOuSSNt9uKUU2YSJFTR
 RQJAxzZFs0CWZ4Blargo3Wgpinaz6Qv03WdkjvcbRtpaH5is3dtDUz2yFT2590WgLy
 Dj7SSiU0hmrb9BTC4oiisZVRAkhO7belfDtOHjIQ=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 559ARO8E3738553
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 9 Jun 2025 05:27:24 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 9
 Jun 2025 05:27:23 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 9 Jun 2025 05:27:23 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37]
 (may be forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 559AR65E1263584;
 Mon, 9 Jun 2025 05:27:20 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>
CC: <b-padhi@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
 <j-choudhary@ti.com>, <bb@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <j-keerthy@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH v4 3/3] DONOTMERGE: arm: dts: k3-j784s4-j742s2-main-common:
 Add PBIST_14 node
Date: Mon, 9 Jun 2025 15:57:06 +0530
Message-ID: <20250609102706.2434495-4-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609102706.2434495-1-n-francis@ti.com>
References: <20250609102706.2434495-1-n-francis@ti.com>
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
Changes since v3:
- move from ti,bist-under-test to ti,sci-dev-id

 .../src/arm64/ti/k3-j784s4-j742s2-main-common.dtsi    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/dts/upstream/src/arm64/ti/k3-j784s4-j742s2-main-common.dtsi b/dts/upstream/src/arm64/ti/k3-j784s4-j742s2-main-common.dtsi
index 83bbf94b58d..0c69561b601 100644
--- a/dts/upstream/src/arm64/ti/k3-j784s4-j742s2-main-common.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-j784s4-j742s2-main-common.dtsi
@@ -2668,4 +2668,15 @@
 		power-domains = <&k3_pds 269 TI_SCI_PD_EXCLUSIVE>;
 		status = "disabled";
 	};
+
+	bist_main14: bist@33c0000 {
+		compatible = "ti,j784s4-bist";
+		reg = <0x00 0x033c0000 0x00 0x400>,
+		      <0x00 0x0010c1a0 0x00 0x01c>;
+		reg-names = "cfg", "ctrl_mmr";
+		clocks = <&k3_clks 237 7>;
+		power-domains = <&k3_pds 237 TI_SCI_PD_EXCLUSIVE>;
+		bootph-pre-ram;
+		ti,sci-dev-id = <234>;
+	};
 };
-- 
2.34.1

