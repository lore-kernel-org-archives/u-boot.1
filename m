Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9B4C54E49
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 09:13:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEA6087C0A;
	Thu,  7 Mar 2024 10:10:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="rVJou6Ks";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB7FE87E6C; Thu,  7 Mar 2024 10:10:32 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B94B87E03
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 10:10:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
From: Alexander Dahl <ada@thorsis.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1709802616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HpygCROxwXeDRgXstUHxFdSmQ6N9fpUk6wuQSCbDdY4=;
 b=rVJou6Ks6NHcql6VcwdEbeDCSw1772J0eAsxi1tZvcETjmr9ZH4Ga8wo7fa4iUEWnKkzfR
 qTvtdZ1rDFqdcQ217shgVynrwS5IUTleHSrc/qLpFvgzC2aMXYxt30V70srCTVCWbpTSlU
 n7xmxPO1B+HyRbWLnnOU7Okywrpcgt2kqhP7T6PfW7jBf0C4ukpHTjrxsJEWWFYwA1o0m/
 wDRX1X85j1CEKIzZmc2g1YnaggvzbgrdZ31ZL9wLtzAo0ekO9mkXbYsneCw13hTtWBkOgw
 mwocASIjEdBGYtRx8ftQH0lepfUOXt+yKN0teIVC8CRNyj/awCE9J4VQoOEY3Q==
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, u-boot@lists.denx.de
Subject: [PATCH 2/4] mtd: nand: raw: Port another option flag from Linux
Date: Thu,  7 Mar 2024 10:10:12 +0100
Message-Id: <20240307091014.39796-3-ada@thorsis.com>
In-Reply-To: <20240307091014.39796-1-ada@thorsis.com>
References: <20240307091014.39796-1-ada@thorsis.com>
Content-Transfer-Encoding: 8bit
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

Introduced in upstream Linux with commit 7a08dbaedd365 for release v5.0.

When the new atmel nand driver was backported to U-Boot with commit
6a8dfd57220d ("nand: atmel: Add DM based NAND driver") that definition
was added to the driver instead of the header file.  Move it over to the
other definitions with the same help text it has in Linux.

Code actually using this has not been ported over to raw nand base yet.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/mtd/nand/raw/atmel/nand-controller.c | 2 --
 include/linux/mtd/rawnand.h                  | 7 +++++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index 0e0441472b8..e06523f3298 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1429,8 +1429,6 @@ static int atmel_nand_setup_data_interface(struct mtd_info *mtd, int csline,
 	return nc->caps->ops->setup_data_interface(nand, csline, conf);
 }
 
-#define NAND_KEEP_TIMINGS       0x00800000
-
 static void atmel_nand_init(struct atmel_nand_controller *nc,
 			    struct atmel_nand *nand)
 {
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index fb002ae6411..4abaf4734cf 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -249,6 +249,13 @@ enum nand_ecc_algo {
  */
 #define NAND_USE_BOUNCE_BUFFER	0x00100000
 
+/*
+ * Do not try to tweak the timings at runtime. This is needed when the
+ * controller initializes the timings on itself or when it relies on
+ * configuration done by the bootloader.
+ */
+#define NAND_KEEP_TIMINGS	0x00800000
+
 /* Options set by nand scan */
 /* bbt has already been read */
 #define NAND_BBT_SCANNED	0x40000000
-- 
2.39.2

