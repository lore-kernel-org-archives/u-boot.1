Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF64CD1284
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 22:12:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F41AA87B71;
	Thu, 11 Apr 2024 00:12:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="lStMdiZM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC57A88120; Thu, 11 Apr 2024 00:12:15 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4F118657F
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 00:12:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-245-032.um16.pools.vodafone-ip.de
 [62.143.245.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id ECD763FE50; 
 Wed, 10 Apr 2024 22:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712787133;
 bh=Z2doeSa4W6SzzfylA4dUKohuyRStQcje0TpTZIkQFrI=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=lStMdiZMUm8/sxkmoEIVTOTGkmHSbfkOtsQrH3+rIPmE8w2qcjRpF6vFwI1h7rUz3
 +5Mf5gzCuD7F9eWhSFZes6ZBcMvhu7StatJsohWzXqzjdomn5Uoah7u0Q5KcI5ipAl
 r+6KwuPgxik10oH3u0aGoMdvKLhPNBDZmSixpi8nsIF69EvIxP6lSL7j3afNc5OQ4E
 ndS/KWlxtGK+kF7lOsihGPA2QFMcrs4zTtcuZoAhAI3h+PObtpNwq4NX91pziNPYWW
 /QvABmRDK1SXAJ6H7ogUti8aCyx1Y85qevcJ9gC7BWyJ0LFFsacAekkqi9Z86Hlatc
 EDPORAOSHqfXw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nam Cao <namcao@linutronix.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] bootflow: always initialize bootflow_iter_set_dev
 parameters
Date: Thu, 11 Apr 2024 00:12:06 +0200
Message-ID: <20240410221206.22782-1-heinrich.schuchardt@canonical.com>
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

method_flags may be passed uninitialized to bootflow_iter_set_dev()
if dev is not NULL.

Always initialize method_flags.

Addresses-Coverity-ID: 467057 Uninitialized scalar variable
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 boot/bootflow.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 68bf99329ab..f659a414c79 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -244,7 +244,7 @@ static int iter_incr(struct bootflow_iter *iter)
 	if (iter->flags & BOOTFLOWIF_SINGLE_DEV) {
 		ret = -ENOENT;
 	} else {
-		int method_flags;
+		int method_flags = 0;
 
 		ret = 0;
 		dev = iter->dev;
@@ -263,7 +263,6 @@ static int iter_incr(struct bootflow_iter *iter)
 		} else if (IS_ENABLED(CONFIG_BOOTSTD_FULL) &&
 			   iter->flags & BOOTFLOWIF_SINGLE_MEDIA) {
 			log_debug("next in single\n");
-			method_flags = 0;
 			do {
 				/*
 				 * Move to the next bootdev child of this media
@@ -305,7 +304,6 @@ static int iter_incr(struct bootflow_iter *iter)
 				}
 			} else {
 				ret = bootdev_next_prio(iter, &dev);
-				method_flags = 0;
 			}
 		}
 		log_debug("ret=%d, dev=%p %s\n", ret, dev,
-- 
2.43.0

