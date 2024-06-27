Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B84C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 11:39:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32322885EE;
	Thu, 27 Jun 2024 13:39:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="D12jjIYr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7B768857C; Thu, 27 Jun 2024 13:39:52 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6BB188582
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 13:39:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAloN97VfWjOthgc4oqVj+D1c3Oi1AKy6lS+3GVIWy9X4CYrrq4GmuT2kU40tYB/EByGXGi0J5R4zjte7YgWWbzYYri7e7VhR8fGjrhSsHJI8lue1ga1vmyga8CT8qdzuFvXHacn8D03zkA5gqoGYgdUXeW3pWz8IuNuevT4H/RzJoy4VW9JMICt45C0am1GPsvamjkvNR/IMLU9Fk6x8Lggnv3FXJmpzujtXXrWls4Jy7toG+IMQMpWGWrrX7MvsVCK6Yu7/7o+LBjdU2QmaxkDAdvXrEIbDyHsn8txITylzfEuyNpW/xoA/3RAQ2w2FT9QLch0xMF8zKJYDv3s9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mvub5FzaK6sCE2FEv6mUojRJwjkXtjo7lcQg4TvpKgc=;
 b=P8cbwX5T3L8dWVg+NVw9akeRQEB9catAYUnOJnEcT5aLqj5IE2cy+1S7A32pj1fvR6nkom3XCSfUl5pYgoojUlA6+qJImn3PAzYO60FBXShnsR89FSZ/mIQlhYi+yi7mi3i8RFVUsXRM2c6miI9XVFDfinNMJkHlQCvjcLjQtH9OddfrAtY18inImCnFZXWRa2LcFxSgY8BUEI+D1oGVSnj9MIPTDI2QImrodmJS8eWwb21uylAVQGe61xrCcdV83c8EIztpCDUvXKjJ5RswuctPOJyJxcTe/p/dr2OcwMc15psTk3X/Ew2wy09LBhNV+2pON3wpWZ3Xr7q/abjHQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mvub5FzaK6sCE2FEv6mUojRJwjkXtjo7lcQg4TvpKgc=;
 b=D12jjIYrOz4t0kgZBq1sj2MAjmbZfSuihoPKeYnL/IIOg+mFvSmpR8nqjM+6VsG+7jRgqr5mTBVP7aUP/18wZLUTLZbadE66RQEr8r9GLpMwwa2m/ZGOS3plzaL/Gq6q0vZ5CLAVUb8xHhNZFOb7rccakIWCg4Vpjp24JI1PZL+/YhLaWtHVyIJ1Na5zf+bIahm8JqmF/xOHFT+taBYpG8hKvd/6J5kPJTn38dqxftch64IGwEf+PxWMiC3zeCs8SpQMi6NRXcGn5sGixGAEXQG1TWxNNtKakgFOXZd2hErgZ44kRASmY/U0yPk//yhubYJfm5qis+jcvNprL0zfmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB10427.eurprd08.prod.outlook.com (2603:10a6:800:1b8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 11:39:47 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 11:39:47 +0000
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
Subject: [PATCH 01/12] net/tcp: fix TCP options processing
Date: Thu, 27 Jun 2024 14:39:28 +0300
Message-ID: <20240627113939.100620-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002BB3.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:21) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI0PR08MB10427:EE_
X-MS-Office365-Filtering-Correlation-Id: ad539576-9a69-4d8f-5aa7-08dc969dd8c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|1800799024|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AIRkWYvUCoEDdEcZ2OLA27ZllYRqsm+ZMVN+vTB5qZgmmsXOVnGdS75xMBYd?=
 =?us-ascii?Q?tbsfl8iDaMoEAOaLrKehvLjep0LswSsfFg6F2oB+C6vL7QHrYlU2J3eDarJH?=
 =?us-ascii?Q?NAe+e93oTZoPxA5bGVE2pUf5jis5LDj/be73RtI2PhVCzyZ/lstQYZlnldiT?=
 =?us-ascii?Q?x6N10bT2eiWX3NIFYmt5ej2r6RUgfN8xiIkKt1yYh7pMGgkKEegcbgosAkbc?=
 =?us-ascii?Q?n4iIe2qHpS9xNF87ORuA3yH3KS6+FY8CHtUY8sejQFZylrs2zgIxGdPqlkz6?=
 =?us-ascii?Q?x78yU4qoA7eVPxY61MZKrUjZKGTIECZ+nF/hF2/i0RWy0ysvLQaDy0C03xn0?=
 =?us-ascii?Q?cJ0tC+wFVc5jZILP4tmY5OOEmL4KuYDIF37x5cPFVwi+kk2UwTrmiNObHI5Y?=
 =?us-ascii?Q?2ojqeZSqh9jY4G+HXpIkpLI9ltQNxDmpbi25rSRIi4zDRO5s6cjm07ueWent?=
 =?us-ascii?Q?aYryuZ6sdz3iXmeFY4RRTrpbxcfis47uO2IA21BfZ/9l0zBq6ANF4xLU/pF6?=
 =?us-ascii?Q?PUIuH9ZX6BuqVKSZWrBog4vX4PMIQqeob6p3dxvb5xN7isTLe7wqwSgMcVnH?=
 =?us-ascii?Q?aw+t2Cz0P/sSCZHjzU35MRsy43FlwAJ5FIQoAwZQG12BLexr3xrsKVlFBGfP?=
 =?us-ascii?Q?ik9yNFaFS0BTC2V9EvO5FBsgOR4mM/A0f/dYAEcyP5CmoFwbo/dKDd1mfy/P?=
 =?us-ascii?Q?6ulGUArddYSlv2ZQ7Vn2x4DHSerCwUbK4YYFLk0qcxUb7dHujSD4OlcK0Hsu?=
 =?us-ascii?Q?kmFh3oR/O5sJJloWDnK4cF3zjFwU4URIqywirx3GdQDmyHGdb5RpxOvv2sdP?=
 =?us-ascii?Q?JMbAhgfkw2zefBGRHS8ZQdFGoulMaGDv2PgO1shiOss83UzRjJlK3M1XAwF+?=
 =?us-ascii?Q?O8FLs4Sq96niWALm+QG1You7mKk6fFss/mHIxT7ACOIOEjqfz6XOFJlAuOOA?=
 =?us-ascii?Q?y63cEJbQ6OZcuxBOVrFKDFwE4QufcmGdhEXnNPF8IIqb2M5V35rpx9NjIk7j?=
 =?us-ascii?Q?e4Hjuiyv1U1I2W3fq+KncIQ29ktAn3wDeZWSQgfb0UHI9+9kKbqFA624jyRN?=
 =?us-ascii?Q?JR6HHyD4Ka9tVeFbK+wJ2AP1jkxvj6+8bKhMdWt0VOHj8LGO1CLJiRYRovQZ?=
 =?us-ascii?Q?gGgygYYD4k+9SkQZbolX/jqAZJg1D9fFWgWftiLvYg0+Em7nt7Bzl0Lnipj9?=
 =?us-ascii?Q?5LFg6ODR+BTJOeuRrTjhPwkMwKJTXZw647pEQt8Uw6uZD3lhT5XcGgLFQQ0c?=
 =?us-ascii?Q?IartNXrMfZHDggfQkHf7lyvN1NeEQdOT5mZ6wKee4s9OrM9+LUPc2MTXsIup?=
 =?us-ascii?Q?tXFk/5MgbhELcpV1Zdb7pKp831pq7rVKbBX4QDuNrsZckMVOmPAZnsghIvDg?=
 =?us-ascii?Q?GtqGWXXVufFBqwB6pqzB/O3KTNIu0Ej7J3Zv1GEl53vu6nGuEcs4MjGq+vPg?=
 =?us-ascii?Q?d5Chr+U6W5Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TRTjFhHaeLPA/iCpufWTWEU69vldl3Q1YyeNozYmjRw9H+auorw/zYHb+lWp?=
 =?us-ascii?Q?zHPQRj8a02KEamGmfhpHiVuURm7/2lSZXF/1HzTOVeepgMIiYIlM6JrECANl?=
 =?us-ascii?Q?u8Q/YfWSecdRheu2WyZ3udF8nheo0N3DJ60MGgTyaedj0hj3gSZXOgXaOMdR?=
 =?us-ascii?Q?z4iRjEowJ13ZnLDaeXhjBg1vzfat3HxAswb3UgTvOvNi9dG1npfjp4cQfcPe?=
 =?us-ascii?Q?P7shZdEtGR/Rv1TvnI+mxdH6XxLp7PKqEYEBIgH/S/EQIJ9D0L4TiRQUgJNY?=
 =?us-ascii?Q?RQm9hYqMe/XKMlWkcVrfcpTrtUYdIMdSa/RspV0ue2obbijGWPQMZmsxrgXy?=
 =?us-ascii?Q?K14tJkLqOVtinMzpB+l/HoJA5h5EjYgX0YyXnkSdv7VZDxGRgohLWvraMg3k?=
 =?us-ascii?Q?1s0oyRAU7UjJTZ92iTPYm/6/kKiP09nlINi9IqzZhIFXR0cV1UGV9d9V93U1?=
 =?us-ascii?Q?vk9AcMfAbYAMqJ7PHIgAfkB5EPljyQo1egx3QxUK9jmjl3jVS+V/LzpH7El8?=
 =?us-ascii?Q?5E6Ht02fVcEUbTDCULnzv2YPzOEUz72tq356v7gVPWi/EpCP5vo36SCx09+O?=
 =?us-ascii?Q?S/sziAPG//5WMdcEDA3dbnvAvY+Hk5Y6BbSRBkrs3kXaWzlKI78YAlSjYivi?=
 =?us-ascii?Q?V/jso+QPWYDiM9uFH0UJ5hliAdHvN6GRCj+gtkwcocFRDoUaGkRPlnugTcJm?=
 =?us-ascii?Q?NEuWMlZqZePzHEvVKqRUEynDqUOW104X0+zpyrgZ3ZxVRIlNHZfEuQ3FvvrB?=
 =?us-ascii?Q?eEZFPQEtlXgMY+EhG2PCm8SlR6Nqi37PK6zeI4jqZ/GR6cmmd7BXMaW1KBKa?=
 =?us-ascii?Q?nc35f1X/VjPywmWt09qVp+0v/gUc+9zCbHHQWsLpAUnIdbYheS+csok7jKEZ?=
 =?us-ascii?Q?fHSND5GoF3nbmzNd3ATY33vo4e+Aw1uQL5xCHfotkVFNVMg+bEKTFuOKQNqf?=
 =?us-ascii?Q?bAALplfrg8D9jnQEhXK1B/DJPi1SJC4uEEj+TwzWV9btAmH1FQ7q2/RjNtxd?=
 =?us-ascii?Q?QHUMgrryVvTD94Ww33hoH2NSPSddpwzTfs6wJbnikNQ3keVB12lGTuWYU3AW?=
 =?us-ascii?Q?kcklD88WQ0S/ENy5JEk5nhaukAn0E4ZtpUgEY//E+iDM6oHU4vuNbgHrjTSz?=
 =?us-ascii?Q?3Vl44OXrwG+29Ayyq2mqiTZhZfpaBDctJZEDZhaHQt+B8U2gMV9fbCDpEJQe?=
 =?us-ascii?Q?1fO+WGzlj/XXn8X/KDDJBP59+EEZw02WFzF+6LXlI5UCcdtLoWhQ8Llzup9Q?=
 =?us-ascii?Q?n6KG6kh3Pd8/izvMoxvLw2vahTRu6I6Fk73HnSK9LDBVjjYidT6jTGUvXRxd?=
 =?us-ascii?Q?Y8O1u0XOmYxtPCiQm1ojmXb4tDVQIBVDwWf7HnAWmZGRmCoxkhzySFSuVwok?=
 =?us-ascii?Q?0itleuzGznNyFT408cII58KO2nQlcb68fbEavz72BVbN3NJuZJGfDOjxOdOP?=
 =?us-ascii?Q?+oOFGAsuzDopSv+bW1ISPe+D0DUH9ej/GVt/8mW6FGOQjBkhkS5nUY/4PkXx?=
 =?us-ascii?Q?vzGD1j4DSJ7sx4KssstNqEDVGuqebvVeek4thqAEQI29rXK8sQT3zGyuijQz?=
 =?us-ascii?Q?sjwcM+s5nHPw4JZwecI9DAo4lmGksfGYrbGDEhlVJIpXsrR+CuZMJCaw3uz2?=
 =?us-ascii?Q?Nl7ll6jEo9TmRjNJR46qyOQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ad539576-9a69-4d8f-5aa7-08dc969dd8c2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 11:39:47.1965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ya4T6NdQFTcUJA5A/2POu+SktTrj5MOM64gKfjhNpVCTl9H9Hm9UaXG/o3dF9Qt0SZGfp2UVUHFUe24nC7usEU8FndQfWkOs8FTb9KoYWI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10427
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
---
 net/tcp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/tcp.c b/net/tcp.c
index a713e1dd609..c9bcd364ee3 100644
--- a/net/tcp.c
+++ b/net/tcp.c
@@ -476,7 +476,7 @@ void tcp_parse_options(uchar *o, int o_len)
 	 * NOPs are options with a zero length, and thus are special.
 	 * All other options have length fields.
 	 */
-	for (p = o; p < (o + o_len); p = p + p[1]) {
+	for (p = o; p < (o + o_len); ) {
 		if (!p[1])
 			return; /* Finished processing options */
 
@@ -491,12 +491,14 @@ void tcp_parse_options(uchar *o, int o_len)
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
2.43.0

