Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3259CCCFA10
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 02:47:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B7AA8891E;
	Thu, 26 Sep 2024 04:47:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b1SPcICY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3925688CB8; Wed, 25 Sep 2024 14:57:02 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DE9088C7C
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 14:56:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2f74e613a10so102363591fa.1
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 05:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727269017; x=1727873817; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TBhqg6rrOsSPl3tFjeJPPeRGg22MQOEOeY4bFAHpkXQ=;
 b=b1SPcICYrotLl3HyHpTfGLUur3u/GJlHDRzttPuyFqBGVr08KLYTmdrU/UkxALNOq5
 Vc9q4QmNW3fQj4VNdUEHmNHgPmgzvZg9Oi3q+uuFArdl9jd7Oxun4NJ7Dt5QO6I58cWQ
 mszdWpAdslrdpNj67t1fBFiCd9U4Uyoxy1oCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727269017; x=1727873817;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TBhqg6rrOsSPl3tFjeJPPeRGg22MQOEOeY4bFAHpkXQ=;
 b=sOsTv3O2IoP/5nPvs3SZx066ZLCv65d/uGg5K2yZD5Gs6eXDkP4PUc9L8OwXfHMrh4
 FJ8hmjZywd0PVfQ+R0SXwkA3Eq605rsAPFBzWj5C4BokJxLcRWPppOBHJG2Hy+fNlUfA
 P+ETGX3dOK/fwlqm3on9rzhpBVxk94g2bz9gCtdEn9ZXtTG/lFUtfRYYCHjIdwq+zm6W
 +pTZH6dlkN0iI3NKi3NYe1O5bpis2LIT6gm3YUJc/6dQ2Qnx1L4UXvQSR9jpetd/uvkY
 TyrOEQwDVvlQti8PpvtiGB9hNV5NdMzmF1RgGp2DXtpdcTPwAOtAk2GYkQiapFmGOTL/
 6K7g==
X-Gm-Message-State: AOJu0Yy2yf3cDDX3se9Wu4VdHKV7JYhBkfsERYQc6HPybFJUNtT98wm6
 oYohivds+bjFrd8jRv8ViNSMQaEb4FXNcHvQFBsDhqp5QRY7/EikMHvtGoeXHzueDF0OLvv+i8N
 RMg==
X-Google-Smtp-Source: AGHT+IFTgBKVQB2+Svfj82U46KunEpR9r22frwRpvBYIrZ1uRKoqgci8MINhw04VSUq3w6mrtcnWKQ==
X-Received: by 2002:a05:6512:138d:b0:536:5339:35a6 with SMTP id
 2adb3069b0e04-5387756657emr1974019e87.53.1727269017147; 
 Wed, 25 Sep 2024 05:56:57 -0700 (PDT)
Received: from chromium.org ([82.132.187.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93930f7889sm209209766b.179.2024.09.25.05.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 05:56:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Andre Przywara <andre.przywara@arm.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Andrew Davis <afd@ti.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 Devarsh Thakkar <devarsht@ti.com>, Gary Bisson <bisson.gary@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>, Sam Edwards <CFSworks@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 00/19] spl: Support a relocating jump between phases (VBE part
 F)
Date: Wed, 25 Sep 2024 14:55:26 +0200
Message-ID: <20240925125622.197915-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Sep 2024 04:47:21 +0200
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


This series includes a way to deal with multiple XPL phases being
built to run from the same region of SRAM. This is useful because it may
not be possible to fit all the different phases in different parts of
the SRAM. Also it is a pain to have to build them with different values
for CONFIG_TEXT_BASE such that they can be loaded at different
addresses.

The mechanism is to copy some relocation code to the top of memory, then
load the next phase below that. Finally, the first phase jumps to the
relocation code, which copies or decompresses the next phase,
overwriting the first phase in the process. Finally, the relocation code
jumps to the start of the next phase.

In this way the maximum amount of space can be used, particular if the
next phase is compressed.

For this to work, some code in U-Boot must be placed in a 'rcode'
(relocation code) section. This ensures it can be copied as a block,
thus reducing the amount of the first-stage code which needs to survive
the relocation process.

For now there is a qemu-arm64 test for this feature, which ensures that
the basic mechanism is sound. Further work will likely expand this test
to include VPL and LZ4-compression, which so far have only been used on
real hardware.

Overall, without SPL_RELOC_LOADER enabled, this series provides a very
small code-size benefit due to it dropping some unneeded symbols.


Simon Glass (19):
  spl: Reduce the size of the bl_len field
  spl: Provide a way of indicating the phase to load
  spl: Avoid including hash algorithms which are not wanted
  spl: Provide a way to mark code needed for relocation
  lib: Mark crc8 as relocation code
  lib: Mark lz4 as relocation code
  lib: Mark memcpy() and memmove() as relocation code
  spl: Add a type for the jumper function
  spl: Add support for a relocating jump to the next phase
  spl: Plumb in the relocating loader
  spl: Support jumping to VPL from TPL
  spl: Record the correct name of the next phase
  spl: Show how to fill in the size of the next image
  spl: Add debugging in spl_set_header_raw_uboot()
  arm: qemu: Allow SPL and TPL
  arm: Add a new qemu_arm64_tpl board
  arm: Provide an rcode section in ARMv8 link script
  arm: qemu_arm64_tpl: Enable the relocating loader
  CI: Add new test for reloc loader

 .azure-pipelines.yml                  |   3 +
 .gitlab-ci.yml                        |   6 +
 MAINTAINERS                           |   6 +
 arch/arm/Kconfig                      |   2 +
 arch/arm/cpu/armv8/u-boot-spl.lds     |   8 ++
 arch/arm/dts/qemu-arm64.dts           |  17 +++
 arch/arm/mach-qemu/Kconfig            |  20 +++
 board/emulation/qemu-arm/Kconfig      |   2 +-
 board/emulation/qemu-arm/MAINTAINERS  |   5 +
 board/emulation/qemu-arm/Makefile     |   1 +
 board/emulation/qemu-arm/qemu-arm.env |   4 +
 board/emulation/qemu-arm/xpl.c        |  50 +++++++
 common/spl/Kconfig                    |   9 ++
 common/spl/Kconfig.tpl                |   9 ++
 common/spl/Kconfig.vpl                |   8 ++
 common/spl/Makefile                   |   1 +
 common/spl/spl.c                      |  45 +++++--
 common/spl/spl_reloc.c                | 182 ++++++++++++++++++++++++++
 configs/qemu_arm64_tpl_defconfig      |  83 ++++++++++++
 doc/develop/spl.rst                   |  35 +++++
 include/asm-generic/sections.h        |  16 +++
 include/spl.h                         |  57 +++++++-
 lib/Makefile                          |   6 +-
 lib/crc8.c                            |   5 +-
 lib/lz4.c                             |  27 ++--
 lib/lz4_wrapper.c                     |   2 +-
 lib/string.c                          |   5 +-
 test/py/tests/test_reloc.py           |  21 +++
 28 files changed, 604 insertions(+), 31 deletions(-)
 create mode 100644 board/emulation/qemu-arm/xpl.c
 create mode 100644 common/spl/spl_reloc.c
 create mode 100644 configs/qemu_arm64_tpl_defconfig
 create mode 100644 test/py/tests/test_reloc.py

-- 
2.43.0

