Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48980C28B2F
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 21:56:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F1E3820B7;
	Fri, 14 Mar 2025 22:56:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oQltzK0b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B95281F0B; Fri, 14 Mar 2025 22:56:00 +0100 (CET)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42F0F82054
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 22:55:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso1423905e9.2
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 14:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741989357; x=1742594157; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hDKvoRf4CBNId6VlxtZ8TbnYRtbGMmAJh+xQ16DgIaU=;
 b=oQltzK0bxD7a4ryMilZzC+jv26tmS13Rp3MkvdW7sgZl5acCc0hlsIzVyGWMrxHtxg
 IsV5QF/VeqsH/QJPxB6KL4NhV3twMrlZcbJXgt+6/J6StQak4ZloOkAt0Omb9nI31jWO
 W5+16XHhFvfzMsoyqyBSmxtMdWxAt1CMb+pT1bCzX6GtMhZSwVylOOe8vQn778geHTps
 MDC1KkQFEH8vnNU2QRhRzCGc+R1GCEbTdr4qDRuoatIKt7amVVotxoR6Xso5vjPI51rt
 kuq9Kl8ygVOE748QljZTauVYjRRshdxpYERljF8Gpb6l/SmNZWeRn5cjZz1czm0iGAxt
 pd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741989357; x=1742594157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hDKvoRf4CBNId6VlxtZ8TbnYRtbGMmAJh+xQ16DgIaU=;
 b=XSZCPqahNJs1GHLdZHCgmCjFkx4+uuLbTdrGNvZuHljuiJS9SM7Ya8dGvhBqR6ON0b
 EQc1FwIKhOWF6kvg28/TMzX3Srj3cM7kbC3LCNgVrmqpBfgR5IXF/eibL4YFKy5+lMwY
 tnOcorbSjCGOT3orRj+ORQhoscZtCpFM5A13V1wCX89603LtcqHMtpfYO6vM+/wYXpaa
 40ZK4h91exISu4HQjFEJ7N/zb5FkW1rt5lrC3K1wIH3yia/d/JS4oUiRhbdtyNtYnp96
 exVvmi1pCmyazN9L1+l4lGNIu+pMFs5Z2WPMt1M38d4VWxGvAbIh8+bbzn7jcrFYywCI
 gWVw==
X-Gm-Message-State: AOJu0YwVRZDqZ7Mm58U2Z5Ww++bN4NE8PiMZ41ZYmaJ4juStEHDhN1yu
 QjLjLraHwWyaYkf1jPiVQqz4NkNqvGBFj32lei70b7Bp4RQ0st6rmric9+LZM4bmyvihuXhv4zh
 9gpciBg==
X-Gm-Gg: ASbGncuUQHlUkRZAGYtPBT9z3lC0laY8R9pg3FBSqHVexZLEX7Arz8p7Y1ojdTGucq6
 dMHrnu33qqagwDhGtuSJR6IQomvFmQ5C/JqGdLBLfCRbSqOoMwZtxM+HtlP/TpaMO816DIIRJ4y
 EQPDKRoJnjJT8d2vxJABFZ270LdeDbMouCqOnULmzdPzX9ksPMkKUCXbdbW9t4CpidW4zXrLBb9
 ELqWe7PAOsU28d+DF6k1l3ZK3XttUWDjeq5NmTp0/J32e8GI4tAH8egTJHRXbKtY1sgNWxNxmpT
 /gfVpD4TwI7sZp6jMCzOfyGCuChqQByCRQaZUOQyzT5C62j6BU+O+g==
X-Google-Smtp-Source: AGHT+IFznq4CctNWshOES8eQuqztATTo5nmG7o0ljJFAaHG2XpnP8AYy69tM185wZQ0PxBCvDnSvPA==
X-Received: by 2002:a05:600c:1c86:b0:43c:f4b3:b0ad with SMTP id
 5b1f17b1804b1-43d1ecd0f21mr52217075e9.19.1741989357351; 
 Fri, 14 Mar 2025 14:55:57 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:5485:bb38:c353:6b0c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe05ff4sm29064395e9.10.2025.03.14.14.55.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 14:55:57 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Hanyuan Zhao <hanyuan-z@qq.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Boon Khai Ng <boon.khai.ng@intel.com>, Marek Vasut <marex@denx.de>,
 Romain Naour <romain.naour@smile.fr>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Christophe ROULLIER <christophe.roullier@foss.st.com>,
 Robert Marko <robert.marko@sartura.hr>, Philip Oberfichtner <pro@denx.de>
Subject: [PATCH 06/12] drivers: net: sandbox: add support for NET_LWIP
Date: Fri, 14 Mar 2025 22:55:08 +0100
Message-ID: <20250314215525.579655-7-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314215525.579655-1-jerome.forissier@linaro.org>
References: <20250314215525.579655-1-jerome.forissier@linaro.org>
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

Make the sandbox mock ethernet driver (drivers/net/sandbox.c) compatible
with NET_LWIP by not relying on any of the structures or functions
defined in net-legacy.h. This is done by providing local definitions of
the various protocol structures (Ethernet, ARP, IPv4, ICMP). Drop the
stub driver that was introduced specifically for NET_LWIP
(drivers/net/sandbox-lwip.c).

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 drivers/net/Kconfig        |  13 +-
 drivers/net/Makefile       |   1 -
 drivers/net/sandbox-lwip.c |  85 -------------
 drivers/net/sandbox.c      | 240 ++++++++++++++++++++++++-------------
 4 files changed, 160 insertions(+), 179 deletions(-)
 delete mode 100644 drivers/net/sandbox-lwip.c

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 1563404ca17..e683c18cad7 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -343,7 +343,7 @@ config ESSEDMA
 
 config ETH_SANDBOX
 	depends on SANDBOX
-	depends on NET
+	depends on NET || NET_LWIP
 	default y
 	bool "Sandbox: Mocked Ethernet driver"
 	help
@@ -352,17 +352,6 @@ config ETH_SANDBOX
 
 	  This driver is particularly useful in the test/dm/eth.c tests
 
-config ETH_SANDBOX_LWIP
-	depends on SANDBOX
-	depends on NET_LWIP
-	default y
-	bool "Sandbox: Mocked Ethernet driver (for NET_LWIP)"
-	help
-	  This driver is meant as a replacement for ETH_SANDBOX when
-	  the network stack is NET_LWIP rather than NET. It currently
-	  does nothing, i.e. it drops the sent packets and never receives
-	  data.
-
 config ETH_SANDBOX_RAW
 	depends on SANDBOX
 	depends on NET
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 80d70212971..519a623dc1c 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -39,7 +39,6 @@ obj-$(CONFIG_ETH_DESIGNWARE_SOCFPGA) += dwmac_socfpga.o
 obj-$(CONFIG_ETH_SANDBOX) += sandbox.o
 obj-$(CONFIG_ETH_SANDBOX_RAW) += sandbox-raw-bus.o
 obj-$(CONFIG_ETH_SANDBOX_RAW) += sandbox-raw.o
-obj-$(CONFIG_ETH_SANDBOX_LWIP) += sandbox-lwip.o
 obj-$(CONFIG_FEC_MXC) += fec_mxc.o
 obj-$(CONFIG_FMAN_ENET) += fm/
 obj-$(CONFIG_FMAN_ENET) += fsl_mdio.o
diff --git a/drivers/net/sandbox-lwip.c b/drivers/net/sandbox-lwip.c
deleted file mode 100644
index 3721033c310..00000000000
--- a/drivers/net/sandbox-lwip.c
+++ /dev/null
@@ -1,85 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2015 National Instruments
- *
- * (C) Copyright 2015
- * Joe Hershberger <joe.hershberger@ni.com>
- */
-
-#include <dm.h>
-#include <log.h>
-#include <malloc.h>
-#include <net.h>
-#include <asm/eth.h>
-#include <asm/global_data.h>
-#include <asm/test.h>
-
-DECLARE_GLOBAL_DATA_PTR;
-
-static int sb_lwip_eth_start(struct udevice *dev)
-{
-	debug("eth_sandbox_lwip: Start\n");
-
-	return 0;
-}
-
-static int sb_lwip_eth_send(struct udevice *dev, void *packet, int length)
-{
-	debug("eth_sandbox_lwip: Send packet %d\n", length);
-
-	return -ENOTSUPP;
-}
-
-static int sb_lwip_eth_recv(struct udevice *dev, int flags, uchar **packetp)
-{
-	return -EAGAIN;
-}
-
-static int sb_lwip_eth_free_pkt(struct udevice *dev, uchar *packet, int length)
-{
-	return 0;
-}
-
-static void sb_lwip_eth_stop(struct udevice *dev)
-{
-}
-
-static int sb_lwip_eth_write_hwaddr(struct udevice *dev)
-{
-	return 0;
-}
-
-static const struct eth_ops sb_eth_ops = {
-	.start			= sb_lwip_eth_start,
-	.send			= sb_lwip_eth_send,
-	.recv			= sb_lwip_eth_recv,
-	.free_pkt		= sb_lwip_eth_free_pkt,
-	.stop			= sb_lwip_eth_stop,
-	.write_hwaddr		= sb_lwip_eth_write_hwaddr,
-};
-
-static int sb_lwip_eth_remove(struct udevice *dev)
-{
-	return 0;
-}
-
-static int sb_lwip_eth_of_to_plat(struct udevice *dev)
-{
-	return 0;
-}
-
-static const struct udevice_id sb_eth_ids[] = {
-	{ .compatible = "sandbox,eth" },
-	{ }
-};
-
-U_BOOT_DRIVER(eth_sandbox) = {
-	.name	= "eth_lwip_sandbox",
-	.id	= UCLASS_ETH,
-	.of_match = sb_eth_ids,
-	.of_to_plat = sb_lwip_eth_of_to_plat,
-	.remove	= sb_lwip_eth_remove,
-	.ops	= &sb_eth_ops,
-	.priv_auto	= 0,
-	.plat_auto	= sizeof(struct eth_pdata),
-};
diff --git a/drivers/net/sandbox.c b/drivers/net/sandbox.c
index fe3627db6e3..2011fd31f41 100644
--- a/drivers/net/sandbox.c
+++ b/drivers/net/sandbox.c
@@ -9,13 +9,84 @@
 #include <dm.h>
 #include <log.h>
 #include <malloc.h>
-#include <net.h>
 #include <asm/eth.h>
 #include <asm/global_data.h>
 #include <asm/test.h>
+#include <asm/types.h>
+
+/*
+ * Structure definitions for network protocols. Since this file is used for
+ * both NET and NET_LWIP, and given that the two network stacks do have
+ * conflicting types (for instance struct icmp_hdr), it is on purpose that the
+ * structures are defined locally with minimal dependencies -- <asm/types.h> is
+ * included for the bit types and that's it.
+ */
+
+#define ETHADDR_LEN 6
+#define IP4_LEN 4
+
+struct ethhdr {
+        u8 dst[ETHADDR_LEN];
+        u8 src[ETHADDR_LEN];
+        u16 protlen;
+} __attribute__((packed));
+
+#define ETHHDR_SIZE (sizeof(struct ethhdr))
+
+struct arphdr {
+	u16 htype;
+	u16 ptype;
+	u8 hlen;
+	u8 plen;
+	u16 op;
+} __attribute__((packed));
+
+#define ARPHDR_SIZE (sizeof(struct arphdr))
+
+#define ARP_REQUEST	1
+#define ARP_REPLY	2
+
+struct arpdata {
+	u8 sha[ETHADDR_LEN];
+	u32 spa;
+	u8 tha[ETHADDR_LEN];
+	u32 tpa;
+} __attribute__((packed));
+
+#define ARPDATA_SIZE (sizeof(struct arpdata))
+
+struct iphdr {
+	u8 hl_v;
+	u8 tos;
+	u16 len;
+	u16 id;
+	u16 off;
+	u8 ttl;
+	u8 prot;
+	u16 sum;
+	u32 src;
+	u32 dst;
+} __attribute__((packed));
+
+#define IPHDR_SIZE (sizeof(struct iphdr))
+
+struct icmphdr {
+	u8 type;
+	u8 code;
+	u16 checksum;
+	u16 id;
+	u16 sequence;
+} __attribute__((packed));
+
+#define ICMPHDR_SIZE (sizeof(struct icmphdr))
+
+#define ICMP_ECHO_REQUEST	8
+#define ICMP_ECHO_REPLY		0
+#define IPPROTO_ICMP		1
 
 DECLARE_GLOBAL_DATA_PTR;
 
+static const u8 null_ethaddr[6];
 static bool skip_timeout;
 
 /*
@@ -59,17 +130,19 @@ int sandbox_eth_arp_req_to_reply(struct udevice *dev, void *packet,
 				 unsigned int len)
 {
 	struct eth_sandbox_priv *priv = dev_get_priv(dev);
-	struct ethernet_hdr *eth = packet;
-	struct arp_hdr *arp;
-	struct ethernet_hdr *eth_recv;
-	struct arp_hdr *arp_recv;
+	struct ethhdr *eth = packet;
+	struct arphdr *arp;
+	struct arpdata *arpd;
+	struct ethhdr *eth_recv;
+	struct arphdr *arp_recv;
+	struct arpdata *arp_recvd;
 
-	if (ntohs(eth->et_protlen) != PROT_ARP)
+	if (ntohs(eth->protlen) != PROT_ARP)
 		return -EAGAIN;
 
-	arp = packet + ETHER_HDR_SIZE;
+	arp = packet + ETHHDR_SIZE;
 
-	if (ntohs(arp->ar_op) != ARPOP_REQUEST)
+	if (ntohs(arp->op) != ARP_REQUEST)
 		return -EAGAIN;
 
 	/* Don't allow the buffer to overrun */
@@ -77,27 +150,29 @@ int sandbox_eth_arp_req_to_reply(struct udevice *dev, void *packet,
 		return 0;
 
 	/* store this as the assumed IP of the fake host */
-	priv->fake_host_ipaddr = net_read_ip(&arp->ar_tpa);
+	arpd = (struct arpdata *)(arp + 1);
+	priv->fake_host_ipaddr.s_addr = arpd->tpa;
 
 	/* Formulate a fake response */
 	eth_recv = (void *)priv->recv_packet_buffer[priv->recv_packets];
-	memcpy(eth_recv->et_dest, eth->et_src, ARP_HLEN);
-	memcpy(eth_recv->et_src, priv->fake_host_hwaddr, ARP_HLEN);
-	eth_recv->et_protlen = htons(PROT_ARP);
+	memcpy(eth_recv->dst, eth->src, ETHADDR_LEN);
+	memcpy(eth_recv->src, priv->fake_host_hwaddr, ETHADDR_LEN);
+	eth_recv->protlen = htons(PROT_ARP);
 
-	arp_recv = (void *)eth_recv + ETHER_HDR_SIZE;
-	arp_recv->ar_hrd = htons(ARP_ETHER);
-	arp_recv->ar_pro = htons(PROT_IP);
-	arp_recv->ar_hln = ARP_HLEN;
-	arp_recv->ar_pln = ARP_PLEN;
-	arp_recv->ar_op = htons(ARPOP_REPLY);
-	memcpy(&arp_recv->ar_sha, priv->fake_host_hwaddr, ARP_HLEN);
-	net_write_ip(&arp_recv->ar_spa, priv->fake_host_ipaddr);
-	memcpy(&arp_recv->ar_tha, &arp->ar_sha, ARP_HLEN);
-	net_copy_ip(&arp_recv->ar_tpa, &arp->ar_spa);
+	arp_recv = (void *)eth_recv + ETHHDR_SIZE;
+	arp_recv->htype = htons(ARP_ETHER);
+	arp_recv->ptype = htons(PROT_IP);
+	arp_recv->hlen = ETHADDR_LEN;
+	arp_recv->plen = IP4_LEN;
+	arp_recv->op = htons(ARP_REPLY);
+	arp_recvd = (struct arpdata *)(arp_recv + 1);
+	memcpy(&arp_recvd->sha, priv->fake_host_hwaddr, ETHADDR_LEN);
+	arp_recvd->spa = priv->fake_host_ipaddr.s_addr;
+	memcpy(&arp_recvd->tha, &arpd->sha, ETHADDR_LEN);
+	arp_recvd->tpa = arpd->spa;
 
-	priv->recv_packet_length[priv->recv_packets] =
-		ETHER_HDR_SIZE + ARP_HDR_SIZE;
+	priv->recv_packet_length[priv->recv_packets] = ETHHDR_SIZE +
+		ARPHDR_SIZE + ARPDATA_SIZE;
 	++priv->recv_packets;
 
 	return 0;
@@ -114,22 +189,22 @@ int sandbox_eth_ping_req_to_reply(struct udevice *dev, void *packet,
 				  unsigned int len)
 {
 	struct eth_sandbox_priv *priv = dev_get_priv(dev);
-	struct ethernet_hdr *eth = packet;
-	struct ip_udp_hdr *ip;
-	struct icmp_hdr *icmp;
-	struct ethernet_hdr *eth_recv;
-	struct ip_udp_hdr *ipr;
-	struct icmp_hdr *icmpr;
+	struct ethhdr *eth = packet;
+	struct iphdr *ip;
+	struct icmphdr *icmp;
+	struct ethhdr *eth_recv;
+	struct iphdr *ipr;
+	struct icmphdr *icmpr;
 
-	if (ntohs(eth->et_protlen) != PROT_IP)
+	if (ntohs(eth->protlen) != PROT_IP)
 		return -EAGAIN;
 
-	ip = packet + ETHER_HDR_SIZE;
+	ip = packet + ETHHDR_SIZE;
 
-	if (ip->ip_p != IPPROTO_ICMP)
+	if (ip->prot != IPPROTO_ICMP)
 		return -EAGAIN;
 
-	icmp = (struct icmp_hdr *)&ip->udp_src;
+	icmp = (struct icmphdr *)(ip + 1);
 
 	if (icmp->type != ICMP_ECHO_REQUEST)
 		return -EAGAIN;
@@ -141,19 +216,19 @@ int sandbox_eth_ping_req_to_reply(struct udevice *dev, void *packet,
 	/* reply to the ping */
 	eth_recv = (void *)priv->recv_packet_buffer[priv->recv_packets];
 	memcpy(eth_recv, packet, len);
-	ipr = (void *)eth_recv + ETHER_HDR_SIZE;
-	icmpr = (struct icmp_hdr *)&ipr->udp_src;
-	memcpy(eth_recv->et_dest, eth->et_src, ARP_HLEN);
-	memcpy(eth_recv->et_src, priv->fake_host_hwaddr, ARP_HLEN);
-	ipr->ip_sum = 0;
-	ipr->ip_off = 0;
-	net_copy_ip((void *)&ipr->ip_dst, &ip->ip_src);
-	net_write_ip((void *)&ipr->ip_src, priv->fake_host_ipaddr);
-	ipr->ip_sum = compute_ip_checksum(ipr, IP_HDR_SIZE);
+	ipr = (void *)eth_recv + ETHHDR_SIZE;
+	icmpr = (struct icmphdr *)(ipr + 1);
+	memcpy(eth_recv->dst, eth->src, ETHADDR_LEN);
+	memcpy(eth_recv->src, priv->fake_host_hwaddr, ETHADDR_LEN);
+	ipr->sum = 0;
+	ipr->off = 0;
+	ipr->dst = ip->src;
+	ipr->src = priv->fake_host_ipaddr.s_addr;
+	ipr->sum = compute_ip_checksum(ipr, IPHDR_SIZE);
 
 	icmpr->type = ICMP_ECHO_REPLY;
 	icmpr->checksum = 0;
-	icmpr->checksum = compute_ip_checksum(icmpr, ICMP_HDR_SIZE);
+	icmpr->checksum = compute_ip_checksum(icmpr, ICMPHDR_SIZE);
 
 	priv->recv_packet_length[priv->recv_packets] = len;
 	++priv->recv_packets;
@@ -171,8 +246,9 @@ int sandbox_eth_ping_req_to_reply(struct udevice *dev, void *packet,
 int sandbox_eth_recv_arp_req(struct udevice *dev)
 {
 	struct eth_sandbox_priv *priv = dev_get_priv(dev);
-	struct ethernet_hdr *eth_recv;
-	struct arp_hdr *arp_recv;
+	struct ethhdr *eth_recv;
+	struct arphdr *arp_recv;
+	struct arpdata *arp_recvd;
 
 	/* Don't allow the buffer to overrun */
 	if (priv->recv_packets >= PKTBUFSRX)
@@ -180,23 +256,24 @@ int sandbox_eth_recv_arp_req(struct udevice *dev)
 
 	/* Formulate a fake request */
 	eth_recv = (void *)priv->recv_packet_buffer[priv->recv_packets];
-	memcpy(eth_recv->et_dest, net_bcast_ethaddr, ARP_HLEN);
-	memcpy(eth_recv->et_src, priv->fake_host_hwaddr, ARP_HLEN);
-	eth_recv->et_protlen = htons(PROT_ARP);
+	memcpy(eth_recv->dst, net_bcast_ethaddr, ETHADDR_LEN);
+	memcpy(eth_recv->src, priv->fake_host_hwaddr, ETHADDR_LEN);
+	eth_recv->protlen = htons(PROT_ARP);
 
-	arp_recv = (void *)eth_recv + ETHER_HDR_SIZE;
-	arp_recv->ar_hrd = htons(ARP_ETHER);
-	arp_recv->ar_pro = htons(PROT_IP);
-	arp_recv->ar_hln = ARP_HLEN;
-	arp_recv->ar_pln = ARP_PLEN;
-	arp_recv->ar_op = htons(ARPOP_REQUEST);
-	memcpy(&arp_recv->ar_sha, priv->fake_host_hwaddr, ARP_HLEN);
-	net_write_ip(&arp_recv->ar_spa, priv->fake_host_ipaddr);
-	memcpy(&arp_recv->ar_tha, net_null_ethaddr, ARP_HLEN);
-	net_write_ip(&arp_recv->ar_tpa, net_ip);
+	arp_recv = (void *)eth_recv + ETHHDR_SIZE;
+	arp_recv->htype = htons(ARP_ETHER);
+	arp_recv->ptype = htons(PROT_IP);
+	arp_recv->hlen = ETHADDR_LEN;
+	arp_recv->plen = IP4_LEN;
+	arp_recv->op = htons(ARP_REQUEST);
+	arp_recvd = (struct arpdata *)(arp_recv + 1);
+	memcpy(&arp_recvd->sha, priv->fake_host_hwaddr, ETHADDR_LEN);
+	arp_recvd->spa = priv->fake_host_ipaddr.s_addr;
+	memcpy(&arp_recvd->tha, null_ethaddr, ETHADDR_LEN);
+	arp_recvd->tpa = net_ip.s_addr;
 
 	priv->recv_packet_length[priv->recv_packets] =
-		ETHER_HDR_SIZE + ARP_HDR_SIZE;
+		ETHHDR_SIZE + ARPHDR_SIZE + ARPDATA_SIZE;
 	++priv->recv_packets;
 
 	return 0;
@@ -212,9 +289,10 @@ int sandbox_eth_recv_arp_req(struct udevice *dev)
 int sandbox_eth_recv_ping_req(struct udevice *dev)
 {
 	struct eth_sandbox_priv *priv = dev_get_priv(dev);
-	struct ethernet_hdr *eth_recv;
-	struct ip_udp_hdr *ipr;
-	struct icmp_hdr *icmpr;
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct ethhdr *eth_recv;
+	struct iphdr *ipr;
+	struct icmphdr *icmpr;
 
 	/* Don't allow the buffer to overrun */
 	if (priv->recv_packets >= PKTBUFSRX)
@@ -223,31 +301,31 @@ int sandbox_eth_recv_ping_req(struct udevice *dev)
 	/* Formulate a fake ping */
 	eth_recv = (void *)priv->recv_packet_buffer[priv->recv_packets];
 
-	memcpy(eth_recv->et_dest, net_ethaddr, ARP_HLEN);
-	memcpy(eth_recv->et_src, priv->fake_host_hwaddr, ARP_HLEN);
-	eth_recv->et_protlen = htons(PROT_IP);
+	memcpy(eth_recv->dst, pdata->enetaddr, ETHADDR_LEN);
+	memcpy(eth_recv->src, priv->fake_host_hwaddr, ETHADDR_LEN);
+	eth_recv->protlen = htons(PROT_IP);
 
-	ipr = (void *)eth_recv + ETHER_HDR_SIZE;
-	ipr->ip_hl_v = 0x45;
-	ipr->ip_len = htons(IP_ICMP_HDR_SIZE);
-	ipr->ip_off = htons(IP_FLAGS_DFRAG);
-	ipr->ip_p = IPPROTO_ICMP;
-	ipr->ip_sum = 0;
-	net_write_ip(&ipr->ip_src, priv->fake_host_ipaddr);
-	net_write_ip(&ipr->ip_dst, net_ip);
-	ipr->ip_sum = compute_ip_checksum(ipr, IP_HDR_SIZE);
+	ipr = (void *)eth_recv + ETHHDR_SIZE;
+	ipr->hl_v = 0x45;
+	ipr->len = htons(IPHDR_SIZE + ICMPHDR_SIZE);
+	ipr->off = htons(IP_FLAGS_DFRAG);
+	ipr->prot = IPPROTO_ICMP;
+	ipr->sum = 0;
+	ipr->src = priv->fake_host_ipaddr.s_addr;
+	ipr->dst = net_ip.s_addr;
+	ipr->sum = compute_ip_checksum(ipr, IPHDR_SIZE);
 
-	icmpr = (struct icmp_hdr *)&ipr->udp_src;
+	icmpr = (struct icmphdr *)(ipr + 1);
 
 	icmpr->type = ICMP_ECHO_REQUEST;
 	icmpr->code = 0;
 	icmpr->checksum = 0;
-	icmpr->un.echo.id = 0;
-	icmpr->un.echo.sequence = htons(1);
-	icmpr->checksum = compute_ip_checksum(icmpr, ICMP_HDR_SIZE);
+	icmpr->id = 0;
+	icmpr->sequence = htons(1);
+	icmpr->checksum = compute_ip_checksum(icmpr, ICMPHDR_SIZE);
 
 	priv->recv_packet_length[priv->recv_packets] =
-		ETHER_HDR_SIZE + IP_ICMP_HDR_SIZE;
+		ETHHDR_SIZE + IPHDR_SIZE + ICMPHDR_SIZE;
 	++priv->recv_packets;
 
 	return 0;
@@ -398,7 +476,7 @@ static int sb_eth_write_hwaddr(struct udevice *dev)
 
 	debug("eth_sandbox %s: Write HW ADDR - %pM\n", dev->name,
 	      pdata->enetaddr);
-	memcpy(priv->fake_host_hwaddr, pdata->enetaddr, ARP_HLEN);
+	memcpy(priv->fake_host_hwaddr, pdata->enetaddr, ETHADDR_LEN);
 	return 0;
 }
 
-- 
2.43.0

