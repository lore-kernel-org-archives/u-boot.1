Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA49C5AC80
	for <u-boot@archiver.kernel.org>; Sun,  9 Aug 2026 05:15:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B50640581;
	Sun,  9 Aug 2026 05:15:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iF4UxkL96u0C; Sun,  9 Aug 2026 05:15:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 03B5B40555
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786252538;
	bh=tXQe/PCizbmxCpE/Vx4oRs9ZzovA29YxtdFqInmg2kI=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=ux+xgN/Ndry6jp9hoWNxXiMwO+vqIF0b714r8xMgSZWf1ZhOrXIZQaSSfm/dNNHCW
	 alwB4iKukzBZrUjfjR0TDd/cDl5i0J+4h+xWnPpKGZ4guv46cPkJEeffSvJNoQYgmV
	 2UtpJLK5yuLp4QOJbUfByEOZQmdt9/2ORsWDOi4eIvS82bedKJnjnBwj34krH9n18Q
	 BgblXjMlLd+d7u4dqo0gYekKnSWo4ELaKsx2i1lGSPldHwzuVabKEku9r2xN/o7sKA
	 iBuUymVIjfxVJB0pRpYO3N0X9ywuCiqYzyvKLhweW0ZfT5Pmyc+3UGmHBx5mxh70dM
	 qAUfDNtm6834Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 03B5B40555;
	Sun,  9 Aug 2026 05:15:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 90F99282
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 04:27:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 764BE6067C
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 04:27:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5647_GsQBNbj for <u-boot@lists.u-boot-project.org>;
 Sun,  9 Aug 2026 04:27:29 +0000 (UTC)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7DE1D6065A
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 04:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7DE1D6065A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7DE1D6065A
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 88E583F60C
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 04:23:57 +0000 (UTC)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8484ba00601so1117198b3a.1
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 21:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786249436; x=1786854236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tXQe/PCizbmxCpE/Vx4oRs9ZzovA29YxtdFqInmg2kI=;
 b=R6Hi+SzSRZTKG5KoKdYSNcDMlmRL2gg9JBmkcyuWh0iUJLC7cxqa5PcOHdBEEYUupF
 2uK4XjRbCgUayTbA4uJVcAMAdTW5gAse8c01RQopAUj6WewLohFzdhhxQsItyUKecs0U
 poaFmpQzEry8pLjraiENMV+sYOypxVOlpG/0+CfN4Hk8S1pt6wB4roeeflDses7S2zlj
 pBlsYsjdgXkR/uqcRk6vDFnm59ws9/gneFDmhoo14wV1A+ETtCd9MbrFnTDDeT+jwMIB
 EEuMipuGQtSN6iMU66y93N9K6I4U4wKeU3ZEkfaVxyobFRMCjtZE/OkRh6WmF31vUG3K
 WoMw==
X-Gm-Message-State: AOJu0Yx5QYtZIq60igiQf53Bpsh/8xyN8WBaQwzqYRp6npOH0sXvZoB5
 sGm4s8UNEu9hRW7A9ObuosmohFGzsAPtaRf43xNsvqC14121WUwPDVdWbAqWWsMiHk1d76bkQ2q
 13qzkkDs91524X4cfE8MNTVZJYwHE58K4kq0kiNrFRKI0mSqwUmQaQy6xhsrYAC8s3ZkhqiDOsX
 6CPbrx4/Rmgm8zX4oOJg==
X-Gm-Gg: AR+sD130tqaJOqlxAS/ZaeyU/rTjQi+5ONIU1x9ySJg2O4uoUcgaiWUgiWjDfYbO8Q/
 UkhH+svfVhg1rxuPS++r4TlYlJJ/AjiVZdSKaASpcWkiWr29Qb8lf1df4PRg/MjziVjddI9HYHw
 vP9bdoMed/EguFazQ+9eHJM22nl0h2JFEQs+cO7XqbiaZJ2x6VndDgckE3DxfrfkZuRAalD9mLK
 k7bvlXU2N0G+jHiu0DCrR2y/GQ5lLOXjxi3fwXJRNMnJi3/2StN17eY/h7brdedX7Q/j6Q0LOYp
 neOnhBpBjMvG11mTU254yB+P3v5eMDRZ7XgtzBhb7SbHLaXdrg1t1WQ6xWrn1+Zk+oZSINyAd+f
 nzsEDrdjA31/TzKWLUObkWCfgbKzKY/lvl/fAfwls1HxATKMn5ulvS1adbqHzXXv/CIJ4ug==
X-Received: by 2002:a05:6a21:6004:b0:3c3:8d4c:6679 with SMTP id
 adf61e73a8af0-3cbce8d5a9amr14099808637.20.1786249435845; 
 Sat, 08 Aug 2026 21:23:55 -0700 (PDT)
X-Received: by 2002:a05:6a21:6004:b0:3c3:8d4c:6679 with SMTP id
 adf61e73a8af0-3cbce8d5a9amr14099766637.20.1786249435291; 
 Sat, 08 Aug 2026 21:23:55 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f35bc75sm2314583a12.19.2026.08.08.21.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 21:23:53 -0700 (PDT)
To: u-boot@lists.u-boot-project.org
Cc: Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/3] test: fit: cover the kernel_noload header-size and
 lying-header paths
Date: Sun,  9 Aug 2026 04:23:28 +0000
Message-ID: <20260809042338.63397-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809042338.63397-1-aristo.chen@canonical.com>
References: <20260809042338.63397-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 09 Aug 2026 05:15:32 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1786249437;
 bh=tXQe/PCizbmxCpE/Vx4oRs9ZzovA29YxtdFqInmg2kI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=LUZrqYLNnyTw5Tp+UaOr6aARlbhpE0k01sFuDPUSTixSm4E8xhq75ClvQ2zJepy15
 uA8iUCkRFeyWV31csBopKqzmzDcHMMh19ZM6o7aUZ7zS8ewD5SfIIgZXa5Xvg3Y4i/
 dGjzJU8qnGr14pVDhVykT1I/6jYG2ZKrKjsNmKe1ogNU0h6wJPgKi3di+6kq7dSRqp
 Aj3v2B73PGxAF4mtqzOI0JAhFG84hWrYMF3oUs6zIZqv2RYiFphvBK+Gr6jm1Tc1C6
 I8IWlLhyGvu8KKHCrpv0J6daVQdwCTrdED8hDji9ILw/+McDr90RqRwyCzWgaw/oow
 fadqHdW6ySUd/Z1/6I6K2rIT3g2ZGbipDejSLeGNaMzwD1pOazGpCRbSR17EzzDuvY
 FLJSQCS++99Eaz4bQF2Mmt/Ij/Cz89Em9jEP5LH0E7jeKfGZC9IIoSla/8rrw7AUTV
 VFnxWw3sA/l5dGe/bclqG5dmW5vcJFnb7czw2nsuWk93H1ia+HMgmFk491kCZ5oWB9
 J0G6Mb8rNTL9zKTb+onrGP4QX2mprSZYeRE21o88LSDGmduT+/Zymrv89qrI4bh780
 7t/UEhq6yAlH5XiTxPzJw7bTgJ/miGLCHR142bAWqJpdW5d/mYmDMMfHAwXyglJ8Qu
 OhYff6yfVbfvfY/tB9TMGIw0=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org; spf=pass
 smtp.mailfrom=canonical.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=LUZrqYLN
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
From: Aristo Chen via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Aristo Chen <aristo.chen@canonical.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Reshape and extend the kernel_noload decompression pytests to match the
new bootm behaviour that reads the uncompressed size from the compressor
header:

  - Rename test_fit_kernel_noload_decomp_overflow to
    test_fit_kernel_noload_decomp_gzip_lying_hdr. Its setup (a 4 MiB
    payload of zeros gzipped) used to force the failure via the 8x
    heuristic starving the buffer; now that bootm reads gzip ISIZE, the
    honest trailer sizes the buffer correctly, so overwrite ISIZE with a
    tiny value instead and verify the resulting decompression is still
    stopped at the buffer boundary. This is the direct test of the
    CONFIG_SYS_BOOTM_LEN cap on the attacker-controlled header value.

  - Add test_fit_kernel_noload_decomp_gzip_hdr_sized: a 6 MiB gzipped
    payload whose compression ratio is past the 8x heuristic
    decompresses cleanly because ISIZE is consulted.

  - Add test_fit_kernel_noload_decomp_lz4_hdr_sized: the same, for lz4
    with --content-size so the frame's FLG bit is set.

  - Add test_fit_kernel_noload_decomp_zstd_hdr_sized: the same, for
    zstd whose default encoder embeds Frame_Content_Size in a
    single-segment frame.

  - Rename the pre-existing test_fit_kernel_noload_decomp_boundary to
    test_fit_kernel_noload_decomp_gzip_boundary so every noload_decomp
    test carries the compressor in its name.

  - Parametrise NOLOAD_ITS on compression so lz4, zstd, and future
    formats can share the template.

The lying-header case is covered for gzip only because the
CONFIG_SYS_BOOTM_LEN cap and buffer allocation live in a single
format-agnostic branch of bootm_load_os(): every parser feeds the same
code path, so one test is enough to exercise the security invariant
end-to-end. Per-parser correctness is covered by the hdr_sized tests
above.

The lzma branch of the helper is exercised separately in
test/lib/compression.c because standard Ubuntu ships xz-utils' lzma
shim which always writes the header size as "unknown".

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/py/tests/test_fit.py | 182 +++++++++++++++++++++++++++++++++-----
 1 file changed, 161 insertions(+), 21 deletions(-)

diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index 76adb98e2c5..0e1175fbea6 100755
--- a/test/py/tests/test_fit.py
+++ b/test/py/tests/test_fit.py
@@ -118,8 +118,9 @@ host save hostfs 0 %(loadables2_addr)x %(loadables2_out)s %(loadables2_size)x
 '''
 
 # A minimal ITS for a compressed 'kernel_noload' kernel. bootm allocates a
-# per-image decompression buffer for this image type, sized as a multiple of
-# the compressed length; see the test_fit_kernel_noload_decomp_* tests.
+# per-image decompression buffer for this image type, sized either from the
+# compressor header or as a multiple of the compressed length; see the
+# test_fit_kernel_noload_decomp_* tests.
 NOLOAD_ITS = '''
 /dts-v1/;
 
@@ -133,7 +134,7 @@ NOLOAD_ITS = '''
                         type = "kernel_noload";
                         arch = "sandbox";
                         os = "linux";
-                        compression = "gzip";
+                        compression = "%(compression)s";
                         load = <0>;
                         entry = <0>;
                 };
@@ -511,14 +512,13 @@ class TestFitImage:
             + output)
 
     @pytest.mark.buildconfigspec('gzip')
-    def test_fit_kernel_noload_decomp_overflow(self, ubman, fsetup):
-        """Test that an over-large compressed kernel_noload image is rejected
+    def test_fit_kernel_noload_decomp_gzip_lying_hdr(self, ubman, fsetup):
+        """A tampered gzip ISIZE cannot shrink the buffer past the payload
 
-        For a compressed 'kernel_noload' kernel, bootm_load_os() allocates a
-        decompression buffer of ALIGN(image_len * 8, SZ_1M) and must bound the
-        decompressor by that buffer. A kernel that decompresses to far more
-        than eight times its compressed size must therefore fail with a
-        decompression error instead of overflowing the buffer.
+        bootm_load_os() sizes the kernel_noload decompression buffer from the
+        compressor header (gzip ISIZE). That value is attacker-controlled;
+        rewriting ISIZE to understate the real size must not let decompression
+        overflow the resulting buffer.
         """
         sz_1m = 1 << 20
 
@@ -527,23 +527,24 @@ class TestFitImage:
         # per-image kernel_noload buffer rather than by that global limit.
         bootm_len = int(ubman.config.buildconfig['config_sys_bootm_len'], 0)
 
-        # 4MB of zeros compresses to a few KB, so the decompression buffer
-        # (ALIGN(image_len * 8, SZ_1M), i.e. 1MB here) ends up far smaller
-        # than the uncompressed image.
         decomp_size = 4 * sz_1m
+        assert decomp_size <= bootm_len, (
+            'Test setup error: uncompressed size (%#x) must be <= '
+            'CONFIG_SYS_BOOTM_LEN (%#x)' % (decomp_size, bootm_len))
         kernel = fit_util.make_fname(ubman, 'test-noload-kernel.bin')
         with open(kernel, 'wb') as fd:
             fd.write(b'\0' * decomp_size)
         kernel_gz = self.make_compressed(ubman, kernel)
 
-        image_len = self.filesize(kernel_gz)
-        req_size = (image_len * 8 + sz_1m - 1) // sz_1m * sz_1m
-        assert req_size < decomp_size <= bootm_len, (
-            'Test setup error: need decomp buffer (%#x) < image (%#x) <= '
-            'CONFIG_SYS_BOOTM_LEN (%#x)' % (req_size, decomp_size, bootm_len))
+        # Rewrite gzip ISIZE (the last 4 bytes) to claim a tiny image, so
+        # bootm allocates ALIGN(<lie>, SZ_1M) = 1 MiB and the real 4 MiB
+        # decompression has to overrun that buffer.
+        with open(kernel_gz, 'r+b') as fd:
+            fd.seek(-4, os.SEEK_END)
+            fd.write((256).to_bytes(4, 'little'))
 
         fit = fit_util.make_fit(ubman, fsetup['mkimage'], NOLOAD_ITS,
-                                {'kernel': kernel_gz})
+                                {'kernel': kernel_gz, 'compression': 'gzip'})
         fit_addr = fsetup['fit_addr']
 
         ubman.run_command_list([
@@ -563,7 +564,146 @@ class TestFitImage:
             ubman.restart_uboot()
 
     @pytest.mark.buildconfigspec('gzip')
-    def test_fit_kernel_noload_decomp_boundary(self, ubman, fsetup):
+    def test_fit_kernel_noload_decomp_gzip_hdr_sized(self, ubman, fsetup):
+        """A well-compressed kernel_noload image fits when ISIZE is honest
+
+        bootm_load_os() reads gzip ISIZE to size the decompression buffer.
+        For a well-compressed image whose ratio exceeds the 8x fallback
+        heuristic (e.g. 6 MiB of zeros gzipping to a few KiB), an ISIZE-sized
+        buffer is the only way the decompression fits.
+        """
+        sz_1m = 1 << 20
+        bootm_len = int(ubman.config.buildconfig['config_sys_bootm_len'], 0)
+
+        # Stay under CONFIG_SYS_BOOTM_LEN so the ISIZE hint isn't rejected as
+        # bogus; still large enough that image_len * 8 falls well short.
+        decomp_size = 6 * sz_1m
+        assert decomp_size <= bootm_len, (
+            'Test setup error: decomp_size (%#x) must be <= '
+            'CONFIG_SYS_BOOTM_LEN (%#x)' % (decomp_size, bootm_len))
+        kernel = fit_util.make_fname(ubman, 'test-noload-kernel-hdrsized.bin')
+        with open(kernel, 'wb') as fd:
+            fd.write(b'\0' * decomp_size)
+        kernel_gz = self.make_compressed(ubman, kernel)
+
+        image_len = self.filesize(kernel_gz)
+        heuristic_bound = (image_len * 8 + sz_1m - 1) // sz_1m * sz_1m
+        assert heuristic_bound < decomp_size, (
+            'Test setup error: 8x heuristic bound (%#x) must be < uncompressed '
+            'size (%#x); if this fires, the compressor got less effective and '
+            'the test needs a bigger payload' % (heuristic_bound, decomp_size))
+
+        fit = fit_util.make_fit(ubman, fsetup['mkimage'], NOLOAD_ITS,
+                                {'kernel': kernel_gz, 'compression': 'gzip'},
+                                basename='test-noload-hdrsized.fit')
+        fit_addr = fsetup['fit_addr']
+
+        # Decompression must succeed: bootm read ISIZE and allocated a big
+        # enough buffer despite the ratio being past the fallback heuristic.
+        output = ubman.run_command_list([
+            'host load hostfs 0 %x %s' % (fit_addr, fit),
+            'bootm start %x' % fit_addr,
+            'bootm loados',
+        ])
+        text = '\n'.join(output)
+        assert 'Image too large' not in text, (
+            'bootm rejected a well-compressed kernel_noload image whose '
+            'ISIZE trailer records the real uncompressed size: %s' % text)
+
+    @pytest.mark.buildconfigspec('lz4')
+    @pytest.mark.requiredtool('lz4')
+    def test_fit_kernel_noload_decomp_lz4_hdr_sized(self, ubman, fsetup):
+        """A well-compressed lz4 kernel_noload image fits when the frame
+        header carries the content size.
+
+        Same as test_fit_kernel_noload_decomp_gzip_hdr_sized but for lz4: the tool
+        must be invoked with --content-size so the frame's FLG bit is set and
+        bootm can read the size instead of falling back to the 8x heuristic.
+        """
+        sz_1m = 1 << 20
+        bootm_len = int(ubman.config.buildconfig['config_sys_bootm_len'], 0)
+
+        decomp_size = 6 * sz_1m
+        assert decomp_size <= bootm_len, (
+            'Test setup error: decomp_size (%#x) must be <= '
+            'CONFIG_SYS_BOOTM_LEN (%#x)' % (decomp_size, bootm_len))
+        kernel = fit_util.make_fname(ubman, 'test-noload-kernel-lz4.bin')
+        with open(kernel, 'wb') as fd:
+            fd.write(b'\0' * decomp_size)
+        kernel_lz4 = kernel + '.lz4'
+        utils.run_and_log(
+            ubman, ['lz4', '--content-size', '-f', kernel, kernel_lz4])
+
+        image_len = self.filesize(kernel_lz4)
+        heuristic_bound = (image_len * 8 + sz_1m - 1) // sz_1m * sz_1m
+        assert heuristic_bound < decomp_size, (
+            'Test setup error: 8x heuristic bound (%#x) must be < uncompressed '
+            'size (%#x); if this fires, lz4 got less effective and the test '
+            'needs a bigger payload' % (heuristic_bound, decomp_size))
+
+        fit = fit_util.make_fit(ubman, fsetup['mkimage'], NOLOAD_ITS,
+                                {'kernel': kernel_lz4, 'compression': 'lz4'},
+                                basename='test-noload-lz4-hdrsized.fit')
+        fit_addr = fsetup['fit_addr']
+
+        output = ubman.run_command_list([
+            'host load hostfs 0 %x %s' % (fit_addr, fit),
+            'bootm start %x' % fit_addr,
+            'bootm loados',
+        ])
+        text = '\n'.join(output)
+        assert 'Image too large' not in text, (
+            'bootm rejected a well-compressed lz4 kernel_noload image whose '
+            'frame header records the real content size: %s' % text)
+
+    @pytest.mark.buildconfigspec('zstd')
+    @pytest.mark.requiredtool('zstd')
+    def test_fit_kernel_noload_decomp_zstd_hdr_sized(self, ubman, fsetup):
+        """A well-compressed zstd kernel_noload image fits when the frame
+        header carries Frame_Content_Size.
+
+        Same as test_fit_kernel_noload_decomp_gzip_hdr_sized but for zstd. The
+        default zstd encoder embeds Frame_Content_Size for a single-segment
+        frame, so no extra flag is needed; bootm reads it and sizes the
+        buffer accordingly.
+        """
+        sz_1m = 1 << 20
+        bootm_len = int(ubman.config.buildconfig['config_sys_bootm_len'], 0)
+
+        decomp_size = 6 * sz_1m
+        assert decomp_size <= bootm_len, (
+            'Test setup error: decomp_size (%#x) must be <= '
+            'CONFIG_SYS_BOOTM_LEN (%#x)' % (decomp_size, bootm_len))
+        kernel = fit_util.make_fname(ubman, 'test-noload-kernel-zstd.bin')
+        with open(kernel, 'wb') as fd:
+            fd.write(b'\0' * decomp_size)
+        kernel_zstd = kernel + '.zst'
+        utils.run_and_log(ubman, ['zstd', '-f', kernel, '-o', kernel_zstd])
+
+        image_len = self.filesize(kernel_zstd)
+        heuristic_bound = (image_len * 8 + sz_1m - 1) // sz_1m * sz_1m
+        assert heuristic_bound < decomp_size, (
+            'Test setup error: 8x heuristic bound (%#x) must be < uncompressed '
+            'size (%#x); if this fires, zstd got less effective and the test '
+            'needs a bigger payload' % (heuristic_bound, decomp_size))
+
+        fit = fit_util.make_fit(ubman, fsetup['mkimage'], NOLOAD_ITS,
+                                {'kernel': kernel_zstd, 'compression': 'zstd'},
+                                basename='test-noload-zstd-hdrsized.fit')
+        fit_addr = fsetup['fit_addr']
+
+        output = ubman.run_command_list([
+            'host load hostfs 0 %x %s' % (fit_addr, fit),
+            'bootm start %x' % fit_addr,
+            'bootm loados',
+        ])
+        text = '\n'.join(output)
+        assert 'Image too large' not in text, (
+            'bootm rejected a well-compressed zstd kernel_noload image whose '
+            'frame header records the real content size: %s' % text)
+
+    @pytest.mark.buildconfigspec('gzip')
+    def test_fit_kernel_noload_decomp_gzip_boundary(self, ubman, fsetup):
         """Test that decompression succeeds exactly at the buffer limit
 
         For a compressed 'kernel_noload' kernel, bootm_load_os() allocates a
@@ -589,7 +729,7 @@ class TestFitImage:
             % (decomp_size, req_size))
 
         fit = fit_util.make_fit(ubman, fsetup['mkimage'], NOLOAD_ITS,
-                                {'kernel': kernel_gz},
+                                {'kernel': kernel_gz, 'compression': 'gzip'},
                                 basename='test-noload-boundary.fit')
         fit_addr = fsetup['fit_addr']
 
-- 
2.43.0

