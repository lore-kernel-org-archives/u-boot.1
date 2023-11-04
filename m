Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACABC4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 08:03:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED7A187113;
	Sat,  4 Nov 2023 09:02:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ohHjPBsY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0885087115; Sat,  4 Nov 2023 09:01:57 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 464D887077
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 09:01:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A481g0l019483;
 Sat, 4 Nov 2023 03:01:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699084902;
 bh=ZadigocHodLj7yF0wxLCUi1M40fI6ZTOlt5wvaP2RWM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ohHjPBsYj4uIWLXqRgj+o/eFQXp360apTQER7bVfZsUO9i/Rvl4qgmtZD9CvQ7Psr
 IS15FAeNAAs2vKMrAKhADKaEi+JKlkFsnFKYs2ApvRQO5s73GdBc/RoWi33Pf+99xp
 dHXXNTx4XBVqpIZA6YH6q89118I0rjFJlUvRxdcs=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A481gfW025401
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 4 Nov 2023 03:01:42 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 4
 Nov 2023 03:01:42 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 4 Nov 2023 03:01:42 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A481gus006879;
 Sat, 4 Nov 2023 03:01:42 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>, <bb@ti.com>, <praneeth@ti.com>
Subject: [PATCH 5/5] board: Move omap3 beagle under beagle vendor folder
Date: Sat, 4 Nov 2023 03:01:37 -0500
Message-ID: <20231104080137.9628-6-nm@ti.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20231104080137.9628-1-nm@ti.com>
References: <20231104080137.9628-1-nm@ti.com>
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

Move the omap3 beagle to the beagle vendor folder representing
BeagleBoard.org platforms.

Suggested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap3/Kconfig       | 2 +-
 board/{ti => beagle}/beagle/Kconfig     | 2 +-
 board/{ti => beagle}/beagle/MAINTAINERS | 2 +-
 board/{ti => beagle}/beagle/Makefile    | 0
 board/{ti => beagle}/beagle/beagle.c    | 0
 board/{ti => beagle}/beagle/beagle.h    | 0
 board/{ti => beagle}/beagle/led.c       | 0
 7 files changed, 3 insertions(+), 3 deletions(-)
 rename board/{ti => beagle}/beagle/Kconfig (88%)
 rename board/{ti => beagle}/beagle/MAINTAINERS (84%)
 rename board/{ti => beagle}/beagle/Makefile (100%)
 rename board/{ti => beagle}/beagle/beagle.c (100%)
 rename board/{ti => beagle}/beagle/beagle.h (100%)
 rename board/{ti => beagle}/beagle/led.c (100%)

diff --git a/arch/arm/mach-omap2/omap3/Kconfig b/arch/arm/mach-omap2/omap3/Kconfig
index 3e3e7bd259ee..bd524f8c9f95 100644
--- a/arch/arm/mach-omap2/omap3/Kconfig
+++ b/arch/arm/mach-omap2/omap3/Kconfig
@@ -152,7 +152,7 @@ config SYS_SOC
 	default "omap3"
 
 source "board/logicpd/am3517evm/Kconfig"
-source "board/ti/beagle/Kconfig"
+source "board/beagle/beagle/Kconfig"
 source "board/timll/devkit8000/Kconfig"
 source "board/ti/omap3evm/Kconfig"
 source "board/isee/igep00x0/Kconfig"
diff --git a/board/ti/beagle/Kconfig b/board/beagle/beagle/Kconfig
similarity index 88%
rename from board/ti/beagle/Kconfig
rename to board/beagle/beagle/Kconfig
index c2eff9e71b0c..eade599dc934 100644
--- a/board/ti/beagle/Kconfig
+++ b/board/beagle/beagle/Kconfig
@@ -4,7 +4,7 @@ config SYS_BOARD
 	default "beagle"
 
 config SYS_VENDOR
-	default "ti"
+	default "beagle"
 
 config SYS_CONFIG_NAME
 	default "omap3_beagle"
diff --git a/board/ti/beagle/MAINTAINERS b/board/beagle/beagle/MAINTAINERS
similarity index 84%
rename from board/ti/beagle/MAINTAINERS
rename to board/beagle/beagle/MAINTAINERS
index c1d81d4174e9..c7fa87acfcc8 100644
--- a/board/ti/beagle/MAINTAINERS
+++ b/board/beagle/beagle/MAINTAINERS
@@ -1,6 +1,6 @@
 BEAGLE BOARD
 M:	Tom Rini <trini@konsulko.com>
 S:	Maintained
-F:	board/ti/beagle/
+F:	board/beagle/beagle/
 F:	include/configs/omap3_beagle.h
 F:	configs/omap3_beagle_defconfig
diff --git a/board/ti/beagle/Makefile b/board/beagle/beagle/Makefile
similarity index 100%
rename from board/ti/beagle/Makefile
rename to board/beagle/beagle/Makefile
diff --git a/board/ti/beagle/beagle.c b/board/beagle/beagle/beagle.c
similarity index 100%
rename from board/ti/beagle/beagle.c
rename to board/beagle/beagle/beagle.c
diff --git a/board/ti/beagle/beagle.h b/board/beagle/beagle/beagle.h
similarity index 100%
rename from board/ti/beagle/beagle.h
rename to board/beagle/beagle/beagle.h
diff --git a/board/ti/beagle/led.c b/board/beagle/beagle/led.c
similarity index 100%
rename from board/ti/beagle/led.c
rename to board/beagle/beagle/led.c
-- 
2.37.2

