Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28F1F357AC
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 14:26:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7339383D17;
	Tue, 24 Feb 2026 15:26:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mhCr2/Nd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F9CA83D3D; Tue, 24 Feb 2026 15:26:23 +0100 (CET)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F49682A9E
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 15:26:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6726f320b54so3172711eaf.1
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 06:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771943179; x=1772547979; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AR29q89EEH5j4QYfmZNDBHtM4JAtR/n5Dv+kF3Z5OY4=;
 b=mhCr2/NdpAA7kGLTCSR4qoepsV5B2mNe7CktbroHfqrT9B7xzLGvciaF8yc1HQ3gro
 tUtBaudLO/lKQcMSeTdApTI1UT2a5uEMGRVjp3GfUR45zKHr8LHzQWrBACaeTAXre6z/
 gDZL/cRu9XI5PSHtB3DeoVadSo9yTIuQ9NFw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771943179; x=1772547979;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AR29q89EEH5j4QYfmZNDBHtM4JAtR/n5Dv+kF3Z5OY4=;
 b=NIGB024wCLtf+uzqjP9N2FlnOM0t8dlWbptirVH5PmCN3yp8alHxKn4rIGB9CKMgNp
 v6eZ8qUead7gMvofk6bAVS9JRu46ZNw8PIbnzx/F7Luo7aBlQJ0dsRBoDy9xsWeR9i6d
 B7GT4wnrk29V4+ozNUsPdX5m81SR8VJORVmUJBI4kN4wvSE745GU19Ownchfy79QwolV
 ZojX5sZIRnpPU0VnaRnFkBSfTbH/OwrPC7fE7+8aSdy78fwg03zr7KvAk1rviCndtFMv
 D5tHiE7DIe8MGjatEtMQTIfsjenZ/+Q5uas204Yo4HKdN1W4d5gunCVKWkDiztODVtx5
 IjjA==
X-Gm-Message-State: AOJu0Yz4iF3P5dMvzMgLaByBNNap/uFNaJO1Ve4htdDUsG1FALSz7cKw
 sBsbhQKPbyn3gVrBYO1mJGQduqwK3x7saejbNFjZ0AkO4Fyf96lZrcm19CMm26l0DWdAN1DzK9z
 n5Eo=
X-Gm-Gg: AZuq6aJbYTkBe4E9u/i5NLB92B+iEfOpREZhkTbOwIr+nuwGIvZMxrn9RUN/tGxezoD
 6osuGn3x73aSzExw8z1NUE4iXpc0g63RI8A7ag3ItkXTl9cEdKkly0sFjvRX0vKphCBqPipzhJ6
 JZwbsqFv0DGVk+otS4n1lcxJKU2l0KN/HFEPRioIs+D5bEtYZyljJVaOWoplhOr8WPQaLcu5RYN
 dLOt+81EO/FPI/0M00fqE5weAVDspP2jmfgpokajd/rmBHrLFOcAFD8eCCbeBfwcB6LyovFS/eX
 ATKUU/h5LwfCgZXe/V08IwDxHJFntN1Km7QU/DxM/w1Oyro+r2j8eCe+8qdl89FHhxkUrXR/pw2
 kstK6yKQPs68FyH6TAWkjGCi38bjtEfmhNVjNwjPPKeaeWTKe2A5u+gVqA4QyG0mpQ61jhv/G3O
 vKlRU+KKhUCCYuy1fb3izC6c5gd3ahLUaZH4QRikMB
X-Received: by 2002:a05:6820:820:b0:65e:f7e6:438c with SMTP id
 006d021491bc7-679c44eb8b5mr6718200eaf.36.1771943179351; 
 Tue, 24 Feb 2026 06:26:19 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157cd5e168sm10199478fac.4.2026.02.24.06.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:26:18 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
X-Google-Original-From: Simon Glass <simon.glass@canonical.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Bin Meng <bmeng.cn@gmail.com>, Greg Malysa <malysagreg@gmail.com>,
 Guillaume Ranquet <ranquet.guillaume@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Leo <ycliang@andestech.com>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@riscstar.com>, Rick Chen <rick@andestech.com>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <stefan.roese@mailbox.org>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>
Subject: [PATCH v2 0/9] bootm: Clean up arch-specific, pre-OS clean-up
Date: Tue, 24 Feb 2026 07:25:42 -0700
Message-ID: <20260224142553.1608883-1-simon.glass@canonical.com>
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

Each arch does something slightly different before booting the OS. Some
archs even do different things depending on the CPU type.

It is quite hard to know what actually happens in the final milliseconds
before the OS boot.

This series attempts to start cleaning up U-Boot in this area.

The basic intent is to create a new bootm_final() function which can be
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
- Look at converting EFI to use the same function

Also, the comment for cleanup_before_linux() could use more details as
to what it is supposed to do, to reduce the number of arch-specific
variations. It currently does different things on differents archs and
is mostly uncommented (apart from an ARM-specific note in a README).
Ideally it would be commented with exactly what it should do, ideally
at a high level so it is not just arch-specific.

While some of these arch-specific differences are necessary, some are
just due to the changes to code over time.

Changes in v2:
- Replace 'efi: Make use of bootm_final()' with a non-EFI patch
- Drop comment about EFI
- Drop the EFI change
- Drop the call to udc_disconnect()
- Drop the EFI_LOADER change
- Drop patch 'efi: Drop EFI_GRUB_ARM32_WORKAROUND'
- Update cover message to reflect dropping the EFI patches, etc.

Simon Glass (9):
  boot: Create a function for final pre-boot steps
  bootm: Remove active devices in bootm_final()
  bootm: Add a message when booting
  bootstage: Add some missing dummy functions
  bootm: Do bootstage processing in bootm_final()
  x86: Call bootm_final()
  riscv: Drop board_quiesce_devices()
  riscv: Call bootm_final()
  x86: Add cleanup_before_linux()

 MAINTAINERS                           |  1 +
 arch/riscv/include/asm/u-boot-riscv.h |  1 -
 arch/riscv/lib/bootm.c                | 24 +------------------
 arch/x86/cpu/cpu.c                    |  5 ++++
 arch/x86/lib/bootm.c                  | 14 +----------
 boot/Makefile                         |  2 +-
 boot/bootm_final.c                    | 34 +++++++++++++++++++++++++++
 include/bootm.h                       | 17 ++++++++++++++
 include/bootstage.h                   |  8 +++++++
 9 files changed, 68 insertions(+), 38 deletions(-)
 create mode 100644 boot/bootm_final.c

-- 
2.43.0

base-commit: 8fd76675efbe7af785ccc1ba1ac8b9f7e10f6715
branch: bootma-us2
