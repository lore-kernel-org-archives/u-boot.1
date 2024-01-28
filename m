Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0021C47258
	for <u-boot@archiver.kernel.org>; Sun, 28 Jan 2024 07:59:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADDDD880D0;
	Sun, 28 Jan 2024 08:59:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="W7YwNNrV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06CED880D4; Sun, 28 Jan 2024 08:59:03 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0130588056
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 08:58:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from localhost.localdomain
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id ABD223FB76; 
 Sun, 28 Jan 2024 07:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706428738;
 bh=a/39bq43kuMZ+Dlrt/Gyw+jKGZZ3RtlB5GfrwN9Pvwk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=W7YwNNrVB0ILzU9uLXzVQAb9t6YxkNe5W2dd2UOVVos/vYiAWo7sZ4wR99ZvfnRrJ
 pDEST4wHQVEHdb0Tq474Vn8w1cMvB8M3rEP7BGrkJLsaQNFcELzDt32dr055bWjjda
 mttjDwtWi3A0//PSusuzuIexXVbQEfqep4PpOxpyEdNtYK297polce9raF1PH9C4Eg
 x8H0dwPf4KgK7P/Q+HVqixHQpLiGgD48ROYQ+znzlKrZj2bv9PeZb6Bi/8AVT+ENwr
 uj+GdihaOi9CEoGYPma2R14sv2oqk/KTWoz+2N+bZ7P6Ld0hzSEQeP9gFCT2bWe43n
 8fQVm3t8wUUKg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] common: event: check event_type_name() argument
Date: Sun, 28 Jan 2024 08:58:55 +0100
Message-ID: <20240128075855.15687-1-heinrich.schuchardt@canonical.com>
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

In event_type_name() we should avoid possible buffer overruns by checking
the type argument.

Addresses-Coverity-ID: 478862 Out-of-bounds access
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 common/event.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/common/event.c b/common/event.c
index dc61b9672f3..16c2ba6cc92 100644
--- a/common/event.c
+++ b/common/event.c
@@ -56,7 +56,10 @@ _Static_assert(ARRAY_SIZE(type_name) == EVT_COUNT, "event type_name size");
 const char *event_type_name(enum event_t type)
 {
 #if CONFIG_IS_ENABLED(EVENT_DEBUG)
-	return type_name[type];
+	if (type < ARRAY_SIZE(type_name))
+		return type_name[type];
+	else
+		return "(unknown)";
 #else
 	return "(unknown)";
 #endif
-- 
2.43.0

