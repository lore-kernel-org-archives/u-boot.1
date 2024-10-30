Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0F5D6B6DB
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 21:34:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DF948926F;
	Wed, 30 Oct 2024 22:34:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="OMC2LV1S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BC328924B; Wed, 30 Oct 2024 22:34:06 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::62b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F11B78925C
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 22:34:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1ZyyJUulV4U0SIdFZScEb0XMQGLLFDH21myNugELDdfEUmFRBU676zqKAZWSv5mJUQ/F9ukmXlonL+O28eb+L+zAPVI1iV+BKBQrXMPr0EkrlkXpwoK+lwcvFiKn4OlhBvA57vw8dX+ROoSuWo3RSbMoH+99QJcITDpNvoaTkz5RHT485DIeagmLYWotIlz5VhQNA2Dm6OS1vfR2QSZSiaqUENyFK+yHzqPQM8vtcr2yuL7FbRygGM9BcucqrLG+DUT7IxCMskTj5IErUEzPZ1jLjLaA0SZ+iIDQrMk+1jtFb31BlnZLKjJ+TErvjKbqVGuGv3xrJcELBCOzD6gUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDLrBIuuGcWeBriDZ4uBWQ2J/MZ0gXBlytHNVnIJplk=;
 b=Py2Ekf1m4ZSoHGF3pjHeExSVVVXhKHuZ97Jvjl85WCYnlGir3mD8YZn5Vdg3BBX4QdolSnV5HvJrCDy+fSeTaBd67jBczV+TCADNqkvhKJuTemmNe6uKwNgwBumxHReiUPS5aJ+fNiKIQPlMVfvKhOxU/LDFSSlUXEasBmhseVgvBxiXRefzpLlfcMZodta1zs/zI1j3w/bP1FOujF0l2syDB547AI9YM4PKjTORAs2ahaiOdirB9tRP8zifAZehsh/3tFsGOmIcOLpJqa2cv5WyjU6qxzKVBM49MNzPJa1iIXLmOr/fzsCt70iX/X2Nw/Jo4LZ69lPDitoA4n0H+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDLrBIuuGcWeBriDZ4uBWQ2J/MZ0gXBlytHNVnIJplk=;
 b=OMC2LV1SXmwuMfMygdEcD6eLFJDZHJhU5tzQ5lSvBQFV7+Re1iWr8/UKQCKYpBS7Lp+RyaImIrZ3F7KjfDx/vSuJw/bcAUVKb0CRLYjXvu6ZfeGslNoP+e1rQr8U7TM0fezBMH/3xFMILWs2tFkL7GtBsi/Qp5c7HdO/Xb5jPCc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AM0PR10MB3201.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:189::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 21:34:03 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%5]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 21:34:03 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ravi Minnikanti <rminnikanti@marvell.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 1/3] cmd/nvedit.c: teach 'env default' to optionally keep
 runtime variables
Date: Wed, 30 Oct 2024 22:34:02 +0100
Message-ID: <20241030213404.2894247-2-ravi@prevas.dk>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030213404.2894247-1-ravi@prevas.dk>
References: <20241030213404.2894247-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0076.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::18) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AM0PR10MB3201:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f4c041-e52a-4236-b2b9-08dcf92a9300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X2aU7tdt8XWxcToEB+ayNjkjsiJiW7yy0LWNzYHeJv1lrrRF/9cK6g0pOugy?=
 =?us-ascii?Q?CCHInM9AstTq3kiCgRtPx18UyDZJiYyhhSE5bsn9kC4NenGmUplskf5NPuFA?=
 =?us-ascii?Q?b52itiQAX+WsN4iIq/sv4GUrz8Gt1h0+unIverws0zqotEp8SkhhPqMXIX2a?=
 =?us-ascii?Q?hfMR+e7icxg3dkoRdTxrZmsE7RETd74lKIv5voRW0BT2B2bJ8/RjC8deDPqm?=
 =?us-ascii?Q?yjaFi4nQiiUAhTLojFRDa3oi9ZcxOCnybIilwUUIMkfRfRSU8Jmlic2voCOq?=
 =?us-ascii?Q?Y9Eouux52qqfHFef7H9RyrlVETwphOABojHFd7MbGOhOQk+uGIKQikIPiI+u?=
 =?us-ascii?Q?zFs12fcrUYVR3Rcg5dPfBeUVqbzXS34zhzNZbRfJYM7QKjEK4nNnzieB3UjJ?=
 =?us-ascii?Q?fuILrJ7tFaUR2sd0u9Ssy84/3uwl5BIfFhBzWWRpHK9kC0A2EOgXhNBCyBBG?=
 =?us-ascii?Q?/o0mWyd+ETTmE9VNGbsNUIA4z495xcL3gW5tpGi68q7frq6usxb9AqkEifmT?=
 =?us-ascii?Q?tR4YR3zWIHbek1UIOg1IwrFapNIC/54LLn4VA8xNan1VRJKUOyEEMv9rls68?=
 =?us-ascii?Q?I2kEnU50OdypiqiiLlfFsRl1fQfYTpG+bVvjuPWpfzM7fqlkR4GS8I9gHoa9?=
 =?us-ascii?Q?FtjKQ0AiXNhqRMulQorNEK2XQ57CA0NRe29t+JOGbbRNhJXbxw31NWOPDXVb?=
 =?us-ascii?Q?AOd1eqnLRzek3BNnyhLVIoiNSGJSh4w4xZAvrA9F2S8CCq7oGBVRP3L9KmbR?=
 =?us-ascii?Q?1X83GGopLPQY2v6AhvUKCNINnbSNf+uhnWwtmydJbe7C0/4PQGQknasssdb7?=
 =?us-ascii?Q?QmLUmUpWn9nGHkrsBp47o5eRniwMBQyqu6RVGN/FgOfDNXOyXeCMlv0kstz3?=
 =?us-ascii?Q?t6QY8e901Dor4u96d2d5j67dL/+ZAhBMWfLMA0+iVOYZAHEXj7gch2rFvRYL?=
 =?us-ascii?Q?Y4riVyDhw60n4blUd0nUvj9fyyrZm30UpWqx/YsQnl2kmhuc/QY26Xxwq9+j?=
 =?us-ascii?Q?ep3YBn/j6B/epjlXQZufHCeYHt8PKx215RxYvB5vNhkh7GHlU9oWqcUQ2BWo?=
 =?us-ascii?Q?g+Z6qXGen+HF8nofYCSv9CuvcCn1iZAKkHvXSdnPtRy7Ip56aR7uAyt8oW4R?=
 =?us-ascii?Q?zStYDlvltrdlstHpNQkQ/Uyqq9ebEwe2W6fJMyHSZbzJS1sgszhyoxoNquKi?=
 =?us-ascii?Q?dTEm5SJ/6AW6962spsEDaoIRsjfl40HHZO/viRcintTNd2PRqBdYf8tE2Yb6?=
 =?us-ascii?Q?swsGDBPo4heUI5aYdFfmNS7c03UjGc/BOhOn3v1EzTY4DHKa7ckkfAANzQNJ?=
 =?us-ascii?Q?imlLbF0hG4WZC4TBO2t1IGwAq80yk5H9QruKDjvQzZ/iXPmjGXiMUHxfxRBj?=
 =?us-ascii?Q?oxUTwfU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YoLPGWcgwPWpVvX46HcDWWkKyO2e0HpyLecRFyIm3OfrLX4fGbXG5N+UOcDg?=
 =?us-ascii?Q?lDZ3njBCMxUhoKW4MsMd0HxcC++CfJaP6xFus0KV9xbbdr/b3GXNyPVbuI1e?=
 =?us-ascii?Q?anBlROQyKb5bFm+Z+xfEDuifBCPMaAPpuskmXdKHfRIpnMbdGTqetCDTjL0D?=
 =?us-ascii?Q?ojiPWrOROnzS0fHgh1C3ENhsCoayShJYvg7icf5pxgBV+pOMbuztS0F3wGY7?=
 =?us-ascii?Q?Zz5i6+3i55ntxqkofZ34Fr8iLo9nmXRXZLFQq+GszS7nqKETlZhDUCzsHkEQ?=
 =?us-ascii?Q?egwDsoItOBW210W9zNsmuhqrjonEvjqkmQmHTkkSNnSglKfe8Tkfw3TBZPcP?=
 =?us-ascii?Q?r2m+BIu+9ipipaYxBmrxX9f0K6lAOdfhneSmMbNTrAD3TeTN1h3q7/9ZELms?=
 =?us-ascii?Q?1XvSSzO4Tc1MkiVj+vchdJsVA3sZA0wMDzRPtBPXzS8cvIOpJfyBitzlddS2?=
 =?us-ascii?Q?vUCNa1wjc2/IKYmVXdcn860sgI+LpVIuvmujxGkMfqWzcxXRPp7RE4yKrZQz?=
 =?us-ascii?Q?n2G7KhzZ22Wk1z8+Rrj3KaCO2f6qn7VcWf8Ndo4BovZBbStr6J/DmWbWsW/u?=
 =?us-ascii?Q?kpnZ+9ftJ+iMkj21ilil8kY1zhi8A0L+sReqFlXxOYUycqzl8pdyrpO1dv+z?=
 =?us-ascii?Q?cjMC/SWKbLMWwFF35BHw6v1CErkfAZjIiTE3FbRSx+0tZekStfYhKpFTmM/X?=
 =?us-ascii?Q?7QuLj4jTzW+YFzIDONaN6Vo2UbQ9K1vm/lCkzZoMNhKmmc+ixqXKl6tLZ74h?=
 =?us-ascii?Q?2P6X+5RqwCfI9PVezUTj1aayBtcQK6fFYEI0WT+mOGpJ9JhNpmeBNG+Lkz+h?=
 =?us-ascii?Q?M3/WmkDLPfjVU37cDYqAYDsJhxZG9YJXfiLEG6Qhn5zGN+dXEVSkbOnZwVIw?=
 =?us-ascii?Q?NpaoUpr5WfSV68vzqjcvbsKqwXYw43lba4f8jUGm8j4M5/02uz6+1l8HZTWh?=
 =?us-ascii?Q?WCoC1swQ+4qlNyjW0A+35V8yye1QZd+FwCuxC6vBLCoAVEApLD9qHHpA6kk+?=
 =?us-ascii?Q?bXhduPQP8iAL1Fk6DUedMa91u0JZhvTtRbtcbcDh4531v6zVedxiNc4v27BD?=
 =?us-ascii?Q?aBy1Jwi0TyNPzz0YmTwbNieCeDs1SsYBW8guao1wVoUvrRtsJlPPCanvyCi4?=
 =?us-ascii?Q?xo6CMML1mjdo0Qo+Ftn0bGIaAyqlkDaOAyf1x9JVxQmIUG+dzOClLhO3kfKs?=
 =?us-ascii?Q?C4Xz0hewW+zF33rQzUaz9L91NIglOfb/6J+DZmDoOkR/vhD2kkj23m6QDpxd?=
 =?us-ascii?Q?Dl0DVdfmho91P6Vu8U4vdCnn1vDcrXV7nasLbkC0m8fd2Ntn9vXX0mAXIqcL?=
 =?us-ascii?Q?AbGRJ3XZl7/3Cp7q23/nWgNBL93/+DVgDsbLWNiVXdmxai6fUKSQVHlxlpyx?=
 =?us-ascii?Q?jnhi825/DdBVbmmJNN3oOaO9Gk86029dtE/nDCGJP7R7ws4DzNI7bZ5nmcDB?=
 =?us-ascii?Q?nKjBctaR2BgtKUCE2zqPKfxjWfUL/33/7muYYSQ1AgqkNrzFfOTwIlEs7/1k?=
 =?us-ascii?Q?ww/ktEqEhxez0qYhUQDnbaSKJswzITfEdUwiAkfykhnFC1m4yRpONlA17aIy?=
 =?us-ascii?Q?4ZICfobJL/gxBZ5SyhUU8xF34MHo+9Hqy1/XSxzI+App3W+dX6DFvI4Bvec8?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f4c041-e52a-4236-b2b9-08dcf92a9300
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 21:34:03.0866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RXHytJBys40APdCj2DoeVqlNXvIdlmRS6x1zISC6Irc40uc7lniOgVDAi/TzbWljZC7x1foTD6yjcZ9BFwU9mC5KDlXnggO9IL+hdIENjZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3201
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

It can be useful to set all variables defined in the default
environment to the value they have there, but without removing
variables that are only defined at runtime. This can sort-of be done
today, by using the "env default var1 var2 ..." variant, but that
requires listing all variables defined in the default
environment. It's much more convenient to be able to say

  env default -k -a

The -k flag is also meaningful in the other case: If var1 is not
defined in the default environment, but var2 is,

  env default var1 var2

would emit a warning about var1 not being in the default env and thus
being deleted. With -k, there's no warning, and var1 is kept as-is.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 cmd/nvedit.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/cmd/nvedit.c b/cmd/nvedit.c
index 392f90f8698..1f259801293 100644
--- a/cmd/nvedit.c
+++ b/cmd/nvedit.c
@@ -523,6 +523,9 @@ static int do_env_default(struct cmd_tbl *cmdtp, int flag,
 			case 'f':		/* force */
 				env_flag |= H_FORCE;
 				break;
+			case 'k':
+				env_flag |= H_NOCLEAR;
+				break;
 			default:
 				return cmd_usage(cmdtp);
 			}
@@ -1133,8 +1136,9 @@ U_BOOT_LONGHELP(env,
 #if defined(CONFIG_CMD_ENV_CALLBACK)
 	"callbacks - print callbacks and their associated variables\nenv "
 #endif
-	"default [-f] -a - [forcibly] reset default environment\n"
-	"env default [-f] var [...] - [forcibly] reset variable(s) to their default values\n"
+	"default [-k] [-f] -a - [forcibly] reset default environment\n"
+	"env default [-k] [-f] var [...] - [forcibly] reset variable(s) to their default values\n"
+	"      \"-k\": keep variables not defined in default environment\n"
 	"env delete [-f] var [...] - [forcibly] delete variable(s)\n"
 #if defined(CONFIG_CMD_EDITENV)
 	"env edit name - edit environment variable\n"
-- 
2.47.0

