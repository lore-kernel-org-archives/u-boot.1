Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A0A606A320
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NxN4oSf1;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GT45h6vi
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ABFAA80C26;
	Sun,  8 Nov 2026 15:12:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bTEkxkVDkfMf; Sun,  8 Nov 2026 15:12:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 93E0280C4D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794150755;
	b=NX25mHX2ViTvPxgIAtw1cQ2pm5nqsU5qbDUWzw/yfmWGcVE1Xybvy5mgFcjxnJmoOIcq
	 AX5Q26McZY4FY9aMhlfJ51je2NOPYdZ/+L/86ZBnz0rySdYCqBsRu4a3hzv3ouyjtf0Sh
	 Crl7khmRACbOt9z4E3RlnLyh7F8q+iKXLSWbGdTv1tFnPphQs/Upx4/5Jb4y6tx8FiDrh
	 7fWfIpfxt+jmlRgDPpN7vKmxXRG0IUYo5c/RsvL2Nhw7HvKEktI+GY5dR0Cn5OCiHnZQk
	 q4RQePt4kVYOJxkqYYlNusUIl/Kpxm/weC4dQxMgNC448UPXyQqJXbrkHKfZ/ucCDqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794150755;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=j7dTLczYI8jAH3dL8lvMfE6llw7VcM4K1tgeX7FnIXg=;
	b=CS4KspwuxLPWohaLTIuEvyNe05Q/quCgben6PFro9kS1pMqkxbf0FbEYxU9woRdGoSab
	 iQktGi4pBt3hHzBbhVyhnA7XDwBaAdFeWKixImkh28XKronfSmzh6+CHEzF78gU0J+9Or
	 WZMUHK+FeipLzc0ncE3vJ6nodDFvAwo+5Err89kpNq8zODQsm1SbxdXzfwOYdrwCCif5W
	 72dqC/TlTeC99MfA3YSmhtKsOdlwphXX2F7M55Amx9oKuHwSMeA18t/1PL9Pokk9UziIh
	 doHCduZ5kSKyQC1DHDF3zwrPTXxHEXISTqJTZror5yxxfE8UvhAKYVtXRkQyzdkQneQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794150755;
	bh=j7dTLczYI8jAH3dL8lvMfE6llw7VcM4K1tgeX7FnIXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NxN4oSf1MYphD2zZxqUAXK7op2fN3jTtvOhVvi3mmn5nxPRnR0MtTf8qAsB+h7N8t
	 MkZOKodIB0jo4GsePZtC77426jQXhqCEFO4Z0kwWHMseZQ82K685BBuEEM/0v7Qo16
	 1ch4KySEFgWKoCK9Axu0Wyxa0sKYDa08BQe4VvmwsEM8RPtFwyaK9KWEPznfO9IrJc
	 WIZrlqCNmihteJ9NxlbrLOb3fag+awM6AU8gBbxIwRd9+QIaW8seOBiQzcoMPBSEXi
	 IkIaMqIOQpTQoLJRXM+StC9Zk5pX9ZtCMnD0Y6qAxIm83r3WWUviG6oaBIx701RLVK
	 7KT6+WbLE+9Rg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 93E0280C4D;
	Sun,  8 Nov 2026 15:12:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9EEA62AC
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 15:12:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 84E6A6064E
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 15:12:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sHm4FlQCSWdP for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 15:12:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 633E86060A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=GT45h6vi
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 633E86060A
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 15:12:30 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4b79502c27aso834905e9.1
 for <u-boot@lists.u-boot-project.org>; Sun, 08 Nov 2026 07:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794150749; x=1794755549;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=j7dTLczYI8jAH3dL8lvMfE6llw7VcM4K1tgeX7FnIXg=;
 b=GT45h6vi8/15LpLFHmab/lniPFBnMbe6dzofOVJRsBSlg0m6FmZ7o53C1zQJXSIEg6
 GeaC7obj78JuCkm2DYGzJPPSRx9UFZRX7wIMq4LC1tSCka3EnfXJSaua7aWfM6SPwzkc
 0aPExoclZ7ck4/Ql15goN43yJdb7/abzO51Z7R5W1JU8ZM2PK/FpwrLwmmjW5eSVNJkB
 KvrNVeNvHsjrQuBY19QcBKkDSYdtrxAuf4LKVGaBpUHLHDFJdFsZmPLyHq5vP/TK6W7t
 kvhsRqcmX0PPiPZotQuKpok7kL7UNpn8tAS7Bud8fEFzE7L8PfBy9xTfYlXU2ydWUlub
 7J9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794150749; x=1794755549;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j7dTLczYI8jAH3dL8lvMfE6llw7VcM4K1tgeX7FnIXg=;
 b=OabZzVb8wbAaNjKcI7gEIInUAocPJyRK7bQL/ldQgCAoGv/Bfiz7XBDAwxDRwQ4z99
 scAzcx9RYQuQB5d+LdDfbPXWZVsyu9YaOajDY6hXpXl9mLIhOLi1N/PmDND+G+OndGTJ
 dG654xJfg2vuAZmuSG2xBHYIB2A6m212L1TsG+802UavH3uCBVSzXrZ8bskJ/obEmx2I
 oo89jEGnE10r0ByWcKWlVOBL+MPA0hetGdS5j5a5XTKVmUONzNIxUS5Bf0vdu1LHX2xC
 OmMx8ipTM2Gg7fjHY28Qha5O+kwiKuKQDUU2ZF1Hn2wfA0jdDP2OL/A7hrUsBbB9mbp4
 ksaA==
X-Gm-Message-State: APuU4Z9Wk6GPjwV9L3oIZdTZJQ5uslRlFn8+GINMXlenmlDPlMWcqgsP
 FACqwOm+dCFuOjiQiuIrLBz37ptMqaZVG3cwBSd4WrNb204/iTrCqYjp
X-Gm-Gg: AYBFou1Mpzn7zaxTPN7AZPRYHaAD25OCVXk9dtvhIxA5+g29yGKStfSpAIkdifwIqB/
 aB2FOJhHmZKeDjogTqHPKHkBP+hPlfP05pE27o6iA8QZoxmeRs8ttZCP+RWmgYUgS5m4JjCYEmm
 eknlSrvzDl8LKR91VeTPjKr0GbiW5eOnejIR5j2YsyruN5QR9XevbbgK4kryzevR5e+DRQj+1qZ
 aL/r0RvmZHj82qfIKEOusrN9TDkdeZtH9BKA7SjL2d8B+mDgQZPdp0wZMz1EXbBjXFoKqbD1kwm
 OnLXKl1wauqg9nMI/VBQzBVxSitB8+mf9DKNsE/oOB/9GgWWzyeKsJmO54yQR7GEWdlV4hWj4ki
 9bxr9PiGL9IU7NHMUFVMHD4GcX76I8fBPnHhpw56ZLQn3Qj7I8KUEc1BrBcTxmrJSFn1GZZqid/
 CZYI30wUqpwiDLpcx+DrqJaXc7VZYZqkpEL0ry8eLWP6ZM3tihRtwVpMOvCdEjkZT6pD4QjAls5
 aEeTIxIhrXb1ZR+KV6AhaxK7rXGoYkljVtLq/KbhY/+oPELJM8+9codp45E/cR5AddeJFAVr3l+
 oIZViCNB++JLrQON8ly8IjfeMJyXwC9F
X-Received: by 2002:a05:600c:1c0e:b0:4a8:9a2f:d27 with SMTP id
 5b1f17b1804b1-4b963c6d797mr33414405e9.25.1794150748504; 
 Sun, 08 Nov 2026 07:12:28 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b90ee1ddc7sm91426435e9.4.2026.11.08.07.12.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2026 07:12:28 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Tony Dinh <mibodhi@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 6/6] test: fs: ext4: add tests for the write path checks
Date: Sun, 08 Nov 2026 15:12:27 +0000
Message-ID: <f47aa87a-91a0-4f6f-8249-57f44a32b47a@gmail.com>
In-Reply-To: <5072bec2-e2e3-405d-91eb-58fe78ea6669@gmail.com>
References: <5072bec2-e2e3-405d-91eb-58fe78ea6669@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

Add three cases to test_ext_oob.py:

- test_fs_ext_oob_first_data_block: a filesystem of two block groups of
  4 KiB blocks whose first data block is 1 must not be written to, so
  that replacing a file whose block is the first of group 1 does not
  clear its bit in group 0's bitmap
- test_fs_ext_oob_parent_dentry: writing a new file into a directory
  whose last entry claims a length past the end of its block must fail
  with "Corrupt directory block, not writing" rather than walk past the
  block
- test_fs_ext_oob_journal_block_type: a journal that needs recovery and
  holds a block of an unknown type with the current sequence number
  must not stall the journal scan; the journal must be recovered and
  the write must go through

ext4_image() now takes the size of the image, as the first case needs
two block groups.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 test/py/tests/test_fs/test_ext_oob.py | 115 +++++++++++++++++++++++++-
 1 file changed, 112 insertions(+), 3 deletions(-)

diff --git a/test/py/tests/test_fs/test_ext_oob.py b/test/py/tests/test_fs/test_ext_oob.py
index 12f4095c6e5..67eb5ea060f 100644
--- a/test/py/tests/test_fs/test_ext_oob.py
+++ b/test/py/tests/test_fs/test_ext_oob.py
@@ -21,8 +21,8 @@ VICTIM = b'victim file\n'
 
 
 @contextmanager
-def ext4_image(ubman, prefix, opts=()):
-    """Make an 8 MiB ext4 image and remove it once the test is done
+def ext4_image(ubman, prefix, opts=(), size=8 << 20):
+    """Make an ext4 image and remove it once the test is done
 
     mk_fs() takes no mkfs.ext4 options, which some tests need. When the with
     block ends, whether or not the test passed, the image is removed and
@@ -32,13 +32,14 @@ def ext4_image(ubman, prefix, opts=()):
         ubman (ConsoleBase): U-Boot console
         prefix (str): prefix of the image file name
         opts (list of str): extra options for mkfs.ext4
+        size (int): size of the image in bytes
 
     Yields:
         str: path of the image
     """
     img = os.path.join(ubman.config.persistent_data_dir, f'{prefix}.ext4.img')
     with open(img, 'wb') as fil:
-        fil.truncate(8 << 20)
+        fil.truncate(size)
     try:
         # U-Boot does not write to a filesystem with metadata checksums
         run(['mkfs.ext4', '-q', '-F', '-O', '^metadata_csum', *opts, img],
@@ -308,3 +309,111 @@ def test_fs_ext_oob_last_inode(ubman):
         assert f'==> {zlib.crc32(b"A" * 0x1000):08x}' in out
         assert 'alive' in ubman.run_command('echo alive')
         run(['e2fsck', '-fn', img], capture_output=True, check=True)
+
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_ext4_write')
+@pytest.mark.requiredtool('debugfs')
+def test_fs_ext_oob_first_data_block(ubman):
+    """ext4fs_init(): a filesystem whose first data block is not the one the
+    bitmap code assumes must not be written to"""
+    # Two block groups of 32768 4 KiB blocks. With a first data block of 1,
+    # block 32768, the first block of group 1, lies in group 0.
+    with ext4_image(ubman, 'ext_oob_fdb', ['-b', '4096'], 136 << 20) as img:
+        # s_blocks_count and s_blocks_per_group are at offsets 4 and 32 of
+        # the superblock
+        assert struct.unpack('<I', read_at(img, 1024 + 4, 4))[0] > 32768
+        assert struct.unpack('<I', read_at(img, 1024 + 32, 4))[0] == 32768
+        add_file(img, 'victim', {0: VICTIM})
+        # Make /victim a block-mapped file whose only block is 32768
+        cmds = ['sif victim flags 0', 'sif victim size 4096']
+        cmds += [f'sif victim block[{i}] 0' for i in range(1, 12)]
+        cmds += ['sif victim block[0] 32768']
+        debugfs(img, cmds)
+        assert victim_has(img, '(0):32768')
+
+        # s_first_data_block is at offset 20 of the superblock. The read
+        # path looks for the group descriptors in the block after it, so
+        # copy them from block 1 to block 2, a reserved GDT block.
+        write_at(img, 1024 + 20, struct.pack('<I', 1))
+        write_at(img, 2 * 4096, read_at(img, 4096, 4096))
+
+        ubman.run_command(f'host bind 0 {img}')
+        ubman.run_command(f'mw.b {ADDR:x} 41 1000')
+        out = ubman.run_command(f'ext4write host 0:0 {ADDR:x} /victim 0x1000')
+        assert 'Unsupported block group layout' in out
+        assert 'written' not in out
+        assert 'alive' in ubman.run_command('echo alive')
+
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_ext4_write')
+@pytest.mark.requiredtool('debugfs')
+def test_fs_ext_oob_parent_dentry(ubman):
+    """ext4fs_update_parent_dentry(): a directory block whose last entry
+    claims a length past the end of the block must be rejected rather than
+    walked past"""
+    with ext4_image(ubman, 'ext_oob_den') as img:
+        blksz = block_size(img)
+        blk = file_block(img, '/', 0)
+
+        # Rewrite the root directory block: '.' and '..', then entries with
+        # no free space after their names, then a last entry that ends 4
+        # bytes past the block with too little free space for the new name
+        data = bytearray(blksz)
+        off = 0
+        entries = [(2, 12, b'.'), (2, 12, b'..')]
+        entries += [(0, 12, b'fill')] * ((blksz - 16 - 24) // 12)
+        for inode, rec_len, name in entries:
+            struct.pack_into('<IHBB', data, off, inode, rec_len, len(name), 2)
+            data[off + 8:off + 8 + len(name)] = name
+            off += rec_len
+        rec_len = blksz - off + 4
+        name = b'l' * (rec_len - 12)
+        struct.pack_into('<IHBB', data, off, 0, rec_len, len(name), 2)
+        data[off + 8:blksz] = name[:blksz - off - 8]
+        write_at(img, blk * blksz, data)
+
+        ubman.run_command(f'host bind 0 {img}')
+        ubman.run_command(f'mw.b {ADDR:x} 41 1000')
+        out = ubman.run_command(
+            f'ext4write host 0:0 {ADDR:x} /newfile 0x1000')
+        assert 'Corrupt directory block, not writing' in out
+        assert 'written' not in out
+        assert 'alive' in ubman.run_command('echo alive')
+
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_ext4_write')
+@pytest.mark.requiredtool('debugfs')
+def test_fs_ext_oob_journal_block_type(ubman):
+    """ext4fs_check_journal_state(): a journal block of an unknown type must
+    end the journal scan rather than stall it"""
+    with ext4_image(ubman, 'ext_oob_jnl') as img:
+        blksz = block_size(img)
+
+        # The journal superblock holds (big endian) magic, type, sequence,
+        # block size, maxlen, first, sequence and start
+        jsb = file_block(img, '<8>', 0) * blksz
+        magic, _, _, _, _, first, seq = struct.unpack('>7I',
+                                                      read_at(img, jsb, 28))
+        assert magic == 0xc03b3998
+
+        # Mark the journal as needing recovery from its first log block,
+        # which holds a block of an unknown type with the current sequence
+        write_at(img, jsb + 28, struct.pack('>I', first))
+        write_at(img, file_block(img, '<8>', first) * blksz,
+                 struct.pack('>3I', magic, 7, seq))
+        # s_feature_incompat is at offset 0x60 of the superblock; 4 is
+        # EXT3_FEATURE_INCOMPAT_RECOVER
+        incompat = struct.unpack('<I', read_at(img, 1024 + 0x60, 4))[0]
+        write_at(img, 1024 + 0x60, struct.pack('<I', incompat | 4))
+
+        ubman.run_command(f'host bind 0 {img}')
+        ubman.run_command(f'mw.b {ADDR:x} 41 1000')
+        with ubman.temporary_timeout(10000):
+            out = ubman.run_command(
+                f'ext4write host 0:0 {ADDR:x} /newfile 0x1000')
+        assert 'Journal Recovery Completed' in out
+        assert 'written' in out
+        assert 'alive' in ubman.run_command('echo alive')
