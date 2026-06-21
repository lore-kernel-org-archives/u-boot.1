Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF8DCDB466
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 00:49:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE40D8499C;
	Sun, 21 Jun 2026 02:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="B0dMKURA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8177A83FEE; Sun, 21 Jun 2026 02:49:42 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E94B8499C
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 02:49:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qwa4vwWctgHeXQxGmiPRJeEttffiYtG3GQkmXKSQ+3mQBR4CoxKDSBdiaguuFD15oJCZsb5BDmbepa5eF1eLdZ2McFt2o3yKCTAatdtv1HyuzDRRDtpLHoH8G7GIIS7Q1qQH74g1VfD6wbJnRFScOswcO9Xozm7QPLqEho/bOHioFV4qe/USVBznapfGaVZZzJQkSYN/MN/mtuu2HySo/+1WODc+tZSr1cuM1JRdueGv95KltUYWsR3XMJfOEqi+G9kSqXCrfD6leLmiy0pwQr9ON6+eUkbyiHH02ooTXqdU+/fM1CPVtavvwTQ6R3IDqeaAoD63MS0Q9unGJnC6rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8h0UP6cSqGCS5Fa+Ed4WoGgJZuMotibn5E0GpCQJug=;
 b=yE0McFTfGA9J6a/to621mC3wS+HxM2pmVQd9KI7K66Xivi8lQPWFXnaId4Ihvxx4evm21HQ8ftXTsikK8VYq+p1XapEW/UVnqR0Zks5YK3Ah+3MsZTLlAFvs1yYnYkFf6izeAfJGTPkajSMS0jaFpVy7tuEAyIju8OKvuUEN1KByOUsNf+nz77kG8/vTtWBpMmWI2TzoDTKnxYaccE772xoFpbSeykbpCcDfkwwbAqZtx8LI9v5OBYK+NYfSJuZ6WqnkHFCPWzNmnOaCdj/yVjvAhPXbC++ATbiMawlNjiNEVafZKR2PqS4G1btA49bG9AiM08lg0TkJ8IEdP5PYOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8h0UP6cSqGCS5Fa+Ed4WoGgJZuMotibn5E0GpCQJug=;
 b=B0dMKURAK9HWkOP7RMuLKNDWivB8GtTRhmFefPP6MmIWYbPI6bfUN+iaLsOmHFgvC7R/O2nFINBag4+zCWey+HRx8jzd5Dk+b6O7LUgiD9zMiXGxVRz8MpJzl+pV3oi+SLM7sUHA84IQHaSpgrcTUpJ9g4erz6MOweqkzdn3DAjbuezambawHOaIaJiGw8BZGZgg90yPWX4s2GT71hr85Bku6Sh9Df6K94KBh33Y07aZBwkmfJqOGffdPh+BULQmI8U2+0sHuJFDg/55lEIBmHiu9vFap7Hp69oNBf52IOGaYZESvSFnKrEze8W0FhrGpdRf+0IdF2qmnOvNaYaj6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PR3PR04MB7305.eurprd04.prod.outlook.com (2603:10a6:102:83::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Sun, 21 Jun
 2026 00:49:39 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Sun, 21 Jun 2026
 00:49:39 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 21 Jun 2026 10:06:37 +0800
Subject: [PATCH v2 01/10] usb: tcpm: avoid hard reset for sink-only ports
 on Source_Cap timeout
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-tcpci-dwc3-v2-1-990ecacc111c@nxp.com>
References: <20260621-tcpci-dwc3-v2-0-990ecacc111c@nxp.com>
In-Reply-To: <20260621-tcpci-dwc3-v2-0-990ecacc111c@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 Wang Jie <dave.wang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Casey Connolly <casey.connolly@linaro.org>, Ye Li <ye.li@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5P287CA0191.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b6::7) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PR3PR04MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: bb82bc9f-0561-4dc5-e135-08decf2ef911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|19092799006|22082099003|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: ctKD1fSzjJ3owtN8Q71lJY2fGfhwURxFkEH/GA/gicEnft/9RiiFbL2/QSau2QUbylwbhGHLJbkAC4Hk0zPm7D59O2r04DDSyOYzPQ7otNZA2W3/8MOgRwl6vErSVxANAKmbvdE3d/V/sGHcJIt+6D0UpkNI281CLijqFtZzs7xB3XAGPA2oVSdSsH+btC2jCxN4WQ4n/iLmQL6iOkFi6hEE88ftGdGUp/H+c3WI2f/ZsajvQXa8gO9bKjfjsJfbrmsBzVpJUEFLc0SUZlYELZSZcJ1gLPNPgqMcOvKAjP+KAcTB082pASA/t+ExKvUG6h7kpjWjSNiyEhsBnfwk3qeF/vk0uDtJcXcZPczbzxl86KOqoXMUJZTEmJmMwkGO+dlEtQ/aK1ZfSUW+lWtmCazms6ZowsbEobpdqFUZCila9QQ0vG8qg91TVa7xgeNTtHDbgYfMjBCdxmKbwFFu62vfALwQT3lLfBXbk7RABdzjhDlxEmInv15O4jNP9cUGCdPt102/ILWZyZIvmrEKc50gtTwdUZRE/W5B5L4pF2/Sj+Yv8HaGqxuupjZJlDL1+Mth+FJe1jashSaoiid4QUjnWv7tETP5E7i4rrRsZpxGQQAkYzO0w/kSS4mk8EgBysa0Djq3l6EveT8/Rke/h5PfOxjcUhcFM+Eqkv1tpvE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(19092799006)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnpFSmQ3NTJMbTJiWkUvd2I2Zm5DVStFUlBVMDRGNE9OMUswZlBOdUtBWGIr?=
 =?utf-8?B?dFZGb3Z4Q3VjTkdwK0JKQVJBam1GYUdIN2xEMkk3OHAwVWxhSnkzbTNTbkt0?=
 =?utf-8?B?b0FldnB6U2FKaVpkemZWNC9keC94Q3pBVGVsMzdpZjBZKzhsRUhuUmI3YXZP?=
 =?utf-8?B?a2dweEVYOXVqQi9EVmJxM0tYMVZJTEs5dkNPbzBXV21aTm4wOXVyd3ozc3Ni?=
 =?utf-8?B?Z1k5MFFjNlFUTGZvVHV1WUNvazg4aWpwYWZtNDBMY1F2UXUrejVDM2trajBz?=
 =?utf-8?B?bXRjSUpkMVN2YzRja0FFTmFmVFJPemdWS0h1MXFaWW9JT3ZDOHhBN1ZTUW1U?=
 =?utf-8?B?U2R6RVZlSzJrS08yRXU3d3NxbG5wcDlHZmJ4Mmx4YWJEUUVTOXk5cHFxMjJq?=
 =?utf-8?B?bGZ6ZWFlNjBGSTdKSFZ5ZFpRZmxFR0tETmRMLzZPSm5YRDFXV0tDRjhUaWg3?=
 =?utf-8?B?VUVFNHdWMURoQWNscmxadVlXcjZNNUZ4bU4wZzlhZEpXeU1zcDQ3dzloK1d3?=
 =?utf-8?B?N0YvcEZCVlNjUThGUi8wbzU2MGNEQk1GSWlvMEx0L0lITDRtQ1l5SGN2Vkwv?=
 =?utf-8?B?aXFUSEt6OG5QMzN0UjQyZFhSRFdhMVFxWDFJMHhNa3UzK0E2YlR0STFjS21C?=
 =?utf-8?B?QXdVRHJwVFlVbFptWXNrb2s1RUhMZkJmM1Q1eHUzaSt4RDR5WkhnbnkzUFFX?=
 =?utf-8?B?bnFjODFnQTlqMHZRc0FNOGtETTZsbElkZ2ZqWjFqc2h5VHVNZkdicWwySUhp?=
 =?utf-8?B?cG1WenozTWtwTERYcEFoT1FoZnJXY2p6aWwzc3RJc1ZPVDkzZ0lpKzF1VDZr?=
 =?utf-8?B?R0ZRU1ZESEFTUjJIVitVSkFwMHFGM25JRVVNMTBCRExnb3lPWDV3cXFJdDE5?=
 =?utf-8?B?UCtjTDdKVGp6YlFNVHhLYklMSUppWXVLN2FYREdsMUlvTTdNRFduYlo5WDQw?=
 =?utf-8?B?YmtUeVpLU0JLenJoVW1NQWJPOFE1UUU2WGdoN2sxRVE3SWxzUThSYnZTdDlB?=
 =?utf-8?B?em9oSjJMU2UvRHpnQWJTNEdNQWtsK1lod2M4ZDBrd2E4VlV2bkoxNUZ5aXcy?=
 =?utf-8?B?SnQ5RXNiNk13aHZReDA0S1lsUjlJSWwzRnVNWk5IU2J3cUIzNWVobVNwM3VY?=
 =?utf-8?B?M1lpMnhrRkhRWDY4cDFXYkNoWmZnREx6L3pmdW5naVVhakxhT2F6QThqeGpv?=
 =?utf-8?B?R0NXQTkzRHVwMFdvdElKYmpJeDdFQmtHZnBTdzNpWWpBd0swMVhSb3ova1NL?=
 =?utf-8?B?SkVVQ3VEcG5jRDFsaTBoQUdwNzU5bVViOUsvV2V3cTZnUVZOU1ByTXBGZEVK?=
 =?utf-8?B?eWp3cGlOMjl4ZUc2R0pPQjBsMkxCTGdwVWhWYk5Dcjc4V2VpS1BLY1RqeXNu?=
 =?utf-8?B?VHdWMlYwVlkyVnppa09hVkdDSzBTYWlUcTdNRDRtbGxSOTRpMmtOR3JxWTRN?=
 =?utf-8?B?RXRseXJhZjl5dUdyYXdCQzEwbVlxQStUY1RiNmUxVXYwakdHa2gwNGlNRzA1?=
 =?utf-8?B?QVkvSlRBeXYrdTJ2QUcrbXN2VjBqNFo4dGd5Qk1TNmRTQ29DQndPdnQrUTFm?=
 =?utf-8?B?L2p0VW1Jc2E5Q3AvVkJ1YmhvVG5EZC9jUUFCNzh5SjVoNDQreUJjTXpManJz?=
 =?utf-8?B?KzliY3BqYWFLdDV6MEdOWVNWUmNCRzBVR0NGNy9zcDk3RDZTRjAzYkhQV1Nu?=
 =?utf-8?B?a0dXeHJTWnIzZ0tJV2p4ZGpJSVRsUExMbEluc0dQT1hXZC9PcHBNc29TU2Nv?=
 =?utf-8?B?VXQyUVlYdkg3ZXZScWRqUWxEclpxRU5WRVphVVM5aFYyc1FqSDV4bUhjU241?=
 =?utf-8?B?RWszMi9NVGJndUZMQ2sxUXMrbW94Wk9rSW11cG55eXRDRXNGKzFtNGMvRTFC?=
 =?utf-8?B?VGpZWmdzVEExNlVSMUZlaTZMSm4xWS9oa0w5NTZDT0owRndVcmY1SER1MjNX?=
 =?utf-8?B?QlVQWnBzbWNtazZDalM4WDVZb0k1a05KOXpNMnhPcnJMaXRtZStaVm43TTRG?=
 =?utf-8?B?WE5GTzY2RStGcnR6UjhtcDFpR2V5eXdhZXByNWJwZmJpUlBCb3A4QkZTYzMr?=
 =?utf-8?B?Tzh2NDlLWVlycGVTS0VFTzVTUkdTTy96RkU0YjJZS2dySFNyMklrelJaUmp2?=
 =?utf-8?B?cWwwaXY3T0U5RHZHNGZlalpZOUM5U2VwSW9iNVZNUzYvOWZGZ0gySkwyRXdO?=
 =?utf-8?B?SzBKTFdXdEhvYWtIVlMxTjMzR3M5SnZWWit5djBlQjVYNjNYb3FTYldFQWcy?=
 =?utf-8?B?MTF0dklzVndVSFZDRzg1b2Zob0Z0NUhJY2svZCtQVDVkQ2VtcE9YY0VEcFFt?=
 =?utf-8?B?ZWdUNDJ0dEw4aTMzTndjQVJWZGZnYU14dVYvV0ZtMEtkVnUydG93TTc1MG9P?=
 =?utf-8?Q?wU5LzZAVvXEUJai/JlQ7wUV9tkNjaP1FFbuZX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb82bc9f-0561-4dc5-e135-08decf2ef911
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2026 00:49:38.9617 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ffDTYfJnEIj/T0fJSAg41P9AL1odmMrXS2QTonQPE98zKleTQFwi5pZ+69cRGSPLrUmoNvAAdpyuZDzCLmF/RU4YJMac5Oxb356rl8VkyyoNig3xk5C1s9JqSDKwZyL/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7305
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

From: Peng Fan <peng.fan@nxp.com>

When a sink-only port times out waiting for Source_Capabilities in
SNK_WAIT_CAPABILITIES, the current code falls through to
hard_reset_state() which sends a Hard Reset. For sink-only ports
powered via VBUS, this causes the source to cut VBUS, resetting
the board.

Unlike DRP ports which can potentially recover by switching roles,
sink-only ports have no recovery path after a Hard Reset induced
VBUS loss. Instead, gracefully fall back to SNK_READY to operate
at the Type-C default current.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/usb/tcpm/tcpm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/tcpm/tcpm.c b/drivers/usb/tcpm/tcpm.c
index d6c0be82333..25ff0926cdf 100644
--- a/drivers/usb/tcpm/tcpm.c
+++ b/drivers/usb/tcpm/tcpm.c
@@ -1647,6 +1647,8 @@ static void run_state_machine(struct udevice *dev)
 			port->vbus_never_low = false;
 			tcpm_set_state(dev, SOFT_RESET_SEND,
 				       PD_T_SINK_WAIT_CAP);
+		} else if (port->port_type == TYPEC_PORT_SNK) {
+			tcpm_set_state(dev, SNK_READY, 0);
 		} else {
 			tcpm_set_state(dev, hard_reset_state(port),
 				       PD_T_SINK_WAIT_CAP);
@@ -1770,9 +1772,13 @@ static void run_state_machine(struct udevice *dev)
 		port->message_id = 0;
 		port->rx_msgid = -1;
 		if (tcpm_pd_send_control(dev, PD_CTRL_SOFT_RESET))
-			tcpm_set_state_cond(dev, hard_reset_state(port), 0);
+			tcpm_set_state_cond(dev,
+					    port->port_type == TYPEC_PORT_SNK ?
+					    SNK_READY : hard_reset_state(port), 0);
 		else
-			tcpm_set_state_cond(dev, hard_reset_state(port),
+			tcpm_set_state_cond(dev,
+					    port->port_type == TYPEC_PORT_SNK ?
+					    SNK_READY : hard_reset_state(port),
 					    PD_T_SENDER_RESPONSE);
 		break;
 

-- 
2.51.0

