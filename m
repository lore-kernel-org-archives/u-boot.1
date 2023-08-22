Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9576AEE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 09:40:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C521864B1;
	Tue, 22 Aug 2023 11:38:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="a/AmYsDt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADB49864B0; Tue, 22 Aug 2023 11:38:45 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C104F864BF
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 11:38:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2b974031aeaso66336891fa.0
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 02:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692697122; x=1693301922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ac78ua15KGS6OCERsg2uRFiFuYtV7//xLyL+JM3k9ek=;
 b=a/AmYsDtF6uXieuu5PMNQGHMFIJuLnLHL6f8sRxjX4qxXVrd8lyF7bJ7GR2iE+xcZJ
 w6E7JWtKxrwT1QCO947xSgzF9L6DpBqBwKEwhsIFS6UE6ZaAB+DMntm2Gnhk/Bg5NZ28
 XoJlas8zz48Oo8DbKoVA7A4NO/5rXyvXFHeRbZqnQklVewPvTseeMN8AS6VY/g6qm2/y
 Zx3GclJf+iBw39WT+AzAPYkRO8uoWJtp9xEnOopc+91Anpb15Rk+BEHwRFy+U8vaBqDI
 gBPTH++8Xp9sX48NKYBSCzS1ILZOs8Kc2PMeXiRJ5aZY+huidiEyiRyFNLbKnYZYn1Z3
 QJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692697122; x=1693301922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ac78ua15KGS6OCERsg2uRFiFuYtV7//xLyL+JM3k9ek=;
 b=cxqJH2zgo4eSUBMo3reYRXEfouzGnXyIRUhoeDYspmE08FejVzmWCsO362CqI7P/4h
 50ZWJMhPKxbZpYSTmmUtYglJ2Xl5X9HuJC1fYOJN0iQp4eTYcH3iBZmiMRnshfOXU3lH
 boTaEu0QKRl9i1m4tdgHUxja+xqiTa9Z5lcg8/+F0obpNRm+Q4oDbRVW4MYNCbAcS5Cg
 w00RqI/pdbl5OyUPGxxMqu28cml4cQBfrND37XvzuYzr38HjytM0yUxbxfVtnGKLxhFo
 RQ/k8O1bmVzeWgSuM6WDRxMvpU0HmNy4DSa2lnKxEHVwetDy/BJqZkWMkzaHU4L/oI6a
 pBUA==
X-Gm-Message-State: AOJu0Yweu0CA6G6fvFlaGNvdLMYjWgyUrazCti93gQKx/L9IIS7oRPpW
 RzJyc8n2MqsR480V6wooM+Q8hhQ8Ahi5TXJxLCxsRg==
X-Google-Smtp-Source: AGHT+IFLBA+qxY3KTcwlMEElkHlBLipxU8p+S+8y1kGvRys/ilxfSlqftHnoDi2iSwFJjQN52EASDg==
X-Received: by 2002:a2e:8542:0:b0:2b6:d7d1:95bf with SMTP id
 u2-20020a2e8542000000b002b6d7d195bfmr7977330ljj.9.1692697121797; 
 Tue, 22 Aug 2023 02:38:41 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 i9-20020a2e8089000000b002b724063010sm2649637ljg.47.2023.08.22.02.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 02:38:41 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv7 09/15] net/lwip: implement lwIP port to U-Boot
Date: Tue, 22 Aug 2023 15:36:08 +0600
Message-Id: <20230822093614.4717-10-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230822093614.4717-1-maxim.uvarov@linaro.org>
References: <20230822093614.4717-1-maxim.uvarov@linaro.org>
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
 net/lwip/port/if.c                    | 343 ++++++++++++++++++++++++++
 net/lwip/port/include/arch/cc.h       |  38 +++
 net/lwip/port/include/arch/sys_arch.h |  10 +
 net/lwip/port/include/limits.h        |   0
 net/lwip/port/sys-arch.c              |  13 +
 6 files changed, 412 insertions(+)
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
index 0000000000..17842a9bc3
--- /dev/null
+++ b/net/lwip/port/if.c
@@ -0,0 +1,343 @@
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
+	/* We iterate over the pbuf chain until we have read the entire
+	 * packet into the pbuf.
+	 */
+	for (q = p; q != NULL; q = q->next) {
+		/* 
+		 * Read enough bytes to fill this pbuf in the chain. The
+		 * available data in the pbuf is given by the q->len
+		 * variable.
+		 * This does not necessarily have to be a memcpy, you can also preallocate
+		 * pbufs for a DMA-enabled MAC and after receiving truncate it to the
+		 * actually received size. In this case, ensure the tot_len member of the
+		 * pbuf is the sum of the chained pbuf len members.
+		 */
+		MEMCPY(q->payload, data, q->len);
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
+
+	return;
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
+		       udev == dev ? "active" : "");
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
+					unetif, ulwip_if_init, ethernetif_input)) {
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

