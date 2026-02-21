Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5395C61DCB
	for <u-boot@archiver.kernel.org>; Sat, 21 Feb 2026 10:01:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A67AB83E88;
	Sat, 21 Feb 2026 11:01:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RcygwMlK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98BBD83EE2; Sat, 21 Feb 2026 11:01:02 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7971383EC8
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 11:01:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=zajec5@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-65bebcbffe8so5401774a12.1
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 02:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771668060; x=1772272860; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RTr4sYVOpLwYpVOaSl0v6pl77oop1BvVPAL9pe9+vhQ=;
 b=RcygwMlKxLrnfErohDwcMk0kFdiiOdpIpBI3gz2kzGOg4dS9FcVb4tsc4oTIFg7MS6
 alkpzISOLFnFl52ha+Q46ONbTT/aaXN/jzBozGYjqefnsuCZLc+qkWDPLS0qlTnBuV1l
 ZNftZ0LXoOyL43unHb+dPOydR9aofd59aj1Gh2SztdIiD1ZKfmMR5BpsSz/S9/H7yM4Y
 RGwhYOxa/hr6A0qSRYTcc6kM3l2u9Wgwo9HYXC+K/XMftZLjrBSqNVN8UyIicya1uY5H
 1BAuhIHd16kghrgHBqgG51bi35viqPwbkPBFe9IahILeXrhI0IYoL9XUYWwF7Aynxt6j
 u1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771668060; x=1772272860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RTr4sYVOpLwYpVOaSl0v6pl77oop1BvVPAL9pe9+vhQ=;
 b=M5XI1HD7QG/dlwxAW5hHaZdeRjH0clqmSJJpia8ZsqUvPkQJrLoNs2vNv0aIQSnAxx
 t/6/ta7aFnv0wkQkRAY0BS5W3oqKpGiQPh7agayoT924GjtzMZWlLoDcwHZ910/c8lKa
 iOatqLHvt1dXkhZ3smoFW04gHfKslwTSCRkIh1BbT15R94AhNTbDGnLvEhJm95J8KXPk
 qFfYeCMJBV6eGqJU0/j3q26pmJ9nqkDABItheW/+Mf+ygn+uDAdO6ns8BVfox8uVN6Qd
 r+FFm6L74g4VWwig7sIPw5EkTvkX6LyHAjxQCqA8+TlkSzUlzRsItSyOp1+HIM6LWPyO
 i47A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB8ug/wSUqK1pOc6Wlu2ZvNN+4wdRmKJS2uCauakqkrFsu/AUSEEyQkoCe7nZqCkS+bWmNUbs=@lists.denx.de
X-Gm-Message-State: AOJu0YwVciAXIYMlewEpkz5/yq4ty1PMY18AXwojxbM3ZtlHHH0Vkcbx
 XdgeThwGqFolZSKmhNjHC0KLzOIvt44mOB3Jj8TK07JEFTNY4e2XkBNQ
X-Gm-Gg: AZuq6aKahOewqD7uiPIvBS/JsFGr77NoRDHH6htgxU2EcJ0+I5b2yN2eh7al8mWadl5
 a4Pg+1UOLiHY010ZKGg19USZhmxzU8aWOEN9fDWJ/UF1lOUVHPw1gtdxOIazgHZo7TJBU9GtWK6
 4KHHrCSSky2EnduvYWaOTQ3mSiNan26YNs0OSHaYyLGeERZ8TjJePj9RLqveLRQuhiJjyXUqvqT
 RHqskVoe0nuk5X19FCnzf8I+cgLfHzpTQna4i7eD0JVto5itVNCnCyMJu1EHwbAdoMJ+nLRZTe3
 dSY5znOWo+SaWlXdEJelmVfPDNXSegCzHjS0BMeowGMrU3Fsy0AnDD0xfz/oPNeIHyQkwmt1D9A
 x8tzEz10ks8gWD4FxR8d78oUdeksswcdJZlfnoyR8AbxPIvjVUih2IMH7wSBiBoz+p9n2OjMc02
 Tc398okWmcHPExhJBQH1iLjtxnBYdWWSGzK5ldKcf9CmCC7DZhGkp0eKkcPg/dRe4W
X-Received: by 2002:a05:6402:51c8:b0:65a:2f31:808 with SMTP id
 4fb4d7f45d1cf-65ea4f1d08bmr1655150a12.32.1771668059854; 
 Sat, 21 Feb 2026 02:00:59 -0800 (PST)
Received: from localhost.localdomain.pl ([89.151.31.85])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65eab9aabb2sm421298a12.8.2026.02.21.02.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Feb 2026 02:00:59 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 6/6] fw_env: drop unneeded variables from flash_write_buf()
Date: Sat, 21 Feb 2026 11:00:11 +0100
Message-ID: <20260221100011.29049-7-zajec5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260221100011.29049-1-zajec5@gmail.com>
References: <20260221100011.29049-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Rafał Miłecki <rafal@milecki.pl>

Recent cleanups made some variables redundant. Both: "blocklen" and
"erase_len" ended up being used as temporary variables used locally in
some short code paths.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 tools/env/fw_env.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/tools/env/fw_env.c b/tools/env/fw_env.c
index de3a33a380d..49a068d91cc 100644
--- a/tools/env/fw_env.c
+++ b/tools/env/fw_env.c
@@ -984,9 +984,6 @@ static int flash_write_buf(int dev, int fd, void *buf, size_t count)
 {
 	void *data;
 	struct erase_info_user erase;
-	size_t blocklen;	/* length of NAND block / NOR erase sector */
-	size_t erase_len;	/* whole area that can be erased - may include
-				   bad blocks */
 	size_t erasesize;	/* erase / write length - one block on NAND,
 				   whole area on NOR */
 	size_t processed = 0;	/* progress counter */
@@ -1005,26 +1002,20 @@ static int flash_write_buf(int dev, int fd, void *buf, size_t count)
 	 * For mtd devices only offset and size of the environment do matter
 	 */
 	if (DEVTYPE(dev) == MTD_ABSENT) {
-		blocklen = count;
-		erase_len = blocklen;
-		erasesize = erase_len;
+		erasesize = count;
 		block_seek = 0;
-		write_total = blocklen;
+		write_total = count;
 	} else {
-		blocklen = DEVESIZE(dev);
-
 		erase_offset = DEVOFFSET(dev);
 
-		/* Maximum area we may use */
-		erase_len = environment_end(dev) - erase_offset;
 		if (DEVTYPE(dev) == MTD_NANDFLASH) {
 			/*
 			 * NAND: calculate which blocks we are writing. We have
 			 * to write one block at a time to skip bad blocks.
 			 */
-			erasesize = blocklen;
+			erasesize = DEVESIZE(dev);
 		} else {
-			erasesize = erase_len;
+			erasesize = environment_end(dev) - erase_offset;
 		}
 
 		/* Offset inside a block */
@@ -1035,7 +1026,7 @@ static int flash_write_buf(int dev, int fd, void *buf, size_t count)
 		 * to the start of the data, then count bytes of data, and
 		 * to the end of the block
 		 */
-		write_total = ROUND_UP(block_seek + count, blocklen);
+		write_total = ROUND_UP(block_seek + count, DEVESIZE(dev));
 	}
 
 	/*
@@ -1074,7 +1065,7 @@ static int flash_write_buf(int dev, int fd, void *buf, size_t count)
 	} else {
 		/*
 		 * We get here, iff offset is block-aligned and count is a
-		 * multiple of blocklen - see write_total calculation above
+		 * multiple of erase size - see write_total calculation above
 		 */
 		data = buf;
 	}
-- 
2.51.0

