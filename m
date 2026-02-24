Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4267F357AC
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 14:25:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC12182BF2;
	Tue, 24 Feb 2026 15:25:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Bp18BCLx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A85DD83642; Tue, 24 Feb 2026 15:25:45 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0D7982A9E
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 15:25:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6759a5576f5so2826152eaf.2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 06:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771943141; x=1772547941; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AR29q89EEH5j4QYfmZNDBHtM4JAtR/n5Dv+kF3Z5OY4=;
 b=Bp18BCLxemxBuYhKXM123s7c9EH+JFug+IZn9Cm+Hwn3YLENfgJOJt02USDDSzfUJr
 EHrxX63jJpUWNfcgZTwegwSaOfYirC1somfJ8FPofVh0jGVFhxH4cP2LZQKLOphx0HTT
 vPVTzcqxjAkGvxx0T1hBP4W3Nq4aptwHCaGtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771943141; x=1772547941;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AR29q89EEH5j4QYfmZNDBHtM4JAtR/n5Dv+kF3Z5OY4=;
 b=UFb2gFpN0vJbRyFLsFVkmmdyNxlgxyrl0MnvFSVQq9iWuZw2W7obsaMCofHuraXuMF
 G6wk6Izr6g6Isg+da/W5nQRMsv/3WwZj2nDIYQS4UJGK/d2WFDpc/UdvR7Al61QNAS21
 hl8VHVhCByd3GLNaijy+69A9rvI3Ypa0UpgtMjuotS2XRroQDRNMGlNJVrPz990ik1HS
 0zvYtQqvyGNChpRe0ntW0is+0d6JJbzDuJNw/wVCIztrLmnsjsxUObLwFokTVUzl08Vk
 vDRnxJe8NnyJl+kUBK6hGHSTUxfK3znWXB7yn009sh3HCdq4+LtWUxBsu+eKCG0i5PWb
 JbIw==
X-Gm-Message-State: AOJu0YzsYd5kQD1uTMd11Kwc8cN5Y5fVggie1VKtTMg1Y8Qqd8qnKTi5
 aY+nvsg0QJ+0i6wHKZnJbIZEqQzseXdhZYyKQKXWyTi7tPgT+xedO1P8pTajO41yTkWXjRk8BDL
 BgMA=
X-Gm-Gg: AZuq6aKNcXG0f5hrG8VFhb+9xxu4xpAnTv12OeIB7z6UlaR5ljMYs8jgYCvb0Vw2yTu
 oQE6Vr+8kaxi/VbHX6pIRxCWafuNcelIb4qpCpJEL3/iCeva1D7wKgjNTZ8sExG42xGD5ob4P+P
 0T8Ck5JZ184jsTXr/1bQ77AcFhVnmDwwSxNWbWgFtCupXTrAMUTxA76AXMMGaj9xcV9/Zr2TKHM
 rQ3dlbvwn8xdVtr8fM3KjhTQJEKdtFrRW8nFjsKNFd5gWPHlKQlsjuFhTvbPCjr03txv7+vaY+r
 MUP3lrxjWuzrZlY4ReYBtEjyye14ZJKmQvfE/g91isEvCs3n95dnDfHNDgcSgC5d92HltTNyT/M
 4iSGF7ofHvcuIU8dFG0RpnKGffRKHc5RE4k/9lHn629h35N6xZYXnAevJWGHJlnAVQ21sjbmvh2
 HWZe8Rkn42fORTQeaXFkMx2iG+cvMD1g==
X-Received: by 2002:a05:6820:820:b0:676:aeb2:63d with SMTP id
 006d021491bc7-679c44ebb90mr6745759eaf.40.1771943140920; 
 Tue, 24 Feb 2026 06:25:40 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-679c56574ddsm8549347eaf.7.2026.02.24.06.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 06:25:40 -0800 (PST)
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
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@riscstar.com>, Rick Chen <rick@andestech.com>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <stefan.roese@mailbox.org>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>
Subject: [PATCH v2 0/9] bootm: Clean up arch-specific, pre-OS clean-up
Date: Tue, 24 Feb 2026 07:25:03 -0700
Message-ID: <20260224142514.1608144-1-simon.glass@canonical.com>
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
