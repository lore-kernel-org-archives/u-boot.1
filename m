Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC946CD11DD
	for <u-boot@archiver.kernel.org>; Fri, 29 Mar 2024 16:09:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1F4488203;
	Fri, 29 Mar 2024 17:09:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="MTXvha5y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF2F488219; Fri, 29 Mar 2024 17:09:21 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08EB687B1A
 for <u-boot@lists.denx.de>; Fri, 29 Mar 2024 17:09:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-245-032.um16.pools.vodafone-ip.de
 [62.143.245.32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 386283F27E; 
 Fri, 29 Mar 2024 16:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1711728559;
 bh=BA+0YlkzBRZdY0ms34jDISVnIdbT6Ap+GUthCujD7+s=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=MTXvha5yK5MBs/gJyKstQknqh3xDiZzrGb70hPW/1IQFSfJ1r7DpctAuwFFutFGFx
 uLnW/LlutnvIKIyq1GIjcv1iNgG8vJVcHNR4W4qyacNH8NJpymPmT+Rc5X9bZ9YzAj
 XHGhFt47N9j9bI/1NTiD6wqv+vIk4hwFS7JyKvcmQvT4t4c0Vvkn7Qi6HOSRGuVX7X
 Az97OGDA3dKkJd/VIJmX0qNEIzvzhiGNtE8+WhbpnvmQoWhkXNY324H6KPYR/P5K6R
 ZBqooD0Ja1YH1AdY80sw1JXmCBS4zZQT9q/2ldmGRCAUyaxfBr2woIe6OCfIKyDtYe
 2WYDc4k1EM1aQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] cli: always show cursor
Date: Fri, 29 Mar 2024 17:09:22 +0100
Message-ID: <20240329160922.127095-1-heinrich.schuchardt@canonical.com>
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

We may enter the command line interface in a state where on the remote
console the cursor is not shown. Send an escape sequence to enable it.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 common/cli.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/common/cli.c b/common/cli.c
index a34938294ec..1c33daf1149 100644
--- a/common/cli.c
+++ b/common/cli.c
@@ -11,6 +11,7 @@
 #define pr_fmt(fmt) "cli: %s: " fmt, __func__
 
 #include <common.h>
+#include <ansi.h>
 #include <bootstage.h>
 #include <cli.h>
 #include <cli_hush.h>
@@ -336,4 +337,7 @@ void cli_init(void)
 #if defined(CONFIG_HUSH_INIT_VAR)
 	hush_init_var();
 #endif
+
+	if (CONFIG_IS_ENABLED(VIDEO_ANSI))
+		printf(ANSI_CURSOR_SHOW "\n");
 }
-- 
2.43.0

