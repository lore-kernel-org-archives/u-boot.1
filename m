Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788B4D73EB0
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 02:18:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDC5E8419D;
	Fri, 30 Jan 2026 03:18:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="VfMSSe89";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50D638419E; Fri, 30 Jan 2026 03:18:09 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1290E8418A
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 03:18:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=andyshrk@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=5t
 cIn2NJ4JKIlBaIjAG4JCb8BWdK5ixB55lATfrM+bY=; b=VfMSSe89VkmXB+w+r0
 KUzsV9vjSTA2v26KAcpukGc/WexpsAgrkraHT87S59DR5gzqUdDSW45Swtk4nbCj
 2gF1wKYY0JJ4jxfh3FEZULR7YREOx4QmDIGxoXUTdagJNAdRHso5TrP6Y0URBMI8
 J7Cyc7L9ktfP7ON7+qjv5CIVo=
Received: from ProDesk-480.. (unknown [])
 by gzsmtp5 (Coremail) with SMTP id QCgvCgBHlHbLFHxpyOAaNQ--.36S2;
 Fri, 30 Jan 2026 10:17:52 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: ada@thorsis.com, dario.binacchi@amarulasolutions.com,
 michael@amarulasolutions.com, trini@konsulko.com, u-boot@lists.denx.de
Cc: Andy Yan <andyshrk@163.com>
Subject: [PATCH] mtd: nand: raw: atmel: Access device ofnode through functions
Date: Fri, 30 Jan 2026 10:17:37 +0800
Message-ID: <20260130021745.391602-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: QCgvCgBHlHbLFHxpyOAaNQ--.36S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXry5CF13XrWrCFWkGw45Wrg_yoWrtw17pa
 yUJay3tw40qF4Y9FWIkFWDGanIy3WktFZ8J3yxX34Iv3ZxXFyUtry5CF1Ik3WrCFWxu3Wa
 vFW0qa4DuF4rAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pMfOw-UUUUU=
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbCxhCyEWl8FNBscgAA36
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

According to commit 84a42ae36683 ("dm: core: Rename device node to indicate it is private")

node_ should not be aaccess outside driver model.

Signed-off-by: Andy Yan <andyshrk@163.com>
---

 drivers/mtd/nand/raw/atmel/nand-controller.c | 18 +++++++++---------
 drivers/mtd/nand/raw/atmel/pmecc.c           |  6 +++---
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index c90a4eab8df..d6e940d4a90 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1010,10 +1010,10 @@ static int atmel_nand_pmecc_init(struct nand_chip *chip)
 	if (nc->caps->legacy_of_bindings) {
 		u32 val;
 
-		if (!ofnode_read_u32(nc->dev->node_, "atmel,pmecc-cap", &val))
+		if (!ofnode_read_u32(dev_ofnode(nc->dev), "atmel,pmecc-cap", &val))
 			chip->ecc.strength = val;
 
-		if (!ofnode_read_u32(nc->dev->node_,
+		if (!ofnode_read_u32(dev_ofnode(nc->dev),
 				     "atmel,pmecc-sector-size",
 				     &val))
 			chip->ecc.size = val;
@@ -1671,7 +1671,7 @@ static int atmel_nand_controller_add_nands(struct atmel_nand_controller *nc)
 	 * Add support for legacy nands
 	 */
 
-	np = nc->dev->node_;
+	np = dev_ofnode(nc->dev);
 
 	ret = ofnode_read_u32(np, "#address-cells", &val);
 	if (ret) {
@@ -1791,7 +1791,7 @@ static int atmel_nand_attach_chip(struct nand_chip *chip)
 	if (ret)
 		return ret;
 
-	if (nc->caps->legacy_of_bindings || !ofnode_valid(nc->dev->node_)) {
+	if (nc->caps->legacy_of_bindings || !ofnode_valid(dev_ofnode(nc->dev))) {
 		/*
 		 * We keep the MTD name unchanged to avoid breaking platforms
 		 * where the MTD cmdline parser is used and the bootloader
@@ -1855,7 +1855,7 @@ atmel_nand_controller_init(struct atmel_nand_controller *nc,
 		return PTR_ERR(nc->mck);
 	}
 
-	ret = ofnode_parse_phandle_with_args(dev->parent->node_,
+	ret = ofnode_parse_phandle_with_args(dev_ofnode(dev->parent),
 					     "atmel,smc", NULL, 0, 0, &args);
 	if (ret) {
 		dev_err(dev, "Missing or invalid atmel,smc property\n");
@@ -1887,7 +1887,7 @@ atmel_smc_nand_controller_init(struct atmel_smc_nand_controller *nc)
 	if (nc->base.caps->legacy_of_bindings)
 		return 0;
 
-	ret = ofnode_parse_phandle_with_args(dev->parent->node_,
+	ret = ofnode_parse_phandle_with_args(dev_ofnode(dev->parent),
 					     nc->base.caps->ebi_csa_regmap_name,
 					     NULL, 0, 0, &args);
 	if (ret) {
@@ -1933,7 +1933,7 @@ static int atmel_hsmc_nand_controller_init(struct atmel_hsmc_nand_controller *nc
 	int ret;
 	u32 addr;
 
-	ret = ofnode_parse_phandle_with_args(dev->parent->node_,
+	ret = ofnode_parse_phandle_with_args(dev_ofnode(dev->parent),
 					     "atmel,smc", NULL, 0, 0, &args);
 	if (ret) {
 		dev_err(dev, "Missing or invalid atmel,smc property\n");
@@ -1957,7 +1957,7 @@ static int atmel_hsmc_nand_controller_init(struct atmel_hsmc_nand_controller *nc
 	if (ret)
 		return ret;
 
-	ret = ofnode_parse_phandle_with_args(dev->node_,
+	ret = ofnode_parse_phandle_with_args(dev_ofnode(dev),
 					     "atmel,nfc-io", NULL, 0, 0, &args);
 	if (ret) {
 		dev_err(dev, "Missing or invalid atmel,nfc-io property\n");
@@ -1971,7 +1971,7 @@ static int atmel_hsmc_nand_controller_init(struct atmel_hsmc_nand_controller *nc
 		return ret;
 	}
 
-	ret = ofnode_parse_phandle_with_args(dev->node_,
+	ret = ofnode_parse_phandle_with_args(dev_ofnode(dev),
 					     "atmel,nfc-sram", NULL, 0, 0, &args);
 	if (ret) {
 		dev_err(dev, "Missing or invalid atmel,nfc-sram property\n");
diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
index e500a0fe3f8..216ee0f7ac7 100644
--- a/drivers/mtd/nand/raw/atmel/pmecc.c
+++ b/drivers/mtd/nand/raw/atmel/pmecc.c
@@ -833,9 +833,9 @@ atmel_pmecc_create(struct udevice *dev,
 	pmecc->dev = dev;
 	mutex_init(&pmecc->lock);
 
-	ofnode_read_resource(dev->node_, 0, &res);
+	ofnode_read_resource(dev_ofnode(dev), 0, &res);
 	pmecc->regs.base = (void *)res.start;
-	ofnode_read_resource(dev->node_, 1, &res);
+	ofnode_read_resource(dev_ofnode(dev), 1, &res);
 	pmecc->regs.errloc = (void *)res.start;
 
 	pmecc->regs.timing = 0;
@@ -910,7 +910,7 @@ struct atmel_pmecc *devm_atmel_pmecc_get(struct udevice *userdev)
 	if (!userdev)
 		return ERR_PTR(-EINVAL);
 
-	ret = ofnode_parse_phandle_with_args(userdev->node_,
+	ret = ofnode_parse_phandle_with_args(dev_ofnode(userdev),
 					     "ecc-engine",
 					     NULL, 0, 0, &args);
 	/* Probe pmecc driver */
-- 
2.43.0

base-commit: 62b45e82bdbf703571450e97f605893fe0d50530
branch: master

