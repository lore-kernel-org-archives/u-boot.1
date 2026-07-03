Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFD6C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 07:51:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2053841F2;
	Fri,  3 Jul 2026 09:51:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QLX2iyJp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC86C843B6; Fri,  3 Jul 2026 09:51:34 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD08D8407E
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 09:51:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3/moktllexBi7cYlOZOrQ5UFY9Pu4aLyUeYJz9yYl0iVw7nnOgfKIgbAIzz6koE/LB1y97kPw2J2rRUausn9qGNQfH9ePv8b4gew32l641B3W50BI+I1DephPzTvoteF3PynAi9q1qGzcnN7yy1Q1xZM1wDT8cAkc8Y9lRnuexZcQjLLkdgC+5rzQPn5yfbgQPlKGHe7yxZog8WYopaU3J77oP36LdJ4UgjjEGWxoHg9LiviopGwMS706SO6Bwlf5G37/CuIJW+AveS6+y4W0d7MpCDPe3qSn4WYT/k3ALutW69yrr6QxNSRg68hl7cgEjhJhRFguBYjFFBLJyfKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GR3/YFZY5lAUWzSUgZfX6QroLJZkJTRBam+G0d5aJxk=;
 b=m+u7LEiPKn5KMUf/Ki0SnI2QedcnTj4HzNNiMW51ewWcC5agxlOZOswPnB84dAJLDKWTmlOSfUVDwyLPrdM9+zjMg9TnIyAM3iztSi5iHMlSeCKkZV1g5L/03PDFo7XAgF2ZMVn++nzMJCHtTdjEqPj817vMJmehUcaEc/UKDCwvJnxlNjcl5NwCqY6I58z0nXLNXKeILSAvUItb5HYNQi2ZgjdrLFfR3X/4UgNcGK71QgoZp1jaJGUyvMcUgAFUjh2Kx45gnMbOfQK53vpR2m96OVoeTtTpVKZuYu9U4gucYEiJhKrGWXSBwbJje9IMSvUpSBcLtKzZJPBHt0qmLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GR3/YFZY5lAUWzSUgZfX6QroLJZkJTRBam+G0d5aJxk=;
 b=QLX2iyJphvgCJFmHlhf48dKNT3126y27YBr90VnX4EI2SAwQAC8z8jaRr4jmif/T3aqnEeuvRmwmb2jrXhp4tsVSKK92C7vkh/PAUxepCj/SwD8PbyZ/CMnejEr0R/cT0mirJ6LQ/QIOuk37JszepbkwjncubyxDTZFlmKDFi6nTpxM50cmPxcanMaqLvcMjzPUzCfyc4ByINiRBDF1egog6/5hr+WAh41Ou4ZIl6PxgLd7usfi2s3us1HE9AMzX2jlXxfSQNF4Zn56x/vTsjzD+FfIPZXCAx5CJfzoQL08OIuvjg9oXbT2PEZsBEOW/229atQ5YAgK6gCPVIwHMyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB8687.eurprd04.prod.outlook.com (2603:10a6:102:21e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 07:51:29 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 07:51:29 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 03 Jul 2026 15:50:19 +0800
Subject: [PATCH] net: Drop unnecessary device_set_name
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-net-v1-1-3c2c7d6323c1@nxp.com>
X-B4-Tracking: v=1; b=H4sIALppR2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwNj3bzUEt1ES0uTNKPkJGMTizQloMqCotS0zAqwKdGxEH5xaVJWanI
 JSKtSbS0A0essLmcAAAA=
X-Change-ID: 20260703-net-a994f2cb348f
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5PR01CA0184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::10) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB8687:EE_
X-MS-Office365-Filtering-Correlation-Id: a3f16aee-e8d2-4da6-67c3-08ded8d7e3ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|376014|1800799024|366016|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: XMFqdLkyl8EYEThWTsOtH1q5gYn9bkANAR8kaI+4JGEh/dy4xeNHKWma+epenpEJwJu03mmN10Tu/pioODGD/eWPVbIHLG0pHuTOOD1NDNhf/egbU+7zYhcwjkV/O/Z3XgdRiLuCpPMU6/XJAmz1AkM8+kcvC39MHqKqIQowQJNcDAYB9pbzRMwxlFP7AAiVmrNwW6FMlC6dEvvOf6HuQRzGrqGiRp4GY9Ugtv/d5N1mQx/MTh4RRk4S2HAo3W4a5VaSRLI9eF/dQXOX9rotTsebazon5maovTC9PbXq1zStMM7mAiJV2EWgxzEuZgEcJZsja9M16MHv+xTlms5e9X91Zwdv1AS0dfdHMB2F+9D/2YsCX2CipZQhNpIq0c1N0AbukQ1xd4WV04I9YcTXLlp5x40XTlqKpsHM8R+nKZym8ImtQnsbDIhblNco96JqFXfEsz9XA/ZZdxBxhtqJlbOk7svSNCjLgE4fTCUQnedd3Gkht9LEB0+JbMOHZlxbCnz3LBDkaStnZy5addBiFL/NyNh0rxsqCdoUp1k6JV2gNdM23CxO05Y4HvnckpC89wxGCxClgyHopOcEAuHzn/BHw9RBGRV764HLKGW9bvnEnNAMrO7mO6qC+2PXNookXC7lo7gyEbXDzVuZJcUs3PHBb3TcIWd61L48Yap+DSo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(376014)(1800799024)(366016)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFh4N1ovUWpWaHQxcVlSb0cxVklCSjFwYTRwQjhRdWlVRTh0UGZNNVRNNkI1?=
 =?utf-8?B?VHp1VTc3TTJoTUlSanlPTGUvSFhjeUpXYWpkWDVmYlRqWE9KUzdGcjg4WG1n?=
 =?utf-8?B?WGU5WUVacEp2UURoNDVRS2J4OGczZ3lnTkFERW1ON1Y1d2lJZ0VmMDQ4ZEtT?=
 =?utf-8?B?UHByRkdDeXBTYnYrL2pBRkpjKytzaVpqUnhSb2dPUEdpQzNuOHQwL29xZWRD?=
 =?utf-8?B?M3YxOU8wRURVc1pjNkFBK1VqazE2Z1BsZkYvVW1xOTNCYmpNSERyZ3JhcnYy?=
 =?utf-8?B?K1EwbExUTGs5Yy85SHoyYXFBOUhrMWUrc01kSlpEdGUzY21kY01jTVYwQ2FQ?=
 =?utf-8?B?WStHck4yU0VITjErYjBhQ0dObkk2cFhzcHFjd05GdGlQcW4yWVlsOHRQdjVU?=
 =?utf-8?B?TTMwMi9Id2twS3RraVFWZkdPZCtrNXVOZDdSUTRIcXpHQ3FsZ1NVZm0zWmtJ?=
 =?utf-8?B?UmFJaUZzcFMzYzNNRUc1ZjRoaDZoUEJ5aTJQcXNVMEZ3YjJTQzB2dDJ6eDhP?=
 =?utf-8?B?bC9NUmlia0cvdm5lc3U5bllNOEVjeWwxb00xVk5mZ0M1RTVTdzAvSm51cWJl?=
 =?utf-8?B?V2hOYTJILytTaG4weS9DRmRuVFJCZEZTTXVDbGZyTEx5K09oZkVUcERucDBn?=
 =?utf-8?B?bTBhVkxvU1NvUTJ3VndMbWpqU2s1b3o2cDc0TlB3dGVVTXR4cHU3Q0xVMTF3?=
 =?utf-8?B?RGhwSzZ4Sk9xTW5kZU1XcDdrTUdhZjBlVkttV3FSeENBQ0tGY291MDZkdkZa?=
 =?utf-8?B?RDY4OGFSVWVlOWZWQUZVQ0YvbEtRRnZma1BOSzlPM2ttaUhCbzBzZHRnbEY1?=
 =?utf-8?B?T1BseHdrL3ZNVFA5ODN1NVFhMDZXaWZSM0xmOXpHQ2tUdlBXdGMrRmdEcDFY?=
 =?utf-8?B?Q21xRUREYUhSMHVpYmRFdXJlMTZxbVZiWDhPWitDN1pQQndHZkxYNVA4ZG43?=
 =?utf-8?B?bmVWVStwV2hneXpUa3JFU1JuYTFYb1ltYU1tdCtZcWhGY3Bxbjc2Y1dGd0ZT?=
 =?utf-8?B?ODk4T1VZUllJdG1GbDN6QW13TlI3L0oyR2pnTVZYaERZYXJINzVHL1lQNjZL?=
 =?utf-8?B?c292ME9HUXdLT3AvT09YeGJnTVJpY3ZrR0g4M3Zod0hsd3d0a0gxNmFvK29a?=
 =?utf-8?B?M0t5RUcxeUx5UWloNEk0dlgzMzVpdGMzT0ZzM1hHdlNIN3BSUTRYaEs1cXE4?=
 =?utf-8?B?bWFjWXQyZ080Vks4ODNUY0lhWVN1Mmo4cklUMmNYZ3VGRkpWYU4rNDlLdzRm?=
 =?utf-8?B?OVA1YWlFRkJBSDdoMmkwVEROME04bERYNmZXdlN4SWtsa1pYeFFTbUZIUk5k?=
 =?utf-8?B?Um41bU04dHdTS2ZlZWcyVXliOTg3TGVxK2lob0FGaVYxV0VMM0FGaTNRSVZS?=
 =?utf-8?B?Mm5EYVFIQmRkMGdUS09uQkV6b281cmhvc1FsM1BPaVBxWHM3N1NZVGVaVjVT?=
 =?utf-8?B?dkJYVUJ5aDNCSFppdUhiMVN2bFdoZGlwdzhidUpTYUdmT1pOR2N1cWJiM1Ni?=
 =?utf-8?B?YmtDcFVqWVBNdzZMMWNpOEF4ZVJRSktUTVZ6RFJuSGJHeXdGVnl3ek5GajRr?=
 =?utf-8?B?NHMralUwRGxvS1N1eGNZeDQxNE1QelBRbnlYNFNLMkhNaTRxQ3ZCVHJsRk55?=
 =?utf-8?B?QUlQeVcrNFByODE0QUNSWWwycjBXWWZWb0dzWW53dXZiNitORGpYRzNiUElO?=
 =?utf-8?B?QlhYS3BIRGQxNkNhUzdNbCsyeUs4Wlh1dDZDWXZiNnNGY1pyaTBqSm5mWXlO?=
 =?utf-8?B?QjhDcVNIcGppcmU2Y1JtWU05SWRjc1dsSHlTL3M3a21lV1hRYXNJRlJpcXZF?=
 =?utf-8?B?b0JwaUxSczBjQWRZM2wreGFjY0p2dGR1aUVMaVZvRm9NSTBmZ3pTMEFxcXhB?=
 =?utf-8?B?MFpWeUtqUjE3RS8zV3BwRWpseUhRdU5XWFFqcVpKZXRsMmpncHYydXJTMzNN?=
 =?utf-8?B?d056dHBpSmowd05INEZnQkpMNTZJOE51aHJZK2V3ZmVabS8ra0ljZE9lTkNM?=
 =?utf-8?B?RVRXbU5ZTVV1dXhHUmxuRW5iSDg0eFgxUExlMkxOcVh2TlFVSXJtaWlRK0c4?=
 =?utf-8?B?VGExUVBtdGxSbUpHZGptSlpkVlhzLyt1YXdRQnQra0g2dkw5TFZWZnNVVXlD?=
 =?utf-8?B?VExsbjBSaDUwYUViVGluQllCSmc1bDF5TCt6NWxDRHlGSkplakRYRkVIMG5O?=
 =?utf-8?B?WjA2ck1PMm82YVA3L0RsdTBvUStHWUtENkRwdlJ1bDFUUmFteXNXb21ObWlZ?=
 =?utf-8?B?dm9VNTRDVTg5d0FDNFJuaVo5MVQ4NFhHR2YwWVdmekJYK016RmNObjlPQ1B1?=
 =?utf-8?B?L1M3c2xuaEdRTjRYRVFIaFdnbk9NREl4VzYxYlhueDYzL3F0NE01WXNuL25i?=
 =?utf-8?Q?JbU2lzzaPGcg7daWI9htlkSmnaZMp3/pJVnmr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f16aee-e8d2-4da6-67c3-08ded8d7e3ce
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 07:51:28.9188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anEYg3TQNg4SFIlklDbEZ1r5jKCUYhL3KQsIE9JBVtAyiXzColTQEfd9wmiM7rDhft+1NaAXU29bxJ0lgCxbymfcGmEDUbFjiMHeIwn5FUHqHwxJEzi7zgwGSvCbELEL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8687
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

When device was created, it already has a name assigned. There is
no need to alloc space for name and set it with same device name.

Cleanup the code to avoid unnecessary device_set_name.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/net/dm9000x.c    | 6 ------
 drivers/net/ftmac100.c   | 6 ------
 drivers/net/ks8851_mll.c | 6 ------
 drivers/net/smc911x.c    | 6 ------
 4 files changed, 24 deletions(-)

diff --git a/drivers/net/dm9000x.c b/drivers/net/dm9000x.c
index 9e17f0b9c28..53225979b66 100644
--- a/drivers/net/dm9000x.c
+++ b/drivers/net/dm9000x.c
@@ -638,11 +638,6 @@ static int dm9000_read_rom_hwaddr(struct udevice *dev)
 	return !is_valid_ethaddr(pdata->enetaddr);
 }
 
-static int dm9000_bind(struct udevice *dev)
-{
-	return device_set_name(dev, dev->name);
-}
-
 static int dm9000_of_to_plat(struct udevice *dev)
 {
 	struct dm9000_priv *db = dev_get_priv(dev);
@@ -673,7 +668,6 @@ U_BOOT_DRIVER(dm9000) = {
 	.name		= "eth_dm9000",
 	.id		= UCLASS_ETH,
 	.of_match	= dm9000_ids,
-	.bind		= dm9000_bind,
 	.of_to_plat = dm9000_of_to_plat,
 	.ops		= &dm9000_ops,
 	.priv_auto	= sizeof(struct dm9000_priv),
diff --git a/drivers/net/ftmac100.c b/drivers/net/ftmac100.c
index fa0b3dbb6d1..d9826178e82 100644
--- a/drivers/net/ftmac100.c
+++ b/drivers/net/ftmac100.c
@@ -429,11 +429,6 @@ static int ftmac100_remove(struct udevice *dev)
 	return 0;
 }
 
-static int ftmac100_bind(struct udevice *dev)
-{
-	return device_set_name(dev, dev->name);
-}
-
 static const struct eth_ops ftmac100_ops = {
 	.start	= ftmac100_start,
 	.send	= ftmac100_send,
@@ -451,7 +446,6 @@ U_BOOT_DRIVER(ftmac100) = {
 	.name	= "ftmac100",
 	.id	= UCLASS_ETH,
 	.of_match = ftmac100_ids,
-	.bind	= ftmac100_bind,
 	.of_to_plat = ftmac100_of_to_plat,
 	.probe	= ftmac100_probe,
 	.remove = ftmac100_remove,
diff --git a/drivers/net/ks8851_mll.c b/drivers/net/ks8851_mll.c
index 2c956154d09..c2f87d4222b 100644
--- a/drivers/net/ks8851_mll.c
+++ b/drivers/net/ks8851_mll.c
@@ -571,11 +571,6 @@ static int ks8851_read_rom_hwaddr(struct udevice *dev)
 	return !is_valid_ethaddr(pdata->enetaddr);
 }
 
-static int ks8851_bind(struct udevice *dev)
-{
-	return device_set_name(dev, dev->name);
-}
-
 static int ks8851_probe(struct udevice *dev)
 {
 	struct ks_net *ks = dev_get_priv(dev);
@@ -615,7 +610,6 @@ U_BOOT_DRIVER(ks8851) = {
 	.name		= "eth_ks8851",
 	.id		= UCLASS_ETH,
 	.of_match	= ks8851_ids,
-	.bind		= ks8851_bind,
 	.of_to_plat = ks8851_of_to_plat,
 	.probe		= ks8851_probe,
 	.ops		= &ks8851_ops,
diff --git a/drivers/net/smc911x.c b/drivers/net/smc911x.c
index f39ba40944f..2835eb45856 100644
--- a/drivers/net/smc911x.c
+++ b/drivers/net/smc911x.c
@@ -431,11 +431,6 @@ static int smc911x_read_rom_hwaddr(struct udevice *dev)
 	return 0;
 }
 
-static int smc911x_bind(struct udevice *dev)
-{
-	return device_set_name(dev, dev->name);
-}
-
 static int smc911x_probe(struct udevice *dev)
 {
 	struct smc911x_priv *priv = dev_get_priv(dev);
@@ -487,7 +482,6 @@ U_BOOT_DRIVER(smc911x) = {
 	.name		= "eth_smc911x",
 	.id		= UCLASS_ETH,
 	.of_match	= smc911x_ids,
-	.bind		= smc911x_bind,
 	.of_to_plat = smc911x_of_to_plat,
 	.probe		= smc911x_probe,
 	.ops		= &smc911x_ops,

---
base-commit: e800cc67f5b6cb50a20f37c993ec1cd4063bdbd3
change-id: 20260703-net-a994f2cb348f

Best regards,
--  
Peng Fan <peng.fan@nxp.com>

