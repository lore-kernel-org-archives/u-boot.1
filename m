Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED6CC3DA7F
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 11:49:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FE618880B;
	Mon, 12 Aug 2024 13:49:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TFUlOZph";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1658987B77; Mon, 12 Aug 2024 13:49:12 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A028B8880B
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 13:49:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47CBn0eT049733;
 Mon, 12 Aug 2024 06:49:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723463340;
 bh=DHv8YKthWFGy+5bogwC6CgeroNwHEAQjf7rZ5aXzX5Y=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=TFUlOZphWE5pAaNWEz55zeed3d3yu/1qhIyrMoM+n+xOk0oqzXWW5iGZ5b3kOCD+k
 JhE3BwyQiWSh7eGAoDcDytv5frB+UjHbLBhjLpeILnriTUQZjwmocPcWmzT2JQk0+n
 JjvM0kLT/371PA+s0FrKLC+ujCJoLc2V7Ea/u4Fw=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47CBn0Bl107559
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 12 Aug 2024 06:49:00 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Aug 2024 06:48:59 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Aug 2024 06:48:59 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47CBmxp6129880;
 Mon, 12 Aug 2024 06:48:59 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Michal Simek <michal.simek@amd.com>, Bryan Brattlof <bb@ti.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 "MD Danish Anwar" <danishanwar@ti.com>, Ravi
 Gunasekaran <r-gunasekaran@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>,
 Andreas Dannenberg <dannenberg@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar <devarsht@ti.com>, Sean
 Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Kishon Vijay
 Abraham I <kishon@ti.com>, Andrew Davis <afd@ti.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Wadim Egorov <w.egorov@phytec.de>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Dhruva Gole <d-gole@ti.com>, Chintan Vankar
 <c-vankar@ti.com>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Nishanth Menon <nm@ti.com>, Sumit Garg <sumit.garg@linaro.org>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v4 06/10] arm: mach-k3: am62x: am625_init: Probe AM65 CPSW NUSS
Date: Mon, 12 Aug 2024 17:18:56 +0530
Message-ID: <20240812114856.3843785-1-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812113621.3840652-1-c-vankar@ti.com>
References: <20240812113621.3840652-1-c-vankar@ti.com>
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

From: Kishon Vijay Abraham I <kishon@ti.com>

In order to support Ethernet boot on AM62x, probe AM65 CPSW NUSS
driver in board_init_f().

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v4:
https://lore.kernel.org/r/20240705045030.1141934-7-c-vankar@ti.com/

Changes from v3 to v4:
- No changes.

 arch/arm/mach-k3/am62x/am625_init.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-k3/am62x/am625_init.c b/arch/arm/mach-k3/am62x/am625_init.c
index 72a752d38e..0182c153a6 100644
--- a/arch/arm/mach-k3/am62x/am625_init.c
+++ b/arch/arm/mach-k3/am62x/am625_init.c
@@ -280,6 +280,16 @@ void board_init_f(ulong dummy)
 		if (ret)
 			panic("DRAM init failed: %d\n", ret);
 	}
+
+	if (IS_ENABLED(CONFIG_SPL_ETH) && IS_ENABLED(CONFIG_TI_AM65_CPSW_NUSS) &&
+	    spl_boot_device() == BOOT_DEVICE_ETHERNET) {
+		struct udevice *cpswdev;
+
+		if (uclass_get_device_by_driver(UCLASS_MISC, DM_DRIVER_GET(am65_cpsw_nuss),
+						&cpswdev))
+			printf("Failed to probe am65_cpsw_nuss driver\n");
+	}
+
 	spl_enable_cache();
 
 	fixup_a53_cpu_freq_by_speed_grade();
-- 
2.34.1

