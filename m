Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD235CF6BE3
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 00:58:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22B208401F;
	Wed,  7 Jan 2026 01:58:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YoZ6nks0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76EC483C4B; Wed,  7 Jan 2026 01:32:23 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE46483A26
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 01:32:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-3fa11ba9ed5so1070845fac.0
 for <u-boot@lists.denx.de>; Tue, 06 Jan 2026 16:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767745939; x=1768350739; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=r+VsbOiQRF6E3mMmV+QEhtVpBh0W0wG50WdIkdpc0H0=;
 b=YoZ6nks0AC1LdPS3bdXRYZinLXgKOSV7SDu/pvLx9IIY03qpEUhUjUK6xBrHoww79D
 d4O6web6Wo5OWaMnCyPuhkWgjmXNBUBEyFnHFrB/Bow5lL38HBxhTbjBwWJw3/AS24jR
 2X8O4UPwR4H93AVsDMe/WFRZdyC3ytUWjANLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767745939; x=1768350739;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r+VsbOiQRF6E3mMmV+QEhtVpBh0W0wG50WdIkdpc0H0=;
 b=RcxcaWZ2CSpVMfrQ5vWC0cEtqx+G6alNWMCPjOXvEqY808khim1zSnBStyQginExqI
 hYPGZEvRA0pRbI904ZOVCJa6eL1cl1xRkx41uh36VnVkkU72P6OPnVrPm2Kd2UCq77JM
 oZrftWdEv3MPSfnTBBpM68ZoQTezPSdXTtSheo+xyXfAWD2eJiKDS83caScIIXuOIIMs
 vP5/NvyjYJCMbhQ1XqDdx+/w0dmz1I7u0CB4XQiTVs/Bv67uMxRT2sEm3ayxV5fDZRNH
 V9WBo1qmC0xx1MnwUA1jbIubyKlQzWtOSCVRedGcXi3uc7G9+cOpmmEivF8nZ5xEKSuP
 +CZg==
X-Gm-Message-State: AOJu0YyS+QeFjPCbDsNcuUqhnf50YMGijMznEHeap6EwaUnL+J+hncsA
 DypuE5ZPpTyCPK8tOvCw2p+60kfcaH591vxixVuqNCVtw+1rl8HfdxSethTFNDznknUGFq46mT3
 b8eU=
X-Gm-Gg: AY/fxX4zij0IjQ+cPPx6Q2u9M0kVK9IFqHlNzDLnayJA7TQGuy8WGQDRnq/PEoaPHUz
 xgyqUObs6glNhjb5Bw/AvZX9VTd+HAi5PTMSIHz5wSLUUwmnxcSo489iu5g7ta+9qRrq8PA3XK0
 HaG/KmzxbyowlM9o9JBlxJHRdEb0Eu85PFh5+ukCjjMypbMXm3r3p4hjYzu3Of9r4NJNeQu4OoO
 IZ9qsqLyfHChl+pcuq9lHBS/2tJVufuy2ZXtMtXDBaKb+8UBJvppLURD5TuUKO4xsREyYwqOLCC
 qGCjWYJ3+h+lvi7tn1FlzL80y18jRMHrZGIXNG602rSHkd/0KpZ+QuTZPmVrXD048MBJ6Xs1ct8
 7FoclSLvQgd4a6w+iarwfohu5vh/OQ8uWDyIdzLCp8rS4HB2c/3NNA9viWUaVvCrO6uZ4v/9x93
 oULFE0TwYZeM3VSt3C
X-Google-Smtp-Source: AGHT+IGTTN4ADQuLcPMQAC9GNMqzVjiyTc8NLVgF4OMVsjuwKwo3mwcTzdqHA0CMIWBF+OhdqE1ktA==
X-Received: by 2002:a4a:ce90:0:b0:659:9a49:8f70 with SMTP id
 006d021491bc7-65f54f6fffbmr243211eaf.53.1767745938809; 
 Tue, 06 Jan 2026 16:32:18 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65f48ab2d00sm1631458eaf.0.2026.01.06.16.32.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 16:32:17 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
X-Google-Original-From: Simon Glass <simon.glass@canonical.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Bin Meng <bmeng.cn@gmail.com>, Greg Malysa <malysagreg@gmail.com>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ian Roberts <ian.roberts@timesys.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Raymond Mao <raymondmaoca@gmail.com>,
 Rick Chen <rick@andestech.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <stefan.roese@mailbox.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yao Zi <me@ziyao.cc>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
Subject: [PATCH 00/10] bootm: Clean up arch-specific, pre-OS clean-up
Date: Tue,  6 Jan 2026 17:31:17 -0700
Message-ID: <20260107003131.3064800-1-simon.glass@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 07 Jan 2026 01:58:34 +0100
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

Each arch does something slightly different before booting the OS. Some
archs even do different things depending on the CPU type.

EFT_LOADER has its own special code, regardless of which arch is being
booted.

It is quite hard to know what actually happens in the final milliseconds
before the OS boot.

This series attempts to clean up U-Boot in this area.

The basic approach is to create a new bootm_final() function which is
called by all archs. It provides some flags for a couple of necessary
variations but otherwise it is generic.

RISC-V, x86 and ARM are converted over to use this new function. For
consistency, EFI loader is converted as well.

A noteable change is that EFI_LOADER now does bootstage processing
before boot, if enabled, thus producing a report.

There is also a patch to drop EFI_GRUB_ARM32_WORKAROUND, as discussed
recently on the mailing list.

Future work could take this a little further:
- Drop board_quiesce_devices() and rely on driver model for that
- Similarly with udc_disconnect()
- cleanup_before_linux() could use more details as to what it is
supposed to do, to reduce the number of arch-specific variations

Note: This is the first 10 patches for an 18-part series from the
Concept tree, as requested. The patches after that complete the cleanup
on ARM and RISC-V.


Simon Glass (10):
  boot: Create a function for final pre-boot steps
  efi: Make use of bootm_final()
  bootm: Add a message when booting
  bootstage: Add some missing dummy functions
  bootm: Do bootstage processing in bootm_final()
  x86: Call bootm_final()
  riscv: Drop board_quiesce_devices()
  riscv: Call bootm_final()
  efi: Drop EFI_GRUB_ARM32_WORKAROUND
  x86: Add cleanup_before_linux()

 MAINTAINERS                           |  1 +
 arch/riscv/include/asm/u-boot-riscv.h |  1 -
 arch/riscv/lib/bootm.c                | 24 +------------------
 arch/x86/cpu/cpu.c                    |  5 ++++
 arch/x86/lib/bootm.c                  | 14 +----------
 boot/Makefile                         |  2 +-
 boot/bootm_final.c                    | 34 +++++++++++++++++++++++++++
 configs/mt7623n_bpir2_defconfig       |  1 -
 include/bootm.h                       | 17 ++++++++++++++
 include/bootstage.h                   |  8 +++++++
 lib/efi_loader/Kconfig                | 10 --------
 lib/efi_loader/efi_boottime.c         | 30 +----------------------
 test/boot/bootflow.c                  |  2 +-
 13 files changed, 70 insertions(+), 79 deletions(-)
 create mode 100644 boot/bootm_final.c

-- 
2.43.0

base-commit: 6cdd7597a2fbfc1572c1b0af23d3daf1cefa2de7
branch: bootma-us
