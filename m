Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6A4C624D5
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 17:09:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0F7C80E49;
	Tue,  1 Sep 2026 17:09:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id peWvbZp-Mic2; Tue,  1 Sep 2026 17:09:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788282589;
	bh=n6IQVvs+//tzixIbtAg9AR6B13IDlVn256/OLCMEA9A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YVNaw4+m5gSQE7ocoh9tD3J5z13zaGvQmC5IvrVstMRaVRCiPAXZ0s4B2VrCdzM9G
	 kZ7tRtRYDS8qjlwqhRrJaZshfWCcj7Ver2z+1HW0xOnCMXwFrI8bve1skjXCgotHs0
	 ngSgY4x8nbJDnidqWSsiTnun1304PlWq2yPQEaIJkFpTuWnaJAhQMK7pkAccZ4wR13
	 /RugNuMJ+8h8ufT0n/6VmfbXSbOgugdYrj3686V+RWUjpYJ49354hUPuGZQYh9P3Iu
	 EjHujsvQKD0KykZP6qmBOdQ/fvi98uNkooD8mUI1qeMwMqCtLmilbVjbX8+83abHBK
	 xqVTX1mpW04jg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16E6680DE0;
	Tue,  1 Sep 2026 17:09:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BB75C2FD
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 17:09:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AD9D040743
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 17:09:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pb9rwbDJCF1F for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 17:09:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Fo+Lx8lk
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 631A640731
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 17:09:43 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7f4df360cc9so58911a34.1
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 10:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788282583; x=1788887383;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n6IQVvs+//tzixIbtAg9AR6B13IDlVn256/OLCMEA9A=;
 b=Fo+Lx8lk32rAIrxpDEiVxw0SawVyW2jr37dtHCCJ3Hg14vtxg5q6he4bXawW5sGXi3
 VCOzk6BIbEg1EyRxg6HxqwVK/aW+lbtdCYiuStKZny/p10zym3PyUnQnQ1as3zDQS/t8
 Lv8eqVbKd3HieAMx7SKL18RlaKZIEwh+b6h5vsFnnrX+lZWPTbl1RvdQ3WqlTynlC04h
 916UJTVbdYhRL/D8PKVBVVswGLpkEuNsP54LHY6gLQsLuiOMH8+pNGRzx2Wqt8CGK/+W
 271c4AyDVtDShdPWzmg0FQaxQ7v3wZN8/rZ8ZoLhDppKKqtjzb0Yn5f/6ACegOMB33Bm
 dDFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788282583; x=1788887383;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n6IQVvs+//tzixIbtAg9AR6B13IDlVn256/OLCMEA9A=;
 b=SPINKVatwOSfxpfBYgU95XE1lRJdmaB+nnlyTTjxkyMcvtjv4UE+FKp2XKmFPjywtW
 +vAhIIHIIRooGZNxHVrHo+VEuQa/1x4ccgEk+/j0kiQd18/Fslu3m+ez6ZpcCgsSeSE9
 Yysk88vq7ZecyJ0lLEl9L9UA2kplflp1AEDijS+KAInPOD8LqAH2U5cFD9eQJXOOz3jk
 4lXEkf1VIQEVLWRgFYXL8V8jX0FfXl/yABqVIdpbuDcxpOq7F2MWP8Z5wO1LSnfsPqNm
 GVpxs50YN0Iw7ujueb7CHeOePAAxJQ9XfJ/QX/Ii/U7LCwN52Wjay8W1IyCd947JQtgJ
 jI/w==
X-Gm-Message-State: AFuF++nWdQkENf60SnCWm75zuafsmq9SO2a83u1KufnR2ljUkLOIMUBn
 RiIvYGulaRdP6sBE4rvN1A+ZgJcA6bxmtpHOZdj0AFNc2RgJWHmvXZkb
X-Gm-Gg: AR+sD112bMqfJeEX4WG4nce1DVwwMuZCC6Y+7vxJh/lMGqB0QFdJw5dR4ROL1kcZAiL
 iq33IXDZDJ3X8JCkOATdUelETd0b4vA+4HRzjxuIXPX7cLOMxb+jil61i28swk6/ZW1YRcigpQ/
 rEoPtvxjlfmZ6MIFtX2pfAdBgITac8Y0kghs1/asCW2VEoF0qC5Qhje3x8tR3dZV3omA8B3zR+F
 MB19KCjra8P6pl87M8DCN+E+K9GUjr7stpvimQBnsOh/dGGqVX2+8IhzkG3X3ulQ6bsJrlabyLp
 cDTRNw5v1JZCx8CIAzXSQSlvsROwCfwQHcc25rECMsJXjb+Ao4/H+OYYxpZlMOH3Lx3zu9+4q9x
 5QEBTKWuWDK5Ijxf6YkAz+liZm6ljhfvA00vROxBRmX7jGhdUw/OPDKPh2SVHai/ZeSfrBEEiRi
 6/H6grZQ7wV5Z1QkB0k9pvRggsm9I/LHM1IhalVFN7jhxt9UMuAdzmbV4JNpste1YObIWeVFUnh
 rZ7mnndBLjzMn4FTeh8bDsgNve6qleYtfsgoA1TP3WQep2a6VY1ODFN+MAWz1XB1WQj6sd3wbTZ
 c0s2qidA3jEjb9DGac4/5riPu5GXAfGIR740/qA7TLxAFpHIOvdm76aDUMCg8PJDBvBkvDu26en
 62iCky0Oe3osioTi3XyA=
X-Received: by 2002:a05:6830:82ec:b0:7e9:e5df:5ee2 with SMTP id
 46e09a7af769-7f68f6d3fa9mr5892781a34.6.1788282581213; 
 Tue, 01 Sep 2026 10:09:41 -0700 (PDT)
Received: from [127.0.1.1] (184-96-151-165.hlrn.qwest.net. [184.96.151.165])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4fa99d927sm10892218a34.19.2026.09.01.10.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 10:09:40 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 01 Sep 2026 11:08:56 -0600
Subject: [PATCH v2 02/10] net: split netconsole transport from stdio frontend
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-submit-lwip-runtime-netconsole-v1-v2-2-3e3d95627cf9@gmail.com>
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

Netconsole's environment handling, input buffer and stdio registration
do not depend on a particular network stack. Packet transmission and
polling do.

Move the existing net_loop and raw-packet code into a legacy transport
file. This leaves legacy behavior unchanged and provides a transport
interface for other network stacks.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/Makefile            |   5 +-
 drivers/net/netconsole-legacy.c | 156 ++++++++++++++++++++++++++++++++++
 drivers/net/netconsole.c        | 184 ++++++++--------------------------------
 drivers/net/netconsole.h        |  29 +++++++
 4 files changed, 226 insertions(+), 148 deletions(-)

diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 4c1f4094ab2..32bf86e14ae 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -82,7 +82,10 @@ obj-$(CONFIG_MVGBE) += mvgbe.o
 obj-$(CONFIG_MVMDIO) += mvmdio.o
 obj-$(CONFIG_MVNETA) += mvneta.o
 obj-$(CONFIG_MVPP2) += mvpp2.o
-obj-$(CONFIG_NETCONSOLE) += netconsole.o
+ifdef CONFIG_NETCONSOLE
+obj-y += netconsole.o
+obj-$(CONFIG_NET_LEGACY) += netconsole-legacy.o
+endif
 obj-$(CONFIG_NET_NPCM750) += npcm750_eth.o
 obj-$(CONFIG_NET_OCTEON) += octeon/
 obj-$(CONFIG_NET_OCTEONTX) += octeontx/
diff --git a/drivers/net/netconsole-legacy.c b/drivers/net/netconsole-legacy.c
new file mode 100644
index 00000000000..c3c69a94a21
--- /dev/null
+++ b/drivers/net/netconsole-legacy.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2004
+ * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
+ */
+
+#include <log.h>
+#include <net.h>
+
+#include "netconsole.h"
+
+static int net_timeout;
+static uchar nc_ether[ARP_HLEN];
+static const char *output_packet;
+static int output_packet_len;
+
+/*
+ * Start with a default last protocol.
+ * We are only interested in NETCONS or not.
+ */
+enum proto_t net_loop_last_protocol = BOOTP;
+
+static void nc_wait_arp_handler(uchar *pkt, unsigned int dest,
+				struct in_addr sip, unsigned int src,
+				unsigned int len)
+{
+	net_set_state(NETLOOP_SUCCESS);
+}
+
+static void nc_handler(uchar *pkt, unsigned int dest, struct in_addr sip,
+		       unsigned int src, unsigned int len)
+{
+	if (nc_has_input())
+		net_set_state(NETLOOP_SUCCESS);
+}
+
+static void nc_timeout_handler(void)
+{
+	net_set_state(NETLOOP_SUCCESS);
+}
+
+static int nc_legacy_refresh_settings(void)
+{
+	int ret;
+
+	ret = nc_refresh_settings_from_env();
+	if (ret <= 0)
+		return ret;
+
+	if (nc_is_broadcast(nc_settings.ip))
+		memset(nc_ether, 0xff, sizeof(nc_ether));
+	else
+		memset(nc_ether, 0, sizeof(nc_ether));
+
+	return 0;
+}
+
+/**
+ * nc_start() - Configure the legacy network loop for netconsole
+ *
+ * Called from net_loop() before processing each packet.
+ */
+void nc_start(void)
+{
+	nc_legacy_refresh_settings();
+	if (!output_packet_len || memcmp(nc_ether, net_null_ethaddr, ARP_HLEN)) {
+		net_set_udp_handler(nc_handler);
+		net_set_timeout_handler(net_timeout, nc_timeout_handler);
+	} else {
+		uchar *pkt;
+
+		net_set_arp_handler(nc_wait_arp_handler);
+		pkt = (uchar *)net_tx_packet + net_eth_hdr_size() +
+			IP_UDP_HDR_SIZE;
+		memcpy(pkt, output_packet, output_packet_len);
+		net_send_udp_packet(nc_ether, nc_settings.ip,
+				    nc_settings.out_port, nc_settings.in_port,
+				    output_packet_len);
+	}
+}
+
+void nc_transport_send(const char *buf, int len)
+{
+	struct udevice *eth;
+	int inited = 0;
+	uchar *pkt;
+
+	debug_cond(DEBUG_DEV_PKT, "output: \"%*.*s\"\n", len, len, buf);
+
+	eth = eth_get_dev();
+	if (!eth)
+		return;
+
+	if (!memcmp(nc_ether, net_null_ethaddr, ARP_HLEN)) {
+		if (eth_is_active(eth))
+			return;
+		output_packet = buf;
+		output_packet_len = len;
+		nc_set_input_recursion(true);
+		net_loop(NETCONS);
+		nc_set_input_recursion(false);
+		output_packet_len = 0;
+		return;
+	}
+
+	if (!eth_is_active(eth)) {
+		if (eth_is_on_demand_init()) {
+			if (eth_init() < 0)
+				return;
+			eth_set_last_protocol(NETCONS);
+		} else {
+			eth_init_state_only();
+		}
+
+		inited = 1;
+	}
+
+	pkt = (uchar *)net_tx_packet + net_eth_hdr_size() + IP_UDP_HDR_SIZE;
+	memcpy(pkt, buf, len);
+	net_send_udp_packet(nc_ether, nc_settings.ip, nc_settings.out_port,
+			    nc_settings.in_port, len);
+
+	if (inited) {
+		if (eth_is_on_demand_init())
+			eth_halt();
+		else
+			eth_halt_state_only();
+	}
+}
+
+void nc_transport_poll(bool block)
+{
+	struct udevice *eth = eth_get_dev();
+
+	if (eth_is_active(eth))
+		return;
+
+	net_timeout = block ? 0 : 1;
+	net_loop(NETCONS);
+}
+
+int nc_transport_start(void)
+{
+	int ret;
+
+	ret = nc_legacy_refresh_settings();
+	if (ret)
+		return ret;
+
+	return net_init();
+}
+
+int nc_transport_stop(void)
+{
+	return 0;
+}
diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index c2ce4a80d12..305a6cf12c6 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -4,13 +4,14 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <command.h>
 #include <env.h>
 #include <log.h>
 #include <stdio_dev.h>
 #include <net.h>
 #include <vsprintf.h>
 
+#include "netconsole.h"
+
 #ifndef CFG_NETCONSOLE_BUFFER_SIZE
 #define CFG_NETCONSOLE_BUFFER_SIZE 512
 #endif
@@ -20,39 +21,9 @@ static int input_size; /* char count in input buffer */
 static int input_offset; /* offset to valid chars in input buffer */
 static int input_recursion;
 static int output_recursion;
-static int net_timeout;
-static uchar nc_ether[6]; /* server enet address */
-static struct in_addr nc_ip; /* server ip */
-static short nc_out_port; /* target output port */
-static short nc_in_port; /* source input port */
-static const char *output_packet; /* used by first send udp */
-static int output_packet_len;
-/*
- * Start with a default last protocol.
- * We are only interested in NETCONS or not.
- */
-enum proto_t net_loop_last_protocol = BOOTP;
-
-static void nc_wait_arp_handler(uchar *pkt, unsigned dest,
-				 struct in_addr sip, unsigned src,
-				 unsigned len)
-{
-	net_set_state(NETLOOP_SUCCESS); /* got arp reply - quit net loop */
-}
+struct nc_settings nc_settings;
 
-static void nc_handler(uchar *pkt, unsigned dest, struct in_addr sip,
-		       unsigned src, unsigned len)
-{
-	if (input_size)
-		net_set_state(NETLOOP_SUCCESS); /* got input - quit net loop */
-}
-
-static void nc_timeout_handler(void)
-{
-	net_set_state(NETLOOP_SUCCESS);
-}
-
-static int is_broadcast(struct in_addr ip)
+bool nc_is_broadcast(struct in_addr ip)
 {
 	static struct in_addr netmask;
 	static struct in_addr our_ip;
@@ -73,7 +44,7 @@ static int is_broadcast(struct in_addr ip)
 		 (netmask.s_addr | ip.s_addr) == ~0)); /* bcast to our net */
 }
 
-static int refresh_settings_from_env(void)
+int nc_refresh_settings_from_env(void)
 {
 	const char *p;
 	static int env_changed_id;
@@ -82,56 +53,41 @@ static int refresh_settings_from_env(void)
 	/* update only when the environment has changed */
 	if (env_changed_id != env_id) {
 		char *tmp = env_get("ncip");
+
 		if (tmp) {
-			nc_ip = string_to_ip(tmp);
-			if (!nc_ip.s_addr)
+			nc_settings.ip = string_to_ip(tmp);
+			if (!nc_settings.ip.s_addr)
 				return -1;	/* ncip is 0.0.0.0 */
 			p = strchr(tmp, ':');
 			if (p != NULL) {
-				nc_out_port = dectoul(p + 1, NULL);
-				nc_in_port = nc_out_port;
+				nc_settings.out_port = dectoul(p + 1, NULL);
+				nc_settings.in_port = nc_settings.out_port;
 			}
 		} else {
-			nc_ip.s_addr = ~0; /* ncip is not set, so broadcast */
+			nc_settings.ip.s_addr = ~0;
 		}
 
 		p = env_get("ncoutport");
 		if (p != NULL)
-			nc_out_port = dectoul(p, NULL);
+			nc_settings.out_port = dectoul(p, NULL);
 		p = env_get("ncinport");
 		if (p != NULL)
-			nc_in_port = dectoul(p, NULL);
-
-		if (is_broadcast(nc_ip))
-			/* broadcast MAC address */
-			memset(nc_ether, 0xff, sizeof(nc_ether));
-		else
-			/* force arp request */
-			memset(nc_ether, 0, sizeof(nc_ether));
+			nc_settings.in_port = dectoul(p, NULL);
+
+		return 1;
 	}
+
 	return 0;
 }
 
-/**
- * Called from net_loop in net/net.c before each packet
- */
-void nc_start(void)
+bool nc_has_input(void)
 {
-	refresh_settings_from_env();
-	if (!output_packet_len || memcmp(nc_ether, net_null_ethaddr, 6)) {
-		/* going to check for input packet */
-		net_set_udp_handler(nc_handler);
-		net_set_timeout_handler(net_timeout, nc_timeout_handler);
-	} else {
-		/* send arp request */
-		uchar *pkt;
-		net_set_arp_handler(nc_wait_arp_handler);
-		pkt = (uchar *)net_tx_packet + net_eth_hdr_size() +
-			IP_UDP_HDR_SIZE;
-		memcpy(pkt, output_packet, output_packet_len);
-		net_send_udp_packet(nc_ether, nc_ip, nc_out_port, nc_in_port,
-				    output_packet_len);
-	}
+	return input_size != 0;
+}
+
+void nc_set_input_recursion(bool enable)
+{
+	input_recursion = enable;
 }
 
 int nc_input_packet(uchar *pkt, struct in_addr src_ip, unsigned dest_port,
@@ -139,10 +95,11 @@ int nc_input_packet(uchar *pkt, struct in_addr src_ip, unsigned dest_port,
 {
 	int end, chunk;
 
-	if (dest_port != nc_in_port || !len)
+	if (dest_port != nc_settings.in_port || !len)
 		return 0; /* not for us */
 
-	if (src_ip.s_addr != nc_ip.s_addr && !is_broadcast(nc_ip))
+	if (src_ip.s_addr != nc_settings.ip.s_addr &&
+	    !nc_is_broadcast(nc_settings.ip))
 		return 0; /* not from our client */
 
 	debug_cond(DEBUG_DEV_PKT, "input: \"%*.*s\"\n", len, len, pkt);
@@ -171,75 +128,17 @@ int nc_input_packet(uchar *pkt, struct in_addr src_ip, unsigned dest_port,
 	return 1;
 }
 
-static void nc_send_packet(const char *buf, int len)
+static int nc_stdio_start(struct stdio_dev *dev)
 {
-	struct udevice *eth;
-	int inited = 0;
-	uchar *pkt;
-	uchar *ether;
-	struct in_addr ip;
-
-	debug_cond(DEBUG_DEV_PKT, "output: \"%*.*s\"\n", len, len, buf);
-
-	eth = eth_get_dev();
-	if (eth == NULL)
-		return;
+	nc_settings.out_port = 6666;
+	nc_settings.in_port = nc_settings.out_port;
 
-	if (!memcmp(nc_ether, net_null_ethaddr, 6)) {
-		if (eth_is_active(eth))
-			return;	/* inside net loop */
-		output_packet = buf;
-		output_packet_len = len;
-		input_recursion = 1;
-		net_loop(NETCONS); /* wait for arp reply and send packet */
-		input_recursion = 0;
-		output_packet_len = 0;
-		return;
-	}
-
-	if (!eth_is_active(eth)) {
-		if (eth_is_on_demand_init()) {
-			if (eth_init() < 0)
-				return;
-			eth_set_last_protocol(NETCONS);
-		} else {
-			eth_init_state_only();
-		}
-
-		inited = 1;
-	}
-	pkt = (uchar *)net_tx_packet + net_eth_hdr_size() + IP_UDP_HDR_SIZE;
-	memcpy(pkt, buf, len);
-	ether = nc_ether;
-	ip = nc_ip;
-	net_send_udp_packet(ether, ip, nc_out_port, nc_in_port, len);
-
-	if (inited) {
-		if (eth_is_on_demand_init())
-			eth_halt();
-		else
-			eth_halt_state_only();
-	}
+	return nc_transport_start();
 }
 
-static int nc_stdio_start(struct stdio_dev *dev)
+static int nc_stdio_stop(struct stdio_dev *dev)
 {
-	int retval;
-
-	nc_out_port = 6666; /* default port */
-	nc_in_port = nc_out_port;
-
-	retval = refresh_settings_from_env();
-	if (retval != 0)
-		return retval;
-
-	/*
-	 * Initialize the static IP settings and buffer pointers
-	 * incase we call net_send_udp_packet before net_loop
-	 */
-	net_init();
-
-	return 0;
+	return nc_transport_stop();
 }
 
 static void nc_stdio_putc(struct stdio_dev *dev, char c)
@@ -248,7 +147,7 @@ static void nc_stdio_putc(struct stdio_dev *dev, char c)
 		return;
 	output_recursion = 1;
 
-	nc_send_packet(&c, 1);
+	nc_transport_send(&c, 1);
 
 	output_recursion = 0;
 }
@@ -264,7 +163,7 @@ static void nc_stdio_puts(struct stdio_dev *dev, const char *s)
 	len = strlen(s);
 	while (len) {
 		int send_len = min(len, (int)sizeof(input_buffer));
-		nc_send_packet(s, send_len);
+		nc_transport_send(s, send_len);
 		len -= send_len;
 		s += send_len;
 	}
@@ -278,9 +177,8 @@ static int nc_stdio_getc(struct stdio_dev *dev)
 
 	input_recursion = 1;
 
-	net_timeout = 0;	/* no timeout */
 	while (!input_size)
-		net_loop(NETCONS);
+		nc_transport_poll(true);
 
 	input_recursion = 0;
 
@@ -295,23 +193,14 @@ static int nc_stdio_getc(struct stdio_dev *dev)
 
 static int nc_stdio_tstc(struct stdio_dev *dev)
 {
-	struct udevice *eth;
-
 	if (input_recursion)
 		return 0;
 
 	if (input_size)
 		return 1;
 
-	eth = eth_get_dev();
-	if (eth_is_active(eth))
-		return 0;	/* inside net loop */
-
 	input_recursion = 1;
-
-	net_timeout = 1;
-	net_loop(NETCONS);	/* kind of poll */
-
+	nc_transport_poll(false);
 	input_recursion = 0;
 
 	return input_size != 0;
@@ -327,6 +216,7 @@ int drv_nc_init(void)
 	strcpy(dev.name, "nc");
 	dev.flags = DEV_FLAGS_OUTPUT | DEV_FLAGS_INPUT;
 	dev.start = nc_stdio_start;
+	dev.stop = nc_stdio_stop;
 	dev.putc = nc_stdio_putc;
 	dev.puts = nc_stdio_puts;
 	dev.getc = nc_stdio_getc;
diff --git a/drivers/net/netconsole.h b/drivers/net/netconsole.h
new file mode 100644
index 00000000000..b2c3ecee6dd
--- /dev/null
+++ b/drivers/net/netconsole.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __NETCONSOLE_INTERNAL_H
+#define __NETCONSOLE_INTERNAL_H
+
+#include <linux/types.h>
+#include <net-common.h>
+
+struct nc_settings {
+	struct in_addr ip;
+	short out_port;
+	short in_port;
+};
+
+extern struct nc_settings nc_settings;
+
+bool nc_has_input(void);
+bool nc_is_broadcast(struct in_addr ip);
+int nc_refresh_settings_from_env(void);
+int nc_input_packet(uchar *pkt, struct in_addr src_ip, unsigned int dest_port,
+		    unsigned int src_port, unsigned int len);
+void nc_set_input_recursion(bool enable);
+
+int nc_transport_start(void);
+int nc_transport_stop(void);
+void nc_transport_send(const char *buf, int len);
+void nc_transport_poll(bool block);
+
+#endif /* __NETCONSOLE_INTERNAL_H */

-- 
2.53.0

