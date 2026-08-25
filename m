Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405A0C61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 18:59:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C960260604;
	Tue, 25 Aug 2026 18:59:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2e4qRC5vVOVO; Tue, 25 Aug 2026 18:59:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787684397;
	bh=YGTaBNrnrfJIE9Fd7c/Xp861ayBq8P1thwGVApYmcS0=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vrGUKlgcjJ8zLR3mrfV9GMkA4IpRWOiG6H053uAFW7johlXzS7jGvaIlz18HWjY2y
	 pbw070WXQxKFcpM2ksxDvCfQx09jq7zm0sumTk4uHYeDxuctaQ3fOMYQL+7REN1lnC
	 oxJc2Miw8vHR0+NNQ3fjLOlXqOTB3CVjyEbzjeY6UqbvbWMcNIBxeTfl5DHutsigub
	 29jMZjKomO9H7brnRa67tYCKdS4EO3YcYmJYYBlFyF01/7DTbeEG85UzfZorVhN9CP
	 m6kFgE7n2BTrf7rS6cf5Ngs3sjZqoOzrql0OjTi7SlsUVnJvngXB9qHGe7Z1oCu5q7
	 UqaZsyPfOgmCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0324A606E1;
	Tue, 25 Aug 2026 18:59:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D59A43C3
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 18:59:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C73D5606E1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 18:59:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5zWrEKOpKzD6 for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 18:59:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2c; helo=mail-oa1-x2c.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=g9+BFvxE
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D678960604
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 18:59:54 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-43b7e186a0cso127650fac.0
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 11:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787684393; x=1788289193;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YGTaBNrnrfJIE9Fd7c/Xp861ayBq8P1thwGVApYmcS0=;
 b=g9+BFvxEzQ6BgdH/dXRqosEEPMDfTxjzFJQ1FTaFO9rVCTeTj0dlwV9aYPP9gLcqn1
 lPBPYDGQLYxPm2AC4pttl97BjWo7Vdem4uQNIFgRDQ2HWeO62gI2PBeSZo0h5U+r9YvK
 2JlvS6i1fSG7QyibSTCq5+vUQX0D7idRTsTIw9e2D26OG/uavBj4hwQ2aqu/VG2Q9jqQ
 knir0mXIpsO8NfO8+M4Rt/UKkxpgobLXmWl2TLnwH84wU8TIo691HSikyKkWOnz4psmq
 1SS/9RYzJT/fwUSk6ZN9g8aDwQu3zI1rwhEBDQGSJIS4dYUjStoab+UP1jL8Gm5YxcwA
 jyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787684393; x=1788289193;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=YGTaBNrnrfJIE9Fd7c/Xp861ayBq8P1thwGVApYmcS0=;
 b=df4NoLfTJgu3QuY1R1xho+ricgEguVyvnJjEny2y9d9brSgYh//YwWofCuGDcdOLfa
 C2t3yMyPD06Y2FtGTD8CdDTDRuGPQULUNrYngbGIfP3E2lFscm5Usnp8kXssqgzxxpKw
 rn/EWHohc7PKpRlodZ8zOs+3TDbt/G4JnkoHCcWH8UMGl50SvnsHqIWi6kshUH3oh9gI
 nYhYUpnY2QsJo8gr7IkLX6Zr8q9tl9r3wypRTqfQPf1dAQTASCL3/YRy+cIw/0xI55Uz
 GEHqyQRfJoIjZnmuecAecmkvcSdKXHuazT0k3/6LXEtBiBxpc2BZ1lEk29qheGXTexvK
 yQzg==
X-Gm-Message-State: AFuF++l3wueyWwSnJJLxOC6mv6EleGY+//oDyuvOgBUKM5XPMtltgfE5
 sKZGjEBKUNG5s1dFu4RSiUBgRacGG/+XiyqEaK9f/ouYrMnSz9IYB1wf
X-Gm-Gg: AR+sD12FbCPhbsPGTLUN0Kkas2zIB9QKXumzAuN6R6DijcD9YOxktUYFYt7XCxONxvJ
 bfokQbDHUcs+uUY4vPsdDDXMtZrflS7XojNWwt+6VSqs4mDboTK/kF1Me3bozeAb2XFAHlrS2P2
 ev0tY0x1YrRSZjQMIt2K7CUgmPg4d/CGL5bz8QzauM8L0peVejzTmnV4sAez2I5yWFOuGFYxUmi
 5FASN30M1rEQV76zm/OEWNu7nirVUfA7Ad6DDevdHy8UKMninDFRmbSkOVMHL9/F2TPGZTnxjCq
 4iqz7dz/wA5J3hTbppBzweEUcdR7bCowxjiFNcZ5Tb0V4loCfVeR6ng6fEKLbZQipNOFdRN5CBb
 o0dNRU50XYTtv5jT53mcv9cjmcdpxFG5FqhVU89lvxwIrjNrLG8Sw3HYsZPlIR/01pM5GJ5Vvnm
 2Pyzt8FB99lJduTk6rDgDywCgK/O6cYO45Vq9FI3Mky4FKuuX2sA+uY0UppPrpeNMN63WquZLEC
 duBMHv8tQAs71R0DiurjTPJ2jWORgqBOt44KarMPem3bhA3dFPFdRzzC+gO9lQwP1g6lEgoSdCt
 jCPdODQ8uDbf166gBGZZIRGp7Eg7JNU7Q24hRtgAgvik/ewZPGnK3HrSNDtHTuLC1XPAq1eeDnz
 CJLrA326bmpdL
X-Received: by 2002:a05:6808:144f:b0:4b3:29e5:5512 with SMTP id
 5614622812f47-4b366b177b3mr1469285b6e.16.1787684393373; 
 Tue, 25 Aug 2026 11:59:53 -0700 (PDT)
Received: from [127.0.1.1] (71-218-10-81.hlrn.qwest.net. [71.218.10.81])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b367eb7eafsm202648b6e.10.2026.08.25.11.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 11:59:52 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 25 Aug 2026 12:59:50 -0600
Subject: [PATCH] net: lwip: support syslog
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-lwip-syslog-v1-v1-1-53210f44fd76@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ6CMBBFr0Jm7USoKTFexbiY1hHGQGk6gBrC3
 W11+X7+exsoJ2GFS7VB4lVUppChOVTgewodo9wzg6lNW5+NxeElEfWjw9Th2iDZ1lh2ZJhOkKW
 Y+CHvX/B6+7Mu7sl+LpXycKSMLlHwfZmWqHNiGo8jSYB9/wLllwhxkgAAAA==
X-Change-ID: 20260825-lwip-syslog-v1-a5625eba2ea3
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>, 
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

LOG_SYSLOG depends on NET, but the raw Ethernet and UDP header
builders it uses are only available with the legacy network stack. This
makes LOG_SYSLOG fail to build with NET_LWIP.

Provide lwIP implementations using the selected Ethernet device and its
indexed IP address from the environment. Move the shared declarations to
net-common.h and extend the syslog test to check the source MAC address
and IPv4 header checksum.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 include/net-common.h   |  7 ++++++
 include/net-legacy.h   |  4 ----
 net/lwip/net-lwip.c    | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++
 test/log/syslog_test.c |  2 ++
 test/log/syslog_test.h |  4 ++--
 5 files changed, 69 insertions(+), 6 deletions(-)

diff --git a/include/net-common.h b/include/net-common.h
index 0c260873c2c..3084a2b2a57 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -362,6 +362,13 @@ struct ethernet_hdr {
 /* Ethernet header size */
 #define ETHER_HDR_SIZE	(sizeof(struct ethernet_hdr))
 
+/* Set Ethernet header; returns the size of the header */
+int net_set_ether(uchar *xet, const uchar *dest_ethaddr, uint prot);
+
+/* Set IPv4 and UDP headers */
+void net_set_udp_header(uchar *pkt, struct in_addr dest, int dport,
+			int sport, int len);
+
 /**
  * net_random_ethaddr - Generate software assigned random Ethernet address
  * @addr: Pointer to a six-byte array containing the Ethernet address
diff --git a/include/net-legacy.h b/include/net-legacy.h
index d3b122c9062..d7f55d34a30 100644
--- a/include/net-legacy.h
+++ b/include/net-legacy.h
@@ -344,15 +344,11 @@ int net_loop(enum proto_t);
 /* Get size of the ethernet header when we send */
 int net_eth_hdr_size(void);
 
-/* Set ethernet header; returns the size of the header */
-int net_set_ether(uchar *xet, const uchar *dest_ethaddr, uint prot);
 int net_update_ether(struct ethernet_hdr *et, uchar *addr, uint prot);
 
 /* Set IP header */
 void net_set_ip_header(uchar *pkt, struct in_addr dest, struct in_addr source,
 		       u16 pkt_len, u8 proto);
-void net_set_udp_header(uchar *pkt, struct in_addr dest, int dport,
-			int sport, int len);
 
 /* Callbacks */
 rxhand_f *net_get_udp_handler(void);	/* Get UDP RX packet handler */
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index 8f8f9d69020..4dd8f0d2ce7 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -159,6 +159,64 @@ static int get_udev_ipv4_info(struct udevice *dev, ip4_addr_t *ip,
 	return 0;
 }
 
+int net_set_ether(uchar *xet, const uchar *dest_ethaddr, uint prot)
+{
+	struct ethernet_hdr *et = (struct ethernet_hdr *)xet;
+	const uchar *src = eth_get_ethaddr();
+
+	memcpy(et->et_dest, dest_ethaddr, ARP_HLEN);
+	if (src)
+		memcpy(et->et_src, src, ARP_HLEN);
+	else
+		memset(et->et_src, 0, ARP_HLEN);
+	et->et_protlen = htons(prot);
+
+	return ETHER_HDR_SIZE;
+}
+
+static void net_lwip_set_ip_header(uchar *pkt, struct in_addr dest,
+				   struct in_addr source, u16 pkt_len,
+				   u8 proto)
+{
+	static u16 ip_id;
+	struct ip_udp_hdr *ip = (struct ip_udp_hdr *)pkt;
+
+	ip->ip_hl_v = 0x45;
+	ip->ip_tos = 0;
+	ip->ip_len = htons(pkt_len);
+	ip->ip_p = proto;
+	ip->ip_id = htons(ip_id++);
+	ip->ip_off = htons(IP_FLAGS_DFRAG);
+	ip->ip_ttl = 255;
+	ip->ip_sum = 0;
+	memcpy(&ip->ip_src, &source, sizeof(source));
+	memcpy(&ip->ip_dst, &dest, sizeof(dest));
+	ip->ip_sum = compute_ip_checksum(ip, IP_HDR_SIZE);
+}
+
+void net_set_udp_header(uchar *pkt, struct in_addr dest, int dport, int sport,
+			int len)
+{
+	struct ip_udp_hdr *ip = (struct ip_udp_hdr *)pkt;
+	struct in_addr source = {};
+	ip4_addr_t addr, mask, gateway;
+	struct udevice *dev = eth_get_dev();
+	u16 pkt_len = IP_UDP_HDR_SIZE + len;
+
+	if (len & 1)
+		pkt[IP_UDP_HDR_SIZE + len] = 0;
+
+	if (dev && !get_udev_ipv4_info(dev, &addr, &mask, &gateway))
+		source.s_addr = addr.addr;
+
+	net_lwip_set_ip_header(pkt, dest, source, pkt_len, IPPROTO_UDP);
+
+	ip->udp_src = htons(sport);
+	ip->udp_dst = htons(dport);
+	ip->udp_len = htons(UDP_HDR_SIZE + len);
+	ip->udp_xsum = 0;
+}
+
 /*
  * Initialize DNS via env
  */
diff --git a/test/log/syslog_test.c b/test/log/syslog_test.c
index b6c0631aaf6..f848506fb1c 100644
--- a/test/log/syslog_test.c
+++ b/test/log/syslog_test.c
@@ -34,11 +34,13 @@ int sb_log_tx_handler(struct udevice *dev, void *packet, unsigned int len)
 
 	/* Check Ethernet header */
 	ut_asserteq_mem(&eth_hdr->et_dest, net_bcast_ethaddr, ARP_HLEN);
+	ut_asserteq_mem(&eth_hdr->et_src, eth_get_ethaddr(), ARP_HLEN);
 	ut_asserteq(ntohs(eth_hdr->et_protlen), PROT_IP);
 
 	/* Check IP header */
 	buf += sizeof(struct ethernet_hdr);
 	ip_udp_hdr = (struct ip_udp_hdr *)buf;
+	ut_assert(ip_checksum_ok(ip_udp_hdr, IP_HDR_SIZE));
 	ut_asserteq(ip_udp_hdr->ip_p, IPPROTO_UDP);
 	ut_asserteq(ip_udp_hdr->ip_dst.s_addr, 0xffffffff);
 	ut_asserteq(ntohs(ip_udp_hdr->udp_dst), 514);
diff --git a/test/log/syslog_test.h b/test/log/syslog_test.h
index 39cce4ed498..89c86541f5e 100644
--- a/test/log/syslog_test.h
+++ b/test/log/syslog_test.h
@@ -31,8 +31,8 @@ struct sb_log_env {
  *
  * The following checks are executed:
  *
- * * the Ethernet packet indicates a IP broadcast message
- * * the IP header is for a local UDP broadcast message to port 514
+ * * the Ethernet packet uses the selected interface and broadcast destination
+ * * the IP header checksum is valid and describes a UDP broadcast to port 514
  * * the UDP payload matches the expected string
  *
  * After testing the pointer to the expected string is set to NULL to signal

---
base-commit: 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc
change-id: 20260825-lwip-syslog-v1-a5625eba2ea3

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

