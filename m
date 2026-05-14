Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1828BCD4F39
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 23:40:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F5C4846B0;
	Fri, 15 May 2026 01:39:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MIm0IbH/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EDCC84687; Thu, 14 May 2026 20:21:04 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B75284694
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 20:21:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=allan.elkaim@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48e6db3ff7eso35536805e9.0
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 11:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778782862; x=1779387662; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GaFvlXpt75ZOpyvmvnvs1APaQpKRoH37rU5Th9XuiWg=;
 b=MIm0IbH/XNMQpItr3IMLevUrepyco9nFHvoz0xGA6Ea4pQK8j9Rkxwo2PS6Apv+8nd
 tn34zLTbMbKFETk+dLJYQOtblTkQfMIfG7pU5yPRLSrKH8xfwOF1LXX9D+E19uCIqMdw
 6rrpkv1EgFWEVPuu+lYHHp8A4Nyo/2QD1GXHIuStWw6nzFFJ0WULUpqBCGEIU9OUCaw9
 /Lr1lGQSpe7P94yuMOiAWR3nXLw6dIvMr/MqyO0GTD9GoBA+2euIy8kDtPxzhJGBqnr3
 vF4aE7zKC6cNJZHEGeqjot1KZdDgXMR35R28L7KHx89JKrXMOAzg6qI8Pj7wr5L/1NAO
 4jHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778782862; x=1779387662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GaFvlXpt75ZOpyvmvnvs1APaQpKRoH37rU5Th9XuiWg=;
 b=fxFhQMirtZvCVEBEwhKJ1f9pi6RiSYjPwdly4rQWo+RevnTN1BqOObghyQy+J+6HxB
 N3E9owLG7RwoO6RoiBGY5XW+KCsUpRgW0k2u12dxcul/oODLtJHRngjtAyTJZvIanBRO
 nMQOhdim5d37E8S4+JHifhTKJfbyra9hIetLUG4/KXraQUsDu2Z+WjdoKRPAW4ud+2qp
 cfXvo0PMTEBl4nU6A7gxCNG4UdzKgySpQFBmzzDdgeAZ+R0A6G+IwXGcmCRzMUw7aUjI
 +3RugLUeQLBy1+1JVjYUDdd34r7G5OUkr4a+BzpPGBgTP/OTw9mjWYhZklV59zDR4GRO
 euKw==
X-Gm-Message-State: AOJu0YzZxhFOXzhVvB5r7UOXpe0LWBogua/tdpPPJ9vbRimWtDBh6fod
 VxEnJgty/CzK69vzlf86V7p+2081HqeuF+F5zkL5DetWmzkv6AFoLEMdP4BXUpKukOw=
X-Gm-Gg: Acq92OG8PsBOcbJiS/rmLDbF6BNWO5SdC135FQGvehyyURWnROMIaut/nCPzNwJfOeW
 WDPQf+snKdqGw8k/FsWqd+dAk7jTUK672SxGeIVjZPYiz27zbTedq7rdi0FqaMeaYn9Elmv0qWn
 Aacaio7LzWsCg3BEsGGgBBR49DCIzBJcK9pBXoNH4IhL5reytnYjWCMfH8gyx1Z6r4ziN5XHtoY
 1cwl1lBoJgyF4vYjvFy1ZBA3855A/D6nYXRvDa/SMsW0wc3/fmgcI5vyl3zsMozYAhGwWV4wHbF
 sX8uGzo1VCkvn+MUI+r3Les9UXKFx0Vi+RDA3JgPBA0zKMpvszh3+68/hMSXgeRVXdTBsAgK+TH
 QiekvAs3jT7mlt5TI85sRtGBdAGvDTwUuTGplo2keAQKWQA1W80WcqoS0u/1nzhSohTEyIlz4Bc
 xf7CTvaCsjvtXQVD+wW10bjxkAX+4M9aumo29c9uLwml/8S+Odztb8qdce1nvqxqjFAxg0YcGNx
 FsrpoJFGLqSMfdBaWqKzibs+WvE/q7E/mRbAyFOUw4XN8fkAhuJ4g940IEzXU/5pxW2GFzqcCQj
 6X0Z
X-Received: by 2002:a05:600c:3b0f:b0:48f:e230:72fb with SMTP id
 5b1f17b1804b1-48fe6631512mr6557305e9.32.1778782861972; 
 Thu, 14 May 2026 11:21:01 -0700 (PDT)
Received: from thinkpad-t15g-g2 ([2a01:e0a:905:5c10:111d:8a59:d7b9:c8a9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe53ab773sm7973575e9.3.2026.05.14.11.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 11:21:01 -0700 (PDT)
From: Allan ELKAIM <allan.elkaim@gmail.com>
To: u-boot@lists.denx.de
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tom Rini <trini@konsulko.com>, Allan ELKAIM <allan.elkaim@gmail.com>
Subject: [PATCH v1 2/2] fs/squashfs: add sqfs_dir_offset() error checks
Date: Thu, 14 May 2026 20:18:53 +0200
Message-ID: <20260514181854.399679-6-allan.elkaim@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260514181854.399679-3-allan.elkaim@gmail.com>
References: <"CACgNL-F2=KJtZ+gThpx_BuWsn6puqFxK0uLOmnABSS9=rRQmeQ@mail.gmail.com">
 <20260514181854.399679-3-allan.elkaim@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 15 May 2026 01:39:52 +0200
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
---

 fs/squashfs/sqfs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index 07e2bd82..430e9bac 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -496,6 +496,8 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
 
 	/* get directory offset in directory table */
 	offset = sqfs_dir_offset(table, m_list, m_count);
+	if (offset < 0)
+		return offset;
 	dirs->table = &dirs->dir_table[offset];
 
 	/* Setup directory header */
@@ -627,6 +629,10 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
 
 		/* Get dir. offset into the directory table */
 		offset = sqfs_dir_offset(table, m_list, m_count);
+		if (offset < 0) {
+			ret = offset;
+			goto out;
+		}
 		dirs->table = &dirs->dir_table[offset];
 
 		/* Copy directory header */
@@ -651,6 +657,10 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
 	}
 
 	offset = sqfs_dir_offset(table, m_list, m_count);
+	if (offset < 0) {
+		ret = offset;
+		goto out;
+	}
 	dirs->table = &dirs->dir_table[offset];
 
 	if (get_unaligned_le16(&dir->inode_type) == SQFS_DIR_TYPE)
-- 
2.53.0

