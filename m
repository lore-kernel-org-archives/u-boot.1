Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8078C5475B
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 18:41:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3378487FFB;
	Tue, 20 Feb 2024 19:40:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="R7al0zt1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECA3A88006; Tue, 20 Feb 2024 19:40:18 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 139E787FF2
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 19:39:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41KIdrXl107912;
 Tue, 20 Feb 2024 12:39:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708454393;
 bh=3eL6qtnzd1Oeg3pag9oYfJu7ow6uwnEGthh4nzh/eKg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=R7al0zt1r1f/gT3A1TezteGJg+kbaUuedMmb01d/rL7pFHGXMvfSvtNbF2+ShfK1X
 20v9KtDJRJtB17lXzKGiGaUQZpph1B/iv8fEufqlsg2jb3EJQuIribckN5sGW57N5U
 6aCKrCd/SVTGqMajXNf4kIMJSkFBBaj6533KhYk8=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41KIdrie017473
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 20 Feb 2024 12:39:53 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Feb 2024 12:39:53 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Feb 2024 12:39:53 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41KIdrQb006246;
 Tue, 20 Feb 2024 12:39:53 -0600
From: Nishanth Menon <nm@ti.com>
To: Robert Nelson <robertcnelson@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 4/5] board: beagle: beagleplay: Configure debounce registers
Date: Tue, 20 Feb 2024 12:39:51 -0600
Message-ID: <20240220183952.3614252-5-nm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220183952.3614252-1-nm@ti.com>
References: <20240220183952.3614252-1-nm@ti.com>
MIME-Version: 1.0
Organization: Texas Instruments, Inc.
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

Configure the debounce configuration that makes sense for BeaglePlay
usage model.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since V1:
* No change

V1: https://lore.kernel.org/r/20240212155332.541949-5-nm@ti.com

 board/beagle/beagleplay/beagleplay.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/board/beagle/beagleplay/beagleplay.c b/board/beagle/beagleplay/beagleplay.c
index 2adb2517ef00..fe1c4f920329 100644
--- a/board/beagle/beagleplay/beagleplay.c
+++ b/board/beagle/beagleplay/beagleplay.c
@@ -59,8 +59,32 @@ static void crystal_32k_enable(void)
 	}
 }
 
+static void debounce_configure(void)
+{
+	/* Configure debounce one time from R5 */
+	if (IS_ENABLED(CONFIG_CPU_V7R)) {
+		/*
+		 * Setup debounce time registers.
+		 * arbitrary values. Times are approx
+		 */
+		/* 1.9ms debounce @ 32k */
+		writel(0x1, CTRLMMR_DBOUNCE_CFG(1));
+		/* 5ms debounce @ 32k */
+		writel(0x5, CTRLMMR_DBOUNCE_CFG(2));
+		/* 20ms debounce @ 32k */
+		writel(0x14, CTRLMMR_DBOUNCE_CFG(3));
+		/* 46ms debounce @ 32k */
+		writel(0x18, CTRLMMR_DBOUNCE_CFG(4));
+		/* 100ms debounce @ 32k */
+		writel(0x1c, CTRLMMR_DBOUNCE_CFG(5));
+		/* 156ms debounce @ 32k */
+		writel(0x1f, CTRLMMR_DBOUNCE_CFG(6));
+	}
+}
+
 void spl_board_init(void)
 {
 	crystal_32k_enable();
+	debounce_configure();
 }
 #endif
-- 
2.43.0

