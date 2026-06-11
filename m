Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDEECD98CC
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 22:45:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC57884664;
	Fri, 12 Jun 2026 00:45:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="QZdGOa4u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC80D846D3; Fri, 12 Jun 2026 00:45:53 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81AB8838BB
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 00:45:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AFD88117150; Fri, 12 Jun 2026 00:45:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1781217947; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=W+06FMYjKUEK7TkJ32zB6CVwAIl8NVBwCp3wm2XH1Xk=;
 b=QZdGOa4uiCx5SuEDV0BK3mLZUbvtC01C9dd16QRZsc7Hv4il7LrTjqskQjw43LR4Pvepw4
 A5xV/H1KVkod/9DY3a8RVJ6tmuuHuuXmHbX3KWpItdk0TobRjL+j+cF+ybuMumTnZVcT+b
 n4MpK9rGjqD+h1I8IEdQmxpR2NV6ru85Opskbw2Kre9iBYYLsXLfQRkEem9GuU7GZCCc9n
 65X7Sg1j5dGA2auJSmspHg7jNrIdN+ylG15/hZDknolj67mK88Sc+nPRb4CTZY4/G5+Yjn
 badvOS/nb6zcfCV2G3pIXe2kH4uC2si/B8bNbgG4oV9cktfYlshnoMtOpq0n+Q==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.denx.de
Cc: Alexander Koch <akoch@initse.com>, Marek Vasut <marex@nabladev.com>,
 David Lechner <dlechner@baylibre.com>,
 Flaviu Nistor <flaviu.nistor@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Tom Rini <trini@konsulko.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Vignesh R <vigneshr@ti.com>
Subject: [PATCH] mtd: spi-nor: Indent SF: just like other boot time messages
Date: Fri, 12 Jun 2026 00:45:19 +0200
Message-ID: <20260611224544.210172-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Alexander Koch <akoch@initse.com>

Indent SF: just like other boot time messages. Change the original indent:

"
DRAM:  3.5 GiB
Core:  310 devices, 34 uclasses, devicetree: separate
SF: Detected w25q128jw with page size 256 Bytes, erase size 4 KiB, total 16 MiB
"

to the fixed indent:

"
DRAM:  3.5 GiB
Core:  310 devices, 34 uclasses, devicetree: separate
SF:    Detected w25q128jw with page size 256 Bytes, erase size 4 KiB, total 16 MiB
    ^^^
"

No functional change.

Signed-off-by: Alexander Koch <akoch@initse.com>
Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Alexander Koch <akoch@initse.com>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Flaviu Nistor <flaviu.nistor@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Vignesh R <vigneshr@ti.com>
Cc: u-boot@lists.denx.de
---
 drivers/mtd/spi/spi-nor-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 937d79af64e..c73f2c7c3f8 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -4758,7 +4758,7 @@ int spi_nor_scan(struct spi_nor *nor)
 	nor->sector_size = mtd->erasesize;
 
 #ifndef CONFIG_XPL_BUILD
-	printf("SF: Detected %s with page size ", nor->name);
+	printf("SF:    Detected %s with page size ", nor->name);
 	print_size(nor->page_size, ", erase size ");
 	print_size(nor->erase_size, ", total ");
 	print_size(nor->size, "");
-- 
2.53.0

