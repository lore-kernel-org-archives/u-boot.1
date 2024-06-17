Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B8FC2BA15
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 15:34:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FE0D883A4;
	Mon, 17 Jun 2024 17:33:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EW91vjlZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF83288398; Mon, 17 Jun 2024 17:33:42 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BE688839F
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 17:33:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-422df2a81f2so32832585e9.0
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 08:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718638420; x=1719243220; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DgffOfhzfN11aJiGi57auQeHNFE++aK5yr2tVO39euQ=;
 b=EW91vjlZTyerQBezmrDqbbWsfXFdeHl0oCPfPgDbVseAfb/8x/Y52741EIbLA1NSKb
 8a8R34AjnyDgRVpzYEA9slyomJe/0WDu24cTRPexE3uRiJIqL0FVPWWAOuToeM3QUUQD
 XSEo3Ap0cjbv+4lRxVggFT8cciQR4bQr9TKc0RyLlJcKIjp0eNTpa9LsFJFsA2FViw8z
 0JE/0gDjlVPrHrRPdRg9Uuz7jl3B1KAL4Pzk9/UOuCraodtf3EAZG4TvtvvIGGqEN5Yn
 a5oLl2zv7R++iblCZc8EnfFWhHzcFDhkYZ99mplW0LTSr97pFsx9yh8iltWFttNpcNAF
 cYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718638420; x=1719243220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DgffOfhzfN11aJiGi57auQeHNFE++aK5yr2tVO39euQ=;
 b=bod51pwnEpYnGKjge/7qa5aMnocTEdoKyM6tLEb+TwaKxIiBVQWp4CxM5rxvJ8AwMH
 ehm0zGZI4m0vEdGkPzhuWh6d4spTXaU9aA+eH3PuaHcWmTruDW8ZCYYESeQ99cqTvvJk
 PnOA602IH1pKNbweMFOkNg26N/5w8WHtHSynhqE4ZK5EYgFA+3AaAaRdEo0ghoG6AR1i
 5w2OR2b0VvqfUFP59+vjLDYE1unU8Zj+a4FiRLPrJtAg/hTANGBX8oxBw4i2g/T4lWmt
 fm3uYEp54GDY498/3YeOUdCeNB5OshVJIoxXcXGUtmd4ic1rDOH8kVDSTw1Sba/3bXy+
 q8gA==
X-Gm-Message-State: AOJu0YzWZkaPpZ1l8wi9+R/8Dbkau6xu3ImWf/PsZN/tKd4iROrdCk1w
 yyZ2d6X6bV7EBjvxvK0NooJJuzaxVALQ5sHxS6a/5WAQgnj797OA288U4oCbdjgNL32KSdrBI3Z
 cRhA=
X-Google-Smtp-Source: AGHT+IEv8CC6SwlJWHqrrlKvW3qpO8ZfkktiDDfjk3qU35Gi9xpteWq51sKMdRU97g8ncSP5IEP91g==
X-Received: by 2002:a05:600c:c10:b0:421:d68a:e3f2 with SMTP id
 5b1f17b1804b1-4230482fbfbmr75791835e9.23.1718638419541; 
 Mon, 17 Jun 2024 08:33:39 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6e75:be8f:56ae:2b5e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f602f620sm161350895e9.19.2024.06.17.08.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 08:33:39 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, Sumit Garg <sumit.garg@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bryan Brattlof <bb@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Shiji Yang <yangshiji66@outlook.com>, Nikhil M Jain <n-jain1@ti.com>,
 Artur Rojek <artur@conclusive.pl>, Yang Xiwen <forbidden405@outlook.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Boon Khai Ng <boon.khai.ng@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v4 05/14] net-lwip: add DHCP support and dhcp commmand
Date: Mon, 17 Jun 2024 17:32:57 +0200
Message-Id: <1455663bf6d4f8537d3919b755ef5148b65975c5.1718638104.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1718638104.git.jerome.forissier@linaro.org>
References: <cover.1718638104.git.jerome.forissier@linaro.org>
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

Add what it takes to enable NETDEVICES with NET_LWIP and enable DHCP as
well as the dhcp command. CMD_TFTPBOOT is selected by BOOTMETH_EFI due
to this code having an implicit dependency on do_tftpb().

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 Makefile                |   6 +
 boot/Kconfig            |   3 +-
 cmd/Kconfig             |  26 ++++
 cmd/Makefile            |   4 +
 cmd/net-lwip.c          |  13 ++
 common/board_r.c        |   4 +-
 drivers/net/Kconfig     |   2 +-
 include/net-lwip.h      |   2 +
 net-lwip/Makefile       |  15 +++
 net-lwip/dhcp.c         |  99 +++++++++++++++
 net-lwip/eth_internal.h |  35 ++++++
 net-lwip/net-lwip.c     | 270 ++++++++++++++++++++++++++++++++++++++++
 net-lwip/tftp.c         |  11 ++
 13 files changed, 486 insertions(+), 4 deletions(-)
 create mode 100644 cmd/net-lwip.c
 create mode 100644 net-lwip/Makefile
 create mode 100644 net-lwip/dhcp.c
 create mode 100644 net-lwip/eth_internal.h
 create mode 100644 net-lwip/net-lwip.c
 create mode 100644 net-lwip/tftp.c

diff --git a/Makefile b/Makefile
index 0fe1623c550..92a0ab770bb 100644
--- a/Makefile
+++ b/Makefile
@@ -862,6 +862,7 @@ libs-y += env/
 libs-y += lib/
 libs-y += fs/
 libs-$(CONFIG_NET) += net/
+libs-$(CONFIG_NET_LWIP) += net-lwip/
 libs-y += disk/
 libs-y += drivers/
 libs-$(CONFIG_SYS_FSL_DDR) += drivers/ddr/fsl/
@@ -2132,6 +2133,11 @@ etags:
 cscope:
 		$(FIND) $(FINDFLAGS) $(TAG_SUBDIRS) -name '*.[chS]' -print > \
 						cscope.files
+ifdef CONFIG_NET_LWIP
+		echo net/eth-uclass.c net/eth_common.c net/eth_bootdev.c \
+		     net/mdio-uclass.c net/mdio-mux-uclass.c >> \
+						cscope.files
+endif
 		@find $(TAG_SUBDIRS) -name '*.[chS]' -type l -print | \
 			grep -xvf - cscope.files > cscope.files.no-symlinks; \
 		mv cscope.files.no-symlinks cscope.files
diff --git a/boot/Kconfig b/boot/Kconfig
index 6f3096c15a6..004e69dd92a 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -378,7 +378,7 @@ config BOOT_DEFAULTS_CMDS
 	select CMD_FAT
 	select CMD_FS_GENERIC
 	select CMD_PART if PARTITIONS
-	select CMD_DHCP if CMD_NET
+	select CMD_DHCP if CMD_NET || CMD_NET_LWIP
 	select CMD_PING if CMD_NET
 	select CMD_PXE if CMD_NET
 	select CMD_BOOTI if ARM64
@@ -540,6 +540,7 @@ config BOOTMETH_EXTLINUX_PXE
 config BOOTMETH_EFILOADER
 	bool "Bootdev support for EFI boot"
 	depends on EFI_BINARY_EXEC
+	select CMD_TFTPBOOT if CMD_NET_LWIP
 	default y
 	help
 	  Enables support for EFI boot using bootdevs. This makes the
diff --git a/cmd/Kconfig b/cmd/Kconfig
index b026439c773..1bfa528e945 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2084,6 +2084,32 @@ config CMD_WOL
 
 endif
 
+if NET_LWIP
+
+menuconfig CMD_NET_LWIP
+	bool "Network commands (lwIP)"
+	default y
+
+if CMD_NET_LWIP
+
+config CMD_DHCP
+	bool "dhcp"
+	select PROT_DHCP_LWIP
+	help
+	  Boot image via network using DHCP/TFTP protocol
+
+config CMD_TFTPBOOT
+	bool "tftp"
+	select PROT_UDP_LWIP
+	default n
+	help
+	  tftpboot - load file via network using TFTP protocol
+	  Currently a placeholder (not implemented)
+
+endif
+
+endif
+
 menu "Misc commands"
 
 config CMD_2048
diff --git a/cmd/Makefile b/cmd/Makefile
index 87133cc27a8..535b6838ca5 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -128,6 +128,10 @@ endif
 obj-$(CONFIG_CMD_MUX) += mux.o
 obj-$(CONFIG_CMD_NAND) += nand.o
 obj-$(CONFIG_CMD_NET) += net.o
+obj-$(CONFIG_CMD_NET_LWIP) += net-lwip.o
+ifdef CONFIG_CMD_NET_LWIP
+CFLAGS_net-lwip.o := -I$(srctree)/lib/lwip/lwip/src/include -I$(srctree)/lib/lwip/u-boot
+endif
 obj-$(CONFIG_ENV_SUPPORT) += nvedit.o
 obj-$(CONFIG_CMD_NVEDIT_EFI) += nvedit_efi.o
 obj-$(CONFIG_CMD_ONENAND) += onenand.o
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
index da0b80f24ff..6548eb8fdd5 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -472,7 +472,7 @@ static int initr_status_led(void)
 }
 #endif
 
-#ifdef CONFIG_CMD_NET
+#if defined(CONFIG_CMD_NET) || defined(CONFIG_CMD_NET_LWIP)
 static int initr_net(void)
 {
 	puts("Net:   ");
@@ -727,7 +727,7 @@ static init_fnc_t init_sequence_r[] = {
 #ifdef CONFIG_PCI_ENDPOINT
 	pci_ep_init,
 #endif
-#ifdef CONFIG_CMD_NET
+#if defined(CONFIG_CMD_NET) || defined(CONFIG_CMD_NET_LWIP)
 	INIT_FUNC_WATCHDOG_RESET
 	initr_net,
 #endif
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index efc55e45ca8..640c4218518 100644
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
index f5c743b8d11..46cf6875f7e 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -11,4 +11,6 @@ struct netif *net_lwip_new_netif_noip(void);
 void net_lwip_remove_netif(struct netif *netif);
 struct netif *net_lwip_get_netif(void);
 
+int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
+
 #endif /* __NET_LWIP_H__ */
diff --git a/net-lwip/Makefile b/net-lwip/Makefile
new file mode 100644
index 00000000000..a56c32bfa74
--- /dev/null
+++ b/net-lwip/Makefile
@@ -0,0 +1,15 @@
+ccflags-y += -I$(srctree)/lib/lwip/lwip/src/include -I$(srctree)/lib/lwip/u-boot
+
+obj-$(CONFIG_$(SPL_TPL_)BOOTDEV_ETH) += ../net/eth_bootdev.o
+obj-$(CONFIG_DM_MDIO)  += ../net/mdio-uclass.o
+obj-$(CONFIG_DM_MDIO_MUX) += ../net/mdio-mux-uclass.o
+obj-$(CONFIG_$(SPL_)DM_ETH) += ../net/eth_common.o
+obj-$(CONFIG_$(SPL_)DM_ETH) += ../net/eth-uclass.o
+obj-$(CONFIG_$(SPL_)DM_ETH) += net-lwip.o
+obj-$(CONFIG_CMD_DHCP) += dhcp.o
+obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
+
+# Disable this warning as it is triggered by:
+# sprintf(buf, index ? "foo%d" : "foo", index)
+# and this is intentional usage.
+CFLAGS_eth_common.o += -Wno-format-extra-args
diff --git a/net-lwip/dhcp.c b/net-lwip/dhcp.c
new file mode 100644
index 00000000000..38ea565508f
--- /dev/null
+++ b/net-lwip/dhcp.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2024 Linaro Ltd. */
+
+#include <command.h>
+#include <console.h>
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
+int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	unsigned long start;
+	struct netif *netif;
+	struct dhcp *dhcp;
+	bool bound;
+
+	netif = net_lwip_new_netif_noip();
+	if (!netif)
+		return CMD_RET_FAILURE;
+
+	start = get_timer(0);
+	dhcp_start(netif);
+	call_lwip_dhcp_fine_tmr(NULL);
+
+	/* Wait for DHCP to complete */
+	do {
+		eth_rx();
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
+	if (dhcp->offered_gw_addr.addr != 0)
+		env_set("gatewayip", ip4addr_ntoa(&dhcp->offered_gw_addr));
+	env_set("ipaddr", ip4addr_ntoa(&dhcp->offered_ip_addr));
+	env_set("netmask", ip4addr_ntoa(&dhcp->offered_sn_mask));
+	env_set("serverip", ip4addr_ntoa(&dhcp->server_ip_addr));
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
diff --git a/net-lwip/eth_internal.h b/net-lwip/eth_internal.h
new file mode 100644
index 00000000000..0b829a8d388
--- /dev/null
+++ b/net-lwip/eth_internal.h
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
diff --git a/net-lwip/net-lwip.c b/net-lwip/net-lwip.c
new file mode 100644
index 00000000000..39e7e51e542
--- /dev/null
+++ b/net-lwip/net-lwip.c
@@ -0,0 +1,270 @@
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
+static uchar net_pkt_buf[(PKTBUFSRX+1) * PKTSIZE_ALIGN + PKTALIGN];
+uchar *net_rx_packets[PKTBUFSRX];
+uchar *net_rx_packet;
+uchar *net_tx_packet;
+
+static err_t low_level_output(struct netif *netif, struct pbuf *p)
+{
+        int err;
+
+	/*
+	 * lwIP is alwys configured to use one device, the active one, so
+	 * there is no need to use the netif parameter.
+	 */
+
+        /* switch dev to active state */
+        eth_init_state_only();
+
+        err = eth_send(p->payload, p->len);
+        if (err) {
+                log_err("eth_send error %d\n", err);
+                return ERR_ABRT;
+        }
+        return ERR_OK;
+}
+
+static err_t net_lwip_if_init(struct netif *netif)
+{
+#if LWIP_IPV4
+	netif->output = etharp_output;
+#endif
+	netif->linkoutput = low_level_output;
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
+	net_tx_packet = &net_pkt_buf[0] + (PKTALIGN - 1);
+	net_tx_packet -= (ulong)net_tx_packet % PKTALIGN;
+	for (i = 0; i < PKTBUFSRX; i++)
+		net_rx_packets[i] = net_tx_packet + (i + 1) * PKTSIZE_ALIGN;
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
+	char ipstr[9] = { 'i', 'p', 'a' , 'd', 'd', 'r', };
+	char maskstr[10] = { 'n', 'e', 't', 'm', 'a', 's', 'k', };
+	char gwstr[12] = { 'g', 'a', 't', 'e', 'w', 'a', 'y', 'i', 'p', };
+	char *env;
+	int ret;
+
+	if (dev_seq(dev) > 0) {
+		ret = snprintf(ipstr, sizeof(ipstr), "ipaddr%d", dev_seq(dev));
+		if (ret < 0 || ret >= sizeof(ipstr))
+			return -1;
+		snprintf(maskstr, sizeof(maskstr), "netmask%d", dev_seq(dev));
+		if (ret < 0 || ret >= sizeof(maskstr))
+			return -1;
+		snprintf(gwstr, sizeof(gwstr), "gw%d", dev_seq(dev));
+		if (ret < 0 || ret >= sizeof(gwstr))
+			return -1;
+	}
+
+	ip4_addr_set_zero(ip);
+	ip4_addr_set_zero(mask);
+	ip4_addr_set_zero(gw);
+
+	env = env_get(ipstr);
+	if (env)
+		ipaddr_aton(env, ip);
+
+	env = env_get(maskstr);
+	if (env)
+		ipaddr_aton(env, mask);
+
+	env = env_get(gwstr);
+	if (env)
+		ipaddr_aton(env, gw);
+
+	return 0;
+}
+
+static struct netif *new_netif(bool with_ip)
+{
+	unsigned char enetaddr[ARP_HLEN];
+	char hwstr[MAC_ADDR_STRLEN];
+	ip4_addr_t ip, mask, gw;
+	struct udevice *dev;
+	struct netif *netif;
+	int ret;
+	static bool first_call = true;
+
+	eth_init_rings();
+
+	if (first_call) {
+		if (eth_init()) {
+			printf("eth_init() error\n");
+			return NULL;
+		}
+		first_call = false;
+	}
+
+	netif_remove(net_lwip_get_netif());
+
+	eth_set_current();
+
+	dev = eth_get_dev();
+	if (!dev)
+		return NULL;
+
+	ip4_addr_set_zero(&ip);
+	ip4_addr_set_zero(&mask);
+	ip4_addr_set_zero(&gw);
+
+	if (with_ip)
+		if (get_udev_ipv4_info(dev, &ip, &mask, &gw) < 0)
+			return NULL;
+
+	eth_env_get_enetaddr_by_index("eth", dev_seq(dev), enetaddr);
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
+
+	if (!netif_add(netif, &ip, &mask, &gw, netif, net_lwip_if_init,
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
+/* Configure lwIP to use the currently active network device */
+struct netif *net_lwip_new_netif()
+{
+	return new_netif(true);
+}
+
+struct netif *net_lwip_new_netif_noip()
+{
+
+	return new_netif(false);
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
+	net_lwip_new_netif();
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
+void net_process_received_packet(uchar *in_packet, int len)
+{
+	struct netif *netif;
+	struct pbuf *pbuf;
+
+	if (len < ETHER_HDR_SIZE)
+		return;
+
+#if defined(CONFIG_API) || defined(CONFIG_EFI_LOADER)
+	if (push_packet) {
+		(*push_packet)(in_packet, len);
+		return;
+	}
+#endif
+
+	netif = net_lwip_get_netif();
+	if (!netif)
+		return;
+
+	pbuf = alloc_pbuf_and_copy(in_packet, len);
+	if (!pbuf)
+		return;
+
+	netif->input(pbuf, netif);
+}
+
+u32_t sys_now(void)
+{
+	return get_timer(0);
+}
diff --git a/net-lwip/tftp.c b/net-lwip/tftp.c
new file mode 100644
index 00000000000..1fa246f55d9
--- /dev/null
+++ b/net-lwip/tftp.c
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

