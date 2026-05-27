Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797E6CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 16:27:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E633B84857;
	Wed, 27 May 2026 18:27:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="BRqrY3nI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AB2C84837; Wed, 27 May 2026 17:06:54 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AC38844CF
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 17:06:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D40453F7DC
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 15:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779894410;
 bh=zOkyOidXWtQayDTOhoayJbFX+MErLED2XG3ynfFmoh0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=BRqrY3nI6UickUu7PdWDjkzTMsYrXHC6OGckyX9n+VJ8NU3OhEC5oPgibYIzUVOZl
 gyzUM6/8cAeuPFbfLz/0DWBql5eBmb9B9X1TO19KdLk9xie6r9BnrUEeZVwJH96jPq
 6pvTBd4a/RMzz13NkXrPuf6Xihv27yCGFe0NPTf2U2raFbOpnF77Ayai9u9lbv2kVC
 G0eu7F7BTMeBjMtj5KjP60LEuvRqHmnK6+mSKT+q0vGJsedRiJea1Ji0wxZA7cc7c/
 SOWdBMHQUR/BvP0R5ZxvKJIvMJwHFc8Wxpju4TbgGxmetEjzH0iE71II9itVZ1ilpr
 9wMNIx/F5OI7Iw44NH8NdXv+GItY/2zNI6m4E5/qct33mjzddFJAnq6gn5P0MQ9ZXH
 JCwryabdnEiubP76N84wZ/qa1tT9zkjNlzFBFZIXckctn+b8YQjKV/AG8lADUElsXW
 OZQ9MMLVuXhz3uLBwsJyG7gbcJXPUVEZxTb5serEZhp8cjeTJf0CjcRPYAS9s9zEix
 r0eW7be3xysNGe91rnwgJQTxBcVl2U53amsDrVgHUvvkbs27VoZ8b2OpjRBpxlAOkG
 Gqp19/6obiHwZz0uHSnMsKAY6D69BLAKv9oYnqqzAaUUDNRC7SkCisGfn7UVD2Rcu6
 ayFO/ZGZi2U2ba+p+LI6C+jE=
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-368edd5fec4so12814291a91.0
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 08:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779894409; x=1780499209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zOkyOidXWtQayDTOhoayJbFX+MErLED2XG3ynfFmoh0=;
 b=Mt7mlLI4MpxLjAa0QvqdCI12l5c7k9+zMprUufRF7BkVx9A4xXpmY+wvlR5v3lunPx
 CwPj1RxdLHWFzOaQY2/XuJEaI/NQQmg/XnnAhV5v8PvTCopOSJjBZ34y8qMt8MrqWzDY
 Ve1c5kFh+55XoBeCYb7K1moukU4Cqnx8wOsQSKsAPmj0hV5fWe3y9h43HMlb+2hPN2zb
 V+DCUW24x6rWSB3lZtEguB1uYhnXx3cU3qOaonBdpEGV80jjfXd6VTZy7JFeuxqT7nRW
 MhWBuu8O7v9nkJyHdsuwiUop1Ql6rikY/G0y936eCW1FN91+sQPZkllzSTNJdLA2+CKD
 pBXQ==
X-Gm-Message-State: AOJu0YzkZrbSCOEjJnCzVEEWaFxIVhfOH4ahlLfv8grjPHt7HqFj0994
 0DuGkG6VqBChO1CXGq7FHiFp9JWqRO1YV/Pz6jdcGsVeU2CxHsqy2u3qQMUFdHJVEOGkqPS9fKt
 QfdU/7adYB4ALE65aUYDnVAvLa3pFGEBj706pCzozRucHTCuszU3wZzTUav8eB/vOjt+nPyyD9j
 XNJAg=
X-Gm-Gg: Acq92OHlxSWWgs9IOJo9qn1E6FEMYGfCL3rS8P6fj6AU2rizAKtBrCBMjJWbk2Tg6mL
 EwBhFXInhCsfikFmqtzvhdcXVXAU8Q6/A6WXmIwGTCi7YZGhHywTo+x5dygam+0qAJi35BbjNE4
 WUVfW0P4Tg08xB3HZWONHb3vBBDrJ7MYZPibz6rSVj/9HxoUQmm5Tb1EpXkdi3aTHP0FvxmyLhI
 qBNJp1cwWx556DtU+SRZEjITqAPj74lTTt6NgDyVuLM18ysVw+ZpPdBU3O0HvDWALVoP0Oz0b9J
 0Rm/Onou+CT6zJkuF0Muv49TAMm4qcqb4qLHHTutoHWa6ZYPPGBQM+0QdKi0eMRwPSqxPGh76iD
 wP5BgZ/rymOKUyxzQwKs35Khx76QiyD3MXeSV9S12TcYz5sTgmb9+rxMhbKfBHDH/5g0TyO1r
X-Received: by 2002:a17:90b:3bcc:b0:367:e244:4c40 with SMTP id
 98e67ed59e1d1-36a67893102mr23052104a91.26.1779894409415; 
 Wed, 27 May 2026 08:06:49 -0700 (PDT)
X-Received: by 2002:a17:90b:3bcc:b0:367:e244:4c40 with SMTP id
 98e67ed59e1d1-36a67893102mr23052052a91.26.1779894408914; 
 Wed, 27 May 2026 08:06:48 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36b73ce986dsm282702a91.6.2026.05.27.08.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 08:06:48 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 0/3] bootm: bound noload kernel decompression to the
 allocated buffer
Date: Wed, 27 May 2026 15:04:32 +0000
Message-ID: <20260527150637.2850104-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520044554.15373-1-aristo.chen@canonical.com>
References: <20260520044554.15373-1-aristo.chen@canonical.com>
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
image is too large. The non-noload code path is unchanged and continues
to use CONFIG_SYS_BOOTM_LEN. A clarifying note is printed when the
failure is gated by the per-image buffer, so the generic
"increase CONFIG_SYS_BOOTM_LEN" advice does not mislead.

Patch 2 adds two sandbox py-tests against the per-image buffer: one
that exceeds the buffer and must be rejected, and one that matches the
buffer exactly and must succeed (guarding the boundary).

Patch 3 raises the noload-decompression headroom from 4x to 8x. The 4x
factor is at the edge of what zstd and xz achieve on real kernels, so
well-compressed vendor kernels can fail to boot at runtime once the
bound is enforced. 8x covers them comfortably while remaining bounded.
The matching references in patch 2's regression tests are updated to
the new bound in the same commit so every patch in the series is
internally consistent.

Tested on sandbox: both new tests pass; the existing
test_fit_compressed_images_load (which covers the load-address path)
and the other tests in test/py/tests/test_fit.py continue to pass.

Changes in v2:
 - Patch 1: also print the per-image buffer size from bootm_load_os()
   when the failure is gated by the noload buffer, so
   handle_decomp_error()'s generic "increase CONFIG_SYS_BOOTM_LEN"
   advice does not mislead.
 - Patch 2: add a second sandbox test covering the buffer-limit
   boundary, in addition to the existing overflow test.
 - New patch 3: raise the noload-decompression headroom from 4x to 8x
   so well-compressed kernels do not have to bisect to find out why
   their board stopped booting; the same commit also updates the
   regression test references so each patch stays self-consistent.

Aristo Chen (3):
  bootm: fix overflow of the noload kernel decompression buffer
  test/py: test kernel_noload decompression buffer overflow
  bootm: increase kernel_noload decompression headroom from 4x to 8x

 boot/bootm.c              |  18 +++---
 test/py/tests/test_fit.py | 126 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+), 7 deletions(-)

-- 
2.43.0

