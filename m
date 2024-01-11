Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDFDC47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 13:20:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1717987B26;
	Thu, 11 Jan 2024 14:20:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ibqDMLir";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F76E87AE6; Thu, 11 Jan 2024 14:19:38 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A5EE87AD8
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 14:19:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 00107B82023;
 Thu, 11 Jan 2024 13:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08E6C433C7;
 Thu, 11 Jan 2024 13:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704979174;
 bh=nQXV1AWQBfFF+AXjJMn0LusHfuNxp8nAR/6ybJK/Dh4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ibqDMLiryYkg5B11OvTb4s9Mal/eJwh6eeFRVB0Mp1dyKgTXpRxZZZ8qoBdfPbRBa
 +D5ruKXblTrYWLXjncp8vlNjh5n596kmHNcMYn4KMuEHCVntjQXjdMNrAjl+zmRCad
 OAnGlLjlKu41iiWXdlW/TIF+moBWfLJ2e5Rkiaro4OdBFmW0gtFp+aU5/WFEKUYfja
 N1mq14z3Y7RR+nab2wefShIhfVt+4pqc1ddwcdu9NbXdmdIlXZ47RC9cXE4mvy4Q71
 trrneao/P3toqgRSj6zOd0oE6Q45AMPcXbdtH3V5bY8sVQFTKsAGZogVudcINLTccn
 ea4tDNdlVGr8A==
From: Roger Quadros <rogerq@kernel.org>
To: trini@konsulko.com, dario.binacchi@amarulasolutions.com,
 michael@amarulasolutions.com
Cc: vigneshr@ti.com, nm@ti.com, praneeth@ti.com, afd@ti.com, srk@ti.com,
 u-boot@lists.denx.de, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 3/4] mtd: rawnand: omap_gpmc: fix OF based partition
 parsing for NAND
Date: Thu, 11 Jan 2024 15:19:19 +0200
Message-Id: <20240111131920.73691-4-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111131920.73691-1-rogerq@kernel.org>
References: <20240111131920.73691-1-rogerq@kernel.org>
MIME-Version: 1.0
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

Set NAND chip ofnode and device so OF based partition parsing
can work.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---

Notes:
    v2: initial commit

 drivers/mtd/nand/raw/omap_gpmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/raw/omap_gpmc.c b/drivers/mtd/nand/raw/omap_gpmc.c
index f827c578d9..b36b6fabae 100644
--- a/drivers/mtd/nand/raw/omap_gpmc.c
+++ b/drivers/mtd/nand/raw/omap_gpmc.c
@@ -1226,6 +1226,8 @@ static int gpmc_nand_probe(struct udevice *dev)
 
 	base = devm_ioremap(dev, res.start, resource_size(&res));
 	gpmc_nand_init(nand, base);
+	mtd->dev = dev;
+	nand_set_flash_node(nand, dev_ofnode(dev));
 
 	ret = nand_scan(mtd, CONFIG_SYS_NAND_MAX_CHIPS);
 	if (ret)
-- 
2.34.1

