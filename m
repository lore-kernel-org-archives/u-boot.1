Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC71D606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 10:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nLnrgewt;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=HTavt4xH
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9CFC260A55;
	Thu, 26 Nov 2026 10:47:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 51eyiwXjdSuR; Thu, 26 Nov 2026 10:47:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B6A6D60A45
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795690031;
	b=ZFC3nTSsXwk7xKrULdmR20ji7Q/CpVjT6O8nd/6XHRtvTlo5lQCIDXbFOCxQkty9XkTJ
	 Miqxh/dFH8480VKcA7IY2sap4/v7IUlcGzDPqTZTl6d+toZmZI7YPTOfKSHoSSPWwSyML
	 Qs7scJZVdOQfEu52pD9Y/O7vqMMi6P3t3ZfHBxS94YzSEqaf3lQGaWsmz6/9671AF+oyk
	 HJ2fhJP8W0dGWcqk477FCcwPox1HptymTZQV/PoMZe4tg/053sirVftQjxTqgLfDYsmGG
	 5spC0EQF5BZkKvx/KUU+PpfCpjn/xBcYM6sNVVuiCILfwGJ5J0s1RMwRTFsBf3Zut1Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795690031;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9CWnCVTtLEMzlYqnLhFov6qb1Ymn4nikMMG3NBpvJho=;
	b=K4XZrDktZat4fFOajySaFRAeLG6PVYQGwoY0TCPIqYR3nRkVAqAQpL8AKeAKVqLdl1V/
	 HeYdyF9QhhnMug3NPKsBBwm10A/huRvB+D0LxXF8rL/C2+xe4rJbCeuyUTK/fYWtAlHWZ
	 l6xUh+uu2vd8KJYnt4ExT1OfSEA82pUFDVJCuKAdSIMfX+sWViGeA69v+J8QHp+QOe/3l
	 vtyQkwzLNPkEdAP7Rv8PfyMW3HlrctgGMPnhbh07J6tOfRx4PCU3K0LOo49bq767FgInh
	 +j7kF7aw70JYREkDoRCD7441wpMcgp1i19Ypi4V7VIv8vISGcJATPPwmDfV6jmtmZZA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=ew.tq-group.com;
	dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=HTavt4xH;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795690031;
	bh=9CWnCVTtLEMzlYqnLhFov6qb1Ymn4nikMMG3NBpvJho=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nLnrgewt9VrCJFmtUYsL4lEs+0RjSt11fnsDfUXT06bagxvVcLixY2oPFAp+ez+Hd
	 YJ0VEQjqcbvK49eFDUnmg/jOJuHEIe77pb+4ivHOBQpCaOm+5MCtE4NVza4gfyf1C6
	 TAZMPIfSnCdWLnL6C1sbLSq0tFDPz4PaXsQLCBG9LAUOQzYAWSbyIxrWItSdtOkAlM
	 iklZ3XkdJzhgDZ5wcIT4lxOnG0ArGFiSQeABjy0I/MNe5C//CTrCUMDINBQlLigbn9
	 wlefLgpV/HUQXBlzfmIjHrdGD3lr8STiTOyX7aahVR2KSnKdj/OzWcGnk0FAjau2XW
	 MhTh+WUW1rfPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B6A6D60A45;
	Thu, 26 Nov 2026 10:47:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 70C5810B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:47:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 242C4608F6
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:47:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wqAlpXhRAi5E for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 10:46:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 43C14608EF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=HTavt4xH
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 43C14608EF
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=9CWnCVTtLEMzlYqnLhFov6qb1Ymn4nikMMG3NBpvJho=; b=HTavt4xHPkIT4XGpqC5fid3JkI
 99wvxGQ9tRPIID4yhP8FN1XV7w6TR8Ykrk0Y3DZSYut8kphIAmK81DJysBPt1M6mIjmpAsIWxxq5U
 OLIXpBYsxxcVi4UwMDWs92W9weGn8euKrfqFQZBxIJzkODI11zWq5gMIFM9/xegPdDeXVl+JRMLvl
 xli1gQLu1bazHeFrxgBaTlLep8Kj9jr0annVykHO6JfU26HI6I+Wiqm8j24HjHUkJ8hAbdQ0MR7+J
 0FX/fGk7j2uYzfnN3pPN8MQAQ5JmPeACLdxivuzWXGkaGAUYsbuHLoTfhYPWzImVy04F9aMk2f8cE
 okzgyIEg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1xWX06-000NuB-2P; Thu, 26 Nov 2026 11:46:50 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1xWX05-0002PX-24; Thu, 26 Nov 2026 11:46:50 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
Date: Thu, 26 Nov 2026 11:46:48 +0100
Subject: [PATCH 3/6] board: tqma6: add SPL support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-update-tqma6-v1-3-a105aba78868@ew.tq-group.com>
References: <20261126-update-tqma6-v1-0-a105aba78868@ew.tq-group.com>
In-Reply-To: <20261126-update-tqma6-v1-0-a105aba78868@ew.tq-group.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot@ew.tq-group.com, 
 u-boot@lists.u-boot-project.org, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Max Merchel <max.merchel@ew.tq-group.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Paul Gerber <Paul.Gerber@tq-group.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Adam Ford <aford173@gmail.com>, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 Paul Gerber <Paul.Gerber@ew.tq-group.com>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>
X-Mailer: b4 0.14.3
X-Virus-Scanned: Clear (ClamAV 1.4.6/28194/Wed Nov 25 07:26:59 2026)
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Update defconfigs to use SPL.

Signed-off-by: Paul Gerber <Paul.Gerber@tq-group.com>
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 arch/arm/mach-imx/mx6/Kconfig      |   6 ++
 board/tq/tqma6/Kconfig             |   7 +-
 board/tq/tqma6/Makefile            |   8 ++
 board/tq/tqma6/clocks.cfg          |  26 ------
 board/tq/tqma6/spl_mba6.c          | 187 +++++++++++++++++++++++++++++++++++++
 board/tq/tqma6/spl_tqma6.c         | 180 +++++++++++++++++++++++++++++++++++
 board/tq/tqma6/spl_tqma6dl_ram.c   | 147 +++++++++++++++++++++++++++++
 board/tq/tqma6/spl_tqma6q_ram.c    | 148 +++++++++++++++++++++++++++++
 board/tq/tqma6/spl_tqma6s_ram.c    | 145 ++++++++++++++++++++++++++++
 board/tq/tqma6/tqma6.c             | 117 +++++++++++++----------
 board/tq/tqma6/tqma6.cfg           |  30 ++++++
 board/tq/tqma6/tqma6.h             |   4 +
 board/tq/tqma6/tqma6_mba6.c        |  98 +++++++------------
 board/tq/tqma6/tqma6dl.cfg         | 125 -------------------------
 board/tq/tqma6/tqma6q.cfg          | 126 -------------------------
 board/tq/tqma6/tqma6s.cfg          | 126 -------------------------
 configs/tqma6_mba6_common.config   |  25 ++++-
 configs/tqma6dl_mba6_mmc_defconfig |   2 +
 configs/tqma6dl_mba6_spi_defconfig |   2 +
 configs/tqma6q_mba6_mmc_defconfig  |   2 +
 configs/tqma6q_mba6_spi_defconfig  |   2 +
 configs/tqma6s_mba6_mmc_defconfig  |   2 +
 configs/tqma6s_mba6_spi_defconfig  |   2 +
 23 files changed, 996 insertions(+), 521 deletions(-)

diff --git a/arch/arm/mach-imx/mx6/Kconfig b/arch/arm/mach-imx/mx6/Kconfig
index 6140d9f319b..19d5d58fc4e 100644
--- a/arch/arm/mach-imx/mx6/Kconfig
+++ b/arch/arm/mach-imx/mx6/Kconfig
@@ -606,10 +606,16 @@ config TARGET_KP_IMX6Q_TPC
 
 config TARGET_TQMA6
 	bool "TQ-Systems TQMa6 board"
+	select TQ_COMMON_SOM
+	select TQ_COMMON_SYSINFO
 	select BOARD_EARLY_INIT_F
 	select BOARD_LATE_INIT
+	select I2C_EEPROM
+	select MISC
 	select MXC_SPI
 	select SPI
+	select SUPPORT_SPL
+	select SPL_SEPARATE_BSS if SPL
 	imply DM
 	imply DM_GPIO
 	imply DM_MMC
diff --git a/board/tq/tqma6/Kconfig b/board/tq/tqma6/Kconfig
index 21bcb8e0cb3..65f5be8af61 100644
--- a/board/tq/tqma6/Kconfig
+++ b/board/tq/tqma6/Kconfig
@@ -105,10 +105,11 @@ config TEXT_BASE
 	default 0x2fc00000 if TQMA6S
 	default 0x4fc00000 if TQMA6Q || TQMA6DL
 
+config SPL_TEXT_BASE
+	default 0x00908000
+
 config IMX_CONFIG
-	default "board/tq/tqma6/tqma6q.cfg" if TQMA6Q
-	default "board/tq/tqma6/tqma6dl.cfg" if TQMA6DL
-	default "board/tq/tqma6/tqma6s.cfg" if TQMA6S
+	default "board/tq/tqma6/tqma6.cfg"
 
 source "board/tq/common/Kconfig"
 
diff --git a/board/tq/tqma6/Makefile b/board/tq/tqma6/Makefile
index ecebc28315d..c29720341ff 100644
--- a/board/tq/tqma6/Makefile
+++ b/board/tq/tqma6/Makefile
@@ -8,5 +8,13 @@
 obj-y  := tqma6.o
 obj-y  += tqma6_emmc.o
 
+ifdef CONFIG_SPL_BUILD
+obj-y += spl_tqma6.o
+obj-$(CONFIG_TQMA6DL) += spl_tqma6dl_ram.o
+obj-$(CONFIG_TQMA6Q) += spl_tqma6q_ram.o
+obj-$(CONFIG_TQMA6S) += spl_tqma6s_ram.o
+obj-$(CONFIG_MBA6) += spl_mba6.o
+endif
+
 obj-$(CONFIG_MBA6) += tqma6_mba6.o
 obj-$(CONFIG_WRU4) += tqma6_wru4.o
diff --git a/board/tq/tqma6/clocks.cfg b/board/tq/tqma6/clocks.cfg
deleted file mode 100644
index c2e6d12b924..00000000000
--- a/board/tq/tqma6/clocks.cfg
+++ /dev/null
@@ -1,26 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (C) 2013 Boundary Devices
- *
- * Copyright (c) 2013-2014 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
- * D-82229 Seefeld, Germany.
- * Author: Markus Niebel
- *
- * Refer doc/imx/mkimage/imximage.txt for more details about how-to configure
- * and create imximage boot image
- */
-
-/* set the default clock gate to save power */
-DATA 4, CCM_CCGR0, 0x00C03F3F
-DATA 4, CCM_CCGR1, 0x0030FC03
-DATA 4, CCM_CCGR2, 0x0FFFC000
-DATA 4, CCM_CCGR3, 0x3FF00000
-DATA 4, CCM_CCGR4, 0x00FFF300
-DATA 4, CCM_CCGR5, 0x0F0000C3
-DATA 4, CCM_CCGR6, 0x000003FF
-
-/* enable AXI cache for VDOA/VPU/IPU */
-DATA 4, MX6_IOMUXC_GPR4, 0xF00000CF
-/* set IPU AXI-id0 Qos=0xf(bypass) AXI-id1 Qos=0x7 */
-DATA 4, MX6_IOMUXC_GPR6, 0x007F007F
-DATA 4, MX6_IOMUXC_GPR7, 0x007F007F
diff --git a/board/tq/tqma6/spl_mba6.c b/board/tq/tqma6/spl_mba6.c
new file mode 100644
index 00000000000..58889e388ba
--- /dev/null
+++ b/board/tq/tqma6/spl_mba6.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2014-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel, Max Merchel
+ */
+
+#include <fsl_esdhc_imx.h>
+#include <i2c.h>
+#include <init.h>
+#include <spl.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/crm_regs.h>
+#include <asm/arch/imx-regs.h>
+#include <asm/arch/iomux.h>
+#include <asm/arch/mx6-pins.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/iomux-v3.h>
+
+#include "tqma6.h"
+#include "../common/tq_bb.h"
+
+#define UART_PAD_CTRL (PAD_CTL_PUS_100K_UP | PAD_CTL_SPEED_MED | \
+			PAD_CTL_DSE_80ohm   | PAD_CTL_SRE_FAST  | PAD_CTL_HYS)
+
+#define USDHC_CLK_PAD_CTRL (PAD_CTL_PUS_47K_UP  | PAD_CTL_SPEED_LOW | \
+	PAD_CTL_DSE_40ohm   | PAD_CTL_SRE_FAST  | PAD_CTL_HYS)
+
+#define USDHC_PAD_CTRL (PAD_CTL_PUS_47K_UP  | PAD_CTL_SPEED_LOW | \
+	PAD_CTL_DSE_80ohm   | PAD_CTL_SRE_FAST  | PAD_CTL_HYS)
+
+#define GPIO_OUT_PAD_CTRL  (PAD_CTL_PUS_100K_UP | PAD_CTL_SPEED_LOW | \
+	PAD_CTL_DSE_40ohm   | PAD_CTL_HYS)
+
+#define GPIO_IN_PAD_CTRL  (PAD_CTL_PUS_100K_UP | PAD_CTL_SPEED_LOW | \
+	PAD_CTL_DSE_40ohm   | PAD_CTL_HYS)
+
+static const iomux_v3_cfg_t mba6_uart2_pads[] = {
+	MX6_PAD_SD4_DAT4__UART2_RX_DATA | MUX_PAD_CTRL(UART_PAD_CTRL),
+	MX6_PAD_SD4_DAT7__UART2_TX_DATA | MUX_PAD_CTRL(UART_PAD_CTRL),
+};
+
+static void mba6_setup_iomuxc_uart(void)
+{
+	imx_iomux_v3_setup_multiple_pads(mba6_uart2_pads,
+					 ARRAY_SIZE(mba6_uart2_pads));
+}
+
+static const iomux_v3_cfg_t mba6_usdhc2_pads[] = {
+	MX6_PAD_SD2_CLK__SD2_CLK |	MUX_PAD_CTRL(USDHC_CLK_PAD_CTRL),
+	MX6_PAD_SD2_CMD__SD2_CMD |	MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_SD2_DAT0__SD2_DATA0 |	MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_SD2_DAT1__SD2_DATA1 |	MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_SD2_DAT2__SD2_DATA2 |	MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_SD2_DAT3__SD2_DATA3 |	MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	/* CD */
+	MX6_PAD_GPIO_4__GPIO1_IO04 |	MUX_PAD_CTRL(GPIO_IN_PAD_CTRL),
+	/* WP */
+	MX6_PAD_GPIO_2__GPIO1_IO02 |	MUX_PAD_CTRL(GPIO_IN_PAD_CTRL),
+};
+
+#define USDHC2_CD_GPIO	IMX_GPIO_NR(1, 4)
+#define USDHC2_WP_GPIO	IMX_GPIO_NR(1, 2)
+
+static struct fsl_esdhc_cfg mba6_usdhc_cfg = {
+	.esdhc_base = USDHC2_BASE_ADDR,
+	.max_bus_width = 4,
+};
+
+int tq_bb_board_mmc_getcd(struct mmc *mmc)
+{
+	struct fsl_esdhc_cfg *cfg = (struct fsl_esdhc_cfg *)mmc->priv;
+	int ret = 0;
+
+	if (cfg->esdhc_base == USDHC2_BASE_ADDR)
+		ret = !gpio_get_value(USDHC2_CD_GPIO);
+
+	return ret;
+}
+
+int tq_bb_board_mmc_getwp(struct mmc *mmc)
+{
+	struct fsl_esdhc_cfg *cfg = (struct fsl_esdhc_cfg *)mmc->priv;
+	int ret = 0;
+
+	if (cfg->esdhc_base == USDHC2_BASE_ADDR)
+		ret = gpio_get_value(USDHC2_WP_GPIO);
+
+	return ret;
+}
+
+int tq_bb_board_mmc_init(struct bd_info *bis)
+{
+	imx_iomux_v3_setup_multiple_pads(mba6_usdhc2_pads,
+					 ARRAY_SIZE(mba6_usdhc2_pads));
+	gpio_request(USDHC2_CD_GPIO, "usdhc2-cd");
+	gpio_request(USDHC2_WP_GPIO, "usdhc2-wp");
+	gpio_direction_input(USDHC2_CD_GPIO);
+	gpio_direction_input(USDHC2_WP_GPIO);
+
+	mba6_usdhc_cfg.sdhc_clk = mxc_get_clock(MXC_ESDHC2_CLK);
+	if (fsl_esdhc_initialize(bis, &mba6_usdhc_cfg))
+		puts("Warning: failed to initialize SD\n");
+
+	return 0;
+}
+
+/*
+ * called from C runtime startup code (arch/arm/lib/crt0.S:_main)
+ * - we have a stack and a place to store GD, both in SRAM
+ * - no variable global data is available
+ */
+void tq_bb_board_init_f(ulong dummy)
+{
+	mba6_setup_iomuxc_uart();
+
+	/* UART clocks enabled and gd valid - init serial console */
+	preloader_console_init();
+}
+
+/*
+ * This is done per baseboard to allow different implementations
+ */
+void board_boot_order(u32 *spl_boot_list)
+{
+	u32 bmode = imx6_src_get_boot_mode();
+	u8 imx6_bmode = (bmode & IMX6_BMODE_MASK) >> IMX6_BMODE_SHIFT;
+
+	/* USB boot */
+	if (spl_boot_device() == BOOT_DEVICE_BOARD) {
+		puts("USB\n");
+		spl_boot_list[0] = BOOT_DEVICE_BOARD;
+		return;
+	}
+
+	switch (imx6_bmode) {
+	case IMX6_BMODE_SD:
+	case IMX6_BMODE_ESD:
+		/* SD/eSD - BOOT_DEVICE_MMC2 */
+		puts("SD\n");
+		spl_boot_list[0] = BOOT_DEVICE_MMC2;
+		break;
+	case IMX6_BMODE_MMC:
+	case IMX6_BMODE_EMMC:
+		/* MMC/eMMC - BOOT_DEVICE_MMC1 */
+		puts("eMMC\n");
+		spl_boot_list[0] = BOOT_DEVICE_MMC1;
+		break;
+	case IMX6_BMODE_SERIAL_ROM:
+		/* SERIAL_ROM - BOOT_DEVICE_BOARD */
+		puts("Serial ROM\n");
+		spl_boot_list[0] = BOOT_DEVICE_BOARD;
+		switch ((imx6_bmode & IMX6_BMODE_SERIAL_ROM_MASK) >>
+			IMX6_BMODE_SERIAL_ROM_SHIFT) {
+		case IMX6_BMODE_ECSPI1:
+		case IMX6_BMODE_ECSPI2:
+		case IMX6_BMODE_ECSPI3:
+		case IMX6_BMODE_ECSPI4:
+		case IMX6_BMODE_ECSPI5:
+			spl_boot_list[0] = BOOT_DEVICE_SPI;
+			break;
+		default:
+			/* Default - BOOT_DEVICE_MMC1 */
+			puts("Wrong SPI device\n");
+			break;
+		}
+		break;
+	default:
+		/* Default - BOOT_DEVICE_MMC1 */
+		puts("Wrong board boot order\n");
+		spl_boot_list[0] = BOOT_DEVICE_MMC1;
+		break;
+	}
+}
+
+int board_fit_config_name_match(const char *name)
+{
+	const char *config = tqma6_get_fdt_configuration();
+
+	if (config && name && !strcmp(config, name)) {
+		printf("Device tree: %s\n", name);
+		return 0;
+	}
+
+	return -EINVAL;
+}
diff --git a/board/tq/tqma6/spl_tqma6.c b/board/tq/tqma6/spl_tqma6.c
new file mode 100644
index 00000000000..d7d448dc5b3
--- /dev/null
+++ b/board/tq/tqma6/spl_tqma6.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2014-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel, Max Merchel
+ */
+
+#include <fsl_esdhc_imx.h>
+#include <hang.h>
+#include <i2c.h>
+#include <init.h>
+#include <spl.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/crm_regs.h>
+#include <asm/arch/imx-regs.h>
+#include <asm/arch/iomux.h>
+#include <asm/arch/mx6-pins.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/iomux-v3.h>
+#include <asm/mach-imx/spi.h>
+#include <asm-generic/sections.h>
+
+#include "tqma6.h"
+#include "tqma6_emmc.h"
+#include "../common/tq_bb.h"
+#include "../common/tq_som.h"
+
+static void ccgr_init(void)
+{
+	struct mxc_ccm_reg *ccm = (struct mxc_ccm_reg *)CCM_BASE_ADDR;
+
+	/* set the default clock gate to save power */
+	writel(0x00C03F3F, &ccm->CCGR0);
+	writel(0x0030FC03, &ccm->CCGR1);
+	writel(0x0FFFC000, &ccm->CCGR2);
+	writel(0x3FF00000, &ccm->CCGR3);
+	writel(0x00FFF300, &ccm->CCGR4);
+	writel(0x0F0000C3, &ccm->CCGR5);
+	writel(0x000003FF, &ccm->CCGR6);
+}
+
+#define USDHC_CLK_PAD_CTRL (PAD_CTL_PUS_47K_UP  | PAD_CTL_SPEED_LOW | \
+	PAD_CTL_DSE_40ohm   | PAD_CTL_SRE_FAST  | PAD_CTL_HYS)
+
+#define USDHC_PAD_CTRL (PAD_CTL_PUS_47K_UP  | PAD_CTL_SPEED_LOW | \
+	PAD_CTL_DSE_80ohm   | PAD_CTL_SRE_FAST  | PAD_CTL_HYS)
+
+#define GPIO_OUT_PAD_CTRL  (PAD_CTL_PUS_100K_UP | PAD_CTL_SPEED_LOW | \
+	PAD_CTL_DSE_40ohm   | PAD_CTL_HYS)
+
+#define SPI_PAD_CTRL (PAD_CTL_PUS_100K_UP | PAD_CTL_SPEED_MED | \
+	PAD_CTL_DSE_80ohm | PAD_CTL_SRE_FAST | PAD_CTL_HYS)
+
+/* eMMC on USDHC3 always present */
+static const iomux_v3_cfg_t tqma6_usdhc3_pads[] = {
+	MX6_PAD_SD3_CLK__SD3_CLK |	MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_SD3_CMD__SD3_CMD |	MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_SD3_DAT0__SD3_DATA0 |	MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_SD3_DAT1__SD3_DATA1 |	MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_SD3_DAT2__SD3_DATA2 |	MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_SD3_DAT3__SD3_DATA3 |	MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_SD3_DAT4__SD3_DATA4 |	MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_SD3_DAT5__SD3_DATA5 |	MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_SD3_DAT6__SD3_DATA6 |	MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	MX6_PAD_SD3_DAT7__SD3_DATA7 |	MUX_PAD_CTRL(USDHC_PAD_CTRL),
+	/* eMMC reset */
+	MX6_PAD_SD3_RST__SD3_RESET |	MUX_PAD_CTRL(GPIO_OUT_PAD_CTRL),
+};
+
+/*
+ * According to board_mmc_init() the following map is done:
+ * (U-Boot device node)    (Physical Port)
+ * mmc0                    eMMC (SD3) on TQMa6
+ * mmc1 .. n               optional slots used on baseboard
+ */
+static struct fsl_esdhc_cfg tqma6_usdhc_cfg = {
+	.esdhc_base = USDHC3_BASE_ADDR,
+	.max_bus_width = 8,
+};
+
+int board_mmc_getcd(struct mmc *mmc)
+{
+	struct fsl_esdhc_cfg *cfg = (struct fsl_esdhc_cfg *)mmc->priv;
+	int ret = 0;
+
+	if (cfg->esdhc_base == USDHC3_BASE_ADDR)
+		/* eMMC/uSDHC3 is always present */
+		ret = 1;
+	else
+		ret = tq_bb_board_mmc_getcd(mmc);
+
+	return ret;
+}
+
+int board_mmc_getwp(struct mmc *mmc)
+{
+	struct fsl_esdhc_cfg *cfg = (struct fsl_esdhc_cfg *)mmc->priv;
+	int ret = 0;
+
+	if (cfg->esdhc_base == USDHC3_BASE_ADDR)
+		/* eMMC/uSDHC3 is never WP */
+		ret = 0;
+	else
+		ret = tq_bb_board_mmc_getwp(mmc);
+
+	return ret;
+}
+
+int board_mmc_init(struct bd_info *bis)
+{
+	imx_iomux_v3_setup_multiple_pads(tqma6_usdhc3_pads,
+					 ARRAY_SIZE(tqma6_usdhc3_pads));
+	tqma6_usdhc_cfg.sdhc_clk = mxc_get_clock(MXC_ESDHC3_CLK);
+	if (fsl_esdhc_initialize(bis, &tqma6_usdhc_cfg)) {
+		puts("Warning: failed to initialize eMMC dev\n");
+	} else {
+		struct mmc *mmc = find_mmc_device(0);
+
+		if (mmc)
+			mmc_set_dsr(mmc, TQMA6_EMMC_DSR);
+	}
+
+	tq_bb_board_mmc_init(bis);
+
+	return 0;
+}
+
+static const iomux_v3_cfg_t tqma6_ecspi1_pads[] = {
+	MX6_PAD_EIM_D16__ECSPI1_SCLK | MUX_PAD_CTRL(SPI_PAD_CTRL),
+	MX6_PAD_EIM_D17__ECSPI1_MISO | MUX_PAD_CTRL(SPI_PAD_CTRL),
+	MX6_PAD_EIM_D18__ECSPI1_MOSI | MUX_PAD_CTRL(SPI_PAD_CTRL),
+	/* SS1 */
+	MX6_PAD_EIM_D19__GPIO3_IO19 | (MUX_PAD_CTRL(SPI_PAD_CTRL) |
+		MUX_MODE_SION),
+};
+
+#define TQMA6_SF_CS_GPIO IMX_GPIO_NR(3, 19)
+
+void tqma6_iomuxc_spi(void)
+{
+	imx_iomux_v3_setup_multiple_pads(tqma6_ecspi1_pads,
+					 ARRAY_SIZE(tqma6_ecspi1_pads));
+
+	gpio_direction_output(TQMA6_SF_CS_GPIO, 1);
+}
+
+int board_spi_cs_gpio(unsigned int bus, unsigned int cs)
+{
+	return ((bus == CONFIG_SF_DEFAULT_BUS) &&
+		(cs == CONFIG_SF_DEFAULT_CS)) ? TQMA6_SF_CS_GPIO : -1;
+}
+
+/*
+ * called from C runtime startup code (arch/arm/lib/crt0.S:_main)
+ * - we have a stack and a place to store GD, both in SRAM
+ * - no variable global data is available
+ */
+void board_init_f(ulong dummy)
+{
+	/* setup clock gating */
+	ccgr_init();
+
+	/* setup AIPS and disable watchdog */
+	arch_cpu_init();
+
+	/* setup AXI */
+	gpr_init();
+
+	timer_init();
+
+	tqma6_iomuxc_spi();
+
+	/* iomux and setup of uart */
+	board_early_init_f();
+
+	/* DDR initialization */
+	tq_som_ram_init();
+}
+
diff --git a/board/tq/tqma6/spl_tqma6dl_ram.c b/board/tq/tqma6/spl_tqma6dl_ram.c
new file mode 100644
index 00000000000..e18ac733b47
--- /dev/null
+++ b/board/tq/tqma6/spl_tqma6dl_ram.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2016-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel, Max Merchel
+ */
+
+#include <config.h>
+#include <hang.h>
+#include <asm/arch/mx6-ddr.h>
+#include <asm/arch/mx6dl-ddr.h>
+#include <asm/arch/sys_proto.h>
+#include <linux/delay.h>
+
+#include "../common/tq_som.h"
+
+static void tqma6dl_init_ddr_controller(void)
+{
+	debug("SPL: tqma6dl ddr iom ....\n");
+	/* TQMa6DL DDR config Rev. 0300D */
+	/* IOMUX configuration */
+	tq_som_init_write_reg(MX6_IOM_GRP_DDR_TYPE, 0x000C0000);
+	tq_som_init_write_reg(MX6_IOM_GRP_DDRPKE, 0x00000000);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDCLK_0, 0x00008030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDCLK_1, 0x00008030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_CAS, 0x00008030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_RAS, 0x00008030);
+	tq_som_init_write_reg(MX6_IOM_GRP_ADDDS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_RESET, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDCKE0, 0x00003000);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDCKE1, 0x00000000);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDBA2, 0x00000000);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDODT0, 0x00003030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDODT1, 0x00003030);
+	tq_som_init_write_reg(MX6_IOM_GRP_CTLDS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DDRMODE_CTL, 0x00020000);
+
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDQS0, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDQS1, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDQS2, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDQS3, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDQS4, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDQS5, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDQS6, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDQS7, 0x00000030);
+
+	tq_som_init_write_reg(MX6_IOM_GRP_DDRMODE, 0x00020000);
+
+	tq_som_init_write_reg(MX6_IOM_GRP_B0DS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_GRP_B1DS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_GRP_B2DS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_GRP_B3DS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_GRP_B4DS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_GRP_B5DS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_GRP_B6DS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_GRP_B7DS, 0x00000030);
+
+	tq_som_init_write_reg(MX6_IOM_DRAM_DQM0, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_DQM1, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_DQM2, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_DQM3, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_DQM4, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_DQM5, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_DQM6, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_DQM7, 0x00000030);
+
+	debug("SPL: tqma6dl ddr calibration ....\n");
+	/* memory interface calibration values */
+	tq_som_init_write_reg(MX6_MMDC_P0_MPZQHWCTRL, 0xA1390003);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPZQHWCTRL, 0xA1390003);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPWLDECTRL0, 0x00440048);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPWLDECTRL1, 0x003D003F);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPWLDECTRL0, 0x0029002D);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPWLDECTRL1, 0x002B0043);
+
+	tq_som_init_write_reg(MX6_MMDC_P0_MPDGCTRL0, 0x424C0250);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPDGCTRL1, 0x02300234);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPDGCTRL0, 0x4234023C);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPDGCTRL1, 0x0224022C);
+
+	tq_som_init_write_reg(MX6_MMDC_P0_MPRDDLCTL, 0x48484C4C);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPRDDLCTL, 0x4C4E4E4C);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPWRDLCTL, 0x36382C36);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPWRDLCTL, 0x34343630);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPRDDQBY0DL, 0x33333333);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPRDDQBY1DL, 0x33333333);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPRDDQBY2DL, 0x33333333);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPRDDQBY3DL, 0x33333333);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPRDDQBY0DL, 0x33333333);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPRDDQBY1DL, 0x33333333);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPRDDQBY2DL, 0x33333333);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPRDDQBY3DL, 0x33333333);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPMUR0, 0x00000800);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPMUR0, 0x00000800);
+
+	debug("SPL: tqma6dl ddr config ....\n");
+	/* configure memory interface */
+	tq_som_init_write_reg(MX6_MMDC_P0_MDPDC, 0x0002002D);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDOTC, 0x00333030);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDCFG0, 0x3F435333);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDCFG1, 0xB68E8B63);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDCFG2, 0x01FF00DB);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDMISC, 0x00011740);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00008000);
+
+	debug("SPL: tqma6dl MX6_MMDC_P0_MDSCR %x ....\n", __raw_readl(MX6_MMDC_P0_MDSCR));
+
+	tq_som_init_write_reg(MX6_MMDC_P0_MDRWD, 0x000026D2);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDOR, 0x00431023);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDASP, 0x00000027);
+
+	debug("SPL: tqma6dl ddr mdctl - leave reset\n");
+	tq_som_init_write_reg(MX6_MMDC_P0_MDCTL, 0x831A0000);
+
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00408032);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00008033);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00048031);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x15208030);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x04008040);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDREF, 0x00007800);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPODTCTRL, 0x00022222);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPODTCTRL, 0x00022222);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDPDC, 0x0002552D);
+	tq_som_init_write_reg(MX6_MMDC_P0_MAPSR, 0x00001006);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00000000);
+
+	/* wait for auto-ZQ calibration to complete */
+	mdelay(1);
+	debug("SPL: tqma6dl ddr init done ...\n");
+}
+
+void tq_som_ram_init(void)
+{
+	if (!is_mx6dl()) {
+		printf("Not running on TQMa6DL\n");
+		hang();
+	}
+
+	tqma6dl_init_ddr_controller();
+
+	if (tq_som_ram_check_size(SZ_1G)) {
+		debug("SPL: TQMa6DL ddr init done ...\n");
+	} else {
+		pr_err("ERROR: Invalid DDR RAM size\n");
+		hang();
+	}
+}
diff --git a/board/tq/tqma6/spl_tqma6q_ram.c b/board/tq/tqma6/spl_tqma6q_ram.c
new file mode 100644
index 00000000000..0a48b5ff6ab
--- /dev/null
+++ b/board/tq/tqma6/spl_tqma6q_ram.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2016-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel, Max Merchel
+ */
+
+#include <config.h>
+#include <hang.h>
+#include <asm/arch/mx6-ddr.h>
+#include <asm/arch/mx6q-ddr.h>
+#include <asm/arch/sys_proto.h>
+#include <linux/delay.h>
+
+#include "../common/tq_som.h"
+
+static void tqma6q_init_ddr_controller(void)
+{
+	debug("SPL: tqma6q ddr iom ....\n");
+	/* TQMa6Q/D DDR config Rev. 0300D */
+	/* IOMUX configuration */
+	tq_som_init_write_reg(MX6_IOM_GRP_DDR_TYPE, 0x000C0000);
+	tq_som_init_write_reg(MX6_IOM_GRP_DDRPKE, 0x00000000);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDCLK_0, 0x00008030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDCLK_1, 0x00008030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_CAS, 0x00008030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_RAS, 0x00008030);
+	tq_som_init_write_reg(MX6_IOM_GRP_ADDDS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_RESET, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDCKE0, 0x00003000);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDCKE1, 0x00000000);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDBA2, 0x00000000);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDODT0, 0x00003030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDODT1, 0x00003030);
+	tq_som_init_write_reg(MX6_IOM_GRP_CTLDS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DDRMODE_CTL, 0x00020000);
+
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDQS0, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDQS1, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDQS2, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDQS3, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDQS4, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDQS5, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDQS6, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDQS7, 0x00000030);
+
+	tq_som_init_write_reg(MX6_IOM_GRP_DDRMODE, 0x00020000);
+
+	tq_som_init_write_reg(MX6_IOM_GRP_B0DS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_GRP_B1DS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_GRP_B2DS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_GRP_B3DS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_GRP_B4DS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_GRP_B5DS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_GRP_B6DS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_GRP_B7DS, 0x00000030);
+
+	tq_som_init_write_reg(MX6_IOM_DRAM_DQM0, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_DQM1, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_DQM2, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_DQM3, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_DQM4, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_DQM5, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_DQM6, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_DQM7, 0x00000030);
+
+	debug("SPL: tqma6q ddr calibration ....\n");
+	/* memory interface calibration values */
+	tq_som_init_write_reg(MX6_MMDC_P0_MPZQHWCTRL, 0xA1390003);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPZQHWCTRL, 0xA1390003);
+
+	tq_som_init_write_reg(MX6_MMDC_P0_MPWLDECTRL0, 0x00180016);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPWLDECTRL1, 0x001F0018);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPWLDECTRL0, 0x00130023);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPWLDECTRL1, 0x00040018);
+
+	tq_som_init_write_reg(MX6_MMDC_P0_MPDGCTRL0, 0x43500364);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPDGCTRL1, 0x034C0344);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPDGCTRL0, 0x43580364);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPDGCTRL1, 0x033C031C);
+
+	tq_som_init_write_reg(MX6_MMDC_P0_MPRDDLCTL, 0x3C323438);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPRDDLCTL, 0x383A3040);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPWRDLCTL, 0x3A3E4440);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPWRDLCTL, 0x4834483A);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPRDDQBY0DL, 0x33333333);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPRDDQBY1DL, 0x33333333);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPRDDQBY2DL, 0x33333333);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPRDDQBY3DL, 0x33333333);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPRDDQBY0DL, 0x33333333);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPRDDQBY1DL, 0x33333333);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPRDDQBY2DL, 0x33333333);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPRDDQBY3DL, 0x33333333);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPMUR0, 0x00000800);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPMUR0, 0x00000800);
+
+	debug("SPL: tqma6q ddr config ....\n");
+	/* configure memory interface */
+	tq_som_init_write_reg(MX6_MMDC_P0_MDPDC, 0x00020036);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDOTC, 0x09444040);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDCFG0, 0x545A79B4);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDCFG1, 0xDB538F64);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDCFG2, 0x01FF00DB);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDMISC, 0x00011740);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00008000);
+
+	debug("SPL: tqma6q MX6_MMDC_P0_MDSCR %x ....\n", __raw_readl(MX6_MMDC_P0_MDSCR));
+
+	tq_som_init_write_reg(MX6_MMDC_P0_MDRWD, 0x000026D2);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDOR, 0x005A1023);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDASP, 0x00000027);
+
+	debug("SPL: tqma6q ddr mdctl - leave reset\n");
+	tq_som_init_write_reg(MX6_MMDC_P0_MDCTL, 0x831A0000);
+
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00488032);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00008033);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00048031);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x19308030);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x04008040);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDREF, 0x00007800);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPODTCTRL, 0x00022222);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPODTCTRL, 0x00022222);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDPDC, 0x00025536);
+	tq_som_init_write_reg(MX6_MMDC_P0_MAPSR, 0x00001006);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00000000);
+
+	/* wait for auto-ZQ calibration to complete */
+	mdelay(1);
+	debug("SPL: tqma6q ddr init done ...\n");
+}
+
+void tq_som_ram_init(void)
+{
+	if (!is_mx6dq()) {
+		printf("Not running on TQMa6D/Q\n");
+		hang();
+	}
+
+	tqma6q_init_ddr_controller();
+
+	if (tq_som_ram_check_size(SZ_1G)) {
+		debug("SPL: TQMa6D/Q ddr init done ...\n");
+	} else {
+		pr_err("ERROR: Invalid DDR RAM size\n");
+		hang();
+	}
+}
diff --git a/board/tq/tqma6/spl_tqma6s_ram.c b/board/tq/tqma6/spl_tqma6s_ram.c
new file mode 100644
index 00000000000..e76a7815f70
--- /dev/null
+++ b/board/tq/tqma6/spl_tqma6s_ram.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2016-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel, Max Merchel
+ */
+
+#include <config.h>
+#include <hang.h>
+#include <asm/arch/mx6-ddr.h>
+#include <asm/arch/mx6dl-ddr.h>
+#include <asm/arch/sys_proto.h>
+#include <linux/delay.h>
+
+#include "../common/tq_som.h"
+
+static void tqma6s_init_ddr_controller(void)
+{
+	debug("SPL: tqma6s ddr iom ....\n");
+	/* TQMa6S DDR config Rev. 0300D */
+	/* IOMUX configuration */
+	tq_som_init_write_reg(MX6_IOM_GRP_DDR_TYPE, 0x000C0000);
+	tq_som_init_write_reg(MX6_IOM_GRP_DDRPKE, 0x00000000);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDCLK_0, 0x00008000);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDCLK_1, 0x00008030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_CAS, 0x00008030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_RAS, 0x00008030);
+	tq_som_init_write_reg(MX6_IOM_GRP_ADDDS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_RESET, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDCKE0, 0x00003000);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDCKE1, 0x00000000);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDBA2, 0x00000000);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDODT0, 0x00003030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDODT1, 0x00003030);
+	tq_som_init_write_reg(MX6_IOM_GRP_CTLDS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DDRMODE_CTL, 0x00020000);
+
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDQS0, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDQS1, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDQS2, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDQS3, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDQS4, 0x00000000);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDQS5, 0x00000000);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDQS6, 0x00000000);
+	tq_som_init_write_reg(MX6_IOM_DRAM_SDQS7, 0x00000000);
+
+	tq_som_init_write_reg(MX6_IOM_GRP_DDRMODE, 0x00020000);
+
+	tq_som_init_write_reg(MX6_IOM_GRP_B0DS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_GRP_B1DS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_GRP_B2DS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_GRP_B3DS, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_GRP_B4DS, 0x00000000);
+	tq_som_init_write_reg(MX6_IOM_GRP_B5DS, 0x00000000);
+	tq_som_init_write_reg(MX6_IOM_GRP_B6DS, 0x00000000);
+	tq_som_init_write_reg(MX6_IOM_GRP_B7DS, 0x00000000);
+
+	tq_som_init_write_reg(MX6_IOM_DRAM_DQM0, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_DQM1, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_DQM2, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_DQM3, 0x00000030);
+	tq_som_init_write_reg(MX6_IOM_DRAM_DQM4, 0x00000000);
+	tq_som_init_write_reg(MX6_IOM_DRAM_DQM5, 0x00000000);
+	tq_som_init_write_reg(MX6_IOM_DRAM_DQM6, 0x00000000);
+	tq_som_init_write_reg(MX6_IOM_DRAM_DQM7, 0x00000000);
+
+	debug("SPL: tqma6s ddr calibration ....\n");
+	/* memory interface calibration values */
+	tq_som_init_write_reg(MX6_MMDC_P0_MPZQHWCTRL, 0xA1390003);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPZQHWCTRL, 0xA1380000);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPWLDECTRL0, 0x004C004A);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPWLDECTRL1, 0x003F0048);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPWLDECTRL0, 0x00000000);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPWLDECTRL1, 0x00000000);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPDGCTRL0, 0x42440240);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPDGCTRL1, 0x022C022C);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPDGCTRL0, 0x00000000);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPDGCTRL1, 0x00000000);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPRDDLCTL, 0x484A504C);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPRDDLCTL, 0x00000000);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPWRDLCTL, 0x34322832);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPWRDLCTL, 0x00000000);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPRDDQBY0DL, 0x33333333);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPRDDQBY1DL, 0x33333333);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPRDDQBY2DL, 0x33333333);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPRDDQBY3DL, 0x33333333);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPRDDQBY0DL, 0x00000000);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPRDDQBY1DL, 0x00000000);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPRDDQBY2DL, 0x00000000);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPRDDQBY3DL, 0x00000000);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPMUR0, 0x00000800);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPMUR0, 0x00000000);
+
+	debug("SPL: tqma6s ddr config ....\n");
+	/* configure memory interface */
+	tq_som_init_write_reg(MX6_MMDC_P0_MDPDC, 0x0002002D);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDOTC, 0x00333030);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDCFG0, 0x3F435333);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDCFG1, 0xB68E8B63);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDCFG2, 0x01FF00DB);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDMISC, 0x00011740);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00008000);
+
+	debug("SPL: tqma6s MX6_MMDC_P0_MDSCR %x ....\n", __raw_readl(MX6_MMDC_P0_MDSCR));
+
+	tq_som_init_write_reg(MX6_MMDC_P0_MDRWD, 0x000026D2);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDOR, 0x00431023);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDASP, 0x00000017);
+
+	debug("SPL: tqma6s ddr mdctl - leave reset\n");
+	tq_som_init_write_reg(MX6_MMDC_P0_MDCTL, 0x83190000);
+
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00408032);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00008033);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00048031);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x15208030);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x04008040);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDREF, 0x00007800);
+	tq_som_init_write_reg(MX6_MMDC_P0_MPODTCTRL, 0x00022222);
+	tq_som_init_write_reg(MX6_MMDC_P1_MPODTCTRL, 0x00000000);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDPDC, 0x0002552D);
+	tq_som_init_write_reg(MX6_MMDC_P0_MAPSR, 0x00001006);
+	tq_som_init_write_reg(MX6_MMDC_P0_MDSCR, 0x00000000);
+
+	/* wait for auto-ZQ calibration to complete */
+	mdelay(1);
+	debug("SPL: tqma6s ddr init done ...\n");
+}
+
+void tq_som_ram_init(void)
+{
+	if (!is_mx6solo()) {
+		printf("Not running on TQMa6S\n");
+		hang();
+	}
+
+	tqma6s_init_ddr_controller();
+
+	if (tq_som_ram_check_size(SZ_512M)) {
+		debug("SPL: TQMa6S ddr init done ...\n");
+	} else {
+		pr_err("ERROR: Invalid DDR RAM size\n");
+		hang();
+	}
+}
diff --git a/board/tq/tqma6/tqma6.c b/board/tq/tqma6/tqma6.c
index f4cd9915185..f0f2ddfe48a 100644
--- a/board/tq/tqma6/tqma6.c
+++ b/board/tq/tqma6/tqma6.c
@@ -9,28 +9,18 @@
  * Author: Markus Niebel
  */
 
-#include <init.h>
-#include <asm/arch/clock.h>
-#include <asm/arch/mx6-pins.h>
-#include <asm/arch/imx-regs.h>
-#include <asm/arch/iomux.h>
-#include <asm/arch/sys_proto.h>
 #include <env.h>
 #include <fdt_support.h>
-#include <asm/global_data.h>
-#include <linux/errno.h>
-#include <asm/gpio.h>
-#include <asm/io.h>
-#include <linux/libfdt.h>
 #include <mmc.h>
 #include <power/pfuze100_pmic.h>
 #include <power/pmic.h>
 
+#include <asm/arch/mx6-pins.h>
+#include <asm/arch/sys_proto.h>
+
 #include "tqma6_emmc.h"
 #include "../common/tq_bb.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 /*
  * Rev. 0200 and newer optionally implements GIGE errata fix.
  * Use a global var to signal presence of the fix. This should be checked
@@ -43,13 +33,6 @@ int tqma6_has_enet_workaround(void)
 	return has_enet_workaround;
 }
 
-int dram_init(void)
-{
-	gd->ram_size = imx_ddr_size();
-
-	return 0;
-}
-
 #define GPIO_REVDET_PAD_CTRL  (PAD_CTL_PUS_100K_DOWN | PAD_CTL_SPEED_LOW | \
 			       PAD_CTL_DSE_40ohm | PAD_CTL_HYS)
 
@@ -57,32 +40,83 @@ static const iomux_v3_cfg_t tqma6_revdet_pads[] = {
 	MX6_PAD_GPIO_6__GPIO1_IO06 | MUX_PAD_CTRL(GPIO_REVDET_PAD_CTRL),
 };
 
+#define TQMA6_REVDET_GPIO IMX_GPIO_NR(1, 6)
+
 void tqma6_detect_enet_workaround(void)
 {
 	int ret;
-	struct gpio_desc desc;
 
 	imx_iomux_v3_setup_multiple_pads(tqma6_revdet_pads,
 					 ARRAY_SIZE(tqma6_revdet_pads));
 
-	ret = dm_gpio_lookup_name("GPIO1_6", &desc);
-	if (ret) {
-		pr_err("error: gpio lookup for enet workaround %d\n", ret);
-		return;
+	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
+		ret = gpio_request(TQMA6_REVDET_GPIO, "tqma6-revdet");
+		if (ret) {
+			pr_err("error: gpio request for enet workaround %d\n", ret);
+			return;
+		}
+
+		if (gpio_get_value(TQMA6_REVDET_GPIO) == 0)
+			has_enet_workaround = 1;
+		else if (gpio_get_value(TQMA6_REVDET_GPIO) > 0)
+			has_enet_workaround = 0;
+
+		gpio_free(TQMA6_REVDET_GPIO);
+	} else {
+		struct gpio_desc desc;
+
+		ret = dm_gpio_lookup_name("GPIO1_6", &desc);
+		if (ret) {
+			pr_err("error: gpio lookup for enet workaround %d\n", ret);
+			return;
+		}
+
+		ret = dm_gpio_request(&desc, "tqma6-revdet");
+		if (ret) {
+			if (ret == -EBUSY)
+				has_enet_workaround = 0;
+			else
+				pr_err("error: gpio request for enet workaround %d\n", ret);
+
+			return;
+		}
+
+		ret = dm_gpio_get_value(&desc);
+		if (ret == 0)
+			has_enet_workaround = 1;
+		else if (ret > 0)
+			has_enet_workaround = 0;
+
+		dm_gpio_free(NULL, &desc);
 	}
+}
 
-	ret = dm_gpio_get_value(&desc);
-	if (ret == 0)
-		has_enet_workaround = 1;
-	else if (ret > 0)
-		has_enet_workaround = 0;
+const char *tqma6_get_fdt_configuration(void)
+{
+	tqma6_detect_enet_workaround();
 
-	dm_gpio_free(NULL, &desc);
+	if (is_mx6dq())
+		return !tqma6_has_enet_workaround() ? "imx6q-mba6b" : "imx6q-mba6a";
+	if (is_mx6sdl())
+		return !tqma6_has_enet_workaround() ? "imx6dl-mba6b" : "imx6dl-mba6a";
+
+	return NULL;
 }
 
 int board_early_init_f(void)
 {
-	return tq_bb_board_early_init_f();
+	tq_bb_board_early_init_f();
+
+	return 0;
+}
+
+#if !IS_ENABLED(CONFIG_SPL_BUILD)
+
+int dram_init(void)
+{
+	gd->ram_size = imx_ddr_size();
+
+	return 0;
 }
 
 int board_init(void)
@@ -117,16 +151,6 @@ static const char *tqma6_get_boardname(void)
 	};
 }
 
-const char *tqma6_get_fdt_configuration(void)
-{
-	if (is_mx6dq())
-		return !tqma6_has_enet_workaround() ? "imx6q-mba6b" : "imx6q-mba6a";
-	if (is_mx6sdl())
-		return !tqma6_has_enet_workaround() ? "imx6dl-mba6b" : "imx6dl-mba6a";
-
-	return NULL;
-}
-
 #if CONFIG_IS_ENABLED(DM_PMIC)
 /* setup board specific PMIC */
 int power_init_board(void)
@@ -146,7 +170,6 @@ int power_init_board(void)
 	return 0;
 }
 #endif
-
 #define FDTFILE_STRLEN 32u
 int board_late_init(void)
 {
@@ -155,8 +178,6 @@ int board_late_init(void)
 
 	env_set("board_name", tqma6_get_boardname());
 
-	tqma6_detect_enet_workaround();
-
 	if (!env_get("fdtfile")) {
 		if (config) {
 			snprintf(fdtfile, FDTFILE_STRLEN, "%s.dtb", config);
@@ -191,7 +212,7 @@ int board_late_init(void)
 /*
  * Device Tree Support
  */
-#if defined(CONFIG_OF_BOARD_SETUP) && defined(CONFIG_OF_LIBFDT)
+#if IS_ENABLED(CONFIG_OF_BOARD_SETUP) && IS_ENABLED(CONFIG_OF_LIBFDT)
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
 	struct mmc *mmc = find_mmc_device(0);
@@ -211,4 +232,6 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 
 	return 0;
 }
-#endif /* defined(CONFIG_OF_BOARD_SETUP) && defined(CONFIG_OF_LIBFDT) */
+#endif /* IS_ENABLED(CONFIG_OF_BOARD_SETUP) && IS_ENABLED(CONFIG_OF_LIBFDT) */
+
+#endif /* !IS_ENABLED(CONFIG_SPL_BUILD) */
diff --git a/board/tq/tqma6/tqma6.cfg b/board/tq/tqma6/tqma6.cfg
new file mode 100644
index 00000000000..3395433dc09
--- /dev/null
+++ b/board/tq/tqma6/tqma6.cfg
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2016-2025 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
+ *
+ * ##########################################################################
+ *
+ * Refer doc/imx/mkimage/imximage.txt for more details about how-to configure
+ * and create imximage boot image
+ *
+ * The syntax is taken as close as possible with the kwbimage
+ */
+
+/* image version */
+IMAGE_VERSION 2
+
+#include <config.h>
+
+/*
+ * Boot Device : one of
+ * spi, sd (the board has no nand neither onenand)
+ */
+#if defined(CONFIG_TQMA6X_MMC_BOOT)
+BOOT_FROM      sd
+#elif defined(CONFIG_TQMA6X_SPI_BOOT)
+BOOT_FROM      spi
+#else
+#error
+#endif
diff --git a/board/tq/tqma6/tqma6.h b/board/tq/tqma6/tqma6.h
index bc09087e3df..43d38e48e7d 100644
--- a/board/tq/tqma6/tqma6.h
+++ b/board/tq/tqma6/tqma6.h
@@ -8,6 +8,10 @@
 #ifndef __TQMA6_H
 #define __TQMA6_H
 
+#include <linux/types.h>
+
+extern const u16 tqma6_emmc_dsr;
+
 const char *tqma6_get_fdt_configuration(void);
 int tqma6_has_enet_workaround(void);
 
diff --git a/board/tq/tqma6/tqma6_mba6.c b/board/tq/tqma6/tqma6_mba6.c
index 8cc5857b06f..45fef41d61d 100644
--- a/board/tq/tqma6/tqma6_mba6.c
+++ b/board/tq/tqma6/tqma6_mba6.c
@@ -9,30 +9,17 @@
  * Author: Markus Niebel
  */
 
-#include <init.h>
-#include <net.h>
-#include <asm/io.h>
-#include <asm/arch/clock.h>
+#include <env.h>
+#include <spl.h>
+
 #include <asm/arch/mx6-pins.h>
-#include <asm/arch/imx-regs.h>
-#include <asm/arch/iomux.h>
 #include <asm/arch/sys_proto.h>
-#include <linux/delay.h>
-#include <linux/errno.h>
-#include <asm/gpio.h>
-#include <asm/mach-imx/mxc_i2c.h>
-
-#include <fsl_esdhc_imx.h>
-#include <linux/libfdt.h>
-#include <malloc.h>
-#include <i2c.h>
-#include <micrel.h>
-#include <miiphy.h>
-#include <mmc.h>
-#include <netdev.h>
 
 #include "../common/tq_bb.h"
 
+#define UART_PAD_CTRL (PAD_CTL_PUS_100K_UP | PAD_CTL_SPEED_MED | \
+	PAD_CTL_DSE_80ohm   | PAD_CTL_SRE_FAST  | PAD_CTL_HYS)
+
 #define TQMA6Q_IOMUX_SW_PAD_CTRL_GRP_DDR_TYPE_RGMII	0x02e0790
 #define TQMA6Q_IOMUX_SW_PAD_CTRL_GRP_RGMII_TERM		0x02e07ac
 
@@ -46,6 +33,30 @@
 /* optimised drive strength for 1.3 .. 2.5 V signal on RGMII */
 #define IOMUX_SW_PAD_CTRL_GRP_DDR_TYPE_RGMII_1P5V	0x000C0000
 
+static const iomux_v3_cfg_t mba6_uart2_pads[] = {
+	MX6_PAD_SD4_DAT4__UART2_RX_DATA | MUX_PAD_CTRL(UART_PAD_CTRL),
+	MX6_PAD_SD4_DAT7__UART2_TX_DATA | MUX_PAD_CTRL(UART_PAD_CTRL),
+};
+
+static void mba6_setup_iomuxc_uart(void)
+{
+	imx_iomux_v3_setup_multiple_pads(mba6_uart2_pads,
+					 ARRAY_SIZE(mba6_uart2_pads));
+}
+
+int tq_bb_board_early_init_f(void)
+{
+	/* iomux and setup of uart */
+	mba6_setup_iomuxc_uart();
+
+	if (IS_ENABLED(CONFIG_SPL_BUILD))
+		preloader_console_init();
+
+	return 0;
+}
+
+#if !IS_ENABLED(CONFIG_SPL_BUILD)
+
 static void mba6_setup_iomuxc_enet(void)
 {
 	struct iomuxc *const iomuxc_regs = (struct iomuxc *)IOMUXC_BASE_ADDR;
@@ -76,53 +87,6 @@ int board_mmc_get_env_dev(int devno)
 	return (devno == 2) ? 0 : 1;
 }
 
-int board_phy_config(struct phy_device *phydev)
-{
-/*
- * optimized pad skew values depends on CPU variant on the TQMa6x module:
- * CONFIG_TQMA6Q: i.MX6Q/D
- * CONFIG_TQMA6S: i.MX6S
- * CONFIG_TQMA6DL: i.MX6DL
- */
-#if defined(CONFIG_TQMA6Q)
-#define MBA6X_KSZ9031_CTRL_SKEW	0x0032
-#define MBA6X_KSZ9031_CLK_SKEW	0x03ff
-#define MBA6X_KSZ9031_RX_SKEW	0x3333
-#define MBA6X_KSZ9031_TX_SKEW	0x2036
-#elif defined(CONFIG_TQMA6S) || defined(CONFIG_TQMA6DL)
-#define MBA6X_KSZ9031_CTRL_SKEW	0x0030
-#define MBA6X_KSZ9031_CLK_SKEW	0x03ff
-#define MBA6X_KSZ9031_RX_SKEW	0x3333
-#define MBA6X_KSZ9031_TX_SKEW	0x2052
-#else
-#error
-#endif
-	/* min rx/tx ctrl delay */
-	ksz9031_phy_extended_write(phydev, 2,
-				   MII_KSZ9031_EXT_RGMII_CTRL_SIG_SKEW,
-				   MII_KSZ9031_MOD_DATA_NO_POST_INC,
-				   MBA6X_KSZ9031_CTRL_SKEW);
-	/* min rx delay */
-	ksz9031_phy_extended_write(phydev, 2,
-				   MII_KSZ9031_EXT_RGMII_RX_DATA_SKEW,
-				   MII_KSZ9031_MOD_DATA_NO_POST_INC,
-				   MBA6X_KSZ9031_RX_SKEW);
-	/* max tx delay */
-	ksz9031_phy_extended_write(phydev, 2,
-				   MII_KSZ9031_EXT_RGMII_TX_DATA_SKEW,
-				   MII_KSZ9031_MOD_DATA_NO_POST_INC,
-				   MBA6X_KSZ9031_TX_SKEW);
-	/* rx/tx clk skew */
-	ksz9031_phy_extended_write(phydev, 2,
-				   MII_KSZ9031_EXT_RGMII_CLOCK_SKEW,
-				   MII_KSZ9031_MOD_DATA_NO_POST_INC,
-				   MBA6X_KSZ9031_CLK_SKEW);
-
-	phydev->drv->config(phydev);
-
-	return 0;
-}
-
 int tq_bb_board_init(void)
 {
 	mba6_setup_iomuxc_enet();
@@ -140,3 +104,5 @@ int tq_bb_board_late_init(void)
 	board_late_mmc_env_init();
 	return 0;
 }
+
+#endif /* !IS_ENABLED(CONFIG_SPL_BUILD) */
diff --git a/board/tq/tqma6/tqma6dl.cfg b/board/tq/tqma6/tqma6dl.cfg
deleted file mode 100644
index 17a3d010517..00000000000
--- a/board/tq/tqma6/tqma6dl.cfg
+++ /dev/null
@@ -1,125 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (c) 2014-2015 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
- * D-82229 Seefeld, Germany.
- * Author: Markus Niebel
- *
- * Refer doc/imx/mkimage/imximage.txt for more details about how-to configure
- * and create imximage boot image
- *
- * The syntax is taken as close as possible with the kwbimage
- */
-
-/* image version */
-IMAGE_VERSION 2
-
-#include <config.h>
-
-/*
- * Boot Device : one of
- * spi, sd (the board has no nand neither onenand)
- */
-#if defined(CONFIG_TQMA6X_MMC_BOOT)
-BOOT_FROM      sd
-#elif defined(CONFIG_TQMA6X_SPI_BOOT)
-BOOT_FROM      spi
-#endif
-
-#include "asm/arch/mx6-ddr.h"
-#include "asm/arch/iomux.h"
-#include "asm/arch/crm_regs.h"
-
-/* TQMa6DL DDR config Rev. 0300D */
-/* IOMUX configuration */
-DATA 4, MX6_IOM_GRP_DDR_TYPE, 0x000C0000
-DATA 4, MX6_IOM_GRP_DDRPKE, 0x00000000
-DATA 4, MX6_IOM_DRAM_SDCLK_0, 0x00008030
-DATA 4, MX6_IOM_DRAM_SDCLK_1, 0x00008030
-DATA 4, MX6_IOM_DRAM_CAS, 0x00008030
-DATA 4, MX6_IOM_DRAM_RAS, 0x00008030
-DATA 4, MX6_IOM_GRP_ADDDS, 0x00000030
-DATA 4, MX6_IOM_DRAM_RESET, 0x00000030
-DATA 4, MX6_IOM_DRAM_SDCKE0, 0x00003000
-DATA 4, MX6_IOM_DRAM_SDCKE1, 0x00000000
-DATA 4, MX6_IOM_DRAM_SDBA2, 0x00000000
-DATA 4, MX6_IOM_DRAM_SDODT0, 0x00003030
-DATA 4, MX6_IOM_DRAM_SDODT1, 0x00003030
-DATA 4, MX6_IOM_GRP_CTLDS, 0x00000030
-DATA 4, MX6_IOM_DDRMODE_CTL, 0x00020000
-DATA 4, MX6_IOM_DRAM_SDQS0, 0x00000030
-DATA 4, MX6_IOM_DRAM_SDQS1, 0x00000030
-DATA 4, MX6_IOM_DRAM_SDQS2, 0x00000030
-DATA 4, MX6_IOM_DRAM_SDQS3, 0x00000030
-DATA 4, MX6_IOM_DRAM_SDQS4, 0x00000030
-DATA 4, MX6_IOM_DRAM_SDQS5, 0x00000030
-DATA 4, MX6_IOM_DRAM_SDQS6, 0x00000030
-DATA 4, MX6_IOM_DRAM_SDQS7, 0x00000030
-DATA 4, MX6_IOM_GRP_DDRMODE, 0x00020000
-DATA 4, MX6_IOM_GRP_B0DS, 0x00000030
-DATA 4, MX6_IOM_GRP_B1DS, 0x00000030
-DATA 4, MX6_IOM_GRP_B2DS, 0x00000030
-DATA 4, MX6_IOM_GRP_B3DS, 0x00000030
-DATA 4, MX6_IOM_GRP_B4DS, 0x00000030
-DATA 4, MX6_IOM_GRP_B5DS, 0x00000030
-DATA 4, MX6_IOM_GRP_B6DS, 0x00000030
-DATA 4, MX6_IOM_GRP_B7DS, 0x00000030
-DATA 4, MX6_IOM_DRAM_DQM0, 0x00000030
-DATA 4, MX6_IOM_DRAM_DQM1, 0x00000030
-DATA 4, MX6_IOM_DRAM_DQM2, 0x00000030
-DATA 4, MX6_IOM_DRAM_DQM3, 0x00000030
-DATA 4, MX6_IOM_DRAM_DQM4, 0x00000030
-DATA 4, MX6_IOM_DRAM_DQM5, 0x00000030
-DATA 4, MX6_IOM_DRAM_DQM6, 0x00000030
-DATA 4, MX6_IOM_DRAM_DQM7, 0x00000030
-
-/* memory interface calibration values */
-DATA 4, MX6_MMDC_P0_MPZQHWCTRL, 0xA1390003
-DATA 4, MX6_MMDC_P1_MPZQHWCTRL, 0xA1390003
-DATA 4, MX6_MMDC_P0_MPWLDECTRL0, 0x00440048
-DATA 4, MX6_MMDC_P0_MPWLDECTRL1, 0x003D003F
-DATA 4, MX6_MMDC_P1_MPWLDECTRL0, 0x0029002D
-DATA 4, MX6_MMDC_P1_MPWLDECTRL1, 0x002B0043
-DATA 4, MX6_MMDC_P0_MPDGCTRL0, 0x424C0250
-DATA 4, MX6_MMDC_P0_MPDGCTRL1, 0x02300234
-DATA 4, MX6_MMDC_P1_MPDGCTRL0, 0x4234023C
-DATA 4, MX6_MMDC_P1_MPDGCTRL1, 0x0224022C
-DATA 4, MX6_MMDC_P0_MPRDDLCTL, 0x48484C4C
-DATA 4, MX6_MMDC_P1_MPRDDLCTL, 0x4C4E4E4C
-DATA 4, MX6_MMDC_P0_MPWRDLCTL, 0x36382C36
-DATA 4, MX6_MMDC_P1_MPWRDLCTL, 0x34343630
-DATA 4, MX6_MMDC_P0_MPRDDQBY0DL, 0x33333333
-DATA 4, MX6_MMDC_P0_MPRDDQBY1DL, 0x33333333
-DATA 4, MX6_MMDC_P0_MPRDDQBY2DL, 0x33333333
-DATA 4, MX6_MMDC_P0_MPRDDQBY3DL, 0x33333333
-DATA 4, MX6_MMDC_P1_MPRDDQBY0DL, 0x33333333
-DATA 4, MX6_MMDC_P1_MPRDDQBY1DL, 0x33333333
-DATA 4, MX6_MMDC_P1_MPRDDQBY2DL, 0x33333333
-DATA 4, MX6_MMDC_P1_MPRDDQBY3DL, 0x33333333
-DATA 4, MX6_MMDC_P0_MPMUR0, 0x00000800
-DATA 4, MX6_MMDC_P1_MPMUR0, 0x00000800
-
-/* configure memory interface */
-DATA 4, MX6_MMDC_P0_MDPDC, 0x0002002D
-DATA 4, MX6_MMDC_P0_MDOTC, 0x00333030
-DATA 4, MX6_MMDC_P0_MDCFG0, 0x3F435333
-DATA 4, MX6_MMDC_P0_MDCFG1, 0xB68E8B63
-DATA 4, MX6_MMDC_P0_MDCFG2, 0x01FF00DB
-DATA 4, MX6_MMDC_P0_MDMISC, 0x00011740
-DATA 4, MX6_MMDC_P0_MDSCR, 0x00008000
-DATA 4, MX6_MMDC_P0_MDRWD, 0x000026D2
-DATA 4, MX6_MMDC_P0_MDOR, 0x00431023
-DATA 4, MX6_MMDC_P0_MDASP, 0x00000027
-DATA 4, MX6_MMDC_P0_MDCTL, 0x831A0000
-DATA 4, MX6_MMDC_P0_MDSCR, 0x00408032
-DATA 4, MX6_MMDC_P0_MDSCR, 0x00008033
-DATA 4, MX6_MMDC_P0_MDSCR, 0x00048031
-DATA 4, MX6_MMDC_P0_MDSCR, 0x15208030
-DATA 4, MX6_MMDC_P0_MDSCR, 0x04008040
-DATA 4, MX6_MMDC_P0_MDREF, 0x00007800
-DATA 4, MX6_MMDC_P0_MPODTCTRL, 0x00022222
-DATA 4, MX6_MMDC_P1_MPODTCTRL, 0x00022222
-DATA 4, MX6_MMDC_P0_MDPDC, 0x0002552D
-DATA 4, MX6_MMDC_P0_MAPSR, 0x00001006
-DATA 4, MX6_MMDC_P0_MDSCR, 0x00000000
-
-#include "clocks.cfg"
diff --git a/board/tq/tqma6/tqma6q.cfg b/board/tq/tqma6/tqma6q.cfg
deleted file mode 100644
index 673482b543c..00000000000
--- a/board/tq/tqma6/tqma6q.cfg
+++ /dev/null
@@ -1,126 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (c) 2013-2014 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
- * D-82229 Seefeld, Germany.
- * Author: Markus Niebel
- *
- * Refer doc/imx/mkimage/imximage.txt for more details about how-to configure
- * and create imximage boot image
- *
- * The syntax is taken as close as possible with the kwbimage
- */
-
-/* image version */
-IMAGE_VERSION 2
-
-#include <config.h>
-
-/*
- * Boot Device : one of
- * spi, sd (the board has no nand neither onenand)
- */
-#if defined(CONFIG_TQMA6X_MMC_BOOT)
-BOOT_FROM      sd
-#elif defined(CONFIG_TQMA6X_SPI_BOOT)
-BOOT_FROM      spi
-#endif
-
-#include "asm/arch/mx6-ddr.h"
-#include "asm/arch/iomux.h"
-#include "asm/arch/crm_regs.h"
-
-/* TQMa6Q/D DDR config Rev. 0300D */
-/* IOMUX configuration */
-DATA 4, MX6_IOM_GRP_DDR_TYPE, 0x000C0000
-DATA 4, MX6_IOM_GRP_DDRPKE, 0x00000000
-DATA 4, MX6_IOM_DRAM_SDCLK_0, 0x00008030
-DATA 4, MX6_IOM_DRAM_SDCLK_1, 0x00008030
-DATA 4, MX6_IOM_DRAM_CAS, 0x00008030
-DATA 4, MX6_IOM_DRAM_RAS, 0x00008030
-DATA 4, MX6_IOM_GRP_ADDDS, 0x00000030
-DATA 4, MX6_IOM_DRAM_RESET, 0x00000030
-DATA 4, MX6_IOM_DRAM_SDCKE0, 0x00003000
-DATA 4, MX6_IOM_DRAM_SDCKE1, 0x00000000
-DATA 4, MX6_IOM_DRAM_SDBA2, 0x00000000
-DATA 4, MX6_IOM_DRAM_SDODT0, 0x00003030
-DATA 4, MX6_IOM_DRAM_SDODT1, 0x00003030
-DATA 4, MX6_IOM_GRP_CTLDS, 0x00000030
-DATA 4, MX6_IOM_DDRMODE_CTL, 0x00020000
-DATA 4, MX6_IOM_DRAM_SDQS0, 0x00000030
-DATA 4, MX6_IOM_DRAM_SDQS1, 0x00000030
-DATA 4, MX6_IOM_DRAM_SDQS2, 0x00000030
-DATA 4, MX6_IOM_DRAM_SDQS3, 0x00000030
-DATA 4, MX6_IOM_DRAM_SDQS4, 0x00000030
-DATA 4, MX6_IOM_DRAM_SDQS5, 0x00000030
-DATA 4, MX6_IOM_DRAM_SDQS6, 0x00000030
-DATA 4, MX6_IOM_DRAM_SDQS7, 0x00000030
-DATA 4, MX6_IOM_GRP_DDRMODE, 0x00020000
-DATA 4, MX6_IOM_GRP_B0DS, 0x00000030
-DATA 4, MX6_IOM_GRP_B1DS, 0x00000030
-DATA 4, MX6_IOM_GRP_B2DS, 0x00000030
-DATA 4, MX6_IOM_GRP_B3DS, 0x00000030
-DATA 4, MX6_IOM_GRP_B4DS, 0x00000030
-DATA 4, MX6_IOM_GRP_B5DS, 0x00000030
-DATA 4, MX6_IOM_GRP_B6DS, 0x00000030
-DATA 4, MX6_IOM_GRP_B7DS, 0x00000030
-DATA 4, MX6_IOM_DRAM_DQM0, 0x00000030
-DATA 4, MX6_IOM_DRAM_DQM1, 0x00000030
-DATA 4, MX6_IOM_DRAM_DQM2, 0x00000030
-DATA 4, MX6_IOM_DRAM_DQM3, 0x00000030
-DATA 4, MX6_IOM_DRAM_DQM4, 0x00000030
-DATA 4, MX6_IOM_DRAM_DQM5, 0x00000030
-DATA 4, MX6_IOM_DRAM_DQM6, 0x00000030
-DATA 4, MX6_IOM_DRAM_DQM7, 0x00000030
-
-/* memory interface calibration values */
-DATA 4, MX6_MMDC_P0_MPZQHWCTRL, 0xA1390003
-DATA 4, MX6_MMDC_P1_MPZQHWCTRL, 0xA1390003
-DATA 4, MX6_MMDC_P0_MPWLDECTRL0, 0x00180016
-DATA 4, MX6_MMDC_P0_MPWLDECTRL1, 0x001F0018
-DATA 4, MX6_MMDC_P1_MPWLDECTRL0, 0x00130023
-DATA 4, MX6_MMDC_P1_MPWLDECTRL1, 0x00040018
-DATA 4, MX6_MMDC_P0_MPDGCTRL0, 0x43500364
-DATA 4, MX6_MMDC_P0_MPDGCTRL1, 0x034C0344
-DATA 4, MX6_MMDC_P1_MPDGCTRL0, 0x43580364
-DATA 4, MX6_MMDC_P1_MPDGCTRL1, 0x033C031C
-DATA 4, MX6_MMDC_P0_MPRDDLCTL, 0x3C323438
-DATA 4, MX6_MMDC_P1_MPRDDLCTL, 0x383A3040
-DATA 4, MX6_MMDC_P0_MPWRDLCTL, 0x3A3E4440
-DATA 4, MX6_MMDC_P1_MPWRDLCTL, 0x4834483A
-DATA 4, MX6_MMDC_P0_MPRDDQBY0DL, 0x33333333
-DATA 4, MX6_MMDC_P0_MPRDDQBY1DL, 0x33333333
-DATA 4, MX6_MMDC_P0_MPRDDQBY2DL, 0x33333333
-DATA 4, MX6_MMDC_P0_MPRDDQBY3DL, 0x33333333
-DATA 4, MX6_MMDC_P1_MPRDDQBY0DL, 0x33333333
-DATA 4, MX6_MMDC_P1_MPRDDQBY1DL, 0x33333333
-DATA 4, MX6_MMDC_P1_MPRDDQBY2DL, 0x33333333
-DATA 4, MX6_MMDC_P1_MPRDDQBY3DL, 0x33333333
-DATA 4, MX6_MMDC_P0_MPMUR0, 0x00000800
-DATA 4, MX6_MMDC_P1_MPMUR0, 0x00000800
-
-/* configure memory interface */
-DATA 4, MX6_MMDC_P0_MDPDC, 0x00020036
-DATA 4, MX6_MMDC_P0_MDOTC, 0x09444040
-DATA 4, MX6_MMDC_P0_MDCFG0, 0x545A79B4
-DATA 4, MX6_MMDC_P0_MDCFG1, 0xDB538F64
-DATA 4, MX6_MMDC_P0_MDCFG2, 0x01FF00DB
-DATA 4, MX6_MMDC_P0_MDMISC, 0x00011740
-DATA 4, MX6_MMDC_P0_MDSCR, 0x00008000
-DATA 4, MX6_MMDC_P0_MDRWD, 0x000026D2
-DATA 4, MX6_MMDC_P0_MDOR, 0x005A1023
-DATA 4, MX6_MMDC_P0_MDASP, 0x00000027
-DATA 4, MX6_MMDC_P0_MDCTL, 0x831A0000
-
-DATA 4, MX6_MMDC_P0_MDSCR, 0x00488032
-DATA 4, MX6_MMDC_P0_MDSCR, 0x00008033
-DATA 4, MX6_MMDC_P0_MDSCR, 0x00048031
-DATA 4, MX6_MMDC_P0_MDSCR, 0x19308030
-DATA 4, MX6_MMDC_P0_MDSCR, 0x04008040
-DATA 4, MX6_MMDC_P0_MDREF, 0x00007800
-DATA 4, MX6_MMDC_P0_MPODTCTRL, 0x00022222
-DATA 4, MX6_MMDC_P1_MPODTCTRL, 0x00022222
-DATA 4, MX6_MMDC_P0_MDPDC, 0x00025536
-DATA 4, MX6_MMDC_P0_MAPSR, 0x00001006
-DATA 4, MX6_MMDC_P0_MDSCR, 0x00000000
-
-#include "clocks.cfg"
diff --git a/board/tq/tqma6/tqma6s.cfg b/board/tq/tqma6/tqma6s.cfg
deleted file mode 100644
index a5057689d64..00000000000
--- a/board/tq/tqma6/tqma6s.cfg
+++ /dev/null
@@ -1,126 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (c) 2013-2014 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
- * D-82229 Seefeld, Germany.
- * Author: Markus Niebel
- *
- * Refer doc/imx/mkimage/imximage.txt for more details about how-to configure
- * and create imximage boot image
- *
- * The syntax is taken as close as possible with the kwbimage
- */
-
-/* image version */
-IMAGE_VERSION 2
-
-#include <config.h>
-
-/*
- * Boot Device : one of
- * spi, sd (the board has no nand neither onenand)
- */
-#if defined(CONFIG_TQMA6X_MMC_BOOT)
-BOOT_FROM      sd
-#elif defined(CONFIG_TQMA6X_SPI_BOOT)
-BOOT_FROM      spi
-#endif
-
-#include "asm/arch/mx6-ddr.h"
-#include "asm/arch/iomux.h"
-#include "asm/arch/crm_regs.h"
-
-/* TQMa6S DDR config Rev. 0300D */
-/* IOMUX configuration */
-DATA 4, MX6_IOM_GRP_DDR_TYPE, 0x000C0000
-DATA 4, MX6_IOM_GRP_DDRPKE, 0x00000000
-DATA 4, MX6_IOM_DRAM_SDCLK_0, 0x00008000
-DATA 4, MX6_IOM_DRAM_SDCLK_1, 0x00008030
-DATA 4, MX6_IOM_DRAM_CAS, 0x00008030
-DATA 4, MX6_IOM_DRAM_RAS, 0x00008030
-DATA 4, MX6_IOM_GRP_ADDDS, 0x00000030
-DATA 4, MX6_IOM_DRAM_RESET, 0x00000030
-DATA 4, MX6_IOM_DRAM_SDCKE0, 0x00003000
-DATA 4, MX6_IOM_DRAM_SDCKE1, 0x00000000
-DATA 4, MX6_IOM_DRAM_SDBA2, 0x00000000
-DATA 4, MX6_IOM_DRAM_SDODT0, 0x00003030
-DATA 4, MX6_IOM_DRAM_SDODT1, 0x00003030
-DATA 4, MX6_IOM_GRP_CTLDS, 0x00000030
-DATA 4, MX6_IOM_DDRMODE_CTL, 0x00020000
-DATA 4, MX6_IOM_DRAM_SDQS0, 0x00000030
-DATA 4, MX6_IOM_DRAM_SDQS1, 0x00000030
-DATA 4, MX6_IOM_DRAM_SDQS2, 0x00000030
-DATA 4, MX6_IOM_DRAM_SDQS3, 0x00000030
-DATA 4, MX6_IOM_DRAM_SDQS4, 0x00000000
-DATA 4, MX6_IOM_DRAM_SDQS5, 0x00000000
-DATA 4, MX6_IOM_DRAM_SDQS6, 0x00000000
-DATA 4, MX6_IOM_DRAM_SDQS7, 0x00000000
-DATA 4, MX6_IOM_GRP_DDRMODE, 0x00020000
-DATA 4, MX6_IOM_GRP_B0DS, 0x00000030
-DATA 4, MX6_IOM_GRP_B1DS, 0x00000030
-DATA 4, MX6_IOM_GRP_B2DS, 0x00000030
-DATA 4, MX6_IOM_GRP_B3DS, 0x00000030
-DATA 4, MX6_IOM_GRP_B4DS, 0x00000000
-DATA 4, MX6_IOM_GRP_B5DS, 0x00000000
-DATA 4, MX6_IOM_GRP_B6DS, 0x00000000
-DATA 4, MX6_IOM_GRP_B7DS, 0x00000000
-DATA 4, MX6_IOM_DRAM_DQM0, 0x00000030
-DATA 4, MX6_IOM_DRAM_DQM1, 0x00000030
-DATA 4, MX6_IOM_DRAM_DQM2, 0x00000030
-DATA 4, MX6_IOM_DRAM_DQM3, 0x00000030
-DATA 4, MX6_IOM_DRAM_DQM4, 0x00000000
-DATA 4, MX6_IOM_DRAM_DQM5, 0x00000000
-DATA 4, MX6_IOM_DRAM_DQM6, 0x00000000
-DATA 4, MX6_IOM_DRAM_DQM7, 0x00000000
-
-/* memory interface calibration values */
-DATA 4, MX6_MMDC_P0_MPZQHWCTRL, 0xA1390003
-DATA 4, MX6_MMDC_P1_MPZQHWCTRL, 0xA1380000
-DATA 4, MX6_MMDC_P0_MPWLDECTRL0, 0x004C004A
-DATA 4, MX6_MMDC_P0_MPWLDECTRL1, 0x003F0048
-DATA 4, MX6_MMDC_P1_MPWLDECTRL0, 0x00000000
-DATA 4, MX6_MMDC_P1_MPWLDECTRL1, 0x00000000
-DATA 4, MX6_MMDC_P0_MPDGCTRL0, 0x42440240
-DATA 4, MX6_MMDC_P0_MPDGCTRL1, 0x022C022C
-DATA 4, MX6_MMDC_P1_MPDGCTRL0, 0x00000000
-DATA 4, MX6_MMDC_P1_MPDGCTRL1, 0x00000000
-DATA 4, MX6_MMDC_P0_MPRDDLCTL, 0x484A504C
-DATA 4, MX6_MMDC_P1_MPRDDLCTL, 0x00000000
-DATA 4, MX6_MMDC_P0_MPWRDLCTL, 0x34322832
-DATA 4, MX6_MMDC_P1_MPWRDLCTL, 0x00000000
-DATA 4, MX6_MMDC_P0_MPRDDQBY0DL, 0x33333333
-DATA 4, MX6_MMDC_P0_MPRDDQBY1DL, 0x33333333
-DATA 4, MX6_MMDC_P0_MPRDDQBY2DL, 0x33333333
-DATA 4, MX6_MMDC_P0_MPRDDQBY3DL, 0x33333333
-DATA 4, MX6_MMDC_P1_MPRDDQBY0DL, 0x00000000
-DATA 4, MX6_MMDC_P1_MPRDDQBY1DL, 0x00000000
-DATA 4, MX6_MMDC_P1_MPRDDQBY2DL, 0x00000000
-DATA 4, MX6_MMDC_P1_MPRDDQBY3DL, 0x00000000
-DATA 4, MX6_MMDC_P0_MPMUR0, 0x00000800
-DATA 4, MX6_MMDC_P1_MPMUR0, 0x00000000
-
-/* configure memory interface */
-DATA 4, MX6_MMDC_P0_MDPDC, 0x0002002D
-DATA 4, MX6_MMDC_P0_MDOTC, 0x00333030
-DATA 4, MX6_MMDC_P0_MDCFG0, 0x3F435333
-DATA 4, MX6_MMDC_P0_MDCFG1, 0xB68E8B63
-DATA 4, MX6_MMDC_P0_MDCFG2, 0x01FF00DB
-DATA 4, MX6_MMDC_P0_MDMISC, 0x00011740
-DATA 4, MX6_MMDC_P0_MDSCR, 0x00008000
-DATA 4, MX6_MMDC_P0_MDRWD, 0x000026D2
-DATA 4, MX6_MMDC_P0_MDOR, 0x00431023
-DATA 4, MX6_MMDC_P0_MDASP, 0x00000017
-DATA 4, MX6_MMDC_P0_MDCTL, 0x83190000
-
-DATA 4, MX6_MMDC_P0_MDSCR, 0x00408032
-DATA 4, MX6_MMDC_P0_MDSCR, 0x00008033
-DATA 4, MX6_MMDC_P0_MDSCR, 0x00048031
-DATA 4, MX6_MMDC_P0_MDSCR, 0x15208030
-DATA 4, MX6_MMDC_P0_MDSCR, 0x04008040
-DATA 4, MX6_MMDC_P0_MDREF, 0x00007800
-DATA 4, MX6_MMDC_P0_MPODTCTRL, 0x00022222
-DATA 4, MX6_MMDC_P1_MPODTCTRL, 0x00000000
-DATA 4, MX6_MMDC_P0_MDPDC, 0x0002552D
-DATA 4, MX6_MMDC_P0_MAPSR, 0x00001006
-DATA 4, MX6_MMDC_P0_MDSCR, 0x00000000
-
-#include "clocks.cfg"
diff --git a/configs/tqma6_mba6_common.config b/configs/tqma6_mba6_common.config
index 78786c53f29..2fd444d0f66 100644
--- a/configs/tqma6_mba6_common.config
+++ b/configs/tqma6_mba6_common.config
@@ -1,14 +1,26 @@
 CONFIG_ARM=y
 CONFIG_ARCH_MX6=y
 CONFIG_SYS_MALLOC_LEN=0x202000
+CONFIG_SYS_MALLOC_F_LEN=0x10000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_SF_DEFAULT_SPEED=50000000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_TARGET_TQMA6=y
+CONFIG_SPL_SYS_MALLOC_F_LEN=0xb000
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_STACK_R_ADDR=0x18000000
+CONFIG_SPL_STACK_R=y
+CONFIG_SPL=y
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
 CONFIG_SYS_MEMTEST_START=0x28000000
 CONFIG_SYS_MEMTEST_END=0x2a000000
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_LOAD_FIT=y
 CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_BOOTDELAY=3
 CONFIG_OF_BOARD_SETUP=y
@@ -16,6 +28,11 @@ CONFIG_FDT_FIXUP_PARTITIONS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run mmcboot"
 CONFIG_SYS_PBSIZE=532
+CONFIG_SPL_LEGACY_IMAGE_FORMAT=y
+CONFIG_SPL_FIT_IMAGE_TINY=y
+CONFIG_SPL_DMA=y
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SPL_WATCHDOG=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_BOOTZ=y
@@ -32,11 +49,13 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_TEMPERATURE=y
-CONFIG_CMD_NFS=y
+CONFIG_CMD_WDT=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
+CONFIG_CMD_NFS=y
 CONFIG_CMD_PING=y
 CONFIG_CMD_CACHE=y
+CONFIG_CMD_PMIC=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
@@ -45,7 +64,10 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="FEC"
 CONFIG_ARP_TIMEOUT=200
+CONFIG_NET_RETRY_COUNT=50
 CONFIG_USE_ROOTPATH=y
 CONFIG_ROOTPATH="/srv/nfs"
 CONFIG_BOUNCE_BUFFER=y
@@ -73,7 +95,6 @@ CONFIG_PINCTRL_IMX6=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_PFUZE100=y
 CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_PFUZE100=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/tqma6dl_mba6_mmc_defconfig b/configs/tqma6dl_mba6_mmc_defconfig
index f16d8e484ac..09e821b995a 100644
--- a/configs/tqma6dl_mba6_mmc_defconfig
+++ b/configs/tqma6dl_mba6_mmc_defconfig
@@ -3,3 +3,5 @@
 
 CONFIG_MX6DL=y
 CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6dl-mba6b"
+CONFIG_OF_LIST="nxp/imx/imx6dl-mba6a nxp/imx/imx6dl-mba6b"
+CONFIG_MULTI_DTB_FIT=y
diff --git a/configs/tqma6dl_mba6_spi_defconfig b/configs/tqma6dl_mba6_spi_defconfig
index fcc03ad491d..bee18e7fc43 100644
--- a/configs/tqma6dl_mba6_spi_defconfig
+++ b/configs/tqma6dl_mba6_spi_defconfig
@@ -3,3 +3,5 @@
 
 CONFIG_MX6DL=y
 CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6dl-mba6b"
+CONFIG_OF_LIST="nxp/imx/imx6dl-mba6a nxp/imx/imx6dl-mba6b"
+CONFIG_MULTI_DTB_FIT=y
diff --git a/configs/tqma6q_mba6_mmc_defconfig b/configs/tqma6q_mba6_mmc_defconfig
index 05fad3d82f4..ed2961c599b 100644
--- a/configs/tqma6q_mba6_mmc_defconfig
+++ b/configs/tqma6q_mba6_mmc_defconfig
@@ -3,3 +3,5 @@
 
 CONFIG_MX6Q=y
 CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6q-mba6b"
+CONFIG_OF_LIST="nxp/imx/imx6q-mba6a nxp/imx/imx6q-mba6b"
+CONFIG_MULTI_DTB_FIT=y
diff --git a/configs/tqma6q_mba6_spi_defconfig b/configs/tqma6q_mba6_spi_defconfig
index 7af41523c2d..dd49741ae7c 100644
--- a/configs/tqma6q_mba6_spi_defconfig
+++ b/configs/tqma6q_mba6_spi_defconfig
@@ -3,3 +3,5 @@
 
 CONFIG_MX6Q=y
 CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6q-mba6b"
+CONFIG_OF_LIST="nxp/imx/imx6q-mba6a nxp/imx/imx6q-mba6b"
+CONFIG_MULTI_DTB_FIT=y
diff --git a/configs/tqma6s_mba6_mmc_defconfig b/configs/tqma6s_mba6_mmc_defconfig
index 23d2a75e55b..c8197c67645 100644
--- a/configs/tqma6s_mba6_mmc_defconfig
+++ b/configs/tqma6s_mba6_mmc_defconfig
@@ -3,3 +3,5 @@
 
 CONFIG_MX6S=y
 CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6dl-mba6b"
+CONFIG_OF_LIST="nxp/imx/imx6dl-mba6a nxp/imx/imx6dl-mba6b"
+CONFIG_MULTI_DTB_FIT=y
diff --git a/configs/tqma6s_mba6_spi_defconfig b/configs/tqma6s_mba6_spi_defconfig
index 4e674fe6634..e200e0c5480 100644
--- a/configs/tqma6s_mba6_spi_defconfig
+++ b/configs/tqma6s_mba6_spi_defconfig
@@ -3,3 +3,5 @@
 
 CONFIG_MX6S=y
 CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6dl-mba6b"
+CONFIG_OF_LIST="nxp/imx/imx6dl-mba6a nxp/imx/imx6dl-mba6b"
+CONFIG_MULTI_DTB_FIT=y

-- 
2.53.0

