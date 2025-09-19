Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8977FCAC59A
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 10:11:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEC2683526;
	Fri, 19 Sep 2025 12:10:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="TFnjeFin";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E71C3801DD; Fri, 19 Sep 2025 12:10:21 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E8D383526
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 12:10:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecN3X3hZhELAhMCDev5so+DHwn4QBxMvgfy6JpdM2XSNgwUvcq52b2e42qyp0g8/D+gS47i3dkTE7zT4lOTHhKNUT5C3kgB9J2ougxU1NM+YK4FTvtCb6FM2+PppXgl8I+bmC6D51KXG0w4Wdw8wV1ydQi5rGdH2yWvEcsEnLysphhuB8b6ON7Lx1HUeJCyP6JcY6USwcFceoECUgeCtLZWzEpQtwpGnW6IXCXThbjW/6pdTADuyua/JTYRIhP+0vq1M/RhB1pXSYaNtUOGo4aGpMGXfweMk6qiylZq/mQ81vzNQNuVY073TabfkAQO3hCpytN7NU2vvwvAlfTQvQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfG2DWk6lpcD441cQH+SSdOXbi01zyKmLH08nFL+/lQ=;
 b=byE9mJxLW7XdLjwolH+neWwXCKvqBWpj312Jgr8YpuWDI2C5ca9ZW6Pax5yjnFAecP55eJ775B/nQV7+OfMQYwFDwPQlH9gWDjfn2sZOYdp5puyG4hMW1S/l7CBDOiDpLTC9MDmBksYT9Vl5tDL4PX5h0onX1xFUEnyFi+nL66islZfQpPk8z3TGT4gbkNM4wKX86k3Np/8EY/C7ck0X8IsONLfPEHxGq18PK6Zabl8DVdFuD70sXQ9OIM+uQL8FQB4Ooe7KHm/3KrDWYvNSZI9fmC1ISr7gBu7iedKxaksQJsN07p+VOhZu354srtZC7Pit0noA1AQt0iUYyITbuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfG2DWk6lpcD441cQH+SSdOXbi01zyKmLH08nFL+/lQ=;
 b=TFnjeFinxHsmk7mJ9wT8KAPpxWVWtB8WCa3mswEi5Q4VrVi48+SkP9dLYCXxXqToBVF8nhVX/tB90NOljGSCd+qTDgKPwO7nTzPcRUcV0k8QN1ExQ18cme8q2ygyyrMdrM9GOFQacQhp2oejzfgTl4uT7GV/7WqsQ12Y3OP0ahE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AM0PR10MB3329.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:185::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 10:10:18 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.9115.020; Fri, 19 Sep 2025
 10:10:18 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 9/9] exports.h: bump XF_VERSION
Date: Fri, 19 Sep 2025 12:10:02 +0200
Message-ID: <20250919101002.568488-10-ravi@prevas.dk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919101002.568488-1-ravi@prevas.dk>
References: <20250919101002.568488-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0114.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::11) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AM0PR10MB3329:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c9f2b04-ea48-4d78-7dd3-08ddf764bc6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0ohXZcReiPrs8QTmpVow0QZPKGKI98ULf8umqTm4i0Ltk5CyakqNzQHKb9R2?=
 =?us-ascii?Q?9Z8mY1i3hMej+Neg6x+wE1pewqrjKd2hc9Kh3zxzmOgIWeFXEdTk7BeJl0b4?=
 =?us-ascii?Q?aUvd3kCQOrJ0OXozUMzpSjaUM9RRR8xE1rmTGqIiR+K0JEHhe7u5tkFi9BuT?=
 =?us-ascii?Q?ac+rJRG2Ip9KtAqT14zAJ3IyEweCDY2PePELeahZ9gnHR9RUCpMuBu9saQ4Q?=
 =?us-ascii?Q?/fGlKdAaGz4gj1Hb7j37u6vd7K2j5lFaFYJFuqOFo9pFKBqVs3AY7Zvw5wYu?=
 =?us-ascii?Q?jTNg+c1ieLeVAvVkEbHKiMNftbKpKM3jhsroFg4KWK5o3t8vdDfRMp4L0C5Q?=
 =?us-ascii?Q?13wOjelz3v4UkmpwWejYVzGQ6yJcq4pK5VH88LDpYFxtCrAyAS4PVMOLU3Qn?=
 =?us-ascii?Q?DMN/aSQGdeP/eYNuwKTPX35V4h3fkL7KHWQEwnZgtqbAEhP/hEyS4tuBc4Bd?=
 =?us-ascii?Q?xS4a/2Mk4XkN2TINjWqBVCyGQe9xlAKPFxB2pNcSuUHXvG9eqq6n/UKZfmU4?=
 =?us-ascii?Q?gQHNe3txd4ZjCXlaGVjF6doNBtJvlCIVJ+kCK8nQ4I+DBMVorGDFR6gfANTY?=
 =?us-ascii?Q?H4QDGxPKdUi1aCfJseZJxMz4p7KJoKHK7ZWDFBrAMgrAfXDHZjK5/6EKMwUY?=
 =?us-ascii?Q?RQhxhhO98fuLZhA/CKnV+gRuTbmwsoUhLTxF5L34+s5zzNCUnlOLB+PiKTW1?=
 =?us-ascii?Q?yAA0M2gZ3mPJAquCcdJ1xfarGNbBFU475P04IjITVkPbpSodaua6RpNQ8B0o?=
 =?us-ascii?Q?wb5twj0KliYwowAFoiFSAweAn024EuMyWxSVnZ85YXMPIPp9kFHKuwLZHNVZ?=
 =?us-ascii?Q?/urNJRyh9Tv9Ae/q6Xaq9Lm2GXuRajKsE2oTIer7tUmDgXeMuMf+fHaTDvWt?=
 =?us-ascii?Q?dziRs+Kh2wy/QrF89TTJqLLxWskWQv90M8bolTJR4W9Tuo1uIXcYAJlGU1Yx?=
 =?us-ascii?Q?saiIpPO9NevdwMup5/810iXJb6K2MozSFrfMVWhg2VT7RK0OsOJ8EkMcWw3G?=
 =?us-ascii?Q?RoLlsZeXtX7IgYATa97el1lQExaprupU/teHt+GdUDuPuXBebR2Jihw951jB?=
 =?us-ascii?Q?L4J18JN11vLgYO0e+TBKv5p69OvOzPaqs/auCLIjsRD5KRJgWDwb/bbwULnb?=
 =?us-ascii?Q?pudZ2RPpJ4WYE1PZ63/XBG2DHTYscTinerzwOy3wmzm8xygPoXm3Q7/4o8zb?=
 =?us-ascii?Q?EJXOaEQTY5WioRqocjoFrnwWGj0inCygYxzuD5RMG+A3uFZpyr/bCwKIL5Bg?=
 =?us-ascii?Q?PObaIi4Oh9HZ6jmWa67OYmThRN/rClgCS1Ws37TFnINLl6zXZhpiK0obe2RA?=
 =?us-ascii?Q?PSOWFCq/UTrEflOYAFFpzVLVkzH6JJ8ETNhm4LtHejwuIPeEh/FlFRbZ4qXQ?=
 =?us-ascii?Q?7EphBfYk7nDnRS9a2gCkkExDTan9ZDrFGaehtlYSjFVDqGnXp/XrS4yKAdp8?=
 =?us-ascii?Q?Ovd+Sq+fE9F85PSveu4/DCzW4l4osk5gzD+DdSxUP6e4orNq0uOTKQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iK1h5F2r7BvysWDF3c6bXh5Gsgve8t8PWdG0BW7NLsnH2nfNG/Gaa+005MMT?=
 =?us-ascii?Q?IASievD2JiwxZRhxVnTC+89Hw7mHBHNKMqoC5IBl6KYL2LXMFtjQB89AwZFu?=
 =?us-ascii?Q?ynrJ5ou2w7Ry4Q/FkpIcwzteqSndyQPRt1htQsdRi0vUSrhuBB/PiEYFHp+x?=
 =?us-ascii?Q?LHDvY/HzpQXILag6de+J0AFSiVxuKFi2Bf7l2rzWG1HQEGhvobPd4HHHFU9w?=
 =?us-ascii?Q?e7Ha19W4l8aznzuTUjwwmX5G9TaB4qPQkROINGegT7UrH++TKOY3l66jAImM?=
 =?us-ascii?Q?43W++XWfzXpnbEnUzPdlgrtpogkICc0AkVmvW0R6Sj5UE3vBHZkgytEPnzfD?=
 =?us-ascii?Q?v6IxQvIRb4ZDHS5GctrQ284iW2zABiHk9bONZvMABMNCBgFKcubs1m+WqpFJ?=
 =?us-ascii?Q?3leWZUEG6v5npSh2a8UY2Uno38Nq1C6FkNhkUTz7w/HEPrCrA7s6CA9ztVqb?=
 =?us-ascii?Q?4jCj/KHRz01uunrq4Rpv5kAfetfZluf1GXOLiurDngOZX24tG80jcS/RbB/e?=
 =?us-ascii?Q?RwAZ2kebfnNDMO8ClQLIFhwcEMgGkRVS5aqoJvHo0emKlkezrm8P2o1EFlcj?=
 =?us-ascii?Q?jNs5djNc52Td3b6bYjWlq1wp7Mc6jMONr76s0Tzst0jIK2Pzh0DdSbv63VBP?=
 =?us-ascii?Q?HwZF6vCaE4QEA0AxNlrcCVmfaqvx2RVaHVxmadXk07BlcGm15vtZwTUWibOl?=
 =?us-ascii?Q?PE8bCyBz1aFxYAi+BKKRO0mQw6XpNe87DLYdrIZbp0kWjHWdJcIkOBiHjgvb?=
 =?us-ascii?Q?Vf6IUfaSddvdsp5OKmjop6ZsmL/t1MUKfv/gu2+YhYwVA2aIun6T4VVCUwge?=
 =?us-ascii?Q?rXAIrBe//6Zjii3bXEXJ6ZKjPUp7poL74oeZp3Vy/rrjtnDQm2fsqFSyZwLu?=
 =?us-ascii?Q?lBFDadj/a3hczdTAsZAi0K/ETlUVC8+HeuT2x3U6xEN699/eWk1ibbuZfMjS?=
 =?us-ascii?Q?5kfVOLbXTBZJFDSHrmj1seBIoP+zWtEtvAZDPtb0KHvx4WQC40qQuFDIfq9Q?=
 =?us-ascii?Q?GVi0E1q8NdyW23d9r4feL6zCKViaUsPgAtneYMgg6obNUPR2b108Rh12GQjI?=
 =?us-ascii?Q?FfDu29Ej1v5t9dBX7INGKtxJvv4Vi+ViebpWlQMjcdOMWcSEtfddUiX8KCtM?=
 =?us-ascii?Q?bRLsLjvAE5AfMkMubaD41arFaiqKF8ahx0uPyxbnYpFE9w9woQ0DhGtxwnRn?=
 =?us-ascii?Q?uJ+Hi7nCc4mj3CBj8fgaWp29HLcSQZckw2thcRL0PYIHbNXE8JEaAjg1h2kj?=
 =?us-ascii?Q?2QrSv1tmuXUhaClUoABBTql+1BL4XkJFnilTBO7LA2Z+PSAIOTB0Bkiu1a/B?=
 =?us-ascii?Q?IK+Sb1bxM2VkXQf949Y3Q/sbj8ki9Y6GTqzMUgnpYRFFVjghQ5+oqozhmgzN?=
 =?us-ascii?Q?muyXKTTw8wxBVVPx8AaFbHvzPzHxOSC1dOJPlK8cUFvWEmGtuGsJADFevO+A?=
 =?us-ascii?Q?/hULkW3akQl8zeWU5TFMUBjDlR0Wu0tuibYvIrW+7Y2TpfquemDFu54sty/G?=
 =?us-ascii?Q?4wtAOPO5MW/uFOvilVvDhdtCs2jqiIvKcDmTEaY8rSJtZxZlGplJhx4iu2bm?=
 =?us-ascii?Q?Qkg7A47SGeWl7ValBcy8AOCPUMTIv/fAS56BmvUDKf6oObZyRa5llEftw4if?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9f2b04-ea48-4d78-7dd3-08ddf764bc6b
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 10:10:18.7738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DA2PDcSjp/6PFQZ0JuVVLijm7b4Zs38u+xJJ4HFd26QCI3czKMXsAFaSuYFVigxB4IvqPeWiE0zanlZ7ThQkH+n65rgPdl9d8qxatnpIyNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3329
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

There have been quite a few changes to _exports.h since the last
update of XF_VERSION, also before the previous patches in this series.

I doubt the mechanism is actually being used in practice, it is simply
too fragile: Not only does the list of exported functions depend on
.config, so with the same XF_VERSION the jump table entries could have
different offsets. But getting to the jump table itself from gd to
even call the ->get_version() is fragile, since offsetof(gd_t, jt)
can, and does, change. For example, as recently as commit
d9902107027 ("global_data: Remove jump table in SPL").

One really must build one's standalone app against the proper U-Boot
version and config.h. But for good measure, do bump it now.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 include/exports.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exports.h b/include/exports.h
index bcf170dca87..12abb35643e 100644
--- a/include/exports.h
+++ b/include/exports.h
@@ -40,7 +40,7 @@ struct jt_funcs {
 #undef EXPORT_FUNC
 };
 
-#define XF_VERSION	9
+#define XF_VERSION	10
 
 #if defined(CONFIG_X86)
 extern gd_t *global_data;
-- 
2.51.0

