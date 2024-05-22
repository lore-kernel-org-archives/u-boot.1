Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16704C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 16:17:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A73A5888AB;
	Wed, 22 May 2024 18:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e4SljbSw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82BD587E06; Wed, 22 May 2024 18:04:21 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BA2B88096
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 18:04:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-572b37afd73so11723972a12.2
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 09:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716393856; x=1716998656; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rvkv0X/HINdq+j3jsczd7lMxOZN6eodUtcU788Qwq+4=;
 b=e4SljbSwGr4EN3KXPeEkL9Nx+x7bGYIfLE/V5/CyLt8M+eTgoRz98OzfIpSxty8Pdq
 IcZb649N+qMMPFrVKbwFqj5Hvg/sXB6Y7p1m+uYp21Xn6IWwPqJgBH73+PywezUak3lF
 11SUjLWM0MzUW5yE7IPJomBbnQ9s9yzBJAeX9JeMSC2/61PRA3KGsry4e+E7IxQhO1KV
 Wni0cTOeKlij3l+cbhCfk6XzM7cQjVSEvvxn5IIlR4532/3LrYMgMKtC4LwaWYdbmMdC
 /7Ev8Upd3cyVpWrE+t1k9zcuYBTnZ8QT1ULkszHDbwT9R6bg59Ci24bfX1HdJYOsT95P
 IOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716393856; x=1716998656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rvkv0X/HINdq+j3jsczd7lMxOZN6eodUtcU788Qwq+4=;
 b=n+qzD393uDvpqwNEQcAIUgTpSCyWXMHlwMdARIhUUeSLf6Gp+nOcB/F4xaLjKpqUuA
 k1FSYb4+H3+ca3TUXLHdQsR97V2f49bbsUSf/+5mgnWkfZ3cHebH+FPrJwIqaNvUTtop
 qBUDaw1zYxoMFEkVLoK8NcIjFYDwe3WDa524GdBh4sNT6c6+NI/P3q2EgFYKsCnj4ILZ
 Qj9PVaIxnEwx+8GpSF+Nh3BOXS7zL7emyFRRpqcjSQf0Thv6YYZ8GCgeRRYoSv0MFG7s
 0LxH/60C4XJjva8oDnOBvwFOapCWZwiCL/PrjIY+a3eyV/beCtjJA9rswGmMbp7spbAq
 /P+w==
X-Gm-Message-State: AOJu0YwyUwdjYUyFsfDW0XoOwR/k4m7NFwQysxoF0DJzacrBq73B5Cvv
 AoP6fps1Vsl54paF1e6mfgvajEcwNOL6/CsmyTGng67ckwjdRVmzz/8nsaS4FGZimsGKcyGBYoV
 dAyG/+KZm
X-Google-Smtp-Source: AGHT+IELsn9BFFg/ZoI3mBlH5Kb3sdIarQkea/LEdC1Cslc3hqXRBYbPqubKaal+P67JUDHHw43fZA==
X-Received: by 2002:a17:906:3c49:b0:a5a:3da6:7712 with SMTP id
 a640c23a62f3a-a6228170c75mr156734266b.71.1716393856036; 
 Wed, 22 May 2024 09:04:16 -0700 (PDT)
Received: from jerome-XPS-13-9310.. ([2a01:e0a:3cb:7bb0:d6a3:fbd6:c45b:172c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6209f64ba8sm367670266b.210.2024.05.22.09.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 09:04:15 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Andrew Davis <afd@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Bryan Brattlof <bb@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Eddie James <eajames@linux.ibm.com>, Shantur Rathore <i@shantur.com>,
 Bin Meng <bmeng.cn@gmail.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Artur Rojek <artur@conclusive.pl>, Shiji Yang <yangshiji66@outlook.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 03/15] net-lwip: add DHCP support and dhcp commmand
Date: Wed, 22 May 2024 18:00:03 +0200
Message-Id: <3a25276d4ca12b29c3ad9e7132d9a3960fffeb52.1716393035.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716393035.git.jerome.forissier@linaro.org>
References: <cover.1716393035.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 22 May 2024 18:16:41 +0200
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

Add what it takes to enable CONFIG_NETDEVICES with CONFIG_NET_LWIP and
enable DHCP as well as the dhcp command (CONFIG_CMD_DHCP_LWIP).
- net-lwip/net-lwip.c is mostly empty for now. It will provide functions
similar to net/net.c except based on the lwIP stack
- include/net-lwip.h is a replacement for include/net.h which is unused
when CONFIG_NET_LWIP is enabled. Declarations from the latter will be
transferred to the former as needed when new network commands are ported
on top of lwIP.
- CONFIG_CMD_TFTPBOOT_LWIP is introduced due to CONFIG_BOOTMETH_EFI having
an implicit dependency on do_tftpb().

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 Makefile                        |   1 +
 boot/Kconfig                    |   2 +
 boot/bootmeth_efi.c             |   3 +-
 cmd/Kconfig                     |  26 ++++
 cmd/Makefile                    |   4 +
 cmd/net-lwip.c                  |  13 ++
 common/board_r.c                |   4 +-
 drivers/dfu/Kconfig             |   2 +-
 drivers/net/Kconfig             |   2 +-
 include/config_distro_bootcmd.h |   2 +-
 include/net-lwip.h              |  85 ++++++++++++
 include/net.h                   |   2 +-
 net-lwip/Kconfig                |  12 +-
 net-lwip/Makefile               |  15 +++
 net-lwip/dhcp.c                 | 105 +++++++++++++++
 net-lwip/eth_internal.h         |  35 +++++
 net-lwip/net-lwip.c             | 224 ++++++++++++++++++++++++++++++++
 net-lwip/tftp.c                 |  11 ++
 net/eth_bootdev.c               |   2 +-
 19 files changed, 540 insertions(+), 10 deletions(-)
 create mode 100644 cmd/net-lwip.c
 create mode 100644 include/net-lwip.h
 create mode 100644 net-lwip/Makefile
 create mode 100644 net-lwip/dhcp.c
 create mode 100644 net-lwip/eth_internal.h
 create mode 100644 net-lwip/net-lwip.c
 create mode 100644 net-lwip/tftp.c

diff --git a/Makefile b/Makefile
index 6296ad6f78..6d0ec35cba 100644
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
index 6f3096c15a..649fd454a2 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -381,6 +381,7 @@ config BOOT_DEFAULTS_CMDS
 	select CMD_DHCP if CMD_NET
 	select CMD_PING if CMD_NET
 	select CMD_PXE if CMD_NET
+	select CMD_DHCP_LWIP if CMD_NET_LWIP
 	select CMD_BOOTI if ARM64
 	select CMD_BOOTZ if ARM && !ARM64
 	imply CMD_MII if NET
@@ -540,6 +541,7 @@ config BOOTMETH_EXTLINUX_PXE
 config BOOTMETH_EFILOADER
 	bool "Bootdev support for EFI boot"
 	depends on EFI_BINARY_EXEC
+	select CMD_TFTPBOOT_LWIP if CMD_NET_LWIP
 	default y
 	help
 	  Enables support for EFI boot using bootdevs. This makes the
diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index aebc5207fc..b12e01d7de 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -70,7 +70,8 @@ static bool bootmeth_uses_network(struct bootflow *bflow)
 {
 	const struct udevice *media = dev_get_parent(bflow->dev);
 
-	return IS_ENABLED(CONFIG_CMD_DHCP) &&
+	return (IS_ENABLED(CONFIG_CMD_DHCP) ||
+		IS_ENABLED(CONFIG_CMD_DHCP_LWIP)) &&
 	    device_get_uclass_id(media) == UCLASS_ETH;
 }
 
diff --git a/cmd/Kconfig b/cmd/Kconfig
index b026439c77..0ef3189d8c 100644
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
+config CMD_DHCP_LWIP
+	bool "dhcp"
+	select PROT_DHCP_LWIP
+	help
+	  Boot image via network using DHCP/TFTP protocol
+
+config CMD_TFTPBOOT_LWIP
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
index 87133cc27a..c96afac10f 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -128,6 +128,10 @@ endif
 obj-$(CONFIG_CMD_MUX) += mux.o
 obj-$(CONFIG_CMD_NAND) += nand.o
 obj-$(CONFIG_CMD_NET) += net.o
+obj-$(CONFIG_CMD_NET_LWIP) += net-lwip.o
+ifdef CONFIG_CMD_NET_LWIP
+CFLAGS_net-lwip.o := -I$(srctree)/lib/lwip/include -I$(srctree)/lib/lwip/u-boot
+endif
 obj-$(CONFIG_ENV_SUPPORT) += nvedit.o
 obj-$(CONFIG_CMD_NVEDIT_EFI) += nvedit_efi.o
 obj-$(CONFIG_CMD_ONENAND) += onenand.o
diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
new file mode 100644
index 0000000000..c740461c64
--- /dev/null
+++ b/cmd/net-lwip.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2024 Linaro Ltd. */
+
+#include <command.h>
+#include <net-lwip.h>
+
+#if defined(CONFIG_CMD_DHCP_LWIP)
+U_BOOT_CMD(
+        dhcp,   3,      1,      do_dhcp,
+        "boot image via network using DHCP/TFTP protocol",
+        "[loadAddress] [[hostIPaddr:]bootfilename]"
+);
+#endif
diff --git a/common/board_r.c b/common/board_r.c
index da0b80f24f..6548eb8fdd 100644
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
diff --git a/drivers/dfu/Kconfig b/drivers/dfu/Kconfig
index d331b05993..17d1641fb1 100644
--- a/drivers/dfu/Kconfig
+++ b/drivers/dfu/Kconfig
@@ -19,7 +19,7 @@ config DFU_WRITE_ALT
 
 config DFU_TFTP
 	bool "DFU via TFTP"
-	depends on NETDEVICES
+	depends on NETDEVICES && !NET_LWIP
 	select UPDATE_COMMON
 	select DFU_OVER_TFTP
 	help
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index b2d7b49976..4ba09c9d6f 100644
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
diff --git a/include/config_distro_bootcmd.h b/include/config_distro_bootcmd.h
index 2a136b96a6..d9b0f2ad5e 100644
--- a/include/config_distro_bootcmd.h
+++ b/include/config_distro_bootcmd.h
@@ -345,7 +345,7 @@
 	BOOT_TARGET_DEVICES_references_VIRTIO_without_CONFIG_CMD_VIRTIO
 #endif
 
-#if defined(CONFIG_CMD_DHCP)
+#if defined(CONFIG_CMD_DHCP) || defined(CONFIG_CMD_DHCP_LWIP)
 #if defined(CONFIG_EFI_LOADER)
 /* http://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-parameters.xml */
 #if defined(CONFIG_ARM64) || defined(__aarch64__)
diff --git a/include/net-lwip.h b/include/net-lwip.h
new file mode 100644
index 0000000000..2308703e46
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
index ac511eab10..330bc6bf66 100644
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
diff --git a/net-lwip/Kconfig b/net-lwip/Kconfig
index 87ce51ca8b..ea70770e73 100644
--- a/net-lwip/Kconfig
+++ b/net-lwip/Kconfig
@@ -4,6 +4,7 @@
 
 menuconfig NET_LWIP
 	bool "Networking support (lwIP stack) -- EXPERIMENTAL"
+	imply NETDEVICES
 	help
 	  Include networking support based on the lwIP (lightweight IP)
 	  TCP/IP stack (https://nongnu.org/lwip). This is a replacement for
@@ -12,8 +13,6 @@ menuconfig NET_LWIP
 	  depend on CONFIG_NET (such as cmd/net.c enabled via CONFIG_CMD_NET).
 	  Therefore the two symbols CONFIG_NET and CONFIG_NET_LWIP are mutually
 	  exclusive.
-	  NOTE: This currently only builds the lwIP library but does not add
-	  any functionality to U-Boot.
 
 if NET_LWIP
 
@@ -50,4 +49,13 @@ config PROT_UDP_LWIP
 	help
 	  Enable support for the User Datagram Protocol in lwIP.
 
+config BOOTDEV_ETH
+        bool "Enable bootdev for ethernet"
+        depends on BOOTSTD
+        default y
+        help
+          Provide a bootdev for ethernet so that is it possible to boot
+          an operating system over the network, using the PXE (Preboot
+          Execution Environment) protocol.
+
 endif
diff --git a/net-lwip/Makefile b/net-lwip/Makefile
new file mode 100644
index 0000000000..79bdaecee5
--- /dev/null
+++ b/net-lwip/Makefile
@@ -0,0 +1,15 @@
+ccflags-y += -I$(srctree)/lib/lwip/include -I$(srctree)/lib/lwip/u-boot
+
+obj-$(CONFIG_$(SPL_TPL_)BOOTDEV_ETH) += ../net/eth_bootdev.o
+obj-$(CONFIG_DM_MDIO)  += ../net/mdio-uclass.o
+obj-$(CONFIG_DM_MDIO_MUX) += ../net/mdio-mux-uclass.o
+obj-$(CONFIG_$(SPL_)DM_ETH) += ../net/eth_common.o
+obj-$(CONFIG_$(SPL_)DM_ETH) += ../net/eth-uclass.o
+obj-$(CONFIG_$(SPL_)DM_ETH) += net-lwip.o
+obj-$(CONFIG_CMD_DHCP_LWIP) += dhcp.o
+obj-$(CONFIG_CMD_TFTPBOOT_LWIP) += tftp.o
+
+# Disable this warning as it is triggered by:
+# sprintf(buf, index ? "foo%d" : "foo", index)
+# and this is intentional usage.
+CFLAGS_eth_common.o += -Wno-format-extra-args
diff --git a/net-lwip/dhcp.c b/net-lwip/dhcp.c
new file mode 100644
index 0000000000..ae2d922cda
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
+#ifdef CONFIG_CMD_TFTPBOOT_LWIP
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
+#ifdef CONFIG_CMD_TFTPBOOT_LWIP
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
index 0000000000..0b829a8d38
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
index 0000000000..886028b68c
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
index 0000000000..1fa246f55d
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
diff --git a/net/eth_bootdev.c b/net/eth_bootdev.c
index 869adf8cbb..060b7cff09 100644
--- a/net/eth_bootdev.c
+++ b/net/eth_bootdev.c
@@ -85,7 +85,7 @@ static int eth_bootdev_hunt(struct bootdev_hunter *info, bool show)
 	 * enumerated already. If something like 'bootflow scan dhcp' is used
 	 * then the user will need to run 'usb start' first.
 	 */
-	if (IS_ENABLED(CONFIG_CMD_DHCP)) {
+	if (IS_ENABLED(CONFIG_CMD_DHCP) || IS_ENABLED(CONFIG_CMD_DHCP_LWIP)) {
 		ret = dhcp_run(0, NULL, false);
 		if (ret)
 			return -EINVAL;
-- 
2.40.1

