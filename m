Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AE3C43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 10:42:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87BFA84832;
	Sun,  5 Jul 2026 12:42:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BMcYcgan";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D8528484C; Sun,  5 Jul 2026 12:42:43 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 380EB846A4
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 12:42:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7e9f69ee6f4so1850634a34.2
 for <u-boot@lists.denx.de>; Sun, 05 Jul 2026 03:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783248160; x=1783852960; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ameHD0QeNWUEkmX1ldjFBXdLMfLPwRfal8heNYF3vqk=;
 b=BMcYcganJPqsPsO0JbA7jQvvwMKhB47DdIyOn20gNvxx/wLZtMAdsairkkoFheH2Yb
 YIKT7IqE/BG87ovATPwCHQKIvqTZNG8azXj2aVcCbM6h+DEl6vJjF9F3guN4ASl9ly4x
 Waqn9f04qjJCQ8DcdiyFdusDsoDv099iWvBkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783248160; x=1783852960;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ameHD0QeNWUEkmX1ldjFBXdLMfLPwRfal8heNYF3vqk=;
 b=a/hZUL2hS1zq00u031iw9a4ppS+mLWmp8z1sZ8Ijsr46EP4sxIW/yNnmHhs9S/zWEc
 PuT4imu/X3CFajao5HoTqAoxPNg0IjRbW0QSdHOtkUeV/trkoFpz7sq/gH5PPFPdv9LO
 5IWZ6o0uoAtkPJf9LqTHhZ+Ur3h5q2ccEjebqkedIvx+vmuDmKH/165jGpvNhlZSwtuP
 YNiCKouedd44eghIa46RVhvcYBDJMczq6hs5iRlOQnHi4f4fHCY7dB6ETFL12jyZddw9
 JVM7+L6LsJavonjPwrRypjh4fOtigxWYU4sV8tmEDTGkJz3cbDgLFJbbOQs/X+B6E7kd
 g3Og==
X-Gm-Message-State: AOJu0Yz68IazxV9kr3mg0i1fqwMg3BFZy70R9QwT4qywjLMxhVI7+CMb
 mdJBiK35kMSMZWUn0cVvDMxFA/9bCChQG7PT82rtSBR/mVAYWPYgEX/iNZ3M9rGdUXD5fAdwIck
 NrgjdSw==
X-Gm-Gg: AfdE7cmVocCYmU3oxpcG0JeZIwIVdoQPbXXAl4i+pjerjfh7+blKHOoaXKakBZZAObE
 izWvaXTYjgydJE/RfbDLu3uvTVco/uALV2VbrsEG5AG+jQD70nf9VdbsJAkeZOk+t5vZ2mndp4B
 vc8vr3kj8KIF6j6YQ8HhbGL6BHu6n+tgm38OrVIX1rNGXF7TTpm20UH6MlESYQXCGXHL+q1YaU5
 js1ZnrW4sK+twjQ0VNW7QqqJW3O4Q/goxI2eaosmvAHQwerRvWRsDmPN7P7FuiCvBqJbLVWbTvb
 0GihFQ4peCoVoEmSSXXMMd9MOB+Ujpf6DaEA7WoiHHxaqHs0H5OYfcJ4Ps40acKAi3uttVoexBy
 GgKU4mBrPwclj2mKZIB4FSALPcOjZc611oz6/jaTaJJUxt9k8GZ0VcQp5ONZjx0WBVREdMfPRZt
 1OWKjEjFs=
X-Received: by 2002:a05:6830:6ae8:b0:7e9:dc88:f10a with SMTP id
 46e09a7af769-7eb7ff1bdc6mr3930195a34.18.1783248159918; 
 Sun, 05 Jul 2026 03:42:39 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7eb54291227sm9136961a34.3.2026.07.05.03.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 03:42:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Aristo Chen <jj251510319013@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@nabladev.com>, Michal Simek <michal.simek@amd.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>,
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Subject: [PATCH v3 0/5] edison: Convert the image build to binman
Date: Sun,  5 Jul 2026 04:42:11 -0600
Message-ID: <20260705104231.3846672-1-sjg@chromium.org>
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

Changes in v3:
- Update the copyright line
- Drop trailing space in ftest.py
- Round U-Boot's size up to a 4KB boundary
- Drop the manual 'truncate -s %4096' step which is no longer needed

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
 arch/x86/dts/edison.dts                   |  35 ++++-
 board/intel/edison/config.mk              |  10 --
 board/intel/edison/edison-environment.txt |   2 +-
 board/intel/edison/edison-osip.dat        |   0
 doc/board/intel/edison.rst                | 182 ++++++++++------------
 tools/binman/etype/intel_osip.py          | 120 ++++++++++++++
 tools/binman/ftest.py                     |  25 +++
 tools/binman/test/entry/intel_osip.dts    |  17 ++
 9 files changed, 277 insertions(+), 120 deletions(-)
 delete mode 100644 board/intel/edison/edison-osip.dat
 create mode 100644 tools/binman/etype/intel_osip.py
 create mode 100644 tools/binman/test/entry/intel_osip.dts

---
base-commit: 2569e25ddd5aa323cd87c7a3819c3a4f4b32302f
branch: edison-us3

-- 
2.43.0

