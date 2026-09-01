Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF93EC624D6
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 17:10:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B078380E82;
	Tue,  1 Sep 2026 17:10:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VVVEua3ym_8s; Tue,  1 Sep 2026 17:09:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788282598;
	bh=sGzskRBcBXKOP8B9dY7vQ/tcZRkL+zo46tCLK8FcI6A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l6R/mSBl1bwDp4mpz48ScbiQ2aNaC1x6Z1rpsDewulpQB4axZGbV30+WImc3og0fd
	 zROGsbhtst5JW/hE+RCU60cfVmmnTwFUQTV+rzq5QMJUpirSYn2FJlMrr8x3G7m7Q9
	 ONphDl5dxVWy+w4rvQRkdVj8zHB/iuR6b5O5pNU1RYI5hOLpVkgdxQ3ZYDBg7B6OIf
	 oKS3XotXDagqtGhYcWSMJFeq5xpHCU6emO6XLrDi5n1a8H4E3tiFK+AJKNxdOWLK6s
	 STePzzatbB0wpdJBHB75jvb0JT9ALWQv4Hwc3l7GV9plysPlCbdCKvot9Hrl4vRruc
	 FmYmBZPuPGRAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 83E4580E80;
	Tue,  1 Sep 2026 17:09:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C5536265
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 17:09:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B7726606F6
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 17:09:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OxtVqbLxr07N for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 17:09:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=dX1tWcbr
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4FC1360633
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 17:09:51 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7f4df360cc9so59078a34.1
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 10:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788282590; x=1788887390;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sGzskRBcBXKOP8B9dY7vQ/tcZRkL+zo46tCLK8FcI6A=;
 b=dX1tWcbrCdenG+byUlLMfHFrUhAO/l+Rpn9Cb7efp6WeWqHlIyfGFeKvExOzCFffd+
 P9PL7Z7FBrjDzZzgBrX9ctWMlcFZorAIcAq0OVlhpLgHKdh499+QiP2vGupa06sCPbvP
 +LS3egBKrQgWE4vxG9QZRrJOAQ6IR5NIAn4xdfDqDBS2KhmcaG0afTF73j1aeg7qbPyJ
 3ND8kb35GhobbpsDP1N//pWWclqiglZzZ8ZWbgU+cqLcRb7OxIXfmo2TIyWZE8gkZvgd
 sboWMzBgJI19t5yFN/lbWT+c8DFiQgozatXTL8euL/Z+ncbqi9ca8LxJkkKzLrGKTtBw
 4uVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788282590; x=1788887390;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sGzskRBcBXKOP8B9dY7vQ/tcZRkL+zo46tCLK8FcI6A=;
 b=TeICgKl1lL+W6c6vBI/HpCyuAZ15B9OfL89nA0B+MMROQwSDQuGuOq/3WAnBQNZV7R
 MCKE4VEMwWktzWiagCvcdKFzX8x8/fKKZ2COwl8vyJuqbZrUcF4L7kGerFSXoaNCBHZl
 sI7jX/wNz5TQ/bWTOtxlX4g84ubsPbU0aSEgZsPYfuYlHKuh1FPYMOQY0cndpComvOkk
 awDYgcGQvxphAkpCKw1b9kJMP0TnTyDXt8B/CIPpQ7QTgfJk25ToQXCUSB4lZdaVAQeH
 /p1E3Ig80Ie5bzZB4hMDE2z2t86747JD2oLrR3G6fkvRVdgmZM7emGr9QulDQMvr/zVQ
 m8gg==
X-Gm-Message-State: AFuF++l8K4e5yj2LtOYc63NDY3SKNjC7b13Ryp2BFJN2DQWfUttLkH1e
 uRs4WMIjjrqM9HaYO+I6hvUEq5uESWsrF4/pl9ra4yI45+S+nPr2xsKF
X-Gm-Gg: AR+sD13QIIlDciTzRA5fNYbV9kCfhOIH5DkiVU/mnRbGPdRHtLQx7I1LpkYi2WZ2Z20
 PLw8F9mdW3u9Hh4Gf7yB59BCMHjXXdtkoT6qykdR/zV+eCH9wD17eLyzAY3W8WslJ+EbnDadvzV
 TIinpFSLdRxDMAYv4t1Ca1WXunlNb3LskSa8/9mRPwBUIi1ythUUuIj9OTVDGfVzW4c+zKSEtdQ
 XhNuwo/KEuFQaDrOqrioFocROKYaV6seWGQHcXgQYutFCBgVToRY/HBzCvw5Pg7S9CxLSE/zZOX
 fVWhj+kwQILgzP2c2+bCLVoR++pE5RyUq/HcZAFCwwzSXF3OxglZSGkJ8unyCJW3aip2fXTBHGh
 M9j2+MZ1plWIAlO7MQivrwlp8oNglaMOD5fiyzIzDzG0PD3COx+dUsloO2cZ3GgP4BdhmO9u1h0
 oYyXlELKqOuLigcd7xtXZtfeu1yYD/HM6JJRej8FULjpVQ46dIQWZsTaUJukzB16akU3WjZQZ+x
 zz59OezeMuS/8C6z0TXTf9QlXfdzPUgQTRMlWobkU447gZAV7Ii9oA+JRYAXJwH9rPJj/hy4G9k
 Dp7NSOsFSyUXfDyBR8uPf4VgTQyoZfQhCh65z/OvUmwG95j3joCigv9edhd6PUW31AXnHeE8fEA
 IbRcwkrGB4QdLzk4hw/4wJWfn4tdyfg==
X-Received: by 2002:a05:6830:83a1:b0:7dc:e78b:158 with SMTP id
 46e09a7af769-7f68f60b62bmr6386186a34.4.1788282590435; 
 Tue, 01 Sep 2026 10:09:50 -0700 (PDT)
Received: from [127.0.1.1] (184-96-151-165.hlrn.qwest.net. [184.96.151.165])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4fa99d927sm10892218a34.19.2026.09.01.10.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 10:09:50 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 01 Sep 2026 11:09:04 -0600
Subject: [PATCH v2 10/10] net: netconsole: add an lwIP transport
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-submit-lwip-runtime-netconsole-v1-v2-10-3e3d95627cf9@gmail.com>
References: <20260901-submit-lwip-runtime-netconsole-v1-v2-0-3e3d95627cf9@gmail.com>
In-Reply-To: <20260901-submit-lwip-runtime-netconsole-v1-v2-0-3e3d95627cf9@gmail.com>
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>
Cc: James Hilliard <james.hilliard1@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, 
 Luca Jones <ljones@t0.technology>, Weijie Gao <weijie.gao@mediatek.com>, 
 Pranav Tilak <pranav.vinaytilak@amd.com>, Simon Glass <sjg@chromium.org>, 
 Vincent Jardin <vjardin@free.fr>, Quentin Schulz <quentin.schulz@cherry.de>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Register netconsole as a UDP client of the shared lwIP runtime. This
keeps its PCB active while foreground network commands run, so their
polling also services console input and output.

Refresh addressing and port settings when the environment changes,
and wait for ARP resolution when output is sent outside an active poll.
A nested send from a protocol callback leaves the packet queued for the
outer poll instead of recursing.

Add sandbox coverage for input, output, runtime sharing, nested
callback output and setting changes.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/Makefile          |   1 +
 drivers/net/netconsole-lwip.c | 200 ++++++++++++++++++++++++
 drivers/net/netconsole.c      |   3 +-
 net/Kconfig                   |  13 +-
 test/dm/Makefile              |   3 +
 test/dm/netconsole.c          | 344 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 557 insertions(+), 7 deletions(-)

diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 32bf86e14ae..96ec6fb187a 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -85,6 +85,7 @@ obj-$(CONFIG_MVPP2) += mvpp2.o
 ifdef CONFIG_NETCONSOLE
 obj-y += netconsole.o
 obj-$(CONFIG_NET_LEGACY) += netconsole-legacy.o
+obj-$(CONFIG_NET_LWIP) += netconsole-lwip.o
 endif
 obj-$(CONFIG_NET_NPCM750) += npcm750_eth.o
 obj-$(CONFIG_NET_OCTEON) += octeon/
diff --git a/drivers/net/netconsole-lwip.c b/drivers/net/netconsole-lwip.c
new file mode 100644
index 00000000000..af2d591610e
--- /dev/null
+++ b/drivers/net/netconsole-lwip.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright 2026 James Hilliard <james.hilliard1@gmail.com> */
+
+#include <env.h>
+#include <lwip/etharp.h>
+#include <lwip/ip4_addr.h>
+#include <lwip/pbuf.h>
+#include <lwip/udp.h>
+#include <net.h>
+#include <timer.h>
+#include <linux/errno.h>
+
+#include "netconsole.h"
+
+#define NC_ARP_TIMEOUT_MS	5000
+
+static struct net_lwip_ctx nc_net;
+static struct udp_pcb *nc_pcb;
+static unsigned int nc_users;
+static int nc_env_id = -1;
+
+static void nc_lwip_recv(void *arg, struct udp_pcb *pcb, struct pbuf *p,
+			 const ip_addr_t *addr, u16_t port)
+{
+	struct in_addr src_ip = {
+		.s_addr = ip_addr_get_ip4_u32(addr),
+	};
+	struct pbuf *q;
+
+	for (q = p; q; q = q->next)
+		nc_input_packet(q->payload, src_ip, pcb->local_port, port,
+				q->len);
+
+	pbuf_free(p);
+}
+
+static int nc_lwip_refresh(void)
+{
+	struct udp_pcb *pcb;
+	int env_id;
+	err_t err;
+	int ret;
+
+	env_id = env_get_id();
+	ret = nc_refresh_settings_from_env();
+	if (ret < 0)
+		return ret;
+
+	if (env_id != nc_env_id) {
+		ret = net_lwip_refresh(&nc_net);
+		if (ret)
+			return ret;
+		nc_env_id = env_id;
+	}
+
+	if (nc_pcb && nc_pcb->local_port == nc_settings.in_port)
+		return 0;
+
+	pcb = udp_new();
+	if (!pcb)
+		return -ENOMEM;
+
+	err = udp_bind(pcb, IP_ADDR_ANY, nc_settings.in_port);
+	if (err != ERR_OK) {
+		udp_remove(pcb);
+		return err;
+	}
+
+	ip_set_option(pcb, SOF_BROADCAST);
+	udp_recv(pcb, nc_lwip_recv, NULL);
+	if (nc_pcb)
+		udp_remove(nc_pcb);
+	nc_pcb = pcb;
+
+	return 0;
+}
+
+static bool nc_lwip_arp_target(const ip4_addr_t *dest, ip4_addr_t *target)
+{
+	struct netif *netif = nc_net.netif;
+
+	if (ip4_addr_isbroadcast(dest, netif) || ip4_addr_ismulticast(dest))
+		return false;
+
+	ip4_addr_copy(*target, *dest);
+	if (ip4_addr_net_eq(dest, netif_ip4_addr(netif),
+			    netif_ip4_netmask(netif)) ||
+	    ip4_addr_islinklocal(dest))
+		return true;
+
+	if (ip4_addr_isany_val(*netif_ip4_gw(netif)))
+		return false;
+	ip4_addr_copy(*target, *netif_ip4_gw(netif));
+
+	return true;
+}
+
+static void nc_lwip_wait_for_arp(const ip4_addr_t *target)
+{
+	const ip4_addr_t *ip_ret;
+	struct eth_addr *eth_ret;
+	ulong start;
+
+	if (etharp_find_addr(nc_net.netif, target, &eth_ret, &ip_ret) >= 0)
+		return;
+
+	start = get_timer(0);
+	while (get_timer(start) < NC_ARP_TIMEOUT_MS) {
+		if (net_lwip_poll() < 0)
+			return;
+		if (etharp_find_addr(nc_net.netif, target, &eth_ret,
+				     &ip_ret) >= 0)
+			return;
+	}
+}
+
+int nc_transport_start(void)
+{
+	int ret;
+
+	if (nc_users) {
+		ret = nc_lwip_refresh();
+		if (!ret)
+			nc_users++;
+
+		return ret;
+	}
+
+	ret = net_lwip_start(&nc_net, NET_LWIP_ADDR_ENV_FLEXIBLE);
+	if (ret)
+		return ret;
+
+	ret = nc_lwip_refresh();
+	if (ret) {
+		net_lwip_stop(&nc_net);
+		return ret;
+	}
+
+	nc_users = 1;
+
+	return 0;
+}
+
+int nc_transport_stop(void)
+{
+	if (!nc_users)
+		return 0;
+	if (--nc_users)
+		return 0;
+
+	if (nc_pcb) {
+		udp_remove(nc_pcb);
+		nc_pcb = NULL;
+	}
+
+	net_lwip_stop(&nc_net);
+	nc_env_id = -1;
+
+	return 0;
+}
+
+void nc_transport_send(const char *buf, int len)
+{
+	ip4_addr_t arp_target;
+	ip_addr_t dest;
+	struct pbuf *p;
+	err_t err;
+
+	if (!nc_users || nc_lwip_refresh())
+		return;
+
+	p = pbuf_alloc(PBUF_TRANSPORT, len, PBUF_RAM);
+	if (!p)
+		return;
+
+	err = pbuf_take(p, buf, len);
+	if (err != ERR_OK)
+		goto out;
+
+	ip_addr_set_ip4_u32(&dest, nc_settings.ip.s_addr);
+	err = udp_sendto_if(nc_pcb, p, &dest, nc_settings.out_port,
+			    nc_net.netif);
+	if (err == ERR_OK &&
+	    nc_lwip_arp_target(ip_2_ip4(&dest), &arp_target))
+		nc_lwip_wait_for_arp(&arp_target);
+
+out:
+	pbuf_free(p);
+}
+
+void nc_transport_poll(bool block)
+{
+	if (!nc_users || nc_lwip_refresh())
+		return;
+
+	do {
+		if (net_lwip_poll() < 0)
+			return;
+	} while (block && !nc_has_input());
+}
diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 63b92e12bf4..0a9ca1400a6 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -113,7 +113,8 @@ int nc_input_packet(uchar *pkt, struct in_addr src_ip, unsigned dest_port,
 	    !nc_is_broadcast(nc_settings.ip))
 		return 0; /* not from our client */
 
-	debug_cond(DEBUG_DEV_PKT, "input: \"%*.*s\"\n", len, len, pkt);
+	debug_cond(DEBUG_NET_PKT_TRACE, "input: \"%*.*s\"\n", len, len,
+		   pkt);
 
 	if (input_size == sizeof(input_buffer))
 		return 1; /* no space */
diff --git a/net/Kconfig b/net/Kconfig
index 386376ce884..02b6e0de21e 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -39,6 +39,13 @@ config NET_LWIP
 
 endchoice
 
+config NETCONSOLE
+	bool "NetConsole support"
+	select PROT_UDP_LWIP if NET_LWIP
+	help
+	  Support the 'nc' input/output device for networked console.
+	  See doc/usage/netconsole.rst for details.
+
 if NET_LEGACY
 
 config ARP_TIMEOUT
@@ -68,12 +75,6 @@ config BOOTP_SEND_HOSTNAME
 	  of the "hostname" environment variable is passed as
 	  option 12 to the DHCP server.
 
-config NETCONSOLE
-	bool "NetConsole support"
-	help
-	  Support the 'nc' input/output device for networked console.
-	  See doc/usage/netconsole.rst for details.
-
 config IP_DEFRAG
 	bool "Support IP datagram reassembly"
 	help
diff --git a/test/dm/Makefile b/test/dm/Makefile
index a3e8bb4bc7e..6e7b8173260 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -52,6 +52,9 @@ obj-$(CONFIG_DM_ETH) += eth.o
 ifeq ($(CONFIG_NET_LWIP)$(CONFIG_PROT_UDP_LWIP),yy)
 obj-y += lwip.o
 endif
+ifeq ($(CONFIG_NET_LWIP)$(CONFIG_NETCONSOLE),yy)
+obj-y += netconsole.o
+endif
 obj-$(CONFIG_EXTCON) += extcon.o
 ifneq ($(CONFIG_EFI_PARTITION),)
 obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fastboot.o
diff --git a/test/dm/netconsole.c b/test/dm/netconsole.c
new file mode 100644
index 00000000000..447965ac912
--- /dev/null
+++ b/test/dm/netconsole.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright 2026 James Hilliard <james.hilliard1@gmail.com> */
+
+#include <dm.h>
+#include <env.h>
+#include <lwip/pbuf.h>
+#include <lwip/udp.h>
+#include <net.h>
+#include <stdio_dev.h>
+#include <asm/eth.h>
+#include <dm/test.h>
+#include <linux/errno.h>
+#include <test/ut.h>
+
+#define NC_TEST_MAX_OUTPUTS	8
+#define NC_TEST_MAX_PAYLOAD	32
+#define NC_TEST_SERVICE_PORT	12000
+
+struct nc_test_eth_hdr {
+	u8 dst[ARP_HLEN];
+	u8 src[ARP_HLEN];
+	__be16 type;
+} __packed;
+
+struct nc_test_output {
+	struct in_addr src_ip;
+	struct in_addr dest_ip;
+	u16 src_port;
+	u16 dest_port;
+	char payload[NC_TEST_MAX_PAYLOAD];
+	unsigned int len;
+};
+
+struct nc_test_context {
+	struct nc_test_output output[NC_TEST_MAX_OUTPUTS];
+	unsigned int output_count;
+	int error;
+};
+
+struct nc_test_service_context {
+	struct stdio_dev *nc;
+	const char *message;
+	unsigned int packets;
+	int nested_poll_ret;
+};
+
+static int nc_test_tx_handler(struct udevice *dev, void *packet,
+			      unsigned int len)
+{
+	struct eth_sandbox_priv *priv = dev_get_priv(dev);
+	struct nc_test_context *context = priv->priv;
+	struct nc_test_eth_hdr *eth = packet;
+	struct nc_test_output *output;
+	struct ip_udp_hdr *ip;
+	unsigned int payload_len;
+
+	if (!sandbox_eth_arp_req_to_reply(dev, packet, len))
+		return 0;
+	if (!sandbox_eth_ping_req_to_reply(dev, packet, len))
+		return 0;
+
+	if (len < sizeof(*eth) || ntohs(eth->type) != PROT_IP)
+		return 0;
+	if (len < sizeof(*eth) + IP_UDP_HDR_SIZE) {
+		context->error = -EINVAL;
+		return 0;
+	}
+
+	ip = (void *)(eth + 1);
+	if (ip->ip_p != IPPROTO_UDP)
+		return 0;
+	if (ntohs(ip->udp_len) < UDP_HDR_SIZE ||
+	    ntohs(ip->udp_len) > len - sizeof(*eth) - IP_HDR_SIZE) {
+		context->error = -EINVAL;
+		return 0;
+	}
+
+	payload_len = ntohs(ip->udp_len) - UDP_HDR_SIZE;
+	if (context->output_count == NC_TEST_MAX_OUTPUTS ||
+	    payload_len > NC_TEST_MAX_PAYLOAD) {
+		context->error = -ENOSPC;
+		return 0;
+	}
+
+	output = &context->output[context->output_count++];
+	output->src_ip = ip->ip_src;
+	output->dest_ip = ip->ip_dst;
+	output->src_port = ntohs(ip->udp_src);
+	output->dest_port = ntohs(ip->udp_dst);
+	output->len = payload_len;
+	memcpy(output->payload, ip + 1, payload_len);
+
+	return 0;
+}
+
+static int nc_test_inject(struct udevice *dev, const char *payload,
+			  struct in_addr src_ip, struct in_addr dest_ip,
+			  u16 src_port, u16 dest_port)
+{
+	struct eth_sandbox_priv *priv = dev_get_priv(dev);
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct nc_test_eth_hdr *eth;
+	struct ip_udp_hdr *ip;
+	unsigned int payload_len = strlen(payload);
+	unsigned int packet_len;
+
+	packet_len = sizeof(*eth) + IP_UDP_HDR_SIZE + payload_len;
+	if (priv->recv_packets >= PKTBUFSRX || packet_len > PKTSIZE_ALIGN)
+		return -ENOSPC;
+
+	eth = (void *)priv->recv_packet_buffer[priv->recv_packets];
+	if (dest_ip.s_addr == (u32)~0)
+		memset(eth->dst, 0xff, ARP_HLEN);
+	else
+		memcpy(eth->dst, pdata->enetaddr, ARP_HLEN);
+	memcpy(eth->src, priv->fake_host_hwaddr, ARP_HLEN);
+	eth->type = htons(PROT_IP);
+
+	ip = (void *)(eth + 1);
+	memset(ip, 0, IP_UDP_HDR_SIZE);
+	ip->ip_hl_v = 0x45;
+	ip->ip_len = htons(IP_UDP_HDR_SIZE + payload_len);
+	ip->ip_off = htons(IP_FLAGS_DFRAG);
+	ip->ip_ttl = 64;
+	ip->ip_p = IPPROTO_UDP;
+	ip->ip_src = src_ip;
+	ip->ip_dst = dest_ip;
+	ip->udp_src = htons(src_port);
+	ip->udp_dst = htons(dest_port);
+	ip->udp_len = htons(UDP_HDR_SIZE + payload_len);
+	ip->ip_sum = compute_ip_checksum(ip, IP_HDR_SIZE);
+	memcpy(ip + 1, payload, payload_len);
+
+	priv->recv_packet_length[priv->recv_packets] = packet_len;
+	priv->recv_packets++;
+
+	return 0;
+}
+
+static void nc_test_service_recv(void *arg, struct udp_pcb *pcb,
+				 struct pbuf *p, const ip_addr_t *addr,
+				 u16_t port)
+{
+	struct nc_test_service_context *context = arg;
+
+	context->packets++;
+	context->nc->puts(context->nc, context->message);
+	context->nested_poll_ret = net_lwip_poll();
+	pbuf_free(p);
+}
+
+static int nc_test_check_output(struct unit_test_state *uts,
+				struct nc_test_context *context,
+				unsigned int index, const char *payload,
+				const char *dest_ip, u16 src_port,
+				u16 dest_port)
+{
+	struct nc_test_output *output;
+
+	ut_asserteq(0, context->error);
+	ut_assert(index < context->output_count);
+	output = &context->output[index];
+	ut_asserteq(strlen(payload), output->len);
+	ut_asserteq_mem(payload, output->payload, output->len);
+	ut_asserteq(string_to_ip("1.1.2.1").s_addr,
+		    output->src_ip.s_addr);
+	ut_asserteq(string_to_ip(dest_ip).s_addr, output->dest_ip.s_addr);
+	ut_asserteq(src_port, output->src_port);
+	ut_asserteq(dest_port, output->dest_port);
+
+	return 0;
+}
+
+static int nc_test_read_input(struct unit_test_state *uts,
+			      struct stdio_dev *nc, const char *expected)
+{
+	unsigned int i;
+
+	ut_assert(nc->tstc(nc));
+	for (i = 0; expected[i]; i++)
+		ut_asserteq(expected[i], nc->getc(nc));
+	ut_assert(!nc->tstc(nc));
+
+	return 0;
+}
+
+static int _dm_test_lwip_netconsole(struct unit_test_state *uts,
+				    struct stdio_dev *nc,
+				    struct udevice *dev,
+				    struct nc_test_context *context,
+				    struct net_lwip_ctx *service_net,
+				    struct udp_pcb **service_pcb)
+{
+	static const char output[] = "netconsole output";
+	static const char input[] = "netconsole input";
+	static const char broadcast_output[] = "broadcast output";
+	static const char broadcast_input[] = "broadcast input";
+	static const char after_ping[] = "after ping";
+	static const char from_service[] = "from service";
+	static const char after_service[] = "after service";
+	static const char changed_input[] = "changed input";
+	static const char default_output[] = "default output";
+	static const char default_input[] = "default input";
+	struct nc_test_service_context service = {
+		.nc = nc,
+		.message = from_service,
+	};
+	struct in_addr host = string_to_ip("1.1.2.2");
+	unsigned int outputs;
+
+	ut_assertok(env_set("ethact", "eth@10002000"));
+	ut_assertok(env_set("ipaddr", "1.1.2.1"));
+	ut_assertok(env_set("netmask", "255.255.255.0"));
+	ut_assertok(env_set("ncinport", "40000"));
+	ut_assertok(env_set("ncoutport", "40001"));
+
+	ut_assertok(nc->start(nc));
+	ut_assertok(nc->start(nc));
+	nc->stop(nc);
+	nc->puts(nc, broadcast_output);
+	ut_asserteq(1, context->output_count);
+	ut_assertok(nc_test_check_output(uts, context, 0, broadcast_output,
+					 "255.255.255.255", 40000, 40001));
+	ut_assertok(nc_test_inject(dev, broadcast_input, host,
+				   string_to_ip("255.255.255.255"), 40001,
+				   40000));
+	ut_assertok(nc_test_read_input(uts, nc, broadcast_input));
+	outputs = 1;
+
+	ut_assertok(env_set("ncip", "1.1.2.2"));
+	nc->puts(nc, output);
+	ut_asserteq(++outputs, context->output_count);
+	ut_assertok(nc_test_check_output(uts, context, outputs - 1, output,
+					 "1.1.2.2", 40000, 40001));
+
+	ut_assertok(nc_test_inject(dev, input, host,
+				   string_to_ip("1.1.2.1"), 40001, 40000));
+	ut_assertok(nc_test_read_input(uts, nc, input));
+
+	if (IS_ENABLED(CONFIG_CMD_PING)) {
+		static char *const ping_argv[] = { "ping", "1.1.2.2" };
+
+		/* A foreground command shares the netif with netconsole. */
+		ut_assertok(do_ping(NULL, 0, ARRAY_SIZE(ping_argv), ping_argv));
+		nc->puts(nc, after_ping);
+		ut_asserteq(++outputs, context->output_count);
+		ut_assertok(nc_test_check_output(uts, context, outputs - 1,
+						 after_ping,
+						 "1.1.2.2", 40000, 40001));
+	}
+
+	/* Model an independent server protocol attached to the same runtime. */
+	ut_assertok(net_lwip_start(service_net,
+				   NET_LWIP_ADDR_ENV_STRICT));
+	*service_pcb = udp_new();
+	ut_assertnonnull(*service_pcb);
+	ut_asserteq(ERR_OK, udp_bind(*service_pcb, IP_ADDR_ANY,
+				     NC_TEST_SERVICE_PORT));
+	udp_recv(*service_pcb, nc_test_service_recv, &service);
+
+	/*
+	 * Change to an uncached peer before entering the service callback. The
+	 * callback's netconsole output starts ARP resolution. The outer runtime
+	 * poll must receive the reply and flush the queued datagram without a
+	 * recursive poll.
+	 */
+	ut_assertok(env_set("ncip", "1.1.2.3"));
+	ut_assertok(env_set("ncinport", "50000"));
+	ut_assertok(env_set("ncoutport", "50001"));
+	ut_assertok(nc_test_inject(dev, "request", host,
+				   string_to_ip("1.1.2.1"), 13000,
+				   NC_TEST_SERVICE_PORT));
+	ut_assertok(net_lwip_poll());
+	ut_asserteq(1, service.packets);
+	ut_asserteq(-EBUSY, service.nested_poll_ret);
+	ut_asserteq(++outputs, context->output_count);
+	ut_assertok(nc_test_check_output(uts, context, outputs - 1,
+					 from_service,
+					 "1.1.2.3", 50000, 50001));
+
+	nc->puts(nc, after_service);
+	ut_asserteq(++outputs, context->output_count);
+	ut_assertok(nc_test_check_output(uts, context, outputs - 1,
+					 after_service,
+					 "1.1.2.3", 50000, 50001));
+
+	ut_assertok(nc_test_inject(dev, changed_input,
+				   string_to_ip("1.1.2.3"),
+				   string_to_ip("1.1.2.1"), 50001, 50000));
+	ut_assertok(nc_test_read_input(uts, nc, changed_input));
+
+	ut_assertok(env_set("ncip", NULL));
+	ut_assertok(env_set("ncinport", NULL));
+	ut_assertok(env_set("ncoutport", NULL));
+	nc->puts(nc, default_output);
+	ut_asserteq(++outputs, context->output_count);
+	ut_assertok(nc_test_check_output(uts, context, outputs - 1,
+					 default_output, "255.255.255.255",
+					 6666, 6666));
+	ut_assertok(nc_test_inject(dev, default_input, host,
+				   string_to_ip("255.255.255.255"), 6666,
+				   6666));
+	ut_assertok(nc_test_read_input(uts, nc, default_input));
+
+	return 0;
+}
+
+static int dm_test_lwip_netconsole(struct unit_test_state *uts)
+{
+	struct nc_test_context context = {};
+	struct net_lwip_ctx service_net = {};
+	struct udp_pcb *service_pcb = NULL;
+	struct stdio_dev *nc;
+	struct udevice *dev;
+	int ret;
+
+	nc = stdio_get_by_name("nc");
+	ut_assertnonnull(nc);
+	ut_assertnonnull(nc->stop);
+	ut_assertok(uclass_get_device_by_name(UCLASS_ETH, "eth@10002000",
+					      &dev));
+
+	sandbox_eth_set_tx_handler(0, nc_test_tx_handler);
+	sandbox_eth_set_priv(0, &context);
+	ret = _dm_test_lwip_netconsole(uts, nc, dev, &context, &service_net,
+				       &service_pcb);
+	if (service_pcb)
+		udp_remove(service_pcb);
+	net_lwip_stop(&service_net);
+	nc->stop(nc);
+	sandbox_eth_set_tx_handler(0, NULL);
+	sandbox_eth_set_priv(0, NULL);
+
+	env_set("ethact", NULL);
+	env_set("ipaddr", "192.0.2.1");
+	env_set("netmask", NULL);
+	env_set("ncip", NULL);
+	env_set("ncinport", NULL);
+	env_set("ncoutport", NULL);
+
+	return ret;
+}
+
+DM_TEST(dm_test_lwip_netconsole, UTF_SCAN_FDT);

-- 
2.53.0

