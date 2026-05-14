Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64409CD37AC
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 02:56:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B956846AC;
	Thu, 14 May 2026 04:55:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="0ZjETmpA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A47E846AC; Thu, 14 May 2026 04:55:58 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EFEC8469F
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 04:55:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RacPNred8nkAcNKX5bWVU80XDrKIKWP5PNk86ikVD+y8tnVFHKokdTIQmhs2J5/vpguLWnDmDUebsqTOkTI+FKH+Jm7Xn+Ct1ht5krngKgJeOyya6weYLFhk8gjXOWw2zPUckmmkL6vNv0LBGXwGaxxWNWORILYKDEQa3hSaxM89+EFjs1F2XiRsZDtuI7ygLH0Sm3Ki00GqO2ykX/nfq2bM/AXrdwjiA7tlKiQIz/m8fnyRuRSWpqIfFFdAfI7RYWPoK7Rm/ltuQdW4hECAjsOcoubM1LsLRgGPnne6VIDpNeIyPufhyKqtqq9/t9VBCa3uXMeRe9vBkkfh5mE2Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQ8Ldl/ganmFv+oUmvcsQeXOt+3SVTZqXxHsrNRa0to=;
 b=Cg98LU7AohLjEUnqWwhIfm8y9ERo40pIsMg4/WHZX30oEaVJz8W4PZYgOvr3OjXMFMXiBOtETzItw/ovAmYSObWsz29HVTUG7Hat5QIeiAuvhdlyOtHdyPfH6DRm4GbcSzfNelTrt0V48foGIFXH6vLci8qAX+/NDT4m2+goAjGOpFv7MYL9RriILBL0Ml9iUc1Kg4jXncmHeb/gyEPj64+7/AMsw4jGyo4Atzil/bl0BWLkJWu4Hr9O79XygQSf/h70ibr02FGfF6Jjofi6QhjNOFmUlrQzOrn7sAMuyAmiwq6Onpkqy9IPYmwZ6bxBTPg64XQOZPiAFGFQNB94XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQ8Ldl/ganmFv+oUmvcsQeXOt+3SVTZqXxHsrNRa0to=;
 b=0ZjETmpAoE61E0dzX/2A3yqg1CoNv7mhztec5Br5GEYBt7v+2+8kq32tBHEamO77eLeFGzzFPPDX5mbsXzOFGvBOUKFVBOkmMD+0PFNa0tzif3Mxd8lHdbpshHV/py++ftfGcrv3awSSMI+/Zqnzq9wSicPVvh0uyrIJSkKDl8eKK6sgcAWco2sWmnYiRGNQY5dM+rtur8nsdHNyUGDn4CAw8KLBYUErzwGXH3DY0LRW2Fmy9KVNuURoSGs897UpbbVYpR/M+K/u6pA13q6sepmrHOs1K31St1R0hb1TvLGg2rY32oOmNK9aVj8Oyp5P0nmERWb3PZ/2uR1xc1Aluw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by PR3PR08MB5786.eurprd08.prod.outlook.com (2603:10a6:102:85::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 14 May
 2026 02:55:54 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 02:55:54 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, David Lechner <dlechner@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Anis Chali <chalianis1@gmail.com>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v6 01/12] bitops: import BITS_PER_TYPE() macro from linux
Date: Thu, 14 May 2026 05:55:31 +0300
Message-ID: <20260514025542.398469-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260514025542.398469-1-mikhail.kshevetskiy@iopsys.eu>
References: <20260514025542.398469-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2PEPF00000B7B.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::411) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|PR3PR08MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: 39776c02-bf93-44a8-44d0-08deb16450e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|52116014|921020|38350700014|18002099003|56012099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: ah5w5jDnO41PKn4IbF6/R2THFdAFwZfRlaeQnprrpHmBEAA1xy9lqCCACBdlc2IqyAIvqrtMqWr4v7j6dNNEWQZGYIflLXU02NQzKgewAIiCT+jFEGx5FqZnhGHcu/kmeabC9yE38MDYkHHXojrvDOGoWPLZMfC+px43ItGAO/UpDqpaOX0U9mgZEJ71eKs3ySdhlzP71DQPYkJzGi5ielpj7pUluzW/AzWpXQPobR3/IANlA2HiwuG/UwLv2Y/y5ry8bnZvL+j/po4zIyzWZDJlue3cC5umjVzSQtktusSsxGHtBuxsoEyn/yW/TMuSFjIpVbvuebk4PcD9cBR7iUjR93fe8N+Sea+Zq1IMMv8P9FkZghGUpeMJiXzWO3F8E/Rk50ewIjavRyQlRzkTFUFpNHN07Lyy07LXC4wDHy0FeoY7V6UR6MOBoYwaktqWBneImvqrYqkKD5ZzhbvJa9lb+0bmUdEUvCho5/YSm4lD7W5A6cCs5xtlBufWR1RniY4d1N00ekrsafVYr9PEeWLazAp/X1ZxMC4+xNys04E5KwXESH0utmL64NfmGOUemrJOHfY5GMibn5MK0hU3BeH+nfHNRG3VJUsYjhovmexXScGDwpt6HUnKY1X5n21xhevbC4TEM03fKbqbcIdhU5WRiJNeBnGZQCroi1r9gn8jafoE8xNlAQ3MxnHmQpTNfnvBZuUFFjP6+o2lStE6JLYJo7ANNvRvnX51wwWiZXmIsYHC4idHRD3pGsRg56xigURT7FQMhc46zmoWhoWVRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(52116014)(921020)(38350700014)(18002099003)(56012099003)(22082099003)(11063799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F97fuaQP6Lbvxlt7UCKi22R9jxZz1Oppl1sDeMkit+A5yynu9ncO4MGfQxmM?=
 =?us-ascii?Q?xcP7mc0QyGawXX1wolfpZw2te7u+ItOjjEyk6IVMd7NpEDl5yd6/SfjAeS9a?=
 =?us-ascii?Q?+WxwgH2/pNFg/vVRvW5PzMj31xPLYPw/X3hP5pI65I5iCTP7JeQG+2Fl+D08?=
 =?us-ascii?Q?TbeHHB3cy9IN4L0wQTTNVtGTUGHU3/6SqB7o0G/YG+YnYmSm5TDiXFBIhl4c?=
 =?us-ascii?Q?0X4y4vk9WizS83JiIwDCODIu5DZ1Xrzck9SjDliWhLBSw7lT+A8jwCGlp0Xw?=
 =?us-ascii?Q?s7qOOktZMtErJ9NCJCeWNjAD44D1hYwLKSI+5QSj4S8TWiEU2/rcjYzOx5Gi?=
 =?us-ascii?Q?2WgF8MqVyR3f5h+uguRIhgKuxwWkGTZimlIp3crkPog2IMoO3i+mNL+Innvc?=
 =?us-ascii?Q?ttnWvYASA5DpgkQtq/mOCJIKdHAmxI/sN0Nn+WTT3kJVTMxImdxZHUHJEY0l?=
 =?us-ascii?Q?v6wsVBZ8gekCLB53heK8cMu71yeyKgmbCXkqVy5Mc2853OipC30tbV18kfsW?=
 =?us-ascii?Q?//UZdFlCUisM1/zpH3QFgtB4GEWS6lLvRY1uaGRFq7znPSgNAgpYxsClbANS?=
 =?us-ascii?Q?5DhhvseC272KDwuNrCUNhlndGu4XubLVR0Z+L8Mpq+buFQe3EkMxfP36i1jX?=
 =?us-ascii?Q?M8JyaebHDgsUMHRrAxaUychTziQai5Zz58rvgaZ7cG/Er50hKJU9eGp1fhI/?=
 =?us-ascii?Q?g9MhbnFuyY+V4xvUq1Juqtyw22nlxA7s5ZoN8df95K94/LDZlsUizke5a3yb?=
 =?us-ascii?Q?7vQ82pT0xwr34zdgwdcvn1Wys9R1Hbvgq7OKVsNKTACdidRplx3SVAKz13KU?=
 =?us-ascii?Q?gbhIyO47f6ZzyH99u4w5Jl7kiaVbBT1a3WshN+n8At756Fcswg9A/PkE1asF?=
 =?us-ascii?Q?8Ax7rDxS1jIwzgoqqdvhpcSoBfimtSXtwHDZQR+iJ+HWojSQMoMKHsxLsON6?=
 =?us-ascii?Q?bQ+yPqtsD7IoAg2aKN8CePYoPV/5tQmVSRQyFuZttlkZFL69SQ25zMywGRqk?=
 =?us-ascii?Q?RknoVVe6NRtGINtBUKYdle5lm3OqXwdvE6kbA1uLKn1fGEUETWm3uFTJz9/S?=
 =?us-ascii?Q?gPXzcxn+g80DZEaNQf0tXaZTy3g3heQy78HHUw2PMCumVAhQc6b6ZVyNGcM0?=
 =?us-ascii?Q?57L4kKNC+DB7VgAS6lEoNJMSS3ZZZe2ihqaWRuokjo45yGcsTQ/1s5HlZqFY?=
 =?us-ascii?Q?ywSlEcyLSlu0oIrIkInGZqKBs4JwBPhdey5AsCv9f3aMNs2IdZSx3OMlkkyi?=
 =?us-ascii?Q?fHc+WRvzkUjRHbuSsjH09Y9orTgf5aeLKO3cm82sTtJALvS7FAhK7+D0Cxpm?=
 =?us-ascii?Q?GhVsX3fW8vEiRpmzRJrjcqwKm3Ui7r6f3i5WBptJEY779XM/QzJoezbu4xIK?=
 =?us-ascii?Q?HkHRopCUDoIL9aVE0PaZNB9iY6tM1yBSI/P+hXKq6zb233UDThRz3CKiT8Yx?=
 =?us-ascii?Q?K7PsPDzzn5d+liE0VUm7UNneBaydnd/FcPDQdTQz3GqpYjgLKCcyej0qTDpb?=
 =?us-ascii?Q?Lskaau6nj/e+5HKlfqreIt4NwT7kwhEuAERLt6UH6eS7g3OUKYJ/PDnwMx0v?=
 =?us-ascii?Q?stS6+0gDKZ6fbuqCrardcomgCdbh51FyAWmzTi5GabrJgVpZjv5A6ol4LKgH?=
 =?us-ascii?Q?9GdQKzaWe6UUH2bLeJdWWsooXCdnVgH17NH4HKlNz2wPLXgAJyPcNKqIDxL3?=
 =?us-ascii?Q?e8IJgS6udDDcfmT2r3gwGvpKksx25flGUp/lJtyD8qKLb0a60j7kJmB/5RPW?=
 =?us-ascii?Q?tJvbDFvZ5MeaVyfyTLAVOYHYHFXoY5Y=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 39776c02-bf93-44a8-44d0-08deb16450e4
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 02:55:54.6407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUMGDT3PGvjUqY0/Gw7A2PD6CV//E8qeAczKr21sCwXFunDXAexiEF7u/+JSuug0ywY0fgI9dl+xsyJ2IsJjHL7ccZVyY3Fr1z+8K10UW8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5786
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

This macro will be used by include/linux/bitfield.h header.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/bitops.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 29e0da48de8..52eea4f8380 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -15,6 +15,7 @@
 #define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
 #define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
 #define BITS_PER_BYTE		8
+#define BITS_PER_TYPE(type)	(sizeof(type) * BITS_PER_BYTE)
 #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
 #endif
 
-- 
2.53.0

