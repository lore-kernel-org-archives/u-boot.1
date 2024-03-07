Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099E0C54E49
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 09:16:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D097287F87;
	Thu,  7 Mar 2024 10:11:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="kYU0V4Y/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65D5387E63; Thu,  7 Mar 2024 10:10:34 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3448A87C0A
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
 bh=6kmjj9hIxPY5EjRg9Xshnk2BmUaj9gQt0E3a6IZtQ88=;
 b=kYU0V4Y/BWXlTcXQiJz4zRqiNleHzyuQ8uED/WNCkd+cQwrCWhD8WCPEdG7DB8xgrJOsHO
 Vrn5wNokXxA1QMffjdop3GlFh232skQ+v9ktwggkO8WJjNMhldUwMBBQWfbEB24Ta079/4
 zt/hpjztPBfaZfZiyAI4peEtREFyR4AsEjwYAldQmHdh6GUNZRFSfINEk5BYWRpzXiDQwo
 SX4xfAj8ZgQ7hbmLp1cGRUfE4j5RRupbP2/zvuXKxCg2UzFp9GZksBtDpafuLaymkzc+k5
 MHAKcFnaz1k3QjFiRoWC9QWFUBeLWW9eM/dtEnljOXQoAiEVkDS9zZYA7i4gIw==
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, u-boot@lists.denx.de
Subject: [PATCH 1/4] mtd: nand: raw: Use macro nand_to_mtd() where appropriate
Date: Thu,  7 Mar 2024 10:10:11 +0100
Message-Id: <20240307091014.39796-2-ada@thorsis.com>
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

In every other place in this file the macro is used, make it consistent.

Fixes: 9d1806fadc24 ("mtd: nand: Get rid of mtd variable in function calls")
Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/mtd/nand/raw/nand_base.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index c40a0f23d7b..688d17ba3c2 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4118,7 +4118,7 @@ static int nand_get_bits_per_cell(u8 cellinfo)
  */
 void nand_decode_ext_id(struct nand_chip *chip)
 {
-	struct mtd_info *mtd = &chip->mtd;
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	int extid;
 	/* The 3rd id byte holds MLC / multichip data */
 	chip->bits_per_cell = nand_get_bits_per_cell(chip->id.data[2]);
@@ -4185,7 +4185,7 @@ static int nand_manufacturer_init(struct nand_chip *chip)
  */
 static void nand_decode_id(struct nand_chip *chip, struct nand_flash_dev *type)
 {
-	struct mtd_info *mtd = &chip->mtd;
+	struct mtd_info *mtd = nand_to_mtd(chip);
 
 	mtd->erasesize = type->erasesize;
 	mtd->writesize = type->pagesize;
@@ -4265,7 +4265,7 @@ static const struct nand_manufacturer *nand_get_manufacturer_desc(u8 id)
 int nand_detect(struct nand_chip *chip, int *maf_id,
 		int *dev_id, struct nand_flash_dev *type)
 {
-	struct mtd_info *mtd = &chip->mtd;
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	const struct nand_manufacturer *manufacturer_desc;
 	int busw, ret;
 	u8 *id_data = chip->id.data;
-- 
2.39.2

