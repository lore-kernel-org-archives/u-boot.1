Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79DCC43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 04:05:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C726284119;
	Sun,  5 Jul 2026 06:05:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ULs2N3Ey";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CAA484119; Sun,  5 Jul 2026 05:44:37 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78E8E801A9
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 05:44:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 01AED3F11B
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 03:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1783223075;
 bh=wbjWkTqLKUoktg4BSeIOYrKoGgNFGci2qXOEj5kCsUs=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=ULs2N3EycjeOK9LzEuMS4pzpETqpUvpbrCJBJ2vKUEFshD4z8ZiZ2Le9l3aaHxKm/
 IzQ1G0ZVD2oHGWi7FXRq2D404nsrGRoiUk8vhVcC17oFkqRn+q0geuBs+NtrW0ZF8M
 ykmx8Aj5vYkf/Zn5Mh9oEKGQqL59wKRRUL6Aa1uhVuoJKSpW+7n3mgMN27IL43x6JO
 YwINyfxb5egLv46dp92eJWueG8U6aotjSVi11ri6e0Vkt4aXX2wxjncPo9/kU2t0CJ
 WwyM1YuG/gzO374mWlROcJSxNj7rOu++9d61NgdrupCdbo4zqTP/folVMqOx/bQfdt
 ay4VczQYd4rtReP4S6zeAjd0kLCGcv8RVsLCCr7PWUCGAYd7Azf51xraYQhP8t0w9x
 zwzFM8YZ6NQU7QsjLIOh/JZz4Y1dxkuREX11nZis/Ay1xRKM32yZPR0PmT0XejURRe
 Yqc964nB+STIVrPhL/qNAmsUzA69LXEoY6rAcdTeJOsOzpfUEFN0ZyNODuhtCggU6P
 wZcli9BOcgR65uDZVS/61N52wS+evf+thPiqDE85JWFyk43Zq1BStKMLDQfU07rA+2
 EgMAKvCwvbGV390rs/kFYDW6pgCW59yD5ZtvC7U+EllR0Es7b5B3zFQXbn8m56PMb1
 gg1Ixo4YIxW3JfppiO6J1S6E=
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c9d5a5b63c5so2793978a12.1
 for <u-boot@lists.denx.de>; Sat, 04 Jul 2026 20:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783223073; x=1783827873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wbjWkTqLKUoktg4BSeIOYrKoGgNFGci2qXOEj5kCsUs=;
 b=V35+Rb9k6tfkoYga8EMBm252whJsRajnYxNCGJj/JcJWKEz/6H/hzpphy17cDTe4a9
 5dqVy4oBQpVcsaaBWLfydT0CBX1URA1ZpVT0Y+I1t6JuVGCbZIMwyT/rHezG4A57zebc
 nTo3R3MsvXEe2AinPGcqTMqCq7Lw+dOF/fZiAWTZM1AotZr4/BJeNQhS6/QoM/XUaPRt
 LqxAlNxjf8pjGimw07KsR1ZT5lBPVfIfFeoHlHQFAdWBTMaUdVD0skz19lDtcxccxUWo
 r5JFqY9HfAsUNwKXTvdxRmBubpn0B7FUKR5EbACOb5IhkM3Gi4fTdTni+1CYPJFWhxk8
 F0BA==
X-Gm-Message-State: AOJu0YxYeidqZnHHHy7mrrsvFxTj6BbbEBmMDTrF96L5gCtXFMZ1ERk1
 VstQ0w2xSP2IqZAu6itBlADsCswasH8h2t9JZfZERRDCHeEVjh0ESYLRregpSXdsFBL6Ckzw6fY
 jaBtiprL94p1ld2qmU960lAIrPJ23akHUOSsDiXLTQLqKaCsyKLycgP5510RdneDHiMsM/f+mYO
 zvjv8=
X-Gm-Gg: AfdE7ckNieIXa/uEnMDvWkOALtkWkq4KQQ5ukPWGpANk9d6+Pludom+6zyhfCIq2xSP
 lFVTE6hzUkOsY+aliEFExaZ02hwOrCqan+a/0dfUxuqNL5M/gC/uvzztD4vWvxj94cvPEScKbnJ
 fgiuBa56u9L0QTrHekYyhBQfyk8DJ8aXcSxZyLjDXICk/ADRVEA5DgFHMrt8aQZ5aEwAlZ6aDr/
 GAjCYphpWRe4lmTAhAUfMO3wK6daK15RDV/4a6yRJYnu7x4P1r9uyP8Hh7o/9sUQZRGZALTVUn1
 LWZr+KDFKQ4JsFLQHN4xuKfYPDts5HjHPRgeRm9GX4UPOvMwMdreNLWQYbwt+2o+W70zDYaZCqp
 AHiaRCf2Y1Dsw0CJP2ZTa+CLEi29ImSMnQ7Li+PoAwC/XXmmRk0S67Fxcw04lXl6kGGEe/Q8Eaj
 66cJ/u
X-Received: by 2002:a05:6a21:62cc:b0:3bf:a4c9:b054 with SMTP id
 adf61e73a8af0-3c03e4c46dcmr5736156637.46.1783223072989; 
 Sat, 04 Jul 2026 20:44:32 -0700 (PDT)
X-Received: by 2002:a05:6a21:62cc:b0:3bf:a4c9:b054 with SMTP id
 adf61e73a8af0-3c03e4c46dcmr5736123637.46.1783223072379; 
 Sat, 04 Jul 2026 20:44:32 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c9e926a4294sm4424735a12.26.2026.07.04.20.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 20:44:31 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v3 0/3] vbe: bound FIT external-data reads against the
 firmware area
Date: Sun,  5 Jul 2026 03:44:08 +0000
Message-ID: <20260705034414.2247-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702071425.9204-1-aristo.chen@canonical.com>
References: <20260702071425.9204-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 05 Jul 2026 06:05:54 +0200
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

vbe_read_fit() loads a firmware-phase FIT from a fixed firmware area on
a block device and then issues a follow-up blk_read() to pull in the
image, and optionally an FDT, referenced by the FIT's image node. The
source offset on the device and the read length both come from the FIT
itself, via data-position or data-offset and data-size. Those properties
live on mutable boot media and can be controlled by an attacker with
write access to the firmware area. On the TPL or VPL path, and on the
bootmeth bootflow path reached via abrec_read_bootflow_fw() and
vbe_simple_read_bootflow_fw(), the follow-up blk_read() runs before any
signature or hash check on the loaded phase.

Patch 1 is a sandbox test-tree preparation. The firmware1 node in
arch/sandbox/dts/test.dts declared area-size = 0xe00000 (14 MiB), but
the binman fw-update section in sandbox_vpl.dtsi is 32 MiB and the FIT
inside it carries ~16 MiB of external data, so the FIT already extended
past the declared area. The mismatch was tolerated because no caller
bounded the external-data load against area_size. Patch 1 raises
area-size to match the binman section size so test_vbe_vpl keeps passing
once the bound is enforced. The patches are ordered so the test is never
broken in the middle of the series.

Patch 2 adds the missing range check, confining the FIT-supplied
[load_addr, load_addr + len) window to [addr, addr + area_size] before
block numbers and lengths are computed, and applying the same constraint
to fdt_load_addr and fdt_size. The check is written in subtraction-only
form against the trusted area_size so the comparison cannot itself
overflow.

Patch 3 adds two sandbox unit tests under test/boot/ that construct
synthetic FITs with out-of-range data-position and oversized data-size,
write them to mmc1, and confirm vbe_read_fit() returns -E2BIG for each
before issuing the follow-up blk_read().

Deferring the external-data blk_read() until after the phase has been
signature-verified would be a stronger structural fix and was discussed
on the v1 thread. Simon confirmed the bounded read is the right first
step and that the verify-then-load change should be a separate series,
so this v3 stays scoped to the bound.

Changes since v2:
 - Patch 3: dropped an unused <mapmem.h> include and added a note in
   the commit body explaining why the load_addr < addr and FDT-region
   clauses are not exercised by the new tests (both are unreachable
   from a sandbox test). Both nits from Simon's v2 review.
 - Carried forward Simon Glass's Reviewed-by on all three patches.

Changes since v1:
 - Collected Simon Glass's Reviewed-by on patches 1 and 2.
 - Added patch 3: sandbox bounds-check tests for vbe_read_fit()
   (Suggested-by Simon Glass).

Aristo Chen (3):
  sandbox: vbe: size firmware1 area to fit the binman fw-update section
  vbe: bound FIT external-data offset and size before blk_read
  test: vbe: cover vbe_read_fit() external-data bounds checks

 arch/sandbox/dts/test.dts |   2 +-
 boot/vbe_common.c         |  16 +++
 test/boot/Makefile        |   2 +-
 test/boot/vbe_read_fit.c  | 224 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 242 insertions(+), 2 deletions(-)
 create mode 100644 test/boot/vbe_read_fit.c

-- 
2.43.0

