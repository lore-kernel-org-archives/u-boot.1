Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789D3C197A0
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 00:49:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52366874EB;
	Sat, 18 Nov 2023 01:48:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iYqiZVmB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACE8E874BA; Sat, 18 Nov 2023 01:48:40 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id E2A7F874D9
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 01:48:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id 76E1320B74C2;
 Fri, 17 Nov 2023 16:48:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 76E1320B74C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1700268507;
 bh=sY1ga84QxzQwE3rV2NZmxjwgJLjsLuRC+ErimqcbemU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iYqiZVmBOOPVupcPXw7UYbJT31k7nU97WVadr2iW/0WlALICJYoMFdqWGlPymBMRw
 GL7wu1J7UBKBA1rdgDkwgp5AA5eFJ0noqnlAOugmyJCejQDjdcBA5DDiWILKX7CTA2
 HEBdzGqRTO7iq6VjeHFH/XcZFWRVKPVJfg60vmaI=
From: seanedmond@linux.microsoft.com
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de,
	pbrobinson@gmail.com,
	trini@konsulko.com
Subject: [PATCH v5 2/3] net: bootp: BOOTP/DHCPv4 retransmission improvements
Date: Fri, 17 Nov 2023 16:48:25 -0800
Message-ID: <20231118004826.157835-3-seanedmond@linux.microsoft.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231118004826.157835-1-seanedmond@linux.microsoft.com>
References: <20231118004826.157835-1-seanedmond@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This patch introduces 3 improvements to align with RFC 951:
- retransmission backoff interval maximum is configurable
- initial retranmission backoff interval is configurable
- transaction ID is kept the same for each BOOTP/DHCPv4 request

In applications where thousands of nodes are serviced by a single DHCP
server, maximizing the retransmission backoff interval at 2 seconds (the
current u-boot default) exerts high pressure on the DHCP server and
network layer.

RFC 951 “7.2. Client Retransmission Strategy” states that the
retransmission backoff interval should be limited to 60 seconds.  This
patch allows the interval to be configurable using the environment
variable "bootpretransmitperiodmax"

The initial retranmission backoff period defaults to 250ms, which is
also too small for these scenarios with many clients.  This patch makes
the initial retransmission interval to be configurable using the
environment variable "bootpretransmitperiodinit".

Also, on a retransmission it is not expected for the transaction ID to
change (only the 'secs' field should be updated). Let's save the
transaction ID and use the same transaction ID for each BOOTP/DHCPv4
exchange.

Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
---

changes in v4:
- Add "select LIB_RAND" for "config CMD_BOOTP" (retransmission
  improvements require rand())

changes in v3:
- Set RETRANSMIT_PERIOD_MAX_MS=60000
- Add randomization factor to retransmission timeout

changes in v2:
- use env_get_ulong() to get environment variables

 cmd/Kconfig |  2 +-
 net/bootp.c | 71 +++++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 56 insertions(+), 17 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index ae846b204dc..93bf752035c 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1717,6 +1717,7 @@ if CMD_NET
 config CMD_BOOTP
 	bool "bootp"
 	default y
+	select LIB_RAND
 	help
 	  bootp - boot image via network using BOOTP/TFTP protocol
 
@@ -1725,7 +1726,6 @@ config CMD_DHCP
 	depends on CMD_BOOTP
 	help
 	  Boot image via network using DHCP/TFTP protocol
-
 config CMD_DHCP6
 	bool "dhcp6"
 	depends on IPV6
diff --git a/net/bootp.c b/net/bootp.c
index 24547cf7bfd..89425717328 100644
--- a/net/bootp.c
+++ b/net/bootp.c
@@ -42,6 +42,22 @@
  */
 #define TIMEOUT_MS	((3 + (CONFIG_NET_RETRY_COUNT * 5)) * 1000)
 
+/*
+ * According to rfc951 : 7.2. Client Retransmission Strategy
+ * "After the 'average' backoff reaches about 60 seconds, it should be
+ * increased no further, but still randomized."
+ *
+ * U-Boot has saturated this backoff at 2 seconds for a long time.
+ * To modify, set the environment variable "bootpretransmitperiodmax"
+ */
+#define RETRANSMIT_PERIOD_MAX_MS	60000
+
+/* Retransmission timeout for the initial packet (in milliseconds).
+ * This timeout will double on each retry.  To modify, set the
+ * environment variable bootpretransmitperiodinit.
+ */
+#define RETRANSMIT_PERIOD_INIT_MS	250
+
 #ifndef CFG_DHCP_MIN_EXT_LEN		/* minimal length of extension list */
 #define CFG_DHCP_MIN_EXT_LEN 64
 #endif
@@ -53,6 +69,7 @@
 u32		bootp_ids[CFG_BOOTP_ID_CACHE_SIZE];
 unsigned int	bootp_num_ids;
 int		bootp_try;
+u32		bootp_id;
 ulong		bootp_start;
 ulong		bootp_timeout;
 char net_nis_domain[32] = {0,}; /* Our NIS domain */
@@ -60,6 +77,7 @@ char net_hostname[32] = {0,}; /* Our hostname */
 char net_root_path[CONFIG_BOOTP_MAX_ROOT_PATH_LEN] = {0,}; /* Our bootpath */
 
 static ulong time_taken_max;
+static u32   retransmit_period_max_ms;
 
 #if defined(CONFIG_CMD_DHCP)
 static dhcp_state_t dhcp_state = INIT;
@@ -396,6 +414,7 @@ static void bootp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
 static void bootp_timeout_handler(void)
 {
 	ulong time_taken = get_timer(bootp_start);
+	int rand_minus_plus_100;
 
 	if (time_taken >= time_taken_max) {
 #ifdef CONFIG_BOOTP_MAY_FAIL
@@ -414,8 +433,17 @@ static void bootp_timeout_handler(void)
 		}
 	} else {
 		bootp_timeout *= 2;
-		if (bootp_timeout > 2000)
-			bootp_timeout = 2000;
+		if (bootp_timeout > retransmit_period_max_ms)
+			bootp_timeout = retransmit_period_max_ms;
+
+		/* Randomize by adding bootp_timeout*RAND, where RAND
+		 * is a randomization factor between -0.1..+0.1
+		 */
+		srand(get_ticks() + rand());
+		rand_minus_plus_100 = ((rand() % 200) - 100);
+		bootp_timeout = bootp_timeout +
+				(((int)bootp_timeout * rand_minus_plus_100) / 1000);
+
 		net_set_timeout_handler(bootp_timeout, bootp_timeout_handler);
 		bootp_request();
 	}
@@ -711,10 +739,14 @@ static int bootp_extended(u8 *e)
 
 void bootp_reset(void)
 {
+	char *ep;  /* Environment pointer */
+
 	bootp_num_ids = 0;
 	bootp_try = 0;
 	bootp_start = get_timer(0);
-	bootp_timeout = 250;
+
+	bootp_timeout = env_get_ulong("bootpretransmitperiodinit", 10, RETRANSMIT_PERIOD_INIT_MS);
+
 }
 
 void bootp_request(void)
@@ -726,7 +758,6 @@ void bootp_request(void)
 #ifdef CONFIG_BOOTP_RANDOM_DELAY
 	ulong rand_ms;
 #endif
-	u32 bootp_id;
 	struct in_addr zero_ip;
 	struct in_addr bcast_ip;
 	char *ep;  /* Environment pointer */
@@ -742,6 +773,9 @@ void bootp_request(void)
 	else
 		time_taken_max = TIMEOUT_MS;
 
+	retransmit_period_max_ms = env_get_ulong("bootpretransmitperiodmax", 10,
+						 RETRANSMIT_PERIOD_MAX_MS);
+
 #ifdef CONFIG_BOOTP_RANDOM_DELAY		/* Random BOOTP delay */
 	if (bootp_try == 0)
 		srand_mac();
@@ -801,18 +835,23 @@ void bootp_request(void)
 	extlen = bootp_extended((u8 *)bp->bp_vend);
 #endif
 
-	/*
-	 *	Bootp ID is the lower 4 bytes of our ethernet address
-	 *	plus the current time in ms.
-	 */
-	bootp_id = ((u32)net_ethaddr[2] << 24)
-		| ((u32)net_ethaddr[3] << 16)
-		| ((u32)net_ethaddr[4] << 8)
-		| (u32)net_ethaddr[5];
-	bootp_id += get_timer(0);
-	bootp_id = htonl(bootp_id);
-	bootp_add_id(bootp_id);
-	net_copy_u32(&bp->bp_id, &bootp_id);
+	/* Only generate a new transaction ID for each new BOOTP request */
+	if (bootp_try == 1) {
+		/*
+		 *	Bootp ID is the lower 4 bytes of our ethernet address
+		 *	plus the current time in ms.
+		 */
+		bootp_id = ((u32)net_ethaddr[2] << 24)
+			| ((u32)net_ethaddr[3] << 16)
+			| ((u32)net_ethaddr[4] << 8)
+			| (u32)net_ethaddr[5];
+		bootp_id += get_timer(0);
+		bootp_id = htonl(bootp_id);
+		bootp_add_id(bootp_id);
+		net_copy_u32(&bp->bp_id, &bootp_id);
+	} else {
+		net_copy_u32(&bp->bp_id, &bootp_id);
+	}
 
 	/*
 	 * Calculate proper packet lengths taking into account the
-- 
2.42.0

