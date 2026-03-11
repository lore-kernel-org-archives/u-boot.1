Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50634106286D
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 12:09:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A0B583FEC;
	Wed, 11 Mar 2026 13:09:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Eu3DQhZ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A463983F2E; Wed, 11 Mar 2026 13:09:21 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9602983F9B
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 13:09:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkOO/NgXW70jfLT15avLwvn9/b57jAD6Tj4scY9j9GnBZfupHLYGf8XrxmSyUPZKN6hcbssTR5dOVVjyshmkkn0T60FZrlkcX8fg18ohGKIXPilBeqP74f6eEqPMlaE9Bg8Mi5q3AE+aeBL/vRxhr8NcjQTwN+FKuY/+z0oE30r8S4N85enPBVq3H7yOo+9+cbL2ck+z2eyKnbF6tdSnQwI2gLTH84P6i/6xSs3KL2uiyFD+CjZeHKJ5151/AsxuSiDnzZE+7p4dLTFKzLKTUYGN4eU5hVtx80BQpZRovNdyYdZEFQ+md98gI0/b/6eQ3h/tzgjHR4QhIqTs2M8O7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EonnSOuB0H3757hBlzlGZ2v/wIGIMM5tZZTXvY62ye4=;
 b=DNaTHyU5nPn/3e2u6GPMWhhcQQeB2RCaW6xQMOv9L0Fw/3MTKkRUo3sLg3z8AJ8lWqGK+vFz7rYbI1bKuTlBvb7soUIWUrSixNRraP6wp4vKqplJJ+gdBQDKdKgAWH5P57tpoT+iZjcv4PYik/oo/u0dyWRgNWZ1P+0xXXoqUAYbS8xoyyiq5WcHsxzALuHns2TPZgicugK/I1oPbyA43ltSJ/CDsVUoM3xGKI68aCkXTlM4B/Be5E33jHhY78uafFB9xjQh0O2CTMiu4qjoUJLLVsJ4dVUWHnvu/wKsfGC6gj4Iqkttn727KymSIbmLP1x4aE/l4T+zh7dmfOvKSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EonnSOuB0H3757hBlzlGZ2v/wIGIMM5tZZTXvY62ye4=;
 b=Eu3DQhZ+uETn94EjYdHr08VR6t0e6PGJCp14uUufn3sdLSWqZfhiV1Yo9pQj/tAavOtQ7dBOGMwLEnhq9qI1GbxsmZaXmnpM24T6I9WtnJ+eSKzbelflyPaFR9iVzP2TUIFCwWNpNqDNzEV74ZSJVNGagk9s4qUOFXLSASqRUQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AMBPR10MB9706.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:769::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 12:09:18 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 12:09:18 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 1/3] cmd: test: allow using [ as alias for test
Date: Wed, 11 Mar 2026 13:09:08 +0100
Message-ID: <20260311120910.3934114-2-ravi@prevas.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311120910.3934114-1-ravi@prevas.dk>
References: <20260311120910.3934114-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPBP307CA0009.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:1::12) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AMBPR10MB9706:EE_
X-MS-Office365-Filtering-Correlation-Id: e8bb5b12-01bd-4058-c945-08de7f670575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mBSipyAOGYnn+dIKoSbVFXdSvvga9NUE19gYS0wcz6aijrkGk5Vk65ikcxixNshhK8MXxDSNGMoK/I8ZR2CNbLKPDOw4gDoME5Fu1Ri26AXv1zabrHMlvkDlH6iwQW/4Hkv1tDQOOrliI40XIWavCZHamuvCwsqw2n1d6lcE3YAQ3YnwDxzlXps4PuOQnzUTxHoozdb86aZZTcVM75nbjG3LMCzk4Xf+SiBgCJpoM9LzM+1AxTxzIM3F0I0h+b3qX5UDhvHnZ5wC2GT3BQKcx4ePlPi4iXy5ZdskQxa1RUXpg3XSdqEEuw/BGPTXznTzvPAL5pn8yrXhPjj75CwOWNEUD+so1gL4VohBkFt/+M2i+FdWPP16tmP2axd6/ARGEDI5TlIFJSq4sKJjjs5/UjEzLRMxtiCYZ9pZZvMztX/Yn8ahSij0sFsMsAzmbvjNpxAA6WRp5k2qCRLzzkUqlsW53b1t722E1ZGqZCWwoUQambAhspB6urO/mgV/ZiZhOeLDRqpBDrAZzPzDLA2HfYPreV4JlmrMe615TtieZyhXdVH//BujBO5UAMQK6l0jVFQV56zuRPa8NhnwFbHXuv7aUolaR+3sbecm6zRFNsNoCiJF4bTvqAAKSm3BO+WCoSAgQ1GN21oynVGa/bYu5k331Di2CmtYkZFxPfR8UQbNu1LgZ0axkbrmi53i+UWRMB3/cMU5EDS4W6GElST8w58JqYrAjQaXMCZ9mF8QYWWqZXOLSpzbnqdhCjM0hCofyZmTx06gNZMuy/dCo23vplMdjXdmFf+kK7+Bb9y+5kU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FJLNLy9K3q+hJprMf9fqouui5dFISQD6nSNTZ1mpoxp63cWeNgqequMCsKkI?=
 =?us-ascii?Q?4UDH/FLfNML3P/1eUI1NZ7m2lZDK3LpNWPw31hWIt5NxIEnzpZogmpcsRMj0?=
 =?us-ascii?Q?iPdFSF/0sFWO9++Enxwzej6Hk5lYx8IxiSEXtc3fMNUakj8JiFbO5Ev4K7xT?=
 =?us-ascii?Q?7CpldT0qCu90hecwphYlTM8iUemMhp9WpRbW2uOpIULO8y8Uj17g0aGmXBpY?=
 =?us-ascii?Q?lH5L+QWEdJmVuKyNotr0H7QZeWXSB3UqqUMv3MYd/sQZlti5l9sJjx3HtYVG?=
 =?us-ascii?Q?wSO1spZ/PDn9V0K+GVHcCksRYbyT0uN60gw6IXrHcsJBePjKpMjRCN76297I?=
 =?us-ascii?Q?pFMyEdn6Fau8Ki1v7UhV0qo0UC7oV1BX+a768T/pew0zEdjwwrEgRuwH/2jM?=
 =?us-ascii?Q?8xosSr7vnS8KsPDmOqPcZPOO+cztWsGwUW4nfHp2nUHSsO/Pbi5KnSmaVusx?=
 =?us-ascii?Q?hRSFWveP4/WesF+WMDPjeuyNrIndgOs4BJj6snByWScIn4O3r3YbHzU7sKGN?=
 =?us-ascii?Q?EZ2cBFygnEFitbqozSV2sQrasSA3yqO1jO5w/279vqBK/ZXZugGC7KRmA299?=
 =?us-ascii?Q?2U5Qe7qrj1Z6AIi71R8mgwtd8QGt6CGyZOysRtGrIc88HHH6/k1zPpQ27MLN?=
 =?us-ascii?Q?nTYw43aZsn/Sa021l+OEwYh35Yr5MUasyEXkQWoil/AonRqml/+vPHWc9zh8?=
 =?us-ascii?Q?giUPOG0hJzi5LN/66OafCRjmwbzvIfiWQa7cEZd7qk7wUwKwnKD/8Y3ILVyi?=
 =?us-ascii?Q?b58M/MO5g2nB2r0bg1blAsTj+4qLU11FUs8Qh3n/98Fbib0eNjKWH7MAZu+w?=
 =?us-ascii?Q?NLSc++wQXX/8g8TectLgsVLq0JDZfRhZsJynO9TYKwo3ta1fpyP+vZiJqIWr?=
 =?us-ascii?Q?4OAV6pkMFrcA3ku28lNy7tFPV+l4gRhruSk9QEI0g+6CdYriElzTDgqkr5B2?=
 =?us-ascii?Q?MGctTxhIosHlQTvOzIcaBiV9dVI4X0QWdIZjczvMq8PcsS5L3zv8nqfPYIh9?=
 =?us-ascii?Q?8YQXvfDLej/i7DMgHPIo6Iv848ogPifaXh0IjAt8GKhqlkuML7br1em/kjrO?=
 =?us-ascii?Q?Bch1RVVYth+GnLEmjUBfswQOW3DkQ1J+Fvrlvsi9Ga2xlvVsUoBHq4P+60uE?=
 =?us-ascii?Q?o6sLEr9tZ+BpAwv3C9mBeUD842Q3OesLapwMczhgLW30j1ir2uZ6QadgZuSS?=
 =?us-ascii?Q?NcfdwFaiUnd3OC2QUWYAmvdx7UpwRgQiYlz9V4qXko9STKfcRVQxWtM1DoEE?=
 =?us-ascii?Q?/yEkzUrrV/Xx3idBvCvwcgFrOUAGs9EL/3ZhQRIFlIs0EALKQNXxED+xS0ny?=
 =?us-ascii?Q?Kdi/YI/4eoEdMCPhEpREsGhSwWYzfQyh2To+4ruSQN221xHptygTDEURlKdy?=
 =?us-ascii?Q?iAZyUAMQO/S1ATEfN4SICXjQz6bAtjd9FqID4DR0tW70dXmZ32XEP1VkAu5B?=
 =?us-ascii?Q?y7nuli1uPUr2l1Ca1hFUl+tO+B95FfLY70lZ+NuMnemPfA0rqqjO8SgCiBxt?=
 =?us-ascii?Q?FdBpY814EjQ/OM/ueG8s7AQr/Rvx6cJfHTd2t1zySMRx9Eo7rj/4HQMaRzXA?=
 =?us-ascii?Q?hHTWcaKh4KsEP/QcIhBDwGpA8/SdW0Evy1aWWaxKYOwJtweuPCYi+vZwXPiI?=
 =?us-ascii?Q?muyFoJ5Ton/j0LzF04NHCIW2Be+iRZrBr9J2m2E0fryzxcOrjxbTHgGjzcEi?=
 =?us-ascii?Q?/mcbLLWbIg+9YPYxBQABR4mZwkNZ2SWnhKpX9WNuVSpFprM4f+kbKdal4Vun?=
 =?us-ascii?Q?3YOVBbyvwnEtjG6tCKCfVE85yl4jc4s=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: e8bb5b12-01bd-4058-c945-08de7f670575
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 12:09:18.4693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJ2z1bnkCAPt8ql2yC888K6gyQIZsfEN+N+thPqZIXUL+o5MMtvpWR6xvpV+BcmVFqxPKeph4Xl6IgZLB7hdVDvyLjBH2GcEGf+eSnukmws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9706
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

I often find myself writing something like

  if [ "$somevar" = 123 ] ; then ...

only to realize that that syntax doesn't work in U-Boot shell, and
must be spelled

  if test "$somevar" = 123 ; then

It only takes a few lines of code to support this POSIX-standardized
alias for test, and helps developers focus on their actual problems
instead of dealing with such unexpected quirks of the shell.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 cmd/test.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/cmd/test.c b/cmd/test.c
index a9ac07e6143..f0645ef98f1 100644
--- a/cmd/test.c
+++ b/cmd/test.c
@@ -63,6 +63,14 @@ static int do_test(struct cmd_tbl *cmdtp, int flag, int argc,
 	char * const *ap;
 	int i, op, left, adv, expr, last_expr, last_unop, last_binop;
 
+	if (!strcmp(argv[0], "[")) {
+		if (strcmp(argv[argc - 1], "]")) {
+			printf("[: missing terminating ]\n");
+			return 1;
+		}
+		argc--;
+	}
+
 	/* args? */
 	if (argc < 3)
 		return 1;
@@ -212,6 +220,17 @@ U_BOOT_CMD(
 	"[args..]"
 );
 
+/*
+ * This does not use the U_BOOT_CMD macro as [ can't be used in symbol names
+ */
+ll_entry_declare(struct cmd_tbl, lbracket, cmd) = {
+	"[",	CONFIG_SYS_MAXARGS, cmd_always_repeatable, do_test,
+	"alias for 'test'",
+#ifdef CONFIG_SYS_LONGHELP
+	" <test expression> ]"
+#endif /* CONFIG_SYS_LONGHELP */
+};
+
 static int do_false(struct cmd_tbl *cmdtp, int flag, int argc,
 		    char *const argv[])
 {
-- 
2.53.0

