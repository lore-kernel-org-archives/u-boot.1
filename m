Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73D4C4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 18:35:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFAF188951;
	Mon, 29 Apr 2024 20:35:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98DB7888BD; Mon, 29 Apr 2024 20:35:18 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id BB49E87EBD
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 20:35:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=microsoft.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=seanedmond@microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id D7044210FBA5;
 Mon, 29 Apr 2024 11:35:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D7044210FBA5
From: Sean Edmond <seanedmond@microsoft.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, Sean Edmond <seanedmond@microsoft.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Charles Hardin <ckhardin@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Anderson <sean.anderson@seco.com>,
 Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v6 2/3] net: bootp: BOOTP/DHCPv4 retransmission improvements
Date: Mon, 29 Apr 2024 11:33:57 -0700
Message-ID: <20240429183449.2284935-3-seanedmond@microsoft.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240429183449.2284935-1-seanedmond@microsoft.com>
References: <20240429183449.2284935-1-seanedmond@microsoft.com>
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

Changes in v7:
- Remove "depends on LIB_RAND || LIB_HW_RAND" from CMD_BOOTP
- Add CMD_BOOTP/CMD_DHCP/CMD_DHCP6 to LIB_RAND menu choice
- Add space after "config CMD_DHCP"

Changes in v6:
- CMD_BOOTP should "depends on LIB_RAND || LIB_HW_RAND"

Changes in v4:
- Add "select LIB_RAND" for "config CMD_BOOTP" (retransmission
  improvements require rand())

Changes in v3:
- Set RETRANSMIT_PERIOD_MAX_MS=60000
- Add randomization factor to retransmission timeout

Changes in v2:
- use env_get_ulong() to get environment variables

 lib/Kconfig |  3 ++-
 net/bootp.c | 71 +++++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 57 insertions(+), 17 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 189e6eb31aa..9b62b3bbea7 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -265,7 +265,8 @@ config REGEX
 choice
 	prompt "Pseudo-random library support type"
 	depends on NET_RANDOM_ETHADDR || RANDOM_UUID || CMD_UUID || \
-		   RNG_SANDBOX || UT_LIB && AES || FAT_WRITE
+		   RNG_SANDBOX || UT_LIB && AES || FAT_WRITE || CMD_BOOTP || \
+		   CMD_DHCP || CMD_DHCP6
 	default LIB_RAND
 	help
 	  Select the library to provide pseudo-random number generator
diff --git a/net/bootp.c b/net/bootp.c
index b9e3cccb4f9..0109446dd6f 100644
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

