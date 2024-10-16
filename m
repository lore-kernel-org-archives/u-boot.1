Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EEFD1AD59
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 13:33:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8AF988DDC;
	Wed, 16 Oct 2024 15:33:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vWf+EHpn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD97D89003; Wed, 16 Oct 2024 12:04:59 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06C8B88FE8
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 12:04:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-430ee5c9570so75526475e9.3
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 03:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729073094; x=1729677894; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lsMAHOHHZRi/aHl47rJpZjLPq4/Y1PUWpeND0mSAp90=;
 b=vWf+EHpnzKDL5l9N1WMW0SQGGfPUOpVTT2/y8QZSHC1PJkAsillXKvkrU+2STfsuIa
 9uc3+xk4JKMgNX6g1Nnx/xSZNRpGI3FXoV933OaGg5jaZDZrwEDEm38N/3o202ClJdVc
 bfKBBQ820gHvIH3Z4UvAVlLmt/t/zxUbTeSFR8QNJsSqhr6hV/FfbCoiv2OZiroJfWWc
 /7xphCtv9EMyNJ/xYUXtLgP+2eSkmPQdvTKKEniVqBuia3pGs6p3dKQiEsp7UMzg6RAt
 VsUkeagQ3KBD/TlCq8pBUGqTVxaunv1ZT9lkmP0cVKM+gEUdV7BnT7W1FwIQRRrK+/dA
 vJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729073094; x=1729677894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lsMAHOHHZRi/aHl47rJpZjLPq4/Y1PUWpeND0mSAp90=;
 b=TudK+Qpoj2RguUTzcgF/GuNk5/Kd92NetmmB72NDV+Oby05NYmbUsEN97cJt5zMAR4
 Y21eTJJyoZPHkYP9nm54HnlVWLAetF2KIWMcK0Njlto8kYSEdaXP/WpoWJIwSIQZ4RVI
 fboK80UwJFW9bIacUslacIxST5XCK/+ebUTjYZshAYoi4Bg4Z/CUwNCxv0kwAyv3Oh6J
 x838R5DSYoVrn5j4XyD3IhGOYMFvYCEV4TxMv40K8rfHygSj62XGU2jy+96b/CEMM7tN
 fXSJ64lejxouWH0AZQ9Hrh5T29JsQt50/tJYtUeSKHgUs0vODVJpK6IxvbNSSGY/qxqy
 rs1w==
X-Gm-Message-State: AOJu0YzQGWQN6mz55ttXcduI43cmvC0aVqQAtnJU122Rse86eL/vLMuQ
 GKzEcB7V2vMrKW+7Qa7k2x5QfTzeoc1qoaKjz8AQyELZfiuBCQFrwdi1FGpuKOnDsw+MRFAVGqn
 QuhLd+C3V
X-Google-Smtp-Source: AGHT+IHATEAP8isg8Ta5XgvU4wikyCkpXf3Yu/BAOTRQQnpUfybSopoqrEV17ihyQPv0cjG5BNAsvw==
X-Received: by 2002:a05:600c:4fd3:b0:431:54f3:11ab with SMTP id
 5b1f17b1804b1-43154f3151amr5850085e9.33.1729073093925; 
 Wed, 16 Oct 2024 03:04:53 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f56f241sm44634515e9.22.2024.10.16.03.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 03:04:53 -0700 (PDT)
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
 Simon Glass <sjg@chromium.org>, Nishanth Menon <nm@ti.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Padmarao Begari <padmarao.begari@amd.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Petr Zejdl <petr.zejdl@cern.ch>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Daniel Palmer <daniel@0x0f.com>,
 Artur Rojek <artur@conclusive.pl>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Christian Marangi <ansuelsmth@gmail.com>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Yang Xiwen <forbidden405@outlook.com>,
 Peter Robinson <pbrobinson@gmail.com>, Gabor Juhos <j4g8y7@gmail.com>,
 Philip Oberfichtner <pro@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Boon Khai Ng <boon.khai.ng@intel.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v13 09/21] net: lwip: add DHCP support and dhcp commmand
Date: Wed, 16 Oct 2024 12:04:03 +0200
Message-Id: <1c29b962ebe40fcb33b7c192a648ac86818f53b2.1729070678.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1729070678.git.jerome.forissier@linaro.org>
References: <cover.1729070678.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 16 Oct 2024 15:33:18 +0200
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
Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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
 net/lwip/dhcp.c                               | 130 ++++++++
 net/lwip/eth_internal.h                       |  35 +++
 net/lwip/net-lwip.c                           | 289 ++++++++++++++++++
 net/lwip/tftp.c                               |  11 +
 21 files changed, 573 insertions(+), 62 deletions(-)
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
index 720bf2cb3e1..774ef7ac5e3 100644
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
index 68f401e4b34..38dd80533fa 100644
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
index 6d20d7597cb..211be398937 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1789,12 +1789,16 @@ config CMD_AB_SELECT
 
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
@@ -1803,12 +1807,6 @@ config CMD_BOOTP
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
@@ -1952,12 +1950,6 @@ config BOOTP_VCI_STRING
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
@@ -2017,29 +2009,6 @@ config CMD_WGET
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
@@ -2088,7 +2057,7 @@ config IPV6_ROUTER_DISCOVERY
 	help
 	  Will automatically perform router solicitation on first IPv6
 	  network operation
-endif
+endif  # if CMD_NET
 
 config CMD_ETHSW
 	bool "ethsw"
@@ -2098,6 +2067,56 @@ config CMD_ETHSW
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
@@ -2105,12 +2124,7 @@ config CMD_PXE
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
index 21d376309b9..94a3df41c6f 100644
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
index 114f2caf7fa..6b49c613703 100644
--- a/cmd/elf.c
+++ b/cmd/elf.c
@@ -133,7 +133,7 @@ int do_bootvx(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
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
index 1acad069d92..e5f33f40643 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -484,7 +484,7 @@ static int initr_boot_led_on(void)
 	return 0;
 }
 
-#ifdef CONFIG_CMD_NET
+#if defined(CONFIG_CMD_NET)
 static int initr_net(void)
 {
 	puts("Net:   ");
@@ -749,7 +749,7 @@ static init_fnc_t init_sequence_r[] = {
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
index fa6fc1cb8e4..89f7411bdf3 100644
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
index ed286e3d326..ca1efd17af7 100644
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
index 64dee779c4a..cc1dfe61cf7 100644
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
index 34fe50133a3..209377aeb26 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -12,11 +12,6 @@ obj-$(CONFIG_CMD_BOOTP) += bootp.o
 obj-$(CONFIG_CMD_CDP)  += cdp.o
 obj-$(CONFIG_CMD_DNS)  += dns.o
 obj-$(CONFIG_DM_DSA)   += dsa-uclass.o
-obj-$(CONFIG_$(XPL_)DM_ETH) += eth-uclass.o
-obj-$(CONFIG_$(PHASE_)BOOTDEV_ETH) += eth_bootdev.o
-obj-$(CONFIG_DM_MDIO)  += mdio-uclass.o
-obj-$(CONFIG_DM_MDIO_MUX) += mdio-mux-uclass.o
-obj-$(CONFIG_$(XPL_)DM_ETH) += eth_common.o
 obj-$(CONFIG_CMD_LINK_LOCAL) += link_local.o
 obj-$(CONFIG_IPV6)     += ndisc.o
 obj-$(CONFIG_$(XPL_)DM_ETH) += net.o
@@ -43,4 +38,13 @@ CFLAGS_eth_common.o += -Wno-format-extra-args
 
 endif
 
+ifeq ($(filter y,$(CONFIG_NET) $(CONFIG_NET_LWIP)),y)
+obj-$(CONFIG_$(XPL_)DM_ETH) += eth-uclass.o
+obj-$(CONFIG_$(PHASE_)BOOTDEV_ETH) += eth_bootdev.o
+obj-$(CONFIG_DM_MDIO)  += mdio-uclass.o
+obj-$(CONFIG_DM_MDIO_MUX) += mdio-mux-uclass.o
+obj-$(CONFIG_$(XPL_)DM_ETH) += eth_common.o
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
index 00000000000..a2cc25d88f5
--- /dev/null
+++ b/net/lwip/dhcp.c
@@ -0,0 +1,130 @@
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
+
+	if (dhcp_start(netif))
+		return CMD_RET_FAILURE;
+
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
index 00000000000..3b08ffe3b74
--- /dev/null
+++ b/net/lwip/net-lwip.c
@@ -0,0 +1,289 @@
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
+	netif->output = etharp_output;
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

