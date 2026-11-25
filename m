Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50792606A323
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ABEFvule;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MCXSFC3p
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A6C580D6F;
	Wed, 25 Nov 2026 12:43:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EjWk3n0Ar7jD; Wed, 25 Nov 2026 12:43:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 788BC80DA5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795610599;
	b=PFIPs4maauQYWdJYhrkK0iWeoXVNX+p+zFJHpynQdxhFTwY5lCed0L/xj42c8zM4KFSF
	 JXPs3riPbRWPenFlvuKPOptoxfXmD4qpTJm6PRbBzhNic+2MjkudMxafJYLqQ+yMeOdhH
	 +5w/RPwcbI+9ySXqvpdMsyKk7fYKU/39Vz7TRAmthsaEh/Z57SVNF6VQztwsK6TNhQ1HR
	 0SrNgWrUsc4zTM+9jBDJbKcupk8M4b5iUzGEOB2TLvgFJegoIeLB3h6ulOZXVBIR5N7CA
	 ElRyTogkOkW122W3i/twfE+lGQOAaU8trzsJb4dqnvbZUlkaaZ06YeldZQnDx/proHQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795610599;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=G5q76NGFqkARnH1bsQJNcnzLpxBVz0guREiagYsrkp8=;
	b=HgTVFLhi62EldOR78WEL/X4CXD8HB9eQCN9FGc8Zwu7BWNawX2bCdN1LsRSMvZGCYaP6
	 0NJmOCvMV8zI/G05V0QrLYH9l9F+x4Uz2P2v6pYv31FKEYuCCEi7/yozh5CdfzmfkJUYk
	 +u5EyqTXaGwtrm89Gu7cTDWQap0fmvs/juGl46g5SS5lihORZRVmz0zBF1nfvQmeLiVIA
	 1pCZSKswBO5Odq9FxMZQY3e6RwX7c4b0+lWZrtfUhWFuRQAX66jW9//MNzXI8zPPoHoje
	 FAVG6/N10ws5s13oS1qjhH8Oc00vcpRoy1E/uA7BcI+Za8FGqIC3xU/hunlYtKTYCPw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MCXSFC3p;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795610599;
	bh=G5q76NGFqkARnH1bsQJNcnzLpxBVz0guREiagYsrkp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ABEFvulee3sjBALEMayqAaKR3JOQtFcq4MU/J8ADxIYnpna7hBiGLOj/Q0SUKnPhg
	 VMm05GAcM8hnLqM2+hKLvIoKn/D38rPST94kJXgnfEF7f7XkbiQHOqsTOJGbWkPnuc
	 IYs3LpUymUQ92/+Hd0llLV5axIKeNob5kFge8ho/BLVQTtEcjLUnBXc6o/jhhz/YCW
	 S0fWfsdpQr2DLs7LRHDDXwGehsoRPtw+LK4VycnpQv3PZVGgIYEOc+/TNZ9XIsbnJl
	 TKB0xC4j2VgrGe33z/Fjm+b0drpYyjsyvTMrQbf4C67AcuF8+KPEAFgI07lerDhdf+
	 Xxmbyb/Ud1ofQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 788BC80DA5;
	Wed, 25 Nov 2026 12:43:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 77F1632D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:43:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6419180893
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:43:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pqkP5Kz2llqo for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 12:43:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 38D7F80795
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=MCXSFC3p
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 38D7F80795
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:43:09 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so73634145e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 04:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795610588; x=1796215388;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=G5q76NGFqkARnH1bsQJNcnzLpxBVz0guREiagYsrkp8=;
 b=MCXSFC3p9ggFxlBSwWPLJTPX5vT33wWIZOxy+X5D9U8qSa+P+58kM0Mo2e8C546DQM
 1m6mH68CYtgJjc97kJ1WX3/fWEswgp+q6Y9GBlB+YtJDTe0NopIsouWbQs4YqS6/TMSL
 dOdf43wKgL10kbEU0i663RggBUUvSGSdzBBDcG9NjW/MPiDoRwfNBVVXIWqGTY7amQNV
 luh095Ao//NBH6hgcxJR0ek2+nnv4swoKkFqy33TChlIySa/HU2RFwvFyyqmJ1edin7l
 d1RNYV8G4ZpRFE9X2ejnLH3teMIjnETO/yWIZrfjNe9h96F9pu+Fv0ab+m+ar+YsMAHZ
 +M/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795610588; x=1796215388;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G5q76NGFqkARnH1bsQJNcnzLpxBVz0guREiagYsrkp8=;
 b=pR4LdMRp8dkWFi2sArPiV66O4eOYq+ib8nIACGMs6RiL6asAR3cdiDH9OLCQi230iS
 9c20dRTYNKU+BWqv9kOyvdDp2URke8l1eTgo+8z/V9K63QA7HafWEz51x9iCaZQK6prT
 5c5tFS56EBrUAJAlUzBmBaK40YfrRi6MumIs6mlW86mLx0Ulk2jfKjcVP8SoXs/LXaFz
 eiJb6+4SqUJBzzWsy9//FUchtw2eaktE8DnaCg90tMrhzGUHi6gRif0h4/7Z7uJkywdh
 vNjk0vL22ykKKwjYOI2E4bUDJtjpqg9pF4p+Jt6wxtFoSRT/AZ2xiuTb86YOFu6x4AGJ
 LwCA==
X-Gm-Message-State: APuU4Z/bNRuo+eeXbtkpFcpYTm38peW6Ek511XZuv9hZikK+ECk7foHT
 MuLJWqD1ony9uhcj/jrzWBSvOEIeKuGIzA19T7fISzNn2VEgoRYcappV8iuJPCLD
X-Gm-Gg: AZFdTZeGF618117aqTLMAO2F9LPAC923NLZm0LuKmBf7D3vZEgjTUMp6jO9r/mJmTC6
 5LGLW85QtWY7p1n5bOocABhoZA5vgSkWrJJAQ1FfLiGgaA5J52jHgOOdl/Q3TY/p+hpzuzoaCV5
 xt/Q9A/M9A1EvPOiO/D/rv6UxCHKtc/kndCAY90E1bUGU5bnVELjM+BeHz9WquhYeRr5GSVDCw7
 SALy/JENB40JjwOz+4VQE0R+uSZdjjIns1r0VYaKe7cBlmveY4Rurk14iq36aOvZpJkEdyewi46
 ef0cBI0Mk6X5qJ2F18zxjOFIbbfT9sUlfClurntd68a+N65vzZvzOq6J/Q0r+Bfb63o1VfxuYju
 bMPMrLrlrUpyljd7OoDE57eBaSbVm7LkOoaDQXXei0AZp+3Ss0UC6qq/9xu7hAbfsA5Tt5Q5Irs
 USaFqdCZHZN/qSN0yBPgiyU7ksVchL35rdwt/zcE+0nYX6ov/6/cKoV6syJ5TnmTpeF5EPaeevl
 CtQPkcuMFdI5VdwXUwgl3+Bd1hevTQeiiYF3Xy6HWp5rMb8ououa1shNHCWX72WYkHbrTpNqcFm
 fqqFFoYqbJTfUyfHP5jFVlThqVTbMSzJcodgtJMZGW+9B3oAXV1fGRl1FeIzcWwaDJSZnL26Q5z
 zwAL/PtpvyU2+0XNwYhqpe1AxeUDtwhy7tv0V7ytYQYWKuAHsZaq2xsJUuIcIY4AbQ5O/unngzm
 dFbAAT7myIuIsOu7oLN7a72+4zxbqfdU5Lots1GDu/dSTmeK+ZSHxDZw==
X-Received: by 2002:a05:600c:468b:b0:4bb:5fd1:92aa with SMTP id
 5b1f17b1804b1-4bb888160c2mr373771605e9.15.1795610587826; 
 Wed, 25 Nov 2026 04:43:07 -0800 (PST)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-7575-e1e3-dbaf-96fb.ipv6.o2.cz.
 [2a00:1028:8388:a84e:7575:e1e3:dbaf:96fb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88442995sm536486045e9.2.2026.11.25.04.43.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Nov 2026 04:43:07 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Bradley Morgan <bradley.morgan@linux.dev>, linux-btrfs@vger.kernel.org,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH 5/6] fs: btrfs: Remove the unused dev.c
Date: Wed, 25 Nov 2026 13:42:58 +0100
Message-ID: <20261125124259.95636-6-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261125124259.95636-1-pepe.schlehofer@gmail.com>
References: <20261125124259.95636-1-pepe.schlehofer@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Nothing uses btrfs_devread(), btrfs_blk_desc or btrfs_part_info, which
are all that fs/btrfs/dev.c defines. On 32-bit PowerPC, GCC turns the
u64 '%' in btrfs_devread() into a call to __umoddi3(), which U-Boot's
private libgcc does not provide.

Remove the file.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Marek Behún <kabel@kernel.org>
Cc: Qu Wenruo <wqu@suse.com>
Cc: Tom Rini <trini@konsulko.com>
---
 fs/btrfs/Makefile |  2 +-
 fs/btrfs/dev.c    | 25 -------------------------
 2 files changed, 1 insertion(+), 26 deletions(-)
 delete mode 100644 fs/btrfs/dev.c

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 31b426d572a..79d96c6e0ca 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -2,6 +2,6 @@
 #
 # 2017 Marek Behún, CZ.NIC, kabel@kernel.org
 
-obj-y := btrfs.o compression.o ctree.o dev.o dir-item.o \
+obj-y := btrfs.o compression.o ctree.o dir-item.o \
 	extent-io.o inode.o subvolume.o crypto/hash.o disk-io.o \
 	common/rbtree-utils.o extent-cache.o volumes.o root-tree.o
diff --git a/fs/btrfs/dev.c b/fs/btrfs/dev.c
deleted file mode 100644
index e27a032c9f6..00000000000
--- a/fs/btrfs/dev.c
+++ /dev/null
@@ -1,25 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * BTRFS filesystem implementation for U-Boot
- *
- * 2017 Marek Behún, CZ.NIC, kabel@kernel.org
- */
-
-#include <blk.h>
-#include <compiler.h>
-#include <fs_internal.h>
-
-struct blk_desc *btrfs_blk_desc;
-struct disk_partition *btrfs_part_info;
-
-int btrfs_devread(u64 address, int byte_len, void *buf)
-{
-	lbaint_t sector;
-	int byte_offset;
-
-	sector = address >> btrfs_blk_desc->log2blksz;
-	byte_offset = address % btrfs_blk_desc->blksz;
-
-	return fs_devread(btrfs_blk_desc, btrfs_part_info, sector, byte_offset,
-			  byte_len, buf);
-}
-- 
2.54.0 (Apple Git-157)

