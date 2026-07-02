Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9F3C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 09:20:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0190E84CD5;
	Thu,  2 Jul 2026 11:20:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="kJZwMDzK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9220C84C8D; Thu,  2 Jul 2026 09:14:54 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 873A68056B
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 09:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F2AFF3F6EF
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 07:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782976492;
 bh=vzb+/imyubTvoIjjuonNoqdX0r3kJsPbyiWKWhnTTxI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=kJZwMDzK/1zLvltyM6s/ZrFjcKjzLI8epYylk+k19IhPy8wNlk/dZ9ioJ1c3W6iur
 E8BhRyk0+gP0j5LPnvL8QRU78JferihMas7sRP4TbjauoEaF9mLjMiCCFYrrBmmVnD
 ++D0MlRmDwc29Z/WSKON813j7j9mMByQEp4NDaImtJ441HBA7iP1DeF/MsPyMPJXn8
 qKSgFzEs+96eMB8zkt5R9T275Uv5eYwUmyJ8DEtCINi4JLUAWH4cjyvGW58AfAAnps
 NlIKHA/x2LJCN4AzVxmaqXuK64TbyqkrYXYyQr5Elcl54agGYnvNKDB7+zE7OxhXRm
 Vmzc9eKC5WPvSrf4GPayLTW74RDZp7+i3o+rtLuERrIKzLq1bO5TFsB6GUDEmkKBdn
 KAM6izqJFvor+Crwarq3AXcveQMXb8Yn1byPeSTWDQSS1Sgpqd4V2OcGncp/0z+QCW
 E/AriVYc5S+1BhkdrU3PRPkADxLF6P5kBBGdiDe75r+LfoSUmH4oO/T+GP2jtp1CkI
 Gncs3/WtroHr2KuazTRFXLZS/5+zzmUViQZRdO4NzVCIx3DtdYUlP2rNmrG+xRWlYr
 uyU64ywALkQZE5MWSNhxvWOkrAjI3m/8fhtibZI/PPuy27dLqj/Ym8tjJgkzjulPsp
 5OG1N+BDo1pDc/AQVx8hXfkg=
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-845a29d8c1eso1973667b3a.2
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 00:14:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782976490; x=1783581290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vzb+/imyubTvoIjjuonNoqdX0r3kJsPbyiWKWhnTTxI=;
 b=ikYCOQAHZGpkcvttYnhjMIGkQy7gqTp+RTIrq5EA8HUyBkS4GJJXMRWwO+F/DEgGST
 lub+jOHP54P3pphxFHdqrvFxlUgeqY8yyCchI0nM7Lj4ihEyC/RkhwgfKM1vse0SH4PU
 ZPq+CYbnGyTiwFavU5AXAKyxOgokocWPrwJmcn+UomyjYpySVKh3zijwZGD+qLGuJ4iw
 r5/LuZIfywL0/VSf3uJijWVbp/KFWusNog09bdSwf+HwYHTCBRK3qV4pt6y1SG19oxmV
 6oTPbjHlOSo/13t2DOX0U+vXLzyo5euHYbqE4Wz8zKkMwGpzPT7ueLL8vaf2yiBASA7q
 TNzQ==
X-Gm-Message-State: AOJu0YysyY2qQYU5H2fMkeWPDF0y7uznK7JuD4rYgLqAQOKW/EMPVhla
 u5Hs7Pwl2X84fO5xbdnyaX0t7J/hpOrWejq/GSL9782fxkOLIDcgGD/AC3gNDne6Pi49bJ+BEFk
 Fr+nLKEaB8A6CplzmMOXv75DLQDKNoFOHtLQis8x2DeRcaJD3MPRF66+5/sR2zkN8Kp8+XUlzfw
 P87YA=
X-Gm-Gg: AfdE7clVHl96yixs1pPMlk0DXNfXiPCujyyjFPsVyc6PLkd/8wjNLMfOWJEIXI+Cj1n
 Xg2UuW7+veeGUSrdwzTwHiRDTZckYlB4aIMzadfdsOyLVmDRGVrSNbg/qkUPGxo5EI3Jr4frCGZ
 rcw2uIKl/NJ12+CX+uyJDh4aP5+llHMHSA/YxIqGnt8ROF4BheVaglTskR9mR60vD94R2RjEe/F
 7WeHEr8+ghzBF8EQl5kGgK173Dwgys1UntXiDbykSHuwdC0IN7sFw8T6k0Yc4zVEUvWweTo6X3p
 J+4gKS0j4sUdDIv33mwpYOI7h/JtwVzq2hr69381EOUqyNXMgPs7pGNKIbtVO0+wLnlR7+a0u+v
 k0TgQNCnmVGuULYgeHNyxOD8sTZVvongZUAYrJYAd6HSWnJnehY5RM37Jkhp6K8ipWiNixxkwXO
 xXsA==
X-Received: by 2002:a05:6a00:4094:b0:845:d284:9dfd with SMTP id
 d2e1a72fcca58-847c0ab02efmr4483709b3a.55.1782976489774; 
 Thu, 02 Jul 2026 00:14:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:4094:b0:845:d284:9dfd with SMTP id
 d2e1a72fcca58-847c0ab02efmr4483677b3a.55.1782976489131; 
 Thu, 02 Jul 2026 00:14:49 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847cba05575sm894056b3a.61.2026.07.02.00.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 00:14:48 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 0/3] vbe: bound FIT external-data reads against the
 firmware area
Date: Thu,  2 Jul 2026 07:13:56 +0000
Message-ID: <20260702071425.9204-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260621143938.2863-1-aristo.chen@canonical.com>
References: <20260621143938.2863-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 Jul 2026 11:20:23 +0200
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
so this v2 stays scoped to the bound.

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
 test/boot/vbe_read_fit.c  | 225 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 243 insertions(+), 2 deletions(-)
 create mode 100644 test/boot/vbe_read_fit.c

-- 
2.43.0

