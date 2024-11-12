Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8EAD42B83
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 13:59:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 253B689440;
	Tue, 12 Nov 2024 14:59:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iWtJWmn9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0BE7893C2; Tue, 12 Nov 2024 14:59:22 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE19989431
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 14:59:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-83abe4524ccso222863639f.1
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 05:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731419958; x=1732024758; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DtbbIOccD3ypn8aFqTUyq79fII/Aidcsb4TcLjK5hMY=;
 b=iWtJWmn9ODhyErv6ylMmpvh6YtNZTtAA1+osDIA7SIPMS8GZHlX4Wql/cXpVXdkawj
 SfN44O+sdTZEV2bHtzXXVjgUOyWPWsq2JxsZ1sAGbUAuXhl37sMsZ2dqd3YUbIwibAKl
 x/AiQELvi1PWhhmYZCfGn9hbjn/YFyjNljgZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731419958; x=1732024758;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DtbbIOccD3ypn8aFqTUyq79fII/Aidcsb4TcLjK5hMY=;
 b=J9YfuZlugshBcTs0rvIwsznyvfLM2iE4JimseSvSsidUl6nMSCq46PDjj3fgHScjsx
 /+2aiZ6GH9y6i3+ki+yy+mIOeuoX03rbBlyMuPaA3bw7+I//MKh6XDvwkm0GtuA0kN/7
 HiIc6zzCt52a4FR6SkZCe7xXRAMd9zZ2c17MIhpEOolqYXlvwhVkMasmyF2nGt5xrv9q
 0CC7qt6AjmMJ+UWy/3WDcVIZVwi0943V5OCbXSpFXdVaIDTytIi6VOdM9CszK6I6HMVJ
 BZ84iNeD4GOsrGCgGas3hyfaYkWAUwFytNiT08eP32a21rJlxgyonK18m8ogOzz6TRhb
 Qv7g==
X-Gm-Message-State: AOJu0Yy8FOV/No+zNiQvOl49aPvCuFMp6QAQ8VLkcDKAeTG6MmW1P1en
 iEIoUgKFP37VbfKjda2S/7i0JvRoJ2IDZ+WB0WScuKniMzVl9MtNeHq66ce6RVUsA82b0b6jD/E
 =
X-Google-Smtp-Source: AGHT+IHgOnnp4pNiA/5SFn1eOzk3Qyljr5fR2216TrKppaea3I8TFWkRKb0DCjzu1qnp+gSKHjt49Q==
X-Received: by 2002:a05:6602:2d84:b0:83a:95fc:b242 with SMTP id
 ca18e2360f4ac-83e032fa8c5mr1546439339f.7.1731419958358; 
 Tue, 12 Nov 2024 05:59:18 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e132c01besm189203039f.30.2024.11.12.05.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 05:59:17 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 00/18] x86: Improve operation under QEMU
Date: Tue, 12 Nov 2024 06:58:53 -0700
Message-Id: <20241112135911.630586-1-sjg@chromium.org>
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

U-Boot can start and boot an OS in both qemu-x86 and qemu-x86_64 but it
is not perfect.

With both builds, executing the VESA ROM causes an intermittent hang, at
least on some AMD CPUs.

With qemu-x86_64 kvm cannot be used since the move to long mode (64-bit)
is done in a way that works on real hardware but not with QEMU. This
means that performance is 4-5x slower than it could be, at least on my
CPU.

We can work around the first problem by using Bochs, which is anyway a
better choice than VESA for QEMU. But this results in the Ubuntu
installer failing to boot via EFI. It isn't clear whether this due to
a problem with the UEFI GOP, or something else. It hangs before the
Ubuntu logo appears.

So this series is unfinished. I thought it best to post what is here in
the hope that others can help work out the kinks.


Simon Glass (18):
  scripts: Add a script for building and booting QEMU
  x86: Expand x86_64 early memory
  RFC: x86: qemu: Switch to bochs display
  x86: qemu: Enable dhrystone
  x86: qemu: Avoid accessing BSS too early
  x86: Drop mpspec from the SPL build
  x86: Add some log categories
  x86: Drop use of CONFIG_REALMODE_DEBUG
  x86: Avoid clearing the VESA display
  x86: Add 64-bit entries to the GDT
  x86: Use defines for the cache flags
  x86: spl: Drop duplicate CPU init
  x86: Drop the message about features missing in 64-bit
  x86: Include stdbool.h in interrupt header
  x86: Tidy up the GDT size in start/16.S
  x86: Disable paging before changing to long mode
  x86: Use the same GDT when jumping to long mode
  x86: Use a simple jump into long mode

 MAINTAINERS                      |   8 ++
 arch/x86/cpu/i386/call64.S       |  35 +++----
 arch/x86/cpu/i386/cpu.c          |  18 +++-
 arch/x86/cpu/qemu/qemu.c         |  20 ++--
 arch/x86/cpu/start.S             |   4 +-
 arch/x86/cpu/start16.S           |   3 +-
 arch/x86/include/asm/interrupt.h |   1 +
 arch/x86/include/asm/processor.h |   5 +-
 arch/x86/lib/Makefile            |   2 +
 arch/x86/lib/bios.c              |  27 +++--
 arch/x86/lib/bios_interrupts.c   |   8 +-
 arch/x86/lib/i8259.c             |   2 +
 arch/x86/lib/spl.c               |   4 +-
 configs/qemu-x86_64_defconfig    |  10 +-
 configs/qemu-x86_defconfig       |   6 +-
 doc/board/emulation/index.rst    |   1 +
 doc/board/emulation/script.rst   |  61 +++++++++++
 scripts/build-qemu.sh            | 175 +++++++++++++++++++++++++++++++
 18 files changed, 331 insertions(+), 59 deletions(-)
 create mode 100644 doc/board/emulation/script.rst
 create mode 100755 scripts/build-qemu.sh

-- 
2.34.1

