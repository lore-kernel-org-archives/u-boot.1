Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898AD606A320
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 15:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ja2TNqeW;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UA+F5NN/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC753405F8;
	Sun,  8 Nov 2026 15:12:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P8GesXLHAykn; Sun,  8 Nov 2026 15:12:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BF9D3405DD
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794150720;
	b=JDggxT2tBh+gMjhduxREKRzr1LSivShK5rFf0i3Ej3jlCPBk2OU1C7l64bllIz8cdsTz
	 YHZk7+l0p9vXuqwbNHer/IezZ3ISdRk2qaqV87SLD842nInE6EFITt9MQfgGzzlNUxppG
	 NrjatLuthBE2jIiZ6LqjPIZ/Vcx8UftPGhqwugkqR4zC+i+IidlI+WmuOxGyh2yvNFIs/
	 jQDVZftYhcAexTC6DiGZqH6VuAHTR5JKE6Y0QzBRvTcCW8PyjaYqPPlA2Oe6N/+cnmZdw
	 Jl3Y/LBjWLsS8NBdg84AE69SO6gbjtsXFWsz1Z34PnjMjMZigTxfSH9l1wRVjF6DGog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794150720;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=laDKQ4ysSsi8zPoQZ4i+zKmQpw9FVfRQLmLjyFoKhCo=;
	b=PxKs23o3Zh5do+EHL0Eya3V9f3ARKv1hDm+zax0Pr5chSoYwyQ3W4j6r5nzMucbAvbvX
	 JJpdKdohsL5btDoWIyivBFyBQ3MO+NLezgPJan4oki2+14SgWm2zBuoCAJLJASV3MmI6T
	 CHbt6VHJvcDQMLWHXKdkoKOdGmCxHNT7PuqAM1tAE5SK1UKV0rVbunDiVWltq8GYK3F5z
	 KcPjIsUZ57Id3mBt/PNLyppHYhYJ4scpmJFsqVqCi/CfAL7IwEldxxhjiAenKHiI4XNeM
	 3Cz6ViOLsDw+mb5Sshh8PbSQ3IEXt9spvJVPeusC9HWGlyfD1qegxNCUC54XY6Hkf7A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794150720;
	bh=laDKQ4ysSsi8zPoQZ4i+zKmQpw9FVfRQLmLjyFoKhCo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ja2TNqeWfQAcVsUnhMcGiTsYY3DUXeJUWpL0HBpo2/vEyf+GCTUOHivBImOxmC/aT
	 +uTNV11FW2fOQaNqRyPqQphlZ+5KSmcEYsLtFxfKcd88h7DXZkFynzSjcXZrnTE/rX
	 Wt/5ZPQOW6tYHZlqfwNyqbDSG40CBtHasPl8Gl2JzMjJmawb6wqcWYo26C4kkoEp9B
	 dANc9Ci17Yr6KsCqpOBISzZQ7V6fMaTNGfZEFtvAxjI9PVoxFSzJFkyKJ3Kqb6pq0w
	 tS0EDj1ZOzFdNmyyDuC/fMCaQgRMp43Dn6dUmOvUOcE6x2b1UapcHhcbzgqPgmZaCi
	 7nxyjFpN3vDYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF9D3405DD;
	Sun,  8 Nov 2026 15:12:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 816D7111
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 15:11:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 72991400A8
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 15:11:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UdrxmwX3K0dO for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 15:11:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1B9D74005E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=UA+F5NN/
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1B9D74005E
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 15:11:54 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4919a880834so61851f8f.0
 for <u-boot@lists.u-boot-project.org>; Sun, 08 Nov 2026 07:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794150712; x=1794755512;
 darn=lists.u-boot-project.org; 
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=laDKQ4ysSsi8zPoQZ4i+zKmQpw9FVfRQLmLjyFoKhCo=;
 b=UA+F5NN/qeDGbodx4LGgbnCtH1L62iRFKs2K4bGOOB1ltl6aejGjCqitS8g7SI1bfA
 GREQ7Xc7bPlsN3h+znHNxOEjOy3IVgsF1VPxxQju8iC/wPAvDCfl7+reGshESitGbj/Z
 Za06xPPkMpxWPIZWgskrHqxGGER0QW1iq7s/E8twIlVsSVwvmE5I4MNwRG6R127umDyk
 U4SNvkYzCBhrowtOFc19RZ2lWAbKfgIa/mcGXF/Rk5V2eb0PsYxuMc4i8mg5PRO3hZiC
 Ng5LMLys1ATsCHspUnSsn/JSGsvKicWqvd529xMPfjTJvY3ZTbfxU59NVbzra0w3GPRi
 YLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794150712; x=1794755512;
 h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=laDKQ4ysSsi8zPoQZ4i+zKmQpw9FVfRQLmLjyFoKhCo=;
 b=LOS5ecgPWLcovtgmODiFwStWVCT9Aq+ks3aDCFQ7fVs5mZG8+QqUA/f8a1q1w5ZbM+
 kFdG39qIRWsQUxk0quFiVXn6SilFAAHQSNxQdMqzjZcLEC16hesP/W9c4nVZCfDK1q9l
 mK238mOZRRexEaTfxItruw2KVGNjoeVrVDsULv3QtVJvEZ9sqs6INAfvmk5kkFvc3MXF
 wBezQjchPejwzyVl2lfuKiNKxnTG/Uikyt9em3nP4rFF7iDmQsk/ovpbfJsuWf6Ybi69
 uNEwB95mHbXkYYpHpKi7AuD0zAovITCkjn3UqtmjPxCBr2x4v3SCUKJ2X0H0fEyZ9h69
 PrQg==
X-Gm-Message-State: APuU4Z8cY8DfgRXDjKD2dghQP/Db6kBSf7frVXDMXh6T8xOJHgiwF1jt
 EsZqn0QRNnJoiB5Bzj1ycBS37VAhDJurM6SDB9LfZvJrKSuAxRZVayU2
X-Gm-Gg: AYBFou3lYreaEfuLRuUWuwfg88NLQbRKwZErPW9VgNp5/MjNRKqx2RrgyeAYTJKlgO6
 jsoudJTEebSxgj3FR5mEcK8xiVgmS9D7hqbGCo6m5D93bZG6UOBiNmkWX7fmZxA3X8CRRzy2bKW
 n7PcRBx1eGtSdVruBXSH5mSdt1knUGSP95VVlDhmI41iJEcrgXQN5DtOpxL8ea0Cu78iB6w8P5e
 fyfvpV2CEfY+NA6kDZ4bnOxkR0xn4LTLTglM7qS/bqelBloI2HpGxWEqH0oQRVlt6lFdJNmeLhu
 0qbRUsExTVcMrCHs1E2YPyTipeMyPZdcWyjhvp2THvzBqwx67dxqcW7W9blIhTlb+e3L8j70YNJ
 Kd4+H/J6PiExYkx0Lv8Lg56AOg+Q+c/zN79uJjZesaqTHrjvM2BWakwyERWx03DN13XA1HdKjsL
 0c111vKisO9+E4m9poCexiFSzDpazBc4/VEm6envIvWUjjSEJI0M2pGHPREJcoKl1e5xIsjej+0
 QJezEXPKquc8CoVWvJxIPtq3wEdkf/r4mbqznRC+4UH4oC6F7CT4WSDdk2VbBlQQTGVr2QH+Bs1
 jhqKsUAicplReZbacINLtNe04tv2gcA=
X-Received: by 2002:a5d:5f51:0:b0:48f:bcdf:6f68 with SMTP id
 ffacd0b85a97d-49589867ad3mr3356490f8f.37.1794150712308; 
 Sun, 08 Nov 2026 07:11:52 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49592f38e2bsm4605876f8f.8.2026.11.08.07.11.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2026 07:11:51 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Tony Dinh <mibodhi@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 0/6] fs: ext4: check on-disk values in the write path
Date: Sun, 08 Nov 2026 15:11:50 +0000
Message-ID: <5072bec2-e2e3-405d-91eb-58fe78ea6669@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

When ext4write (or saveenv with the environment on ext4) writes to a
filesystem, it walks the parent directory's block and the journal by
values it reads from the image. A corrupt or crafted image can then make
it write a directory entry past the end of its block buffer, overflow
the fixed journal entry tables, or loop for ever in the journal scan
that runs before every write. The write path also takes the first data
block to be the one mke2fs makes, while ext4fs_blk_to_group() reads it
from the superblock, so that the two can disagree on the block group of
a block.

This series follows "fs: ext4: check on-disk indices before using them"
v2, which covers the read path and the delete path, and applies on top
of it:
https://patchwork.ozlabs.org/project/uboot/list/?series=530226

1. the write path refuses a first data block other than the one its
   bitmap code assumes, so that ext4fs_blk_to_group() and the bitmap
   code always agree on the group of a block
2. ext4fs_get_new_blk_no() uses ext4fs_blk_to_group(), as Simon
   suggested on that series, after a quiet check for the end of the
   filesystem
3. directory entries: one helper checks that each entry lies inside its
   block and that its length covers its name, and the three functions
   that walk a directory block (the walk that adds a name, search_dir()
   and unlink_filename()) use it
4. the journal entry tables: every function that adds an entry checks
   for room, counting the entries already used, and a transaction logs
   no more blocks than one descriptor block has tags for
5. the journal scan ends at a block without the journal magic, of an
   unknown type, unmapped or past the end of the journal, or at a revoke
   block whose count is larger than the block
6. tests in test/py for 1, 3 and 5

With sandbox_defconfig and CONFIG_ASAN, on the earlier series the new
directory test corrupts the heap (dlmalloc's check fails, "Assertion
`inuse(p)' failed"), the journal test times out in the scan, and the
first data block test replaces the file, which under valgrind reads one
byte past the end of a block bitmap in ext4fs_reset_block_bmap(); with
this series all three pass. The existing ext4 tests still pass with
--fs-type ext4. Writing files to filesystems of several block groups
until they are full, with 1 KiB and 4 KiB blocks, with and without
extents, gives the same block counts as without this series, and
e2fsck finds them clean.

The journal table limit only bites on filesystems with very many block
groups, so no test makes one; with the default of 100 entries a normal
write uses a handful.

CI: the series passes all 91 jobs of U-Boot's Azure pipeline, in build
13738 of my CI-only pull request, on top of the ext4 v2 above (Patchwork
series 530226) on main feb8913982e.
PR:    https://github.com/u-boot/u-boot/pull/1064
Build: https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13738

Ana Bobillo (6):
  fs: ext4: refuse to write with an unexpected first data block
  fs: ext4: use ext4fs_blk_to_group() in ext4fs_get_new_blk_no()
  fs: ext4: check directory entries before using them
  fs: ext4: bound the journal entry tables
  fs: ext4: stop the journal scan at the end of the log
  test: fs: ext4: add tests for the write path checks

 fs/ext4/ext4_common.c                 | 122 ++++++++++++++++----------
 fs/ext4/ext4_journal.c                | 105 +++++++++++++++-------
 fs/ext4/ext4_write.c                  |  13 ++-
 test/py/tests/test_fs/test_ext_oob.py | 115 +++++++++++++++++++++++-
 4 files changed, 270 insertions(+), 85 deletions(-)


base-commit: 8649a54d301a4d0ac526324c7a7ad2574939ff27
prerequisite-patch-id: d5a6719867877bf4c0422833eee0bf2cc5aaaab8
prerequisite-patch-id: b835c6b7cdb7863c6f71d94f725f072fffdaa24a
prerequisite-patch-id: 117c9e973a140f08733823f076375012f7f0c285
prerequisite-patch-id: 2ed9cf40521d69baa52454f829bcd1d1da991892
prerequisite-patch-id: 7fa629dd32831d8e39db5f23ab2131a84ed097af
prerequisite-patch-id: b53bdb663aab3246d5ddecf18de1ae73e30fe6a5
