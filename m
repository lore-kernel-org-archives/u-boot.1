Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AD8C3DA49
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 10:50:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9F24886F0;
	Sat, 20 Jul 2024 12:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LBDabgi7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DACA88403; Sat, 20 Jul 2024 12:50:03 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 262FC886CC
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 12:50:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-427cede1e86so17702345e9.0
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 03:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721472600; x=1722077400; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=N1URo5lpdArq6ZLUUTgYYbpqkFmRX+YZIqGU3L3RqZk=;
 b=LBDabgi7+w/2aI86uAP0bPsi16aTIGvvn0DROQk/M8gyLUYFvi516vDPIuH0xl2Sub
 83hNNPcADZyzF+ER+iCL0nl5NtKz7U2gx7ouA0VJFJHQr3ZchEFaCrCOVmDYFu3aldAU
 pdf8NS8Hlygmws5mnV9soS6VlFarSKnNIdxP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721472600; x=1722077400;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N1URo5lpdArq6ZLUUTgYYbpqkFmRX+YZIqGU3L3RqZk=;
 b=UX84DCwGxMmVSvxbamIx3J0S8eY4wVdx1h5MNHzeHptPPqC8m5Pko7kpGNzLFmgfjA
 ECo2WH/56R3XeP9ISy585nClt1OuDr6dZjtooFUWqccW0sUHO5FxAzSSY08h+Ww2ZUxu
 U5Kb/UYtDSta9N9iDNov+PZfMDNCyce5ppFsBRojtueReCcdO03nSwTfvemrQX1oAqqd
 5dcGjIP2XKjbXdubKcHNCp9j2ftVkKWHHMIUL4rgOhUX/UfmoskIIWhL0aU68Gi8/G1f
 6ckPGhNPDe93rJZA2QoKWapgANKZ2+xLHZoyXMiDOeMZvGrFFamCGrHhlNR2uIgM/Kng
 GwVw==
X-Gm-Message-State: AOJu0YyQ5BbHWR7/l7fZeNB0ttT3GUjJCCDtX776G/7RkHSMvURj+Eo6
 Zqykg1qOc6V1s7mBNdFmd3EjJcigKTxgulNPUHwVXiNLRW5vWRCopLeP9g8JX+hRO6svyLIOPTE
 =
X-Google-Smtp-Source: AGHT+IH0PDV+nRxGcp5DDixqx4yTnNyqgJJdr0sNAijBl/9AwmphZUzqhur94PnBNeTNQrqwE8krcA==
X-Received: by 2002:a05:600c:4f0d:b0:426:5ee5:3129 with SMTP id
 5b1f17b1804b1-427dc515367mr7502185e9.2.1721472600224; 
 Sat, 20 Jul 2024 03:50:00 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684225sm3715616f8f.9.2024.07.20.03.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jul 2024 03:49:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andrew Davis <afd@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Brandon Maier <brandon.maier@collins.com>,
 Bryan Brattlof <bb@ti.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 00/20] binman: Enhance FIT support for firmware
Date: Sat, 20 Jul 2024 11:49:30 +0100
Message-Id: <20240720104950.2730773-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

So far Binman's FIT support is designed for booting the OS. But FIT is
also used to hold firmware images.

One missing feature is the ability to produce the smaller FDTs used by
SPL builds.

This series adds this, running fdtgrep on each devicetree to create the
correct one for each model, for a particular boot phase. This allows,
for example, a particular SPL image + devicetree combination to be
selected during boot.


Simon Glass (20):
  fixdep: Support VPL
  binman: Correct an error in the FIT-template example
  binman: Tidy up bintool docs
  binman: Tidy up comment for Bintoolfdt_add_pubkey.run()
  binman: Move problem-checking code into a function
  binman: elf: Add more debugging to LookupAndWriteSymbols()
  binman: Write the compressed output to a file
  binman: Correct comment in blob_dtb GetFdtEtype()
  binman: Mention expanded entries in u-boot-vpl
  binman: Fix a comment typo in _DoReadFileDtb()
  binman: Correct indentation in testSplPubkeyDtb
  binman: Add a bintool for fdtgrep
  binman: Remove dependency on pylibfdt for entry-docs
  binman: Allow entry types to override FDT contents
  binman: Add support for alternative FDTs
  binman: fit: Allow providing FDT filenames in a directory
  binman: fit: Write the compatible string to configuration
  binman: fit: Allow running fdtgrep on devicetree blobs
  Makefile: Provide VPL devicetree and padding to binman
  Makefile: Pass OF_SPL_REMOVE_PROPS to binman

 Makefile                                     |   3 +
 doc/develop/spl.rst                          |   2 +
 scripts/basic/fixdep.c                       |   2 +
 tools/binman/binman.rst                      |   4 +-
 tools/binman/bintools.rst                    |  69 +++--
 tools/binman/btool/fdt_add_pubkey.py         |   4 +
 tools/binman/btool/fdtgrep.py                | 137 ++++++++++
 tools/binman/control.py                      |  77 +++---
 tools/binman/elf.py                          |   2 +-
 tools/binman/entries.rst                     |  94 ++++++-
 tools/binman/entry.py                        |  17 ++
 tools/binman/etype/alternates_fdt.py         | 132 ++++++++++
 tools/binman/etype/blob_dtb.py               |   8 +-
 tools/binman/etype/fit.py                    |  93 ++++++-
 tools/binman/etype/u_boot_spl_nodtb.py       |   2 -
 tools/binman/etype/u_boot_tpl_nodtb.py       |   2 -
 tools/binman/etype/u_boot_vpl.py             |   3 +
 tools/binman/etype/u_boot_vpl_nodtb.py       |   4 +-
 tools/binman/ftest.py                        | 255 +++++++++++++++++--
 tools/binman/image.py                        |  24 ++
 tools/binman/main.py                         |   2 +
 tools/binman/test/328_alternates_fdt.dts     |  28 ++
 tools/binman/test/329_alternates_fdtgrep.dts |  29 +++
 tools/binman/test/330_alternates_vpl.dts     |  29 +++
 tools/binman/test/331_alternates_spl.dts     |  29 +++
 tools/binman/test/332_alternates_inval.dts   |  29 +++
 tools/binman/test/333_fit_fdt_dir.dts        |  58 +++++
 tools/binman/test/334_fit_fdt_compat.dts     |  60 +++++
 tools/binman/test/335_fit_fdt_phase.dts      |  61 +++++
 tools/binman/test/alt_dts/model1.dts         |  24 ++
 tools/binman/test/alt_dts/model2.dts         |  24 ++
 31 files changed, 1208 insertions(+), 99 deletions(-)
 create mode 100644 tools/binman/btool/fdtgrep.py
 create mode 100644 tools/binman/etype/alternates_fdt.py
 create mode 100644 tools/binman/test/328_alternates_fdt.dts
 create mode 100644 tools/binman/test/329_alternates_fdtgrep.dts
 create mode 100644 tools/binman/test/330_alternates_vpl.dts
 create mode 100644 tools/binman/test/331_alternates_spl.dts
 create mode 100644 tools/binman/test/332_alternates_inval.dts
 create mode 100644 tools/binman/test/333_fit_fdt_dir.dts
 create mode 100644 tools/binman/test/334_fit_fdt_compat.dts
 create mode 100644 tools/binman/test/335_fit_fdt_phase.dts
 create mode 100644 tools/binman/test/alt_dts/model1.dts
 create mode 100644 tools/binman/test/alt_dts/model2.dts

-- 
2.34.1

