Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0833AC3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 12:31:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7936D8171B;
	Mon, 31 Mar 2025 14:31:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SBBEe6Ij";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6259B81E60; Mon, 31 Mar 2025 14:31:35 +0200 (CEST)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DA4481703
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 14:31:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-3912d2c89ecso3905509f8f.2
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 05:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743424292; x=1744029092; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Rru4VkyuErfQgN73Ry0SYP1FFMxA7NgKent1bS7oVTA=;
 b=SBBEe6IjU9MHZs0EFTfYvBlFeOwV1ZodpNZ4v+k0sQ503zUZUe6SQqk0M2bvKuwiSg
 n2sJZa154fuqJgJZQ5v+AGSJmAd/pJHigG6lMwzqioxJk7oCnBB78KfqM/UDTVNj23+x
 o149tsxxVHtroTNCjzJx6FN4AVr1Ox5HJxnu9ibGeU3LZjMZYvrgcUAvHnO8LYTfAALg
 MX9KZrBS/L9yrr/dbvVd0BjuUnSDfPMEntIhE+mJrW4IatqDMv8w+aggDz69MASbtE0s
 VSohp50lLJ75sMzkUQkptEaZ+FpmxbhbaczWk23/exVSbiTsCSTTBa2v3uKtNtDRUl+u
 SSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743424292; x=1744029092;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rru4VkyuErfQgN73Ry0SYP1FFMxA7NgKent1bS7oVTA=;
 b=BUDMKw+HEdrKSRqoXQSMDiPk1uidfYr4LayLQIXJpQ3NM8CJJKYdNRDF0SflH5A5p4
 bAX9GxJaEDLOhu8U5WIVpRtlSO9CC+QqBFPIbp4nelog9Br1kGS0Gb/r4oj5kuYKz06q
 5tzvpaOQlvGlm08NJ0Bpf5UyVFIwb5wkTnJL0XwOuC9dAbQRYeD5lfBrYKW6WHGDAqiT
 gcXRKRz78fmImGQs3VVVTPmlnhCJuOy9eFrvXujZ+se/k/yL1IWAVH32HAtjrwcIC7la
 k25nl7wjBBJqjTwtDzmjZw0DI93ochi2fH//vL/2ybdEK+5nB5+bT5qZbqowOVTvIGBC
 p5OQ==
X-Gm-Message-State: AOJu0YzFmLJ+wzqhwJrLPaJXpspoI1JqwDTBXqMx3Akg20SidP6RnrlQ
 m/arnu71GjFWFtmcO4yWQTYk0bcL1LYhSxgsbPlbtI42DbYuz0Laqs1KbdvM0FbSvIXqFu6dJsS
 XeozqLzGq
X-Gm-Gg: ASbGnctflvTuBYEPtjMlDozxJha/kSWf4NJtuPtH83a2vpUE9y+Scz93UcY5zpfr8Ak
 GLg0hGyv7DI3TTzWIs+bpj6SZU4qSh6QBevv0di7WHkmA1+Aynu3Wbp5bK7ctkpjwiFCsimMLFE
 tmxVToYx9rcWy9XQUITohrfItG30rk+t9JcVy/hEeTZ6lz2HnBRnc9vgs1fIHP08G/sAZ+2FVhN
 KBxIIPgpdWYlCfilZsDiPgBNr2zCLFq+duVZ1IfuEiowFEDNQBUdaFaPbb/1ISeGNimCGERSghk
 cbE/EBB4VDXKtcOAxikaIgYV3Rs5j+TCaP7EthrkwGvTR9kpLVYu
X-Google-Smtp-Source: AGHT+IEe0Pig3MSPYPowtcw2OuTG8ZsMWII8l+niGUbJUllNtqdu0/9syyt9kiwe6wSFl3QzTVgT7w==
X-Received: by 2002:a05:6000:1446:b0:38d:e6b6:508b with SMTP id
 ffacd0b85a97d-39c120cb5e5mr7117926f8f.9.1743424291730; 
 Mon, 31 Mar 2025 05:31:31 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:f23c:25c9:dc74:be1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b6589e4sm11337029f8f.10.2025.03.31.05.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 05:31:31 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v5 00/16] Uthreads
Date: Mon, 31 Mar 2025 14:30:54 +0200
Message-ID: <20250331123120.2025062-1-jerome.forissier@linaro.org>
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

This series introduces threads and uses them for two things:
- Improve the performance of the USB bus scanning code (scan multiple
busses simultaneously),
- Implement background jobs in the shell via two new commands: 'spawn'
and 'wait'.

The threading framework is called 'uthread' and is inspired from the
barebox threads [2]. setjmp() and longjmp() are used to save and
restore contexts, as well as a non-standard extension called initjmp().
This new function is added in several patches, one for each
architecture that supports HAVE_SETJMP. A new symbol is defined:
HAVE_INITJMP. Two tests, one for initjmp() and one for the uthread
scheduling, are added to the lib suite.

The schedule() and udelay() function are updated to become thread
re-scheduling points, and mutex objects are introduced. With that the
USB stack initialization is modified to benefit from concurrency when
UTHREAD is enabled, where uthreads are used in usb_init() to initialize
and scan multiple busses at the same time. The code was tested on arm64
and arm QEMU with 4 simulated XHCI buses and some devices. On this
platform the USB scan takes 2.2 s instead of 5.6 s. Tested on i.MX93 EVK
with two USB hubs, one ethernet adapter and one webcam on each, "usb
start" takes 2.4 s instead of 4.6 s.

Finally, the spawn and wait commands are introduced, allowing the use of
threads from the shell. Tested on the i.MX93 EVK with a spinning HDD
connected to USB1 and the network connected to ENET1. The USB plus DHCP
init sequence "spawn usb start; spawn dhcp; wait" takes 4.5 seconds
instead of 8 seconds for "usb start; dhcp".

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=446674
[2] https://github.com/barebox/barebox/blob/master/common/bthread.c

Changes in v5:
- Rebase on top of next (at d5742298803 "Merge tag 'qcom-next-20250324'
of https://gitlab.denx.de/u-boot/custodians/u-boot-snapdragon into next")
- Apply review tags
- Explain why initjmp() is introduced for every platform (arm, riscv,
sandbox).
- Implement mutexes ("uthread: add uthread_mutex", "test: lib: add
uthread_mutex test")
- USB: keep 'controllers_initialized' local to usb_init() and use the DM
function device_active() to count the controllers initialized successfully.
Protect the USB devices with a mutex (so usb_init() cannot run concurrently
with usb_stop()).
- Fix copyright in cmd/spawn.c

Changes in v4:
- Rebase on top of next (at 5ca70325b64 "Merge branch 'fixes' of
https://source.denx.de/u-boot/custodians/u-boot-tegra into next")
- Add a stack_sz parameter to initjmp(). This is made necessary by the
sandbox implementation which relies on sigaltstack(), which need both
the stack base address and its size in its stack_t argument. In any
case it is cleaner to provide the exact stack boundaries. With that,
a crash was fixed on sandbox in the lib_initjmp unit test.
@Ilias: I kept your R-b on the two patches with a trivial change
(passing one more parameter), but I removed it from "arm: add initjmp()"
since there's one more line of assembly code and who knows what I might
have done wrong ;)
- Remove symbol UTHREAD_GRANULARITY and use a tight scheduling loop in
delay() instead. Tests on an i.MX93 board have shown that setting
UTHREAD_GRANULARITY as low as 10 microseconds (or higher) can have a
negative impact on the console input (some key presses do not register)
while 0 makes the console fully responsive.  The test consist in running
"spawn sleep 10" and typing a command. I suspect other platforms may
behave similarly, therefore do not bother with the added complexity of
a configurable delay.
- Apply review tags

Changes in v3:
- Rebase on top of Heinrich's series "common: cleanup usage of structure
jmp_buf_data":
https://patchwork.ozlabs.org/project/uboot/list/?series=446674
https://lists.denx.de/pipermail/u-boot/2025-March/582221.html
- HAVE_INITJMP now depends on HAVE_SETJMP. Provide proper Sphinx-like
documentaion for initjmp().
- test/lib/initjmp.c: change SPDX license tag from GPL2.0+ to
GPL-2.0-or-later
- Add doc/api/setjmp.rst. The initjmp() test is used as an example in the
documentation.
- uthread_create() now accepts an optional user-allocated struct uthread
- Remove the list_empty() test from uthread_schedule() (not needed)
- Add Sphinx doc to all functions in uthread.h (moved from uthread.c).
- Add doc/api/uthread.rst. The uthread test is used as an example in the
documentation.
- Document struct uthread and its components
- Provide numbers to justify the scheduling loop in udelay() in commit
"lib: time: hook uthread_schedule() into udelay()".
- Do not insert uthread_schedule() in common/console.c:fgetc() since it
is already in schedule()
- The wait command can be interrupted with Ctrl-C
- Switch spawn and wait tests from DM_TEST() to CMD_TEST()
- Add MAINTAINERS entry
- Apply review tags

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

Jerome Forissier (16):
  arch: introduce initjmp() and Kconfig symbol HAVE_INITJMP
  arm: add initjmp()
  riscv: add initjmp()
  sandbox: add initjmp()
  test: lib: add initjmp() test
  uthread: add cooperative multi-tasking interface
  uthread: add uthread_mutex
  cyclic: invoke uthread_schedule() from schedule()
  lib: time: hook uthread_schedule() into udelay()
  test: lib: add uthread test
  test: lib: add uthread_mutex test
  dm: usb: move bus initialization into new static function
    usb_init_bus()
  dm: usb: initialize and scan multiple buses simultaneously with
    uthread
  cmd: add spawn and wait commands
  test: cmd: add test for spawn and wait commands
  MAINTAINERS: add UTHREAD

 MAINTAINERS                   |   9 ++
 arch/Kconfig                  |   9 ++
 arch/arm/lib/setjmp.S         |  12 +++
 arch/arm/lib/setjmp_aarch64.S |  10 ++
 arch/riscv/lib/setjmp.S       |  11 ++
 arch/sandbox/cpu/Makefile     |  11 +-
 arch/sandbox/cpu/initjmp.c    | 175 +++++++++++++++++++++++++++++++
 cmd/Kconfig                   |  17 +++
 cmd/Makefile                  |   2 +
 cmd/spawn.c                   | 188 +++++++++++++++++++++++++++++++++
 common/cyclic.c               |   3 +
 doc/api/index.rst             |   2 +
 doc/api/setjmp.rst            |  20 ++++
 doc/api/uthread.rst           |  19 ++++
 drivers/usb/host/usb-uclass.c | 192 ++++++++++++++++++++++++----------
 include/setjmp.h              |  32 ++++++
 include/u-boot/schedule.h     |   3 +
 include/uthread.h             | 183 ++++++++++++++++++++++++++++++++
 lib/Kconfig                   |  21 ++++
 lib/Makefile                  |   2 +
 lib/time.c                    |   9 +-
 lib/uthread.c                 | 166 +++++++++++++++++++++++++++++
 test/boot/bootdev.c           |  14 +--
 test/boot/bootflow.c          |   2 +-
 test/cmd/Makefile             |   1 +
 test/cmd/spawn.c              |  32 ++++++
 test/lib/Makefile             |   2 +
 test/lib/initjmp.c            |  73 +++++++++++++
 test/lib/uthread.c            | 146 ++++++++++++++++++++++++++
 29 files changed, 1303 insertions(+), 63 deletions(-)
 create mode 100644 arch/sandbox/cpu/initjmp.c
 create mode 100644 cmd/spawn.c
 create mode 100644 doc/api/setjmp.rst
 create mode 100644 doc/api/uthread.rst
 create mode 100644 include/uthread.h
 create mode 100644 lib/uthread.c
 create mode 100644 test/cmd/spawn.c
 create mode 100644 test/lib/initjmp.c
 create mode 100644 test/lib/uthread.c

-- 
2.43.0

