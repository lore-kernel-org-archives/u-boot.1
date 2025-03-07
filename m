Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7145BC19F32
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 07:57:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F1E78144A;
	Fri,  7 Mar 2025 08:56:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VnAJbiul";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68EF981703; Fri,  7 Mar 2025 08:56:33 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6241381668
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 08:56:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5277uT2Y3903689
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Mar 2025 01:56:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741334189;
 bh=TJkSEZHhkCMej6xOcSZQegf5tiJX3uHUdX5bqlIgXbQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=VnAJbiulTYkILpXN8ifU6YTzsRmEzJPB25V7h+J6yAcwsfKTcZ3eSE5b0ynV752Q4
 171844vWi12jMEwSPP4+tiDeJP3Rm9Sv/+KR0uMtBUA4BTOF5AFrS3ICSX7w7j5jtK
 YPzhuzLvuzut40a4Hni/YVaH0Y6NIek3muHBOZ4Q=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5277uTLq105420
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 7 Mar 2025 01:56:29 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Mar 2025 01:56:29 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Mar 2025 01:56:29 -0600
Received: from localhost (a0543016.dhcp.ti.com [172.24.227.86])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5277uSeK086125;
 Fri, 7 Mar 2025 01:56:29 -0600
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>
Subject: [PATCH 08/10] configs: ti_armv7_common: add cfgs for SPI falcon boot
Date: Fri, 7 Mar 2025 13:25:36 +0530
Message-ID: <20250307075541.2571104-9-anshuld@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307075541.2571104-1-anshuld@ti.com>
References: <20250307075541.2571104-1-anshuld@ti.com>
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

When booting from SPI, only the tispl.bin and tiboot3.bin is loaded from
the SPI. tiboot3.bin is located by the ROM and tispl.bin's offset is
specified by CONFIG_SYS_SPI_U_BOOT_OFFS.

The kernel and args however are loaded from the eMMC or SD and not SPI,
therefore we don't actually make use of these config values at runtime,
they are added to avoid compile time 'undefined identifier' errors when
building with SPL_OS_BOOT enabled.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 include/configs/ti_armv7_common.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/configs/ti_armv7_common.h b/include/configs/ti_armv7_common.h
index 3def7b1027e..f101d10992a 100644
--- a/include/configs/ti_armv7_common.h
+++ b/include/configs/ti_armv7_common.h
@@ -119,6 +119,12 @@
 /* FAT */
 
 /* RAW SD card / eMMC */
+
+/* SPI */
+#define CFG_SYS_SPI_KERNEL_OFFS	0
+#define CFG_SYS_SPI_ARGS_OFFS	0
+#define CFG_SYS_SPI_ARGS_SIZE	0
+
 #endif
 
 /* General parts of the framework, required. */
-- 
2.43.0

