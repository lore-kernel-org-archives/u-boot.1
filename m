Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2044CDD55D
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 21:39:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6639088FCB;
	Wed, 18 Sep 2024 23:39:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="lACJWlvD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBF2B88FD8; Wed, 18 Sep 2024 23:39:38 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7F7688DC1
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 23:39:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-110-162.46.114.pool.telefonica.de
 [46.114.110.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 51BA83F298; 
 Wed, 18 Sep 2024 21:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1726695576;
 bh=pddLST+ZJcjZxhvM0MAoymxvnI9KTIrt4F+8ma4oMVY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=lACJWlvDmIdkFFII2xAgoDJ8GNIC83Yf3yCY62IJLEcR1cRar/nURBMbtQd6zdazW
 bkbn0okM5gZJBALEBRQgAIXjAs5KcwIkAnwsWQ92ilp5mllzTyIA2NanJ6MWbbA7PN
 5Ur9r5FYFSni2OdDMv50kUyehhWkeNFJUxonsqLD/n+dRvSw1NFAdI8bemMMYp3Umv
 xDZ6fCM98YtPKN64DcYeN4mUMq6wfVYTnE4L21c9NocuZy6C/D2x4xcZwK6Z3uSm2E
 GL/75zl2WD9fAHFrXwJYi8c49Y5/AQo+E4JjMfp0OoEaGExWwDu++hs3YdDKdUM0XQ
 lEKXuiCkc5u/Q==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] lmb: add missing LMB_NOOVERWRITE description
Date: Wed, 18 Sep 2024 23:39:34 +0200
Message-ID: <20240918213934.19875-1-heinrich.schuchardt@canonical.com>
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

Without a LMB_NOOVERWRITE building the HTML documentation leads to a
warning which should be treated as an error.

Fixes: 5e9553cc72b8 ("lmb: allow for resizing lmb regions")
Reported-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/lmb.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/lmb.h b/include/lmb.h
index fc2daaa7bfc..8ed5ac0a4fc 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -18,6 +18,7 @@
  * enum lmb_flags - definition of memory region attributes
  * @LMB_NONE: no special request
  * @LMB_NOMAP: don't add to mmu configuration
+ * @LMB_NOOVERWRITE: region cannot be resized
  */
 enum lmb_flags {
 	LMB_NONE		= 0,
-- 
2.45.2

