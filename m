Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A28C4167B
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 16:55:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DA5D87B57;
	Thu, 14 Dec 2023 17:52:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J/qF1spg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E79887AC5; Thu, 14 Dec 2023 17:51:45 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77FE687ACA
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:51:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-35f418f394dso23454065ab.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 08:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702572701; x=1703177501; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s+dxsgUPBLoTcoQWhp34wtg56IrCFS8NnHBImkU+8po=;
 b=J/qF1spg8gl7VMlAJlRBPjOdbulsSsWp1ZYpLUv4Aorw16mV1VuEQKThCqpu2gHFaE
 tuhCbn94EkbbHmKGHSVKIiLZAXc2w+FzdEr6entZmPojrAl/d1WucC3qmWeTibRXsiEA
 7MsLtagdkkOBqFFR32fVih1oHltuDVDfnRkGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702572701; x=1703177501;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s+dxsgUPBLoTcoQWhp34wtg56IrCFS8NnHBImkU+8po=;
 b=a4El0OGA7XLo8G6vupvYfi0PAsDVG14sJI0W3sQeLWNaYuFmabct7sAuing5C1CgSh
 kYeuT3fs7V5UQtt5Q3942KSfosXpRAMWJjJPN/wJYQhWhthLElQXDZTglBnWOl9H/6Sw
 21Sc2Ky3ZnGhYL+o/3llhKguM934dKZASd9o2juti1JH3+Id3JH6IV0qmU+x4ZhbVLvG
 7d7qvdZ/kBTAnOinzfcSD7v6AQ2Ye1IJYFixdkj/uHDroerjJBO3tptchOno8HqCJJu8
 aCiPi707FzbEDWV5Jdwf3qv9LYlKklJuUNUsDjv3OF5GgnoJE0eX1MHCxhLFUTXcepTF
 V0Rg==
X-Gm-Message-State: AOJu0YxMJLosr0czObaG5QreSO5gzXX4/PEaI6js9GH98aweIAiCbJVa
 9kCKEg74jfGMEbsX8Ue1brWNTslruR8509c82lzZsQ==
X-Google-Smtp-Source: AGHT+IHS2iJlKsxPLqFzkMQCoWrul5SQ4wQK2/jFrYNWbggtR5tiixU+SyrMXiXWgPxymrcyV6WDRw==
X-Received: by 2002:a05:6e02:1b85:b0:35e:6b86:3c1e with SMTP id
 h5-20020a056e021b8500b0035e6b863c1emr14352739ili.34.1702572700998; 
 Thu, 14 Dec 2023 08:51:40 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 bn14-20020a056e02338e00b00357ca1ed25esm1228347ilb.80.2023.12.14.08.51.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 08:51:40 -0800 (PST)
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
Subject: [PATCH v2 00/21] Complete decoupling of bootm logic from commands
Date: Thu, 14 Dec 2023 09:50:09 -0700
Message-ID: <20231214165112.2182274-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 14 Dec 2023 17:52:15 +0100
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

Simon Glass (21):
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

 arch/arc/lib/bootm.c                          |   5 +-
 arch/arm/lib/bootm.c                          |   6 +-
 .../cmd_stm32prog/cmd_stm32prog.c             |  33 +++--
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
 arch/sandbox/cpu/cpu.c                        |   8 ++
 arch/sandbox/lib/bootm.c                      |   5 +-
 arch/sh/lib/bootm.c                           |   6 +-
 arch/x86/lib/bootm.c                          |   6 +-
 arch/xtensa/lib/bootm.c                       |   4 +-
 boot/bootm.c                                  | 133 ++++++++++--------
 boot/bootm_os.c                               |  78 +++++-----
 cmd/booti.c                                   |  55 +++++---
 cmd/bootm.c                                   |  43 ++++--
 cmd/bootz.c                                   |  35 +++--
 configs/sandbox_defconfig                     |   3 +-
 include/bootm.h                               | 124 ++++++++++++++--
 27 files changed, 440 insertions(+), 202 deletions(-)

-- 
2.43.0.472.g3155946c3a-goog

