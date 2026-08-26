Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4FBC61DBD
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 17:36:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DEAAE80B32;
	Wed, 26 Aug 2026 17:36:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IPlKCaWoQ6zJ; Wed, 26 Aug 2026 17:36:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787765794;
	bh=QIydT3+y0X2ZTvZs+oGfGoKKMfo+uSb+4UEbQ+OrDYY=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=mXDzI16OKcV7Ma6cDa2qwM2w6mxOXo85+dczgPjDWBx8DuuMvbJmlyDAsIt+z4RI7
	 /n1tRM9a/w5xf5uwibjjin1oQUxPNqWOylp01aemHaEzoN9CVJsSBr3UsNAOoD78yQ
	 ph3zmUCkCaDt2Ff4Oox9j3bu4irLr7iUMpkA/BveGBZ7Pga7K8wKHKbeBgFttVYDf8
	 jQVK1Y4SJzOpmmlVlpemcutv42oMBC1eprlJYLzduYZIeb0KpDrDpIjLxgSK3etzdi
	 XIVoA+vWnem98+d4RC1ohKzE3kFAFG6fFn/62gxazg9er7x68Z9ZecdSiD2TxpIPqs
	 09/OH8JdUNcOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B064080B19;
	Wed, 26 Aug 2026 17:36:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 87780323
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 17:36:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6EBAB40545
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 17:36:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vJ5UzWxrJpSX for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 17:36:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::233; helo=mail-oi1-x233.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=j06UGOLC
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 35AC34052D
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 17:36:31 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4b1be215736so1250159b6e.1
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 10:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787765791; x=1788370591;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QIydT3+y0X2ZTvZs+oGfGoKKMfo+uSb+4UEbQ+OrDYY=;
 b=j06UGOLCALgRo0Yvbuw2sM6WwaULVkUF8q86H2WvoEnw+zndnQyjF3nn+TEQ9jLv0T
 X+hlDO/KLi0ouBfvAt7XD2NiDkkuzgW2KhCjAn7ohDxGpSYcTOWXMrggJWcVt0bkHPq+
 W3hlQdfqk5DXCRwWTAteCGteAgRpruyoiKmQ4sx2zGkKAsbCau/R4mA6v6q/Y4jQ050Z
 WR85lD6hN7SgJrkBIeQ5aHUWs9Y/oDTclaoCfVUElT5aOrTqmGKMbripRMH7J6ci1QLy
 JitwI/1Xe7f/Zlf0FQtJ84NIBJCOIn1rko5LGpZWMnla+ZundOe8sv3Fw48sBGe0/UDl
 o0iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787765791; x=1788370591;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QIydT3+y0X2ZTvZs+oGfGoKKMfo+uSb+4UEbQ+OrDYY=;
 b=M0fNfXigfxJuiEfDqEEApbFBZd+jmeWBGA829EbiALosOiLkiulnliMXPK2Q2TTYcR
 3PIrwl+BG4NwLIv8FnhKnaPFHecBUIEhzcHBGLZxELct7zrNgVbHH+actmRLGI+J34Tz
 XALg+OI2M9upO3FshgkIgV0+qAoIoxLoOc1Rh9TNVR+KvjGyw8cpbZsoWuoR4CkfSnXH
 0trwqP3VJuQOio91esEbAJIUiHbiDElrSRitP5NV9pc9SP2qrmVflqUk2y7Jy9yT7sMt
 xerRmhF3ThkUOrGSX502SaBeYhI1qNHo67/S6ZGFa5vShzSuri00qpygPAI80PM9p/LM
 YEeg==
X-Gm-Message-State: AFuF++mz7TGOGkbfr3HlEpZcdCDtobAkrBqF+5tnX5aMFtlxaw9WJABh
 mw+fceeaEEX2nRusaWtNTQavfbYTR8ZcSaZrCYzFVOo1+FLtJQY6nNjp
X-Gm-Gg: AR+sD10KLdXf/H1a4+ZgZ2yWbRRDw+lvGsiYYiK6+uScTixJQrfYifUBV5kjEXra2xk
 SC9MGeb8Bdm6uYJgMAh3vBtoY+zZggL+qWzdjfi16vqlKtOSImdAXxTAKoG1uD6nGK5lvHz0h/F
 9kxMPi8z4SS/fdn/mHtPw8KNhUkFyq0q8FSiRxL4WIg1z9jsv7lTdKCWBRKU+iNbaCugg6opZ5W
 BJRCz1BCF2V95WiSTSHG0HAK3qfFGjV71xXkv/nktjJAMtfP58/l2keCt6EIhrjnKc7nRY2BxH1
 xnMKj2mpsyCl8XlnIxJC0EHaueQyoAR6mPm0VZNSUkfkFe9unvbxc1bx21k6EHthE3axZc7ANLn
 sjmzBsXVgoppoiFT7AMnJE9NkKaQ/gYKpbd0X8dtzVYoX9n3+PWVVP3qqh99cl4pv8px7w4nm5L
 1HfAlvgd/y48iaYTRUp7J79zw7Y7tPNhmc+7bCjkdDj8zLuEmQgARBSdeExcpgkVjrCp0ObLizo
 x8grZ9jEk+dGW3G6u88EFyM6Qy624esz2ge+ZfITp0lJuaMrXGCXF/Egij2Jw8QFM5UfpvSq0Vx
 7t30ClExX/8j2XYut93B6Wiw4557livmyvbfrbHbrJnVHkddyn5Hmwyu4RglRveuZB/Lpxxt2nQ
 xci1m+zfmOpD1IB+FAw==
X-Received: by 2002:a05:6808:4fd1:b0:4aa:d5f:123e with SMTP id
 5614622812f47-4b366b0ea25mr9464230b6e.9.1787765790702; 
 Wed, 26 Aug 2026 10:36:30 -0700 (PDT)
Received: from [127.0.1.1] (184-96-151-165.hlrn.qwest.net. [184.96.151.165])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b36a7b3783sm2360606b6e.8.2026.08.26.10.36.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:36:30 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 26 Aug 2026 11:36:18 -0600
Subject: [PATCH v2] net: lwip: support syslog
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-lwip-syslog-v1-v2-1-8c457f2b35ea@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOwQ6CMAyGX4Xs7JQNhsaT72E4jFGgBjayAkoI7
 +6GZ5Nevv7t126MwCMQuycb87AgobMB5ClhptO2BY51YCZTWaQ3qXj/xpHTSr1r+SK4VoVUUGk
 JOmNhafTQ4OcQPssf01y9wEzREicqTcArr63pYmseafKgh8ug0ca8Q5qcX4+PFhE9f4+HElxlU
 qRNnjf1tXi0wdKfjRtYue/7F5B9VUTeAAAA
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
Changes v1 -> v2:
  - Guard the lwIP raw-header helpers with LOG_SYSLOG  (suggested by Peter Robinson)
  - Link to v1: https://patch.msgid.link/20260825-lwip-syslog-v1-v1-1-53210f44fd76@gmail.com
---
 include/net-common.h   |  7 ++++++
 include/net-legacy.h   |  4 ----
 net/lwip/net-lwip.c    | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++
 test/log/syslog_test.c |  2 ++
 test/log/syslog_test.h |  4 ++--
 5 files changed, 71 insertions(+), 6 deletions(-)

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
index 8f8f9d69020..bf916a2a977 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -159,6 +159,66 @@ static int get_udev_ipv4_info(struct udevice *dev, ip4_addr_t *ip,
 	return 0;
 }
 
+#if CONFIG_IS_ENABLED(LOG_SYSLOG)
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
+#endif
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

