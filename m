Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F280ACF34C8
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 21:30:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22B118901A;
	Thu,  3 Oct 2024 23:28:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Yf60Eopf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E8CD89032; Thu,  3 Oct 2024 23:28:29 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F040988FDE
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 23:28:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X9qsuvgXg7PBRw6YbWRJrn/NU2euPFq2wcKRNmm3+Pr96vPlOVyE8nphxmd1la9iHiUTRNHmCRL3MSorpcSYcJhUEXyJFnFX71sp2pSoCILEdoDPBcbklYu42OHndKuhqPH0k+TGr70TwQTGgxK9zkYD1dyrzaaEoVhVfHWgJPfxednqAhpu8Z84b+cgpgVQIi/gtOotg+QlbIlqw85FnhloAPad0XBPFdiq8qbGj0nXN0d1aVm0t7Hjqh5VNjEX9rTbVR95IpkqMZbNi/5mUO37+ONDVQc9DGXt0EB8MIO5yjrUoYKiSsWjsz2AJbKHQ3iVbTGoGk1VgNha0WqaBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7YL/Z9M0a4M4n8Ehe2PIBVuYOram7Iso9n40HXJI4Y=;
 b=wf/+Cybqtox/POgL2CbV2EgPzZth2nInINPt/mmhuvTPs8QPPA1Hn9o1xuNSLjBqwKU5ATQrDr0D34/rhuNBtBzuD2ex9W4rimOPr1hBUW9ZP++Vz+FOiX9HFT2EwTmxGPeViDMIGRnKX8x/435Tbjw/P0RbD9Fj9BV6NT8QyfPtviwmB5OK5wqIrLolKlMjNIQiLjGYFHZmq2/D9cT+DNkOpwJY+GwJV2ZpxF9UMJG3qbn11v3DcdxEUzg/+jik7JlE7/s7KGCbvj+u8loXKZOCyEaIFOwirrTOeSjCtj6dUSTQ4JOeEHAlCdNiIwOOWcYNzp9uJQAlmXL6XhXptw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7YL/Z9M0a4M4n8Ehe2PIBVuYOram7Iso9n40HXJI4Y=;
 b=Yf60EopfJ2mRozN1HSl4A3XiNoQv5pVbg1O95vEKwWTqrE1YcXQnWlgsMswAiGqxUFJo0egr+sPGwLoajcz+O6etpf7VP/EcJ3LOaKZ4pBPRWD+QLOxGz1fKAiPxuQBQ9Qfw92vJD2ab9F7DuyDZephpvA1xBDwSMnivkFAqJJ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS4PR10MB6063.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:582::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9; Thu, 3 Oct
 2024 21:28:26 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.8048.007; Thu, 3 Oct 2024
 21:28:25 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 12/13] boot: cedit: include u-boot/schedule.h
Date: Thu,  3 Oct 2024 23:28:01 +0200
Message-ID: <20241003212802.3810-13-ravi@prevas.dk>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003212802.3810-1-ravi@prevas.dk>
References: <20241003212802.3810-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0014.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::23) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS4PR10MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f7d4d8a-15f5-4fbb-16ca-08dce3f250d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xtKigCU1BqD3L0kJ8npGWHQFWGeIrDByUpG6GtA2vH4lqNpkdFRquI1tbLzd?=
 =?us-ascii?Q?a6wj/lLHEHNEjfaXiMC4vN8HgPKwG3zq6LzX8l+U/IAt8P+0qOi6DkEbLGIk?=
 =?us-ascii?Q?8KRFuYhYXS4bYtyn2oU0KxUk1018nX8svC7MYregFOdsseGQ4I11OKaUDafg?=
 =?us-ascii?Q?kOzu/2Yyqf4BNaJ3Bo5mRjwi4l5otXkD25bRWlpBw8VlUs8Q3swvJVlRhO8P?=
 =?us-ascii?Q?y2NVvmdzLrbNo4xE7340yIDprUpAcDKkEkaWpQ90AINtxddueLZ+yjlHZI2v?=
 =?us-ascii?Q?fZiSBneZVJlJNKrxTXqywcx1o+50fYnlnhYvRpW2emPR+7LZnpRBVhHPr2Lv?=
 =?us-ascii?Q?UOFtsR8uAwOJ7zufbUsQf9mvBPpB/Uq2BubjvLLyLFEbZkM+V+xOFpUBbLK1?=
 =?us-ascii?Q?94FIpzfCuKAhP0u2Lq8yF0FmTNXhaZcYq4/IRo3VtOWJzZPylT1hBQHmZnoh?=
 =?us-ascii?Q?AfOyqtc28M2I0GfHpj2sRmdePzCl5MzWRnYKvUmB7Yb1JoPrBxkiOSJDynsJ?=
 =?us-ascii?Q?wOf8qZBJ1rvRh5kBwOmt0fleANCr92Vh1xlbd0SAObNmNIBLneun1DYxcMAr?=
 =?us-ascii?Q?JpRfxo5GFVGVYykxCcEvE9+aGusQNbsTqqVhgXMNI5RgNzvw9AEKwNpdnzE3?=
 =?us-ascii?Q?ojU055YeiRzYkcLPpXiKSG3So9txOnMTvTUjBATKVPFci19LY/ibRdTTGhqV?=
 =?us-ascii?Q?ggRm9vchqWSiZ1eGXHxI7iKr3nZV9ThaK8YY575E6PFeoWP+0SYmIK0knjDe?=
 =?us-ascii?Q?rFsSBPV6Ay5O+1MuQp/FwyCllCUbqfQtTotIyQQWFhRivdHU0LJ4IPtyEdcE?=
 =?us-ascii?Q?E6QZnmKWLxzmOKj/TcvYZRq7o/WforV8Oz+XL4GMtQe+e1iTYZ9QGBj/Ky4v?=
 =?us-ascii?Q?lLyhxazOJ9N45VzqCB9/XsFt2LPPewHlzgpZbp5bpxZcaHoFL3iJa4cOR4mf?=
 =?us-ascii?Q?I6/9Lahwm5miEfxTPuAzwcjZAMNi2ZustB1zN9tKpnxDTszMeBtkHIBs1hn6?=
 =?us-ascii?Q?3iJqM1c8SMFTCQ+IFmB5T2QPhkHMESmnBM7Ew5Qer/3i5vU45sm5GausD2Au?=
 =?us-ascii?Q?PhW3+S2cCU1r6RK+/FseRaVAUBTiscSohvF4nAlaO/fNXuC16cyyE/sEyGrG?=
 =?us-ascii?Q?rk3w8Z5uWw+ZSJosDN0WJqTTrPu4nLfaHJbbRq9HEB3qa73DJYDDePiZBIJI?=
 =?us-ascii?Q?/odeWgRfgpH6k2id3PyTOp2Y+SLRjzAG9mEvo3lKkz8io1u8v8shxsjWKqKi?=
 =?us-ascii?Q?5UUH7FVuDGaDSdfcyGRDsWrSBC9RKzkGsrUAGHQFgwbvUOGNdWleHyGHuIDM?=
 =?us-ascii?Q?lXvCiVCCgvERBUjp6RSA5TuR8jkaHArMMBolcB0UDJD9kw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RpuNgTHhX1QJESZpMsMntUviX2VBgg0HyXQV0s5G6pRVhu4brGK7HY3byFJQ?=
 =?us-ascii?Q?B8seXCzsy7mYnOh8lJ9+3bE0bUb/QriYrKvnZDT23uGuXOEhEG8684GWSBWK?=
 =?us-ascii?Q?lauZu4BUz4qoIVgbt8cSNRwZ3FXxk/nG9oUPasVnsW6ut8X6tMW+92tehbIB?=
 =?us-ascii?Q?7EOFcjDWE4ByWJQjWAiD8YKcrW+6V0DSG67Iu65+xP90glMLW+IMSLV6ojhn?=
 =?us-ascii?Q?W1VCpkyQ0pquNvq56vy0qjngraoFauenX81OZfHUMOf46g2N6qkyLgK6yR/x?=
 =?us-ascii?Q?RLlOgGe1aUL+S/byAmf9e/p7NzTgctfdx9FidKw9g8rKyPZne2ccW9qtXoa7?=
 =?us-ascii?Q?O9sK/uK53ywm36TSMR52QjaWtlEzml9GKWManMtOON9FRXvF3v8G6XpGJHZU?=
 =?us-ascii?Q?PgTyX1kd26O1vN8sFPs3pOPe46NxuesaqYjLQjWU1F19pzC+Kkq5eirwlCe6?=
 =?us-ascii?Q?6ayAC7nuksTiTATwmdwmUfMx1GQ+UbU68xAgGtACyWQQ8LoIazePR1hE1BW4?=
 =?us-ascii?Q?Po7sakElNnojdNe/ch+SbOPMF0M/2itPesUWuc4gQY4wM7wdHpZy3zrZ0tuU?=
 =?us-ascii?Q?wsjAYcJNoEv7WJoWjT2vpNPcEaFtksv85pZNCOqDlu6SafGD2cnPtQVrQ3WH?=
 =?us-ascii?Q?efQCymMTwAlgsed960DNjpaKRs7TWtEGv3CJCm1ArlShniPvnBk0xFHe1bVM?=
 =?us-ascii?Q?4E4iqqatwa6vJV/6sVfWxfMwTgj0eQLexj5ZZCqucBuNLdK8iLQKXv0GdyNM?=
 =?us-ascii?Q?JPTcjb+K1l49Uqdb3p/TuKKZz4K48XKNJvaxRp5GOpLRytCOeWYibz4uRtyc?=
 =?us-ascii?Q?834Q1bFi3yVKGGiztL1W5s44AO0kiIPwtanLNnjKewUb+Zqk/sGVGqB0QRpW?=
 =?us-ascii?Q?1TFN9XY8oUbRY/Yn1jBuBj4gr1asSsPbEshsLcQlZgDjCPoOceeDFjhxrS+N?=
 =?us-ascii?Q?24di1KUowjxYyNKpg6+GaAI3ybUtDVGOM4uHFC7+LxltIEUPL2DluEqCTAD+?=
 =?us-ascii?Q?++/wR1/AZ2cIOiOmE09tvM9puwc9qHf0n+wU9WUoxTK85r4N2a8i0G6Uv/h0?=
 =?us-ascii?Q?HHBqnHpoD4Yir7R9pYPVUf/FKODOv2sLVMQtYP6Lj291QW5KUL6I9ZwO8vW3?=
 =?us-ascii?Q?eGmImnYOwwQb08G883y/po+2xso4hetu/rp3UhLPQiq2g+gNZPgHkc3hk++t?=
 =?us-ascii?Q?Y9meW5A9yR1jOUtkIlp45CH7a1Nim6DkA7apaGQ0JpevqbZTZxQ95TzT1Vjj?=
 =?us-ascii?Q?AyWVXNa7gRu67DRBZNbNFzwnFpFXRt0QToZ5M+vHE4EYX1Xi5WpaXkIZmh7j?=
 =?us-ascii?Q?uSAZ88u48aERHyrT8ftLYo2r258YuFIgwmAZ3ua4dQJ6tgaXHfn/i9Pd8eLs?=
 =?us-ascii?Q?j9qt2N01OXq8pVYhusZ19ssrqQEti/pYuXvr0d9bTNZXV1VtMYNg+Q7OySpY?=
 =?us-ascii?Q?ORJkoJePBd43nUZMzzJhOVwrqk30Ag7DQmexdSpvjbnmrAntPMHlM5yvxhND?=
 =?us-ascii?Q?tWsTd1pBg3edp56lqXxvAEz9p4+pekjhEvACPqBTvLYT46+qUhGt5OMyH5on?=
 =?us-ascii?Q?6lJL83Evq5R5RQ0QMpyg5p78t37N6sAv6WAWeGwh5LIghbzkGBiJRXyYj0fW?=
 =?us-ascii?Q?lA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7d4d8a-15f5-4fbb-16ca-08dce3f250d9
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 21:28:25.8503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+8Im5RQt2FYCMT7IxFUa32yq9tYBN8UqMay/aiJCq69efhpJP4ZQNeAnqk0NIKPNMRPfH425hZW/d8cvD98i++w9QBIcfwEx3bCw5i8d3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6063
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

This TU currently relies on getting a declaration of schedule()
through some nested include. Include the proper header directly.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 boot/cedit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/boot/cedit.c b/boot/cedit.c
index c29a2be14ce..ff0efda3a7b 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -20,6 +20,7 @@
 #include <video.h>
 #include <linux/delay.h>
 #include "scene_internal.h"
+#include <u-boot/schedule.h>
 
 enum {
 	CMOS_MAX_BITS	= 2048,
-- 
2.46.2

