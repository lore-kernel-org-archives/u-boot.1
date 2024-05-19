Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166C2C25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 19:56:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57534882AA;
	Sun, 19 May 2024 21:55:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="GxCCxL/g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56D0C8822D; Sun, 19 May 2024 21:55:49 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAD6388223
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 21:55:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dj39VFoWD2BkqgU6EVrDYispZ49LJ09s+MuT2UfyL6Esf7MMjCMPcwqZL0tiF6qr+7TgB18YwEggJELEharpuK+p4nuBBNWeLZczPjhbRetXHfUBpQXZWz7aZKwiu/vNbftOUwLS4KaW1Svhi+AdNVw1m8Cl7eUFzeuj6pNfE1ISDVrdiyAT039o+1aJWCUxXmV7+MJ52smo8bIjpwrjBfi26uTpnAYjvM2kVt1bG3N2eMhuRWtqqCyEKYn6Ok/tbqJ7HBRbWUIpPAQUfcfQIkba+2VMDsLLc7xEMus3NxXUI3xAgHQeS7duaVa26X8IBpIGslbA4F1tkhLfNNDBlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UE40nuG7Vu+qqaqGdBU4hU2mGC6HGPVgb4Xrb/CdMPY=;
 b=BWvMtUKtL4e8pnfLe+VbyyrOi+pnqvWSqb85jsh91GSmSqUZchdOkTfDuaIdv+EcnO+4EUkB1K5Pyn5SksnpGJyThir5KVThUE/SbQ/xWwgAfWwn1ozCKfjcFd6hjNm7H6qgoVm2lzOXLcvN1aNekJF1YL6tSf1avyLEm6MEjoCUgU1hqdvALp+58OZRSRl+ptMMu5P1v4zRwd1rmwJh3rqLuQssRfnQn0UEZFDY3+akZBfHDFhYnS6jBf6E4C5YdUw77LcNxxCFdvroRU6mjfH5kwlPfTfRwp9X5GsRzEaIsyeiDZ0xikyt/Utw4mzo/B6d2vTq0uB0EG+OESyWgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UE40nuG7Vu+qqaqGdBU4hU2mGC6HGPVgb4Xrb/CdMPY=;
 b=GxCCxL/g7KKCm9XOcaMG+d/i1jA+08BWWj7t9lOHC8tmtydWkLM0nLY30VyxZZJvj9/wCR44UiSs+XPTFH3VDlopyg2gkkijkioMhrRNbKusdDrizx1oBkqljzH4rQF0RB8FS5yqp9l4w8fqIN2Nka2lQiwFYebxxYadp/cV0wU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AM0PR10MB3716.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:156::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Sun, 19 May
 2024 19:55:42 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7587.030; Sun, 19 May 2024
 19:55:42 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v3 3/3] cyclic: make clients embed a struct cyclic_info in
 their own data structure
Date: Sun, 19 May 2024 21:55:32 +0200
Message-Id: <20240519195532.1648830-4-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20240519195532.1648830-1-rasmus.villemoes@prevas.dk>
References: <20240519195532.1648830-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0105.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::14) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AM0PR10MB3716:EE_
X-MS-Office365-Filtering-Correlation-Id: b622d1c9-da3b-44c4-22da-08dc783daa39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|366007|376005|52116005|1800799015|38350700005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VxzTVK9N20fNwN2dhRJCMOBr0/pAFClai+adWZSXPX5KWeLVSQIlMONuSw9p?=
 =?us-ascii?Q?wErzD6RbB4zCjT0jSWuJBCGcOFdT7PQ9oUioAAW0sJoaA2a0fxUOlV2pXsyK?=
 =?us-ascii?Q?TohDS6kMWUy9Uli43TVrDnD3LmQjOIKRXOYBXlbY8fHhygpb3I6l+YDwGE2E?=
 =?us-ascii?Q?r1CRCQT0iN1PXx+4TdhmYR5fSngfenKCnilXM2oPDVDlEDZ36kPPMyn16wYL?=
 =?us-ascii?Q?wBnkS+pQjWsNi1evdnndsHdHjnstizAxn45R+zSumfyUrOfgBT9M2CtJVwEy?=
 =?us-ascii?Q?sq5CCcvATHlUyRMDMlAWDXNKvs9KbnKM0Blk36810ntZnpDPsiPD2d88LuiH?=
 =?us-ascii?Q?JVH201lN96ZZKTZRod+aYc3Bs+GofiI8UgLD3/2uj2FeNgCLstY3Wf6qxAtK?=
 =?us-ascii?Q?jTC9U94P63TOv4Ky1Z0BQqKKB7Y6HyXXG/918/80/wv8+mPBlWt2fIXCua3s?=
 =?us-ascii?Q?2tGl9Gok8tnbqW/7opjnrhpFwdOIW6tm09KfLTpgpj2LDzfGMOGpu68B68Wl?=
 =?us-ascii?Q?dgHPG/72IyU91di77WKde+L6pjHAJbgeHkw07iijRvUc9WSirWV3KKvaK9W6?=
 =?us-ascii?Q?D1YBCdsaYilbbR8QzeNnQ5gIwv57Iot8pD38rjotL+NNIt7zrzLBm9IXVeOS?=
 =?us-ascii?Q?5KYzLsXkCTCiFmECOXhLooFGECRw0uT3t4+IRj2OhJ2LyR3nt07w1A90DSSR?=
 =?us-ascii?Q?eI7u8AHxwvaSvklOVr0OdmBI/q+lVKJMf0sxR0hbMAg8mR6TFXkh1MeCD2ON?=
 =?us-ascii?Q?Hrmc24VUyHen9PhU7ByMZZk2alOhKTf/z1vvr7+I8YKMFG5VRUZm36BtNfXV?=
 =?us-ascii?Q?IudCxdQeKg6jc2zOjGq2x9bj7iBW/lP7H47zf34beIysjEYwimpEKRAnGdsE?=
 =?us-ascii?Q?ZLP9aYxnJnZVbD3exnhO7apkqHJf08GJL8p1Bcwm6iA0lMmqzWobOHZD5NxS?=
 =?us-ascii?Q?MoDYjJs1ehG4uzFYpO9m6Lo2Qsm+J1UkXyHpgkwKp0LKb5IG8o7kImCMfYO/?=
 =?us-ascii?Q?DnjfbsXNLkBg6w7p87sdzGB1P20XxaztW9R80Gs1aGxlhj+9KZAZBpkY+3T/?=
 =?us-ascii?Q?1rpr6VDHcB2/1eRJJq7Ac+mtgKYeyKtIzMce5VyAMG9Wsk4OI71qwHYiAyGx?=
 =?us-ascii?Q?iUBFydUfiZ33pr1uppCFH602nmsg6i+Zi+MefNPZg+9gKMlahTUBqlSIWltt?=
 =?us-ascii?Q?ASlDtiPtndCIV4NZ5LsrUF5ayfGWFjOKGl/qlWLXkq6S6SWozQJS48pZCoW5?=
 =?us-ascii?Q?oL2SuEoUtL+QIkqGHhBQ+PaawyFbsK1mN/rq4tKfyA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gRgMnsHK+1DEndlOuG463DWy6s/FwrYKrUlXxMc3a8mDh1LFERwCErjjMWzb?=
 =?us-ascii?Q?klz+FyLq85Mxr4RC99hpjf3gXYoSWfcrkdxrXOlddYBcyAXhAxRpojHT/gj3?=
 =?us-ascii?Q?GlPlJ8T23lIt+or1vR7iNE1iXYaputVFJowie9sukmRizMW0uDSeE/uanhxQ?=
 =?us-ascii?Q?+Z+L5NUq7C7X1mmFrthrUEzMFmp3HhJO54ywS+PJm7I+YUHHMdGzavR5PjiF?=
 =?us-ascii?Q?K6/BxOIqPSKRJM/+D1wYT/ZdYJOpPjHOpzBwYPI3WQDhL3RRlnSE8cilk8fT?=
 =?us-ascii?Q?56yqoheLH61HovAxyGWBP9manUGm1KJPV/aSxVfxaFSP2+qqInBYfGms8pZQ?=
 =?us-ascii?Q?kl/5RytikPHcL33COBjf9UUVac1NerS7tuc6JukxY5P7qCxokcCDU00n6uU6?=
 =?us-ascii?Q?eyUgY00F9jY6jpThIqhC4jbbm9jU26cVAXyCtzbEKo9ml/Ez13bM3qf81h5V?=
 =?us-ascii?Q?9xeuK2jgHxd/tjgWc33HReIzyjErsUSejnsNsegoRDemRTElpIHNZpgq4UNC?=
 =?us-ascii?Q?xTGR1fSpiCgtGVcExO5QUiTEfxOuYuuml2hI8gSWd9xhs7hy6y9TdcrB86Lu?=
 =?us-ascii?Q?kG+ZLFmBuvsrzUOoRUI7fGAinLC+bNv+9uzELR55bY6hU4YROp6tlOFJixjM?=
 =?us-ascii?Q?Qch7V6rWKyEunxODE2Vvlyf4lQufcn8jFWS4uWgpJcqptTljabYgBQJ9n1M1?=
 =?us-ascii?Q?/A9cTrmRX658NQKIg8aoshP/2WYtgobTN1KslY9tIH6seaqTUfjYtBvuwdVA?=
 =?us-ascii?Q?CD5rb/YAmUvM8fB7LpxJuhTZzgiQuCIrJAuNdA7c9t1XswQFbEKiYahqHDso?=
 =?us-ascii?Q?D/m60Uk3qMEAi6cO1hOQLS7UtCpy8OSH7RM6YTovd3D1nwILbH2UgS5Rn0Gc?=
 =?us-ascii?Q?4nKQ5Flq6T7X1MmVEVbBJtHLH+Df4kh44401YW5uf8V2qq0gY74eDtZQxCol?=
 =?us-ascii?Q?sbluudm7nmyLqB9gdHL5EGbTILn9rSR8mlfmmCcXi9echbfaJBP4Qz8G4TFu?=
 =?us-ascii?Q?/5tKRHlF8C+V/OryRkmHN6zSfp7du2ctaJpY9mOy0QDlF3detqnw3pm3gM+2?=
 =?us-ascii?Q?2J2HD8mjIfHjF02zzs3Nlw+G/LWBDvdH7+n6S9tVgxcuDKd39ny61wPRvRZT?=
 =?us-ascii?Q?8j4JtAftySMjtKj5R+CB8IShPVfZ1z44rocK0Vlr4EM4lykTkFxhkiCGu7U7?=
 =?us-ascii?Q?0sQmvpbLm0zRNJnLQHvM+tIsI7cEXSDdt9g4TpNHmmmlTcoNMSvl3p0nrhA3?=
 =?us-ascii?Q?nJKReW5MOA9dooPekMqoEpQPLKN9desx/zg4/QiIBLYXyK1iPI1haN3173n/?=
 =?us-ascii?Q?VIPPCcqAlf2lsMKVvxI58BZzNqaIxCeAps3IQLhsmCB8AC/8WQnLU1IP6iIg?=
 =?us-ascii?Q?Rt3y+OaiPAi9hxc9K/MbQ0gYxdkFdBPdx3HimR9xzLIvILjG7AjyRYa1cMI1?=
 =?us-ascii?Q?PqIM/N8Ad6OzoMAemRtq/ELypoQLtmdUoCLAqCoYLq2ZcNaD3k2qDVGKqs6u?=
 =?us-ascii?Q?m0Fy3pWWsc7p+9LtvBt6tMaEvKC4Zqj0b1azY1e9XmZATkWMoSh6G3yI7sPD?=
 =?us-ascii?Q?ryof8TdMA0h3jPVj0ywFaF8ZxrSx80MlH2tFDn6UQSVgWR2AU0G1fl9R/2B3?=
 =?us-ascii?Q?Bw=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: b622d1c9-da3b-44c4-22da-08dc783daa39
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2024 19:55:42.5230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8k73gc85XlbPxMVsWeW8qyfENbU855eY6ytvJPPX3O6pSTrPnC5hDP/8xmyPL/IqBIXVuJjW+32EyAYdPiQvROr1B5o/HakGuuXOEVn1CoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3716
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

There are of course not a whole lot of examples in-tree yet, but
before they appear, let's make this API change: Instead of separately
allocating a 'struct cyclic_info', make the users embed such an
instance in their own structure, and make the convention that the
callback simply receives the 'struct cyclic_info *', from which the
clients can get their own data using the container_of() macro.

This has a number of advantages.

First, it means cyclic_register() simply cannot fail, simplifying the
code. The necessary storage will simply be allocated automatically
when the client's own structure is allocated (often via
uclass_priv_auto or similar).

Second, code for which CONFIG_CYCLIC is just an option can more easily
be written without #ifdefs, if we just provide an empty struct
cyclic_info {}. For example, the nested CONFIG_IS_ENABLED()s in
https://lore.kernel.org/u-boot/20240316201416.211480-1-marek.vasut+renesas@mailbox.org/
are mostly due to the existence of the 'struct cyclic_info *' member
being guarded by #ifdef CONFIG_CYCLIC.

And we do probably want to avoid the extra memory overhead of that
member when !CONFIG_CYCLIC. But that is automatic if, instead of a
'struct cyclic_info *', one simply embeds a 'struct cyclic_info',
which will have size 0 when !CONFIG_CYCLIC. Also, the no-op
cyclic_register() function can just unconditionally be called, and the
compiler will see that (1) the callback is referenced, so not emit a
warning for a maybe-unused function and (2) see that it can actually
never be reached, so not emit any code for it.

Reviewed-by: Stefan Roese <sr@denx.de>
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 board/Marvell/octeon_nic23/board.c |  9 +++++---
 cmd/cyclic.c                       | 12 +++++------
 common/cyclic.c                    | 22 +++++--------------
 doc/develop/cyclic.rst             | 26 ++++++++++++++---------
 drivers/watchdog/wdt-uclass.c      | 33 +++++++++++++----------------
 include/cyclic.h                   | 34 +++++++++++++++---------------
 test/common/cyclic.c               | 19 +++++++++++------
 7 files changed, 76 insertions(+), 79 deletions(-)

diff --git a/board/Marvell/octeon_nic23/board.c b/board/Marvell/octeon_nic23/board.c
index bc9332cb74a..74b9c741b7b 100644
--- a/board/Marvell/octeon_nic23/board.c
+++ b/board/Marvell/octeon_nic23/board.c
@@ -357,10 +357,13 @@ int board_late_init(void)
 	board_configure_qlms();
 
 	/* Register cyclic function for PCIe FLR fixup */
-	cyclic = cyclic_register(octeon_board_restore_pf, 100,
-				 "pcie_flr_fix", NULL);
-	if (!cyclic)
+	cyclic = calloc(1, sizeof(*cyclic));
+	if (cyclic) {
+		cyclic_register(cyclic, octeon_board_restore_pf, 100,
+				"pcie_flr_fix");
+	} else {
 		printf("Registering of cyclic function failed\n");
+	}
 
 	return 0;
 }
diff --git a/cmd/cyclic.c b/cmd/cyclic.c
index 40e966de9aa..339dd4a7bce 100644
--- a/cmd/cyclic.c
+++ b/cmd/cyclic.c
@@ -15,14 +15,16 @@
 #include <time.h>
 #include <vsprintf.h>
 #include <linux/delay.h>
+#include <linux/kernel.h>
 
 struct cyclic_demo_info {
+	struct cyclic_info cyclic;
 	uint delay_us;
 };
 
-static void cyclic_demo(void *ctx)
+static void cyclic_demo(struct cyclic_info *c)
 {
-	struct cyclic_demo_info *info = ctx;
+	struct cyclic_demo_info *info = container_of(c, struct cyclic_demo_info, cyclic);
 
 	/* Just a small dummy delay here */
 	udelay(info->delay_us);
@@ -32,7 +34,6 @@ static int do_cyclic_demo(struct cmd_tbl *cmdtp, int flag, int argc,
 			  char *const argv[])
 {
 	struct cyclic_demo_info *info;
-	struct cyclic_info *cyclic;
 	uint time_ms;
 
 	if (argc < 3)
@@ -48,10 +49,7 @@ static int do_cyclic_demo(struct cmd_tbl *cmdtp, int flag, int argc,
 	info->delay_us = simple_strtoul(argv[2], NULL, 0);
 
 	/* Register demo cyclic function */
-	cyclic = cyclic_register(cyclic_demo, time_ms * 1000, "cyclic_demo",
-				 info);
-	if (!cyclic)
-		printf("Registering of cyclic_demo failed\n");
+	cyclic_register(&info->cyclic, cyclic_demo, time_ms * 1000, "cyclic_demo");
 
 	printf("Registered function \"%s\" to be executed all %dms\n",
 	       "cyclic_demo", time_ms);
diff --git a/common/cyclic.c b/common/cyclic.c
index c62e7fa7d19..ec38fad6775 100644
--- a/common/cyclic.c
+++ b/common/cyclic.c
@@ -26,34 +26,22 @@ struct hlist_head *cyclic_get_list(void)
 	return (struct hlist_head *)&gd->cyclic_list;
 }
 
-struct cyclic_info *cyclic_register(cyclic_func_t func, uint64_t delay_us,
-				    const char *name, void *ctx)
+void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
+		     uint64_t delay_us, const char *name)
 {
-	struct cyclic_info *cyclic;
-
-	cyclic = calloc(1, sizeof(struct cyclic_info));
-	if (!cyclic) {
-		pr_debug("Memory allocation error\n");
-		return NULL;
-	}
+	memset(cyclic, 0, sizeof(*cyclic));
 
 	/* Store values in struct */
 	cyclic->func = func;
-	cyclic->ctx = ctx;
 	cyclic->name = name;
 	cyclic->delay_us = delay_us;
 	cyclic->start_time_us = timer_get_us();
 	hlist_add_head(&cyclic->list, cyclic_get_list());
-
-	return cyclic;
 }
 
-int cyclic_unregister(struct cyclic_info *cyclic)
+void cyclic_unregister(struct cyclic_info *cyclic)
 {
 	hlist_del(&cyclic->list);
-	free(cyclic);
-
-	return 0;
 }
 
 void cyclic_run(void)
@@ -76,7 +64,7 @@ void cyclic_run(void)
 		if (time_after_eq64(now, cyclic->next_call)) {
 			/* Call cyclic function and account it's cpu-time */
 			cyclic->next_call = now + cyclic->delay_us;
-			cyclic->func(cyclic->ctx);
+			cyclic->func(cyclic);
 			cyclic->run_cnt++;
 			cpu_time = timer_get_us() - now;
 			cyclic->cpu_time_us += cpu_time;
diff --git a/doc/develop/cyclic.rst b/doc/develop/cyclic.rst
index 67831496a70..893c269099a 100644
--- a/doc/develop/cyclic.rst
+++ b/doc/develop/cyclic.rst
@@ -19,20 +19,26 @@ Registering a cyclic function
 
 To register a cyclic function, use something like this::
 
-    static void cyclic_demo(void *ctx)
+    struct donkey {
+        struct cyclic_info cyclic;
+        void (*say)(const char *s);
+    };
+
+    static void cyclic_demo(struct cyclic_info *c)
     {
-        /* Just a small dummy delay here */
-        udelay(10);
+        struct donkey *donkey = container_of(c, struct donkey, cyclic);
+
+        donkey->say("Are we there yet?");
     }
-    
-    int board_init(void)
+
+    int donkey_init(void)
     {
-        struct cyclic_info *cyclic;
-        
+        struct donkey *donkey;
+
+        /* Initialize donkey ... */
+
         /* Register demo cyclic function */
-        cyclic = cyclic_register(cyclic_demo, 10 * 1000, "cyclic_demo", NULL);
-        if (!cyclic)
-        printf("Registering of cyclic_demo failed\n");
+        cyclic_register(&donkey->cyclic, cyclic_demo, 10 * 1000, "cyclic_demo");
         
         return 0;
     }
diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
index 12850016c93..e2e7f9ab84b 100644
--- a/drivers/watchdog/wdt-uclass.c
+++ b/drivers/watchdog/wdt-uclass.c
@@ -17,12 +17,15 @@
 #include <asm/global_data.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
+#include <linux/kernel.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
 #define WATCHDOG_TIMEOUT_SECS	(CONFIG_WATCHDOG_TIMEOUT_MSECS / 1000)
 
 struct wdt_priv {
+	/* The udevice owning this wdt_priv. */
+	struct udevice *dev;
 	/* Timeout, in seconds, to configure this device to. */
 	u32 timeout;
 	/*
@@ -40,18 +43,17 @@ struct wdt_priv {
 	/* autostart */
 	bool autostart;
 
-	struct cyclic_info *cyclic;
+	struct cyclic_info cyclic;
 };
 
-static void wdt_cyclic(void *ctx)
+static void wdt_cyclic(struct cyclic_info *c)
 {
-	struct udevice *dev = ctx;
-	struct wdt_priv *priv;
+	struct wdt_priv *priv = container_of(c, struct wdt_priv, cyclic);
+	struct udevice *dev = priv->dev;
 
 	if (!device_active(dev))
 		return;
 
-	priv = dev_get_uclass_priv(dev);
 	if (!priv->running)
 		return;
 
@@ -124,20 +126,14 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
 		memset(str, 0, 16);
 		if (IS_ENABLED(CONFIG_WATCHDOG)) {
 			if (priv->running)
-				cyclic_unregister(priv->cyclic);
+				cyclic_unregister(&priv->cyclic);
 
 			/* Register the watchdog driver as a cyclic function */
-			priv->cyclic = cyclic_register(wdt_cyclic,
-						       priv->reset_period * 1000,
-						       dev->name, dev);
-			if (!priv->cyclic) {
-				printf("cyclic_register for %s failed\n",
-				       dev->name);
-				return -ENODEV;
-			} else {
-				snprintf(str, 16, "every %ldms",
-					 priv->reset_period);
-			}
+			cyclic_register(&priv->cyclic, wdt_cyclic,
+					priv->reset_period * 1000,
+					dev->name);
+
+			snprintf(str, 16, "every %ldms", priv->reset_period);
 		}
 
 		priv->running = true;
@@ -162,7 +158,7 @@ int wdt_stop(struct udevice *dev)
 		struct wdt_priv *priv = dev_get_uclass_priv(dev);
 
 		if (IS_ENABLED(CONFIG_WATCHDOG) && priv->running)
-			cyclic_unregister(priv->cyclic);
+			cyclic_unregister(&priv->cyclic);
 
 		priv->running = false;
 	}
@@ -262,6 +258,7 @@ static int wdt_pre_probe(struct udevice *dev)
 			autostart = true;
 	}
 	priv = dev_get_uclass_priv(dev);
+	priv->dev = dev;
 	priv->timeout = timeout;
 	priv->reset_period = reset_period;
 	priv->autostart = autostart;
diff --git a/include/cyclic.h b/include/cyclic.h
index 38946216fb8..dc0749ba03d 100644
--- a/include/cyclic.h
+++ b/include/cyclic.h
@@ -18,7 +18,6 @@
  * struct cyclic_info - Information about cyclic execution function
  *
  * @func: Function to call periodically
- * @ctx: Context pointer to get passed to this function
  * @name: Name of the cyclic function, e.g. shown in the commands
  * @delay_ns: Delay is ns after which this function shall get executed
  * @start_time_us: Start time in us, when this function started its execution
@@ -29,8 +28,7 @@
  * @already_warned: Flag that we've warned about exceeding CPU time usage
  */
 struct cyclic_info {
-	void (*func)(void *ctx);
-	void *ctx;
+	void (*func)(struct cyclic_info *c);
 	const char *name;
 	uint64_t delay_us;
 	uint64_t start_time_us;
@@ -42,28 +40,30 @@ struct cyclic_info {
 };
 
 /** Function type for cyclic functions */
-typedef void (*cyclic_func_t)(void *ctx);
+typedef void (*cyclic_func_t)(struct cyclic_info *c);
 
 #if defined(CONFIG_CYCLIC)
 /**
  * cyclic_register - Register a new cyclic function
  *
+ * @cyclic: Cyclic info structure
  * @func: Function to call periodically
  * @delay_us: Delay is us after which this function shall get executed
  * @name: Cyclic function name/id
- * @ctx: Context to pass to the function
- * @return: pointer to cyclic_struct if OK, NULL on error
+ *
+ * The function @func will be called with @cyclic as its
+ * argument. @cyclic will usually be embedded in some device-specific
+ * structure, which the callback can retrieve using container_of().
  */
-struct cyclic_info *cyclic_register(cyclic_func_t func, uint64_t delay_us,
-				    const char *name, void *ctx);
+void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
+		     uint64_t delay_us, const char *name);
 
 /**
  * cyclic_unregister - Unregister a cyclic function
  *
  * @cyclic: Pointer to cyclic_struct of the function that shall be removed
- * @return: 0 if OK, -ve on error
  */
-int cyclic_unregister(struct cyclic_info *cyclic);
+void cyclic_unregister(struct cyclic_info *cyclic);
 
 /**
  * cyclic_unregister_all() - Clean up cyclic functions
@@ -97,17 +97,17 @@ void cyclic_run(void);
  */
 void schedule(void);
 #else
-static inline struct cyclic_info *cyclic_register(cyclic_func_t func,
-						  uint64_t delay_us,
-						  const char *name,
-						  void *ctx)
+
+struct cyclic_info {
+};
+
+static inline void cyclic_register(struct cyclic_info *cyclic, cyclic_func_t func,
+				   uint64_t delay_us, const char *name)
 {
-	return NULL;
 }
 
-static inline int cyclic_unregister(struct cyclic_info *cyclic)
+static inline void cyclic_unregister(struct cyclic_info *cyclic)
 {
-	return 0;
 }
 
 static inline void cyclic_run(void)
diff --git a/test/common/cyclic.c b/test/common/cyclic.c
index 461f8cf91f4..51a07c576b6 100644
--- a/test/common/cyclic.c
+++ b/test/common/cyclic.c
@@ -12,22 +12,27 @@
 #include <linux/delay.h>
 
 /* Test that cyclic function is called */
-static bool cyclic_active = false;
+static struct cyclic_test {
+	struct cyclic_info cyclic;
+	bool called;
+} cyclic_test;
 
-static void cyclic_test(void *ctx)
+static void test_cb(struct cyclic_info *c)
 {
-	cyclic_active = true;
+	struct cyclic_test *t = container_of(c, struct cyclic_test, cyclic);
+	t->called = true;
 }
 
 static int dm_test_cyclic_running(struct unit_test_state *uts)
 {
-	cyclic_active = false;
-	ut_assertnonnull(cyclic_register(cyclic_test, 10 * 1000, "cyclic_demo",
-					 NULL));
+	cyclic_test.called = false;
+	cyclic_register(&cyclic_test.cyclic, test_cb, 10 * 1000, "cyclic_test");
 
 	/* Execute all registered cyclic functions */
 	schedule();
-	ut_asserteq(true, cyclic_active);
+	ut_asserteq(true, cyclic_test.called);
+
+	cyclic_unregister(&cyclic_test.cyclic);
 
 	return 0;
 }
-- 
2.40.1.1.g1c60b9335d

