Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A8ACF044D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 10:51:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 240E489184;
	Wed,  9 Oct 2024 12:51:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="dtulQLlK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCEBE891B2; Wed,  9 Oct 2024 12:51:09 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0565A891AB
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 12:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbGM7D4uT50JTqz8qSumbreY9W32iheRjzQ71v19kk7uwRaTex1lt7DaoQQV6GP4c8ybZeToGKcrCd0cdoyLajJwo92YcjJuLPb96WPAuVDMCBSr7BZc8faD9ymmKsq6aL7T2lk9D9T2ORwjK3HRshA1Cm2NAJlCLTOakX0Imbee9OWFhp0RbR1pUkA/d9LN/yrPlFuLCfLf306YwlKlcSsdfQ7O0hJYh/w+ENhJEUZD6dFBxsxL3fm8zhKGDu+/IVW8xXJyq9raB1YpLtq4qZ8zQsRFzUIvFl2cXeP4+s0gIeFKKvCSxi0hykRzNdGJi5Pyy9NYGddboButBCJtjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEz99YBS3mgQpsbqTk31psHOSp1vBUbPdtOGEPpO9Vk=;
 b=kx6+ABJKlyfI2u2rCvfCLTvo9fpTOzK2QzBz0BEVnakxOyUMozJ5W3Zvx/Vg5YL6FuLRvUJRkPOLu6SULkHasSVyVXV5ZV3visoCUsvmU0eKSztfyHvc9x48kGm5N5VTiATdme0FcGYRMxoftL5ZgnkexDYXRh3gSw3ZfaS3kjHlaIhVh6X/qYhHi1oGu5bajmwL+WGRANGSnTztMM8CYQq3bLQvyTL5vqx7ZSwB9x9Gs0roM5BG6tkauSAyXiUm+ml9P/mKs1wt4/8jAemi/X4PTeVzVO984Dp/z3SfhSvguaBet/3GefexHBDBFPIg455jCeRpiJGu3Ljd+2Uojw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BEz99YBS3mgQpsbqTk31psHOSp1vBUbPdtOGEPpO9Vk=;
 b=dtulQLlKppiYEqYe68H4XRA5uDcOMRg7Y0yRbTgR6JHZ9NrcEvvfGhNjdiYfo/aqTLNbGeGkzNsD1rZcYEDRvbZEPBNMMbx6Yhl5U461Ekp1Z3kDS7VgqYnJj+OPVWgQxRuirzGlhiKRJfUjhkq8XDfmAej4egJ1NI65B/auFX8nJNIct/d2pnvLNYNlqJh134eIET6BfQ56loJk2vaSiLJ65/OrJS2SKe7ARBUMkLVHO2n1YJuNLq+q010Yb37RHKIJQaI2oUoLYoBjK8lDn84izBSbr7BiLLHDF4MngaDf//8BHjXmOBuyegbhLvrtf1OoJTD19GLTCAdTSTkQ5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB10026.eurprd08.prod.outlook.com (2603:10a6:20b:632::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 10:51:04 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 10:51:04 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v11 01/13] net/tcp: fix TCP options processing
Date: Wed,  9 Oct 2024 13:50:42 +0300
Message-ID: <20241009105054.1879054-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241009105054.1879054-1-mikhail.kshevetskiy@iopsys.eu>
References: <20241009105054.1879054-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0081.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB10026:EE_
X-MS-Office365-Filtering-Correlation-Id: cff889b1-d519-4fa5-588c-08dce8504585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|52116014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wNsHi0bjAnqK9GLpgDXjN43j9we8g2GMZEr1iGNUiDl4s6MRKUnEasXyXfIu?=
 =?us-ascii?Q?M2h/zHGRlMP+4gf2IvrBvYzJ1RDY3MVdUowktbHo0mVZg0GlEKIvTer6h7+G?=
 =?us-ascii?Q?PRSHuOJGNN+CnG/PgmvnZA/0eQxfzuYxdHqYBLkjxj7mNTFyicxBsNiWMlvN?=
 =?us-ascii?Q?Af25kmC/nPchQzJVc1TfAM19A0ClHm3JJcRwKl6j42BQCOI2lTAmYQHZsJs1?=
 =?us-ascii?Q?r7ZWPFhwOamKKwwVkXxuZTr8+ltFGb+Hz55kB9unEmTTAgQ6iHC9aem03+Hf?=
 =?us-ascii?Q?1L9phHcSMy95I1TZkrTl3iwUTO7o1tpCjGsOHDZbK7s4F+qbgjV0naxqQCfn?=
 =?us-ascii?Q?xVDdvv51a/xOrPX9qLogM4Svyk23ka9AuV7CAcyhjFYAhDTmoq5Q/lDtst2U?=
 =?us-ascii?Q?ljUnQDf6Oz032Guyzmw/gh+qg4UnjpzUWY8sV0iSldiJ9YmJDW3LqsEKyhzw?=
 =?us-ascii?Q?eyB79/ZQV2Um35Ys9tHNbh49Zdvq/GTE5xdsyHYfFupJj6UvNnqfpMltqqEX?=
 =?us-ascii?Q?p0p9oTpAfhMqbVZpw3Sj1Oc9SC1SBU6K+kySPlUyL6rRA3BbOn78DHLxmmC/?=
 =?us-ascii?Q?hOxqwZto3KVDxAV88hYCa7A3lHQ3zA6TgZwxD37Qj+OhMOm59sQOXe/1Kpbw?=
 =?us-ascii?Q?wjbl9PUXk9P/C9OapJgi38zjEaqsLmEyZ+Rz2wYuWlMwOd5lEdwbCmx4AYwS?=
 =?us-ascii?Q?C8bbgsB1CWXTfGcebZzLhGFbsoM5inQ2X7cXyn10B9e4L+MR1PlWF1/J/wO4?=
 =?us-ascii?Q?+vdd09OwwKXkxken/32xUjDd3a2AvtmB/68tuqhz/TdzU2c4iQIMw/7VqTRs?=
 =?us-ascii?Q?Jq01zHpCeck/fe9zNhWmA/ZnJ+5g9lcHXNbq/Suw17fHz9GZloMSrS6VNhoc?=
 =?us-ascii?Q?fuZc4Fs55rbchQyP04w/nU0t9RcU4C74Rge01sggdY3GL66Vj+2QzjpdaoKy?=
 =?us-ascii?Q?4BykCFijytpDESi2KjtpHkBSKoGBQJWGFYflgIO3Skzy9JtCj2WBeYYTKyiF?=
 =?us-ascii?Q?+CkPz9oGAvuywYHX41kz2aBaZkkSRHEZqXmm2hreIeB40zTL/S29WvnKI8za?=
 =?us-ascii?Q?LzLpAXdnrbDHNFYajIx3an1MYwn5BQI+1ssiN4wRrswmKSPi7PylmFXtNz37?=
 =?us-ascii?Q?Ef9EKyuKHkCD05ro+ByjBdD/WjkezCDAk6IkRLz+VIp1aXSBGaBjVo3+MLI/?=
 =?us-ascii?Q?tMjxqt/SPGc6+pYwdFV9lzHS55bGSItol3QZGm+zjmtLxTCFCoyTq0phZHV1?=
 =?us-ascii?Q?K6RdMaQZfGxJoX6BbWn7RKnCGxjOAQIioXG0T+wWYStYitiZq6bqYnOjLWnf?=
 =?us-ascii?Q?7NPDYi9K+qoAw8fE6GBZqngk3DuTq5Z/6Z3kT+NvoszRE0/X86Vs4wbL5qGu?=
 =?us-ascii?Q?pKeQfCU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(52116014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BIxddQyitM1fhYt3n1f8O4LeNJ3xxlGaWp0JdXuHUrH9Il93zAK7p5VZft9T?=
 =?us-ascii?Q?BK6pOyr9m2E6Rh2jIYoM5vojWv1bxNWWnj0iCrEedMpNW2R+oND5sxr8boOH?=
 =?us-ascii?Q?7bjdJwDrAyoV8sSJjEf1IJpLUNtccZ3hBTlvWMJli+C582IO1e0M8VzR/VMU?=
 =?us-ascii?Q?wRCmgUx49fGsvb1Zwr9LAae9epUF+RI5sNPxEisqtc/l7H/KZyGTw339jORp?=
 =?us-ascii?Q?dGVuqy2l1+tnZ+oWKhJ4GSx4LUD+85GRbVM7JNwtC+DCvfWYQ+pGU5/O3LbD?=
 =?us-ascii?Q?6E9r6WQ4N4EQNbw3WrgN8WM+ZtRSGIbtVrPYvPY4GiA+pDdxaUrMWvwX914k?=
 =?us-ascii?Q?df2ucjYJvyBIS7AyQDRpH/E/guDjR+cdnFjLQ7593ox/MKfLJKy1KM2bBRji?=
 =?us-ascii?Q?0WU2NvwiRrwU9rLFoe6m9Qr+OUW8Z6hQpKgoBABOXZmKDTqlc6YSVsX/25tW?=
 =?us-ascii?Q?HmP9tneB21dDZwh8EneVjo93NR5xozhUhol8lPovVKJbaQO5nqv2rdrkGrDG?=
 =?us-ascii?Q?UrHoT30gwCa0bnWqTIo+gJPAst4qcxvHcnZOLSnP2bzVKTOOdkDBuweu8K7e?=
 =?us-ascii?Q?Y/T6gDVUfsP/Srig87DvtxhV9w9nLylZ3x7Te9JuPVWU83TMkjS+o8Lam6qx?=
 =?us-ascii?Q?c+goGlk46gvGPrDVNmpG9OQuoiqQQcc6X3pFY0+s4gJsPOpwxXF7pZZOsEjn?=
 =?us-ascii?Q?aNy1pxiolHwn/W3Zc9d9EXCIuw9/5NPA8JDVv/htj0K3rEokpF8Y0WTVpAG3?=
 =?us-ascii?Q?54w7QUlpkQKWvj8zdqylBKd0Q+6oU91zbR/2+6tquR05WJxNhuao9+wdyDjZ?=
 =?us-ascii?Q?gr3JhLO+Mm+Y2IKVStYtKchakry3e4+YXuZzZCOrFWyri+EfsR1cRuBOuZOi?=
 =?us-ascii?Q?WeiCCA4+LQj7l2eqSJ07zX2K5jloolSC1WuP+DO4aCe1lgCb0VX8wx+d6TOU?=
 =?us-ascii?Q?bpSGqgn9+1juFGJCJsVYUNxIBH1DrqH3pHLLH7xIa6JIfGWnFmAldkpp4yJc?=
 =?us-ascii?Q?2zO4nbpatrdx254w+U9irE9P3AYxxb1A7+NNH8g29zIOyNqNKaXDNibDRF+5?=
 =?us-ascii?Q?fDYLEdmMWq71YwlJLrDyO2IZfhQMR4eTgY99vvV+8QRBhqomUowYZq6Ki88k?=
 =?us-ascii?Q?PecS1Q5TaaZUUQgDX+1fOKGYVlhd13F4lNFDO+j/nuYLDgIRyedHj3cmUMvx?=
 =?us-ascii?Q?dDtlvwyvVQc0B+VgxNws6D2aEIxgXx4TCTpwPuTVV2jVCDFGa2x1hw/5c6A3?=
 =?us-ascii?Q?iNWFiWDAlf0EA9rEWnC82Jhl7J+RvADqtq5JY3HlXviq8QI+Iu6H3SNIiEg7?=
 =?us-ascii?Q?vqKVx+6MImDLVJDcNtdtxXpHez8zdE8Pf3O/A2mTlb30VX+2Ssu1Y7xJtEW+?=
 =?us-ascii?Q?Z9Qk2MqgZ5rNF3qRsR0rrA9Gh+3kwQR/mylx8H1lSYN4ye5vThQaprYDWENn?=
 =?us-ascii?Q?oaXxbeEfrRHKt1FHhf1IrLNGPv93dBDVwmp7hYSwuX83an7CLOgIZdxixZsW?=
 =?us-ascii?Q?jz8r/+RXZIf1q7+0woiuabBq/MXPf9gtx4RDMaODDJyu+WO8RndCQ9zjOi6r?=
 =?us-ascii?Q?4hLMfQo9c4GiegwVM9pxL21e/nFNwWOsbyar8iIDWPG9B1GhO+u/1LeSBFvT?=
 =?us-ascii?Q?44CoXc07A0apSIKbjCja5vs=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: cff889b1-d519-4fa5-588c-08dce8504585
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 10:51:04.2617 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2zvTP5j4NU52jE9ln9s6x41l77tLh19e+qjv0RCoELGuZA7A/oj/7yk8vix+YwBJcfPyw3fDzVIjXcFKlQP6jSvUov5ozOMWugOhF+ceIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10026
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

Current TCP code may miss an option if TCP_O_NOP option was used before
it for proper aligning.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 net/tcp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/tcp.c b/net/tcp.c
index b0cc8a1fe3e..3e3118de450 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -475,7 +475,7 @@ void tcp_parse_options(uchar *o, int o_len)
 	 * NOPs are options with a zero length, and thus are special.
 	 * All other options have length fields.
 	 */
-	for (p = o; p < (o + o_len); p = p + p[1]) {
+	for (p = o; p < (o + o_len); ) {
 		if (!p[1])
 			return; /* Finished processing options */
 
@@ -490,12 +490,14 @@ void tcp_parse_options(uchar *o, int o_len)
 		case TCP_O_TS:
 			tsopt = (struct tcp_t_opt *)p;
 			rmt_timestamp = tsopt->t_snd;
-			return;
+			break;
 		}
 
 		/* Process optional NOPs */
 		if (p[0] == TCP_O_NOP)
 			p++;
+		else
+			p += p[1];
 	}
 }
 
-- 
2.45.2

