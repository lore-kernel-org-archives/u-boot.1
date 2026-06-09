Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C5DCD8CAC
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 07:19:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEBB0807C4;
	Tue,  9 Jun 2026 09:19:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="F6FF1QRp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09560846D3; Tue,  9 Jun 2026 09:19:21 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5CB880087
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 09:19:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gd88EdzboQp6LTdowuJ/p7UUKmhZOubf/0pbZMt7n8SfQN2xFF0vfMe+fm64VeMKLu881b7mrOACFAi3vy+JgPUnGJnGGjNNB+EdfCeMsB2+MAeSHjhITE8k6BrmnBKHgRP23lS0GVu6b24IUZxtv88JG+RaONII45JhkkxhRBbxXgKJeU/79r0NJ3XoTRg6fI01Ww3VAxAzjPcj6RF5GsiodYuBzvwpUb1iH2KZOCw41oNSuI2mbVLDYDKUH3a8m3TArXbVGGERINsyyTP6UvTcm9EPu3aXzdzuT175SFPpDiqYzzqh86k73BEJriw4jw0wpzU0z7iSoONkMrFiHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JO2FLoLjo8pxgRaTV4JMf4wXgI8Sjd/ngHG/EEZb10=;
 b=YuJ5XKrYYpBre+iyiJKnuvobsFnRTj/TIAWWFM6F+9VgtDv7jXzg7AR2aVVNmLZfBfC1TpRJ4rWRfEKO/Qf7IWGY7KTo2FOuhYu43B3xPHg4uJo4uPBhX3fSXxRK/lRBNwWOP1S537Eooooynjr6qguG8hTveO2K89XxsfkKeWnwb+LK3n8CqCdqJz8QDW+tUxfzuwhAVjOZpkKTH1nlzQGbzGqllu8CuFGoHFowJ6TLodjoL0GX4oEJtUeoYwE5VrK43DWlf3oVwW+Xf8XTb6SJsXlBz56c/0mb5rAQPpqpmv3L2/JXy6sDre+99ioOy9lcaF3WA9vlixEGaL7kiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JO2FLoLjo8pxgRaTV4JMf4wXgI8Sjd/ngHG/EEZb10=;
 b=F6FF1QRpvX/keU0d0cK83lzujrgfyYJJewbh2UMk3JhTrGB7Vs+WkNk+XzFAq5MT1wz6dKM0M84YCndUftxK2UwFKxAzgBVRNs9BL3uZFd3cKtUvQjntY3Ax04t5cxWHDkrAfxCkh2ugxi4Miw6LZDjadRA4B68wFYmJFT3tu+BARuXPTzfRnvdGX/ess4i6Jmfdk3/SkWHgmPOAuNgaSSt+3aY7b9vSriILUrDw9hE5DR2iQJngz/FWWRRCNsmPvGZZkQ5p6uXNy9O2wNKTJf+HIWmvfqLKSQejLY3PRlZMfnLaj1X3wTGwvxkqXkGkTkS86Q9Ccy6k7z5/TIeTpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI2PR04MB11148.eurprd04.prod.outlook.com (2603:10a6:800:293::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 07:19:15 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.010; Tue, 9 Jun 2026
 07:19:15 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 09 Jun 2026 16:36:18 +0800
Subject: [PATCH v2 01/13] imx8m: Imply DM_THERMAL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-imx-misc-v2-1-58e1665d55ae@nxp.com>
References: <20260609-imx-misc-v2-0-58e1665d55ae@nxp.com>
In-Reply-To: <20260609-imx-misc-v2-0-58e1665d55ae@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d6::10) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|VI2PR04MB11148:EE_
X-MS-Office365-Filtering-Correlation-Id: b98c28f3-27a0-4816-d83c-08dec5f7697e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|19092799006|22082099003|18002099003|38350700014|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Ix25FY2pRczsU+nhVIOlnwaiBUaw9dfUsvHbhryf2NCmlYbv6V0ImWdlQdBLOTkXJBWTAp7GZ6u0AEUE5PjAsGB+OtNF/iwFIA9mGemPTiwjGn14FDyw/41JcHAf9BFAqnGJGlapC1I+EVK3Yh0+8ueDLGLlwIfmg/xD+PDcqY1d/ZZcv8Rczr/MXbJBDG1oJ7ldHIWCZj7iRoK+DCuvPzxA+UsWRz4GU3vvgIVnaGYvK++b8bLykakIkgB/T7vzIlnDDDb+UUz4p3wh3EVH6Ih2BL8AXkccr3srm+Sqib12Xk1+6dv37aRwyezadMrj0BwW8y7+PzepnHaEwd1L/6B9ZIN+t5pm+xFG+1afmt9l0wRi3PJDGQwTBNL7Zek0D1MJJmjWKFU0/j1aWl4wD+rL5rrpqORbW1a0XQfBrFiZrR1Mqt+RsJ1qvuKPa6KQHfQeCLOr5DP33p7di/M135LsMvLce3duuOZvOUtP+7oX4YK0CnoNaCa8x0Sq5OEG6Nl0OHIGDlYS1khVHC7FR2u/RcqnRYQwP/NoRkO5FgcT+p6jevGvxaXas2xgI4POoF/Efmob5WREAzWDBAzDawiK4s+vqQGb1TLYBa7r8oym4+B0A2jyI6fMsSQnmxrWDKYaBJafIT65slnYqHjzaEtfe6nMjftO3TQuVDJs3iWBW4tGZNH0j2v55+GsY8xZxDF30hKmndrIqQTJZVG/+sS4wnWCHZLxNYG7i7zhHFFiShLhqXIPvrTJew6Jxk1c
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(19092799006)(22082099003)(18002099003)(38350700014)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnFRYXhLeGVscDh6UFFlQ1M3dDVZeTdFUXFrRDJkZXprdklNTzU1ZDNBbWxl?=
 =?utf-8?B?aE91bEJuUWtiTlNkR3NaS3J5ZXdoZ3p2YUtsc0ZKWGhLSE9VRFRNRGJIWUt2?=
 =?utf-8?B?aVViL2wxaWFYTzdYMjk5YmhrQjhWQWd0YzZhZ3czRTJnMXpDdTBjWmU1a2h6?=
 =?utf-8?B?MlFEMlhmVzdzeGdndnRvTWhjK2NLblFPV0h1ZmU0TmVQNS8yZmRkREZyQlQ0?=
 =?utf-8?B?VURLalQxZnQ1azJoNUszTGxtODhKRWRodkNqZVdjVGNhVEk0Z3k4a0xiMTVt?=
 =?utf-8?B?ZGZ5U0JOaCtFR2MzUStCcjFFQlNNLzY5Q0lObkRsV2ZjcDVIbFJqV2lybk1L?=
 =?utf-8?B?dUg2MDBPazl1SHQ4SElZS3VKMWM4NGc2d3haYldLWUtkVFVMU1dvY1FlWnpI?=
 =?utf-8?B?dzNTZDFCM1FrdkErYmZTeDBmblpIOGNOMXJSVFZpRVE5RDI3QzdaTGFldDFT?=
 =?utf-8?B?U1dZeEFZSjQ3cmNHLzBMNDMvQ0wvOUhkY2V0Z2Y2MHlsd2EzUGdjOE9TTCsr?=
 =?utf-8?B?R1VkZmNpbjh4OUtIbEFTTGo5Y1dQOWxjL29BR1FBNVVXcmgzeDlUeHpHdWJm?=
 =?utf-8?B?dmRRTng2QVhLT2IrRXZzWUVENmZtR052eXJjTkE5MXBEZWZwNzVKeWRyVWtO?=
 =?utf-8?B?cmdYQ1NGVk5Cb2lWaGNSRHhqbUhQZm82WjJISEdEK2swbWVOa3lja0cyL05P?=
 =?utf-8?B?bG5lbmo5QUpMS3VWSWZSb1FId29ESzEyK3R6U05FUVV0ai9vcThuRzVWdDRZ?=
 =?utf-8?B?ZTVuOU1CaUdaMmNyZnFEYk1YWkZ6Mzd3K2pBWUxVSFgrUDJ5ekE0K0E1YXFn?=
 =?utf-8?B?OGhTTGpZMmlyVjhDaG9EcFZLSndZY3FNOGdFUVZ5NXRJM3Fhb1J6eEo3Rk1q?=
 =?utf-8?B?b042Y21FcWp6cExwU3FydCtIWGEyZHVPVFVYR3BzRm1PclNUT0VWYU1IUElk?=
 =?utf-8?B?ZlV0WUdsWGMwNytXQjFpeUtLaTQ4Y25pTUNxL1AxTERSdFJST3lHOEljSC9H?=
 =?utf-8?B?NmUySEFYTjJkZi94amM5MXZVdlV0ekkwK1d1aHduVGQ2bG5senlnTDlQa2dF?=
 =?utf-8?B?NjYyM2k1MndUSHZMbWpFckx4ZndnTnExR3RsbzVMK0NuZGhpbjRmQlNLeGJK?=
 =?utf-8?B?STVCTXEwU0F1azNaU29YK0syaXViQW1GcXRRRUc0YjJoTFZzdWhlckZYWEFo?=
 =?utf-8?B?TGpnaDJSVzdNQWZiSWZTN3pIOGNuK2Q2VVQyU21kNks3SDJMMWJ4YnJaQkZU?=
 =?utf-8?B?Q2VGdW5hSU42KzlCQ0l5QnA0Y0dJbTlrNGpWNDhGbmJ0L0NVbzUxYkRjakp2?=
 =?utf-8?B?c3BQby8rTW5IWi93cEdpS3JkcWRPbzNBdkF4eG5laTZEL0VxOXJLNTk5WmFh?=
 =?utf-8?B?TTJ3dkRkRjRWajhEUGNSU1FSSVJuZThMclJQNDVUQ1F6b3Fhd0R4eEYvRm9t?=
 =?utf-8?B?ZWIvR001Mmkvem5RVGpxeG9nT0VNcW95cWRRSXZXT1BJbmdrVmxUM3VPclBP?=
 =?utf-8?B?UTNBRWx2NDA4UzF3dHlvcmJybktPbmhXWHBVWjJMZ2ZEaHdpTlVETXkwbm50?=
 =?utf-8?B?MmpnT0hINi9UNEtQR3hJM3d3TEdPcml2bUZSQzdtRStTcVRGZGJ2cGJ1YXIz?=
 =?utf-8?B?VVE1bWRuV2RUNkl6bUlNWlBHYi9hOEVjbkc2dzdoMnJzdTg5Rit5NjZwN1N4?=
 =?utf-8?B?aFVUcGhGbjdHeXIxYjJRTURFaGNGcEFZY1lMMWsvMlMxK0tIWXQ2dENySDZn?=
 =?utf-8?B?Z3JqeTROYnV0Q1BOdlJ3Z3NBZys0cnozMVM1RDRVQ09ESm80VmdBVWlzZ1Rj?=
 =?utf-8?B?OVk0eEFMVFFDTGNmZFVOM0FxckVRbmNIMm9OMlNSejZvRXYraStYL3ozd2VP?=
 =?utf-8?B?Vlo0RnlKSVR4bFJONXArblNzNUJTMnRYVStrZEsrTWVHMnkxOFUzb2p0OFE4?=
 =?utf-8?B?Q2pTWS9QOEJnbzMwRk82bUU0Ymo0aDFiWW9DZFVtS1MzRktWeG10a2lqYjdh?=
 =?utf-8?B?SmhQUllWcVh3cWdFRWZFbVMrbUpMNnFxUFdzZ25PR25mTWtzYi9idHNmTEhG?=
 =?utf-8?B?NExYN25UTHord21KazJRcVZNaytYRDh0RWtBVkdVY2hiUjJEcW1MMzN2NCtR?=
 =?utf-8?B?NHlXLzM5cTJmc1l2RXBrcGFaeFNoa0d5THVTRjVWbkFxT2YwN3hBY3AxQkpw?=
 =?utf-8?B?Nk1wYzRTejZobTV0VFpCUXY0MEpEUzlDN0hMUThOd2Iyak00eVJ0Q1lpRlFE?=
 =?utf-8?B?ZjZWTWZ0blo4K0dLRjB4aEVOMEFuSFdodjNDNHlOVFJlWnNxRlBMSzVsY3Ru?=
 =?utf-8?B?YmxabGVuNHlackpsWWRTUXEwZU1ieWZNeWtSdUs1TTB1M0QvRXVYQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b98c28f3-27a0-4816-d83c-08dec5f7697e
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:19:15.3217 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCDR8KUuVmDSinw63BiegpwPfpvYkMGIObu7RjXfGoWh89bdzzr+i8aAcGi2pSk6DoPQ7nFA8679vYLtWr5KeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11148
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

CONFIG_IMX_TMU depends on CONFIG_DM_THERMAL, so when selecting IMX_TMU,
DM_THERMAL should also be selected.

Update i.MX8M based defconfigs.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx8m/Kconfig               | 1 +
 configs/imx8mm-cl-iot-gate-optee_defconfig    | 1 -
 configs/imx8mm-cl-iot-gate_defconfig          | 1 -
 configs/imx8mm-icore-mx8mm-ctouch2_defconfig  | 1 -
 configs/imx8mm-icore-mx8mm-edimm2.2_defconfig | 1 -
 configs/imx8mm-mx8menlo_defconfig             | 1 -
 configs/imx8mm-phygate-tauri-l_defconfig      | 1 -
 configs/imx8mm_beacon_defconfig               | 1 -
 configs/imx8mm_beacon_fspi_defconfig          | 1 -
 configs/imx8mm_evk_defconfig                  | 1 -
 configs/imx8mm_evk_fspi_defconfig             | 1 -
 configs/imx8mm_phg_defconfig                  | 1 -
 configs/imx8mm_venice_defconfig               | 1 -
 configs/imx8mn_beacon_2g_defconfig            | 1 -
 configs/imx8mn_beacon_defconfig               | 1 -
 configs/imx8mn_beacon_fspi_defconfig          | 1 -
 configs/imx8mn_ddr4_evk_defconfig             | 1 -
 configs/imx8mn_evk_defconfig                  | 1 -
 configs/imx8mn_venice_defconfig               | 1 -
 configs/imx8mp-libra-fpsc_defconfig           | 1 -
 configs/imx8mp_beacon_defconfig               | 1 -
 configs/imx8mp_rsb3720a1_4G_defconfig         | 1 -
 configs/imx8mp_rsb3720a1_6G_defconfig         | 1 -
 configs/imx8mp_venice_defconfig               | 1 -
 configs/imx8mq_cm_defconfig                   | 1 -
 configs/imx8mq_evk_defconfig                  | 1 -
 configs/imx8mq_phanbell_defconfig             | 1 -
 configs/imx8mq_reform2_defconfig              | 1 -
 configs/kontron-sl-mx8mm_defconfig            | 1 -
 configs/kontron_pitx_imx8m_defconfig          | 1 -
 configs/librem5_defconfig                     | 1 -
 configs/phycore-imx8mm_defconfig              | 1 -
 configs/phycore-imx8mp_defconfig              | 1 -
 configs/pico-imx8mq_defconfig                 | 1 -
 configs/toradex-smarc-imx8mp_defconfig        | 1 -
 configs/verdin-imx8mm_defconfig               | 1 -
 configs/verdin-imx8mp_defconfig               | 1 -
 37 files changed, 1 insertion(+), 36 deletions(-)

diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 0d22d3b4e3a..5f7d7e4c66e 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -10,6 +10,7 @@ config IMX8M
 	select ARMV8_CRYPTO
 	imply CPU
 	imply CPU_IMX
+	imply DM_THERMAL
 	imply IMX_TMU
 
 config IMX8MQ
diff --git a/configs/imx8mm-cl-iot-gate-optee_defconfig b/configs/imx8mm-cl-iot-gate-optee_defconfig
index 4039ef298d3..20294756d90 100644
--- a/configs/imx8mm-cl-iot-gate-optee_defconfig
+++ b/configs/imx8mm-cl-iot-gate-optee_defconfig
@@ -136,7 +136,6 @@ CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
-CONFIG_DM_THERMAL=y
 CONFIG_TPM2_TIS_SPI=y
 CONFIG_TPM2_FTPM_TEE=y
 CONFIG_USB=y
diff --git a/configs/imx8mm-cl-iot-gate_defconfig b/configs/imx8mm-cl-iot-gate_defconfig
index 489d1ff2d32..ccd7bf6ed8e 100644
--- a/configs/imx8mm-cl-iot-gate_defconfig
+++ b/configs/imx8mm-cl-iot-gate_defconfig
@@ -139,7 +139,6 @@ CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
-CONFIG_DM_THERMAL=y
 CONFIG_TPM2_TIS_SPI=y
 CONFIG_TPM2_FTPM_TEE=y
 CONFIG_USB=y
diff --git a/configs/imx8mm-icore-mx8mm-ctouch2_defconfig b/configs/imx8mm-icore-mx8mm-ctouch2_defconfig
index 2db503652ee..d84d60a7baf 100644
--- a/configs/imx8mm-icore-mx8mm-ctouch2_defconfig
+++ b/configs/imx8mm-icore-mx8mm-ctouch2_defconfig
@@ -88,4 +88,3 @@ CONFIG_MXC_UART=y
 CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
-CONFIG_DM_THERMAL=y
diff --git a/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig b/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig
index 7650d7b734d..82fdd16c4d6 100644
--- a/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig
+++ b/configs/imx8mm-icore-mx8mm-edimm2.2_defconfig
@@ -88,4 +88,3 @@ CONFIG_MXC_UART=y
 CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
-CONFIG_DM_THERMAL=y
diff --git a/configs/imx8mm-mx8menlo_defconfig b/configs/imx8mm-mx8menlo_defconfig
index f8a7d6060ee..3f954976c0a 100644
--- a/configs/imx8mm-mx8menlo_defconfig
+++ b/configs/imx8mm-mx8menlo_defconfig
@@ -149,7 +149,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/imx8mm-phygate-tauri-l_defconfig b/configs/imx8mm-phygate-tauri-l_defconfig
index e34f12cabf3..9dc7fe21820 100644
--- a/configs/imx8mm-phygate-tauri-l_defconfig
+++ b/configs/imx8mm-phygate-tauri-l_defconfig
@@ -105,5 +105,4 @@ CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
-CONFIG_DM_THERMAL=y
 CONFIG_IMX_WATCHDOG=y
diff --git a/configs/imx8mm_beacon_defconfig b/configs/imx8mm_beacon_defconfig
index 04daa0040c1..32339e7f6e2 100644
--- a/configs/imx8mm_beacon_defconfig
+++ b/configs/imx8mm_beacon_defconfig
@@ -135,7 +135,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/imx8mm_beacon_fspi_defconfig b/configs/imx8mm_beacon_fspi_defconfig
index 6017f50e51e..8c66fad7390 100644
--- a/configs/imx8mm_beacon_fspi_defconfig
+++ b/configs/imx8mm_beacon_fspi_defconfig
@@ -133,7 +133,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/imx8mm_evk_defconfig b/configs/imx8mm_evk_defconfig
index 7521df31f2f..953968c9092 100644
--- a/configs/imx8mm_evk_defconfig
+++ b/configs/imx8mm_evk_defconfig
@@ -120,7 +120,6 @@ CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/imx8mm_evk_fspi_defconfig b/configs/imx8mm_evk_fspi_defconfig
index 8ab6ee24b23..79abe3bfeeb 100644
--- a/configs/imx8mm_evk_fspi_defconfig
+++ b/configs/imx8mm_evk_fspi_defconfig
@@ -107,7 +107,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 CONFIG_IMX_WATCHDOG=y
 CONFIG_FSPI_CONF_HEADER=y
 CONFIG_FSPI_CONF_FILE="fspi_header.bin"
diff --git a/configs/imx8mm_phg_defconfig b/configs/imx8mm_phg_defconfig
index c99b8e22bac..26bb5c12f02 100644
--- a/configs/imx8mm_phg_defconfig
+++ b/configs/imx8mm_phg_defconfig
@@ -103,7 +103,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/imx8mm_venice_defconfig b/configs/imx8mm_venice_defconfig
index 0cde12d9d78..d9d1b7c6e71 100644
--- a/configs/imx8mm_venice_defconfig
+++ b/configs/imx8mm_venice_defconfig
@@ -157,7 +157,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 # CONFIG_TPM_V1 is not set
 CONFIG_TPM2_TIS_SPI=y
 CONFIG_USB=y
diff --git a/configs/imx8mn_beacon_2g_defconfig b/configs/imx8mn_beacon_2g_defconfig
index fd80c3065ed..83db14dc5bc 100644
--- a/configs/imx8mn_beacon_2g_defconfig
+++ b/configs/imx8mn_beacon_2g_defconfig
@@ -131,7 +131,6 @@ CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 # CONFIG_SPL_DM_USB is not set
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/imx8mn_beacon_defconfig b/configs/imx8mn_beacon_defconfig
index bc2d6014b21..6a1be97318a 100644
--- a/configs/imx8mn_beacon_defconfig
+++ b/configs/imx8mn_beacon_defconfig
@@ -138,7 +138,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 # CONFIG_SPL_DM_USB is not set
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/imx8mn_beacon_fspi_defconfig b/configs/imx8mn_beacon_fspi_defconfig
index 800f851edbc..662f8f902d0 100644
--- a/configs/imx8mn_beacon_fspi_defconfig
+++ b/configs/imx8mn_beacon_fspi_defconfig
@@ -137,7 +137,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 # CONFIG_SPL_DM_USB is not set
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/imx8mn_ddr4_evk_defconfig b/configs/imx8mn_ddr4_evk_defconfig
index 18c44e801f4..63e75aaf7a6 100644
--- a/configs/imx8mn_ddr4_evk_defconfig
+++ b/configs/imx8mn_ddr4_evk_defconfig
@@ -97,7 +97,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 # CONFIG_SPL_DM_USB is not set
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/imx8mn_evk_defconfig b/configs/imx8mn_evk_defconfig
index 3233686034b..152f04953f8 100644
--- a/configs/imx8mn_evk_defconfig
+++ b/configs/imx8mn_evk_defconfig
@@ -126,6 +126,5 @@ CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
-CONFIG_DM_THERMAL=y
 CONFIG_IMX_WATCHDOG=y
 CONFIG_SHA384=y
diff --git a/configs/imx8mn_venice_defconfig b/configs/imx8mn_venice_defconfig
index 54dce09bc9f..c5685c84d2a 100644
--- a/configs/imx8mn_venice_defconfig
+++ b/configs/imx8mn_venice_defconfig
@@ -152,7 +152,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 # CONFIG_TPM_V1 is not set
 CONFIG_TPM2_TIS_SPI=y
 CONFIG_USB=y
diff --git a/configs/imx8mp-libra-fpsc_defconfig b/configs/imx8mp-libra-fpsc_defconfig
index 44f3c9fd796..142cbcf9888 100644
--- a/configs/imx8mp-libra-fpsc_defconfig
+++ b/configs/imx8mp-libra-fpsc_defconfig
@@ -156,7 +156,6 @@ CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
diff --git a/configs/imx8mp_beacon_defconfig b/configs/imx8mp_beacon_defconfig
index 1693264c9d6..8359f748244 100644
--- a/configs/imx8mp_beacon_defconfig
+++ b/configs/imx8mp_beacon_defconfig
@@ -152,7 +152,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 CONFIG_TPM2_TIS_SPI=y
 CONFIG_USB=y
 # CONFIG_SPL_DM_USB is not set
diff --git a/configs/imx8mp_rsb3720a1_4G_defconfig b/configs/imx8mp_rsb3720a1_4G_defconfig
index 401ad666011..eafaf4140be 100644
--- a/configs/imx8mp_rsb3720a1_4G_defconfig
+++ b/configs/imx8mp_rsb3720a1_4G_defconfig
@@ -159,7 +159,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 CONFIG_VIDEO=y
 CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_IMX_WATCHDOG=y
diff --git a/configs/imx8mp_rsb3720a1_6G_defconfig b/configs/imx8mp_rsb3720a1_6G_defconfig
index fdfd72fcd7b..6e8bb06d019 100644
--- a/configs/imx8mp_rsb3720a1_6G_defconfig
+++ b/configs/imx8mp_rsb3720a1_6G_defconfig
@@ -160,7 +160,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 CONFIG_VIDEO=y
 CONFIG_SYS_WHITE_ON_BLACK=y
 CONFIG_IMX_WATCHDOG=y
diff --git a/configs/imx8mp_venice_defconfig b/configs/imx8mp_venice_defconfig
index 49f0e0e829f..990d100f253 100644
--- a/configs/imx8mp_venice_defconfig
+++ b/configs/imx8mp_venice_defconfig
@@ -157,7 +157,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 # CONFIG_TPM_V1 is not set
 CONFIG_TPM2_TIS_SPI=y
 CONFIG_USB=y
diff --git a/configs/imx8mq_cm_defconfig b/configs/imx8mq_cm_defconfig
index 79c51191be0..9a8c16ccb19 100644
--- a/configs/imx8mq_cm_defconfig
+++ b/configs/imx8mq_cm_defconfig
@@ -94,6 +94,5 @@ CONFIG_MXC_UART=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_QSPI=y
-CONFIG_DM_THERMAL=y
 CONFIG_IMX_WATCHDOG=y
 CONFIG_WDT=y
diff --git a/configs/imx8mq_evk_defconfig b/configs/imx8mq_evk_defconfig
index 67a7f339816..dd0c615032a 100644
--- a/configs/imx8mq_evk_defconfig
+++ b/configs/imx8mq_evk_defconfig
@@ -107,7 +107,6 @@ CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
diff --git a/configs/imx8mq_phanbell_defconfig b/configs/imx8mq_phanbell_defconfig
index 64e3ee04293..9138bca067d 100644
--- a/configs/imx8mq_phanbell_defconfig
+++ b/configs/imx8mq_phanbell_defconfig
@@ -93,4 +93,3 @@ CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_SPL_DM_REGULATOR_GPIO=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
-CONFIG_DM_THERMAL=y
diff --git a/configs/imx8mq_reform2_defconfig b/configs/imx8mq_reform2_defconfig
index 23ee6278503..a63a01ba8d9 100644
--- a/configs/imx8mq_reform2_defconfig
+++ b/configs/imx8mq_reform2_defconfig
@@ -93,7 +93,6 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
diff --git a/configs/kontron-sl-mx8mm_defconfig b/configs/kontron-sl-mx8mm_defconfig
index f999ed073e8..c3a954dffd9 100644
--- a/configs/kontron-sl-mx8mm_defconfig
+++ b/configs/kontron-sl-mx8mm_defconfig
@@ -192,7 +192,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/kontron_pitx_imx8m_defconfig b/configs/kontron_pitx_imx8m_defconfig
index b216a0bb270..1b175670ffd 100644
--- a/configs/kontron_pitx_imx8m_defconfig
+++ b/configs/kontron_pitx_imx8m_defconfig
@@ -106,7 +106,6 @@ CONFIG_DM_RTC=y
 CONFIG_RTC_RV8803=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
diff --git a/configs/librem5_defconfig b/configs/librem5_defconfig
index 7e450e2d356..72ffb72a137 100644
--- a/configs/librem5_defconfig
+++ b/configs/librem5_defconfig
@@ -130,7 +130,6 @@ CONFIG_MXC_UART=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_MXC_SPI=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
diff --git a/configs/phycore-imx8mm_defconfig b/configs/phycore-imx8mm_defconfig
index 3767fdfb23b..10061a1ba4c 100644
--- a/configs/phycore-imx8mm_defconfig
+++ b/configs/phycore-imx8mm_defconfig
@@ -131,5 +131,4 @@ CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
-CONFIG_DM_THERMAL=y
 CONFIG_IMX_WATCHDOG=y
diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index 2b2aa899632..a116c65a99e 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -162,7 +162,6 @@ CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
 CONFIG_USB_XHCI_HCD=y
diff --git a/configs/pico-imx8mq_defconfig b/configs/pico-imx8mq_defconfig
index 2d5bfffa093..dc2263368ab 100644
--- a/configs/pico-imx8mq_defconfig
+++ b/configs/pico-imx8mq_defconfig
@@ -91,4 +91,3 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
-CONFIG_DM_THERMAL=y
diff --git a/configs/toradex-smarc-imx8mp_defconfig b/configs/toradex-smarc-imx8mp_defconfig
index c0185ed9ca5..7301d7a4ace 100644
--- a/configs/toradex-smarc-imx8mp_defconfig
+++ b/configs/toradex-smarc-imx8mp_defconfig
@@ -160,7 +160,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 # CONFIG_SPL_DM_USB is not set
 CONFIG_DM_USB_GADGET=y
diff --git a/configs/verdin-imx8mm_defconfig b/configs/verdin-imx8mm_defconfig
index c8a2a057135..16e5ce7f406 100644
--- a/configs/verdin-imx8mm_defconfig
+++ b/configs/verdin-imx8mm_defconfig
@@ -145,7 +145,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
index 3c9dab36d90..778d56ad55d 100644
--- a/configs/verdin-imx8mp_defconfig
+++ b/configs/verdin-imx8mp_defconfig
@@ -162,7 +162,6 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 # CONFIG_SPL_DM_USB is not set
 CONFIG_DM_USB_GADGET=y

-- 
2.51.0

