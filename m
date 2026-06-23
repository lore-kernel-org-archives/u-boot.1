Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D5DCDB470
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 07:03:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC99084A90;
	Tue, 23 Jun 2026 08:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="P707gpGY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D8C8849E5; Tue, 23 Jun 2026 04:08:58 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D6EC849E0
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 04:08:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBkHpr9lz385nEbBdaAW2HKtCYYCU7Ei0RxXvijsXw+y3+f6Z7Nd/vE5thGclVrnK1ChxrQwcEcgu4tUgl7H7WSlTZxFJk+vSSOvEA7JMdwj8vRu7lsydZ6p7BENBnc8sj0NIm6YJdChJ85ajgejuRgXm9sXzmaWX32y6sOGhJu63aeNLbzvyoSjN39bZPmzcOxwN1SMBISgi5dvpnbFraHiGo2QOmq5O+458kr+e8ak4nBeArLrItRscn0G8XOKScawyP823vIvCXAgWjstYokad2rbXuGFk5pLTitDPNoKRzDEAm2KbxBdPfAxHA78BnXNLb/kxfjFDldzfuvLHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uc1R8BBFZFrOAE5U+ij+yLj9SR2adw6TicMuCT4w7s=;
 b=nxwhFqFM3fDn/kibdF8bId26GXddKCfx7ZsM3cSu02W6zhUZ0hFeSlwf+eu5rE7DWinsn+GcoOmG0eHZkcPRgk9f+NcGewboM26/PnRG/sGUdz1TRqHf0OaEL37fIJawosufZpWnpmf8nO+zjGSBXD1k/VbQTuwwLaszAu3w2HKd4FRSjqpufE0OBTKOSNAU2EyPXV4Yt2zmkPsjgwpm2qPFpUIoksM22Z/Cpn0pPMcBZRgA0nLocKBHZ78xwLplO3LbedSyidHTMIH5qZj3mY0GWZecLQPtIoFUz9KI4Q0LBaqwnNjpne2GYyK54kiaFigvHwpwX6d+bIT/59Z6lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uc1R8BBFZFrOAE5U+ij+yLj9SR2adw6TicMuCT4w7s=;
 b=P707gpGYUO26fQTFen8hBUjkB92+NjWbsySNzXeaL3K5JFB7xMU2JvY5OIvkUmiOkZnuKsSYrXEHCxXuzuBBaPAGQYD1UOvvhLbnLnEyhj4cr6gDgiV6KJB+dTWJWQS9Pxe5qDodhyKuCK2fexpXd9qEJgSnosYXtTdoiXtNoyJY5mplexUOFnJ7n2lG0mvi/rwDoE6EiXQBxbpmwE41qc3Fr99odTWLB7l5IRBuZHNrruNPcVMLjYm/NkE2fw5O3dCLAnYH0NRqV5jgUl91xjcEHrn117YAV7uIFVeFJOADdVKx7WIfBdYbVihNLomuhPM1m4zOHYq98rlhmC1cyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by SA6PR03MB8010.namprd03.prod.outlook.com (2603:10b6:806:437::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Tue, 23 Jun
 2026 02:08:52 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 02:08:52 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>
Subject: [PATCH v2 0/2] drivers: clk: n5x: Fix and clean up EMAC clock source
 selection
Date: Tue, 23 Jun 2026 10:07:50 +0800
Message-ID: <cover.1782178282.git.chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::27) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|SA6PR03MB8010:EE_
X-MS-Office365-Filtering-Correlation-Id: ea2d1118-efaf-40dd-3a2e-08ded0cc5f48
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|18002099003|55112099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: dM1noVRVwj6DNIyS64/m7ByC6DjZZ6uiPg+aF8VXCUltVcZu5En8clE75qf3fIqpltZaK4P1iCDOBJjdm9QPHxl4ms/Lq/xCVF4erPBU2pL26QkPhnebqDRCt6+/OJVo6PTj1Ke7rgsGPI0SG23jZJF4neEAwLqpMIGsmT8oyQfB0BfXFkXXdII5qgWxc0FLlhw4w3MH/0AhXHAXzoxQu0F7Xu7eAoYNZdrh3MMFB3PRkcnHGyaaik92TTRHzoUGIpyhZDi9sKYcFJHqcp9e5XZGRyxx+xmD/7ljBWjE7veXeXgqrW0Iybg+wDbNqRnBWebcJlTejbPbMi9IjqtQSdIRdDgz9Y6xhG2PQTzHptcM1rmPss6Ph9vr8X7nu8IAv6MdttHuwYf+XpfQJAv+Uh/h7HqxdTJK/deavsdtnOqWbBxjm52bJFOOV1S1/kQOUCv48SCnxMij0J8hRGtvNrakF+/AERyLJhj0b+xl1l5nY7LTC6iGKWQKqidDIaWMYRCETYHpGD/XqFb0BsHJ+PU4ghjMj9OIfin+58UcBmVyLuXQkgPUu3BBcRQft88InGgKNxohGvLl/rLwBTcyXXkDGeplprM9aokY1R+QxKoEmvDjLINia2szrRC40z2Gs6B9DTi1qUynwzrGi2S7RWZGb1+bw3j5j9FRKgzxPvk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(55112099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UjcSc/tOYf78Qzr4F6/zusOGCpnOk5l+QV8V+5SDVK3MqC4zak978FkJGDfm?=
 =?us-ascii?Q?qYQX973B6rZby1F2kLlnghC7QAZrTBQNEz+IN5UAYT7emIZywc1E8yYP9eB8?=
 =?us-ascii?Q?jJYrVzmleB5a2S7RNOj7A7z4LdgDQNOxyFB9RhknkNnSEjdqEsG2vmrxr7kH?=
 =?us-ascii?Q?ar/En4rQxoWrSOOO4xVPJciKzorw13/5+kRz9fJgRNwhl69uv2P70ImnJGFy?=
 =?us-ascii?Q?Sl4g3og/xhfjlXg+UXeiJhYA43ez7/qPrB40sLBKC2DZgAbbZns+a/tDEqWu?=
 =?us-ascii?Q?xyaNZzKZ7rvr7njAzoz9FKqDC9gCcnaUd+ppzpjKicszgcflQp38c7Gg6YaL?=
 =?us-ascii?Q?sRlbv4gfCkYluFjZx6GNaoQf3Wnscnr279cx3rGJLqb9irdxUmFqKEvy55eQ?=
 =?us-ascii?Q?Hp2vke8UWVnRLFSv40indGQEt0hB9Loyp1bWP0em9rK/WyWaQYPstREtCYwb?=
 =?us-ascii?Q?YrACjbEq4bcA5YY5OGfXxUCUoKhD/zHkiBbmyb4x44P9UAFI6U60QJnjNkQE?=
 =?us-ascii?Q?tDJXHpU9b2utkpXMc4uq682zeCGlwVAEWposh5Q+I3/KJ4oTnnKDXmActmmf?=
 =?us-ascii?Q?ZJyPQQOWDrutbK08CvZl2F888YwuNPc0lDtyOTbIHTP+mg4v8hW3y60W7cdG?=
 =?us-ascii?Q?/gF0c8AgTmujngxEv6Ic1/ykzvWMmPqLOxE6cUqi7N8t6X4EUNKybRMzrQJC?=
 =?us-ascii?Q?mz/WwKuUJ+IDTXYpvAIXys6AwhkzxTxmh76h5tm30e1Un6919nnbTBZHKkS2?=
 =?us-ascii?Q?7yqinhYuiJLvTFeVemKzEpVpQBxWQnoe72a7582M+xVaxrarZQTy3/Bi8jDY?=
 =?us-ascii?Q?zP6NJrwqF551Mt3MR7GEF37LblQBYEVAwQYQ/oWgGsg7iY7BY5uk8Oimdjcx?=
 =?us-ascii?Q?qNeb0d+PN8U1UtwmslFX0qLSB+mjJNRU/9EaL69X579zVJNVAfbo4yseR5bq?=
 =?us-ascii?Q?zVFVNEfxw3cwc59udxyJhEo2JOHn5uYhN3FpeU/MpO02rdHkX4MdOr8RXIBX?=
 =?us-ascii?Q?W6Cq6CIOh6ruUiachBY1UmjZuF0ThDbG7zg5fLjOepjqbXeJyB++nC7jWchs?=
 =?us-ascii?Q?2oc1TB5l2aDMz6T1iJxx3sI4goi/m5ua0i6mlKa/8e+pq4OZkIALIBVPQgst?=
 =?us-ascii?Q?3xfbETopgHktKeE99dvIOMyygQFXcxsZaWa0UTcEc7ZPEgnBLopdckESY1DG?=
 =?us-ascii?Q?27I2SYTCN6jN+ASCbcuJgPFbRCDROS9uT2wyFHOvxubst3WcRGNp58LAwjXK?=
 =?us-ascii?Q?UUHGhC3U0zpDzNnxmTUdoFWlvxCT2nd8i/TzjObkfTbXqFes4AqhEK9XY0s4?=
 =?us-ascii?Q?Wtb9WKH9eY3hUwbp+KIG6G+HyIiUDxBARVTVyfDXArhLCJsF7NcaBAC4Bya2?=
 =?us-ascii?Q?NLvFlfDITmguM4BTi5WDKHGcl6mqh+W+z5H/wWCn2Cha8A6mvA0joQFjvhGs?=
 =?us-ascii?Q?bPSu4CIqxXXnc6nWq4owt7E9Ql5XjpVeAlXzfLezZXY3m6SqZiVG3AalAiCO?=
 =?us-ascii?Q?EbEWiiZZOXhWhQHsjgKFHKty8mN5hXPTCM3swNpqVrEjhRj6UosqFaxGp1Pc?=
 =?us-ascii?Q?3nHvVD/UaH0lb6uRNKY2MPodDN8tcJcUxFUhzYxdSeCVPDsRC6JiRmnVdol9?=
 =?us-ascii?Q?N8WgfxN1sXVy9wLo6WtzuRrIhrNAXOxdhngYGm8rBwT48Xo8yFTvw3WTH27m?=
 =?us-ascii?Q?CuXBfX1u7Bu3hk4bM0n7oSAHZ9iPkS7NLVwnGBm9s5Lo6MIcdcSuqgYzISM6?=
 =?us-ascii?Q?Lpu6spNwLpCpSc9LYcSf+uPEzspuFq8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2d1118-efaf-40dd-3a2e-08ded0cc5f48
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 02:08:52.6552 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZObKEFaJPrGV0+NuTxDtDYHM2IPpCum87vQn7HFui6KQ4+RQyM8v2tV2/8yv5D4ibGS9DYHgKob/lifmkpOmyQgjhkxqYpwEwR303uVe/h8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB8010
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:59:46 +0200
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

This series fixes the EMAC clock source selection in the N5X clock
driver and then cleans it up to match the Agilex clock driver.

Patch 1 is the functional fix that was sent as v1: the mask was applied
after the shift instead of before, so EMAC always read the clock source
as emaca_free_clk. Patch 2 is a follow-up readability change that
replaces the open-coded mask-and-shift with FIELD_GET(), as suggested by
Tien Fong on the v1 review, aligning N5X with the existing Agilex usage.

Tested on Intel SoCFPGA N5X SoCDK hardware.

v1->v2:
--------
- No functional change to the fix (patch 1).
- New patch 2: use FIELD_GET() for the EMAC clock source select field,
  for consistency with the Agilex clock driver (Tien Fong's review nit).

History:
--------
[v1] https://patchwork.ozlabs.org/project/uboot/patch/20260507090215.18074-1-chen.huei.lok@altera.com/

Chen Huei Lok (2):
  drivers: clk: n5x: Fix incorrect EMAC clock source selection
  drivers: clk: n5x: Use FIELD_GET for EMAC clock source selection

 drivers/clk/altera/clk-n5x.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--
2.43.7

