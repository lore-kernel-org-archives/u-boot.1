Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957E4C5CFC1
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 22:48:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C37660649;
	Sat, 15 Aug 2026 22:48:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pqCQWDa5cjfz; Sat, 15 Aug 2026 22:48:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4D6576062B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786834127;
	bh=EJ/5Ylt1TKf1UggP2XQQoMJWmCd4XeRdFFiKao4fmZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cq1ltTwXCdjrCRUgBaRsKce/N+FZVIw3MdBDLPt6l4JCchaX2uFHwQ6cwAKlX6Xat
	 P+yrRBaoLgdyTfNMQylfyxXxBkUBdnmR3xx2TXaljrKH7jauXYI8obXZcbxcmOOA5E
	 daBMqbhcBnODx6cU6DOrw//8oIAPtTNr1DoOKyeNR6Zpjsj6Ag3ZFAN0uLUWdLnelk
	 5JSd+WkiCzkSLzGDMtS0zHpHWoVgYEURRlVcUtODe3owD/xwg5oR4dCH5oFzEdCrMp
	 jmxi61avVD3zLyKTqjoGZXWHa1A4AuBVhIR7dxbKUU9KRSurX62UoRrVM3dJTAtrDl
	 ZgW5shz8ZgDOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D6576062B;
	Sat, 15 Aug 2026 22:48:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 670F02BB
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 22:03:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4D41060644
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 22:03:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id No2ld1z4-Vps for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 22:03:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=pranavkasthuri@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4EA2660633
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4EA2660633
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=O2yWrtiN
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4EA2660633
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 22:03:17 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4954a2e73a9so15809495e9.3
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 15:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786831395; x=1787436195;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EJ/5Ylt1TKf1UggP2XQQoMJWmCd4XeRdFFiKao4fmZs=;
 b=O2yWrtiNsqF4eU/dP6caRoo+qaLG44F5KwvnRXd2uryfGMB2Fs67/Us9B/cyhHn+DH
 khbMeqc0BCg+dX8DW1g/Y4pHo92x4WzzDS/sM6HjZNNpzSzRV0JxeSk1XzMsDepYjxpS
 OSFPaKgBf/yJYWmUQAAwkRolXuTUz8ykCADjREojKGg15yaqt3B5sSwrtQtLhEmH0qcM
 uxKfyyL+hElrcFjm1Hve6YxyIANj3BKHwj/L7VP45vxZ96gAKGp9CkP8p0MHUC43z54J
 2u5AkholBbP+fjAm4H37siZzhlxoAc767Pt3t75tREzjX2M7mKVyQDovf704lD+eYGZH
 i/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786831395; x=1787436195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EJ/5Ylt1TKf1UggP2XQQoMJWmCd4XeRdFFiKao4fmZs=;
 b=Y0XTkGXi48py5RFLCeI5WBaRDzJSeLSpV3P+se6KkBq+yOuFcfE7whW4gmuxAmWCJ+
 LkMw0OeaJhn0SBpmc1UKFKzD6nmZGc/JumxOV7SOBzILeydjnXS6UrILKg4NzZDCDJIq
 SIO97ZC2pC+2HI8ydx5xlUocQbE5+ooubTLFNkyl9HdapETb3bSnHq3oV4KvbCorS4Fm
 BwznMkY1VJFv3CGej3junIml9UtFcR5c+WhyMkLkSRC/tOxQRTM7vudl4EIdXkyZAyrm
 KlD7LGnZ7rxuL8ddmEKLazD11CddlV939pecbJDLrK7uj9q9yQZpQr8u1Iy4hECZGfjb
 rvfA==
X-Gm-Message-State: AOJu0YxwkapFq65KxRxnvyIjKEgczQuzZQO9ouVQj/gRNm3yzfv5kNC8
 01RR++yQwyo/Pz88Tjyc/EiFIXVyP89GEDqOqWuY0io/zOjEacVnJvEdnOF88LLlFaw=
X-Gm-Gg: AR+sD130iem/7bnD6WEjJp4MeoKYEBeVi4yd/61o15utQEObtrAnet/G+eY0JrOe7sY
 rLEOOWr0QnWG/ICDNxBH66YGHlnMOcQAaESHbzs4nwc5PNUQ2kdo+5o42N0wxHesgzSwHuJTgTQ
 un3rHpxHKjXx/McqdzNpUY+qWslqEp5jzYRw/F6EAJpst+eMuKHdLMWTJ2/V/KjIvcllaLaIEPa
 nbh0OaneeKrzp7Dion30G3x0hrI8FJnjmtzd5b7UJebN2yqNQNUw9xKWmqL70E+u8Qp/IYXMEGO
 KQNxEZyzpQ9gT9taIUrUyRclyu08kWB88FSnTPPlKLu/rJzh+NqzqyRrmsdmt32G8LG/A3eKHTr
 trmg/m6dWHO0sIjc0glvBeRBSU/mVsqu4hvGE/0nGYdEL42KJt/de2CMwc3vXnRVQSMlfS9v/T+
 aWUDVCjoRxEitzGwLtFm4rcfWsExlJ+CTPSrtf8l5OBrXHwytS+kyX/pY1r/bqF9KX1A/xNKWHJ
 /H+SzWQ6fTBWcI/an6vEJXeEeCCO0sR65LUNKQ7c9yqFyIwEE4t7wlvEqdb4f8p1bDVdUW9OtQd
 z2tK1zwOwnW4Qw+m7xrCMOTZ
X-Received: by 2002:a05:600c:1da8:b0:496:bbce:fc with SMTP id
 5b1f17b1804b1-4998798467amr232877465e9.12.1786831395142; 
 Sat, 15 Aug 2026 15:03:15 -0700 (PDT)
Received: from Mac (default-188-240-185-161.interdsl.co.uk. [188.240.185.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988b1d33asm179055255e9.10.2026.08.15.15.03.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 15 Aug 2026 15:03:14 -0700 (PDT)
From: Pranav Rajendran <pranavkasthuri@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: joaomarcos.costa@bootlin.com, richard.genoud@bootlin.com,
 thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
 trini@konsulko.com, Pranav Rajendran <pranavkasthuri@gmail.com>
Subject: [PATCH v1 1/2] fs/squashfs: bound fragment table accesses in
 sqfs_frag_lookup()
Date: Sat, 15 Aug 2026 23:01:14 +0100
Message-ID: <20260815220115.11335-2-pranavkasthuri@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260815220115.11335-1-pranavkasthuri@gmail.com>
References: <20260815220115.11335-1-pranavkasthuri@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 15 Aug 2026 22:48:45 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

sqfs_frag_lookup() validates its fragment index only against
sblk->fragments, which is read from the image superblock and is
therefore under the control of whoever supplies the image. Every
buffer access derived from that index is then made without checking
it against the size of the buffer actually read from the device:

 - the fragment index table entry at 'table_offset + block *
   sizeof(u64)' can be read past the end of 'table', as 'block' is
   inode_fragment_index / SQFS_MAX_ENTRIES and has no upper bound;

 - the metadata block header and payload are read from
   'metadata_buffer' at 'table_offset', but that buffer is sized from
   start_block, which comes from the unvalidated index table entry
   above. A start_block just below sblk->fragment_table_start yields a
   single-block buffer while SQFS_METADATA_SIZE(header) may be up to
   SQFS_METADATA_BLOCK_SIZE, so both the decompression source and the
   memcpy() source can run past the end of the buffer;

 - 'entries' is allocated with SQFS_METADATA_BLOCK_SIZE bytes but only
   partially filled, so entries[offset] can read uninitialised heap
   memory when the metadata block holds fewer than offset + 1 entries.

Compute the size of both buffers explicitly, rejecting the
multiplication overflow the way sqfs_read_directory_table() already
does, and check each access against it. Also track how much of
'entries' was populated and reject an index beyond that.

A crafted SquashFS image can trigger all three cases, either crashing
U-Boot or feeding adjacent heap contents into the fragment entry that
the following data read is based on.

Fixes: c51006130370 ("fs/squashfs: new filesystem")
Signed-off-by: Pranav Rajendran <pranavkasthuri@gmail.com>
---
 fs/squashfs/sqfs.c | 50 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index 55fbe1bcc1a..cd88923521e 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -109,6 +109,7 @@ static int sqfs_frag_lookup(u32 inode_fragment_index,
 	unsigned char *metadata_buffer, *metadata, *table;
 	struct squashfs_fragment_block_entry *entries;
 	struct squashfs_super_block *sblk = ctxt.sblk;
+	size_t table_size, metadata_size, valid_len;
 	unsigned long dest_len;
 	int block, offset, ret;
 	u16 header;
@@ -133,7 +134,12 @@ static int sqfs_frag_lookup(u32 inode_fragment_index,
 	start /= ctxt.cur_dev->blksz;
 
 	/* Allocate a proper sized buffer to store the fragment index table */
-	table = malloc_cache_aligned(n_blks * ctxt.cur_dev->blksz);
+	if (__builtin_mul_overflow(n_blks, ctxt.cur_dev->blksz, &table_size)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	table = malloc_cache_aligned(table_size);
 	if (!table) {
 		ret = -ENOMEM;
 		goto out;
@@ -147,6 +153,16 @@ static int sqfs_frag_lookup(u32 inode_fragment_index,
 	block = SQFS_FRAGMENT_INDEX(inode_fragment_index);
 	offset = SQFS_FRAGMENT_INDEX_OFFSET(inode_fragment_index);
 
+	/*
+	 * 'inode_fragment_index' is only checked against sblk->fragments, which
+	 * is itself read from the image, so the resulting index may point past
+	 * the fragment index table that was actually read from the device.
+	 */
+	if (table_offset + ((u64)block + 1) * sizeof(u64) > table_size) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	/*
 	 * Get the start offset of the metadata block that contains the right
 	 * fragment block entry
@@ -158,7 +174,13 @@ static int sqfs_frag_lookup(u32 inode_fragment_index,
 	n_blks = sqfs_calc_n_blks(cpu_to_le64(start_block),
 				  sblk->fragment_table_start, &table_offset);
 
-	metadata_buffer = malloc_cache_aligned(n_blks * ctxt.cur_dev->blksz);
+	if (__builtin_mul_overflow(n_blks, ctxt.cur_dev->blksz,
+				   &metadata_size)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	metadata_buffer = malloc_cache_aligned(metadata_size);
 	if (!metadata_buffer) {
 		ret = -ENOMEM;
 		goto out;
@@ -170,6 +192,11 @@ static int sqfs_frag_lookup(u32 inode_fragment_index,
 	}
 
 	/* Every metadata block starts with a 16-bit header */
+	if (table_offset + SQFS_HEADER_SIZE > metadata_size) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	header = get_unaligned_le16(metadata_buffer + table_offset);
 	metadata = metadata_buffer + table_offset + SQFS_HEADER_SIZE;
 
@@ -183,6 +210,16 @@ static int sqfs_frag_lookup(u32 inode_fragment_index,
 		goto out;
 	}
 
+	/*
+	 * The metadata block's payload is read straight out of
+	 * 'metadata_buffer', so it has to fit in what was read from the device.
+	 */
+	if (table_offset + SQFS_HEADER_SIZE + SQFS_METADATA_SIZE(header) >
+	    metadata_size) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	entries = malloc(SQFS_METADATA_BLOCK_SIZE);
 	if (!entries) {
 		ret = -ENOMEM;
@@ -198,8 +235,17 @@ static int sqfs_frag_lookup(u32 inode_fragment_index,
 			ret = -EINVAL;
 			goto out;
 		}
+
+		valid_len = dest_len;
 	} else {
 		memcpy(entries, metadata, SQFS_METADATA_SIZE(header));
+		valid_len = SQFS_METADATA_SIZE(header);
+	}
+
+	/* Only the part of 'entries' that was actually filled in is usable */
+	if (((u64)offset + 1) * sizeof(*entries) > valid_len) {
+		ret = -EINVAL;
+		goto out;
 	}
 
 	*e = entries[offset];
-- 
2.50.1 (Apple Git-155)

