Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25F3EEAA53
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:23:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69E1A87085;
	Thu, 14 Sep 2023 18:21:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Heqnjv4h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7E0687080; Thu, 14 Sep 2023 18:21:14 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A498586672
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:21:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2bd0d135ca3so19044381fa.3
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694708469; x=1695313269; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E2ziTbeXz5Mw5Zsh+PXRJwRlKMm+1xFvTuTYPCWU9yo=;
 b=Heqnjv4hBecb9QiqEYTmjYEPG00F+sbUZdo6cTWVG8D6KDTTNmpYrtIi4uyKA67E5x
 rPnFhVrdtUWuNQGJgaXTNmICy+Bmul1MsrEEYdo+Gwr3kvxO2bwXTT6fODMuw3/QvVTp
 vk6Mo3RwsxUXBlNJeVCsp5Hb9eq5D8nSuaIt4kLQk1yoU/1+HcEYaYzwq8CyhfaS7YBY
 ybptJ4oEA8fxqLGXuHM+kpIpOxf0KRGux6k4qf+Ib8s3Ny7N3L4RWHuAtuedl4EKde2I
 fiW+ghr5EzxQ+Wtf4MC6AvtfSH4g27jBK7H7arE00J2MgQWVWpA9Ei+8Zs7KWHCuPoT8
 bjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694708469; x=1695313269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E2ziTbeXz5Mw5Zsh+PXRJwRlKMm+1xFvTuTYPCWU9yo=;
 b=Ayo6Z+LhgKXJ8F8D3sQj0IFtwwPW0+D0Qk1w9E3X9PVMab5GEpKwKEC3wFoDE03n4L
 bSskjPaSJMurYwbx+0psvT8JA/HQ7SqaXH1fMxtK/wl5xZuMmkOO6e1xSZUpMANpC00f
 BJEp26TfsAlWioen5seZtcOR3KnRJk2H4A/vS6o0oa11xMrgzcycMPtsRdxMd9HF7Epr
 TfOU/T2JkmY89zBM1HKgeS7m/fOLO7wG0z0pRNArIWq05Ry/fD/395wgb95fm/lBLV5z
 bfOhZUsqkriQDyvVXmiEryVeppWGg+dh5XZG1et+CnL/MiZmJt+nHeXb100ntUxN/DYC
 yzSw==
X-Gm-Message-State: AOJu0YyH7/+FzLOd1JnaP1BcTIRinUrD0Ma7xmqgH0NmmX0IyuIOhXUl
 Aus4v9m+q20jQmqNgeEb41h/U+OW/CQWcJPgHlTCaQ==
X-Google-Smtp-Source: AGHT+IET7EieKTHwGyWHv69bu3gWT4vTGAtQXaG5NG7qUUfIr1s2gTKzU638H1ADCp/YUvrhibtUag==
X-Received: by 2002:a2e:8757:0:b0:2bc:b29e:8ff7 with SMTP id
 q23-20020a2e8757000000b002bcb29e8ff7mr5759520ljj.20.1694708468502; 
 Thu, 14 Sep 2023 09:21:08 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a2e8e8f000000b002ba7ae1f52asm346919ljk.0.2023.09.14.09.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:21:08 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv9 14/15] net/lwip: split net.h to net.h, arp.h and eth.h
Date: Thu, 14 Sep 2023 22:18:27 +0600
Message-Id: <20230914161828.3662-15-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230914161828.3662-1-maxim.uvarov@linaro.org>
References: <20230914161828.3662-1-maxim.uvarov@linaro.org>
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
 include/net.h     | 189 +--------------------------------------------
 include/net/arp.h |   7 ++
 include/net/eth.h | 190 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 201 insertions(+), 185 deletions(-)
 create mode 100644 include/net/arp.h
 create mode 100644 include/net/eth.h

diff --git a/include/net.h b/include/net.h
index de7baeb121..780c51fab9 100644
--- a/include/net.h
+++ b/include/net.h
@@ -20,6 +20,7 @@
 #include <time.h>
 #include <linux/if_ether.h>
 #include <rand.h>
+#include  <net/arp.h>
 
 struct bd_info;
 struct cmd_tbl;
@@ -30,25 +31,6 @@ struct udevice;
 #define DEBUG_NET_PKT 0		/* Packets on info on the network at large */
 #define DEBUG_INT_STATE 0	/* Internal network state changes */
 
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
@@ -112,150 +94,7 @@ typedef void rxhand_icmp_f(unsigned type, unsigned code, unsigned dport,
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
@@ -495,16 +334,6 @@ extern char	net_root_path[CONFIG_BOOTP_MAX_ROOT_PATH_LEN];	/* Our root path */
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
@@ -557,6 +386,8 @@ extern struct in_addr	net_ntp_server;		/* the ip address to NTP */
 extern int net_ntp_time_offset;			/* offset time from UTC */
 #endif
 
+int eth_mcast_join(struct in_addr mcast_addr, int join);
+
 /* Initialize the network adapter */
 int net_init(void);
 int net_loop(enum proto_t);
@@ -827,18 +658,6 @@ static inline void net_random_ethaddr(uchar *addr)
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
index 0000000000..f614f0ef78
--- /dev/null
+++ b/include/net/arp.h
@@ -0,0 +1,7 @@
+/* ARP hardware address length */
+#define ARP_HLEN 6
+/*
+ * The size of a MAC address in string form, each digit requires two chars
+ * and five separator characters to form '00:00:00:00:00:00'.
+ */
+#define ARP_HLEN_ASCII (ARP_HLEN * 2) + (ARP_HLEN - 1)
diff --git a/include/net/eth.h b/include/net/eth.h
new file mode 100644
index 0000000000..17552bca81
--- /dev/null
+++ b/include/net/eth.h
@@ -0,0 +1,190 @@
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
+				 uchar *enetaddr);
+
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
+				 uchar *enetaddr);
+
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
+	bool loop;
+	int err;
+	bool init_done;
+} ulwip;
+
+struct ulwip *eth_lwip_priv(struct udevice *current);
-- 
2.30.2

