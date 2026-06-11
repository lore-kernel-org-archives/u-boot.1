Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6458ACD98CE
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 12:43:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D88F84664;
	Thu, 11 Jun 2026 14:43:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GFW0MTd5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE059846D3; Thu, 11 Jun 2026 11:45:06 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1842838D7
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 11:45:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=allan.elkaim@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-490e1904089so9994225e9.0
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 02:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781171103; x=1781775903; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FABnyk9DIAj4Ms9k9ri2reXHEegZKeZAHBQGGKjMnTQ=;
 b=GFW0MTd5F1XbY0oCToNmQep0mjLABpeOZVz3Mq3hvsYJtxFAXVYTnyexWoLP2axZHD
 nmKkWk4wOX+4/C8HENCAvIEsH3SAiwtHBx5DfdopQf4cS3HIe6htnvz+HRwLSmERkE5L
 c/wKvcLOdVwdA6ERZn/nTM2k033MulTxM9pxLtta0GWQ1tj/u3rol7ifyFAuRmOe/96z
 mPW1wo3d4WCvSyAl+aVB4BKeta1nPa+Sp2HZs/VFZvIzU3NrK8dvDEEdo5Sa2hxyNOEK
 4LvSRR5cBgzNwyD7R+DqXVcU8rfpExpT2aLoH0hgok9D4G/orv9uCcDTpV8tCCRsz9Ra
 RgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781171103; x=1781775903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FABnyk9DIAj4Ms9k9ri2reXHEegZKeZAHBQGGKjMnTQ=;
 b=P36p1fFi5/FpFxVEA0Z4WhhUo9cEPGx2wAEkcDzMKx0tUzFpA7+gUmJhhiydSJctKe
 Kno9TGtI3TiB2Zvue04IWnyGjEsqZLD2CBo5x456lj5mTbdrWvrFSiHN20Ro8vkaSJjA
 OzDyj6s3NZ1Iq+mmrGQ7Px11xzRVnXb6PmiIYic4FzUy592o3NeD2bKw0eSUFd1tUQpF
 cd4vp7FoWr3wVHUuGEBq/fH5Vzu+yEzXeQpodGW/bZJ7C43zNBnNfhGwztRoDC4OQHsV
 1hCiJMd0d7EC2JzRhDH/LRd5FaFTMTNevjOTT0CRqI2YYjg9rNpobzuWoWaK536Q5lUy
 YkCA==
X-Gm-Message-State: AOJu0YzcmUoFKo2n/oZl89FFbEtHKSjFUC8UN+5IQ8YHMkbi8gMcG9Dd
 Ki9eCfSILuB3K0c1+V7JL4IWonYR43Uy5dVzNhXfONCOAndy5OPGT63xYy6BiivFrjg=
X-Gm-Gg: Acq92OGSdzKybbSHFuPeq/8KCb/9Zgy1U4MeCdExVRMNXrTOK/HitiGeaT0btao+eIj
 x02d9IN4oovYSGweDzK4F3yKpce0DItyXzhnaLVDBrHQ0SrvbdKxhQgIdsfiiil63zhhL3V53Vs
 p0ilq+D6gJUnIRIGyOr7OqA1AXwxrgE+A2WV8n/n+roneuGhEnqYGXMPmk+NbOHkeWj3+Jx0YX9
 kFRFuQAc+m1dBJAEkAIfns9FwmMSb2CAqI4O1f9DJft+8f6Agvb1IrXHgMV0366i2E7mmedvqAm
 1xoZpcfEHGKHwAY5+O7GJvtLRo5j2B2qBY/LMwKOwTmMzz9A02wA5e3qzh59OEbU++Xw4UBdosV
 NokJeZzYkoI4w+XI4j58+8WjPAk4g/Ndf7LfaMuthuzgah1dv0YnJH9H9PZVzso4pjRpktY79EJ
 dm+NUru1HSzIG+eom++Lvg8tnJW7zY6OZ30gnPJPYtOgjtiCMvP4cASXj9uGVccWD3lLRTXr2Hv
 XJrFEdCuvhdNxUSbF1+KT3xKxbd6yJ/SMXJjLSKxNoxLP1xcOd7A33tvCUBFJv0RyHztx9Jpapq
 x0A0+aOBimcP1itsNR6CT1vsT0EvOoV6+dBRhLRHJt8ASiTPBdM=
X-Received: by 2002:a05:600c:3b23:b0:490:4b89:535d with SMTP id
 5b1f17b1804b1-490e55a5e74mr26438635e9.1.1781171102815; 
 Thu, 11 Jun 2026 02:45:02 -0700 (PDT)
Received: from thinkpad-t15g-g2 (lfbn-idf2-1-525-203.w86-246.abo.wanadoo.fr.
 [86.246.224.203]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2ca21f4sm51499075e9.7.2026.06.11.02.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 02:45:02 -0700 (PDT)
From: Allan ELKAIM <allan.elkaim@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Joao Marcos Costa <jmcosta944@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Allan ELKAIM <allan.elkaim@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH v2 1/3] fs/squashfs: fix heap exhaustion during symlink
 resolution
Date: Thu, 11 Jun 2026 11:43:45 +0200
Message-ID: <20260611094353.722555-2-allan.elkaim@gmail.com>
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

When sqfs_read_nest() encounters a symlink it resolves it by calling
itself recursively. In the unfixed code this looks like:

  // dirsp is open: inode_table + dir_table still on heap
  resolved = sqfs_resolve_symlink(symlink, filename);
  ret = sqfs_read_nest(resolved, ...); // recursive: allocates a new
                                       // inode_table + dir_table pair
  free(resolved);
  goto out;
  // out: sqfs_closedir(dirsp) <- parent tables freed HERE, too late

There is no permanent leak: the parent's tables are freed at the
out: label once the recursive call returns. However, for the entire
duration of the recursive call both the parent's inode_table +
dir_table and the child's inode_table + dir_table are live on the
heap simultaneously. On large squashfs images these tables can be
significant in size, and this temporary double allocation may exhaust
the heap budget.

A superficial workaround would be to increase CONFIG_SYS_MALLOC_LEN,
but that wastes memory on all boards and does not address the
structural problem. The correct fix is to change the freeing order:
release the parent directory's resources before recursing. This way
only one set of inode and directory tables is live at any given time,
halving the peak heap usage during symlink resolution.

When heap exhaustion does occur and malloc returns NULL for dir_table
or pos_list inside sqfs_read_directory_table(), the failure is
currently silent and cascading:

  - metablks_count is not reset to -1 before the goto out, so the
    function returns a positive block count alongside a NULL pointer.
  - sqfs_opendir_nest() does not detect the failure (it only checks
    metablks_count < 1) and calls sqfs_search_dir() with m_list=NULL.
  - sqfs_dir_offset() iterates over m_list[0..n], reading from
    addresses 0x0, 0x4, 0x8, ... None of those values match the
    inode's start_block, so the function returns -EINVAL.
  - The error propagates up as a load failure with no indication
    that the root cause was heap exhaustion:

      Error: invalid inode reference to directory table.
      Failed to load '<symlink path>'

Two fixes:
1. In sqfs_read_directory_table(), set metablks_count = -1 whenever
   malloc fails after sqfs_count_metablks() returns a positive value,
   so that the caller's "metablks_count < 1" check correctly detects
   the failure and avoids calling sqfs_search_dir() with a NULL
   pos_list.
2. In sqfs_read_nest() and sqfs_size_nest(), call sqfs_closedir() on
   the parent dirsp before the recursive call so that the parent's
   inode and directory tables are freed before the child allocates
   its own. Only one set of tables is then live at any given time,
   halving peak heap usage during symlink resolution.

Link: https://lists.denx.de/pipermail/u-boot/2026-May/618533.html

Signed-off-by: Allan ELKAIM <allan.elkaim@gmail.com>
Reviewed-by: Richard Genoud <richard.genoud@bootlin.com>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
---

(no changes since v1)

 fs/squashfs/sqfs.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index 9cb8b4af..07e2bd82 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -853,12 +853,16 @@ static int sqfs_read_directory_table(unsigned char **dir_table, u32 **pos_list)
 		goto out;
 
 	*dir_table = malloc(metablks_count * SQFS_METADATA_BLOCK_SIZE);
-	if (!*dir_table)
+	if (!*dir_table) {
+		metablks_count = -1;
 		goto out;
+	}
 
 	*pos_list = malloc(metablks_count * sizeof(u32));
-	if (!*pos_list)
+	if (!*pos_list) {
+		metablks_count = -1;
 		goto out;
+	}
 
 	ret = sqfs_get_metablk_pos(*pos_list, dtb, table_offset,
 				   metablks_count);
@@ -1473,6 +1477,15 @@ static int sqfs_read_nest(const char *filename, void *buf, loff_t offset,
 
 		symlink = (struct squashfs_symlink_inode *)ipos;
 		resolved = sqfs_resolve_symlink(symlink, filename);
+		/*
+		 * Free the parent directory resources before recursing so that
+		 * the recursive call can allocate its own inode and directory
+		 * tables without exhausting the heap.
+		 */
+		free(dirs->entry);
+		dirs->entry = NULL;
+		sqfs_closedir(dirsp);
+		dirsp = NULL;
 		ret = sqfs_read_nest(resolved, buf, offset, len, actread);
 		free(resolved);
 		goto out;
@@ -1731,6 +1744,11 @@ static int sqfs_size_nest(const char *filename, loff_t *size)
 
 		symlink = (struct squashfs_symlink_inode *)ipos;
 		resolved = sqfs_resolve_symlink(symlink, filename);
+		/*
+		 * Free the parent directory resources before recursing.
+		 */
+		sqfs_closedir(dirsp);
+		dirsp = NULL;
 		ret = sqfs_size(resolved, size);
 		free(resolved);
 		break;
-- 
2.53.0

