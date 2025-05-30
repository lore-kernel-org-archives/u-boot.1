Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D114C5B549
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 10:07:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D66168329B;
	Fri, 30 May 2025 12:07:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="Bx4qKLdw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD69D8329C; Fri, 30 May 2025 12:07:07 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5552D83291
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 12:07:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 129C426031;
 Fri, 30 May 2025 12:07:05 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r_2iD14MR_da; Fri, 30 May 2025 12:07:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1748599623; bh=1WDmCOxEjBdqIrdaJHxG9i+yMrppiuyQ3Y2hS7vPvro=;
 h=From:To:Cc:Subject:Date;
 b=Bx4qKLdw8xNn2qDGLEIDr0FE4V258U22FUjiNHTo8yMcWySsNMugDjHKO9hss/ll5
 Ai441f+VjgiJYe5kl53oiJNqBqnKakGy8UU+s7FmLjf0gmBW7OUYl+cM46/TNNQOZe
 pXlW5SFOnlV5whi66/W/bmIjnm180bTx9+YMvYPRtfOoZKgzSFofciaZ4mQCySb0DV
 PWDQH1aQKKXyFkViHUutlJrosOHaEvTdGXj2XN/09G0a9/uyhua9ilIUZbr3ma3w3r
 63LAdC9Kwo1e2h7ITyMEznWgHn5eLRyOebA5g5x7EPtdahrQrxWz09OItFDi1SWnG5
 sciWJ07FbL5sA==
From: Yao Zi <ziyao@disroot.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH] scripts: Remove "thead" as the misspell of "thread"
Date: Fri, 30 May 2025 10:06:43 +0000
Message-ID: <20250530100643.57666-1-ziyao@disroot.org>
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

"thead" is frequently used as abbreviation of T-Head, the IP and SoC
designer in China. This misspell entry causes lots of false-positives
when working with our T-Head SoC port.

Let's remove the entry as what has been done in Linux upstream commit[2]
15571273db93 ("scripts/spelling.txt: remove 'thead' as a typo").

Link: https://www.t-head.cn/ # [1]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=15571273db93ac2e4415e74280e04566c31d5eb0 # [2]
Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 scripts/spelling.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index aec616b1d3b..36387e0e0ab 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -1456,7 +1456,6 @@ teh||the
 temorary||temporary
 temproarily||temporarily
 temperture||temperature
-thead||thread
 therfore||therefore
 thier||their
 threds||threads
-- 
2.49.0

