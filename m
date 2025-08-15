Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60453CA0ED1
	for <u-boot@archiver.kernel.org>; Fri, 15 Aug 2025 16:07:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8F5583AA1;
	Fri, 15 Aug 2025 18:06:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="QQQ5zKe0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC9CC83AB4; Fri, 15 Aug 2025 18:06:57 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20705.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::705])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A94C583A9A
 for <u-boot@lists.denx.de>; Fri, 15 Aug 2025 18:06:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+Tjnwi3c09EBVJCTHsaGmOEfkBo//0/ZQeh/KXj8AtPEtfwf3rKZ0SJpCGcZox6JpFI1wrJOfOwkBEWuOVadcUmmKUmIvsXNcf0u5jnwsupm511KcMjcHY7ITUdrdPvKTyUtVpzWCl4p2pc5yMnGmyY0y6FUmmnAYOfqX00Uok6brH8wcM8ZthlkPkogIabvpDli3+lIhyuJwgFGD1R/coYa7IKDFTU0uV3E64BUkcCy+GZR2WNrXKMIpyDC5eya0gn21TXMoY5B94X9o5EJYmsiPWgmF90TRT5C5cLqZrEl9IMOI1CgLnFqJKcZGKFGc6nwZJt68qPadzII6df+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIAUtqZYduyZswGrc4TT32EcDhZPXFLJPWBXFPoNK8I=;
 b=BFVAFeFjCH4++/dV7bki4Np4IdiFKHXr4rMRMqrYAWu9LxmrzMTXjgaOvAWQ2QjA/YH3NwNUGfmqiQebHrEIUhKvVvz4imxRa+08atbDAgNoATlO2X25tI5xyPu7n+E7SLcwfuo4EZlg+hOlveTuTMGYYm0y1eHuGraBdepRRqKSNgwgxb9d6PidUmDbnB+9d0a/FjJdKWkN9NS0ZYg0qdfpKK6vUqDyk7wFMaEHEPIsp6ho4YtJxDAPI9/wEFVma3wiihmzyYCzRzi6aGnlCKk5Yk7vlg8J8I+jy1HQNfj/n1VA57SNaGsTjKuxTq20KtRbeSKP4QRQHXkhfQFTXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIAUtqZYduyZswGrc4TT32EcDhZPXFLJPWBXFPoNK8I=;
 b=QQQ5zKe0vXwWtPpeoBaKpBt2FGwP21v5Y47wZC3Y3FP/RG7yeUgLd3ragU7cx66rQZKFHuJnSiKzR273IBmSrWK0OTIn3bgx9GGwUo9NEhdEJR7MR8xnRJ9OITeHQTBs5qpSI7tFsKOf3PTzAcFgYDtwy9MgiDgNLrJCUhwNKbWLTUFqMmDQbGGBjnMe8T47El54T9J50lEz8NE/qKpHABPTMP7xacghbs+uWUQBPpld5mSuP14aMLESXciAvsO1PXuw/j9rJpBFVEJVfa69t0MXO5b6vHk2EsLGDPG/6/phRNyy9hb/qmk5IbP+I/DcdENV+HukVlWyjwtNsS93Bw==
Received: from DB8P191CA0026.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::36)
 by AMBP195MB2791.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:6a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Fri, 15 Aug
 2025 16:06:53 +0000
Received: from DB3PEPF0000885C.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::44) by DB8P191CA0026.outlook.office365.com
 (2603:10a6:10:130::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 16:06:53 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB3PEPF0000885C.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 15 Aug 2025 16:06:53 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 15 Aug
 2025 18:06:52 +0200
Received: from ls-radium.phytec (172.25.39.17) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 15 Aug
 2025 18:06:50 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <trini@konsulko.com>, <holger.brunck@hitachienergy.com>,
 <hs@nabladev.com>, <sjg@chromium.org>, <jh80.chung@samsung.com>,
 <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH] cmd: Remove default prompt from output
Date: Fri, 15 Aug 2025 09:06:35 -0700
Message-ID: <20250815160635.3575367-1-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885C:EE_|AMBP195MB2791:EE_
X-MS-Office365-Filtering-Correlation-Id: 327163a8-9760-4875-ded1-08dddc15c00b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qxjh/GiJW6Td2qN8vVjeL8HdQpohO0lO9O2v55fJsPgY40R6IY/9sAgotyS+?=
 =?us-ascii?Q?DhQ5ljfArbozhqiz1XTs9SwPBv46u7SYCm7PmkRTtAo5uFBXen0mjpPh/qqY?=
 =?us-ascii?Q?l3zpDpT7mHgNDJWqrkoLSqcSC+60EmmNNcgZf9wbrik1SJyWOnxRGi/YA7FZ?=
 =?us-ascii?Q?jBb9m4zon9wvOK6LyBDWZ9KDtNszTQvepZwAGGykP82RyUpwWegAKY66PIsW?=
 =?us-ascii?Q?rgaadQIdOJAnMPXbjq5rQPe/6zjzVmhHfsafV5TLq3rdc1PbtZpdHITEf9JM?=
 =?us-ascii?Q?g3dC8Qa1zHKv4TY/iO5/Yllgmu77HQy53fN4NdnxbrscFeHfX3appM89aD3E?=
 =?us-ascii?Q?daP1icyKwWBUw9/SWygdgrAR7kDjvyiyxL8ugZhLapidV5R3eFlcxttJlrQk?=
 =?us-ascii?Q?mt5s041cwIEnzdWxICJc4JNkEFCXdsbfHnc9DdajK1pGKxhi075fc/iB2lvb?=
 =?us-ascii?Q?7X0ullyr5GEhbUGl1oGyDvUUwjwt8OTjAneWhYXOu/06yVUpR0CBbf07cHfJ?=
 =?us-ascii?Q?0SNuXOZTmjgD06uXGO3gbMegL2RbMsa11XeF2rUYt7S+ygXljm/OBvX8vcHp?=
 =?us-ascii?Q?+EakDTcpvv+1H/TSpo/Hc9DLAntSee2j/7Yql9wWPov4Lhxnykeq91YsZlUI?=
 =?us-ascii?Q?tNMMv4RoarQD3DmGRn4ZGL2usMowhr9mDiRaHOuYD9sIrVflWdYPeI/BraSv?=
 =?us-ascii?Q?zZtaHPp5LKtS7D2NdZJrFRM8f1ULDmm2HCDIzg6VcFVWM8/y+aCF+k54Sgek?=
 =?us-ascii?Q?KKs0WvQ256dvLr7zSd84RUMuUbOHssOzkaheGz2U/yXujzfYYRZWUqLzHswy?=
 =?us-ascii?Q?L6tQzlbif2AVSmpS+1McZYKFVXg61yJQBRuoq/BZ81FlCOgmq3JQaG0Ly0M0?=
 =?us-ascii?Q?SiX7U1FwnBx44D+vDS5VnLSPEheNYAAUvZZ93EczlFMuywiMEE16te2BJrxv?=
 =?us-ascii?Q?Z4iFmRfaIdUDyRdNVLOsRPE2NAenzGOmiLJvqw6k4rv6ZHLTBCNp2pWXehPS?=
 =?us-ascii?Q?+BKpjyQoHbmwSj1OM2n1oceYDx+UdN90luIhDOvbN2nVCZalMiX8Iq86NLHV?=
 =?us-ascii?Q?efdE9wZNHl/Cvxuorjc6E+p91AJHdzlF+QMuYSSx/nhon5KhUW5XC1iq2Kdy?=
 =?us-ascii?Q?p3DETjfdPJXxIttEJECUDnR9FcMHtQFAICqxAaA2T1ydUTDi+4UgLnliFPaN?=
 =?us-ascii?Q?2uM9N1ZqVb5vr6j2nVi0bF4DN0UMc7BluQ2yojp99ukAhYz+EFOCqOgnstve?=
 =?us-ascii?Q?gYFcrCA4dViNXv9ON+nyjHWZmLD1386IfWWQZjPyxDbNBs8OEDm2T7zNStYp?=
 =?us-ascii?Q?JJ/qqQHU2xMcJlkpAgZUO7F8ROM56/TnvmYVBZUa9XDjQbrY6gblZxt0mcBm?=
 =?us-ascii?Q?JdJ6wuQ80wEeBANW7pUd+YIiFSR/PBXSne19ghUCRPqqaLfBnI1o/93/SrT1?=
 =?us-ascii?Q?XTwR+4a0ZC92qrXxYHAmN/l8XpvNxATjLKnkJig78Xjbg0eQj9W7z9Vj0nNo?=
 =?us-ascii?Q?x1tdYv99ICOZqSx6Ec9vVyuUwItfO4DcUqhE?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 16:06:53.0099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 327163a8-9760-4875-ded1-08dddc15c00b
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBP195MB2791
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

Some commands include the U-Boot prompt (=>) in their output,
which can interfere with tools like labgrid that rely on prompt
detection to determine when a command has completed. This may cause
such tools to misinterpret partial output.

To avoid this issue, it's better to update the command output itself
rather than modifying the actual U-Boot prompt. Changing the prompt
is not acceptable in many cases, as some boards have used the default
prompt (=>) for years, and altering it - especially just for testing -
could lead to inconsistencies or unintended side effects.
Instead, replace instances of the prompt that appear within command
output (not the real prompt) with an alternative like -> to ensure
correct parsing by tools that rely on prompt recognition.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 cmd/i2c.c      |  2 +-
 cmd/mtdparts.c | 12 ++++++------
 common/hash.c  |  6 +++---
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/cmd/i2c.c b/cmd/i2c.c
index e021067e68a..f7695047629 100644
--- a/cmd/i2c.c
+++ b/cmd/i2c.c
@@ -715,7 +715,7 @@ static int do_i2c_crc(struct cmd_tbl *cmdtp, int flag, int argc,
 	 */
 	count = hextoul(argv[3], NULL);
 
-	printf ("CRC32 for %08lx ... %08lx ==> ", addr, addr + count - 1);
+	printf("CRC32 for %08lx ... %08lx --> ", addr, addr + count - 1);
 	/*
 	 * CRC a byte at a time.  This is going to be slooow, but hey, the
 	 * memories are small and slow too so hopefully nobody notices.
diff --git a/cmd/mtdparts.c b/cmd/mtdparts.c
index 571b79f091d..48d06f2e000 100644
--- a/cmd/mtdparts.c
+++ b/cmd/mtdparts.c
@@ -242,7 +242,7 @@ static void index_partitions(void)
 			if (dev == current_mtd_dev) {
 				mtddevnum += current_mtd_partnum;
 				env_set_ulong("mtddevnum", mtddevnum);
-				debug("=> mtddevnum %d,\n", mtddevnum);
+				debug("-> mtddevnum %d,\n", mtddevnum);
 				break;
 			}
 			mtddevnum += dev->num_parts;
@@ -252,17 +252,17 @@ static void index_partitions(void)
 		if (part) {
 			env_set("mtddevname", part->name);
 
-			debug("=> mtddevname %s\n", part->name);
+			debug("-> mtddevname %s\n", part->name);
 		} else {
 			env_set("mtddevname", NULL);
 
-			debug("=> mtddevname NULL\n");
+			debug("-> mtddevname NULL\n");
 		}
 	} else {
 		env_set("mtddevnum", NULL);
 		env_set("mtddevname", NULL);
 
-		debug("=> mtddevnum NULL\n=> mtddevname NULL\n");
+		debug("-> mtddevnum NULL\n-> mtddevname NULL\n");
 	}
 }
 
@@ -282,12 +282,12 @@ static void current_save(void)
 		env_set("partition", buf);
 		strncpy(last_partition, buf, 16);
 
-		debug("=> partition %s\n", buf);
+		debug("-> partition %s\n", buf);
 	} else {
 		env_set("partition", NULL);
 		last_partition[0] = '\0';
 
-		debug("=> partition NULL\n");
+		debug("-> partition NULL\n");
 	}
 	index_partitions();
 }
diff --git a/common/hash.c b/common/hash.c
index 0c45992d5c7..07a4df963ad 100644
--- a/common/hash.c
+++ b/common/hash.c
@@ -535,7 +535,7 @@ static void hash_show(struct hash_algo *algo, ulong addr, ulong len, uint8_t *ou
 {
 	int i;
 
-	printf("%s for %08lx ... %08lx ==> ", algo->name, addr, addr + len - 1);
+	printf("%s for %08lx ... %08lx --> ", algo->name, addr, addr + len - 1);
 	for (i = 0; i < algo->digest_size; i++)
 		printf("%02x", output[i]);
 }
@@ -621,8 +621,8 @@ int hash_command(const char *algo_name, int flags, struct cmd_tbl *cmdtp,
 
 		crc = crc32_wd(0, (const uchar *)addr, len, CHUNKSZ_CRC32);
 
-		printf("CRC32 for %08lx ... %08lx ==> %08lx\n",
-				addr, addr + len - 1, crc);
+		printf("CRC32 for %08lx ... %08lx --> %08lx\n",
+		       addr, addr + len - 1, crc);
 
 		if (argc >= 3) {
 			ptr = (ulong *)hextoul(argv[0], NULL);
-- 
2.25.1

