Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FB8C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 19:59:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ABDC84C9F;
	Mon, 13 Jul 2026 21:59:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MEYNh9Jr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEE3384C4F; Mon, 13 Jul 2026 16:26:06 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82DA684C06
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 16:26:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=allan.elkaim@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-47d6c634f45so1691253f8f.3
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 07:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783952764; x=1784557564; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IlqumcwDrhZZTiOeRHvCojP/MrmXgj08g6gsJ8D183Q=;
 b=MEYNh9JrfMW7deO906w5vQlGNUZ1BBD8RDZBPxJ0JW70sO0wG5Vf/YzAQyi4hMGaB1
 lYQ+rgeIuCW/ngftLifLuG8AgiQCa5msVfcTSw6T4XOPZYxa7zXqjAfD2H0OeK0FNTG+
 Br3klOt5coA4VgLphfeCIdf2hci3kEBeuS6/puOcKlKmX1JwPlVUCx0OxXYbn5M7PKzb
 0XQqnRc6o9S18dJZPp0L3zhlEWgThNEVAByq5t6aYIOgjoLp2D+s7UeIN/Gy7lFRJWuJ
 xBhevsJDpEa50YeIvs1/gptVQ05WMtQoQPpIMNFpFtIjDv2/tJEFSe5ifiXgE4lplbbK
 u1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783952764; x=1784557564;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IlqumcwDrhZZTiOeRHvCojP/MrmXgj08g6gsJ8D183Q=;
 b=LMjyL2LRHTBitVj0+AFrQJYBXD++R6oueW3i7ckQSnPktHOi+Nj8QbGLPrDwiyTs3y
 6F5q1BTPskWuGQYQqup2Ah6RshELLpmt+1480TibXDvCdd5mfc/xVgrj5NhSJsUCMxIB
 XDIWxy3V2LT3qWHZci6M8K2TTwiSUUFq88drZAAi9eM8SAIW0ULHmmOk7RcojmkWCNdo
 ahY/E+8K5Ot+onDRtBtSPh7Hg/eEcWFsuerkuLFf0vpnIQdkxstmgBcK8OFs8qKsBT+9
 GYDMR0coBx2z/pIJuiRFZxArySzwiJk1zHkrRgT8GI1SUwKiUe0U46bOfYAdFfOcxpO1
 oD9Q==
X-Gm-Message-State: AOJu0YygcABxRtuKUT8Wjt6jWx6jhh2W6UjwMwk+XUrVDhySy4eqNFHQ
 W05yb5I24Y5WSZNQJe43CPDWWyQKy69WwFCMTQWi78ihwltRlSyRepMqJoG0I6sW
X-Gm-Gg: AfdE7cm/utxHyoiJFKCYGIcifXMv3ZlRduvUyAn85/rAzgyVMdnCrDLktBGiczYaKCG
 dYCMI5nLCMBz6GY77HaOQf4aRZM61kAPh2GHncR6NdKIjLctByyubC2srQzeCF7fHNQ5yWRjGNb
 t9Qbi/ZHL7CS4ElbdaeHdkptH3paIALsNwOJPNHj2taEGCp9CF6sebt9Rr7nyYpD8tEGkLwkpv3
 a1qAdTQh0iQq6R58Z7VbFwkiJeOWgaoFVQUtejW8xOsb6LbvwgioCo3K/Ya1S5Xmnc+sYtNOxOI
 FLx9bj/lVA5+OwqdmfUtAMbAvaIfaf/aoahZ3NoISHk/RzHKqVfu7YBg0MN1vVWgxNoLOG2Yr/1
 NIHOiF40wIIzfanqPCnAxtd+d9eYHyaWeqNRByjE0C9HprPfoHyXo4ToNR8g1xUSEbq91cTf7O5
 8PEOXvYMdHUM9RxzujIJUyNGhses/471fn+fApgFomjUPP5HNuLkVAmCTsWkTygYBNEIIQKneXO
 S0TRZkpAwG+TdSHTLOSPxYXR8Znmdc2FNDxc2VaKgl/lVZPwnNErZ8NtlWB+4xxbxjgCEt9dH3m
 GSVwVVBHUrlsRwc=
X-Received: by 2002:a05:6000:2007:b0:47e:81a9:71bc with SMTP id
 ffacd0b85a97d-47f2dcd1a92mr10748498f8f.40.1783952763771; 
 Mon, 13 Jul 2026 07:26:03 -0700 (PDT)
Received: from thinkpad-t15g-g2 (82-64-82-74.subs.proxad.net. [82.64.82.74])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d83bdsm83691562f8f.13.2026.07.13.07.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 07:26:02 -0700 (PDT)
From: Allan ELKAIM <allan.elkaim@gmail.com>
To: u-boot@lists.denx.de
Cc: Joao Marcos Costa <jmcosta944@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tom Rini <trini@konsulko.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Allan ELKAIM <allan.elkaim@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH v3 1/3] fs/squashfs: fix heap exhaustion during symlink
 resolution
Date: Mon, 13 Jul 2026 16:22:43 +0200
Message-ID: <20260713142420.2618339-3-allan.elkaim@gmail.com>
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

Reviewed-by: Richard Genoud <richard.genoud@bootlin.com>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Allan ELKAIM <allan.elkaim@gmail.com>
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

