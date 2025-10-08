Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6697CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 07:09:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F05A88394E;
	Wed,  8 Oct 2025 09:09:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="lkgKdYq9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1BAF839AF; Wed,  8 Oct 2025 09:09:17 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74FB883981
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 09:09:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tf+e7p0QHBHZbIu1uTDXTIaNjiFoejSLhBSYor0moSGQs90vCvgNng8nl0+bYCXe/uEK3o/lk8t4yDIKLtxo1c0KD6LDJL23RQdRhQSFVIK/wWLpbhDz186KLUyI4OHKim7tZgnbPr796NFHwP6bGvcIyCOUi6hwlSHQE/X6HgGZsLJDslGuTWuciyoJAWN/H0/hwZKPrPRW0oWR7FfIYlhiLGUW5vjKNIUGHKbCqnIX3NDpD5Ff6Zc14t+J86jei9tqs0IvBbRR/dLJhynK9bUrn+oVVCj5wslAgoQANEGHMG8d8ReD4nDg+9Th4oBmxWduIWE9xh6G90/6zdoIsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Spucv5B8KXO/yiEWdTaA/TX/KD3NspWjz6wFA27erKQ=;
 b=AFbEQBIlW5ZmAbvo0Mf3grkEnRs4YeBTINqaDa/tBqkW3pcGKtjNXO0A/McD4mNu44gASKORtSTHeA1hdmI5fu7ESd1kdjIgkrE5pNuu8qMRqWiZS4Cy+V4k+U4ER+rfc5yGPw8igpOZCdV717Hi0DdvnbSm5b/L3swVlq/RaB8IznuEVbvXnBfdcncN1doMk84CnNkeBiEJHSjwjCG9ES1lGNSzwMX2/BAEsuUkx7IKtjO096mM9FF6K58ZvhE8rUpxEFvLg5oAQ0duwgXV357h7un+8sN3VvBSYLtyon93QfUpDDY6qblDLQJDzmea0DLA4HxpbjKKmdZRu/SWlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Spucv5B8KXO/yiEWdTaA/TX/KD3NspWjz6wFA27erKQ=;
 b=lkgKdYq9ffqSAHxAI2ApfXysej+znbMwFvJHtkhT2iXIiFOtOS5fHQXgyF9U5kKA3n0kCrepN2X9qWVhptiEiZXoeSu1yMzYg7bKqANj21V1QIAzQvAAHKsXgSMsHyxiXXzEGQGCP4SrDaDavqqh+H6ARfGOFMuf2gB/EveSX+T6SOvLo9Hz7Dslp9de2baHgiLRroUmGOvbgXy3jvpGo62Sc2M5zlg39aAIvoqcOJ9UjWFw6P2X6Ww4+9AQ5JXILHp4LEyrBYstTpLl5qDVYS41K3qsaybPRT79SkRKC2WNOHji4gLux88h0sXsyH1WclWemygwE+OPEj9O1EEz8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7638.eurprd08.prod.outlook.com (2603:10a6:10:31f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 07:09:13 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 07:09:13 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 1/2] arm/airoha: an7581 ignores CFG_MAX_MEM_MAPPED value
Date: Wed,  8 Oct 2025 10:09:02 +0300
Message-ID: <20251008070903.370974-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008070903.370974-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251008070903.370974-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002BC0.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: 114064f8-2ae3-43d1-bb07-08de063995d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?B3PV7OvICtHN/TxrqYPmzM8zvnjx6gwPu13SFYFWfJUkX1J+94ILXUR7aaox?=
 =?us-ascii?Q?QUs3Aszs515dSvUXSSG/pYoE7DyArDlmJD9ibKf+/tyaQhDslZZTBBpsaV2c?=
 =?us-ascii?Q?2elN/UnCrGPIYJtde5bDfogLa4OZWwrW4/j+oj/39Oaqu98l75y+fwbnlVtj?=
 =?us-ascii?Q?eVhlsuu9ZoNFZuuQVGJUWAGO/GpcX2Z6rUv2SBjuxZ1oFk3ZP3LKvm2QFAmV?=
 =?us-ascii?Q?ocQma4jQYstxvhIlh5OYzvw9lpLuM54mW2IGUVlJnXHrqBBt7O7n4XBPnpwb?=
 =?us-ascii?Q?bRdsTBmOQJXPsWZMGUtzWZ6M7KqSBH1kK13AyLo5OQyfn8LLDpu00CuvNLzH?=
 =?us-ascii?Q?uYY8m9RvNptGoOc3t844pZAc+sLwxQnEFQxaFUOEtV92Xl2M0/IXAP1vbbgV?=
 =?us-ascii?Q?KoTmK7acfQzCClhx6S8IXcjwcj8rLjhgg7LYfTqH45OaPASEtTrHQqR1shG5?=
 =?us-ascii?Q?shePVp33mfbT4t7jlX9b/YTTvvpF87DS2Q7KGSUeCeSo4cjYJiLtfhq6V+7T?=
 =?us-ascii?Q?qr+eZGlsFjHdrX8E6ziW3RW8ksvMEMfdjqxp0Ou0bHOZUdlFGnjcS+wnh61b?=
 =?us-ascii?Q?96/3LfwPVmrclhswysXv/D27djqBFSE6VWYXgxeohrTHy2tacFVOrzXHn6Li?=
 =?us-ascii?Q?9WGOsfJFcTmSizRinZ1MuTJ+jtDmly5SUiQ9mz4Ij4UeWvrnzw/4D8meChcA?=
 =?us-ascii?Q?EF7oJVVV5+UzKEVvh6PBBbCehpWx4ZqxVsTlFQ3z4cyRvFXe+Vn1w8cEfzm9?=
 =?us-ascii?Q?Vu9C9InGjjPl/Bb8R0qU3+mnNh3fcqTqugAqer3FD7hfN0Ehr6+FHziIKCNf?=
 =?us-ascii?Q?h39AuqOl+Gq92b5tiPoqQD4CwoUPZvO0eOy4fRChs9ihk7b63X+LW32YCo9n?=
 =?us-ascii?Q?4QWtVhQEPafnVkHwjb5X5QkPm4nhEnIzrg6XLz4grSIVuUrW3D7fHLAjwlZs?=
 =?us-ascii?Q?FkacRaXsCRtkePZiSmI+ME1qlnpl6qEMFNrpz2vqo+ucf4DIxzbjGdsCA2GU?=
 =?us-ascii?Q?FJYHV7x4CbPDulEtC4rEpVf0Aq9v+19ce9AuAEQX3epsCknrqrBqtp+91L6j?=
 =?us-ascii?Q?DyOrG0Ir1zmk8sz6+hBYOdrCFj2Qi1B1ChGhBTX/kaPmDnBIFK2eNBZrjeZ6?=
 =?us-ascii?Q?yYJDrKDxSM5On2o60TvQa92B4XOIEmsQa9EzBZW/qt4oM5OsGOmuQt2fHYj5?=
 =?us-ascii?Q?+QZn8s2JdEX4VBegMeAsnHIdxG8IatfDhm8QEFF20CbSqJ4yHGkyQqBQZOxf?=
 =?us-ascii?Q?w3CwqbSixx9GoCQCMVsBaRzrcxhB/EwT9gx5rS9Te6BdhR/7fkxz2KTbutTq?=
 =?us-ascii?Q?3yU2U2ZI4eW9O7bVANwsnOBsa2UHOPazYcovzdNnkIdWGxIP0nZeFujqmeol?=
 =?us-ascii?Q?Ep3gzlERvM0H7LE1eU4g7vb5VlnMZgl23HFW8c2XZ37tV6WOJkLkVwQgT88G?=
 =?us-ascii?Q?8v1FaY0VK9z5to6fbjz0eQMBdonqdN+/SlIDEzXN1tZwTA+OXh+YTCCkja/q?=
 =?us-ascii?Q?+M6iEaIKDytKSfQbBtQTDhebLrRDMuGhqtX2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U+JhWkV+WfkkzjZQl5lEhuw04gwQiPas7Aud2cpKkaC0Vf24+3Pe+wuepptx?=
 =?us-ascii?Q?B4Vp7YQs+CsBiMofWe/E5YPpgVu9YTyj+Gn7+j+JhexpLFS8L1gFM/TeGqD9?=
 =?us-ascii?Q?Frw/SyB4DenARTsi7OC54+VoQYCQ6r4gaF51xNGnwAFAZf4VUZ7b2MYUqDbh?=
 =?us-ascii?Q?ekFRC4tj9JXkUC9sW8dV1I/fH+8RmVukXHvlmiOhqQlQ6W/1fOfbOpgD8Qo3?=
 =?us-ascii?Q?Hz4lQoWpbJQLukshBhxCJEf0NL5ET2LJxQMAmjo9CGRh4Ag3Jgz7RqXR7srM?=
 =?us-ascii?Q?5zj4v6RCIg/+SbHXmYtxW8267JkBvWCPMIu0fPm8U+6lTIhpUo4GRx9dvDpU?=
 =?us-ascii?Q?r6GrX11MwX8V7/oJkVanicaKtc4VMkfWDwsMqphXxnG8fX7+4au5pI04tMNk?=
 =?us-ascii?Q?uYV27hqelmVHmyhiVrFIOQX2FXFrVkdbutLKB29VgW85a2z/8aNldK9NKRvI?=
 =?us-ascii?Q?Za9zjuK93rwYgJDBrs92L71qJGYVeA8fZNKAyRQ7dVoLE1lFQWBZoSRlSJvh?=
 =?us-ascii?Q?vvaG7WPJbBsYebeGvFV5j7obfLmAxYkCeZLWl61QTTjGVDx/BlOv+5c2XBIH?=
 =?us-ascii?Q?KIznF4xnRd3/qYu1Np6yyjdCf1O2eKtB2/BDObxWeC5C8zld9rzpa2uJMdSv?=
 =?us-ascii?Q?yYsa4v1brTIyGdMvblFm5b27HsVzHq4G9mZTxP4jb7bNrejfACbgzgr4frBv?=
 =?us-ascii?Q?GuW2cSKbRoYek/kpUxOAzuIjCoayxwOWI99ANfINA+Ag2J76YlW+wzNjgCFD?=
 =?us-ascii?Q?Vjj1mWbAXKDlqwY658qcHgAC0AG5+vUsRBzpjz7b6w7HJYTvLtBcwI02mKLF?=
 =?us-ascii?Q?o9Rsr7YEpo8+ABGkMsHpcSW6TLS3xbyyAjGTFExpMSPSahGQcAA8xiXTHTBo?=
 =?us-ascii?Q?amrb/2vPVIFzMwGHmVkp3CfzbphTTvDqqrLO9SOhPXj6UOm98el0dT5Ul2qL?=
 =?us-ascii?Q?FTLFayY/JveASEvFocElm4T1OVkO0PVsvJF3S40k3erabLujSsrjTlp7sViH?=
 =?us-ascii?Q?IVChDPrLPLod/87YdXxzRqVXbhDBJvlPoaRmKMOcvmh5XIWLjU8AaV/Nm30l?=
 =?us-ascii?Q?FeW48wh++UaW3DH0lqtI1gpUsysvR8bMqEXi3l1tJ/K9+kimpxNzmRBfT0Kc?=
 =?us-ascii?Q?G1iNOSyBmFwP22QRV85yaOVS+2+esJHFQ5bPvUF7d4/gnXQY54HS7uLEX6fy?=
 =?us-ascii?Q?TYlmxBnbQ+AjYgbSfur/LOaS7pa//pcRhi7BjZlxKk9xSoMqPxrZKoJJNtbl?=
 =?us-ascii?Q?0E8he80PNAsGp+Lw6d31GUvezJzWxFyakcEvHXxK+bgNMgloHD78P7cVkaFj?=
 =?us-ascii?Q?9fU0GLEDSsyxZj4bVKgs7P7Lh87RJK2WmQDf9uGq/no2S0IwF3+HKw4ug1HW?=
 =?us-ascii?Q?WN8f4+MIlNiKeMwPGgaaqEGO0btj3EbgJ/tOmbKK/0dsh4z3XnBDbhVGyttb?=
 =?us-ascii?Q?lzBLZXa7saENJd1abyBlFRuRbvPjhkmyKBg5HvkTBNwopFLwX2u9ZfsfDZ7H?=
 =?us-ascii?Q?RdBOobwJ9O/nMtQCEeLTtynn0aR6xt1/Sumx4eE6kRyedAhXvhjKO7tIEnaM?=
 =?us-ascii?Q?ioJd1iCPlT740HPP36WxIUP/AeIT0nLgx81cceVLtd5eD9gbach61rg+Zuwn?=
 =?us-ascii?Q?kxif0isPwD4KmlaKvtd5W48=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 114064f8-2ae3-43d1-bb07-08de063995d3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 07:09:13.3507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7UjCYGdF3w3wZNeFIiBxeO5iNKn0hh+n28j9lXwGMpaRpx4DjTlgdmNcx6YClPxaMKLmdFSeet8pgSgFcJL1oK5IMvi5zduNM317YI5TR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7638
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

This partly fix commit 726404a66c773 ("airoha: rework RAM size handling
to support multiple RAM size")

The function get_effective_memsize() do not see non-global defines
of CFG_MAX_MEM_MAPPED, so the effective memory size will not be changed.

Fix the issue by putting definition of CFG_MAX_MEM_MAPPED to the proper
place.

Fixes: 726404a66c773 ("airoha: rework RAM size handling to support multiple RAM size")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 arch/arm/mach-airoha/an7581/init.c | 2 --
 include/configs/an7581.h           | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-airoha/an7581/init.c b/arch/arm/mach-airoha/an7581/init.c
index 11992027d92..be0ccadf7da 100644
--- a/arch/arm/mach-airoha/an7581/init.c
+++ b/arch/arm/mach-airoha/an7581/init.c
@@ -8,8 +8,6 @@
 #include <asm/global_data.h>
 #include <asm/system.h>
 
-#define CFG_MAX_MEM_MAPPED  SZ_2G
-
 DECLARE_GLOBAL_DATA_PTR;
 
 int print_cpuinfo(void)
diff --git a/include/configs/an7581.h b/include/configs/an7581.h
index 64f04c9d9a5..dfb611d298b 100644
--- a/include/configs/an7581.h
+++ b/include/configs/an7581.h
@@ -15,5 +15,6 @@
 
 /* DRAM */
 #define CFG_SYS_SDRAM_BASE		0x80000000
+#define CFG_MAX_MEM_MAPPED		SZ_2G
 
 #endif
-- 
2.51.0

