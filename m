Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2208AC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:03:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 364AA8710B;
	Sun, 12 Nov 2023 21:03:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gela9JC0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4619871A5; Sun, 12 Nov 2023 21:03:06 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D772870F2
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:03:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3580b94ac2eso16265695ab.0
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819379; x=1700424179; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WtKW6IVxLs1v6G/OvpOI9T6OREAEMFSGLikZfpJAmDU=;
 b=gela9JC0ApAcQVfaOKzoqyPNXfOTzh5tKJAr3cRWwhGW+Ka/9BFjkw9Jp8EQEc/Y7p
 GRp/fDnTIgShXZ4sQCKsmXkjlqR0Uxn3j+dlNugcZ8drucAz7tvPwZ/z0zwsLzbUShcn
 sv3+YPc2O+0EGWVhQopWsvGbcbpgiQffUrxhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819379; x=1700424179;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WtKW6IVxLs1v6G/OvpOI9T6OREAEMFSGLikZfpJAmDU=;
 b=OGoUTqFQvP+bAiI860uoB5sob+YlwfZDENdkswHXi9z5npfTJp1PHfghWU19RIRzCW
 IQ6A+UyxK5RnURKnBphjXxvB5wFdmSSg+55nvHkVX45y0lqhkhe7xJEsETHmhBKmNuZp
 gsbQhMjLlpMTMDSahBKodn5IGWHXHPyRredPtVZR1mhRRKwFz3lTpVKK1P04QfE0KapQ
 mvuo3ox8LJKJEjc6VlvNNwE8+Pb31hO+vkKSQj9j4t4dOFrEX2T0KTxLoHZsqjFLSaag
 PXFlaPMLjji1Wmo0SGv4pFVZPsAzPTUlO4vVDA/Zg6TcXvi3+wl7ba9KW3cpn6tLR/RQ
 YWRA==
X-Gm-Message-State: AOJu0YwNV/clCViKptXtGJHnRif3+apxUn4gdIRV9zDMNIfOPSupQiAL
 fPaLIz8Fx4sRp6DFw9yOY60TKq7vJCOXIdKV17NSvg==
X-Google-Smtp-Source: AGHT+IHXvHF95qY+eSLOrFqpWLEjHx3KGaarp4EONwz5T1op4ttcEJT9igwHbsXvOs92L3DSUTcLnw==
X-Received: by 2002:a92:ca48:0:b0:359:3ee6:a91a with SMTP id
 q8-20020a92ca48000000b003593ee6a91amr7980478ilo.21.1699819379031; 
 Sun, 12 Nov 2023 12:02:59 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a923204000000b0035761b749casm1208256ile.46.2023.11.12.12.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 12:02:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Eddie James <eajames@linux.ibm.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaewon Jung <jaewon8868@gmail.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v4 00/12] Resolve issues with booting distros on x86
Date: Sun, 12 Nov 2023 13:02:37 -0700
Message-ID: <20231112200255.172351-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
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

Changes in v4:
- Don't rename the legacy-USB functions
- Add a bit more detail to the comment
- Use a Kconfig option

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

 arch/x86/Kconfig                  |  8 ++++
 arch/x86/config.mk                |  4 ++
 arch/x86/cpu/x86_64/cpu.c         | 12 ++++++
 arch/x86/dts/coreboot.dts         | 10 +++++
 board/emulation/qemu-x86/Kconfig  |  3 +-
 boot/bootm.c                      |  2 +-
 boot/expo.c                       |  4 +-
 cmd/bootflow.c                    | 53 ++++++++++++++++++------
 common/usb.c                      |  5 +++
 configs/coreboot64_defconfig      |  2 +
 configs/coreboot_defconfig        |  2 +
 configs/qemu-x86_64_defconfig     |  5 ++-
 configs/qemu-x86_defconfig        |  1 +
 doc/usage/cmd/bootflow.rst        | 67 +++++++++++++++++++++++++++++++
 drivers/usb/host/usb-uclass.c     | 14 ++++++-
 drivers/video/Kconfig             |  1 +
 drivers/video/console_truetype.c  | 10 +++++
 drivers/video/vidconsole-uclass.c | 15 +++----
 include/usb.h                     | 21 +++++++++-
 include/video.h                   |  9 +++--
 lib/efi_loader/efi_gop.c          | 12 +++---
 test/boot/bootflow.c              | 64 ++++++++++++++++++++++++-----
 22 files changed, 280 insertions(+), 44 deletions(-)

-- 
2.42.0.869.gea05f2083d-goog

