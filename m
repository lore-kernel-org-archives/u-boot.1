Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D23C47073
	for <u-boot@archiver.kernel.org>; Sun,  7 Jan 2024 08:43:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2469D87A09;
	Sun,  7 Jan 2024 09:43:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="AglUFzV7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BED3087A0D; Sun,  7 Jan 2024 09:43:46 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB7F587A08
 for <u-boot@lists.denx.de>; Sun,  7 Jan 2024 09:43:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D77A63F276; 
 Sun,  7 Jan 2024 08:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1704617023;
 bh=8veVAHwpCe1JbiJFV/o2N/lXDlaCEjTFIGz54g4jisY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=AglUFzV7wzRbrWrh7EK3LbYlh2hDlSewBGpcFt6SApkajKh4MxC0N/NA/TtRf13xG
 hGc5jLdKCNQiUYwRTVqlK5iLzpQUo/G8XfpdYjXqzMckldohXHJtWbS47HRLGVKGuI
 dhEap0Lj49cLECJ6IIoT1lxPLJCeRrBAaeTE5hzrcMLwbDXGTbE5j6pTsmqDyqmlFX
 B/O0oMEt58wPOyfvpQ48idPqtQXiO7XnOSYFi6mT4MIkcnB5TqOsa4HxNrmzReJYtY
 bagzXtl9p8BKkXdO08cLxVhUxVkDiC7Dr+IynpzpkGAhEGvr7zj/JXOxfcy8s62AXr
 RSP9r/dhw2C4g==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] boot: remove dead code in bootflow_check()
Date: Sun,  7 Jan 2024 09:43:40 +0100
Message-ID: <20240107084340.59954-1-heinrich.schuchardt@canonical.com>
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

The 'return 0;' statement is not reachable. Remove it.
'else' is superfluous after an if statement with return.

Addresses-Coverity-ID: 352451 ("Logically dead code")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
Simon, please, recheck the logic of the function.

The comment 'For 'all' we return all bootflows' implies that in this case
0 should be returned.

Best regards

Heinrich
---
 boot/bootflow.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 1ea2966ae9..05484fd5b1 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -361,7 +361,7 @@ static int bootflow_check(struct bootflow_iter *iter, struct bootflow *bflow)
 	}
 
 	/* Unless there is nothing more to try, move to the next device */
-	else if (ret != BF_NO_MORE_PARTS && ret != -ENOSYS) {
+	if (ret != BF_NO_MORE_PARTS && ret != -ENOSYS) {
 		log_debug("Bootdev '%s' part %d method '%s': Error %d\n",
 			  dev->name, iter->part, iter->method->name, ret);
 		/*
@@ -371,10 +371,8 @@ static int bootflow_check(struct bootflow_iter *iter, struct bootflow *bflow)
 		if (iter->flags & BOOTFLOWIF_ALL)
 			return log_msg_ret("all", ret);
 	}
-	if (ret)
-		return log_msg_ret("check", ret);
 
-	return 0;
+	return log_msg_ret("check", ret);
 }
 
 int bootflow_scan_first(struct udevice *dev, const char *label,
-- 
2.43.0

