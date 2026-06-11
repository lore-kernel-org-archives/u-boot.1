Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9488CD98CE
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 12:44:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B33FE84841;
	Thu, 11 Jun 2026 14:43:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NjF3uZCo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 080A9838D7; Thu, 11 Jun 2026 11:45:12 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6F8184664
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 11:45:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=allan.elkaim@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-490b9318997so56944665e9.2
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 02:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781171109; x=1781775909; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5yJuI6CsqroAg1Ru5hjHdRPGn1S9/TtORZmODxz/D7c=;
 b=NjF3uZCo7q0T50f3Rx4WUZ9mH/5lsye0c9kSZDrpgGxTel1yEU9QMZIyk4ZDlQ3673
 bA2P5RSVCI96cMaS6DlYSIdQvQjGt8EVGKtHbAfQ3bz+qV54R92JZ4ZXzXJehIuYt3LO
 bJO0Op2QWHc3h3LjDxi0Ae3MWelIr0HFAbd/jEOopYCca6gjjpu7vvWgub0SY0/grckQ
 EXh1QZSUySRhgBxHwrDETs7i4cyfRNTMY9kO7Ai5+x7glWyJgIRAcV3OzqwdNz8aS+86
 PV4iF4BeZMXQH6dS69BxkmpdNPk6xMu0ANnHHseidOuvPsFydc3GoY5mONEkBqnB1IH3
 F9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781171109; x=1781775909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5yJuI6CsqroAg1Ru5hjHdRPGn1S9/TtORZmODxz/D7c=;
 b=fKwduWlgsutB/SrogJhoS3jCDZ/uxwO0ByDUtzcKfFJE3qzeESeYSH8vX9TzlWx4CT
 6Fx+59yGQWyAqJTgR5VYYvKItMffEHfLscqUyzv1hE4dmC8My4eoHRZrwZvHITLX/CLu
 TJY/KC/MIs039/wZEwvxwJaEb0nD+K3Qkg/t3QUWqpqpiZplVPf4K4wbQbSECWfy1VcL
 GP39lOS3kox75YcVbsXgzAk4VS8nx8lMBBcsZeQRoVSe5tiucMycKqA2T2LGV5EkXzUd
 3QhRaM/ryBQ6IvlhB5SeMNNhqZZpP04+TMdM19fp0UbvACKkvVihz1ORdOiNH9EyV3ZA
 srtg==
X-Gm-Message-State: AOJu0YwKI3/aa8VvnOcAaDbz0G6lS5ZBeLp5TKe8t2kDPNkPfZ1UuXTZ
 v+aGve1dR+dgX9G8rfo+VeuZkN4Sa/HE8Sd/cnRSpXqrAFkJyUiW8E3XvAwGcHujZig=
X-Gm-Gg: Acq92OGWxgSRkUZ9jQepgDOGnswanrd0zodIMsgtgC+NJiPzTyzkrlvpnkCRjZteEBN
 PosZmSdDwlEUlIjMGB2nym/np37vDbcqC5QighX4m+7TC+zR+XPmRKDSUbDooQ9X9S6yDr6uU+C
 VXpt2qVs0kharpDDBF24VrLwgm39vod+JDp3f1W72912GaxT6/bRsJ2oiOWAxDadlbY+bqrpbCv
 HLjRAu8ZMJ936qTxziqJWHYcBF0/4rVYcjBX10/ojw4KaFvfJdv/i0h9LOhEkwgxffwiQjwBgly
 nP+jPeDE/mfC6Uo/6jVOt1wcp0I/lPCcCJFeRanAhBOBrTsiRbnypN+CT4FghelwZjpCx1hmaDj
 9JNowXPpJSaONlo8GmfYc2+1542Ej9wrB/FARhWQEM9OvKyQaMXSjnKAz8e4EuzISbt25Wv5HCX
 STcxBjkcTn2bWmc25CnmE9d1Nd4Joh505BXnzrK9OsieigYHZI7C7uw35TPtedANI5SJL/PAenf
 ykGjMjE/QNQs69Z1OCPNK6ABO1UN/GSKDTpZy9xHTzrta4S3W4lQyqoxuGoil4UkcFoB3lgWR/t
 J7uK+O46yi0eE75fxtA9BPoFjzkw2SfvXPZE0ewdC11+Jbmgj8g=
X-Received: by 2002:a05:600c:4f95:b0:490:601f:d775 with SMTP id
 5b1f17b1804b1-490e55b8672mr24326725e9.5.1781171108922; 
 Thu, 11 Jun 2026 02:45:08 -0700 (PDT)
Received: from thinkpad-t15g-g2 (lfbn-idf2-1-525-203.w86-246.abo.wanadoo.fr.
 [86.246.224.203]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2ca21f4sm51499075e9.7.2026.06.11.02.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 02:45:08 -0700 (PDT)
From: Allan ELKAIM <allan.elkaim@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Joao Marcos Costa <jmcosta944@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Allan ELKAIM <allan.elkaim@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH v2 3/3] fs/squashfs: fix dirs->entry leak on inode lookup
 failure
Date: Thu, 11 Jun 2026 11:43:47 +0200
Message-ID: <20260611094353.722555-4-allan.elkaim@gmail.com>
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

In sqfs_search_dir(), when sqfs_find_inode() fails to locate the inode
of a directory entry just returned by sqfs_readdir_nest(), the function
returns directly while dirs->entry still holds the entry allocation,
leaking it. The bare return also bypasses the regular error path.

Free the entry and leave through the out label instead, consistent
with the other error paths in this function.

Signed-off-by: Allan ELKAIM <allan.elkaim@gmail.com>
---

Changes in v2:
- New patch, fixing a pre-existing leak of the same kind as the ones
  addressed in patch 2 (suggested by Richard Genoud's review)

 fs/squashfs/sqfs.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index af32d008..df988774 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -547,8 +547,12 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
 		/* Get reference to inode in the inode table */
 		table = sqfs_find_inode(dirs->inode_table, new_inode_number,
 					sblk->inodes, sblk->block_size);
-		if (!table)
-			return -EINVAL;
+		if (!table) {
+			free(dirs->entry);
+			dirs->entry = NULL;
+			ret = -EINVAL;
+			goto out;
+		}
 		dir = (struct squashfs_dir_inode *)table;
 
 		/* Check for symbolic link and inode type sanity */
-- 
2.53.0

