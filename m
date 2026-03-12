Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238CAFED2FE
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 10:01:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1F278420C;
	Thu, 12 Mar 2026 11:01:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="H3JXBcI/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F3E783F2A; Thu, 12 Mar 2026 11:01:27 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74E3B8420C
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 11:01:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YtXi0VimFHuePMNTwN5p9xLyu4hZQDvd3GDGsB2rD+7Zs49rcwvm2qmMjPOxEgh8SKOYQJL8smfm7JiHBsqrWodLqjBfz9ThvLAnU5vl8V/wgzB6C/amSHw22KpnC/iJyWwnErj2TGszOXxHZtSCRj8VF7rAOaUZrmhJqTYOsio3pQZqRxDYH7PTS1EwfVHrP41kzp27xHz2IBhZ+soUvIdLVLrBIRDe8j/BGrjEZWCI3jruJRAMCFAYlyhgj5pIC+00iiMnAjluJvHmRpmKqSHaq90mzlWPUYSKmT2LUpXi/7AjY46V8kqZ4dl/ZPQprxCuCekOjw7yz7PxQyqFiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Pn4xDDqjzZgmidy30alrk9mcoXhODsgURKf8dlxTrc=;
 b=MKL8OyIOJHql02wbiDPdsOqdKsy5XCKGS/aXp7JS1g8Vw8IhV8mDggGXcNNS1cKtzJ2YK3PHw2HaDeewMUVwwPhegHNRovucxzRwXytuZi2wvEUmmP6vCfqSQ1biCtOrSAtg+5Tr5opXsdlvaE+yUwfZZIO+LVF/MaD6kYb912go8F2vSNxLGqDAzfZD9/cNV5zNHDSmC2LXlBcvFOpJX2EkFkChrjoaRWBCtMeHDZyfITJFEcOErWWABvGc7R46nsJI9Yml7X/Q/NLC/vt3tZU2pNPzaAjJ46zYDQW52X5yhFpzpDPjtjj19ZwjriTvXxdOpx1TnIZwtZ1fASqOxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Pn4xDDqjzZgmidy30alrk9mcoXhODsgURKf8dlxTrc=;
 b=H3JXBcI/7JS8QWKus3v8bsEyhv+s67MIQiRRYy3mnVtSm33U7sm2AVkXTBhWNx2BMczdD8U2WIKcKR6N8xaCVWc9ghVGRVJJnJSxXZsIG1qYrkTV9C5bP2DHMcKKZ8cfKqw1KIoZa6FKwZSZIX4w3Brr1cPQn8YR2PtBTxj0diA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV2PR10MB6694.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 10:01:22 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 10:01:22 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 4/4] cmd: test: fix handling of single-argument form of test
Date: Thu, 12 Mar 2026 11:01:06 +0100
Message-ID: <20260312100106.702368-5-ravi@prevas.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312100106.702368-1-ravi@prevas.dk>
References: <20260312100106.702368-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0067.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::34) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV2PR10MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: f777a8df-6274-4669-5d93-08de801e5071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: /TP6s1Rwg1anYxbQ5U17X/qEo0P5bu1Uv/l4LMzwc+wJnjFhcCah5L4sbioeM81hAXL1yrI3x63IcAoVXqVofjhbBVncLmKoPIE/fxaejiKOk+AGIJbv4d6pbU3JaW4Ic/HXFMOsqY8379NF2s9uHMCZeKoLkjEFpvzr9lMC5aHSL+NZPDSmHmmyRBvvxqtOL0gGWIEHcTfgiapaPhAhbDgA9lWi7JkQVyCZSulhI0vLz2P/281MgOrc8Hw0VbnvjDidWgzoDKBKSv+83lB7TGbicfRjQ0MGBPiQzyQEfnw8PTLS/+R5VZIf2VZZUpM6EvjOTaxgq0XpVU5o2ZGOuteOdMS2CQU3VGhpllAm5dPfK/JjSH1UPCzsUQoWuNwOR2wOlITHHV1EXEd+sBl8r5BFrZcUYZSIpRDZyLYZSSxfNj4GgXOgFJyScMNSnXlPlEH/UZcDplfCqtgyI5Y6zPCXd30A1Cmecy8nd2FrkHGcCmOJIyr7njo+kWymYnvcNkAVClVb0j6aZ3wEURyvMCjwHPn85KMtPjcbWVhZI+A5vnhyq9Y3WEwMoTgEEfD7OxIL1YyCtGUGpvF99NTRt1ATSYNfS1wRGnUJXmjHpAIeAC8WEhymabaReWRV/PzUkomdtV+Gm6fx+GhJrGgJq2cTGAGh+x4g3EnjJsJhWWBDYGwu2wTaCBTUscdspCEmi2IxBq1k4mZK8vGrStehiQYg7FDCiZ5rRSub5iuve/McA2TR0lbnvYXlO3y0BnIxlPAYLu8tDvLCtr1nWkKIxjNPE1J0NMZygwwuSv5uh3s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I1s9b0olBAcUJAjuhCtUsBxNOzaa1evV7AuQKUew7+KEuXhy/0QEOVCr79cC?=
 =?us-ascii?Q?/zEXidisq4ZnFhqsjRegYF6KVNj1dg1kc4xXNgn91gOTRyrhbcFV0lqiITql?=
 =?us-ascii?Q?M88ADYDpUO1yc4fcOsV5RasGp/P5CcHQApv0MczhndfKCDJEsMiqZrGBuRZC?=
 =?us-ascii?Q?L3pNqE7tY5Eu62hTa8kCAr4HTUpFnpeFYFGFFCSFvFv+d6QQn/peX8bx/Mgk?=
 =?us-ascii?Q?TAS9Kp9O5g/ArC66ReULnFthPhHS6ugUUxUMKQCwFnxV4MrQCvbyIJB9odZu?=
 =?us-ascii?Q?KdtzLTMe0HvaXegiQ6tMWMwtBo8yF0PbQpmAShsnFsqwva5SXshPyOjs1bje?=
 =?us-ascii?Q?siBW4pfCbPN0/7gv1TPQB8IqOt2f4paXBguorWFeK7Q1i/lkpi/np4pLCK5k?=
 =?us-ascii?Q?psi0wgbGakMC7SJKXW30LjZjxEpEAGEjv02CvA1zEPHmvY0z1tnHK5Ol9sAe?=
 =?us-ascii?Q?Jur1FWOVUgKl2aZAtcUXwV7aOC3214UxcRTdvb4IZxv9YiN5VTADuKBE2VUC?=
 =?us-ascii?Q?aSOZRQ70h+ok1Hzwl4EAbMfihxs+45oZ5M+/FugfD8n8ERAuu/i23YIveuWp?=
 =?us-ascii?Q?UVti6UGulZSFk8gJvCcrUMmHd0Qm7V2UQ9Qh4BcecK2MaAV4tZQTDxCxgmUc?=
 =?us-ascii?Q?xb4Epve0GNVbBnU0x6ibFGykAYT+VFGjBflubRLuM5TZ4cFd5RLyigqW68EI?=
 =?us-ascii?Q?LrZAGNJXNv6seY0e93b+Q+NCxJ47GJLiXS6+s980TFVz60Ho6T23ly1lzlxJ?=
 =?us-ascii?Q?wRPWCxRVxOr5PRqL1sgngXrU1/XzGONN61qvzetypSK0G0+g7tNE7k5nmPLw?=
 =?us-ascii?Q?+LJA4qnDtztCHQ5LYLwmge8cW2M6n/joXjN5Vz13Zl1PLBFUSA5IjYtwixU0?=
 =?us-ascii?Q?OdmWN8LFR6iTEdFBmI9CjHQnMVFTc9fe8Q8XMUnZ0NG+YivDm6QBQGbhnjWz?=
 =?us-ascii?Q?N/I+8JHzdnuqbCwVWrNeZYPdNaSgi5jwgBmX100sPEccBuvaxxyA0NkMfXew?=
 =?us-ascii?Q?8XL5VDolBSxmud2FV12CwCtKv9ahR/z+2+9ED1FkZQoaNF24WIPB1Z0IiNrQ?=
 =?us-ascii?Q?zoDRvFOj/9+htNR1EHca2hrCZzkqlsKjoJESnkVlNss34l6bPcbjAIOtfyXn?=
 =?us-ascii?Q?lalAwbFZ1CiD5UMM9zsoeR44zAQAMiXlSq5KrCLHftfr35CFV/3GqyG5eG8O?=
 =?us-ascii?Q?TOy4wBhApXlZ+IR6LfbxeJ4ism9uzJjlMdfeRIeVjfV3kVK41mgCjxO00OrW?=
 =?us-ascii?Q?7qVKrC2UhzVi5A0lrokoRLLjGqt7o3M2ded9/XVGHn/y1CjQzljfByU5CE/A?=
 =?us-ascii?Q?bA8rlqnvR87mnXC/ByRM54QF3GG8wEkI6yRXeg4oTxAyShm6cvQRwvk5XDM1?=
 =?us-ascii?Q?SMgz2R3862j8ubuAR2iZff3YhGuzo8xkM7jZF6WHES0z/eM6ENrxEpzpNYzI?=
 =?us-ascii?Q?ke0XiGFeSdd6a4J6gPcZiVhkMQv2Zu/gef8RQw9phzljgXgc7Fu/w2hcUC6w?=
 =?us-ascii?Q?Mtf4E4XK47cD9m380Ze89YOWB6SoHsLXFsnRABmYtADn0MQX9ZEgTnhNxStR?=
 =?us-ascii?Q?DWr4Zr6kpjm9OE5RldXUk62witAqIp35GroaTulw54zAeFIUjB6qPJQd+NZu?=
 =?us-ascii?Q?kFG+5L2/8scyGv2zY0ApIethCL1BC58XgA5oeouUjFED+XwY9PESku/zLDi+?=
 =?us-ascii?Q?j1Inu8Blawc4PLLqJd59HWOVAa7kDfT5kWj5JREMonUZTAwUtoV6r3DBxBFb?=
 =?us-ascii?Q?s+7h7Qm88P2ui3uhggVbNdIC02j69ek=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: f777a8df-6274-4669-5d93-08de801e5071
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 10:01:22.1875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: djbEPEvWMUJI0DRVXAbQC1Rsaq7ql2WCXRySF1fdqQNp7LPglcOJvbUsnU+Lg+OznT3UaHrVjYKDgiXAgYLJ8ytWomvStGvO6MoeO7NCh78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6694
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

POSIX states that

  0 arguments:
      Exit false (1).
  1 argument:
      Exit true (0) if $1 is not null; otherwise, exit false.

and at least bash and busybox sh behave that way.

The current 'argc < 3' does the right thing for a non-existing or
empty argv[1], but not for a non-empty argv[1]. Fix that and add
corresponding test cases.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 cmd/test.c     | 11 +++++++++--
 test/hush/if.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/cmd/test.c b/cmd/test.c
index f0645ef98f1..0d0f090386c 100644
--- a/cmd/test.c
+++ b/cmd/test.c
@@ -71,10 +71,17 @@ static int do_test(struct cmd_tbl *cmdtp, int flag, int argc,
 		argc--;
 	}
 
-	/* args? */
-	if (argc < 3)
+	/*
+	 * Per POSIX, 'test' with 0 arguments should return 1, while
+	 * 'test <arg>' should be equivalent to 'test -n <arg>',
+	 * i.e. true if and only if <arg> is not empty.
+	 */
+	if (argc < 2)
 		return 1;
 
+	if (argc == 2)
+		return !strcmp(argv[1], "");
+
 #ifdef DEBUG
 	{
 		debug("test(%d):", argc);
diff --git a/test/hush/if.c b/test/hush/if.c
index 5f75ea68b32..6129e2c530c 100644
--- a/test/hush/if.c
+++ b/test/hush/if.c
@@ -32,6 +32,15 @@ static int hush_test_if_base(struct unit_test_state *uts)
 	sprintf(if_formatted, if_format, "false");
 	ut_asserteq(1, run_command(if_formatted, 0));
 
+	sprintf(if_formatted, if_format, "test");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test ''");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test 'abc'");
+	ut_assertok(run_command(if_formatted, 0));
+
 	return 0;
 }
 HUSH_TEST(hush_test_if_base, 0);
@@ -355,6 +364,27 @@ static int hush_test_lbracket_alias(struct unit_test_state *uts)
 	sprintf(if_formatted, if_format, "[ ! aaa != aaa -o ! bbb = bbb ]");
 	ut_assertok(run_command(if_formatted, 0));
 
+	sprintf(if_formatted, if_format, "[ ]");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "[");
+	ut_asserteq(1, run_command(if_formatted, 0));
+	ut_assert_nextline(missing_rbracket_error);
+
+	sprintf(if_formatted, if_format, "[ '' ]");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "[ ''");
+	ut_asserteq(1, run_command(if_formatted, 0));
+	ut_assert_nextline(missing_rbracket_error);
+
+	sprintf(if_formatted, if_format, "[ 'abc' ]");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "[ 'abc'");
+	ut_asserteq(1, run_command(if_formatted, 0));
+	ut_assert_nextline(missing_rbracket_error);
+
 	return 0;
 }
 HUSH_TEST(hush_test_lbracket_alias, UTF_CONSOLE);
-- 
2.53.0

