Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26854C27C55
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 16:37:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 589708851A;
	Thu,  6 Jun 2024 18:34:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iNMF5t7V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12F3588266; Thu,  6 Jun 2024 15:37:07 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30BD0883E3
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 15:37:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-421396e3918so13067605e9.0
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 06:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717681022; x=1718285822; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4RzFAA9LYOYXHC/Gax1OLSKwhVCmqlmkqrYorjPNo60=;
 b=iNMF5t7VX5700e8W8FWIytooH9O7m6p6ABMZfnO50fm5rdgL+4Bmc0xB9RgHZUgFSk
 Rnuy7h0P8NuQhM6u4U1z0D9WIF9lDyJlKelRGn2ZTpBml85WCFmQv+xXCRktilFHmN65
 CMB7if6kTrV6rDMdFi5BXHLbR+gO1ioDdW3j+i3rBeQVjYSZteGlpomskU9Gl0gyW8wM
 3ecy5f8820BxOCE/QoMzF/vBVXRpLQawEAz8QJxMtXNvdKyi6UYmFJqawU/fgieJwqm3
 4SUZbXn/wfWshrGjQ7dfE8Avk+j4EVT4wzU91oFuZo1QML1cS5Du4zo8uNtD1FHxrY2Z
 8DIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717681022; x=1718285822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4RzFAA9LYOYXHC/Gax1OLSKwhVCmqlmkqrYorjPNo60=;
 b=fzi/NYhNLQI9H1LePJYHAP0WiUwqDIAGA6pzb0IjoRQlh26xw9pzen7Hpa/pHj6/hE
 FJcL9VmaL4YoHuYERZXJWvmAADer6AZ3Gw4RCLdGAFmlpRoj3saLxeq5Yt0JM08BMkMn
 IZY73ERTy7oumDyvrKD/DH0ZO4MTP8GTLHyaEeqypq8mIzsNITHMc8fBJ1733uIRlRZD
 VUileumytkPBnvaeEHCUb/SXnasa+JrSmM3mdmEmZCyUri16UPICWgbf6+UIjJ9Lkd69
 wtR0yr853T2sH0JFvtVPGKc1aTkH/69qsfWr5ZzWb7EMVzUTH/IvhvVYc6bQYRgXPVX6
 bx1g==
X-Gm-Message-State: AOJu0Yx+Z/FEMVyRBLNH+SBZuz8RbyxrXGJrRAvGWHHP09XvTryp6twQ
 me1igAo6Stj11AYtN5KLe92s9YBLv5TnLQDbU9rpk8xnGO/SlYJTchWz6m8gTJjyXrdQI8J9q8N
 vaXDoaX6Z
X-Google-Smtp-Source: AGHT+IGs1hDSu1XkkBYLSLE01jiRkU5HbWIH04cs8ns8aiuSV2MIqWwMpyiEh8vgEfTq0Iz/PrMZsg==
X-Received: by 2002:a05:600c:6a82:b0:421:54da:8dff with SMTP id
 5b1f17b1804b1-42156357040mr55997215e9.41.1717681021627; 
 Thu, 06 Jun 2024 06:37:01 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c19d52dsm23111955e9.8.2024.06.06.06.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 06:37:01 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Artur Rojek <artur@conclusive.pl>, Bin Meng <bmeng.cn@gmail.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Jonas Karlman <jonas@kwiboo.se>, Boon Khai Ng <boon.khai.ng@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 03/12] net-lwip: add DHCP support and dhcp commmand
Date: Thu,  6 Jun 2024 15:35:58 +0200
Message-Id: <02e13fa4f3a1779afaa16f55cff5fb3bf68ce903.1717680809.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1717680809.git.jerome.forissier@linaro.org>
References: <cover.1717680809.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Jun 2024 18:34:03 +0200
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
well as the dhcp command.
- net-lwip/net-lwip.c is mostly empty for now. It will provide functions
similar to net/net.c except based on the lwIP stack
- include/net-lwip.h is a replacement for include/net.h which is unused
when NET_LWIP is enabled. Declarations from the latter will be
transferred to the former as needed when new network commands are ported
on top of lwIP.
- CMD_TFTPBOOT is selected by BOOTMETH_EFI due to this code having
an implicit dependency on do_tftpb().

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 Makefile                |   1 +
 boot/Kconfig            |   3 +-
 cmd/Kconfig             |  26 +++++
 cmd/Makefile            |   4 +
 cmd/net-lwip.c          |  13 +++
 common/board_r.c        |   4 +-
 drivers/net/Kconfig     |   2 +-
 include/net-lwip.h      |  85 +++++++++++++++
 include/net.h           |   2 +-
 net-lwip/Makefile       |  15 +++
 net-lwip/dhcp.c         | 105 +++++++++++++++++++
 net-lwip/eth_internal.h |  35 +++++++
 net-lwip/net-lwip.c     | 224 ++++++++++++++++++++++++++++++++++++++++
 net-lwip/tftp.c         |  11 ++
 14 files changed, 525 insertions(+), 5 deletions(-)
 create mode 100644 cmd/net-lwip.c
 create mode 100644 include/net-lwip.h
 create mode 100644 net-lwip/Makefile
 create mode 100644 net-lwip/dhcp.c
 create mode 100644 net-lwip/eth_internal.h
 create mode 100644 net-lwip/net-lwip.c
 create mode 100644 net-lwip/tftp.c

diff --git a/Makefile b/Makefile
index ceb99a2698e..d3c9e6775dc 100644
--- a/Makefile
+++ b/Makefile
@@ -860,6 +860,7 @@ libs-y += env/
 libs-y += lib/
 libs-y += fs/
 libs-$(CONFIG_NET) += net/
+libs-$(CONFIG_NET_LWIP) += net-lwip/
 libs-y += disk/
 libs-y += drivers/
 libs-$(CONFIG_SYS_FSL_DDR) += drivers/ddr/fsl/
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
index 00000000000..966d7226eda
--- /dev/null
+++ b/cmd/net-lwip.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2024 Linaro Ltd. */
+
+#include <command.h>
+#include <net-lwip.h>
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
index b2d7b499766..4ba09c9d6f8 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -96,7 +96,7 @@ config DSA_SANDBOX
 
 menuconfig NETDEVICES
 	bool "Network device support"
-	depends on NET
+	depends on NET || NET_LWIP
 	select DM_ETH
 	help
 	  You must select Y to enable any network device support
diff --git a/include/net-lwip.h b/include/net-lwip.h
new file mode 100644
index 00000000000..2308703e46b
--- /dev/null
+++ b/include/net-lwip.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __NET_LWIP_H__
+#define __NET_LWIP_H__
+
+#include <asm/cache.h>
+#include <linux/types.h>
+#include <lwip/netif.h>
+#include <time.h>
+
+/*
+ *	The number of receive packet buffers, and the required packet buffer
+ *	alignment in memory.
+ *
+ */
+#define PKTBUFSRX	CONFIG_SYS_RX_ETH_BUFFER
+#define PKTALIGN	ARCH_DMA_MINALIGN
+
+/* ARP hardware address length */
+#define ARP_HLEN 6
+
+/*
+ * Maximum packet size; used to allocate packet storage. Use
+ * the maxium Ethernet frame size as specified by the Ethernet
+ * standard including the 802.1Q tag (VLAN tagging).
+ * maximum packet size =  1522
+ * maximum packet size and multiple of 32 bytes =  1536
+ */
+#define PKTSIZE			1522
+#ifndef CONFIG_DM_DSA
+#define PKTSIZE_ALIGN		1536
+#else
+/* Maximum DSA tagging overhead (headroom and/or tailroom) */
+#define DSA_MAX_OVR		256
+#define PKTSIZE_ALIGN		(1536 + DSA_MAX_OVR)
+#endif
+
+struct udevice *eth_get_dev(void); /* get the current device */
+/*
+ * Get the hardware address for an ethernet interface .
+ * Args:
+ *	base_name - base name for device (normally "eth")
+ *	index - device index number (0 for first)
+ *	enetaddr - returns 6 byte hardware address
+ * Returns:
+ *	Return true if the address is valid.
+ */
+int eth_env_get_enetaddr_by_index(const char *base_name, int index,
+				 uchar *enetaddr);
+int eth_init(void);			/* Initialize the device */
+int eth_send(void *packet, int length);	   /* Send a packet */
+int eth_rx(void);
+int eth_get_dev_index(void);
+int eth_init_state_only(void); /* Set active state */
+void eth_set_current(void);		/* set nterface to ethcur var */
+
+struct ethernet_hdr {
+	u8		et_dest[ARP_HLEN];	/* Destination node	*/
+	u8		et_src[ARP_HLEN];	/* Source node		*/
+	u16		et_protlen;		/* Protocol or length	*/
+} __attribute__((packed));
+
+/* Ethernet header size */
+#define ETHER_HDR_SIZE	(sizeof(struct ethernet_hdr))
+
+/**
+ * string_to_enetaddr() - Parse a MAC address
+ *
+ * Convert a string MAC address
+ *
+ * Implemented in lib/net_utils.c (built unconditionally)
+ *
+ * @addr: MAC address in aa:bb:cc:dd:ee:ff format, where each part is a 2-digit
+ *	hex value
+ * @enetaddr: Place to put MAC address (6 bytes)
+ */
+void string_to_enetaddr(const char *addr, uint8_t *enetaddr);
+
+int net_lwip_init(void);
+struct netif *net_lwip_get_netif(void);
+
+int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
+int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
+
+#endif /* __NET_LWIP_H__ */
diff --git a/include/net.h b/include/net.h
index ac511eab103..330bc6bf66c 100644
--- a/include/net.h
+++ b/include/net.h
@@ -914,7 +914,7 @@ static inline struct in_addr env_get_ip(char *var)
  */
 void reset_phy(void);
 
-#if CONFIG_IS_ENABLED(NET)
+#if CONFIG_IS_ENABLED(NET) || CONFIG_IS_ENABLED(NET_LWIP)
 /**
  * eth_set_enable_bootdevs() - Enable or disable binding of Ethernet bootdevs
  *
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
index 00000000000..d1d35999b04
--- /dev/null
+++ b/net-lwip/dhcp.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2024 Linaro Ltd. */
+
+#include <command.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <lwip/dhcp.h>
+#include <lwip/dns.h>
+#include <lwip/timeouts.h>
+#include <net-lwip.h>
+#include <time.h>
+
+#define DHCP_TIMEOUT_MS 2000
+
+#ifdef CONFIG_CMD_TFTPBOOT
+/* Boot file obtained from DHCP (if present) */
+static char boot_file_name[DHCP_BOOT_FILE_LEN];
+#endif
+
+static void call_lwip_dhcp_fine_tmr(void *ctx)
+{
+	dhcp_fine_tmr();
+}
+
+int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	unsigned long start;
+	struct netif *netif;
+	struct dhcp *dhcp;
+	bool bound;
+
+	/* Running DHCP on the primary interface only */
+	if (eth_get_dev_index() != 0)
+		return -EINVAL;
+
+	net_lwip_init();
+
+	netif = net_lwip_get_netif();
+	if (!netif)
+		return CMD_RET_FAILURE;
+
+	/*
+	 * The fine timer is half a second, it deals with the initial DHCP
+	 * request.
+	 * We don't bother with the coarse timer (1 minute) which handles the
+	 * DHCP lease renewal.
+	 */
+	sys_timeout(500, call_lwip_dhcp_fine_tmr, NULL);
+	start = get_timer(0);
+	dhcp_start(netif);
+
+	/* Wait for DHCP to complete */
+	do {
+		eth_rx();
+		sys_check_timeouts();
+		bound = dhcp_supplied_address(netif);
+		if (bound)
+			break;
+	} while (get_timer(start) < DHCP_TIMEOUT_MS);
+
+	sys_untimeout(call_lwip_dhcp_fine_tmr, NULL);
+
+	if (!bound)
+		return CMD_RET_FAILURE;
+
+	dhcp = netif_dhcp_data(netif);
+
+	env_set("bootfile", dhcp->boot_file_name);
+	if (dhcp->offered_gw_addr.addr != 0) {
+
+		env_set("gatewayip", ip4addr_ntoa(&dhcp->offered_gw_addr));
+		/* Set this interface as the default for IP routing */
+		netif_set_default(netif);
+	}
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
index 00000000000..886028b68c3
--- /dev/null
+++ b/net-lwip/net-lwip.c
@@ -0,0 +1,224 @@
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
+#include <net-lwip.h>
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
+int net_lwip_init(void)
+{
+	ip4_addr_t ipaddr, netmask, gw;
+	struct netif *unetif;
+	struct udevice *udev;
+	int ret;
+	unsigned char env_enetaddr[ARP_HLEN];
+	const struct udevice *dev;
+	struct uclass *uc;
+
+	eth_set_current();
+
+	udev = eth_get_dev();
+	if (!udev) {
+		log_err("no active eth device\n");
+		return ERR_IF;
+	}
+
+	eth_init_rings();
+
+	ret = eth_init();
+	if (ret) {
+		log_err("eth_init error %d\n", ret);
+		return ERR_IF;
+	}
+
+	uclass_id_foreach_dev(UCLASS_ETH, dev, uc) {
+		char ipstr[IP4ADDR_STRLEN_MAX];
+		char maskstr[IP4ADDR_STRLEN_MAX];
+		char gwstr[IP4ADDR_STRLEN_MAX];
+		char hwstr[MAC_ADDR_STRLEN];
+		char *env;
+
+		eth_env_get_enetaddr_by_index("eth", dev_seq(dev), env_enetaddr);
+		log_info("eth%d: %s %pM %s\n", dev_seq(dev), dev->name, env_enetaddr,
+			 udev == dev ? "active" : "");
+
+		unetif = malloc(sizeof(struct netif));
+		if (!unetif)
+			return ERR_MEM;
+		memset(unetif, 0, sizeof(struct netif));
+
+		ip4_addr_set_zero(&gw);
+		ip4_addr_set_zero(&ipaddr);
+		ip4_addr_set_zero(&netmask);
+
+		if (dev_seq(dev) == 0) {
+			snprintf(ipstr, IP4ADDR_STRLEN_MAX, "ipaddr");
+			snprintf(maskstr, IP4ADDR_STRLEN_MAX, "netmask");
+			snprintf(gwstr, IP4ADDR_STRLEN_MAX, "gw");
+		} else {
+			snprintf(ipstr, IP4ADDR_STRLEN_MAX, "ipaddr%d", dev_seq(dev));
+			snprintf(maskstr, IP4ADDR_STRLEN_MAX, "netmask%d", dev_seq(dev));
+			snprintf(gwstr, IP4ADDR_STRLEN_MAX, "gw%d", dev_seq(dev));
+		}
+		snprintf(hwstr, MAC_ADDR_STRLEN, "%pM",  env_enetaddr);
+		snprintf(unetif->name, 2, "%d", dev_seq(dev));
+
+		string_to_enetaddr(hwstr, unetif->hwaddr);
+		unetif->hwaddr_len = ETHARP_HWADDR_LEN;
+
+		env = env_get(ipstr);
+		if (env)
+			ipaddr_aton(env, &ipaddr);
+
+		env = env_get(maskstr);
+		if (env)
+			ipaddr_aton(env, &netmask);
+
+		if (!netif_add(unetif, &ipaddr, &netmask, &gw,
+			       unetif, net_lwip_if_init, netif_input)) {
+			log_err("err: netif_add failed!\n");
+			free(unetif);
+			return ERR_IF;
+		}
+
+		netif_set_up(unetif);
+		netif_set_link_up(unetif);
+	}
+
+	return CMD_RET_SUCCESS;
+}
+
+/*
+ * Return the current network interface for lwIP. In other words, the struct
+ * netif that corresponds to eth_get_dev().
+ */
+struct netif *net_lwip_get_netif(void)
+{
+	int idx;
+
+	idx = eth_get_dev_index();
+	if (idx < 0)
+		return NULL;
+
+	return netif_get_by_index(idx + 1);
+}
+
+int net_init(void)
+{
+	return net_lwip_init();
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

