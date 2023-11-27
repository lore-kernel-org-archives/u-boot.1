Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0709AC4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:02:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9357875A0;
	Mon, 27 Nov 2023 14:00:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i5DFrayL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 148A0875A1; Mon, 27 Nov 2023 14:00:37 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E29FF87515
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:00:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50aaaf6e58fso6349594e87.2
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090032; x=1701694832; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WFhPMt/MmIvRFR8Ozw7h9vmh/ZDYm1mfbwP2T4bUmDI=;
 b=i5DFrayLdYKrghV0jzTXIN0L30MVTGumPjBB4Q7nzQ06IDZbEaUOkBy2R5PiSuei1L
 V4NX+MXpDl3tfNfIXOk6xm4okiNKyIcrY6SVVsEl9qvjK893gZgW1uCy/4vjDpKCukQC
 86xPqk05WP58monlQUm5w0+r1QsA8lrILnTuil4/KV/0XJbHJvzZ0ryT82Z8+mXo5sUy
 3h7O8/cUgmnRToPRrTgDgJuhC9n3tXCsEu6aRBrIkUGrNMbpyGGmzf/hQLGT4bTgIQN2
 rC0zJbMBNlxu486YE7rYIwvVe2J7TppdlAsTvb4jjuxz+tOj9ehYXTltI8p8O1q/hR+i
 11XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090032; x=1701694832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WFhPMt/MmIvRFR8Ozw7h9vmh/ZDYm1mfbwP2T4bUmDI=;
 b=qv7ajnPiDqmEcCU3ZDm6jj1WV1TvigF/DXnyd6UcBO9cj87spDAkO+hTgm49D6r0Pi
 Ttegs2SlbMgYMKGro2WOocVgLTewpz5UTr2/KcuJzoZYHPnkiIY6PDaNzLHKZvkJgDRW
 WJ/NRZTPXVeLOTgKmpm+QLFx+UiCCCThMjlckpiadx9GoTQ92XrGX633Ipfdexk22XdT
 /kFgCkZ0sBxUbtsoDYfh8xBKh/9U3LW83il7YkZTXdNZ1Nn61avHOGlxCzyCnUJN61z4
 2NnPwQe5N9hVNqSHdXxWdiCN9qr+4ISbUp7tgy86yylrC7PNcsTUX37zbRPhY/R0Fvql
 L9Tg==
X-Gm-Message-State: AOJu0YwdOqN8NQoR5mooAOVWh0vk16l434bujv/u2rX2pJujgGyzkKC2
 MLjDKcOQFXxLDeN6O3s2EmOowtRJ9Ykawd3aiJy0fA==
X-Google-Smtp-Source: AGHT+IF1ZNNrMltpJ8CbXQl86LmalKFsomYyWc3tdF7XpsLFyOHnOjlZGGt9Vgws7/KpDMysERWZdA==
X-Received: by 2002:ac2:5b04:0:b0:50a:aa72:f00d with SMTP id
 v4-20020ac25b04000000b0050aaa72f00dmr7513424lfn.29.1701090031694; 
 Mon, 27 Nov 2023 05:00:31 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.00.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:00:31 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 10/43] net/lwip: implement lwIP port to U-Boot
Date: Mon, 27 Nov 2023 18:56:53 +0600
Message-Id: <20231127125726.3735-11-maxim.uvarov@linaro.org>
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

Implement port of lwIP stack to the U-Boot. lwIP is well known full IP stack
which provides wide functionality, various examples, API closer to linux userland.
Rich debug printing and possibility to run lwIP apps under linux make it
easier to develop and debug apps.
U-Boot implementation keeps the original file structure widely used for lwIP ports.
(i.e. port/if.c port/sys-arch.c). That should allow us to easy port apps to or
from U-Boot. Multiply ethernet devices are supported and "ethact" env variable
chooses the active device.
Having a rich IP stack inside U-Boot will allow us to have such applications
as http or https clients.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 lib/Kconfig                           |   2 +-
 net/eth-uclass.c                      |  37 ++-
 net/lwip/Kconfig                      |   1 +
 net/lwip/port/if.c                    | 327 ++++++++++++++++++++++++++
 net/lwip/port/include/arch/cc.h       |  44 ++++
 net/lwip/port/include/arch/sys_arch.h |  10 +
 net/lwip/port/include/limits.h        |   0
 net/lwip/port/sys-arch.c              |  13 +
 8 files changed, 426 insertions(+), 8 deletions(-)
 create mode 100644 net/lwip/port/if.c
 create mode 100644 net/lwip/port/include/arch/cc.h
 create mode 100644 net/lwip/port/include/arch/sys_arch.h
 create mode 100644 net/lwip/port/include/limits.h
 create mode 100644 net/lwip/port/sys-arch.c

diff --git a/lib/Kconfig b/lib/Kconfig
index 19649517a3..915402e843 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -258,7 +258,7 @@ config REGEX
 choice
 	prompt "Pseudo-random library support type"
 	depends on NET_RANDOM_ETHADDR || RANDOM_UUID || CMD_UUID || \
-		   RNG_SANDBOX || UT_LIB && AES || FAT_WRITE
+		   RNG_SANDBOX || UT_LIB && AES || FAT_WRITE || LWIP
 	default LIB_RAND
 	help
 	  Select the library to provide pseudo-random number generator
diff --git a/net/eth-uclass.c b/net/eth-uclass.c
index 3d0ec91dfa..f57da423f5 100644
--- a/net/eth-uclass.c
+++ b/net/eth-uclass.c
@@ -21,6 +21,7 @@
 #include <net/pcap.h>
 #include "eth_internal.h"
 #include <eth_phy.h>
+#include <net/ulwip.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -32,6 +33,7 @@ DECLARE_GLOBAL_DATA_PTR;
 struct eth_device_priv {
 	enum eth_state_t state;
 	bool running;
+	ulwip ulwip;
 };
 
 /**
@@ -347,6 +349,13 @@ int eth_init(void)
 	return ret;
 }
 
+struct ulwip *eth_lwip_priv(struct udevice *current)
+{
+	struct eth_device_priv *priv = dev_get_uclass_priv(current);
+
+	return &priv->ulwip;
+}
+
 void eth_halt(void)
 {
 	struct udevice *current;
@@ -420,8 +429,13 @@ int eth_rx(void)
 	for (i = 0; i < ETH_PACKETS_BATCH_RECV; i++) {
 		ret = eth_get_ops(current)->recv(current, flags, &packet);
 		flags = 0;
-		if (ret > 0)
-			net_process_received_packet(packet, ret);
+		if (ret > 0) {
+			if (ulwip_active())
+				ulwip_poll(packet, ret);
+			else
+				net_process_received_packet(packet, ret);
+		}
+
 		if (ret >= 0 && eth_get_ops(current)->free_pkt)
 			eth_get_ops(current)->free_pkt(current, packet, ret);
 		if (ret <= 0)
@@ -555,6 +569,7 @@ static int eth_post_probe(struct udevice *dev)
 	struct eth_pdata *pdata = dev_get_plat(dev);
 	unsigned char env_enetaddr[ARP_HLEN];
 	char *source = "DT";
+	int ret;
 
 	priv->state = ETH_STATE_INIT;
 	priv->running = false;
@@ -587,18 +602,26 @@ static int eth_post_probe(struct udevice *dev)
 		/* Override the ROM MAC address */
 		memcpy(pdata->enetaddr, env_enetaddr, ARP_HLEN);
 	} else if (is_valid_ethaddr(pdata->enetaddr)) {
-		eth_env_set_enetaddr_by_index("eth", dev_seq(dev),
-					      pdata->enetaddr);
+		ret = eth_env_set_enetaddr_by_index("eth", dev_seq(dev),
+						    pdata->enetaddr);
+		if (ret) {
+			log_err("Error update env for eth%d\n", dev_seq(dev));
+			return -EINVAL;
+		}
 	} else if (is_zero_ethaddr(pdata->enetaddr) ||
 		   !is_valid_ethaddr(pdata->enetaddr)) {
 #ifdef CONFIG_NET_RANDOM_ETHADDR
 		net_random_ethaddr(pdata->enetaddr);
 		printf("\nWarning: %s (eth%d) using random MAC address - %pM\n",
 		       dev->name, dev_seq(dev), pdata->enetaddr);
-		eth_env_set_enetaddr_by_index("eth", dev_seq(dev),
-					      pdata->enetaddr);
+		ret = eth_env_set_enetaddr_by_index("eth", dev_seq(dev),
+						    pdata->enetaddr);
+		if (ret) {
+			log_err("Error update env for eth%d\n", dev_seq(dev));
+			return -EINVAL;
+		}
 #else
-		printf("\nError: %s No valid MAC address found.\n",
+		log_err("\nError: %s No valid MAC address found.\n",
 		       dev->name);
 		return -EINVAL;
 #endif
diff --git a/net/lwip/Kconfig b/net/lwip/Kconfig
index 295261a042..9135dee6b4 100644
--- a/net/lwip/Kconfig
+++ b/net/lwip/Kconfig
@@ -1,6 +1,7 @@
 menu "lwIP"
 config LWIP
 	bool "Support LWIP library"
+	select LIB_RAND
 	help
 	  Enable the lwIP library code with
 	  all dependencies (commands are implemented with lwIP
diff --git a/net/lwip/port/if.c b/net/lwip/port/if.c
new file mode 100644
index 0000000000..ed15f4a459
--- /dev/null
+++ b/net/lwip/port/if.c
@@ -0,0 +1,327 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
+ */
+
+#include <common.h>
+#include <command.h>
+#include <net/eth.h>
+#include <dm/device.h>
+#include <dm/uclass-id.h>
+#include <dm/uclass.h>
+#include "lwip/debug.h"
+#include "lwip/arch.h"
+#include "netif/etharp.h"
+#include "lwip/stats.h"
+#include "lwip/def.h"
+#include "lwip/mem.h"
+#include "lwip/pbuf.h"
+#include "lwip/sys.h"
+#include "lwip/netif.h"
+#include "lwip/ethip6.h"
+#include "lwip/timeouts.h"
+
+#include "lwip/ip.h"
+
+/*
+ * MAC_ADDR_STRLEN: length of mac address string
+ */
+#define MAC_ADDR_STRLEN 18
+
+int ulwip_active(void)
+{
+	struct udevice *udev;
+	struct ulwip *ulwip;
+
+	udev = eth_get_dev();
+	if (!udev)
+		return 0;
+
+	ulwip = eth_lwip_priv(udev);
+	return ulwip->active;
+}
+
+int ulwip_in_loop(void)
+{
+	struct udevice *udev;
+	struct ulwip *ulwip;
+
+	udev = eth_get_dev();
+	if (!udev)
+		return 0;
+
+	sys_check_timeouts();
+
+	ulwip = eth_lwip_priv(udev);
+	return ulwip->loop;
+}
+
+void ulwip_loop_set(int loop)
+{
+	struct udevice *udev;
+	struct ulwip *ulwip;
+
+	udev = eth_get_dev();
+	if (!udev)
+		return;
+
+	ulwip = eth_lwip_priv(udev);
+	ulwip->loop = loop;
+}
+
+void ulwip_exit(int err)
+{
+	struct udevice *udev;
+	struct ulwip *ulwip;
+
+	udev = eth_get_dev();
+	if (!udev)
+		return;
+
+	ulwip = eth_lwip_priv(udev);
+	ulwip->loop = 0;
+	ulwip->err = err;
+}
+
+int ulwip_app_get_err(void)
+{
+	struct udevice *udev;
+	struct ulwip *ulwip;
+
+	udev = eth_get_dev();
+	if (!udev)
+		return 0;
+
+	ulwip = eth_lwip_priv(udev);
+	return ulwip->err;
+}
+
+typedef struct {
+} ulwip_if_t;
+
+static struct pbuf *low_level_input(uchar *data, int len)
+{
+	struct pbuf *p, *q;
+
+	/* We allocate a pbuf chain of pbufs from the pool. */
+	p = pbuf_alloc(PBUF_RAW, len, PBUF_POOL);
+	if (!p) {
+		LINK_STATS_INC(link.memerr);
+		LINK_STATS_INC(link.drop);
+		return NULL;
+	}
+
+	for (q = p; q != NULL; q = q->next) {
+		memcpy(q->payload, data, q->len);
+		data += q->len;
+	}
+
+	LINK_STATS_INC(link.recv);
+
+	return p;
+}
+
+void ulwip_poll(uchar *in_packet, int len)
+{
+	struct pbuf *p;
+	int err;
+	struct netif *netif;
+	int eth_idx;
+
+	eth_idx = eth_get_dev_index();
+	if (eth_idx < 0) {
+		log_err("no eth idx\n");
+		return;
+	}
+
+	netif = netif_get_by_index(eth_idx + 1);
+	if (!netif) {
+		log_err("!netif\n");
+		return;
+	}
+
+	p = low_level_input(in_packet, len);
+	if (!p) {
+		log_err("no mem\n");
+		return;
+	}
+
+	/* ethernet_input always returns ERR_OK */
+	err = ethernet_input(p, netif);
+	if (err)
+		log_err("ip4_input err %d\n", err);
+}
+
+static int ethernetif_input(struct pbuf *p, struct netif *netif)
+{
+	return 0;
+}
+
+static err_t low_level_output(struct netif *netif, struct pbuf *p)
+{
+	int err;
+
+	/* switch dev to active state */
+	eth_init_state_only();
+
+	err = eth_send(p->payload, p->len);
+	if (err) {
+		log_err("eth_send error %d\n", err);
+		return ERR_ABRT;
+	}
+	return ERR_OK;
+}
+
+err_t ulwip_if_init(struct netif *netif)
+{
+	ulwip_if_t *uif;
+	struct ulwip *ulwip;
+
+	uif = malloc(sizeof(ulwip_if_t));
+	if (!uif) {
+		log_err("uif: out of memory\n");
+		return ERR_MEM;
+	}
+	netif->state = uif;
+
+#if defined(CONFIG_LWIP_LIB_DEBUG)
+	log_info("              MAC: %02X:%02X:%02X:%02X:%02X:%02X\n",
+		 netif->hwaddr[0], netif->hwaddr[1], netif->hwaddr[2],
+		 netif->hwaddr[3], netif->hwaddr[4], netif->hwaddr[5]);
+	log_info("             NAME: %s\n", netif->name);
+#endif
+#if LWIP_IPV4
+	netif->output = etharp_output;
+#endif
+#if LWIP_IPV6
+	netif->output_ip6 = ethip6_output;
+#endif
+
+	netif->linkoutput = low_level_output;
+	netif->mtu = 1500;
+	netif->flags = NETIF_FLAG_BROADCAST | NETIF_FLAG_ETHARP | NETIF_FLAG_LINK_UP;
+
+	ulwip = eth_lwip_priv(eth_get_dev());
+	ulwip->init_done = 1;
+
+	return ERR_OK;
+}
+
+int ulwip_init(void)
+{
+	ip4_addr_t ipaddr, netmask, gw;
+	struct netif *unetif;
+	struct ulwip *ulwip;
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
+	ulwip = eth_lwip_priv(udev);
+	if (ulwip->init_done) {
+		log_info("init already done for %s\n", udev->name);
+		ret = eth_init();
+		if (ret)
+			return ERR_IF;
+		ulwip->active = 1;
+		return CMD_RET_SUCCESS;
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
+		if (IS_ENABLED(CONFIG_LWIP_LIB_DEBUG)) {
+			log_info("Starting lwIP\n ");
+			log_info("	netdev: %s\n", dev->name);
+			log_info("	    IP: %s\n", ip4addr_ntoa(&ipaddr));
+			log_info("          GW: %s\n", ip4addr_ntoa(&gw));
+			log_info("        mask: %s\n", ip4addr_ntoa(&netmask));
+		}
+
+#if LWIP_IPV6
+#define MAC_FROM_48_BIT 1
+		netif_create_ip6_linklocal_address(unetif, MAC_FROM_48_BIT);
+		log_info("             IPv6: %s\n", ip6addr_ntoa(netif_ip6_addr(unetif, 0)));
+#endif /* LWIP_IPV6 */
+
+		if (!netif_add(unetif, &ipaddr, &netmask, &gw,
+			       unetif, ulwip_if_init, ethernetif_input)) {
+			log_err("err: netif_add failed!\n");
+			free(unetif);
+			return ERR_IF;
+		}
+
+		netif_set_up(unetif);
+		netif_set_link_up(unetif);
+	}
+
+	if (IS_ENABLED(CONFIG_LWIP_LIB_DEBUG)) {
+		log_info("Initialized LWIP stack\n");
+	}
+
+	ulwip->active = 1;
+	return CMD_RET_SUCCESS;
+}
+
+/* placeholder, not used now */
+void ulwip_destroy(void)
+{
+}
diff --git a/net/lwip/port/include/arch/cc.h b/net/lwip/port/include/arch/cc.h
new file mode 100644
index 0000000000..74d0a0932a
--- /dev/null
+++ b/net/lwip/port/include/arch/cc.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
+ */
+
+#ifndef LWIP_ARCH_CC_H
+#define LWIP_ARCH_CC_H
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <vsprintf.h>
+#include <rand.h>
+
+#define LWIP_ERRNO_INCLUDE <errno.h>
+
+#define LWIP_ERRNO_STDINCLUDE	1
+#define LWIP_NO_UNISTD_H 1
+#define LWIP_TIMEVAL_PRIVATE 1
+
+#define LWIP_RAND() ((u32_t)rand())
+
+/* different handling for unit test, normally not needed */
+#ifdef LWIP_NOASSERT_ON_ERROR
+#define LWIP_ERROR(message, expression, handler) do { if (!(expression)) { \
+						handler; }} while (0)
+#endif
+
+#define LWIP_DONT_PROVIDE_BYTEORDER_FUNCTIONS
+
+#define LWIP_PLATFORM_ASSERT(x) do {printf("Assertion \"%s\" failed at line %d in %s\n", \
+				    x, __LINE__, __FILE__); } while (0)
+
+#define atoi(str) (int)dectoul(str, NULL)
+#define lwip_strnstr(a, b)  strnstr(a, b)
+
+#define LWIP_ERR_T int
+#define LWIP_CONST_CAST(target_type, val) ((target_type)((uintptr_t)val))
+
+#if defined(CONFIG_SYS_BIG_ENDIAN)
+#define BYTE_ORDER BIG_ENDIAN
+#endif
+
+#endif /* LWIP_ARCH_CC_H */
diff --git a/net/lwip/port/include/arch/sys_arch.h b/net/lwip/port/include/arch/sys_arch.h
new file mode 100644
index 0000000000..87a3fb66d1
--- /dev/null
+++ b/net/lwip/port/include/arch/sys_arch.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
+ */
+
+#ifndef LWIP_ARCH_SYS_ARCH_H
+#define LWIP_ARCH_SYS_ARCH_H
+
+#endif /* LWIP_ARCH_SYS_ARCH_H */
diff --git a/net/lwip/port/include/limits.h b/net/lwip/port/include/limits.h
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/net/lwip/port/sys-arch.c b/net/lwip/port/sys-arch.c
new file mode 100644
index 0000000000..68476d16e8
--- /dev/null
+++ b/net/lwip/port/sys-arch.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * (C) Copyright 2023 Linaro Ltd. <maxim.uvarov@linaro.org>
+ */
+
+#include <common.h>
+#include "lwip/opt.h"
+
+u32_t sys_now(void)
+{
+	return get_timer(0);
+}
-- 
2.30.2

