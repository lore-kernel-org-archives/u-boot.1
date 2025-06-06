Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E23C61CE7
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 20:03:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDC5C81FEE;
	Fri,  6 Jun 2025 22:03:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="MZ/rNzdj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2164082145; Fri,  6 Jun 2025 22:03:33 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E78481F0D
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 22:03:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljOwY9Dch6liXHMugJJk6RqJqHFjb+B3+4CfFtgGjlrHAe2aypZuFD5lRoodu0NohKqf50W5L5PzDkyxxhqxW/pQnwrlnnd9mR370JS6hgswrcvwRZHqjhcAnSlkWzZrHO8wd+FsDB2OU8aQ7cY7Qc12slrSqxsd3T5kacmFL5kRgKDA9iJA8JLfVHbjHxh9/I0y3Ue1tm5V9V/wGaSQ1V8dAl7RLzh1VyRd/c9UgqKFKSyE2g+grQceHp8YjPYPguMKGGaMlcgvsqqYg5eSKkIB2jJTgRSvBCIkowP25202zsLF9AkPS6iZw0Ad3Sb+wdmkOsHjjF/quluTTWu3aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umeSZzMBIX7dzW8FTHsRSANFR9ed1yqHnL0pEG6cRyE=;
 b=qQK5P6EHu0VD/Jp2IEnRwTJdlLFMF3AJBLhgKJi65fvdRx6rkYrFLWTQz1/1DNmpHOq8qG200+wGc5sm8tgpMn5zUJ5yrp42pT09AsQVm35Q+zCz9lokxJg/8y0yI1yfHpfDQ0sMEjo44yfyC5HmFDoIww2e3AnpOjvTgPM7v0Xqf4/v4vcvyc4JAla6NUqxgtNvjyX8SyixHquPF93OyFszmGCzbHNBY88TUkom+1s2Tn+4Skg47HdkuZgvH+ShUR/m0r+Y9GpFtJkXlGS2ZOQnpHpWBXN3gZ/XCzKuPRK8+PFhE+TFYO1+JZIG53XILq0GYukwWBVFpP5HKw3yKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umeSZzMBIX7dzW8FTHsRSANFR9ed1yqHnL0pEG6cRyE=;
 b=MZ/rNzdji6yh8FZC6QBfYloUk3Lwoy7ClkaPS6ahRREvAAi7l/h4dNYRyQftxXmXaeFF12nYlJmaIkunm5THEl2RYmbA8JDAJHLWnvr7Vb7FGsdjIDiYWVAXPV37SXgB73WlQTrM3SB4pw/5GU6MYpSaiCiBHFp1NT+22R2T/4Beub+lEDdF5nW1RQ/Z8xi7iER0VO0Dk4Qw22Sn0De+p4j71oKU4xLbXl02ndqqVv8X6z5Pd5ws9UYKcH1k60d4iEfwViQlCAnP/w/v+FB4Iy2srAxhx6KwY5Lo2m35Col98gXG5ZAYSwxB8aEa+NleWyw97TD0xccSKf5fZB1WBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB8325.eurprd08.prod.outlook.com (2603:10a6:20b:536::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 20:03:29 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Fri, 6 Jun 2025
 20:03:29 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH] arm/airoha: reset_cpu() does not take any params
Date: Fri,  6 Jun 2025 23:03:21 +0300
Message-ID: <20250606200321.461248-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0061.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:270::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b59418c-a0f8-4e9b-9c78-08dda535344d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ysvHDLKSwFIWIZhQJ4UQ9/IKUNvwov8EPOnV0UvjuYx+sSNghVXdRmVVBAZI?=
 =?us-ascii?Q?i4AyfvlZtEf966brVtZKmc3dFzWkRAt7yqgQM9/NMM9msFIujCi8LPfUaYA5?=
 =?us-ascii?Q?T14OH2S39TfTYDctgCZUf7GkIibjO6zoJnFGaYIV+dyuqe70KIhgSFgVjpK6?=
 =?us-ascii?Q?prUQaBaT+/ZCzpaMPW4uaLFsF1vmwTSMadalAnBbR9KoaRUS9gHNzxVOomS+?=
 =?us-ascii?Q?J8dkgdqu13q1Kts2OObPRcGGjrIaSlvmnDuocGxAj7VR0/3RFC/S9Dja7UVq?=
 =?us-ascii?Q?wRn8OBEA3u6NRsOpcYkM+Ry5RWBkV1pbPN3VsHuPK5JLdKS5RMTf6cfZ4Kwi?=
 =?us-ascii?Q?dV+kOHUYd+DkiqTv+v+hAvv/eJOapCwLy8Jed5oiXH0K1ldalhnaozWjsO2/?=
 =?us-ascii?Q?vhuFwFZnmTG69EcFNNvQ/7BH+IhAnhTK9XepdODM5zByMoE2ojyTUIiFGTTs?=
 =?us-ascii?Q?MdfrtHSG7vcWR9EuiuSfHB/Ok9/G229j/13QLUafEj7u5z6irp342ympkMtA?=
 =?us-ascii?Q?PVEz6Ru6fq53PQYh72qv7tGuH13/dPPmlzWFhJCOx73Yx9yI/9/6Rvt6xKBq?=
 =?us-ascii?Q?4CAOlOQRX83ytAvbCQzVdHX3DvvuNmNRJiTOfABXWeD+O35oH1VGLfuCU2NE?=
 =?us-ascii?Q?xm27Df3JpaashalJSvxAKC361g1FKptdMY85YzKkHxJIsob07rCIVssBmBcM?=
 =?us-ascii?Q?WQvzRC+CbXfXFT3AW8nLmM1k1NBZL2vwF7WvQj9MdYI6TWWnt7jKqfboSTkx?=
 =?us-ascii?Q?wn/8CZ84OyXjU2OFxRO/Ne+77zwweEZjGQ9XPqz98wEBszDEuGYdTM5mj49t?=
 =?us-ascii?Q?GMVKverMACcVZqmfwcv4+s5KzyyOPOC/Csqye07+qICW4e7tv6w61iFm8f9Q?=
 =?us-ascii?Q?hjYBekMpEwPtuvwbA8LbT8o07jJipzGSjwOfYTd3/J8emptN084YXB+w3BQS?=
 =?us-ascii?Q?Nwet6GhocofiOkRCiTLAKCLouFGOBgdIevYU1bZBPNmwwXhwAg3gdnJgOOVd?=
 =?us-ascii?Q?SbB33yVJlNb5NaqplKqq6JK38rBxHr68nxuEuSRfoEarbnZiPda/53PTpsgF?=
 =?us-ascii?Q?cR0IjLMPbJEDqodAFg/uMHfc05JPZ5IuT8+o0IWT3nCwXUQjREXsplCeqw2r?=
 =?us-ascii?Q?fSQa1JDZeaBB0cPaRZuW9IEfN5Cy3dTzCifa9r/ury/3AFnwtA3tpWv4k9xr?=
 =?us-ascii?Q?ixF2D7p7fp9/zBhrxFpcIF7IKZwySCnsSYir3iyhGxDufNS9OJOpIAG+uwF4?=
 =?us-ascii?Q?lDFxAWxYugj8kn8yy/kcJagAw++bbafN6RfAelOgaE4xOTlItuEDjGOzHRx5?=
 =?us-ascii?Q?q2RqLl7zteFIOQGYWULxQnruUi8GdZre8p61tz7kG24UkrXO+aP8cZizU9N0?=
 =?us-ascii?Q?r6luuAOX4wQU+/f/ab1DBytR8LkG0DERB5G0TUD8wHEiLps8fEmhRbfWBykG?=
 =?us-ascii?Q?dWhrRoMxt0OPdZQI5QVYPV2AI77pmLZaUx8otV11sR5GRUt6IOgdgg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iQOY7KXcxUBacSaNK6nxZLX/mt7DyP0g2nCM8IzV9VnOYJbDcfpLHn/a1dFm?=
 =?us-ascii?Q?/zN0EoY8yHG4+G4dekaTgyvbx7AYY0DL4iFpJ0rgD4BPT7cffIAUkfIs2e7d?=
 =?us-ascii?Q?bz2eKwALHSR120cgmG3youvzzULmBCsWDnQPs/+GnRY2Rvm93O6l706p+U8b?=
 =?us-ascii?Q?IZljA5JfbYxiJ3vT6skXrtR8N3FU3/9dXRLyLH7kFkHlGvcqL75B+wWhyzuK?=
 =?us-ascii?Q?z5XagARwOtONqrmUtvYuaWseZghtPA5p8SE1llkgEIHYCTZGvDAX9GIbRadv?=
 =?us-ascii?Q?AdGTrjOjSqRL0PosR/pvGSCJ5c7WyDR/OK7oXhUHiHhtYcyHTFChhzBN3TiG?=
 =?us-ascii?Q?U0T1ji1zMQSHst6F8bjjAiA9KpZfEbwlQpD4bRJpcc7cbreu3klzIayky7e0?=
 =?us-ascii?Q?hLK5CE9fdIpG+Hj7lV8oc6VPXSVqt9FqCdoTsRzeHgleNqFqvVcWvP+JZ7cx?=
 =?us-ascii?Q?cStKxsB/PzvroPsZaoh8NqNwiH7LgaJNtaDiycHSj743SksuXZnwpZVb5uey?=
 =?us-ascii?Q?36Vq5IYoIYyMfEYhfthg0oz5QVKMWwtho54I6GNnY4aUbMhr48FBiZ4cF4w+?=
 =?us-ascii?Q?wVlR8lM+SfLKiERec0qM2x8jZGKGJiNmIYaLzforzMg3gTV+m552Vrnyy8ex?=
 =?us-ascii?Q?g5Gq/2mtgoStynCEpREf5YGobeDFvDDIQoXdSZ0tIeCapVmMfW7AB5eCGN3c?=
 =?us-ascii?Q?f/rojtE3/oJTups3hcvt6CTtsbXab4iMXXQdY8J5h1Fnw6ZZxEL6tWrNBubE?=
 =?us-ascii?Q?nktp5IJ1vQ9oimcTBlnq07mqYJNGOAYYHa6a9D5+QxrQk2PTLUsfN4IyVJNz?=
 =?us-ascii?Q?Aw1WQX75ZAtsNKKaFLam5Yt4xAh8N5AfNRvrYnhIwq2HkGh3ocZO+lcg9Vg8?=
 =?us-ascii?Q?vgN+p9wBRwCMvpGXa4gjNfbYSR6m7HZBdM/oi6BQRuasz6elBXu7Cqib68e1?=
 =?us-ascii?Q?F9Hp981b7y19zho2QLRWrmyoYoawUFIC4eKIpAbjDbCTQWlV4Aumjg6ifAWj?=
 =?us-ascii?Q?C1IVj8xhb2UyJu8dMzN5bKxMlI+NAYEnHlVd1a2Kfz8/xmGSHkh7++my8MRU?=
 =?us-ascii?Q?xlj5tgr/1HgnShA5c0psPX/5Q0zvcPusljZsXFJVQa5LxmM7LD7lDryuikOd?=
 =?us-ascii?Q?JYUBzCL1wNXKxyQN0SvmYLmTpViUr7SIf7Gk+faZimtE+8I8GISJdRTNyiKm?=
 =?us-ascii?Q?Vc/2nW8YIyL1qeb2e/GsDZS68tizhD8vwP8GPxydbgQkxauXY9I5xEu3q8c0?=
 =?us-ascii?Q?LgYw/clu8NIopy8J/6LRfvZMCQoH3nolz461os7dqOf3OYt51eU8P9fc0jyp?=
 =?us-ascii?Q?z3DjYxefwyVrs/PJOD7W1h28GGqx9HceErInjtgF5vcDVoNF5zkOu9HYfgFA?=
 =?us-ascii?Q?kJcQOuQ4YKl4WioCb2qnI45awvAx732LoWzqu6tC5Qh16IluGKn6x7dTXkWh?=
 =?us-ascii?Q?ejzL9xzy5OXOhmH5uuvRoRt8KBBQTnXniGnmDVAR3BeSohFkMDjKD1bt5LPi?=
 =?us-ascii?Q?sHnHEl320Xd7qSPj+oplxxRdqBNTxo6bKXAsMypmKSxzM1OEZkOFcatRUp1M?=
 =?us-ascii?Q?6critauuUC5V67o9F/QRtY3/zNJHn7IpBlymX+qLKpK2/SS1SExzCZFdI6AZ?=
 =?us-ascii?Q?+ItDX3rZLFNkAoU7Tm+/sy8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b59418c-a0f8-4e9b-9c78-08dda535344d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 20:03:28.8606 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5A6oeR3HP+P3JfI9EoXgg0VYPmi044wIc6GoaIlHkh1pxJO5daO6lc5YDe/RosbVirJTi/zfSbSCDzQfoDPlpMzKLIzf9NGOAw9DxvAB9oQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8325
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

According to include/sysreset.h the reset_cpu() function does not take any args

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 arch/arm/mach-airoha/an7581/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-airoha/an7581/init.c b/arch/arm/mach-airoha/an7581/init.c
index cefe9c6db9e..e127ab2ad68 100644
--- a/arch/arm/mach-airoha/an7581/init.c
+++ b/arch/arm/mach-airoha/an7581/init.c
@@ -21,7 +21,7 @@ int dram_init_banksize(void)
 	return fdtdec_setup_memory_banksize();
 }
 
-void reset_cpu(ulong addr)
+void reset_cpu(void)
 {
 	psci_system_reset();
 }
-- 
2.47.2

