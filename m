Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7235C36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 20:48:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12A5980EEF;
	Mon, 24 Mar 2025 21:48:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Lx3OjTuI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B86580F70; Mon, 24 Mar 2025 21:48:50 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 3818A809D0
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 21:48:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from LAPTOP-HS0II3UH.corp.microsoft.com
 (d66-183-145-126.bchsia.telus.net [66.183.145.126])
 by linux.microsoft.com (Postfix) with ESMTPSA id 3256B2036563;
 Mon, 24 Mar 2025 13:48:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3256B2036563
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1742849327;
 bh=uBK4Clbfiu/XPvtop36sfpe1cf6SehhKyZoB03/0qak=;
 h=From:To:Cc:Subject:Date:From;
 b=Lx3OjTuISZifqKp6ngJFkp8FcFDZWrSISt7j/l4PP+mA+uNpuTfmjyoizbzBW7P3T
 qMgYZFEPSbpXFH7f3useyLmZtXWv3e5Kcojo/XsVpLtSMwHNri8PlvVHN/KTMBkpcm
 5EJWUZiSNDg0dHfyRQ1ovEY6f13exKRFokAWaJ8c=
From: seanedmond@linux.microsoft.com
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com,
	rfried.dev@gmail.com,
	trini@konsulko.com
Subject: [PATCH v2] net: dhcp6: Send DHCPv6 using multicast MAC
Date: Mon, 24 Mar 2025 13:48:45 -0700
Message-Id: <20250324204845.25603-1-seanedmond@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
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

From: Sean Edmond <seanedmond@microsoft.com>

In IPv6, the broadcast MAC address is not used.  Instead, it should use
the multicast address (see RFC RFC2464).

Add IPV6_ALL_NODE_ETH_ADDR macro for clarity.

Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
---
 include/net6.h | 10 ++++++++++
 net/dhcpv6.c   | 12 ++++++------
 net/dhcpv6.h   |  8 +++++++-
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/include/net6.h b/include/net6.h
index 1ed989e584a..2ceeaba0639 100644
--- a/include/net6.h
+++ b/include/net6.h
@@ -90,6 +90,16 @@ struct udp_hdr {
 				  0x00, 0x00, 0x00, 0x00, \
 				  0x00, 0x00, 0x00, 0x00, \
 				  0x00, 0x00, 0x00, 0x02 } } }
+/*
+ * With IPv6, the broadcast MAC address is not used. Instead, it should use
+ * the multicast address (see RFC RFC2464 section 7)
+ */
+#define IPV6_ALL_NODE_ETH_ADDR(_ip6_addr)  {0x33, \
+				  0x33, \
+				  _ip6_addr.in6_u.u6_addr8[12], \
+				  _ip6_addr.in6_u.u6_addr8[13], \
+				  _ip6_addr.in6_u.u6_addr8[14], \
+				  _ip6_addr.in6_u.u6_addr8[15]}
 
 #define IPV6_LINK_LOCAL_PREFIX	0xfe80
 #define IPV6_LINK_LOCAL_MASK	0xffb0 /* The first 10-bit of address mask. */
diff --git a/net/dhcpv6.c b/net/dhcpv6.c
index 54619ee6983..984a64a4ff3 100644
--- a/net/dhcpv6.c
+++ b/net/dhcpv6.c
@@ -29,6 +29,10 @@
 int updated_sol_max_rt_ms = SOL_MAX_RT_MS;
 /* state machine parameters/variables */
 struct dhcp6_sm_params sm_params;
+/* DHCPv6 all server IP6 address */
+const struct in6_addr dhcp_mcast_ip6 = DHCP6_MULTICAST_ADDR;
+/* IPv6 multicast ethernet address */
+const u8 net_dhcp6_mcast_ethaddr[6] = IPV6_ALL_NODE_ETH_ADDR(dhcp_mcast_ip6);
 
 static void dhcp6_state_machine(bool timeout, uchar *rx_pkt, unsigned int len);
 
@@ -171,7 +175,6 @@ static int dhcp6_add_option(int option_id, uchar *pkt)
  */
 static void dhcp6_send_solicit_packet(void)
 {
-	struct in6_addr dhcp_bcast_ip6;
 	int len = 0;
 	uchar *pkt;
 	uchar *dhcp_pkt_start_ptr;
@@ -200,9 +203,8 @@ static void dhcp6_send_solicit_packet(void)
 	len = pkt - dhcp_pkt_start_ptr;
 
 	/* send UDP packet to DHCP6 multicast address */
-	string_to_ip6(DHCP6_MULTICAST_ADDR, sizeof(DHCP6_MULTICAST_ADDR), &dhcp_bcast_ip6);
 	net_set_udp_handler(dhcp6_handler);
-	net_send_udp_packet6((uchar *)net_bcast_ethaddr, &dhcp_bcast_ip6,
+	net_send_udp_packet6((uchar *)net_dhcp6_mcast_ethaddr, (struct in6_addr *)&dhcp_mcast_ip6,
 			     PORT_DHCP6_S, PORT_DHCP6_C, len);
 }
 
@@ -218,7 +220,6 @@ static void dhcp6_send_solicit_packet(void)
  */
 static void dhcp6_send_request_packet(void)
 {
-	struct in6_addr dhcp_bcast_ip6;
 	int len = 0;
 	uchar *pkt;
 	uchar *dhcp_pkt_start_ptr;
@@ -252,9 +253,8 @@ static void dhcp6_send_request_packet(void)
 	len = pkt - dhcp_pkt_start_ptr;
 
 	/* send UDP packet to DHCP6 multicast address */
-	string_to_ip6(DHCP6_MULTICAST_ADDR, strlen(DHCP6_MULTICAST_ADDR), &dhcp_bcast_ip6);
 	net_set_udp_handler(dhcp6_handler);
-	net_send_udp_packet6((uchar *)net_bcast_ethaddr, &dhcp_bcast_ip6,
+	net_send_udp_packet6((uchar *)net_dhcp6_mcast_ethaddr, (struct in6_addr *)&dhcp_mcast_ip6,
 			     PORT_DHCP6_S, PORT_DHCP6_C, len);
 }
 
diff --git a/net/dhcpv6.h b/net/dhcpv6.h
index 65c8e4c71d3..d41a3c30615 100644
--- a/net/dhcpv6.h
+++ b/net/dhcpv6.h
@@ -40,7 +40,13 @@
 /* vendor-class-data to send in vendor clas option */
 #define DHCP6_VCI_STRING	"U-Boot"
 
-#define DHCP6_MULTICAST_ADDR	"ff02::1:2"	/* DHCP multicast address */
+/*
+ * All-DHCPv6 server multicast address
+ */
+#define DHCP6_MULTICAST_ADDR { { { 0xFF, 0x02, 0x00, 0x00, \
+								   0x00, 0x00, 0x00, 0x00, \
+								   0x00, 0x00, 0x00, 0x00, \
+								   0x00, 0x01, 0x00, 0x02 } } }
 
 /* DHCP6 States supported */
 enum dhcp6_state {
-- 
2.34.1

