Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6FFC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 12:43:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5158884AC7;
	Wed,  8 Jul 2026 14:40:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="nsDcFspf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ACD184979; Wed,  8 Jul 2026 12:35:33 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F28FE838D7
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 12:35:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 596003F427
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 10:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1783506930;
 bh=cBW1jalaLfwmxR7CFIh7Z8NalEoBp/1EyBjgzkMCepY=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=nsDcFspfMWfB4GUjwVvDA+58rI28+ZTXq3H1ZTVJT9Z8r1LhcOIrQ4SMsXyq7r+oe
 i4QMfoYnnzczzzyFLuYCLVZ13XCfALri7vDczFl8jrvksHCV4EszByNq46J1/KAS9q
 xWexggVMAnd3ScCzsp1QzzNNSU5sHR8YcRGKwkuPd4DovxjVFDnCEzWz/C3O0xL6b9
 oFyj+nTa7DS5zy7vdbyUAR7UhsAmlX9+dLSJKSSjfRCz96RAoMmJyrcI5w2xRvQ26y
 WYjr3zGXHvNiXH9aTYZC7hRhMy0LcQB5+iyOT5AmNCQOyacrbIIKgudUUnH4wHQOyy
 sM9s600rp9AGdrSeP2aSdLT3Eb+rID5bjc5evMQNoeTp06Kcd2HeWXYUbXSpOq5A7X
 kJNumj1bza1e1isTxZNSadNX3+KqPEWaobeWBBaBdJxKXnIv6sAtc44myFtlfl8DGH
 rh882v0OVwe+xI/MzG0cbR6G6eEyjQkarxHwWroz8nLvQzYKBPHikExbbo2ijYmn7M
 D0IPfOovGEl1xLwt87gzjUY2sm8IAzCnzXF5va9JtRUQKNkEvA+dOquWeDZj4yKYTi
 i6MhYghVPU79FLBh+SGCMhHHvJU1oldmG6sC+H9o6ZOJu+YsyLRMmSvMQh4/zz8BbU
 MJq9+UtBGbQsKSxx4DqDgLao=
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-381250979d5so708970a91.0
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 03:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783506929; x=1784111729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cBW1jalaLfwmxR7CFIh7Z8NalEoBp/1EyBjgzkMCepY=;
 b=GbKx50bEUysREA8B+2bdrevhCg6dcUOYOMgy8s1pT8ud/tPy/U0DCN3xnhEgNb/7gR
 KwFWV39nNwKW6GgX0UnzJydp/aNor3beJKImKfDe7dQf8iKgDbfiT6Ly04Zu9tcMKg7s
 aKg7iT9u13d6gpk93R/bYDpbmdtrXoLp9KRA+oxDaLeS2ZlPjUgJ5039CfBIa48+bXlA
 93CzdtbPmv3yv2EuY1bM/JOSEXZXqNII/gq0P6vntbhhI2g3TRsjsCH5d04tyZ5TzfGD
 Qx9iGWYzK5OuVBpCYuA6pU2ZJjvxryn1qQ5yXyXBkD1qCoqDbjCR4NTll9iPMfFemWnj
 Vm3w==
X-Gm-Message-State: AOJu0Ywh41dVH+rI4lbt7FW3E6aJEhb6kVxLjd9ufV9dRXNilasGZqzz
 y356+kIoWPT2ElHOrKgllaMxU30pewKAMq7WSRmVoiHs/E5gLEAycziQ4ZRLixFxMZXKh+BAIxI
 4f0tvaZW+YcznqQ9VrcsHaiQOVCwRq803fKmz63Tho49dTNAd91F1oZQiq2T9SvqFHDD91CaA8+
 cfjqI=
X-Gm-Gg: AfdE7clbcgea2xki4U8Pu/LHDCauYylBmJRP6vB0o4T3IyptuASbDnxmqju2uvmzhyP
 /Tu34Re4w4XuyPuNz5FKbpuibg+HJebjeg7M0mDstK9CFPcgQyBR8M51JUSaTLvIOVq+6JD0hKg
 xA7ZAK523PZZCLyGXIwk55gkws0Yp6dGFcd+H675a0nUdPCf8w8Xt+6Ebhh4cwCYWfHlvLPB+86
 9p8ZIjhfjKZ1N41nTUyXYlg9Dnm2yiwt2XjSL8wC1RHSRe9TwcDerFo/I6u57oz4TM+iAPdGZSh
 r9ej5fvWWzLfGGet/SwPTXonK8z9zIi4mHXrePvNV2ZB0xgRkVj6xYjW7/HKNIt7uokrs8StBQJ
 GgZwISki+lXAy96nFTjwIDXoSaJPHIo84OhZLvRB/0tn//wA2+T3K9jNttcO5BA==
X-Received: by 2002:a17:90b:2752:b0:37e:10d1:c05b with SMTP id
 98e67ed59e1d1-389417e4858mr1905458a91.22.1783506928522; 
 Wed, 08 Jul 2026 03:35:28 -0700 (PDT)
X-Received: by 2002:a17:90b:2752:b0:37e:10d1:c05b with SMTP id
 98e67ed59e1d1-389417e4858mr1905417a91.22.1783506928024; 
 Wed, 08 Jul 2026 03:35:28 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-387d12fcd99sm2563896a91.2.2026.07.08.03.35.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 03:35:27 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 0/2] spl: fit: bound external data-size in load_simple_fit()
Date: Wed,  8 Jul 2026 10:34:47 +0000
Message-ID: <20260708103452.49277-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618154750.180675-1-aristo.chen@canonical.com>
References: <20260618154750.180675-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 08 Jul 2026 14:40:34 +0200
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

Link to v1:
https://lore.kernel.org/u-boot/20260618154750.180675-1-aristo.chen@canonical.com/

Changes from v1 (all from Simon's review of patch 1):

- Move the shared error label to the end of the function so no goto
  jumps into an if-body. Both bound checks now goto too_big and the
  printf/return sits after the final return 0.
- Rewrite the comment on the early len > max_size check. The real
  reason it exists is to keep get_aligned_image_size() from running
  its int arithmetic on a hostile value; the block-aligned size
  check further down is the mathematically binding one because size
  is len rounded up.
- Include the data-size value in the diagnostic printf so a real
  failure is triageable from a board log.
- Note in the fix commit message that CONFIG_SYS_BOOTM_LEN is a
  conservative ceiling for the firmware/loadables/FDT/FPGA callers
  rather than the exact capacity at the destination. The overlay
  caller remains the one that is actually tight against its buffer.

---

This series closes a pre-authentication memory corruption window in
the SPL FIT loader. load_simple_fit() in common/spl/spl_fit.c reads
external image data from the boot device with a transfer sized from
the FIT data-size property, and only verifies the image hash after
the read has already happened. data-size is in the exc_prop[]
exclusion list in boot/image-fit-sig.c, so it is not covered by the
configuration signature and stays under the control of anyone able
to modify the boot medium even when CONFIG_SPL_FIT_SIGNATURE is on.
An inflated value drives info->read() into the destination before
fit_image_verify_with_data() can reject the image. The device-tree
overlay path is the sharpest case, because there the destination is
a fixed CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY_BUF_SZ heap buffer rather
than a sized load region.

Patch 1 adds a max_size argument to load_simple_fit() and rejects
both the raw data-size and the block-aligned transfer length with
-EFBIG before the device read is issued. The size check is the
mathematically binding one because size is len rounded up to the
device block length; the early len check exists so
get_aligned_image_size() never runs on a hostile value, where its
int arithmetic would invoke signed-integer overflow. Callers that
load into a memory region pass CONFIG_SYS_BOOTM_LEN, the same limit
spl_parse_legacy_validate() already applies to legacy images. The
overlay path passes the size of its temporary buffer.

Patch 2 adds a sandbox regression test in test/image/spl_load.c. It
builds a FIT with external data, then rewrites the data-size
property in place to a value far beyond both the image buffer and
any plausible load region, and asserts that spl_load_simple_fit()
returns -EFBIG instead of overrunning the destination. Without the
fix the test crashes inside the test-harness read callback when
memcpy() walks past the small calloc'd image; with the fix the load
is rejected cleanly.

Verified on sandbox_spl_defconfig: the new test passes, and the full
SPL unit test suite reports 20 run, 1 skipped, 0 failures. Also
cross-built am335x_hs_evm_defconfig and am335x_hs_evm_spi_defconfig
with arm-linux-gnueabihf-, both within the SRAM budget.

On the size question from v1 review: the cleaner shape (single
too_big label at end of function) plus the expanded printf now
costs 71 bytes text on am335x_hs_evm (vs the 57 bytes v1 quoted
for the goto-into-if shape). text+data lands at 45132 out of the
CONFIG_SPL_MAX_SIZE = 0xb0b0 = 45232 budget, so 100 bytes of
headroom.

Aristo Chen (2):
  spl: fit: bound the external data size before reading it
  test: spl: check load_simple_fit() rejects an oversized data-size

 common/spl/spl_fit.c  | 51 ++++++++++++++++++++++++++++++++++++++-----
 test/image/spl_load.c | 49 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+), 6 deletions(-)

-- 
2.43.0

