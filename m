Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291D0CD37B2
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 22:22:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 884C8846AC;
	Mon, 11 May 2026 00:22:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="sRCb7ioK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00900846D2; Mon, 11 May 2026 00:22:17 +0200 (CEST)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3818D846A7
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 00:22:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 1EDB9B00535;
 Mon, 11 May 2026 00:21:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1778451734;
 bh=cc4qnew4X0+0dKhu6tQdIhUir4zg8J5FU5wO3PYSKps=;
 h=From:To:Cc:Subject:Date:From;
 b=sRCb7ioKRp/J8d4QrVNwpYl2fCONqvsFfFpkpDssnZHqV0VLgdcOk997IIH/2zYBi
 CNTTcBmKLCGIbBPCYQrn4qBRoGMEmx5tNZETeZY4lyG8xlzgRZ6hjRj2KIqF8URJGk
 TvpuMbHFk3z5apJmaTMcS6IeaXw7irMpIVs86gmHLtBQDP/YiWNd4QQSHAmEPUP2Bz
 FqwS8c6xXH3/NDeAPzQv/ANIWAXKVd22cHDJRYt0eILWmV7/OwvgLx/dU6wJHRY0Al
 svKrlVMi4NavqvrlRLEc9PjDDhPm2v9Jm8vRZn0puqEHKDXAcvL1E781d8UqwEuCFT
 y5iSWgWqgqYIQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Vincent Jardin <vjardin@free.fr>,
 Christoph Reiter <christoph.reiter@evk.biz>,
 David Lechner <dlechner@baylibre.com>,
 Flaviu Nistor <flaviu.nistor@gmail.com>, Jeffrey Yu <jeyu@issi.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Shiji Yang <yangshiji66@outlook.com>, Ssunk <ssunkkan@gmail.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Tom Rini <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH v1] mtd: spi-nor: Add gd55lb02gf chips
Date: Mon, 11 May 2026 00:21:03 +0200
Message-ID: <20260510222140.603755-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
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

Add GigaDevice GD55LB02GF (256 MiB, JEDEC 0xc8 0x60 0x1c) to the
spi-nor ID table.

Same die family as the existing gd55lb02g entry but a distinct memtype
byte (0x60 versus 0x67), so the existing entry does not match.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

 drivers/mtd/spi/spi-nor-ids.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index c0fa98424aa..50f6dd3e5c4 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -191,6 +191,8 @@ const struct flash_info spi_nor_ids[] = {
 	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
 	{INFO("gd55lb02g", 0xc8671C, 0, 64 * 1024, 4096,	SECT_4K |
 	SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
+	{INFO("gd55lb02gf", 0xc8601C, 0, 64 * 1024, 4096,	SECT_4K |
+	SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
 	{INFO("gd25lf80", 0xc86314, 0, 64 * 1024, 16,	SECT_4K |
 	SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK)},
 	{INFO("gd25lf16", 0xc86315, 0, 64 * 1024, 32,	SECT_4K |
-- 
2.43.0

base-commit: bfe90a308a94caa9d855440683521ff04122ae2a
branch: for-upstream/spi-nor-gd55lb02gf
