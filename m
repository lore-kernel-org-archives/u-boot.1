Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9FBC8303C
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 08:53:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8809800D7;
	Fri, 11 Jul 2025 10:53:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="TcEQkmNd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84A9980194; Fri, 11 Jul 2025 10:53:20 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C48718006D
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 10:53:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 7851E25B1A;
 Fri, 11 Jul 2025 10:53:17 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v789NTT0KrQk; Fri, 11 Jul 2025 10:53:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1752223996; bh=g6J1boj+I+cbXQIxKD90MxA+106a9ACdPvwpsEP16kw=;
 h=From:To:Cc:Subject:Date;
 b=TcEQkmNdcjA3Qw5Ia1lnj2F+Nx8WlftqUf5CQs3XIsaMEeV7coLggvfstosmhvQt/
 /WH8fI0Nj2TMlvSlTMz9ASjDb16ubt1+nVce23frBnfpdSFqeIPX4koioguLjmj3ZM
 j2NV3sTmRgvNOhytzPM7F+dox6PlL3266oF733pjaIDxGTOJcoE7V19pFp+fDdwsJl
 JpS18+rsIvjxB9F0AkP5cWm0OW5qkcp01SzKs35FWxC3nNM1geja4au9DtUjrTaJf+
 lqmLTslAhVQQKE5he79WM3TXx8PYBk/FkeyGeTioFmfhLd/1rTRUa+kP5Bbaz5z+cr
 fe/18xV3kopGw==
From: Yao Zi <ziyao@disroot.org>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v2] kbuild: Avoid including architecture-specific Makefile
 twice
Date: Fri, 11 Jul 2025 08:52:34 +0000
Message-ID: <20250711085234.23659-1-ziyao@disroot.org>
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

Let's simply remove the extra include to fix these nasty errors. For
config targets, bumping Kbuild also introduced a new include to
arch/$(SRCARCH)/Makefile, which is removed as well for consistency.

Fixes: 5f520875bdf ("kbuild: Bump the build system to 5.1")
Signed-off-by: Yao Zi <ziyao@disroot.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

Changes from v1
- Don't describe the problem as RISC-V-specific since it may affect ARM
  builds as well.
- Prevent config targets from including for architecture-specific
  Makefile as well for consistency.
- Add comments to explain the removal.
- Link to v1: https://lore.kernel.org/u-boot/20250709161418.21287-2-ziyao@disroot.org/

 Makefile | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index da53efa09f1..e745cc618ba 100644
--- a/Makefile
+++ b/Makefile
@@ -635,8 +635,9 @@ ifeq ($(config-targets),1)
 # Read arch specific Makefile to set KBUILD_DEFCONFIG as needed.
 # KBUILD_DEFCONFIG may point out an alternative default configuration
 # used for 'make defconfig'
-# Modified for U-Boot
--include arch/$(SRCARCH)/Makefile
+# Modified for U-Boot: we don't include arch/$(SRCARCH)/Makefile for config
+# targets, which is useless since U-Boot has no architecture defining its own
+# KBUILD_{DEF,K}CONFIG, or CROSS_COMPILE.
 export KBUILD_DEFCONFIG KBUILD_KCONFIG CC_VERSION_TEXT
 
 config: scripts_basic outputmakefile FORCE
@@ -724,8 +725,10 @@ endif
 ARCH_CPPFLAGS :=
 ARCH_AFLAGS :=
 ARCH_CFLAGS :=
-# Modified for U-Boot
--include arch/$(SRCARCH)/Makefile
+# Modified for U-Boot: we put off the include of arch/$(SRCARCH)/Makefile until
+# making sure include/config/auto.conf is up-to-date and include of config.mk,
+# because the architecture-specific Makefile may make use of variables defined
+# in config.mk. See also the comment about autoconf_is_old.
 
 ifeq ($(dot-config),1)
 ifeq ($(may-sync-config),1)
-- 
2.50.0

