Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131A7CD5BCF
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 03:44:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24DEF848BF;
	Tue, 26 May 2026 05:44:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="OWPrCdF9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC202848E6; Tue, 26 May 2026 03:42:19 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA8DC84881
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 03:42:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 29F8E3F6C9
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 01:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779759737;
 bh=46mzKJxr6Vd9s/ksLhuOSc9pmwcsTD2w+0ckCUlP6Qc=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=OWPrCdF9rhs/fan4uuiUhojCsy6xYG9Q9SjLuSdvhjjCtnsUvOF55b1vRStzEbI9+
 8vCao4HbBF+lG+4TcgUhEB+esMsL3ls4Uqudc6ktMCQ4oNp8U9wadPcTO7wHroxTW+
 XVJ6cRaD76h59l4ZW+wtdH6Z4GEgLzXOjta2qIXCrB7txQ6Ob0HCwNeXnEUlkDqv/u
 d/ZMFLQliq5SMINiXnESZ6+5Nv7IDOYRQejEbymYZp646IG/xburiViQfaNZAbzyzg
 A8etZgMtKXU8bW6Kot1ucRWyNutC+ayPykBruT6NIuTg0rInHTOhR4asiHd8fvYBmA
 MeYFjmRw0vB4+O8rC2PcDwqVqBdknmmJqarUTZkKVFUPLGYWda+0C5aT+pVUtm39aA
 G0nvmxw6APk74r2+dFhJICZGtpLpmIlIO8edBvp4lnl/TudYgmawPhV+fPjpK7l4YB
 V7lBsaULnSxdP2bUeZpFtQc1PVM5VJIadhlP4wQrUk2lyCApSxHEMI0XnSRxJgSaGe
 8oT55qRV5gTsxmmf8E8yArNh+fnx3tUicVbV6bEqMJmy0KejWQoHk2LJPBV2CV2aRF
 KMAL9iSBTW0Qt8SH0n5CeTe0cn1oW3zGC48jOOGItqebDeg9LKzYtXk6wgSN0rvh2w
 0WTXgEf1FAIPX49TqyK6jXU0=
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-367cb6de61aso2940047a91.1
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 18:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779759735; x=1780364535;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=46mzKJxr6Vd9s/ksLhuOSc9pmwcsTD2w+0ckCUlP6Qc=;
 b=jC+PW4/sIjKE8ZXqH80LH/YHi/e+p291g0RThqdZy8FiTNH61r9jWk7cGfu9o0y58n
 CWw2oK079A9RpPWY00SLPpQqwN708B1kDy2QdycGJuMDwYkGslKXcIotlKDdI1MZdtiO
 V1oEbRs9Q1U87jKf6Y9/gDVbpM0rNwDlWWnOGGL3gU1aHaVd4oyfzA2JD9bRMf2T/Fw0
 0huAL/eeLjcFe1BXCDdObpHsOoYwFafZQ9aCTZQKGNRxhk+0CuAtcMjmn9yJ8bVyoK1P
 xz9bWyTVK3Eg8lh2SWimWa4S0DYvbTWZY77bDFHyAVQSo/CY8TFgapCaIFCNAENWYl2l
 VIBw==
X-Gm-Message-State: AOJu0Yyv469dHHF4ay4KKiJRxhIrjCDk54nTrSLSuhOVj/zJzDzsyXVl
 zeH7jlr1v/TmWUuWuAhblhydZM/FFZ8CPSmDo+uJ2ixOmNPvy2qtYdTQL3/aDzQA8d481CXvv4V
 cwgbx+bOoL3xdk7PFT9+i25U7J19iTOIQv7Zmvp3H74c/zIjhkl70dzWogsmSR883KB8OgvP7OA
 siBlKqpQ==
X-Gm-Gg: Acq92OFfZxYzDarA5H92mhFIUV7SaPVl9CcJvyq/ou4iph77yah4BQpAkcaa1XUxjhf
 C5O0VJGHkpCeIfSeK+j4F050tfsRaGRS9EXxE0yVYtDSZqTJ602Ti0FblgBr6XxyxIfMnqzxd4z
 glmnHiybTKU+8V7mkERPYZLg1z4PullJm82Y434YQt6OnXQeUFL2E2UKfYLd7COXf09vZBjFvCZ
 g9f1lyKYnT8GfI9XzcKomQ/mAFC4wC+FgRpyVOphzHDqoKZoYRM2p4Yo1fy0LKVa/2B6fa0z+9C
 fC6laEx8M3Z8kVMwupgBL++WofTLqpnqBjMUXQ9zpgGSXSQ8RuEcUFtZcBNd1ftTTk6TpYspu8P
 gpaBs22ZNIrnGLEJgMqanU6tocig3Ojy137F0Ez+cK5TnVI39fEkHe5+q4L+fQW6Sj4oH1zM1wp
 w7CwUxThIwfMk1ASk=
X-Received: by 2002:a17:90b:5485:b0:36a:aeaf:ab2a with SMTP id
 98e67ed59e1d1-36aaeafabf7mr8424798a91.19.1779759735346; 
 Mon, 25 May 2026 18:42:15 -0700 (PDT)
X-Received: by 2002:a17:90b:5485:b0:36a:aeaf:ab2a with SMTP id
 98e67ed59e1d1-36aaeafabf7mr8424782a91.19.1779759734769; 
 Mon, 25 May 2026 18:42:14 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a7263178dsm14398196a91.3.2026.05.25.18.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 18:42:14 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 0/1] treewide: prefer __func__ over __FUNCTION__ and
 __PRETTY_FUNCTION__
Date: Tue, 26 May 2026 01:41:39 +0000
Message-ID: <20260526014144.3519-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 26 May 2026 05:44:15 +0200
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

The remaining 55 occurrences of __FUNCTION__ across 19 files plus the
lone __PRETTY_FUNCTION__ in drivers/usb/musb-new/omap2430.c are
converted to the C99-standard __func__ identifier. In C (unlike C++)
__PRETTY_FUNCTION__ is identical to __func__, so behaviour is
unchanged.

Small pre-existing style issues on the lines being touched (comma
spacing, "printf (" spacing, one mis-aligned continuation, missing
space in string-literal concatenation around __func__) are fixed in
the same pass so checkpatch comes out clean on the rename hunks.
Other instances of the same patterns elsewhere in the same files are
deliberately left alone to keep the diff focused.

Ten "Unnecessary ftrace-like logging" warnings remain on
function-entry traces of the form printf("%s\n", __func__) and
dbg("%s\n", __func__) in drivers/net/rtl8169.c (behind
DEBUG_RTL8169* preprocessor guards) and drivers/usb/host/ohci-hcd.c.
checkpatch matches that literal shape regardless of the wrapper, so
silencing them would require changing debug message text or removing
the traces entirely.

Build tested on CMPCPRO and socrates (powerpc), guruplug (arm
kirkwood), jetson-tk1 (arm, exercises drivers/net/rtl8169.c),
brcp170 (arm zynq, exercises drivers/fpga/xilinx.c and spartan*),
am3517_evm (arm, exercises drivers/usb/musb-new/omap2430.c) and
sandbox.

Aristo Chen (1):
  treewide: prefer __func__ over __FUNCTION__ and __PRETTY_FUNCTION__

 arch/arm/mach-kirkwood/cpu.c       | 10 +++++-----
 arch/mips/include/asm/system.h     |  4 ++--
 arch/powerpc/cpu/mpc85xx/liodn.c   |  2 +-
 board/Marvell/guruplug/guruplug.c  |  2 +-
 board/socrates/nand.c              |  2 +-
 boot/fdt_support.c                 | 14 +++++++-------
 drivers/ddr/fsl/main.c             |  2 +-
 drivers/ddr/fsl/mpc85xx_ddr_gen1.c |  2 +-
 drivers/ddr/fsl/mpc85xx_ddr_gen2.c |  2 +-
 drivers/ddr/fsl/mpc85xx_ddr_gen3.c |  2 +-
 drivers/fpga/spartan2.c            | 12 ++++++------
 drivers/fpga/spartan3.c            | 12 ++++++------
 drivers/fpga/xilinx.c              | 12 ++++++------
 drivers/net/mcfmii.c               |  2 +-
 drivers/net/rtl8169.c              | 18 +++++++++---------
 drivers/rtc/m41t62.c               |  4 ++--
 drivers/usb/host/ohci-hcd.c        |  2 +-
 drivers/usb/musb-new/omap2430.c    |  2 +-
 examples/standalone/sched.c        |  2 +-
 include/usbdevice.h                |  6 +++---
 20 files changed, 57 insertions(+), 57 deletions(-)

-- 
2.43.0

