Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A904C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 15:34:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9433681420;
	Tue,  4 Mar 2025 16:32:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zmq+eE8K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94ADA81253; Tue,  4 Mar 2025 16:32:19 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC5088169D
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 16:32:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-390ec7c2cd8so2956097f8f.1
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 07:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741102284; x=1741707084; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6dPblarylN8souWe5s8hv1iSPguaPR0c9vbblRNbfZ0=;
 b=zmq+eE8KSFu2USnhQFIqdQIogSVyv9Y61PFzn9+836T9pZxglTrW/7z6f57i9SknAx
 eXV1zZcaLxbDCf52MgjVvIu6GupnjJI+xrN2Xgs27NrvyTUocC4NBWeeRXP1EenMm65N
 R6At1347+ymemJva7oF4+KNvyptO1SfA+zyY2qZTx/QiI+f7BbHBCfcBJeIfJJ9opB3h
 j3bIOM9fbk4KGjVN0ffObvxGlYaWgRyC43TQ0m8ZuSZpP46hgfUy8TtpoZ5NTJKDVjSU
 UfxjuM9aj0FLOM1OeLQ3s7LXzZVuxVn0UxAOWJV7glN5CuUSuZwsK161AYgr8WfJkWfJ
 Vctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741102284; x=1741707084;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6dPblarylN8souWe5s8hv1iSPguaPR0c9vbblRNbfZ0=;
 b=C1hvvKBo+WqtMTw6cbgZFWEatpN6rn5sGMEz0zyavdkxxx7DjcJWo4YMooYIEkhzf3
 tbjZKyUkX7ZEcynutHfc1mJmdCnBQXg7NsnftJYK6V5mHL+L/JhSUCqcVi+LMdjsbuNp
 KlCoxZ1lAEhEXTlbGDdoTzTVuzOF6WVZyQdHCvy1k7zV2JG1AXzmPIEmSIjCjPb9QtWX
 phlb4GnIWEKiPrjDJxZ/RLsJB0fRXu3OZkqyx462qrFOyOKDk374ABAmMEVaXbSgRsaI
 1/c1CrCqlsxe4pYMiEQgLvl5469VoIDeuoyC59BCMZ1rnBhB6kdd3CWTfzcJgZZUTcZC
 pbJw==
X-Gm-Message-State: AOJu0YwxrMVHskP/PShboAsw/xIMoMJP+OEyfe6q1BcFpoTr58vyd+mo
 WuL2M+xwOsiNyrg5PIOz/Nm8/KAZisXFeLBNiEchfSfy7KsW2xAujjXW28O4jYXF9vNSh/NbZnE
 H
X-Gm-Gg: ASbGncuFiQCkcdtkJe5ReLFdp0xba8FipwAfe4b1KB77E6rvHzen2QeCGEgqgdo+RkR
 o43HM1jlIqY4Gzia/LohnOEG2x2ZSZlJbVXRdQ2feQ++xkS+qvSUYoyP274ZAfKTNtu73ry3mUY
 CpU+wcicnEzr6/uEpt/hGunNrUiRCdT6fLcDCinu77/9J7Rw6wb7rtTOooIiEZf9XxkCwz2cLJw
 DRRH8uOGab5KKDKHTA2K7VnGF5QWQIdBQVfYaUAHnUsRpzch+nOec/tFvT+4VWv/G18r1DknrP2
 RDndkXAM5SxPAVFUDc362JY5K9p2LfwkEa4ft8z2B+JQLyu+knIFsg==
X-Google-Smtp-Source: AGHT+IFriBjiZDeGPZ43xaKTDwIMKjNr63ECK43Z2Rc3MrfPYV5h7fs+OMp4KC+sbklv59c1r8lEAg==
X-Received: by 2002:a05:6000:381:b0:391:6fd:bb64 with SMTP id
 ffacd0b85a97d-39106fdbc4cmr6505244f8f.13.1741102283915; 
 Tue, 04 Mar 2025 07:31:23 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:771e:3d0f:d9c9:2f92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485db82sm17669254f8f.88.2025.03.04.07.31.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 07:31:23 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v3 00/14] Uthreads
Date: Tue,  4 Mar 2025 16:24:48 +0100
Message-ID: <20250304152510.2832340-1-jerome.forissier@linaro.org>
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
shell via two new commands: 'spawn' and 'wait'. Note that it needs to
be applied on top of "common: clean up usage of structure jmp_buf_data"
by Heinrich S. [1].

The threading framework is called 'uthread' and is inspired from the
barebox threads [2]. setjmp() and longjmp() are used to save and
restore contexts, as well as a non-standard extension called initjmp().
This new function is added in several patches, one for each
architecture that supports HAVE_SETJMP. A new symbol is defined:
HAVE_INITJMP. Two tests, one for initjmp() and one for the uthread
scheduling, are added to the lib suite. NOTE: the SANDBOX version of
initjmp() appears to have problems and needs to be worked on.

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
 arch/arm/lib/setjmp.S         |  11 ++
 arch/arm/lib/setjmp_aarch64.S |   9 ++
 arch/riscv/lib/setjmp.S       |  10 ++
 arch/sandbox/cpu/Makefile     |  11 +-
 arch/sandbox/cpu/initjmp.c    | 172 +++++++++++++++++++++++++++++++
 cmd/Kconfig                   |  17 +++
 cmd/Makefile                  |   2 +
 cmd/spawn.c                   | 188 ++++++++++++++++++++++++++++++++++
 common/cyclic.c               |   3 +
 doc/api/index.rst             |   2 +
 doc/api/setjmp.rst            |  20 ++++
 doc/api/uthread.rst           |  19 ++++
 drivers/usb/host/usb-uclass.c | 168 +++++++++++++++++++++---------
 include/setjmp.h              |  29 ++++++
 include/u-boot/schedule.h     |   3 +
 include/uthread.h             | 123 ++++++++++++++++++++++
 lib/Kconfig                   |  29 ++++++
 lib/Makefile                  |   2 +
 lib/time.c                    |  21 +++-
 lib/uthread.c                 | 139 +++++++++++++++++++++++++
 test/boot/bootdev.c           |  14 +--
 test/boot/bootflow.c          |   2 +-
 test/cmd/Makefile             |   1 +
 test/cmd/spawn.c              |  32 ++++++
 test/lib/Makefile             |   2 +
 test/lib/initjmp.c            |  72 +++++++++++++
 test/lib/uthread.c            |  80 +++++++++++++++
 29 files changed, 1138 insertions(+), 61 deletions(-)
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

