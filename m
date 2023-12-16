Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90001C4332F
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 03:54:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A326887708;
	Sat, 16 Dec 2023 04:54:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Mf4kuIPd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5614187A9B; Sat, 16 Dec 2023 04:14:58 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9308587B52
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 04:14:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-35da85e543eso5830465ab.0
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702696492; x=1703301292; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pSDc3axz2law/Mah60bpFK2zYIVNZKAwnpUbLns/heI=;
 b=Mf4kuIPd0MKb8K2CFfJN9KeKnB/5I/84nk/fCsxizGCc4IC0cLhJb0RDu0FH/L+GXm
 GzGvHoQij48jbz4GRK1wALayu2bm+l5Nm4i9Ysd3GKZKKukBb0BGMZF+KHxOb15jQErK
 7IRSPCiCVt2zmprlVRR7rEGd/w6GQo82HILNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702696492; x=1703301292;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pSDc3axz2law/Mah60bpFK2zYIVNZKAwnpUbLns/heI=;
 b=na1/qIvXPQUNLhGW2d1hJUkwUOdiZKRCwGhube/+JxnUlIlkdbOxzNAsrq3efvbIKa
 K1cYGXUcexMzAC+CYH0LfOSfYFi+2tB2OpwKsUHMNfV/Lev6MmnOX9/dizYGG5IKuE5r
 yLL8EeWayXY0oiOKlnlKqXzhlazDR6lzS8/OOhuXt+sZu7IczFjChxH8aKgp41+PbB2J
 LVbNtQ9nstKv6TlaRsbvAHMHucbb1UMTtdSHL7z7q+af/2OW6D2jtUOe99hwnv/2zvw8
 peBjPCDsRQKNDykJI2z3SyllLR+z3CYe+7l/MbQ11HF6mRomLTvNz5Y9LMeerPGMF55Q
 U83g==
X-Gm-Message-State: AOJu0YxiYqlk21HBJiYPjFoyb0I6fs+yBirtBzYdjQfvItW8O+4oNYKh
 lL8x4JBDOEhU6/nMYp9pmyHBBnBT2lmS+QiNk7R31w==
X-Google-Smtp-Source: AGHT+IHhrj01Ckbkc01UL/B61aZCWuu9+XCar4O970M4/VuAk5qndCgyqx6if2QRvfM2YgxRZfNreQ==
X-Received: by 2002:a05:6e02:1a8b:b0:35f:847c:1e45 with SMTP id
 k11-20020a056e021a8b00b0035f847c1e45mr4551660ilv.28.1702696492016; 
 Fri, 15 Dec 2023 19:14:52 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a92ceca000000b0035f75e80d1esm542163ilq.52.2023.12.15.19.14.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 19:14:51 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Alison Wang <alison.wang@nxp.com>, Andy Fleming <afleming@gmail.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Angelo Dureghello <angelo@sysam.it>, Bin Meng <bmeng.cn@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Eddie James <eajames@linux.ibm.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo <ycliang@andestech.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@denx.de>, Mario Six <mario.six@gdsys.cc>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Nikita Shubin <n.shubin@yadro.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Rick Chen <rick@andestech.com>,
 Safae Ouajih <souajih@baylibre.com>, Scott McNutt <smcnutt@psyent.com>,
 Sean Anderson <sean.anderson@seco.com>, Stefan Roese <sr@denx.de>,
 Thomas Chou <thomas@wytron.com.tw>, Wolfgang Denk <wd@denx.de>,
 uboot-snps-arc@synopsys.com, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3 00/22] Complete decoupling of bootm logic from commands
Date: Fri, 15 Dec 2023 20:14:04 -0700
Message-ID: <20231216031446.2222362-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 16 Dec 2023 04:54:52 +0100
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

This series continues refactoring the bootm code to allow it to be used
with CONFIG_COMMAND disabled. The OS-handling code is refactored and
a new bootm_run() function is created to run through the bootm stages.
This completes the work.

A booti_go() function is created also, in case it proves useful, but at
last for now standard boot does not use this.

This is cmdd (part d of CMDLINE refactoring)
It depends on dm/bootstda-working
which depends on dm/cmdc-working

Changes in v3:
- Rename addr_fit to addr_img in struct bootm_info
- Rename addr_fit to addr_img in struct bootm_info
- Enable CONFIG_MEASURED_BOOT always and rely on CONFIG_MEASURED_BOOT
- Rename addr_fit to addr_img in struct bootm_info
- Add new boot_run() function

Changes in v2:
- Add new patch to enable more bootm OS methods in sandbox
- Split addition of struct bootm_info to its own patch
- Split changing of boot_os_fn parameters to a separate patch
- Split out adding the rest of struct bootm_info fields to separate patch
- Split out patch to move do_bootm_states() comment to header
- Split out booti removal of #ifdef
- Split out bootz removal of #ifdef
- Adjust patch to focus just on dropping the do_bootm_states() arguments
- Split do_bootm_states() rename to a separate patch
- Rework series to allow OS access to cmdline arguments for bootm

Simon Glass (22):
  mips: Add a reset_cpu() function
  m68k: Add a reset_cpu() function
  ppc: Add a reset_cpu() function
  nios2: Add a reset_cpu() function
  riscv: Add a reset_cpu() function
  bootm: Adjust how the board is reset
  sandbox: bootm: Enable more bootm OS methods
  bootm: Create a struct for argument information
  bootm: Adjust arguments of boot_os_fn
  bootm: Add more fields to bootm_info
  bootm: Move do_bootm_states() comment to header file
  booti: Avoid use of #ifdef
  bootz: Avoid use of #ifdef
  bootm: Drop arguments from do_bootm_states()
  bootm: Rename do_bootm_states() to bootm_run_states()
  bootm: Tidy up boot_selected_os()
  bootm: Create a function to run through the bootm states
  stm32: Use local vars in stm32prog for initrd and fdt
  bootm: Create a function to run through the bootz states
  stm32: Use bootm_run() and bootz_run()
  bootm: Create a function to run through the booti states
  bootm: Create a new boot_run() function to handle booting

 arch/arc/lib/bootm.c                          |   5 +-
 arch/arm/lib/bootm.c                          |   6 +-
 .../cmd_stm32prog/cmd_stm32prog.c             |  33 ++--
 arch/m68k/lib/bootm.c                         |   5 +-
 arch/m68k/lib/traps.c                         |   7 +
 arch/microblaze/lib/bootm.c                   |   6 +-
 arch/mips/cpu/cpu.c                           |   8 +-
 arch/mips/lib/bootm.c                         |   8 +-
 arch/nios2/cpu/cpu.c                          |   8 +-
 arch/nios2/lib/bootm.c                        |  10 +-
 arch/powerpc/lib/bootm.c                      |   5 +-
 arch/powerpc/lib/traps.c                      |  10 ++
 arch/riscv/cpu/cpu.c                          |  13 ++
 arch/riscv/lib/bootm.c                        |  11 +-
 arch/riscv/lib/reset.c                        |   7 +-
 arch/sandbox/cpu/cpu.c                        |   8 +
 arch/sandbox/lib/bootm.c                      |   5 +-
 arch/sh/lib/bootm.c                           |   6 +-
 arch/x86/lib/bootm.c                          |   6 +-
 arch/xtensa/lib/bootm.c                       |   4 +-
 boot/bootm.c                                  | 119 ++++++++-------
 boot/bootm_os.c                               |  78 +++++-----
 cmd/booti.c                                   |  55 ++++---
 cmd/bootm.c                                   |  43 ++++--
 cmd/bootz.c                                   |  35 +++--
 configs/sandbox_defconfig                     |   3 +-
 include/bootm.h                               | 142 ++++++++++++++++--
 27 files changed, 444 insertions(+), 202 deletions(-)

-- 
2.43.0.472.g3155946c3a-goog

