Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037B8C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 12:59:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BAF3C813BD;
	Tue, 28 Jul 2026 12:59:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yJFRo1GI4Ydu; Tue, 28 Jul 2026 12:59:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BA94B81387
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785243597;
	bh=18rFFD3pCTgz4sR2RMNCjcB/gynpicHIct6ozNXVvuY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HnPFnHG7ocZJfz4bm7U5R4v9L8JFq60JDGBKibZvfhrvCWns/do5hoZOsYozzz6Lm
	 Y1RFslp05vpUosxZqTv71oLcDtSp2kOn+CnhJrscQFxEY57UBoLo3w2kKhmBXLNHYr
	 /6bl+uz0UlkTyZ0v9wZwQRlPKDFtH8vqkgzHe7uA2OQLh9J8MdZdT0I+z96YgVicLH
	 E7DkCmvoRhftGWnlMRAOIAITv9EF4oZ3CcTqBChYCkD9LilUkpyuEZAvl9wbNawunC
	 QiNoOXduhOCSbsK1aR77l1o/Xc2s2L6YjhtnwwhR4JNqTrRIcsnsW9Io85utXrg+3b
	 jyLUrwcfuk12Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA94B81387;
	Tue, 28 Jul 2026 12:59:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B21D263
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:55:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1D52A4089D
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:55:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YozG5z2azVDi for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 06:55:52 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 300114089A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 300114089A
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 300114089A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:55:52 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-69fe400c14aso3464274a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 23:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785221750; x=1785826550;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=18rFFD3pCTgz4sR2RMNCjcB/gynpicHIct6ozNXVvuY=;
 b=jJDmY4KxvnvgcbS//kY/18gOX+NAZqlw3S/ZzmbjkKLpBiUgYB/C/atB9jwLg/ncLa
 Ht+jYi9ssIb1pPECDZ1ua67XEt/gvmiMptUSkB/Gd1wssOFoylp+madyFPBwd1Txg3I9
 Ku2RorqqBJt9R7XgAdZMgT3piBThNzNwAj34FNjHMwEUHdNbU4PzFAGTZ7ll/VAoj5vD
 Hd+ZScu2MJams8w/MDuL8lYO8rnmzcEoc9M/gnk+3HEcF8sjQccjeyvbBTDMSSfx03An
 BfkbiyUVHp+V9wLGRT+h3g9O2Qo8nz1me6tPUvCs78jmaXz/bVUMh9PINAwFpvEdhQLe
 BBlg==
X-Gm-Message-State: AOJu0Yxhe1C+R8z140d48AM5Cr/YGGJt5FWwRfyHrHrwxXn3z9c2GlnP
 5NlZXxZqY1OS13gx2mHV4OLcZV8D08Sx8Gy6t4NDk8OMlGY3utSkFTwURBIm+dSC3Os=
X-Gm-Gg: AR+sD12JgCgDOsZOYG1KKZAm+7bPM1u2Q05HILyGIjKFQswyG7L+SesR19Lq6xIgR8C
 CS2IZVb7AJpBgMEqsRA7zNRUmQzfuHp2FJcskHuoD4U6ryptZr9SVRiFchQp0hoqW83uk7PGCH0
 eXMdIMUtIqedvNwI7Bn3NCFQaoZfAHeGl3DpeKU1AodqkM2upHOwNDz9AGwrzBjoSOxWCkilWtX
 atb4CWDURxjfHi5rz/4+MioDk4eiWP8ANF6XZ7SQQkLKEp7l1MB3mWKJYSDdJRzE+AOhxUZPKDv
 7q6p61vnCrLXh9aAi7klk3fqN2Ee8kQojDXY/sHirGrFA1cqZg9z8IF4D4WT8NJ4+1FmlbyMlDm
 H9LakOjqvE8ywXuAuGPuQNIT60oTi25chDXaNdP5HenJxleLDExmheczV8WibXpM1iBm8aYGowh
 wALjhoPNkY9WJGlYllaxASZn1NpG/CnR0O44wcvOlWQi8Y0vSbQKAcp+7iKKz6bcKhql0=
X-Received: by 2002:a05:6402:51ce:b0:69a:aa19:9df with SMTP id
 4fb4d7f45d1cf-6a034a8e122mr484856a12.32.1785221749951; 
 Mon, 27 Jul 2026 23:55:49 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f00d97d5688120f3c08.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:d97d:5688:120f:3c08])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69fb5746e08sm3493586a12.23.2026.07.27.23.55.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 23:55:49 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Tue, 28 Jul 2026 08:55:40 +0200
Subject: [PATCH v2 2/2] test: squashfs: add directory table overflow
 regression test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-sqfs-oob-fix-v2-2-077d9f0e01c4@byteray.co.uk>
References: <20260728-sqfs-oob-fix-v2-0-077d9f0e01c4@byteray.co.uk>
In-Reply-To: <20260728-sqfs-oob-fix-v2-0-077d9f0e01c4@byteray.co.uk>
To: u-boot@lists.u-boot-project.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Joao Marcos Costa <joaomarcos.costa@bootlin.com>, u-boot@lists.denx.de
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, 
 Michael Zimmermann <sigmaepsilon92@gmail.com>, 
 Eric Kilmer <eric.kilmer@trailofbits.com>, Argus <argus@byteray.co.uk>, 
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Tue, 28 Jul 2026 12:59:47 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1785221750; x=1785826550;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=18rFFD3pCTgz4sR2RMNCjcB/gynpicHIct6ozNXVvuY=;
 b=ltdoqPtH6fRZNBTPi/ENCYnHi/4ouqbw1ELaInFxSltV8sZcL0gL2u+iCxz7WkhyB6
 /tSQfesTmba4KH4dTWRGPynb2BhX4TLoYvibUr6eqbCXBUjejAcm8maX9lkDH//XzHdY
 iiVOUCJxyzmx0PDd32t1ugwu3gP6jNYPmK8Qd1DbSd98RWlvKW2vMWrmXqsfgmRfDIg7
 /S0v0O4B6Lm0Qj4cMzydDmNQ/nO39YpfQJ8fJQtSNJzd5UzsEW4sPUzCaStOmDirVtF5
 K0ZvTgselk9ug4vQCzmaWZWI1Srb9cqs1Cwfkn1J/joYCpiv4HwSn8YXLCMLVJHK/HQi
 cD5Q==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=ltdoqPtH
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

Add a Python test that lists a crafted SquashFS image whose directory
table declares an oversized metadata-block count. Such an image must be
rejected without corrupting the heap, which the test checks by confirming
U-Boot is still responsive afterwards.

Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
 .../test_fs/test_squashfs/test_sqfs_overflow.py    | 75 ++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/test/py/tests/test_fs/test_squashfs/test_sqfs_overflow.py b/test/py/tests/test_fs/test_squashfs/test_sqfs_overflow.py
new file mode 100644
index 00000000000..df7f875a58f
--- /dev/null
+++ b/test/py/tests/test_fs/test_squashfs/test_sqfs_overflow.py
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: GPL-2.0
+# Regression test for the SquashFS directory-table integer overflow.
+
+import os
+import struct
+import pytest
+
+# metadata block size (SQFS_METADATA_BLOCK_SIZE) and metadata header size
+SQFS_METADATA_BLOCK_SIZE = 8192
+# metablks_count that makes metablks_count * SQFS_METADATA_BLOCK_SIZE wrap a
+# 32-bit int back down to a tiny value: (2^19 + 1) * 8192 == 2^32 + 8192.
+NR_METABLKS = (1 << 19) + 1
+
+def make_overflow_image(path):
+    """Build a SquashFS image whose directory table inflates metablks_count so
+    that metablks_count * SQFS_METADATA_BLOCK_SIZE wraps a 32-bit int, then
+    writes one block of data one metadata block past the resulting buffer."""
+    def metahdr(size):
+        # uncompressed metadata block header (bit 15 set)
+        return struct.pack('<H', 0x8000 | (size & 0x7fff))
+
+    # inode table: one small valid uncompressed metadata block
+    inode_region = metahdr(32) + b'\x00' * 32
+    inode_start = 96
+    dir_start = inode_start + len(inode_region)
+
+    # directory table: NR_METABLKS metadata blocks, only block 1 carries data
+    dir_region = bytearray()
+    dir_region += metahdr(0)                          # block 0: empty
+    dir_region += metahdr(200) + b'A' * 200           # block 1: data
+    dir_region += metahdr(0) * (NR_METABLKS - 2)      # blocks 2..N-1: empty
+    frag_start = dir_start + len(dir_region)
+
+    sb = bytearray(96)
+    struct.pack_into('<I', sb, 0, 0x73717368)         # s_magic
+    struct.pack_into('<I', sb, 4, 1)                  # inodes
+    struct.pack_into('<I', sb, 12, 131072)            # block_size
+    struct.pack_into('<H', sb, 20, 1)                 # compression = gzip/zlib
+    struct.pack_into('<H', sb, 22, 17)                # block_log
+    struct.pack_into('<H', sb, 26, 1)                 # no_ids
+    struct.pack_into('<H', sb, 28, 4)                 # s_major
+    struct.pack_into('<Q', sb, 48, frag_start)        # id_table_start
+    struct.pack_into('<Q', sb, 56, 0xffffffffffffffff)  # xattr_id_table_start
+    struct.pack_into('<Q', sb, 64, inode_start)       # inode_table_start
+    struct.pack_into('<Q', sb, 72, dir_start)         # directory_table_start
+    struct.pack_into('<Q', sb, 80, frag_start)        # fragment_table_start
+    struct.pack_into('<Q', sb, 88, 0xffffffffffffffff)  # export_table_start
+
+    img = bytearray(sb) + inode_region + dir_region
+    # pad so the directory-table block read stays within the file
+    need = ((len(img) + 511) // 512 + 1) * 512
+    img += b'\x00' * (need - len(img))
+    struct.pack_into('<Q', img, 40, len(img))         # bytes_used
+
+    with open(path, 'wb') as f:
+        f.write(img)
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_squashfs')
+@pytest.mark.buildconfigspec('fs_squashfs')
+@pytest.mark.singlethread
+def test_sqfs_ls_dir_table_overflow(ubman):
+    """Listing a crafted image whose directory table declares an oversized
+    metadata-block count must be rejected without corrupting the heap.
+    """
+    ubman.restart_uboot()
+    image_path = os.path.join(ubman.config.build_dir, 'sqfs_dir_table_overflow')
+    make_overflow_image(image_path)
+    try:
+        ubman.run_command('host bind 0 {}'.format(image_path))
+        ubman.run_command('sqfsls host 0')
+        # The crafted image must not take the board down.
+        assert 'alive' in ubman.run_command('echo alive')
+    finally:
+        os.remove(image_path)

-- 
2.43.0

