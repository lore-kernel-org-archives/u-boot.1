Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39623C5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 16:13:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 236B588027;
	Tue, 27 Feb 2024 17:10:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="kDFmh16U";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BVtyh9w+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75FA48806E; Tue, 27 Feb 2024 17:10:26 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F93E88005
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 17:10:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TkjBQ6tX0z9ss0;
 Tue, 27 Feb 2024 17:10:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TpG6WBb/r66+IT5K+At0mbkZqVQjZQFSR1OzTjf3i4M=;
 b=kDFmh16U891ByAvMt476r3lvtWtqbjEzXCFJPR7h9NT0cYDVspQn9gM3ONYDVsXddLQsDC
 85MGZE3zpCOeb8cKxgNBCoWitDLGqZvc+0sygLO11z0bKE/NKTQjNTyY3nLolcf5/rZyQW
 nFtmYt8yrElsAslOTCHaNg90FdDCcl6CuUS9zDmRH461RR3zaEnQdShz1xq0BKRI5wVG3x
 XfgqnZbyP1MWUUnhIZhwra7j85ShkKuIPK/SvQl6imdF5qxXk9ykLDU3twO5AqKTptgP5d
 QTn7jUz7xNhRtMvaCc9b13vXPRQ9clsXmy/6YNu4WDSyJhqTZOCXhi0+a7/vSg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TpG6WBb/r66+IT5K+At0mbkZqVQjZQFSR1OzTjf3i4M=;
 b=BVtyh9w+phasHyKQgzbzpEaVp5BZcwURb5sx1zjiw14hqElv25k0KzYI6b2N3PhHbwxO+n
 Mm7J4B52sxFiRIN1ZTT6GHS0A/zEcQmQfwF9vj/n91HQqdShWjGOUZYoBK723Z7x/qboNY
 8+tIUWjKAq5TiKpIhQwMq+5YEkylyUnZgbouB03Y69QclcJmiIERvxPyxddseA4ssfW5ib
 +PKLtUUz77wjTizVz6FWaQx3dlCS9fFoGJg7YfGyjsHyf/aDpc4LI/RHWIpCbAnKhzRIm7
 DnS6LPYl+TmW448Z19qKAEG92vdaBCUJTNq+GFebv4pZ6mvL8zoTsSiDmwhpJA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 16/19] ARM: renesas: Rename arch-/mach-rmobile to
 arch-/mach-renesas
Date: Tue, 27 Feb 2024 17:05:56 +0100
Message-ID: <20240227160912.412181-17-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
References: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: t4bjhotny7wj5yqwh6ypqec81y9g36ah
X-MBO-RS-ID: db84c048e40ec36ae66
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

Rename arch-rmobile to arch-renesas and mach-rmobile to mach-renesas
because all the chips are made by Renesas, while only a subset of
them is from the R-Mobile line.

Use the following command to perform the rename, with manual move of
the directories using git mv and manual fix up to arch/arm/Makefile:

"
$ git grep -l '\<\(arch\|mach\)-rmobile\>' | \
  xargs -I {} sed -i 's@\<\(arch\|mach\)-rmobile\>@\1-renesas@g' {}
$ sed -i 's@rmobile@renesas@' board/*/*/Kconfig
"

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
---
 MAINTAINERS                                          |  2 +-
 Makefile                                             |  2 +-
 arch/arm/Kconfig                                     |  2 +-
 arch/arm/Makefile                                    |  2 +-
 arch/arm/{mach-rmobile => mach-renesas}/Kconfig      | 12 ++++++------
 arch/arm/{mach-rmobile => mach-renesas}/Kconfig.32   |  0
 arch/arm/{mach-rmobile => mach-renesas}/Kconfig.64   |  4 ++--
 .../arm/{mach-rmobile => mach-renesas}/Kconfig.rcar3 |  0
 .../arm/{mach-rmobile => mach-renesas}/Kconfig.rcar4 |  0
 arch/arm/{mach-rmobile => mach-renesas}/Kconfig.rza1 |  0
 .../arm/{mach-rmobile => mach-renesas}/Kconfig.rzg2l |  0
 arch/arm/{mach-rmobile => mach-renesas}/Kconfig.rzn1 |  0
 arch/arm/{mach-rmobile => mach-renesas}/Makefile     |  0
 arch/arm/{mach-rmobile => mach-renesas}/board.c      |  0
 .../{mach-rmobile => mach-renesas}/cpu_info-rcar.c   |  0
 .../{mach-rmobile => mach-renesas}/cpu_info-rzg.c    |  0
 .../{mach-rmobile => mach-renesas}/cpu_info-rzg2l.c  |  0
 arch/arm/{mach-rmobile => mach-renesas}/cpu_info.c   |  0
 arch/arm/{mach-rmobile => mach-renesas}/emac.c       |  0
 .../include/mach/boot0.h                             |  0
 .../include/mach/gpio.h                              |  0
 .../include/mach/irqs.h                              |  0
 .../include/mach/r8a7790.h                           |  2 +-
 .../include/mach/r8a7791.h                           |  2 +-
 .../include/mach/r8a7792.h                           |  2 +-
 .../include/mach/r8a7793.h                           |  2 +-
 .../include/mach/r8a7794.h                           |  2 +-
 .../include/mach/rcar-base.h                         |  2 +-
 .../include/mach/rcar-gen3-base.h                    |  2 +-
 .../include/mach/rcar-gen4-base.h                    |  2 +-
 .../include/mach/rcar-mstp.h                         |  2 +-
 .../include/mach/renesas.h                           |  0
 .../include/mach/rzg2l.h                             |  0
 .../include/mach/sys_proto.h                         |  0
 .../lowlevel_init_ca15.S                             |  0
 .../lowlevel_init_gen3.S                             |  0
 .../arm/{mach-rmobile => mach-renesas}/memmap-gen3.c |  0
 .../{mach-rmobile => mach-renesas}/memmap-rzg2l.c    |  0
 .../{mach-rmobile => mach-renesas}/psci-r8a779a0.c   |  0
 board/beacon/beacon-rzg2m/Kconfig                    |  2 +-
 board/hoperun/hihope-rzg2/Kconfig                    |  2 +-
 board/renesas/condor/Kconfig                         |  2 +-
 board/renesas/draak/Kconfig                          |  2 +-
 board/renesas/eagle/Kconfig                          |  2 +-
 board/renesas/ebisu/Kconfig                          |  2 +-
 board/renesas/falcon/Kconfig                         |  2 +-
 board/renesas/grayhawk/Kconfig                       |  2 +-
 board/renesas/rzg2l/Kconfig                          |  2 +-
 board/renesas/salvator-x/Kconfig                     |  2 +-
 board/renesas/spider/Kconfig                         |  2 +-
 board/renesas/ulcb/Kconfig                           |  2 +-
 board/renesas/v3hsk/Kconfig                          |  2 +-
 board/renesas/v3msk/Kconfig                          |  2 +-
 board/renesas/whitehawk/Kconfig                      |  2 +-
 board/silinux/ek874/Kconfig                          |  2 +-
 55 files changed, 37 insertions(+), 37 deletions(-)
 rename arch/arm/{mach-rmobile => mach-renesas}/Kconfig (88%)
 rename arch/arm/{mach-rmobile => mach-renesas}/Kconfig.32 (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/Kconfig.64 (56%)
 rename arch/arm/{mach-rmobile => mach-renesas}/Kconfig.rcar3 (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/Kconfig.rcar4 (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/Kconfig.rza1 (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/Kconfig.rzg2l (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/Kconfig.rzn1 (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/Makefile (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/board.c (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/cpu_info-rcar.c (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/cpu_info-rzg.c (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/cpu_info-rzg2l.c (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/cpu_info.c (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/emac.c (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/include/mach/boot0.h (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/include/mach/gpio.h (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/include/mach/irqs.h (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/include/mach/r8a7790.h (94%)
 rename arch/arm/{mach-rmobile => mach-renesas}/include/mach/r8a7791.h (97%)
 rename arch/arm/{mach-rmobile => mach-renesas}/include/mach/r8a7792.h (93%)
 rename arch/arm/{mach-rmobile => mach-renesas}/include/mach/r8a7793.h (97%)
 rename arch/arm/{mach-rmobile => mach-renesas}/include/mach/r8a7794.h (94%)
 rename arch/arm/{mach-rmobile => mach-renesas}/include/mach/rcar-base.h (99%)
 rename arch/arm/{mach-rmobile => mach-renesas}/include/mach/rcar-gen3-base.h (97%)
 rename arch/arm/{mach-rmobile => mach-renesas}/include/mach/rcar-gen4-base.h (96%)
 rename arch/arm/{mach-rmobile => mach-renesas}/include/mach/rcar-mstp.h (97%)
 rename arch/arm/{mach-rmobile => mach-renesas}/include/mach/renesas.h (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/include/mach/rzg2l.h (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/include/mach/sys_proto.h (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/lowlevel_init_ca15.S (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/lowlevel_init_gen3.S (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/memmap-gen3.c (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/memmap-rzg2l.c (100%)
 rename arch/arm/{mach-rmobile => mach-renesas}/psci-r8a779a0.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0b08ca19239..cd9b2d42e83 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -497,7 +497,7 @@ M:	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
 M:	Marek Vasut <marek.vasut+renesas@mailbox.org>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-sh.git
-F:	arch/arm/mach-rmobile/
+F:	arch/arm/mach-renesas/
 F:	drivers/clk/renesas/
 F:	drivers/gpio/gpio-rcar.c
 F:	drivers/i2c/rcar_*
diff --git a/Makefile b/Makefile
index 3b5db90df6f..f308d7884dd 100644
--- a/Makefile
+++ b/Makefile
@@ -1266,7 +1266,7 @@ spl/u-boot-spl.srec: spl/u-boot-spl FORCE
 	$(call if_changed,objcopy)
 
 %.scif: %.srec
-	$(Q)$(MAKE) $(build)=arch/arm/mach-rmobile $@
+	$(Q)$(MAKE) $(build)=arch/arm/mach-renesas $@
 
 OBJCOPYFLAGS_u-boot-nodtb.bin := -O binary \
 		$(if $(CONFIG_X86_16BIT_INIT),-R .start16 -R .resetvec) \
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index dbd7e014245..01d6556c42b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2269,7 +2269,7 @@ source "arch/arm/mach-orion5x/Kconfig"
 
 source "arch/arm/mach-owl/Kconfig"
 
-source "arch/arm/mach-rmobile/Kconfig"
+source "arch/arm/mach-renesas/Kconfig"
 
 source "arch/arm/mach-meson/Kconfig"
 
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index d7ca8715a3f..a4266a3e366 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -75,7 +75,7 @@ machine-$(CONFIG_ARCH_NPCM)             += npcm
 machine-$(CONFIG_ARCH_OMAP2PLUS)	+= omap2
 machine-$(CONFIG_ARCH_ORION5X)		+= orion5x
 machine-$(CONFIG_ARCH_OWL)		+= owl
-machine-$(CONFIG_ARCH_RENESAS)		+= rmobile
+machine-$(CONFIG_ARCH_RENESAS)		+= renesas
 machine-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip
 machine-$(CONFIG_ARCH_S5PC1XX)		+= s5pc1xx
 machine-$(CONFIG_ARCH_SNAPDRAGON)	+= snapdragon
diff --git a/arch/arm/mach-rmobile/Kconfig b/arch/arm/mach-renesas/Kconfig
similarity index 88%
rename from arch/arm/mach-rmobile/Kconfig
rename to arch/arm/mach-renesas/Kconfig
index c1db9531a3c..5aacc6f58f3 100644
--- a/arch/arm/mach-rmobile/Kconfig
+++ b/arch/arm/mach-renesas/Kconfig
@@ -88,12 +88,12 @@ config RZG2L
 endchoice
 
 config SYS_SOC
-	default "rmobile" if ARCH_RENESAS
+	default "renesas" if ARCH_RENESAS
 
-source "arch/arm/mach-rmobile/Kconfig.32"
-source "arch/arm/mach-rmobile/Kconfig.64"
-source "arch/arm/mach-rmobile/Kconfig.rza1"
-source "arch/arm/mach-rmobile/Kconfig.rzn1"
-source "arch/arm/mach-rmobile/Kconfig.rzg2l"
+source "arch/arm/mach-renesas/Kconfig.32"
+source "arch/arm/mach-renesas/Kconfig.64"
+source "arch/arm/mach-renesas/Kconfig.rza1"
+source "arch/arm/mach-renesas/Kconfig.rzn1"
+source "arch/arm/mach-renesas/Kconfig.rzg2l"
 
 endif
diff --git a/arch/arm/mach-rmobile/Kconfig.32 b/arch/arm/mach-renesas/Kconfig.32
similarity index 100%
rename from arch/arm/mach-rmobile/Kconfig.32
rename to arch/arm/mach-renesas/Kconfig.32
diff --git a/arch/arm/mach-rmobile/Kconfig.64 b/arch/arm/mach-renesas/Kconfig.64
similarity index 56%
rename from arch/arm/mach-rmobile/Kconfig.64
rename to arch/arm/mach-renesas/Kconfig.64
index 57ed1d6c50d..b5067d0a8f0 100644
--- a/arch/arm/mach-rmobile/Kconfig.64
+++ b/arch/arm/mach-renesas/Kconfig.64
@@ -6,7 +6,7 @@ config SYS_MALLOC_F_LEN
 config OF_LIBFDT_OVERLAY
 	default y if RCAR_64
 
-source "arch/arm/mach-rmobile/Kconfig.rcar3"
-source "arch/arm/mach-rmobile/Kconfig.rcar4"
+source "arch/arm/mach-renesas/Kconfig.rcar3"
+source "arch/arm/mach-renesas/Kconfig.rcar4"
 
 endif
diff --git a/arch/arm/mach-rmobile/Kconfig.rcar3 b/arch/arm/mach-renesas/Kconfig.rcar3
similarity index 100%
rename from arch/arm/mach-rmobile/Kconfig.rcar3
rename to arch/arm/mach-renesas/Kconfig.rcar3
diff --git a/arch/arm/mach-rmobile/Kconfig.rcar4 b/arch/arm/mach-renesas/Kconfig.rcar4
similarity index 100%
rename from arch/arm/mach-rmobile/Kconfig.rcar4
rename to arch/arm/mach-renesas/Kconfig.rcar4
diff --git a/arch/arm/mach-rmobile/Kconfig.rza1 b/arch/arm/mach-renesas/Kconfig.rza1
similarity index 100%
rename from arch/arm/mach-rmobile/Kconfig.rza1
rename to arch/arm/mach-renesas/Kconfig.rza1
diff --git a/arch/arm/mach-rmobile/Kconfig.rzg2l b/arch/arm/mach-renesas/Kconfig.rzg2l
similarity index 100%
rename from arch/arm/mach-rmobile/Kconfig.rzg2l
rename to arch/arm/mach-renesas/Kconfig.rzg2l
diff --git a/arch/arm/mach-rmobile/Kconfig.rzn1 b/arch/arm/mach-renesas/Kconfig.rzn1
similarity index 100%
rename from arch/arm/mach-rmobile/Kconfig.rzn1
rename to arch/arm/mach-renesas/Kconfig.rzn1
diff --git a/arch/arm/mach-rmobile/Makefile b/arch/arm/mach-renesas/Makefile
similarity index 100%
rename from arch/arm/mach-rmobile/Makefile
rename to arch/arm/mach-renesas/Makefile
diff --git a/arch/arm/mach-rmobile/board.c b/arch/arm/mach-renesas/board.c
similarity index 100%
rename from arch/arm/mach-rmobile/board.c
rename to arch/arm/mach-renesas/board.c
diff --git a/arch/arm/mach-rmobile/cpu_info-rcar.c b/arch/arm/mach-renesas/cpu_info-rcar.c
similarity index 100%
rename from arch/arm/mach-rmobile/cpu_info-rcar.c
rename to arch/arm/mach-renesas/cpu_info-rcar.c
diff --git a/arch/arm/mach-rmobile/cpu_info-rzg.c b/arch/arm/mach-renesas/cpu_info-rzg.c
similarity index 100%
rename from arch/arm/mach-rmobile/cpu_info-rzg.c
rename to arch/arm/mach-renesas/cpu_info-rzg.c
diff --git a/arch/arm/mach-rmobile/cpu_info-rzg2l.c b/arch/arm/mach-renesas/cpu_info-rzg2l.c
similarity index 100%
rename from arch/arm/mach-rmobile/cpu_info-rzg2l.c
rename to arch/arm/mach-renesas/cpu_info-rzg2l.c
diff --git a/arch/arm/mach-rmobile/cpu_info.c b/arch/arm/mach-renesas/cpu_info.c
similarity index 100%
rename from arch/arm/mach-rmobile/cpu_info.c
rename to arch/arm/mach-renesas/cpu_info.c
diff --git a/arch/arm/mach-rmobile/emac.c b/arch/arm/mach-renesas/emac.c
similarity index 100%
rename from arch/arm/mach-rmobile/emac.c
rename to arch/arm/mach-renesas/emac.c
diff --git a/arch/arm/mach-rmobile/include/mach/boot0.h b/arch/arm/mach-renesas/include/mach/boot0.h
similarity index 100%
rename from arch/arm/mach-rmobile/include/mach/boot0.h
rename to arch/arm/mach-renesas/include/mach/boot0.h
diff --git a/arch/arm/mach-rmobile/include/mach/gpio.h b/arch/arm/mach-renesas/include/mach/gpio.h
similarity index 100%
rename from arch/arm/mach-rmobile/include/mach/gpio.h
rename to arch/arm/mach-renesas/include/mach/gpio.h
diff --git a/arch/arm/mach-rmobile/include/mach/irqs.h b/arch/arm/mach-renesas/include/mach/irqs.h
similarity index 100%
rename from arch/arm/mach-rmobile/include/mach/irqs.h
rename to arch/arm/mach-renesas/include/mach/irqs.h
diff --git a/arch/arm/mach-rmobile/include/mach/r8a7790.h b/arch/arm/mach-renesas/include/mach/r8a7790.h
similarity index 94%
rename from arch/arm/mach-rmobile/include/mach/r8a7790.h
rename to arch/arm/mach-renesas/include/mach/r8a7790.h
index 233531cb4ab..61101df3f1a 100644
--- a/arch/arm/mach-rmobile/include/mach/r8a7790.h
+++ b/arch/arm/mach-renesas/include/mach/r8a7790.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * arch/arm/include/asm/arch-rmobile/r8a7790.h
+ * arch/arm/include/asm/arch-renesas/r8a7790.h
  *
  * Copyright (C) 2013,2014 Renesas Electronics Corporation
  */
diff --git a/arch/arm/mach-rmobile/include/mach/r8a7791.h b/arch/arm/mach-renesas/include/mach/r8a7791.h
similarity index 97%
rename from arch/arm/mach-rmobile/include/mach/r8a7791.h
rename to arch/arm/mach-renesas/include/mach/r8a7791.h
index 78a910cfdd2..40524d77d84 100644
--- a/arch/arm/mach-rmobile/include/mach/r8a7791.h
+++ b/arch/arm/mach-renesas/include/mach/r8a7791.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * arch/arm/include/asm/arch-rmobile/r8a7791.h
+ * arch/arm/include/asm/arch-renesas/r8a7791.h
  *
  * Copyright (C) 2013,2014 Renesas Electronics Corporation
  */
diff --git a/arch/arm/mach-rmobile/include/mach/r8a7792.h b/arch/arm/mach-renesas/include/mach/r8a7792.h
similarity index 93%
rename from arch/arm/mach-rmobile/include/mach/r8a7792.h
rename to arch/arm/mach-renesas/include/mach/r8a7792.h
index cc1b00db33f..51c0d63eefb 100644
--- a/arch/arm/mach-rmobile/include/mach/r8a7792.h
+++ b/arch/arm/mach-renesas/include/mach/r8a7792.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * arch/arm/include/asm/arch-rmobile/r8a7792.h
+ * arch/arm/include/asm/arch-renesas/r8a7792.h
  *
  * Copyright (C) 2016 Renesas Electronics Corporation
  */
diff --git a/arch/arm/mach-rmobile/include/mach/r8a7793.h b/arch/arm/mach-renesas/include/mach/r8a7793.h
similarity index 97%
rename from arch/arm/mach-rmobile/include/mach/r8a7793.h
rename to arch/arm/mach-renesas/include/mach/r8a7793.h
index 4cb064731ca..f15f8236059 100644
--- a/arch/arm/mach-rmobile/include/mach/r8a7793.h
+++ b/arch/arm/mach-renesas/include/mach/r8a7793.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * arch/arm/include/asm/arch-rmobile/r8a7793.h
+ * arch/arm/include/asm/arch-renesas/r8a7793.h
  *
  * Copyright (C) 2014 Renesas Electronics Corporation
  */
diff --git a/arch/arm/mach-rmobile/include/mach/r8a7794.h b/arch/arm/mach-renesas/include/mach/r8a7794.h
similarity index 94%
rename from arch/arm/mach-rmobile/include/mach/r8a7794.h
rename to arch/arm/mach-renesas/include/mach/r8a7794.h
index 6d0d729bb12..592625e6e9a 100644
--- a/arch/arm/mach-rmobile/include/mach/r8a7794.h
+++ b/arch/arm/mach-renesas/include/mach/r8a7794.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * arch/arm/include/asm/arch-rmobile/r8a7794.h
+ * arch/arm/include/asm/arch-renesas/r8a7794.h
  *
  * Copyright (C) 2014 Renesas Electronics Corporation
  */
diff --git a/arch/arm/mach-rmobile/include/mach/rcar-base.h b/arch/arm/mach-renesas/include/mach/rcar-base.h
similarity index 99%
rename from arch/arm/mach-rmobile/include/mach/rcar-base.h
rename to arch/arm/mach-renesas/include/mach/rcar-base.h
index e422e9100a8..4c2ee8187e0 100644
--- a/arch/arm/mach-rmobile/include/mach/rcar-base.h
+++ b/arch/arm/mach-renesas/include/mach/rcar-base.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * arch/arm/include/asm/arch-rmobile/rcar-base.h
+ * arch/arm/include/asm/arch-renesas/rcar-base.h
  *
  * Copyright (C) 2013,2014 Renesas Electronics Corporation
  */
diff --git a/arch/arm/mach-rmobile/include/mach/rcar-gen3-base.h b/arch/arm/mach-renesas/include/mach/rcar-gen3-base.h
similarity index 97%
rename from arch/arm/mach-rmobile/include/mach/rcar-gen3-base.h
rename to arch/arm/mach-renesas/include/mach/rcar-gen3-base.h
index ca1274272d3..5e2e9eca452 100644
--- a/arch/arm/mach-rmobile/include/mach/rcar-gen3-base.h
+++ b/arch/arm/mach-renesas/include/mach/rcar-gen3-base.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * ./arch/arm/mach-rmobile/include/mach/rcar-gen3-base.h
+ * ./arch/arm/mach-renesas/include/mach/rcar-gen3-base.h
  *
  * Copyright (C) 2015 Renesas Electronics Corporation
  */
diff --git a/arch/arm/mach-rmobile/include/mach/rcar-gen4-base.h b/arch/arm/mach-renesas/include/mach/rcar-gen4-base.h
similarity index 96%
rename from arch/arm/mach-rmobile/include/mach/rcar-gen4-base.h
rename to arch/arm/mach-renesas/include/mach/rcar-gen4-base.h
index ac57698849a..f34473db35a 100644
--- a/arch/arm/mach-rmobile/include/mach/rcar-gen4-base.h
+++ b/arch/arm/mach-renesas/include/mach/rcar-gen4-base.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * ./arch/arm/mach-rmobile/include/mach/rcar-gen4-base.h
+ * ./arch/arm/mach-renesas/include/mach/rcar-gen4-base.h
  *
  * Copyright (C) 2021 Renesas Electronics Corp.
  */
diff --git a/arch/arm/mach-rmobile/include/mach/rcar-mstp.h b/arch/arm/mach-renesas/include/mach/rcar-mstp.h
similarity index 97%
rename from arch/arm/mach-rmobile/include/mach/rcar-mstp.h
rename to arch/arm/mach-renesas/include/mach/rcar-mstp.h
index d241652641f..7ca362e519c 100644
--- a/arch/arm/mach-rmobile/include/mach/rcar-mstp.h
+++ b/arch/arm/mach-renesas/include/mach/rcar-mstp.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * arch/arm/include/asm/arch-rmobile/rcar-mstp.h
+ * arch/arm/include/asm/arch-renesas/rcar-mstp.h
  *
  * Copyright (C) 2013, 2014 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
  * Copyright (C) 2013, 2014 Renesas Electronics Corporation
diff --git a/arch/arm/mach-rmobile/include/mach/renesas.h b/arch/arm/mach-renesas/include/mach/renesas.h
similarity index 100%
rename from arch/arm/mach-rmobile/include/mach/renesas.h
rename to arch/arm/mach-renesas/include/mach/renesas.h
diff --git a/arch/arm/mach-rmobile/include/mach/rzg2l.h b/arch/arm/mach-renesas/include/mach/rzg2l.h
similarity index 100%
rename from arch/arm/mach-rmobile/include/mach/rzg2l.h
rename to arch/arm/mach-renesas/include/mach/rzg2l.h
diff --git a/arch/arm/mach-rmobile/include/mach/sys_proto.h b/arch/arm/mach-renesas/include/mach/sys_proto.h
similarity index 100%
rename from arch/arm/mach-rmobile/include/mach/sys_proto.h
rename to arch/arm/mach-renesas/include/mach/sys_proto.h
diff --git a/arch/arm/mach-rmobile/lowlevel_init_ca15.S b/arch/arm/mach-renesas/lowlevel_init_ca15.S
similarity index 100%
rename from arch/arm/mach-rmobile/lowlevel_init_ca15.S
rename to arch/arm/mach-renesas/lowlevel_init_ca15.S
diff --git a/arch/arm/mach-rmobile/lowlevel_init_gen3.S b/arch/arm/mach-renesas/lowlevel_init_gen3.S
similarity index 100%
rename from arch/arm/mach-rmobile/lowlevel_init_gen3.S
rename to arch/arm/mach-renesas/lowlevel_init_gen3.S
diff --git a/arch/arm/mach-rmobile/memmap-gen3.c b/arch/arm/mach-renesas/memmap-gen3.c
similarity index 100%
rename from arch/arm/mach-rmobile/memmap-gen3.c
rename to arch/arm/mach-renesas/memmap-gen3.c
diff --git a/arch/arm/mach-rmobile/memmap-rzg2l.c b/arch/arm/mach-renesas/memmap-rzg2l.c
similarity index 100%
rename from arch/arm/mach-rmobile/memmap-rzg2l.c
rename to arch/arm/mach-renesas/memmap-rzg2l.c
diff --git a/arch/arm/mach-rmobile/psci-r8a779a0.c b/arch/arm/mach-renesas/psci-r8a779a0.c
similarity index 100%
rename from arch/arm/mach-rmobile/psci-r8a779a0.c
rename to arch/arm/mach-renesas/psci-r8a779a0.c
diff --git a/board/beacon/beacon-rzg2m/Kconfig b/board/beacon/beacon-rzg2m/Kconfig
index c03857cf2fe..1eb9e0dda94 100644
--- a/board/beacon/beacon-rzg2m/Kconfig
+++ b/board/beacon/beacon-rzg2m/Kconfig
@@ -1,7 +1,7 @@
 if TARGET_BEACON_RZG2M
 
 config SYS_SOC
-	default "rmobile"
+	default "renesas"
 
 config SYS_BOARD
 	default "beacon-rzg2m"
diff --git a/board/hoperun/hihope-rzg2/Kconfig b/board/hoperun/hihope-rzg2/Kconfig
index ee422ba6c8f..e15b54ae5ce 100644
--- a/board/hoperun/hihope-rzg2/Kconfig
+++ b/board/hoperun/hihope-rzg2/Kconfig
@@ -1,7 +1,7 @@
 if TARGET_HIHOPE_RZG2
 
 config SYS_SOC
-	default "rmobile"
+	default "renesas"
 
 config SYS_BOARD
 	default "hihope-rzg2"
diff --git a/board/renesas/condor/Kconfig b/board/renesas/condor/Kconfig
index 2286d88de7f..fbfb12cc4f9 100644
--- a/board/renesas/condor/Kconfig
+++ b/board/renesas/condor/Kconfig
@@ -1,7 +1,7 @@
 if TARGET_CONDOR
 
 config SYS_SOC
-	default "rmobile"
+	default "renesas"
 
 config SYS_BOARD
 	default "condor"
diff --git a/board/renesas/draak/Kconfig b/board/renesas/draak/Kconfig
index 9106387bb99..8f3d904f9d7 100644
--- a/board/renesas/draak/Kconfig
+++ b/board/renesas/draak/Kconfig
@@ -1,7 +1,7 @@
 if TARGET_DRAAK
 
 config SYS_SOC
-	default "rmobile"
+	default "renesas"
 
 config SYS_BOARD
 	default "draak"
diff --git a/board/renesas/eagle/Kconfig b/board/renesas/eagle/Kconfig
index 4d12843b4e9..04895d2bb4b 100644
--- a/board/renesas/eagle/Kconfig
+++ b/board/renesas/eagle/Kconfig
@@ -1,7 +1,7 @@
 if TARGET_EAGLE
 
 config SYS_SOC
-	default "rmobile"
+	default "renesas"
 
 config SYS_BOARD
 	default "eagle"
diff --git a/board/renesas/ebisu/Kconfig b/board/renesas/ebisu/Kconfig
index f500a94c9a3..a9049b6d5ad 100644
--- a/board/renesas/ebisu/Kconfig
+++ b/board/renesas/ebisu/Kconfig
@@ -1,7 +1,7 @@
 if TARGET_EBISU
 
 config SYS_SOC
-	default "rmobile"
+	default "renesas"
 
 config SYS_BOARD
 	default "ebisu"
diff --git a/board/renesas/falcon/Kconfig b/board/renesas/falcon/Kconfig
index 1fcefa7e3cd..44a2e5651ae 100644
--- a/board/renesas/falcon/Kconfig
+++ b/board/renesas/falcon/Kconfig
@@ -1,7 +1,7 @@
 if TARGET_FALCON
 
 config SYS_SOC
-	default "rmobile"
+	default "renesas"
 
 config SYS_BOARD
 	default "falcon"
diff --git a/board/renesas/grayhawk/Kconfig b/board/renesas/grayhawk/Kconfig
index 97621a30ad0..a6dbfb50e73 100644
--- a/board/renesas/grayhawk/Kconfig
+++ b/board/renesas/grayhawk/Kconfig
@@ -1,7 +1,7 @@
 if TARGET_GRAYHAWK
 
 config SYS_SOC
-	default "rmobile"
+	default "renesas"
 
 config SYS_BOARD
 	default "grayhawk"
diff --git a/board/renesas/rzg2l/Kconfig b/board/renesas/rzg2l/Kconfig
index 1335fc7ae80..c7b75704beb 100644
--- a/board/renesas/rzg2l/Kconfig
+++ b/board/renesas/rzg2l/Kconfig
@@ -4,7 +4,7 @@
 if TARGET_RZG2L_SMARC_EVK
 
 config SYS_SOC
-	default "rmobile"
+	default "renesas"
 
 config SYS_BOARD
 	default "rzg2l"
diff --git a/board/renesas/salvator-x/Kconfig b/board/renesas/salvator-x/Kconfig
index ed4c479f7ca..52955e144a6 100644
--- a/board/renesas/salvator-x/Kconfig
+++ b/board/renesas/salvator-x/Kconfig
@@ -1,7 +1,7 @@
 if TARGET_SALVATOR_X
 
 config SYS_SOC
-	default "rmobile"
+	default "renesas"
 
 config SYS_BOARD
 	default "salvator-x"
diff --git a/board/renesas/spider/Kconfig b/board/renesas/spider/Kconfig
index 8df2e85fc9c..bd5825ef56c 100644
--- a/board/renesas/spider/Kconfig
+++ b/board/renesas/spider/Kconfig
@@ -1,7 +1,7 @@
 if TARGET_SPIDER
 
 config SYS_SOC
-	default "rmobile"
+	default "renesas"
 
 config SYS_BOARD
 	default "spider"
diff --git a/board/renesas/ulcb/Kconfig b/board/renesas/ulcb/Kconfig
index 1e9a10d2814..318603608ce 100644
--- a/board/renesas/ulcb/Kconfig
+++ b/board/renesas/ulcb/Kconfig
@@ -1,7 +1,7 @@
 if TARGET_ULCB
 
 config SYS_SOC
-	default "rmobile"
+	default "renesas"
 
 config SYS_BOARD
 	default "ulcb"
diff --git a/board/renesas/v3hsk/Kconfig b/board/renesas/v3hsk/Kconfig
index 531ceb788f4..da595a493b5 100644
--- a/board/renesas/v3hsk/Kconfig
+++ b/board/renesas/v3hsk/Kconfig
@@ -1,7 +1,7 @@
 if TARGET_V3HSK
 
 config SYS_SOC
-	default "rmobile"
+	default "renesas"
 
 config SYS_BOARD
 	default "v3hsk"
diff --git a/board/renesas/v3msk/Kconfig b/board/renesas/v3msk/Kconfig
index fe037fd98f0..8f423868962 100644
--- a/board/renesas/v3msk/Kconfig
+++ b/board/renesas/v3msk/Kconfig
@@ -1,7 +1,7 @@
 if TARGET_V3MSK
 
 config SYS_SOC
-	default "rmobile"
+	default "renesas"
 
 config SYS_BOARD
 	default "v3msk"
diff --git a/board/renesas/whitehawk/Kconfig b/board/renesas/whitehawk/Kconfig
index 05a87894fac..8adb24c2d2e 100644
--- a/board/renesas/whitehawk/Kconfig
+++ b/board/renesas/whitehawk/Kconfig
@@ -1,7 +1,7 @@
 if TARGET_WHITEHAWK
 
 config SYS_SOC
-	default "rmobile"
+	default "renesas"
 
 config SYS_BOARD
 	default "whitehawk"
diff --git a/board/silinux/ek874/Kconfig b/board/silinux/ek874/Kconfig
index 60b390a121e..5b34087bff8 100644
--- a/board/silinux/ek874/Kconfig
+++ b/board/silinux/ek874/Kconfig
@@ -1,7 +1,7 @@
 if TARGET_SILINUX_EK874
 
 config SYS_SOC
-	default "rmobile"
+	default "renesas"
 
 config SYS_BOARD
 	default "ek874"
-- 
2.43.0

