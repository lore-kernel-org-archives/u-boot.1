Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD48C47074
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 09:12:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D8FC87977;
	Wed, 10 Jan 2024 10:11:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="m8CiMPus";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ABAF87A88; Wed, 10 Jan 2024 10:10:55 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::625])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DE5E87A9B
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 10:10:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExM/m09gi6m5gqKafdyhYBPorIi6hDVHp0tX7XsaSJbVZ3565g2WZiH8ays/wY3YS9Wx8Bk3Zi34zKsUXTZM9ndyH8DxAtMr3Sc3S2GLcXIHP4Wo0rzXmCKdARCezndSD44AuoMEh6rlOE3H2+sLeYMvZo/GGtXdWza3TCj6nJAijNAWp+n8er/kKRBwmi8n4wArDT4Nrqu4NdMgEa7lpWdXTWGepn0zikKns4pm+DScSKJw0u8EyBraOTMteXGVkQzxk+wIOY94flAPpClyhebfZwAX1p5cHAn417/O3KsrwJytOJIn7O3XI5TA1tvumpcPeVxeTvCtdM6mOY/9Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhraIAs0DvPqU1uuy9jpzxtHdq7OrTMVvXGN1I20GPE=;
 b=k+1FN4zaz7vTrYVOTAA2b0wGt4SAtDt6MoHHfZPyHUMz3qj4Dh+5gsF6QN/hlbz0FyuElpO8j3aOqOXMM8VBHaVgYKwvscmktcTyVUal8Np98n5bepWK0PiTIUyF+evvseHDvqLqn3Xzin/eUjt/ELYoBt20+4z7o8BnM1tCpXrR4a/U5sAzONTZW0ZgFEEWPiyD4TRg3stZ7G/nDWR0qwUwK6KJaU7bv0rEqf6TZyf7ekQiFjeOATn1Sl0VDRAo/rWfbUzu7Uj1lmHNaB1CDjxWkcHzSl8deq3XbTigjusdXP8uBHsD31qLireX/eCcgLtuyxaQ3D9b3L+akpkwuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhraIAs0DvPqU1uuy9jpzxtHdq7OrTMVvXGN1I20GPE=;
 b=m8CiMPusw1clu6cuATW6qo1VD4L33ff+Ur3BbMVWckl7kaIJKBUxwJtsLnR0CXC+8uF+pOEgKXYCpD4UVeIt58ohA9GWzjR415rdJwE7WDl/60h9aU5MlVCF0AI1UxOxf68KpsOixirsDJKGJnXSKfGmEl4YEj4BeBqEE4fQxHc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by GV1PR08MB8641.eurprd08.prod.outlook.com (2603:10a6:150:82::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 09:10:51 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::daa3:b3af:ec52:4278]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::daa3:b3af:ec52:4278%3]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 09:10:51 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v3 08/11] setexpr: rename 'get_arg()' to 'setexpr_get_arg()'
Date: Wed, 10 Jan 2024 10:10:34 +0100
Message-Id: <20240110091037.392520-9-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240110091037.392520-1-lukas.funke-oss@weidmueller.com>
References: <20240110091037.392520-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::11) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|GV1PR08MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b028df-d742-4c4d-c3a4-08dc11bc0a3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +71VQD5hn2fjfZd79alQlcfSAmNUiwvypeAS7ilL9QTTkt12oWFLmdg4gDWC5pijTuwNfZDxK3x18W/nD6Z5ebc0lCxBWhWML14iRxIdPIuYZXP1+8ED/Aw37WFRVSi4cvzyvaHaIItLIPGkkacawwQLvh1N2AK9KGcfHjQd0ZsY/IY+2pIcG2Dund7os7qiwf6KlQ/34RqkhSJWKUUW8PIXwdnRwRQS9riJgM4X6N8DLFOPvm5KN+VHgLc+DBU6OfFqfhjorOrGpr5EYvzSGw7vnxr+LpSjySflZSvQlGVPOrMjgCifNRRBWgR5AWGSIrHtdYg6S7vmiyh4v6u9uMlV8mMOhvTGw7JXW5Pj1EsB56kIliWNTbPQYTAbZ92vMcM9BzRzKjsiO9LgxXFb8ltY9OP3c+PxR0rVvqQJcv9HA3MImQNfWDJSbdFtfxviWuax8IJds2IPCrY+SZLhucWvdSfITvS4zx0KOf3mWjjF5zVXcY9eolAUqYlt5zcIOqrBNYbyPePsjJTWNtYIA8aj68A6BPuYEGUWNeHAF4AD1/830xYU4Zyo1/6K0Hj2b3D3LNaDCDQ4WewrytUZBS5CzzALKoSWSq6dJKAQwx4Dk/XtvJCT+XVrlzXYyfhl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(396003)(136003)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(86362001)(26005)(1076003)(2616005)(6666004)(478600001)(6506007)(9686003)(6512007)(52116002)(83380400001)(5660300002)(4326008)(2906002)(41300700001)(6486002)(8676002)(8936002)(6916009)(66556008)(66946007)(66476007)(54906003)(316002)(38100700002)(38350700005)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a3KRSVBUpy0yFc1zyhbL3kCxpZr/N8pNAChNPJ8wzd+Oi264jnUY+jh6TrI3?=
 =?us-ascii?Q?o2JtTcwZ07sTZRBo51/URwprPpsxiPoy3Ul+bX0zfV68bluSNsZYcDewbxFd?=
 =?us-ascii?Q?9zLI6WPmA9Ae9vcES0AJun5Ww6sS1MlQNOW5Wh79M07U6WCpzwDMFMfrKQfe?=
 =?us-ascii?Q?0YKDmdpS5u38XkEUoxnltaYaCGsm/+7yYelOMa7iefQytZwwD+xDjMeITrC+?=
 =?us-ascii?Q?0rwaCNROud5dydpvBm6VCPWoCAk6uoudWh5j/5qZcFHZiqf3E3kfwnROLEdW?=
 =?us-ascii?Q?wwDgpM7YNFMjnuIZi83kpPez75t6irCjQbIHGakyO0NJ77fZtYVA2Uuix2eq?=
 =?us-ascii?Q?12PLEappuEPSfg/dAZCpS8Tw9WkIwRE5Grppfnhzkg+v2pS6TudEju6V7Nva?=
 =?us-ascii?Q?OdvxKl4LX+gp5IYUqKBElvZkdM8i9s4x3bMHqizrA8cTdotn4/9OcVSCBqvB?=
 =?us-ascii?Q?x7nN5YbVkLkOvnJjoSMIL/1wcOm5Jz6DyYrhr/z6IMeUS5cvRPrIaFOTWajg?=
 =?us-ascii?Q?NrstbFpJ4jS0fa+S65kDsIopuf+qZgMDbEBD/QyxAL88gWNqgGSD744RCx48?=
 =?us-ascii?Q?X91Gt8yVHG6coHy7arzpvEhE0eK1+GZu1/tdFlb6ZuWjQdeRM2ctTFqUNlMj?=
 =?us-ascii?Q?tfrIM+VebLF4K5nluf4e3xPSLA0/e+HjzECd6GcBPkeI9dPb2JIUghQR9Y3R?=
 =?us-ascii?Q?zAHnGwTYQBU+654gjtMO7+03Of100/jSnvAya29oUXx1SnuoAhWP0NVpoTBw?=
 =?us-ascii?Q?wuMs+Wt0vyD4qKw/YAGGVyDOODqhAIcT98lfUXki9rez+1DLIfMtFB3wOHpF?=
 =?us-ascii?Q?lqUnbqYzr2B3OUQJTkBpj2E2joRrxFzXho7BKVB9hBSMlninQWyE87tR288q?=
 =?us-ascii?Q?pJ8QANPnK5VOfuAmpqVihdxxDPOvNHGuLLMNT48BoBd3+6Y3CUswnhRj0IVv?=
 =?us-ascii?Q?2ufyeV/4xqIf6OT+XTY7FYL7wQsEine3+LoILaHhgkDHBH4DtLu/QsPqaA19?=
 =?us-ascii?Q?0gnPHqskkplsZC9LkTcqNbpRlLv1VaVfaSbJolhAwDu08n3fZwsgQvDIUveS?=
 =?us-ascii?Q?i6bC496nlZOvGjn+gPk4Zqt/GwuFvv/93FRtuxGlvhf/fLL+tmbWGryNWzJL?=
 =?us-ascii?Q?ZRmwfhwTQ25WuLqYTmW2MbWxVAzGX0YPLSa80gOGCVtw4ZKdP0/sToP8aryx?=
 =?us-ascii?Q?CTWsBcNSEvqPM0VX3niYhDKmBSF44hzlGaQVpE28JuoUVYp0PH6IbZc6rHPe?=
 =?us-ascii?Q?UDluKLmAWEpwkeFxtY4N6uYWyBJ+Urf3aXq7Kv7b/82l2KBCm8TX3/dM1ANu?=
 =?us-ascii?Q?332kTPxCijH+Xex7IxV5I6eXqyBZ01qn7gwi3GCEsR8hZuJXqYZ3zyelcR9f?=
 =?us-ascii?Q?+3Ec6GMPp+qvVRl3APBPt3pNJPl8Qc1Exzac1cLwV0fOf/DOw2wFLD5qZr4J?=
 =?us-ascii?Q?FIvjl2ukjdq5lz+MENI/tP/naG8xOtUZu1o+7ch1YSgw4Cq8nwAg27O4lWQJ?=
 =?us-ascii?Q?zAgxoh+evXi2s9YAvr2Htba9dtf+ec3AaAkD2DYnF6DRfqCdaFiOBn9WmiBl?=
 =?us-ascii?Q?V7H1+B6x7AeTe0bAhUDRQkbQpQ8AJvd51H0Tx40L/uEPu4TkiblEdJpRoFnq?=
 =?us-ascii?Q?Ow=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b028df-d742-4c4d-c3a4-08dc11bc0a3a
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 09:10:50.3947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YSpdTSlklRVIBq4YJmhUpdRiHDAiLbZPfkY9SDC+SYlxedkVEINCCZ0kK+IzzUd44JsytTUL8qGnM5WlcHPoUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8641
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

From: Lukas Funke <lukas.funke@weidmueller.com>

Prefix the get_arg() function with 'setexpr_' in order to prepare
the removal of the static specifier. The prefix shall denote the origin
of the function.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

(no changes since v1)

 cmd/setexpr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/cmd/setexpr.c b/cmd/setexpr.c
index 233471f6cb..bc57d41448 100644
--- a/cmd/setexpr.c
+++ b/cmd/setexpr.c
@@ -34,7 +34,7 @@ struct expr_arg {
 	};
 };
 
-static int get_arg(char *s, int w, struct expr_arg *argp)
+static int setexpr_get_arg(char *s, int w, struct expr_arg *argp)
 {
 	struct expr_arg arg;
 
@@ -388,7 +388,7 @@ static int do_setexpr(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	w = cmd_get_data_size(argv[0], 4);
 
-	if (get_arg(argv[2], w, &aval))
+	if (setexpr_get_arg(argv[2], w, &aval))
 		return CMD_RET_FAILURE;
 
 	/* format string assignment: "setexpr name fmt %d value" */
@@ -441,7 +441,7 @@ static int do_setexpr(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (strlen(argv[3]) != 1)
 		return CMD_RET_USAGE;
 
-	if (get_arg(argv[4], w, &bval)) {
+	if (setexpr_get_arg(argv[4], w, &bval)) {
 		if (w == CMD_DATA_SIZE_STR)
 			free(aval.sval);
 		return CMD_RET_FAILURE;
-- 
2.30.2

