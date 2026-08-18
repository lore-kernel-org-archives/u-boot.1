Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42222C5DF7E
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 13:50:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 07397408BE;
	Tue, 18 Aug 2026 13:50:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dF8MCLHupH8c; Tue, 18 Aug 2026 13:50:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 14726408BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787061056;
	bh=5VK2Fia5jNg66B+u/9UU+u5a30QkkXOl6B3wxqExfWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lYODJGxoc3qArNb1j/99qdZ6Z2szvDpfzIdI6vehcO84AWoNA+Axo8niX53zgpEfy
	 WGsMAnGJf7UOx5s/m1i7ewEqqfgl10Yv9Zy6BvPz0WlKc1+ZN6pxnB1SKdI7wdmnid
	 h/DF/oBQxXb3CwoHVwiFsKgv0ACmaKhW3ZtemDI941WDcZxiJphNyLcg+9mLKmH5pn
	 h/t4AbOqXuu2NQJwxI40dDJJyTjcdtf5J9DT7dU1Alur29gzavPUgGFWpH0gbGAmzy
	 E2/JI/jZJx8T0Ps43sHAL8KJlkp5Yv6gfhFS2zMp2MSFKlT/msZWufXBNxT7/eL928
	 rB/VEm6Q1M4Tw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14726408BC;
	Tue, 18 Aug 2026 13:50:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 47684237
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:24:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2CBEC40159
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:24:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lgAuABeaAuhS for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 13:24:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2C152400EC
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2C152400EC
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=HJlXb6nZ
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2C152400EC
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:24:04 +0000 (UTC)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A86343F8AE
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 13:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1787059442;
 bh=5VK2Fia5jNg66B+u/9UU+u5a30QkkXOl6B3wxqExfWY=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=HJlXb6nZ64Uf1pbk1qntqMs7XPBp9dtPBKU3eq/XfMslGDhXcb2Np3vMP7RvisIL3
 H2QHhQACc7C6ICW11myZBBKj1MNRPXxeWSFZJkQkyCL1F9k19dCEabxcxD75JmX2uY
 ivPHPRQq4WFJ1JDw7MNAWtBe39zZ/fTLth+kpwq35MPc3s8u3QKuN7/ncs1eKW6K+P
 QWejoenorJlESZlWyoLI3l1duWLkoItAHJPlenoF702Znz53oba8mCpP2OditeD2Qn
 GVJYE+DhGu2tv6QewD0R3J23ZoU/4fTroYyaqagV36jUL9GSUr1X7m6/J2wXDr96nC
 84SzwMYjxzXv/GNx06ZQ9OTnG3AnUsXxIVjeGZzLrI3DnfR5oUCbJmYA9Bf6eh7Nqq
 44apTOXPCmztQI97+Syke76eLjUcBrvlG4E8/+htOosNpXl864iWFnu9jLyZoSvcib
 kDCP8O0t07IYLmbin1zDm2E1aWONtS/OfNAppd2YeRkJz4BlJPFMIywMTyfbcJ69CZ
 qQxHt37KsrRL/IR3pySUScLHtw5TGyKXjRPC1QIlBEX3gtPS3YYX4bvIBdldMKlglv
 0VnVEz3FnIhkYAL6EghrLeucbtZ6Hrny8EjSCqEqaGVcitOhWtkJ+ObJ9qVsvlVqSn
 59d6qb5JAou7Yveo+Dsq0jTY=
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-84e024d2129so7868587b3a.2
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 06:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787059441; x=1787664241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5VK2Fia5jNg66B+u/9UU+u5a30QkkXOl6B3wxqExfWY=;
 b=o+Z1zJN0WsBGLR1TYtxJekKhxBOa1Fxj3WbQ36GfIfV6/rSo4MLAh88c9nCGYBO59u
 sjopbeB5bVVp6LrEGhvAJ6H6SQzv+fEh8NWnb3uUrOaL0IZHyQBtWNrK2skH3V/eudlm
 7oXEpS59i2jSrGrnrRP7YfX+Y2b89Zmw8c5RsnR9ixQQDIR7DzNh0wIOLy1rUHM+RRJg
 F0onfKoTY9lZ+1u147Kfu/KVdSsSXCe/SRW7qedwANursaWbfXtCC3G3HT9XDGed7CuZ
 zQkSTMfWmO4zLSyx69q601QP0veDPL1TgQNauGQ61I6boW5YL9iOvl9b/Zfk/BHctNsP
 FVuA==
X-Gm-Message-State: AOJu0YyWFDxN95fj08XKgI8ULVM+2gPin/D3NqB4J4xraMJPIAX2lea+
 5c1q236nrBxtgn+k4BGAoLfY831Hug619RlFd4KajaWVgAL6/IJQvkV2ANChtYnKJaCLDgcffq0
 fQPYqPeqflxqJufWOw8Zkt+OSRkYcECNdz88jxHs5VpzKdMABX+kQ7zCt1gLl3wOqzV0A+AhwcR
 7G327w5NNgGru7Hh2A4g==
X-Gm-Gg: AR+sD12DKu9IVw/kDp4xBl5ufUINLemCWd7MS5SGNXWCq6ICIHesXZRgLvpqNTRBQ36
 ho3UKheMiNiJxwRkg4T9GBRFrUZJL4VM4ZrZtlkom/brHuLoy9DKOrT5RbGgtNFaQdOSDUs2CCX
 ip0P4AccutcLO8vPbXtJ44l9lQJ3NE4QnjFS9ti+gfKxJ+8VZaioIcFDQk4ZhAvNc9bvIcVy0b5
 6bOnO8OWD8wBfygkMzW2lRBo78VnuYgEUs9hp8+L2V+n1SpmG6rp4Jyb5Ml7WFc8fFHBqOtL9r/
 GTDV83cbtORbRuYDCjnm/mQwu/AutqmazxMZk2jRDujMJbnZSXFC73SLSYCUMEKcwP312YMtEm3
 beDUauSQirSSre2Zjanp+ivpcZGiyPABimPnXHisDLrzPIfOR
X-Received: by 2002:a05:6a00:4ac3:b0:82f:50cd:e586 with SMTP id
 d2e1a72fcca58-84fde001affmr39420160b3a.13.1787059441129; 
 Tue, 18 Aug 2026 06:24:01 -0700 (PDT)
X-Received: by 2002:a05:6a00:4ac3:b0:82f:50cd:e586 with SMTP id
 d2e1a72fcca58-84fde001affmr39420072b3a.13.1787059440728; 
 Tue, 18 Aug 2026 06:24:00 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b6fc0e84sm1515818b3a.43.2026.08.18.06.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 06:24:00 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, nora.schiffer@ew.tq-group.com,
 Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 6/8] test: fit: cover the kernel_noload lz4 header-size path
Date: Tue, 18 Aug 2026 13:23:20 +0000
Message-ID: <20260818132332.324173-7-aristo.chen@canonical.com>
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

Add test_fit_kernel_noload_decomp_lz4_hdr_sized: a 6 MiB payload
whose lz4 compression ratio is past the 8x heuristic decompresses
cleanly because Content_Size is consulted. The tool must be invoked
with --content-size so the frame's FLG bit is set. The test is
guarded by @pytest.mark.requiredtool('lz4') so it skips on hosts
that do not ship the lz4 command.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/py/tests/test_fit.py | 47 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index f59010c8c35..42edddb0600 100755
--- a/test/py/tests/test_fit.py
+++ b/test/py/tests/test_fit.py
@@ -611,6 +611,53 @@ class TestFitImage:
             'bootm rejected a well-compressed kernel_noload image whose '
             'ISIZE trailer records the real uncompressed size: %s' % text)
 
+    @pytest.mark.buildconfigspec('lz4')
+    @pytest.mark.requiredtool('lz4')
+    def test_fit_kernel_noload_decomp_lz4_hdr_sized(self, ubman, fsetup):
+        """A well-compressed lz4 kernel_noload image fits when the frame
+        header carries the content size.
+
+        Same as test_fit_kernel_noload_decomp_gzip_hdr_sized but for lz4:
+        the tool must be invoked with --content-size so the frame's FLG
+        bit is set and bootm can read the size instead of falling back to
+        the 8x heuristic.
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
     @pytest.mark.buildconfigspec('zstd')
     @pytest.mark.requiredtool('zstd')
     def test_fit_kernel_noload_decomp_zstd_hdr_sized(self, ubman, fsetup):
-- 
2.43.0

