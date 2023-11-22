Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3168C61D99
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 23:34:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEA45876AA;
	Thu, 23 Nov 2023 00:31:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEDFB8766D; Thu, 23 Nov 2023 00:29:32 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 0B13587653
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 00:29:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=microsoft.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=seanedmond@microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id 431BA20B74C2;
 Wed, 22 Nov 2023 15:29:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 431BA20B74C2
From: Sean Edmond <seanedmond@microsoft.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, Sean Edmond <seanedmond@microsoft.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Michal Simek <michal.simek@amd.com>, Ramon Fried <rfried.dev@gmail.com>,
 Roger Knecht <rknecht@pm.me>, Simon Glass <sjg@chromium.org>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH v6 3/3] net: bootp: add config option BOOTP_RANDOM_XID
Date: Wed, 22 Nov 2023 15:27:46 -0800
Message-ID: <20231122232812.823837-4-seanedmond@microsoft.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122232812.823837-1-seanedmond@microsoft.com>
References: <20231122232812.823837-1-seanedmond@microsoft.com>
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

The new config option BOOTP_RANDOM_XID will randomize the transaction ID
for each new BOOT/DHCPv4 exchange.

Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
Reviewed-by: Tom Rini <trini@konsulko.com>

---

(no changes since v5)

Changes in v5:
- fix depends for BOOTP_RANDOM_XID:
  "depends on CMD_BOOTP && (LIB_RAND || LIB_HW_RAND)"

Changes in v3:
- Add depends for BOOTP_RANDOM_XID

 cmd/Kconfig |  7 +++++++
 net/bootp.c | 31 +++++++++++++++++--------------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 6b7c5e6d521..8204f72f6ac 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1853,6 +1853,13 @@ config BOOTP_VCI_STRING
 	default "U-Boot.arm" if ARM
 	default "U-Boot"
 
+config BOOTP_RANDOM_XID
+	bool "Send random transaction ID to BOOTP/DHCP server"
+	depends on CMD_BOOTP && (LIB_RAND || LIB_HW_RAND)
+	help
+	  Selecting this will allow for a random transaction ID to get
+	  selected for each BOOTP/DHCPv4 exchange.
+
 if CMD_DHCP6
 
 config DHCP6_PXE_CLIENTARCH
diff --git a/net/bootp.c b/net/bootp.c
index 89425717328..49cd9064436 100644
--- a/net/bootp.c
+++ b/net/bootp.c
@@ -837,22 +837,25 @@ void bootp_request(void)
 
 	/* Only generate a new transaction ID for each new BOOTP request */
 	if (bootp_try == 1) {
-		/*
-		 *	Bootp ID is the lower 4 bytes of our ethernet address
-		 *	plus the current time in ms.
-		 */
-		bootp_id = ((u32)net_ethaddr[2] << 24)
-			| ((u32)net_ethaddr[3] << 16)
-			| ((u32)net_ethaddr[4] << 8)
-			| (u32)net_ethaddr[5];
-		bootp_id += get_timer(0);
-		bootp_id = htonl(bootp_id);
-		bootp_add_id(bootp_id);
-		net_copy_u32(&bp->bp_id, &bootp_id);
-	} else {
-		net_copy_u32(&bp->bp_id, &bootp_id);
+		if (IS_ENABLED(CONFIG_BOOTP_RANDOM_XID)) {
+			srand(get_ticks() + rand());
+			bootp_id = rand();
+		} else {
+			/*
+			 *	Bootp ID is the lower 4 bytes of our ethernet address
+			 *	plus the current time in ms.
+			 */
+			bootp_id = ((u32)net_ethaddr[2] << 24)
+				| ((u32)net_ethaddr[3] << 16)
+				| ((u32)net_ethaddr[4] << 8)
+				| (u32)net_ethaddr[5];
+			bootp_id += get_timer(0);
+			bootp_id = htonl(bootp_id);
+		}
 	}
 
+	bootp_add_id(bootp_id);
+	net_copy_u32(&bp->bp_id, &bootp_id);
 	/*
 	 * Calculate proper packet lengths taking into account the
 	 * variable size of the options field
-- 
2.42.0

