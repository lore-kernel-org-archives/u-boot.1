Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D85DCF34B0
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 16:11:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03E6F88ED2;
	Thu,  3 Oct 2024 18:11:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wPUSRyA+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2536D882EF; Thu,  3 Oct 2024 17:47:08 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC17C88E5F
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 17:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42f6bec84b5so11127295e9.1
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 08:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727970422; x=1728575222; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D6T8MPFWQVifW4AmTfng+k+WEPqiE2ByoBIjEqOxYuo=;
 b=wPUSRyA+ZmcRhxVciF4KqlJvGu1k41fj6FZ92/XKSBBlVbomBSWXItXDrLHeF9XQ6z
 JYhNyoCXRO7IZ2rf64yyTTvkkdOdcK8ZDbVHtAK5zT5fK7+E8rfCSM2ZrzFeM6VPd8WZ
 OjAxXgWiVIcpz7CpjbPWalRBcNJtGBxbuTgjYUP8dM7VX2r4TyZfPHrhO4ZZo89Y2cue
 UyeDMzDXxvnFWIcOZbdAEVr/2WTm9OBTnGnJpCOMbt81qpY+0O6aS6ki77rJxuBYy0Z4
 lvYzoeUuYLfe6wrTZ4fFR4a64evyYdZ/beLTUPRFfl088wkHmHyI6xPg1WF/KEOGkeAn
 Df2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727970422; x=1728575222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D6T8MPFWQVifW4AmTfng+k+WEPqiE2ByoBIjEqOxYuo=;
 b=bSP/n6eeZgT+aTDoM2c51VS7s2QnTdG6qKnJzsdbBWuRhqXnRHHRerYPuZnamqq1RE
 AD6LoKQcrOvvCoZxdO5qJL7G4VhLNqZlWOH3jFDmNy4o+PQcC7VHfFq10q5RYKq2zknj
 bCO95MKrcFXSN6I4EMwM1v2X8qunkU2w4J4cJtqKewFbaKSa2L/uO4lKw8zZq39/UW+M
 b9bDexXu2dPEcjq9wHp44S1V874uHG8ZISZpLpx2VyK6S8k4/CQZ/ZzRFqipT+b1y4Lx
 5FM2R9YOwjGeGa5SEK3X5Iz1YkC1CMp2sJnJ2DaoXc3MO5bPYgziy0gxroE98Vk2A1W1
 in+Q==
X-Gm-Message-State: AOJu0YwAmcFcw6glnjz3ep+TbP8vzJ2zTk437mIkqCPDNvnl9pdzO82h
 kONNMT2e+ldpev4d9g5gmvpBs+FUHy9ERliFpegYgUGaV7RbvVTArCQp4jCZAtyPTthIPONhiHv
 uvdZVunNy
X-Google-Smtp-Source: AGHT+IFscSBut1Td4Abr/7RpYLgxksCfoMaRlJr9KfCejjku5zeDO+op4Yf4neEzcXz0Lo5M3IlUKw==
X-Received: by 2002:a05:600c:3515:b0:42c:b1e1:a45b with SMTP id
 5b1f17b1804b1-42f7c76d5dfmr40532115e9.19.1727970422133; 
 Thu, 03 Oct 2024 08:47:02 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d888:7a58:deed:47d6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d08245059sm1541748f8f.55.2024.10.03.08.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 08:47:00 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Matteo Lisi <matteo.lisi@engicam.com>, Tom Rini <trini@konsulko.com>,
 Gilles Talis <gilles.talis@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marex@denx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Petr Zejdl <petr.zejdl@cern.ch>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Artur Rojek <artur@conclusive.pl>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Yang Xiwen <forbidden405@outlook.com>,
 Boon Khai Ng <boon.khai.ng@intel.com>,
 Robert Marko <robert.marko@sartura.hr>, Philip Oberfichtner <pro@denx.de>,
 Jonas Karlman <jonas@kwiboo.se>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v11 13/29] net-lwip: add DHCP support and dhcp commmand
Date: Thu,  3 Oct 2024 17:46:17 +0200
Message-Id: <122c4866fe98a74dc22b18b048b462cb3564c73a.1727968902.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1727968902.git.jerome.forissier@linaro.org>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Oct 2024 18:11:48 +0200
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

Add what it takes to enable NETDEVICES with NET_LWIP and enable DHCP as
well as the dhcp command. CMD_TFTPBOOT is selected by BOOTMETH_EFI due
to this code having an implicit dependency on do_tftpb().

Note that PXE is likely non-fonctional with NET_LWIP (or at least not
100% functional) because DHCP option 209 is not supported by the lwIP
library. Therefore, BOOTP_PXE_DHCP_OPTION cannot be enabled.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 board/engicam/imx8mp/icore_mx8mp.c            |   2 +-
 .../imx8mp_debix_model_a.c                    |   2 +-
 board/ti/am335x/board.c                       |   3 +-
 board/xilinx/common/board.c                   |   3 +-
 cmd/Kconfig                                   | 100 +++---
 cmd/Makefile                                  |   6 +-
 cmd/elf.c                                     |   2 +-
 cmd/net-lwip.c                                |  13 +
 common/board_r.c                              |   4 +-
 common/usb_kbd.c                              |   2 +-
 drivers/net/Kconfig                           |   2 +-
 include/net-common.h                          |   3 +
 include/net-legacy.h                          |   3 -
 include/net-lwip.h                            |   3 +
 lib/tiny-printf.c                             |   3 +-
 net/Makefile                                  |  14 +-
 net/lwip/Makefile                             |   5 +
 net/lwip/dhcp.c                               | 127 ++++++++
 net/lwip/eth_internal.h                       |  35 +++
 net/lwip/net-lwip.c                           | 291 ++++++++++++++++++
 net/lwip/tftp.c                               |  11 +
 21 files changed, 572 insertions(+), 62 deletions(-)
 create mode 100644 cmd/net-lwip.c
 create mode 100644 net/lwip/Makefile
 create mode 100644 net/lwip/dhcp.c
 create mode 100644 net/lwip/eth_internal.h
 create mode 100644 net/lwip/net-lwip.c
 create mode 100644 net/lwip/tftp.c

diff --git a/board/engicam/imx8mp/icore_mx8mp.c b/board/engicam/imx8mp/icore_mx8mp.c
index e2ed70caa43..bfdc447c478 100644
--- a/board/engicam/imx8mp/icore_mx8mp.c
+++ b/board/engicam/imx8mp/icore_mx8mp.c
@@ -33,7 +33,7 @@ static void setup_fec(void)
 	setbits_le32(&gpr->gpr[1], BIT(22));
 }
 
-#if CONFIG_IS_ENABLED(NET)
+#if CONFIG_IS_ENABLED(NET) || CONFIG_IS_ENABLED(NET_LWIP)
 int board_phy_config(struct phy_device *phydev)
 {
 	if (phydev->drv->config)
diff --git a/board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c b/board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c
index 112770ba493..c709d017483 100644
--- a/board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c
+++ b/board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c
@@ -29,7 +29,7 @@ static void setup_fec(void)
 	setbits_le32(&gpr->gpr[1], BIT(22));
 }
 
-#if CONFIG_IS_ENABLED(NET)
+#if CONFIG_IS_ENABLED(NET) || CONFIG_IS_ENABLED(NET_LWIP)
 int board_phy_config(struct phy_device *phydev)
 {
 	if (phydev->drv->config)
diff --git a/board/ti/am335x/board.c b/board/ti/am335x/board.c
index 681002ba1da..249c9fd2e7e 100644
--- a/board/ti/am335x/board.c
+++ b/board/ti/am335x/board.c
@@ -900,7 +900,8 @@ int board_late_init(void)
 #endif
 
 /* CPSW plat */
-#if CONFIG_IS_ENABLED(NET) && !CONFIG_IS_ENABLED(OF_CONTROL)
+#if (CONFIG_IS_ENABLED(NET) || CONFIG_IS_ENABLED(NET_LWIP)) && \
+    !CONFIG_IS_ENABLED(OF_CONTROL)
 struct cpsw_slave_data slave_data[] = {
 	{
 		.slave_reg_ofs  = CPSW_SLAVE0_OFFSET,
diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index 5e5eb49ddf3..b6a2381c909 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -491,7 +491,8 @@ int board_late_init_xilinx(void)
 				ret |= env_set_by_index("uuid", id, uuid);
 			}
 
-			if (!CONFIG_IS_ENABLED(NET))
+			if (!(CONFIG_IS_ENABLED(NET) ||
+			      CONFIG_IS_ENABLED(NET_LWIP)))
 				continue;
 
 			for (i = 0; i < EEPROM_HDR_NO_OF_MAC_ADDR; i++) {
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 3beddd72583..d09c237a52f 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1798,12 +1798,16 @@ config CMD_AB_SELECT
 
 endmenu
 
-if NET
+if NET || NET_LWIP
 
 menuconfig CMD_NET
 	bool "Network commands"
 	default y
 
+endif
+
+if NET
+
 if CMD_NET
 
 config CMD_BOOTP
@@ -1812,12 +1816,6 @@ config CMD_BOOTP
 	help
 	  bootp - boot image via network using BOOTP/TFTP protocol
 
-config CMD_DHCP
-	bool "dhcp"
-	depends on CMD_BOOTP
-	help
-	  Boot image via network using DHCP/TFTP protocol
-
 config CMD_DHCP6
 	bool "dhcp6"
 	depends on IPV6
@@ -1961,12 +1959,6 @@ config BOOTP_VCI_STRING
 	default "U-Boot.arm" if ARM
 	default "U-Boot"
 
-config CMD_TFTPBOOT
-	bool "tftpboot"
-	default y
-	help
-	  tftpboot - load file via network using TFTP protocol
-
 config CMD_TFTPPUT
 	bool "tftp put"
 	depends on CMD_TFTPBOOT
@@ -2026,29 +2018,6 @@ config CMD_WGET
 	  wget is a simple command to download kernel, or other files,
 	  from a http server over TCP.
 
-config CMD_MII
-	bool "mii"
-	imply CMD_MDIO
-	help
-	  If set, allows 802.3(clause 22) MII Management functions interface access
-	  The management interface specified in Clause 22 provides
-	  a simple, two signal, serial interface to connect a
-	  Station Management entity and a managed PHY for providing access
-	  to management parameters and services.
-	  The interface is referred to as the MII management interface.
-
-config MII_INIT
-	bool "Call mii_init() in the mii command"
-	depends on CMD_MII && (MPC8XX_FEC || FSLDMAFE || MCFFEC)
-
-config CMD_MDIO
-	bool "mdio"
-	depends on PHYLIB
-	help
-	  If set, allows Enable 802.3(clause 45) MDIO interface registers access
-	  The MDIO interface is orthogonal to the MII interface and extends
-	  it by adding access to more registers through indirect addressing.
-
 config CMD_PING
 	bool "ping"
 	help
@@ -2097,7 +2066,7 @@ config IPV6_ROUTER_DISCOVERY
 	help
 	  Will automatically perform router solicitation on first IPv6
 	  network operation
-endif
+endif  # if CMD_NET
 
 config CMD_ETHSW
 	bool "ethsw"
@@ -2107,6 +2076,56 @@ config CMD_ETHSW
 	  operations such as enabling / disabling a port and
 	  viewing/maintaining the filtering database (FDB)
 
+config CMD_WOL
+	bool "wol"
+	help
+	  Wait for wake-on-lan Magic Packet
+
+endif  # if NET
+
+if NET || NET_LWIP
+
+if CMD_NET
+
+config CMD_DHCP
+	bool "dhcp"
+	select PROT_DHCP_LWIP if NET_LWIP
+	help
+	  Boot image via network using DHCP/TFTP protocol
+
+config CMD_MII
+	bool "mii"
+	imply CMD_MDIO
+	help
+	  If set, allows 802.3(clause 22) MII Management functions interface access
+	  The management interface specified in Clause 22 provides
+	  a simple, two signal, serial interface to connect a
+	  Station Management entity and a managed PHY for providing access
+	  to management parameters and services.
+	  The interface is referred to as the MII management interface.
+
+config MII_INIT
+	bool "Call mii_init() in the mii command"
+	depends on CMD_MII && (MPC8XX_FEC || FSLDMAFE || MCFFEC)
+
+config CMD_MDIO
+	bool "mdio"
+	depends on PHYLIB
+	help
+	  If set, allows Enable 802.3(clause 45) MDIO interface registers access
+	  The MDIO interface is orthogonal to the MII interface and extends
+	  it by adding access to more registers through indirect addressing.
+
+config CMD_TFTPBOOT
+	bool "tftp"
+	select PROT_UDP_LWIP if NET_LWIP
+	default n
+	help
+	  tftpboot - load file via network using TFTP protocol
+	  Currently a placeholder (not implemented) when NET_LWIP=y.
+
+endif  # if CMD_NET
+
 config CMD_PXE
 	bool "pxe"
 	select PXE_UTILS
@@ -2114,12 +2133,7 @@ config CMD_PXE
 	help
 	  Boot image via network using PXE protocol
 
-config CMD_WOL
-	bool "wol"
-	help
-	  Wait for wake-on-lan Magic Packet
-
-endif
+endif  # if NET || NET_LWIP
 
 menu "Misc commands"
 
diff --git a/cmd/Makefile b/cmd/Makefile
index 91227f1249c..1c8cc42503d 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -127,7 +127,11 @@ obj-y += legacy-mtd-utils.o
 endif
 obj-$(CONFIG_CMD_MUX) += mux.o
 obj-$(CONFIG_CMD_NAND) += nand.o
-obj-$(CONFIG_CMD_NET) += net.o
+ifdef CONFIG_CMD_NET
+obj-$(CONFIG_NET) += net.o
+obj-$(CONFIG_NET_LWIP) += net-lwip.o
+CFLAGS_net-lwip.o := -I$(srctree)/lib/lwip/lwip/src/include -I$(srctree)/lib/lwip/u-boot
+endif
 obj-$(CONFIG_ENV_SUPPORT) += nvedit.o
 obj-$(CONFIG_CMD_NVEDIT_EFI) += nvedit_efi.o
 obj-$(CONFIG_CMD_ONENAND) += onenand.o
diff --git a/cmd/elf.c b/cmd/elf.c
index f07e344a596..e4c68744d5f 100644
--- a/cmd/elf.c
+++ b/cmd/elf.c
@@ -130,7 +130,7 @@ int do_bootvx(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	else
 		addr = hextoul(argv[1], NULL);
 
-#if defined(CONFIG_CMD_NET)
+#if defined(CONFIG_CMD_NET) && !defined(CONFIG_NET_LWIP)
 	/*
 	 * Check to see if we need to tftp the image ourselves
 	 * before starting
diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
new file mode 100644
index 00000000000..82edb5fd2e6
--- /dev/null
+++ b/cmd/net-lwip.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2024 Linaro Ltd. */
+
+#include <command.h>
+#include <net.h>
+
+#if defined(CONFIG_CMD_DHCP)
+U_BOOT_CMD(
+        dhcp,   3,      1,      do_dhcp,
+        "boot image via network using DHCP/TFTP protocol",
+        "[loadAddress] [[hostIPaddr:]bootfilename]"
+);
+#endif
diff --git a/common/board_r.c b/common/board_r.c
index 4faaa202421..49347370a1f 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -472,7 +472,7 @@ static int initr_status_led(void)
 }
 #endif
 
-#ifdef CONFIG_CMD_NET
+#if defined(CONFIG_CMD_NET)
 static int initr_net(void)
 {
 	puts("Net:   ");
@@ -738,7 +738,7 @@ static init_fnc_t init_sequence_r[] = {
 #ifdef CONFIG_PCI_ENDPOINT
 	pci_ep_init,
 #endif
-#ifdef CONFIG_CMD_NET
+#if defined(CONFIG_CMD_NET)
 	INIT_FUNC_WATCHDOG_RESET
 	initr_net,
 #endif
diff --git a/common/usb_kbd.c b/common/usb_kbd.c
index bbfee23bc26..36107a3b278 100644
--- a/common/usb_kbd.c
+++ b/common/usb_kbd.c
@@ -423,7 +423,7 @@ static int usb_kbd_testc(struct stdio_dev *sdev)
 	 */
 	unsigned long poll_delay = CONFIG_SYS_HZ / 50;
 
-#ifdef CONFIG_CMD_NET
+#if defined(CONFIG_CMD_NET) && !defined(CONFIG_NET_LWIP)
 	/*
 	 * If net_busy_flag is 1, NET transfer is running,
 	 * then we check key-pressed every second (first check may be
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 9c042808b44..25084b4103d 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -97,7 +97,7 @@ config DSA_SANDBOX
 
 menuconfig NETDEVICES
 	bool "Network device support"
-	depends on NET
+	depends on NET || NET_LWIP
 	select DM_ETH
 	help
 	  You must select Y to enable any network device support
diff --git a/include/net-common.h b/include/net-common.h
index 6bc76658d9d..cbcac178c82 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -118,6 +118,9 @@ extern int		net_restart_wrap;	/* Tried all network devices */
 extern uchar               *net_rx_packets[PKTBUFSRX]; /* Receive packets */
 extern const u8		net_bcast_ethaddr[ARP_HLEN];	/* Ethernet broadcast address */
 extern char	net_boot_file_name[1024];/* Boot File name */
+extern struct in_addr	net_ip;		/* Our    IP addr (0 = unknown) */
+/* Indicates whether the pxe path prefix / config file was specified in dhcp option */
+extern char *pxelinux_configfile;
 
 /**
  * compute_ip_checksum() - Compute IP checksum
diff --git a/include/net-legacy.h b/include/net-legacy.h
index 19c991e12f6..bdca904a0f8 100644
--- a/include/net-legacy.h
+++ b/include/net-legacy.h
@@ -285,12 +285,9 @@ extern char	net_hostname[32];	/* Our hostname */
 #ifdef CONFIG_NET
 extern char	net_root_path[CONFIG_BOOTP_MAX_ROOT_PATH_LEN];	/* Our root path */
 #endif
-/* Indicates whether the pxe path prefix / config file was specified in dhcp option */
-extern char *pxelinux_configfile;
 /** END OF BOOTP EXTENTIONS **/
 extern u8		net_ethaddr[ARP_HLEN];		/* Our ethernet address */
 extern u8		net_server_ethaddr[ARP_HLEN];	/* Boot server enet address */
-extern struct in_addr	net_ip;		/* Our    IP addr (0 = unknown) */
 extern struct in_addr	net_server_ip;	/* Server IP addr (0 = unknown) */
 extern uchar		*net_tx_packet;		/* THE transmit packet */
 extern uchar		*net_rx_packets[PKTBUFSRX]; /* Receive packets */
diff --git a/include/net-lwip.h b/include/net-lwip.h
index 5c3f9e7e86c..cfd06726577 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -10,5 +10,8 @@ struct netif *net_lwip_new_netif(struct udevice *udev);
 struct netif *net_lwip_new_netif_noip(struct udevice *udev);
 void net_lwip_remove_netif(struct netif *netif);
 struct netif *net_lwip_get_netif(void);
+int net_lwip_rx(struct udevice *udev, struct netif *netif);
+
+int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 
 #endif /* __NET_LWIP_H__ */
diff --git a/lib/tiny-printf.c b/lib/tiny-printf.c
index 9a70c6095b3..f6727360097 100644
--- a/lib/tiny-printf.c
+++ b/lib/tiny-printf.c
@@ -269,7 +269,8 @@ static int _vprintf(struct printf_info *info, const char *fmt, va_list va)
 				}
 				break;
 			case 'p':
-				if (CONFIG_IS_ENABLED(NET) || _DEBUG) {
+				if (CONFIG_IS_ENABLED(NET) ||
+				    CONFIG_IS_ENABLED(NET_LWIP) || _DEBUG) {
 					pointer(info, fmt, va_arg(va, void *));
 					/*
 					 * Skip this because it pulls in _ctype which is
diff --git a/net/Makefile b/net/Makefile
index a9cecee637a..68370595a8e 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -12,11 +12,6 @@ obj-$(CONFIG_CMD_BOOTP) += bootp.o
 obj-$(CONFIG_CMD_CDP)  += cdp.o
 obj-$(CONFIG_CMD_DNS)  += dns.o
 obj-$(CONFIG_DM_DSA)   += dsa-uclass.o
-obj-$(CONFIG_$(SPL_)DM_ETH) += eth-uclass.o
-obj-$(CONFIG_$(SPL_TPL_)BOOTDEV_ETH) += eth_bootdev.o
-obj-$(CONFIG_DM_MDIO)  += mdio-uclass.o
-obj-$(CONFIG_DM_MDIO_MUX) += mdio-mux-uclass.o
-obj-$(CONFIG_$(SPL_)DM_ETH) += eth_common.o
 obj-$(CONFIG_CMD_LINK_LOCAL) += link_local.o
 obj-$(CONFIG_IPV6)     += ndisc.o
 obj-$(CONFIG_$(SPL_)DM_ETH) += net.o
@@ -43,4 +38,13 @@ CFLAGS_eth_common.o += -Wno-format-extra-args
 
 endif
 
+ifeq ($(filter y,$(CONFIG_NET) $(CONFIG_NET_LWIP)),y)
+obj-$(CONFIG_$(SPL_TPL_)BOOTDEV_ETH) += eth_bootdev.o
+obj-$(CONFIG_DM_MDIO)  += mdio-uclass.o
+obj-$(CONFIG_DM_MDIO_MUX) += mdio-mux-uclass.o
+obj-$(CONFIG_$(SPL_)DM_ETH) += eth-uclass.o
+obj-$(CONFIG_$(SPL_)DM_ETH) += eth_common.o
 obj-y += net-common.o
+endif
+
+obj-$(CONFIG_NET_LWIP) += lwip/
diff --git a/net/lwip/Makefile b/net/lwip/Makefile
new file mode 100644
index 00000000000..4e92a101ddb
--- /dev/null
+++ b/net/lwip/Makefile
@@ -0,0 +1,5 @@
+ccflags-y += -I$(srctree)/lib/lwip/lwip/src/include -I$(srctree)/lib/lwip/u-boot
+
+obj-$(CONFIG_$(SPL_)DM_ETH) += net-lwip.o
+obj-$(CONFIG_CMD_DHCP) += dhcp.o
+obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
new file mode 100644
index 00000000000..be458d554cb
--- /dev/null
+++ b/net/lwip/dhcp.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2024 Linaro Ltd. */
+
+#include <command.h>
+#include <console.h>
+#include <dm/device.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <lwip/dhcp.h>
+#include <lwip/dns.h>
+#include <lwip/timeouts.h>
+#include <net.h>
+#include <time.h>
+
+#define DHCP_TIMEOUT_MS 10000
+
+#ifdef CONFIG_CMD_TFTPBOOT
+/* Boot file obtained from DHCP (if present) */
+static char boot_file_name[DHCP_BOOT_FILE_LEN];
+#endif
+
+static void call_lwip_dhcp_fine_tmr(void *ctx)
+{
+	dhcp_fine_tmr();
+	sys_timeout(10, call_lwip_dhcp_fine_tmr, NULL);
+}
+
+static int dhcp_loop(struct udevice *udev)
+{
+	char *ipstr = "ipaddr\0\0";
+	char *maskstr = "netmask\0\0";
+	char *gwstr = "gatewayip\0\0";
+	unsigned long start;
+	struct netif *netif;
+	struct dhcp *dhcp;
+	bool bound;
+	int idx;
+
+	idx = dev_seq(udev);
+	if (idx < 0 || idx > 99) {
+		log_err("unexpected idx %d\n", idx);
+		return CMD_RET_FAILURE;
+	}
+
+	netif = net_lwip_new_netif_noip(udev);
+	if (!netif)
+		return CMD_RET_FAILURE;
+
+	start = get_timer(0);
+	dhcp_start(netif);
+	call_lwip_dhcp_fine_tmr(NULL);
+
+	/* Wait for DHCP to complete */
+	do {
+		net_lwip_rx(udev, netif);
+		sys_check_timeouts();
+		bound = dhcp_supplied_address(netif);
+		if (bound)
+			break;
+		if (ctrlc()) {
+			printf("Abort\n");
+			break;
+		}
+		mdelay(1);
+	} while (get_timer(start) < DHCP_TIMEOUT_MS);
+
+	sys_untimeout(call_lwip_dhcp_fine_tmr, NULL);
+
+	if (!bound) {
+		net_lwip_remove_netif(netif);
+		return CMD_RET_FAILURE;
+	}
+
+	dhcp = netif_dhcp_data(netif);
+
+	env_set("bootfile", dhcp->boot_file_name);
+
+	if (idx > 0) {
+		sprintf(ipstr, "ipaddr%d", idx);
+		sprintf(maskstr, "netmask%d", idx);
+		sprintf(gwstr, "gatewayip%d", idx);
+	} else {
+		net_ip.s_addr = dhcp->offered_ip_addr.addr;
+	}
+
+	env_set(ipstr, ip4addr_ntoa(&dhcp->offered_ip_addr));
+	env_set(maskstr, ip4addr_ntoa(&dhcp->offered_sn_mask));
+	env_set("serverip", ip4addr_ntoa(&dhcp->server_ip_addr));
+	if (dhcp->offered_gw_addr.addr != 0)
+		env_set(gwstr, ip4addr_ntoa(&dhcp->offered_gw_addr));
+
+#ifdef CONFIG_PROT_DNS_LWIP
+	env_set("dnsip", ip4addr_ntoa(dns_getserver(0)));
+	env_set("dnsip2", ip4addr_ntoa(dns_getserver(1)));
+#endif
+#ifdef CONFIG_CMD_TFTPBOOT
+	if (dhcp->boot_file_name[0] != '\0')
+		strncpy(boot_file_name, dhcp->boot_file_name,
+			sizeof(boot_file_name));
+#endif
+
+	printf("DHCP client bound to address %pI4 (%lu ms)\n",
+	       &dhcp->offered_ip_addr, get_timer(start));
+
+	net_lwip_remove_netif(netif);
+	return CMD_RET_SUCCESS;
+}
+
+int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	eth_set_current();
+
+	return dhcp_loop(eth_get_dev());
+}
+
+int dhcp_run(ulong addr, const char *fname, bool autoload)
+{
+	char *dhcp_argv[] = {"dhcp", NULL, };
+	struct cmd_tbl cmdtp = {};	/* dummy */
+
+	if (autoload) {
+		/* Will be supported when TFTP is added */
+		return -EOPNOTSUPP;
+	}
+
+	return do_dhcp(&cmdtp, 0, 1, dhcp_argv);
+}
diff --git a/net/lwip/eth_internal.h b/net/lwip/eth_internal.h
new file mode 100644
index 00000000000..0b829a8d388
--- /dev/null
+++ b/net/lwip/eth_internal.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2001-2015
+ * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
+ * Joe Hershberger, National Instruments
+ */
+
+#ifndef __ETH_INTERNAL_H
+#define __ETH_INTERNAL_H
+
+/* Do init that is common to driver model and legacy networking */
+void eth_common_init(void);
+
+/**
+ * eth_env_set_enetaddr_by_index() - set the MAC address environment variable
+ *
+ * This sets up an environment variable with the given MAC address (@enetaddr).
+ * The environment variable to be set is defined by <@base_name><@index>addr.
+ * If @index is 0 it is omitted. For common Ethernet this means ethaddr,
+ * eth1addr, etc.
+ *
+ * @base_name:	Base name for variable, typically "eth"
+ * @index:	Index of interface being updated (>=0)
+ * @enetaddr:	Pointer to MAC address to put into the variable
+ * Return: 0 if OK, other value on error
+ */
+int eth_env_set_enetaddr_by_index(const char *base_name, int index,
+				 uchar *enetaddr);
+
+int eth_mac_skip(int index);
+void eth_current_changed(void);
+void eth_set_dev(struct udevice *dev);
+void eth_set_current_to_next(void);
+
+#endif
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
new file mode 100644
index 00000000000..ca5426d058b
--- /dev/null
+++ b/net/lwip/net-lwip.c
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Copyright (C) 2024 Linaro Ltd. */
+
+#include <command.h>
+#include <dm/device.h>
+#include <dm/uclass.h>
+#include <lwip/ip4_addr.h>
+#include <lwip/err.h>
+#include <lwip/netif.h>
+#include <lwip/pbuf.h>
+#include <lwip/etharp.h>
+#include <lwip/init.h>
+#include <lwip/prot/etharp.h>
+#include <net.h>
+
+/* xx:xx:xx:xx:xx:xx\0 */
+#define MAC_ADDR_STRLEN 18
+
+#if defined(CONFIG_API) || defined(CONFIG_EFI_LOADER)
+void (*push_packet)(void *, int len) = 0;
+#endif
+int net_restart_wrap;
+static uchar net_pkt_buf[(PKTBUFSRX) * PKTSIZE_ALIGN + PKTALIGN];
+uchar *net_rx_packets[PKTBUFSRX];
+uchar *net_rx_packet;
+const u8 net_bcast_ethaddr[6] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
+char *pxelinux_configfile;
+/* Our IP addr (0 = unknown) */
+struct in_addr	net_ip;
+
+static err_t linkoutput(struct netif *netif, struct pbuf *p)
+{
+	struct udevice *udev = netif->state;
+	void *pp = NULL;
+	int err;
+
+	if ((unsigned long)p->payload % PKTALIGN) {
+		/*
+		 * Some net drivers have strict alignment requirements and may
+		 * fail or output invalid data if the packet is not aligned.
+		 */
+		pp = memalign(PKTALIGN, p->len);
+		if (!pp)
+			return ERR_ABRT;
+		memcpy(pp, p->payload, p->len);
+	}
+
+	err = eth_get_ops(udev)->send(udev, pp ? pp : p->payload, p->len);
+	free(pp);
+	if (err) {
+		log_err("send error %d\n", err);
+		return ERR_ABRT;
+	}
+
+	return ERR_OK;
+}
+
+static err_t net_lwip_if_init(struct netif *netif)
+{
+#if LWIP_IPV4
+	netif->output = etharp_output;
+#endif
+	netif->linkoutput = linkoutput;
+	netif->mtu = 1500;
+	netif->flags = NETIF_FLAG_BROADCAST | NETIF_FLAG_ETHARP | NETIF_FLAG_LINK_UP;
+
+	return ERR_OK;
+}
+
+static void eth_init_rings(void)
+{
+	int i;
+
+	for (i = 0; i < PKTBUFSRX; i++)
+		net_rx_packets[i] = net_pkt_buf + i  * PKTSIZE_ALIGN;
+}
+
+struct netif *net_lwip_get_netif(void)
+{
+	struct netif *netif, *found = NULL;
+
+	NETIF_FOREACH(netif) {
+		if (!found)
+			found = netif;
+		else
+			printf("Error: more than one netif in lwIP\n");
+	}
+	return found;
+}
+
+static int get_udev_ipv4_info(struct udevice *dev, ip4_addr_t *ip,
+			      ip4_addr_t *mask, ip4_addr_t *gw)
+{
+	char *ipstr = "ipaddr\0\0";
+	char *maskstr = "netmask\0\0";
+	char *gwstr = "gatewayip\0\0";
+	int idx = dev_seq(dev);
+	char *env;
+
+	if (idx < 0 || idx > 99) {
+		log_err("unexpected idx %d\n", idx);
+		return -1;
+	}
+
+	if (idx) {
+		sprintf(ipstr, "ipaddr%d", idx);
+		sprintf(maskstr, "netmask%d", idx);
+		sprintf(gwstr, "gatewayip%d", idx);
+	}
+
+	ip4_addr_set_zero(ip);
+	ip4_addr_set_zero(mask);
+	ip4_addr_set_zero(gw);
+
+	env = env_get(ipstr);
+	if (env)
+		ip4addr_aton(env, ip);
+
+	env = env_get(maskstr);
+	if (env)
+		ip4addr_aton(env, mask);
+
+	env = env_get(gwstr);
+	if (env)
+		ip4addr_aton(env, gw);
+
+	return 0;
+}
+
+static struct netif *new_netif(struct udevice *udev, bool with_ip)
+{
+	unsigned char enetaddr[ARP_HLEN];
+	char hwstr[MAC_ADDR_STRLEN];
+	ip4_addr_t ip, mask, gw;
+	struct netif *netif;
+	int ret = 0;
+	static bool first_call = true;
+
+	if (!udev)
+		return NULL;
+
+	if (first_call) {
+		eth_init_rings();
+		/* Pick a valid active device, if any */
+		eth_init();
+		lwip_init();
+		first_call = false;
+	}
+
+	if (eth_start_udev(udev) < 0) {
+		log_err("Could not start %s\n", udev->name);
+		return NULL;
+	}
+
+	netif_remove(net_lwip_get_netif());
+
+	ip4_addr_set_zero(&ip);
+	ip4_addr_set_zero(&mask);
+	ip4_addr_set_zero(&gw);
+
+	if (with_ip)
+		if (get_udev_ipv4_info(udev, &ip, &mask, &gw) < 0)
+			return NULL;
+
+	eth_env_get_enetaddr_by_index("eth", dev_seq(udev), enetaddr);
+	ret = snprintf(hwstr, MAC_ADDR_STRLEN, "%pM",  enetaddr);
+	if (ret < 0 || ret >= MAC_ADDR_STRLEN)
+		return NULL;
+
+	netif = calloc(1, sizeof(struct netif));
+	if (!netif)
+		return NULL;
+
+	netif->name[0] = 'e';
+	netif->name[1] = 't';
+
+	string_to_enetaddr(hwstr, netif->hwaddr);
+	netif->hwaddr_len = ETHARP_HWADDR_LEN;
+	debug("adding lwIP netif for %s with hwaddr:%s ip:%s ", udev->name,
+	      hwstr, ip4addr_ntoa(&ip));
+	debug("mask:%s ", ip4addr_ntoa(&mask));
+	debug("gw:%s\n", ip4addr_ntoa(&gw));
+
+	if (!netif_add(netif, &ip, &mask, &gw, udev, net_lwip_if_init,
+		       netif_input)) {
+		printf("error: netif_add() failed\n");
+		free(netif);
+		return NULL;
+	}
+
+	netif_set_up(netif);
+	netif_set_link_up(netif);
+	/* Routing: use this interface to reach the default gateway */
+	netif_set_default(netif);
+
+	return netif;
+}
+
+struct netif *net_lwip_new_netif(struct udevice *udev)
+{
+	return new_netif(udev, true);
+}
+
+struct netif *net_lwip_new_netif_noip(struct udevice *udev)
+{
+
+	return new_netif(udev, false);
+}
+
+void net_lwip_remove_netif(struct netif *netif)
+{
+	netif_remove(netif);
+	free(netif);
+}
+
+int net_init(void)
+{
+	eth_set_current();
+
+	net_lwip_new_netif(eth_get_dev());
+
+	return 0;
+}
+
+static struct pbuf *alloc_pbuf_and_copy(uchar *data, int len)
+{
+        struct pbuf *p, *q;
+
+        /* We allocate a pbuf chain of pbufs from the pool. */
+        p = pbuf_alloc(PBUF_RAW, len, PBUF_POOL);
+        if (!p) {
+                LINK_STATS_INC(link.memerr);
+                LINK_STATS_INC(link.drop);
+                return NULL;
+        }
+
+        for (q = p; q != NULL; q = q->next) {
+                memcpy(q->payload, data, q->len);
+                data += q->len;
+        }
+
+        LINK_STATS_INC(link.recv);
+
+        return p;
+}
+
+int net_lwip_rx(struct udevice *udev, struct netif *netif)
+{
+	struct pbuf *pbuf;
+	uchar *packet;
+	int flags;
+	int len;
+	int i;
+
+	if (!eth_is_active(udev))
+		return -EINVAL;
+
+	flags = ETH_RECV_CHECK_DEVICE;
+	for (i = 0; i < ETH_PACKETS_BATCH_RECV; i++) {
+		len = eth_get_ops(udev)->recv(udev, flags, &packet);
+		flags = 0;
+
+		if (len > 0) {
+			pbuf = alloc_pbuf_and_copy(packet, len);
+			if (pbuf)
+				netif->input(pbuf, netif);
+		}
+		if (len >= 0 && eth_get_ops(udev)->free_pkt)
+			eth_get_ops(udev)->free_pkt(udev, packet, len);
+		if (len <= 0)
+			break;
+	}
+	if (len == -EAGAIN)
+		len = 0;
+
+	return len;
+}
+
+void net_process_received_packet(uchar *in_packet, int len)
+{
+#if defined(CONFIG_API) || defined(CONFIG_EFI_LOADER)
+	if (push_packet)
+		(*push_packet)(in_packet, len);
+#endif
+}
+
+u32_t sys_now(void)
+{
+	return get_timer(0);
+}
diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
new file mode 100644
index 00000000000..1fa246f55d9
--- /dev/null
+++ b/net/lwip/tftp.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2024 Linaro Ltd. */
+
+#include <command.h>
+#include <net-lwip.h>
+
+int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	/* Not implemented */
+	return CMD_RET_FAILURE;
+}
-- 
2.40.1

