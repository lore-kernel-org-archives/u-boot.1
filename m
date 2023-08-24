Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CEFC3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 03:11:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14C9A8656A;
	Thu, 24 Aug 2023 05:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iIuBadGf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7683C86569; Thu, 24 Aug 2023 05:11:18 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA5DA8651E
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 05:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37O3BAIs097613;
 Wed, 23 Aug 2023 22:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692846670;
 bh=GtEqeqXa7mr40QVRyhb1eOBVz/3Ypg6y6zzWc9XBUh8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=iIuBadGfTyG/F3eGWzHoSZ7I9l+ELUUjlf49Y/fTWFQEXzTdazHHlwUhblSDtP5Q7
 pU6CCRLjQWp97BGMg3U3kkcL5P6GpUEm3668Q7OvJ4+i0YmawCogLNdGvNsEJ27Xz1
 Q6sDVy/mD6io1gLNkTj5y0PunxgJfBGifIfCI//A=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37O3BA0D090226
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Aug 2023 22:11:10 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Aug 2023 22:11:09 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Aug 2023 22:11:09 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37O3B9iW015460;
 Wed, 23 Aug 2023 22:11:09 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, Simon
 Glass <sjg@google.com>
CC: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V5 02/17] include: configs: am62x_evm: Drop unused SDRAM
 address
Date: Wed, 23 Aug 2023 22:10:46 -0500
Message-ID: <20230824031101.3460411-3-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230824031101.3460411-1-nm@ti.com>
References: <20230824031101.3460411-1-nm@ti.com>
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

Drop unused macro. This was meant for a second region of DDR which we
do not need for AM62x evm configurations.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
New patch (part of bootstd transition)

 include/configs/am62x_evm.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/configs/am62x_evm.h b/include/configs/am62x_evm.h
index 44180dc7687b..379e0c13a395 100644
--- a/include/configs/am62x_evm.h
+++ b/include/configs/am62x_evm.h
@@ -12,9 +12,6 @@
 #include <config_distro_bootcmd.h>
 #include <env/ti/mmc.h>
 
-/* DDR Configuration */
-#define CFG_SYS_SDRAM_BASE1		0x880000000
-
 /* Now for the remaining common defines */
 #include <configs/ti_armv7_common.h>
 
-- 
2.40.0

