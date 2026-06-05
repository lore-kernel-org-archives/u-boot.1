Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3137CD6E7D
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 17:16:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7F9D84994;
	Fri,  5 Jun 2026 19:15:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="YZEz6AuA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 206418498C; Fri,  5 Jun 2026 17:24:20 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2208C8497A
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 17:24:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=roberhu001@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
 Content-Type; bh=x9gqfBAUgWG59grKYbFQOffpwshn6Ucge4QTa39eFKs=;
 b=YZEz6AuAQRi8872jP6TgTWnBnY/VjUJ8Xz6tjD5kDsTFuzdg4+H1bRTPENXSDH
 uo/uwVkw/ZpzfnGhTGVKMOv58hvUTNn5U7LFkCvG8p62G6Gkk3t3TXNW8VF6SB0H
 kSz0jd9BP7oad8HnX/XWSTXo8HQs6zy7ddTv+RTxDsqiQ=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id
 _____wBHMwIE6iJq+4a8BQ--.1490S2; 
 Fri, 05 Jun 2026 23:24:09 +0800 (CST)
From: Zunyi Hu <roberhu001@163.com>
To: u-boot@lists.denx.de
Cc: Zunyi Hu <roberhu001@163.com>
Subject: [PATCH 1/2] mtd: spinand: core: fix Winbond W25N bad block marker (1
 byte BBM)
Date: Fri,  5 Jun 2026 23:23:46 +0800
Message-Id: <20260605152347.684-1-roberhu001@163.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBHMwIE6iJq+4a8BQ--.1490S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF48XF1kCr1rZF1xCF4UJwb_yoW8Jw1fpF
 WDAa4xCF4UJFnxXw45Ca1ayF98Cw1FvrWkJFWSg3sxZwnYyF98u345tFWSyF9xGF13ZF1S
 qFySgr9F9F1DAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUg0ePUUUUU=
X-Originating-IP: [27.38.249.80]
X-CM-SenderInfo: purev2tkxqiii6rwjhhfrp/xtbCwBnjf2oi6hnv8QAA3g
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

According to the Winbond datasheet, the factory Bad Block Marker
is strictly a single non-0xFF byte located at spare byte 0.
The default spinand core assumes a 2-byte marker (byte 0 and 1).

However, after programming, upper-layer file systems (such as UBI)
may utilize byte 1 for metadata. The default 2-byte check leads to
false-positive bad block detections on valid blocks. Introduce a
manufacturer-specific check (Winbond ID: 0xEF) to strictly evaluate
only marker[0].

Signed-off-by: Zunyi Hu <roberhu001@163.com>
---
 drivers/mtd/nand/spi/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index e5330958c7e..5395a1bdf68 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -676,6 +676,17 @@ static bool spinand_isbad(struct nand_device *nand, const struct nand_pos *pos)
 	if (ret)
 		return ret;
 
+	/*
+	 * Winbond W25N (incl. W25N01G/GV): factory BBM is a single non-0xFF
+	 * byte at spare byte 0 (see datasheet).  Byte 1 may hold ECC or file
+	 * system markers after programming — do not treat it as BBM.
+	 */
+	if (spinand->id.data[1] == 0xEF) {
+		if (marker[0] != 0xff)
+			return true;
+		return false;
+	}
+
 	if (marker[0] != 0xff || marker[1] != 0xff)
 		return true;
 
-- 
2.17.1

