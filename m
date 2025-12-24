Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF057E75423
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 08:27:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9AEC8426C;
	Wed, 24 Dec 2025 09:25:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Cc3oF8ho";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47957841D2; Wed, 24 Dec 2025 09:25:11 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5268984258
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 09:25:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xmUEQhdYXVdfP8yQiedp92nW6vscVAWDPb1PFb93zeJ5KvzLTe3JlcAZ9zhT/mMSUVg9WjNFk8jaL5l8NqYTJa3Ho6NZeqG+O0HnhjZoRK73IOexixRKTgXvVjRVaBFD/J4COabNDk12lbAyTfdrDRAcYpVL39Ad85bS4BxQ70aCNl+MjEA9AmBGTlbvUESmpZdBpcQc5BLJHKjUHGXZdaKWEFKG9g0bjg6+FbdiKShJ3/sL44/7z2Rlkkoxz/XUGJEVMZKp6RMYrjZLzZ3lRovXNnN88V/WI1NrmMhfAXYC2yG77NVDHQRqzqjBvippfCH6tggwoAjcXOwI0qWVxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSpsCxdMKIJ1IQsJncxTLv67hANK4apnzzW0gFSOou4=;
 b=t9O0ZHvctCksrBTBzCdppGG7YZWYZTU3FzLyJUFbe4yIxqv9l5nsjQRObX2Q/9j5KGaYn16xYOBdQUuOpOv6asG7qQU82EpYkK3T5XIQVKHrTxD+aNpgEQlBakcuPGvfimvysm41eRXxhCAIm8PSBmmC3XgsnHhttTdA9fl0mb8PzCU1glHhZ0oG7eJyyxTLgkMirA6zKz1YC0iDMhUtFRse/KXDgvL/+mGUlBTFFFMN8FbKuQx4sZu1g3qTI3yQKHBJEzApaEwNvT3N77oITG6+AALrvvOxCHLZ77qpiluz4CL1ey1EoMHjwvfuLozQvvoBJDwTnaxdYRDG/yNPyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSpsCxdMKIJ1IQsJncxTLv67hANK4apnzzW0gFSOou4=;
 b=Cc3oF8hoMUgQ0sV7vPHBwPLOapK5noDOEdPiwG4JICXoVGXvb72XrYc5K7OrpXVFuV8C537QglbuoTdvdppcGcuQopkUSFb5TW96DBPcZ1XyQm8U7H7ekRTO+sBDTRGF2sj+2tXy9mri/CylhASvntmAdy9qoFE+aLFNTccxOVEKawWVtI5t6+qg2rcNedqL+/1F9ujBzhj1LTdVr8Aqd+Zcn0vN6J1sSBk5I1GpzIZ2M6kl/QgmxXlPMqqYc9pyzT+jvzzQLZ9TjVLt+g10v9+sEgNfmOWZKMdoGDsAnasAvipXXHA9Ngj9qwkbogwJnOx5f6LxsFSr/Hp6Yn3WHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB6562.eurprd08.prod.outlook.com (2603:10a6:20b:355::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 08:25:07 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 08:25:07 +0000
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
Subject: [PATCH RESEND 16/19] net: airoha: bind MDIO controller on Ethernet
 load
Date: Wed, 24 Dec 2025 11:24:06 +0300
Message-ID: <20251224082409.1347373-17-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: 239ae707-1772-424c-a545-08de42c5f26a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N3XCfJMCgbAQNuEG8KY4vPowpbvxi9hP/067xR4kGB9NiDXSpxK1Cz4S8sXw?=
 =?us-ascii?Q?y0he5+2u2Cfn5BLKj4xyi77RUUl2d0Wsi+KNxSIgIOx+acC1fWlgGZUjdhbj?=
 =?us-ascii?Q?z6R3i6X94h6t+SD1IjBV65YGFo/vh15iDlEUZ/T/D85bnbrAw56GlLwoIjzW?=
 =?us-ascii?Q?CTzBh/gSx1TVW0zoKlgxKsEvQef+BNFdspkjQr28lWYmHXWUYOQ4lJKgODTz?=
 =?us-ascii?Q?C6EdLrQCaGS+Zuu2jhANNOsf/AfXE6vDJRVk0Y/pVNQ0gn9M1LliF8jy0t7x?=
 =?us-ascii?Q?IHDoB3TKzNkvkemLOKsxUldLjFP+Ig7e0Orzif6n8GKxWUOjMERLDsLlj30N?=
 =?us-ascii?Q?K6Zo5Eh/Ci+r5xTyhTUH+C2P12vifwpy6nkV7NZ5CQECAhz8DPSoRDvc2ssK?=
 =?us-ascii?Q?u1Nxf2/iq0jg41+Gb3FDs1Q+IQV/s+XIwz0SFP0hSrGLhIuccgh7eMYyRhYE?=
 =?us-ascii?Q?BCtoJ3L+ifz/pxV7QPC2NfBv6hfusUr2c66Sv1SknfMquEJM7MLO9MZrxXPo?=
 =?us-ascii?Q?d6OosCZ8eKqgdHkZUgoKjeH6jkZdR5TVXgImHHFSDrVtQoKYaVeHaOe1/Snz?=
 =?us-ascii?Q?xF4th8SUPSDz7iNK3nfmQvyxhOyXSAyo8FlbxnejzqefQmt5U0PK9vzz/jsI?=
 =?us-ascii?Q?UhUXNBU+U6oDqp9oZShRfoAaTD7xjfogpQbRbFqUN1cX1CR4xGwBvMYWQ969?=
 =?us-ascii?Q?5p4gGXovaYvtmxSPlSxns1ZYJ4NQA3r263gEHisV3X2kyAUSlBDN9w88pMYl?=
 =?us-ascii?Q?rROmiOP25CDWytAQWtXm1aMQwUNuOffM3AYGxLfgoJ2hoFqhSnpWsHtO839k?=
 =?us-ascii?Q?WomrJt68lS3rZg5vJ7/RuikDMbWxjUY5QhCH4sn8XkvTnhwtnwY4A0q9h6bc?=
 =?us-ascii?Q?G954gaXTi/WUjHubB/cj8nGtOs05myimU74Fe+sKV1/sIP+xO5OhJTyIH6hn?=
 =?us-ascii?Q?vreR368hOIRDK5IsoJIDG6WkJ9QhrVFftOS4LMTLKAL6BcUVD/yLU0n5KSN+?=
 =?us-ascii?Q?So2i4LBLl8MBLV+lqRHn2TOYy10ErQ0cofEO27LOv1JshFc9xggo+K6XDD38?=
 =?us-ascii?Q?4lL9q1eYvZUxDKZcu/EZT8HpvkPkBe9K6/B/0D2nMFORIt9xWArwWHtQ78S/?=
 =?us-ascii?Q?Ag/xBaeAC9hcg9Gk8ZI1HuuK7I84l5SFGxptX1HmctLOM9vk5caHXY4qDLtG?=
 =?us-ascii?Q?2Q2ocU3A9mtTRpAuP0u2xOQaUA3+swUCoMVnFeCglSJBFY72thmejqT3lFAn?=
 =?us-ascii?Q?wMcIzDJaaXGCcqBge24p85aD4eO8M1sNgIhZc1kmkO2FhA+tNrz3sBq//ZSQ?=
 =?us-ascii?Q?HRMuTqvHGnznBmnAocRnnDx3XDmRK8Thkc0Eh0ldbNlPKCu0NakLU35uK5jJ?=
 =?us-ascii?Q?HWGwvGphMislMZUCz6pIGnSiYptJ+Kng7+GREapKE0J+vBmvyhpTaYHV9lFj?=
 =?us-ascii?Q?9aagKzeDYwdvVnG8+crcI/zZBg7zcMPYyPuxlzpkXjjrTFHqTt2ZhnNOOrq3?=
 =?us-ascii?Q?aUlmbKQbJaLbiXfDon1smfd+FSq4pn44DR5gtgsU4CfFhO1F3KG4TVr73w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?faqG+biEDRwUmd7gMqr52LEt7NuBtFf52vdkWfMSg/rRO4rpNo5uPX1mwbTD?=
 =?us-ascii?Q?WYy6RrD4r0uJs9Dw5Eep8XBJYq8SBq7dnKxdk3As3l3XYim+9nNKNN4wKmXE?=
 =?us-ascii?Q?1TFHGi8JUp2UTAy7K0ooi+6QbWI/WpklXMlHAUfO43ok7ETaSo5/05WqnjnT?=
 =?us-ascii?Q?vdSRh3at4nt8/uoW5BvzqOkzbYyPNg5NiXHrbI3htUHgOc+E7ZVwseynfPTG?=
 =?us-ascii?Q?p02/sJRsLieEow3JYIJ9rnxiOCVKU47Z2Sllw8vi5islLw1CE9jx+1vgt+ov?=
 =?us-ascii?Q?JYeUyLCLyI/nr4iHhrRJ7oEjnhyu2PWTEnuYBuWbjQJGu23o94dJSX7ahE9i?=
 =?us-ascii?Q?a8yoOQ9kaWg0frmGwhNwv+rB/r7ZqOVSz5OnzVKGFPh6S9xVrmySxpUytOSu?=
 =?us-ascii?Q?UpzfLf6kC6+avw5oi/7LocHavgdEhRKX7sVMC+yAKYZ9wwo757KHbFTYYpeD?=
 =?us-ascii?Q?ej3cUGya/MCrL5IME1e4ld5rYcZq+4BwuAnG+FkijGHtEoE5CCyYsbZIufWp?=
 =?us-ascii?Q?fOoddlgBHkwVFyHdLbeCXOD/TrNplbYBHSdwobROzXbQzCUD3GP6mIVb0e8n?=
 =?us-ascii?Q?gcptytWx5rUn+/Zz2XvkOidVaJcyJlU8WPRSk1n8aZwrmDt+vWIAW1aDvkjG?=
 =?us-ascii?Q?MlFjeaY0gVBaQT2csxFo+NBIBMyHwAYazI1di3rW2S9VyhHGZ1bOPV52N2vw?=
 =?us-ascii?Q?bTgsP1qTr+4AhxhyJxrDcAhyRRkHk47D27zc9sCDBqnr8NLF+3a3hoaFPBt3?=
 =?us-ascii?Q?9rvxAHgWOPmlMzWxA2p28YHy0Au2TjpmERjuxL3T+qtKoaO9mBjM6opkEGcw?=
 =?us-ascii?Q?mcUeVd39WdSV9qD88UdfwA3YkoBWSak0Dxcj1W9mnJoBXRCXZQVbV4GHQLl0?=
 =?us-ascii?Q?48xtO4TToFzMXn2GGUt7h8e/XDNJTgrCjn2herjeTg05W/w7NWpQK5lgYnk5?=
 =?us-ascii?Q?H3Umq79k0YqV1Mhz0iZWEfdM8VPYMuULqnh+I3uviNqGv0Sw7CV9O6ITLgvS?=
 =?us-ascii?Q?G9hj/Bqn7XNc36zOif1ryy6y4awcnfaE8qLsKZ+/uvfqATCccOf+J804Smum?=
 =?us-ascii?Q?RXLzVIW8zL20QkA6w/FhgY7t3nC/0HXgDkgRmeaPc6cInxbeVvJWI6u/3eIO?=
 =?us-ascii?Q?1d4+0+bXAZWT7XSNu0hamsja3Alwi8H8/DapWhuGbyBRkan31npP323v8KAa?=
 =?us-ascii?Q?PzwL5NqbXCrtm8zUYgDkKG+k10aDKaS1FAg9fhmonyAixmBaKfF9KhzLBQtD?=
 =?us-ascii?Q?/3daj9sQcxcpkh9v9maLJ5XvmxhLCwW11pBj6eUOpDVcmJkzAz0VW56qO5nz?=
 =?us-ascii?Q?oPMbHlkQKa2mwbT1jQ9AuP9v2KEyhicWAIBXMdguZK4PCmGnfV6XX0yDtd4M?=
 =?us-ascii?Q?a8M0VMmm/v5GsXqkg30yXd87RAzQfJEFrKlVFd5VCvHNTneequnr8k3I6RE2?=
 =?us-ascii?Q?RVAY/trgHGG7aTEQfWbFEQp6AxcA6xkaVgjJ3Gy6QIjb/cQ7qjbcJydxLbnD?=
 =?us-ascii?Q?8MDGO6VKIgHjOHrpJSvyMlC5KwFl+ieTR91ZK45ocbXUoyr7L/SjIDAilDAp?=
 =?us-ascii?Q?jXCViNhGrmflYd5yrh3Z4ctRCg86nT9D9bqN3bMgX2F/EoTeaZ/nRmJOqT3t?=
 =?us-ascii?Q?oNVzrjyKQxys3hTD+NZVtC4lLjPC6UoOZh4mhX7JSCm9s0YoVMWCzhuO/qe/?=
 =?us-ascii?Q?pz8IrKmdsqVLjD76XYJA6wrn7KouKmYMOfViiOpVrpMSRNn55Q5w3SfLA64n?=
 =?us-ascii?Q?wlD2mlnSjFrgZKzpqkC6JbhHhDJWfJc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 239ae707-1772-424c-a545-08de42c5f26a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 08:25:07.8394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ZAuczyvOI6eCjV+C8XnM4d9ofscM/G7f8YA+WcpI3WQkGe2C9LZkBwO7mlGPG0k14mShZSk7CMJ3gr3+McElmC8M2sZ7RtWXmlPmdGcx3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6562
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

From: Christian Marangi <ansuelsmth@gmail.com>

Bind MDIO controller on Ethernet Controller load. The Airoha AN7581 SoC
have an integrated Switch based on MT7531 (or more saying MT7988).

Attach it to the switch node to support scanning for MDIO devices on the
BUS.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/Kconfig      |  1 +
 drivers/net/airoha_eth.c | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 1356ca36722..943305155c4 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -130,6 +130,7 @@ config AIROHA_ETH
 	select PHYLIB
 	select DM_ETH_PHY
 	select DM_RESET
+	select MDIO_MT7531_MMIO
 	help
 	  This Driver support Airoha Ethernet QDMA Driver
 	  Say Y to enable support for the Airoha Ethernet QDMA.
diff --git a/drivers/net/airoha_eth.c b/drivers/net/airoha_eth.c
index a0644f63366..63f57d299ed 100644
--- a/drivers/net/airoha_eth.c
+++ b/drivers/net/airoha_eth.c
@@ -11,6 +11,7 @@
 #include <dm.h>
 #include <dm/device-internal.h>
 #include <dm/devres.h>
+#include <dm/lists.h>
 #include <mapmem.h>
 #include <miiphy.h>
 #include <net.h>
@@ -1203,12 +1204,38 @@ static int arht_eth_write_hwaddr(struct udevice *dev)
 
 static int airoha_eth_bind(struct udevice *dev)
 {
+	struct airoha_eth_soc_data *data = (void *)dev_get_driver_data(dev);
+	ofnode switch_node, mdio_node;
+	struct udevice *mdio_dev;
+	int ret;
+
 	/*
 	 * Force Probe as we set the Main ETH driver as misc
 	 * to register multiple eth port for each GDM
 	 */
 	dev_or_flags(dev, DM_FLAG_PROBE_AFTER_BIND);
 
+	if (!CONFIG_IS_ENABLED(MDIO_MT7531_MMIO))
+		return 0;
+
+	switch_node = ofnode_by_compatible(ofnode_null(),
+					   data->switch_compatible);
+	if (!ofnode_valid(switch_node)) {
+		debug("Warning: missing switch node\n");
+		return 0;
+	}
+
+	mdio_node = ofnode_find_subnode(switch_node, "mdio");
+	if (!ofnode_valid(mdio_node)) {
+		debug("Warning: missing mdio node\n");
+		return 0;
+	}
+
+	ret = device_bind_driver_to_node(dev, "mt7531-mdio-mmio", "mdio",
+					 mdio_node, &mdio_dev);
+	if (ret)
+		debug("Warning: failed to bind mdio controller\n");
+
 	return 0;
 }
 
-- 
2.51.0

