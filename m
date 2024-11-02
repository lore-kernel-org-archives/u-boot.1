Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75B9E67801
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 15:04:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 196A989030;
	Sat,  2 Nov 2024 16:04:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="CSKgDmuM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3E2689046; Sat,  2 Nov 2024 16:04:20 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D862F8902E
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 16:04:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 2B6AC408DC; 
 Sat,  2 Nov 2024 15:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730559858;
 bh=zdW/LiAqebC/tTFFjLMPKBOaajcDUA1k7M5fOJwbjYA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=CSKgDmuMtvC8u72cCCg9O21hFef1TKxWgMV9Q4wfpGEHxDBb/PEBYiE15GcDDBTDE
 fYolqgcCgwu/4eBhYzxJKSr9aDZXQmCYyoVE4OJHExRk4BCZiqFDbucYtWQwloPgp8
 30Dm01IbdWdSDvCONaiwRt5z6LSFVYFF8/p1NVCWQ8eppQ6t66eWh20MueZxD9OjY2
 MF2yqR+r5FEPHDDWXNpLoL0eoxVWiXIiwzvVCBc23hPxcGU4NqgJnBvH7g2bmoLNqI
 ISCr9/FzQrJ8esi6NLZuHd78py2rGf47IykTUgUIleLXSB/aAt0gCtn2DHivvbO+nP
 ma1fGUNXNxlZQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] upl: fix parsing of DT property
Date: Sat,  2 Nov 2024 16:04:13 +0100
Message-ID: <20241102150413.133499-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

When calling decode_addr_size() we must pass the size of the device-tree
property and not sizeof(void *).

Fixes: 90469da3da0d ("upl: Add support for reading a upl handoff")
Addresses-Coverity-ID: 510459 Wrong sizeof argument
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 boot/upl_read.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/upl_read.c b/boot/upl_read.c
index 5063897a132..be3e1d116e1 100644
--- a/boot/upl_read.c
+++ b/boot/upl_read.c
@@ -520,7 +520,7 @@ static int decode_upl_graphics(struct upl *upl, ofnode node)
 		return log_msg_ret("reg", -EINVAL);
 	}
 
-	len = decode_addr_size(upl, buf, sizeof(buf), &gra->reg);
+	len = decode_addr_size(upl, buf, size, &gra->reg);
 	if (len < 0)
 		return log_msg_ret("buf", len);
 
-- 
2.45.2

