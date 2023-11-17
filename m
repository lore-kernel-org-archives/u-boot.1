Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1146C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 21:49:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E785A86F89;
	Fri, 17 Nov 2023 22:49:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="afw4mIVJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A2D886FC9; Fri, 17 Nov 2023 22:49:30 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 31AF286EE2
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 22:49:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id 6C41820B74C3;
 Fri, 17 Nov 2023 13:49:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6C41820B74C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1700257767;
 bh=2Vd1P5yqdiZL5bsQr0Cbw8A5Pd2BipCxM3i/BUTmuGQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=afw4mIVJSeEHthXlvNDrxGDYpZVKGyjAqczPOETjWTFVd0mD5LQFF7IX4x0bNl6YA
 cfmwh9IL9P7Q4pBgLQqcoETZX3v7dVTmscChXS3gVPAabEZOVyIROEMSbdGSCzROwY
 cB/CM3S3hYIuGEhzbkx9NWLOntNb0jh6olRNmqOY=
From: seanedmond@linux.microsoft.com
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de,
	pbrobinson@gmail.com,
	trini@konsulko.com
Subject: [PATCH v4 3/3] net: bootp: add config option BOOTP_RANDOM_XID
Date: Fri, 17 Nov 2023 13:49:25 -0800
Message-ID: <20231117214925.138486-4-seanedmond@linux.microsoft.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117214925.138486-1-seanedmond@linux.microsoft.com>
References: <20231117214925.138486-1-seanedmond@linux.microsoft.com>
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

The new config option BOOTP_RANDOM_XID will randomize the transaction ID
for each new BOOT/DHCPv4 exchange.

Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
---
 cmd/Kconfig |  7 +++++++
 net/bootp.c | 31 +++++++++++++++++--------------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 93bf752035c..244237e6d60 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1853,6 +1853,13 @@ config BOOTP_VCI_STRING
 	default "U-Boot.arm" if ARM
 	default "U-Boot"
 
+config BOOTP_RANDOM_XID
+	bool "Send random transaction ID to BOOTP/DHCP server"
+	depends on CMD_BOOTP && (LIB_RAND || EXYNOS_ACE_SHA || RNG_NPCM)
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

