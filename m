Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE23E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:28:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B0DE871DB;
	Mon,  2 Oct 2023 03:15:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EdT6X5Lq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7127787182; Mon,  2 Oct 2023 03:15:32 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81E1487135
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:14:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-35142c4cbbdso37408205ab.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209294; x=1696814094; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EVvzGSeXUiOi0220dYgj/pCKWoo77k0/a9RnZn2lFts=;
 b=EdT6X5Lq3cIT4fqOHscwuGpbpSaYFqnaDt+k/GsUUcExATuC4QKPnwFqDaFKmKgNg2
 yruJ1OAqCwXhwBTQDBPlPn/TaVI6Ue4zo6MqKDhTUAgwGf9fMY0hTBHwgN1zDNbPVE6J
 620zD/tWUTw7pAYfNZYJkYoYakdCt99W77GXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209294; x=1696814094;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EVvzGSeXUiOi0220dYgj/pCKWoo77k0/a9RnZn2lFts=;
 b=auef3coklr3LFaemkTdf9CPa7cxnzFYQZW1bSVGMwistoMD6sgKT4IZaw+C1CY3ff/
 /NYabX4PiPukD+x0O4VpVVwYWrtWRdVmVSpZpgX48zuWRJ6kfb2n+/2kiiiolLCh9kGu
 H885YcmschI1dIZPTMiCVJYFRWA9dy1g0omG9olKNFvJ/2PH5L5+37fbTlv1u1RqOPly
 1gkCzMOobngY8/SD4sG43JOjMAKEXUhzN25Fx5km2dYltmYTPMJ3TluTro9QOZE/Rovv
 sqxxN8XWAhF1VlAaiUkFxahnpyoLxxr+5QWVakWuvYiJ2EGeQOlNEGOm2XAXS1N2a6mv
 cL5g==
X-Gm-Message-State: AOJu0YwHAHxWz27F7AFxjzgTgZAKRyhRpNxUCxl/Z9wMoty3OPSOHGFG
 hQmxnLy3HUiE7bpG9yBRExxSbgA69Crx4bHXEkA=
X-Google-Smtp-Source: AGHT+IEGCXQlmX01YLwF8y/pE2PscMZ/HhvevH353sMFAEDwszzN3kHTf4tfJNkaynn2gwjlPW7dfA==
X-Received: by 2002:a05:6e02:1bef:b0:351:1f41:d2cd with SMTP id
 y15-20020a056e021bef00b003511f41d2cdmr12342518ilv.29.1696209293876; 
 Sun, 01 Oct 2023 18:14:53 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 s23-20020a02c517000000b0042b2e309f97sm6522951jam.177.2023.10.01.18.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:14:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v3 00/12] Resolve issues with booting distros on x86
Date: Sun,  1 Oct 2023 19:14:35 -0600
Message-ID: <20231002011450.462468-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
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

This little series reprises the EFI-video fix, fixes a USB problem and
enables a boot script for coreboot.

It also moves to truetype fonts for coreboot and qemu-x86, since the
menus look much better and there are no strong size constraints.

With these changes it is possible to boot a Linux distro automatically
with U-Boot on x86, including when U-Boot is the second-stage
bootloader.

Changes in v3:
- Add new patch to refactor mmc prep to allow a different scan
- Add missing word 'function' in the commit message
- Clear the screen before booting
- Add new patch to drop unnecessary truetype operations from SPL
- Add new patch to enable truetype fonts in coreboot
- Add new patch to enable truetype fonts in qemu-x86 and qemu-x86_64

Changes in v2:
- Rebase to -next
- Add some more comments to the header file
- Add fixes tag
- Add new patch to add a return code to bootflow menu
- Add new patch to add a coreboot boot script
- Add new patch to avoid unbinding devices in use by bootflows

Simon Glass (12):
  efi: Correct handling of frame buffer
  bootstd: Refactor mmc prep to allow a different scan
  bootstd: Add a return code to bootflow menu
  x86: coreboot: Add a boot script
  usb: Avoid unbinding devices in use by bootflows
  expo: Correct background colour
  video: Correct setting of cursor position
  video: Drop unnecessary truetype operations from SPL
  x86: Enable SSE in 64-bit mode
  x86: coreboot: Enable truetype fonts
  x86: qemu: Expand ROM size
  x86: qemu: Enable truetype fonts

 arch/x86/config.mk                |  1 -
 arch/x86/cpu/x86_64/cpu.c         | 11 +++++
 arch/x86/dts/coreboot.dts         | 10 +++++
 board/emulation/qemu-x86/Kconfig  |  3 +-
 boot/bootm.c                      |  2 +-
 boot/expo.c                       |  4 +-
 cmd/bootflow.c                    | 53 ++++++++++++++++++------
 common/usb.c                      |  7 +++-
 configs/coreboot64_defconfig      |  4 +-
 configs/coreboot_defconfig        |  4 +-
 configs/qemu-x86_64_defconfig     |  7 ++--
 configs/qemu-x86_defconfig        |  1 +
 doc/usage/cmd/bootflow.rst        | 67 +++++++++++++++++++++++++++++++
 drivers/usb/host/usb-uclass.c     | 14 ++++++-
 drivers/video/console_truetype.c  | 10 +++++
 drivers/video/vidconsole-uclass.c | 15 +++----
 include/usb.h                     | 15 ++++++-
 include/video.h                   |  9 +++--
 lib/efi_loader/efi_gop.c          | 12 +++---
 test/boot/bootflow.c              | 64 ++++++++++++++++++++++++-----
 20 files changed, 264 insertions(+), 49 deletions(-)

-- 
2.42.0.582.g8ccd20d70d-goog

