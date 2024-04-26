Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D20C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 08:03:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25BC089140;
	Fri, 26 Apr 2024 10:02:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tq-group.com header.i=@tq-group.com header.b="eLRdsyTe";
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="e8NwUZUG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70B2888EF8; Fri, 26 Apr 2024 10:02:57 +0200 (CEST)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2859589145
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 10:02:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=matthias.schiffer@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1714118574; x=1745654574;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eLMyik4jwIvxzanoiox4VPCgipj7fBmhrcMJjO4krV4=;
 b=eLRdsyTeVfFiL/1fAUXamzC2P+1dZMj4KMHcvhsNYD+eMP2flfqIxaco
 N8iVEaE9c92UCymQpS7g5Ag/4yEIB3nMfS74TYU17krxDteJUzEm7a0zv
 A2he3sGlqTr0U2P7OxXwmO2rKY8N5+yCWsrLrjf2ZMXmuv4S6MQvu28bv
 Ejc6BvlqkkGptxfAm/ur20S6SQpT9u80/x3WJVd8e98+oaIcvfABFfbI/
 fze/SHWgyNlRFPTww5i02pkhwu+lZ6Moz/Nw/u0Xbxtu3i5vqxJmpjuFB
 MVpFbzrw/T2jUgj9mJVPkt/eYavEL1Dj3X5lr12UvPw9zM35RwBzf/Y8+ A==;
X-IronPort-AV: E=Sophos;i="6.07,231,1708383600"; d="scan'208";a="36629245"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
 by mx1.tq-group.com with ESMTP; 26 Apr 2024 10:02:54 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5C3C216F00B; Fri, 26 Apr 2024 10:02:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
 s=dkim; t=1714118570;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=eLMyik4jwIvxzanoiox4VPCgipj7fBmhrcMJjO4krV4=;
 b=e8NwUZUGrEkc89Lj6c1ZzTRIyWHzOKiNytfsraFAqv7q3burGCM6Dkg0hZSuUgLoVjsNn9
 WUUcOYrNX44I+/J0kCU4lhpB40FYbpMPqzIDoVsPguAKUS3J4H0VLSeRnCPlf//+WexqpZ
 5w/e+puf6lKnP31Td8tvNIHRuhZp+dmIJvc0EWAaZ2zPf5VSHjUj2Uht0pg05ofmkzLhTi
 jWgMAfEuYW5S6/rdlr6wUFyKrGtgOR4R6jDHZdQP/N1TNiw+snnMt8SNsdAQz8+jrPHerT
 m3RkGhEv1/tR1IA/8uSohAbR3Dl/p80qtkXUbJZ9s2eE2OV8ToXJA14TpV/m6A==
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, MD Danish Anwar <danishanwar@ti.com>,
 Jai Luthra <j-luthra@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Nishanth Menon <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Suman Anna <s-anna@ti.com>
Cc: u-boot@lists.denx.de, u-boot@ew.tq-group.com,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 3/5] net: ti: am65-cpsw-nuss: fix error handling for "RX dma
 add buf failed"
Date: Fri, 26 Apr 2024 10:02:26 +0200
Message-ID: <93c1d3ea7a0f90d08d267c5acf9b59e65aaccf62.1714117337.git.matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <de7fe2da7ae4a85252d63904fae61585e4641936.1714117337.git.matthias.schiffer@ew.tq-group.com>
References: <de7fe2da7ae4a85252d63904fae61585e4641936.1714117337.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The RX DMA channel has been requested at this point already, so it must
be freed.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/net/ti/am65-cpsw-nuss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-nuss.c
index 4a57e945a3a..65ade1afd05 100644
--- a/drivers/net/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ti/am65-cpsw-nuss.c
@@ -362,7 +362,7 @@ static int am65_cpsw_start(struct udevice *dev)
 					  UDMA_RX_BUF_SIZE);
 		if (ret) {
 			dev_err(dev, "RX dma add buf failed %d\n", ret);
-			goto err_free_tx;
+			goto err_free_rx;
 		}
 	}
 
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

