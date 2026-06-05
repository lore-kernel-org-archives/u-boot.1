Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9635DCD6E7D
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 17:15:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4418849A9;
	Fri,  5 Jun 2026 19:15:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="HGsA8kFO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1464C84932; Fri,  5 Jun 2026 17:43:29 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 125C584974
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 17:43:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 577533F8D8
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 15:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1780674206;
 bh=N/q4d530aMiEGxJ9RIN4ETzd3otsMvmI6rbpnLfl1Z8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=HGsA8kFO4GnAErK4j3lfS1wuC8rxGOsEMFcN4PT8Zel4aT9KJYPlor9NLJtgAL0Wi
 nNqdREQS3OTeUPt/8d1AwOBAogzrSJetkdxpDqhHEI+WG7FkX54t21NywZiHExCMzm
 NvnyL1MWuY5xomZg5ZPNFMqMC1oe0DSx1BesZCLigu8hknB1sutcPr5ReYEVAF75vF
 cjjrb0oJdhqfXOhcDHqEMzGMxthbCgFJStHclka7ApsNbrR7lbrvCni8TIY/YEKwF/
 AdcBZfWAyGXZ3LdKNDiDF9gUEIPI3QPyyAXOtzZO0kSOl5p2JuV5Sv/io5rKkMFqPl
 RcgES1sP2l1sLdqV5p0Mz3zPAiOw97hlR4ydcVj+egt+1+fN9Tg78a4o6OVuCGw8I8
 AvjjDOWLJ29EJTWXgFt37nVqzgKYJXfOXod87KH+jzvsm38INnmMVSn6vZSJQvPUWq
 sEcHb2GIaOiXEd3x6xGzxH6AdazWaErnLZ9wxqEPCbF4FDBQCcYEHBY85t71tfgec6
 aCWXDrnXN4rzlR2z15xd0dZa17bc5LeaDOJ9KTx/Xa43n0qKH/YfO9uHPQIkPgOE9D
 xPSVbxqX7PHJtDsTVkdboYIah4qBDD9dRoKv8o5n12VtBn22g1nFHVRMhO3J1XNugQ
 0JH+90OPoHemXXZVPiJmh+gk=
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-36bbdcf36f0so1866929a91.0
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 08:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780674205; x=1781279005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N/q4d530aMiEGxJ9RIN4ETzd3otsMvmI6rbpnLfl1Z8=;
 b=rurr6MbRkXP0iG2K+q7WQfPWwJ2XZHg2DZvVBkyzUEg4pfbXpS7kiYrL8D87rWvT0n
 EKRZ1FkaBdYRwrVMnxEqwSXpOBZSEv+rc8XmK8UDMt25TBctpByrnfC21Kf0LfrGq2mb
 2qepilTP02aJHO8UGFMauGdVi7sFDPT06iJr8OId2M8Hd1e0LSm+GVXFBi51eNltHO9L
 aQMIJv6XXnOtgl3lnc2QBYCzzhXOFannKVleU9DIkackL/sR41TY7lB3I6Jg2G7SgNYJ
 tTKn2ogH1LJDen9BLgYq5t+auyd4qEO6v5/tznjUimvHBHGHtj2bdwBUzyJy6bp9oX+t
 7hLQ==
X-Gm-Message-State: AOJu0Yzk8KEljrGy67cnNLjzhMFfDXKXnC1oWdR3AO26zegc0/4s8XWA
 ixg91StwafRMNszR5kZyyHeDTIXO1tO/Lqd4avl9YUPe1yzuy/gGkcE9PJmmx32jBQleWJEytgj
 bOjpd0C0Ffb18XAeI96irLnyajAY24xW+40C4xArzEP9ynbMly1mPPO16K/N0N6N3Ul4jHdDkDH
 PVovI=
X-Gm-Gg: Acq92OGhBH3Nrw0WT23Tp6PeQcscLwqYyeay3wvl+arv9U7SZ7abOn4llSpiiPVIu/P
 r77MkrqOiajwt51wqlWKmUeBp1FOvwQtuviZlnXcgWYCicf3nvjtV8e12h7zdiEw1yPLWAg6v5S
 9UtW3HYiv7sTCBTYYIADNslU0JPzDYwSg4h9/UPziYlyWnjjl7sYsxodoQN23gVSY/hD10Rd+aG
 VJTjVwzFxFEnvG13/wS6T+YD6C1j1JzTnaBt7SKO3+pxO1p5v5Jdw1e62Fnf75sAbbQAQNrPWJN
 FMPqyFMpoiy/7w8zkD9OQ+JvEyu2TB+4wY4Yy4mW6+9QQwCzsZUplRLUXpg8uRwNAWivwcIbKdo
 iBED2cXstiAh6NUZlN6kd4R95vEEeMQxGLzyZa5UzM6Cv+5S+sg9SubsVtGU/kmeqa9Xs7Zt4LW
 0AL/uL
X-Received: by 2002:a17:90b:1b50:b0:36b:a162:a1be with SMTP id
 98e67ed59e1d1-3713049177fmr2688617a91.4.1780674204795; 
 Fri, 05 Jun 2026 08:43:24 -0700 (PDT)
X-Received: by 2002:a17:90b:1b50:b0:36b:a162:a1be with SMTP id
 98e67ed59e1d1-3713049177fmr2688589a91.4.1780674204286; 
 Fri, 05 Jun 2026 08:43:24 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f70a285a1sm7233531a91.9.2026.06.05.08.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 08:43:23 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 3/3] test/py: test kernel_noload decompression buffer
 overflow
Date: Fri,  5 Jun 2026 15:42:51 +0000
Message-ID: <20260605154255.833334-4-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605154255.833334-1-aristo.chen@canonical.com>
References: <20260520044554.15373-1-aristo.chen@canonical.com>
 <20260527150637.2850104-1-aristo.chen@canonical.com>
 <20260605154255.833334-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 05 Jun 2026 19:15:17 +0200
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
(ALIGN(image_len * 8, SZ_1M)).

The overflow test builds a FIT whose decompressed size far exceeds the
per-image buffer and asserts that 'bootm loados' rejects it with a
decompression error rather than overflowing.

The boundary test builds a FIT whose decompressed size equals the
per-image buffer exactly and asserts that 'bootm loados' succeeds,
guarding against an off-by-one rejection at the buffer limit.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/py/tests/test_fit.py | 125 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index 4f56a1421e1..d63fdd80528 100755
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
@@ -426,3 +456,98 @@ class TestFitImage:
 
         output = ubman.run_command_list(cmds)
         assert "can't get kernel image!" in '\n'.join(output)
+
+    @pytest.mark.buildconfigspec('gzip')
+    def test_fit_kernel_noload_decomp_overflow(self, ubman, fsetup):
+        """Test that an over-large compressed kernel_noload image is rejected
+
+        For a compressed 'kernel_noload' kernel, bootm_load_os() allocates a
+        decompression buffer of ALIGN(image_len * 8, SZ_1M) and must bound the
+        decompressor by that buffer. A kernel that decompresses to far more
+        than eight times its compressed size must therefore fail with a
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
+        # (ALIGN(image_len * 8, SZ_1M), i.e. 1MB here) ends up far smaller
+        # than the uncompressed image.
+        decomp_size = 4 * sz_1m
+        kernel = fit_util.make_fname(ubman, 'test-noload-kernel.bin')
+        with open(kernel, 'wb') as fd:
+            fd.write(b'\0' * decomp_size)
+        kernel_gz = self.make_compressed(ubman, kernel)
+
+        image_len = self.filesize(kernel_gz)
+        req_size = (image_len * 8 + sz_1m - 1) // sz_1m * sz_1m
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
+        # the buffer boundary and report 'Image too large'; it must not run
+        # past the buffer and return to the prompt.
+        ubman.run_command('bootm loados', wait_for_prompt=False)
+        try:
+            ubman.wait_for('Image too large')
+        finally:
+            # The decompression failure resets the board; bring up a fresh
+            # instance so later tests start from a clean console.
+            ubman.restart_uboot()
+
+    @pytest.mark.buildconfigspec('gzip')
+    def test_fit_kernel_noload_decomp_boundary(self, ubman, fsetup):
+        """Test that decompression succeeds exactly at the buffer limit
+
+        For a compressed 'kernel_noload' kernel, bootm_load_os() allocates a
+        decompression buffer of ALIGN(image_len * 8, SZ_1M). A kernel whose
+        decompressed size equals that buffer exactly must succeed, guarding
+        against an off-by-one rejection at the buffer limit.
+        """
+        sz_1m = 1 << 20
+
+        # 1MiB of zeros compresses to a few KB, so image_len * 8 rounds up to
+        # exactly 1MiB. Picking decomp_size = 1MiB makes the decompressed size
+        # match the buffer exactly.
+        decomp_size = sz_1m
+        kernel = fit_util.make_fname(ubman, 'test-noload-kernel-boundary.bin')
+        with open(kernel, 'wb') as fd:
+            fd.write(b'\0' * decomp_size)
+        kernel_gz = self.make_compressed(ubman, kernel)
+
+        image_len = self.filesize(kernel_gz)
+        req_size = (image_len * 8 + sz_1m - 1) // sz_1m * sz_1m
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

