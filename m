Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C55DC5DF7D
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 13:51:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3DE4A81113;
	Tue, 18 Aug 2026 13:51:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XaDsVokxajje; Tue, 18 Aug 2026 13:50:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 329D68117E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787061059;
	bh=EH2yeaIJE6z+RQJNKVxOmbEQDOMLXIyGl87/rZG2iuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SidUUNgKBUOfA2pAbkHd5BtZxVGIidR6Ls6OBWQVgPE4rl+3eZpTRRfqmp7NZwmcW
	 SFhjbiCsqfgL3XytFEdk8ZXbKV+m/QTDdfdviW512RYkKGnixOIvf2+vN07w/KnPJU
	 Ev6QToIvGVgdULA24l4G53RFdSgicl+kZBfSBv8gkkGpYdhxOF4zA+F8+QzY1oncTU
	 91GHFcYmjoHz6NVgftDSQ50cTw0IShYe4wcvV70iGCXcLEx0TRWOGdOEfvBlkQ30KD
	 LlCqY90BwDRSbZBSb18SlMtC61TuNyLuMb3rU2rgavqf3v7wLCXOEdVuSJkg2Q20lJ
	 kWZS9e3m8rsCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 329D68117E;
	Tue, 18 Aug 2026 13:50:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 65A37237
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:24:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 57C1A6086B
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:24:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BbpUoZzzdSya for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 13:24:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4570D605DB
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4570D605DB
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=s3XqKy6m
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4570D605DB
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:24:10 +0000 (UTC)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 996203F82D
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1787059448;
 bh=EH2yeaIJE6z+RQJNKVxOmbEQDOMLXIyGl87/rZG2iuw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=s3XqKy6mPRc0CNDHFZHP/aygC54AZ/E3gt2vl07M/6wipAGHheWXncqu0xW1YMdF5
 EixWced1liI3kNnKOzk6nEMZ9biHbQyxMz/hEb0yq//8WTGcm3zf8qLOzPPK7ehDVy
 /5XdjVC2l38W/k7pSqf6JFO/zKQ3CAFJx6I3Y08yG3PINRCqzY+DNZbUOZNVxIeGCD
 39s9f+Aod3lr/M7ntztQqXRK19xcoWk2BiWrAmWpyy0wamSotA+0FS5zqyFtIjzCb5
 JBEBBhG1z1nPYpp3Sen/+jOve10IEpZ7STM45WsrWoa8ecvga8VNjyUX+N8bMu79fq
 F0KiE+Boi4xRr981EUKuXBdzaLNFBfrDiGPqNMC4JDmf7znzQ+qV+1Yso89R9dF1tq
 h2dNFffh2iKmCx6q+BrjXu7AaepGmJqw6lklvR6RQO6ucPbz56fTxneKI85GYaOf++
 /LUm5nV8BDWNqT4PzIkhjgh9qbF4LE6itDKoLN3IdzZei6Cs5PnEP1cxO0d4CDPL9d
 C8IfPv8pyAP1PoxB7XLE62U17C+hPrmCQ8gZ/HU64s4O/BroSUuzo2nPhtM+Wic5oe
 LWPKF7cktca0aWchc+F/TKq72Zgrb/xjfrjAnj7IfMz30W5NVIx/04w5CVGmsAcZPB
 gIJd/ibVUAP8Uw/g676DOuNo=
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-84e048a801dso6249934b3a.3
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 06:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787059447; x=1787664247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EH2yeaIJE6z+RQJNKVxOmbEQDOMLXIyGl87/rZG2iuw=;
 b=Fy/Cd9RM/3m0TvLRwoitA0qlT6hWGJsoNErshmca0bFjUEKmt8pC/1kaxPqcKQXchj
 zuKU8dB63Z1LX2kYKl/Kl6PE55ztnvm7oeI7vVYVSCZxbsMHO0+U8S8ckEM+bcITy9Bd
 W+7nv3Zd7qAl0xaJzQnVZupGq7pPcQlzZJlDjTxHkBtj/AUyWBOiy7GAx97GKi+anfhi
 Ijjrpn17t6wTa45uRVHPpRCTbXqxlY9qOm5BW0OcNTAjiYv/JGl7mAVv6phpJXKhKUhr
 9U64Q9LSzpBPfnRgD3hE93T2NVuTdbUT7vV/Im14gZE1HVfj+4V6SRqXgMUt1lETck1n
 0Jvg==
X-Gm-Message-State: AOJu0YzHzWK1Lti95mAdsHmsMnXY+N9J3ewlctmNcLNLRR11PVJm0i2f
 lv/8trGSJryaYcxXpkmtSwpeIO4t11nHlqLJa5nxBzTBZ+cXOmMRAG36flN2oUufpCAqrqySq8C
 bqWMcnGkKwsD01R6qCXwCHDYQ74Bg3N69vxIJNiwhMaMLJu50RY348uZ+5XfMUf+R1FVQYvlFaR
 8QJ/b0bqRUd2kartVDQw==
X-Gm-Gg: AR+sD10KC2cqidh+rqoh8AHe8OaHfOIopmysj/nraUO54toO1ZCpEZzME36GcupKyFw
 ucGIIxttXASbSOXsRP89vBJyjkAMRCJpIEFbHqtXgt0isDqAkIB/zQvMXIuQyQdKc3uhLg/HTLE
 1Gqzm2teKvS1rdb1kQCN6XNvvb2CjqzCXZG5UBjFo8xl0F/fxmuLiV6t+fYqu/XmTtc9T+MlAd3
 vbJx23aew2mO00su3MFYRnR4QRLqb2s3PFpiuFzybaL4P5BWGsR7z7ZGZzX1hgPV19Eb0vjlGp1
 wSwDzbw1lvNx783UMgmdSGrJgkjJm2ix2HY9Z1WjIeBJsLtN9ePZ0Upia4VsSkFikGExYrMvNZ6
 VZJZ/nhMA+dZHOYozNFAtNrNORQMAoNcOFtMFdNcvY5DugcVq
X-Received: by 2002:a05:6a00:2e20:b0:83e:b443:965e with SMTP id
 d2e1a72fcca58-84fddfa8bddmr34313149b3a.3.1787059447083; 
 Tue, 18 Aug 2026 06:24:07 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e20:b0:83e:b443:965e with SMTP id
 d2e1a72fcca58-84fddfa8bddmr34313073b3a.3.1787059446604; 
 Tue, 18 Aug 2026 06:24:06 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b6fc0e84sm1515818b3a.43.2026.08.18.06.24.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 06:24:06 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, nora.schiffer@ew.tq-group.com,
 Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 8/8] test: fit: cover the kernel_noload lzma header-size
 and unknown-size paths
Date: Tue, 18 Aug 2026 13:23:22 +0000
Message-ID: <20260818132332.324173-9-aristo.chen@canonical.com>
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

Exercise bootm_lzma_uncompressed_size() end-to-end on sandbox:

- test_fit_kernel_noload_decomp_lzma_hdr_sized boots a 6 MiB
  kernel_noload payload that lzma compresses far past the 8x fallback
  heuristic, so the boot only succeeds when bootm sizes the buffer
  from the header's uncompressed-size field. Streaming encoders write
  the "unknown" marker into that field, so the test compresses with
  Python's lzma module and patches the real size into the fixed
  8-byte field, matching what LZMA SDK style encoders record.

- test_fit_kernel_noload_decomp_lzma_unknown_size leaves the marker in
  place and checks that bootm falls back to the 8x heuristic buffer
  and still boots the image.

No external tool is required: Python's lzma module is part of the
standard library.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/py/tests/test_fit.py | 98 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index 42edddb0600..0edf875a9e1 100755
--- a/test/py/tests/test_fit.py
+++ b/test/py/tests/test_fit.py
@@ -704,6 +704,104 @@ class TestFitImage:
             'bootm rejected a well-compressed zstd kernel_noload image whose '
             'frame header records the real content size: %s' % text)
 
+    @pytest.mark.buildconfigspec('lzma')
+    def test_fit_kernel_noload_decomp_lzma_hdr_sized(self, ubman, fsetup):
+        """A well-compressed lzma kernel_noload image fits when the header
+        records the real uncompressed size.
+
+        Same as test_fit_kernel_noload_decomp_gzip_hdr_sized but for lzma.
+        Streaming encoders write the "unknown" marker into the .lzma-alone
+        size field, so compress with Python's lzma module and patch the
+        real size into the fixed 8-byte header field, the way LZMA SDK
+        style encoders record it.
+        """
+        lzma = pytest.importorskip('lzma')
+        sz_1m = 1 << 20
+        bootm_len = int(ubman.config.buildconfig['config_sys_bootm_len'], 0)
+
+        decomp_size = 6 * sz_1m
+        assert decomp_size <= bootm_len, (
+            'Test setup error: decomp_size (%#x) must be <= '
+            'CONFIG_SYS_BOOTM_LEN (%#x)' % (decomp_size, bootm_len))
+        kernel = fit_util.make_fname(ubman, 'test-noload-kernel-lzma.bin')
+        with open(kernel, 'wb') as fd:
+            fd.write(b'\0' * decomp_size)
+        filters = [{'id': lzma.FILTER_LZMA1, 'preset': 6,
+                    'dict_size': 1 << 20}]
+        blob = lzma.compress(self.read_file(kernel),
+                             format=lzma.FORMAT_ALONE, filters=filters)
+        assert blob[5:13] == b'\xff' * 8, (
+            'Test setup error: expected the streaming encoder to write the '
+            '"unknown" size marker')
+        blob = blob[:5] + decomp_size.to_bytes(8, 'little') + blob[13:]
+        kernel_lzma = kernel + '.lzma'
+        with open(kernel_lzma, 'wb') as fd:
+            fd.write(blob)
+
+        image_len = self.filesize(kernel_lzma)
+        heuristic_bound = (image_len * 8 + sz_1m - 1) // sz_1m * sz_1m
+        assert heuristic_bound < decomp_size, (
+            'Test setup error: 8x heuristic bound (%#x) must be < uncompressed '
+            'size (%#x); if this fires, lzma got less effective and the test '
+            'needs a bigger payload' % (heuristic_bound, decomp_size))
+
+        fit = fit_util.make_fit(ubman, fsetup['mkimage'], NOLOAD_ITS,
+                                {'kernel': kernel_lzma, 'compression': 'lzma'},
+                                basename='test-noload-lzma-hdrsized.fit')
+        fit_addr = fsetup['fit_addr']
+
+        output = ubman.run_command_list([
+            'host load hostfs 0 %x %s' % (fit_addr, fit),
+            'bootm start %x' % fit_addr,
+            'bootm loados',
+        ])
+        text = '\n'.join(output)
+        assert 'Image too large' not in text, (
+            'bootm rejected a well-compressed lzma kernel_noload image whose '
+            'header records the real uncompressed size: %s' % text)
+
+    @pytest.mark.buildconfigspec('lzma')
+    def test_fit_kernel_noload_decomp_lzma_unknown_size(self, ubman, fsetup):
+        """An lzma stream with the "unknown" size marker falls back cleanly
+
+        Streaming encoders write 0xff..ff into the .lzma-alone size field.
+        bootm must fall back to the 8x heuristic buffer and still boot the
+        image.
+        """
+        lzma = pytest.importorskip('lzma')
+        sz_1m = 1 << 20
+
+        # Incompressible data keeps the real size well inside the 8x
+        # fallback buffer.
+        payload = os.urandom(sz_1m)
+        kernel = fit_util.make_fname(ubman, 'test-noload-kernel-lzma-unk.bin')
+        filters = [{'id': lzma.FILTER_LZMA1, 'preset': 6,
+                    'dict_size': 1 << 20}]
+        blob = lzma.compress(payload, format=lzma.FORMAT_ALONE,
+                             filters=filters)
+        assert blob[5:13] == b'\xff' * 8, (
+            'Test setup error: expected the streaming encoder to write the '
+            '"unknown" size marker')
+        kernel_lzma = kernel + '.lzma'
+        with open(kernel_lzma, 'wb') as fd:
+            fd.write(blob)
+
+        fit = fit_util.make_fit(ubman, fsetup['mkimage'], NOLOAD_ITS,
+                                {'kernel': kernel_lzma, 'compression': 'lzma'},
+                                basename='test-noload-lzma-unk.fit')
+        fit_addr = fsetup['fit_addr']
+
+        output = ubman.run_command_list([
+            'host load hostfs 0 %x %s' % (fit_addr, fit),
+            'bootm start %x' % fit_addr,
+            'bootm loados',
+        ])
+        text = '\n'.join(output)
+        assert 'Image too large' not in text, (
+            'bootm rejected an lzma kernel_noload image carrying the '
+            '"unknown" size marker; the 8x fallback should have covered '
+            'it: %s' % text)
+
     @pytest.mark.buildconfigspec('gzip')
     def test_fit_kernel_noload_decomp_gzip_boundary(self, ubman, fsetup):
         """Test that decompression succeeds exactly at the buffer limit
-- 
2.43.0

