Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9290CA0EED
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 18:21:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE9E9829E7;
	Fri, 22 Aug 2025 20:20:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="JZBf4/2C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 810ED82DA1; Fri, 22 Aug 2025 20:20:47 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDC9B82998
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 20:20:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KN8pP0yWIg3WGZAjoFhEO/DvQpAp3yu1t1AnfRA0L8AWzQ/qWR2v1pIHADNPHHtDXD8N6VYYiY/ER5Ywg6QueE75PVw1KC2R+8mzVDtZ+h9D2ZBnl7SjGGZeQjcXKpM4V5MJB9fkz7JAGhKOFDO8Cv96KEW4slzzlBziN44BbjYwYimxlg2+YeHZCh6r+KSnzt1k2NIY2paywMwa96z48Iclcb+6Y5ymbY33Qew1DhrJmiCSnAI+aoIY/A6YtxG8lkYrYNoUgSFr/19cA/MaLHex6ugcLEGCay7XJ6uWsbwAmqPqYGGiKiSL6gmzun15wELXBYf77DVUDZ2vEdXWgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HDXDNz332jPpcJ39f4FurWCE1an2PjC+oxC4U0obO0=;
 b=KU7GpzZuEMAX/bx/n9rZmkFIQABKmSzuRXJA2o0Q1549xq9XmUG/mQ4srPY6TOOWFatPNqfddXPndzA9N4mm6uawkKY87TLWHg4BDP+IDexeF42rv02oUBMm0ANa31kfK3Uluk8+2VaEv6gY+/GDFxk1dfFwN7ORqcHtDiVzI0oORJCId+6hMtZecazW6aFRNt1zERu7foPsnvJIGqpSIXVG+csGnUxKbMP0qbV2pecYHMahHLwasEPZD0GWVm53cOt4Riq21Jr/1RLuYGpNQb+HDI8wkKZ5OwmynqKv2MQcys+WVocwB2Y7FfAA+tb33zo+4n5ObvUQ6QDNrDZKCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HDXDNz332jPpcJ39f4FurWCE1an2PjC+oxC4U0obO0=;
 b=JZBf4/2Cp4IcVPmLQuD+zq0IKmeAo0wHso7bPU0SGwyWeMFU/4WmbIeeypGfjn6ehmAWdd2iWrGzvz1RsCDaBnHRiv4Rje4VvM8HZgvgLwhEzKQxurTITFIeHyM3N5ZqHZuda1C5sXE/YDVOgub+nzO+RqlBvlWB19P6j1St8do=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by VI1PR10MB3742.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.18; Fri, 22 Aug
 2025 18:20:41 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 18:20:41 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 3/3] memtest: remove use of vu_long typedef in mem_test_alt
Date: Fri, 22 Aug 2025 20:18:48 +0200
Message-ID: <20250822181848.3325832-4-ravi@prevas.dk>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822181848.3325832-1-ravi@prevas.dk>
References: <20250822181848.3325832-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0038.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::22) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|VI1PR10MB3742:EE_
X-MS-Office365-Filtering-Correlation-Id: ac11ae16-4b75-447d-43ce-08dde1a89762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?liHaY1SCJO2Ul60VIxRoZ+tXKGOhBN8H4q7BVN2KvdoZUUdeHohcfKdBMHCd?=
 =?us-ascii?Q?t4R5XTJDqSLznttSIZj2Nhn3NJUuU1SVfXgG7BWEMAKQ8GykbIOj46eWzMLz?=
 =?us-ascii?Q?/ANKKWHOwYb8AFSyV2JC2Y/KSHhieg7N1IkIUUnQsOefCqniYT+UYWk/eX4/?=
 =?us-ascii?Q?mN9KV/6qBCqWZHeqCsw+1D6SyHmcoZsPyQCVKWecMtAq9uAEB/KyVcmXY5mY?=
 =?us-ascii?Q?Pec9Ym9AdgIoIwIy2F0mO/7y716Z9c9EY2w4NQle+fHgbg4/Po9z5azKze2T?=
 =?us-ascii?Q?ZOpxLilO0Ch9knbH5AKX0jdQImCwPoddhFU5c9SiPAOy26wcghKL+ur9DsMJ?=
 =?us-ascii?Q?8Vok4KREK7IjiO26o+sjR16faeDHHbj8YWlnjwaKRMJTLHocCANzaMWHGsYD?=
 =?us-ascii?Q?mZyXVEBuaYCHa6ny/KZ73svXFWZ6RU+s1EPoi6r/CVB51zmBM0GLeBwWXvZM?=
 =?us-ascii?Q?i8ODTA0XHZvq2oFgfe5ejGl1rT0ZWfiquFvs8VpT0uNlJqoNUYgNPOLgMyy4?=
 =?us-ascii?Q?9ID4u6L07rbyOfIHq56iWJjFcv3K3+tWmAvo5K128jpWxx43tmza09mNxAJM?=
 =?us-ascii?Q?4zJMA92XqkD5IeC+5GDwgyzhoaW2s2CmQDHzH2Q8xzNcTnzhnOoaMlb9HiF4?=
 =?us-ascii?Q?AZIDeTHKkThiBXbPg4vzXm4mfYP80Cnct+JU2MMF42NNoTA33HLRuSp8AUM4?=
 =?us-ascii?Q?g4WYLVxKsGY4HCeqWv8pOE3avJSk88nMi7dDcS57N+ePQ8s6HMp28avkHkwk?=
 =?us-ascii?Q?qm6ECIM8UEFl9y5EsfZ9vDQqfKdWWs8WAI+ykcpsikp7kPDvgnP0g7ajKzjz?=
 =?us-ascii?Q?SrjNIwN8GBBQaNi1tOdXsO/qMid2dnCz/2pGkNxz3WtwYz1DSgeEuJKgWKqO?=
 =?us-ascii?Q?ofB6iALIRfZ3JEBBwjxyr100Mp5B/fu57zjAi7S23t/il7wGHiG68UdWJAWw?=
 =?us-ascii?Q?x8bxYchqqZenwCc6PQc8FAae/ZeKxRIkoRV2izhcqzrmft1QqhheCinB1p3S?=
 =?us-ascii?Q?v40jIi40s3U+MeuSaNbtIPVQ6dVDFKSBKtyPCZyw5SOeqkqTzQ6EJHEJCjTT?=
 =?us-ascii?Q?Ggzuw93MwaYejS5ehtvEym9q6mDPkwsOBgk1v4dan1dKhGGETC3P3sYRZKN5?=
 =?us-ascii?Q?8T2sEr7U+04gyVhJae/7CRWqP5k/+zRQppAOto4A6LiylrHIbAJNIFgFU/jQ?=
 =?us-ascii?Q?bqZxDj/h8kYWKiDrQrMDi8tvDyrxQSJbbW4KoB4922IMSdm7jtgASieS4IUN?=
 =?us-ascii?Q?WsUGfgJgvy55eQEKroY6bbPlhd8f5AaVOwZ5agnqdmbH28EkPcoLwwTL4uLi?=
 =?us-ascii?Q?bVYE/nMJNUEZyct2E+Hgvv9jhSIzmDMs6yUHD1CxOSOB3Q/ADgSvYVYTONsa?=
 =?us-ascii?Q?XPB3fA7ljxU2jVsBDj9pwPdO2M7KUt9IWfikRUejp/6GlUrgg6X1TxawEb8g?=
 =?us-ascii?Q?bULmdMTj4AnWHkk3IzRKC8kUkFZUhlXStfPFAkXEVP+RdWlo+zHDDQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zbHl218eqVay48K+lqEcgkTaWtAEpRG2dGjyud0D2Eq/ZMW+KagOHNc7i2nk?=
 =?us-ascii?Q?DG0E+4dlcETPKsiT9Zsn/Ih4ctZH7HrqBUFKiw7YgrsG+9s+ZZSjyOB1JrRj?=
 =?us-ascii?Q?Zrvc/TQ0PbA25p4nYzHZnQNS9t6npjjIcKvykVZR/TpXLcoX+OuufCbcBLbM?=
 =?us-ascii?Q?fvEKuRS3rQOLgPt6Ez+Wk4pNoCZy4yHAOMeOGUIIMnDpe7dI0RCV+rKEnM6W?=
 =?us-ascii?Q?F8VPSzWgPfHrEvsfL3QY3SCaj3t9zfUOn+TibEpcBSWIWMeCtlU7NSNC5OXP?=
 =?us-ascii?Q?TmlHt6JCFaFmKQA/mTbxeZW3CVfwTWuA/8irsXIQsCXM+AcTJQTWTdfSrkU6?=
 =?us-ascii?Q?pF71NFzChT6T0reQ72vTn6Y+9gE6/N62uNNO810UDm2oYEDKt3RyjkxnFiyi?=
 =?us-ascii?Q?DFMcZLhLtYj/JUvwpUr4kTIMs9DXSE3/Dz9gULYIYSAjEJeG8psUBbedyfJe?=
 =?us-ascii?Q?wD5l3pvhT64auMZbSUpECwYt1X3bJn5hmRA3KYzIxDl9Rz2vgVPkAH6lV4/G?=
 =?us-ascii?Q?pGvX3+qwlfI3Y/m2CHSUQIPY7nP1F/9L3GYRVCUEP47FSGRCDNQSC1ajG9P6?=
 =?us-ascii?Q?ASKY3aHTULMwq6F1XRUyBT9iNyRbWy/m78HKWSR5fPtk9xwg7FpKh27GmXhI?=
 =?us-ascii?Q?h+gOH9YrX5peDXL9i7dUSAHzcrYAK9MQqJ8LPunvME8EpA+GyMH37iJvo3jC?=
 =?us-ascii?Q?MfPyujH1ipXlxluzEBGMPdHWgZPxDMVTutSYOzGMDsFB2fyQi7Q+/7iiqDeV?=
 =?us-ascii?Q?8nZWujurObJK4xlGYqVWJoitzBlFqY7kWW4KMFNZJpxAhWF6s3RJAB+6F9ZB?=
 =?us-ascii?Q?A1zFZnOyyfakXc2fioniF7gmHMKuEnnC80vx0EFbOs+gfFqpGGYLWDqHcKM1?=
 =?us-ascii?Q?y2ddMaCyyyLsJOt4ociWQ80OPiriiVzKPBdQ6jM25Mwp8tgFhSeFIiUTSjQ0?=
 =?us-ascii?Q?rLZZFKmmp2w3IPpeJuL6l4cqfKBxcMf/Hthupe2hNDJJBjBQDXLaN0VjQFbO?=
 =?us-ascii?Q?+Z33kl4I/8O4nxD0kjLhj5jRZhiBdPYhMxh/L/SB4Msmr76QwhIPXWLjS6cy?=
 =?us-ascii?Q?o80RaSH2JNY3070CwgTlBYR8zXmibLyAZwT0Ge51vjRE92Jh4Zxgggf9Y1HW?=
 =?us-ascii?Q?Ivho2tQyIJDJ0fxQbMSISribAhUThetqNSDCeaWOIXvoydvj7Ca7WF7A+OUS?=
 =?us-ascii?Q?xLZNc/m4Tv6VX7thFxVTBMDRJ88UajWZk/3IcmIJ91NS9LkLVtXseOc7t6/8?=
 =?us-ascii?Q?EGrTjYJS3Fg76Ctg3moSjNPEi9alBzO7X8yTl9AWgayjtqrek9MeEL2SM2+0?=
 =?us-ascii?Q?oY2SLWcf7y030P8nqLi0uu1BfwE2sMatwnx7TKuFZC6z8A2tIHpeqwwZ3D6o?=
 =?us-ascii?Q?ZcQmwiFSpHu6b6HrMMijqGnxxOksa2RMEQVMf1N0a6hnBbdLtOxOXmd86PeN?=
 =?us-ascii?Q?7ArBr4EuxchJK0ir/SMOFzdg5BCd7qXXPcxysb/6e5pXRMRgbR2w2YAhupoD?=
 =?us-ascii?Q?yHCWKISnjrgyOpUO6lp0imHxA8BxO7o6L7zYngzqWoD8SqCXvoE5ZWy35FxC?=
 =?us-ascii?Q?vfyPfnGFMPzLJBL6dN+YueYnRaI74PUKZeCChLcdhX4lm5TgG6v3WaCOeJND?=
 =?us-ascii?Q?7w=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: ac11ae16-4b75-447d-43ce-08dde1a89762
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 18:20:36.8788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EcTuqgvYC+yWkg9DBGQ3ML03lV+A7PdeXtdDz60waTr9j+bW0EANF9/bpOvAgcXlvDE85XEnmW8T2iXEupB5nA5uHA8iCPl6noBJDWU/IyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3742
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

Hiding a qualifier such as "volatile" inside a typedef makes the code
much harder to understand. Since addr and dummy being
volatile-qualified are important for the correctness of the test code,
make it more obvious by spelling it out as "volatile ulong".

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 cmd/mem.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/cmd/mem.c b/cmd/mem.c
index 013e93f09df..c8c602ec9c4 100644
--- a/cmd/mem.c
+++ b/cmd/mem.c
@@ -710,10 +710,10 @@ static int do_mem_loopw(struct cmd_tbl *cmdtp, int flag, int argc,
 #endif /* CONFIG_LOOPW */
 
 #ifdef CONFIG_CMD_MEMTEST
-static ulong mem_test_alt(vu_long *buf, ulong start_addr, ulong end_addr,
-			  vu_long *dummy)
+static ulong mem_test_alt(volatile ulong *buf, ulong start_addr, ulong end_addr,
+			  volatile ulong *dummy)
 {
-	vu_long *addr;
+	volatile ulong *addr;
 	ulong errs = 0;
 	ulong val, readback;
 	int j;
@@ -733,7 +733,7 @@ static ulong mem_test_alt(vu_long *buf, ulong start_addr, ulong end_addr,
 	/* Rate-limit schedule() calls to one for every 256 words. */
 	u8 count = 0;
 
-	num_words = (end_addr - start_addr) / sizeof(vu_long);
+	num_words = (end_addr - start_addr) / sizeof(ulong);
 
 	/*
 	 * Data line test: write a pattern to the first
@@ -815,8 +815,8 @@ static ulong mem_test_alt(vu_long *buf, ulong start_addr, ulong end_addr,
 	 *
 	 * Returns:     0 if the test succeeds, 1 if the test fails.
 	 */
-	pattern = (vu_long)0xaaaaaaaaaaaaaaaa;
-	anti_pattern = (vu_long)0x5555555555555555;
+	pattern = (ulong)0xaaaaaaaaaaaaaaaa;
+	anti_pattern = (ulong)0x5555555555555555;
 
 	debug("%s:%d: length = 0x%.8lx\n", __func__, __LINE__, num_words);
 	/*
@@ -837,7 +837,7 @@ static ulong mem_test_alt(vu_long *buf, ulong start_addr, ulong end_addr,
 		if (temp != pattern) {
 			printf("\nFAILURE: Address bit stuck high @ 0x%.8lx:"
 				" expected 0x%.8lx, actual 0x%.8lx\n",
-				start_addr + offset*sizeof(vu_long),
+				start_addr + offset*sizeof(ulong),
 				pattern, temp);
 			errs++;
 			if (ctrlc())
@@ -859,7 +859,7 @@ static ulong mem_test_alt(vu_long *buf, ulong start_addr, ulong end_addr,
 				printf("\nFAILURE: Address bit stuck low or"
 					" shorted @ 0x%.8lx: expected 0x%.8lx,"
 					" actual 0x%.8lx\n",
-					start_addr + offset*sizeof(vu_long),
+					start_addr + offset*sizeof(ulong),
 					pattern, temp);
 				errs++;
 				if (ctrlc())
@@ -902,7 +902,7 @@ static ulong mem_test_alt(vu_long *buf, ulong start_addr, ulong end_addr,
 		if (temp != pattern) {
 			printf("\nFAILURE (read/write) @ 0x%.8lx:"
 				" expected 0x%.8lx, actual 0x%.8lx)\n",
-				start_addr + offset*sizeof(vu_long),
+				start_addr + offset*sizeof(ulong),
 				pattern, temp);
 			errs++;
 			if (ctrlc())
@@ -924,7 +924,7 @@ static ulong mem_test_alt(vu_long *buf, ulong start_addr, ulong end_addr,
 		if (temp != anti_pattern) {
 			printf("\nFAILURE (read/write): @ 0x%.8lx:"
 				" expected 0x%.8lx, actual 0x%.8lx)\n",
-				start_addr + offset*sizeof(vu_long),
+				start_addr + offset*sizeof(ulong),
 				anti_pattern, temp);
 			errs++;
 			if (ctrlc())
-- 
2.50.1

