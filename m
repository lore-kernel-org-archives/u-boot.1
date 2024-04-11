Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F167FCD1292
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 03:23:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AE76881DC;
	Thu, 11 Apr 2024 05:23:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EbyW8aYH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72E88881CE; Thu, 11 Apr 2024 05:23:06 +0200 (CEST)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F04687F70
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 05:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtTCyvzzS4zs+8n+TRPihqIZTz1MQanfJQ5wqyCa7pl0VgQhwtjFSbKosgkosrYJ5OLKzL+pXNzlU/hNEeXnN5oqdxKvVMEG4COvE7GFPHk+MYtnO+zblK3VQDg0311Yj0JfH+Dc9/aoxv5Bsqx/Un5uYLL/xHByw0rW6kufm2y7ve9YMcZhD71jHWrhDfzdseBcDn9t3WzKj7rdG38EYC2N2w7o2cPlbsbXvax1z9cFm93Xi0EDEB0OVvL+aZyod5ekgP/gd4pZklbXpMSEcNszKDX8Ly214pO0QVvC1rcv810nFMrG/s4SO14XpSSIk7udA/mMNV/hT62uzC+kCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3i3haQXlV3blF7oFjyEvD87LBI+PouqducUOa9tuVIU=;
 b=HKIkqbSSzc7uwNFCR2oX6goZZmxj/ZZy2qBPOk3Nt+vG9wRNV74Q4hZLtA2QbIsquNSyNrcsr6z+AEtahhk9uZFSAC6DKZfyw0MtDKZpp1ndHXx+ZkxOSTUsj7U04wmDPgexGtao7oiCct3Og6n/oTkAfRyqMZ2QPIQC4qSbbMhVmW+pM59EqkqIHnB/G1SecIxAk2oSRIvKv6v4COQLrZ7gJdF2XuqAmR6UL3ZWQybQIGrzJ+G4Js1PCyrgBm+OgfrJx+pgusN1vnldVjblyiWQOFxCO1DlYuqOO/zssXmh+h/tja8cxAUYa7bVvnHnnFm3D07gmSTFV866NApgLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3i3haQXlV3blF7oFjyEvD87LBI+PouqducUOa9tuVIU=;
 b=EbyW8aYHTf4LBQl5qw8Ibax/hiV5KWoK5y34AzUGaJsSpuQDdK9ZTc/kkko5GZEOAUDC4wDoAZCPaJucDuf3HAC9hDrwKDOEsoA5E3rEXSOvYOwQ9b1kA07WSxbyYoGy5Z4x08xRrBBT8r/KsymrB/7/ricfI56sSE1dp4aRRAI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7951.eurprd04.prod.outlook.com (2603:10a6:102:ca::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 11 Apr
 2024 03:23:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Thu, 11 Apr 2024
 03:23:03 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 11 Apr 2024 12:22:59 +0800
Subject: [PATCH v5 1/5] gpio: imx_rgpio2p: support one address
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-imx93-of-v2-v5-1-9eb3c64ff160@nxp.com>
References: <20240411-imx93-of-v2-v5-0-9eb3c64ff160@nxp.com>
In-Reply-To: <20240411-imx93-of-v2-v5-0-9eb3c64ff160@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB7951:EE_
X-MS-Office365-Filtering-Correlation-Id: b72f64bd-4d75-4a05-57a3-08dc59d6b243
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QptFJ8Uia91Y7aFzsqzSA745mxHQtkPtDCHKoGt3yk60BtwvHct8KmwzcSoOBcZ76X0PO5qBL3NcsDN5FDFAJ/zbSp4h/+n2MoEcI8SJEQL2aPfCDc0uCYKVZdnwFgNtZMxpvOw9Gy2NsgmYL+EE1YUmXkTvb6U2GNXs3C0BvSsEQ8heMMm4uBtvRfpoELUM6cBRZwlgDKGSsCtB8g430A+GNmS5y050V6U/65QpG/l1DHkitX6YbXs1PGZ6jeNGW23dowiRaM/qg8sDOBxzgMBElEJyJRfaMeUDk1xGuhBLzajHqfFvpGCjc+cY3i+STiD5PtVrF45LV1zPraCNbG41cldS1AbfsbCscaABPwDeyok1NZCypGRaYdMEmeAbq08NxzMWnmriqgMBYa+tdLVy+EiV6+iDL2BOMPIsJalLJaMQQuwspHXPnlvgHng1kqgTg4BwdqO1EWFZ99JC8McAQZoKKSoPjkTY7/li9YGk4LHwp/IvfVCrwFETQrEmv2fgAyfdVyai99zRVa6FzHSx4Tdgzjn0MT8c5aY2iDrXcn9qpHtoUmDZgcAbhTGbjdPEkkjSxXMLCtFK27AhH84b193Mv3zoimlRbPrwuo3ASPLSASjUB4xhYG0uYc+4lc69zMquzWzL5lxEpeWfj3oCh+nJJfYKT8Gj3DPSY5Cp3eSrIAEslGKZU6mZ2IPU871bPpNT6MaYqak7OAX6ccyk768VMG2OOuvHFil247k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(376005)(366007)(1800799015)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjNHY1ZaejZEUGRxQzdvKzBReWlxY0svUU5qWURPNU9lUytqVEZwTzY0STN4?=
 =?utf-8?B?S0Rwb3NpYm80SHhLNXdrSVBEcXdHb0MzWHJ4QXZFNnM5MW1sdzBzaEQ0NXRZ?=
 =?utf-8?B?UWtvOEZaU1F0aTFzSGRBOW9Eb01Jbkg3VmVGaEVCR1dPL3dSaTFKNkVyalo0?=
 =?utf-8?B?aXBvOUp5angrTmlORENNK0FCVmhnSWovME1ScmZvb240TGxrb1JCREJpdVZB?=
 =?utf-8?B?ODVGbWFwNmNzKy9QRmZ6Q2s0N2tvR0phbG5RZnN5enV4bytvV1oyTG94R3Nj?=
 =?utf-8?B?R1hhdGNFak1DU0VCK0JnTTh4WFF1YjIrNE1tUkdFL1BOcnJad2hKNTNFdHYx?=
 =?utf-8?B?M3pwTi9USXdBdFlwUDg2Rjg1cTEvUks5WHpBdUtKWFRhUGJIaCtmdjNsaHlp?=
 =?utf-8?B?MW5EeFNYcEhNMm92eEgvbmNCM2Y1UTdyendDYkpnMEhMV0dsWmxqVTFQQkhG?=
 =?utf-8?B?MVZDdVpheDRuQWR6cE9uOE0rejRnQkw0QmZpaFZRSmhBUWdueWplak40TW9Y?=
 =?utf-8?B?VjlIbnhmZGlVTDRTd281bzB2dHdsVGViUEJqeFdjUUQzdWJSYXZ6QVpaaVJF?=
 =?utf-8?B?ZDlDa2FPQ0F5cGRHT1RGUHhZNUpIZ0VIMS9EQUwxSTBOUlJrYXJHZUN4Qmgr?=
 =?utf-8?B?bWkyT2RkY3FSdm92NUUwNGd5ZmhRVkptRTAyaUt2MTZ4aHdTVjF4ZWwxcFVE?=
 =?utf-8?B?Z1czZXY1OW0xbkpIRVk1aFJGVElTYVVhVUU2bTBQMGpFSzlZTkFQcCttSUxM?=
 =?utf-8?B?dTZsL0o0eGg1RHArL1ZOM1VjUzRVYTlFeUlOcGpwbVZYNjJTdjFzVE9NZ2Uw?=
 =?utf-8?B?Q3JMbG1hZDdRbVNpTVhkSFVsTWg0QS8zVUNtVjN3NDFpMkRVeTJzSVZ2bk9a?=
 =?utf-8?B?eVBNY3hhWXZZa0Q1M3VVVmpDVkk5M25qbE83dE5QNzcxeXJZL0c1Qm1NK2d6?=
 =?utf-8?B?Yjl5S0xLcU54MDVldkVOb3VOTEN3M3JBTlJvYUhSc2VUYXZEYmp6RHExbEJa?=
 =?utf-8?B?UEJwVlQrWGFJR0FPVjlWRnVKMU1tNUFabTF4dU81Y2VCVjNoNyt5b2VLZG9M?=
 =?utf-8?B?RlhsMGU4RkdCYnljL2lXdnM1a204OFplaEU1ZGV0Q0xCZ0FrU2o5VGJ2eFlX?=
 =?utf-8?B?TlFOWDNmVUxJc00rUVdIQWFobXBQODc5eENTSnpLS21DNEx4cXhaZW1Db0VV?=
 =?utf-8?B?RDVnUjBGdWM3QkU1R3FHeEYra0Y5VUFuN21XemR3Q0k2aGhidWszaks2MXlr?=
 =?utf-8?B?TnAycSs0WG0vQlZ3YjlKQ3p2STZsOWhZV0lzK2lGMzNYK3ZXdktlUW1NQnJj?=
 =?utf-8?B?bTVNUHRpdXA5RFpRUmtGdjEyeHlGWTVwb0hldnlJaUczUjA0bHZQMXBKb2xP?=
 =?utf-8?B?S3pEazI0K2VuRytMMVdRQkwwOTJKaFNDRHZWbUwxVFovNlE1RmM3YkFxdlla?=
 =?utf-8?B?SGJab3F4Q1lYT3ZJS0F1UmovWUJBaUpjdWl3UTVJUEhVR3pKbElDS0xkN2xm?=
 =?utf-8?B?RjNIRVFuVWkzdXM5UUc0NFRDUEVIVzdZT1ByT2thS284M1lWZWRtRTJEN25m?=
 =?utf-8?B?WUdrY3l6WlM3QnA1MWg4VG5DM3cxVi9jL0JjL2RxSDZyZ1pCTEhTQ1oyU0di?=
 =?utf-8?B?UUtsd3B5SS9iakVXYjZnWE1kZGtJdnBmMjE0SnYyUnFrTGVrbTE2UmNKM3kw?=
 =?utf-8?B?VngxbjZ5eThEUXZCN04yK2dPVTFoVnF1U3NhNmorQ0xRc3pPcVlUWi9GYWhE?=
 =?utf-8?B?Y29Iblk2R001M2cyQUpVeXNOZG1yN1MweEF0YzBxUXhRNlVKTStQL1U3WjZt?=
 =?utf-8?B?VmZ6aXJZdy9kK0ZvRE5Fbk92Z0UzYnFOMlhSRlBRa2U1NUx0bW1UdDlaR2RM?=
 =?utf-8?B?Vy8vbURXdERwS0pRc3hsTHlxZ0RNS1M5YlRJTWNtclAxSUJSanBhTW1FOG9s?=
 =?utf-8?B?ejBWWTJIekpHUlRlL0pleEFhWUJWSjVRbmxyeHVpOVpWTDhCOFJvNkdtNmhz?=
 =?utf-8?B?cWdiZU9reWZ4ZXhaazFpNGdKUmJpUTEzUlRJdmxRRWdGQjVqWURUU1cxY2VK?=
 =?utf-8?B?bTZDN0JSblRwV1dkQml5TDlIYzQybjZFZEdyblhTamVZL2RjeURXTks4WDNE?=
 =?utf-8?Q?CymE7whTSk2lQ7FLz/IbkX3Z9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b72f64bd-4d75-4a05-57a3-08dc59d6b243
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 03:23:02.9636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/xIjtE03OKNW0tkm4RanEW2TWl/sF6Fri/U4KRQXMN20HbHQYrcOUsleWmX4+A6v9LfwaAf/P8H5DeKlRrvMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7951
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

The i.MX8ULP/93 gpio dt-schema have been updated to only have one
address entry, update the driver to support it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/gpio/imx_rgpio2p.c | 42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/imx_rgpio2p.c b/drivers/gpio/imx_rgpio2p.c
index 175e460aff5..3227a8d5b57 100644
--- a/drivers/gpio/imx_rgpio2p.c
+++ b/drivers/gpio/imx_rgpio2p.c
@@ -21,6 +21,12 @@ enum imx_rgpio2p_direction {
 
 #define GPIO_PER_BANK			32
 
+struct imx_rgpio2p_soc_data {
+	bool have_dual_base;
+};
+
+#define IMX8ULP_GPIO_BASE_OFF	0x40
+
 struct imx_rgpio2p_data {
 	struct gpio_regs *regs;
 };
@@ -165,6 +171,9 @@ static int imx_rgpio2p_probe(struct udevice *dev)
 static int imx_rgpio2p_bind(struct udevice *dev)
 {
 	struct imx_rgpio2p_plat *plat = dev_get_plat(dev);
+	struct imx_rgpio2p_soc_data *data =
+		(struct imx_rgpio2p_soc_data *)dev_get_driver_data(dev);
+	bool dual_base = data->have_dual_base;
 	fdt_addr_t addr;
 
 	/*
@@ -176,9 +185,26 @@ static int imx_rgpio2p_bind(struct udevice *dev)
 	if (plat)
 		return 0;
 
-	addr = devfdt_get_addr_index(dev, 1);
-	if (addr == FDT_ADDR_T_NONE)
-		return -EINVAL;
+	/*
+	 * Handle legacy compatible combinations which used two reg values
+	 * for the i.MX8ULP and i.MX93.
+	 */
+	if (device_is_compatible(dev, "fsl,imx7ulp-gpio") &&
+	    (device_is_compatible(dev, "fsl,imx93-gpio") ||
+	    (device_is_compatible(dev, "fsl,imx8ulp-gpio"))))
+		dual_base = true;
+
+	if (dual_base) {
+		addr = devfdt_get_addr_index(dev, 1);
+		if (addr == FDT_ADDR_T_NONE)
+			return -EINVAL;
+	} else {
+		addr = devfdt_get_addr_index(dev, 0);
+		if (addr == FDT_ADDR_T_NONE)
+			return -EINVAL;
+
+		addr += IMX8ULP_GPIO_BASE_OFF;
+	}
 
 	/*
 	 * TODO:
@@ -202,9 +228,17 @@ static int imx_rgpio2p_bind(struct udevice *dev)
 	return 0;
 }
 
+static struct imx_rgpio2p_soc_data imx7ulp_data = {
+	.have_dual_base = true,
+};
+
+static struct imx_rgpio2p_soc_data imx8ulp_data = {
+	.have_dual_base = false,
+};
 
 static const struct udevice_id imx_rgpio2p_ids[] = {
-	{ .compatible = "fsl,imx7ulp-gpio" },
+	{ .compatible = "fsl,imx7ulp-gpio", .data = (ulong)&imx7ulp_data },
+	{ .compatible = "fsl,imx8ulp-gpio", .data = (ulong)&imx8ulp_data },
 	{ }
 };
 

-- 
2.35.3

