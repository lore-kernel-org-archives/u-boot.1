Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4D7C5DF74
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 13:50:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 68BBE81109;
	Tue, 18 Aug 2026 13:50:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 45DWF8txCa7z; Tue, 18 Aug 2026 13:50:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BBCD8810B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787061048;
	bh=WRniE80TcNzGbgTHMpQBZb0BaewyWscdfPz+acBOcAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YBgSW8NajHlOVs81Jx0ic260TxugXK74lmjt0PeNjWZPsShtS8HktynBWyNX3WArs
	 Q9p48zhUUMnQj0D87FRSWA/cieSPnWLl1uWbqOMH4AFUNupX6cib1K1+8xhTGEUfkV
	 NiP1EPGqtCKXWRKskkyll4rwJkXDqVEyRG0xIPQ82EhtqgVdd7WDXQbKN9dP2Jh+FH
	 nSM/NyMb1n8W0uCMXJ2PEbO5wlp4SuXNN/SWWOvfD8uPkx2iCYa02cTHjcgqiTxiUo
	 NtZitip4TVGFjsND7APopDp8DZfep0zHHUMve2T49FMooKY1Kx8+Xir/OKfkj+DqeX
	 HUap+Hwlq+P5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BBCD8810B7;
	Tue, 18 Aug 2026 13:50:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 16B54194
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:23:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F1159608A1
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:23:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9NYgQyuLNTV5 for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 13:23:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org DB34A605DB
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DB34A605DB
Authentication-Results: smtp3.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=mbdaTkPU
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DB34A605DB
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:23:54 +0000 (UTC)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 11AAF3F62F
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1787059433;
 bh=WRniE80TcNzGbgTHMpQBZb0BaewyWscdfPz+acBOcAs=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=mbdaTkPU06Ip6TdS/xZvw/dqjlScaDWtQDdBsHv5e8Flv1l+YbqNNnADyxDmMsaPT
 V7PAdpaqqEr1BtX/6MssvXaOspxeAxwG+qsgZHdlOZNWKnlWZJ5i9Z3hgJMTqx9dCb
 m7q1R+fAsKhVYop7f92ZubtYxuWf8/CELnHCu4wS/D2HnjjVHAbsVp7SR6Al0BesZg
 Q1FjYIUfhK/mPrJRQ7RUtir6KnEzXR7RePeR4AZapVyjaowLu7dw+x21xlBTbliz9s
 z4UvcIRthgLdPvzlGsG340aa52zMRCrQNH/cgphhq+v+qIMSLz2rC+ZlBYtUk+Bkkx
 GmU6jTG3zBGT0Ki6fs3mXsn0ZtE42ukO98CPAk6NdOnXsk3MSjCH1lNeyJIms9tiAC
 TlrotvPsCXYO3bsOhUz4Vl4BO83zqffRG6BAXHTPqXMnH37ZjZxYmcYt7oO9Reknie
 4aLoS2ZCnDnCiMd0a/3YB/kiANi+/ErougggzXDLwYX78Edv6oCLQoHMdg3kLhjW7n
 c0sxAiBY54v/1JiB7YIyfZIosAaASqTXixIIvoLczKT3cC9XXDTVwVXLUFqlOioaSI
 yrN+6vmskSeP+0Fs4lb+Fi/Ll7zn51+02LfBUbzbIcSqZTBBhMbhYPcam1R61SoV/0
 s3POEpIXvozwV4VS+wBsmLss=
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-84fa3b14ed2so4245483b3a.1
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 06:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787059431; x=1787664231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WRniE80TcNzGbgTHMpQBZb0BaewyWscdfPz+acBOcAs=;
 b=O0eTKdZ+3lySwGHXuOXnAzv1VFT9OpwIewCUEaRsVQIvhMVauCgMWtio0hvrhsquDx
 pnFXf9Z/nQjDXrzbiu3GKd7wr9qN51GYyZWOaEdPi/0mWpE7MUWLL63LtUuj+svW5Uv5
 CfAKmJHDNqFTZrmXUm1mRwamQWLpKt4/jIaSfp89+0UEVsO4j9B75tuhdzFpy3FT362D
 LiaaEIIgDeLnLLL1xSsbbueYZl9tceiipql6QPDYcsXDvmiu7CAA1E2pqNGTWJsPog6t
 aYLkVylqOuE42a7X8oAFjMHH+I2ORyad1fzdTvH3g7OgomwP0SRH0uMlhHzEHNLnTmed
 PnCA==
X-Gm-Message-State: AOJu0Yws0Dk5JUsHfFBF8xpkC14dl60QIRvOQOIb5EgZTN9DLvJG9CCS
 kvFVt4qSD/1g/DJv0GAyrp9ChwmZXqr46He3Ob5oAVjVj+7e2kwvNrDxq7dGfpL4raT1+cGO5Nn
 AjOb/jAmPef1+oPoAG9B5nQh5dPSKrszVUbT3vOEn1HkxvpNN4p9WZD4r3bwO7aWcOZTacMMrG6
 B0kU0rkO3ivGyNXwUj2w==
X-Gm-Gg: AR+sD13G7upDVINBajZf5tJklbuqiQs2i8EA3VGayQyeWUGtT3iTCNJfi/v6YCPpHFS
 XtpxR4rjSNcYt3SKMe78raI8SoVZ3AaXmY+djFTOXJGWVeCFNYJ17ZKi6A64NaAvv6RlX1xiMcp
 UDxp5y7vwVOAfWB50YohOw/p7A4m8pmXeWc0LALjJppbczM8ct1Vx4V+XIVsUzfcToCEv6FNFu7
 ueJO4PgCzJfJNgI8ldKZ675pP3AI1T1UaJtydBzRn5dsJ4KdshXRW7iJet3e5ej+JGN7j+PA15L
 Ki9JuvxlCMVbk+Sor2b/QTwyBAvMPLH7TPVF0sMkfJgU6zGJUuH+Ty6T6HmnL/Q2fV494be29Lp
 a8WBL5UwEqIOR1Z+mVLsUTPsdf4pZ/a/lc4H+8uq3/PKdhaGd
X-Received: by 2002:a05:6a00:448e:b0:848:42d0:bc91 with SMTP id
 d2e1a72fcca58-851b87d91a5mr12091840b3a.12.1787059431475; 
 Tue, 18 Aug 2026 06:23:51 -0700 (PDT)
X-Received: by 2002:a05:6a00:448e:b0:848:42d0:bc91 with SMTP id
 d2e1a72fcca58-851b87d91a5mr12091727b3a.12.1787059430974; 
 Tue, 18 Aug 2026 06:23:50 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b6fc0e84sm1515818b3a.43.2026.08.18.06.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 06:23:50 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, nora.schiffer@ew.tq-group.com,
 Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/8] test: fit: cover the kernel_noload gzip header-size
 and lying-header paths
Date: Tue, 18 Aug 2026 13:23:16 +0000
Message-ID: <20260818132332.324173-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818132332.324173-1-aristo.chen@canonical.com>
References: <20260809042338.63397-1-aristo.chen@canonical.com>
 <20260818132332.324173-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 18 Aug 2026 13:50:44 +0000
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

Reshape and extend the kernel_noload decompression pytests to match
the new bootm behaviour that reads ISIZE from the gzip trailer:

  - Rename test_fit_kernel_noload_decomp_overflow to
    test_fit_kernel_noload_decomp_gzip_lying_hdr. Its setup (a 4 MiB
    payload of zeros gzipped) used to force the failure via the 8x
    heuristic starving the buffer; now that bootm reads ISIZE, the
    honest trailer sizes the buffer correctly, so overwrite ISIZE
    with a tiny value instead and verify the resulting decompression
    is still stopped at the buffer boundary. This is the direct test
    of the CONFIG_SYS_BOOTM_LEN cap on the attacker-controlled
    header value.

  - Add test_fit_kernel_noload_decomp_gzip_hdr_sized: a 6 MiB gzipped
    payload whose compression ratio is past the 8x heuristic
    decompresses cleanly because ISIZE is consulted.

  - Rename the pre-existing test_fit_kernel_noload_decomp_boundary to
    test_fit_kernel_noload_decomp_gzip_boundary so every
    noload_decomp test carries the compressor in its name.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/py/tests/test_fit.py | 84 ++++++++++++++++++++++++++++++---------
 1 file changed, 66 insertions(+), 18 deletions(-)

diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index 76adb98e2c5..81df84f54c9 100755
--- a/test/py/tests/test_fit.py
+++ b/test/py/tests/test_fit.py
@@ -118,8 +118,9 @@ host save hostfs 0 %(loadables2_addr)x %(loadables2_out)s %(loadables2_size)x
 '''
 
 # A minimal ITS for a compressed 'kernel_noload' kernel. bootm allocates a
-# per-image decompression buffer for this image type, sized as a multiple of
-# the compressed length; see the test_fit_kernel_noload_decomp_* tests.
+# per-image decompression buffer for this image type, sized either from the
+# gzip ISIZE trailer or as a multiple of the compressed length; see the
+# test_fit_kernel_noload_decomp_* tests.
 NOLOAD_ITS = '''
 /dts-v1/;
 
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
+        gzip ISIZE trailer. That value is attacker-controlled; rewriting
+        ISIZE to understate the real size must not let decompression overflow
+        the resulting buffer.
         """
         sz_1m = 1 << 20
 
@@ -527,20 +527,21 @@ class TestFitImage:
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
                                 {'kernel': kernel_gz})
@@ -563,7 +564,54 @@ class TestFitImage:
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
+                                {'kernel': kernel_gz},
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
+    @pytest.mark.buildconfigspec('gzip')
+    def test_fit_kernel_noload_decomp_gzip_boundary(self, ubman, fsetup):
         """Test that decompression succeeds exactly at the buffer limit
 
         For a compressed 'kernel_noload' kernel, bootm_load_os() allocates a
-- 
2.43.0

