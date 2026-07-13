Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12336C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 20:00:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE2A084CA4;
	Mon, 13 Jul 2026 21:59:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Os0Sq0hq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B50DA84C4F; Mon, 13 Jul 2026 16:27:04 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4DE084C06
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 16:27:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=allan.elkaim@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-47dec32798aso3312091f8f.1
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 07:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783952822; x=1784557622; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=axvvkqPr7KkIUrHu5YdnkcBPhKQ7sOoI7vqolHKc3RM=;
 b=Os0Sq0hqqMl0oLlXJyiA0tXZj/CwFNoYXwECNKh5E+VSqtDvD4OWoVd64vMSZJraoo
 Nr6APAyr3EGlrcx/EroJCcd6zh0gBo5NRcLNV3JkL0oxus8jT5LUiNg5SGXVaBKkVTfL
 26lLuKbOoCthS6Uc2NZu0XxPs8oLYa6Ra2JIoKzLMUsW77rlTd7ko0xqbPgQ7H0aFxMZ
 NFu7oLMyxAKgEXY4fd6qDYsCe8Gd9hyKaUb0KetZwvW9MPQq18eix9/tFnU0gYhf2A8T
 bC5A8R94czwJ2xaZ1iv+D51OjUjvECYEeePHOIyMQRrFq1dQvyxzX86LGFdUS39NWZhU
 p8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783952822; x=1784557622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=axvvkqPr7KkIUrHu5YdnkcBPhKQ7sOoI7vqolHKc3RM=;
 b=AOCic2PyCau0KNLrOMyYhDHWHuOAXKpVsIQAACXjWku3QFQVvvXr4FQzQ9IqY/HjMJ
 hHN9RRoKflk+1EMlgo7JcpalsI5z/V5/hERfD8KyYoWQlvSk2gqrbiZHTfClCS+OHtCh
 T9kyrhwK+5sT3yrZcPmywhTCbP5kVfXKfUV/IDBjJWpHAotiBApdM/J3WceihM5VWe8c
 66wKfEQ53yjwgP3lvHJKEoDgk8BIQPXjYBmvMBPedsO48B8ZO5+pI6Lx2EO5FSIX6Fm/
 dE+R4hpmesiiQsFnCzSmRpaW4VaexoWPKBNqag59SixhT3y3FdXBy1eYXgzqAnb/7qHo
 vO6w==
X-Gm-Message-State: AOJu0YwrlGsfKzlpqSbca14waGT6jpn3bxVz4fVBNVPDDR1MREVJYnpu
 kvM3+h/w67kEOOOuDefG/OA/ytXJTqWZsnFeTSAu5EY10KyvD1mXpMVR1PxbsodQ
X-Gm-Gg: AfdE7cl3geaGwvjE1dakEQa0OMEdNtxItSoIjv3P+ULRptp0C/oNuN+1ctrcOGHz0UM
 pYQejoqMWVIMWVypfrzayORPuOdhIm8uUKoy8foBcVFkkb3YY3J7Y8HKXPmdfD/pCDoRMX5vi8m
 mzn9a8GUqz4TITdbQmroPAOjAZtXJfpi4RVot6wm1bay8GcY94vs5qB3zWXKObA1zqySnCcjOO6
 ZK4RSHLgppFUcoI7ssBw0/Zm8teW7Q8dkLmIHQCF3HBbo5t5rySkS8v9l07BRQ833U8ILILePiK
 1OrIYQu/eibJkDp95nCToKd5L9DRHYK1bmIxd07J2M5y2t916nFW1gnP9zahuJawoQC6CVeOhTf
 rJ7FDbLF8nnIcgKGaDmQ8vtM79d8lQKeKt8bSkqvsDCgjEbhHVetxvEwk9OE+Jb+auwYKxBD4aa
 Ca7mKf5M8mXnz1D/LOTFgcew6RvzU6G1ZpdLZ49d4c0BeZsmLMqSBC47KKyrczlj4KjuHiPA5FU
 p/ArL0dh6dMK3AE63OvWL4GkSk2j1UVBeCdOAxz3vupU7DCcJzTIc9I0JrAtSdEyso7GHAx7Xtv
 MkAX
X-Received: by 2002:a05:6000:2511:b0:43b:498f:dceb with SMTP id
 ffacd0b85a97d-47f2dc8cc19mr11387251f8f.9.1783952822288; 
 Mon, 13 Jul 2026 07:27:02 -0700 (PDT)
Received: from thinkpad-t15g-g2 (82-64-82-74.subs.proxad.net. [82.64.82.74])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d83bdsm83691562f8f.13.2026.07.13.07.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 07:27:01 -0700 (PDT)
From: Allan ELKAIM <allan.elkaim@gmail.com>
To: u-boot@lists.denx.de
Cc: Joao Marcos Costa <jmcosta944@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tom Rini <trini@konsulko.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Allan ELKAIM <allan.elkaim@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH v3 2/3] fs/squashfs: add sqfs_dir_offset() error checks
Date: Mon, 13 Jul 2026 16:22:45 +0200
Message-ID: <20260713142420.2618339-5-allan.elkaim@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713142420.2618339-1-allan.elkaim@gmail.com>
References: <20260713142420.2618339-1-allan.elkaim@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 13 Jul 2026 21:59:35 +0200
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

sqfs_dir_offset() returns a negative errno on failure, but three
call sites in sqfs_search_dir() use the return value as an array
index without checking for errors first. If the lookup fails,
dirs->table is set to an invalid address, leading to undefined
behavior.

Add negative-value guards after each sqfs_dir_offset() call so
that any lookup failure propagates cleanly as an error rather
than producing incorrect results.

Note: the corresponding sqfs_find_inode() NULL checks and the
heap exhaustion fix during symlink resolution are applied in
separate patches.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Richard Genoud <richard.genoud@bootlin.com>
Signed-off-by: Allan ELKAIM <allan.elkaim@gmail.com>
---

(no changes since v2)

Changes in v2:
- Free dirs->entry and reset it to NULL in the two error paths
  reachable while a directory entry is held, so a lookup failure
  no longer leaks the entry (reported by Richard Genoud)

 fs/squashfs/sqfs.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index 07e2bd82..af32d008 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -496,6 +496,8 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
 
 	/* get directory offset in directory table */
 	offset = sqfs_dir_offset(table, m_list, m_count);
+	if (offset < 0)
+		return offset;
 	dirs->table = &dirs->dir_table[offset];
 
 	/* Setup directory header */
@@ -627,6 +629,12 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
 
 		/* Get dir. offset into the directory table */
 		offset = sqfs_dir_offset(table, m_list, m_count);
+		if (offset < 0) {
+			free(dirs->entry);
+			dirs->entry = NULL;
+			ret = offset;
+			goto out;
+		}
 		dirs->table = &dirs->dir_table[offset];
 
 		/* Copy directory header */
@@ -651,6 +659,12 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
 	}
 
 	offset = sqfs_dir_offset(table, m_list, m_count);
+	if (offset < 0) {
+		free(dirs->entry);
+		dirs->entry = NULL;
+		ret = offset;
+		goto out;
+	}
 	dirs->table = &dirs->dir_table[offset];
 
 	if (get_unaligned_le16(&dir->inode_type) == SQFS_DIR_TYPE)
-- 
2.53.0

