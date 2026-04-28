Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB86FFF886C
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 09:03:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 358598432A;
	Tue, 28 Apr 2026 11:03:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="BIfKqJKF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2ABD845C8; Tue, 28 Apr 2026 11:03:14 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D8B884324
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 11:03:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y8S0O+OeWOE+dZwvcjgo3u+c4IbrsKSVQsqiD70GwnH3NDySpS/vT2QDUCvN62RJ2xq4YdsSTZOuLjLTlBqJPzgSPC02Bl5RRyvYzD3vdUioTyCOmTh3C4wujAV5UBgMABvLLGbab9/CE/3OA8+ONrM+WQOXZOEnpCtQ/fn866G+uZjyilLE5w+gqnYnYo6/5sS8QmYd4xG7+CnY7SNwOnhf7zPPcGa+2sXOnb/mH8SBm6RsBQdHl34c5ScQyt7EqGbmF/u14gLF8G1J4JF3mlyDLOZ9y7s0ddUPjTAnzscx4510nNLPOuUE+qdA4mHUpT0npFIV7RGkPEYlX5cyhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRnyuGW/CC+8RvTnYB0bevJ+8Aoqmo/S2DwCXaOmmw0=;
 b=rmDAQt4v4MeLo6EWOD0Vqx/MmPEUOe6EFhd/Ncu9C+s4sItcy+qlY/u++LFPRkyk1+yECkIXAjSNyCotCXx3aK+DRXqyt2KUCU6XW4g3YvGYv6rkLU0F5AxBfNN5bZ0ezlN7BkznKoQSsDa5HiPEOhb1n9Px32+9+6RRCB6Vm7hUw1YlvM0I0j3PmSPZGnZ0XKO3QbVnVhscR5YxfIP6hgn9dMIODy14xMIaAbJQdPDTPVYW+9CrMtgxW+YnIeoJ5nMwDYp52xFumD8jHqAWpV4js7yrWoeEhuXryLvgNWNqeVBDzh/zo3CY8aS+tf2R0b8/3+X/6/bPxeh+Klnm2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRnyuGW/CC+8RvTnYB0bevJ+8Aoqmo/S2DwCXaOmmw0=;
 b=BIfKqJKFPHfg/PmEl5CaUGckti7ZKtptyRz79LTSFOa18w8vbrRl1ZMjaGmc7gTAweAk0ZhfEK6qEUYx9HBFUyiW7KZ6kUlqORZGusOc1anazU4CdubsdzsG+j6BEZXbwOdftTPUoChOms+PqyAMZHuW3JAStUi+N2AV/OlLrHCg6aUbAgSe1xGuariINCKd1IzILmYkmqwEeSAFbKfrIMKC9iBD0Wfw9m8ijeAFIQ8BLWxU7cP5MVUAFoWiUAhk5Yp3X63uMKxgbuDcm+cxm94vnODixCyjFOH1CaNbunW5JLhED+hn1/dN0KQMKUhHTBt0m2fr2ZoeI2wMo0U/xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24) by DUYPR04MB12689.eurprd04.prod.outlook.com
 (2603:10a6:10:661::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 09:03:07 +0000
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029]) by AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029%6]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 09:03:07 +0000
From: Ye Li <ye.li@nxp.com>
To: festevam@gmail.com,
	u-boot@lists.denx.de
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, ping.bai@nxp.com, ye.li@oss.nxp.com
Subject: [PATCH] imx8mp_evk: Fix the ND mode VDD_SOC voltage
Date: Tue, 28 Apr 2026 17:05:17 +0800
Message-Id: <20260428090517.1808814-1-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0255.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1f1::8) To AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB12051:EE_|DUYPR04MB12689:EE_
X-MS-Office365-Filtering-Correlation-Id: 70992fc6-bd52-4395-4ef0-08dea504f704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|42112799006|376014|52116014|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info: Aavd99oz7alU8Jb2JQ8XQRgkYUUkCDT+EKtGk/MPkkORsnEH0HBlAKNzRpc1yf5KT8rDO6qeLTNyM5Hkb1elnD7aJxl8GGrRHv8OdcmVhxMGSzsxYjOLzmYJcmc7cge4BZa/3dWSxKwjT8ydROQ5atnXYgib+lyhjtUAXZJOQyDGV3a6pkp/GwIIVwLKvYOASmk5hpmooYFIwvffqm9Uu0OrtoGMSQIbZcproiLauP1cgMu+WmGkN0oPLahpS9fRS6AP2LfaZeRS+BuUyuO8QO1Bc8ir5nwoExnhaQB4FiBEyRMYOd7VtnMWzgK0Wg+iggh79bNrcW3uDhZgyGtx/p6gGZuJFy6/5m0j6NT2jv6EfxII+SxvdhdmDfnqWHvHcz25F6X3iPB6l0ZvEMblb0h1ZjceJxfowgtQfKbUblEl3F5CysNd/orW6zlbezwUD/y+ICHS3bAkfR8FisfBdFJF/6ZF2GbNraCzmoXWo2cHq+v/12Ftki0PLwbBKHAIzzTe0zpNRqHQ1Xmcs+X2gDOM3fjEFzAj+Ta331Pcl7+u9+K004DwuMOCEBZ73DENCz1Hj9gtkjm2GYNRrgl3eHSr6cDfkgIFmVanVpY505fVw+xNgCxFhgfgjzkUM//pOdy+U67esNHwtOPiBStd6sGFQkx0DmQCQCa5IaAj4O2eFJnmn/hvlO8i8UemUwuUdFnPYLVvT5cdbrpNN0VGghsNTTCLZnZlb4uytD3qTjQdXfUvQ1nx/CtHt8kAQ6ikshcJq03GLGieQTy6yTDym3QQQWwFbjzAHsRjMbh5a/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB12051.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(42112799006)(376014)(52116014)(56012099003)(18002099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tXesM4of55MuDjtxMzRAJIu10yJYcN6Y67KVH6Ttv0AX9U7HKP0tvX43VSBw?=
 =?us-ascii?Q?BRW5pcUrOFS/TKrJky8b9QR5BDJ/QUJJYMLvN3K84Z8RDmpDUhVtL//YyMCr?=
 =?us-ascii?Q?9CNmAJCK9r8lqUNmY6QHjKUObr2zVxKGZMUkVhLKhFdHO1a3xsBQc/54gD/5?=
 =?us-ascii?Q?oG0OV0dQQBrETPqGstCMV/VDG9hUyfIHTyUhxNdjHTomBZOEaufwUcj+EboJ?=
 =?us-ascii?Q?IkfwZGIFmvNFoj0wfIHLWbSGHsHGvi78vqwn6a8cKqhHICu+uPyDM8AI1u7Y?=
 =?us-ascii?Q?HOHIRVkDpbJnnhmmMLd0ZlOb3YLcY1gPbXii30Iik4xuEKsSxJv/ZNmhT+ak?=
 =?us-ascii?Q?pxdcpiSbQ7dySz7CC/PcHYpu+AwPkGIrhP3JdZGLZ9VhQ04dgcIhFMd0qnFR?=
 =?us-ascii?Q?P0uiKnCA3L4dPZ3DtAi4PZXdVQEkglC87usuitVadwndER/I2cLGY8nGTKRi?=
 =?us-ascii?Q?gQQeM1TV8g/Ynj/ZyyGo2twNbcNb3SNT9Ch6izwX1vnNua/1Grs6e5j+4Hbl?=
 =?us-ascii?Q?8GyOSIwCsP+Z3SXUsVqk5blTFYcVnlcrUmOyLE66wf/StwxK0vekCWzPBLFz?=
 =?us-ascii?Q?c//Dy5BdN2GdleiF5aOpCIcX6SXcwTj0h7sYULlK3CnTjh+iwQCZ33U97Nlj?=
 =?us-ascii?Q?4RoStIKLE/qh2vkimlTQRnbFDKz5Dsp+KllTMrbb2v33h6gL3mHk1oCrjwwp?=
 =?us-ascii?Q?Wi7Y/oXaCnQsxtiM/tZ5zJXQLbwX0yPmM0MDX/xIsamyWE9R6y0vL3i18Sb7?=
 =?us-ascii?Q?dhyyhBoxs7JwsMNvjghh4H6NxLdqToLxHuAe40jfgGZVfGOwp1E5uWBl9xf2?=
 =?us-ascii?Q?BxQzlpxVd2W+WHnTCRDHAoIOYvFNLFwEUDpdJGBffFz7ZNidPO4ZiY01jiS7?=
 =?us-ascii?Q?a3VBe8XapL8G8c9g7y4Q3imNpTfZFajP37r51GO2Dh4lWx92p9A8Fn5Q/TdN?=
 =?us-ascii?Q?hBgIZgL1vMbj5J2q90lAOU5ytMGzktxr6o/W1Ut7S8QYYMPB3AjduoHOt0HQ?=
 =?us-ascii?Q?/D6KpSGO11veBoMZyYWAihtQoYSGXYp8SrnV9bodpsRlEXUokq+VntYOscz7?=
 =?us-ascii?Q?sW2SBseZoterXBrsd1IfF+H63WNLVFJAoFgFmnFIqC/uWgg4HWmuOU3XgefY?=
 =?us-ascii?Q?2QjPAcoaZgcKzOLpXp5rpNdbOU4KmCRSlFXzKpcClMxvlWDT/EliWg0K4AKI?=
 =?us-ascii?Q?DpmcT8WFwNjVrik1C2i5eGl0sberTOk8i0g1lnHh+4EcqF6QUO1CfxjoWgdM?=
 =?us-ascii?Q?RzHDGGK3Z6GRrS8UUGw9Qggf1w6LD4qlxbWbhBt19e0Q4f0u09gix8Vpv5si?=
 =?us-ascii?Q?KXUoXbDBoOBstX2ZgFCW8LhxjpqGnUj7tD+Lo82pIrV256jyVFBrrvuLJzZn?=
 =?us-ascii?Q?dhPcUM198PHjJaWYAEHTFWIpJ0HbfWrYs5jsw8FLsnEI2fwMelrztaaSZLMC?=
 =?us-ascii?Q?p3/aRmZ+/P0hoQaP5mnwAkXK93kSXdcDItQefs4qQJSG9ArmX3KX81Db0eOs?=
 =?us-ascii?Q?rNXN/sZg8iQibGQfiY/uI+CueNXKYkbrV6iZ2WMmanRzLl/wO1rhw4dtKdp+?=
 =?us-ascii?Q?M4BKa37UZDbADHC3Lpe/dkqvtzykuPlyQI4PoFvTvRZDeQ+2RjAMEata3JQB?=
 =?us-ascii?Q?gJpoHFsoeK0ydq00hqmj66SD1ioc7MPdyenKky4qROhRzD0NKA6TfsMo6XIQ?=
 =?us-ascii?Q?glG8vbSRstBoS3KE4LBxOEq6oaZR70Y5vu3R2pzzKWbNGgkG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70992fc6-bd52-4395-4ef0-08dea504f704
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB12051.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 09:03:07.7284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDDYYJl9g0v5udF/a4E19mfootGvUhOnG9meJYpDeTWCzUX3/5rtnTlhRcQ8ovE+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUYPR04MB12689
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

From: Jacky Bai <ping.bai@nxp.com>

The 'CONFIG_IS_ENBLAED' check only works when there is a
CONFIG_SPL_IMX8M_VDD_SOC_850MV config a option is defined and enabled.
So use the 'IS_ENABLED' macro instead to fix the ND mode VDD_SOC voltage.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
---
 board/nxp/imx8mp_evk/spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/nxp/imx8mp_evk/spl.c b/board/nxp/imx8mp_evk/spl.c
index 27cd82e745a..cd7d79b382d 100644
--- a/board/nxp/imx8mp_evk/spl.c
+++ b/board/nxp/imx8mp_evk/spl.c
@@ -65,7 +65,7 @@ int power_init_board(void)
 	 * Enable DVS control through PMIC_STBY_REQ and
 	 * set B1_ENMODE=1 (ON by PMIC_ON_REQ=H)
 	 */
-	if (CONFIG_IS_ENABLED(IMX8M_VDD_SOC_850MV))
+	if (IS_ENABLED(CONFIG_IMX8M_VDD_SOC_850MV))
 		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x14);
 	else
 		pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x1C);
-- 
2.37.1

