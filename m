Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1772CCD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 16:27:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DB22848A2;
	Wed, 27 May 2026 18:27:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="fnoI8Okr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C05A984837; Wed, 27 May 2026 17:06:58 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9234844CF
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 17:06:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6CED83F96A
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 15:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779894416;
 bh=E8Gupq8XHQa+pjY7cM8VGUu+7Zpt83/zJHw3iYL7hts=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=fnoI8OkruVfC7I7/+WLOp619NgNVsQiBQjAEXtS/XFjFw1KMmW35GGQ6aJbksRH5B
 QN8Hk3uUEtSfbIkxUsPWFhRMZM+u1BLNsTFGa+FQlD1412P4U5lKMw/U4c8pBLy/fk
 tO+/gxQjqqH2y8PasV/K0bm3nqpHjnQ0mplJhgT2L2ssKreLe9U0NT4Rxjilvbxb9b
 2iWU0M0bwbh7QW/1jKE6IMUoCgLCppGfHJVWsIhuVbp3B5Kieg3OzZC1ajces+hxkB
 lrZUPOtHAzEaCjzAtdBvCy6j7Euw7iDVbex/l1+bR+r9J9/h7FSFZgQQP7ByGK+ARK
 MktXKqkMQRUevLox9WiaybG12b0OpJzgVBXY8gLb1v8s4XfJwa5OPiHon4sA6N2898
 NxU/6CA8UFjsbYXp1Mwsmb+Ys1hNMOpVXvEApLE5Hk0AkVu6PMrv4fae4RaROOnDEa
 Whd69I5tVb4X2O2ZQphW8T60Gh5r2CCVI2rGCiYooby2PpKcPKEfTExCni4ET2LBZY
 Dco3hMpOrlZdkTwZK5pR4xooXNvEX4b8d3xqvf9SX4Pvols/ePdYhus4yhtbzKQ2JK
 yYpR/KWFAT5iv4Yy3LvYF9h//p05/sQyNn1jZXl2ip4r1vxwcYwlpUiK+I01On5dnr
 1VPYBqDN3C2DM+dhBcWbPhZM=
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-369ef27fd09so9866644a91.3
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 08:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779894415; x=1780499215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E8Gupq8XHQa+pjY7cM8VGUu+7Zpt83/zJHw3iYL7hts=;
 b=nq2zXI0dD2XRJjn2irZlndrVHzG5J8M7nxkkoxx/g3xc+HMZEADHLosXcMU5cK4Yhh
 Iyu8QcI9S64Yw9/6UMvnuJtRVxOXuT1dUhvrfPcfC755y8L6xlkjfWl8zn1PeF3T1bWI
 tvXoTZSG1ABqhDWyem8utaFkW9Qmw66xSXV/9ffCOeJt3mqkY++5n+MYwnCRqTr8Xg+c
 a/Nd0vVLn5wmntO0QqBuWrBIG0x0t7I8mcRgeaq3YtFQ3tqcearB/pzTxi56q4gVgMtc
 9YU+5Zj3fq0TctNsWXbQ+hIeIhEggOvw55CPUsewjeQig1Rjre6jZSFbf5W1n6FGf+bM
 LZFg==
X-Gm-Message-State: AOJu0Yyd9ciu8LVq9EjbyQZOy2p3d+xxnKlaKrZH7/YMx5h/gwoeG17z
 fqQaehGrNIh4z3+Q415pggIkZvy7I2FzWnEJnxEjAroIOsWXXoPd0XIRXU0oWKtRwFe+rkWSOIE
 C3V5AgsaJNdq5Tksk8lwgw2ew3d/aEqE9a1SguQJEn7LCdrSfQNawHfe9fJyZe/e5NoczS59CuF
 DGMN0=
X-Gm-Gg: Acq92OEyFPfrCNtkitK/HoO/E+SXWC4v0TKS9cbZ7E4ipbSKs6UwN6bpgn853tuXGkt
 wgE4DkRt3f6huJs3mPZ5zSByu/BHg+rKx53/muQRC9xqVz9RlJ2y9Qq6dfQvlx9UBMW8nH/XjX+
 tdn8f/OVKkRMIL2Uwh/aL2I1gWRymcEfdGCh1efY+i2ZpRV36twDP/FHsR4PQ+dMX76ENi/G9Xp
 AJ20gOXpTmFNPaUPyi4EV4G13ioqQAQgTsXkiXcqQ2P8+XKoSaul7zw5tuF4k9gTRGnS3wlwzec
 Te92OT8P9wBcKtmxnUukGR2a+T9ysvOjUTw75ltzwNWR1IZr+KNj+JL5V+Rj8Etz4tgD4kMiFxc
 ouZ/HNq/7UdfCyFREK1K34dT7+6yXX54Z3aUctfxelZLEIR5+C/Y4MQ+bn42KJ/mklQTce2gKqE
 IgHURF1XM=
X-Received: by 2002:a17:90b:4c87:b0:369:7421:b376 with SMTP id
 98e67ed59e1d1-36a6762542emr22206155a91.19.1779894414805; 
 Wed, 27 May 2026 08:06:54 -0700 (PDT)
X-Received: by 2002:a17:90b:4c87:b0:369:7421:b376 with SMTP id
 98e67ed59e1d1-36a6762542emr22206119a91.19.1779894414305; 
 Wed, 27 May 2026 08:06:54 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36b73ce986dsm282702a91.6.2026.05.27.08.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 08:06:53 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 2/3] test/py: test kernel_noload decompression buffer
 overflow
Date: Wed, 27 May 2026 15:04:34 +0000
Message-ID: <20260527150637.2850104-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527150637.2850104-1-aristo.chen@canonical.com>
References: <20260520044554.15373-1-aristo.chen@canonical.com>
 <20260527150637.2850104-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 27 May 2026 18:27:25 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Add sandbox tests that exercise the per-image decompression buffer that
bootm_load_os() allocates for a compressed kernel_noload image
(ALIGN(image_len * 4, SZ_1M)).

The overflow test builds a FIT whose decompressed size far exceeds the
per-image buffer and asserts that 'bootm loados' rejects it with a
decompression error rather than overflowing.

The boundary test builds a FIT whose decompressed size equals the
per-image buffer exactly and asserts that 'bootm loados' succeeds,
guarding against an off-by-one rejection at the buffer limit.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/py/tests/test_fit.py | 126 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index 4f56a1421e1..560b7513e67 100755
--- a/test/py/tests/test_fit.py
+++ b/test/py/tests/test_fit.py
@@ -117,6 +117,36 @@ host save hostfs 0 %(loadables1_addr)x %(loadables1_out)s %(loadables1_size)x
 host save hostfs 0 %(loadables2_addr)x %(loadables2_out)s %(loadables2_size)x
 '''
 
+# A minimal ITS for a compressed 'kernel_noload' kernel. bootm allocates a
+# per-image decompression buffer for this image type, sized as a multiple of
+# the compressed length; see the test_fit_kernel_noload_decomp_* tests.
+NOLOAD_ITS = '''
+/dts-v1/;
+
+/ {
+        description = "FIT with a compressed kernel_noload image";
+        #address-cells = <1>;
+
+        images {
+                kernel-1 {
+                        data = /incbin/("%(kernel)s");
+                        type = "kernel_noload";
+                        arch = "sandbox";
+                        os = "linux";
+                        compression = "gzip";
+                        load = <0>;
+                        entry = <0>;
+                };
+        };
+        configurations {
+                default = "conf-1";
+                conf-1 {
+                        kernel = "kernel-1";
+                };
+        };
+};
+'''
+
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('fit')
 @pytest.mark.requiredtool('dtc')
@@ -426,3 +456,99 @@ class TestFitImage:
 
         output = ubman.run_command_list(cmds)
         assert "can't get kernel image!" in '\n'.join(output)
+
+    def test_fit_kernel_noload_decomp_overflow(self, ubman, fsetup):
+        """Test that an over-large compressed kernel_noload image is rejected
+
+        For a compressed 'kernel_noload' kernel, bootm_load_os() allocates a
+        decompression buffer of ALIGN(image_len * 4, SZ_1M) and must bound the
+        decompressor by that buffer. A kernel that decompresses to far more
+        than four times its compressed size must therefore fail with a
+        decompression error instead of overflowing the buffer.
+        """
+        sz_1m = 1 << 20
+
+        # CONFIG_SYS_BOOTM_LEN is the global decompression limit. Keep the
+        # uncompressed size below it, so the failure is forced by the smaller
+        # per-image kernel_noload buffer rather than by that global limit.
+        bootm_len = int(ubman.config.buildconfig['config_sys_bootm_len'], 0)
+
+        # 4MB of zeros compresses to a few KB, so the decompression buffer
+        # (ALIGN(image_len * 4, SZ_1M), i.e. 1MB here) ends up far smaller
+        # than the uncompressed image.
+        decomp_size = 4 * sz_1m
+        kernel = fit_util.make_fname(ubman, 'test-noload-kernel.bin')
+        with open(kernel, 'wb') as fd:
+            fd.write(b'\0' * decomp_size)
+        kernel_gz = self.make_compressed(ubman, kernel)
+
+        image_len = self.filesize(kernel_gz)
+        req_size = (image_len * 4 + sz_1m - 1) // sz_1m * sz_1m
+        assert req_size < decomp_size <= bootm_len, (
+            'Test setup error: need decomp buffer (%#x) < image (%#x) <= '
+            'CONFIG_SYS_BOOTM_LEN (%#x)' % (req_size, decomp_size, bootm_len))
+
+        fit = fit_util.make_fit(ubman, fsetup['mkimage'], NOLOAD_ITS,
+                                {'kernel': kernel_gz})
+        fit_addr = fsetup['fit_addr']
+
+        ubman.run_command_list([
+            'host load hostfs 0 %x %s' % (fit_addr, fit),
+            'bootm start %x' % fit_addr,
+        ])
+
+        # 'bootm loados' decompresses the kernel. Decompression must stop at
+        # the buffer boundary and report 'Image too large', which resets the
+        # board; it must not run past the buffer and return to the prompt.
+        ubman.run_command('bootm loados', wait_for_prompt=False)
+        matched = ubman.p.expect(['Image too large', ubman.prompt_compiled])
+
+        # The decompression failure resets the board; bring up a fresh
+        # instance so later tests start from a clean console.
+        ubman.restart_uboot()
+
+        assert matched == 0, \
+            "'bootm loados' did not reject a kernel_noload image whose " \
+            'decompressed size overflows its decompression buffer'
+
+    def test_fit_kernel_noload_decomp_boundary(self, ubman, fsetup):
+        """Test that decompression succeeds exactly at the buffer limit
+
+        For a compressed 'kernel_noload' kernel, bootm_load_os() allocates a
+        decompression buffer of ALIGN(image_len * 4, SZ_1M). A kernel whose
+        decompressed size equals that buffer exactly must succeed, guarding
+        against an off-by-one rejection at the buffer limit.
+        """
+        sz_1m = 1 << 20
+
+        # 1MiB of zeros compresses to a few KB, so image_len * 4 rounds up to
+        # exactly 1MiB. Picking decomp_size = 1MiB makes the decompressed size
+        # match the buffer exactly.
+        decomp_size = sz_1m
+        kernel = fit_util.make_fname(ubman, 'test-noload-kernel-boundary.bin')
+        with open(kernel, 'wb') as fd:
+            fd.write(b'\0' * decomp_size)
+        kernel_gz = self.make_compressed(ubman, kernel)
+
+        image_len = self.filesize(kernel_gz)
+        req_size = (image_len * 4 + sz_1m - 1) // sz_1m * sz_1m
+        assert decomp_size == req_size, (
+            'Test setup error: need decomp_size (%#x) == req_size (%#x)'
+            % (decomp_size, req_size))
+
+        fit = fit_util.make_fit(ubman, fsetup['mkimage'], NOLOAD_ITS,
+                                {'kernel': kernel_gz},
+                                basename='test-noload-boundary.fit')
+        fit_addr = fsetup['fit_addr']
+
+        # Decompression at the buffer limit must succeed, returning to the
+        # prompt cleanly and never printing 'Image too large'.
+        output = ubman.run_command_list([
+            'host load hostfs 0 %x %s' % (fit_addr, fit),
+            'bootm start %x' % fit_addr,
+            'bootm loados',
+        ])
+        text = '\n'.join(output)
+        assert 'Image too large' not in text, (
+            "'bootm loados' rejected a kernel_noload image whose decompressed "
+            'size matches its buffer exactly: %s' % text)
-- 
2.43.0

