Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DE9C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 12:09:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 505E688F1D;
	Thu, 25 Apr 2024 14:09:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BbdTg+ls";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFB9588F1C; Thu, 25 Apr 2024 14:09:03 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B5F988E6A
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 14:08:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43PC8oae040530;
 Thu, 25 Apr 2024 07:08:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1714046930;
 bh=21znT8ggcsZqZiZmad+LdtPhVgS4vifoSsOlDAuCWI0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=BbdTg+lshZi+bdily+u8lbg8aEaFZ4A+z0kdOVn8RzqqImFeuNkQEk9wANaW0CxeB
 6CLiHzx2OChbqyXgY6LP1J91WkF18Dsg4XqU2B66HEjqdSUWqtF4zOwW7AU4NX+y5Y
 x3ja7ZJPnZqHeZS1YimmuGKDZAcOP8/2zVVqbPDM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43PC8o1r038237
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 25 Apr 2024 07:08:50 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Apr 2024 07:08:49 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Apr 2024 07:08:49 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43PC8mSa061874;
 Thu, 25 Apr 2024 07:08:49 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>, Michal Simek
 <michal.simek@amd.com>, Vignesh Raghavendra <vigneshr@ti.com>, "MD Danish
 Anwar" <danishanwar@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Andreas Dannenberg <dannenberg@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, Bin Meng <bmeng@tinylab.org>, "Sean
 Anderson" <seanga2@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 "Nikhil M Jain" <n-jain1@ti.com>, Wadim Egorov <w.egorov@phytec.de>, "Joao
 Paulo Goncalves" <joao.goncalves@toradex.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Chintan Vankar <c-vankar@ti.com>, Dhruva Gole
 <d-gole@ti.com>, Francesco Dolcini <francesco.dolcini@toradex.com>, "Andrew
 Davis" <afd@ti.com>, Roger Quadros <rogerq@kernel.org>, Maxime Ripard
 <mripard@kernel.org>, Neha Malcom Francis <n-francis@ti.com>, Simon Glass
 <sjg@chromium.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v2 01/10] common: spl: spl: Init DRAM size in R5/A53 SPL
Date: Thu, 25 Apr 2024 17:38:13 +0530
Message-ID: <20240425120822.2048012-2-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425120822.2048012-1-c-vankar@ti.com>
References: <20240425120822.2048012-1-c-vankar@ti.com>
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

Initialize DRAM size in SPL stage since networking requires DDR
to be initialized.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v1:
https://lore.kernel.org/r/20240112064759.1801600-2-s-vadapalli@ti.com/

Changes from v1 to v2:
- Updated dram_init_banksize() function to be called from common section
  instead of board specific function call as suggested by Tom.

 common/spl/spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index e06bc75d36..2a9d58195c 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -718,7 +718,7 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 		initr_watchdog();
 
 	if (IS_ENABLED(CONFIG_SPL_OS_BOOT) || CONFIG_IS_ENABLED(HANDOFF) ||
-	    IS_ENABLED(CONFIG_SPL_ATF))
+	    IS_ENABLED(CONFIG_SPL_ATF) || IS_ENABLED(CONFIG_SPL_NET))
 		dram_init_banksize();
 
 	if (CONFIG_IS_ENABLED(PCI) && !(gd->flags & GD_FLG_DM_DEAD)) {
-- 
2.34.1

