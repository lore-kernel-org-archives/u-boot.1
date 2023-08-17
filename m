Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A742C3DA58
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 17:04:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 706B386BA4;
	Thu, 17 Aug 2023 19:04:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TcseoXYj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBF9086B9D; Thu, 17 Aug 2023 19:04:23 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AA9086BAB
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 19:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 765F261E59;
 Thu, 17 Aug 2023 17:04:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE04DC433CB;
 Thu, 17 Aug 2023 17:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692291853;
 bh=8j0xJ0j/hUPZPh3NP9IRQ8iownf7t+ZCdwIn3f/CnUs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=TcseoXYj0BYt5+xGoBH/++H4+Jt7bYd/js4pImY7nDXhixNjW92/2zE5GQHA7OqLH
 5fbL2oWeikU/uHujkXu8jrEv6bv/Nr3ZeYSh0SdcBawLS43P63r47GJbbjwwEk5AeZ
 RXJ2YX8gMB9iqL0tH8CPvevwRn2LFk+/7SLgSxrGfDva0nAxdYReWPGFh3JfMYD6y1
 g348aIU5RWIbX9cwPHXs40xTsCa0r8XiWGu8H9xwSwSOwRhUCvoKC67KnxPGCk8T8n
 Zf2/Cn7h3yx4ES8GbTZTbk99dEHTg4yZoGFblgVKbAqPcKGskBqYbDU9Un5BE7gIYx
 yh4eUI3MIFe0Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id CCB4AC3DA5C;
 Thu, 17 Aug 2023 17:04:13 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 18 Aug 2023 01:04:03 +0800
Subject: [PATCH RESEND 4/5] clk: promote clk_dev_ops to
 linux/clk-provider.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230818-clk-fix-v1-4-49ec18f820bf@outlook.com>
References: <20230818-clk-fix-v1-0-49ec18f820bf@outlook.com>
In-Reply-To: <20230818-clk-fix-v1-0-49ec18f820bf@outlook.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692291852; l=1308;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=AsXbGKWGRqE3lMjTv3H8xZIwt4yI2mwPFQ61gXMGbNI=;
 b=fayyID6emo5avyU30zRUPRyYSoRpenqpatkddd/geJBHfYiNS1S3MRgy1EU9KzCSHiR9zzLlw
 V7lGGLJ5nz+BpXY8ooDmagzV4YaqXhtVobgboCSqGJNavmH+urkNLZq
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230724 with
 auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
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
Reply-To: forbidden405@outlook.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Yang Xiwen <forbidden405@outlook.com>

So that it can be used by others.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/clk/clk-uclass.c     | 5 -----
 include/linux/clk-provider.h | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index dc3e9d6a26..5cc80e5e39 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -25,11 +25,6 @@
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 
-static inline const struct clk_ops *clk_dev_ops(struct udevice *dev)
-{
-	return (const struct clk_ops *)dev->driver->ops;
-}
-
 struct clk *dev_get_clk_ptr(struct udevice *dev)
 {
 	return (struct clk *)dev_get_uclass_priv(dev);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 801404480b..dfafb4cc9d 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -21,6 +21,11 @@ static inline void clk_dm(ulong id, struct clk *clk)
 		clk->id = id;
 }
 
+static inline const struct clk_ops *clk_dev_ops(struct udevice *dev)
+{
+	return (const struct clk_ops *)dev->driver->ops;
+}
+
 /*
  * flags used across common struct clk.  these flags should only affect the
  * top-level framework.  custom flags for dealing with hardware specifics

-- 
2.34.1

