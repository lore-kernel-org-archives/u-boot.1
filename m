Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B20EC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:45:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F5188786E;
	Mon,  4 Dec 2023 01:45:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hVwl/tLC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FEA28761C; Mon,  4 Dec 2023 01:27:06 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FD76875F5
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:27:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d05e4a94c3so20785175ad.1
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649620; x=1702254420; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lt7lqo/R80Vzc2dGKtG5JaZ1IJx77c/da4liznlSojA=;
 b=hVwl/tLCrQygxNckSw4w0ZE6WdbPZWQJPU0hcM6AW0aBMFG/dBQt0iuTZVPZqfpBjN
 skw5QyUuQ18JS6ES5XzVftxio3H71M9koWfvgJhcOAIraRNFfNnG05c3btfvvGdTDxPl
 qy1AMsKsKuNvqD1Fb8MOCn1skQoUu7VQgpatM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649620; x=1702254420;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lt7lqo/R80Vzc2dGKtG5JaZ1IJx77c/da4liznlSojA=;
 b=CclUCiF7YmeriBWS2v+w8nkTk9xbj3kp6Htujrh67rpfDDFhPiZ56sZzggVeR4eVnt
 y/QkpraRjMf+KIkes4tDPwv73ke+e0neLkuislReUWpuhdRsELqIyn4V72KvJxBxnyAv
 IQK1w1rJOaDB9vCZRojLyl7iyWcdycIaF9138C8hCKrxjeHa/J6JQDYRZ5P/GA3qIqkf
 6Ax4HVl63GRaeOL3E3En92iFJcSWuVVPI91nPjjKGSAfOvmi1WaGNR8Xs9kKd1OW6BtG
 RqRgigpLDt52YMgoqc9Lo63YrngpaXqLuQAnfdHlIKIcaCSSipq6WL1xM3Dqg9180jR6
 qqmg==
X-Gm-Message-State: AOJu0YxUrxz32Ic8jhdnC+oFIps4nOYBNwzvaPhpR9fyK1UNBMfwZp2t
 H0eA8Pad/b+QENNZ8XLZPHltVLQAaM1mzUbjW6y1Qg==
X-Google-Smtp-Source: AGHT+IFfFxkG+TNrwktrxm61JgA3IwiaWUc+sbcLZNvMg1cQ3tjzrUmFYygzE8bH/OrKyIcqtXNQGQ==
X-Received: by 2002:a17:902:6946:b0:1d0:6ffe:a22 with SMTP id
 k6-20020a170902694600b001d06ffe0a22mr3035925plt.128.1701649620375; 
 Sun, 03 Dec 2023 16:27:00 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a170902904500b001cfb971edfasm7097227plz.205.2023.12.03.16.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:26:59 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Alison Wang <alison.wang@nxp.com>, Andy Fleming <afleming@gmail.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Angelo Dureghello <angelo@sysam.it>, Bin Meng <bmeng.cn@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Eddie James <eajames@linux.ibm.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
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
 Thomas Chou <thomas@wytron.com.tw>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>,
 Wolfgang Denk <wd@denx.de>, uboot-snps-arc@synopsys.com,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 00/18] Complete decoupling of bootm logic from commands
Date: Sun,  3 Dec 2023 17:26:16 -0700
Message-ID: <20231204002642.895926-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 04 Dec 2023 01:45:16 +0100
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


Simon Glass (18):
  bootm: netbds: Drop passing of arguments
  bootm: plan: Drop passing of arguments
  bootm: qnxelf: Drop passing of arguments
  nios2: Drop separate parsing of bootm args
  treewide: bootm: Drop command-line args to boot_os_fn
  bootm: Drop arguments from boot_selected_os()
  mips: Add a reset_cpu() function
  m68k: Add a reset_cpu() function
  ppc: Add a reset_cpu() function
  nios2: Add a reset_cpu() function
  riscv: Add a reset_cpu() function
  bootm: Adjust how the board is reset
  bootm: Drop arguments from do_bootm_states() and rename
  bootm: Create a function to run through the bootm states
  stm32: Use local vars in stm32prog for initrd and fdt
  bootm: Create a function to run through the bootz states
  stm32: Use bootm_run() and bootz_run()
  bootm: Create a function to run through the booti states

 arch/arc/lib/bootm.c                          |   2 +-
 arch/arm/lib/bootm.c                          |   3 +-
 .../cmd_stm32prog/cmd_stm32prog.c             |  35 +++--
 arch/m68k/lib/bootm.c                         |   3 +-
 arch/m68k/lib/traps.c                         |   7 +
 arch/microblaze/lib/bootm.c                   |   3 +-
 arch/mips/cpu/cpu.c                           |   8 +-
 arch/mips/lib/bootm.c                         |   5 +-
 arch/nios2/cpu/cpu.c                          |   8 +-
 arch/nios2/lib/bootm.c                        |   5 +-
 arch/powerpc/lib/bootm.c                      |   3 +-
 arch/powerpc/lib/traps.c                      |  10 ++
 arch/riscv/cpu/cpu.c                          |  13 ++
 arch/riscv/lib/bootm.c                        |   5 +-
 arch/riscv/lib/reset.c                        |   7 +-
 arch/sandbox/lib/bootm.c                      |   2 +-
 arch/sh/lib/bootm.c                           |   3 +-
 arch/x86/lib/bootm.c                          |   3 +-
 arch/xtensa/lib/bootm.c                       |   2 +-
 boot/bootm.c                                  | 125 ++++++++++--------
 boot/bootm_os.c                               | 101 +++++---------
 cmd/booti.c                                   |  55 ++++----
 cmd/bootm.c                                   |  36 +++--
 cmd/bootz.c                                   |  38 ++++--
 include/bootm.h                               | 107 +++++++++++++--
 25 files changed, 362 insertions(+), 227 deletions(-)

-- 
2.43.0.rc2.451.g8631bc7472-goog

