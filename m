Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDF7C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 13:11:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6602880DB;
	Wed, 27 Mar 2024 14:11:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gySCCk9n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6C248800C; Wed, 27 Mar 2024 14:11:16 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::612])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09B10880A6
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 14:11:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9uU1juQGM7z2H+RJPZfe79GWBO8kKkDcScdWFLvi254uoj/EvsJpFoQHhmCbvPrFwYNRSYzV3eb8uA14ju88MeItLulKrUD61ByjG3ykpkSF29yrMpIK6xagbl1lLGyDe9q5jcciCzM8zklayR9NBinvxxLktTx5ByjxDNFNjkA8dNy+D9uR5fJGIG+kcE7RrkG2iroBsvMFCOmG4sue7+hQGfIr4jKyJa22A+TX63WuvI7qGDh0D9Rxz5qmp6pvJst4ktJVp7n8m4lhJrkr90DOlTgNixOjwQ3xccl1oMx17jDWmqn7VRb7XolF4HAQNzK4SZv+z4Qn3olJDqASg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3i3haQXlV3blF7oFjyEvD87LBI+PouqducUOa9tuVIU=;
 b=WdtJ7/6WwaeUIyhsVZgzuZsbUTZud3fFPzVLD6Z8sS3wV1tP1qf0X7kH+xFzSGzb8j0ImRybXLTjTMQBqFI2vB/kLdadO09dqu8Iqgi2S94C6dbanK5mB9ErOvWhEKwTw27cbziCs4augkWi3ergrNT2kpVcl2vATo7r0naSgAWmzm5NieaoPQBsEizLC0uNnBCn3ZViUcWHktV+0GRjEJxn4ldgO8arsl83qT1ATuNqYScZnfDd6xB+Rf/kkx0iZoZwE/thVvQthzn5bpAfEXBlzulkqf4zYU4SCgxtK6ulkWkvoPYygNgqwhvNIhIDQpLOlSETCKCKLZbZQZ4X0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3i3haQXlV3blF7oFjyEvD87LBI+PouqducUOa9tuVIU=;
 b=gySCCk9nXyDkr2MQAbOvX3FCsIkhW+ncnIdoBJagKY+OUTHfURa6+jV5aCzlFjw1R+c3+qZJNZq3Y2udm15/cAPr/hc89vtw58vyV03cyPGbwVT6Fg60Iu7QW2WPXySv+3zS9CEvzcuYAW663aQtkePdtbFB+KPvuVD6k9sK3aA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 13:11:13 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Wed, 27 Mar 2024
 13:11:13 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 27 Mar 2024 22:10:45 +0800
Subject: [PATCH 1/6] gpio: imx_rgpio2p: support one address
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-imx93-of-v1-1-afab6b31422a@nxp.com>
References: <20240327-imx93-of-v1-0-afab6b31422a@nxp.com>
In-Reply-To: <20240327-imx93-of-v1-0-afab6b31422a@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8536:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fd92a8d-fbb8-4389-5642-08dc4e5f60de
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: adEhQCzrmZAg3lBDyNiZmiIJNSIGgd1k2P45QCj6Gn08sWtE4xLHJ6vCk4ow6BQL+OR/pBgv6iJ1vaxFFIyJPRsKx6GUJaHcork6S52i+2qfMHJCxy6bdpZU20Tss3goiZcCGapOdNUTD+nwTcN1ddmj/7gEdND6jiYUZPh086vclpx4gY5sfayfqaLLG/t5YKoub0vfMKFGrwQ33wBh38xHgjRcz8PYgW6e1tD8U7c8rWZvgtKnA9Nj3pXBCmoYn33Y1aqp85XiVBcyItpfmi8Zypt+7Vx1pcnzr/qZQofU0bDzdRbQ47zDu1saj2aQxcpRZ9YOVXIRPNbACznp2cx1VkjonysdsMyJ8mOh55zADr09u492c4Oq9TurD0XOQaKWB3NYA04leTLuH+WyyrEDxUxygMjTrWBZ+tc9bHfsAX50iAYhwepYOAmijy7lwPNVRr3OqJJ3ww6UETGLTeKrPctM2cVeWb4Nf/Gf7Q3wuER/p5O1N53ed0AsmbjC7YvDJtBY9OSNxZBQVrQ4uqRMnXY74peXc+/KoSjhNHbPSpuM1fNBBOaL3K723p+SYhM5HX63eIk1idMFpNq1PuBCDaqsNK5KMfZndvPTvZncTmh+ET0OeUQr6Z/izgXpvseHFhW1kt/PgTxbGlxuESOyQnGx4q2FSSNmwAeCkhmc2yvwX92sBp3gN8A1J1np0IcVk7PbhWlrK7Ckc+Kp/0N1SD4Gtf09MdUN+j6F/UI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(1800799015)(366007)(376005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVlwckhDK2MxUXg4VXBCQVNUZytaTDdpbWM3TjlCSmdRMzNIRW5pakVMVWh5?=
 =?utf-8?B?M0lMYWxoQkFxMmJPbkt6dlJVVzc3dFpVcHRJWUdpZmwzMUZZVUdaSWFRdVJK?=
 =?utf-8?B?QktzV1hrNk9vV29yRW9rQVVwcE11azd5eDZYWkY1SWl5bnZkbmw3cXdsZVJu?=
 =?utf-8?B?MXRQWHVhZTJVS2xVUWw1VFZTckRaUG1UMStpMDYyQVVUSjVyanA5blhRL0x5?=
 =?utf-8?B?R1VoZEFaa2M5TlRPQTFPVEV3ZS9iQkV6WVkrT3N1M0tva3U5N1lkczlKNWFC?=
 =?utf-8?B?M1JwWGdrMnZacEdjYUxqZERab3BMNVNQMUFOeWx6SFNQTldTeWpaQTZnSlZN?=
 =?utf-8?B?Y0dSc2FLb2MvMkN3V0tZM1FFMnh0Q2NZSlM3NWEyc2xNeHVBNHR0WFJxODVu?=
 =?utf-8?B?YmdEMmFST2xtbGRyWkJ5eUpPUkVOd0IzcG1LTjVNekNTS1RjeGIxd3ZjOFIw?=
 =?utf-8?B?cVFYcjJ5aVZkYWpXR1RsS1kxRHB0T2wzbE9XTFRWQnJXTUJUZlloS1VyR1lk?=
 =?utf-8?B?U3ErZ1EzbGpvOHNsMU5uWkRJbmpUbmh1bGpJRjgyN1JQV0h6TFB3M3gwS1F4?=
 =?utf-8?B?WEV3dVdubnl4OTVmNUwvdXl6S3o5RTNiL2ZHeTBPZ1k3V0djb0cwVGx6Nk1U?=
 =?utf-8?B?SmlXeHNQY3Y2SFpTSFp3VVBVckFZWVZQZ3dDUEhrbkZWZGo4VEZyejZIQzZC?=
 =?utf-8?B?MVZkM3pySDZ5UjJraGNGZlZnNmNCYWJPbkNwdEREQzd3ZlZGa1hqSU5hMk9p?=
 =?utf-8?B?YU1SOGZyZWN2RWVDUU5ITGZRcnlIY3gwektGaTl2TjNjWkpwMStTcDJoR3J3?=
 =?utf-8?B?eHdVM25ZMlBOQzFDc0hzVi8rNFk5SzQ1eFJwZWFJMmVoUnRjWmlaZmpicXpX?=
 =?utf-8?B?TzJkMkV3Q1RiYjRaWU52Qm5KcUY3bUl3bmFDQ1NsazBFOW1GRjAyamVzVEJw?=
 =?utf-8?B?RnBkV0JpcFJrMU1GcGJJcG92Z1VDOGx2ckFpeW50NGRnUnhBNmQrZVJDZWxH?=
 =?utf-8?B?QVhRcDMxSHBEVlV5aHdBaGJUSFQxOHJYa043L1ZuZWJlTEp5Rm4yemp0Tmc1?=
 =?utf-8?B?STZKNCtSRmpQTzNyQkVXSVFlU1Z5cEtHNE04cGF3dHRKOGJJQ3liTHQ3RlFQ?=
 =?utf-8?B?d0Qzbi96eERQVjRpSlZLa1cyYVF6WlBLa252TUQ5WmRKb2IrYUZSSTdTdU1h?=
 =?utf-8?B?M0REUHBSUGF4MFlEazZkcXI4dlQxNGxwdzNrOUpTY0hiZWZOakRRWnNDc3VB?=
 =?utf-8?B?SllaZ2VhM3BhaUJHM2ZxVlVLWUNURDFjOEVJQzN4L0IxbVA5ZTRydWgzYlV3?=
 =?utf-8?B?T09CK3J0QXJuUlhXeGwzWHUwbGVram04QVMzM0RhMDl4WEtHaTl3L2RpS1d1?=
 =?utf-8?B?VXRqNjBRU1dockU0WlFKOHNlY01uWU1MUDdoQURUUTJUWS9nTmhxeHZDZDVn?=
 =?utf-8?B?Sk5HblNWTzdKVnNTVWFmb2hCbVNMdUtCbWNISllSWDJxRDROQVA5NURrZ0Jm?=
 =?utf-8?B?clc0R0NCSEM2TC9DL1RBU2hpNnpoSUJ0VjlIUDBNMTdIeFMwc1k1RExtTUhh?=
 =?utf-8?B?eWx3SWxhQytGSkM5dWxybDlhVFF6SWVqM3hhbW9kWXFCcHhVaTBPK2RpRFdv?=
 =?utf-8?B?MXFxVUU4Tk5PT3ZWQXRLVUtSby8yUUU4R1JYT3ZaQ2hYU1lTN3dQTitYenZo?=
 =?utf-8?B?bzhWN1p2TzA4VEFjUXMvc1htOHVZOGV4d1NvZ1ZUa2hJZUpJSmhLOUlrTzQz?=
 =?utf-8?B?VEMwdm9mcFFBS2x3emQ5WWhmand5U1U0c3NsNTVpQjE4eWJ0ZDRrTzdaUjI3?=
 =?utf-8?B?RGswUndjYjEwK0srejBqZUR4UVRSWjRwNWtyOGV6bktvZ2ZwbkVxNW43Wnpa?=
 =?utf-8?B?Z01QUGUrMHlLbGMzVU5wNTlQNXFGdDl2b0xRM0crbDVZSERmaTJPaDQzN3FY?=
 =?utf-8?B?TURzdlhiOHczclhGM25qUlh0Q0t2aTRmSWNTNmkvNVgrbEs3VmdCSzFXYVZN?=
 =?utf-8?B?YkMrWXFFQk5aWm9jUTA5Q2FvdEhLN3I1cTRENi94YjN1ZHpTcTNzU0F5KzV1?=
 =?utf-8?B?Q0h1YktmUDh2b3FvRWcvTVFZRmIxbldwRG1PZHZCWnlsNGU4Vmw5aWx6K3Q0?=
 =?utf-8?Q?VNIGTXjtTMa1Psc5f9T5BwRQa?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd92a8d-fbb8-4389-5642-08dc4e5f60de
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 13:11:13.4844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xyOYgoAlNwnIeyboB2WtalGtx6MkSmxZb9/lGS4+ArbOM+Eg//0Lpod041OD9idPajmLQtCRoArDXGYvFb7++w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8536
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

