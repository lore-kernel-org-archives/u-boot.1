Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5162ECA0EED
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 18:20:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FD2F82BA7;
	Fri, 22 Aug 2025 20:20:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="jzdYFOWc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9A048006D; Fri, 22 Aug 2025 20:20:45 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C604781D5D
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 20:20:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsKL/U24PtO/SSSBfNZ+IJIafBtbxDKJcE3LZd0LhGK71HY9Eu9S1P0v/FG4hq+5ncteFi44SOO8j+M6p5hV7igLwmDi9+fU7H8S8W2QfpdX48o+0HOaBjWfUCb4HNljLO6zac4MD6yECQMAAtHjlKl94smEErHxda8dLcXYf0qiFHu7HxTGuqtsldXAwvY4wf52h3KB+eGxoxjMN/KIbiqbty9OqWa/T6PnIkUHR1qdONDPrmGh1YFSC6yQE1T0snU6pc3KZWncRwLqY6pGqouYg29oX8WTUxDZdrcFtulOSKFtuSVKIpL95KlGUogJTJ7NvuXADCJ1LgkSxEmUDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y25/cS/sth2ZA66y0DIfK6efFSpjO7agJ7FIxAgOjlc=;
 b=Z++S5Dn/Svk44CvIbJFAMmboexnTfRTUgWegU7Ci9s4rT3hObXHw7oheuyFEDKvb+PoJDKmxjr8U+BXogZ7GY0zV581Be1AthJgeWwuzM0EurrJ908g2CK+AB+zPjT22wsVi5cGUr8jYmZwD415sEYVjAAXxtqE3Fgs7584lDXxJ4/0NX7xXmbRWV7hjZ+h/ZZvnslm98B7WcrAInKHafp8kwPP7IU0o/SY3MZpj13jY+yWxBxKp+LVQ5DeWsVeDVV+bTkk0TBFhVaMZBlORNtECk8p5cMslsiPYRtIK2p91WcpD66CH/55rdSfw2b4CGDVkYAiH84KJjfuMGldP/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y25/cS/sth2ZA66y0DIfK6efFSpjO7agJ7FIxAgOjlc=;
 b=jzdYFOWcoc++gfna1/1TbtMKRiO7nlnechhF2W0GEnZJ0MSrwXRiBVKip11h6M4SoYbd2l2MnoA9/UCD6z7I3ScJdHs6Yvl+c9fcyZWKqNtMnAmfcgn5JXDGHMsBfVtFKly81+ez3AShbhHll/W8OkoNtWYDHvwWrYyIAjg3sVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by VI1PR10MB3742.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.18; Fri, 22 Aug
 2025 18:20:40 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 18:20:40 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 1/3] memtest: don't volatile-qualify local variables
Date: Fri, 22 Aug 2025 20:18:46 +0200
Message-ID: <20250822181848.3325832-2-ravi@prevas.dk>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822181848.3325832-1-ravi@prevas.dk>
References: <20250822181848.3325832-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0086.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::10) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|VI1PR10MB3742:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e1a953b-a96e-4024-2bba-08dde1a8962f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0EUKNQjYMmHOHvolLGqUq0Ds4IYcSW/bZD2hN4TUfR4Obgz8bf3eMlLMYXXD?=
 =?us-ascii?Q?CPLClUdnUCesWNJlHdtE61bvGajtUC3AgdePArPEzBnc4GYWDReQa9lTEoOW?=
 =?us-ascii?Q?2gVFvJKEWCs4Ce2fXX7l5wugcKPNEFIkdyPhOcV11m6wTs5IqjBahCOznONA?=
 =?us-ascii?Q?zz90tnywBrOt2t9XMC/NeKvKULnfHINDfIwBefEGNnvtXF6W+Dy+7dmK2bRh?=
 =?us-ascii?Q?qzZRgTfb2Jpp3TFxsDhl9PX8yfznvr/6NeeoADa1rKDEeIktLw3GRDRf21BV?=
 =?us-ascii?Q?9PVVePO0/O/TKYaCKAJfgHyiPCQtdj6PBuTgVnNjmhfy6TlHtcx/8FltT0b0?=
 =?us-ascii?Q?4n2lzYZ9F+ihJTuI1hvvxpdb9e8QUq0WoSc2Nj7KcvuV3J46hAUX5IqmGUQ9?=
 =?us-ascii?Q?cUolWoMBFj1A5i3S42x6zd1C5b2nP/ZwB2EW/hvQaws1WM+/fmhkyKbFkltt?=
 =?us-ascii?Q?eMGMyMqMCEz+QGU4/z0p9xI0/IZ2TOL6KYAMfJIWNMRzqmlJsLFFNFmseaQZ?=
 =?us-ascii?Q?UO8DsI0JCR6KLwLosW59T191lk8zHC/otL8WFwYanrsO4FPAukrsCXNAnmDt?=
 =?us-ascii?Q?Dn4o910V9SMfIvnTO13y2ieFOwYo8auXM+4mr1cK0xbjRR14TPSQMBnaKVja?=
 =?us-ascii?Q?bsA3Dqe+uMfhqZ/S7TrFZfeRSiX6ywFugz0s+Uc9YySKobrSgyO1clPxgRX8?=
 =?us-ascii?Q?JA+RZ5RAPykN4GBFO52UV4ZrbwPNJ5NNrCN1Yi0kOOjjOyKJEMSe6qIIYJKN?=
 =?us-ascii?Q?/mQu18+IwaS9826yEFtkwrkpSxRaGUHMTGwU8/oo4MKSodW5K4Lqy0vYddzS?=
 =?us-ascii?Q?kwPLhIDf2UOxLimVOtnY8DKoSdayhYJ3LItgsHW48htt9BT1+vNrp1sB42Do?=
 =?us-ascii?Q?K1TZMoBLM9EQYh/khcpP3SAaN98yrvt5f2whGkMQXIulLCF73pDLRFPG7nKc?=
 =?us-ascii?Q?rp3T3805l4IGHRElPNPyuUrCzUl4r0wYzYpmrmkTXaaxnz1Vb8Mgt68nKk74?=
 =?us-ascii?Q?PvYQH3mM7ydVj9dccMw3whPWKF75njojzhYC2xtptYOjPBzMjn8g+jXppZSV?=
 =?us-ascii?Q?wRbGmDJPF5N0ZrrdXijJdWVwgaDx3dNk+JBiB44OMXSuMA866ph306UF7EcG?=
 =?us-ascii?Q?k3ToyK9ll6fwViAzgYHXl6RGsHKW/+dFt7qLxAqZYt3LsTDjPgn2FMOMd2ai?=
 =?us-ascii?Q?NzeHiVyguwV/6SZ9UtAd6lySoYgP+KnlNVLoQpnGE3i8GYR8th69/r0dnRFm?=
 =?us-ascii?Q?yLutU5VcqXwp5UkMI5IkS+ehQ+PNN5czE7xnq5AXkojgIS0bO3VkxPSAmEiJ?=
 =?us-ascii?Q?86MBAMu4d/+hjq+AEQfVJInEPX7LQCTWA5jTWJFYR8F2YBXUits9n8ngbrvh?=
 =?us-ascii?Q?XT80hH64NT608JQe20IDC/he6O9kB8EZA49ZYPwaJEb6yf40rRLhkICs1RoN?=
 =?us-ascii?Q?ASzAh0Ck+GR9aKEWhiYgyoyonNONa4YgXhT9/h23CYFT4/4K4gtRUQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ggWyDPHAd7Lg8JveGMJcvN703iOtJrtLKbAL9z3r59RKe9IdmrEIHHzYSV8n?=
 =?us-ascii?Q?D3DYRJN+ZQh/o33wSR6O8SlSSttAgivdE/ToHFGzwvnh5r7bADvkWKghbMLy?=
 =?us-ascii?Q?n5DirT8pHe8qa9mvbii73RPE8loP6DauXZc7eIi+VfqJo/Ihvgnl6UinXbTT?=
 =?us-ascii?Q?3ebWR5alzjwrUn65VecHcvWda44eTZ1RhD/lLBwUFAmOuuE81bWHyKykO1fd?=
 =?us-ascii?Q?y599mBFCmKFGZ6qFNDZV7ydRH5KgMGol4PpX2M4jY7gSc4UWRP8FdXtbwyls?=
 =?us-ascii?Q?xwtcHjQL4c3udgBdYEvsvviBRAayki1m7511Xf022l4eT6Q4bEpwLYLZV4+V?=
 =?us-ascii?Q?njEI23k8iSFVA435aDkDK5No5B5ATRpR1t0DkMYptTHBVo1t/e0BRq9bfOgM?=
 =?us-ascii?Q?pg79BPOD2nmBvd8xgkHZAMwOoBxG+iwB62Q/xq5JyuhBifULDuxinsbtnreY?=
 =?us-ascii?Q?orLg1Wtqq3NaANXLLobRkk9cjLoHU11oUWZSYA6vU8iVJ92DGZh4SyK/7HbE?=
 =?us-ascii?Q?BF2V3tnI7RmKxfKTcHhE4eFdY4IegmnTsCTomx+qaOlIFNxOOEY/7vPCw4vB?=
 =?us-ascii?Q?oGab9HFVsWc6JTbU8sRqRsZd6VTd3mta5hyN9G0wMWKS304Sy0Z6L8x069zO?=
 =?us-ascii?Q?F/37JDWEVirPHFtZvvsOp3NC/Q26Lrmlh6AzzBk9ycMsB2qSOwIDGvbmTC5C?=
 =?us-ascii?Q?A5AjDxIdnd+Djmy6Gqx/wOcfpiBxGMEpsjuBtY5gFa6tJHlLxc/hYW0iCNAA?=
 =?us-ascii?Q?sVRIjjyAFYyNDUBeDgRDkuxap/EDFjbz16uI3GV5IFszJnFXLrz6orP+yZmj?=
 =?us-ascii?Q?40/kvLTuMSPteL3D7TcrjGkl+xafIC+m8E2TkuvjYdwOYcJwVxnT38ERaUdx?=
 =?us-ascii?Q?YFa3kKfrEJf14D4T1JvUGvtJaau6OD0GyNYOyC2261ttZsd6/cS8z2+qdwzK?=
 =?us-ascii?Q?VWipsL6PFmK1f84wJGBfqoZ2udt3GyJkquat4c4PsiCT1mEQJCy84tsdvpL9?=
 =?us-ascii?Q?xbcqwV00/xFh/HnVYJc6MlIChmeby/0vOugry6ELuIrHuEDlF2hZ29UqbJmG?=
 =?us-ascii?Q?bVWV3pOplsYsWxt/xwigSMMJ0O5FkO+jQvTCFpB5S2+v0fWuQwpzf2DaC1AY?=
 =?us-ascii?Q?la54vP3dpOqlmtgS9EnoVyUyZrHxEqWl9QYoiZHj8Klqd0sZFImt5yiJsVtt?=
 =?us-ascii?Q?pelGBRIp7xrwQ2p6lLwvL4Nxx2lU1PMQOdPDJvEHnFzVuM8gW2n/TYhzflNi?=
 =?us-ascii?Q?Uo1LUJFaQRSEyGJ7CkhLG817WOkTrn+d2PO2Cta5NzkuFwDkjLi0so38gcB7?=
 =?us-ascii?Q?fbmVmcI6i6Cc0k02JrvGiaLbb59Ey5/QFU0NzN/mU1l0whZguEHYjmubGeW3?=
 =?us-ascii?Q?x0m2potKy6X5yZpcHc/YS2u6V/mgHjuShEtH27WG4SRQPV/QKfkwY4H5EFuw?=
 =?us-ascii?Q?FZzv915ahrHrKkiq8Q3ImMOsKntqe2ACw6Gi+PpLNXk9IX3Ci/KO+iWYrwdi?=
 =?us-ascii?Q?BI4n6QwLQhfhzpKdcczx+gUU0UMKtLZKS0HtamC3bfOgTgwk9xDbgtHY4Vru?=
 =?us-ascii?Q?79SLx6qCU2Ap+6TUZeaLrsq6qBxRscXkQngbvVCj8DqJCj0GOWCD+oJtEBCZ?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1a953b-a96e-4024-2bba-08dde1a8962f
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 18:20:34.7991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aAz4IhVjXM+upTurTwo46OTNXwF+p3y2HikPv58KUFuRdLNeKOCrAu6Dy4uaRMb1SXCS5UplJKj4miV/opk45rvplqVe04ZQHazpx820lwo=
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

It is obviously important that the addr pointer used to access the
memory region being tested is volatile-qualified, to prevent the
compiler from optimizing out the "write this value, read it back,
check that it is what we expect".

However, none of these auxiliary variables have any such need for,
effectively, being forced to live on the stack and cause each and
every reference to them to do a memory access.

This makes the memtest about 15% faster on a beagleboneblack.

Before:

  => dcache off
  => time mtest 0x81000000 0x81100000 0 1
  Testing 81000000 ... 81100000:
  Iteration:      1
  Tested 1 iteration(s) with 0 errors.

  time: 10.868 seconds

After:

  => dcache off
  => time mtest 0x81000000 0x81100000 0 1
  Testing 81000000 ... 81100000:
  Iteration:      1
  Tested 1 iteration(s) with 0 errors.

  time: 9.209 seconds

[Without the 'dcache off', there's no difference in the time, about
0.6s, but the memtest cannot usefully be done with dcache enabled.]

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 cmd/mem.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/cmd/mem.c b/cmd/mem.c
index 9e716776393..9a1cfa4534c 100644
--- a/cmd/mem.c
+++ b/cmd/mem.c
@@ -717,12 +717,9 @@ static ulong mem_test_alt(vu_long *buf, ulong start_addr, ulong end_addr,
 	ulong errs = 0;
 	ulong val, readback;
 	int j;
-	vu_long offset;
-	vu_long test_offset;
-	vu_long pattern;
-	vu_long temp;
-	vu_long anti_pattern;
-	vu_long num_words;
+	ulong offset, test_offset;
+	ulong pattern, anti_pattern;
+	ulong temp, num_words;
 	static const ulong bitpattern[] = {
 		0x00000001,	/* single bit */
 		0x00000003,	/* two adjacent bits */
-- 
2.50.1

