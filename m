Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3FACC61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 20:14:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B86276070D;
	Tue, 25 Aug 2026 20:14:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aPnROqfoVFWL; Tue, 25 Aug 2026 20:14:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787688850;
	bh=LIdid3uXewyEdnpw97D7Etxumhtle/W9Zxon1g2cRqo=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GkDomvvdTORcYkNpRBpvZZ+HGLBxno66jzVbY+w4HoZHVNZYmV/Ym3Xf0lwuifTOm
	 1oOuBIDSOGN+/z8h7OjVo1SBEvEKE4sz3NgKqnRtJyrGM2kxjI4cyHIZbfe1+gLJqV
	 RAHC7g0YXEwl/yt5qZ2kGAeAnlQpf1c3ha8+aPh7Ky1O5HrwhehdaZ7duo6wSMcEJt
	 HSbmNufgVWd82ARJn5FCZMdBlT6vGpYZ4cdpn513QfPMDVlAmLWDh+MTUbwZ16NIxR
	 k/4foeQatGh64jk844+/UjvEaTiiKvMtfXnPnjWQLu/ogzitb/5kVGkI8JH3K+DU0n
	 vPBtDgXyCmXPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 852ED60728;
	Tue, 25 Aug 2026 20:14:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DAF2D334
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 20:14:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CCD2A4064C
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 20:14:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5pzRH6ByiMxX for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 20:14:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22a; helo=mail-oi1-x22a.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=CYR1AKcj
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C0D0D4064E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 20:14:07 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4b28d7c729fso229400b6e.0
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 13:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787688846; x=1788293646;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LIdid3uXewyEdnpw97D7Etxumhtle/W9Zxon1g2cRqo=;
 b=CYR1AKcjhhWisijri55azuLS0DAD9sE97lrhIlnola6Drld+hNlIpRezEkvFo58nKR
 bSymCi6SIvfIH45DPXzhtib9s1gwmK8X835iQBhwSHLivI0Mrp+qqPlWJlPOhs/tI+KF
 Vp3afbIiijz4oItp1SoW9RX0nBir2AARPnIS1IhbWdcdxUaH6aA7EieitvtEgNlvnZmT
 w1AaD8rZe8jBPxQJfHkrHI+7XpUYUuLjAynk2gyUkU2Aw/s3KEh33/xu+97EBtdL0QqC
 HRV/TtGSI+HZXeQc4iB3375Oq9z4TRU1euO1JapT9BeEJ++gVSxQ7gIh7SgQXHox/uO6
 qxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787688846; x=1788293646;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LIdid3uXewyEdnpw97D7Etxumhtle/W9Zxon1g2cRqo=;
 b=Oc3OSdWa84GACPes20Bqziz8/5khPAjSIRQb1HOJbmTOv6KTki71UXEXU8vSAQnySF
 YCjtBNXqJDITKCpjQXJEm8Qct3aNZnomC3enqdxGsHVvrjnYrjKJbd6nJ2vn8aR+rM30
 MJHQBMD1W93G5DSvxdBQLlAenTNvjCLGtXGrV1NayGJNPqEQdKRA8499bHIuFIE4k+Yj
 kCwVzo/5G6l8KSPHVeCrpvokfOgbmRamy64ma/gHA6A3YCqL/zLe1HOgS1XM4p9/zZem
 qgNRCFGCqedXc05qPSvxm/VOBsz6T9GNqsxeuWbJAJ9beh9ercWIxGVWX4GF9gkXvrBb
 TOvA==
X-Gm-Message-State: AFuF++kqPhZmQsV15LQEE3yMcqeo0arKvwZcPMhe287Dp7i6pSBhxxJ+
 o6D14k1M9qboedRHWdr913YSbi4TShcJ1hhdMI/KysJOX7Nhb2OjQwFT
X-Gm-Gg: AR+sD10xfywu+IBsYQ6Sy13xQdRyKklfNo1SZmKyHy65NpJBIwyvJrwhigRGVZHQ0TZ
 cqUSa16bxO+PG78E/aV11tk9lrXAvqr6TCtIEXv1tls8LefVxpjfWDqnWZg+F0nTAEkbeUbhroo
 lI4OedsFL54Ff5WtmmAyZd357Re/jGaCDNNDLC9hQo5W0JUUbQzocwEKq0xQ6+tOS4Mux1jRsjM
 ZFzJmwxhmqNBhMGyT5CAp6xs0E7L+5dUeUQfP6RTOuLWQ8gMVKSOUN4s0KgXIjhfXtaAM7FThht
 9xXGfpgUELlzPs9E6oDvVnYmS2A9Ay5GU6VRx4LHDyuTZahs+jHAQpCVFLFgKD7PvOtdhGTp7/z
 BDfQKW9Rsbx3d8rmmpdW41IxjlVpiPHUrWUVWnJwAgWcKhXrz4S5znnn94MNW1RD023bzvbsFmo
 Gw4Mqcwl1V/Et8wv/cok5i9aUEIaa+xnolCIxSfnzSr0xxNmbgTUi9PepR7TPO/Mq8q6mmjWLgm
 vIynRde0Y37qzQ+Uwg2kCQFnBMcncHoueiblTnR/t7NEPYMcNNgfmpx2vPfZxXhm1y30SSKaT5a
 s/+vBa6sZ8aHkRs+v58s2Lgmt4mMfE66CY/N0M5tMWsvZw3jUPyef4k6AZVDr9vSPU5Imp/DbXm
 7sRxuZv2ZJPcN
X-Received: by 2002:a05:6808:4f66:b0:4b1:540a:df99 with SMTP id
 5614622812f47-4b366d54c1fmr2146419b6e.21.1787688845963; 
 Tue, 25 Aug 2026 13:14:05 -0700 (PDT)
Received: from [127.0.1.1] (71-218-10-81.hlrn.qwest.net. [71.218.10.81])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b367c77c28sm343156b6e.4.2026.08.25.13.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 13:14:05 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 25 Aug 2026 14:14:03 -0600
Subject: [PATCH] net: sandbox: support raw Ethernet with lwIP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-submit-lwip-sandbox-raw-v1-v1-1-f9558fb4f6d1@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMSw6CQBAFr0J6bUdmBESuYlz0QCttZCDT/BLC3
 R10WS+vagPlIKxQJRsEnkWl9xHMKYG6Jf9ilCYy2NQWaWlz1Ml1MuJnkQGVfOP6FQMtOBu8Zre
 LydPMuLKAGBgCP2X9xe+PP0f7zfV4FI+HI2V0gXzdHtM06BiYunNH4mHfv0rYBeKeAAAA
X-Change-ID: 20260825-submit-lwip-sandbox-raw-v1-749315041b86
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 David Lechner <dlechner@baylibre.com>, 
 James Hilliard <james.hilliard1@gmail.com>
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

ETH_SANDBOX_RAW is restricted to NET_LEGACY despite operating through
the common Ethernet driver API.

Make the localhost shim stack-neutral: define the ARP layout locally,
populate lwIP's per-device ipaddr environment variable, and retain the
legacy address state when that stack is selected.

Linux loopback can expose UDP checksum-offload seeds through raw sockets
without the metadata needed to validate them. Normalize these to the valid
IPv4 no-checksum form. Only update the dummy UDP bind for UDP output so
lwIP-generated ICMP packets cannot disturb it.

This enables both real-interface and localhost raw Ethernet with lwIP.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 arch/sandbox/cpu/eth-raw-os.c | 83 +++++++++++++++++++++++++++++--------------
 drivers/net/Kconfig           |  2 +-
 drivers/net/sandbox-raw.c     | 49 +++++++++++++++++--------
 include/net-legacy.h          |  6 ++++
 include/net-lwip.h            |  5 +++
 5 files changed, 103 insertions(+), 42 deletions(-)

diff --git a/arch/sandbox/cpu/eth-raw-os.c b/arch/sandbox/cpu/eth-raw-os.c
index 39ea3b3f012..c9c3a561a76 100644
--- a/arch/sandbox/cpu/eth-raw-os.c
+++ b/arch/sandbox/cpu/eth-raw-os.c
@@ -208,7 +208,6 @@ int sandbox_eth_raw_os_send(void *packet, int length,
 			    struct eth_sandbox_raw_priv *priv)
 {
 	int retval;
-	struct udphdr *udph = packet + sizeof(struct iphdr);
 
 	if (priv->sd < 0 || !priv->device)
 		return -EINVAL;
@@ -226,38 +225,50 @@ int sandbox_eth_raw_os_send(void *packet, int length,
 	 * stack from sending that ICMP message claiming that the port has no
 	 * bound socket.
 	 */
-	if (priv->local && (priv->local_bind_sd == -1 ||
-			    priv->local_bind_udp_port != udph->source)) {
+	if (priv->local && length >= sizeof(struct iphdr)) {
 		struct iphdr *iph = packet;
-		struct sockaddr_in addr;
+		unsigned int iphdr_len = iph->ihl * 4;
+		struct udphdr *udph;
 
-		if (priv->local_bind_sd != -1)
-			os_close(priv->local_bind_sd);
+		if (iph->protocol != IPPROTO_UDP ||
+		    iphdr_len < sizeof(*iph) ||
+		    length < iphdr_len + sizeof(*udph))
+			goto send;
 
-		/* A normal UDP socket is required to bind */
-		priv->local_bind_sd = socket(AF_INET, SOCK_DGRAM, 0);
-		if (priv->local_bind_sd < 0) {
-			printf("Failed to open bind sd: %d %s\n", errno,
-			       strerror(errno));
-			return -errno;
+		udph = packet + iphdr_len;
+		if (priv->local_bind_sd == -1 ||
+		    priv->local_bind_udp_port != udph->source) {
+			struct sockaddr_in addr = {};
+
+			if (priv->local_bind_sd != -1)
+				os_close(priv->local_bind_sd);
+
+			/* A normal UDP socket is required to bind */
+			priv->local_bind_sd = socket(AF_INET, SOCK_DGRAM, 0);
+			if (priv->local_bind_sd < 0) {
+				printf("Failed to open bind sd: %d %s\n", errno,
+				       strerror(errno));
+				return -errno;
+			}
+			priv->local_bind_udp_port = udph->source;
+
+			/**
+			 * Bind the UDP port that we intend to use as our source port
+			 * so that the kernel will not send an ICMP port unreachable
+			 * message to the server
+			 */
+			addr.sin_family = AF_INET;
+			addr.sin_port = udph->source;
+			addr.sin_addr.s_addr = iph->saddr;
+			retval = bind(priv->local_bind_sd,
+				      (struct sockaddr *)&addr, sizeof(addr));
+			if (retval < 0)
+				printf("Failed to bind: %d %s\n", errno,
+				       strerror(errno));
 		}
-		priv->local_bind_udp_port = udph->source;
-
-		/**
-		 * Bind the UDP port that we intend to use as our source port
-		 * so that the kernel will not send an ICMP port unreachable
-		 * message to the server
-		 */
-		addr.sin_family = AF_INET;
-		addr.sin_port = udph->source;
-		addr.sin_addr.s_addr = iph->saddr;
-		retval = bind(priv->local_bind_sd, (struct sockaddr *)&addr,
-			      sizeof(addr));
-		if (retval < 0)
-			printf("Failed to bind: %d %s\n", errno,
-			       strerror(errno));
 	}
 
+send:
 	retval = sendto(priv->sd, packet, length, 0,
 			(struct sockaddr *)priv->device,
 			sizeof(struct sockaddr_ll));
@@ -283,6 +294,24 @@ int sandbox_eth_raw_os_recv(void *packet, int *length,
 			  (socklen_t *)&saddr_size);
 	*length = 0;
 	if (retval >= 0) {
+		if (priv->local && retval >= sizeof(struct iphdr)) {
+			struct iphdr *iph = packet;
+			unsigned int iphdr_len = iph->ihl * 4;
+
+			if (iph->protocol == IPPROTO_UDP &&
+			    iphdr_len >= sizeof(*iph) &&
+			    retval >= iphdr_len + sizeof(struct udphdr)) {
+				struct udphdr *udph = packet + iphdr_len;
+
+				/*
+				 * Loopback packets can retain a checksum-offload seed
+				 * which a raw socket cannot validate without skb metadata.
+				 * An IPv4 UDP checksum of zero explicitly disables the
+				 * checksum, so present that portable form to U-Boot.
+				 */
+				udph->check = 0;
+			}
+		}
 		*length = retval;
 		return 0;
 	}
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index faa08e9ebba..c057504cf66 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -366,7 +366,7 @@ config ETH_SANDBOX
 
 config ETH_SANDBOX_RAW
 	depends on SANDBOX
-	depends on NET_LEGACY
+	depends on NET
 	default y
 	bool "Sandbox: Bridge to Linux Raw Sockets"
 	help
diff --git a/drivers/net/sandbox-raw.c b/drivers/net/sandbox-raw.c
index c3d40f0b59e..c57893c48ce 100644
--- a/drivers/net/sandbox-raw.c
+++ b/drivers/net/sandbox-raw.c
@@ -13,6 +13,21 @@
 #include <malloc.h>
 #include <net.h>
 
+#define ARP_PROTOCOL_ADDR_LEN	4
+#define ARP_OP_REPLY		2
+
+struct sb_arp_hdr {
+	u16 hrd;
+	u16 pro;
+	u8 hln;
+	u8 pln;
+	u16 op;
+	u8 sha[ARP_HLEN];
+	struct in_addr spa;
+	u8 tha[ARP_HLEN];
+	struct in_addr tpa;
+} __packed;
+
 static int reply_arp;
 static struct in_addr arp_ip;
 
@@ -20,6 +35,8 @@ static int sb_eth_raw_start(struct udevice *dev)
 {
 	struct eth_sandbox_raw_priv *priv = dev_get_priv(dev);
 	struct eth_pdata *pdata = dev_get_plat(dev);
+	char ipaddr[sizeof("ipaddr99")];
+	int idx = dev_seq(dev);
 	int ret;
 
 	debug("eth_sandbox_raw: Start\n");
@@ -27,9 +44,13 @@ static int sb_eth_raw_start(struct udevice *dev)
 	ret = sandbox_eth_raw_os_start(priv, pdata->enetaddr);
 	if (priv->local) {
 		env_set("ipaddr", "127.0.0.1");
+		if (IS_ENABLED(CONFIG_NET_LWIP) && idx > 0 && idx <= 99) {
+			snprintf(ipaddr, sizeof(ipaddr), "ipaddr%d", idx);
+			env_set(ipaddr, "127.0.0.1");
+		}
 		env_set("serverip", "127.0.0.1");
 		net_ip = string_to_ip("127.0.0.1");
-		net_server_ip = net_ip;
+		net_set_server_ip(net_ip);
 	}
 	return ret;
 }
@@ -44,13 +65,13 @@ static int sb_eth_raw_send(struct udevice *dev, void *packet, int length)
 		struct ethernet_hdr *eth = packet;
 
 		if (ntohs(eth->et_protlen) == PROT_ARP) {
-			struct arp_hdr *arp = packet + ETHER_HDR_SIZE;
+			struct sb_arp_hdr *arp = packet + ETHER_HDR_SIZE;
 
 			/**
 			 * localhost works on a higher-level API in Linux than
 			 * ARP packets, so fake it
 			 */
-			arp_ip = net_read_ip(&arp->ar_tpa);
+			memcpy(&arp_ip, &arp->tpa, sizeof(arp_ip));
 			reply_arp = 1;
 			return 0;
 		}
@@ -68,7 +89,7 @@ static int sb_eth_raw_recv(struct udevice *dev, int flags, uchar **packetp)
 	int length;
 
 	if (reply_arp) {
-		struct arp_hdr *arp = (void *)net_rx_packets[0] +
+		struct sb_arp_hdr *arp = (void *)net_rx_packets[0] +
 			ETHER_HDR_SIZE;
 
 		/*
@@ -80,18 +101,18 @@ static int sb_eth_raw_recv(struct udevice *dev, int flags, uchar **packetp)
 		 * to get a response. For this reason we fake the response to
 		 * make the u-boot network stack happy.
 		 */
-		arp->ar_hrd = htons(ARP_ETHER);
-		arp->ar_pro = htons(PROT_IP);
-		arp->ar_hln = ARP_HLEN;
-		arp->ar_pln = ARP_PLEN;
-		arp->ar_op = htons(ARPOP_REPLY);
+		arp->hrd = htons(ARP_ETHER);
+		arp->pro = htons(PROT_IP);
+		arp->hln = ARP_HLEN;
+		arp->pln = ARP_PROTOCOL_ADDR_LEN;
+		arp->op = htons(ARP_OP_REPLY);
 		/* Any non-zero MAC address will work */
-		memset(&arp->ar_sha, 0x01, ARP_HLEN);
+		memset(arp->sha, 0x01, ARP_HLEN);
 		/* Use whatever IP we were looking for (always 127.0.0.1?) */
-		net_write_ip(&arp->ar_spa, arp_ip);
-		memcpy(&arp->ar_tha, pdata->enetaddr, ARP_HLEN);
-		net_write_ip(&arp->ar_tpa, net_ip);
-		length = ARP_HDR_SIZE;
+		memcpy(&arp->spa, &arp_ip, sizeof(arp->spa));
+		memcpy(arp->tha, pdata->enetaddr, ARP_HLEN);
+		memcpy(&arp->tpa, &net_ip, sizeof(arp->tpa));
+		length = sizeof(*arp);
 	} else {
 		/* If local, the Ethernet header won't be included; skip it */
 		uchar *pktptr = priv->local ?
diff --git a/include/net-legacy.h b/include/net-legacy.h
index d3b122c9062..2737b683cb1 100644
--- a/include/net-legacy.h
+++ b/include/net-legacy.h
@@ -288,6 +288,12 @@ extern char	net_root_path[CONFIG_BOOTP_MAX_ROOT_PATH_LEN];	/* Our root path */
 extern u8		net_ethaddr[ARP_HLEN];		/* Our ethernet address */
 extern u8		net_server_ethaddr[ARP_HLEN];	/* Boot server enet address */
 extern struct in_addr	net_server_ip;	/* Server IP addr (0 = unknown) */
+
+static inline void net_set_server_ip(struct in_addr ip)
+{
+	net_server_ip = ip;
+}
+
 extern uchar		*net_tx_packet;		/* THE transmit packet */
 extern uchar		*net_rx_packet;		/* Current receive packet */
 extern int		net_rx_packet_len;	/* Current rx packet length */
diff --git a/include/net-lwip.h b/include/net-lwip.h
index 8e59a2299e0..9b7755e335e 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -26,6 +26,11 @@ enum proto_t {
 	TFTPGET
 };
 
+static inline void net_set_server_ip(struct in_addr ip)
+{
+	/* lwIP reads serverip from the environment when starting a command. */
+}
+
 static inline int eth_is_on_demand_init(void)
 {
 	return 1;

---
base-commit: 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc
change-id: 20260825-submit-lwip-sandbox-raw-v1-749315041b86

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

