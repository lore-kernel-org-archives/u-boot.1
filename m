Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B109CC5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 10:27:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B245588A2E;
	Mon, 26 Aug 2024 12:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wgGL4pHb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEB0988A31; Mon, 26 Aug 2024 12:25:58 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05D3A88B68
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 12:25:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QAPdOS094269;
 Mon, 26 Aug 2024 05:25:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1724667939;
 bh=Ucj8Kk1crcaQ07Sy776uhRrlGFWv5daOV4IdMGfLTIM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=wgGL4pHbraBprJbkpxQaSytuTsNB2r8wwhBwO0x+ez2kwmQCi4lW8kCwlX1vf8DgF
 0nwubg6xzCwgn3rzexw2BbgoFkwZm83+IZ1Q/uVYXm5Wg96YaLv4PSCe3VFEfhtq+5
 Cumf8rQ2tOuFPwYOsdHx8wnSawW8jKhFyiiGFioE=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QAPdiM024900
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 26 Aug 2024 05:25:39 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 05:25:39 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 05:25:39 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QAPc3Z041898;
 Mon, 26 Aug 2024 05:25:38 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Michal Simek <michal.simek@amd.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Dhruva Gole <d-gole@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>, MD Danish Anwar
 <danishanwar@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Matthias Schiffer" <matthias.schiffer@ew.tq-group.com>, Andreas Dannenberg
 <dannenberg@ti.com>, Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar
 <devarsht@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>, Sean Anderson
 <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Kishon Vijay Abraham I
 <kishon@ti.com>, Andrew Davis <afd@ti.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Wadim Egorov <w.egorov@phytec.de>, "Chintan
 Vankar" <c-vankar@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>, Sumit Garg
 <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v6 11/11] arm64: dts: ti: k3-am62x-sk-common: Add bootph-all
 property in phy_gmii_sel node
Date: Mon, 26 Aug 2024 15:55:15 +0530
Message-ID: <20240826102515.2774296-12-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826102515.2774296-1-c-vankar@ti.com>
References: <20240826102515.2774296-1-c-vankar@ti.com>
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

Add missing bootph-all property for CPSW MAC's PHY node
phy_gmii_sel.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
Link: https://lore.kernel.org/r/20240430085048.3143665-1-c-vankar@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>

[ upstream commit: ba50141137fae205a731005e70687f4a52289050 ]

(cherry picked from commit 2bdd1743a9f6515efe7c3648a25d63b4a9ce4a10)
---

Link to v5:
https://lore.kernel.org/r/20240813105400.4054657-11-c-vankar@ti.com/

Changes from v5 to v6:
- Added Reviewed-by tag from Sumit Garg.

 dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi b/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
index 3c45782ab2b..96378b19c41 100644
--- a/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
+++ b/dts/upstream/src/arm64/ti/k3-am62x-sk-common.dtsi
@@ -128,6 +128,10 @@
 	};
 };
 
+&phy_gmii_sel {
+	bootph-all;
+};
+
 &main_pmx0 {
 	/* First pad number is ALW package and second is AMC package */
 	main_uart0_pins_default: main-uart0-default-pins {
-- 
2.34.1

