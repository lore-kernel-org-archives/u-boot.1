Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE1FC0218A
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 10:20:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F047A81D6A;
	Tue, 28 Jan 2025 11:20:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hPWUGWGj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A99A81D67; Tue, 28 Jan 2025 11:20:08 +0100 (CET)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAE92819B1
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 11:20:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so59518075e9.2
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 02:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738059605; x=1738664405; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rUrgf3lxJSTo0DJpV41maSi1L7zCKB+pMrNF7qyWqqw=;
 b=hPWUGWGjrp0yblwHC6pebCXhVqxXnMNxUBXOpSIkQmHEAhMw2rtynHOeqJ/emepouR
 WdciWft7GsqgqrJQS+MXx25F01qJKd/TdXfjIA7Lb3Cd8pL+/Z5YCx16PexaWjnW5Vg0
 ijhBjAfdHmmc+PnZANHGmIdhA7HjgAuUZgSvB0mkxWrfl2IrMhPg9+UnP+oY2psBNG5/
 209sKP2eGkHnhKWlLUca3zHGateazrMlrLkDUelZo/Rtvcb1SBzCa83vW4ieGR2R4wpO
 lCXpZ6qmka8oOv9nxBKTPHCuEdQmV59OZ7nK2vz/vw5XOs4NYWdL48BuNflECFihENQI
 CuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738059605; x=1738664405;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rUrgf3lxJSTo0DJpV41maSi1L7zCKB+pMrNF7qyWqqw=;
 b=jkB6ckHZWOdtJOe6/e62WoN93lZFycrUAmD2hUW8tPIPZd9U62b4l2M42jwmqEjMFR
 WntZ0HNVhPzDhSOq4jz1U55Vke4x2IGOs0DglFIs/D9rSDAcH2rcHzkLMg+VR+GdiB3c
 EmtaRaasMGTdZyqCxVhnFSeEyCRTej4omH+9Sa9uC/wixWOxAWaIQnsTc30N5FVTAIgO
 kExneRs9TxBzOUB41tiSLcaH4NJrdfZaEOd8MWfBKsgoAe58Q057nPrMbC9VLdWBfhCf
 GDTUuGCbIbyl+D5WEE4pX1CSOnsw0pCbta6fxjj93uyC1NmFvmu1j0JJlH8ZtcY0yfc+
 iocw==
X-Gm-Message-State: AOJu0YxgttRZdSiTKPPTU9Prsnj4FxOduWpxOudiF3pI+/y6O8rNg5KX
 633SZVMIX2EWbGYKkB/udddaBDPg8mYORd7+6KyB0jhud+2Z9dwfxFtibuaiUXdjBJCbkYPT4A1
 uXG3yLTfs
X-Gm-Gg: ASbGncscBs75dMyqwOSTWBrFevV1hIK8SJ850R7bBblW+bpqBp7jGgp618C4htGcFEr
 7QOWPUc69Sdc8yWqwaof/I4A+JTg04OT7934IpnRtpMUjb5+WX6eIxmJT2P8GeLYdtX92vh/1iX
 vSYUiV4x2B8ddTEe0XSifz1+hjE379iOaAUQTkTpr/9AKMeSrv+/2vTW4b8y2x/3DweZMF20PvQ
 LOxhPtXrvSFRm5VyC8G3w5r+vOhc1mcpmPDTQiJsmH7noL4ZHVnlpjeOm5gblFhqe7NsIYlxdCm
 MKT/OS6zVSzPM+588i25Xps=
X-Google-Smtp-Source: AGHT+IFDq0BD8e/Sw9SOEp78nato6x9McP7Ogn9tL382LB0eAxsGZeC3AEJnY+2wlYuGPPqUJTed9g==
X-Received: by 2002:a05:600c:3d96:b0:434:a26c:8291 with SMTP id
 5b1f17b1804b1-4389143b5dbmr393008455e9.24.1738059603867; 
 Tue, 28 Jan 2025 02:20:03 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:45e:43e2:ed61:42fe])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4b9977sm164651245e9.25.2025.01.28.02.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 02:20:03 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [RFC PATCH v2 0/3] Coroutines
Date: Tue, 28 Jan 2025 11:19:14 +0100
Message-ID: <cover.1738059345.git.jerome.forissier@linaro.org>
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

This series introduces a simple coroutines framework and uses it to
speed up the efi_init_obj_list() function. It is just an example to
trigger discussions; hopefully other places in U-Boot can benefit from
a similar treatment. Suggestions are welcome.

I came up with this idea after analyzing some profiling data (ftrace)
taken during the execution of the "printenv -e" command on a Kria KV260
board. When the command is first invoked, efi_init_obj_list() is called
which takes a significant amount of time (2.872 seconds). This time can
be split into 0.570 s for efi_disks_register(), 0.811 s for
efi_tcg2_register() and 1.418 s for efi_tcg2_do_initial_measurement().
All the other child functions are much quicker. Another interesting
observation is that a large part of the time is actually spent waiting
in __udelay(). More precisely:
- For efi_disks_register(): 421 ms / 570 ms = 73.8 % spent in __udelay()
- For efi_tcg2_register(): 805 ms / 811 ms = 99.1 % spent in __udelay()
- For efi_tcg2_do_initial_measurement(): 1395.025 ms / 1418.372 ms =
  98.3 % spent in __udelay()

Given the above data, it is reasonable to think that a nice speedup
could be obtained if these functions could somehow be run in parallel.
efi_tcg2_do_initial_measurement() unfortunately needs to be excluded
because it depends on the first two. But efi_disks_register() and
efi_tcg2_register() are clearly independant and are therefore good
candidates for concurrent execution.

So, I considered two options:

- Spin up a secondary core to take care of one function while the other
one runs on the main core
- Introduce some kind of software scheduling

I quickly ruled out the first one for several reasons: initializing a
secondary core is typically quite hardware-specific, it would not scale
well if more functions than available cores would need to be run in
parallel, it would make debugging harder etc.
Software scheduling however can be accomplished quite easily, especially
since we don't need to consider preemptive multitasking. Coroutines [1]
for example can perfectly do the job. They provide a way to save and
restore the execution context (registers and stack). Here is how it
look like:

static void do_some_work(int v)
{
	int i;

	for (i = 0; i < 5; i++) {
		printf("%d", v);
		/* Save context and resume main thread */
		co_yield();
	}
}

static void co1(void *arg)
{
	do_some_work(1);
	/* Mark coroutine as "done" and resume main thread */
	co_exit();
}

static void co2(void *arg)
{
	do_some_work(2);
	co_exit();
}

void main_thread(void)
{
	struct co *co1, *co2;

	co1 = co_create(co1, ...);
	co2 = co_create(co2, ...);

	do {
		printf("A");
		if (!co1->done) {
			/* Invoke or resume first coroutine */
			co_resume(co1);
		}
		printf("B");
		if (!cor21->done) {
			/* Invoke or resume second coroutine */
			co_resume(co2);
		}
	} while (!(co1->done && co2->done));

	/* At this point, co1 and co2 have both called co_exit() */
}

The above example would print: A1B2A1B2A1B2A1B2A1B2.

- The first commit introduces the coroutine framework, loosely based on
libaco [2]. The code was simplified and reformatted to better suit
U-Boot.
- The second commit modifies efi_init_obj_list() in order to turn
efi_disks_register() and efi_tcg2_register() into coroutines when
COROUTINES in enabled. On a KV260 board with a SD card inserted, this
saves about .6 second (2.2 s instead of 2.8 s).
- The third commit applies coroutines to usb_init(), which can
significantly reduce the time it takes to scan multiple buses. Tested
on arm64 QEMU with 4 XHCI buses: the USB scan takes  2.2 s instead of
5.8 s.

[1] https://en.wikipedia.org/wiki/Coroutine
[2] https://github.com/hnes/libaco/

Changes in v2

- Remove x86 and x86_64 arch code since it is untested
- Add missing SPDX license tag to arch/arm/cpu/armv8/co_switch.S
- Change Apache-2.0 SPDX license tag to "Apache-2.0 OR GPL-2.0-or-later"
- Apply coroutines to the USB bus scan in usb_init()
Jerome Forissier (3):
  Introduce coroutines framework
  efi_loader: optimize efi_init_obj_list() with coroutines
  usb: scan multiple buses simultaneously with coroutines

 arch/arm/cpu/armv8/Makefile    |   1 +
 arch/arm/cpu/armv8/co_switch.S |  36 +++++++
 drivers/usb/host/usb-uclass.c  | 152 +++++++++++++++++++++++++++++-
 include/coroutines.h           | 130 ++++++++++++++++++++++++++
 lib/Kconfig                    |  10 ++
 lib/Makefile                   |   2 +
 lib/coroutines.c               | 165 +++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_setup.c     | 113 +++++++++++++++++++++-
 lib/time.c                     |  14 ++-
 9 files changed, 615 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/cpu/armv8/co_switch.S
 create mode 100644 include/coroutines.h
 create mode 100644 lib/coroutines.c

-- 
2.43.0

