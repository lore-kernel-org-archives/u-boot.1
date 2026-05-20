Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADBDCD37AC
	for <u-boot@archiver.kernel.org>; Sun, 17 May 2026 09:04:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B277845E3;
	Sun, 17 May 2026 11:04:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="sDXHC2OJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A4DD8460E; Sun, 17 May 2026 11:04:23 +0200 (CEST)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC48B8407D
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 11:04:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 2232CB00592;
 Sun, 17 May 2026 11:04:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1779008659;
 bh=vMEfT+f0jYeZiwYjy80vhx7inqGsrajaQ7zsfVGE6m4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sDXHC2OJz+ibb6LsSPDRq6nNo7lugd/sx5dj3TkAc8mYfXHTbL57h6a48sv2c7LR0
 QnmplxCCry49b18JlInon++942v8uJMkRda0LNCucawczMGyLhC90WZGIvoAtGZfYU
 EdUECrb3PFEYy+XNFY0arLcf5k8rgnkGhzRFtuVANDlkIhH+ql2R9FXUxbzHpMmm3d
 3UwavZ5qLFkyekcCCLBhozrxc6k64h6i+tGrXvGLpvlLycAn7YdzuIy/v989uzP0yl
 yJDDteDo6uZMExmGTfjHAY37+fFAzeGfaFqclLXWIn/zbDOI1cT836+Cv4jtJvbQi4
 QEaTjAOiEPAZw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Vincent Jardin <vjardin@free.fr>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Christoph Reiter <christoph.reiter@evk.biz>,
 David Lechner <dlechner@baylibre.com>,
 Flaviu Nistor <flaviu.nistor@gmail.com>, Jeffrey Yu <jeyu@issi.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Shiji Yang <yangshiji66@outlook.com>, Ssunk <ssunkkan@gmail.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Tom Rini <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH v2] mtd: spi-nor: Add gd55lb02gf chips
Date: Wed, 20 May 2026 17:00:21 +0200
Message-ID: <20260520150032.1904130-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <"<20260510222140.603755-1-vjardin@free.fr>">
References: <"<20260510222140.603755-1-vjardin@free.fr>">
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

Add the GigaDevice GD55LB02GF (256 Mo) similar to gd55lb02ge with
the same read path flags.

SPI_NOR_HAS_LOCK and SPI_NOR_HAS_TB do not match this chip's
status register layout: the GD55LB02GF uses a 5-bit block protect
field BP0..BP4 plus a CMP bit in SR2 for direction (see datasheet
"Status Register Block Protection").

The generic stm-lock helpers drive only BP0..BP2 and assume SR1
bit 5 is TB, but on this part SR1 bit 5 is BP3.
Enabling either flag would leave BP3..BP4 unmanaged or corrupt
BP3 on every lock op.
A proper support needs a vendor specific lock callback, it is out
of scope for this table update.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
Suggested-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

---

Changes in v2:
- Place the new entry next to gd55lb02ge with style matching the
  neighbour.
- Drop SPI_NOR_HAS_LOCK. Did not adopt SPI_NOR_HAS_TB from
  gd55lb02ge: neither flag matches this chip's SR layout (see
  comments for the BP0..BP4 / CMP rationale).

 drivers/mtd/spi/spi-nor-ids.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index c0fa98424aa..31a2ba49a87 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -231,6 +231,10 @@ const struct flash_info spi_nor_ids[] = {
 		     SECT_4K | SPI_NOR_QUAD_READ |
 		     SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
 	},
+	{
+		INFO("gd55lb02gf", 0xc8601c, 0, 64 * 1024, 4096,
+		     SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES)
+	},
 #endif
 #ifdef CONFIG_SPI_FLASH_ISSI		/* ISSI */
 	/* ISSI */
-- 
2.43.0

base-commit: bfe90a308a94caa9d855440683521ff04122ae2a
branch: for-upstream/spi-nor-gd55lb02gf
