Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78ED3CD8CA4
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 23:05:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 964C4838BB;
	Mon,  8 Jun 2026 01:05:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FgHvSvJk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D5E0841C2; Mon,  8 Jun 2026 01:05:30 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5545B83314
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 01:05:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-440dcd6406aso1330691fac.1
 for <u-boot@lists.denx.de>; Sun, 07 Jun 2026 16:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780873527; x=1781478327; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XoV7cX4TDjND/c7abhb2QDgAkvoTWaToG/egJDE2YEw=;
 b=FgHvSvJkML7GyUIYKUMxICEcsIqFnflUc5zYHH6oazDtTpG+1aJFrJred1EF2OMz3O
 WWw5DPn5GSlhMT1MNVH/zOnDO39xbo5CCEktjWRaN3F+RQTPIzH2j5KHyCR9kiXu83Pn
 42eX4mxjwAgnjJNFM9CAxln+Er8ZVhDeH4KFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780873527; x=1781478327;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XoV7cX4TDjND/c7abhb2QDgAkvoTWaToG/egJDE2YEw=;
 b=mzM52i1XnPVx+MsN5/7HXoDR24EZHnW6CoR5B6YZtsZVOo/bO3UwFqp1NCc+pfuzuv
 kZQC4NbdqFgFIsYv16WIom6ePMRD4Id4Dk0i+qdNs4O10MJHnH425NXAkjIp2drhGQze
 8jFZsr4GNsn+/WBrcveTFnSUzLyUeeIFIksr20LME3X+/F4LKSyt61lPIKGqfoScTeOT
 NEQ/hQaUVqA1bD410gjvYAojER4oOL+v7vbeYwO7TU4PWSqF/ZVX3S2RGRRvSRHWThnl
 Z/UKQiHUiw/R/ywYkPA487r6hvRtGSyxRazTQNttigdOVV4A6+OcjPMvhxNNFXzBIPLE
 MSrw==
X-Gm-Message-State: AOJu0Yy55WvIY6uiFD5sK/fta5a4kdn8CyRLH/23pPeUeKx2fd1DuOTc
 W5FDlEJaoVHb2zYuzMwV5NRILZO093y/ZAOwrRXbtOk2T6vzhTRk56inH5GSYPqEGnDOderAPgR
 CWrkBhA==
X-Gm-Gg: Acq92OGvgAisCqbJThJZFpV4MRBANs6JjW8GNHkM4dO502IrdmP4qmVjkfWr5UHziTz
 QBjHrMXBPrHCLUHk91YhtXzmY4nXTvyUt7bcscQjBCJ4hUTPPAy2Q38R9Je0AlXmw5b/jCLO9uE
 E6K/ZhAy9PdtV4pu59QSV4xtgbuXMBonH9TMEPdEDx5RIDqmCnZx8KMgO8hQsdbu64Zpsa9CkcJ
 ASLORf2l2UjK5926QsHWp4JDUwko5iFuub4gQ6Yp13bRYEwzzse8aJ1FHzEN1ZC+HMVdI1IJvlI
 St8bQgUu45kCLJlXg5NzcK2J770cAQkjgXLFz7dtEP37U2oSBWaHd9dBoijZ7U1WhL4Nbc5BKsb
 i+xVyCT7cW0K2tTfWB7U5jL0hPwEeNHNB/zyHwzp83S9UhFyV0iS3opALLwAPEQLOR4iq7W5SKD
 k350g+usOAjQIUvdPY8udY7Ss6uIg5
X-Received: by 2002:a05:6871:6206:b0:42f:24c4:e317 with SMTP id
 586e51a60fabf-4413d3c2408mr6992462fac.14.1780873527047; 
 Sun, 07 Jun 2026 16:05:27 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-440d7d4f449sm13916389fac.8.2026.06.07.16.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 16:05:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Aristo Chen <jj251510319013@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>,
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>, Yannic Moog <y.moog@phytec.de>
Subject: [PATCH 0/5] edison: Fix mainline boot and convert the image to binman
Date: Sun,  7 Jun 2026 17:05:09 -0600
Message-ID: <20260607230519.3022520-1-sjg@chromium.org>
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

Mainline U-Boot does not boot on the Intel Edison. The mask ROM enters
the OS image 0x1000 above its load address, so U-Boot needs 4KB of zero
padding ahead of it. That padding used to come from an alignment rule in
board/intel/edison/config.mk, but the Kbuild-6.1 bump stopped that input
being built, so u-boot.bin now starts with code at offset 0 and the ROM
jumps into the middle of it.

This series moves the image build into binman: a new intel-osip entry
generates the OSIP header (with the GPT-protective MBR the mask ROM
needs) and a fill provides the 4KB gap, replacing the config.mk hack and
restoring the boot. It also widens the DFU auto-probe window so an
automated flash has time to start, adds the board to the sjg-lab CI and
rewrites the documentation to separate a normal DFU update from xFSTK
recovery.

Tested on real hardware: a bricked board recovers via xFSTK, takes a
fresh U-Boot over DFU and boots the result.


Simon Glass (5):
  binman: Add an entry type for the Intel OSIP header
  edison: Widen the DFU auto-probe window for flashing U-Boot
  x86: edison: Align U-Boot via binman to fix the boot
  CI: Add an sjg-lab job for the Intel Edison
  doc: edison: Rewrite the update instructions

 .gitlab-ci.yml                            |   6 +
 arch/x86/dts/edison.dts                   |  16 +-
 board/intel/edison/config.mk              |  10 --
 board/intel/edison/edison-environment.txt |   2 +-
 board/intel/edison/edison-osip.dat        |   0
 doc/board/intel/edison.rst                | 187 ++++++++--------------
 tools/binman/etype/intel_osip.py          | 121 ++++++++++++++
 tools/binman/ftest.py                     |  25 +++
 tools/binman/test/entry/intel_osip.dts    |  17 ++
 9 files changed, 251 insertions(+), 133 deletions(-)
 delete mode 100644 board/intel/edison/edison-osip.dat
 create mode 100644 tools/binman/etype/intel_osip.py
 create mode 100644 tools/binman/test/entry/intel_osip.dts

---
base-commit: 9e87893c24d1f21350e69bc222e6a3214c933b3b
branch: edison-us

-- 
2.43.0

