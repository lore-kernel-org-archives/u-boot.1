Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43AEECD98CE
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 17:23:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DB548486B;
	Fri, 12 Jun 2026 19:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="jxb4G6u5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A268983FF5; Fri, 12 Jun 2026 16:41:49 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CF13839A8
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 16:41:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=roberhu001@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id; bh=OCYMib6ifepI1R/
 FQB1q5QNS6NoKFMemmCrpqng0JjQ=; b=jxb4G6u5qhcncqR1xeLuaVQH0rR63CP
 nSMi8hOrFOGuH5WkbFUPo5JCRDcG21V+Yg1OL04zfF5wyHB/F47tp/rLTqtbe+9c
 2v8ZUxqH6VoU8RPlrAUIICpoSh/veGvp1tZjRN2JgjHtNdAT1tbUL47/Le//e1UK
 0iRV36zOxeKc=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id
 _____wA3fGGVGixqMwVNDA--.53249S2; 
 Fri, 12 Jun 2026 22:41:26 +0800 (CST)
From: Zunyi Hu <roberhu001@163.com>
To: dario.binacchi@amarulasolutions.com,
	michael@amarulasolutions.com
Cc: frieder.schrempf@kontron.de, u-boot@lists.denx.de,
 Zunyi Hu <roberhu001@163.com>
Subject: [PATCH] mtd: spinand: winbond: Clarify factory BBM offset in OOB
 layout
Date: Fri, 12 Jun 2026 22:41:21 +0800
Message-Id: <20260612144121.24973-1-roberhu001@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wA3fGGVGixqMwVNDA--.53249S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jry5XryxuFy3AF45Xr1UKFg_yoWftrgEgw
 17XF4xGr47JFy7tr1Sy393Z342kw48X3Z7Z3Z5Kw1a9ayDArs3C34kXrnayFy8ZrZxJr90
 yrn5X3Z3tr17AjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_bAw5UUUUU==
X-Originating-IP: [113.87.116.120]
X-CM-SenderInfo: purev2tkxqiii6rwjhhfrp/xtbC6BZR7GosGpbNPgAA36
X-Mailman-Approved-At: Fri, 12 Jun 2026 19:22:35 +0200
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

The Winbond OOB layout function offsets the region by 2 bytes. Add a
brief comment to explicitly document that these 2 bytes are reserved
for the factory Bad Block Marker (BBM).

This eliminates the "magic number" and improves code readability,
preventing future accidental overwrites of the BBM area.

Signed-off-by: Zunyi Hu <roberhu001@163.com>
---
 drivers/mtd/nand/spi/winbond.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index a89aaec516b..01de6540f0d 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -110,7 +110,7 @@ static int w25m02gv_ooblayout_free(struct mtd_info *mtd, int section,
 	if (section > 3)
 		return -ERANGE;
 
-	region->offset = (16 * section) + 2;
+	region->offset = (16 * section) + 2; /* bytes 0-1 per section: factory BBM */
 	region->length = 6;
 
 	return 0;
-- 
2.17.1

