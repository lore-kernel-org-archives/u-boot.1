Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6C1C02198
	for <u-boot@archiver.kernel.org>; Sun, 16 Feb 2025 20:44:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 674E380AE6;
	Sun, 16 Feb 2025 21:44:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c5H32Cln";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 729D680104; Sun, 16 Feb 2025 21:44:50 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 123A280104
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 21:44:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-855799b9d1cso36672839f.1
 for <u-boot@lists.denx.de>; Sun, 16 Feb 2025 12:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739738686; x=1740343486; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9o36hZKDCWruTMgvAe6c+Acq8fbx9dtL4I2IvxRSnR4=;
 b=c5H32ClnHZga/u9ZniU8Z/gJCIvsnWNjwG68rOG2LkUuKWXiOqyhcMHV/TMoauI/9H
 WRzORpbeIIU7zumrrY/8OOXTSEgVlGBMWSKREJUd2Il22Kc5WanK4v+k496b4rZdH1jJ
 7h2tGXqmh66936ZotFp9VWCsNs5mxzLoC5E9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739738686; x=1740343486;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9o36hZKDCWruTMgvAe6c+Acq8fbx9dtL4I2IvxRSnR4=;
 b=ewlgdTHBNIy8wBFpI+zxPXd67BGy5IF4dSfOD+ZunHYy4QoTqtm+kEdncs9aJfdj17
 vPgA19lF3lOTo1v/uCwAuhQHk66Z3wl18DUg6bILzqdQOom1sjbuuGWnokASACy8jg1X
 gASztF4f2I8WCV7cqGlCNrHAbCL6M/dedyX4spTNClgGUHnMq/gjVxAPkvXy8I4JiUMK
 VkFXZQestyP6jdzDi0kWcE4yOeFJWFU+cw40cw/KnS/MQFYBY2YsdbO5p+XHderla6GR
 stFcrtYd+riu5yV+2BhTR2QUck9OwSV45FCHQV+4aNC20zkzZbJsnbeYU6TSaGRUNvl+
 9p5Q==
X-Gm-Message-State: AOJu0YyJMPI9fwdZcWuFZ2cYQ6Wxq/mqBDSxwSQ/XLC44d2xjIPtT2Up
 4eVcOseMf7ZtHR+65emqYjCYF2Vp2RtFr4xFeKtvaEaiva8MW9/A/1/k4kzJRZr7SsY7o1A24M4
 =
X-Gm-Gg: ASbGnctuXF9JmwSo6GwxarAW7RvT16bz7eziMYBqn4vv1oqJyzwtZYuH73aQza8yDxt
 w/k1lrD1I2LUOkY4m/JvMzRH+ZeeL0IsDHXZH6cq9WLWi6h/KjT/sPBrXNjZRSQxLFZPzniGFFO
 lIR388ivv8XaC6LXz0jAypPc4AhnV+5Po6Tez3xB0jl/8vVOjn3L2pvuHjnLJ9AJ5HCt5fry2rv
 r/WaeL2Og0olkK7Pa54swQ1lcHIBOeaXMAQt3PgWg73+PpuVpYrcZAbSLtIRMVxbV1MV6r+b3HH
 0DRSG+lXpXOCN/vsVZFWEPn4nu9F7E6Gm/DWHsQKMtNM8K5X+xKh
X-Google-Smtp-Source: AGHT+IFXGBJhpKuAnjOnDsrHsy6/84yGXy9ofKXFEeQ34NCD2J6ShVa/NF09vbWUthX1c4jj7VhV0w==
X-Received: by 2002:a05:6e02:2686:b0:3d1:bbc2:a324 with SMTP id
 e9e14a558f8ab-3d28076e074mr71196395ab.4.1739738685752; 
 Sun, 16 Feb 2025 12:44:45 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed281718f4sm1854186173.45.2025.02.16.12.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 12:44:44 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Love Kumar <love.kumar@amd.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Philip Oberfichtner <pro@denx.de>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Tom Rini <trini@konsulko.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 00/28] x86: Improve operation under QEMU
Date: Sun, 16 Feb 2025 13:43:45 -0700
Message-ID: <20250216204421.3560012-1-sjg@chromium.org>
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

U-Boot can start and boot an OS in both qemu-x86 and qemu-x86_64 but it
is not perfect.

With both builds, executing the VESA ROM causes an intermittent hang, at
least on some AMD CPUs.

With qemu-x86_64 kvm cannot be used since the move to long mode (64-bit)
is done in a way that works on real hardware but not with QEMU. This
means that performance is 4-5x slower than it could be, at least on my
CPU.

We can work around the first problem by using Bochs, which is anyway a
better choice than VESA for QEMU. The second can be addressed by using
the same descriptor across the jump to long mode.

With an MTRR fix this allows booting into Ubuntu on qemu-x86_64

Changes in v2:
- Redo commit message
- Add new patch to rename the _D dirty flag
- Add new patch to support CPU functions in long mode
- Add new patch to tidy up address size in MTRR calculations
- Add new patch with a 64-bit version of is_power_of_2()
- Add new patch to set an MTRR for the RAM in QEMU
- Add new patch with a helper to send characters
- Add new patch to allow tests to be filtered by role
- Add more patches to support booting with kvm
- Add new patch with a test for booting Ubuntu 24.04

Simon Glass (28):
  x86: Expand x86_64 early memory
  x86: qemu: Switch to bochs display
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
  x86: Rename the _D dirty flag
  x86: Support CPU functions in long mode
  x86: Tidy up address size in MTRR calculations
  Add a 64-bit version of is_power_of_2()
  x86: Support MTRRs of 4GB on 32-bit machines
  x86: emulation: Set an MTRR for the RAM
  scripts: Expand a few options
  test/py: Add a helper to send characters
  test/py: Allow tests to be filtered by role
  RFC: test/py: Deal with timeouts
  test: Add a test for booting Ubuntu 24.04

 .gitlab-ci.yml                   |  5 +++
 arch/x86/cpu/cpu.c               | 24 +++++++++++++++
 arch/x86/cpu/i386/call64.S       | 35 +++++++++------------
 arch/x86/cpu/i386/cpu.c          | 41 +++++++++---------------
 arch/x86/cpu/mtrr.c              | 12 +++++---
 arch/x86/cpu/qemu/dram.c         | 15 +++++++++
 arch/x86/cpu/qemu/qemu.c         | 20 ++++++++----
 arch/x86/cpu/start.S             |  4 ++-
 arch/x86/cpu/start16.S           |  3 +-
 arch/x86/cpu/x86_64/cpu.c        |  5 ---
 arch/x86/include/asm/cpu.h       | 35 ++++++++++++++++++---
 arch/x86/include/asm/interrupt.h |  1 +
 arch/x86/include/asm/processor.h |  5 ++-
 arch/x86/lib/Makefile            |  2 ++
 arch/x86/lib/bios.c              | 27 +++++++++-------
 arch/x86/lib/bios_interrupts.c   |  8 ++---
 arch/x86/lib/i8259.c             |  2 ++
 arch/x86/lib/spl.c               |  4 +--
 configs/qemu-x86_64_defconfig    | 10 +++---
 configs/qemu-x86_defconfig       |  6 ++--
 include/linux/log2.h             |  6 ++++
 scripts/build-qemu.sh            |  4 +--
 test/py/conftest.py              | 22 +++++++++++++
 test/py/console_base.py          | 33 ++++++++++++--------
 test/py/pytest.ini               |  1 +
 test/py/tests/test_distro.py     | 53 ++++++++++++++++++++++++++++++++
 test/py/tests/test_sleep.py      |  1 +
 27 files changed, 273 insertions(+), 111 deletions(-)
 create mode 100644 test/py/tests/test_distro.py

-- 
2.43.0

