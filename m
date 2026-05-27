Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86412CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 16:27:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACB44848B9;
	Wed, 27 May 2026 18:27:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="bMAiM4Pv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 357D784837; Wed, 27 May 2026 17:07:01 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 369BF844CF
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 17:06:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DFAA93F971
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 15:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779894418;
 bh=k+CJWGWixrXiqnVUEXIvw7bpJcXVfh+o+Nf4zlzg9XM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=bMAiM4PvLOl6/C/etiWRiQFOEHrJe2XyeYHzkmYBEeyoDoS2errlGWcD4PNlij08q
 ZG9U8bHFPN2tXv91lrPjJ74pPavbyGV7u57zSMGnbiBTil9W0QQejnRBLCXCZeWaf/
 SO3hK110mRcPqN4e/zm1+sA1I+FjbTiULHc0D1icIadbUfQVfrcliBQOfH1eL1cgBC
 1+j0Zj/FPIOjWcHb2yriLNOUYYPXJJfm8CQf6GH3A62BSAf5yzNEJ+LPmoyX1jKJpZ
 rS9qChhdRGsAH7bYVOPgJvx8/IrGcdX72oqQYK/WU6bo7e4VCDMSvejg01IfrSW/d5
 jwU0bvheRHbRps/uIjYNXthNNpkE+gag1sniBcbPO/Y4HcB3jxCe9uuQdsjiviz+k8
 ty7Z6q3rYkuvWaz0SQQj2Z921EGX/RLEgIuCPCF9i/yYinGoSqLHjJd5nGIZ1LS0HK
 iCig33tgbVTwt9cmGrz5BXKwJY1az3ayXIjdaqHXvp8MIhCyZR1+SYXgVfGTgbV3Jq
 75ifJTgQfaBKvgmVauIthSgGFGcYElHbvbwSbBC942HE94yZYUgYD1FA/AnuM3UHvO
 lfLTyRgnwFtbJU36tSWalsKz51q3TwCopksu8+OZtE0tuHpmho+kVNAauAGvK5bDNf
 0M6Hhenb8gVHVK1FkD2TRpeo=
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-36603ad6709so10018703a91.2
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 08:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779894417; x=1780499217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k+CJWGWixrXiqnVUEXIvw7bpJcXVfh+o+Nf4zlzg9XM=;
 b=tWzU/kEbdt4l2ykk+41TzQl/oOv2wZGtMoTP4I0t87zSqUEz64+ugtbVznhy3yT7gD
 JbIg4BotUH/14kywZyEwzjS9FaVMRwm5AlM7sZKPusoLBdAgz0w2sel1jTJQo99dwCyb
 wJ6CgPJpF/AkR5WY3HnY8yTw9+U0p21+6RhkgWskWnFdcUWYzY15+iASK79bG+FqsrXv
 3zrzL83HWhQACQBQFPMCVkxnDitPWlNdhN+wC9CwP1wOdcRNF+RgrsjCB801IDqCuEml
 WoqeMG4LD1Z5aCCaejJ5t+DyGHlFWB4riN2KfacoLPl74HGfta1PTilEUIfx/ZRsvuih
 7hqA==
X-Gm-Message-State: AOJu0YzEP1obG9ysYUEFa4jmUw2NrucWdEQptWrL2fdTkBPVlhzGOXWG
 ESQlzA6zIw6qGK1ta0hyRN/QEIVfZyNp0UcYI1DL4gxrqq5tRlDUT6JyvZWjFq2y/GzBXXeZjbE
 wcg6WaPXqUtSN2CdHuOZ6sXgRMz5uM9gBVvYAGnDelHvxA/1wLJLZ6qIo2e9kv7GRYQb+pX1Wij
 CAWP87dg==
X-Gm-Gg: Acq92OGWr8aSwUPJh3NGs0/XMQKVuV888KEp31LCl8CuXKiUyMiJEd3ELHYphUm72+u
 4fog5gOEGsom5vCXxKzSMoqKqykCbXDZg7epJgk0V17G2AEvEh1QGRwd/YYbDFFJTerQQ9gvcwI
 8y1+6FhqSEUrzWuG/rh3hOMa8/k/jeQ22bbiCS+aa/TUxIHZvEhYU9EeQiOfK0EvHXaWIW5DjxS
 WS2L4M+HNhJAgTxdp4SCwUWhsExOWXo+c/BtYldvNgbMB+541AvSH65G473jhLECdDpgEjMWDoP
 +foPfJYnBWp9QAfjrHR6MRorfwq5Ss6oRna1dplq7zpBeENPYwD028f+if/PIWGXGctbP5T0FD3
 Sre2Y0FZVGSRerQB0rxJMFDVq9TGb8UQNEjc0L1HlxE2gMzqi0unyMS3YAoLdlEaShtUWM5m79b
 c3dmlFE8E=
X-Received: by 2002:a17:90b:198c:b0:36a:9f69:6df3 with SMTP id
 98e67ed59e1d1-36a9f69ca06mr11571521a91.24.1779894417420; 
 Wed, 27 May 2026 08:06:57 -0700 (PDT)
X-Received: by 2002:a17:90b:198c:b0:36a:9f69:6df3 with SMTP id
 98e67ed59e1d1-36a9f69ca06mr11571498a91.24.1779894416968; 
 Wed, 27 May 2026 08:06:56 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36b73ce986dsm282702a91.6.2026.05.27.08.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 08:06:56 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Benjamin ROBIN <dev@benjarobin.fr>,
 Ludwig Nussel <ludwig.nussel@siemens.com>
Subject: [PATCH v2 3/3] bootm: increase kernel_noload decompression headroom
 from 4x to 8x
Date: Wed, 27 May 2026 15:04:35 +0000
Message-ID: <20260527150637.2850104-4-aristo.chen@canonical.com>
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

For a compressed kernel_noload image, bootm_load_os() allocates a buffer
of ALIGN(image_len * 4, SZ_1M). The 4x factor is at the edge of what
modern compressors (zstd, xz) achieve on real kernels, so a
well-compressed vendor kernel can fail to boot at runtime with no
intervening warning.

Bump the headroom to 8x. The buffer is still bounded by the compressed
image size, and the SZ_1M alignment keeps the overhead below 1 MiB on
small kernels. Update the matching references in the kernel_noload
sandbox tests so they stay in sync with the bound bootm_load_os()
enforces.

Suggested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/bootm.c              |  6 +++---
 test/py/tests/test_fit.py | 14 +++++++-------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index f9b81bbf794..1d8bd30217f 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -619,14 +619,14 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 	/*
 	 * For a "noload" compressed kernel we need to allocate a buffer large
 	 * enough to decompress in to and use that as the load address now.
-	 * Assume that the kernel compression is at most a factor of 4 since
-	 * zstd almost achieves that.
+	 * Allow up to 8x compression: this comfortably covers what zstd and xz
+	 * achieve on real kernels, with headroom for well-compressed payloads.
 	 * Use an alignment of 2MB since this might help arm64
 	 */
 	if (os.type == IH_TYPE_KERNEL_NOLOAD && os.comp != IH_COMP_NONE) {
 		phys_addr_t addr;
 
-		decomp_len = ALIGN(image_len * 4, SZ_1M);
+		decomp_len = ALIGN(image_len * 8, SZ_1M);
 		err = lmb_alloc_mem(LMB_MEM_ALLOC_ANY, SZ_2M, &addr,
 				    decomp_len, LMB_NONE);
 		if (err)
diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index 560b7513e67..deffadc8b3e 100755
--- a/test/py/tests/test_fit.py
+++ b/test/py/tests/test_fit.py
@@ -461,9 +461,9 @@ class TestFitImage:
         """Test that an over-large compressed kernel_noload image is rejected
 
         For a compressed 'kernel_noload' kernel, bootm_load_os() allocates a
-        decompression buffer of ALIGN(image_len * 4, SZ_1M) and must bound the
+        decompression buffer of ALIGN(image_len * 8, SZ_1M) and must bound the
         decompressor by that buffer. A kernel that decompresses to far more
-        than four times its compressed size must therefore fail with a
+        than eight times its compressed size must therefore fail with a
         decompression error instead of overflowing the buffer.
         """
         sz_1m = 1 << 20
@@ -474,7 +474,7 @@ class TestFitImage:
         bootm_len = int(ubman.config.buildconfig['config_sys_bootm_len'], 0)
 
         # 4MB of zeros compresses to a few KB, so the decompression buffer
-        # (ALIGN(image_len * 4, SZ_1M), i.e. 1MB here) ends up far smaller
+        # (ALIGN(image_len * 8, SZ_1M), i.e. 1MB here) ends up far smaller
         # than the uncompressed image.
         decomp_size = 4 * sz_1m
         kernel = fit_util.make_fname(ubman, 'test-noload-kernel.bin')
@@ -483,7 +483,7 @@ class TestFitImage:
         kernel_gz = self.make_compressed(ubman, kernel)
 
         image_len = self.filesize(kernel_gz)
-        req_size = (image_len * 4 + sz_1m - 1) // sz_1m * sz_1m
+        req_size = (image_len * 8 + sz_1m - 1) // sz_1m * sz_1m
         assert req_size < decomp_size <= bootm_len, (
             'Test setup error: need decomp buffer (%#x) < image (%#x) <= '
             'CONFIG_SYS_BOOTM_LEN (%#x)' % (req_size, decomp_size, bootm_len))
@@ -515,13 +515,13 @@ class TestFitImage:
         """Test that decompression succeeds exactly at the buffer limit
 
         For a compressed 'kernel_noload' kernel, bootm_load_os() allocates a
-        decompression buffer of ALIGN(image_len * 4, SZ_1M). A kernel whose
+        decompression buffer of ALIGN(image_len * 8, SZ_1M). A kernel whose
         decompressed size equals that buffer exactly must succeed, guarding
         against an off-by-one rejection at the buffer limit.
         """
         sz_1m = 1 << 20
 
-        # 1MiB of zeros compresses to a few KB, so image_len * 4 rounds up to
+        # 1MiB of zeros compresses to a few KB, so image_len * 8 rounds up to
         # exactly 1MiB. Picking decomp_size = 1MiB makes the decompressed size
         # match the buffer exactly.
         decomp_size = sz_1m
@@ -531,7 +531,7 @@ class TestFitImage:
         kernel_gz = self.make_compressed(ubman, kernel)
 
         image_len = self.filesize(kernel_gz)
-        req_size = (image_len * 4 + sz_1m - 1) // sz_1m * sz_1m
+        req_size = (image_len * 8 + sz_1m - 1) // sz_1m * sz_1m
         assert decomp_size == req_size, (
             'Test setup error: need decomp_size (%#x) == req_size (%#x)'
             % (decomp_size, req_size))
-- 
2.43.0

