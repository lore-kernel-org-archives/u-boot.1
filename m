Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFB5CD98E1
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 14:25:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BB4384895;
	Tue, 16 Jun 2026 16:25:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GGcd7MxY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 603D784895; Tue, 16 Jun 2026 16:24:59 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F11B78484C
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 16:24:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-69e49452f35so1147286eaf.1
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 07:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781619896; x=1782224696; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WbyxDQR9avKejSBGjAYNcq329WGSisPAMAKYNk3ijn4=;
 b=GGcd7MxYKtEJFilIO+KFt9nihXU7wf01Fb7+evchuj3SEDB65M33UO46k1fjdW8Ux3
 /nTDq423gxmrN7HRxBgFJ9to/JP6AiJxERMoU/42wMdRx2OScCn9Tkvc7XE9CQHG5MZV
 evUdpJpwHQznosiu4iU03Uiy21wl0nIBDtM/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781619896; x=1782224696;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WbyxDQR9avKejSBGjAYNcq329WGSisPAMAKYNk3ijn4=;
 b=Er4cQnIepkAd7Gmmf1YEsigi+idjHjBvjaZXZ8ipESKrQ/luO+IvCxn2i9M9iZ65g9
 xjKQE9AC0Yl3q5NHFzIACcUZP9orpHojC0CNpet9vhxx/UqL9q7zGBN6Oi9KfWp/Y+XU
 8INZusAl4RYesE5nLIW3ce9BPQIwIvqByk5vgYaCIypxkfwHoKsgvza+I+E3/aCzUOPz
 vhdnmVgLrqGKPFarEdJUUvIud84iU6dQfle6pF9Xg47nZyp8JIHAtzk8DHVBcTOkaumA
 DiqdzsLqfOdNehOGPXB5A+Ak+AGg37sBaxYHJzshVLn6SaVUK91NnSog9HY9I5mw74cg
 EuKg==
X-Gm-Message-State: AOJu0YwB6nKjU+VJM6URFdf7VCb8PmNZBNSjS8AUqrap329BPf1/aPQL
 uVRA6Gdi8ZYa4pibtwwmittmqg34tofobaI3a31T/c5gPv3Vm+V7LD5yaeqUXLI9dcfToBFFshB
 Pmhw=
X-Gm-Gg: Acq92OErZIW6EF6EU9/tdwe3qUnyrlIN7JYVypks5rpBw5hf5Yk6h5/uce7IBE26CKx
 PyXc6ONx8mBIq/0l3aVZdVcBSId970CJth1nK7XKwfRntkPj+GZYfOeASkPfrrPyvwPS6nRfGbq
 Ho/2pzFgcVb9Hd1uJLdW9z1Roi4p2wnM51obTCXEJqgsuTCrD1W6t4JkOMZTKpZYHSSM/Fk0F6E
 ZEPmuYUzxjgb/pYZTtK+WLvbaUO/lFQoZV4B8Ff/FqhRfq7uvRD8vAyYHtYRqv7fY4hv13lEhJE
 PaO7vJufMAqylXDmIKP6y9sEyScmThzW4m9OMeqJqbzhrqEwQ3MWiUqTt8+V78B6/hI2b2fmKDP
 zbs3bVD0qB12Le501j3ylNtjFTn9yxJDDUhGV/7g+1oVtYbBGYfSvGkQ4sZQ1vp6sg5oL/5nPbE
 USkbZSHAnhtcgUcZ/lFQ==
X-Received: by 2002:a05:6820:4dc3:b0:699:a7d1:5fd5 with SMTP id
 006d021491bc7-69eec974124mr10513790eaf.39.1781619895603; 
 Tue, 16 Jun 2026 07:24:55 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4430900e368sm2215230fac.16.2026.06.16.07.24.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 07:24:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Aristo Chen <jj251510319013@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@nabladev.com>, Michal Simek <michal.simek@amd.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>,
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>, Yannic Moog <y.moog@phytec.de>
Subject: [PATCH v2 0/5] edison: Convert the image build to binman
Date: Tue, 16 Jun 2026 08:24:15 -0600
Message-ID: <20260616142444.48193-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The Intel Edison image is assembled by a board config.mk hack that
prepends a 4KB alignment gap to u-boot.bin, plus a static OSIP-header
blob checked into the tree. This series is a cleanup of that, not a boot
fix: the mainline boot regression from the Kbuild-6.1 bump is fixed
directly by the 'Repair boards broken by the 6.1 kbuild bump' series,
which this one applies on top of.

Assemble the whole image with binman instead. A new intel-osip entry
generates the OSIP header (with the GPT-protective MBR the mask ROM
needs) and a fill provides the 4KB gap that the mask ROM's load/entry
offset requires. The gap and U-Boot are emitted together as
u-boot-edison-dfu.bin, the ready-to-flash payload for the u-boot0
partition, so a DFU update no longer needs a hand-rolled prepend. The
OSIP load address and entry point come from CONFIG_TEXT_BASE rather than
hard-coded magic numbers.

It also widens the DFU auto-probe window so an automated flash has time
to start, adds the board to the sjg-lab CI and rewrites the
documentation to separate a normal DFU update from xFSTK recovery.

Tested on real hardware: a bricked board recovers via xFSTK, takes a
fresh U-Boot over DFU and boots the result.

Changes in v2:
- Drop Bay Trail from the SoC list and add Moorefield (it is not an
  Intel MID part)
- Refer to the board as the Intel Edison in the MBR sector comment
- Write the 0x55aa boot signature as a single 16-bit value
- Derive the Edison OSIP load address and entry point from
  CONFIG_TEXT_BASE instead of hard-coding them
- Require intel,load-address and intel,entry-point rather than
  defaulting to Edison's addresses
- Reframe as a binman conversion (the boot fix is now a precursor) and
  drop the duplicate 'Fixes' tag
- Wrap the gap and U-Boot in a section emitted as u-boot-edison-dfu.bin,
  the ready-to-flash DFU payload
- Keep a reference to the stock U-Boot v2014.04 the board ships with
- Flash the binman-built u-boot-edison-dfu.bin over DFU instead of
  prepending the 4KB gap to u-boot.bin by hand
- Restore the xFSTK progress output and the note that the reconnection
  attempts are normal
- Refer to the board as the Intel Edison

Simon Glass (5):
  binman: Add an entry type for the Intel OSIP header
  edison: Widen the DFU auto-probe window for flashing U-Boot
  x86: edison: Move U-Boot alignment into binman
  CI: Add an sjg-lab job for the Intel Edison
  doc: edison: Rewrite the update instructions

 .gitlab-ci.yml                            |   6 +
 arch/x86/dts/edison.dts                   |  28 +++-
 board/intel/edison/config.mk              |  10 --
 board/intel/edison/edison-environment.txt |   2 +-
 board/intel/edison/edison-osip.dat        |   0
 doc/board/intel/edison.rst                | 178 +++++++++-------------
 tools/binman/etype/intel_osip.py          | 120 +++++++++++++++
 tools/binman/ftest.py                     |  25 +++
 tools/binman/test/entry/intel_osip.dts    |  17 +++
 9 files changed, 266 insertions(+), 120 deletions(-)
 delete mode 100644 board/intel/edison/edison-osip.dat
 create mode 100644 tools/binman/etype/intel_osip.py
 create mode 100644 tools/binman/test/entry/intel_osip.dts

---
base-commit: 7492f24148a31a1d92b1f722996e4882bd7f955a
branch: edison-us2

-- 
2.43.0

