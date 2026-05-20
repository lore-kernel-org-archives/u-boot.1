Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A11ECD4F54
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 12:49:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF858847E1;
	Wed, 20 May 2026 14:49:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="jdVaxAoW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC6048469D; Wed, 20 May 2026 06:46:22 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC8E98039B
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 06:46:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6E8813F1C0
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 04:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779252380;
 bh=gRJ5wgVUIT7yCodi+J3OViQknhIvfg8ysRIdwZlUPKs=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=jdVaxAoW+SPG5bEHDmO67su+3vczZlfG9zvAQZ7Su2NdhGXRkHeJYBn6UMn07zANk
 xhVey4+GMRy7ZvkbCnsg5mRbVCsgKV12p7A8uEbLfvkGyBEoMEgM3I1gv2A19h6Etf
 y04fl+SPa5VUmG+l1BAQSRX4Sf1DYnCLbPPdT4bS066Mj/3YN33cBL2Gq+2D5D2iMx
 QG0bKReSTKFn8qchAXhW9dB277gc3g20c9biYfHkj5frLWDmZMFAjjGsTs9LBwclkT
 QpkZDfK82gomjgQadL1FR20uSq0fXK/brmuD4psu5Gfsx8YZa/dvPf6eIEVPstWVGq
 90LzImdUe0jGmqtUA9jY9pWdM3EN5h4rd5VSwK3i2qswX77s7vEmCeTqS7Fa/u4W7D
 pyaWhwVwxWj82k+tJUqhCG2Qr2TCvZJLHVpdWfAvA4KXFob0khAXmcOtuV5XFtrIdQ
 ilWllN1+Sdmp/HbsRdGFQtYc5RR7T4nNIWivSK2CNp8P+Laiari5i9fDekFXXh1TMt
 JyHhbylANNmhJadNPTRbkuF4gE4w6lb0ZzUlOjhmFKFRDJxfqfeL835Mo2ogUClD1s
 xUqJlZg9UrlcT4pLObvSE75LEqQpx/2obb2pc8Dz8ItaLKsxLyLP3lx0qHxRuedVZs
 gs6NnPmow5DMghvFbfOUgJbI=
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-368edd5fec4so4895897a91.0
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 21:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779252379; x=1779857179;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gRJ5wgVUIT7yCodi+J3OViQknhIvfg8ysRIdwZlUPKs=;
 b=pXCSISWWuArUIUudETy2K84D8Y+9aBvdfQjU+uFryuraOI/vysbc803t0I9QydtPM5
 EMtNWVuQ2WdMtwDm6qUupHdv6sSMYJEzovWYvWDgGuVrEnLR8UXV4HDTKL2U+h+dOoiz
 wDbVlL30igxWCa8TNJZElz88Q6dO+boVM4aYAA0OvRPcRk8v6vtXrLNrmMytB97cHL1n
 KRwnY7bMQC7kQU1T4DbuA6EUhTFA7mQFCdXQ39N3JIVAsSKnhCbEYF23pl8dnR6YoeUr
 Rl8b13PGtfXTfe6dHhddNLRn09bLpG/pPCxDz9cspy+06D58OMNgMSZvEm5fajYlCol1
 ZNvw==
X-Gm-Message-State: AOJu0Yx9U7dvpTgs6mSL4vUFvuGD7qWIMJhWJUBurzpYxkxulHHYVTCs
 TSL2I5mqbqbIccMNe9nZPHk3wtMuenkBlJHkwIp+T5cSFI/QGB94O71uNmDFaR3o2EDkh1CrlC6
 1Md0Loz5T6vzqjynegGreZ8q7BdBdvQnrJG849r7QJUigfaTj0QwvqhjXvp+ZnThG5UQIFfJDfj
 SgIzs=
X-Gm-Gg: Acq92OH3r7F1hXo37P547TLz7bMm+Ll069NThJ864mpsU+hv+S+G30IiBlga3i2MRbn
 Ed3iYVZtVeYc2Et71vUlIs+fAH4RHuFz6V+i5jqWXMIP9CAwyGpIra7r31L4F8YoAZpM7nBHCDS
 q4nVzK3XTjibHfp5E+jeJEmJacc65dN15mrTSHpbSfNy5DQOzxygLi72OZpGmRJioR64ZuE2hSo
 InuBhjlpuK+iR799Y/AU0uvX+7x0EA46yV3NSgXgp4ERshu31Y+1OKdXOd7r5TpzVx1WrODX11E
 pDpPb1lMWF5lXfHSfN4bJ2N7oAcF12RGzesnfhNkICOt24fv/xsBc0/M/6k5zDapJ58pNwMQJZ6
 e1y2T+pXsA4PwyHoj/n5FDkbJ66xOSSwuO71AfVnhHnBLPX5mYKIe3TT1jvxUlYGSP8FzmVGTSi
 Voy6coFWhtfcP7p3A=
X-Received: by 2002:a05:6a20:2451:b0:3a0:aee6:acc1 with SMTP id
 adf61e73a8af0-3b22ebc8960mr24858937637.33.1779252378828; 
 Tue, 19 May 2026 21:46:18 -0700 (PDT)
X-Received: by 2002:a05:6a20:2451:b0:3a0:aee6:acc1 with SMTP id
 adf61e73a8af0-3b22ebc8960mr24858903637.33.1779252378418; 
 Tue, 19 May 2026 21:46:18 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f1977a570sm18570304b3a.20.2026.05.19.21.46.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:46:17 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 0/2] bootm: bound noload kernel decompression to the
 allocated buffer
Date: Wed, 20 May 2026 04:45:49 +0000
Message-ID: <20260520044554.15373-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
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

For a compressed kernel_noload image, bootm_load_os() allocates a
decompression buffer of ALIGN(image_len * 4, SZ_1M) and then passes
CONFIG_SYS_BOOTM_LEN (typically 128 MiB on arm64) to image_decomp() as
the output limit. The decompressors honour whatever limit they are
given, so a kernel that decompresses to more than four times its
compressed size runs past the end of the allocated buffer and silently
corrupts adjacent memory.

A 4x compression ratio is at the edge of what modern compressors
(zstd, xz) achieve on real kernels, and is trivially exceeded by
crafted, highly compressible payloads, so this is reachable both
accidentally and intentionally. The overflow can land on already-loaded
boot artefacts (FDT, ramdisk, loadables), U-Boot's own data, or
memory-mapped device registers; the existing post-decompression overlap
check in bootm_load_os() only catches overlap with the FIT itself.

Patch 1 plumbs the actual allocation size through to image_decomp() and
handle_decomp_error() via a single decomp_len variable, so
decompression stops at the buffer boundary and fails cleanly when the
image is too large. The non-noload code path is unchanged and
continues to use CONFIG_SYS_BOOTM_LEN.

Patch 2 adds a sandbox py-test that builds a FIT with a compressed
kernel_noload image whose decompressed size exceeds the per-image
buffer, and asserts that 'bootm loados' reports the failure instead of
overflowing.

Tested on sandbox: the new test passes; the existing
test_fit_compressed_images_load (which covers the load-address path)
and the other tests in test/py/tests/test_fit.py continue to pass.

Aristo Chen (2):
  bootm: fix overflow of the noload kernel decompression buffer
  test/py: test kernel_noload decompression buffer overflow

 boot/bootm.c              | 11 ++---
 test/py/tests/test_fit.py | 84 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+), 5 deletions(-)

-- 
2.43.0

