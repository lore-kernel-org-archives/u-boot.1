Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AB3C3064D
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:42:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 325A2885E7;
	Thu, 27 Jun 2024 13:40:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="qrWFgZZD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39D7D88630; Thu, 27 Jun 2024 13:40:10 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63773885DB
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 13:40:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3logg0qFr/cw8B8zfdWkQzNkaYp/pULcnrMhDJr4664aGrQ2DxRZ2hSLR+iArYwGty0PdMZAjYJ/OFMXivgRA4SMbNz4QRYVsiAw9LoB4gX+iABZoCFSKK9rijCNn4vDXwM6KyUTDNtVS5aHqb1d2jSUwY++yJptRdRD9j3qxFTOMugTX2Omt3q32iu0ig4fJ3hR4Oa/Drz1qKdlGBLlMzNU50Iuk0Y64WYLyUUtfr3ZlnoTiT3W7fzaTlffk+19N3JPomPpw8XB46pYWgqpklPB2DPeHF2dYHa6zz7lsAITcwHxJ3juOVIlsTJx3He5e8mAOS2PR5T+DO2TYGnTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySPOAhJHz0aPTCFI/sh45VZg7bEPrMP+QbrmglTv/ck=;
 b=C0dfYyHEodZQuuVdxDanisMX/UFQT9wR9iSSVTUBPOgWKygTVOQaMg/V4mIctnrTUmC1DZutqDNuVoM3gcwGusAYA5WYKac2K+4Cn+DekH5kvYQ1hrKkSthz3Nu7LU6P/nG3WRmGOekHpAcxKB0HzvwsK/qDiebSTVmXpDxHB0IplIHP6xv/Eo63A0lR+mpMCCRElZmOL4eqRWALbR7s9eu83vybSgQFU64Y4Cd1l9BK2/sDlC4VoAIBxvsrY/whtxkOX7xqQhzrqZAgP/lXkdYZ3/Ox6eT9lVVQ6jTieRs9lQ0zjkaDrPrFdVkyn04GkP0hm0Y5ddakBy97T9TWGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySPOAhJHz0aPTCFI/sh45VZg7bEPrMP+QbrmglTv/ck=;
 b=qrWFgZZDYd2OjMgsd5gQwlt/03gfphCmuYdpq/OfVFeaNz3orGYFFXOL1v3S8aXwfgwx3emwlY8cHcKWZjLZDA/sjpq8DYoZea7F2Hk5F4XJ+DGm/y4QGLGTZIAYNvf40XnKyEpte7qRoDKjm1cx2whDF53byh7UbimyalJJyOlWpWmZneecNmAlRZNzPWXc/3yE0Ysc4iN1gYnx5DLZbQEC6gbJ6XjKlRNsRlBdFX7ZPZllbY+XuiuuFjEi0Q6BLxorKRst5RpKfcNI+dgctZlfeasUu69ulRvo9CMJ6JKDorCFrINleKZBcV03Nmneis1caGsX06YImPCkYTS5Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB8640.eurprd08.prod.outlook.com (2603:10a6:10:400::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 11:40:05 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 11:40:05 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Marek Vasut <marex@denx.de>,
 Baruch Siach <baruch@tkos.co.il>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Richard Weinberger <richard@nod.at>, u-boot@lists.denx.de
Subject: [PATCH 12/12] net/tcp: define a fallback value for rcv_wnd size
Date: Thu, 27 Jun 2024 14:39:39 +0300
Message-ID: <20240627113939.100620-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627113939.100620-1-mikhail.kshevetskiy@iopsys.eu>
References: <20240627113939.100620-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002BB3.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:21) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB8640:EE_
X-MS-Office365-Filtering-Correlation-Id: b634e509-6e60-4844-3296-08dc969de366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|7416014|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6ShilAwCaQFkq/czfETtbm99YTBg/E7erfWe544mwODzazykuJ6k5I5dNQKJ?=
 =?us-ascii?Q?1TVuBOLro/qBGXYMUFDtfxaVFYGyPKw68fgVhz0SukAoJUMJ5QnrHrUGdCky?=
 =?us-ascii?Q?a7d8EUuPqCPKAzQrHybTwS4JU2tblHesp07y17579SlVuuvI8HwN3wx+OUCT?=
 =?us-ascii?Q?VTfwT0j8hE7ySi6NJ8FdiO5hQ2ZWI2a+CW4oS6FbFHG7CnQyXfRltqHVDrDr?=
 =?us-ascii?Q?5wVKdNLxyXh6fHIuzHK/0xCx5eR5NjXjTPv1sT9wAdXhCM5K+7cSWZji7Ldw?=
 =?us-ascii?Q?lotBRiTfok89lCwwYrINp6Ae4LPRTi51mQ7Tue4CwAQ77g/PehOZoYRToECn?=
 =?us-ascii?Q?X8kl2Ww7iOtsm/W4WJh3S7+ib+TLXpal4Hjjis3cmCuoGf8o5y4Ug2L7wWTT?=
 =?us-ascii?Q?agqWQfnhTHobDaM7FiK0g7ouBvhz9aOhR+VC8+3iEgRhX5cnVD0bk4xxYTNC?=
 =?us-ascii?Q?/B7Y63ACXzC7g60pVdwcsQE3BdaPGvWmSvXW/lY8TRsjDbs/Gfi5AcwXoZtI?=
 =?us-ascii?Q?rYlLe67kmAN8BwKWTlyRw2yUZyTs6M9TZBy/S29q5qw08VZYqU+g6omNUxvD?=
 =?us-ascii?Q?Re4vni9bhRZ3mC4aAYf/ngwZuZed6sIOselLhc2q6IrQ8M1qgFxw71RQHTnn?=
 =?us-ascii?Q?U50uBjllrRIgJDvofX9ev7RbzgByfIOkwhuMx24YlV/UbFi14c8u1HgVREa0?=
 =?us-ascii?Q?Hurntvf/FOX8RIjTmTyT+sfbR18fjRe0lHjRMGKogAuN22u3HMpKLSmZF5CU?=
 =?us-ascii?Q?5GdJqUKjcXXe7+AT9lvQn2fVWyBFfKq3qI4/4Fpy1QWu3lXEIOgV822+Hnmu?=
 =?us-ascii?Q?1PXDmsj8kXIM2AK1pWCqe7mA01w6ZzgGpRovP3p3ysCZR/2dXclf/cDWHnpd?=
 =?us-ascii?Q?w/UtTqBDxHewnF6pVTPXfxOsHIHekUS0M1rPZPZru+eIWkE62G25EvJ1cKB1?=
 =?us-ascii?Q?5J+nlx/pxstFKXKVI0cYA7AezKJPP3jL/DtMKn3Mm8DMKA8szmrumJ/CEL4+?=
 =?us-ascii?Q?u4Mo8BI22grhSmWogEKIk4WcOQeuSzhS2MkM2M9dtNLkSsSeFQJiK5LJAuAm?=
 =?us-ascii?Q?66jZXgG5fuK5CIzqWyrf8v67F8Aicj0mm0qtvAe7Ro5Vk78bfbxmHorsmhZ9?=
 =?us-ascii?Q?lE0SfWEDwIzaB2av8XVAidYjXIrwHnOAax0YLF6vfba0FjefhQpoH2h05Psm?=
 =?us-ascii?Q?U9OG/X+KrGNVrmfbbyoFWsstBucShFmlKDpsujJDIEqCPm6mxG0W7t0/rO7D?=
 =?us-ascii?Q?usGAJDDUEzR1KBKMtHBt3KNBaBTJHWnyu8Zedrk5hDdus8PLv7bIMeMlk6v3?=
 =?us-ascii?Q?9pOyDU4irCOklLavAXQ5FEIw68HwFBW2S1HyMVfeROJX10SYqDcj2vGY7JEW?=
 =?us-ascii?Q?Zz9fImfl8mwA8cs2bXq3Nbq/5ssaLknNi3u82o5O268QbChAUcMhgiOU0KFR?=
 =?us-ascii?Q?NOMsrGVFR6M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aB5hg9V5gYoQjI9ijWj0JuTu1B6PHDWPxAlU4KArq/6vUy/CJMh3B/2HKGPn?=
 =?us-ascii?Q?MIcoKztJat+IaLDMXj1W9CWxsM/ohlUhG+GZzCx1wyJQnTRrA/czHpmqgh89?=
 =?us-ascii?Q?voJqG7kzOQ9qjbGQY3srZ7VfIqJJhjP2nZQ018dlBnHhjnR3l+Tseb1vgUJL?=
 =?us-ascii?Q?QFN5H+JGEeH0Lm4ogtxQlrwhYEHgk16ddhmymzuYbhLmCzlMVqU45jbKjoUX?=
 =?us-ascii?Q?9D80ElniyVDp0AOfCJcEkrOS0t7Dd8LCojSVLQAAtzGRQ78dU2nwzyA/5+Oi?=
 =?us-ascii?Q?seuYQ/iFXe+CqCPWBYYx9KdpKrYYdpQclmZBl38EpBAzBSyOJTZ3B+zhhHAR?=
 =?us-ascii?Q?5OCFFFrk6DbHDVYOm4R1wQm7VW4M+k7loJu/8UgeamUrvmN0snr4k2G0UWWa?=
 =?us-ascii?Q?2Mi2Y4efpeY1/z+0PkGm7CU/HdHkvaQqcIdgJxA8CWsX0+xACv8HvmbDOj1L?=
 =?us-ascii?Q?yjzhhvDzOfg/Af3V0WptyScVwRKQcxBYuFYrjs9Qn5oDIiwwbxhb54dlz9wE?=
 =?us-ascii?Q?77nBVqvuGjmbEKoTAhB0UEXVvvhLFr5ei2HrQlDEHMV1fNkhw+dxbxvphOG5?=
 =?us-ascii?Q?rYQBDyYAH+9TZDJs+DVc/0JBHb1u/hMbxJL900jwv2+zFcINNgqAXo6v6cG+?=
 =?us-ascii?Q?C9ys5ndSxY6GbTzbpunyBQ0MR7XX0OhYPNw67jdgJobgkaVETlobCHUuu4V7?=
 =?us-ascii?Q?WS1Fci5AUkgpFb/y1iB+erhDXOEenLQPfz6vVwnYm6dGaBk2t7c68hshaqMF?=
 =?us-ascii?Q?iMg0aqOhPO6S4j01kwIx2Y0/GVAKeRkFR8Kk0oPDF4N0dVId4M1lsMa/mr4E?=
 =?us-ascii?Q?HzJbUc87hihc2unq/21HrLvyWE7p5q5XqQ8UGzfEM/tJ2ZfQK7AwtDOt8Bhi?=
 =?us-ascii?Q?8X+5Fc+hzRdtS5SLyQpWrTIGKrV6e0RpM3Oa7bZrVtmYk5EkfURXA6500HV9?=
 =?us-ascii?Q?TKSq/Yv+fnvJlj1VLeMms49VHDTzCQ/2k4Z3tVk88DpvUeooH9BuU03ig1Gz?=
 =?us-ascii?Q?VuasGY+bNVmhO9sJ6OvxOVNl5XhT8Pqs2PnI5ZVfX/8zSTz1xfp7E6L+gl6J?=
 =?us-ascii?Q?+inkxGPscYpcFpmBd8DmWFPg8tqEWbuP/E8ioAmX2XAYfamuub+XhbytDfTr?=
 =?us-ascii?Q?1hHoYYTKq0+n/7BJAGH5/Vwqe4iAZGO9q6Lwe6VqOPlz4lXHcpwbJkaTti9P?=
 =?us-ascii?Q?N52OYbGsEGsNO0YbAF7K7iBkfUAQ77h2RkgQMxg74J4FRCaliuCMYtpFVUTE?=
 =?us-ascii?Q?UwFJESWa9o29w0cCm6YdmkbWvEdcZ1bMJWnjSppuvWQa75lyOmuXbCt7b5aM?=
 =?us-ascii?Q?9a0yodAeaw31aE/7l+jFhrMt/mWwXpx7y/ziMqok38M823IAiMrDSmNi180Z?=
 =?us-ascii?Q?QmK3xeoCW3aTHd2U23xVdBFkc1THN2/Ttjtm61Hma5L8PunDdHqyMRCWdaet?=
 =?us-ascii?Q?avKfQZbJqXL6yTnXQ6P3UArUH8NwDPqE30qRMVlIzXq4yUf0sCFqt5DXYXSa?=
 =?us-ascii?Q?ag4WUUe3vGRA79xFeoBOEahplmarBpwe7F/R62sZ3wTuvMYgKqADaUO34PIo?=
 =?us-ascii?Q?WsEnkTxnH/97bn17XQVO8mZDpITppT2y+8HxoJvwkaQh8C0wYQRx3FkcWtQ5?=
 =?us-ascii?Q?zoK8/QGHBZnaHjCD2/EtIrc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b634e509-6e60-4844-3296-08dc969de366
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 11:40:05.1704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzzj2VxEmybrODtySXzM5iq0DAymythSfwzd4INb1/NBa2wMStmBCINQnMI+DEIOvduQTBIBrOEenFsRBuxlDU0e0gVBITVH+LPt17ZNJhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8640
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

Some driver implements it's own network packet pool, so PKTBUFSRX is zero.
This results in zero-size TCP receive window, so data transfer doesn't
work. Avod it by setting a reasonable fallback value.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 net/tcp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/tcp.c b/net/tcp.c
index c0045e32198..3f12c71e1f7 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -30,7 +30,11 @@
 #define TCP_SEND_TIMEOUT	2000UL
 #define TCP_RX_INACTIVE_TIMEOUT	30000UL
 #define TCP_START_SEQ_INC	2153	/* just large prime number */
-#define TCP_RCV_WND_SIZE	(PKTBUFSRX * TCP_MSS)
+#if PKTBUFSRX != 0
+  #define TCP_RCV_WND_SIZE	(PKTBUFSRX * TCP_MSS)
+#else
+  #define TCP_RCV_WND_SIZE	(4 * TCP_MSS)
+#endif
 
 #define TCP_PACKET_OK		0
 #define TCP_PACKET_DROP		1
-- 
2.43.0

