Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278F6EBFD14
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 08:13:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65DCC83B99;
	Mon, 13 Apr 2026 10:13:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="v9inzxsy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D3E4841FF; Mon, 13 Apr 2026 10:13:50 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A77CB841C2
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 10:13:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdTOm4//ZDCgcLeLYxh/so/jzO9kXwZDePn3pFa0QNXfMkXGxd41JLgNFROttCASjY1LflRqaTZxOCl5+qrtFSxT+mVZCnfADeUS4v8ptsO42xA62rAb4+ENsWpCdidFwi3CiHMCNE4XGO5rHlkTl6v1VQlJXzrIzBYEkpFJ8qOf1cChI1qDUL8cW1XLO3zReu/M5tku3c28CnK0S87Dd4lghv4GjVDFvyY/Wk28BMtz8PrNZJ/1tM3hH8anF4x1HovLJuIH99vEed1s2gv7uG8zRMKAm6xgv4b+X/4+RWIVIZzVnm3glV8wgHD5m91FaEUtByba/EOLkvRa6oMlig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6RDVbr/A50BH56noEFDFUzQLRSAIvJ82l0ps4B7458=;
 b=vfAoMtgos0ZLzxC92MXcqCaJgH9hP8V82bpHkL2wOtE7JMlxWtTRI8gtRH8e+wQ2U0eUfY9j4ittYL5TjzANuMJNS2ybjsIT6DEIExu5vEwIEPowJpmjDo9eeYkTm0/ZjRfvs0GRith6FGPas8p8Z40IM1uDNCpvCkcymFFYvKsCQvaBGhyFkzzIm/3/uAknPdPs0IX+gKp2yoHz11JxIzv43sc/QHvCB+7EkbzKnm2hay/QjA8TIrSO8rYWUdNQjx2awDnr0h/WUwJin/MrKXZenktC50uNc8y0qv9Vf1ns7eYPKpnsq82yHw+fyRKTjNazAAvPrztwbUx8CRcVtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6RDVbr/A50BH56noEFDFUzQLRSAIvJ82l0ps4B7458=;
 b=v9inzxsybSm+hF78RJ8qL3n3/tL/8SakyURImPQi6fU5IsAl/HD0F8Tg1QLpaYMkismJdJL6nbOGvjunrtSE75kKoUAE+jjH5iKHxjBKZ8rMZq54Y+8b73g+s2zIeg30ASf5Z2FoHE64DF4RZ3/AwLbx+fXoOAU5zFHv1vEosbkbSITovebhz9XFLDOx65ENxP+6u71rrxzZRc+hjSr6pSHsRlM5maiPU9+IJWk0V8vxWRQ2N/Qtlqkj0BmZ3wrqdZ97dUEY0ruWAtQnwhCKAX0ll49hD1aqkRWZeqi3Tg2qwsB0oH87twlvS6jBx4bOn6LnUfST3S54RlllKIAPBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB10483.eurprd04.prod.outlook.com (2603:10a6:10:565::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 08:13:42 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 08:13:42 +0000
From: alice.guo@oss.nxp.com
Date: Mon, 13 Apr 2026 16:15:40 +0800
Subject: [PATCH v2 2/2] net: fsl_enetc: Add support for i.MX952
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-netc-v1-2-8670e5ce2d49@nxp.com>
References: <20260413-netc-v1-0-8670e5ce2d49@nxp.com>
In-Reply-To: <20260413-netc-v1-0-8670e5ce2d49@nxp.com>
To: Ye Li <ye.li@nxp.com>, Tim Harvey <tharvey@gateworks.com>, 
 Marek Vasut <marex@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Michael Walle <mwalle@kernel.org>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Heiko Thiery <heiko.thiery@gmail.com>, Clark Wang <xiaoning.wang@nxp.com>, 
 Thomas Schaefer <thomas.schaefer@kontron.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Robert Marko <robert.marko@sartura.hr>, Yao Zi <me@ziyao.cc>, 
 Peng Fan <peng.fan@nxp.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Jacky Bai <ping.bai@nxp.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SG2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:3:18::29) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB10483:EE_
X-MS-Office365-Filtering-Correlation-Id: fd8be593-118f-4ce7-b817-08de9934936a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|366016|19092799006|1800799024|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: A0ZgCR7HzdGflHkWDt+fz09PT0gxZSoliWMnuwKacynibaPZIl79PuDiD7MSYE74xPrmA4XBOpmNYnWNQfqXx5XTvXEYwmetbIFfXfna42GK7teb4sEICAfznmxZff1ghaKzuTtIyioPLKbjuS8VryWfaEzeXkKDcgcqnH+97uzP0s6mJXcGJz2+biP17mRxgfsWP8DLl7S3rhCe7GxjrO/4c92017OcDQ1D/HxwC2m2nDWZyCpSdv/hLzRYONzDpUR8gIAN8pqgYbDDLpRaIx6iyVZm+EcVrwiwh8d69pi2RRk7t4bsOYfX3GVsj4lUG5rycY4q5Z4r8LwhJ6Bd0a8CDyv6bC41md7IyahHGE3CumIvrOk+zca/tY895IlKAkVFQZbj6pIaTUCq0NzBQj7uyAu+9vyqVw23zhEHnXDORRQtCP28hmFVzBI4zoQArWd9IKqVhdrLMLzSOihSMfcC0rp++RzbkkVJ1uBTOsbTOIQRO4m+D4xgZvgj77rAtcAtZrKQSBepNxu6YBIsuwyg+GgeYhAQX9RiRdPdnAVe7CRbjqIA6bA4hWJnwRfQ0PXrKVbHkbHMIiXCJr3Y2o+Jm4r8zifAteY1ILu3hkepSNtNeJA/nrzA1pYHN8JB5bVVOkmk0F59e8rWfIMKh/MB8o/EXJGoVpx1faSn2UmuTijguoALzxiIbOhAwn2aqi22tg0BxZzRvpDAxH/7Y4PdgvsolyAgxHhl88teLiH2uphWHENrKgyyO6wUsZXcEU3+lGu4C7Zrzc+FsB3PBVgYi+bRUiuPKJDLCVtuUJ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(366016)(19092799006)(1800799024)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VElhRWdGMldNSFEwYjF5bERVbGN5bjV1SEx2WTR1RHlRSEMyakEvczJEUjY2?=
 =?utf-8?B?OW45dWlVMGZxRHZWMjVsMmM2VnQ3ejZMT3g3dWF6ZWNaY0JxWW04WUQ5a2tt?=
 =?utf-8?B?L2JZRzY1UzlBdkdraTJXVGZNekI5eGlNNStsTlkyY3NRQmJlOGZnQVFSb1BQ?=
 =?utf-8?B?SjU3MlphYmtWNWdYcUlha0FNcDlOZWt2REw0MWtNVXg3dW1zRGdHemRFYlJv?=
 =?utf-8?B?WEpqTWYxVWs2ckt0QWRtWEhMZWpuZEx6YjZOcXBUT0pwOTZZUFNMRDVZY0M1?=
 =?utf-8?B?ZHZOSFhoOUkvNkxlUTMwUGpGR0YzQXM2blltMldSc3E1anJHT050aStJRmtK?=
 =?utf-8?B?d1Z6d2E3OG1wMGc5andFeVZwdjV3ZHlhZnhoSFVubVJ3bGhCQWJ0N1VwRkpB?=
 =?utf-8?B?YW8ySlY1TTllazVlOVQvR0t2RHhEc21HSVpsSGZvQTNsTEJCbDJ2NFdnRFNv?=
 =?utf-8?B?UDRET0RBRFVFMkRhL0F3TktRU1lHWmgyZU82NmUrSUdMOWgwQkZ5TFNIOVdN?=
 =?utf-8?B?dVhxL3g0UkdQVy9VVjhSUHk3N0RpQnJ0UnBGaFVzdWtvM2Fua2ltUkovWmhK?=
 =?utf-8?B?cm1BRDBndVM2NFJqVzROOWZCTW9sVVdHMFJockpBNkpLUFNsN2IyR2lUSDA3?=
 =?utf-8?B?Y3N4QklFd1BtOGovSjlIM0t3d1hralRsWGlvRVhBdE9NZW5HZTRleDVzU0Jq?=
 =?utf-8?B?aEg3TkJRbGxMaDlzQ1RHL2hVVnNvbEdTQVFOeER6aE9QTXhqNzRzek0zaHRV?=
 =?utf-8?B?RUs2YlZ1VWxHYm1qWUFtNHQ3MzFXUjB4TWswcjRsQUMxeDJXeVpuZ2tGMEMy?=
 =?utf-8?B?V010c1h5UzhSOUFkRnRpZEZXNDdLSFlrYlV3Qm1Eek9YTFB1akNDSUhnVzJ4?=
 =?utf-8?B?RndzcWI5S1FjaFJTU3B6OU1IMmV4cTE0emdZM2w2cXBBOFFZbUY1TVlXY2t1?=
 =?utf-8?B?UVVqNkFRYWc5VGR2SFoxSTcwSnc3QkI4M0tFUkNZaVRMbzgwdFRHRjdYQXox?=
 =?utf-8?B?czEyUE40WkFxTElPRzlyTmV3VmFQLzduRTVQb0gzYjB1cUhYNHJZdDJrRElO?=
 =?utf-8?B?aVd6UGx5UE5yekp3bXpNOHVtVlYvSERmUFhpSnlnKzQ4dFJvSTBUU1ZwaDV5?=
 =?utf-8?B?RGI0OTcyRmJ4ZWc3SWs0SEp6Yk1aeFRuTlh3K2FoQ3g3SnFvU0RTV1NSUlhH?=
 =?utf-8?B?dzQxbEVmNXZ6S3dnaGZXZmVhRUgzQy9RYkp1SXNrSnBpRUlHQnFGM2g2SVov?=
 =?utf-8?B?WGNsSWNONWtFZTJCbmVCZnZpMXFaNHEwejV6L2ZpRkE3YWtWcUJoSmJML2NX?=
 =?utf-8?B?Z1AzZlNwNVpQb2NSekZudkR5RFFZUm5UM3h2alJKMy82YmlQZmNFWXNXaXRh?=
 =?utf-8?B?S25iWUdtOUVEWkZCT3liL3RleEp2Zy9ka2FXK3EvTVBqNGNjNXl3NUN3NzNO?=
 =?utf-8?B?TEcxbjFXeWZodm5HYlFObnNqZVJlcDMvbE9NK1kzVWdBN3IzM1EwVDQxVVZY?=
 =?utf-8?B?TWk4VzhhMDZpUHhGOTZZOW9FVWtQSno4S25BTFllTVI4M3Z5cmx0SkQyWlVj?=
 =?utf-8?B?VG5FZ2JpZ2VCN3FGdWRnM3IwNml5WnUyQUZ6cHd4VWlHZmw5c0IyYlJycjlq?=
 =?utf-8?B?M1RQS3FkWTN1RE1aYXFDQTlRVWNEVVFnWncrc1ozMGg5LzF5MXBwYUlBL1V2?=
 =?utf-8?B?UHJaODRNbDNqb0VQMHhvUkJlOFczWmxMS3RkMHdtVjM5TkZGVlROcFpsTk14?=
 =?utf-8?B?eUFpSWVleUwxQ2ZvQzAvREpxdUl5Wk92M3NSbXU4b0NTMDF1TDc1cTFzZ29l?=
 =?utf-8?B?TitTSWYwQXQ2UU14YmJWSG5yOUhjQXkrVG5FZDlvMnI4cFB3VVJFWjBwUkVF?=
 =?utf-8?B?V0dna3lrbDZtNDgrd2VlMFcvOThQamJjd2laQVZlVUsraWZxOFhrUkJQcWVG?=
 =?utf-8?B?TEpTRGM4c1F5aHRrdmdYYVJ5cUJackt4Z0I0Q1NEdUV5S3RHM1NCWnNnOTk3?=
 =?utf-8?B?Vm5wWElPVGhlMnBvUHoyNzdwdTBXSDJiSHUvZ2VXOE1nbGdtRWl4RFdBWmkr?=
 =?utf-8?B?MXBiaHA5OHpWcVdvY2kvRE9zK2JiSC8vMEV5QXpXUE9hSW5STWdBdlEvOU82?=
 =?utf-8?B?TkNBN29qWWtuQzR0QlVBazM5NHR4aTVEZjY1cEk3SjYzeSttbm9GcmtBeFM0?=
 =?utf-8?B?NU5sZUV1N092SExHRDB2RXBmSGRWUGszQkY2eXBLa3NvK3BSWmZUQ2NnVWpS?=
 =?utf-8?B?Q2Jha2ExMDdWZW5OakFrbW9rTUJNaExXOHU3UUFVdS94Snl0bHhVMFNBN0Z6?=
 =?utf-8?B?NVNEdGMxRzlGM09IclFhVHVzUS9GR2gzZVVTK29COGxRdWs3Um5mZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8be593-118f-4ce7-b817-08de9934936a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 08:13:42.5696 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZzO8DCd7xHaWleC8sOcdCW+ZzBmiqNCZFPXfxmofxRRYx8NVgw5yKBPo+H0ToJofWhiiCcQ0FBmPE1JMYm2Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10483
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

From: Ye Li <ye.li@nxp.com>

Extend ENETC driver to support i.MX952 platform where 2 ENETC
controllers are located on different PCIe buses.

Key changes:
- Add enetc_dev_id_imx() to derive device ID from device tree "reg"
  property for i.MX952, mapping bus_devfn values 0x0 and 0x100 to device
  IDs 0 and 1 respectively
- Implement imx952_netcmix_init() to configure MII protocol and PCS
  settings based on PHY mode parsed from device tree
- Add i.MX952 to FSL_ENETC_NETC_BLK_CTRL Kconfig dependencies

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/net/Kconfig                   |  4 +-
 drivers/net/fsl_enetc.c               | 28 +++++++++++++-
 drivers/net/fsl_enetc_netc_blk_ctrl.c | 72 +++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 3 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index ed07e286676..4da10ed1289 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -1018,8 +1018,8 @@ config FSL_ENETC
 config FSL_ENETC_NETC_BLK_CTRL
 	bool "NXP ENETC NETC blocks control driver"
 	depends on FSL_ENETC
-	depends on IMX95 || IMX94
-	default y if IMX95 || IMX94
+	depends on IMX95 || IMX94 || IMX952
+	default y if IMX95 || IMX94 || IMX952
 	help
 	  This driver configures Integrated Endpoint Register Block (IERB) and
 	  Privileged Register Block (PRB) of NETC. For i.MX platforms, it also
diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
index 766aea035d3..a1569b9d989 100644
--- a/drivers/net/fsl_enetc.c
+++ b/drivers/net/fsl_enetc.c
@@ -67,10 +67,36 @@ static int enetc_is_ls1028a(struct udevice *dev)
 	       pplat->vendor == PCI_VENDOR_ID_FREESCALE;
 }
 
+static int enetc_dev_id_imx(struct udevice *dev)
+{
+	if (IS_ENABLED(CONFIG_IMX952)) {
+		int bus_devfn;
+		u32 reg[5];
+		int error;
+
+		error = ofnode_read_u32_array(dev_ofnode(dev), "reg", reg, ARRAY_SIZE(reg));
+		if (error)
+			return error;
+
+		bus_devfn = (reg[0] >> 8) & 0xffff;
+
+		switch (bus_devfn) {
+		case 0:
+			return 0;
+		case 0x100:
+			return 1;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return PCI_DEV(pci_get_devfn(dev)) >> 3;
+}
+
 static int enetc_dev_id(struct udevice *dev)
 {
 	if (enetc_is_imx95(dev))
-		return PCI_DEV(pci_get_devfn(dev)) >> 3;
+		return enetc_dev_id_imx(dev);
 	if (enetc_is_ls1028a(dev))
 		return PCI_FUNC(pci_get_devfn(dev));
 
diff --git a/drivers/net/fsl_enetc_netc_blk_ctrl.c b/drivers/net/fsl_enetc_netc_blk_ctrl.c
index 8577bb75632..0c87d80ea5c 100644
--- a/drivers/net/fsl_enetc_netc_blk_ctrl.c
+++ b/drivers/net/fsl_enetc_netc_blk_ctrl.c
@@ -35,6 +35,7 @@
 #define  MII_PROT_RGMII			0x2
 #define  MII_PROT_SERIAL		0x3
 #define  MII_PROT(port, prot)		(((prot) & 0xf) << ((port) << 2))
+#define  MII_PROT_GET(reg, port)	(((reg) >> ((port) << 2)) & 0xf)
 
 #define IMX95_CFG_LINK_PCS_PROT(a)	(0x8 + (a) * 4)
 #define PCS_PROT_1G_SGMII		BIT(0)
@@ -97,6 +98,9 @@
 #define IMX94_TIMER1_ID			1
 #define IMX94_TIMER2_ID			2
 
+#define IMX952_ENETC0_BUS_DEVFN		0x0
+#define IMX952_ENETC1_BUS_DEVFN		0x100
+
 /* Flags for different platforms */
 #define NETC_HAS_NETCMIX		BIT(0)
 
@@ -567,6 +571,69 @@ static int netc_prb_check_error(struct netc_blk_ctrl *priv)
 	return 0;
 }
 
+static int imx952_netcmix_init(struct udevice *dev)
+{
+	struct netc_blk_ctrl *priv = dev_get_priv(dev);
+	ofnode child, gchild;
+	phy_interface_t interface;
+	int bus_devfn, mii_proto;
+	u32 val;
+
+	/* Default setting */
+	val = MII_PROT(0, MII_PROT_RGMII) | MII_PROT(1, MII_PROT_RGMII);
+
+	/* Update the link MII protocol through parsing phy-mode */
+	dev_for_each_subnode(child, dev) {
+		if (!ofnode_is_enabled(child))
+			continue;
+
+		ofnode_for_each_subnode(gchild, child) {
+			if (!ofnode_is_enabled(gchild))
+				continue;
+
+			if (!ofnode_device_is_compatible(gchild, "pci1131,e101"))
+				continue;
+
+			bus_devfn = netc_of_pci_get_bus_devfn(gchild);
+			if (bus_devfn < 0)
+				return -EINVAL;
+
+			interface = ofnode_read_phy_mode(gchild);
+			if (interface == -1)
+				continue;
+
+			mii_proto = netc_get_link_mii_protocol(interface);
+			if (mii_proto < 0)
+				return -EINVAL;
+
+			switch (bus_devfn) {
+			case IMX952_ENETC0_BUS_DEVFN:
+				val &= ~CFG_LINK_MII_PORT_0;
+				val |= FIELD_PREP(CFG_LINK_MII_PORT_0, mii_proto);
+				break;
+			case IMX952_ENETC1_BUS_DEVFN:
+				val &= ~CFG_LINK_MII_PORT_1;
+				val |= FIELD_PREP(CFG_LINK_MII_PORT_1, mii_proto);
+				break;
+			default:
+				return -EINVAL;
+			}
+		}
+	}
+
+	if (MII_PROT_GET(val, 1) == MII_PROT_SERIAL) {
+		/* Configure Link I/O variant */
+		netc_reg_write(priv->netcmix, IMX95_CFG_LINK_IO_VAR,
+			       IO_VAR(1, IO_VAR_16FF_16G_SERDES));
+		/* Configure Link 2 PCS protocol */
+		netc_reg_write(priv->netcmix, IMX95_CFG_LINK_PCS_PROT(1),
+			       PCS_PROT_2500M_SGMII);
+	}
+	netc_reg_write(priv->netcmix, IMX95_CFG_LINK_MII_PROT, val);
+
+	return 0;
+}
+
 static const struct netc_devinfo imx95_devinfo = {
 	.netcmix_init = imx95_netcmix_init,
 	.ierb_init = imx95_ierb_init,
@@ -578,9 +645,14 @@ static const struct netc_devinfo imx94_devinfo = {
 	.xpcs_port_init = imx94_netc_xpcs_port_init,
 };
 
+static const struct netc_devinfo imx952_devinfo = {
+	.netcmix_init = imx952_netcmix_init,
+};
+
 static const struct udevice_id netc_blk_ctrl_match[] = {
 	{ .compatible = "nxp,imx95-netc-blk-ctrl", .data = (ulong)&imx95_devinfo },
 	{ .compatible = "nxp,imx94-netc-blk-ctrl", .data = (ulong)&imx94_devinfo },
+	{ .compatible = "nxp,imx952-netc-blk-ctrl", .data = (ulong)&imx952_devinfo },
 	{},
 };
 

-- 
2.34.1

