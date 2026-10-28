Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F3A606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 05:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zNM56Bio;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jjaoHOp+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 738FE606BE;
	Wed, 28 Oct 2026 05:50:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tZ08rwy-ak6h; Wed, 28 Oct 2026 05:50:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 52BD560673
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793166654;
	b=Tcpk7R8PrPTprxrGVMFp45H4ctKx4XLaoqFEXdwNRlXCxMIDcZhFr8UekgwGFmZRiIL4
	 KCz9HKA0avAgI0kszj/GIv9i4UU/Pj2tpeE80LB98p1sHON21jRt3esemNiZA3L48upYK
	 Y9PsEgxlxmcSV/x9AQcZT5M4OE69NFdt6Y5WdU/MzMj06oxfYTGmJkiBEcynBN8ia+4AF
	 JOZBtfkbfxz3LBwZBBjhgGIQw+1HLtsk4/ucxLxrQM7EVht+A7KI01EDzP0hhguAaQf70
	 4ACZEucCrRc/DSp6ij/Qd43pRQcOUdqHDlBLi05u5699HYGFnhG+VF7eG6EMZG1fQow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793166654;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mhdx6nIFlZ2oaCNoATWdwBwdYVlnvOWkqIe3JtHEFhw=;
	b=AD8SFDSj+PkX1XMC5d65Xus+/QUYit5mlki7iW9bDfhY4ipA8GVScFVTBRlD684pv+wu
	 edpfJbk8ZQ0oE72JWkXqdv0vs5yp+BNH9Apy83uWkaD9IMYZQAmwKGKt19LPO6Jk6IhOC
	 sVrB4GeLkqtV993Km3eHaWwI/4cCWMjLaMW6eJNbP2ZW38WX/oW4b4N3HERHM+7ySt08R
	 JJkYHhy2Sv/h4i/sYQ2z9HoiFneHQgdXaJY0PJpOy5KTBUBHOAlCYCrL6ft0FKWE49l4U
	 oFbHEUECXVoSMWj3orpTonD5cmOmB9OyzV93XwyACguWIwI5A5io02awaJDIidC/Jqw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jjaoHOp+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793166654;
	bh=mhdx6nIFlZ2oaCNoATWdwBwdYVlnvOWkqIe3JtHEFhw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zNM56BioJrQUTbZS0bvLaYuZLBlj//l1LKFJuNZmpJ2L50Z0sfLhlYuMxHanTsG3s
	 TCaF49ucbaP6XntdHqb3dHlkEWz9EBCWFkeebVHOqvd8ekWMaAsWiw3NTI+tECPF8E
	 /x8nIe7jIIV/Dq+dV1WFTVfUXhBlELMXNWoyR6trKL/5znRglYt7TAKlqefbjrjph7
	 EMYUMZ4AOANUoVmc4c61MpSDhxvoCiqgHbBDlUqlN6BnErix8MNI20Eruqmj8KPVTP
	 m5ZtLENL8qXMnN3pZILRkGrvuz4M6LZ7yEjintdWRX5dmQGGuPN+8C3qW5vcN9AFUd
	 ILdEbzmW5i/Ww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 52BD560673;
	Wed, 28 Oct 2026 05:50:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CAC0D473
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:50:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BCB9160678
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:50:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h-jWNO0A8EDM for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 05:50:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A18B66065C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793166652;
 b=IntmTf2mCmVmEBfzaKHKJVAGWv8kz8PTFeR6KQdVOOfyiFAtEHyYnRdlPiWc5cHO36zk
 VRhkCFKbrcRXJaOHFwqzovQ8UhV1ELmyvsLg2WhyBf0U+/+ALQWHRe0K9pkkza9Z/PoX6
 7WknNjwI9Gj1UkG8mzl5k0pPK+WnPUG0RrG2571knvtKYnR3mdz+jHhspTBy4aL8XTK6i
 uCTg9Mqs69/NeAYGTX2fdPx1NYoZmQaDTaf63wz1hlKgBBae8645SFrEIb63FVJ10ASgS
 IJLsDyVbVCJDKAu4LVpchNP9/c+IWkDd9RV6jk/GGaYk1awTyr3oTKRCNyeEF665i5w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793166652;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID;
 bh=mhdx6nIFlZ2oaCNoATWdwBwdYVlnvOWkqIe3JtHEFhw=;
 b=AiRDp8rTmQCBgbu2vAP5ZtYMqoN/hkXS+hoJ2fIAPIstjUDAEIIfVBfzQwbj6eR7g/6I
 4vvs1Ffudig40DET1Wbhdl1GbtFxRoxy/2l1PukH/83V5NWXVTzO9BQMnf7zg6hpcmivE
 EOXpCVQ7/Fp3X0ubXXGi6W9soqZ+NDUpYUzXRNUP00g4G8Z890rkBpZ5MYDhmw4vUYM00
 tt7tzZh1X/Yjv1IPTXJj+2zp2VOE/EYtxPTS9jFB7lm9D2xyrXKNcjNybBguAw2wO+oPC
 v+9JCGlMOVvFeuikY+qWIuS8dbuLFyYlRGckOx945CfueFTW4O4FWXOYHWBx1x/XYuA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=jjaoHOp+; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=jjaoHOp+
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A18B66065C
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:50:51 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso457893f8f.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793166649; x=1793771449;
 darn=lists.u-boot-project.org; 
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mhdx6nIFlZ2oaCNoATWdwBwdYVlnvOWkqIe3JtHEFhw=;
 b=jjaoHOp+J2ZN4qt6+wY+jKhIf9sN3LLavfvAHrfBF9Fm3hXdkS9WOzk2ePPGeK0a2Z
 ZIJR2MYcFikODZfNh5RGpMMKDRjbB2qs8GoMjmckrizgDmX2ZrjqYHQTeJUn/okTd5B5
 F+p1sjQq3UJlAEmImDygJ0InvQMrn5A1g3Yrq0BXXa40pzlhU6S2Nj0b45Mp5FGrJjB3
 +5jHA4XiJO/R+WBAV0GuVnr6aZ237j97hrI68hrH4FkiCweeJ3aWZu+wU8Icq+ku9Fhy
 Tb+KQDRSTbPEQLB8jmgQVeaXIDrH/jLN7v91qjGPUE+lt8LSPXK0BQ8K9fbiiLnrcprJ
 nN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793166649; x=1793771449;
 h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mhdx6nIFlZ2oaCNoATWdwBwdYVlnvOWkqIe3JtHEFhw=;
 b=yGJlp2t1hmgemyFCU5iY/Ma9zxyAxjnqXeP2IFvksrwh9RxdjlxEGFYWyA0e1px23p
 RcbAIXe/DQeYcjAQaYpu/37glDK5fumChpspazK6qbaLacL8HA4XhLyJV7ZeGMRMol/5
 Q6X2cG7phn0a7I4MUdjIK06TNnVN7p1zibeQv/yb9usyJI8QGqO1pTx8JSXaeDNExd2i
 IKwuimv8/AyWuRB6Iactzr/dqeHdUDz95TmEbUgWP/KNhSzFi7J99eyaWhs8HvIFFd3P
 B82QHdS3XPJgP9ERsEErA0H7Y8fy5J3v7u+LFfYUvbKll4dHqv2ts4rcKyk3/IjRKpBL
 PZIg==
X-Gm-Message-State: AFq9FYIXMW1s8Zl6EsSjaQwA9C2GK9aE/MdzIGbt3W5i4ve0UuDLcNdn
 864hhWVEJczPXRoa85ctIKiauFD5jm8TnR/KWg2j8FEvEktqzKL5Rzci
X-Gm-Gg: AYBFou1FRkfKMC0xcdBIPe+3qJCxNp8X9mvmuQ9j1OMENxT0w19U+kq8vOV6dExI/ei
 I90+wr9ff/RfiMe19drs+cvLhS/+FUZ/0sA5esjtZyUEa59/jKQY1IEssBGn/tbXh26l8lm2JM1
 Is+TePOACQUV4P3mgx6uP4+csCk9IrGjQgAAZC4rqupzK+dTTNM8hEMPZC+JkbnOfK+DCB9/UMb
 yIufUCgH0ErKiXVsvGDuZol3I28+FPnI9DTUhI0bmFd0cFBlY3I8YY51oclfjzq/q1J2cP7LIVr
 0N+s8ym+edHszwV5se2GB0hhT0tts3OcW4hAL2rPgzjJTWbmSBcAdLBC4Q2acE3C21porhvwNBk
 l6PAvwHgZVRMpP6Lq/5eY6JK+9vpZgSdLwHW9/DyT9+61g3pP+kIxVUT6LivQE+d8exvA3tcTDf
 yLGmhWL0GfeuI8qyswJMuEggk4reR6Fjhn7vbu0tg+7NXDX7paklYQyqn6ur01cdu5o3xC6IWUv
 PVkb4YwK17QtOZEvt7iwjkyQqkretKaE2/LSalbxrXlaXFzAr3MggUBeSUCQPP8UEXBMzbxIVfL
 cc5jKaeym5JuQgYE4Nmn7b8YCGlbt/g=
X-Received: by 2002:a05:6000:2284:b0:48b:f08:8159 with SMTP id
 ffacd0b85a97d-48e5d46820amr3530840f8f.40.1793166649163; 
 Tue, 27 Oct 2026 22:50:49 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd8ddasm28747478f8f.48.2026.10.27.22.50.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 22:50:48 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Tony Dinh <mibodhi@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 0/6] fs: ext4: check on-disk indices before using them
Date: Wed, 28 Oct 2026 05:50:47 +0000
Message-ID: <78892543-03de-412e-831f-de840765be59@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

The ext4 driver takes several indices from the filesystem image and uses
them without checking them against the structures they index. A corrupt
or crafted image can then make ext4load read past an extent tree node, or
make ext4write (and saveenv with the environment on ext4) write outside
the block bitmaps, the inode bitmaps and the group descriptor table when
it replaces an existing file.

This series checks each of those indices where it is read:

1. extent tree nodes: entry count against the node's capacity, and the
   depth, as Linux does
2. the triple indirect lookup compares the cached block with the wrong
   index, read past the end of its buffer
3. the write path refuses block group layouts its bitmap code cannot
   handle, including zero blocks per group, which divides by zero
4. block numbers released by the delete path must lie inside the
   filesystem, and a failed read of an indirect block stops the delete
5. the block group of an inode is (n - 1) / inodes_per_group in the write
   path too, and inode numbers from directory entries are checked as
   Linux checks them
6. tests in test/py for each of the above

With sandbox_defconfig and CONFIG_ASAN, the new tests pass with the
series applied. On master the corrupt extent header is not rejected, the
looping extent tree hangs ext4load, ext4fs_init() divides by zero, ASan
reports segfaults in ext4fs_reset_block_bmap() and in
ext4fs_reset_inode_bmap(), the journal's inode is deleted, and replacing
the file in the last inode of a group fails with "no inode left to
assign". The triple indirect test passes on master too: there the wrong
compare reads past the buffer but seldom changes which block is read, so
the test checks that blocks reached through the later entries of the
triple indirect block still read back correctly. The existing ext4 and
env tests still pass, and repeatedly overwriting files on clean images,
with and without extents, with 1 KiB and 4 KiB blocks, keeps the images
clean for e2fsck.

Tom asked for the results of a CI run. This series, exactly as posted
here, went through U-Boot's Azure pipeline on a pull request opened only
for CI, together with three other series of mine that touch other files
(block device block sizes, USB Ethernet rx headers and EFI capsule
sizes), on top of v2027.01-rc1. Every job passed:
https://github.com/u-boot/u-boot/pull/1064
https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13698

Simon suggested that ext4fs_get_new_blk_no() could use
ext4fs_blk_to_group() too. I would rather do that as a follow-up: there,
running past the last group means that the filesystem is full, not that
a block number is corrupt, so it needs a quiet check rather than the
helper's error message.

Changes in v2:
- Add Simon's Reviewed-by tags to patches 1 to 3
- Use printf() for every error message, as the rest of the driver does
- Patch 4: compute the block group from the first data block, as Linux
  does; check the reads of the indirect blocks; return -EIO for read and
  journal errors
- Patch 5: add ext4fs_inode_to_group() and use it for every inode bitmap
  index; reject reserved inodes other than the root
- Patch 6: clean up after a failing test; use f-strings; add tests for
  patch 1's depth check, patch 2, the last inode of a group and the
  journal's inode
- Rebase on main

Link to v1: https://patchwork.ozlabs.org/project/uboot/list/?series=529698

Ana Bobillo (6):
  fs: ext4: check extent tree nodes before walking them
  fs: ext4: fix the triple indirect cache check in
    read_allocated_block()
  fs: ext4: refuse to write with an unsupported block group layout
  fs: ext4: check block numbers before releasing them
  fs: ext4: fix the block group of an inode in the write path
  test: fs: ext4: add tests for corrupt on-disk indices

 fs/ext4/ext4_common.c                 | 132 ++++++++++-
 fs/ext4/ext4_common.h                 |   2 +
 fs/ext4/ext4_write.c                  | 151 ++++++++-----
 include/ext4fs.h                      |   1 +
 scripts/pylint.base                   |   1 +
 test/py/tests/test_fs/test_ext_oob.py | 310 ++++++++++++++++++++++++++
 6 files changed, 530 insertions(+), 67 deletions(-)
 create mode 100644 test/py/tests/test_fs/test_ext_oob.py

