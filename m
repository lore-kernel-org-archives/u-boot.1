Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A78C531CA
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 13:23:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2B5E409D2;
	Thu, 23 Jul 2026 13:22:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vhTAm_hZHzoL; Thu, 23 Jul 2026 13:22:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9EE13409AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784812976;
	bh=Sb9F8W0pmrIz9jOMpXnLEKAUPrPHJtFBbjSh/jn6MTM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g/BHZp9MxcFNUcNsAcElrXdCtajh/TXF5yVCJcj0BEMrBdorBOZyedUT+IYUMdWV4
	 sdO+qd4C4ycX7f4Vis8Y6YacVfzeKlT49wnhedEg8hn+L/GoAhnNtUd/HjOSyqPJGs
	 zdHWVCf591w3lgijFkNhW2hidXtoT65aw5iWWUUXW1tppUSRwOiD4022zOVyA04jfQ
	 u99oH1hYSFUhhbhF/YhRixQxP8KWTTFtmrbTerB/F67BEelopi2y93P3gcEYOm0mRd
	 feqxhFtg/wlKGiNkvJPVgWqgDv9XNe13WcdPDvgnhzMR0liMWoPE/MHn2Kl3AIs2i/
	 P+uGWi5+tLtFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9EE13409AE;
	Thu, 23 Jul 2026 13:22:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E5092E5
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:27:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 904526071E
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:27:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lLqXcuUDINBf for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 09:27:08 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 788766075B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 788766075B
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 788766075B
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:27:07 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c197f968b3cso66647366b.2
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 02:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784798825; x=1785403625;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Sb9F8W0pmrIz9jOMpXnLEKAUPrPHJtFBbjSh/jn6MTM=;
 b=MHAbDa8QoArwCsD4u83xIIpxB7ML116zByr7OTiyiMPS6DugF7UmerzllTYBW+xyqk
 u01sx/qZZKmkCAgGJx19D5h+JnhI99WLd+wvHp5mOIsa00nATLFsO7KHkduXdw2TF61g
 Sb186Fyequ8kiCPGFxYBi/GNU593SxBVj/2mLBbZd1IX1g5mUS42FwQOES8ba7WsgONh
 D9Ojvg6Ex6AWOeNOBLgpT3Jwihn3Nj/dXfY/6rCxM2owdBDcoGxRSE/ucsp1+Qr3IiBT
 DE48xsQhnuLp7eJ4AU1YwtAysNoRHEWkI+XcyBWcQYPC6sctBZUF5jRHTsIH0Jtokfug
 PCHQ==
X-Gm-Message-State: AOJu0YxtWPK1SFePQyNmfbvKEM5mLffWhd1HZdL7u+5X04wAPJbjXP1Q
 fclLZsB5xSW3OV0kNTiZYNxv/UoRB+cviQWvbQJZ4Fsp7KOpKOniLPhxV3fETiycKBc=
X-Gm-Gg: AR+sD11cMDx2zYhn9oC/7YC3c2c9vEMPGWXFvgUBqukLZFJhMmv/ZGrESeVYlY7+tlr
 G5Q0WrwVXhOhoM5ITgf+dc5N5thAu1w8NAFxyaX9A7YEah4CQS5ncxHsMbxvjrc6WIeFM35gcGI
 RUwuGfmSTEFgRcscER5Lu5qnWPeuGE3rDa+Vg2jfY17eyIVsxzGLin8PIs19KNEmbm/lfThly7U
 f/9BTcTZXXVsI0RJmH01WNEGM0DmhoKSwx7ZQ5eafOnbfA+BxUPWSvyeIMoXGeGkI7hn7YdEplY
 5Gn5cF+7JYc2Fwr8YsdY/dJk1FRqB/R6ePFXAvBvWr2yCt9msJrKUHf+K07sjRssvk7pO9TAbEQ
 LLr11llsMh8dLIT4GKoGrjdPl9nx/FAuLcdDHbTZIM2d5xIybplsNhfd3p+99XnhpUy0mX6wghK
 aLSF4a/xKgC7oHiqeIbrXquh9QsZDwxiEDQGc+sx+qk6XZ28KRobo8Md3aOKW3/PdhCgQ=
X-Received: by 2002:a17:907:9862:b0:c14:816a:156a with SMTP id
 a640c23a62f3a-c1c5099b4a5mr77317866b.43.1784798825108; 
 Thu, 23 Jul 2026 02:27:05 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f0aed0099e3f3dc2d051096.dip0.t-ipconnect.de.
 [2003:ff:f0a:ed00:99e3:f3dc:2d05:1096])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32af244asm206455266b.27.2026.07.23.02.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 02:27:04 -0700 (PDT)
From: shj <shahriyar@byteray.co.uk>
Date: Thu, 23 Jul 2026 11:26:51 +0200
Subject: [PATCH 2/2] test: squashfs: add directory table overflow
 regression test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-sqfs-oob-fix-v1-2-4fb6d9a49e8a@byteray.co.uk>
References: <20260723-sqfs-oob-fix-v1-0-4fb6d9a49e8a@byteray.co.uk>
In-Reply-To: <20260723-sqfs-oob-fix-v1-0-4fb6d9a49e8a@byteray.co.uk>
To: u-boot@lists.u-boot-project.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Joao Marcos Costa <joaomarcos.costa@bootlin.com>, u-boot@lists.denx.de
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, 
 Michael Zimmermann <sigmaepsilon92@gmail.com>, 
 Eric Kilmer <eric.kilmer@trailofbits.com>, Argus <argus@byteray.co.uk>, 
 shj <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 23 Jul 2026 13:22:52 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1784798825; x=1785403625;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Sb9F8W0pmrIz9jOMpXnLEKAUPrPHJtFBbjSh/jn6MTM=;
 b=AHdNUkD2El+QGpcvgvHYVWCJhr4Bu6hi74t84cf+/IdbiRksCY0mfQKB1yqySplTaa
 ERL6WAT07jYIQnrgGuqvFkW5rm5QYWYG05CO3e/8KTlxujDPVtPzVyUKOywHQRLqhh87
 NnePd+d9+UEqBi2nfurp3kokKaxteNAAc7dvqrAIo4qv40zM7dlgYqzLNR2a76ql1Rp4
 HDiwcilMLhM5mtANjgIWNvlILIbhqL+QWSLTeUagw7+/s6e/0VyBYUXZnbBCVOB+CERe
 jdfL2r7NC4BeX7g/2V8xUDDb8qZNdCv3ehd1tzxXUxiUgKZSsX4HEb15UFucRxNs51RE
 HHFA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=AHdNUkD2
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

Signed-off-by: shj <shahriyar@byteray.co.uk>
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

