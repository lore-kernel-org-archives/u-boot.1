Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB6CCDE000
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 17:25:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03E478495B;
	Thu, 25 Jun 2026 19:24:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="BYlCkExK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 895CB8495B; Thu, 25 Jun 2026 19:24:56 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD71A8496E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 19:24:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4629d80fa08so2349638f8f.3
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 10:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1782408293; x=1783013093; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HAy5E/RT9dtJBEcYwCOZkE4Y70iWOvGi1RgfWX7kUvw=;
 b=BYlCkExK4dxJyZivV4e9/OZtHhUfJst3+fvJUNqXSMjwQjd0/jjWicHAIs+lbC0A0N
 l1rihxufnqOdmZKi05j+Qr36m3vPj1pOshQF+oqTybn5v4WD9nf1eQsh5mieEDGNFEpO
 +KKS4zsaotwJbi6teref4lh8lm8C1niPJBCFHnjGFnuFjI3XbR2HA0r37GvFVHFF/x5O
 m2xi7VxE7Vpdtr0F5KkTnmUv9tpXhs4QlptbJkgkjK76zgbTgVYFoLUIwPB82x0k2+Mr
 GOvesdNMI12YS4nASXRguVLTEkmPRHa9biqQ/k6RuaH7CBZqBy9fJrc8OD4+2WBmh1ee
 3s6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782408293; x=1783013093;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HAy5E/RT9dtJBEcYwCOZkE4Y70iWOvGi1RgfWX7kUvw=;
 b=Gh9hKrX2tBUMleFrVGbaRFvCR/mNoBIlmkY3pWC0OaWJq190K9u1Crqd3fWV3OtASp
 iYfUJPAfJ+JwEJVZbF/r9XXwZYLZ44myM62T7Gj4NlIfohyTAjLTrjdqIgrXmXtq7k+Z
 OY9xJ+3DiGyF+ohOyXKLIIEQXU47EsiYJz/goWfx8mdwcc7O1MWKDdblI6j+mEA2hMQo
 KUEN6LMtxA2zDUVh4G/VS2D0RCpwfzx3LNldvk++V2UkYk+Bps8aCtcYAuJsImMCjZpA
 dJgM+sP9c1nv+PkRZBO8Yh525qOiBzRo9GigbaJDx4SqzGTpLoGi1A+/kJEEeUkyR75I
 Nj3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8f4WCDVBaB7UaPaUg/vTkUPMlybEfqDk13yYMkKme36bhj5cRq1wpgr0bJryr5q107nz/CSZ0=@lists.denx.de
X-Gm-Message-State: AOJu0YzwsjK1j/T8E2e2gndo2q7zMfPGDqLAVsGCCBkVdNp0Sn04BiEF
 qS0L9N7kuswGA/iOGs4WvEtOGmKfx8+sLcL6As6KkKokQD89gtwd93odqKaRc1Nh2jo=
X-Gm-Gg: AfdE7cnBycxxsAT5roqmyfwhipYlyhOdNA3rp84iqDw+JBPj/u4t9He+sIja3Sb45aS
 vHg0q3G6jdoHav4CIbCOmlUVJj/IGN4EDtglERApU5lvlP95jgzsUaDpY5ZZamUpJqaFekywEL/
 nqFvh0zDzNhxO3y1/hRtJhsKZMhfCXBWbZ9+43RbFp9LVq+F1q/hP2sBPNiUSMUeWxHyoZvo5sR
 SYQacMQbIu0jsDE12akwogwYrv9hDW+WHYIlzGIzCy7cRiKQw+/deM8AhF1M60mlqn8GuVcTiAU
 RQt55i4A+bQd/o1QYp2RSIB7uUGCac+ckKocAAL7A7RWp31M/oiy9jMB4t5t6gP/IO85uxVD+sn
 1HD4bw2qWjznrDqA06d+7uz1s6Xa+cH9LxlOx4OidTSRI8GcGDEfy+JTbe+GiQ5imwLawhdqIw9
 rBoKuUIugcquo+RRGW541DCzVnz7oFNA==
X-Received: by 2002:a05:600c:3e0d:b0:492:4723:166b with SMTP id
 5b1f17b1804b1-49266873f80mr46441545e9.13.1782408293091; 
 Thu, 25 Jun 2026 10:24:53 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.92.128])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492697ba453sm2585755e9.0.2026.06.25.10.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 10:24:52 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 25 Jun 2026 21:24:22 +0400
Subject: [PATCH 2/2] fs: btrfs: use fs_ls_generic() and drop custom
 implementation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-btrfs-readdir-v1-2-dd781a2b3965@flipper.net>
References: <20260625-btrfs-readdir-v1-0-dd781a2b3965@flipper.net>
In-Reply-To: <20260625-btrfs-readdir-v1-0-dd781a2b3965@flipper.net>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, 
 u-boot@lists.denx.de
Cc: =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>, 
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Yao Zi <me@ziyao.cc>, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3452; i=alchark@flipper.net;
 h=from:subject:message-id; bh=HPc9KiFewGFxcjuXSS5JQGLOe88A69dyt5yVBlQUUUI=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTZpsRN3sA25dK7Yj6tBqa/MQVuLp/iXC/Xzj7HzDNVr
 9A1L3Fqx0QWBjEuBksxRZa535bYTjXim7XLw+MrzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 aKRjrGPEwMUpAFPtsYGRoaOze4pEk9j02HVqstk1nn1z+6Q/iT6X5diSNH3lr7PStxgZbrgZbHo
 0Ob5zdt+cOR0MYcYP25Z9ePiHX8BRtES8eeNhVgA=
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

Now that generic callbacks for opendir/readdir/closedir are implemented,
the custom btrfs_ls() implementation is no longer needed, along with the
btrfs_iter_dir() callback iterator.

Use fs_ls_generic() instead.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 fs/btrfs/dir-item.c | 59 +++--------------------------------------------------
 fs/fs.c             |  2 +-
 include/btrfs.h     |  1 -
 3 files changed, 4 insertions(+), 58 deletions(-)

diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index 8cf5be3790e7..e8aebc0c7366 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -114,65 +114,12 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
 	return btrfs_match_dir_item_name(root, path, name, name_len);
 }
 
-int btrfs_iter_dir(struct btrfs_root *root, u64 ino,
-		   btrfs_iter_dir_callback_t callback)
-{
-	struct btrfs_path path;
-	struct btrfs_key key;
-	int ret;
-
-	btrfs_init_path(&path);
-	key.objectid = ino;
-	key.type = BTRFS_DIR_INDEX_KEY;
-	key.offset = 0;
-
-	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
-	if (ret < 0)
-		return ret;
-	/* Should not happen */
-	if (ret == 0) {
-		ret = -EUCLEAN;
-		goto out;
-	}
-	if (path.slots[0] >= btrfs_header_nritems(path.nodes[0])) {
-		ret = btrfs_next_leaf(root, &path);
-		if (ret < 0)
-			goto out;
-		if (ret > 0) {
-			ret = 0;
-			goto out;
-		}
-	}
-	do {
-		struct btrfs_dir_item *di;
-
-		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
-		if (key.objectid != ino || key.type != BTRFS_DIR_INDEX_KEY)
-			break;
-		di = btrfs_item_ptr(path.nodes[0], path.slots[0],
-				    struct btrfs_dir_item);
-		if (verify_dir_item(root, path.nodes[0], di)) {
-			ret = -EUCLEAN;
-			goto out;
-		}
-		ret = callback(root, path.nodes[0], di);
-		if (ret < 0)
-			goto out;
-	} while (!(ret = btrfs_next_item(root, &path)));
-
-	if (ret > 0)
-		ret = 0;
-out:
-	btrfs_release_path(&path);
-	return ret;
-}
-
 /*
  * btrfs_next_dir_entry() - read one directory entry at or after a cursor
  *
- * Streaming counterpart to btrfs_iter_dir() for the fs-layer readdir, which
- * is re-entered once per entry: returns the first real entry whose
- * BTRFS_DIR_INDEX_KEY offset is >= *offset and advances *offset past it.
+ * Iterator for the fs-layer readdir, which is re-entered once per entry:
+ * returns the first real entry whose BTRFS_DIR_INDEX_KEY offset is
+ * >= *offset and advances *offset past it.
  *
  * @root, @ino:		directory to read
  * @offset:		in/out cursor; DIR_INDEX offset to resume from
diff --git a/fs/fs.c b/fs/fs.c
index 4694a88f776b..1ebda6f4ee2a 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -320,7 +320,7 @@ static struct fstype_info fstypes[] = {
 		.null_dev_desc_ok = false,
 		.probe = btrfs_probe,
 		.close = btrfs_close,
-		.ls = btrfs_ls,
+		.ls = fs_ls_generic,
 		.exists = btrfs_exists,
 		.size = btrfs_size,
 		.read = btrfs_read,
diff --git a/include/btrfs.h b/include/btrfs.h
index 6fff45a497ee..3878b7817ea6 100644
--- a/include/btrfs.h
+++ b/include/btrfs.h
@@ -15,7 +15,6 @@ struct fs_dirent;
 
 int btrfs_probe(struct blk_desc *fs_dev_desc,
 		struct disk_partition *fs_partition);
-int btrfs_ls(const char *);
 int btrfs_exists(const char *);
 int btrfs_size(const char *, loff_t *);
 int btrfs_read(const char *, void *, loff_t, loff_t, loff_t *);

-- 
2.53.0

