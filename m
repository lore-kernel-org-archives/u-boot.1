Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F70FD2D77
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 13:13:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10E1784065;
	Tue, 10 Mar 2026 14:12:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DDXMiceM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE38C83981; Tue, 10 Mar 2026 10:14:10 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F27AC83F6D
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 10:14:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAH/mlPK/CHhcE7lInKD/IjStJxaaIUCqgWJFBUgcuu78H1gJaY903M+ruULDQFE8fsDgxMY0I4fh8IpStM/gEtipMyYDHEwHB6/vGgbp8/x5qS2cLMOP1JBxh2jAidbhsQGiZENMfwTYaoo+AgKG5dBxLxg1KTXalxeMudWMII0COBfO7xHLaYhWROtz/YHL4OQCfQv9ZmL38A7nNqqmMuxnyNk0dnsF6N2xppRbGtBomlr46PiKfF9kOFpgTfjbuqugyN5opEobtT2I0ZdrE4icRMVioE2xjhk77OV7HLM9Zi2+h/7gCkgd2KnnjT6d6q8whqUAHHO5D/Gc9EghA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/A1s54QQjbw+j46wXP3yOv2/YcHp1K1ooFAVxNb3BfM=;
 b=nG2tHeZ5556GTDeEeLROkglcRi91r+iWchuKcnXGtV5SFbq8fUpK+nLfhxyjp67TRRBu4g/OWY/xi/JUQLl4kN7szCCBRtCYnVIjOMKCEHF6E3aRm2ex80u2qkRfAFmv8koo2R/WufHa5uDrSyolpVNIpcvEw1aGQWKRtjvouBL4m7Yc+k1lhnP07DVfSpABy2WRF/84W5UpgDe64Wk+DvEH/F5kNWstaTwYzLcW27wW0cp1Re1BcGsTnOpIoYx8JcwPe9AMoajLtrFy7ZOsgzr9AJTOsdzXhJK0wzr3WNZGX2Ior6OoR9MapEizhEDP8kvKfOSUNICBKxw9erQsbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/A1s54QQjbw+j46wXP3yOv2/YcHp1K1ooFAVxNb3BfM=;
 b=DDXMiceMHIiNXSTr1w+fkSBMHSYL603gfCibSCBuwozSWzEp4v4/SOjehnUbuZiacJS9VkENOQH+5iTRQlTB4HijiU+yLEriJpZqj9Jbn9rCItKiI0z9TfQhRg5C8ZoUuIq/pSDR6xedtHnftENZWtCkuq3vnr5e2aBmuLJcQNzEV+vllfVYRkeW4hna7uiLLGKrnxozkpz4IVjGt2k36uSwp6oIDoNqDK1Z4uS+rwkYcXVD8OE2jtb+j/zSqPe6XBRQkXZZs5m6tWl3JYY5seSGaKeQKUobUKIZjxd7BqYQeyVd1120emrP12Nw/Dgzm2NfnxJ5J7UxpWXBIzx2Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV2PR04MB11192.eurprd04.prod.outlook.com (2603:10a6:150:279::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 09:14:04 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 09:14:04 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 10 Mar 2026 15:53:36 +0800
Subject: [PATCH v1 02/10] watchdog: ulp_wdog: Get watchdog base address
 from device tree
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-wdog-v1-2-2ee21e890634@nxp.com>
References: <20260310-wdog-v1-0-2ee21e890634@nxp.com>
In-Reply-To: <20260310-wdog-v1-0-2ee21e890634@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de
Cc: Joseph Guo <qijian.guo@nxp.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Ji Luo <ji.luo@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Jacky Bai <ping.bai@nxp.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 David Zang <davidzangcs@gmail.com>, Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Primoz Fiser <primoz.fiser@norik.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Joseph Guo <qijian.guo@nxp.com>, Mathieu Othacehe <m.othacehe@gmail.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Jindong Yue <jindong.yue@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR02CA0071.apcprd02.prod.outlook.com
 (2603:1096:4:54::35) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV2PR04MB11192:EE_
X-MS-Office365-Filtering-Correlation-Id: 0778df67-603d-42e1-806c-08de7e855ff3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|52116014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 3CZTgXVqqVrdM/YTe1fhFi3nmW6w/r3LKulDD4m57qEBw6zDNdX8qScKzhm/YH38dAE49BgSdhSJ+MBmu3X+Z5JsS18doBb4OT+3xVzyWv5LLri015rtViQwuFEJGYLfs7Pn++M3nkq2IDoYQpVKZhB34s7b98eO9owvweh5dBa7kCvsTtCaqo6Ipkir3MFglJiOTcuv5IFHI88Bcqi85frWzuraIynfJ1nwLmYEJrkPj4Z5OuFq7Tf/NUhAd05EkgPct/+R2UvPSR1WUYoeHNy8UxxqNyFo0eJOwCBA8C7GbkcWL9KT2056EZbI+WYiaPaO26GuHJpu1FYqQYvlNw7RydpzsPWAaVYT1aKPnTQEXNKXNgVElnRJMimvtFdYcUsWlbsk+JajA/fei70saXnDDe9T0pqZlOzyheRWmPXWnzKi/qZ0tFJouSBFtavu1uK9AeUyAFfyh11CRPSEcm+bwCEdRd1U+Sh204iqsf+Yi35MdpUj80+GCBCIwQ8BPkGcNdXnuiv9jU0FAzP3RHf7PadGbuGLj+wbOyvmRwMe0WAuJWxR6peLUEY9HH2I5YDjBlqji1zwuQT5Y0T2dOdGJorBY1hSESPL1DSU8Ri/rQRRK6eZcvr7roB/A49m1fyU1HSlFEnu4abKgo7BvczTsNxnvKKP7+kiF2RS5rii7YvWJ7ohd6mlNDJc/kKNCQt/iu61k7zkhWRdzXrCV11fhWhu0cLOzmPxM9gNzGieCTk4CgAQ6qv+i8g2CXbz9C24vEv3FH5uhI69G6RcRgtQnLVWkk/gdJd92j74aC0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(52116014)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFBmL3VuZmVRRU45OE1Yd0RiOHFOY0U5TGwxMXpBNWhWQytrQUVqRllreElR?=
 =?utf-8?B?WFVFbGZMOFNORjJaU1ZwUHQ5cG80ZUppeDdHZnUybjdPbm1IM3l0RWRDdXVn?=
 =?utf-8?B?bklZTUw0U3p0MlJpYWF0MlNJb1RYdjZhOWFxNStQU0RFWGRqWFYwQ21yaWcy?=
 =?utf-8?B?QkpwZEh3REh6L3NmUW1hQ3cyYWZUOUladG40djIwd2ZzNHd4dFQ0ejUzY1g3?=
 =?utf-8?B?SFprWFdudkpJVDdJN25oTzdQbEMzdzl4L2Q5V2k5MXc3V3VrQTJETWtBVVRn?=
 =?utf-8?B?WEkzN3Z3c0xETmFvcUkvTEJkNkVvOGNJU1h5aUlQUmhrQjcwU3d0WUVpT0xq?=
 =?utf-8?B?M0pON0RFVURIaVUwNk1UajIyaEhoSmEvNVNLR2hGOTltd1IzQUIxMlh6Q0Mr?=
 =?utf-8?B?UkN5ZElJZzFqOUxxY01Bdno4aWNudldWcDJyQ1Ntb2VGbVU3TEZLZVBGRVQ4?=
 =?utf-8?B?SzB6RDVlNlhwWHpWZlFTOE9LRFRqZlBlNjV1N3F2VHZKdmJuYTVlVDR4WE91?=
 =?utf-8?B?cGR1MFkwSG9pdXVZV2QyYmNNcFUyZmxzS0JuQ3dHZ05MaDFDZGl2RWV4bGdP?=
 =?utf-8?B?OGNQOFkxR1UvaURPdVU3THRyOG4xRytCNkx4cnFwVTloOFZjdXQva2hJQlV5?=
 =?utf-8?B?S2ZvTEhMRFltNjFqVWpWVldTVHpPVFVuMFBCMTBta2VTUmNyTzh0QVpxbVdo?=
 =?utf-8?B?cnhSYmNabEErNHFTQmdSeFBtaXpqTitoZXk3cEVOa0JPRGVCUkwvZENWVjBi?=
 =?utf-8?B?RktFaWZFN3BlaEQ2OHVTTUF2Tk5DOTRWYWFmWTN5MmxWVFFwT1l2WDUyc3dM?=
 =?utf-8?B?SnlYOFQzQ2xBYkZzQnc3bms5bHJIOHpjRzNmemhJOXZWMXZHdlp0QmpLaFJH?=
 =?utf-8?B?bnM2STNLTnVvOUR3K09FeDZvdTdkdmJadWtTaXBEeFg3Y0hBU05oUUJQR2V5?=
 =?utf-8?B?SU9JcWdBQzgwR21mNWUyVEFiVmFOMWM1cUFrcmJUMXF0UXZsTFo2bHV5QXVB?=
 =?utf-8?B?NFJKd1ZGcmZFLzlZcHNlZUI5UFZDc1dvNTNtL2R1bzdyUS9IOFdKZkNnU0Fa?=
 =?utf-8?B?L0xiaUJnOHMrSjcxTWdseVUzaVlEc1Z4czVxMS9SQi92emdwOCtMaTN6MkRZ?=
 =?utf-8?B?bjFCOHI4M213bTV0WVZrR1hhaWd3bkhYcGFENzZSUlhLZENRcTZjM3dGWmxz?=
 =?utf-8?B?OEJyUER0enlOQTlvcVVWV1NaaVJ3RmJhYUJwNzNaR2tZSm02aHNWVHVYbUN5?=
 =?utf-8?B?SDJRTUkrTWdOQWdMb1hndTlFd0NHTzB6Vk90M1hvaDV0anZSc1ZCL3hwcHpV?=
 =?utf-8?B?eUZTMFljUE1uYVJQb01NaVh5cnFTd0tkUFM0L20xTWlLNzg1N1NuVkJCQkdS?=
 =?utf-8?B?NXRFYVlGUEpoQThWUDdTOGR4YWpkV2FubkxLWnV2TFN1b1pGdm5adWVmZ1hF?=
 =?utf-8?B?WHdqUmFwSyt5UTB2SXRHUStYUGwzdWd5YlpoOWRjcHVVekFORENNcEtDRmVj?=
 =?utf-8?B?VFpGSjBRS0NmZVJlTVB5b01nRTVkbFAzanZXYlA0dUl1WWhieWI5NDM2S1lv?=
 =?utf-8?B?VW5EYzgySDg4VzFlZXZHNjVSSUFiREwrcWttMy9odEFZOGdMSlIwem9WcEly?=
 =?utf-8?B?aEJ0bGJ4ZW1IamJjLy9RNkIzWVkzMDNPZzhWclZEVHVwdng3TE13bUMyejFz?=
 =?utf-8?B?VVZlbDlNMmFhU2VSUDBBTWVKWEhjVWluM3dDTkpEZ0JzOU1pbWhLc0VqUXJB?=
 =?utf-8?B?SHZrbFg1dTRIMlIvaUJJUUhmWTdYNFhtZGU4SjgzS1lneEk3SXdybGpnaEpn?=
 =?utf-8?B?YVRPMG1LT0NvYmZuanJTNExVMmFxT0YzY0J5WDVvQVNTczdJNjgwd29sY29n?=
 =?utf-8?B?ZU45TnVoV3Ryb2d6dzFMV0p0a0dYcGNHSFQ3TFVmMWZDazB3MGh0M3liSGJJ?=
 =?utf-8?B?SDRMbGNkcXZOUVBSN3B3WnpSWDl5QXp3eXVGT0dVb2xnWUJ5Wm9pMHBIdk5v?=
 =?utf-8?B?aWY4TSt6OTIwZ1RjclJReFNJOStmMGR3ZC80ck5uVVEzY3dMWFNJMi9EN0N3?=
 =?utf-8?B?ajRJN0NteHNUK1h0d0U0U2FwQWFqVEk2ckczZ1kwRWI1U1JJcy83LytXYWQz?=
 =?utf-8?B?dmRrV09kNGFOUVVKLy9Hc1lFekcxZ2N1NGYvY0RDZU9hblpIaUYxQ3M4ZVFk?=
 =?utf-8?B?L3dkQzlEemRIQ3Z6amVTWFJaVDJyOFhua1AweFdUVldFRTAwU3dLUFdxdWJ0?=
 =?utf-8?B?aEZIWDZBd0FpRHNKZWZlTHNrWEpYaXg1UU5hR0F4NkxKUEpIUkx5dkFJQzZJ?=
 =?utf-8?B?N3hpVkdaYjJmbit4d2g5NkVVTXJVQnY4QXhodjZnUGk3eXppRUlPQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0778df67-603d-42e1-806c-08de7e855ff3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 09:14:04.1784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LG+ijaqxdwN+jDAAIM9wEmkOvzoinUzrjd781ydb7GQAKTwrXLHnP36etwu8cOkrWAfWjMde10dKNn3Bx6T55A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11192
X-Mailman-Approved-At: Tue, 10 Mar 2026 14:12:11 +0100
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

From: Alice Guo <alice.guo@nxp.com>

Replace hardcoded WDOG_BASE_ADDR with dynamic address lookup from device
tree.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/watchdog/ulp_wdog.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/watchdog/ulp_wdog.c b/drivers/watchdog/ulp_wdog.c
index 83f19dc0e86..3840a3db784 100644
--- a/drivers/watchdog/ulp_wdog.c
+++ b/drivers/watchdog/ulp_wdog.c
@@ -6,6 +6,7 @@
 #include <cpu_func.h>
 #include <asm/io.h>
 #include <asm/arch/imx-regs.h>
+#include <asm/arch/sys_proto.h>
 #include <dm.h>
 #include <wdt.h>
 
@@ -51,11 +52,22 @@ struct ulp_wdt_priv {
 #define CLK_RATE_1KHZ			1000
 #define CLK_RATE_32KHZ			125
 
-void hw_watchdog_set_timeout(u16 val)
+static struct wdog_regs *ulp_watchdog_get_wdog_regs(void)
 {
-	/* setting timeout value */
-	struct wdog_regs *wdog = (struct wdog_regs *)WDOG_BASE_ADDR;
+	fdt_addr_t addr;
+
+	addr = imx_wdog_alias_to_addr(NULL, true);
+	if (addr == FDT_ADDR_T_NONE) {
+		printf("Error: Failed to get watchdog base address from DT\n");
+		return NULL;
+	}
+
+	return (struct wdog_regs *)addr;
+}
 
+void hw_watchdog_set_timeout(struct wdog_regs *wdog, u16 val)
+{
+	/* setting timeout value */
 	writel(val, &wdog->toval);
 }
 
@@ -89,7 +101,7 @@ void ulp_watchdog_init(struct wdog_regs *wdog, u16 timeout)
 	while (!(readl(&wdog->cs) & WDGCS_ULK))
 		;
 
-	hw_watchdog_set_timeout(timeout);
+	hw_watchdog_set_timeout(wdog, timeout);
 	writel(0, &wdog->win);
 
 	/* setting 1-kHz clock source, enable counter running, and clear interrupt */
@@ -107,16 +119,17 @@ void ulp_watchdog_init(struct wdog_regs *wdog, u16 timeout)
 	ulp_watchdog_reset(wdog);
 }
 
-void hw_watchdog_reset(void)
+void hw_watchdog_reset(struct wdog_regs *wdog)
 {
-	struct wdog_regs *wdog = (struct wdog_regs *)WDOG_BASE_ADDR;
-
 	ulp_watchdog_reset(wdog);
 }
 
 void hw_watchdog_init(void)
 {
-	struct wdog_regs *wdog = (struct wdog_regs *)WDOG_BASE_ADDR;
+	struct wdog_regs *wdog = ulp_watchdog_get_wdog_regs();
+
+	if (!wdog)
+		return;
 
 	ulp_watchdog_init(wdog, CONFIG_WATCHDOG_TIMEOUT_MSECS);
 }
@@ -124,9 +137,12 @@ void hw_watchdog_init(void)
 #if !CONFIG_IS_ENABLED(SYSRESET)
 void reset_cpu(void)
 {
-	struct wdog_regs *wdog = (struct wdog_regs *)WDOG_BASE_ADDR;
+	struct wdog_regs *wdog = ulp_watchdog_get_wdog_regs();
 	u32 cmd32 = 0;
 
+	if (!wdog)
+		return;
+
 	if (readl(&wdog->cs) & WDGCS_CMD32EN) {
 		writel(UNLOCK_WORD, &wdog->cnt);
 		cmd32 = WDGCS_CMD32EN;
@@ -141,7 +157,7 @@ void reset_cpu(void)
 	while (!(readl(&wdog->cs) & WDGCS_ULK))
 		;
 
-	hw_watchdog_set_timeout(5); /* 5ms timeout for general; 40ms timeout for imx93 */
+	hw_watchdog_set_timeout(wdog, 5); /* 5ms timeout for general; 40ms timeout for imx93 */
 	writel(0, &wdog->win);
 
 	/* enable counter running */
@@ -155,7 +171,7 @@ void reset_cpu(void)
 	while (!(readl(&wdog->cs) & WDGCS_RCS))
 		;
 
-	hw_watchdog_reset();
+	hw_watchdog_reset(wdog);
 
 	while (1);
 }

-- 
2.43.0

