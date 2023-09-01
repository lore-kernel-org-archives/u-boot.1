Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409EACA0FE6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 10:39:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6514F868B1;
	Fri,  1 Sep 2023 12:39:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gbr1YWd0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9AAA8688B; Fri,  1 Sep 2023 12:39:22 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5615A8669D
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 12:39:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-jain1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 381AdGTK009272;
 Fri, 1 Sep 2023 05:39:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693564756;
 bh=kovpGWgynjPJfJnQG853bMesC96RDuB6neFcZXOUYDA=;
 h=From:To:CC:Subject:Date;
 b=gbr1YWd0enKTblEjVqk+MkBHoJ8Rv3xQe1pPM806MYOKlDYOnVNy1vcNTvyFFlVbX
 wuoxLYZ4TdvLk5R6d52a88g4qZGgtu7oAFkYrNGzXoC7odysgr8ez6IDNFqldOjnDt
 ykli8JdcN8Md2VF5s5ZsYum4aDvZwr9s2CZ4iGDE=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 381AdGWI007998
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 1 Sep 2023 05:39:16 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Sep 2023 05:39:16 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Sep 2023 05:39:16 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 381AdFRD119053;
 Fri, 1 Sep 2023 05:39:16 -0500
From: Nikhil M Jain <n-jain1@ti.com>
To: <u-boot@lists.denx.de>, <devarsht@ti.com>, <trini@konsulko.com>
CC: <vigneshr@ti.com>, Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH] tools: logos: Rename TI logo files
Date: Fri, 1 Sep 2023 16:09:13 +0530
Message-ID: <20230901103913.38407-1-n-jain1@ti.com>
X-Mailer: git-send-email 2.34.1
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

Change the file name from ti.gz and ti.bmp to ti_logos_414x97_32bpp to
help user understand the resolution and identify the logo files when
placed in the boot partition and update the splashfile name with the
same in .env file.

Signed-off-by: Nikhil M Jain <n-jain1@ti.com>
---
 board/ti/am62x/am62x.env                           |   2 +-
 tools/logos/{ti.bmp => ti_logo_414x97_32bpp.bmp}   | Bin
 tools/logos/{ti.gz => ti_logo_414x97_32bpp.bmp.gz} | Bin
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/logos/{ti.bmp => ti_logo_414x97_32bpp.bmp} (100%)
 rename tools/logos/{ti.gz => ti_logo_414x97_32bpp.bmp.gz} (100%)

diff --git a/board/ti/am62x/am62x.env b/board/ti/am62x/am62x.env
index f2dc87893a..ece9eacc08 100644
--- a/board/ti/am62x/am62x.env
+++ b/board/ti/am62x/am62x.env
@@ -17,7 +17,7 @@ bootpart=1:2
 bootdir=/boot
 rd_spec=-
 
-splashfile=ti.gz
+splashfile=ti_logo_414x97_32bpp.bmp.gz
 splashimage=0x80200000
 splashpos=m,m
 splashsource=sf
diff --git a/tools/logos/ti.bmp b/tools/logos/ti_logo_414x97_32bpp.bmp
similarity index 100%
rename from tools/logos/ti.bmp
rename to tools/logos/ti_logo_414x97_32bpp.bmp
diff --git a/tools/logos/ti.gz b/tools/logos/ti_logo_414x97_32bpp.bmp.gz
similarity index 100%
rename from tools/logos/ti.gz
rename to tools/logos/ti_logo_414x97_32bpp.bmp.gz
-- 
2.34.1

