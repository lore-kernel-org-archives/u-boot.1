Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262B8E7E36D
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 11:02:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E2F7840D8;
	Fri,  3 Apr 2026 13:02:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XMw68/yn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C78B840F1; Fri,  3 Apr 2026 13:02:01 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51CC7840BE
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 13:01:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCnGkFkUoH68yM5ydCNIr+rQGoZilPM4P3GgF2KrJmjyzA2SwRxwzTRvQnvA4GlcTHm2BfANPSKg2gF7g0thFfr3thJlGtktuVrUU2MFxb52r0xcKB7bFc0vFuCbI4myY8XP8R14vjL480ViIOlJIApr9N82is9YvC7AR/0kvGAF8Esp7PUJEZfFHczcWPHzKFN/8DVdZT8ux8z9qLRdxJ92J3oVvQTHjuGoDwkTQCMpF5EJr59a82jfwU9ONgWxQZWWv+iUIF/DwVx71jTUs/oJlyWeiuxSGOST7qK6bcuea3kfNNgXwLHFbkG6Lgj6azZDTjOLlds9ue20lGy8zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4PyCOxiw9ABSCDvALWidZbiivprLALahOBYh6NJQP0=;
 b=foCb0Y+stRblrVU4DqGFlNySB9ixf5h9c7LfifyB6wKuq3Xvl25NKEK01YtfFb6gs4rMZ0At5FUls5JoMHVxIzpFldOjaX7By3YjqG+IV8vNCbk9P+0Hi0xsw0bgMavOg3QVZlByJmt0qdLRoJjN4Sl+fI4yyJS5llVbMc8cHwYuU3a8zA59a1N+T3TtZiLHkg4CC/U+4oA5dNS9l2eNcGsAmWlrsP8jSe5cQGJmCSijDZ+gB6WPdDXwz+qpfpvZRJF/KuAP3nafpKxvRtwVgIiitiRSXQDXeJDll8Nn8p10BDV6N2u8Ul5DzIL9/riK6WqC0usqpuyUfZHeaW5+QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4PyCOxiw9ABSCDvALWidZbiivprLALahOBYh6NJQP0=;
 b=XMw68/yndHIubRkoOsx/74vnNMcv3X6uMr1AfTSUCmxqHaF4LSvk1S+qep6GmQ67a8YjR7j/CR71+5V8w0QScMh9/yba01vx7J11lHOZfQFOhiVo2ZwsAg/WVdgiQS977RTwaW3n3GzaBVAc6vegxJsHpXRDkn8st+HdsyIqgg/xLr/j0V0UH8vbEv6tQ280Wz4vIeY/VDNH4grok76+9Q4GV1k/QXaBD4B8NwcA4K1c0WsanmuAjVV5d3or+zf8CtY9hY+JLL1kX+3JMFNQDY6AwNvEpFKoLqxZW1XqTZrbmI8RUP/S1si+PJrR9q4FGgEGJGCpjs4ZoiwCMT45IQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7766.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Fri, 3 Apr
 2026 11:01:57 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9769.016; Fri, 3 Apr 2026
 11:01:57 +0000
From: alice.guo@oss.nxp.com
Date: Fri, 03 Apr 2026 17:41:27 +0800
Subject: [PATCH v1 2/3] net: fsl_enetc: Add support for i.MX952
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-enetc-v1-2-e42ae28ae3fe@nxp.com>
References: <20260403-enetc-v1-0-e42ae28ae3fe@nxp.com>
In-Reply-To: <20260403-enetc-v1-0-e42ae28ae3fe@nxp.com>
To: Marek Vasut <marex@nabladev.com>, Tim Harvey <tharvey@gateworks.com>, 
 Ye Li <ye.li@nxp.com>, u-boot@lists.denx.de, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, 
 Thomas Schaefer <thomas.schaefer@kontron.com>, 
 Michael Walle <mwalle@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Robert Marko <robert.marko@sartura.hr>, Yao Zi <me@ziyao.cc>, 
 Heiko Thiery <heiko.thiery@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR03CA0093.apcprd03.prod.outlook.com
 (2603:1096:4:7c::21) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: f0bf463f-3a5d-4594-23fb-08de91706c2d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|7416014|376014|52116014|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kWv89q4jtyNn1ZzFqSOg43j0lV0Puk9cOCwltuluCWNFvngke9DExU46uwMYQacFr5t93luRKnVoI8mo8bJBWGKnMH4+oTi64y+YBUoph2BdC8zneiBF6NudCYaUftXLNrsi2WIskjfBSbtmAZO7fHGNCmVymw6xL/LuMkCu2KQfxWkRhHBxC19N64h/KW+xMTfUll++OMx6IlqmSAt1+gzpyaK0cdwtdzArDFQr2fMcOYL8GRrAVIBiwVzaPKZC/27m27z0hG1OFHtypPGKIWro8hGan6bZ1N7COzIHNwULQdgNWDEyG8F4DrU9+6HADEqWT7sObLW6Mb5Mai+nLmKS+RYR1+Stske5NSwIZqYUvoi231+mLtpvyiWAxK2HMBS2BUn4g42KmSiLD/kaCFeI7upglMoPa005hvW9/Do5PuHIoWmqkl4kSAPHcX50XnRJQW+t1KqLKSRukHYX8v8rRxF/njkaqClKcmfkFu486Wbdvbf2915ltYijfLSSn33E2DNUb2IyAiJORbm5Byqp2imIGjVDnQFjAUe2k/BqGxssgp5ZBQmX2Y0fLQ6GEpOMLPm2NBBqZIe/dMk5zGp7mwKh3mOlMKU1gA18boCwyWzJZEUkIdNRlPSUubL9axeOzGbjVrYXvXCmcsimnml4vhlG9QyabhkNbSYV3kaKOHTzEeyWjA56kAeFLn3amgkWLFTOTby/zwksN87gHtAD0+pq7iwTVZv/fq6KCG4Vjg1NtAgJ2BEYa4byb7MYKf/CoVNirmQCGaqmbpaXPrsloIegzbJmCnwPlAphDIg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(52116014)(38350700014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHduRnZKMCtZeUk5ZXhiZ1poSGxYK0g1a2NNNFpNNlQrT2E1L3M4YXZGK3Nm?=
 =?utf-8?B?TVl3UHJRTEtRNk9hTUkwMFlWREhrclkwdHJmd3NxNlF0dE5mSnFKVHhIWW0y?=
 =?utf-8?B?Y2w4cU5yKzF1VDl5TDdVRXVKZ244WGpXSE1kZGVZdXI2MkpTeXNjQVkrR3lE?=
 =?utf-8?B?T0NIa0NzMUY0Q0FPM0x5M3BmVTUzd2ZNT1BwL2VsdUxwN2E1anE4TmJBWWt6?=
 =?utf-8?B?RVdsODFGSHB1aThCYkprWlRRSWNjNlVkZ2ovbnVuTUhpOTJZd2IvQllPNk1X?=
 =?utf-8?B?Z2cwMnBzWGdlM1QxR082amJnekFHZVQ3cEE5TTlZTHhjUjl0bVhBS2NCM0tx?=
 =?utf-8?B?YjQrZ2dMUFpiYUlaZ2RVRmdrcmlVMWlPSUZGeDdSWUswNHRLWS9JZWEycE5h?=
 =?utf-8?B?bXgyV3V3WUlZdHRXYmtrWkZpUlluRWRwYUlXaDcwU2djQzMzUzI3QTM3UGJM?=
 =?utf-8?B?WUgxTzhLK09FN20yTTFWNGhKRld5YWs3UW5XaXdpS0tlTVlRL3B0Tzd6Mm5v?=
 =?utf-8?B?M25qbHgwbWMyWCtsQjdtNEs5TGZub2lWa1pDaWRyTW4wS0k0QWtNK1Y0TDNQ?=
 =?utf-8?B?QmJhU0RhRW40Z1drWjZTaU8rWHdMdXFLY1IvV0ZqVm53ZnU5NUV6QysxYnVW?=
 =?utf-8?B?MEw0Qmp6RDNoM0Z6R3Y3eGJJQjRkd1RiTW5MR0NaYTZNeTlqYTlGZm5wRFdL?=
 =?utf-8?B?aGluSUdRVVlyaVJiK0pRbjdXcGlNaW1mcXR6bnpHVFlQSzJGb0ZlS1BKY2pS?=
 =?utf-8?B?VHo1elN3VEMrbXdXOCtGWUFiSFAxZ2FJWmN6OStZQzRBZDZ1Uk15WEFqVDNU?=
 =?utf-8?B?WlRPcjBTdWRmd1Y1SUUzVkU5UWZ4UTN1OGJzNkpCQzJDUlVrdDNkd3hBd0pL?=
 =?utf-8?B?OUwxbXkvUmMvN0JBc1hycmRoMFljVnpPQkwrejZqN1FWaytER0xia0x1K1Qr?=
 =?utf-8?B?Sk5zcW5NUklIUE5tTWhsRWFiRjdXV2dCNlhSNHdBTWo0YkdMNk4xOUcrSzMw?=
 =?utf-8?B?ckpvVTFGRjV6d29YdzlkM3dPaUpQSjFlYTByb3FLanFnTGZHZ3BNTGVsc0d4?=
 =?utf-8?B?bzFGTkVGbUV6OEZabHF6SDN3WHhLc1dhKzlybTQ0Zm8xQTFBZ2Z2anU1NWFV?=
 =?utf-8?B?K0JuN1BNZnNUYkowV29RMU1uZWVjeDhnbmFPRnRMMGVSRmpETjhKYUg1by9B?=
 =?utf-8?B?OG5lVEFKdEFHb3Q0VllSd1Bvay9vYzJRbG42Z1V2QVFiV21QVGk2ZHlVbDRO?=
 =?utf-8?B?TlZBRUYzZy9lZlB4Rlh0cS9uVlozdlZyRk54eFE4RVQvTFBZZjdwU0s5ZjFG?=
 =?utf-8?B?T01tdE1pSHkvb3IzeTJkLzUzNVBTT1l6bEVWRzJJZWM1Q1MwWFM4SElFc29a?=
 =?utf-8?B?NU85N0JRYmVUU2VoY1hCbHh1dk9aK3hjVVUvRXFRY29jMnE2d1lRMnQ0aSt3?=
 =?utf-8?B?K2xDSUpkbWNFWWpiRnM3bXJDanVXdkxzNEhHMlUrRjVHc21qZlJQY1Qxc08w?=
 =?utf-8?B?T200cG90WXZiKzFsUHJhd2ZOMVcwNWFkNzRqMkE1L2NwSVR2OVhJU2pDY2hY?=
 =?utf-8?B?eVo1M0ZwUUY3L1dQSzFBejRYWjZDYzJrcmNWZmNwRVF6L2pCNjQySGM0cVVh?=
 =?utf-8?B?TC8zYjl4Y1RFZHlFTUE2MHVxUkNlM0FpYlZTWC96S0M4QW0wWlhsYlJYRkVS?=
 =?utf-8?B?UmlPenZYWE00SUxxMnl2R3JpRHJ2RDBpcUJxaXJucFYvUEpUZk5oZ3RKeWI3?=
 =?utf-8?B?L3RYRTl4TTl5cVNOZ0FhZjhiQytZQ2Q2dTU2MGluVXh4cWljRDVOZjdJYUEy?=
 =?utf-8?B?aFZ2OEJBVjhjam0yVG1GOVlOWU1rb25XQ2J5bFRvSHB6S3VrQmV0NzhzMGZG?=
 =?utf-8?B?NHhZQlRHVEpBcW1zQmRmNkVsT2dKT21UUUNkMHpyWVFYcllxeVdjaGQ2V3N6?=
 =?utf-8?B?V0M1emxlRGhyR1RFVXVxcytsclczci9zL0VrTnRob3ArdDZhbkRpbEFwY01V?=
 =?utf-8?B?Q0RDbnBpQi9KWnRTRUQzczU2amhnVUdiK08zNVBOeDRDM0tXOEZOenhKSHJ0?=
 =?utf-8?B?dGQ4dTh1Sk5saGN4N1drZFltcERRcEQwQUM2UTEwY21VWTU2bGh2ZllKZmhE?=
 =?utf-8?B?RW9tVG1TdEMxUUM1T3BiclZTZ09XT2FqZ0pWM1c3YWllNnVXRWFMM2Rib1li?=
 =?utf-8?B?cHpxSWF4ajhoNUdMdzNSa0hmM1ZxdHg5RnNCaTQvZktiTDMwempYM1hMVmpp?=
 =?utf-8?B?dXFQdUViTWtYRWFoZEd0d082MXBBNGwwOWRoVTFYM1BPcEJ2RHkzaEl1OGNJ?=
 =?utf-8?B?MWlZNW5lak8xOEswbGJaN1ZaQndhTG5SdkNVQm5DdmpBbVhrbjN5QT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0bf463f-3a5d-4594-23fb-08de91706c2d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 11:01:57.1584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfyvxUBMTUvNaxCNjdwa7bwrCYTwwYXNqa1BVpxDG0ZKLaoHXsho2WVGtGi/7wN5ZqVzGWcU/8eh+dyIHHG/xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7766
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
2.43.0

