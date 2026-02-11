Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B72A6E9E311
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 15:19:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09BB783A47;
	Wed, 11 Feb 2026 16:19:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hugovil.com header.i=@hugovil.com header.b="USkTJCRw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F8948388D; Wed, 11 Feb 2026 16:19:20 +0100 (CET)
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7047283CBD
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 16:19:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hugo@hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
 ; s=x;
 h=Subject:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Cc:To
 :From:subject:date:message-id:reply-to;
 bh=d+V0j9oahlNWdYbXAdZ4hAO7VnAzUKa8yAV9XfWab0E=; b=USkTJCRwghvUYJWJIg4cg6wYkN
 K6U0k7wLBS23pKxT5w7nax6wP2yfxJJPJwRwAiSN0FnSaIT4p0JfN5WNs/bpNHztHgHGkcjd/HnPb
 TtHySeom30DSlo3h8syIT3mnmaIU8hj2ks2AS9BoEEdeQBYgKrAfjdEuFvwT449R4JW0=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:51494
 helo=pettiford.lan) by mail.hugovil.com with esmtpa (Exim 4.92)
 (envelope-from <hugo@hugovil.com>)
 id 1vqBzm-0000yE-VM; Wed, 11 Feb 2026 10:19:15 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Tom Rini <trini@konsulko.com>
Cc: hugo@hugovil.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 u-boot@lists.denx.de
Date: Wed, 11 Feb 2026 10:19:09 -0500
Message-ID: <20260211151913.249518-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: [PATCH] cmd: pxe_utils: fix syntax error in comments
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
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

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Add missing "to" so that the sentence makes sense.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 boot/pxe_utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 836e4eb526c..419ab1f1b0e 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -1083,7 +1083,7 @@ static void eol_or_eof(char **c)
  */
 
 /*
- * Parse a string literal and store a pointer it at *dst. String literals
+ * Parse a string literal and store a pointer to it at *dst. String literals
  * terminate at the end of the line.
  */
 static int parse_sliteral(char **c, char **dst)

base-commit: b99da05e1538b8fa153322da82917af2aa27e1d6
-- 
2.47.3

