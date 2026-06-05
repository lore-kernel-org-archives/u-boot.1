Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F0CACD6E7C
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 17:15:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65D0184987;
	Fri,  5 Jun 2026 19:15:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="PszNr+IO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29DF984956; Fri,  5 Jun 2026 17:43:21 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F309F84932
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 17:43:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 827493F2D2
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 15:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1780674198;
 bh=bd+SmA3yHsJMlNPt3ejqB+N6JneR5wy0QgOShMoX9pg=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=PszNr+IO3MI7Xwa/9EBjRxUYwuprbtfsgQxCDWtiLmvHE9Q9Dmb1PZ3b3bJJ9R/wW
 uMx73CEPaUb/H9OaIjD1RNMk42NGa8SWnvljrtoLp+QtHK692qwMm38w+6qc6C3q9s
 1UUFlrn4mRuTUk4X+CdtNKjunUEq52izfSsgVt0jDzWxGtggX/pKfqQ9rK3U2TCF+B
 OOy9Tq6vwqjoOGZ8Y6ReonvHlKlP4AMONiqbnctgjwg0XP8y3J9sLoiXKVGRQVdLXH
 tUAz7lhL/rgQnQAKZ642oHXaC9WdTdjEThuPJ542Zqi0Khse5N0TrNkOxIJpYkdMII
 xu+PUapT8GXwO0X9gGRwNebyS9KqnBc4WTBr8qx6g047XIMJQtV+7kMFMIgezeW5zd
 Cpe+fXitrvH9J7gMM9GsYYCokrtVelFqdi3cRqOVayvmVMQsjukIfTQrXjfomZXyvq
 YYbno5ZfXJMhavUdMRWPnw/bYyQoJjzWsVXfnucLiIKIE2CIpTsP/ap/Am++VDDXxP
 aREM2Vzai/s07CE8peYavvXS0bfzSeSpCJuEkE6xgPykPf7E9bJyLCpMtrxEfWfN8W
 MnatxtUwd7VMSz4xPE32nX3Y2YJa3Yo3T2GLKgL/gWOasVrbCqET4BDgF/RkS/tl3i
 SDUk6NRRjUWZyXXSh8Qkn0qg=
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-36d97a4e08fso1872833a91.0
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 08:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780674197; x=1781278997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bd+SmA3yHsJMlNPt3ejqB+N6JneR5wy0QgOShMoX9pg=;
 b=I9pCqx/1J9M7VmNbfaH3pjc3ZFJomfMU5scrrTnu3q22tDZILLq7KTzD9Nr33kNCBo
 zGqC58yWGieXP9lNJ1kI/z+ODLM2I7JsqWiWtNg1CRWiYlpJUzuH7jCpg0EDyY1ogdKs
 caPurNSmv50U4RgJ0a5AB7RqvsF6hF6d7nJCfFsOGkcwcmZSZUGYTUSieJeRGLE45bbH
 QrtBnLI3DH0ah9u+J5Hmdfzqh5MsE4+YlCqzZwPPyn11ncPEXdCUmv4hnyNQXs7bxHpV
 zPmqvBA4dvtKT1pqHULh6UK9Ck1y7pKzFSBvjEwxdhsgiLXTnrDShiSLAZJUINC4gjPE
 yhZg==
X-Gm-Message-State: AOJu0Yz9qEt0aeVt3zIzkkVS3CNFxx+u1HRnfAVjHOTfdY+sK7qOcDs/
 gjh1YxhWg1gaE/CmG91B03WGE+HJlAfBfoXPmw+zcZgfX6ducrhUGYkUQUunzQgeqa6fWzL0nyR
 xtgBGgqb8kVSsVsMG3ZHHvSwLpj21tgdQYuELYQKpmCS5PWZ+6a9qsqZfUKfbLHfM73Ry0SO7wK
 fjN7k=
X-Gm-Gg: Acq92OEB1pqY4je24c+RfMS3v23b51N+eG6yeJdILmeW+/1z1yHXufUpBjiWXO3ESGC
 ++2J4WJPrHRatlfdyQ9J0KW8n4BElsN6LxO2SLKWtkFhKcPU/MCk+cjn425oc2gN4uqb4kvAXqK
 y9O9mVaF4Q2w1Vugqe4P67NqnTbqI3a2TMOTERHcHLwJh1ZiyL32/zoWmT5Xs1CkABAgjx1ghqM
 qmvQQ38swj7PrFFj6Aej2JNoEswPHhzXkQmTlroMiRXAOKRQheJBE5+9b8SB8YMeBuG8dHfY6Xr
 3tnHp6QULiey8ns4cDDAZMMoeIZgVp5DAmedhiLu0piA36sOaKffSS9u1TsUmk/yZZHHckzCC9P
 pYYSJ8u3v1vj+g7etgb4ozTCd7ZcKEPHbCIiMG4gA5FjgOIlm1mnX6lUTDonY8Fw3ndyJNQRFVL
 NjTj+v
X-Received: by 2002:a17:90b:5747:b0:36b:9798:4f67 with SMTP id
 98e67ed59e1d1-370eee03facmr4291471a91.8.1780674197066; 
 Fri, 05 Jun 2026 08:43:17 -0700 (PDT)
X-Received: by 2002:a17:90b:5747:b0:36b:9798:4f67 with SMTP id
 98e67ed59e1d1-370eee03facmr4291452a91.8.1780674196544; 
 Fri, 05 Jun 2026 08:43:16 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f70a285a1sm7233531a91.9.2026.06.05.08.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 08:43:15 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v3 0/3] bootm: bound noload kernel decompression to the
 allocated buffer
Date: Fri,  5 Jun 2026 15:42:48 +0000
Message-ID: <20260605154255.833334-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527150637.2850104-1-aristo.chen@canonical.com>
References: <20260520044554.15373-1-aristo.chen@canonical.com>
 <20260527150637.2850104-1-aristo.chen@canonical.com>
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

Patch 2 raises the noload-decompression headroom from 4x to 8x. The 4x
factor is at the edge of what zstd and xz achieve on real kernels, so
well-compressed vendor kernels can fail to boot at runtime once the
bound is enforced. 8x covers them comfortably while remaining bounded.

Patch 3 adds two sandbox py-tests against the per-image buffer at the
final 8x value: one that exceeds the buffer and must be rejected, and
one that matches the buffer exactly and must succeed (guarding the
boundary).

Tested on sandbox: both new tests pass; the existing
test_fit_compressed_images_load (which covers the load-address path)
and the other tests in test/py/tests/test_fit.py continue to pass.

Changes in v3:
 - Swap patch 2 (tests) and patch 3 (bump) so the multiplier is bumped
   first and the tests are introduced once at the final 8x value,
   rather than written at 4x and rewritten at 8x. Patch 1 stays first
   as the self-contained fix for backporting.
 - Patch 1: use the direct IH_TYPE_KERNEL_NOLOAD && comp != NONE
   condition to gate the "noload buffer" note, instead of
   'decomp_len != CONFIG_SYS_BOOTM_LEN' which relied on alignment
   never coincidentally matching the global limit.
 - Patch 3 (tests): drive the overflow test with ubman.wait_for() and
   ubman.restart_uboot(), instead of reaching into ubman.p.expect().
 - Patch 3 (tests): add @pytest.mark.buildconfigspec('gzip') to both
   test methods.

Changes in v2:
 - Patch 1: also print the per-image buffer size from bootm_load_os()
   when the failure is gated by the noload buffer, so
   handle_decomp_error()'s generic "increase CONFIG_SYS_BOOTM_LEN"
   advice does not mislead.
 - Patch 2: add a second sandbox test covering the buffer-limit
   boundary, in addition to the existing overflow test.
 - New patch 3: raise the noload-decompression headroom from 4x to 8x
   so well-compressed kernels do not have to bisect to find out why
   their board stopped booting.

Aristo Chen (3):
  bootm: fix overflow of the noload kernel decompression buffer
  bootm: increase kernel_noload decompression headroom from 4x to 8x
  test/py: test kernel_noload decompression buffer overflow

 boot/bootm.c              |  18 +++---
 test/py/tests/test_fit.py | 125 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+), 7 deletions(-)

-- 
2.43.0

