Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAAFC02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 14:01:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA50580CB0;
	Fri, 14 Feb 2025 15:01:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Jcfbeokb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 984F280756; Fri, 14 Feb 2025 15:01:01 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22ED480C7E
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 15:00:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43948021a45so21919825e9.1
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 06:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739541658; x=1740146458; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AuE9vfbqyNesF3kfSnaNimSwy5hQ+ULzGj1F+MqyOZQ=;
 b=JcfbeokbTLGVdPl2PT6dWVldujaBBatXXo3oyqoBVBHCjiOTqPOlrQ2U4tbOvq4Ajl
 ue/+AyFVduecngJT6HAebXhoN+aAN2yIoZquMffjx5jIG9Ii5kYRwpDgFLMU44S32dyr
 kRg+OdJljxEV5HtMTJNjaYNKkTtsDv4wu6Ms5wGydOR6S4rxro/oa0njlJX6iaHigee/
 llLoF4P/n8WrR6eIwcJ+Kl/BSNc0AcVls5h/cJtIMhij2KK2ZLc4375HON5vvgfGVlK1
 dN61Ogoqdsi8Y4YkG7W4KYeei9LpS8X1FhO5PL/4d2Oya1E+1SRA9RQ0AcPuBuN9zani
 +X9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739541658; x=1740146458;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AuE9vfbqyNesF3kfSnaNimSwy5hQ+ULzGj1F+MqyOZQ=;
 b=qRaOIhp1a4f1vQh8sNpKVq4q5oN3Aql8NFtX3xpJlqu4FKBLt2uqQQV2bx2+98FK6R
 tW87kgmim2KgGiXGWaEdOaDJWuJ4jlO44PFWOvfPYxIRoAeWuwbbQsAPBYXKA3ttYBXM
 /BKGueUai7csFFtmc210bXITMy3Qn/kP1FmmpZA2bBvBp1MN3oyP+h18gkBSDCvadLAA
 XPiKhFWD3OggmcG72At+SlGn9h6Q5/Yjy9obt1LfeVAZC6po4zE4+rgmYSxKrmigB8tW
 Ne+RDGlwb/WxPkII7mDZKgOHQmTRywIdhEFj18DEoT93La8/SYTufh/EzzsXsOc0p5WH
 56ug==
X-Gm-Message-State: AOJu0YxhzdT8GAdDiEtHhcfd+CeJ0hW9brWAV7O+JnlpLhtwf2s5Y8/6
 UaMmeHQbjKvZuFGZf1qib8sx4ht18U07yIGF/SmqoqNN29rJOlg1oGiMaSJBDBpWTsHAciqHFlg
 ApwSKnA==
X-Gm-Gg: ASbGncsPFGlnmLybP35YBnJh3r2SciuI7GW2TPTt1xVvG2jQsU31Il+B8V6WFd0lWHp
 UmrPdHjEou5nxpKEW3Sn8+R75T+l77V1sWpBdsVL+6cyV7IQBaJbWXmWZWYIo12ZEqR2XdpGEua
 PKnU099qBVBCf3QYfdvpIJ5i8uy4iVxPmqUI3jXaXsV6Xq/gs6zvv26rBtoM/72cUt6Jh8bNtGs
 qllkT4LcQb37CeJTCJUcLUSMUtyKshf/5O4PrXY+g/fOi2vp9mWtDTTV1V8ade2d1NfsxWCpVV8
 i9IXd3CsTq1QJ6S41v+qHNF2
X-Google-Smtp-Source: AGHT+IE2sXu/pXYD5PXOUYi1G7rGK22KK6mSjJ5M4Pj4Gyy7yyEQhlyJwCbAHrv5o6bj+qmOlrnGxw==
X-Received: by 2002:a5d:5885:0:b0:38f:23ed:2c7 with SMTP id
 ffacd0b85a97d-38f23ed03d1mr10648901f8f.14.1739541656713; 
 Fri, 14 Feb 2025 06:00:56 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:65ac:d875:2c3e:607f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258fc7e0sm4666391f8f.48.2025.02.14.06.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 06:00:56 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [RFC PATCH 00/10] Uthreads
Date: Fri, 14 Feb 2025 15:00:15 +0100
Message-ID: <20250214140031.484344-1-jerome.forissier@linaro.org>
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

This is a rework of the "Coroutines" RFC v2 series [1] which allowed to
run functions in parallel, and more specifically the ones that rely
on udelay() to poll hardware and wait for some event to happen. With
that we have shown that some intializations could be sped up
(namely, efi_init_obj_list()).

In this new version I dropped coroutines for threads and used the USB
subsystem as a (hopefully) better example. The goal and the basic
concepts are the same but threads are likely more familiar to
programmers. The API is  more self-contained: the main thread just
needs to create the threads, call a schedule function, then cleanup.
Threads may yield the processor to another thread by calling the same
schedule function. When doing so they do not switch to the main thread;
they switch to the new thread directly. Another major change is the
simplification of the stack management. Now each thread has its own
stack, there is no stack sharing anymore. The code is inspired from the
barebox threads [2].

The custom assembly code that was present in the coroutines series is
mostly replaced by setjmp()/longjmp(). As a result, supporting multiple
architectures is much easier, although there is still a need for a
non-standard extension to setjmp()/longjmp() called initjmp(). The new
function is added in several patches, one for each architecture that
supports HAVE_SETJMP. A new symbol is defined: HAVE_INITJMP. Two tests,
one for initjmp() and one for uthread scheduling, are added to the lib
suite. NOTE: the SANDBOX version of initjmp() appears to have problems
and needs to be worked on.

After introducing uthreads and making udelay() a thread re-scheduling
point, the USB stack initialization is modified to benefit from
concurrency when UTHREAD is enabled, where uthreads are used in
usb_init() to initialize and scan multiple busses at the same time.
The code was tested on arm64 and arm QEMU with 4 simulated XHCI buses
and some devices. On this platform the USB scan takes 2.2 s instead of
5.6 s. Tested on i.MX93 EVK with two USB hubs, one ethernet adapter and
one webcam on each, "usb start" takes 2.4 s instead of 4.6 s.

With UTHREAD=y on qemu_arm64_defconfig the code size increases by less
than 1KB (936 bytes exactly).

CI:
- (UTHREAD not set):
  https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/24625
- (UTHREAD enabled for QEMU arm/arm64/riscv32/riscv64):
  https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/24626

[1] https://lists.denx.de/pipermail/u-boot/2025-January/578779.html
[2] https://github.com/barebox/barebox/blob/master/common/bthread.c

Jerome Forissier (10):
  arch: introduce symbol HAVE_INITJMP
  arm: add initjmp()
  riscv: add initjmp()
  sandbox: add initjmp()
  test: lib: add initjmp() test
  uthread: add cooperative multi-tasking interface
  lib: time: hook uthread_schedule() into udelay()
  dm: usb: move bus initialization into new static function
    usb_init_bus()
  dm: usb: initialize and scan multiple buses simultaneously with
    uthread
  test: lib: add uthread test

 arch/Kconfig                      |   8 ++
 arch/arm/include/asm/setjmp.h     |   1 +
 arch/arm/lib/setjmp.S             |  11 ++
 arch/arm/lib/setjmp_aarch64.S     |   9 ++
 arch/riscv/include/asm/setjmp.h   |   1 +
 arch/riscv/lib/setjmp.S           |  10 ++
 arch/sandbox/cpu/Makefile         |  11 +-
 arch/sandbox/cpu/initjmp.c        | 172 ++++++++++++++++++++++++++++++
 arch/sandbox/include/asm/setjmp.h |   5 +
 drivers/usb/host/usb-uclass.c     | 167 ++++++++++++++++++++---------
 include/uthread.h                 |  31 ++++++
 lib/Kconfig                       |  19 ++++
 lib/Makefile                      |   2 +
 lib/time.c                        |  17 ++-
 lib/uthread.c                     | 108 +++++++++++++++++++
 test/boot/bootdev.c               |  14 +--
 test/boot/bootflow.c              |   3 +-
 test/lib/Makefile                 |   2 +
 test/lib/initjmp.c                |  72 +++++++++++++
 test/lib/uthread.c                |  58 ++++++++++
 20 files changed, 660 insertions(+), 61 deletions(-)
 create mode 100644 arch/sandbox/cpu/initjmp.c
 create mode 100644 include/uthread.h
 create mode 100644 lib/uthread.c
 create mode 100644 test/lib/initjmp.c
 create mode 100644 test/lib/uthread.c

-- 
2.43.0

