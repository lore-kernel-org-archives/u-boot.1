Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5AC6C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 19:36:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 619F182B07;
	Fri,  6 Jun 2025 21:35:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Y1lh0+i1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3257682A53; Fri,  6 Jun 2025 21:35:40 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4F7E82A8D
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 21:35:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gy5jnuzRvngKn1zwqPJh05RUn470FjA/w13FhLhxm6+iRJ1V72YnIbZEfq+xp0B9X0tK2jH5cyvckW8yY1+OQlxuL/Nf+76gNx4c30rpYHAUAc+pIazOtTZ/IOuxBrMr9dwuwKp8514vCANSwSNvi5VKOsM1R4HizlGdxNg42EWZu8G6HpVsW+yI+ziJApXcnO71ZZHJiIv0fr1sItP/n+ydINm5083lEPv9lomaGoz200SGsg3relGAdOuM51MZSkTcF6EXXr2hx8BcdisLRgD3lWKAtcU5P+yQXdwmktlkYjhw0BgiBeGW+JZkPxzgC1uzuRFa7m1YW/kAhuIbNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQxmcHqOhYIiVk1oEc+X/tb7u6KrcL2Kjm29GrvyrRU=;
 b=pHcR3ciXDmEcB81DQrTS+MhdYjn6h1YLqgwXNdDsNnRCsDzyiLd9IgRxaeiR+/l+4JUjylSN9hP1CQVMhLtOmOBfHKn7OBvzChdoo7imz5hiLabNZJq8NZxL3lQZ5xIiZmxLdLOYpIWnbGSFYQJdesMAqc67XZnLPFzD7mxPH+IqclwWXL8pKbjgUkbIadUuRj62BGiOfSMdBXufTxCP5pbBpmWAf3feRgQnSMdqG99SObBm77eeOicZE2ka+WWV2ASkGf4d0HANI4sUQLlXu8FI+Lc+19rpZ5KacUSiKYfvX/ZWefMS9QGV7hAUZaqMHtXChPpH4OyDHfZ7KYuiNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQxmcHqOhYIiVk1oEc+X/tb7u6KrcL2Kjm29GrvyrRU=;
 b=Y1lh0+i1d15YOMwc7V4ssiWjK18XeOauX71Bz/v5rERQiW8XkGrrc56jnvn8/hNEFSxsWomAscvFAKpky0WQicGKNRLyTfEo8YcDcZ/v1WFRJ73OYV9KUMqSw1XrDIvwaZHNzVjaSz4hbmk9yDZU0F+p9BceWgeO7xdCRY8hFyzPJEbfRJSXMMAaT+K6kWiSNUM0bpU2ntmYL4G3StY+W98I45Ua9Ic4e0ekSYd6B64Z4MiLqHPA/DSbeg2WwgxInhj+Ldt+YoxAWfG6yJQJ9A/K1X5zrjTDgBbaxf4abwK05Xu18HiDQ6ApOy56/RsVNZzL2Sm0SV54irGVwccahw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB7623.eurprd08.prod.outlook.com (2603:10a6:102:241::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Fri, 6 Jun
 2025 19:35:36 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8769.037; Fri, 6 Jun 2025
 19:35:36 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Edwards <cfsworks@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 3/3] common/spl: improve error handling in spl_fit
Date: Fri,  6 Jun 2025 22:35:24 +0300
Message-ID: <20250606193524.458095-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250606193524.458095-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250606193524.458095-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AEE.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::318) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAXPR08MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b182990-aee2-4cc1-3694-08dda5314fb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?M/DGrnFJcXfOdKcH4G7T+8FmUSI4JV9CAk5wUJKzCLkvrxtHCou2KbhqXRz9?=
 =?us-ascii?Q?rNTkb6V59G3ZAo5ZPKwHhDN/zr7miTmvAmX0vCK6BWMeF3JO2P0oMColNQY8?=
 =?us-ascii?Q?JHQltc1paOqW1dQUmTtt01D7bA9JTBmxS13ZbsuYTjiSVtzEI8ia8HHNITPQ?=
 =?us-ascii?Q?uiyO4D9uKzdAWqAKGeRcSCuO9tqWnaW6nyj6DYk30PvwREjj+10H75eTx6ee?=
 =?us-ascii?Q?YI4NUA1ySc7fYR/2Ulp9ZFcgmjCO3iyZchMbX16Dm2wWb3xAhqPgsOofj1DS?=
 =?us-ascii?Q?HmRiqVdYJ90pglCOH+N9baNercupDQDfVNTQKORVLsoUM/6Pd3+Hlhs7rKRc?=
 =?us-ascii?Q?/85KZ8O9bp4XHOOxJ4Omw47o+vEvKoNmvwDliHACIlgq7c63Q+sm3Buv5gFD?=
 =?us-ascii?Q?eNJO29Pn+KG6a7hacQ+QoGswiFbyT/5MrCOnsabMT8/XjRlqbSRvPjcDpTyl?=
 =?us-ascii?Q?fap7S1EOxrV4dtwG8C3v9m91dQNpCtaYA1a7BEZLuNZMJdwL1oroNG8kKeFo?=
 =?us-ascii?Q?AD5t217jeL9WbuDKjDXqmmjmcry5CUQirQlS5YCGe4M2abkGl0u28TipUXZJ?=
 =?us-ascii?Q?McaP8Uc6tjIhpDc6wBW78CxzG1WIdPZc+hXg3AF942gqPhLomrOZy7Uk6+tt?=
 =?us-ascii?Q?Jp3rm6WWFVIoc7/SOh43lzdvZrnQGaVjn2KBm6+RmZGNPbtcqX5kJOsxaNR4?=
 =?us-ascii?Q?ReZIX6VHXHEijE1J7jmhNwIH7fKSj9HR+nPI7JWcPjP+2NS1i1eQItJtxFqG?=
 =?us-ascii?Q?vEMZDOh0MSnQpI+dsSODbsuQ7rsWlKFthXjLv6l7J5wI6xv95hRwiLzu2hIh?=
 =?us-ascii?Q?AquRAXmiCneyhSR5DhnBlbQKigHPXBg62Ct+83aKllWy+4BR/VGfA8O4SNRd?=
 =?us-ascii?Q?7W1DxcWVUJqFtjmRkdGXUxI+qCHDVoNBGNWxV/PmyAK0MmmHzNZif5zBB07k?=
 =?us-ascii?Q?clR9SIRUeclTOmerG7vTs0ahvyQU4y5WvCw2CxafkiLiN8yZGAmG+iYBM4AD?=
 =?us-ascii?Q?WKd6p7qjaJNY2iDb8KpyVlWtT1DnID5YbGp1dsoe/7E31QnsYkzJofkoTH67?=
 =?us-ascii?Q?SzkBumXAmjZQGfM9uVmJQw2Jo+ZWFGIlW98opPb5erUzYCpvOsXCkyA9kUOA?=
 =?us-ascii?Q?ev9YMAv37PRgJLoYiAfUxVg5gD4TjhCAo/FSrm0eZ0N9eAly4GtYa4wF7d2P?=
 =?us-ascii?Q?GHAMYLDUwoRHlZX3arHBk2JibVkHcxI2LbbTgZEE0W42I+L4nHH6nIQm4kS7?=
 =?us-ascii?Q?NUNchAF5/9vNN7oaddDG/4JmRuwaornlxqdpfSlmU70Qwas2pov6jJvZPHFX?=
 =?us-ascii?Q?py2h22F8rYznaNvXeqEgp63lQBwCchJw5wT8YIcA/dJ5PbPpj5ulHgIGE2vg?=
 =?us-ascii?Q?mJctgJF/WyXiytIjL3GzuTDkVICIYgbJx96tg7uo4zkJSpFvgRi8U63BEuPT?=
 =?us-ascii?Q?AIbWpyjULbGSxrVroDFNs7u4qzBwCEOBBg71w/gjkqZmkwJ0xamtsQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EnEPE5iwcXf2Zir5VJn3wXhp29BwxAf1K+xqTpp+8GvbDSscJCqbz8ONzgtA?=
 =?us-ascii?Q?2YS36POaq/j1ODxrJiqLzaM62uasT3ZhyTxSzCClqUNXIGdEs492zucXVaPy?=
 =?us-ascii?Q?/+IB1sS1GgNW6AwsL8gl0+QGe80JkilLZvA8qT+UpZ3yvuY8EztoI51pymW+?=
 =?us-ascii?Q?JysD+ZrUEP0FM+KHDW2hjIXmejiSRa0GID3ZaT6DKHDrv/luQXg7ScllKC7v?=
 =?us-ascii?Q?iBYa2lA8TXLrl3XiVn1OxIHLPPZNYPOAQ0TipERZkc27ptCMkUIiqlpmJk23?=
 =?us-ascii?Q?E6WcvqaS0r4mOlnFXL523aytF+PRZ371nAxiJYbzb/t75wmqX8gP88VD1P3y?=
 =?us-ascii?Q?JuzLvWIL+vXOZTOst9tTIOqyiVkYK67AzHZZjnCBUT+i4GtTTE8FeawxyoGS?=
 =?us-ascii?Q?7rXXMoySRB0VpXiJHezKmsNjah9CZMhkeRy+gQl2Y4W2MWyYV9gyoOe7okUi?=
 =?us-ascii?Q?sfc3qqwAFe1k62kVHtxeuVk9jqGZP0IgnFNFOlui4RB7Q1SZ7zeLoCspnN78?=
 =?us-ascii?Q?V6mfOw/EZFjZCc9QIb/E3Oj6GidkI39RQha2M+1yAgDXCXaGiCQsGOib6aGD?=
 =?us-ascii?Q?2aZ2VwNv6aVmLd67MWBu8s7OBdARMlkGzHKyQAjPxKoU0nC2hv51wq43OYY7?=
 =?us-ascii?Q?7ixZFHnLMvFrI8trXpMDompuQ4bkX88Ppd7TCtUjhFzddi5jXT+S47lNORdT?=
 =?us-ascii?Q?nX8TAtJ9Gm5QDe+QXJLjErUXtVDG3lr93+YHJzIMlSynnUqDaNrCJAsR6FQ2?=
 =?us-ascii?Q?VPjVFSY+rW+oJ4LY+WbPSnYkA/CYxjOkO60hbrYfI0/kxpd6ZIgHzrH51xHj?=
 =?us-ascii?Q?8tj9Wm7DNpoEx+N0B+/IleSavDhAt8Pu8Mvy0+4m2KoV96pqgStpppQqhS4A?=
 =?us-ascii?Q?qXisGOk5V8dvQMyLeXqwT7drft7a3xF9WCYWPMNeKSLpD/O6v+yk2o8J+Hax?=
 =?us-ascii?Q?XeThHeUP4AKT/vkQoTGNSlBhqwhYlG1ca4yoawqjtk9Pvq9RHxaUcDYPwAjr?=
 =?us-ascii?Q?692wsitcOPRkpjcCLiekF9jM6iMzldukLf/bwY1SdsNtMj6Uo1jVw+RexKve?=
 =?us-ascii?Q?Ub/WMVsgL7pqPRoBiosA86XzQxaw7yap73wzwXk6v07vjaqZyiZHYYMooMDX?=
 =?us-ascii?Q?Fl3McSQjj9cs1rj+moPLyzNt9/k5fSVtQUQqHm+nZt1nT1v0CZzAEw5ca8Hi?=
 =?us-ascii?Q?KxUpMmDYTZeQDbargg19EaCqCtMAg9rCCPeKTZHvWvW4BpguMa5gAD4k4eu6?=
 =?us-ascii?Q?41Y03kmiJkxBwUQBS9mZtc8V+/OcBN84fSzrZI63CIIvBpqHwKR7O6JB3FKH?=
 =?us-ascii?Q?xe8gcmjo+etqb1GDN8+mq00UoGlDuGaq/xXES5ii3zBuAk/VAi7aVNQ3a9nf?=
 =?us-ascii?Q?tpisK9yeKzJI6qmIiCba15l2ckdPgg/3Nm4TgsJ7DJLLTE5v0QKLPi1g9fzp?=
 =?us-ascii?Q?W1fbBRBiW97O4og4EE6d1r4C/ZN7v1k81DVZOQsRflI+XCrFt/Sp6LOI8blR?=
 =?us-ascii?Q?fciIEyyp3gVKLkucv5puWhUBRix98/6uaaZXWKZrhmd5VJSMMKYNip7abB4c?=
 =?us-ascii?Q?TXl32/gCteJr3gjjgawXwbbJ/yhh7F/XFp9SB3B5BdX2uDozb6G/LfytzhLe?=
 =?us-ascii?Q?NaxQzoBfCmFCOSgAfR7Tz2Y=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b182990-aee2-4cc1-3694-08dda5314fb6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 19:35:36.7767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNlc3aGIUgu4BthBrWudiVO2asD3VTTwne0s1XHX5uQxonkFK2idxLwBG5om+QEW8wshFGeau7hTzROAIVKvgsbsIiQPgl/FD0Wgu/uoJU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7623
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

This fix possible NULL pointer dereference.
Also some comments added about potential memory leak.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 common/spl/spl_fit.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 783bb84bdb5..438d1ecf124 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -703,13 +703,29 @@ static int spl_simple_fit_read(struct spl_fit_info *ctx,
 	 */
 	size = get_aligned_image_size(info, size, 0);
 	buf = board_spl_fit_buffer_addr(size, size, 1);
+	if (!buf)
+		return -EIO;
 
 	count = info->read(info, offset, size, buf);
+	if (!count) {
+		/*
+		 * The memory allocated by board_spl_fit_buffer_addr()
+		 * should be freed. Unfortunately, we don't know what
+		 * memory allocation mechanism was used, so we'll hope
+		 * for the best and leave it as is.
+		 *
+		 * To somewhat reduce memory consumption, one can try
+		 * to reuse previously allocated memory as it's done in
+		 * board_spl_fit_buffer_addr() from test/image/spl_load.c
+		 */
+		return -EIO;
+	}
+
 	ctx->fit = buf;
 	debug("fit read offset %lx, size=%lu, dst=%p, count=%lu\n",
 	      offset, size, buf, count);
 
-	return (count == 0) ? -EIO : 0;
+	return 0;
 }
 
 static int spl_simple_fit_parse(struct spl_fit_info *ctx)
-- 
2.47.2

