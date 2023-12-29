Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF1FC47073
	for <u-boot@archiver.kernel.org>; Fri, 29 Dec 2023 17:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 445A387C1F;
	Fri, 29 Dec 2023 18:47:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oO0fzoxn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBA9087B82; Fri, 29 Dec 2023 18:47:21 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4547F87BC2
 for <u-boot@lists.denx.de>; Fri, 29 Dec 2023 18:47:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl2Tr006049;
 Fri, 29 Dec 2023 11:47:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1703872022;
 bh=lOq0LVFEBpn1xaq8Xame7f0+mGA/xBRAI0fbJmC9p68=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=oO0fzoxnIprsByd3i/hEPEYuz7b8VWzWtrQUclfb5WKBEBK22rrEEdQJpL+Nhl0EB
 UVbQ8IFYBDwQGmJlvsMXmwTYN/ebn0HHnT8A6l6zfu28V4a5V38UZ+N4TGYEtJjNoV
 dFrRCf2Gg7VwwAKTRSf5BkLvQBw7DSUTOQVCX5Xs=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BTHl2ma115383
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Dec 2023 11:47:02 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Dec 2023 11:47:01 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Dec 2023 11:47:01 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BTHl16V005107;
 Fri, 29 Dec 2023 11:47:01 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Martyn Welch <martyn.welch@collabora.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon
 Glass <sjg@chromium.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 24/26] arm: dts: k3-am654: move dummy_clock to root node
Date: Fri, 29 Dec 2023 11:47:21 -0600
Message-ID: <20231229174656.634065-52-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229174656.634065-28-bb@ti.com>
References: <20231229174656.634065-28-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1222; i=bb@ti.com;
 h=from:subject; bh=EgKWDQhy0J0jYUdfpUvxuTtSVIgB6NL8JxmZjGJCVkw=;
 b=owNCWmg5MUFZJlNZZo5dVQAAcP////57e+N+3c378PNN/1e3v3c32+bTnXO//Or/iz9r0d6wA
 RmYHagPUA0aaANDQANAAAAGgAA0DIDQ0NAAZGgNB6gPU9QaNqPSPTU02oYYUQZpNGEaDQ000ZAG
 ho000AyaaaaNGgMIGgNDIyHomIYJk0xAAAAaBoYIZDQZI2piNGQeSaNG0gbUaGjI0MTQyAGg0NG
 gA0ZlBoaPSBkBoAaAGQNAAAaABB3C7kanKqsgfRLBGQ5UoyAkD4pZyVUECwCzWfTxwMDS66mjdk
 iBNUWfGAE/S5IZJKQRiLqnAIQZ/HVzDJTjMHVjA75Mm4iOApnDu3QQ6vybUJgQ4RfLMSx+SDmdy
 TbTGBBbQAGhOTVBqsR7BCpHzd77jl3tcG4sCN7butR3I9fRD3dHVlMFvWdl1GAA46vhPcAD0h5N
 VM+Toghc+9cw2eIxpftsfrcjSZt3zotuMYJ6ofvxCs9+HkSBjBksFI9SuJBZ7aPP8jggTZKtTL2
 SFQ0nRk9kdtxTB1KSx+FXoKGYB4ivze6L1xiERRBi0NGJBMF9KEdbuwx/j4JtOgOK4fDaPYk436
 f0+xZEtc5RsgF06p1TJGcQAsIGBBrCUoEmOfQy56zWNQzDcmWXFXJZl+2CoSi380CB+tNxLNJN/
 xdyRThQkGaOXVU=
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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

The dummy_clock node is used to help the drivers probe the IO needed to
setup consoles and boot media to load firmware into the SoC.

This dummy_clock isn't a device that exists nor does it exist in the
mcu domain. So move it from cbass_mcu to the root node to avoid any
confusion.

Tested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/k3-am654-r5-base-board.dts | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
index 9926981c661a0..b27b2b05ad840 100644
--- a/arch/arm/dts/k3-am654-r5-base-board.dts
+++ b/arch/arm/dts/k3-am654-r5-base-board.dts
@@ -30,6 +30,13 @@
 		ti,sci-host-id = <10>;
 		bootph-pre-ram;
 	};
+
+	clk_200mhz: dummy_clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <200000000>;
+		bootph-pre-ram;
+	};
 };
 
 &cbass_mcu {
@@ -51,13 +58,6 @@
 		mbox-names = "tx", "rx";
 		bootph-pre-ram;
 	};
-
-	clk_200mhz: dummy_clock {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <200000000>;
-		bootph-pre-ram;
-	};
 };
 
 /*
-- 
2.43.0

