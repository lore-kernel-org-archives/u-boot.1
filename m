Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E503CDB479
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 14:25:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B534A849CE;
	Tue, 23 Jun 2026 16:25:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="BV2aJ8ME";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A448849EA; Tue, 23 Jun 2026 16:15:53 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 097BF849CE
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 16:15:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 824D93F181
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 14:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782224150;
 bh=ydUXUbeo68JMZXYIRup8btws9soRBQaj56tqAo5xX/s=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=BV2aJ8MEFI+reUSeO8SylY+s07yfZXIJSwZir2uYiQ5fyvYRSAOLfVKNEjWfdmGol
 cQ2lhh8j4/FAWx501cFPJPUDxljogNJ3SZjsZHaR8A84jPgopw9eZO5BghL06W3E16
 SnpxrRn7waTL/gvRjchr801t8k7t8HhLdOfEWPkpnej30OsRmovh2OIa6equOCnL+7
 V/RcuwuZRn9iimhfWOeiEOtWLZ4sh+aiyU8SCqd14RdOPCg3aeVIyLqkA74LhkdOwQ
 ibAX1gcun2TDcfs8QMHQTZEcrFv5xI0xtKkRPFKPyCqpK/NcuuhHucWOGQJRDUwzpg
 QMyj1vm1gZK9xWK9sRbqW/ifI033wEGI8gcPl8BXGRa1nW6SB4RUzUaTKP14eQ6toc
 yTqU/ztl6C7k3Loxuzp1bgXkHRLooS9H8k6zoaqTJOZSFSw+4FMSFrm0+3HH07qFyQ
 I7oI9l2b922bNmx9T7jAJMOEiXheh9W/mvttk+0Q6hM/k4ILCHaM8d4emvrEpixMb6
 OiS4E/yh0wNLgeUSDmfmp52tBvJgmpgcGNo/GYdxywty7AniGbXsOVpv8ut9EUK8J/
 DCZ2kqRl+LqSBdVHew5VOrgYrF1shG6UWLHnjkzeLgeNRWsjSH7xYgGZ8NGsriXOwn
 rF4gRUdb6b+xcmRwg6RGw4+w=
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2c7c7fdca0cso11441075ad.2
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 07:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782224149; x=1782828949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ydUXUbeo68JMZXYIRup8btws9soRBQaj56tqAo5xX/s=;
 b=eXTq3Xj9Fwkubc/Myl8NA2ubFT7CA12Mh9iBe7vQnEvRc23gQ+PE9veEe+Jzh9k+Mn
 LS3sT6b39n5UC4BEbMO0X5Hslhk39HJTBau/aOCAOOdT1AkE1CcNMvoPQYROWNuS9HL/
 F9k38GaBnbVLtVf1YcClCjCd57/LCpo3iPBZ/C19p9aivxW5hT4MbR30WQCEANqQAM3a
 4n27GY4HA5XyndCoGah4xbJZVrCv2bdjbfRf56y1oJTTJ7adPx3Ql4q1AjmhC3ovBlvC
 nT9BGwMC62KSLqYgjtNmKBaULD5f+5FxOcG2le48CEXqRvYki7i2eeoX4TlIVuqPHIM6
 OQMA==
X-Gm-Message-State: AOJu0Yz86aZEYf1A9VmLeSyYSzD/+3tfzKjoyq8m0kD8+scVJ9T1y2LG
 GGfdp25skv5k3QZPVLkXf+J6mqT92YX6t8rhAvhwigtpwrRSV9jd9y31QuNOB+hOdOJcdTiwnIS
 ACkbM7AXKPXFZ63spwtQX+OKWolNenru6KJMfzm0kfiOxXTBGWVtEeOPdwpbH69EqF7iNgO5/bE
 Ds1nGQvQ==
X-Gm-Gg: AfdE7cn6MmyUIuZ/c2UmTeAvB44J0meeDSq9FgKJyCUUK2FZLs2nNbuRW5bl5JIgTlz
 6zp9xe4QJLgitG3stOb3do+ZIh37Wzvjf2aVfxtoAA6kC39UNnIvlQTUO9l75E4PYowK46HJ8lK
 HmjBJw7x3W7ZiSx+O3WVrt3XqHbz/W9rBYlz9U6uyaZAt1S/cW15fpw4lxUxRymqZB4f0stzgqX
 bf9GYVo8rfv1JM8sGTHksjhz5aYezbgAeJlDYRcPAjZXjv19yCxpNyr97E2lWUNdxTN0McCYEuU
 YJ62aWbhp+XEHpC12sL1g1LiH+zUblzFalJP8NCnB+ip4+/XwVcMc+mcLmhcuSCBN0TAIlR4xKZ
 dlafBEw36ELSsgoq50BbBPHh3TfZctSV4tAwHgk9DAuXUQ27SSb/IVUhlRpc1rg==
X-Received: by 2002:a17:902:e847:b0:2c7:a735:705f with SMTP id
 d9443c01a7336-2c7c992980bmr32467835ad.3.1782224148844; 
 Tue, 23 Jun 2026 07:15:48 -0700 (PDT)
X-Received: by 2002:a17:902:e847:b0:2c7:a735:705f with SMTP id
 d9443c01a7336-2c7c992980bmr32467245ad.3.1782224148149; 
 Tue, 23 Jun 2026 07:15:48 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7436d3505sm110410325ad.19.2026.06.23.07.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 07:15:47 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 0/4] arm: k3: replace tifsstub runtime filter with
 per-state FIT configurations
Date: Tue, 23 Jun 2026 14:15:14 +0000
Message-ID: <20260623141540.618272-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528132746.719699-1-aristo.chen@canonical.com>
References: <20260528132746.719699-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 23 Jun 2026 16:25:36 +0200
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

Changes since v1, all addressing review feedback from Anshul Dalal:

  1. Patch 1: use strncmp() in k3_fit_config_match_security_state()
     instead of strcmp() with a redundant ternary, since the suffix
     length is already known.

  2. Patches 1, 2 and 3: drop the CONFIG_SPL_LOAD_FIT #if guard
     around board_fit_config_name_match() on the TI EVM, phycore
     and verdin boards. SPL_LOAD_FIT is always selected on ARCH_K3
     and LTO drops the function in any build that does not use it.

  3. The move of enum k3_device_type and get_device_type() from
     arch/arm/mach-k3/common.h to arch/arm/mach-k3/include/mach/
     hardware.h in patch 1 is kept as-is. common.h is currently
     mach-k3-internal and is not in the include search path for
     board files; making it public would be a larger refactor that
     Anshul has offered to take on separately [3].

Patch 4 is unchanged from v1; Acked-by from Neha Malcom Francis and
Reviewed-by from Anshul Dalal collected on v1 are carried forward.

Patch 1 has small non-behavioral changes vs v1, so v1 tags from
Alexander Sverdlin (Reviewed-by), Neha Malcom Francis (Acked-by),
and Akashdeep Kaur (Tested-by) are not carried forward and are
pending re-confirmation against v2.

Boot tested on AM625 SK GP silicon end-to-end through TFA, OP-TEE,
A53 SPL, U-Boot proper, and Linux 6.5. The two "Skipping
authentication on GP device" messages in the SPL banner confirm only
the GP tifsstub variant is present in the selected FIT
configuration; loading any HS variant on GP silicon would fail TIFS
authentication before reaching that point. Building (R5 SPL + A53
SPL + U-Boot proper) was verified clean against v2 on am62x_evm,
phycore_am62x, and verdin-am62 defconfigs.

Akashdeep Kaur tested v1 on AM62PX HS-FS and AM62X HS-SE devices,
including deep-sleep suspend/resume. v2 changes are non-behavioral
so the same code paths exercise as v1, but explicit re-test on v2
would be welcome.

[1] https://lore.kernel.org/u-boot/20250916122244.a7rda2ouhou47hp7@bryanbrattlof.com/
[2] https://github.com/open-source-firmware/flat-image-tree/issues/32
[3] https://lore.kernel.org/u-boot/DJG933DITHOO.G8ER04I2UPWX@ti.com/

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
 board/phytec/phycore_am62ax/phycore-am62ax.c  |  6 ++
 board/phytec/phycore_am62x/phycore-am62x.c    |  6 ++
 board/ti/am62ax/evm.c                         |  6 ++
 board/ti/am62px/evm.c                         |  6 ++
 board/ti/am62x/evm.c                          |  6 ++
 board/toradex/verdin-am62/verdin-am62.c       |  5 +-
 board/toradex/verdin-am62p/verdin-am62p.c     |  5 +-
 18 files changed, 241 insertions(+), 92 deletions(-)

--
2.43.0

