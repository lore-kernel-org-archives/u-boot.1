Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61382C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 16:05:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D7F788859;
	Wed, 22 May 2024 18:04:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lQSOcf3V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C85B8886E; Wed, 22 May 2024 18:04:40 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BD5A88851
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 18:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-51f72a29f13so7068753e87.3
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 09:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716393877; x=1716998677; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SyBXk5fPr40U/jXFRA/YhJ3WRcygfdZHv6qUbOAm9Ck=;
 b=lQSOcf3V/ss1gEMQHUHA16Km6G1irtnUc3cuBc877NdHQ9Hkn+82cevBD8R072bpA5
 1UBabcPEgrDguIuAQxb3P0of31r98LI9d7ZWLT3KKGUv+fndifP2Q667HwWzNW19N2jq
 tgIUnm5ntDaMVqjxUrsobm0SFL+/uu8TjlXWCM5O/d3UvO1ImyOpjtvkvq/8VHWIok0a
 tIP4suNBod8DzJ24A2Z0VGOA4d2hzEXOP0QkwgVFS/k/Kb3KonsplyDJybd4CNtnzwKJ
 F+n4CG+TugmbWYAuIEaEaq2Ga7SYohnp30CqKdzTVU2cpM4aRV0ySQNNl6+jkTIn/6kI
 897g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716393877; x=1716998677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SyBXk5fPr40U/jXFRA/YhJ3WRcygfdZHv6qUbOAm9Ck=;
 b=kIdr9lW0W10QR8HOQqZeIUx6AkBc4oaRgrnFPP9wILPWX5p4e1zG7t4LZwF52kkm9H
 K9Jcp4ledxYBtPTniwpbke5HIFFBN/b7tBQ7CJX7vfW/IKDDdaPb4v5uP4DtsLHoHVqG
 UTyqVxb0iinnm4hW6X/Xb5sENazT6TUhZMWK39KHuNBRk9+N8O8Zd/YKCyCQfJyAduN2
 mxFl679zctHujjo+T+dpQz/ajde32R6Fm0x8F5+Yni8QEpYG43JR5wyXgpMki94Uf38W
 xz46HFbxNNugOPnTV591o2bs55tfyir04Wy1jn/qZ/TAaqor3IRFIKxv6p4v/yJHH/CO
 YNjA==
X-Gm-Message-State: AOJu0YwwdwzDOXnvsaOkwAY4tW6gMSsemb7tG83NONaXERMCAf1XlElE
 0LRLQ8V19rq+ChW46NjUO/Mltt5EI+/stxmE9mL2i1IUNXHFrp/lCyJMs4sDKTNBPxStdOIdOZc
 WrVUAjZxT
X-Google-Smtp-Source: AGHT+IGJ0NDjDZwZnsG8ZtrM6GfF2BVgm3iqSdVVmpydR/UyVRZ9gFEw2Q0wNj3egBeNlANTLbuGtA==
X-Received: by 2002:ac2:5312:0:b0:51c:8b45:c9fb with SMTP id
 2adb3069b0e04-526bf54bea0mr1630456e87.69.1716393877360; 
 Wed, 22 May 2024 09:04:37 -0700 (PDT)
Received: from jerome-XPS-13-9310.. ([2a01:e0a:3cb:7bb0:d6a3:fbd6:c45b:172c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6209f64ba8sm367670266b.210.2024.05.22.09.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 09:04:37 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/15] net-lwip: import net command from cmd/net.c
Date: Wed, 22 May 2024 18:00:08 +0200
Message-Id: <8c97a1e0a572fde6a764c2d20bd0fc1376e1cf90.1716393035.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716393035.git.jerome.forissier@linaro.org>
References: <cover.1716393035.git.jerome.forissier@linaro.org>
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

Add support for "net list" and "net stats" to net-lwip/ by copying the
code from cmd/net.c.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 cmd/net-lwip.c     | 98 ++++++++++++++++++++++++++++++++++++++++++++++
 include/net-lwip.h | 50 +++++++++++++++++++++++
 2 files changed, 148 insertions(+)

diff --git a/cmd/net-lwip.c b/cmd/net-lwip.c
index 2926399bd0..20d0d61176 100644
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
 
 #if defined(CONFIG_CMD_DHCP_LWIP)
@@ -43,3 +47,97 @@ U_BOOT_CMD(
 	"[loadAddress] URL"
 );
 #endif
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
diff --git a/include/net-lwip.h b/include/net-lwip.h
index 23ad70fc09..6fda940fec 100644
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
-- 
2.40.1

