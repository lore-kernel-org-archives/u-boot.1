Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1E5CD4851
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 18:37:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B50008465A;
	Sat, 16 May 2026 20:37:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="G+OSVXyh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E42DB84686; Sat, 16 May 2026 20:37:04 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8C50845E3
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 20:37:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-176-199-115-125.um44.pools.vodafone-ip.de
 [176.199.115.125])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 379B43FBFF; 
 Sat, 16 May 2026 18:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1778956622;
 bh=0YI7Z8eH3pyDGQdjDZWRxwkNl5re54jhtcvTap3gRKk=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=G+OSVXyhWFruEljMR7YE4aYTLJiVh0oPOqycZISEPm2ZL2v4sSZsClGdN/4KdOu00
 7zY7cM1ytOzTrOJGn1Flf8z/fD263HnTBezHdtHL4+o5mwRMGhovYjyEO1jOSCFHUW
 /PNcsXARxQs5YQCVsUqkl8m9msQOEiMB8vpVf+toSXYQgbw2ve4XMkEg5hihOPNwfG
 9wPQHxS0EyExGfn0klhzsxikqSVQEuy2LN8DTwL+y11TQouPdI5uXCndJb+bZei2pS
 fLd3gY8VPLtzcJJUA8Lu9LkyQL4zxmvpqFzi/pFfl03GyOfLHhmrtbSIxOgavpmoGv
 0fQvyXjkvcbnr8/qBr6/ZRG0mHsFbAB6KaYI6mszteFtLntKBM+R8LAbzzSXKCa3C3
 hPxtrhLxr7U9yBxzDye/ONTAwgsY9YsXIHxoXizBKlvn5o5jkcdVpzjAsGL8i167ZQ
 O5x4P6Y4lgOlyJVZb6Pm7hndO+xvD/PblDOJYFHavyYZm965t/bc6cR4FE8yTmmMEe
 E7u5K7zFnijzUL5H2viI9J4I803Dzjcu7uTbTrESHhFQqlhlzf0orJ+Np/RrmS0kuf
 OC61moWTh1LDoymPnut7aXpSttmFZFgLPkGU+5Z9EyF7ypBX0B1dP3PRhxpM9kI/r/
 anLvvh3mHpOfL5EAL3Knoecc=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Daniel Palmer <daniel@thingy.jp>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] fs: fat: fix seconds in timestamp
Date: Sat, 16 May 2026 20:37:00 +0200
Message-ID: <20260516183700.7037-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
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

The FAT time format stores seconds/2 in bits 4:0. The expression
'tm.tm_sec > 1' is a boolean comparison (yields 0 or 1) where a
right-shift 'tm.tm_sec >> 1' was intended.  As a result every
file timestamp written by U-Boot has its seconds field set to
either 0 or 1, depending on whether tm_sec is greater than 1.

Also fix the indentation of the tm_hour line.

Fixes: ba23c378c544 ("fs: fat: fill creation and change date")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 fs/fat/fat_write.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
index c98b530f747..a1d28b4e305 100644
--- a/fs/fat/fat_write.c
+++ b/fs/fat/fat_write.c
@@ -1175,9 +1175,9 @@ static void dentry_set_time(dir_entry *dentptr)
 		date = (tm.tm_mday & 0x1f) |
 		       ((tm.tm_mon & 0xf) << 5) |
 		       ((tm.tm_year - 1980) << 9);
-		time = (tm.tm_sec > 1) |
+		time = (tm.tm_sec >> 1) |
 		       ((tm.tm_min & 0x3f) << 5) |
-		(tm.tm_hour << 11);
+		       (tm.tm_hour << 11);
 		dentptr->date = date;
 		dentptr->time = time;
 		return;
-- 
2.53.0

