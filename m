Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F40CCD1AA
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 12:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C580B802C1;
	Tue, 21 Oct 2025 14:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="NQ1jIXsV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E59DD8323A; Tue, 21 Oct 2025 09:10:39 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 172DA82B20
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 09:10:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l932297267@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=gX
 syOc+GLdnn/WzgoExXC3i5DEdD8GdtIu2oAA4itzA=; b=NQ1jIXsV93A1i4mrx8
 S2lSiccDSJ6ZnyMm6+qfmF56JFiSAMNu+BePjaOmg2PZbyyHhg7MrH7KW3Pyl6QU
 FyZd8QAAuNWZJs3ugtK9htlaZIhnvD5Qi/UyQUgbyNqH6JXmIWZEqy1pZE9/UuvF
 C8B8+/v8poTC8Iq9hQ58hQMHM=
Received: from localhost (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDHeSnnMfdoacDYBQ--.141S2;
 Tue, 21 Oct 2025 15:10:33 +0800 (CST)
From: xslynin <l932297267@163.com>
To: u-boot@lists.denx.de
Cc: xslynin <l932297267@163.com>
Subject: [PATCH] drivers: net: dm9000 recv in stick package
Date: Tue, 21 Oct 2025 15:10:29 +0800
Message-Id: <20251021071029.149916-1-l932297267@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDHeSnnMfdoacDYBQ--.141S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ary5Wr4UAF1rAF47Zr17trb_yoW8Gw48pF
 4ay3yxZr4UK340qw1DXw4kWF15XF4aqay8uryUCa4rZrnxAr12kFyaga4avFn5XF4xGw42
 yF4UXr12kF4qq3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUbAwxUUUUU=
X-Originating-IP: [113.57.237.89]
X-CM-SenderInfo: boztjjqzxslli6rwjhhfrp/1tbiXBTthWj3JpTc5QAAs0
X-Mailman-Approved-At: Tue, 21 Oct 2025 14:51:30 +0200
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

between two calls of dm9000_recv_common in eth_rx, it's possible that
hardware get multi packet like a data and an arp or multi data(like tftp
 for window size, RFC7440), check the ISR for status and clear
immediately leads an unexpected behavior while the hardware runs well.

keeping the ISR check could reduce the check behavior of MRCMDX
register, so I just change the pos of clear and run well in larger window size of tftp.

Signed-off-by: xslynin <l932297267@163.com>
---
 drivers/net/dm9000x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dm9000x.c b/drivers/net/dm9000x.c
index 9e17f0b9c28..14ec85b4308 100644
--- a/drivers/net/dm9000x.c
+++ b/drivers/net/dm9000x.c
@@ -492,8 +492,6 @@ static int dm9000_recv_common(struct dm9000_priv *db, uchar *rdptr)
 	if (!(dm9000_ior(db, DM9000_ISR) & 0x01)) /* Rx-ISR bit must be set. */
 		return 0;
 
-	dm9000_iow(db, DM9000_ISR, 0x01); /* clear PR status latched in bit 0 */
-
 	/* There is _at least_ 1 package in the fifo, read them all */
 	dm9000_ior(db, DM9000_MRCMDX);	/* Dummy read */
 
@@ -512,8 +510,10 @@ static int dm9000_recv_common(struct dm9000_priv *db, uchar *rdptr)
 		return -EINVAL;
 	}
 
-	if (rxbyte != DM9000_PKT_RDY)
+	if (rxbyte != DM9000_PKT_RDY) {
+		dm9000_iow(db, DM9000_ISR, 0x01); /* clear PR status latched in bit 0 */
 		return 0; /* No packet received, ignore */
+	}
 
 	debug("receiving packet\n");
 
-- 
2.34.1

