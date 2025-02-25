Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0F2C021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 16:35:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 148A380F56;
	Tue, 25 Feb 2025 17:35:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MUN49nN3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5949380F96; Tue, 25 Feb 2025 17:35:13 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB7EA807EE
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 17:35:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38f22fe889aso5179409f8f.3
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 08:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740501310; x=1741106110; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9WjYaLFMlVKPGL8G2Drzp3bwIPdnL1GctqQaI+gZ1J0=;
 b=MUN49nN30JMJ1f+a3aQnyWf7kzmviFzfmkK+vh12tcCDCmfBPrdeKH8rRPXToJVnon
 vHPXKcxDY1emzEcunE/aXWjwIgomc0d0RT1NbqghBG9TOfke+8G5WGzQfGgbqYJRD4AZ
 3lGIGR6awhArQyp5DtKDWT52Jhq6bum+LU4yVpOCS2uxd4aXSOBM6BuTLwfZl6tMWyzr
 0ji/0NAMSw9I46cM4JpDPRzSlhgHTphWNLvQK9Nkd1Jl7BqgTI5CVG0qPzy+BsHyeGmh
 kTmee48QEDGkZ8Ji2rJYmW9hf2PFNhatWR6t4421TR4viBeBCuHk3i+YkmshrFjeeD2o
 /qUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740501310; x=1741106110;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9WjYaLFMlVKPGL8G2Drzp3bwIPdnL1GctqQaI+gZ1J0=;
 b=iUUqj+oHOIhFsaEkKmYdxUMkXt5yskTTSWSrITV+AUmfL7C+y8AEiKLC2tT/4IThwE
 RM3eYvSdTOZMlBLY2Hj1W1UuM33+3Y8qg+WoTTL7ZfqgZSYIzaWWtAtdkZLJuHKO3i2f
 CuMtrJh5KLD/hajC1Lu7+Gme/P0OI23WdfFL59mC68r9KHAlh0ZdTueM2Hq824aQxUXw
 kNn8bcJckemYmrzoMxvW6nxHn4Q9g0f/Wf3vcB4LqHk+j+2ms/Am4K1Z4eOysJZCzq02
 Ejv9AcpxgIm7JI4PE+ActQJ5E63L06c3MReTBe1dpTt5rFxWK6x3yFiH6apDMn6fSLgw
 OnYg==
X-Gm-Message-State: AOJu0Yy1onWwyVIc5H7Nk9bzB/26+TQs37SbwAkJ0eE1puZ9dp2G5AAH
 kLrUUd04wOAjikCM9TE2TToGIpaLjfojjVfMon6DM9EgEX/3Ftuf+ycExab7+Gwn66/+lmvi5WI
 m6Rgx0g==
X-Gm-Gg: ASbGnctj6LW4TUpX/K7W9SXolIxqZc8Aw7/4Cv7Tm6sK7Z6ziTxgT6Sq6aib8MyoP6q
 ZjIxZFqGf6Ie03lz+zufMGlDiaO5ffzVDSteJs9tRvgl1lEH6vhYvrpK11wwYCYCgfjYSEoUY+v
 1HqQCFPK9Fp2vUrQFngG6jb6qg8y8xLAGaMvzMvxA7mWQPRuJb1+KfiMAmGbGJF6923uleEjfIR
 1RFlztaD8/P+vmP/ozLkNBQJ10vv+s9xCJYmm30T3FDRYepQAEmrqL4bgw85jegP2pQlRDCCqqi
 7Gb86srv7airiRjBhhpzZCxKQafYle185k0=
X-Google-Smtp-Source: AGHT+IGbS8503j2NyxaB861OZKl0UkTmREbfbBisCJf5zr23DwIAFRCUny2UZn8VizjQe3UnUi2OZA==
X-Received: by 2002:a5d:6c6e:0:b0:38d:dce1:f207 with SMTP id
 ffacd0b85a97d-390cc631a3emr4442794f8f.44.1740501310040; 
 Tue, 25 Feb 2025 08:35:10 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02ce735sm146356195e9.3.2025.02.25.08.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 08:35:09 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v2 00/14] Uthreads
Date: Tue, 25 Feb 2025 17:34:26 +0100
Message-ID: <cover.1740499185.git.jerome.forissier@linaro.org>
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

This series introduces threads and uses them to improve the performance
of the USB bus scanning code and to implement background jobs in the
shell via two new commands: 'spawn' and 'wait'.

The threading framework is called 'uthread' and is inspired from the
barebox threads [1]. setjmp() and longjmp() are used to save and
restore contexts, as well as a non-standard extension called initjmp().
This new function is added in several patches, one for each
architecture that supports HAVE_SETJMP. A new symbol is defined:
HAVE_INITJMP. Two tests, one for initjmp() and one for the uthread
scheduling, are added to the lib suite. NOTE: the SANDBOX version of
initjmp() appears to have problems and needs to be worked on.

[1] https://github.com/barebox/barebox/blob/master/common/bthread.c

After introducing threads and making schedule() and udelay() a thread
re-scheduling point, the USB stack initialization is modified to benefit
from concurrency when UTHREAD is enabled, where uthreads are used in
usb_init() to initialize and scan multiple busses at the same time.
The code was tested on arm64 and arm QEMU with 4 simulated XHCI buses
and some devices. On this platform the USB scan takes 2.2 s instead of
5.6 s. Tested on i.MX93 EVK with two USB hubs, one ethernet adapter and
one webcam on each, "usb start" takes 2.4 s instead of 4.6 s.

Finally, the spawn and wait commands are introduced, allowing the use of
threads from the shell. Tested on the i.MX93 EVK with a spinning HDD
connected to USB1 and the network connected to ENET1. The USB plus DHCP
init sequence "spawn usb start; spawn dhcp; wait" takes 4.5 seconds
instead of 8 seconds for "usb start; dhcp".

Changes in v2:
- Rewrite the cover letter, do not mention the older coroutines series
- Rebased onto next
- UTHREAD_STACK_SIZE is set to 32768 (32 KiB) instead of 32178
- Remove uthread_free_all() and let threads be freed as they terminate
by uthread_schedule()
- Add function descriptions
- Add documentation (doc/develop/uthread.rst)
- Explain initjmp() in the description of "arch: introduce symbol
HAVE_INITJMP".
- Add thread groups (uthread_grp_new_id() and uthread_grp_done())
- Add the spawn and wait commands

Jerome Forissier (14):
  arch: introduce symbol HAVE_INITJMP
  arm: add initjmp()
  riscv: add initjmp()
  sandbox: add initjmp()
  test: lib: add initjmp() test
  uthread: add cooperative multi-tasking interface
  cyclic: invoke uthread_schedule() from schedule()
  lib: time: hook uthread_schedule() into udelay()
  doc: develop: add documentation for uthreads
  test: lib: add uthread test
  dm: usb: move bus initialization into new static function
    usb_init_bus()
  dm: usb: initialize and scan multiple buses simultaneously with
    uthread
  cmd: add spawn and wait commands
  test: dm: add test for spawn and wait commands

 arch/Kconfig                      |   8 ++
 arch/arm/include/asm/setjmp.h     |   1 +
 arch/arm/lib/setjmp.S             |  11 ++
 arch/arm/lib/setjmp_aarch64.S     |   9 ++
 arch/riscv/include/asm/setjmp.h   |   1 +
 arch/riscv/lib/setjmp.S           |  10 ++
 arch/sandbox/cpu/Makefile         |  11 +-
 arch/sandbox/cpu/initjmp.c        | 172 +++++++++++++++++++++++++++++
 arch/sandbox/include/asm/setjmp.h |   5 +
 cmd/Kconfig                       |  17 +++
 cmd/Makefile                      |   2 +
 cmd/spawn.c                       | 176 +++++++++++++++++++++++++++++
 common/console.c                  |   2 +
 common/cyclic.c                   |   3 +
 doc/develop/index.rst             |   1 +
 doc/develop/uthread.rst           | 136 +++++++++++++++++++++++
 drivers/usb/host/usb-uclass.c     | 168 +++++++++++++++++++---------
 include/u-boot/schedule.h         |   3 +
 include/uthread.h                 |  44 ++++++++
 lib/Kconfig                       |  21 ++++
 lib/Makefile                      |   2 +
 lib/time.c                        |  10 +-
 lib/uthread.c                     | 178 ++++++++++++++++++++++++++++++
 test/boot/bootdev.c               |  14 +--
 test/boot/bootflow.c              |   2 +-
 test/cmd/Makefile                 |   1 +
 test/cmd/spawn.c                  |  33 ++++++
 test/lib/Makefile                 |   2 +
 test/lib/initjmp.c                |  72 ++++++++++++
 test/lib/uthread.c                |  68 ++++++++++++
 30 files changed, 1122 insertions(+), 61 deletions(-)
 create mode 100644 arch/sandbox/cpu/initjmp.c
 create mode 100644 cmd/spawn.c
 create mode 100644 doc/develop/uthread.rst
 create mode 100644 include/uthread.h
 create mode 100644 lib/uthread.c
 create mode 100644 test/cmd/spawn.c
 create mode 100644 test/lib/initjmp.c
 create mode 100644 test/lib/uthread.c

-- 
2.43.0

