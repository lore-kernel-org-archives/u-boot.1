Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF2FC5DF7D
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 13:50:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 09AEB8113C;
	Tue, 18 Aug 2026 13:50:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zg8KRrmb5YMt; Tue, 18 Aug 2026 13:50:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1DBA781138
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787061051;
	bh=hn6Wg5Y1Fkw8cIXQ8O0esyoCAv/zzWdoyfNat2E4xy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U5o4tJlub8Lh8MGDeMRZndptcrUfJlcz7eRygWv+XrsLyOyyMNIIVfYOWtcTCxkz/
	 AGeRYTkFGGlIml0RsH3BbKKjGOrXLSDCXxCQcXu6yQNbevtCUm+5VpMuUUyzMJPXU7
	 XNwc82kVtf4haHhacWZaDvyPlBXwVe2YBEYRDavqmkfSSwtm2W4DMws1ILkysXYWuO
	 quG5oak+O/75acSyYZ/JOdcxw1d5fXzylCqtvT47ig6/rifSyb9892qWKrXpY+SuoA
	 LIU1AnJIgogamfWfWbyjj8c6KMAWIOHiqiaI+ah190TxOMAwzu472wZ5J3rSJYcEUH
	 myyeLeDdnQc+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1DBA781138;
	Tue, 18 Aug 2026 13:50:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BBDA5336
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:24:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A2000608A1
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:24:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bKiSpLZrlmf9 for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 13:23:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 73BB36086B
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 73BB36086B
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=R4AKnoyx
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 73BB36086B
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:23:59 +0000 (UTC)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A31743F16D
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1787059437;
 bh=hn6Wg5Y1Fkw8cIXQ8O0esyoCAv/zzWdoyfNat2E4xy0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=R4AKnoyxb/2shn1lc7LsvbixEhW/oV1SmatscagAz4zRm5+G45GxUhZaQ5erYMXh5
 LACKTXAk+0rjV665xuS0PHnlTkDA5w6z5nufSOiFmvMbFJeZyLM89ndDNfXLKL/0EH
 yiMqIcvdMgBafAEGpDuaiFLI2J30YM/MpfFbF4uZuk9qBThOC/jyyq1uaJJsBD93/m
 BX5T/OwYASt0pxLQbk1m289xo/BCAQEemGEQATEnmxuQgLU5kdjYhva3mSf77LOHnX
 ggLE5yJWOHEjy+SfHhY9+lnhqE7A02MLTa/nggCFY3pKz6H+r4bBdYnYjaDQ36lb+o
 H+3qZRkk4nozLAn7iNPmvMIrFeSikceBkeCAwdgs9aNSAdTLiDDEPAa47jA1FEVVH4
 CJ1PJgJ1IoTqmuhLumszZtzDsmkfA2ngJeKDThRXXOM+DYw9EB0rnl6+XVJ7Uo59xD
 V9aulX+IfqpKqRo9iXMIKX+ggQZMEePXN0a7PaNcf5Ly/qk5f0gwh9/pyErgd0LtO+
 j8AV8o95uSZZA+BbPFug6+2XL4pGrp/6z/MZD4QfkP4L4SWbjn3hI9oLIi9BDvjAtg
 TYcqNNr+lffo2FEk0XsIty/bem6FXTctWwtVaOW3Jg2LxcF6u4WjQUBD41nDAO2cyW
 19rAk1otsiRRqFI96wryprPI=
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-84e4ef9a74aso8356566b3a.1
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 06:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787059436; x=1787664236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hn6Wg5Y1Fkw8cIXQ8O0esyoCAv/zzWdoyfNat2E4xy0=;
 b=QL/OlRZKVXk6WX+QgoDVmveBQaN+/Gqz6DzejwAbJsxRndn+NInbSKIp8KrH4LDNQ9
 uCFvFIXeaj1JD9DqcxCODuG6WA1ys5YBaN8Es5jKbEUGC5BfHvCLV2aT5Z2gX2V++G74
 6EW77FQhbgsNKLBXcW7e3ryHVKHHxfH4Td07z/1JsMY5ZGqk7DMkbJHgzMfE0nzUTxWH
 6uuB2OLYXTHZ1dgfadbvnbFTxtW6laoJMxY0H5F+9NfqJ6MTIRQa/1zZP4W18Kn+SI0K
 Sl+PH+1tZZJFAetMWDAM+qf7uGPiLUi8s9gdrcD8AEwl805rK6MQxxAWR9csMjba0RBX
 CrJQ==
X-Gm-Message-State: AOJu0YxdzttFqmZzwb/+YZ92Yje7XZGEBTo/Hi3aNCVvhIHRKSLuRJoJ
 0aaCREWMoiBjlKsqV2SlIaW9a69eTxtdthDlo/vyVn1WWI4ZHbKfzDlU1DYRlr3W7BkJkGhkoj9
 h517MMNUr6M66JDMIoxSpKqgaVU3KfRMZoUi4/qbF7T1dXgTloj4Z46oGGmZrkJOaMlRYblUUZr
 TVTFCzkdDwvSHFCr8KlQ==
X-Gm-Gg: AR+sD12Izr9WM54UpLu6NoG5zJgOOX3y164jtfyA/HNtT2RdGFZCgRBURf42mnUdCP4
 Ik34s7LODpGr+G9kTCDa2xTMOazDkapfgCgL4Rv+ZRoFaa+K8XsOUrNpQsNFOrJYw1ZrlxH2ziV
 RDHwbdcIYki5QODiSBfrOsOWqSLOlOriavf/0uDa5u/nnVTlTh/p7GgedTB3p4VhnbfIyt1FjHS
 +COYN8UCbdMKBs2UWAxC55U4V2to1IdqsmOdzNS4BmbdknraWNF9wQDhml6/SAR0Y62IbrQkn1P
 iIYwygDT+5c4q3gU03hoMemN0imOwUsQs9lS6iV6CpkOytQ0t+hTg/QEowFW1KjSHv1JovowDvU
 9wqWGb1BJpo05hAY+8oAR6Y3iHvi6Jz9/zcBslMLQmfv740E+
X-Received: by 2002:a05:6a00:c592:20b0:851:c2a6:172f with SMTP id
 d2e1a72fcca58-851c2a6189emr5313851b3a.7.1787059436148; 
 Tue, 18 Aug 2026 06:23:56 -0700 (PDT)
X-Received: by 2002:a05:6a00:c592:20b0:851:c2a6:172f with SMTP id
 d2e1a72fcca58-851c2a6189emr5313799b3a.7.1787059435803; 
 Tue, 18 Aug 2026 06:23:55 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b6fc0e84sm1515818b3a.43.2026.08.18.06.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 06:23:55 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, nora.schiffer@ew.tq-group.com,
 Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 4/8] test: fit: cover the kernel_noload zstd header-size
 path
Date: Tue, 18 Aug 2026 13:23:18 +0000
Message-ID: <20260818132332.324173-5-aristo.chen@canonical.com>
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

Parametrise NOLOAD_ITS on the compression field so a single template
can drive gzip, zstd, and future format tests, and update the
existing gzip callers to pass compression='gzip'.

Add test_fit_kernel_noload_decomp_zstd_hdr_sized: a 6 MiB payload
whose zstd compression ratio is past the 8x heuristic decompresses
cleanly because Frame_Content_Size is consulted. The test is guarded
by @pytest.mark.requiredtool('zstd') so it skips on hosts that do
not ship the zstd command.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/py/tests/test_fit.py | 59 +++++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index 81df84f54c9..f59010c8c35 100755
--- a/test/py/tests/test_fit.py
+++ b/test/py/tests/test_fit.py
@@ -119,8 +119,9 @@ host save hostfs 0 %(loadables2_addr)x %(loadables2_out)s %(loadables2_size)x
 
 # A minimal ITS for a compressed 'kernel_noload' kernel. bootm allocates a
 # per-image decompression buffer for this image type, sized either from the
-# gzip ISIZE trailer or as a multiple of the compressed length; see the
-# test_fit_kernel_noload_decomp_* tests.
+# compressor header (gzip ISIZE, zstd Frame_Content_Size, ...) or as a
+# multiple of the compressed length; see the test_fit_kernel_noload_decomp_*
+# tests.
 NOLOAD_ITS = '''
 /dts-v1/;
 
@@ -134,7 +135,7 @@ NOLOAD_ITS = '''
                         type = "kernel_noload";
                         arch = "sandbox";
                         os = "linux";
-                        compression = "gzip";
+                        compression = "%(compression)s";
                         load = <0>;
                         entry = <0>;
                 };
@@ -544,7 +545,7 @@ class TestFitImage:
             fd.write((256).to_bytes(4, 'little'))
 
         fit = fit_util.make_fit(ubman, fsetup['mkimage'], NOLOAD_ITS,
-                                {'kernel': kernel_gz})
+                                {'kernel': kernel_gz, 'compression': 'gzip'})
         fit_addr = fsetup['fit_addr']
 
         ubman.run_command_list([
@@ -594,7 +595,7 @@ class TestFitImage:
             'the test needs a bigger payload' % (heuristic_bound, decomp_size))
 
         fit = fit_util.make_fit(ubman, fsetup['mkimage'], NOLOAD_ITS,
-                                {'kernel': kernel_gz},
+                                {'kernel': kernel_gz, 'compression': 'gzip'},
                                 basename='test-noload-hdrsized.fit')
         fit_addr = fsetup['fit_addr']
 
@@ -610,6 +611,52 @@ class TestFitImage:
             'bootm rejected a well-compressed kernel_noload image whose '
             'ISIZE trailer records the real uncompressed size: %s' % text)
 
+    @pytest.mark.buildconfigspec('zstd')
+    @pytest.mark.requiredtool('zstd')
+    def test_fit_kernel_noload_decomp_zstd_hdr_sized(self, ubman, fsetup):
+        """A well-compressed zstd kernel_noload image fits when the frame
+        header carries Frame_Content_Size.
+
+        Same as test_fit_kernel_noload_decomp_gzip_hdr_sized but for zstd.
+        The default zstd encoder embeds Frame_Content_Size for a
+        single-segment frame, so bootm can read it and size the buffer
+        accordingly.
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
     @pytest.mark.buildconfigspec('gzip')
     def test_fit_kernel_noload_decomp_gzip_boundary(self, ubman, fsetup):
         """Test that decompression succeeds exactly at the buffer limit
@@ -637,7 +684,7 @@ class TestFitImage:
             % (decomp_size, req_size))
 
         fit = fit_util.make_fit(ubman, fsetup['mkimage'], NOLOAD_ITS,
-                                {'kernel': kernel_gz},
+                                {'kernel': kernel_gz, 'compression': 'gzip'},
                                 basename='test-noload-boundary.fit')
         fit_addr = fsetup['fit_addr']
 
-- 
2.43.0

