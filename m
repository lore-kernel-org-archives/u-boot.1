Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E553CD4F39
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 23:40:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B80A84687;
	Fri, 15 May 2026 01:39:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J7R8Mx5U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4259D846A4; Thu, 14 May 2026 20:21:00 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1141684687
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 20:20:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=allan.elkaim@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so75434685e9.0
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 11:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778782857; x=1779387657; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+0kxSL0bSp1ZdArz4mOTepGjPK4tLbGYwxqTVr9cm+A=;
 b=J7R8Mx5UlPC+35Wj0RnIo3JjejR3oOHRwBKY1qPeDL3G5RnGKybeyhhviohcciaGjJ
 UjwZuBn/sx5aIBBxxOzbnl7eqIj3l9uWGuclrZsHl9QHM1m/Gbmz+gYz8HiJeIgTHsko
 m6Z8b9YKDWYzEG6Le1VTMhoGwdyCPct++jtrSYJrc7I2Kb+g0xhpom72ma+kqKlXKL45
 8HTz1NwwljjjIh3bayr70P6nUjRRVKsQX/Lnvht5iUNA42FMMnCRL1hfYFG6K2tEB5X0
 2mxH75HJO5kFF6LEyJ98M/oRM2WTwD8bUo7MlonnxL14nb0wg0K+p+UEi9OphWVL/aZ+
 U1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778782857; x=1779387657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+0kxSL0bSp1ZdArz4mOTepGjPK4tLbGYwxqTVr9cm+A=;
 b=sF9ArR/wIi3jIXQGnwDzSp887Y3WznPvF/6NkZou+vnEXzTOLNrJUZoDu73bUuOScl
 Cu0ZBjKlucuY+nB75GxNu7R7vGBem6h+T71schI3PsqmUaNno1J3ml8MhXNoTs0RGPIg
 QADKXdVcmUhKcryIB9I9LQFvkf/lkWs42IAbezKRuTYsy9NH5YF/2xCeVRwpFAhHYhN9
 WTOlRcMqRx8W2xkXFdCvdWYxES+sEcdr7vonl+vFb53cKA8GWnZwssZlkcYKaJn+On/b
 pfcEPer+mLBWE2ryIBIfYXbMRouCIfsNRa9bvJ/F8S4PZJ58bSkzO3d2WMxnL0s39PIj
 rYYA==
X-Gm-Message-State: AOJu0Ywwv5nrD1vcYyl3RYucnPfcqFjG3FQ2wOtSTKhVI21/QHX2Tkt3
 wfthRQlqiCVb6GU/fGWMPaARJXvuBxRFyOrFmOru3KK7J2ribQCiFLh3xO1HPufxUzI=
X-Gm-Gg: Acq92OFJNfxpQdBfDNohTbSfR0o+ICmj3PtbvG/WdTeFvdH8pq8/x8ZDkn6h1LVE83L
 EqYOO+yTstOSV0ZHDX6adWuqb3TfGh6BgeYcEjQNm75vfqHhf5dzagrGMKWlrS2KXpacDPFJBWD
 iHGkNzA6sf0X6UWhQ1UGvMXemGqHVY0L42kIEiTK2lW6yis84MjCXl5sUCeKUpuwZ4Bpot9lFNc
 hjVMMz3Q8Nu4wQ0GzdGrxojVEocPHXCNpUEE+/sLoidb93nwAZ0CyCjSNIGI/PXBldIeSXgwUvS
 g123Tr7Fmi1v05jGLXrrleX07f6nf9B4LgairOOA6RXUD3g6DTlJq+5rgmBMQOx9YlO6UrkwreS
 I0hPX4lKdTKHMYcT9tOlRD739QhWppF95fvmjIRRlJodiRE2by0qMmbOWym9S6VFVFezPYg5pgg
 WM79D/XFzVd1TllfZTP3R1ORvjSK1mzAIc5UUuPj2uwtMtmr/cYBfgZsJKp+e0yh7vDjivBg4S/
 Zs53yKdbM6rI1i3mIXq/dc8tkGW09j4TQagyYnAHwb30cYoJwQu2fIDygy91BKnyQ/29ukG2MfZ
 GGKH
X-Received: by 2002:a05:600c:4fcb:b0:488:a797:f0ac with SMTP id
 5b1f17b1804b1-48fe6613ab3mr6682715e9.28.1778782857016; 
 Thu, 14 May 2026 11:20:57 -0700 (PDT)
Received: from thinkpad-t15g-g2 ([2a01:e0a:905:5c10:111d:8a59:d7b9:c8a9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe53ab773sm7973575e9.3.2026.05.14.11.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 11:20:56 -0700 (PDT)
From: Allan ELKAIM <allan.elkaim@gmail.com>
To: u-boot@lists.denx.de
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tom Rini <trini@konsulko.com>, Allan ELKAIM <allan.elkaim@gmail.com>
Subject: [PATCH v1 1/2] fs/squashfs: fix heap exhaustion during symlink
 resolution
Date: Thu, 14 May 2026 20:18:52 +0200
Message-ID: <20260514181854.399679-5-allan.elkaim@gmail.com>
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
---

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

