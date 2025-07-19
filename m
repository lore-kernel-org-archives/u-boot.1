Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94468C83F34
	for <u-boot@archiver.kernel.org>; Sat, 19 Jul 2025 00:58:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 757D583764;
	Sat, 19 Jul 2025 02:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="QO/yy2+h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42C9E83754; Sat, 19 Jul 2025 02:57:51 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 467388365C
 for <u-boot@lists.denx.de>; Sat, 19 Jul 2025 02:57:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2cevrtL6PfTHtZppJgvlCBqnDvivqg4oqQ78mc2LEad7tIDsG0v95Emgpyq4qw+0zVBYvh9GIQPV0OGYIGXvPIFAkE9OBxYc4akJDdPm98oKlpz1WKLwGGS5fOIDAtvDrUye5zVintDwLsDsHqLZpqYT8714IJKEWz9tLMWX3PndLWi82aCmzbySpz0rK1C2SRGyiymidPm5FZg0/fT7pFVB1peLQiFGx3L1u7EuEU9SdedAxTRaTUJXYvTDDMveVWI9fUvRup1SzmmkQwZ/4BuAFOLU/SQvIr4DFQ94cGyv4kUu6PGpgL/S5nM98Rh2zxAuWiF/L1K4YcwMj3CBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOQN4/SiGDOagWtejiqSVfuKv/tUf78YA/4Ge+HqQAI=;
 b=lRqa5KdmbvToXOFnKHQ6RIb9+Udgh3r1ZZQBPJy1klghsRxyEp7Jop5M9Ozjmo2nGXiySmcGSULpjXLBMLq56EbRSCHIT1wMgn5JBYyQYBO2Ol0SRZ7F6ob52Gw7vWmlkgWg6StFFviWHJ4JyFwPq7o6NUoS+a7vT1u9HiRJbcins5F+JqA7A3PMIwFI+lkKShyN/6lDTe0gBm4cXnuiFcptm7gHM8mqZtZ++RpojY2YrWO1st7LngnEe41y42jvvsttPjoa5jYh1z15D2I/G2iDy5BBRh8AsCX3p/Kd/MZPY6G1EY47e42O8JQsvQvY4YDua/0/PNrjsKHGvJfSlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOQN4/SiGDOagWtejiqSVfuKv/tUf78YA/4Ge+HqQAI=;
 b=QO/yy2+hHk9gYsSmjRUNomuZ2gceR96a3GieUf9j2UyWaXGaz9iLpptteM1S7b5EZ/x/u55I4ot3tC1gc38+SRNJp7rey1AJIPEyhjM3fjo1t9cI25lXz7v8PpIDzz7ofkiXd3k5xwBlIcQuA0kS6yw6ImrsZ7gbNEp9y/MyCrt0vX8WJFE26n6v+E/UMdTS6KX0Uoh111UfY8aho251SS8W/1WMeU/2ysFZq5/lQQuufsslnmbraNB93DwSkh/jwYibvO2AFY2v+2IuLcuJVXebuq/oPdVCHzarS0vCaY7eS4ahz1iEIZd/MkCUWQxc7Sz9cbTABcs4aaE/7zxbtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI1PR08MB10218.eurprd08.prod.outlook.com (2603:10a6:800:1be::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.39; Sat, 19 Jul
 2025 00:57:47 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8922.037; Sat, 19 Jul 2025
 00:57:47 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 6/7] drivers/net/airoha_eth: add support for airoha en7523 SoC
 family
Date: Sat, 19 Jul 2025 03:57:16 +0300
Message-ID: <20250719005717.113842-7-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250719005717.113842-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250719005717.113842-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI1PR08MB10218:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cc8e199-145e-4a10-d412-08ddc65f4739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5mN6Xx97lAhrVvnWDI6igjVcr2GwRGGj1OjXb2ugt1H0zv6ndIAmeNA2bo6o?=
 =?us-ascii?Q?+wOzt6MOf5eatZqDvNek+d1IB/cJEJgW+TA2NylSTzxDS/fPIoQsgNwTg7aO?=
 =?us-ascii?Q?fZgLqXaCTVMv7SAnpni9SJ0g7Is3lmYczX7MAwNEFdgMYDtgmmVUqzh8IlOq?=
 =?us-ascii?Q?QmcOJ2rsBkQGc5h7dCc6LiCvDaPbfeGwWpedKgOgm4YNLB0KUSmb5vzxI0KQ?=
 =?us-ascii?Q?G/Q7fJ/bhA2zQgkYvdPbb8t2XLM2zGgQIPLSmK1SDrVCzYIWO7b5w5HWfsIm?=
 =?us-ascii?Q?W45fOQgWm5Pa3BDOtK+x8uJLLE0IErmhCSW7ltuCaK/ZXRZeo+ksOCVLD0Dk?=
 =?us-ascii?Q?JuAn/gc3a2NjdNDiYxgCk47OI0C2c4nkwsD3SPHaWoYisWcMLCj6wS68tiuf?=
 =?us-ascii?Q?ktJTwf+ruZku2Ua8Mx3rClDf+8xPktDjpOsM0ABKGVkocXIKKoiSh8AUAL+b?=
 =?us-ascii?Q?kStIGKGBSWui3YmWbFMdEylGfqEZz+mvPZbuUiUBpWzscFR/MUIr5mHRwAmF?=
 =?us-ascii?Q?nrNWmSoEUw96fhKgYegyAoC45Igo8NYl7Wghl2Ggx1A+hc7YSO/1SskkRu5V?=
 =?us-ascii?Q?TkR4OuCV4EceB0jok4SMayp1IVqfgGA54cK/apKRWUdtERmYMswzCVdawzXz?=
 =?us-ascii?Q?YV0S8CYoBYq0SlXkYqklNuCcBmo09F9eaB5sHpVqhvA72nTpGhYhHAfHcbiQ?=
 =?us-ascii?Q?OLB+MznsxViDcyDAKdUID+KSM4mihimr+PVwua4Q8sgNKw6m3BhF76wsPTZ7?=
 =?us-ascii?Q?428flPwAl8BNLtRcHzqAzabNROapAEdl50nb6ksvbRa71x02DrSWE8fFJFfF?=
 =?us-ascii?Q?t2J3Oa5NSs2Wbwmcfcs/IvQ8gowMKgpOltTsJsY0coGYhzrXb4PL0E+oo3mf?=
 =?us-ascii?Q?SrkYvJb0gPMjQTQpjRAOvg5IRF5J67Pq6uNey3KDft8Stguw26Q+OiS7ZKI+?=
 =?us-ascii?Q?C4rNb3RNhTqYxvfxFpn/g18oEGESDZGigx9ev+Kz+mdqdsvoji8Vo/zuxG/X?=
 =?us-ascii?Q?ZnAhcBa0Nn35zzPmx2WrAlBJ7WWDxFIr/RtjQScIjQsVLCznlrhyl4eHnaJE?=
 =?us-ascii?Q?+eLmPcKhZ3itpDjv5Zku+PasyyanV6oNC3B7G0GDBq6dT6oP4aIb43lxtA83?=
 =?us-ascii?Q?OKa/wSsUwPUFxPy+BhtZJOtH2bvKWjzjsBdOl+gRcxKQr0rfGq4/vOm1jgax?=
 =?us-ascii?Q?qyxNd2stjV4T0Q50AapTePcIBXH1eaevW6AtSK3ZngEjml4xQC2tYdFrKQOw?=
 =?us-ascii?Q?hHl5xuM5rxzfWE8nj3WqmDNAfhXrUWjRzwas1R4YMUQHaSiQJrp1DUbQrykz?=
 =?us-ascii?Q?1J3oGPVwRRDgrAY9VfvNhHqQgDqTPt/ArjpmEK2PGFqqH1QnvvwUC2dMVGO7?=
 =?us-ascii?Q?/ler0UIcri57Lszs/23IZ+f4kTD/kQxDQzBG4RWvc2gPhpyILTBoDpYnOoJm?=
 =?us-ascii?Q?xHVtF9oWGioMl/NPTsKCocPPWqytT7fauTbUijcGSsg8fXQoViS16fr5bnho?=
 =?us-ascii?Q?Xer+QH8NJLuA6p4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ohN8D/nHS01pN5Ui6p2HUj4RnBZZkutq6LQ+pC4QerPryrlNxNVLtDsAVjJJ?=
 =?us-ascii?Q?zNSJCeNBjANGemBepUamc85n5iDGz5wKdwWAWN2Y+q68jsFaB/zoioHBSIVJ?=
 =?us-ascii?Q?3DVzeVIL0/Pd7YS5XT1/JJN6Xl6u0l+kWczop7vacbMOQaVlUx6tf13gv+wH?=
 =?us-ascii?Q?ll4CBy/BLwD2tQPyANQqGt9xzqPIBqotcnCF0HITBGgZKxzFYo3fvvN51zPW?=
 =?us-ascii?Q?LfB4jXLLnErchRv3gwtbNMqv75XetJPJMTQJ0qxMYuuzP4q6e9AuQfuEdABJ?=
 =?us-ascii?Q?6HdEs0cePdw76+UWIY8uNOvDjDUm94CH+R5JwEfAUvzIan14gM8nYZyBGzcu?=
 =?us-ascii?Q?owDpRmcdGBxH0ty/JjCO+mV2UTebXNgb+Ka8k8GuoTAnHWEzzhqYoZXdP/g1?=
 =?us-ascii?Q?/7LZg1bD2zl/yC67sxTX7S95nM75CgxMiNZyF1HEk5b4M/G7tB9bZCho+pFX?=
 =?us-ascii?Q?1lP82wLztfDYKK3L6auY2qAB0oDlenVojpRDYbAHEEN0uhcSpqSFDLN1wpcv?=
 =?us-ascii?Q?+Qgt8708rLkyNOGeaso+gO9h1UPGAVHm7ERyLIjvcCuWaBPF1boDMlKfDmu+?=
 =?us-ascii?Q?gi71I5MCZaoGpvQ4/YA5I1qgnmAWEf9tewzvWJSDj9xh9vN/AAG10eoCK2KI?=
 =?us-ascii?Q?YubACqiwNp9sH/+2FCiG6XO4M2K431l5TMst3UNyrTFGa2u0d8meJqplZDA4?=
 =?us-ascii?Q?MdeRqdeFVNHnSkefiKVns5GcfAlRp0LpZZqK0ws8qM9hz3gzcUeL6sGHud6p?=
 =?us-ascii?Q?/RiuVlaO7vp63JVD3Q0N/XbJBRFnTNuKmusWCqhAaGIa2Mkv4jahKWI1eI2l?=
 =?us-ascii?Q?xUU77femIJl7kyDATODDlYj0zCGZp2rUkaJXIf/wLp3brBrOPu+YpJkloMQZ?=
 =?us-ascii?Q?n6gFertVu9V3+rfOYYmPzovA01p5vgP9MX1P+xhC9TV8qnxYS9WPmxhSCfBV?=
 =?us-ascii?Q?Y1gLyGc3iygxlfzqLjjEVZZU8WH2ZE4FW9k/iFakjo2GyNGva6mqYFd5x1F7?=
 =?us-ascii?Q?rpW7M9BIVBrFN5+UCBc6M4wm6oURtqzHv7tlXVkT0GOslFmu0ylM+GRXQXXv?=
 =?us-ascii?Q?HTmDxr3w9YjcKPbpOEIDeLtkUYm/VYZGWMJLRumXCM3c2x6CI30yAZ+rWx69?=
 =?us-ascii?Q?/yow2UmU/FPgxIeoj3bmRM9ftv3w6yBhOVkp94yA/Qsz52CKzqiHXggYCBWv?=
 =?us-ascii?Q?j04DF/Vr9saF8QmpH0WA+6MihQl95TWxzhMZOD6W+05FhLPjV7HZ9e1DiSmr?=
 =?us-ascii?Q?/QygveNAF4gVGMTVtigU+p54aFxoJJpSoVc0CHE2kdcWVBEfHwcQpHztmAxM?=
 =?us-ascii?Q?gM16MyzbDCi/ShnekTPHy45qq4ZV+HBVhFFJPcoBCezlCOETpGPGxLjofGGd?=
 =?us-ascii?Q?GOAJr6pqTOg5vP+CNSdBrJbnVCh9nkEodD29aekfJ+v36AJyILnrZlJrBdH5?=
 =?us-ascii?Q?BM4oSEfZYj5eWwSIULUr2qDIO0dUYcO5nSCSqKxYR0ojZa7/wLitBUHos146?=
 =?us-ascii?Q?jktDi56CIaSEXRWFLJ4c2TNkmgoxE92VOqWmMEvDOu7aVD8rXhLuDiA4A8lA?=
 =?us-ascii?Q?bvo993L2stQvlW+R5VFAmQwYmv4ldMeyHk6vxFdlS+04NltQSJ/JLfYspr9D?=
 =?us-ascii?Q?Up/Tf3owSJuEa5xzmrsW56s=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc8e199-145e-4a10-d412-08ddc65f4739
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2025 00:57:47.8253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7+ZdIDCQmXm4ye6NBYzOXaMfYYVW/8UwUGBUoHSiHrk/VseZIre17y30t+he6TNuS46K8K4hJbGvsZ+0DHtehumI0nNflyjAYzKrlFdHa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10218
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

This patch adds support for en7523/en7529/en7562 ethernet devices

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha_eth.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index 6588eb3a806..bcbbd94d31a 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -22,10 +22,22 @@
 #include <linux/iopoll.h>
 #include <linux/time.h>
 
+#if defined(CONFIG_TARGET_EN7523)
+#define SWITCH_OFNODE	"airoha,en7523-switch"
+#define SCU_OFNODE	"airoha,en7523-scu"
+#elif defined(CONFIG_TARGET_AN7581)
+#define SWITCH_OFNODE	"airoha,en7581-switch"
+#define SCU_OFNODE	"airoha,en7581-scu"
+#endif
+
 #define AIROHA_MAX_NUM_GDM_PORTS	1
 #define AIROHA_MAX_NUM_QDMA		1
 #define AIROHA_MAX_NUM_RSTS		3
+#if defined(CONFIG_TARGET_EN7523)
+#define AIROHA_MAX_NUM_XSI_RSTS		3
+#elif defined(CONFIG_TARGET_AN7581)
 #define AIROHA_MAX_NUM_XSI_RSTS		4
+#endif
 
 #define AIROHA_MAX_PACKET_SIZE		2048
 #define AIROHA_NUM_TX_RING		1
@@ -685,7 +697,7 @@ static int airoha_switch_init(struct udevice *dev, struct airoha_eth *eth)
 	ofnode switch_node;
 	fdt_addr_t addr;
 
-	switch_node = ofnode_by_compatible(ofnode_null(), "airoha,en7581-switch");
+	switch_node = ofnode_by_compatible(ofnode_null(), SWITCH_OFNODE);
 	if (!ofnode_valid(switch_node))
 		return -EINVAL;
 
@@ -727,7 +739,7 @@ static int airoha_eth_probe(struct udevice *dev)
 	ofnode scu_node;
 	int ret;
 
-	scu_node = ofnode_by_compatible(ofnode_null(), "airoha,en7581-scu");
+	scu_node = ofnode_by_compatible(ofnode_null(), SCU_OFNODE);
 	if (!ofnode_valid(scu_node))
 		return -EINVAL;
 
@@ -781,9 +793,11 @@ static int airoha_eth_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+#if !defined(CONFIG_TARGET_EN7523)
 	ret = reset_get_by_name(dev, "xfp-mac", &eth->xsi_rsts.resets[3]);
 	if (ret)
 		return ret;
+#endif
 
 	ret = airoha_hw_init(dev, eth);
 	if (ret)
@@ -972,7 +986,11 @@ static int arht_eth_write_hwaddr(struct udevice *dev)
 }
 
 static const struct udevice_id airoha_eth_ids[] = {
+#if defined(CONFIG_TARGET_EN7523)
+	{ .compatible = "airoha,en7523-eth" },
+#elif defined(CONFIG_TARGET_AN7581)
 	{ .compatible = "airoha,en7581-eth" },
+#endif
 	{ }
 };
 
-- 
2.47.2

