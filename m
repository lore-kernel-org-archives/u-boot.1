Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB625FF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 15:08:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 319328407E;
	Mon, 27 Apr 2026 17:08:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="rsq/i4+M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FE5483693; Mon, 27 Apr 2026 17:08:44 +0200 (CEST)
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [IPv6:2a01:e0c:1:1599::15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6266583693
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 17:08:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown
 [IPv6:2a01:e0a:98a:56a0:e0ee:b353:5249:f120])
 (Authenticated sender: vjardin@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id 4E4F378034D;
 Mon, 27 Apr 2026 17:08:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1777302521;
 bh=zUghVHmGktXdZGFAMQ56Plg4V5Ef3hnnivwQzd1ULIc=;
 h=From:To:Cc:Subject:Date:From;
 b=rsq/i4+MSsLZzreh6ygeBbsv1Ht5Em0WnAtowOcZQzK0msJbsw/h8f04UIyz1A0ux
 /XzfnUG6zrTZYXzb6jKdo98qQFpHJY7RBeHiI517Yn4+2jl5t6fa92f0LvX8gTcyN4
 YIb7rXdwnMqsj64gTB+3MfV54nxNsL/TWZiWnAokZlz64qS3ehmP/nyOqSOJKdKZwl
 XvjicN3XoYyq7Ob2G/IrrbC4N0Co2UAf44QjEqTglaJKrSl0AuP2YO4K3L1s0OkhPC
 E1YwaoOn8/qOVXQqlTBLApmnE5Odx/7oMGaLPmsOBGdri9uofQzvNHS3IRyrFLUJ6r
 ujyAVbx0urRMw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Vignesh R <vigneshr@ti.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Tom Rini <trini@konsulko.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Ssunk <ssunkkan@gmail.com>, Jeffrey Yu <jeyu@issi.com>,
 Flaviu Nistor <flaviu.nistor@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Christoph Reiter <christoph.reiter@evk.biz>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Shiji Yang <yangshiji66@outlook.com>, David Lechner <dlechner@baylibre.com>
Subject: [PATCH] mtd: spi-nor: Add gd55lb02gf chips
Date: Mon, 27 Apr 2026 17:08:07 +0200
Message-ID: <20260427150808.17319-1-vjardin@free.fr>
X-Mailer: git-send-email 2.50.1
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

Same die as gd55lb02g but a distinct JEDEC ID (memtype byte
0x60 vs 0x67), so the existing entry does not match.

Quad-read flag left disabled until QE bring-up is sorted; the
chip ships with QE = 0 and lighting it requires a controller
fixup that is not yet wired.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 drivers/mtd/spi/spi-nor-ids.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index c0fa98424aa..a29bc98d027 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -191,6 +191,8 @@ const struct flash_info spi_nor_ids[] = {
 	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
 	{INFO("gd55lb02g", 0xc8671C, 0, 64 * 1024, 4096,	SECT_4K |
 	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{INFO("gd55lb02gf", 0xc8601C, 0, 64 * 1024, 4096,	SECT_4K |
+	/* SPI_NOR_QUAD_READ | */ SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
 	{INFO("gd25lf80", 0xc86314, 0, 64 * 1024, 16,	SECT_4K |
 	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)},
 	{INFO("gd25lf16", 0xc86315, 0, 64 * 1024, 32,	SECT_4K |
-- 
2.50.1 (Apple Git-155)

