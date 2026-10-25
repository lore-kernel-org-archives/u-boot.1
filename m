Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A804606A328
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=piicwsz3;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xz/Ahf68
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5BE59605FC;
	Sun, 25 Oct 2026 13:04:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AzLr6vV23L0a; Sun, 25 Oct 2026 13:04:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 97A3460F19
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792933449;
	b=ls6aXggWu9mx9ziXMNaeoK6bmxn2HkGvYiQ9hmtxI68BipeSOBmTAYi9O4g3nTa0mpxY
	 xSyfnqDq/5GG/gdNvkwp7v3ajGA/NnBKp8RwLvLILDNWXTsw1g9OlSRiA57QcAxGP2l3l
	 7BwKJfuxkfNnFHOM+BmpsPTRzUbuyghDAOU2nS0VGrMfzI/IBLYjSfb8smX/YPhB6aNGI
	 Vy76Bx/Ad3Du7IERWefJK1RFqqLjV4RnunSitsObiyTu1G0ITBjurusUpjd1u9vRVDshq
	 fpTPeFwCTONB9cje+lVsMNNOVjc4ybYtZXe7U+pIJbF3x6aBhpGwkxeVuTxRWNIq1PA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792933449;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2D1OqXQFelgqoVKwehJQKU/4HY0aiIbGi7rN8x3MYW4=;
	b=B3cViMwGwkqk6/F8zz8Si/mvdITEgI/yLipWg/MijLWE4AQnG9IkDOVoTR57Z8t1cx9c
	 i/2mFvJw5s1Meox2TgJ1DWv9M8VmIdC7xf9xUXA3jn0Cs6I/JdmdWZGTzwQBoxExpEMpF
	 GDHrSwjQXVmMPPVDw9v3fT/24SStFngyop6fX0mup9TVvqIQ2AI0F8jBZ1Cthqf5u+VZU
	 sX2oTNIuWj/GBRMSxHmtGz+uwl9IBdAyxPxpCfxn8sObeL9oCy0lI8uxw36ndXPTXNVUR
	 vekrv0puTmSACbD6YOdAWyT9qIZ3nV5FuePAeR+NsXp4ENRVG07JM4cY013T6RRPL0g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="Xz/Ahf68";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792933449;
	bh=2D1OqXQFelgqoVKwehJQKU/4HY0aiIbGi7rN8x3MYW4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=piicwsz3khQnfVUPhihFyHwtturoO2+iNCOHPjOZgBPEYABLguKfkHbiL77GOf3YQ
	 P9RKcA1SaNPJgYYcamCGmMJLco6cSqz/CXRoITZVw298LC4d/k6g9bspP2/RCF8RQO
	 4rSq5SwollsP6NlPWv0LmBsttk2b7km5+hIMBD5Om986DiKbdbTijgc+VbhBeJpu6F
	 f8PDHRaHmweIwvsFGbC5/Xq+2vRvMpVqQ5PwlzuPywhlSYNSDT1VTda3XfwrV/5m4t
	 xFetV8Qj4L0JZRtNhCXFzH0egyfP157CAuX+jTmNhS9/4RXQdJipX7WfA/l+sD9ngC
	 fABKDSHd95iNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97A3460F19;
	Sun, 25 Oct 2026 13:04:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 988C335F
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 13:04:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7EAB760F19
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 13:04:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id buFeBIM_XvzF for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 13:04:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7E5E6605FC
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792933447;
 b=QAaQHMGPvF3NOATMK3KPPZ1OMyshEXFoRuFQ7KgNHkGrgCLzYqkKLQSI0uIehDYHLIEh
 Xr43HxeYRZk4KbCddTe2FTuexgSuyHTuZzBR2iCf9j/EDwtw0TR0DmLYfYZepfU0oaGfL
 zNFcvd7XYmD4L7Z7FBPEsf8HkmZFcCLAr19JQzfGW0ITG/sgPdACwDYgsPy8yrGUMsynl
 JYvoLBsC5VWuEUlyRj9wWBjk67rJWQlx8Q2xVM6DAtZsRfGq59COvz5RTAbdVKD3pymdN
 OYQioDCM69Gq5B7EC3F6gPKsZkJaYC5/ml3rdepadzcQW6JtFKhou3S+bBPy+tWR+KQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792933447;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID;
 bh=2D1OqXQFelgqoVKwehJQKU/4HY0aiIbGi7rN8x3MYW4=;
 b=J6SDfLvaOoIR/oVa2fFZGLbo7Dqthkc0Z038G2XH1AZOaxfzyOAeaDs+FQ7NrMPd/hQo
 PO92aWMV2DF/oNJXZqj2w7i44GFin/phdP2Pj/tm1BJFAEA8yCh8ozrvmKy8gDKVKrfUG
 T/tishJ7jpVn8ib4LdDx1oS6p6ub9HysqPOnhUGdrIOxdUzVIlQPab5x+MD/ex5crrmXA
 av7qKw94H652UFpcNtNlyvmp9KDoNTfC0NNJkqlbws5Y7iPsnXHRn6O70rQ+86n8Dpb7U
 KpSbaVi2ODoJ0kOrYZEjRv8GjT4t8d9eoCYHs331bn6g9JV4/IiUbNLKPvGXqp+bxpA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="Xz/Ahf68"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Xz/Ahf68
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7E5E6605FC
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 13:04:06 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so4293085e9.0
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 06:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792933445; x=1793538245;
 darn=lists.u-boot-project.org; 
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2D1OqXQFelgqoVKwehJQKU/4HY0aiIbGi7rN8x3MYW4=;
 b=Xz/Ahf68XK4bH6ErQAmZKR44J/CGpgIrV/SnAtnRPEvj4J4662QqC3GiEf3okRzlwZ
 5JcKi2VyQexL7OP2mnwmhH/VpyDogyKXpQBsYVrYBuibTUimM/cRgcFxp4KCOdgeOH7k
 ENTzhTcXQCv7vkRNdi3NqQiUI1Sl7eNuwg0hKVUEKV47R41fU/aMU8TEKxlSYWWOgZUn
 TGFCaDpENUcxG9ahl5haELPQsXpuItyWWs6yAy8b/H6CiJH5lBftxyjYaHHVBozM4LXE
 m6YhRattzD4EwbSEePQiLgqxJDtd0/UysQhdS2mDuR+IoeNbuQn27gr1X5YZWCFTFPR2
 71Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792933445; x=1793538245;
 h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2D1OqXQFelgqoVKwehJQKU/4HY0aiIbGi7rN8x3MYW4=;
 b=CnToQhyun5GnRPtBkZBeRkLEpm0Rgvh3563c5jPWFXEffCO++pn/aPCy09lA6zJEFv
 JhigzexJ08tEn9GbiQ5ajVIfy+O97OsuhDR5bOuYLKiXwsPhL+IqkA8Mjv/ZA3t3vu3D
 DcIu9GU20SsLAsIRPHzBSlETo2lQfve2P/XWROsAxeQQZPqIfGs8VOqdNAFlv2U95CjJ
 TzkiBJy+8lkxPS5g0nZ23O0qUW1coPABliG1NkDCa4uE8Smgsyq7Cgg2KD0q5jqjpEms
 iN7aCDRw1n4x6quz+Kyayeox4B9F1nhNc2fH6EPCLRRZIhey4tJ2GI0aMtaEhrvrtEXS
 Z8Cg==
X-Gm-Message-State: AFq9FYI9qxQkczxtHXUJbmaStR34eIKeEC8lbtNdO+RoT/sjIsdIiJ+w
 F15fYoGTeI45zNIAL4DEEQLCz8VIf2Ri3HBdkMoLhwAWVmPif1MoTqhM
X-Gm-Gg: AYBFou1Fig35LoZs0uRsUnvtuiNZZ4xX2J4yqxxYWmhPvop/xtjVe0BHSPEgWfT9tby
 +pBsSQDVgV4sQ/wpEFM4kKDpEKokt8Snqm10CO3nNak6vq2L2kE+fojU4xD87YC9QUUrBRVlsee
 jNd9l3GqlfVoucLBNMMtERGbcjEmSaVrfJrdwTeyfwWakP6XzRbXDpm+hQtuarPnwUPBF/TrHq/
 tEdF0Kl75XhF0xkmBCFcyUJoKEoU9IwbvpUMXVrpml2s0Xqc9hy2+bdKCyHymsTU/jXaE03EmkN
 7A+0nl43fcZjjBttqHZcxRU7w5RHiZs3NnLSiomA/jcFKOCmqUcqwTcwUSsg+Ey+Wnm4Mgi2o8x
 2x0HVnBH1d8N0O2qYx0F/anRqlCIcJu8/Coarw2al1WJblAI889HWGKb0qhAC5JKWBTwIVx5rAQ
 lM9tqb9iDhSAVAMcJq6HOE14HQkG+wEJTNOExVsyYonDzOdUmzERxFo7yB/ORkG3EJ/IoKBHSy3
 KG54uyxsUvE7mmT5nHsyk3y3lKiZpFbC8jIAMbfmglyY8nhxnWsoNrVjA==
X-Received: by 2002:a05:600c:4583:b0:4a2:167a:c946 with SMTP id
 5b1f17b1804b1-4a35ac8ea44mr80842455e9.13.1792933444589; 
 Sun, 25 Oct 2026 06:04:04 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a4cb7bece3sm68130565e9.10.2026.10.25.06.04.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Oct 2026 06:04:04 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Tony Dinh <mibodhi@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH RESEND 0/6] fs: ext4: check on-disk indices before using them
Date: Sun, 25 Oct 2026 13:04:03 +0000
Message-ID: <dd4dce11-8583-4124-a8de-c8680536a08b@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

This is a resend of the series posted on 23 October, now with the
patches inline: the first posting carried them as attachments, which b4
and Patchwork cannot use. The patches are unchanged and still apply to
master.

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
   filesystem
5. the block group of an inode is (n - 1) / inodes_per_group in the write
   path too, and inode numbers from directory entries are range checked
6. tests in test/py for the cases above

With sandbox_defconfig and CONFIG_ASAN, the new tests fail on master and
pass with the series applied. On master the corrupt extent header is not
rejected, ASan reports segfaults in ext4fs_reset_block_bmap() and in
ext4fs_reset_inode_bmap(), and ext4fs_init() divides by zero. The
existing ext4, env and mmc tests still pass, and repeatedly overwriting
files on clean images, with and without extents, with 1 KiB and 4 KiB
blocks, keeps the images clean for e2fsck.

Simon Glass's "ext4: Add a few overflow checks in the writing code"
series from last year checks the block size and the table sizes in
ext4fs_get_bgdtable() and ext4fs_init(). This series checks other
fields; patch 3 adds its check next to his at the start of
ext4fs_init(), so whichever lands second needs a small rebase.

Ana Bobillo (6):
  fs: ext4: check extent tree nodes before walking them
  fs: ext4: fix the triple indirect cache check in
    read_allocated_block()
  fs: ext4: refuse to write with an unsupported block group layout
  fs: ext4: check block numbers before releasing them
  fs: ext4: fix the block group of an inode in the write path
  test: fs: ext4: add tests for corrupt on-disk indices

 fs/ext4/ext4_common.c                 |  54 +++++++-
 fs/ext4/ext4_write.c                  | 172 ++++++++++++++++----------
 include/ext4fs.h                      |   1 +
 scripts/pylint.base                   |   1 +
 test/py/tests/test_fs/test_ext_oob.py | 147 ++++++++++++++++++++++
 5 files changed, 306 insertions(+), 69 deletions(-)
 create mode 100644 test/py/tests/test_fs/test_ext_oob.py


base-commit: acc808479730e13e74199119eb9b2b9113999244
