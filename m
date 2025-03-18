Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C60C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 10:47:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C64AB8168B;
	Tue, 18 Mar 2025 11:47:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EdvvP2NW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72F4480F70; Tue, 18 Mar 2025 11:47:22 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E05E580107
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 11:47:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso33328025e9.3
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 03:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742294839; x=1742899639; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yOPgufj4kLRMSWQlYufILY6J9GW0j2tb3LYdXXWjnn4=;
 b=EdvvP2NWhuk37bz+wflCIK/0f8lsC0uusUIOxoFJ7hZgaOngEzE8mwDKmfBTVdon2w
 j/zzIevm2fQz/ablLDFn2aeiF+i3FhWNn4HlGvqtRGEkGatb45bYvmNjvkmjeCqeuOkL
 6uAoHS0V6HFZnXQEn9IbYR/PXLh5fhI//h+1A01iwUfP0q7yCpNuFNEDffNH0caSBoh/
 z/R6hVKOpTF1vQ2z9WwIPevRtQDXQ/W7WuaXXNTjhDj0jCYcV/UlUc4mNO8JKjtxuH+k
 5+qUeaRjLHYhyN2zci7h64F61Y1zRv64CACSxhuZlGGSx8Xj1ZMfi5TBnilQS3QEr82d
 nnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742294839; x=1742899639;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yOPgufj4kLRMSWQlYufILY6J9GW0j2tb3LYdXXWjnn4=;
 b=lsxaFzChgsObWtV+t0iCfj9jEAzS5xs83tZ50x8b+OMN4RnN8uWOjiDz4zIYYJdC85
 HoANrjAxQXTash3kDySu1t7kkzbp27C5p6w1J1ZlQ8TcRP6ijKaHUFYjSZtM2DxVP9TM
 O0Yjx39RQFSEv+8Zik7JXiutM5asKGqFgwBlo+p8RebcPhiKmXpRBMtnt18sU+CkbS4X
 NZ7ZQgsd+/tbFxkGWXUJf4em3q5u6OfRmTGhbC632re1u5cpztv2pKJOsJ+EWPEIS2vz
 igmyRpeOfkzd/uf5ELJwjmmf7vsno9OT2h2qcj8TuXE+Y9vnVqxSvF11zBfepFWTB00X
 VtFg==
X-Gm-Message-State: AOJu0YwTJ4eNoa4bvuBe3ZEI8BhHsxZveUXCadCD7+x7795F54u7IvPn
 TKvVaQVj/pgOng1dR2FFoWNow/QbqFl+NXbqU//iq4YZmIiMn43CGliB2xDbaBDS78zVC1uUeEU
 doiDJZw==
X-Gm-Gg: ASbGncvRP+12pnaSU6cU6HUAPTUEXB3Mob+UozETrOev2V7g0S74yjDocLed8N/t5bV
 UfHwIimeWTihC2qcyG22V/XoM5Revqzz4zFSZux1QAaE07YUEKud4JTIiBkDAWJfb97xln/TF5N
 N3dJd5mspceoxlCtcDUiNcG6faoWdLMQCnef/EjWjbTc6zgGp8VsQ0ld1e1TYW7Sv0arrfb68v1
 v+1ZX686m/j8LGDpKA2qEwKvdMSouzMBIE7dmALeu/KPZiws+bj/SwLd8K38Xt9KhkReSYfD8Es
 f2si+PGUD94v355185MeMJCAj8J/S61Bf3438Q9yaUucFUtsKN4CoA==
X-Google-Smtp-Source: AGHT+IF5kAZKsv52MkmtVpfPg8ABjyCefO4jUVijQQMmkj/cPuWZAe7zzAXrpY60+3m+gFep5tPXbA==
X-Received: by 2002:a05:600c:3492:b0:439:643a:c8d5 with SMTP id
 5b1f17b1804b1-43d3b7cc0bemr18717245e9.0.1742294839004; 
 Tue, 18 Mar 2025 03:47:19 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:78bd:2e7e:120c:26bb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fdda2dbsm131788185e9.2.2025.03.18.03.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 03:47:18 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v4 00/14] Uthreads
Date: Tue, 18 Mar 2025 11:46:36 +0100
Message-ID: <20250318104659.1114340-1-jerome.forissier@linaro.org>
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
barebox threads [2]. setjmp() and longjmp() are used to save and
restore contexts, as well as a non-standard extension called initjmp().
This new function is added in several patches, one for each
architecture that supports HAVE_SETJMP. A new symbol is defined:
HAVE_INITJMP. Two tests, one for initjmp() and one for the uthread
scheduling, are added to the lib suite.

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

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=446674
[2] https://github.com/barebox/barebox/blob/master/common/bthread.c

Changes in v4:
- Rebase on top of next (at 0e1fc465fea "Merge tag 'dm-pull-15mar25' of
git://git.denx.de/u-boot-dm into next")
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

Jerome Forissier (14):
  arch: introduce initjmp() and Kconfig symbol HAVE_INITJMP
  arm: add initjmp()
  riscv: add initjmp()
  sandbox: add initjmp()
  test: lib: add initjmp() test
  uthread: add cooperative multi-tasking interface
  cyclic: invoke uthread_schedule() from schedule()
  lib: time: hook uthread_schedule() into udelay()
  test: lib: add uthread test
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
 cmd/spawn.c                   | 188 ++++++++++++++++++++++++++++++++++
 common/cyclic.c               |   3 +
 doc/api/index.rst             |   2 +
 doc/api/setjmp.rst            |  20 ++++
 doc/api/uthread.rst           |  19 ++++
 drivers/usb/host/usb-uclass.c | 168 +++++++++++++++++++++---------
 include/setjmp.h              |  32 ++++++
 include/u-boot/schedule.h     |   3 +
 include/uthread.h             | 123 ++++++++++++++++++++++
 lib/Kconfig                   |  21 ++++
 lib/Makefile                  |   2 +
 lib/time.c                    |   9 +-
 lib/uthread.c                 | 139 +++++++++++++++++++++++++
 test/boot/bootdev.c           |  14 +--
 test/boot/bootflow.c          |   2 +-
 test/cmd/Makefile             |   1 +
 test/cmd/spawn.c              |  32 ++++++
 test/lib/Makefile             |   2 +
 test/lib/initjmp.c            |  73 +++++++++++++
 test/lib/uthread.c            |  80 +++++++++++++++
 29 files changed, 1128 insertions(+), 61 deletions(-)
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

