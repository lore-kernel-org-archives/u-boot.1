Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8797CD4F54
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 13:30:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 707438404D;
	Thu, 28 May 2026 15:30:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Yvg9NX2C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B4098056B; Thu, 28 May 2026 15:28:17 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1D5080398
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 15:28:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4F9F93F877
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 13:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779974894;
 bh=38RhEQ5+Ko7Ft3TG4YLEryDENUzolSRma3UexHvyuBA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Yvg9NX2CYO51gjsXxCptdbzDYRUrAtUU1auc1wXiHZeTBesu5MViqm21jI5q0ybBR
 FctFLSKounwwMiwSpHBV4S4dN24lDaeFB9rS6Ays+bRpTfUJApd8G+stQfEy/kQWsj
 m86iCFW/3L8TNG+feRlwJVKgAHmctMl+4cAzXGS3wAwd2hhAs/xmKGalFONd3MISIe
 2ONOIIEaJxpJprRf8dZlNenFVguchRZWspLUh8A7E1aiRor+19co81u2256cG3CBPZ
 z8Db1/VXkQyjjjouBGlftdoXTYwgW3+fP2b/XZBU5e5Bc54IQi7b+VRrtG+uTtf1jA
 cwLmR6epp1Nm1OBvooRioXotngF06RvGNl2TTgwqw9RXlAxTA6v/RsvLrc2S/iOXwt
 vx+H2OwQKSyifFvSEy6FSW/0iY0zPekEr3XU7wu7rltggl+V7r/a9UJJKNq4Rr4Xcv
 /hODQFhmXNkA60riQMo5oN8P4bO/SVUbi1GkM1onOvfYtc4eD4VUaLogqJfPmXmkoo
 WXK1ZbLrklfEgkvyX0tz18D4q9xzwy5TEgXrtFyyYp9PVQYqpRqvJN9UIwcnJtP+DJ
 6PUCAh8HbIu9PAEBpclg5rvy2QKGnV0tRef4LFGxpu6mPV48cNagrpAFvQAINMkKjs
 cO6EjMEyLrK8FwLVM06AXoK4=
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2bc7f9b2213so94040195ad.0
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 06:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779974893; x=1780579693;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=38RhEQ5+Ko7Ft3TG4YLEryDENUzolSRma3UexHvyuBA=;
 b=b0xrpPybIailnTUAZ92ETkoIl3mOkD77yc4DUIpJkYdICDOnkONv0Yl1kdXG0Zn0zg
 waXrLAO7nWU6no830Lg9+NemLrrx092rjiN4LAvsKIzYMuBe3hhzjHI6519nTx44Fjmk
 S847t8nM7GsMWTwHhBPjugWAgaR+mi9wDzZr0ikyhYGQ+UBdWBBnZ3NLhIYGigJ5khU4
 kKcfx4M2rI7zxMrfSIQRXn8FCS7TPvisX6Mgs1j78V1xPV4MF2Bk+7KYtgge0q1Ous0V
 Edh4DF7mgMr+fKrttk6gQwODG4RPVlzn0Pi1u21+Z3JgiZFeSeWbChp49ZtCRXEIGyxb
 rFKw==
X-Gm-Message-State: AOJu0YwkpmN0lQMl8rabscuKe0C2sEOE//WqSw/OLu7VAFXZBEv1U39a
 uKe7+Bj9eP9F7L5M0jychXMRIOTAgAED4dQicP7dPSYeMOhJ5ijRFESk7vxz1LF+TuQiLKDUr1y
 z9W5Y9fracKIwdiEoRau9bqh6bd9r71RBPaKCjNMaiZLLNGiynKa3vZ3BhGrOFlykGXQM+3CfMO
 1yFBY=
X-Gm-Gg: Acq92OFFH//31xCGQZuaRsnDhm6K4NEeCeuBHSqJmrbWBy2PmDLFtLB9CMuKQX2zDEL
 gZFzyKyGM2547VhyZvJwT2cuogW4vOtAl7BaTWeOtMfgdq9/XozfaFPSp4Utc1QZ60ajqwkgrvA
 QJ3824Cf7LqNMGWoMwXEq5bUGE3qnP2077ISLQuI1qaCfcw6hGNIFGJ2AN+FXfuiM4CjBFFcov4
 0wEDDZmd2Fvpduls5HNMghmuQ23B/jEDSwRyZWD0LeSlhT2IwLwAHMki5nfaXARV4jIqy+DT475
 TwGf3BGkRKNyMeSIdhUUXP/ByESDLMKWdZi3FWVqgxaGt9nfYeYjKm8oIKt8ZDm0fyOA3R/lNRr
 iSRf7q3D/UEVKhvI2b1pn9Pzh/dqsAIFLUxmgMSkKsAQWlx8+1vDy0b8SZrntMS+b1qInr+lJLK
 9jq0fTlY8=
X-Received: by 2002:a17:903:390d:b0:2b4:5e0f:c239 with SMTP id
 d9443c01a7336-2beb03776bcmr279175755ad.10.1779974892894; 
 Thu, 28 May 2026 06:28:12 -0700 (PDT)
X-Received: by 2002:a17:903:390d:b0:2b4:5e0f:c239 with SMTP id
 d9443c01a7336-2beb03776bcmr279175455ad.10.1779974892454; 
 Thu, 28 May 2026 06:28:12 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58b3058sm187006315ad.39.2026.05.28.06.28.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 06:28:11 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 0/4] arm: k3: replace tifsstub runtime filter with
 per-state FIT configurations
Date: Thu, 28 May 2026 13:27:09 +0000
Message-ID: <20260528132746.719699-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 28 May 2026 15:30:21 +0200
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

The AM62x family (TI EVMs, phytec phycore, toradex verdin) ships
two or three mutually-exclusive tifsstub variants per tispl.bin FIT
image (tifsstub-hs, tifsstub-fs, tifsstub-gp), all assigned the same
load address 0x9dc00000. The current platform code loads every
variant and discards the wrong ones at runtime by zeroing *p_size in
board_fit_image_post_process() (arch/arm/mach-k3/r5/common.c).

This runtime-filter approach has become a friction point. An earlier
attempt to add FIT-image load-address overlap detection to mkimage
flagged the shared 0x9dc00000 as an apparent conflict, and the
workaround in that series was to shift each tifsstub by 64KB
increments. Bryan Brattlof reviewed that change at the time [1] and
pointed out that the real semantics are "load one of three at
runtime", and that moving the binaries was not necessarily safe given
downstream IPC assumptions about the fixed load address. The series
was ultimately reverted upstream, which leaves the underlying
question open: any future static FIT validator needs a way to
understand that these three images do not actually collide. The same
point is being discussed at the spec level in flat-image-tree issue
#32 [2], where a "mutually-exclusive-group" property has been floated
to express runtime-resolved overlaps to static tooling.

This series fixes the problem structurally without moving any
binaries and without a spec extension. Each board's binman dtsi is
updated so the tispl.bin FIT carries one configuration per security
state (conf-hs-se, conf-hs-fs, conf-gp), each containing only the
matching tifsstub. board_fit_config_name_match() in each affected
board reads the SoC security state via get_device_type() and selects
the correct configuration up front, via a shared helper
k3_fit_config_match_security_state() added in arch/arm/mach-k3/
common.c. Each FIT configuration ends up with exactly one tifsstub at
0x9dc00000, so the overlap goes away from any static validator's
perspective and no platform-specific runtime knowledge is needed to
pick the right firmware.

Series ordering is intentional and bisectable. Patch 1 introduces
the helper, migrates the TI EVMs, and leaves the runtime filter in
place. Phytec phycore and toradex verdin boards still use their old
single-config dtsi at this point, and the runtime filter continues
to do the right thing for them in the meantime. Patch 2 migrates the
phytec phycore-am62 SoMs. Patch 3 migrates the toradex Verdin AM62
modules; their previous board_fit_config_name_match() returned 0
unconditionally, which after the dtsi split would have selected the
first listed configuration regardless of silicon and broken HS-SE
parts, so this patch is also a latent-bug fix on top of the migration.
Patch 4 drops the now-dead runtime filter.

Boot tested on AM625 SK GP silicon end-to-end through TFA, OP-TEE,
A53 SPL, U-Boot proper, and Linux 6.5. The two "Skipping
authentication on GP device" messages in the SPL banner confirm only
the GP tifsstub variant is present in the selected FIT
configuration; loading any HS variant on GP silicon would fail TIFS
authentication before reaching that point. Building (R5 SPL + A53
SPL + U-Boot proper) was verified clean against this restructured
series on am62x_evm, phycore_am62x, and verdin-am62 defconfigs.

Testing on HS-FS and HS-SE silicon would be very welcome; I do not
have either part.

[1] https://lore.kernel.org/u-boot/20250916122244.a7rda2ouhou47hp7@bryanbrattlof.com/
[2] https://github.com/open-source-firmware/flat-image-tree/issues/32

Aristo Chen (4):
  arm: k3: select tifsstub via board_fit_config_name_match
  board: phytec: phycore-am62: select tifsstub via FIT config
  board: toradex: verdin-am62: select tifsstub via FIT config
  arm: k3: drop redundant tifsstub runtime filter

 arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 42 ++++++++++---
 arch/arm/dts/k3-am625-sk-binman.dtsi          | 61 ++++++++++++++-----
 .../dts/k3-am625-verdin-wifi-dev-binman.dtsi  | 42 ++++++++++---
 arch/arm/dts/k3-am62a-phycore-som-binman.dtsi | 15 +++--
 arch/arm/dts/k3-am62a-sk-binman.dtsi          | 28 ++++++---
 arch/arm/dts/k3-am62p-sk-binman.dtsi          | 28 ++++++---
 .../dts/k3-am62p5-verdin-wifi-dev-binman.dtsi | 15 +++--
 arch/arm/mach-k3/common.c                     | 27 ++++++++
 arch/arm/mach-k3/common.h                     | 10 ---
 arch/arm/mach-k3/include/mach/hardware.h      | 11 ++++
 arch/arm/mach-k3/r5/common.c                  | 14 +----
 board/phytec/phycore_am62ax/phycore-am62ax.c  |  8 +++
 board/phytec/phycore_am62x/phycore-am62x.c    |  8 +++
 board/ti/am62ax/evm.c                         |  8 +++
 board/ti/am62px/evm.c                         |  8 +++
 board/ti/am62x/evm.c                          |  8 +++
 board/toradex/verdin-am62/verdin-am62.c       |  3 +-
 board/toradex/verdin-am62p/verdin-am62p.c     |  3 +-
 18 files changed, 251 insertions(+), 88 deletions(-)

--
2.43.0

