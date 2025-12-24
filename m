Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861EDE75423
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 08:25:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC47684206;
	Wed, 24 Dec 2025 09:24:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="qO4SxdG+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4985D8421D; Wed, 24 Dec 2025 09:24:49 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50DF3841D2
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 09:24:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhmDDASBXRDVC1we46/x4wXZ7TtK4NRF3Q9mgpAiYyifwJs6JMaIxErjLpoBnXajugqnC1WxO/hkIqVVGXgKbxN6d61pmg6iGmDthJBp2BFVPMfNzN+TQykQ9LVL7DLwl8zKyp7EDmAyi8woPeEL66YesI8kyAU3R5XsneA3t0Z7RafbKnGiHD2h/nSXzS0B17ExbRUNRrPjr8ARLQmRPy3IvVcKOYurSfTh2pMHbSq/UHdd4p7t6rpfPzifIvhALaJXieFkaFt/gmDz0QK/MYs4QhG+E9VUebT8S7INy6OGKNKtbqMgy0pLZxmajXzaasl15Fo0JlaL6DRPI+0HVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqVNwd8khqFDo+kPHAtNbu2fowXYAwaZJ7cge27IiSs=;
 b=AoMfAiY/jt8ciA6Cg7NHiYcKDKC01PYYpdAn37ie+vBdUf7Jbhr4yMLnK9LavDVj5vb4+GfKH22wCnO89h4H+4UgsL45ix3esIdJgNzFRBHRSRHwolZu5crl4VI6xbrSC1AePdpjQ3JCIlKaZiTPr7LQYJez1DX8VmCoXSCqzTj738wYgOdkc1VSaBCLKN50LDAs68KbkIoKb5mSETmSbzx7MYJaz+Ji+noQ8mhU9tre08tQfH8yV/JaF+G7K7i2MOWOWkg67IXQ5TyOyDmrZa1zkPt5K0UOlw+K229xJZZJ5sxZUc7ysztVtv+Nugo7akdGdV+SvHX+b9V5ZGzcqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqVNwd8khqFDo+kPHAtNbu2fowXYAwaZJ7cge27IiSs=;
 b=qO4SxdG+kFKQF1b6cm05S754KK+ylj30yEN8yjWEB4q2YSvV1Sv76Tyw4sOoJbMwuL2NwywOuaAkQgfUoObqarCPG+4Pde+u3JrD4qmgfXe7odmF78LJ+J/uh4gW2yLBfU1qc+h/EMmiypZoi/wUfUNJxpLkquy9asmBDTvX5dcx+kJIkcfqERfA+MtxZqN+gXJLOU/cMDCyGNWK7Y0ltHAz17myCtf5481LUjw1qrjcIyxaR4pA+6ZmEhR0X+AzWyvHa6xeeikqYMBunerJPjzUN3EOlIdxNgGj7Z0KdIb8FYMHMCbCpj+aCFml7uCHbF6Rm0eswxlqO0rSF1hfhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM9PR08MB6721.eurprd08.prod.outlook.com (2603:10a6:20b:305::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 08:24:45 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 08:24:44 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <me@ziyao.cc>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Markus Gothe <markus.gothe@genexis.eu>, Greg Malysa <malysagreg@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND 08/19] net: airoha: pcs: improve/fix building rules
Date: Wed, 24 Dec 2025 11:23:58 +0300
Message-ID: <20251224082409.1347373-9-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224082409.1347373-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251224082409.1347373-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM9PR08MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b0cd86f-175e-4e24-a562-08de42c5e4b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|52116014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Am+Yko0xK/ZmdP2qC4Gab2mnuz2mkzQWl7YjooWIabCRN30PUoqSnpfHVdr6?=
 =?us-ascii?Q?Z47tZp8hcM/WMN/XM6xUfiRwIupjP5AJO7MILwMUMSMIZk0jIHVILI5LHOLE?=
 =?us-ascii?Q?z4GigmflUQ90ji3/3kDXavUiSKJYu7XIr0+Pe2r20Zgv40lxF6bzsxnRA15z?=
 =?us-ascii?Q?21v5OG287f+eAG1ExuEsHd+gqGqlmU852lYgLpumHR22LjJ49q32pgOxOMlz?=
 =?us-ascii?Q?uJQTzQuw61xsYGqtsJaHjoQuvAPJzQdBI8BD7pd2p2JOVc3uw5D5y1C+YJwI?=
 =?us-ascii?Q?jvkI5TQqYxGOhsRToRbuCYGxfNHyTXjRZef/Pu1tjgGpRSQQE6kJ5GtiFAnW?=
 =?us-ascii?Q?vFvg6XkXGqPA3ynlfNMv2sfKqEhYfvlO7UxIW+OBVOQSOnV6XZ5zhlqNOgaK?=
 =?us-ascii?Q?b1z+qh4oS83efk3mO4+LJbw9iO6mqbG/HAWFMPVPSVN8Wo5fQPWD3NIGKGik?=
 =?us-ascii?Q?QYJxE2hMlQaLOjIjSoyRjcfXiB5ZMsnOaq6ZHFavq97TZ53GSyYLuqRLmW/K?=
 =?us-ascii?Q?XqW392/8IKwQgN5wPQCcftK090TJ0Ty+Pt9/8EL+0HgLb9yzyMEl3iqI534R?=
 =?us-ascii?Q?llS1OqmJbLKhsnSFgyW3P3fC8TjTVa6RorPohbJjNMo+DMm5vMi6HCEdaT92?=
 =?us-ascii?Q?CjYbPJ/HBqQhfVuXOHhxd0/ATliIqdG4Moz+mYt/ytKZmbCsDWziqKj9P3ZX?=
 =?us-ascii?Q?3szxNLRrtyVmPiyECiW5XKC/JaVX10omw8tLnrm0+SoIij8+03osR/OTkJE5?=
 =?us-ascii?Q?iAELz2At5XVSbJunECDN3QCLCey0Tk7IBe7KIASHw7p9zkwnjFZMf2aE6JDM?=
 =?us-ascii?Q?2uuKvn7tVYFaXKja/FOLG0NpN78Pdvbjt1ycF+H06QYnpBdIth9n3neOO+CM?=
 =?us-ascii?Q?W97TAFbAOES7JsuktdGj+LyimaJ0uVTiTQEF/9s9fMjmskI78Xt4i7Ojk34Q?=
 =?us-ascii?Q?7k1alNCmFDUAd0V4u+D27oEehBWBV3VG5qWgfw7/Rptq2UEY2Lf5SRCxp9Hs?=
 =?us-ascii?Q?VokQs2m/gOaz+yy4uXm6AP7T3MJykLzLB9QsFTVrYHEAdVjiP0vLS4c7yOJg?=
 =?us-ascii?Q?7khrAr6Dk2t5zcKJHT5VlxuhAZFc+AorN89THUVUS/KQlRCyUhG/RpyxNUKs?=
 =?us-ascii?Q?EGHCa72tVVzOSYE2yh7HxzCCUXARKyR6/D8qfLONUYkJA/Q/GxLwEJF9LifM?=
 =?us-ascii?Q?8dp1ESh6TRiPS7ETOMzy7HWyCPD75Sehvt4HJgWOYLH/BQIK1W5fRKD+xYAM?=
 =?us-ascii?Q?7toncsWXyXWW47GWAj+/QLElG368qUGhvHG6u9IuKtFSSIKIIxjHU6Szv5K1?=
 =?us-ascii?Q?Likh/f/ky69TC8BM8gkMmcx2U9ZMzc5AI2IG5fnsMa26v2GvqI9IH2KN1QI0?=
 =?us-ascii?Q?qutDwCvymtnCJa9IptKkHXNpmAFheLCppATYh0gCFY+OXB62QUqhJEgiG+oL?=
 =?us-ascii?Q?Yz908XlieCgKdxKm4aMsd9abYJgZYyEDV8e19bsXA0KTK/28WmEmBWdp2fJq?=
 =?us-ascii?Q?0K9LsjEH7kwYOMrOUzd8RjW8AktUv1LcrJeg5y6E0Zlj4flVo6Wk2GbnOA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(52116014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?213Ujbt0XGVjw47yX0K/aMavkUmRrsH2J+esMqAy+Ao5UM4LmoOAhrV+U8Y4?=
 =?us-ascii?Q?hefc0kgZ0auidyluBso+rNKqAWZVDww4w2DpHW9WHVr+pU0DVjJAPdqq25SX?=
 =?us-ascii?Q?h/DdrUvL0sZPXU5znBdQW0dBQ8X5tqd70owpHs3JY3myb0cwdoqUdK67P0jU?=
 =?us-ascii?Q?OdLUcdsiR0tJ5jL6p9s+Lf0vAIwQiU+5R+3Hk0i8BdBXNuF9K5+fmsbwkvFt?=
 =?us-ascii?Q?5eo/ZdyjMpXKbMO000fPukYSfCtFlOrTDrYK0iqWlLhg2DHwHlthzeSV1jUb?=
 =?us-ascii?Q?HgaDMO685nc3oNBvTIpBSCXw8Ls80y67cQfDcjYl9UxeI5ED2IRrNtxAswRq?=
 =?us-ascii?Q?wumzlZIP+dfqnBhLY+4/FZ7tMA45iNMV5KOK649IPwoVhIA4XqFRpw49f4Xk?=
 =?us-ascii?Q?4TNLUYYiKL+WkKn/TZzzhjOkQnMQFm/d7onVJ5icCPlCBOp6YJnAN/RdRXF8?=
 =?us-ascii?Q?D4tHaS1Y2OOotjDmUo/3M1e/gD+4Hyle8NfL7CZLWVG2OhPlbowCGELUoyOL?=
 =?us-ascii?Q?Yo17G6wCvILaNh8QeYCqLC6rLzYw4oYuwpJKlJG1WcdecSSpB+kITWMTJm6r?=
 =?us-ascii?Q?1xigvt2l58OKhmS33FBkyVHBsTKK5sJ9MjgylI0Rx3g/MSRH17XcjJmMlw7H?=
 =?us-ascii?Q?/RqhXfo5kfUkH8ui8ds2aaQBYw4LrQmmeuoIx7Cteo+0GpWgU6YZkZ8Vac7A?=
 =?us-ascii?Q?rMZjR/HoDnS732s7g81QN5z0hoY6dZ9fyq8Heb0OiK1axyNq/nMjxfNcaSRY?=
 =?us-ascii?Q?PZwq7bjjHKKr0lO3gJQx73KkX3bUEgKwLBsMSmWKbYsHd3JU/htwq2dxxNF5?=
 =?us-ascii?Q?FVAImOlbjJ9FQqzK0U0xPvbVAupSxgHdWCoeMc4yWtI9cmVOk4lQPmPdyzhd?=
 =?us-ascii?Q?pGac0AAdTsJmbVXyEIE49MwMpfYrY7YtGgMw8p+Q6ztKsE0hmebYof1eWcVA?=
 =?us-ascii?Q?KSU2cjAqsOhIHLZtCPR8toa9ctIhcutrZH4RzuCmn6gLwUABGf3t+T6IMHW4?=
 =?us-ascii?Q?lPfQ9u8CtmWr/xHBj7pXbKv21qj7eBYRz857Sbvx1rLuVsq7jh0pihuimMcG?=
 =?us-ascii?Q?Z0guwgGea69CXPTRkouD6O0SfVpfmmeHh2Yaj789ZUbKxliUiLAQRHVHvEm3?=
 =?us-ascii?Q?7pAhFYD1tHR++yumMchi/jY6HuN8nC9MaZ9b8Uy2uaKlFTGM2BPXyZk+B7/3?=
 =?us-ascii?Q?0c7ukHnnOYnRGag673CydHfQ/YaI3gC8qVrfFx9dZIV7QwcVqii/Bm6YYnVz?=
 =?us-ascii?Q?QcblS+hDFXd21W1wrT8IRUNep6TA7v2DuV5IHntFLKBk6J7Iemq5/iS6nFLC?=
 =?us-ascii?Q?goVggZm2bHJ9RM68uM5Gdgl7A4erlyJ79ukXVfOesyIkjmg5+ep52peQHMjd?=
 =?us-ascii?Q?wffEWBRGietW6Ryp4bnzbIgnjCzHQr2rARNrJgeE3Ea07IH5q7f5x//Rsl9X?=
 =?us-ascii?Q?LyYhNU3L4hmvASgZrdTKkgUHSfXlDeWO4Dfpl+2ZPcXmjfvEdnXQc5+7/84c?=
 =?us-ascii?Q?OsYg2zxrWk8haDX6K2Dg8AEev7iMnmRnYO3SYcTL3tOHPaWa1tFNkweeBF14?=
 =?us-ascii?Q?5egDJGk2DjLvkzmCoGYUY3PGrjcRixaLNPuXIcjfOACPbx5gwHxmbyIPy7q2?=
 =?us-ascii?Q?s8EtqlrtJFaVBPEr/XOKB45r8rtIWl2fFR+lSU4NhvSfMqcB6lCFHagq3+hb?=
 =?us-ascii?Q?eSvTPTHYgQZbu6BK2gfgiqp8Y17W9Mv2bxdYURTFN6ZfDvG0EAcoYUUDbg4W?=
 =?us-ascii?Q?l7YPjlM4CEiYHhZdSj8gYQTBwfMg/gw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b0cd86f-175e-4e24-a562-08de42c5e4b5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 08:24:44.7460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oap/WdmMauykO2DxAqxiySEvNMiAxjgRR8kp8COcrnrdRSJSKexL282l7jZKQq+12CNRfObkD07AM95q9PRmrfH5Q/Um1QVFXR/TItJ4zlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6721
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

pcs-airoha-common.o should not build unconditionally,
also make building rules looks better.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/net/airoha/Makefile | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/airoha/Makefile b/drivers/net/airoha/Makefile
index 27f2969434c..81fd26cf813 100644
--- a/drivers/net/airoha/Makefile
+++ b/drivers/net/airoha/Makefile
@@ -1,6 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y				+= pcs-airoha-common.o
-ifdef CONFIG_PCS_AIROHA_AN7581
-obj-y				+= pcs-an7581.o
-endif
+obj-$(CONFIG_PCS_AIROHA)	+= pcs-airoha-common.o
+obj-$(CONFIG_PCS_AIROHA_AN7581)	+= pcs-an7581.o
-- 
2.51.0

