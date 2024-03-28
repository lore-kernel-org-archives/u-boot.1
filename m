Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCD1C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 23:53:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6474B88125;
	Thu, 28 Mar 2024 00:53:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WyoXuUFn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67CB188124; Thu, 28 Mar 2024 00:53:28 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::611])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 906D987D2E
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 00:53:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrMM55avL3CmsUfs1k1gsPLuEL3InQESgrnk2edlA5EeCiDKa6UsOK4lk+VtJcMbVH1Yva8ZGqToWczOoH7rbrV7r3pDkw4CIx1UCb6IhzZTfHYGawm2YGhYDWjv9XnYRHEiMIQyQJZYRpw/WhoBheT2KjHWzYTXpSUO85Zarh5pi4M785RFDS5SCg5wGtdyNUhjDMVVKgVLzFTBs91lbyrAczFSLfed31YsFo0dLrS+3AkK1LR1YWpFqs+p0YkkDcn6Aoii+O8XeA1V2ha4VEFNWHQdEG4utpFKaYPScA/JgkGIOz2Vo5/fy8lK7EbiaqWNQenB9OjJk0zrwGvBng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3i3haQXlV3blF7oFjyEvD87LBI+PouqducUOa9tuVIU=;
 b=RDCMfofJZ5fiXAd22ccCHFsrRVQ8+3Si1SLWyxe3rbMSXuSaQfmMpxgTM1ygUc0/kektosEbm1Cc2xkvRIEAfHi234K4ZjrgEG9dJB41QxUSjgeP67EWP6Avvtw/tRVxtwkI1Ow15sRVvJXORmmYgbckA+iP2PeBRRZwzy9raU3fUnIgYX78lS43izT32jyQJWpLZ+wHRnNHuQer4Enhz5qVO/9I0k2pFTUkViJmBL655hmhwbW3Mcm5YBfXFE6WOchAzPo5JHEpBVO9+wd1Z8b05I5BSHCJxRD+8SAQH+36v/nLRpRZvr5SC3FLuBByL0gQSRKgJfZR004BHh+p2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3i3haQXlV3blF7oFjyEvD87LBI+PouqducUOa9tuVIU=;
 b=WyoXuUFnjgtymqvwk6Af9r1d9kikcszQbiQgF9SF95ZQUGE77P/92RCArwIF97b9eCuV/A+hojGJ+ePSX3l8cmgtbCBSS/eNQNo/FToJDYO6AMlavmrFFcfQJQtf8hHIKPs9QMx8UgMBoFoN2BDRjgaFY+HBAU2Ct0kOLIabXyI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DUZPR04MB10064.eurprd04.prod.outlook.com (2603:10a6:10:4d3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 23:53:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Wed, 27 Mar 2024
 23:53:25 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 28 Mar 2024 08:52:58 +0800
Subject: [PATCH v3 1/6] gpio: imx_rgpio2p: support one address
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-imx93-of-v3-1-4e7f341ed7ea@nxp.com>
References: <20240328-imx93-of-v3-0-4e7f341ed7ea@nxp.com>
In-Reply-To: <20240328-imx93-of-v3-0-4e7f341ed7ea@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SG3P274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::33)
 To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DUZPR04MB10064:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dd5a139-2868-4cdc-4e9a-08dc4eb91796
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mxfGI3TlfHArD5oodB/jJ1//LDzFDMadk4BPGaoXeZ1IKzqPYmwFLPVpzAPNpmxGwpkfxShwtrly38scCLMUS0tQCqLvIZvFtyVy+7kgMhMGaRnHZgWYoR9WaA2pmpc6Sm1YG7htPaniwbj9CsfNmiD3fQaHSGdXqgPOt33/jpwPqhtQUvyqIuFoBLN6QVNKfs9Yu11ULRUz8lwadBXCZLZdZ51czDeVK/Egf3+s70Bf+S/ZkX74cYjJCZnzVBedaJyZ0pLVSPFIcBgu9vrsXAmN6C/xOaOQn4lsi3Ud/RixUyLvNXugW6jIiLGgAtciMEEzkOQ9vrIf/+FI8RZOr7Cgh0YRjXjC4TKgs/m737i7sNiCX8tcznTSg8r8nYcXPkdyPaVsnKMWPHdST9sZW8bpzzbzfnWYKrhAKKmw12454RqAWZrufzpRBos1DECjbmpsjfftLDVmWhNJhbouB6lNaSx9Lp247RMb8yHZSyJnSOPLJ5pzlUtgireZ0jYZM05I4wnilQr3u8IWyjbf9MDI86HYjeOYGo8AXYKAo+87FCgI/Uiqo/DvJwSTVfh0gSNJna2jSGSVicH82kfIrZSRSo3vpKmGL82OXJliGeaOLpdcJ+3c2a/Xi8E1J/uwl+OWsrE1JKgQVneES0cCSjIFEpqvYLJG99hSyla+skYqYYDas9QkJi8Yu7ij4i5IJ1ay9ymhjKRbdLtLBlIR3SVS8zraRbW9jkfvJ72/Xt8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUpJRjA1Szhxd2VTcC9Vek43M1lsN2hEQlNGRmhkbS9XOCtFK01PdVR1NnNs?=
 =?utf-8?B?RGV6Z2hEQXBhWmZJVnQwN0lhMWV3dFQ0cVNWaHVKaHJaWXpWLzNNdkN1aTgv?=
 =?utf-8?B?dUZMb2dxSGxZTVpZVTBKRTAvOWxFRnNDcDZOQ3VLYk1aWTBHWnpuTkRvQjkz?=
 =?utf-8?B?RUZtOWVzaXJFOGpjUC85TjVvVldNNVpIYjIwMS9WcGFac2hUVTVLMUdQb3E3?=
 =?utf-8?B?Z0lxK2I2K1JYeEJBazZMdlowZzJLTmdTNkZTRW1nRmg2M3RDTi9NeXUvMnlv?=
 =?utf-8?B?cm1wWmhLNG5uYklWSWN2T2g1M0I3TTJsNWoyMk94NXlpbkhxb241QnE4ODY3?=
 =?utf-8?B?aGQ5K0o5ejF0Wi9NeEQ5NVpLejlFY2tnMUNaK3BWWGdKRGZMRzB3VytvaWtr?=
 =?utf-8?B?MDJkTWRPUmVja2xtWC9ZN0JxODNWSDAvTGdhTkl1K3hyMHJoL1orb283Wldn?=
 =?utf-8?B?RGt5bmZvWThxSDBvcUdTWVVsWXBXT3F4d2VCNlp0a2tnK1FVMW5pVVQ5U2p3?=
 =?utf-8?B?QkNrQjcrbEpKTy9jWHVyNUhzdjVoV2lRSStpV1ZQYW9DdUNIcm5XOFVLeExI?=
 =?utf-8?B?cmFTYkMyTkRPMUV5WDdPVDR3clgxdDJMTjBBekdQcnIzbXFlMHZ5eWo2enRz?=
 =?utf-8?B?U3FMSENqSXFMdk9CUC9JdXMzdTRuS0VmcmdCVjJDQXNkbi9RWWJ2TklsMzlR?=
 =?utf-8?B?VFk0S1k0eVpOVnVkMWRudmVtZ3kwd21JYVlSYlRYaFoxaGtRc3c5Sng3VXk5?=
 =?utf-8?B?b0F4NGFuVWVYM3FFcTVWNk5RTVNTQWg0RWxiSUQvbGxwTzBJb0FBRWp5Q2xz?=
 =?utf-8?B?d0dQWVZ1SXc3VDNkTE83azVhZ0p0WFBBQXVBQkFraE10cnRuTGlpVEFCZDJH?=
 =?utf-8?B?UmN5V0lMckdOSzJDVFlwejNQQjQ1VG5zek9DVWtGQTdmT0hUaTFDU0V0anVW?=
 =?utf-8?B?Ly9rbWRaaGw1b0d3aGd5OVBoRGhvR0JKaGFqb1FPS1VIb2tSZGh1TFF5Y0Ja?=
 =?utf-8?B?L2ltUklzNjQ0a0MyVm5MNWtpMFVIS2YxZjVIT3EyQ2dhaGhpcDZwdnpZZytB?=
 =?utf-8?B?dmZoL2hTaWp6R3VkTWUvSkVxWmhmYTU1MmRERi9pUitHRVY0TVNJU2t5Ymxh?=
 =?utf-8?B?MXBXT2Z1YWVJV29mSWYxcmgrUmEyMGR0eTdZbS8rMWk0QlNSVFJZWVU4R09E?=
 =?utf-8?B?bnl5TWZaYTVUN0IzYnk3YUJiYnBzcGdQQkhCQ2dKOW96dTlTUThram5BUjNO?=
 =?utf-8?B?M1lBaXFlS0JnbFZnWDZRVW5ROVNNcVM1b2pHc0Yxb3VMTFpsYUhVUkRBUWhP?=
 =?utf-8?B?ajRzRUErMFdmcm5KcWpmWms2MWFqLzQ3aE1VZWU2T1JhNUZrWlFmVXBJaHFk?=
 =?utf-8?B?RjY5VzlHTWlVVTZKbmhoN01PSGZsOU9BK3N0NlJ5WlRwSisrNUNhMk0rU3JS?=
 =?utf-8?B?YVg3ZzRiOWJKaEw0YTVLb2VIN21aT3BuYzhxOHZiOVFKanBWM3ovenMrNlFF?=
 =?utf-8?B?UFpyMWZQek1RZjhmbys3SkJpUC9rWG4vZFpPcjdxNXl1TTRlQXFhS05XZTNC?=
 =?utf-8?B?WVBPQjZKTlRodi9NME9qMHRtVzhCQ3RYUE9UUlRzNDdMQU9yV2hSYkV5ZmJr?=
 =?utf-8?B?aCt0OFREdWM1QVpnU2xYVEFHRDk0cGZmakpyeTdWeVJEeGR5K1YyRmVKeDBN?=
 =?utf-8?B?MDhTdGJwT2N1V0Q1dkh3TWVVek52dC9JZWdzaFF1TjhrWlVpOUxtSVNpSmFz?=
 =?utf-8?B?YUJKbEpKTC9xby9Meis3aFZOOU10WVJMeEhjN1FWeTZjTUtPcjFuOGpXb3BE?=
 =?utf-8?B?dFpNem91eXVHMTdvSU1yUVgvTzMybnpvdHFNSE01aGZ2N2gwUDhCYXZWRW83?=
 =?utf-8?B?WnFVZlRtMXFhZXgrSnJXNkdMSkw4d3NOekVUTDNQZVc4WVErRlI1RDlsdjAy?=
 =?utf-8?B?U2JOYzVJYjJzTk0zc09tM1pEYm1IYzFwRU5ZVmNRVlkrVXhsSm50UlFWMkY2?=
 =?utf-8?B?Q2wrL2NNTVAydkc5ZUJycjFnK0p3N0U3aGVKYTN6WDlpaTFDZ0lkRFQxUC9X?=
 =?utf-8?B?MnJuQVE3d29DSlNhZytyVTMzWWx2ZkppZ0M5KzdrMHIyTXdmVm5SOWJmblVm?=
 =?utf-8?Q?J2Nd2kalG5gMbTSuDqjdcl4AN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dd5a139-2868-4cdc-4e9a-08dc4eb91796
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 23:53:25.3339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FR64xP0vLKoMmYtb6FEK9CZ1JxFdnr6Cu6JyWAcNZiVP1YfAdVH7KPA1WVguXnJdgs4KoK0dYFDJ0vw9ZTENYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10064
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

