Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519B2C2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 06:05:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 211E888403;
	Tue, 18 Jun 2024 08:05:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="t8iKc8fx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7755488445; Tue, 18 Jun 2024 08:05:51 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AD3288422
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 08:05:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-041-025.um47.pools.vodafone-ip.de
 [178.202.41.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 545ED3FC08; 
 Tue, 18 Jun 2024 06:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718690748;
 bh=mPupYyqYBmFM0EStQeTzdvPxO7+vCzk1eLleZfTHzLA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=t8iKc8fxpYMQbmWegP5kvrQs7hlN07TIhWPSxXEJMVZ5HHu87TDesl2YRJynRv9Hv
 OXIpQFpv8dpXVuJ6GboHlTLB/DKu5x00AKexa2w9ec+ZvIog7ou1dvbZEzByGZbO5r
 0Txa23Svqq0jFtWM6iqWNFpVLuzlvC2WkXSHh06+u37LYjV6UXqMnLKnyhKkSSFauS
 Df6ZP1dRhXr7MBTzIlR738d0CWbJEUlTu46v+IBWY5BcQTF56+sU7U+ImO3kkrXiDI
 +vUrMV1JKt4GxX10G5XuUliFzqxAu+xWBcM8eQ3Eg8qhDufc6d0vN8DT7VZc+Hi5I9
 vIBviS2JY8Bdw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cmd: link to doc/usage/fit/x86-fit-boot.rst
Date: Tue, 18 Jun 2024 08:05:46 +0200
Message-ID: <20240618060546.9681-1-heinrich.schuchardt@canonical.com>
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

Replace the outdated link.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index ff0f5941ecc..9e4245a9702 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -622,7 +622,7 @@ config CMD_ZBOOT
 
 	  Consider using FIT in preference to this since it supports directly
 	  booting both 32- and 64-bit kernels, as well as secure boot.
-	  Documentation is available in doc/uImage.FIT/x86-fit-boot.txt
+	  Documentation is available in doc/usage/fit/x86-fit-boot.rst.
 
 endmenu
 
-- 
2.43.0

