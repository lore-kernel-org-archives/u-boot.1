Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3520DCD5BA4
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 12:50:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4324C84825;
	Wed, 20 May 2026 14:49:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="q9oJCjpb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58CCA84688; Wed, 20 May 2026 06:46:29 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EAD98039B
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 06:46:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 268A73F648
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 04:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779252387;
 bh=h1ICx4JnJCXKsiNloh8o5992hDOTGDeUASzqm19tcWw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=q9oJCjpbxscntzG7L8eIACtnI4HwTOpno4yLVosaM7dFgy3elzMpvDZYE5toR7/I2
 1PYVydlc1h/PAILNsf673wHunagOOnjPjuH8wpXvVi5ja1aozoqFAGx4wl3wlFA7q2
 zKNMnco9FMaoJFrVPQX5RovW8hWOxCgKj3iVjNx8WIRD9/OaQ5VTBnQ27P0aRKOtim
 R1jpmlnARuqEQGHIcaykZIG+iuUaofFQe0+8Zf14g9aC7j2iOWtzGNVKOL1eARNhUn
 2hZj/zhCt9EDUj2psk+Wt0WG4+lggVsSNlRqYY+WGPgcmqU/VjMs38fDB3v3HEyEX7
 GUe+yIBt3Y71nymBu9CajDCqlWVlft5vFfvjfAJ1KzB6JXODaIh0Fa3u3/6IQZV3SB
 /+sokd9i6o4KZZ7ivT7za40nc75a91qhmLG2JFMSIu+GIOGTNMFhPYsJtzB/yQFyOU
 FaOFboZWxNwbAFVQYW27NF0QY/ZuRAYThBVoO2Sh5zDcFyjtSYoMMOMq7zrxBj3l0A
 VXIrh9C4nI+Oyq/wfCNRV0qagD0D2LUCdOHO/ghu3KsvdcYSsxcxWC9cUmzERLIcIS
 dHovS3Nu9v8cShWDeppNSz+Lx6/7ZAmu0yqrSujAcnMp0MQhvKCHaLEUXqnAlQM091
 O1JCRDZbCD02msV06/tfGci4=
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c8276c91addso2364929a12.2
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 21:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779252385; x=1779857185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h1ICx4JnJCXKsiNloh8o5992hDOTGDeUASzqm19tcWw=;
 b=QrjHNca4jXFGnExAUZhd807yyo81vngvp9ABwpHNDo3zHit4hombVCBti15bNQI1uu
 RayqM4LmINSUXtxBOhKZiRNyXrglMpgbMN+RTCYo5NVwxMzjxBCW/FdmuSlYLRf6lrDJ
 Zn/sdvIYRJSrTGwkI4p/FX8TcS+xdoEicHCZjqExQVflw1foGWOiwiG3Ai8KiwtsAKx/
 tIKNPF2z9tN6KAwK0IdYYhlsDjCkxrZFI7zwAQWFYmorK3kqdrN6DxMQwNFtKx2vzqG1
 T3T8BkiVJGgoAXkwyOnphBXpAMOzwhQLsgXQhcXPD654bU2hIQYDBjNUsQPDLmJYBNlN
 /TQQ==
X-Gm-Message-State: AOJu0YzD2aW4Z2ko7FxrFI8UAbhXl6dYxZAGP5QD4tSjssPLoElrpC1M
 5E8p84FYOUsaTn8zhjpVN8YKi6XGVvtz2ElaufVQU1PdfUxPMKSnrZkM12ywv/drzFFV4bFYaEq
 XE1lBvWwkamxi+2Fm8w01lUGkB7oHB/xaUo6expWoDSZnJwhfim62PCaz4RFSgrRtpHHJXrNWQn
 LmHp8=
X-Gm-Gg: Acq92OHgbm6oyw56uQ8GFVys5tb3DiUzrx6csnLn2XHoHzbjcRLjojJX+JdfEPI4rVr
 VdaG3mWEubpHRveeRcQe+2G848VtDl0uC8MCTHlaciGSYW1+I3745Wn0YSkpsd3UMJiMP0Be9S6
 KGpBqw3WHj4HI63nQZCB0d3UTT8wSSf8rwkMXtAfS2aa60mGfcF6X9xiLn0wc9olAKs0GxmAScQ
 pyWxWI1nCIgWP9ZHpSj86tFAict525JEyNvqO41d2y1qxDkEL7WoHWhwoWXq4g8TQtLme1viMpX
 ixRPDXiz6Vi4uakTvRGcxeED0TQD8BwBfhZ2c5VYwImu6IoqB7BT+2xJIll1tEhXevmpW/7iwDG
 dtnMxPBn1PEQLWLTBrzkbYFY7vqkka3A1JqXbPuWuGqPx/nMa4xsNUDLucQAo3rJ/v0aIrFIkP4
 ddmvUhhKtb28fckYxGCqcmEqZP2g==
X-Received: by 2002:a05:6a00:3005:b0:837:db9d:9606 with SMTP id
 d2e1a72fcca58-83f33d26f5cmr24012807b3a.23.1779252385070; 
 Tue, 19 May 2026 21:46:25 -0700 (PDT)
X-Received: by 2002:a05:6a00:3005:b0:837:db9d:9606 with SMTP id
 d2e1a72fcca58-83f33d26f5cmr24012785b3a.23.1779252384681; 
 Tue, 19 May 2026 21:46:24 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f1977a570sm18570304b3a.20.2026.05.19.21.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:46:23 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v1 2/2] test/py: test kernel_noload decompression buffer
 overflow
Date: Wed, 20 May 2026 04:45:51 +0000
Message-ID: <20260520044554.15373-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520044554.15373-1-aristo.chen@canonical.com>
References: <20260520044554.15373-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 20 May 2026 14:49:56 +0200
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

Add a sandbox test that builds a FIT containing a compressed
kernel_noload kernel whose uncompressed size far exceeds four times its
compressed size. bootm_load_os() sizes the decompression buffer to
ALIGN(image_len * 4, SZ_1M), so such an image must be rejected with a
decompression error rather than overflowing the buffer.

The test verifies that 'bootm loados' reports the failure instead of
decompressing past the end of the buffer.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/py/tests/test_fit.py | 84 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index 4f56a1421e1..04e10c33046 100755
--- a/test/py/tests/test_fit.py
+++ b/test/py/tests/test_fit.py
@@ -117,6 +117,36 @@ host save hostfs 0 %(loadables1_addr)x %(loadables1_out)s %(loadables1_size)x
 host save hostfs 0 %(loadables2_addr)x %(loadables2_out)s %(loadables2_size)x
 '''
 
+# A minimal ITS for a compressed 'kernel_noload' kernel. bootm allocates its
+# own decompression buffer for this image type, sized to 4x the compressed
+# length; see test_fit_kernel_noload_decomp_overflow().
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
@@ -426,3 +456,57 @@ class TestFitImage:
 
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
-- 
2.43.0

