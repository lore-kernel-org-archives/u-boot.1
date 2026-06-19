Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E091CD4F26
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 14:49:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22A1184A2C;
	Fri, 19 Jun 2026 16:49:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Fvgi42+9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9C5E84A30; Fri, 19 Jun 2026 16:49:39 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA2C4849CA
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 16:49:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hB0gNCBw8WQs04wDwgq3LUTKvsbOsXZPVYI0xJHdRRwkN4rv11N49wBylyj2dMW1HQX8qkUEvsCvNz9guhb+RyCf8QGeWrjRVZfKREwLrmqtHCoyhPG3BA1VGRRKZUMx7kR1mOOT86EpisswcMZyrHRVAVZlUgsMVBQ34+Jgibe7RNe8V1dLUY9da+ZWBpiOigrU9euBSIUKg9JIAV7+vLI//AGP8DL6KGiZuG9SmJEuJLIrV7RtJyFTOnRq6fdgI0p6Mj3B4j4vdty47b1K434UGrbRkUy46p7vmb5wM9KnMujaY2FFcsxUYpQUY3vbAx/x6KgGQBYv0dbeO2I56Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cMqUDhJX2MlBdkrrxFpCJCpsPXeME9OMtGDHKqJT+E=;
 b=rOP/+Uej8EnYd9bhCqNiHaKm3U/u43a53OtXFTgcYE4XKaTOvcLL5iZAfhJP/K1bnac17YAGKL7oZ8Xha4xm4fxXOMV/Mw9cMJfAUU0lFyowZRcsVlJnV84+b0ohwkclutPF1T2aEw4KfSKnQLkE3W8GOo5xkQOKOCqJRhuDW9azj1i86/iCCxPu9zhYHIyEelNXyAaU2Mg44Y5TsTDrOxqcrSLBBBsCyWgTb1RAAWmOg1vr876v5j7cKVBGfrUKuu62W5sPGzvPXywt2ryV7GkiQ1t2G0+KDjSY5RpXrHfR5TR/yu5gQvjwGVa1AAd0xzJZC/N/G2qsxc8a7iSZYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cMqUDhJX2MlBdkrrxFpCJCpsPXeME9OMtGDHKqJT+E=;
 b=Fvgi42+9UXvXImInZu7fktkrbXhW0TgBAs3fzuxV/uEYycyubpI/iRzLBYwFzZNfkihkDSpPQ45Hortd16KMxJrXe7azpf4d0AMtJNfEAEbb0LQoxOrRc/POFjCjs1Ezw10g9zoTwOJ39jB491IV7qYqvvLd8Lvlu+Diy521zRjnqgULFyNm2MAhKVY21vzgOcx8PVDLK+5spUhd9QSbZjImI+qqBpN6dvJQCC6bt+7AKlrOoMDRr2yJIK4fGjBexYUdvZF5c6pwYbNHMVRLoHG6H1W051OiDJVrJ9+5KNeuolFsC4c0Z6TrMssX6KLuRiC6uXltPnnWkoYPu1/H3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GV2PR04MB11827.eurprd04.prod.outlook.com (2603:10a6:150:2d6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Fri, 19 Jun
 2026 14:49:36 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 14:49:36 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 20 Jun 2026 00:06:07 +0800
Subject: [PATCH 5/6] imx95/952/94_evk/: enable booting Image.gz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-imx-gz-boot-v1-5-143c60a572b7@nxp.com>
References: <20260620-imx-gz-boot-v1-0-143c60a572b7@nxp.com>
In-Reply-To: <20260620-imx-gz-boot-v1-0-143c60a572b7@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>
Cc: Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GV2PR04MB11827:EE_
X-MS-Office365-Filtering-Correlation-Id: edb713e5-a9a8-431e-1d3d-08dece11fb4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|19092799006|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: CZFcS48AESL9VqwUzowbhul+1NsQFVJjJ8Um3Q/5yTaHv/K2asSwqKozf4r5NSchVdqMgu4mpNxr970e3C5Q3nuORoiIWFbSl1c7sL1P1BrTBkYEVgcL0aD+h4i2Z8uwhC5fNEqEY1Ey5yN/IHo05BbT6oHTIiBhORFQzi9zkNph32gAWKCHPxZVrDnMdVJLu3gcosQcjy/epBXLVnCRIAws4Hwg+R0/iHRjosw04aO+hdq+xiaidW02XDkKfiS2+Z6/4j6PUmVmRFPrwHb++d5vl/dJubSlFyraTLwMRJ6DQVSYi61gUAlIntVPaTJZw6M63PuFPiKVkI6s7wCvhRuIkYDcawtXB6zEvjBfnHSKRXnU40IIjSJj+qpfhezrfweL6tztSSD+WUx7zomomW0BYysnmBhyRuPM50XoLl/lV7WVMYicwCAxkySpXybwjYmlJQIsT10bs87c49ohX7cVz+bGe7PuU/JUZlibbE1DvXwgAYR5leapB1WXQ7OkiqWgSUF5nCrKNRQ3NNMHo+NLPeteoHAm/bjhH7Qz4o9oWwlgXEXWbYPkWBJR920UyfbGs8Laq+kvco1qdpwOLKhE2NYQn9tS3/IWHQLYnkbthxUe8MtQTPABMg8NKPnSB8QXU+p+IjcEZgi51XYPWuKMhzwyL65/X5P3zmysLXU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(19092799006)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NThkcFZ2VkJDMDFKdHN2Z3EwdDN5bG1jTXB6UG9ndWFNY2NBSlBtU3FWRFZp?=
 =?utf-8?B?MnJpTTlMYVVXMEtIdXdOT0JUblplUHJlWjVvNW5kY21oNlk5NmhkK3ZXb0dU?=
 =?utf-8?B?a1B4ckhPNUV6K2RsSUNlREVtVFJNdXExVGkrMXorZGw4Q1g4UHFBNXdiL1Nx?=
 =?utf-8?B?cGxrNjl0QkxmanZBL3dZWUpPSVNZd3Q1U1JRY3YxdC9lK2pOSy9QQjkyOHRm?=
 =?utf-8?B?bEZwODJpWFNoK3grVHo2VUtmWFp5bmx0VmVLZW1UdzNZL3ZqbVBFR2JFdng5?=
 =?utf-8?B?My9LU1ZuSGxncnRtUitwWkQreXJwNVJTcCt3SFVXWGZZQ0Z2WkRwcGkrVi9F?=
 =?utf-8?B?UWlNdEFXUVdXNDlaSTgyL0o2WnZ5Q2JpV0RDUS9rem5aRUx3YWc0RXFaZEkw?=
 =?utf-8?B?eXIzSE9PbzZTZTZZNGJLdld2Uy9YSzkyY2ZhYzUvWElyYkhUWHRHQ3JXM1V5?=
 =?utf-8?B?bFBpSlh6YWlNbkRmc2xxRGJ0eExtL2dCTml2bXR0bWIvNjRzVDVKTHlTUnh0?=
 =?utf-8?B?OWVHVWhEQ2IxY0lwVG9BY3FXZWFGTEc0bnh3WEVudGNRRi80Z3JiYzRnbVN0?=
 =?utf-8?B?Q0RuMi9ZaEIrYjMrTno2RXJYc2s5TWRMUVlXVFU2UHNyVUdhUmJsMzdYMWpF?=
 =?utf-8?B?R3pjUThQR3A5bFk1L1NReEV2Z2Ixd3lRVDVNZ2NFY0l3anRQbHc2VFRXcVM4?=
 =?utf-8?B?bTRuQXE0M2lYYnVtOFoxV2dHZHhSS1h4dXhFL1dEZTNDdzRFa0xNT3I2RWFX?=
 =?utf-8?B?M1lkUnNVUkN4SjBnOFJBc092bFF2N01RQ3hEblZJVnpQVk4wcU9GRmoxemY2?=
 =?utf-8?B?ZzRYNmM1dWdJUGhNRmtzcStZaHZwOHd3UXJJN3h5TnYybVVvR1F5YmtrUEww?=
 =?utf-8?B?dUM2NnpWVURtcURkUXJ4OHlFQWhra2hCWmI3d3QzNUVmNFgwYm5maGZVVTBn?=
 =?utf-8?B?U2liSXU2aUY3aHBWVFJVVnZ1Nlk2V0xCUkN0WHp2TnYwYjRsSlA0bEpUN0xL?=
 =?utf-8?B?MUxWZ29Jck12YXhuTDByaGFMVTVLanR0MVNSbVRwcStHZzRBZXQ5b1lyUFRw?=
 =?utf-8?B?Mkc1WndpcGJKNjJTVVU5MjZvUWpIUUQ2V1lSeDFMMVdPaC9YUHY5T3Fhdm4w?=
 =?utf-8?B?ck1kaFdlYmNocE9vNkpZTkZkZW5qVU1Za0UxOE5PQVJUMDVBa0grRG9SZW5O?=
 =?utf-8?B?MzdiY29ZTUFyMy83eDdKU3JFQ3RRNFUwck5vMStqMEZZbDVqNVFmc2wvMTFu?=
 =?utf-8?B?NTJrUHRtcm1mb2xySTg1T0ozNzdVNExwSlJiR3pYbEpEMjhmK1lzbENYVnEx?=
 =?utf-8?B?QXdYQlhGL2JLQ0xOZDkyaENoSitCTmtRdjJrZHk1RVNkdWJGUVFTQTk2K1FY?=
 =?utf-8?B?WkhGb2dEeVZNdm9VSUVNM29mY09oc3JMUWI3d3pJL3AzaWpQcCt6b0NsNiti?=
 =?utf-8?B?TWpucjQ5VDFNQVd1SHRwSWxNUnpleFJFalZxNkdmT01aOHMvV2dObEVReVQw?=
 =?utf-8?B?VWo4T3h0SEVJRzVoM1FSUFVybHhOTXlnb05VWlNtZzNsNW5kemJrMkVuR0dK?=
 =?utf-8?B?aWI1bk81L2dDUnkybzd2MzJzMEZmVTZFMVJEekJJalAvNlB0MFNjTjBYOVN1?=
 =?utf-8?B?c1E4bkNTRFR6emVBV3d1VTJtbDMrWmVxUGFmN1hMVC8yaWFHODVoNStWRmV6?=
 =?utf-8?B?Ym5IZm1VSUFhb3VWL1RyNXdVc0JyZTJBZmhwQXBrWE1LclJWRjJSV3VLTytu?=
 =?utf-8?B?UWZ6ZE9UM1BpRkNCS1E3S1RMdzNHaGFuYXltR1dzOWNkM3I3SHIzc1d2TVdk?=
 =?utf-8?B?RGFuYnVwVk9kK3VaVHljTEx0V3N1bGFBQWozaXZUMUdhOXpmcVR2TkpkSm1k?=
 =?utf-8?B?bU16Vlc0aDNmZkxBcWVidXdQdDZEdExBaVFUdkhQbnU5YVdqSHZuMkJoaDZ2?=
 =?utf-8?B?K1JoMzU3SGd2enJSOUdXUHBWczhnZ2E3dVJUKzloTk9TUC94bkw3WEtoZGFn?=
 =?utf-8?B?Tkd3SnRSUi95bmkxZmlhdUFuV3RQYVdwRTZRUnJxUnZZM2hCay94NzhNcDcv?=
 =?utf-8?B?RXU5Smg3ZDIvZ1l1YS9rbXFlL2VHOWZLTkxabmVLNnArSkNOa1I4dzU5d1JC?=
 =?utf-8?B?WjF1d3dDT2hwdllyck9xc1IyRGFZazR6bDhXNHJqYXpwK1lBVlNiYXJtUmlZ?=
 =?utf-8?B?OTVhdXVoeTExSjZ4THVVOTAyMVRJU0dQaGpTVGc5YnZ0ZFhzNGhRaWVuZ3k2?=
 =?utf-8?B?MTlqVXdGVmY5TnYvd3VUSHRUS1dFS3IrU1ZJL3I1c0pycjFVdjQ0QmZmR2xB?=
 =?utf-8?B?NEtzTlFQNTE1dGFLcVRDelg1UnFWaHRRY2QyOEMvT0toTkc1N2duTmRhUDRG?=
 =?utf-8?Q?giRkIAjNwXQOgkNG0kl0fb1tSbIB9kiJvQPnl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb713e5-a9a8-431e-1d3d-08dece11fb4a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 14:49:36.3107 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gdzBi+Pke8eGqAKJsYbWuIKeCrTbMdYZxOFE6WFH45MxYuuIZnyD9BwEqUVo49+r/iEKcostvYJR3Dfqxht9s4574p2aMN/IC8jdP4Hz2ChnZGDZxTFM9VGVY+78tfcT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11827
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

Add support for booting compressed kernel Image.gz by defining
kernel_comp_addr_r and kernel_comp_size in the default environment.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/nxp/imx94_evk/imx94_evk.env   | 3 +++
 board/nxp/imx952_evk/imx952_evk.env | 3 +++
 board/nxp/imx95_evk/imx95_evk.env   | 5 ++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/board/nxp/imx94_evk/imx94_evk.env b/board/nxp/imx94_evk/imx94_evk.env
index 894f5975812..c2006c95529 100644
--- a/board/nxp/imx94_evk/imx94_evk.env
+++ b/board/nxp/imx94_evk/imx94_evk.env
@@ -19,7 +19,10 @@ initrd_addr=0x93800000
 emmc_dev=0
 sd_dev=1
 scriptaddr=0x93500000
+ip_dyn=yes
 kernel_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_comp_addr_r=0xC0000000
+kernel_comp_size=0x2000000
 image=Image
 splashimage=0xA0000000
 console=ttyLP0,115200 earlycon
diff --git a/board/nxp/imx952_evk/imx952_evk.env b/board/nxp/imx952_evk/imx952_evk.env
index 6ecaf9724c1..07faeb9fc9a 100644
--- a/board/nxp/imx952_evk/imx952_evk.env
+++ b/board/nxp/imx952_evk/imx952_evk.env
@@ -52,7 +52,10 @@ initrd_addr=0x93800000
 emmc_dev=0
 sd_dev=1
 scriptaddr=0x93500000
+ip_dyn=yes
 kernel_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_comp_addr_r=0xC0000000
+kernel_comp_size=0x2000000
 image=Image
 splashimage=0xA0000000
 console=ttyLP0,115200 earlycon
diff --git a/board/nxp/imx95_evk/imx95_evk.env b/board/nxp/imx95_evk/imx95_evk.env
index 19f9bd5c16e..1d63a74aefa 100644
--- a/board/nxp/imx95_evk/imx95_evk.env
+++ b/board/nxp/imx95_evk/imx95_evk.env
@@ -3,8 +3,11 @@ initrd_addr=0x93800000
 emmc_dev=0
 sd_dev=1
 scriptaddr=0x93500000
-kernel_addr_r=CONFIG_SYS_LOAD_ADDR
 image=Image
+ip_dyn=yes
+kernel_addr_r=CONFIG_SYS_LOAD_ADDR
+kernel_comp_addr_r=0xC0000000
+kernel_comp_size=0x2000000
 splashimage=0xA0000000
 console=ttyLP0,115200 earlycon
 fdt_addr_r=0x93000000

-- 
2.51.0

