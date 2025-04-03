Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D10BC3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 22:01:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE3D582991;
	Thu,  3 Apr 2025 23:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="a+zgKhVY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AD5C82937; Thu,  3 Apr 2025 23:59:44 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6183F828D0
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 23:59:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 533Lxcos3796723
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Apr 2025 16:59:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1743717578;
 bh=dSJlxtt4L4Em3mXWSPDj4Vq9SGfYJ1ZL01z3lDxrSKs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=a+zgKhVYKhmi4RoO/1Ii/VbrFQcQ/0ejoEMZ0wbh8sY/JnqyfvFf7VV3TwrtR1VFF
 wB6hft4koxdi1NrdN5QypXCU1iqqqwC5pwlCtlaBHJ9ofwB7DfDhn+R9duXUJxBJTN
 /gOMZG4hEYI9YwIg0SVydNOJdCQRyHRRqOprlFYs=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 533LxcG3057923
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 3 Apr 2025 16:59:38 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Apr 2025 16:59:39 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Apr 2025 16:59:38 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 533LxbRg089767;
 Thu, 3 Apr 2025 16:59:38 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>
Subject: [PATCH v3 10/10] Makefile: update tispl regex to also clean falcon spl
Date: Fri, 4 Apr 2025 03:29:07 +0530
Message-ID: <20250403215910.1292922-11-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403215910.1292922-1-anshuld@ti.com>
References: <20250403215910.1292922-1-anshuld@ti.com>
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

Build for A53 on am62 platforms now generates tispl_falcon.bin alongside
tispl.bin, edit the regex for `make clean` so that both files are
removed.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 4fca315ecff..2b41264b301 100644
--- a/Makefile
+++ b/Makefile
@@ -2224,7 +2224,7 @@ CLEAN_FILES += include/autoconf.mk* include/bmp_logo.h include/bmp_logo_data.h \
 	       include/config.h include/generated/env.* drivers/video/u_boot_logo.S \
 	       tools/version.h u-boot* MLO* SPL System.map fit-dtb.blob* \
 	       u-boot-ivt.img.log u-boot-dtb.imx.log SPL.log u-boot.imx.log \
-	       lpc32xx-* bl31.c bl31.elf bl31_*.bin image.map tispl.bin* \
+	       lpc32xx-* bl31.c bl31.elf bl31_*.bin image.map tispl*.bin* \
 	       idbloader.img flash.bin flash.log defconfig keep-syms-lto.c \
 	       mkimage-out.spl.mkimage mkimage.spl.mkimage imx-boot.map \
 	       itb.fit.fit itb.fit.itb itb.map spl.map mkimage-out.rom.mkimage \
-- 
2.49.0

