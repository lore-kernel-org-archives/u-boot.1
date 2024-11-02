Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5D3E67804
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 15:41:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D4968898B;
	Sat,  2 Nov 2024 16:41:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="sZqb+b+K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 036888899C; Sat,  2 Nov 2024 16:41:54 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F377E8887A
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 16:41:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-107-023.46.114.pool.telefonica.de
 [46.114.107.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id DA8923F1C5; 
 Sat,  2 Nov 2024 15:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730562108;
 bh=a8BmI8ogMF4gCs5QnTfQbWlcMqf3eWpNJzztgge3biQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=sZqb+b+KkiLKy1Ai62SjBWGt9KQf2fs3xbBPvE4ZYhjlFVOa5ntbKeFa3wDCVlv6N
 aAjDz/WADQsgmldcKZDpS7RfQI5p+dJRtOZEzMeGlTXpo+uS3at6+WoqkBmiTrQdqs
 QyEdSe0ZPbhi3kVkovyiljYDaizyJxbsYR9F/gTtogO3rkEmZUkWDY7ytC3G4EcED/
 u4oGmOi3ng4Ybw6AuUCgVz+8RaRGZMHQbrpTUWS6l3zEOkGORMl6mnoCDTeRMvyo08
 GXYb6BOVjVJIjZpUMLfS7EcXgAu5k9v9k5h68s9X3qROsmZ9/hTqryvZfGxHCrmSXx
 8QafmngQMmo4A==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Alexander Gendin <agendin@matrox.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] test: cmd/mbr: pass correct buffer size to
 init_write_buffers
Date: Sat,  2 Nov 2024 16:41:30 +0100
Message-ID: <20241102154130.267948-1-heinrich.schuchardt@canonical.com>
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

We want to completely initialize the mbr and embr buffers. This requires
passing the buffer size and not the size of a pointer to the buffer.

Addresses-Coverity-ID: 510454 Wrong sizeof argument
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/cmd/mbr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/cmd/mbr.c b/test/cmd/mbr.c
index b14137e589a..16a8bc39e7e 100644
--- a/test/cmd/mbr.c
+++ b/test/cmd/mbr.c
@@ -277,7 +277,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 				 (ulong)0xbffe00 / BLKSZ));
 
 	/* Test one MBR partition */
-	init_write_buffers(mbr_wbuf, sizeof(mbr_wbuf), ebr_wbuf, sizeof(ebr_wbuf), __LINE__);
+	init_write_buffers(mbr_wbuf, BLKSZ, ebr_wbuf, BLKSZ, __LINE__);
 	ut_assertok(build_mbr_parts(mbr_parts_buf, sizeof(mbr_parts_buf), 1));
 	ut_assertok(run_commandf("write mmc 6:0 %lx 0 1", mbr_wa));
 	memset(rbuf, '\0', BLKSZ);
-- 
2.45.2

