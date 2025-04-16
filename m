Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C9CC369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 07:48:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9130182D6F;
	Wed, 16 Apr 2025 09:46:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gz6PQPcq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9458C82D1A; Wed, 16 Apr 2025 09:46:46 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 888D882D27
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 09:46:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53G7khuq266231
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Apr 2025 02:46:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744789603;
 bh=SCvpE7VzJc7CGNDnFe49/kNohdgK6Yr9QBmPF6/Lwqw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=gz6PQPcqAn1UNOtb/ePsDTBjG3PPeA7Ip5qb6utH42UdNcowPqIV4mY5L1nfWsdHq
 sv1k11cv/7DPkkIigct0/P8uiX/0HK78Bc3mu4LFe0TK3UlmUNjiGQUAnqlJZRDL5G
 xK96kNT5zheoZRgeJctvUhE8Xkefu82D9Eq1WF+w=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53G7kgjX023776
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Apr 2025 02:46:42 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Apr 2025 02:46:42 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Apr 2025 02:46:42 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53G7kfLH076000;
 Wed, 16 Apr 2025 02:46:42 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>
Subject: [PATCH v4 8/8] Makefile: update tispl regex to also clean falcon spl
Date: Wed, 16 Apr 2025 13:15:14 +0530
Message-ID: <20250416074515.1452854-9-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416074515.1452854-1-anshuld@ti.com>
References: <20250416074515.1452854-1-anshuld@ti.com>
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
index e83672b1823..1d8fa759141 100644
--- a/Makefile
+++ b/Makefile
@@ -2225,7 +2225,7 @@ CLEAN_FILES += include/autoconf.mk* include/bmp_logo.h include/bmp_logo_data.h \
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

