Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47DB7C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 07:19:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89B9683E63;
	Fri, 11 Apr 2025 09:19:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="G+pkqqQf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2254083EBA; Fri, 11 Apr 2025 09:19:08 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 018D682B39
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 09:19:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-109-163.46.114.pool.telefonica.de
 [46.114.109.163])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 7D14A3FF0B; 
 Fri, 11 Apr 2025 07:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1744355944;
 bh=X2YvWuEPnqNqyrNu1hl7ZSUV+cQ8pA6z4Uw9n77iBME=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=G+pkqqQfGqr5wbHR20L9mfv8cIq9oBC+gyMlNKece79v8ymGu6nFizV/gzQvX4pCQ
 TQiyKBpP3uiRIofAi4nUNI/4TBZ+hsgXomF+eVy4WwsHrOfIjA1+6U4FzMBHbML0Hq
 UUNXrPFHUSifgKnRKGJkfl0Srr2enmuXTN0e4WCeVyNwhwhFO+ZFs7tCEByWFllEB/
 ipAawUgWRPwoenmzva3n9nb4mh8dEg0H33IcEEHSPpTXGKADHWFgsRWEcwkCwJdJMY
 1rWGr5ahVnQS1hDvVsHG9o9gjHN4HWOM1uKU/zV33/lRduwVwOWsMsZW4DkKpYTPvn
 7sVHU4+mII2XA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Joao Marcos Costa <jmcosta944@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] fs/sqaushfs: avoid illegal free() in sqfs_opendir()
Date: Fri, 11 Apr 2025 09:19:00 +0200
Message-ID: <20250411071900.36136-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

* Use calloc() to allocate token_list. This avoids an illegal free if
  sqfs_tokenize() fails.
* Do not iterate over token_list if it has not been allocated.

Addresses-Coverity-ID: 510453:  Null pointer dereferences  (FORWARD_NULL)
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 fs/squashfs/sqfs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index 7c364686f14..2dcdd60f683 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -949,7 +949,7 @@ static int sqfs_opendir_nest(const char *filename, struct fs_dir_stream **dirsp)
 		goto out;
 	}
 
-	token_list = malloc(token_count * sizeof(char *));
+	token_list = calloc(token_count, sizeof(char *));
 	if (!token_list) {
 		ret = -EINVAL;
 		goto out;
@@ -987,9 +987,11 @@ static int sqfs_opendir_nest(const char *filename, struct fs_dir_stream **dirsp)
 	*dirsp = (struct fs_dir_stream *)dirs;
 
 out:
-	for (j = 0; j < token_count; j++)
-		free(token_list[j]);
-	free(token_list);
+	if (token_list) {
+		for (j = 0; j < token_count; j++)
+			free(token_list[j]);
+		free(token_list);
+	}
 	free(pos_list);
 	free(path);
 	if (ret) {
-- 
2.48.1

