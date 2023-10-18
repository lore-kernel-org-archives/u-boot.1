Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB709CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 03:38:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAFD286EDD;
	Wed, 18 Oct 2023 05:38:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="aspF97+l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AE6086F08; Wed, 18 Oct 2023 05:38:20 +0200 (CEST)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
 by phobos.denx.de (Postfix) with ESMTP id 88CCE86E6C
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 05:38:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bruce_suen@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=+vJlY
 j7Uul6Z2EpHsK/QQY4KHASKqLTRpzXtTyVF9/k=; b=aspF97+lKBnCe37KKTj+8
 5BdPPI6oqW5uiqDYx4hUC/PB7DU7XOcJym1hx6o/sRF4bDYRzoS+21Ktj1SjF93a
 EPYzFpaqF9BcrgJfYrbP5bgJJqz8uAZmzhUj2b35JPceiGeG2U25wMwOndowpFRU
 p+2bvEp4JjZhExhFmJl6e4=
Received: from localhost.localdomain (unknown [119.123.78.113])
 by zwqz-smtp-mta-g4-1 (Coremail) with SMTP id _____wBnJysdUy9lS8hqAw--.24539S4;
 Wed, 18 Oct 2023 11:38:06 +0800 (CST)
From: Bruce Suen <bruce_suen@163.com>
To: u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, bruce.sun@xtxtech.com,
 Bruce Suen <bruce_suen@163.com>
Subject: [PATCH] mtd: spi-nor-ids: add support for xtx XT55Q02G
Date: Tue, 17 Oct 2023 23:38:02 -0400
Message-Id: <20231018033802.5356-1-bruce_suen@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBnJysdUy9lS8hqAw--.24539S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw48Cw4xWr4fZrWfXFyxKrg_yoWDJrb_Ga
 43Wr17Gr40vF1kXa43C3W7Aryjka1FgFn2vF1xK39xZFZ8Ar13XasrXay8Jry7ua1jva4q
 vw12yw15Grs8KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRduci3UUUUU==
X-Originating-IP: [119.123.78.113]
X-CM-SenderInfo: 5euxuvpbvxv0i6rwjhhfrp/xtbBFgYMKFgi7QFE6wABsM
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

Add support for XTX XT55Q02G(1.8V,2Gbit).

Signed-off-by: Bruce Suen <bruce_suen@163.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 4587215984..9aab913356 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -564,6 +564,8 @@ const struct flash_info spi_nor_ids[] = {
 	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("xt25q01g", 0x0b601B, 0, 64 * 1024, 2048,
 	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO("xt55q02g", 0x0b601C, 0, 64 * 1024, 4096,
+	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	/* adding these wide voltage QSPI flash parts */
 	{ INFO("xt25w512", 0x0b651A, 0, 64 * 1024, 1024,
 	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
-- 
2.34.1

