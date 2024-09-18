Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20429CDD55D
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 22:01:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 932938901F;
	Thu, 19 Sep 2024 00:01:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="mtp/5WuP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 248FD89020; Thu, 19 Sep 2024 00:01:18 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AFBB8901C
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 00:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-110-162.46.114.pool.telefonica.de
 [46.114.110.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 9F67C3F1C6; 
 Wed, 18 Sep 2024 22:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1726696875;
 bh=Y8B4O3CUnUpLNew2inL25LIiO2lU8vtvhXvh5LyeohI=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=mtp/5WuPMP/ejUj3H0zRPTqd3k/jERZQU+1pnVfBB5kNrpnAg2hpR26gNBMyHyuOu
 pvAsu2ldIU4fYMqfLMETEkbpAGkE/TWI3w7QvahNstpJywUTDlLj2vsVFLD9YyE1xy
 Tg9RnC2foIXXvQ0a9gbFPbDZaTcAJqL6L0KNKieRmkHIcpJLc0T3PkOhZRjyvAu923
 YeOylmmgg0pihFTWFqTIAMgRXbmcaPlqaF0SzUiatrUQTDBpstHQoUMaId4S/acjrl
 0YKKoBaA6ZbsEYvZG5Jhe9iR8YoP8gsixaKoS1hbcdUTgTFsutpaGDuk9iwrgTbvIE
 nNStOzu1TF6lQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] events: correct event_uninit() description
Date: Thu, 19 Sep 2024 00:01:13 +0200
Message-ID: <20240918220113.22247-1-heinrich.schuchardt@canonical.com>
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

The function name in the description must match the function.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/event.h b/include/event.h
index fb353ad623e..75141a192a4 100644
--- a/include/event.h
+++ b/include/event.h
@@ -385,7 +385,7 @@ static inline int event_notify_null(enum event_t type)
 int event_uninit(void);
 
 /**
- * event_uninit() - Set up dynamic events
+ * event_init() - Set up dynamic events
  *
  * Init a list of dynamic event handlers, so that these can be added as
  * needed
-- 
2.45.2

