Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92270C47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 15:10:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 532C8879AC;
	Thu,  4 Jan 2024 16:10:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QSyNswsA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A3A4879AC; Thu,  4 Jan 2024 16:10:51 +0100 (CET)
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C69E48798B
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 16:10:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x144.google.com with SMTP id
 e9e14a558f8ab-35fc1a1b52bso2164375ab.2
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 07:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704381046; x=1704985846; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Xk4V+RgnmIvm4289rEIMHbfKRp6GgKqVfQM6XVzmUSk=;
 b=QSyNswsAK/wvG7QU38Q3itQHjDMpJgAz05bWz3VmT1ysZfq509QHyhOESJSvD2C6tp
 w7/jOm6GjESs04TsdMVk78XOhJU9q2bgJ+xqm/Wb5ckCCfDdOgLkSMv/MmnzEvsxdUM6
 rWQ47CbZn4k6IvVIRWkNZJI2ehvjYa/UZCX+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704381046; x=1704985846;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xk4V+RgnmIvm4289rEIMHbfKRp6GgKqVfQM6XVzmUSk=;
 b=UWy6t7Z1bZl2aRjh0r0qRg3+YC4q77NyZJeXVivYZSFWVGzJC8NStu01o91sKqBNhw
 cy8wyYjA1lWHgroqCZp2l26HpKQSdVMcSr8FfG/Upfa0TdQ2qxJ1ci9E6upL1xANMkNB
 IS2IdlX+1Y1YT8yfuMJinOVgrU3VS7nnpnsOCdiUbjwyX9JFc524MEv0aLGNkLM434FP
 BqJhZ45H47NA0uIJ9Ysk/cwQPgP+smkQfAk86SGqRJU2tq3ZOS3YjRGmC68UAnpXWXSM
 /nWvo4rTxynrWddPe2mFB7ARPF/MaqaJtav0ViKXP+AdTj+PGe7k/MNAACQ/e20928H+
 OXUA==
X-Gm-Message-State: AOJu0YwkoyZCPglc0xF61VqrPCJ4c5GZQqVsJZkZqjrH4rLrDrIz/s4h
 2pFbOHCaDLDsDxTQxEgDV7F4dt86k4TTiwm6byy/ImY80UdxAAU=
X-Google-Smtp-Source: AGHT+IEqMsL1f4qAlYMsnUqwgziAjnjUGbryPAN30yCZV7UZoKgOtCzNywsHZ9CWzrAfqLqA7iEjBg==
X-Received: by 2002:a5e:de0a:0:b0:7b7:fe53:ebdb with SMTP id
 e10-20020a5ede0a000000b007b7fe53ebdbmr749099iok.32.1704381046142; 
 Thu, 04 Jan 2024 07:10:46 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 z14-20020a02938e000000b0046d710cef38sm4937310jah.159.2024.01.04.07.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 07:10:45 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Fabio Estevam <festevam@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nikhil M Jain <n-jain1@ti.com>, Peter Robinson <pbrobinson@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v6 0/7] Resolve issues with booting distros on x86
Date: Thu,  4 Jan 2024 08:10:35 -0700
Message-Id: <20240104151042.695717-1-sjg@chromium.org>
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

This little series reprises the EFI-video fix, fixes a USB problem and
enables a boot script for coreboot.

It also moves to truetype fonts for coreboot and qemu-x86, since the
menus look much better and there are no strong size constraints.

With these changes it is possible to boot a Linux distro automatically
with U-Boot on x86, including when U-Boot is the second-stage
bootloader.

Changes in v6:
- Rebase to -next
- Move 'Avoid unbinding devices in use by bootflows' to another series

Changes in v4:
- Use a Kconfig option

Changes in v3:
- Clear the screen before booting
- Add new patch to drop unnecessary truetype operations from SPL
- Add new patch to enable truetype fonts in coreboot
- Add new patch to enable truetype fonts in qemu-x86 and qemu-x86_64

Changes in v2:
- Add new patch to add a coreboot boot script

Simon Glass (7):
  x86: coreboot: Add a boot script
  video: Correct setting of cursor position
  video: Drop unnecessary truetype operations from SPL
  x86: Enable SSE in 64-bit mode
  x86: coreboot: Enable truetype fonts
  x86: qemu: Expand ROM size
  x86: qemu: Enable truetype fonts

 arch/x86/Kconfig                  |  8 ++++++++
 arch/x86/config.mk                |  4 ++++
 arch/x86/cpu/x86_64/cpu.c         | 12 ++++++++++++
 arch/x86/dts/coreboot.dts         | 10 ++++++++++
 board/emulation/qemu-x86/Kconfig  |  3 ++-
 configs/coreboot64_defconfig      |  2 ++
 configs/coreboot_defconfig        |  2 ++
 configs/qemu-x86_64_defconfig     |  5 +++--
 configs/qemu-x86_defconfig        |  1 +
 drivers/video/Kconfig             |  1 +
 drivers/video/console_truetype.c  | 10 ++++++++++
 drivers/video/vidconsole-uclass.c | 15 ++++++++-------
 12 files changed, 63 insertions(+), 10 deletions(-)

-- 
2.34.1

