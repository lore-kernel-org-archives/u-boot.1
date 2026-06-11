Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA3BCD98CE
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 12:43:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71B4784701;
	Thu, 11 Jun 2026 14:43:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OzXAatVh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1186B838D7; Thu, 11 Jun 2026 11:45:08 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3340383FEC
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 11:45:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=allan.elkaim@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-490bc6a7958so7117875e9.1
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 02:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781171106; x=1781775906; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SgFLtOWwAiW/KkIJayJclF0i2Aw24p4yBXlb4r2PDek=;
 b=OzXAatVhkqYIc4U6/7zo+zifUEvI5eMrACR9iju8TY+H9kgnVjfhJGOdAavtd8v8Dz
 KhEwoOeeYAQJf/GDiuivCStbrm3ewXDb/r+5renf3BTPabXlbhLcNcvKyHYcm6HMWgKi
 4tMqTZE6RRI7Y9dIE0D2kr/O6c0rZUiGcGnTbZIbuE5CYMYSnTHgVymSQj/YTv5etEsd
 NRonjLOnoRL6i3mQ5wG5qReWemCP2Qbs3Dh5alRsV/jjIe4W7tfWDblFnXlAwSM4QLTg
 zq8Ao9RqkAtnpkjzcFka9haMJb0t0OM69hw2Zek6zYKY4I0QGx14tbYqr0DYqWtXkm1E
 ybfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781171106; x=1781775906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SgFLtOWwAiW/KkIJayJclF0i2Aw24p4yBXlb4r2PDek=;
 b=RXmA2wsWunvjx2mTyH4KxB2hpq6GZ4G/SH/mi8gIq5ymn4Q2Po4mLszYP/aj3oSyr/
 Ix7R9YEcsTc+8NCw77pLq/TuyvY9ItRP31oVCmpDaHi/1fx9sz8su2R9TtkCZtQPOkU3
 +mhwPJgcZPiJDD+68IFKuB8hqGXlpvZl0w83mig3nKXzIuNncP/v26wHjrZ9vz/xx/bw
 ozIg4xFooErnfX06i4FvyOO+7BuWna+lOc+3jwGucZD9vd1LDw7lcAQQ8l1A9Cfyws5e
 zfb63Km9PHseYUDTbPJ7JCXdkjOENlSOUPrUnwwsDMBLekO+xgRMupguzCMzCqCQ9soX
 8Fsw==
X-Gm-Message-State: AOJu0Yx/DZz4HT/kEc7s5PKGEsFxRrHh6fa7VRIL53RbKb4P5+8erOi2
 5Bg77Bn2wuZezPiQjuTC9G7IPcZKCIcwKaHyOVQJ0Gbx+GnFvYvOz4yZ3tfGBQoKBvg=
X-Gm-Gg: Acq92OFX6p4d4niicqZDKC8kpiwyF+HXMbvdUBIPm54fXV3u4nbJ2J5hvoFysxummP0
 pSUJ3SgF73lV1FSl/a9DEXU0crLzdUQ+svheQ9LxpjFc0w6c8id3Pf8fwtn4qK1dVp7XdQF+bUh
 HeUoNOOmmUVFigSQ61eplBKqkJmttylJYNrsOBS5Hs4+H+6dFJV4+n7iCxWzA0XCskoJ44BGk1M
 fL/yL5MIoHamB6w5nNvOU+MllY6yfH6rX+71R278hlimIdNGafpvXySA9PiWv4UWvSnb+nQEhlI
 HIqpAVtSC/m4MXe/WoB0o3UCB+pGwgOxbOk9lmL/9faqpOL+ytnHM/CkaOEuNZbkOfZwueGZyWU
 VKZ5WfrXJZikohgzGR7YQ2dlxUXGAVFcaYHn1cXlSXp57M/Bq1f3w0XqM+kkalCjrx4VZD0AsW5
 xKE/lPwRVpE7wwRxMqLcDdLY17E6GsihG3DA5gAGsLW4OXstmUxQDG2Dw7IfWNoJaf8dJoXgshF
 tJvMtQjBslGn8+uUS0t0YDgpJz1FV74t1lVx61PVOT/A/JyjNmDl+Z/2T0ikYFsdZnJre7y1rem
 Y53hYB6mdbmZjlMY0AttPUuzUH/JlBwcO0kpxZQWq6xsGQZXH4A=
X-Received: by 2002:a05:600c:3e0b:b0:490:b4a8:e031 with SMTP id
 5b1f17b1804b1-490e52cae48mr22194445e9.4.1781171105560; 
 Thu, 11 Jun 2026 02:45:05 -0700 (PDT)
Received: from thinkpad-t15g-g2 (lfbn-idf2-1-525-203.w86-246.abo.wanadoo.fr.
 [86.246.224.203]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2ca21f4sm51499075e9.7.2026.06.11.02.45.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 02:45:05 -0700 (PDT)
From: Allan ELKAIM <allan.elkaim@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Joao Marcos Costa <jmcosta944@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Allan ELKAIM <allan.elkaim@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH v2 2/3] fs/squashfs: add sqfs_dir_offset() error checks
Date: Thu, 11 Jun 2026 11:43:46 +0200
Message-ID: <20260611094353.722555-3-allan.elkaim@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611094353.722555-1-allan.elkaim@gmail.com>
References: <20260611094353.722555-1-allan.elkaim@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 11 Jun 2026 14:43:41 +0200
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

Signed-off-by: Allan ELKAIM <allan.elkaim@gmail.com>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
---

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

