Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 191EBEE7FF3
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 13:57:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD7E186AA8;
	Fri,  8 Sep 2023 15:55:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kFhGJc+R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AF1C86A2F; Fri,  8 Sep 2023 15:55:58 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4848886A17
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 15:55:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2b9c907bc68so35551691fa.2
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 06:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694181354; x=1694786154; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ash13g7/if63QP3IHtWSLLGMQlWqbPSmRPF1wXNTlyw=;
 b=kFhGJc+RYdW+me09AXi8Jkhgp3z9dBlBecH88Ft01sQMNUWcy1N70zjiQOx8/265EC
 8RBap/4LwHFZyQ1lFlQ1cMMBCdeV2Yw/IiciQpDBYlWKmWXOBA0JJbFDejRE/E5YzcK6
 Gd4+QieB0mLvXfT2zfGDcBwwHfPu1pzA4V+oe6XXMKnCepxP11rg/B74Y2cIqBYCXdKC
 UrIgSJoWmOVBLthDAK3kih7UNuKS1MvVVNjBcfegu3qUVSipKO2tlmebN+XH73AbUZEw
 JWOvCnQueKOt23LDxFUXZNvXbJpTrOiqpOWajBGW2X63Zmc/UZSshoMmbgUFCk1GD779
 fXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694181354; x=1694786154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ash13g7/if63QP3IHtWSLLGMQlWqbPSmRPF1wXNTlyw=;
 b=Pa25C7z6x0pN16GTLPjUiSgQJ+RwDrM1pe1BFZTdNGNIJpbbj6TJNKP1pju4ZyCrDl
 F0jA0i78EiQhxsOlQTG6Viv1LihVnSu7+EQPtQsWFXPzMOrh6qc/5h3p3jK8mX4UpzEQ
 uOzdu5aFGOepFvTn27V1U7vNJWHctr0GPWqBU9bMvA51Jicgmjg/t0v9i1absAP0zm7b
 XYXcmlI1KJ+egRgazlp8VI7n5UJ4/fk/kYa2m9U97lFAXdcNJvBKbuH4pjYa4tS/2dWT
 50MLG3J7gVOcPkT0Du8XrZrvVmnTSR6Mb8REe/p9P9GbrRO7T5BzHNBuqGzYjbK/00E+
 0osg==
X-Gm-Message-State: AOJu0YxmxpJcSALIhZ3ZM1fK2YPkI7r0RBDudLI5d/XjhtcTarS/mdJz
 D9F14+mLAsvX8ZHLv17+/iopWRjzK2iWhlZWB67/7A==
X-Google-Smtp-Source: AGHT+IFd1/2RZyPpmguuTVGSAJNvjvMEoboKI65Tl7dZ3iZd4oKQZszhP3hrSZ9zo92ShWglerfAVg==
X-Received: by 2002:a2e:a406:0:b0:2b9:412a:111d with SMTP id
 p6-20020a2ea406000000b002b9412a111dmr2189491ljn.42.1694181354277; 
 Fri, 08 Sep 2023 06:55:54 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 u14-20020a2e9f0e000000b002bcbae4c21fsm306907ljk.50.2023.09.08.06.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 06:55:54 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv8 09/15] net/lwip: implement lwIP port to U-Boot
Date: Fri,  8 Sep 2023 19:53:14 +0600
Message-Id: <20230908135320.7066-10-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230908135320.7066-1-maxim.uvarov@linaro.org>
References: <20230908135320.7066-1-maxim.uvarov@linaro.org>
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
 net/eth-uclass.c                      |   8 +
 net/lwip/port/if.c                    | 332 ++++++++++++++++++++++++++
 net/lwip/port/include/arch/cc.h       |  38 +++
 net/lwip/port/include/arch/sys_arch.h |  10 +
 net/lwip/port/include/limits.h        |   0
 net/lwip/port/sys-arch.c              |  13 +
 6 files changed, 401 insertions(+)
 create mode 100644 net/lwip/port/if.c
 create mode 100644 net/lwip/port/include/arch/cc.h
 create mode 100644 net/lwip/port/include/arch/sys_arch.h
 create mode 100644 net/lwip/port/include/limits.h
 create mode 100644 net/lwip/port/sys-arch.c

diff --git a/net/eth-uclass.c b/net/eth-uclass.c
index c393600fab..6625f6d8a5 100644
--- a/net/eth-uclass.c
+++ b/net/eth-uclass.c
@@ -32,6 +32,7 @@ DECLARE_GLOBAL_DATA_PTR;
 struct eth_device_priv {
 	enum eth_state_t state;
 	bool running;
+	ulwip ulwip;
 };
 
 /**
@@ -347,6 +348,13 @@ int eth_init(void)
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
diff --git a/net/lwip/port/if.c b/net/lwip/port/if.c
new file mode 100644
index 0000000000..0025b1273f
--- /dev/null
+++ b/net/lwip/port/if.c
@@ -0,0 +1,332 @@
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
+#define MAC_ADDR_STRLEN 17
+
+int ulwip_enabled(void)
+{
+	struct udevice *udev;
+	struct ulwip *ulwip;
+
+	udev = eth_get_dev();
+	if (!udev)
+		return 0;
+
+	ulwip = eth_lwip_priv(udev);
+	return ulwip->init_done;
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
+static struct pbuf *low_level_input(void)
+{
+	struct pbuf *p, *q;
+	u16_t len = net_rx_packet_len;
+	uchar *data = net_rx_packet;
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
+void ulwip_poll(void)
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
+	p = low_level_input();
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
+	struct ethernetif *ethernetif;
+
+	ethernetif = netif->state;
+
+	/* move received packet into a new pbuf */
+	p = low_level_input();
+
+	/* if no packet could be read, silently ignore this */
+	if (p) {
+		/* pass all packets to ethernet_input, which decides what packets it supports */
+		if (netif->input(p, netif) != ERR_OK) {
+			LWIP_DEBUGF(NETIF_DEBUG, ("%s: IP input error\n", __func__));
+			pbuf_free(p);
+			p = NULL;
+		}
+	}
+
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
+	ret = eth_init();
+	if (ret) {
+		log_err("eth_init error %d\n", ret);
+		return ERR_IF;
+	}
+
+	udev = eth_get_dev();
+	if (!udev) {
+		log_err("no active eth device\n");
+		return ERR_IF;
+	}
+
+	eth_set_current();
+
+	ulwip = eth_lwip_priv(udev);
+	if (ulwip->init_done) {
+		log_info("init already done for %s\n", udev->name);
+		return CMD_RET_SUCCESS;
+	}
+
+	uclass_id_foreach_dev(UCLASS_ETH, dev, uc) {
+		char ipstr[IP4ADDR_STRLEN_MAX];
+		char maskstr[IP4ADDR_STRLEN_MAX];
+		char gwstr[IP4ADDR_STRLEN_MAX];
+		char hwstr[MAC_ADDR_STRLEN];
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
+		ipaddr_aton(env_get(ipstr), &ipaddr);
+		ipaddr_aton(env_get(maskstr), &netmask);
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
+	return CMD_RET_SUCCESS;
+}
+
+/* placeholder, not used now */
+void ulwip_destroy(void)
+{
+}
diff --git a/net/lwip/port/include/arch/cc.h b/net/lwip/port/include/arch/cc.h
new file mode 100644
index 0000000000..23fd51c308
--- /dev/null
+++ b/net/lwip/port/include/arch/cc.h
@@ -0,0 +1,38 @@
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
+						    handler; }} while (0)
+#endif
+
+#define LWIP_DONT_PROVIDE_BYTEORDER_FUNCTIONS
+
+#define LWIP_PLATFORM_ASSERT(x) do {printf("Assertion \"%s\" failed at line %d in %s\n", \
+				    x, __LINE__, __FILE__); } while (0)
+
+#define atoi(str) (int)dectoul(str, NULL)
+
+#define LWIP_ERR_T int
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

