Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756B7CE7B15
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 13:41:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 143CF88CEF;
	Fri,  6 Sep 2024 15:41:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CShv1kxe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7291788C9F; Fri,  6 Sep 2024 14:34:32 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8005288CD8
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 14:34:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42bb8cf8abeso15231345e9.2
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 05:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725626066; x=1726230866; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CyeBZ0DLA6zQ+juCrEW2Qv3rK8oiqdwIVFJS7M/NbyU=;
 b=CShv1kxej+0FwiGNV/jf49n4p+7oBVvxAiXAjTYpc0yuivD+2x7nMf//zaiYldtgoh
 MsRaOHJfhoCNrrS7L4seSW6/Yu6N0w/ue6iee68iGvItv0b/qCP37mOH8cPe9WH1iVvS
 F5qUtsbe9HPvHU860om/xlCETi8hVivVW2MBBOmXS5klN75VThkuek9vb53ml+Z52IQt
 efv4fRgAyQ8TdZCLhuHYKK1ytjFfi6q4W8CjnwCkjl/cSPaz+/ij8esLMRVtELQSpdNi
 jCHTxBwIYIZxOjfoc1i1O9fos6mhxL2hwC8BSMv5f8Zo9p3ZmvwR2rjDzaFO4dOjWIf0
 nFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725626066; x=1726230866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CyeBZ0DLA6zQ+juCrEW2Qv3rK8oiqdwIVFJS7M/NbyU=;
 b=rKoLB88gAqnz5qoJFM9catlr+8RLa5EkR8bQU4uuaOJf0uzys8O/lF5Sgca5RU8Lcs
 M/MzYv5eUNo3Pzwsqs7mbWHuSpOE6s2F4TGVvPY9OPkcj9LxqoEh/eyJL6VPl0mDsRYw
 KCM6Znd4QUp1Q9nVzyCfxh27XkK9HwxklmsTL+b/ba8tl29y6juDPOAvnssVbpVwtneI
 evDzUwYQglCAUZqqLmb8ZxoKsQ53ue3+J+YNVKtthFe3hZrBn5KyAhqDJclnubzvLFEh
 FjjXnOlz8pU4eeNqZehyJLaRJqojIzOvIdvRd2XBMMY9wwWcDVjMy8lkEIrfkD5aThaS
 kNmQ==
X-Gm-Message-State: AOJu0YxKKJ5H3PTbhRT8mbgkiVErQa4pVUljNIeb2xoqFpy41WL/GFkV
 ArQcvx8mxzgYyTv2tlrC9ox0qEh7r71NTPPKVXft19L7h8awmG2KxFcj45/pC4YY3P64FO1Fs/s
 KED+VTmwL
X-Google-Smtp-Source: AGHT+IEZi70uYvegpuF1P5YFVMagY7w54u1P0G24wObZUwh4bTH/nHnGUTyXOHGwH4Vj/zvIY871eQ==
X-Received: by 2002:a05:600c:1c01:b0:427:9a8f:9717 with SMTP id
 5b1f17b1804b1-42c9f8e665dmr18283165e9.0.1725626065246; 
 Fri, 06 Sep 2024 05:34:25 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:1ff1:215c:d8a4:9f99])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ca05cf0e8sm19640125e9.27.2024.09.06.05.34.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 05:34:24 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Eugen Hristev <eugen.hristev@collabora.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Jakub Klama <jakub@conclusive.pl>, Artur Rojek <artur@conclusive.pl>,
 TsiChung Liew <Tsi-Chung.Liew@nxp.com>, Stefan Roese <sr@denx.de>,
 Heiko Schocher <hs@denx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, egnite GmbH <info@egnite.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>, Bryan Brattlof <bb@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>,
 Marcin Jabrzyk <marcin@conclusive.pl>, Peng Fan <peng.fan@nxp.com>,
 Jason Liu <jason.hui.liu@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 William Zhang <william.zhang@broadcom.com>,
 Yang Xiwen <forbidden405@outlook.com>, Gabor Juhos <j4g8y7@gmail.com>,
 Boon Khai Ng <boon.khai.ng@intel.com>, Philip Oberfichtner <pro@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Robert Marko <robert.marko@sartura.hr>,
 Ye Li <ye.li@nxp.com>, Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Richard Weinberger <richard@nod.at>, Love Kumar <love.kumar@amd.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>
Subject: [PATCH v10 01/25] Miscellaneous fixes
Date: Fri,  6 Sep 2024 14:33:17 +0200
Message-Id: <93ccc45cc6928e54878708d77607c5ad1e4a979f.1725625913.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725625913.git.jerome.forissier@linaro.org>
References: <cover.1725625913.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Sep 2024 15:41:12 +0200
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

Squashed commit of patches posted separately [1][2][3].

    cmd: pxe: CMD_PXE implies CMD_TFTPBOOT
    common: update: UPDATE_COMMON implies CMD_TFTPBOOT
    test/py: test_efi_loader: add HTTP (wget) test for the EFI loader
    test/py: test_efi_loader: add missing dependency on cmd_tftpboot
    test/py: net_boot: fix comment
    net: fec_mxc_init(): do not ignore return status of fec_open()
    net: wget: allow EFI boot
    net: ftgmac100: depend on NET
    net: phy: ncsi: depend on NET
    net: wget: removed unused function wget_success()
    net: fm: call dtsec_init_phy() only when it is defined
    arm: omap2: add missing #include <netdev.h>
    at91: rename mem_init() to at91_mem_init()
    flash: prefix error codes with FL_
    buildman/toolchain.py: do not set CROSS_COMPILE for sandbox
    Makefile: detect HOST_ARCH properly when CROSS_COMPILE is multi-word
    [1]
    net: guard call to tftp_start() with IS_ENABLED(CONFIG_CMD_TFTPBOOT)
    [2]
    configs/ethernut5.h: define CFG_SYS_I2C_RTC_ADDR unconditionally
    [3]

[1] http://patchwork.ozlabs.org/project/uboot/list/?series=422079
[2] http://patchwork.ozlabs.org/project/uboot/patch/20240902132511.148683-1-jerome.forissier@linaro.org/
[3] http://patchwork.ozlabs.org/project/uboot/patch/20240902131246.127897-1-jerome.forissier@linaro.org/

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 Makefile                                      |  2 +-
 arch/arm/mach-at91/include/mach/at91_common.h |  2 +-
 arch/arm/mach-at91/spl_at91.c                 |  2 +-
 arch/arm/mach-at91/spl_atmel.c                |  2 +-
 arch/arm/mach-omap2/omap3/emac.c              |  1 +
 .../atmel/at91sam9m10g45ek/at91sam9m10g45ek.c |  2 +-
 board/atmel/at91sam9n12ek/at91sam9n12ek.c     |  2 +-
 board/atmel/at91sam9x5ek/at91sam9x5ek.c       |  2 +-
 .../atmel/sama5d27_som1_ek/sama5d27_som1_ek.c |  2 +-
 .../sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c   |  2 +-
 board/atmel/sama5d2_icp/sama5d2_icp.c         |  2 +-
 .../atmel/sama5d2_xplained/sama5d2_xplained.c |  2 +-
 .../atmel/sama5d3_xplained/sama5d3_xplained.c |  2 +-
 board/atmel/sama5d3xek/sama5d3xek.c           |  2 +-
 .../atmel/sama5d4_xplained/sama5d4_xplained.c |  2 +-
 board/atmel/sama5d4ek/sama5d4ek.c             |  2 +-
 board/cobra5272/flash.c                       | 26 ++++----
 .../conclusive/kstr-sama5d27/kstr-sama5d27.c  |  2 +-
 board/freescale/m5253demo/flash.c             |  6 +-
 board/gardena/smart-gateway-at91sam/spl.c     |  2 +-
 board/siemens/corvus/board.c                  |  2 +-
 board/siemens/smartweb/smartweb.c             |  2 +-
 board/siemens/taurus/taurus.c                 |  2 +-
 cmd/Kconfig                                   |  1 +
 common/Kconfig                                |  1 +
 common/flash.c                                | 44 ++++++-------
 drivers/mtd/altera_qspi.c                     |  4 +-
 drivers/mtd/cfi_flash.c                       | 36 +++++------
 drivers/net/Kconfig                           |  1 +
 drivers/net/fec_mxc.c                         |  3 +-
 drivers/net/fm/eth.c                          | 10 ++-
 drivers/net/phy/Kconfig                       |  1 +
 include/configs/ethernut5.h                   |  2 -
 include/flash.h                               | 20 +++---
 net/net.c                                     | 23 ++++---
 net/wget.c                                    | 11 ++--
 test/py/tests/test_efi_loader.py              | 62 ++++++++++++++-----
 test/py/tests/test_net_boot.py                |  2 +-
 tools/buildman/test.py                        | 46 ++++++++++++++
 tools/buildman/toolchain.py                   |  6 +-
 40 files changed, 217 insertions(+), 129 deletions(-)

diff --git a/Makefile b/Makefile
index f23554da4c1..5113098d29c 100644
--- a/Makefile
+++ b/Makefile
@@ -21,7 +21,7 @@ include include/host_arch.h
 ifeq ("", "$(CROSS_COMPILE)")
   MK_ARCH="${shell uname -m}"
 else
-  MK_ARCH="${shell echo $(CROSS_COMPILE) | sed -n 's/^[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\2/p'}"
+  MK_ARCH="${shell echo ${lastword $(CROSS_COMPILE)} | sed -n 's/^[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\2/p'}"
 endif
 unexport HOST_ARCH
 ifeq ("x86_64", $(MK_ARCH))
diff --git a/arch/arm/mach-at91/include/mach/at91_common.h b/arch/arm/mach-at91/include/mach/at91_common.h
index 683e539b1b3..8fec346c1e4 100644
--- a/arch/arm/mach-at91/include/mach/at91_common.h
+++ b/arch/arm/mach-at91/include/mach/at91_common.h
@@ -28,7 +28,7 @@ void at91_pllb_init(u32 pllar);
 void at91_mck_init(u32 mckr);
 void at91_mck_init_down(u32 mckr);
 void at91_pmc_init(void);
-void mem_init(void);
+void at91_mem_init(void);
 void at91_phy_reset(void);
 void at91_sdram_hw_init(void);
 void at91_mck_init(u32 mckr);
diff --git a/arch/arm/mach-at91/spl_at91.c b/arch/arm/mach-at91/spl_at91.c
index cde1700a283..0d1233cd109 100644
--- a/arch/arm/mach-at91/spl_at91.c
+++ b/arch/arm/mach-at91/spl_at91.c
@@ -142,7 +142,7 @@ void board_init_f(ulong dummy)
 	preloader_console_init();
 #endif
 
-	mem_init();
+	at91_mem_init();
 
 	at91_spl_board_init();
 }
diff --git a/arch/arm/mach-at91/spl_atmel.c b/arch/arm/mach-at91/spl_atmel.c
index 62a7df8a195..7bfbadf0483 100644
--- a/arch/arm/mach-at91/spl_atmel.c
+++ b/arch/arm/mach-at91/spl_atmel.c
@@ -134,7 +134,7 @@ void board_init_f(ulong dummy)
 
 	board_early_init_f();
 
-	mem_init();
+	at91_mem_init();
 
 	ret = spl_init();
 	if (ret) {
diff --git a/arch/arm/mach-omap2/omap3/emac.c b/arch/arm/mach-omap2/omap3/emac.c
index 7348e92cabd..1e30a06361d 100644
--- a/arch/arm/mach-omap2/omap3/emac.c
+++ b/arch/arm/mach-omap2/omap3/emac.c
@@ -9,6 +9,7 @@
 #include <net.h>
 #include <asm/io.h>
 #include <asm/arch/am35x_def.h>
+#include <netdev.h>
 
 /*
  * Initializes on-chip ethernet controllers.
diff --git a/board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c b/board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c
index 3bd94d0889d..af486e977e5 100644
--- a/board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c
+++ b/board/atmel/at91sam9m10g45ek/at91sam9m10g45ek.c
@@ -125,7 +125,7 @@ static void ddr2_conf(struct atmel_mpddrc_config *ddr2)
 		      2 << ATMEL_MPDDRC_TPR2_TXARD_OFFSET);
 }
 
-void mem_init(void)
+void at91_mem_init(void)
 {
 	struct atmel_mpddrc_config ddr2;
 
diff --git a/board/atmel/at91sam9n12ek/at91sam9n12ek.c b/board/atmel/at91sam9n12ek/at91sam9n12ek.c
index afc0c0520e1..6f9abcbb127 100644
--- a/board/atmel/at91sam9n12ek/at91sam9n12ek.c
+++ b/board/atmel/at91sam9n12ek/at91sam9n12ek.c
@@ -167,7 +167,7 @@ static void ddr2_conf(struct atmel_mpddrc_config *ddr2)
 		      2 << ATMEL_MPDDRC_TPR2_TXARD_OFFSET);
 }
 
-void mem_init(void)
+void at91_mem_init(void)
 {
 	struct at91_pmc *pmc = (struct at91_pmc *)ATMEL_BASE_PMC;
 	struct at91_matrix *matrix = (struct at91_matrix *)ATMEL_BASE_MATRIX;
diff --git a/board/atmel/at91sam9x5ek/at91sam9x5ek.c b/board/atmel/at91sam9x5ek/at91sam9x5ek.c
index e5688c6cf13..f52b9a97731 100644
--- a/board/atmel/at91sam9x5ek/at91sam9x5ek.c
+++ b/board/atmel/at91sam9x5ek/at91sam9x5ek.c
@@ -181,7 +181,7 @@ static void ddr2_conf(struct atmel_mpddrc_config *ddr2)
 		      2 << ATMEL_MPDDRC_TPR2_TXARD_OFFSET);
 }
 
-void mem_init(void)
+void at91_mem_init(void)
 {
 	struct at91_pmc *pmc = (struct at91_pmc *)ATMEL_BASE_PMC;
 	struct at91_matrix *matrix = (struct at91_matrix *)ATMEL_BASE_MATRIX;
diff --git a/board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c b/board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c
index 36995a927cf..cb3cd7ac9ae 100644
--- a/board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c
+++ b/board/atmel/sama5d27_som1_ek/sama5d27_som1_ek.c
@@ -146,7 +146,7 @@ static void ddrc_conf(struct atmel_mpddrc_config *ddrc)
 		      (8 << ATMEL_MPDDRC_TPR2_TFAW_OFFSET));
 }
 
-void mem_init(void)
+void at91_mem_init(void)
 {
 	struct at91_pmc *pmc = (struct at91_pmc *)ATMEL_BASE_PMC;
 	struct atmel_mpddr *mpddrc = (struct atmel_mpddr *)ATMEL_BASE_MPDDRC;
diff --git a/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c b/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
index c775d593e58..15cbd0daa6f 100644
--- a/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
+++ b/board/atmel/sama5d27_wlsom1_ek/sama5d27_wlsom1_ek.c
@@ -208,7 +208,7 @@ static void ddrc_conf(struct atmel_mpddrc_config *ddrc)
 	ddrc->cal_mr4 |= ATMEL_MPDDRC_CAL_MR4_MR4R(0xFFFE);
 }
 
-void mem_init(void)
+void at91_mem_init(void)
 {
 	struct at91_pmc *pmc = (struct at91_pmc *)ATMEL_BASE_PMC;
 	struct atmel_mpddr *mpddrc = (struct atmel_mpddr *)ATMEL_BASE_MPDDRC;
diff --git a/board/atmel/sama5d2_icp/sama5d2_icp.c b/board/atmel/sama5d2_icp/sama5d2_icp.c
index 986da01639f..6f0d578abf7 100644
--- a/board/atmel/sama5d2_icp/sama5d2_icp.c
+++ b/board/atmel/sama5d2_icp/sama5d2_icp.c
@@ -180,7 +180,7 @@ static void ddrc_conf(struct atmel_mpddrc_config *ddrc)
 		      (7 << ATMEL_MPDDRC_TPR2_TFAW_OFFSET));
 }
 
-void mem_init(void)
+void at91_mem_init(void)
 {
 	struct at91_pmc *pmc = (struct at91_pmc *)ATMEL_BASE_PMC;
 	struct atmel_mpddr *mpddrc = (struct atmel_mpddr *)ATMEL_BASE_MPDDRC;
diff --git a/board/atmel/sama5d2_xplained/sama5d2_xplained.c b/board/atmel/sama5d2_xplained/sama5d2_xplained.c
index c8a8eb49826..d104736fa7c 100644
--- a/board/atmel/sama5d2_xplained/sama5d2_xplained.c
+++ b/board/atmel/sama5d2_xplained/sama5d2_xplained.c
@@ -146,7 +146,7 @@ static void ddrc_conf(struct atmel_mpddrc_config *ddrc)
 		      7 << ATMEL_MPDDRC_TPR2_TFAW_OFFSET);
 }
 
-void mem_init(void)
+void at91_mem_init(void)
 {
 	struct at91_pmc *pmc = (struct at91_pmc *)ATMEL_BASE_PMC;
 	struct atmel_mpddr *mpddrc = (struct atmel_mpddr *)ATMEL_BASE_MPDDRC;
diff --git a/board/atmel/sama5d3_xplained/sama5d3_xplained.c b/board/atmel/sama5d3_xplained/sama5d3_xplained.c
index 54cc3c4d900..f98322fb540 100644
--- a/board/atmel/sama5d3_xplained/sama5d3_xplained.c
+++ b/board/atmel/sama5d3_xplained/sama5d3_xplained.c
@@ -175,7 +175,7 @@ static void ddr2_conf(struct atmel_mpddrc_config *ddr2)
 		      8 << ATMEL_MPDDRC_TPR2_TXARD_OFFSET);
 }
 
-void mem_init(void)
+void at91_mem_init(void)
 {
 	struct atmel_mpddrc_config ddr2;
 
diff --git a/board/atmel/sama5d3xek/sama5d3xek.c b/board/atmel/sama5d3xek/sama5d3xek.c
index f2e1242fcb0..28079a81517 100644
--- a/board/atmel/sama5d3xek/sama5d3xek.c
+++ b/board/atmel/sama5d3xek/sama5d3xek.c
@@ -241,7 +241,7 @@ static void ddr2_conf(struct atmel_mpddrc_config *ddr2)
 		      8 << ATMEL_MPDDRC_TPR2_TXARD_OFFSET);
 }
 
-void mem_init(void)
+void at91_mem_init(void)
 {
 	struct atmel_mpddrc_config ddr2;
 
diff --git a/board/atmel/sama5d4_xplained/sama5d4_xplained.c b/board/atmel/sama5d4_xplained/sama5d4_xplained.c
index 09ca16ca88c..f9112fc5321 100644
--- a/board/atmel/sama5d4_xplained/sama5d4_xplained.c
+++ b/board/atmel/sama5d4_xplained/sama5d4_xplained.c
@@ -184,7 +184,7 @@ static void ddr2_conf(struct atmel_mpddrc_config *ddr2)
 		      8 << ATMEL_MPDDRC_TPR2_TXARD_OFFSET);
 }
 
-void mem_init(void)
+void at91_mem_init(void)
 {
 	struct atmel_mpddrc_config ddr2;
 
diff --git a/board/atmel/sama5d4ek/sama5d4ek.c b/board/atmel/sama5d4ek/sama5d4ek.c
index 1f8b85f0614..0bdc6adbdc8 100644
--- a/board/atmel/sama5d4ek/sama5d4ek.c
+++ b/board/atmel/sama5d4ek/sama5d4ek.c
@@ -169,7 +169,7 @@ static void ddr2_conf(struct atmel_mpddrc_config *ddr2)
 		      8 << ATMEL_MPDDRC_TPR2_TXARD_OFFSET);
 }
 
-void mem_init(void)
+void at91_mem_init(void)
 {
 	struct atmel_mpddrc_config ddr2;
 	const struct atmel_mpddr *mpddr = (struct atmel_mpddr *)ATMEL_BASE_MPDDRC;
diff --git a/board/cobra5272/flash.c b/board/cobra5272/flash.c
index 616842e62f4..d324aa6ac11 100644
--- a/board/cobra5272/flash.c
+++ b/board/cobra5272/flash.c
@@ -135,22 +135,22 @@ int flash_erase(flash_info_t *info, int s_first, int s_last)
 {
 	ulong result;
 	int iflag, cflag, prot, sect;
-	int rc = ERR_OK;
+	int rc = FL_ERR_OK;
 	int chip1;
 	ulong start;
 
 	/* first look for protection bits */
 
 	if (info->flash_id == FLASH_UNKNOWN)
-		return ERR_UNKNOWN_FLASH_TYPE;
+		return FL_ERR_UNKNOWN_FLASH_TYPE;
 
 	if ((s_first < 0) || (s_first > s_last)) {
-		return ERR_INVAL;
+		return FL_ERR_INVAL;
 	}
 
 	if ((info->flash_id & FLASH_VENDMASK) !=
 	    (AMD_MANUFACT & FLASH_VENDMASK)) {
-		return ERR_UNKNOWN_FLASH_VENDOR;
+		return FL_ERR_UNKNOWN_FLASH_VENDOR;
 	}
 
 	prot = 0;
@@ -160,7 +160,7 @@ int flash_erase(flash_info_t *info, int s_first, int s_last)
 		}
 	}
 	if (prot)
-		return ERR_PROTECTED;
+		return FL_ERR_PROTECTED;
 
 	/*
 	 * Disable interrupts which might cause a timeout
@@ -217,11 +217,11 @@ int flash_erase(flash_info_t *info, int s_first, int s_last)
 			MEM_FLASH_ADDR1 = CMD_READ_ARRAY;
 
 			if (chip1 == ERR) {
-				rc = ERR_PROG_ERROR;
+				rc = FL_ERR_PROG_ERROR;
 				goto outahere;
 			}
 			if (chip1 == TMO) {
-				rc = ERR_TIMEOUT;
+				rc = FL_ERR_TIMEOUT;
 				goto outahere;
 			}
 
@@ -252,7 +252,7 @@ static int write_word(flash_info_t *info, ulong dest, ulong data)
 {
 	volatile u16 *addr = (volatile u16 *) dest;
 	ulong result;
-	int rc = ERR_OK;
+	int rc = FL_ERR_OK;
 	int cflag, iflag;
 	int chip1;
 	ulong start;
@@ -262,7 +262,7 @@ static int write_word(flash_info_t *info, ulong dest, ulong data)
 	 */
 	result = *addr;
 	if ((result & data) != data)
-		return ERR_NOT_ERASED;
+		return FL_ERR_NOT_ERASED;
 
 	/*
 	 * Disable interrupts which might cause a timeout
@@ -302,7 +302,7 @@ static int write_word(flash_info_t *info, ulong dest, ulong data)
 	*addr = CMD_READ_ARRAY;
 
 	if (chip1 == ERR || *addr != data)
-		rc = ERR_PROG_ERROR;
+		rc = FL_ERR_PROG_ERROR;
 
 	if (iflag)
 		enable_interrupts();
@@ -320,13 +320,13 @@ int write_buff(flash_info_t *info, uchar *src, ulong addr, ulong cnt)
 
 	if (addr & 1) {
 		printf ("unaligned destination not supported\n");
-		return ERR_ALIGN;
+		return FL_ERR_ALIGN;
 	}
 
 #if 0
 	if (cnt & 1) {
 		printf ("odd transfer sizes not supported\n");
-		return ERR_ALIGN;
+		return FL_ERR_ALIGN;
 	}
 #endif
 
@@ -364,5 +364,5 @@ int write_buff(flash_info_t *info, uchar *src, ulong addr, ulong cnt)
 		cnt -= 1;
 	}
 
-	return ERR_OK;
+	return FL_ERR_OK;
 }
diff --git a/board/conclusive/kstr-sama5d27/kstr-sama5d27.c b/board/conclusive/kstr-sama5d27/kstr-sama5d27.c
index 64282ae9dc7..37750137ad9 100644
--- a/board/conclusive/kstr-sama5d27/kstr-sama5d27.c
+++ b/board/conclusive/kstr-sama5d27/kstr-sama5d27.c
@@ -182,7 +182,7 @@ static void ddrc_conf(struct atmel_mpddrc_config *ddrc)
 		      (8 << ATMEL_MPDDRC_TPR2_TFAW_OFFSET));
 }
 
-void mem_init(void)
+void at91_mem_init(void)
 {
 	struct at91_pmc *pmc = (struct at91_pmc *)ATMEL_BASE_PMC;
 	struct atmel_mpddr *mpddrc = (struct atmel_mpddr *)ATMEL_BASE_MPDDRC;
diff --git a/board/freescale/m5253demo/flash.c b/board/freescale/m5253demo/flash.c
index 334518a4bc9..ab5d2ebff64 100644
--- a/board/freescale/m5253demo/flash.c
+++ b/board/freescale/m5253demo/flash.c
@@ -72,7 +72,7 @@ int flash_get_offsets(ulong base, flash_info_t * info)
 		}
 	}
 
-	return ERR_OK;
+	return FL_ERR_OK;
 }
 
 void flash_print_info(flash_info_t * info)
@@ -369,9 +369,9 @@ int write_buff(flash_info_t * info, uchar * src, ulong addr, ulong cnt)
 	}
 
 	if (cnt == 0)
-		return ERR_OK;
+		return FL_ERR_OK;
 
-	return ERR_OK;
+	return FL_ERR_OK;
 }
 
 /*-----------------------------------------------------------------------
diff --git a/board/gardena/smart-gateway-at91sam/spl.c b/board/gardena/smart-gateway-at91sam/spl.c
index fb3ec48f9c5..db9ba881884 100644
--- a/board/gardena/smart-gateway-at91sam/spl.c
+++ b/board/gardena/smart-gateway-at91sam/spl.c
@@ -110,7 +110,7 @@ static void ddr2_conf(struct atmel_mpddrc_config *ddr2)
 		      2 << ATMEL_MPDDRC_TPR2_TXARD_OFFSET);
 }
 
-void mem_init(void)
+void at91_mem_init(void)
 {
 	struct at91_matrix *matrix = (struct at91_matrix *)ATMEL_BASE_MATRIX;
 	struct at91_pmc *pmc = (struct at91_pmc *)ATMEL_BASE_PMC;
diff --git a/board/siemens/corvus/board.c b/board/siemens/corvus/board.c
index 7d73d1f2b36..cd27fc1cc37 100644
--- a/board/siemens/corvus/board.c
+++ b/board/siemens/corvus/board.c
@@ -187,7 +187,7 @@ static void ddr2_conf(struct atmel_mpddrc_config *ddr2)
 		      2 << ATMEL_MPDDRC_TPR2_TXARD_OFFSET);
 }
 
-void mem_init(void)
+void at91_mem_init(void)
 {
 	struct atmel_mpddrc_config ddr2;
 
diff --git a/board/siemens/smartweb/smartweb.c b/board/siemens/smartweb/smartweb.c
index 946fbc3f229..e9e4bc348cb 100644
--- a/board/siemens/smartweb/smartweb.c
+++ b/board/siemens/smartweb/smartweb.c
@@ -238,7 +238,7 @@ void at91_spl_board_init(void)
 			 | AT91_SDRAMC_TRP_VAL(2) | AT91_SDRAMC_TRCD_VAL(2) \
 			 | AT91_SDRAMC_TRAS_VAL(5) | AT91_SDRAMC_TXSR_VAL(8))
 
-void mem_init(void)
+void at91_mem_init(void)
 {
 	struct at91_matrix *ma = (struct at91_matrix *)ATMEL_BASE_MATRIX;
 	struct at91_port *port = (struct at91_port *)ATMEL_BASE_PIOC;
diff --git a/board/siemens/taurus/taurus.c b/board/siemens/taurus/taurus.c
index bda12a97708..3764ab48ab3 100644
--- a/board/siemens/taurus/taurus.c
+++ b/board/siemens/taurus/taurus.c
@@ -177,7 +177,7 @@ void sdramc_configure(unsigned int mask)
 	sdramc_initialize(ATMEL_BASE_CS1, &setting);
 }
 
-void mem_init(void)
+void at91_mem_init(void)
 {
 	unsigned int ram_size = 0;
 
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 43f78a5aeb1..83c82818bf4 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2099,6 +2099,7 @@ config CMD_ETHSW
 config CMD_PXE
 	bool "pxe"
 	select PXE_UTILS
+	imply CMD_TFTPBOOT
 	help
 	  Boot image via network using PXE protocol
 
diff --git a/common/Kconfig b/common/Kconfig
index 83c81edac20..968d4fb66a8 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -934,6 +934,7 @@ menu "Update support"
 config UPDATE_COMMON
 	bool
 	select DFU_WRITE_ALT
+	imply CMD_TFTPBOOT
 
 config UPDATE_TFTP
 	bool "Auto-update using fitImage via TFTP"
diff --git a/common/flash.c b/common/flash.c
index 24ddc8bee72..a64e51a9b5a 100644
--- a/common/flash.c
+++ b/common/flash.c
@@ -110,13 +110,13 @@ addr2info(ulong addr)
  * Make sure all target addresses are within Flash bounds,
  * and no protected sectors are hit.
  * Returns:
- * ERR_OK          0 - OK
- * ERR_TIMEOUT     1 - write timeout
- * ERR_NOT_ERASED  2 - Flash not erased
- * ERR_PROTECTED   4 - target range includes protected sectors
- * ERR_INVAL       8 - target address not in Flash memory
- * ERR_ALIGN       16 - target address not aligned on boundary
- *			(only some targets require alignment)
+ * FL_ERR_OK          0 - OK
+ * FL_ERR_TIMEOUT     1 - write timeout
+ * FL_ERR_NOT_ERASED  2 - Flash not erased
+ * FL_ERR_PROTECTED   4 - target range includes protected sectors
+ * FL_ERR_INVAL       8 - target address not in Flash memory
+ * FL_ERR_ALIGN       16 - target address not aligned on boundary
+ *			   (only some targets require alignment)
  */
 int
 flash_write(char *src, ulong addr, ulong cnt)
@@ -131,11 +131,11 @@ flash_write(char *src, ulong addr, ulong cnt)
 	__maybe_unused ulong cnt_orig = cnt;
 
 	if (cnt == 0) {
-		return (ERR_OK);
+		return (FL_ERR_OK);
 	}
 
 	if (!info_first || !info_last) {
-		return (ERR_INVAL);
+		return (FL_ERR_INVAL);
 	}
 
 	for (info = info_first; info <= info_last; ++info) {
@@ -146,7 +146,7 @@ flash_write(char *src, ulong addr, ulong cnt)
 
 			if ((end >= info->start[i]) && (addr < e_addr) &&
 			    (info->protect[i] != 0) ) {
-				return (ERR_PROTECTED);
+				return (FL_ERR_PROTECTED);
 			}
 		}
 	}
@@ -169,11 +169,11 @@ flash_write(char *src, ulong addr, ulong cnt)
 #if defined(CONFIG_FLASH_VERIFY)
 	if (memcmp(src_orig, addr_orig, cnt_orig)) {
 		printf("\nVerify failed!\n");
-		return ERR_PROG_ERROR;
+		return FL_ERR_PROG_ERROR;
 	}
 #endif /* CONFIG_SYS_FLASH_VERIFY_AFTER_WRITE */
 
-	return (ERR_OK);
+	return (FL_ERR_OK);
 }
 
 /*-----------------------------------------------------------------------
@@ -182,33 +182,33 @@ flash_write(char *src, ulong addr, ulong cnt)
 void flash_perror(int err)
 {
 	switch (err) {
-	case ERR_OK:
+	case FL_ERR_OK:
 		break;
-	case ERR_TIMEOUT:
+	case FL_ERR_TIMEOUT:
 		puts ("Timeout writing to Flash\n");
 		break;
-	case ERR_NOT_ERASED:
+	case FL_ERR_NOT_ERASED:
 		puts ("Flash not Erased\n");
 		break;
-	case ERR_PROTECTED:
+	case FL_ERR_PROTECTED:
 		puts ("Can't write to protected Flash sectors\n");
 		break;
-	case ERR_INVAL:
+	case FL_ERR_INVAL:
 		puts ("Outside available Flash\n");
 		break;
-	case ERR_ALIGN:
+	case FL_ERR_ALIGN:
 		puts ("Start and/or end address not on sector boundary\n");
 		break;
-	case ERR_UNKNOWN_FLASH_VENDOR:
+	case FL_ERR_UNKNOWN_FLASH_VENDOR:
 		puts ("Unknown Vendor of Flash\n");
 		break;
-	case ERR_UNKNOWN_FLASH_TYPE:
+	case FL_ERR_UNKNOWN_FLASH_TYPE:
 		puts ("Unknown Type of Flash\n");
 		break;
-	case ERR_PROG_ERROR:
+	case FL_ERR_PROG_ERROR:
 		puts ("General Flash Programming Error\n");
 		break;
-	case ERR_ABORTED:
+	case FL_ERR_ABORTED:
 		puts("Flash Programming Aborted\n");
 		break;
 	default:
diff --git a/drivers/mtd/altera_qspi.c b/drivers/mtd/altera_qspi.c
index c26615821c8..e5c8df750b7 100644
--- a/drivers/mtd/altera_qspi.c
+++ b/drivers/mtd/altera_qspi.c
@@ -96,7 +96,7 @@ int flash_erase(flash_info_t *info, int s_first, int s_last)
 	ret = mtd_erase(mtd, &instr);
 	flash_set_verbose(0);
 	if (ret)
-		return ERR_PROTECTED;
+		return FL_ERR_PROTECTED;
 
 	puts(" done\n");
 	return 0;
@@ -114,7 +114,7 @@ int write_buff(flash_info_t *info, uchar *src, ulong addr, ulong cnt)
 
 	ret = mtd_write(mtd, to, cnt, &retlen, src);
 	if (ret)
-		return ERR_PROTECTED;
+		return FL_ERR_PROTECTED;
 
 	return 0;
 }
diff --git a/drivers/mtd/cfi_flash.c b/drivers/mtd/cfi_flash.c
index a7826e81c17..e50502824ac 100644
--- a/drivers/mtd/cfi_flash.c
+++ b/drivers/mtd/cfi_flash.c
@@ -593,11 +593,11 @@ static int flash_status_check(flash_info_t *info, flash_sect_t sector,
 			       flash_read_long(info, sector, 0));
 			flash_write_cmd(info, sector, 0, info->cmd_reset);
 			udelay(1);
-			return ERR_TIMEOUT;
+			return FL_ERR_TIMEOUT;
 		}
 		udelay(1);		/* also triggers watchdog */
 	}
-	return ERR_OK;
+	return FL_ERR_OK;
 }
 
 /*-----------------------------------------------------------------------
@@ -616,9 +616,9 @@ static int flash_full_status_check(flash_info_t *info, flash_sect_t sector,
 	case CFI_CMDSET_INTEL_PROG_REGIONS:
 	case CFI_CMDSET_INTEL_EXTENDED:
 	case CFI_CMDSET_INTEL_STANDARD:
-		if (retcode == ERR_OK &&
+		if (retcode == FL_ERR_OK &&
 		    !flash_isset(info, sector, 0, FLASH_STATUS_DONE)) {
-			retcode = ERR_INVAL;
+			retcode = FL_ERR_INVAL;
 			printf("Flash %s error at address %lx\n", prompt,
 			       info->start[sector]);
 			if (flash_isset(info, sector, 0, FLASH_STATUS_ECLBS |
@@ -627,14 +627,14 @@ static int flash_full_status_check(flash_info_t *info, flash_sect_t sector,
 			} else if (flash_isset(info, sector, 0,
 						FLASH_STATUS_ECLBS)) {
 				puts("Block Erase Error.\n");
-				retcode = ERR_NOT_ERASED;
+				retcode = FL_ERR_NOT_ERASED;
 			} else if (flash_isset(info, sector, 0,
 						FLASH_STATUS_PSLBS)) {
 				puts("Locking Error\n");
 			}
 			if (flash_isset(info, sector, 0, FLASH_STATUS_DPS)) {
 				puts("Block locked.\n");
-				retcode = ERR_PROTECTED;
+				retcode = FL_ERR_PROTECTED;
 			}
 			if (flash_isset(info, sector, 0, FLASH_STATUS_VPENS))
 				puts("Vpp Low Error.\n");
@@ -702,12 +702,12 @@ static int flash_status_poll(flash_info_t *info, void *src, void *dst,
 		if (get_timer(start) > tout) {
 			printf("Flash %s timeout at address %lx data %lx\n",
 			       prompt, (ulong)dst, (ulong)flash_read8(dst));
-			return ERR_TIMEOUT;
+			return FL_ERR_TIMEOUT;
 		}
 		udelay(1);		/* also triggers watchdog */
 	}
 #endif /* CONFIG_SYS_CFI_FLASH_STATUS_POLL */
-	return ERR_OK;
+	return FL_ERR_OK;
 }
 
 /*-----------------------------------------------------------------------
@@ -810,7 +810,7 @@ static int flash_write_cfiword(flash_info_t *info, ulong dest, cfiword_t cword)
 		break;
 	}
 	if (!flag)
-		return ERR_NOT_ERASED;
+		return FL_ERR_NOT_ERASED;
 
 	/* Disable interrupts which might cause a timeout here */
 	flag = disable_interrupts();
@@ -899,7 +899,7 @@ static int flash_write_cfibuffer(flash_info_t *info, ulong dest, uchar *cp,
 		shift = 3;
 		break;
 	default:
-		retcode = ERR_INVAL;
+		retcode = FL_ERR_INVAL;
 		goto out_unmap;
 	}
 
@@ -930,7 +930,7 @@ static int flash_write_cfibuffer(flash_info_t *info, ulong dest, uchar *cp,
 		}
 	}
 	if (!flag) {
-		retcode = ERR_NOT_ERASED;
+		retcode = FL_ERR_NOT_ERASED;
 		goto out_unmap;
 	}
 
@@ -950,7 +950,7 @@ static int flash_write_cfibuffer(flash_info_t *info, ulong dest, uchar *cp,
 		retcode = flash_status_check(info, sector,
 					     info->buffer_write_tout,
 					     "write to buffer");
-		if (retcode == ERR_OK) {
+		if (retcode == FL_ERR_OK) {
 			/* reduce the number of loops by the width of
 			 * the port
 			 */
@@ -975,7 +975,7 @@ static int flash_write_cfibuffer(flash_info_t *info, ulong dest, uchar *cp,
 					src += 8, dst += 8;
 					break;
 				default:
-					retcode = ERR_INVAL;
+					retcode = FL_ERR_INVAL;
 					goto out_unmap;
 				}
 			}
@@ -1025,7 +1025,7 @@ static int flash_write_cfibuffer(flash_info_t *info, ulong dest, uchar *cp,
 			}
 			break;
 		default:
-			retcode = ERR_INVAL;
+			retcode = FL_ERR_INVAL;
 			goto out_unmap;
 		}
 
@@ -1043,7 +1043,7 @@ static int flash_write_cfibuffer(flash_info_t *info, ulong dest, uchar *cp,
 
 	default:
 		debug("Unknown Command Set\n");
-		retcode = ERR_INVAL;
+		retcode = FL_ERR_INVAL;
 		break;
 	}
 
@@ -1389,7 +1389,7 @@ int write_buff(flash_info_t *info, uchar *src, ulong addr, ulong cnt)
 		if (i > cnt)
 			i = cnt;
 		rc = flash_write_cfibuffer(info, wp, src, i);
-		if (rc != ERR_OK)
+		if (rc != FL_ERR_OK)
 			return rc;
 		i -= i & (info->portwidth - 1);
 		wp += i;
@@ -1398,7 +1398,7 @@ int write_buff(flash_info_t *info, uchar *src, ulong addr, ulong cnt)
 		FLASH_SHOW_PROGRESS(scale, dots, digit, i);
 		/* Only check every once in a while */
 		if ((cnt & 0xFFFF) < buffered_size && ctrlc())
-			return ERR_ABORTED;
+			return FL_ERR_ABORTED;
 	}
 #else
 	while (cnt >= info->portwidth) {
@@ -1413,7 +1413,7 @@ int write_buff(flash_info_t *info, uchar *src, ulong addr, ulong cnt)
 		FLASH_SHOW_PROGRESS(scale, dots, digit, info->portwidth);
 		/* Only check every once in a while */
 		if ((cnt & 0xFFFF) < info->portwidth && ctrlc())
-			return ERR_ABORTED;
+			return FL_ERR_ABORTED;
 	}
 #endif /* CONFIG_SYS_FLASH_USE_BUFFER_WRITE */
 
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 6ed325517c0..e7d0ddfe25a 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -468,6 +468,7 @@ config FTMAC100
 config FTGMAC100
 	bool "Ftgmac100 Ethernet Support"
 	select PHYLIB
+	depends on NET
 	help
 	  This driver supports the Faraday's FTGMAC100 Gigabit SoC
 	  Ethernet controller that can be found on Aspeed SoCs (which
diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
index 0a0d92bc2cd..2dc1364beec 100644
--- a/drivers/net/fec_mxc.c
+++ b/drivers/net/fec_mxc.c
@@ -615,8 +615,7 @@ static int fecmxc_init(struct udevice *dev)
 	if (fec->xcv_type != SEVENWIRE)
 		miiphy_restart_aneg(dev);
 #endif
-	fec_open(dev);
-	return 0;
+	return fec_open(dev);
 }
 
 /**
diff --git a/drivers/net/fm/eth.c b/drivers/net/fm/eth.c
index 19f3f0fef07..22025b6a273 100644
--- a/drivers/net/fm/eth.c
+++ b/drivers/net/fm/eth.c
@@ -26,7 +26,8 @@
 
 #include "fm.h"
 
-#if defined(CONFIG_MII) || defined(CONFIG_CMD_MII) && !defined(BITBANGMII)
+#if ((defined(CONFIG_MII) || defined(CONFIG_CMD_MII)) && \
+     !defined(CONFIG_BITBANGMII))
 
 #define TBIANA_SETTINGS (TBIANA_ASYMMETRIC_PAUSE | TBIANA_SYMMETRIC_PAUSE | \
 			 TBIANA_FULL_DUPLEX)
@@ -701,8 +702,11 @@ static int init_phy(struct fm_eth *fm_eth)
 		supported |= SUPPORTED_2500baseX_Full;
 #endif
 
-	if (fm_eth->type == FM_ETH_1G_E)
-		dtsec_init_phy(fm_eth);
+	if ((IS_ENABLED(CONFIG_MII) || IS_ENABLED(CONFIG_CMD_MII)) &&
+	    !IS_ENABLED(CONFIG_BITBANGMII)) {
+		if (fm_eth->type == FM_ETH_1G_E)
+			dtsec_init_phy(fm_eth);
+	}
 
 #ifdef CONFIG_PHYLIB
 #ifdef CONFIG_DM_MDIO
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 73064b2af68..a9efc509814 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -368,6 +368,7 @@ config PHY_FIXED
 
 config PHY_NCSI
 	bool "NC-SI based PHY"
+	depends on NET
 
 endif #PHYLIB
 
diff --git a/include/configs/ethernut5.h b/include/configs/ethernut5.h
index c327bbbe07d..338306dfe08 100644
--- a/include/configs/ethernut5.h
+++ b/include/configs/ethernut5.h
@@ -55,9 +55,7 @@
 #endif
 
 /* RTC */
-#if defined(CONFIG_CMD_DATE) || defined(CONFIG_CMD_SNTP)
 #define CFG_SYS_I2C_RTC_ADDR		0x51
-#endif
 
 #define I2C_SOFT_DECLARATIONS
 
diff --git a/include/flash.h b/include/flash.h
index 60babe8a805..32bc65e7b60 100644
--- a/include/flash.h
+++ b/include/flash.h
@@ -127,16 +127,16 @@ void flash_perror(int err);
 /*-----------------------------------------------------------------------
  * return codes from flash_write():
  */
-#define ERR_OK				0
-#define ERR_TIMEOUT			1
-#define ERR_NOT_ERASED			2
-#define ERR_PROTECTED			4
-#define ERR_INVAL			8
-#define ERR_ALIGN			16
-#define ERR_UNKNOWN_FLASH_VENDOR	32
-#define ERR_UNKNOWN_FLASH_TYPE		64
-#define ERR_PROG_ERROR			128
-#define ERR_ABORTED			256
+#define FL_ERR_OK			0
+#define FL_ERR_TIMEOUT			1
+#define FL_ERR_NOT_ERASED		2
+#define FL_ERR_PROTECTED		4
+#define FL_ERR_INVAL			8
+#define FL_ERR_ALIGN			16
+#define FL_ERR_UNKNOWN_FLASH_VENDOR	32
+#define FL_ERR_UNKNOWN_FLASH_TYPE	64
+#define FL_ERR_PROG_ERROR		128
+#define FL_ERR_ABORTED			256
 
 /*-----------------------------------------------------------------------
  * Protection Flags for flash_protect():
diff --git a/net/net.c b/net/net.c
index d9bc9df643f..1e0b7c85624 100644
--- a/net/net.c
+++ b/net/net.c
@@ -334,17 +334,22 @@ void net_auto_load(void)
 		net_set_state(NETLOOP_SUCCESS);
 		return;
 	}
-	if (net_check_prereq(TFTPGET)) {
-/* We aren't expecting to get a serverip, so just accept the assigned IP */
-		if (IS_ENABLED(CONFIG_BOOTP_SERVERIP)) {
-			net_set_state(NETLOOP_SUCCESS);
-		} else {
-			printf("Cannot autoload with TFTPGET\n");
-			net_set_state(NETLOOP_FAIL);
+	if (IS_ENABLED(CONFIG_CMD_TFTPBOOT)) {
+		if (net_check_prereq(TFTPGET)) {
+			/*
+			 * We aren't expecting to get a serverip, so just
+			 * accept the assigned IP
+			 */
+			if (IS_ENABLED(CONFIG_BOOTP_SERVERIP)) {
+				net_set_state(NETLOOP_SUCCESS);
+			} else {
+				printf("Cannot autoload with TFTPGET\n");
+				net_set_state(NETLOOP_FAIL);
+			}
+			return;
 		}
-		return;
+		tftp_start(TFTPGET);
 	}
-	tftp_start(TFTPGET);
 }
 
 static int net_init_loop(void)
diff --git a/net/wget.c b/net/wget.c
index 4a168641c65..c8cce554c5e 100644
--- a/net/wget.c
+++ b/net/wget.c
@@ -8,6 +8,7 @@
 #include <command.h>
 #include <display_options.h>
 #include <env.h>
+#include <efi_loader.h>
 #include <image.h>
 #include <lmb.h>
 #include <mapmem.h>
@@ -196,13 +197,6 @@ void wget_fail(char *error_message, unsigned int tcp_seq_num,
 	wget_send(action, tcp_seq_num, tcp_ack_num, 0);
 }
 
-void wget_success(u8 action, unsigned int tcp_seq_num,
-		  unsigned int tcp_ack_num, int len, int packets)
-{
-	printf("Packets received %d, Transfer Successful\n", packets);
-	wget_send(action, tcp_seq_num, tcp_ack_num, len);
-}
-
 /*
  * Interfaces of U-BOOT
  */
@@ -432,6 +426,9 @@ static void wget_handler(uchar *pkt, u16 dport,
 	case WGET_TRANSFERRED:
 		printf("Packets received %d, Transfer Successful\n", packets);
 		net_set_state(wget_loop_state);
+		efi_set_bootdev("Net", "", image_url,
+				map_sysmem(image_load_addr, 0),
+				net_boot_file_size);
 		break;
 	}
 }
diff --git a/test/py/tests/test_efi_loader.py b/test/py/tests/test_efi_loader.py
index 85473a9049b..5f3b448a066 100644
--- a/test/py/tests/test_efi_loader.py
+++ b/test/py/tests/test_efi_loader.py
@@ -45,11 +45,18 @@ env__efi_loader_helloworld_file = {
     'crc32': 'c2244b26',                   # CRC32 check sum
     'addr': 0x40400000,                    # load address
 }
+
+# False if the helloworld EFI over HTTP boot test should be performed.
+# If HTTP boot testing is not possible or desired, set this variable to True or
+# ommit it.
+env__efi_helloworld_net_http_test_skip = True
 """
 
 import pytest
 import u_boot_utils
 
+PROTO_TFTP, PROTO_HTTP = range(0, 2)
+
 net_set_up = False
 
 def test_efi_pre_commands(u_boot_console):
@@ -110,10 +117,10 @@ def test_efi_setup_static(u_boot_console):
     global net_set_up
     net_set_up = True
 
-def fetch_tftp_file(u_boot_console, env_conf):
-    """Grab an env described file via TFTP and return its address
+def fetch_file(u_boot_console, env_conf, proto):
+    """Grab an env described file via TFTP or HTTP and return its address
 
-    A file as described by an env config <env_conf> is downloaded from the TFTP
+    A file as described by an env config <env_conf> is downloaded from the
     server. The address to that file is returned.
     """
     if not net_set_up:
@@ -128,7 +135,13 @@ def fetch_tftp_file(u_boot_console, env_conf):
         addr = u_boot_utils.find_ram_base(u_boot_console)
 
     fn = f['fn']
-    output = u_boot_console.run_command('tftpboot %x %s' % (addr, fn))
+    if proto == PROTO_TFTP:
+        cmd = 'tftpboot'
+    elif proto == PROTO_HTTP:
+        cmd = 'wget'
+    else:
+        assert False
+    output = u_boot_console.run_command('%s %x %s' % (cmd, addr, fn))
     expected_text = 'Bytes transferred = '
     sz = f.get('size', None)
     if sz:
@@ -147,16 +160,8 @@ def fetch_tftp_file(u_boot_console, env_conf):
 
     return addr
 
-@pytest.mark.buildconfigspec('of_control')
-@pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
-def test_efi_helloworld_net(u_boot_console):
-    """Run the helloworld.efi binary via TFTP.
-
-    The helloworld.efi file is downloaded from the TFTP server and is executed
-    using the fallback device tree at $fdtcontroladdr.
-    """
-
-    addr = fetch_tftp_file(u_boot_console, 'env__efi_loader_helloworld_file')
+def do_test_efi_helloworld_net(u_boot_console, proto):
+    addr = fetch_file(u_boot_console, 'env__efi_loader_helloworld_file', proto)
 
     output = u_boot_console.run_command('bootefi %x' % addr)
     expected_text = 'Hello, world'
@@ -164,6 +169,32 @@ def test_efi_helloworld_net(u_boot_console):
     expected_text = '## Application failed'
     assert expected_text not in output
 
+@pytest.mark.buildconfigspec('of_control')
+@pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
+@pytest.mark.buildconfigspec('cmd_tftpboot')
+def test_efi_helloworld_net_tftp(u_boot_console):
+    """Run the helloworld.efi binary via TFTP.
+
+    The helloworld.efi file is downloaded from the TFTP server and is executed
+    using the fallback device tree at $fdtcontroladdr.
+    """
+
+    do_test_efi_helloworld_net(u_boot_console, PROTO_TFTP);
+
+@pytest.mark.buildconfigspec('of_control')
+@pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
+@pytest.mark.buildconfigspec('cmd_wget')
+def test_efi_helloworld_net_http(u_boot_console):
+    """Run the helloworld.efi binary via HTTP.
+
+    The helloworld.efi file is downloaded from the HTTP server and is executed
+    using the fallback device tree at $fdtcontroladdr.
+    """
+    if u_boot_console.config.env.get('env__efi_helloworld_net_http_test_skip', True):
+        pytest.skip('helloworld.efi HTTP test is not enabled!')
+
+    do_test_efi_helloworld_net(u_boot_console, PROTO_HTTP);
+
 @pytest.mark.buildconfigspec('cmd_bootefi_hello')
 def test_efi_helloworld_builtin(u_boot_console):
     """Run the builtin helloworld.efi binary.
@@ -178,6 +209,7 @@ def test_efi_helloworld_builtin(u_boot_console):
 
 @pytest.mark.buildconfigspec('of_control')
 @pytest.mark.buildconfigspec('cmd_bootefi')
+@pytest.mark.buildconfigspec('cmd_tftpboot')
 def test_efi_grub_net(u_boot_console):
     """Run the grub.efi binary via TFTP.
 
@@ -185,7 +217,7 @@ def test_efi_grub_net(u_boot_console):
     executed.
     """
 
-    addr = fetch_tftp_file(u_boot_console, 'env__efi_loader_grub_file')
+    addr = fetch_file(u_boot_console, 'env__efi_loader_grub_file', PROTO_TFTP)
 
     u_boot_console.run_command('bootefi %x' % addr, wait_for_prompt=False)
 
diff --git a/test/py/tests/test_net_boot.py b/test/py/tests/test_net_boot.py
index 63309fe82e1..d7d74356928 100644
--- a/test/py/tests/test_net_boot.py
+++ b/test/py/tests/test_net_boot.py
@@ -75,7 +75,7 @@ env__net_pxe_bootable_file = {
     'check_pattern': 'ERROR',
 }
 
-# False or omitted if a PXE boot test should be tested.
+# False if a PXE boot test should be tested.
 # If PXE boot testing is not possible or desired, set this variable to True.
 # For example: If pxe configuration file is not proper to boot
 env__pxe_boot_test_skip = False
diff --git a/tools/buildman/test.py b/tools/buildman/test.py
index e9d2c7e41b0..d4f0dd8f0e5 100644
--- a/tools/buildman/test.py
+++ b/tools/buildman/test.py
@@ -36,6 +36,16 @@ main: /usr/sbin
 x86: i386 x86_64
 '''
 
+settings_data_wrapper = '''
+# Buildman settings file
+
+[toolchain]
+main: /usr/sbin
+
+[toolchain-wrapper]
+wrapper = ccache
+'''
+
 migration = '''===================== WARNING ======================
 This board does not use CONFIG_DM. CONFIG_DM will be
 compulsory starting with the v2020.01 release.
@@ -605,6 +615,9 @@ class TestBuild(unittest.TestCase):
                          tc.GetEnvArgs(toolchain.VAR_ARCH))
         self.assertEqual('', tc.GetEnvArgs(toolchain.VAR_MAKE_ARGS))
 
+        tc = self.toolchains.Select('sandbox')
+        self.assertEqual('', tc.GetEnvArgs(toolchain.VAR_CROSS_COMPILE))
+
         self.toolchains.Add('/path/to/x86_64-linux-gcc', test=False)
         tc = self.toolchains.Select('x86')
         self.assertEqual('/path/to',
@@ -613,6 +626,39 @@ class TestBuild(unittest.TestCase):
         self.assertEqual('HOSTCC=clang CC=clang',
                          tc.GetEnvArgs(toolchain.VAR_MAKE_ARGS))
 
+        # Test config with ccache wrapper
+        bsettings.setup(None)
+        bsettings.add_file(settings_data_wrapper)
+
+        tc = self.toolchains.Select('arm')
+        self.assertEqual('ccache arm-linux-',
+                         tc.GetEnvArgs(toolchain.VAR_CROSS_COMPILE))
+
+        tc = self.toolchains.Select('sandbox')
+        self.assertEqual('', tc.GetEnvArgs(toolchain.VAR_CROSS_COMPILE))
+
+    def testMakeEnvironment(self):
+        """Test the MakeEnvironment function"""
+        tc = self.toolchains.Select('arm')
+        env = tc.MakeEnvironment(False)
+        self.assertEqual(env[b'CROSS_COMPILE'], b'arm-linux-')
+
+        tc = self.toolchains.Select('sandbox')
+        env = tc.MakeEnvironment(False)
+        self.assertTrue(b'CROSS_COMPILE' not in env)
+
+        # Test config with ccache wrapper
+        bsettings.setup(None)
+        bsettings.add_file(settings_data_wrapper)
+
+        tc = self.toolchains.Select('arm')
+        env = tc.MakeEnvironment(False)
+        self.assertEqual(env[b'CROSS_COMPILE'], b'ccache arm-linux-')
+
+        tc = self.toolchains.Select('sandbox')
+        env = tc.MakeEnvironment(False)
+        self.assertTrue(b'CROSS_COMPILE' not in env)
+
     def testPrepareOutputSpace(self):
         def _Touch(fname):
             tools.write_file(os.path.join(base_dir, fname), b'')
diff --git a/tools/buildman/toolchain.py b/tools/buildman/toolchain.py
index 324ad0e0821..cbd8ce03d30 100644
--- a/tools/buildman/toolchain.py
+++ b/tools/buildman/toolchain.py
@@ -159,6 +159,8 @@ class Toolchain:
         if which == VAR_CROSS_COMPILE:
             wrapper = self.GetWrapper()
             base = '' if self.arch == 'sandbox' else self.path
+            if (base == '' and self.cross == ''):
+                return ''
             return wrapper + os.path.join(base, self.cross)
         elif which == VAR_PATH:
             return self.path
@@ -201,10 +203,10 @@ class Toolchain:
         if self.override_toolchain:
             # We'll use MakeArgs() to provide this
             pass
-        elif full_path:
+        elif full_path and self.cross:
             env[b'CROSS_COMPILE'] = tools.to_bytes(
                 wrapper + os.path.join(self.path, self.cross))
-        else:
+        elif self.cross:
             env[b'CROSS_COMPILE'] = tools.to_bytes(wrapper + self.cross)
             env[b'PATH'] = tools.to_bytes(self.path) + b':' + env[b'PATH']
 
-- 
2.40.1

