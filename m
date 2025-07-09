Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D113FC83F0A
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 16:15:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CC4B83479;
	Wed,  9 Jul 2025 18:15:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="bQZGTF3i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 090EE83479; Wed,  9 Jul 2025 18:15:18 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47C5B8344C
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 18:15:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 00E0422F5A;
 Wed,  9 Jul 2025 18:15:14 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tFJQAWG5JGpo; Wed,  9 Jul 2025 18:15:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1752077711; bh=SGCFwqTUN+iSeNbLgCJtCQU8dSGBOWcjyj42WhELzbI=;
 h=From:To:Cc:Subject:Date;
 b=bQZGTF3iM7unUEfbr3Hv9DsQYr6wzk/Gxn0qKCZPUDsGD1YW2mElmzjrI0F4dI2Op
 uwN3YBst+qfi1WMm+MWzWyY0HND/A+XVqVKyBYLqJEx22N3L5FMx3TcSX9bBDda+K3
 s7CxABt8/Vgz0dG5ih28KwreTwSBFO9/NyPQOoTWtaMoi3F4PcyF/A/LYnEb5BlLeJ
 gkJWzT4LdR4m2RkNv59qCbjJOodyvPOh/rCe9w37WpzMLQ5QCFOEZRinpBAstSpSrH
 hnuOxYZgwokvTfY+eETIjFHxhmrZGHp3DZhx7k17u4ffWO0AxdlEnlBIOxzfyYhUV1
 YLOaq6dqpYjYQ==
From: Yao Zi <ziyao@disroot.org>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH] kbuild: Avoid including architecture-specific Makefile twice
Date: Wed,  9 Jul 2025 16:14:19 +0000
Message-ID: <20250709161418.21287-2-ziyao@disroot.org>
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

Stranges errors are observed when building U-Boot master for almost any
RISC-V board, the messages are in two types, one is about duplicated
symbols,

	u-boot/arch/riscv/cpu//mtrap.S:32: multiple definition of `trap_entry';
	arch/riscv/cpu/mtrap.o: u-boot/arch/riscv/cpu//mtrap.S:32: first defined here

and the other is fixdep's complaint about missing dependency files,

	fixdep: error opening file: arch/riscv/cpu/.mtrap.o.d: No such file or directory
	fixdep: error opening file: arch/riscv/cpu//.start.o.d: No such file or directory

where the latter could only be reproduced when building parallelly.

Both the two types of errors are about files in arch/riscv/cpu, and
there's a suspicious slash character in the reported path. Looking
through RISC-V-specific Makefiles, there's only one place that may
expand to such a path,

	libs-y += arch/riscv/cpu/$(CPU)/

The right hand expands to "arch/riscv/cpu//" if $(CPU) isn't defined at
the time of including. With some debug statement added to
arch/riscv/Makefile, the output proves that arch/riscv/Makefile is
included twice, once with $(CPU) undefined and once defined correctly
according to CONFIG_SYS_CPU.

Futher bisecting shows an extra include statement against
arch/$(SRCARCH)/Makefile is added in earlier bump of Kbuild system. But
the statement is evaluated before config.mk is included and definition
of $(CPU), causing objects in arch/riscv/cpu/ are built and linked twice
(once as "arch/riscv/cpu/*", and once as "arch/riscv/cpu//*"), resulting
in the error.

Let's simply remove the extra include to fix these nasty errors. Note
though this therotically affects all architectures, ones except RISC-V
may not reproduce similar errors since there are no source files
directly under arch/*/cpu, thus the extra include doesn't hurt.

Fixes: 5f520875bdf ("kbuild: Bump the build system to 5.1")
Signed-off-by: Yao Zi <ziyao@disroot.org>
---

I was surprised to see this morning's CI passed[1] even for these RISC-V
boards. Builds for SiFive unleashed, QEMU S-Mode virt and Sipeed Lichee
Pi 4A always fail on my machine with the latest master branch, thus
maybe I missed some points when digging the issue, please correct me if
so.

[1]: https://source.denx.de/u-boot/u-boot/-/commit/3833600dbaa2d7008063f3127abf21be8f0fe6cd/pipelines?ref=master

 Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Makefile b/Makefile
index da53efa09f1..b610dcc0b6e 100644
--- a/Makefile
+++ b/Makefile
@@ -724,8 +724,6 @@ endif
 ARCH_CPPFLAGS :=
 ARCH_AFLAGS :=
 ARCH_CFLAGS :=
-# Modified for U-Boot
--include arch/$(SRCARCH)/Makefile
 
 ifeq ($(dot-config),1)
 ifeq ($(may-sync-config),1)
-- 
2.50.0

