Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F579C07D59
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:03:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1A98875C8;
	Mon, 27 Nov 2023 14:00:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QqDGZvd5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87216875FC; Mon, 27 Nov 2023 14:00:46 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBEDE875DF
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:00:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50aabfa1b75so5882210e87.3
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090042; x=1701694842; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UVa+z8ZgfXxQSDWa2Nvtk/JjyLX2HbFM1q8u36pxb0w=;
 b=QqDGZvd5sK1JjZ9lyUU8/DgaanrMNQ9LHHPGodqXrarsq4AHKEdoExEJAqmUDT+5Cv
 tkBVFiq8MxvugBAWhM8YGgHWPZZQ2eD5S0DGerGZW1UoBrcwYKHHO5G18coagI7FPtzy
 Jke2WdM7s7LeQdSngqvbawTFJkJB0IZGXAX8taJkNlvU8gX8UCTPTdJb2mPMI3zHBPJ5
 MKXoiug8urO0Rb9nXsaKcXrn81byoDHRYaIQQrrxc4r8gg748z5P8RaVBQMPnzv+nzpz
 fUkvbFh0/x+kbW1ALlGfAILgvPldIt1hfp39KEp/IPV66cG02UR+KeckRbiprGX40VO/
 N37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090042; x=1701694842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UVa+z8ZgfXxQSDWa2Nvtk/JjyLX2HbFM1q8u36pxb0w=;
 b=FsjnGaMRPProCPd7r+vCaMc2J31lz4q25u2jANY1S+u++5kCTp3Rs8+NvzhNqW/b/T
 dHWxuSQCKf/ndXKKUeqIuAwuB7BilOb2zbiwPvmyUi6LZVWDTYTQVlkjMHTj0rU0N6Ec
 CGlzRwMqS0qCxcCznWkcfzlo7titJlWtdvjKWDGdmBWEpQQMSz0yfszrEi1+vvzqWYop
 jcAmOqz+N2hzUsjjAxzvBXWOyWhy3MDnIraMWafR3HJ5xOi8UvGi92pjgb12yOqxGVIE
 4CswoG4Op27T/VNtIexz7rU+pxTRTFcHV8YL/gKlaprmHpS9bnLMsuAT7v37sf/wZ+cE
 FIVQ==
X-Gm-Message-State: AOJu0YzPFDGrTw2zSIVCxBpPN6pXyiaOqQgI1exn73yFBCuHpDrnoHTT
 X/ROkWDMM5nMy6so6OAw9QW/2Ny0kiZJfGlHI8I3Ww==
X-Google-Smtp-Source: AGHT+IGCIPzG0tPhvnWdj1q40gMOTl4kxrGRBJnQKUBNm/Q37rT/h749NHJ7x3mU6+qCofjrcY80KA==
X-Received: by 2002:a19:7b02:0:b0:509:1067:c20d with SMTP id
 w2-20020a197b02000000b005091067c20dmr6225742lfc.39.1701090040965; 
 Mon, 27 Nov 2023 05:00:40 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:00:40 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 14/43] net/lwip: split net.h to net.h, arp.h and eth.h
Date: Mon, 27 Nov 2023 18:56:57 +0600
Message-Id: <20231127125726.3735-15-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
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

current net.h has ethernet and protocol definitions. Protocol definitions
overlap with lwIP protocol definitions and net.h can not be included from
lwIP code. Splitting on logical blocks makes that work.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 include/net.h     | 189 +-------------------------------------------
 include/net/arp.h |   9 +++
 include/net/eth.h | 194 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 207 insertions(+), 185 deletions(-)
 create mode 100644 include/net/arp.h
 create mode 100644 include/net/eth.h

diff --git a/include/net.h b/include/net.h
index ed15064fc1..8efc4d7f3e 100644
--- a/include/net.h
+++ b/include/net.h
@@ -21,6 +21,7 @@
 #include <time.h>
 #include <linux/if_ether.h>
 #include <rand.h>
+#include  <net/arp.h>
 
 struct bd_info;
 struct cmd_tbl;
@@ -32,25 +33,6 @@ struct udevice;
 #define DEBUG_INT_STATE 0	/* Internal network state changes */
 #define DEBUG_NET_PKT_TRACE 0	/* Trace all packet data */
 
-/*
- *	The number of receive packet buffers, and the required packet buffer
- *	alignment in memory.
- *
- */
-#define PKTBUFSRX	CONFIG_SYS_RX_ETH_BUFFER
-#define PKTALIGN	ARCH_DMA_MINALIGN
-
-/* Number of packets processed together */
-#define ETH_PACKETS_BATCH_RECV	32
-
-/* ARP hardware address length */
-#define ARP_HLEN 6
-/*
- * The size of a MAC address in string form, each digit requires two chars
- * and five separator characters to form '00:00:00:00:00:00'.
- */
-#define ARP_HLEN_ASCII (ARP_HLEN * 2) + (ARP_HLEN - 1)
-
 /* IPv4 addresses are always 32 bits in size */
 struct in_addr {
 	__be32 s_addr;
@@ -114,150 +96,7 @@ typedef void rxhand_icmp_f(unsigned type, unsigned code, unsigned dport,
  */
 typedef void	thand_f(void);
 
-enum eth_state_t {
-	ETH_STATE_INIT,
-	ETH_STATE_PASSIVE,
-	ETH_STATE_ACTIVE
-};
-
-/**
- * struct eth_pdata - Platform data for Ethernet MAC controllers
- *
- * @iobase: The base address of the hardware registers
- * @enetaddr: The Ethernet MAC address that is loaded from EEPROM or env
- * @phy_interface: PHY interface to use - see PHY_INTERFACE_MODE_...
- * @max_speed: Maximum speed of Ethernet connection supported by MAC
- * @priv_pdata: device specific plat
- */
-struct eth_pdata {
-	phys_addr_t iobase;
-	unsigned char enetaddr[ARP_HLEN];
-	int phy_interface;
-	int max_speed;
-	void *priv_pdata;
-};
-
-enum eth_recv_flags {
-	/*
-	 * Check hardware device for new packets (otherwise only return those
-	 * which are already in the memory buffer ready to process)
-	 */
-	ETH_RECV_CHECK_DEVICE		= 1 << 0,
-};
-
-/**
- * struct eth_ops - functions of Ethernet MAC controllers
- *
- * start: Prepare the hardware to send and receive packets
- * send: Send the bytes passed in "packet" as a packet on the wire
- * recv: Check if the hardware received a packet. If so, set the pointer to the
- *	 packet buffer in the packetp parameter. If not, return an error or 0 to
- *	 indicate that the hardware receive FIFO is empty. If 0 is returned, the
- *	 network stack will not process the empty packet, but free_pkt() will be
- *	 called if supplied
- * free_pkt: Give the driver an opportunity to manage its packet buffer memory
- *	     when the network stack is finished processing it. This will only be
- *	     called when no error was returned from recv - optional
- * stop: Stop the hardware from looking for packets - may be called even if
- *	 state == PASSIVE
- * mcast: Join or leave a multicast group (for TFTP) - optional
- * write_hwaddr: Write a MAC address to the hardware (used to pass it to Linux
- *		 on some platforms like ARM). This function expects the
- *		 eth_pdata::enetaddr field to be populated. The method can
- *		 return -ENOSYS to indicate that this is not implemented for
-		 this hardware - optional.
- * read_rom_hwaddr: Some devices have a backup of the MAC address stored in a
- *		    ROM on the board. This is how the driver should expose it
- *		    to the network stack. This function should fill in the
- *		    eth_pdata::enetaddr field - optional
- * set_promisc: Enable or Disable promiscuous mode
- * get_sset_count: Number of statistics counters
- * get_string: Names of the statistic counters
- * get_stats: The values of the statistic counters
- */
-struct eth_ops {
-	int (*start)(struct udevice *dev);
-	int (*send)(struct udevice *dev, void *packet, int length);
-	int (*recv)(struct udevice *dev, int flags, uchar **packetp);
-	int (*free_pkt)(struct udevice *dev, uchar *packet, int length);
-	void (*stop)(struct udevice *dev);
-	int (*mcast)(struct udevice *dev, const u8 *enetaddr, int join);
-	int (*write_hwaddr)(struct udevice *dev);
-	int (*read_rom_hwaddr)(struct udevice *dev);
-	int (*set_promisc)(struct udevice *dev, bool enable);
-	int (*get_sset_count)(struct udevice *dev);
-	void (*get_strings)(struct udevice *dev, u8 *data);
-	void (*get_stats)(struct udevice *dev, u64 *data);
-};
-
-#define eth_get_ops(dev) ((struct eth_ops *)(dev)->driver->ops)
-
-struct udevice *eth_get_dev(void); /* get the current device */
-/*
- * The devname can be either an exact name given by the driver or device tree
- * or it can be an alias of the form "eth%d"
- */
-struct udevice *eth_get_dev_by_name(const char *devname);
-unsigned char *eth_get_ethaddr(void); /* get the current device MAC */
-
-/* Used only when NetConsole is enabled */
-int eth_is_active(struct udevice *dev); /* Test device for active state */
-int eth_init_state_only(void); /* Set active state */
-void eth_halt_state_only(void); /* Set passive state */
-
-int eth_initialize(void);		/* Initialize network subsystem */
-void eth_try_another(int first_restart);	/* Change the device */
-void eth_set_current(void);		/* set nterface to ethcur var */
-
-int eth_get_dev_index(void);		/* get the device index */
-
-/**
- * eth_env_set_enetaddr_by_index() - set the MAC address environment variable
- *
- * This sets up an environment variable with the given MAC address (@enetaddr).
- * The environment variable to be set is defined by <@base_name><@index>addr.
- * If @index is 0 it is omitted. For common Ethernet this means ethaddr,
- * eth1addr, etc.
- *
- * @base_name:  Base name for variable, typically "eth"
- * @index:      Index of interface being updated (>=0)
- * @enetaddr:   Pointer to MAC address to put into the variable
- * Return: 0 if OK, other value on error
- */
-int eth_env_set_enetaddr_by_index(const char *base_name, int index,
-				 uchar *enetaddr);
-
-
-/*
- * Initialize USB ethernet device with CONFIG_DM_ETH
- * Returns:
- *	0 is success, non-zero is error status.
- */
-int usb_ether_init(void);
-
-/*
- * Get the hardware address for an ethernet interface .
- * Args:
- *	base_name - base name for device (normally "eth")
- *	index - device index number (0 for first)
- *	enetaddr - returns 6 byte hardware address
- * Returns:
- *	Return true if the address is valid.
- */
-int eth_env_get_enetaddr_by_index(const char *base_name, int index,
-				 uchar *enetaddr);
-
-int eth_init(void);			/* Initialize the device */
-int eth_send(void *packet, int length);	   /* Send a packet */
-
-#if defined(CONFIG_API) || defined(CONFIG_EFI_LOADER)
-int eth_receive(void *packet, int length); /* Receive a packet*/
-extern void (*push_packet)(void *packet, int length);
-#endif
-int eth_rx(void);			/* Check for received packets */
-void eth_halt(void);			/* stop SCC */
-const char *eth_get_name(void);		/* get name of current device */
-int eth_mcast_join(struct in_addr mcast_addr, int join);
+#include <net/eth.h>
 
 /**********************************************************************/
 /*
@@ -497,16 +336,6 @@ extern char	net_root_path[CONFIG_BOOTP_MAX_ROOT_PATH_LEN];	/* Our root path */
 /* Indicates whether the pxe path prefix / config file was specified in dhcp option */
 extern char *pxelinux_configfile;
 /** END OF BOOTP EXTENTIONS **/
-extern u8		net_ethaddr[ARP_HLEN];		/* Our ethernet address */
-extern u8		net_server_ethaddr[ARP_HLEN];	/* Boot server enet address */
-extern struct in_addr	net_ip;		/* Our    IP addr (0 = unknown) */
-extern struct in_addr	net_server_ip;	/* Server IP addr (0 = unknown) */
-extern uchar		*net_tx_packet;		/* THE transmit packet */
-extern uchar		*net_rx_packets[PKTBUFSRX]; /* Receive packets */
-extern uchar		*net_rx_packet;		/* Current receive packet */
-extern int		net_rx_packet_len;	/* Current rx packet length */
-extern const u8		net_bcast_ethaddr[ARP_HLEN];	/* Ethernet broadcast address */
-extern const u8		net_null_ethaddr[ARP_HLEN];
 
 #define VLAN_NONE	4095			/* untagged */
 #define VLAN_IDMASK	0x0fff			/* mask of valid vlan id */
@@ -559,6 +388,8 @@ extern struct in_addr	net_ntp_server;		/* the ip address to NTP */
 extern int net_ntp_time_offset;			/* offset time from UTC */
 #endif
 
+int eth_mcast_join(struct in_addr mcast_addr, int join);
+
 /* Initialize the network adapter */
 int net_init(void);
 int net_loop(enum proto_t);
@@ -831,18 +662,6 @@ static inline void net_random_ethaddr(uchar *addr)
 	addr[0] |= 0x02;	/* set local assignment bit (IEEE802) */
 }
 
-/**
- * string_to_enetaddr() - Parse a MAC address
- *
- * Convert a string MAC address
- *
- * Implemented in lib/net_utils.c (built unconditionally)
- *
- * @addr: MAC address in aa:bb:cc:dd:ee:ff format, where each part is a 2-digit
- *	hex value
- * @enetaddr: Place to put MAC address (6 bytes)
- */
-void string_to_enetaddr(const char *addr, uint8_t *enetaddr);
 
 /* Convert an IP address to a string */
 void ip_to_string(struct in_addr x, char *s);
diff --git a/include/net/arp.h b/include/net/arp.h
new file mode 100644
index 0000000000..cbdc948e64
--- /dev/null
+++ b/include/net/arp.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+/* ARP hardware address length */
+#define ARP_HLEN 6
+/*
+ * The size of a MAC address in string form, each digit requires two chars
+ * and five separator characters to form '00:00:00:00:00:00'.
+ */
+#define ARP_HLEN_ASCII (ARP_HLEN * 2) + (ARP_HLEN - 1)
diff --git a/include/net/eth.h b/include/net/eth.h
new file mode 100644
index 0000000000..d8ffdff2c0
--- /dev/null
+++ b/include/net/eth.h
@@ -0,0 +1,194 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#include <net/arp.h>
+
+struct udevice;
+
+enum eth_state_t {
+	ETH_STATE_INIT,
+	ETH_STATE_PASSIVE,
+	ETH_STATE_ACTIVE
+};
+
+/**
+ * struct eth_pdata - Platform data for Ethernet MAC controllers
+ *
+ * @iobase: The base address of the hardware registers
+ * @enetaddr: The Ethernet MAC address that is loaded from EEPROM or env
+ * @phy_interface: PHY interface to use - see PHY_INTERFACE_MODE_...
+ * @max_speed: Maximum speed of Ethernet connection supported by MAC
+ * @priv_pdata: device specific plat
+ */
+struct eth_pdata {
+	phys_addr_t iobase;
+	unsigned char enetaddr[ARP_HLEN];
+	int phy_interface;
+	int max_speed;
+	void *priv_pdata;
+};
+
+enum eth_recv_flags {
+	/*
+	 * Check hardware device for new packets (otherwise only return those
+	 * which are already in the memory buffer ready to process)
+	 */
+	ETH_RECV_CHECK_DEVICE		= 1 << 0,
+};
+
+/**
+ * struct eth_ops - functions of Ethernet MAC controllers
+ *
+ * start: Prepare the hardware to send and receive packets
+ * send: Send the bytes passed in "packet" as a packet on the wire
+ * recv: Check if the hardware received a packet. If so, set the pointer to the
+ *	 packet buffer in the packetp parameter. If not, return an error or 0 to
+ *	 indicate that the hardware receive FIFO is empty. If 0 is returned, the
+ *	 network stack will not process the empty packet, but free_pkt() will be
+ *	 called if supplied
+ * free_pkt: Give the driver an opportunity to manage its packet buffer memory
+ *	     when the network stack is finished processing it. This will only be
+ *	     called when no error was returned from recv - optional
+ * stop: Stop the hardware from looking for packets - may be called even if
+ *	 state == PASSIVE
+ * mcast: Join or leave a multicast group (for TFTP) - optional
+ * write_hwaddr: Write a MAC address to the hardware (used to pass it to Linux
+ *		 on some platforms like ARM). This function expects the
+ *		 eth_pdata::enetaddr field to be populated. The method can
+ *		 return -ENOSYS to indicate that this is not implemented for
+		 this hardware - optional.
+ * read_rom_hwaddr: Some devices have a backup of the MAC address stored in a
+ *		    ROM on the board. This is how the driver should expose it
+ *		    to the network stack. This function should fill in the
+ *		    eth_pdata::enetaddr field - optional
+ * set_promisc: Enable or Disable promiscuous mode
+ * get_sset_count: Number of statistics counters
+ * get_string: Names of the statistic counters
+ * get_stats: The values of the statistic counters
+ */
+struct eth_ops {
+	int (*start)(struct udevice *dev);
+	int (*send)(struct udevice *dev, void *packet, int length);
+	int (*recv)(struct udevice *dev, int flags, uchar **packetp);
+	int (*free_pkt)(struct udevice *dev, uchar *packet, int length);
+	void (*stop)(struct udevice *dev);
+	int (*mcast)(struct udevice *dev, const u8 *enetaddr, int join);
+	int (*write_hwaddr)(struct udevice *dev);
+	int (*read_rom_hwaddr)(struct udevice *dev);
+	int (*set_promisc)(struct udevice *dev, bool enable);
+	int (*get_sset_count)(struct udevice *dev);
+	void (*get_strings)(struct udevice *dev, u8 *data);
+	void (*get_stats)(struct udevice *dev, u64 *data);
+};
+
+#define eth_get_ops(dev) ((struct eth_ops *)(dev)->driver->ops)
+
+struct udevice *eth_get_dev(void); /* get the current device */
+/*
+ * The devname can be either an exact name given by the driver or device tree
+ * or it can be an alias of the form "eth%d"
+ */
+struct udevice *eth_get_dev_by_name(const char *devname);
+unsigned char *eth_get_ethaddr(void); /* get the current device MAC */
+
+/* Used only when NetConsole is enabled */
+int eth_is_active(struct udevice *dev); /* Test device for active state */
+int eth_init_state_only(void); /* Set active state */
+void eth_halt_state_only(void); /* Set passive state */
+
+int eth_initialize(void);		/* Initialize network subsystem */
+void eth_try_another(int first_restart);	/* Change the device */
+void eth_set_current(void);		/* set nterface to ethcur var */
+
+int eth_get_dev_index(void);		/* get the device index */
+
+/**
+ * eth_env_set_enetaddr_by_index() - set the MAC address environment variable
+ *
+ * This sets up an environment variable with the given MAC address (@enetaddr).
+ * The environment variable to be set is defined by <@base_name><@index>addr.
+ * If @index is 0 it is omitted. For common Ethernet this means ethaddr,
+ * eth1addr, etc.
+ *
+ * @base_name:  Base name for variable, typically "eth"
+ * @index:      Index of interface being updated (>=0)
+ * @enetaddr:   Pointer to MAC address to put into the variable
+ * Return: 0 if OK, other value on error
+ */
+int eth_env_set_enetaddr_by_index(const char *base_name, int index,
+				  uchar *enetaddr);
+
+/*
+ * Initialize USB ethernet device with CONFIG_DM_ETH
+ * Returns:
+ *	0 is success, non-zero is error status.
+ */
+int usb_ether_init(void);
+
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
+				  uchar *enetaddr);
+
+void eth_init_rings(void);	/* Initialize rings */
+int eth_init(void);			/* Initialize the device */
+int eth_send(void *packet, int length);	   /* Send a packet */
+
+#if defined(CONFIG_API) || defined(CONFIG_EFI_LOADER)
+int eth_receive(void *packet, int length); /* Receive a packet*/
+extern void (*push_packet)(void *packet, int length);
+#endif
+int eth_rx(void);			/* Check for received packets */
+void eth_halt(void);			/* stop SCC */
+const char *eth_get_name(void);		/* get name of current device */
+
+/*
+ *	The number of receive packet buffers, and the required packet buffer
+ *	alignment in memory.
+ *
+ */
+#define PKTBUFSRX	CONFIG_SYS_RX_ETH_BUFFER
+#define PKTALIGN	ARCH_DMA_MINALIGN
+
+/* Number of packets processed together */
+#define ETH_PACKETS_BATCH_RECV	32
+
+extern u8		net_ethaddr[ARP_HLEN];		/* Our ethernet address */
+extern u8		net_server_ethaddr[ARP_HLEN];	/* Boot server enet address */
+extern struct in_addr	net_ip;		/* Our    IP addr (0 = unknown) */
+extern struct in_addr	net_server_ip;	/* Server IP addr (0 = unknown) */
+extern uchar		*net_tx_packet;		/* THE transmit packet */
+extern uchar		*net_rx_packets[PKTBUFSRX]; /* Receive packets */
+extern uchar		*net_rx_packet;		/* Current receive packet */
+extern int		net_rx_packet_len;	/* Current rx packet length */
+extern const u8		net_bcast_ethaddr[ARP_HLEN];	/* Ethernet broadcast address */
+extern const u8		net_null_ethaddr[ARP_HLEN];
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
+typedef struct ulwip {
+	bool loop; /* spin in lwip loop */
+	bool active; /* active lwip app processing*/
+	int err;
+	bool init_done;
+
+} ulwip;
+
+struct ulwip *eth_lwip_priv(struct udevice *current);
-- 
2.30.2

