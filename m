Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B11C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 16:04:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C66182D83;
	Wed, 18 Jun 2025 18:04:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=tkos.co.il header.i=@tkos.co.il header.b="opR+UtIr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E117482DF2; Wed, 18 Jun 2025 18:04:45 +0200 (CEST)
Received: from mail.tkos.co.il (guitar.tkos.co.il [84.110.109.230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0758F82C55
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 18:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=tkos.co.il
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=baruch@tkos.co.il
Received: from tarshish.tkos.co.il (unknown [10.0.8.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.tkos.co.il (Postfix) with ESMTPS id BD034440EA6;
 Wed, 18 Jun 2025 19:03:37 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
 s=default; t=1750262617;
 bh=IdE4zDcGQlf2/nFueecG0JAI7gcJQaK51OzMndt7CtI=;
 h=From:To:Cc:Subject:Date:From;
 b=opR+UtIrW4M9XJGSS7brOMaquAb91YXdMyyATVfxeFKAaQw6k5YKPCwqKVz53VIXz
 7b4WLOEofCMO4a6+NIwpxoJz7llZC+xy7kwKbuYLxzzh4mSfB9zrNihUA7BNAzDEwh
 E91fimEeFJ9jBB2TPzyfcMgwZQodgD08h677dow0spBR8uMozngpRVNJ+nWXbahepL
 W+1IRJearMRESCFjuzpd9wB1Pdn5ZRY8Co65HycvC3KjxttwTtbkaXHs1TkpeKmmAD
 1gHiOHHTP2Rm5rObinGGcewEM/5ucJ6ZARnl9mQKtMLyqLWXg29TEtQPAWodaikoGM
 fCS9SPRg8+sPg==
From: Baruch Siach <baruch@tkos.co.il>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] net: designware: fix bus address dereference
Date: Wed, 18 Jun 2025 19:04:35 +0300
Message-ID: <e3ed716de67cf4f46b303e9e7536b4938fba5a68.1750262675.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.47.2
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

Device bus address might not be valid for direct access when the bus
address and CPU address are not the same. Use dev_bus_to_phys() to
translate bus address back to CPU address.

Fixes: 3d98b8c504e15 ("net: designware: Invalidate RX buffer cache before freeing the DMA descriptor")
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/net/designware.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index 0f93c25e3fed..fce3ef910cb2 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -716,7 +716,7 @@ static int _dw_free_pkt(struct dw_eth_dev *priv)
 	ulong desc_start = (ulong)desc_p;
 	ulong desc_end = desc_start +
 		roundup(sizeof(*desc_p), ARCH_DMA_MINALIGN);
-	ulong data_start = desc_p->dmamac_addr;
+	ulong data_start = dev_bus_to_phys(priv->dev, desc_p->dmamac_addr);
 	ulong data_end = data_start + roundup(CFG_ETH_BUFSIZE, ARCH_DMA_MINALIGN);
 
 	/* Invalidate the descriptor buffer data */
-- 
2.47.2

