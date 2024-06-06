Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DACC27C54
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 13:37:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 702F288468;
	Thu,  6 Jun 2024 15:37:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cD2dLD16";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4390E8845E; Thu,  6 Jun 2024 15:37:14 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E320F88428
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 15:37:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42147970772so6521945e9.0
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 06:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717681031; x=1718285831; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OtoV3jzifw6rLkvypsu0OIFaVen0nzudNrCYRDRSCXw=;
 b=cD2dLD16BKDmrVJBClpN7jUcclsmyRlLMJ5ssuv1E11p28XLAB+iwDOHBvqmTUZHpZ
 aKrnNHeP8jvtSm/w6d97BiaPbJQEhZnqgcqtLNE49Xu/SwuUEbSsCVYT1tRnyaO2aMA1
 6VbTf6srswShHvXEEgqgrclKJlcHh1xmBymSVcovUKb76zbwoCXuPaNIMsPHNsxGIlKB
 RoxJXlwxPN0FGZ5tsctOUpOsPq4uhwtotccMUhn2/voNELUsB/ul/pBf1MOimihBIr8s
 Rl6rIPS9CFRDbDnYtLzaxY5Q0aSm0pHBiKZDNcguAzPiu5wKphWxLhjPcWTwTs+88HEU
 9HfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717681031; x=1718285831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OtoV3jzifw6rLkvypsu0OIFaVen0nzudNrCYRDRSCXw=;
 b=RX0SgVOCKeuyKtzANNzfFADkyU9qZhvkY9gcTQfn6iTDptHgbcXaW/gcJu86gDl5VQ
 PcEqE0s1JrDJyv3Nxc9EMWtcB6MWxk4XVukP2A7aqJ+lMlHcHjRivIAnLIsb5/+Cntwk
 ph5nkHHm4/GWGSrQyUEstTAUIFFGMb2DvF8cmcQLpsxuoRGhYYMQEmQFY75IgyTcyms/
 athh4T1puTbGdwT1ZOmrMgmjoGo8bVc0ueDc3PDm98/QumQ+MfJ7aEEoaVE7Yh7lOp1E
 fdf2/bvfhwDLD+DybRau8cnHMUEIDT3oxcHPvUFBfFDQHhOLZIXWRDNzJC1S2anGGtq6
 PyLw==
X-Gm-Message-State: AOJu0YzFr6+Zk6ug930yfFQganZNdl5cSAExvxjK/H8QdF32cAaL8UFY
 WItDTx44MoRzGfynHUr1oxjan1t+zFLbOZ/+lhvtsJsrhx1bCgaJ8v9/4GIiEUj37IDj+CBiZVd
 SnxTni3r5
X-Google-Smtp-Source: AGHT+IEB7fYlCJS/MOTg9tlQ3Lr13wYkHZ3IghnT6Vtnktw3U8b0bHSU5YH5rp0JaVyzd8aGpCeGFw==
X-Received: by 2002:a05:600c:4f83:b0:420:66e:4c31 with SMTP id
 5b1f17b1804b1-4215634de43mr53010875e9.34.1717681031171; 
 Thu, 06 Jun 2024 06:37:11 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c19d52dsm23111955e9.8.2024.06.06.06.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 06:37:10 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Ramon Fried <rfried.dev@gmail.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Sean Edmond <seanedmond@microsoft.com>
Subject: [PATCH v3 07/12] net-lwip: add wget command
Date: Thu,  6 Jun 2024 15:36:02 +0200
Message-Id: <16eac9a19f8f6572ea111cc20cc5793bfb5e6f94.1717680809.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1717680809.git.jerome.forissier@linaro.org>
References: <cover.1717680809.git.jerome.forissier@linaro.org>
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

Add support for the wget command with NET_LWIP.

About the small change in cmd/efidebug.c: when the wget command based
on the lwIP stack is used the wget command has a built-in URL
validation function since it needs to parse it anyways (in parse_url()).
Therefore wget_validate_uri() doesn't exist. So, guard the call in
efidebug.c with CONFIG_CMD_WGET.

Based on code initially developed by Maxim U.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Maxim Uvarov <muvarov@gmail.com>
Cc: Maxim Uvarov <muvarov@gmail.com>
---
 cmd/Kconfig        |   7 ++
 cmd/Makefile       |   5 +-
 cmd/efidebug.c     |   8 +-
 cmd/net-common.c   | 115 +++++++++++++++++++++++++++++
 cmd/net-lwip.c     |  12 +++
 cmd/net.c          | 115 -----------------------------
 include/net-lwip.h |  51 +++++++++++++
 net-lwip/Makefile  |   1 +
 net-lwip/wget.c    | 180 +++++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 375 insertions(+), 119 deletions(-)
 create mode 100644 cmd/net-common.c
 create mode 100644 net-lwip/wget.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 6ef0b52cd34..d9a86540be6 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2117,6 +2117,13 @@ config CMD_TFTPBOOT
 	help
 	  tftpboot - load file via network using TFTP protocol
 
+config CMD_WGET
+	bool "wget"
+	select PROT_TCP_LWIP
+	help
+	  wget is a simple command to download kernel, or other files,
+	  from a http server over TCP.
+
 endif
 
 endif
diff --git a/cmd/Makefile b/cmd/Makefile
index 535b6838ca5..e90f2f68211 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -129,8 +129,11 @@ obj-$(CONFIG_CMD_MUX) += mux.o
 obj-$(CONFIG_CMD_NAND) += nand.o
 obj-$(CONFIG_CMD_NET) += net.o
 obj-$(CONFIG_CMD_NET_LWIP) += net-lwip.o
+obj-$(filter y,$(CONFIG_CMD_NET) $(CONFIG_CMD_NET_LWIP)) += net-common.o
 ifdef CONFIG_CMD_NET_LWIP
-CFLAGS_net-lwip.o := -I$(srctree)/lib/lwip/lwip/src/include -I$(srctree)/lib/lwip/u-boot
+lwip-includes := -I$(srctree)/lib/lwip/lwip/src/include -I$(srctree)/lib/lwip/u-boot
+CFLAGS_net-lwip.o := $(lwip-includes)
+CFLAGS_net-common.o := $(lwip-includes)
 endif
 obj-$(CONFIG_ENV_SUPPORT) += nvedit.o
 obj-$(CONFIG_CMD_NVEDIT_EFI) += nvedit_efi.o
diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index c2c525f2351..d80e91ecadd 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -741,9 +741,11 @@ static int efi_boot_add_uri(int argc, char *const argv[], u16 *var_name16,
 	if (!label)
 		return CMD_RET_FAILURE;
 
-	if (!wget_validate_uri(argv[3])) {
-		printf("ERROR: invalid URI\n");
-		return CMD_RET_FAILURE;
+	if (IS_ENABLED(CONFIG_CMD_WGET)) {
+		if (!wget_validate_uri(argv[3])) {
+			printf("ERROR: invalid URI\n");
+			return CMD_RET_FAILURE;
+		}
 	}
 
 	efi_create_indexed_name(var_name16, var_name16_size, "Boot", id);
diff --git a/cmd/net-common.c b/cmd/net-common.c
new file mode 100644
index 00000000000..f01d9e63998
--- /dev/null
+++ b/cmd/net-common.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2000
+ * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
+ */
+
+#include <command.h>
+#include <dm/device.h>
+#include <dm/uclass.h>
+#ifdef CONFIG_NET
+#include <net.h>
+#elif defined CONFIG_NET_LWIP
+#include <net-lwip.h>
+#else
+#error Either NET or NET_LWIP must be enabled
+#endif
+#include <linux/compat.h>
+#include <linux/ethtool.h>
+
+static int do_net_list(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	const struct udevice *current = eth_get_dev();
+	unsigned char env_enetaddr[ARP_HLEN];
+	const struct udevice *dev;
+	struct uclass *uc;
+
+	uclass_id_foreach_dev(UCLASS_ETH, dev, uc) {
+		eth_env_get_enetaddr_by_index("eth", dev_seq(dev), env_enetaddr);
+		printf("eth%d : %s %pM %s\n", dev_seq(dev), dev->name, env_enetaddr,
+		       current == dev ? "active" : "");
+	}
+	return CMD_RET_SUCCESS;
+}
+
+static int do_net_stats(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	int nstats, err, i, off;
+	struct udevice *dev;
+	u64 *values;
+	u8 *strings;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	err = uclass_get_device_by_name(UCLASS_ETH, argv[1], &dev);
+	if (err) {
+		printf("Could not find device %s\n", argv[1]);
+		return CMD_RET_FAILURE;
+	}
+
+	if (!eth_get_ops(dev)->get_sset_count ||
+	    !eth_get_ops(dev)->get_strings ||
+	    !eth_get_ops(dev)->get_stats) {
+		printf("Driver does not implement stats dump!\n");
+		return CMD_RET_FAILURE;
+	}
+
+	nstats = eth_get_ops(dev)->get_sset_count(dev);
+	strings = kcalloc(nstats, ETH_GSTRING_LEN, GFP_KERNEL);
+	if (!strings)
+		return CMD_RET_FAILURE;
+
+	values = kcalloc(nstats, sizeof(u64), GFP_KERNEL);
+	if (!values)
+		goto err_free_strings;
+
+	eth_get_ops(dev)->get_strings(dev, strings);
+	eth_get_ops(dev)->get_stats(dev, values);
+
+	off = 0;
+	for (i = 0; i < nstats; i++) {
+		printf("  %s: %llu\n", &strings[off], values[i]);
+		off += ETH_GSTRING_LEN;
+	};
+
+	kfree(strings);
+	kfree(values);
+
+	return CMD_RET_SUCCESS;
+
+err_free_strings:
+	kfree(strings);
+
+	return CMD_RET_FAILURE;
+}
+
+static struct cmd_tbl cmd_net[] = {
+	U_BOOT_CMD_MKENT(list, 1, 0, do_net_list, "", ""),
+	U_BOOT_CMD_MKENT(stats, 2, 0, do_net_stats, "", ""),
+};
+
+static int do_net(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	struct cmd_tbl *cp;
+
+	cp = find_cmd_tbl(argv[1], cmd_net, ARRAY_SIZE(cmd_net));
+
+	/* Drop the net command */
+	argc--;
+	argv++;
+
+	if (!cp || argc > cp->maxargs)
+		return CMD_RET_USAGE;
+	if (flag == CMD_FLAG_REPEAT && !cmd_is_repeatable(cp))
+		return CMD_RET_SUCCESS;
+
+	return cp->cmd(cmdtp, flag, argc, argv);
+}
+
+U_BOOT_CMD(
+	net, 3, 1, do_net,
+	"NET sub-system",
+	"list - list available devices\n"
+	"stats <device> - dump statistics for specified device\n"
+);
diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
index 3abafdf7969..b80375c831e 100644
--- a/cmd/net-lwip.c
+++ b/cmd/net-lwip.c
@@ -2,6 +2,10 @@
 /* Copyright (C) 2024 Linaro Ltd. */
 
 #include <command.h>
+#include <dm/device.h>
+#include <dm/uclass.h>
+#include <linux/compat.h>
+#include <linux/ethtool.h>
 #include <net-lwip.h>
 
 #if defined(CONFIG_CMD_DHCP)
@@ -35,3 +39,11 @@ U_BOOT_CMD(
 	"hostname [envvar]"
 );
 #endif
+
+#if defined(CONFIG_CMD_WGET)
+U_BOOT_CMD(
+	wget,   3,      1,      do_wget,
+	"boot image via network using HTTP protocol",
+	"[loadAddress] URL"
+);
+#endif
diff --git a/cmd/net.c b/cmd/net.c
index d407d8320a3..03b4582204f 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -676,118 +676,3 @@ U_BOOT_CMD(
 );
 
 #endif  /* CONFIG_CMD_LINK_LOCAL */
-
-static int do_net_list(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	const struct udevice *current = eth_get_dev();
-	unsigned char env_enetaddr[ARP_HLEN];
-	const struct udevice *dev;
-	struct uclass *uc;
-
-	uclass_id_foreach_dev(UCLASS_ETH, dev, uc) {
-		eth_env_get_enetaddr_by_index("eth", dev_seq(dev), env_enetaddr);
-		printf("eth%d : %s %pM %s\n", dev_seq(dev), dev->name, env_enetaddr,
-		       current == dev ? "active" : "");
-	}
-	return CMD_RET_SUCCESS;
-}
-
-static int do_net_stats(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	int nstats, err, i, off;
-	struct udevice *dev;
-	u64 *values;
-	u8 *strings;
-
-	if (argc < 2)
-		return CMD_RET_USAGE;
-
-	err = uclass_get_device_by_name(UCLASS_ETH, argv[1], &dev);
-	if (err) {
-		printf("Could not find device %s\n", argv[1]);
-		return CMD_RET_FAILURE;
-	}
-
-	if (!eth_get_ops(dev)->get_sset_count ||
-	    !eth_get_ops(dev)->get_strings ||
-	    !eth_get_ops(dev)->get_stats) {
-		printf("Driver does not implement stats dump!\n");
-		return CMD_RET_FAILURE;
-	}
-
-	nstats = eth_get_ops(dev)->get_sset_count(dev);
-	strings = kcalloc(nstats, ETH_GSTRING_LEN, GFP_KERNEL);
-	if (!strings)
-		return CMD_RET_FAILURE;
-
-	values = kcalloc(nstats, sizeof(u64), GFP_KERNEL);
-	if (!values)
-		goto err_free_strings;
-
-	eth_get_ops(dev)->get_strings(dev, strings);
-	eth_get_ops(dev)->get_stats(dev, values);
-
-	off = 0;
-	for (i = 0; i < nstats; i++) {
-		printf("  %s: %llu\n", &strings[off], values[i]);
-		off += ETH_GSTRING_LEN;
-	};
-
-	return CMD_RET_SUCCESS;
-
-err_free_strings:
-	kfree(strings);
-
-	return CMD_RET_FAILURE;
-}
-
-static struct cmd_tbl cmd_net[] = {
-	U_BOOT_CMD_MKENT(list, 1, 0, do_net_list, "", ""),
-	U_BOOT_CMD_MKENT(stats, 2, 0, do_net_stats, "", ""),
-};
-
-static int do_net(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct cmd_tbl *cp;
-
-	cp = find_cmd_tbl(argv[1], cmd_net, ARRAY_SIZE(cmd_net));
-
-	/* Drop the net command */
-	argc--;
-	argv++;
-
-	if (!cp || argc > cp->maxargs)
-		return CMD_RET_USAGE;
-	if (flag == CMD_FLAG_REPEAT && !cmd_is_repeatable(cp))
-		return CMD_RET_SUCCESS;
-
-	return cp->cmd(cmdtp, flag, argc, argv);
-}
-
-U_BOOT_CMD(
-	net, 3, 1, do_net,
-	"NET sub-system",
-	"list - list available devices\n"
-	"stats <device> - dump statistics for specified device\n"
-);
-
-#if defined(CONFIG_CMD_NCSI)
-static int do_ncsi(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
-{
-	if (!phy_interface_is_ncsi() || !ncsi_active()) {
-		printf("Device not configured for NC-SI\n");
-		return CMD_RET_FAILURE;
-	}
-
-	if (net_loop(NCSI) < 0)
-		return CMD_RET_FAILURE;
-
-	return CMD_RET_SUCCESS;
-}
-
-U_BOOT_CMD(
-	ncsi,	1,	1,	do_ncsi,
-	"Configure attached NIC via NC-SI",
-	""
-);
-#endif  /* CONFIG_CMD_NCSI */
diff --git a/include/net-lwip.h b/include/net-lwip.h
index 0019d1524e5..6fda940fec2 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -51,6 +51,56 @@ int eth_env_get_enetaddr_by_index(const char *base_name, int index,
 int eth_init(void);			/* Initialize the device */
 int eth_send(void *packet, int length);	   /* Send a packet */
 int eth_rx(void);
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
+int eth_get_dev_index(void);
 const char *eth_get_name(void);
 int eth_get_dev_index(void);
 int eth_init_state_only(void); /* Set active state */
@@ -85,5 +135,6 @@ int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_tftpb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
+int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
 
 #endif /* __NET_LWIP_H__ */
diff --git a/net-lwip/Makefile b/net-lwip/Makefile
index aa247859483..bc011bb0e32 100644
--- a/net-lwip/Makefile
+++ b/net-lwip/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_CMD_DHCP) += dhcp.o
 obj-$(CONFIG_CMD_DNS) += dns.o
 obj-$(CONFIG_CMD_PING) += ping.o
 obj-$(CONFIG_CMD_TFTPBOOT) += tftp.o
+obj-$(CONFIG_CMD_WGET) += wget.o
 
 # Disable this warning as it is triggered by:
 # sprintf(buf, index ? "foo%d" : "foo", index)
diff --git a/net-lwip/wget.c b/net-lwip/wget.c
new file mode 100644
index 00000000000..e3e6f525674
--- /dev/null
+++ b/net-lwip/wget.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2024 Linaro Ltd. */
+
+#include <command.h>
+#include <console.h>
+#include <display_options.h>
+#include <image.h>
+#include <lwip/apps/http_client.h>
+#include <lwip/timeouts.h>
+#include <net-lwip.h>
+#include <time.h>
+
+#define SERVER_NAME_SIZE 200
+#define HTTP_PORT_DEFAULT 80
+
+static ulong daddr;
+static ulong saved_daddr;
+static ulong size;
+static ulong prevsize;
+#define PROGRESS_PRINT_STEP_BYTES (100 * 1024)
+static ulong start_time;
+static enum done_state {
+        NOT_DONE = 0,
+        SUCCESS = 1,
+        FAILURE = 2
+} done;
+
+static int parse_url(char *url, char *host, u16 *port, char **path)
+{
+	char *p, *pp;
+	long lport;
+
+	p = strstr(url, "http://");
+	if (!p)
+		return -EINVAL;
+
+	p += strlen("http://");
+
+	/* Parse hostname */
+	pp = strchr(p, ':');
+	if (!pp)
+		pp = strchr(p, '/');
+	if (!pp)
+		return -EINVAL;
+
+	if (p + SERVER_NAME_SIZE <= pp)
+		return -EINVAL;
+
+	memcpy(host, p, pp - p);
+	host[pp - p + 1] = '\0';
+
+	if (*pp == ':') {
+		/* Parse port number */
+		p = pp + 1;
+		lport = simple_strtol(p, &pp, 10);
+		if (pp && *pp != '/')
+			return -EINVAL;
+		if (lport > 65535)
+			return -EINVAL;
+		*port = (u16)lport;
+	} else {
+		*port = HTTP_PORT_DEFAULT;
+	}
+	if (*pp != '/')
+		return -EINVAL;
+	*path = pp;
+
+	return 0;
+}
+
+static err_t httpc_recv_cb(void *arg, struct altcp_pcb *pcb, struct pbuf *pbuf,
+			   err_t err)
+{
+	struct pbuf *buf;
+
+	if (!pbuf)
+		return ERR_BUF;
+
+	for (buf = pbuf; buf; buf = buf->next) {
+		memcpy((void *)daddr, buf->payload, buf->len);
+		daddr += buf->len;
+		size += buf->len;
+		if (size - prevsize > PROGRESS_PRINT_STEP_BYTES) {
+			printf("#");
+			prevsize = size;
+		}
+	}
+
+	altcp_recved(pcb, pbuf->tot_len);
+	pbuf_free(pbuf);
+	return ERR_OK;
+}
+
+static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
+			    u32_t rx_content_len, u32_t srv_res, err_t err)
+{
+	ulong elapsed;
+
+	if (httpc_result != HTTPC_RESULT_OK) {
+		log_err("\nHTTP client error %d\n", httpc_result);
+		done = FAILURE;
+		return;
+	}
+
+	elapsed = get_timer(start_time);
+        log_info("\n%u bytes transferred in %lu ms (", rx_content_len,
+                 get_timer(start_time));
+        print_size(rx_content_len / elapsed * 1000, "/s)\n");
+
+	if (env_set_hex("filesize", rx_content_len) ||
+	    env_set_hex("fileaddr", saved_daddr)) {
+		log_err("Could not set filesize or fileaddr\n");
+		done = FAILURE;
+		return;
+	}
+
+	done = SUCCESS;
+}
+
+int wget_with_dns(ulong dst_addr, char *uri)
+{
+	char server_name[SERVER_NAME_SIZE];
+	httpc_connection_t conn;
+	httpc_state_t *state;
+	char *path;
+	u16 port;
+
+	daddr = dst_addr;
+	saved_daddr = dst_addr;
+	done = NOT_DONE;
+	size = 0;
+	prevsize = 0;
+
+	if (parse_url(uri, server_name, &port, &path))
+		return CMD_RET_USAGE;
+
+	memset(&conn, 0, sizeof(conn));
+	conn.result_fn = httpc_result_cb;
+	start_time = get_timer(0);
+	if (httpc_get_file_dns(server_name, port, path, &conn, httpc_recv_cb,
+			       NULL, &state))
+		return CMD_RET_FAILURE;
+
+	while (!done) {
+		eth_rx();
+		sys_check_timeouts();
+		if (ctrlc())
+			break;
+	}
+
+	if (done == SUCCESS)
+		return 0;
+
+	return -1;
+}
+
+int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[])
+{
+	char *end;
+	char *url;
+	ulong dst_addr;
+
+	if (argc < 2 || argc > 3)
+		return CMD_RET_USAGE;
+
+	dst_addr = hextoul(argv[1], &end);
+        if (end == (argv[1] + strlen(argv[1]))) {
+		if (argc < 3)
+			return CMD_RET_USAGE;
+		url = argv[2];
+	} else {
+		dst_addr = image_load_addr;
+		url = argv[1];
+	}
+
+	if (wget_with_dns(dst_addr, url))
+		return CMD_RET_FAILURE;
+
+	return CMD_RET_SUCCESS;
+}
-- 
2.40.1

