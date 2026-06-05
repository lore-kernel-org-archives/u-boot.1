Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E04CCD6E7D
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 17:16:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BEE4849B4;
	Fri,  5 Jun 2026 19:15:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="MolLt9tQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDBCB8497A; Fri,  5 Jun 2026 17:24:20 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D227884987
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 17:24:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=roberhu001@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id; bh=GejAJyq1NLxZpOW
 MOuuaUyjDyr2zI5on5h0kbEsn8BM=; b=MolLt9tQjahOg1VNf/e6rY47XWwzFsJ
 op8kgOv9L4PFVLxEjiC+ex6Xm53qeuGH3XVYg94RfG8O2qQYsdYCNEJiZHYEmdwJ
 9LR+Fb5Z001eUEGRiwIc6ulZ0bk7qydXkStjpgEA5igxBI4S3BGn+96T4A2xWKSo
 2+sqO+Ahx/4Q=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id
 _____wBHMwIE6iJq+4a8BQ--.1490S3; 
 Fri, 05 Jun 2026 23:24:11 +0800 (CST)
From: Zunyi Hu <roberhu001@163.com>
To: u-boot@lists.denx.de
Cc: Zunyi Hu <roberhu001@163.com>
Subject: [PATCH 2/2] mtd: spinand: winbond: add support for W25N01G
Date: Fri,  5 Jun 2026 23:23:47 +0800
Message-Id: <20260605152347.684-2-roberhu001@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260605152347.684-1-roberhu001@163.com>
References: <20260605152347.684-1-roberhu001@163.com>
X-CM-TRANSID: _____wBHMwIE6iJq+4a8BQ--.1490S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw4DJryUZw4fXw4DWw1xKrg_yoWfAFg_X3
 90vrWxCrs2kr1ft3WxKw18A3y5ta18ZF1vqFn2gwsxKrWY934fuFyUXrn7Cw4q9r15tFyS
 yr1rJwnYyw17CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUjBHqUUUUUU==
X-Originating-IP: [27.38.249.80]
X-CM-SenderInfo: purev2tkxqiii6rwjhhfrp/xtbC5xvjf2oi6htJwwAA3T
X-Mailman-Approved-At: Fri, 05 Jun 2026 19:15:30 +0200
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

Add device ID and geometry parameters for the Winbond W25N01G
1G-bit SPI NAND flash memory.

Signed-off-by: Zunyi Hu <roberhu001@163.com>
---
 drivers/mtd/nand/spi/winbond.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index c119486efb7..78584e5a1e2 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -96,6 +96,14 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &update_cache_variants),
 		     0,
 		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL)),
+	SPINAND_INFO("W25N01G", 0xAA,
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 1, 1, 1),
+		     NAND_ECCREQ(1, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL)),
 };
 
 /**
-- 
2.17.1

