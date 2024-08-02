Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815CFC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 14:22:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B52A88BBF;
	Fri,  2 Aug 2024 16:22:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q4cYRXWi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 281BD88B9B; Fri,  2 Aug 2024 15:15:03 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEB7088BD9
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 15:14:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-428243f928fso45337525e9.0
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 06:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722604497; x=1723209297; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MtSosFecyJvIyJYNL5DqArY3wn+oBQ02WqcMEILv1Bw=;
 b=Q4cYRXWiYzvI4otUGt0WEBM0eN1g42tBfOoIjq7gAy4a+akgyvxhFuq6iE6wVAdYPx
 lNKcnC+I5ueubbbYlffW8b8aL6dAV49WbeQU6E5gZ6DYqiEV/X7EPMKIYUfK8qeMDBJR
 S6ueubRni9K5YslrkaDWy1z1aAEL/vUidbm9yLgcln0xFzSPvAOhveY+8pBZugQn408k
 qwT1boVpw5w0mNZ+mbIboJ8Id4tNnDcQtocwMfEXzRa1YkX2N31RovikhQPbFTV96ZzB
 BdhaX1ik8j5hzIMNw3s5Z7j2BBYoTxXGzFTVgN6FioScjE1X4EbgcB7IZcS6gZri0Kw3
 Xt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722604497; x=1723209297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MtSosFecyJvIyJYNL5DqArY3wn+oBQ02WqcMEILv1Bw=;
 b=kFYez6B8qng9BC9iVtPtmvwa0qlBLWw2g/VCAV5jAKx0pO6JoBXdy8DzH+VZFNLoJN
 GxSMt6p1wHxn7l7bYy5CYNVYAlN/6XFnANoFI8v/KQ76xrJrwsl2cse60Z4VU0Go2Wej
 goGurIxn+bwRI509BTqc8cI2aV08Fyx56QtxT9ZPjqECgBSiHv2Nplg0nKw6iqBGIuzP
 A2W97o0J1ifc6kqElAtgTYkSzqGniodIVIa+XZsG2lTeDoznAJFXzBfU9N03m7WcbN10
 VsuWPRIccD0xUkerSnb5dr6qUUb4QUTZz+oak9BXpNo//14pGUnetkawCSuBi4wxikJ7
 XIkA==
X-Gm-Message-State: AOJu0YzrR6B9sS6WCwEzn1eAW25ajQbKIDog/6NwSOosdaFlhKI7BgO3
 2O9krwZq8ow2BqluqblsNsPkO1WsF61vvwjLwQq71stfIr0zjebPeaHLHURflKlS70luFv/vDik
 JvlA+/6Wy
X-Google-Smtp-Source: AGHT+IE53zaVMOS/1DmmcfkRfCbZkk3gr4ka1yvrBcbF7qHdwFkMwFna8oAPd1IHgYdTNXJ1HuGTnQ==
X-Received: by 2002:adf:f2ce:0:b0:368:3ef7:3929 with SMTP id
 ffacd0b85a97d-36bbc0ff3b8mr2740487f8f.22.1722604496716; 
 Fri, 02 Aug 2024 06:14:56 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:4fc9:a3ab:c134:cdf4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0cc58sm1970304f8f.2.2024.08.02.06.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 06:14:56 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>,
 Matteo Lisi <matteo.lisi@engicam.com>, Tom Rini <trini@konsulko.com>,
 Gilles Talis <gilles.talis@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marex@denx.de>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Petr Zejdl <petr.zejdl@cern.ch>, Shiji Yang <yangshiji66@outlook.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Sean Anderson <sean.anderson@seco.com>, Artur Rojek <artur@conclusive.pl>,
 Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
 Yang Xiwen <forbidden405@outlook.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Boon Khai Ng <boon.khai.ng@intel.com>
Subject: [PATCH v6 08/20] net-lwip: add DHCP support and dhcp commmand
Date: Fri,  2 Aug 2024 15:13:55 +0200
Message-Id: <3b5b101e621173d67955ba5e009bd0a1b805bf61.1722601509.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1722601509.git.jerome.forissier@linaro.org>
References: <cover.1722601509.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 02 Aug 2024 16:22:11 +0200
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

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 board/engicam/imx8mp/icore_mx8mp.c            |   2 +-
 .../imx8mp_debix_model_a.c                    |   2 +-
 board/ti/am335x/board.c                       |   2 +-
 board/xilinx/common/board.c                   |   2 +-
 boot/Kconfig                                  |   3 +-
 cmd/Kconfig                                   |  91 +++---
 cmd/Makefile                                  |   6 +-
 cmd/elf.c                                     |   2 +-
 cmd/net-lwip.c                                |  13 +
 common/board_r.c                              |   4 +-
 common/usb_kbd.c                              |   2 +-
 drivers/net/Kconfig                           |   2 +-
 include/net-lwip.h                            |   3 +
 lib/tiny-printf.c                             |   2 +-
 net/Makefile                                  |  15 +-
 net/lwip/Makefile                             |   5 +
 net/lwip/dhcp.c                               | 127 ++++++++
 net/lwip/eth_internal.h                       |  35 +++
 net/lwip/net-lwip.c                           | 292 ++++++++++++++++++
 net/lwip/tftp.c                               |  11 +
 20 files changed, 566 insertions(+), 55 deletions(-)
 create mode 100644 cmd/net-lwip.c
 create mode 100644 net/lwip/Makefile
 create mode 100644 net/lwip/dhcp.c
 create mode 100644 net/lwip/eth_internal.h
 create mode 100644 net/lwip/net-lwip.c
 create mode 100644 net/lwip/tftp.c

diff --git a/board/engicam/imx8mp/icore_mx8mp.c b/board/engicam/imx8mp/icore_mx8mp.c
index e2ed70caa43..c5328743016 100644
--- a/board/engicam/imx8mp/icore_mx8mp.c
+++ b/board/engicam/imx8mp/icore_mx8mp.c
@@ -33,7 +33,7 @@ static void setup_fec(void)
 	setbits_le32(&gpr->gpr[1], BIT(22));
 }
 
-#if CONFIG_IS_ENABLED(NET)
+#if !CONFIG_IS_ENABLED(NO_NET)
 int board_phy_config(struct phy_device *phydev)
 {
 	if (phydev->drv->config)
diff --git a/board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c b/board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c
index 112770ba493..1bb4ea75d5a 100644
--- a/board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c
+++ b/board/polyhex/imx8mp_debix_model_a/imx8mp_debix_model_a.c
@@ -29,7 +29,7 @@ static void setup_fec(void)
 	setbits_le32(&gpr->gpr[1], BIT(22));
 }
 
-#if CONFIG_IS_ENABLED(NET)
+#if !CONFIG_IS_ENABLED(NO_NET)
 int board_phy_config(struct phy_device *phydev)
 {
 	if (phydev->drv->config)
diff --git a/board/ti/am335x/board.c b/board/ti/am335x/board.c
index 34f4a919656..4b90d69c2d0 100644
--- a/board/ti/am335x/board.c
+++ b/board/ti/am335x/board.c
@@ -901,7 +901,7 @@ int board_late_init(void)
 #endif
 
 /* CPSW plat */
-#if CONFIG_IS_ENABLED(NET) && !CONFIG_IS_ENABLED(OF_CONTROL)
+#if !CONFIG_IS_ENABLED(NO_NET) && !CONFIG_IS_ENABLED(OF_CONTROL)
 struct cpsw_slave_data slave_data[] = {
 	{
 		.slave_reg_ofs  = CPSW_SLAVE0_OFFSET,
diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
index 0b43407b9e9..4c34a39e5ea 100644
--- a/board/xilinx/common/board.c
+++ b/board/xilinx/common/board.c
@@ -495,7 +495,7 @@ int board_late_init_xilinx(void)
 				ret |= env_set_by_index("uuid", id, uuid);
 			}
 
-			if (!CONFIG_IS_ENABLED(NET))
+			if (CONFIG_IS_ENABLED(NO_NET))
 				continue;
 
 			for (i = 0; i < EEPROM_HDR_NO_OF_MAC_ADDR; i++) {
diff --git a/boot/Kconfig b/boot/Kconfig
index 11175fb7bb2..d7ce868fda7 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -380,7 +380,7 @@ config BOOT_DEFAULTS_CMDS
 	select CMD_PART if PARTITIONS
 	select CMD_DHCP if CMD_NET
 	select CMD_PING if CMD_NET
-	select CMD_PXE if CMD_NET
+	select CMD_PXE if (CMD_NET && !NET_LWIP)
 	select CMD_BOOTI if ARM64
 	select CMD_BOOTZ if ARM && !ARM64
 	imply CMD_MII if NET
@@ -540,6 +540,7 @@ config BOOTMETH_EXTLINUX_PXE
 config BOOTMETH_EFILOADER
 	bool "Bootdev support for EFI boot"
 	depends on EFI_BINARY_EXEC
+	select CMD_TFTPBOOT if CMD_NET
 	default y
 	help
 	  Enables support for EFI boot using bootdevs. This makes the
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 40ac5a8dbac..a7f6d23d248 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1774,12 +1774,16 @@ config CMD_AB_SELECT
 
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
@@ -1788,12 +1792,6 @@ config CMD_BOOTP
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
@@ -1937,12 +1935,6 @@ config DHCP6_ENTERPRISE_ID
 
 endif
 
-config CMD_TFTPBOOT
-	bool "tftpboot"
-	default y
-	help
-	  tftpboot - load file via network using TFTP protocol
-
 config CMD_TFTPPUT
 	bool "tftp put"
 	depends on CMD_TFTPBOOT
@@ -2001,29 +1993,6 @@ config CMD_WGET
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
@@ -2072,7 +2041,7 @@ config IPV6_ROUTER_DISCOVERY
 	help
 	  Will automatically perform router solicitation on first IPv6
 	  network operation
-endif
+endif  # if CMD_NET
 
 config CMD_ETHSW
 	bool "ethsw"
@@ -2085,6 +2054,7 @@ config CMD_ETHSW
 config CMD_PXE
 	bool "pxe"
 	select PXE_UTILS
+	depends on !NET_LWIP
 	help
 	  Boot image via network using PXE protocol
 
@@ -2093,7 +2063,52 @@ config CMD_WOL
 	help
 	  Wait for wake-on-lan Magic Packet
 
-endif
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
+endif  # if NET || NET_LWIP
 
 menu "Misc commands"
 
diff --git a/cmd/Makefile b/cmd/Makefile
index 87133cc27a8..fe733cf6ba9 100644
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
index 32b7462f92a..70a64b69554 100644
--- a/cmd/elf.c
+++ b/cmd/elf.c
@@ -128,7 +128,7 @@ int do_bootvx(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
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
index c823cd262f1..db15742763d 100644
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
@@ -727,7 +727,7 @@ static init_fnc_t init_sequence_r[] = {
 #ifdef CONFIG_PCI_ENDPOINT
 	pci_ep_init,
 #endif
-#ifdef CONFIG_CMD_NET
+#if defined(CONFIG_CMD_NET)
 	INIT_FUNC_WATCHDOG_RESET
 	initr_net,
 #endif
diff --git a/common/usb_kbd.c b/common/usb_kbd.c
index f3b4a3c94e6..1a7d8ca9a67 100644
--- a/common/usb_kbd.c
+++ b/common/usb_kbd.c
@@ -418,7 +418,7 @@ static int usb_kbd_testc(struct stdio_dev *sdev)
 	 */
 	unsigned long poll_delay = CONFIG_SYS_HZ / 50;
 
-#ifdef CONFIG_CMD_NET
+#if defined(CONFIG_CMD_NET) && !defined(CONFIG_NET_LWIP)
 	/*
 	 * If net_busy_flag is 1, NET transfer is running,
 	 * then we check key-pressed every second (first check may be
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index d332f712a7c..1dc69224aa8 100644
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
index 9a70c6095b3..c2492b69a13 100644
--- a/lib/tiny-printf.c
+++ b/lib/tiny-printf.c
@@ -269,7 +269,7 @@ static int _vprintf(struct printf_info *info, const char *fmt, va_list va)
 				}
 				break;
 			case 'p':
-				if (CONFIG_IS_ENABLED(NET) || _DEBUG) {
+				if (!CONFIG_IS_ENABLED(NO_NET) || _DEBUG) {
 					pointer(info, fmt, va_arg(va, void *));
 					/*
 					 * Skip this because it pulls in _ctype which is
diff --git a/net/Makefile b/net/Makefile
index 70eec8caf0d..9b30e961d07 100644
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
@@ -42,3 +37,13 @@ obj-$(CONFIG_CMD_WGET) += wget.o
 CFLAGS_eth_common.o += -Wno-format-extra-args
 
 endif
+
+ifeq ($(filter y,$(CONFIG_NET) $(CONFIG_NET_LWIP)),y)
+obj-$(CONFIG_$(SPL_TPL_)BOOTDEV_ETH) += eth_bootdev.o
+obj-$(CONFIG_DM_MDIO)  += mdio-uclass.o
+obj-$(CONFIG_DM_MDIO_MUX) += mdio-mux-uclass.o
+obj-$(CONFIG_$(SPL_)DM_ETH) += eth-uclass.o
+obj-$(CONFIG_$(SPL_)DM_ETH) += eth_common.o
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
index 00000000000..3c1eeaf9fb1
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
+	char *srvipstr = "serverip\0\0";
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
+		sprintf(srvipstr, "serverip%d", idx);
+	}
+
+	env_set(ipstr, ip4addr_ntoa(&dhcp->offered_ip_addr));
+	env_set(maskstr, ip4addr_ntoa(&dhcp->offered_sn_mask));
+	env_set(srvipstr, ip4addr_ntoa(&dhcp->server_ip_addr));
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
index 00000000000..e258d3df3ef
--- /dev/null
+++ b/net/lwip/net-lwip.c
@@ -0,0 +1,292 @@
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
+        static bool called;
+	int i;
+
+        if (called)
+		return;
+	called = true;
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
+	bool first_call = true;
+
+	if (!udev)
+		return NULL;
+
+	if (first_call) {
+		/* Pick a valid active device, if any */
+		eth_init();
+		first_call = false;
+	}
+
+	eth_init_rings();
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
+
+#if defined(CONFIG_API) || defined(CONFIG_EFI_LOADER)
+			if (push_packet)
+				(*push_packet)(packet, len);
+#endif
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

