Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A846C36010
	for <u-boot@archiver.kernel.org>; Sat,  5 Apr 2025 19:06:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4315882ACF;
	Sat,  5 Apr 2025 21:06:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1743879977;
	bh=xe2np3EA8jiuh5QWg4ICUtJbZETbBA9E42f8HaPV+J4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PIVNQxrc+X+T9sbZtavHwZpgsWT/6DPjL24yEAih0OO3yFaEscKnP4g4qVDQrGTFi
	 CnZxWtrH20Y7TJYiDBiSPytBdONjHibTVrJEYb59e0seZzy6c70mPjQrZWntVzJBsY
	 fSgNTXrwA7xfIc2RGlCRxqjGbfm74srTtdEDnotXyW1BThuOwEoXwk0b2BZoTO9Kc1
	 sMSuvnpNrauh6qiOGqa+Yu2z8uFZ1OgAjEVB3CA8IipgclFIVB5W8TTlt3Zg/Y6pR5
	 TZMqgokaIg9b4hfu6qgVn8jKdd/IZuKhdVt1eIwELJA1jT4TyyNwP7p2JJeYCIExXH
	 EOCPthyth6g+g==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34CCC82AAF; Sat,  5 Apr 2025 21:06:14 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 400B081F45
 for <u-boot@lists.denx.de>; Sat,  5 Apr 2025 21:06:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Mim+KMxg"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4BACE10252EF9; 
 Sat,  5 Apr 2025 21:06:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1743879971; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=xe2np3EA8jiuh5QWg4ICUtJbZETbBA9E42f8HaPV+J4=;
 b=Mim+KMxgd4ipK96+6BaK9fyiQXTUzks+WPOwYDN2f2JzpDjpbP0MPnpWxwse3z0ssgv2ho
 j6PSYogAd837nKRg3bIzHI/htO2Ob0jWa1j/um6CSE6BgiDAq9OeKd4tomcF7lnI0PQVO5
 bVVL298IlIv/A+ldizhF+gw/q2yBTmevE/veQju8AizjRdOvIGMQ+xYWt9GoFrAUxS0dY3
 gCNL1Nyn4lR7aVDQa+WWFTA34e1/jBmrHEClb/M+YdJWHYjQudfnoDdFqsxvNz0cnp4TZO
 LVwxB6b4tv6uESdi+K+8brG2QnEofL5kzyYFvlEbfZNmBk1s+0eMRPTp+8/ERg==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Love Kumar <love.kumar@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 5/8] test: increase timeouts
Date: Sat,  5 Apr 2025 21:05:57 +0200
Message-Id: <20250405190600.24081-6-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250405190600.24081-1-hs@denx.de>
References: <20250405190600.24081-1-hs@denx.de>
MIME-Version: 1.0
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

From: Heiko Schocher <hs@nabladev.com>

running tests on github/gitlab while board is somewhere in
the wide world, needs bigger command and standard timeouts.

Increase them to:

TIMEOUT_MS = 60000                  # Standard timeout
TIMEOUT_CMD_MS = 45000              # Command-echo timeout

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---

(no changes since v1)

 test/py/u_boot_console_base.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index 7eaceb39d9..0aabedc394 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -30,8 +30,8 @@ PAT_ID = 0
 PAT_RE = 1
 
 # Timeout before expecting the console to be ready (in milliseconds)
-TIMEOUT_MS = 30000                  # Standard timeout
-TIMEOUT_CMD_MS = 10000              # Command-echo timeout
+TIMEOUT_MS = 60000                  # Standard timeout
+TIMEOUT_CMD_MS = 45000              # Command-echo timeout
 
 # Timeout for board preparation in lab mode. This needs to be enough to build
 # U-Boot, write it to the board and then boot the board. Since this process is
-- 
2.20.1

