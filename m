Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E594C6FA8F
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 22:15:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47E85864ED;
	Wed, 30 Aug 2023 00:15:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="yLSJ6KZq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 306D8864EC; Wed, 30 Aug 2023 00:15:09 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6611864EC
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 00:15:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37TMF0vN067089;
 Tue, 29 Aug 2023 17:15:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693347300;
 bh=Ly0WR6eKTTxkr1gyCsztYfGg02RM6QW7oFBr7zJPg10=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=yLSJ6KZqgyPkHp8Fq4CFp5Zt8p2pE0r09qzkKmz/RBHLejJyHnleYXv7cZIYKvsWO
 psbXb6WFBScRExQwFPlRTBq1Zb0z3ZViennBev5mJS0ie1wmjHO85RIG+xHKqxCA2U
 WrZ8Tj0MR+Xwo0hcKX+/Za7mU7TD4JvkX5ec3OM8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37TMF0J2069065
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 29 Aug 2023 17:15:00 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 29
 Aug 2023 17:14:59 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 29 Aug 2023 17:14:59 -0500
Received: from fllv0039.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37TMEwMm028583;
 Tue, 29 Aug 2023 17:14:59 -0500
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [RFC PATCH 1/2] Makefile: Run defconfig files through the C
 preprocessor
Date: Tue, 29 Aug 2023 17:14:56 -0500
Message-ID: <20230829221457.101469-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230829221457.101469-1-afd@ti.com>
References: <20230829221457.101469-1-afd@ti.com>
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

This allows us to use some of the normal preprocessor directives inside
defconfig files. Such as #define and #include.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 scripts/kconfig/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 12e525ee31f..16db9b7cf60 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -93,7 +93,8 @@ endif
 endif
 
 %_defconfig: $(obj)/conf
-	$(Q)$< $(silent) --defconfig=arch/$(SRCARCH)/configs/$@ $(Kconfig)
+	$(Q)$(CPP) -nostdinc -I $(srctree) -undef -x assembler-with-cpp $(srctree)/arch/$(SRCARCH)/configs/$@ -o generated_defconfig
+	$(Q)$< $(silent) --defconfig=generated_defconfig $(Kconfig)
 
 # Added for U-Boot (backward compatibility)
 %_config: %_defconfig
-- 
2.39.2

