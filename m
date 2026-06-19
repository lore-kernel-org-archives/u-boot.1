Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8357ECD98F2
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 14:49:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1482384A45;
	Fri, 19 Jun 2026 16:49:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sNo2tvIC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F49F849BF; Fri, 19 Jun 2026 16:49:06 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 215C984A39
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 16:49:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dpv2kQ5bHyb1LxxebsOfA6OT5/iL5EPlaVY6p/GesbQyr3AwPNiZPsqBVGZfmxdh3jpJuQgNsn1tBjpvKW1EcitDAnb3gMrbzc3Mqn/IFBoYIy0lu2daxK/r20paK8cTSeXNmwi8Ktbo1IkaV5Qk/6EheBbQ+GC+GQrOybICvGoLUxnFDV1ozzxyC4xGC9Z4CiRRT79jwV9YS+qgSI21C6UFJRGopX0giUkGQE6/itqqaq0rFvnOQOoLtKfiFhIh1gJQIXtVm/NPAsuIhGjG3km2WM8KfqtlTb3YlVylsMHxBIggkLXNVtaRrD+zoHYclLjoiym0asel6T88+gWOaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btM6HVLODBMjHehtGwS3qvBTR8Z8C79r0onDubb4bA4=;
 b=rDgBvnEk8GFuZqn0btFG33vWf0fHKI0HfdW0xvKjaXpLrQvBSXQJmwWwZRyCGQmhf62+/Zu2XuEAKY9fCZRwlLm0VCw6lQLxqucsf4oFtSqCQNC6Ln3XtG+i0HSYq95697ZfQ4meiNl5JJKwzO0eD10F6nX+Od9ManenZ3g4NiKMOtF5aHG2S4d9dWVh3vEfFLxOf+r6+2EkJTBy2TMT3RxeTj2BvbTsuCLEt5pBVT6/FQAL3euzRL+DgpyuAVmIV8Y69l+go/9W1I0qPdZ/9Se46+fzZPiLO9JKjnHgaG46VQSqq3tgNLaP4WY3F7p6kZfSGFa+KSTNILCkC0xqnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btM6HVLODBMjHehtGwS3qvBTR8Z8C79r0onDubb4bA4=;
 b=sNo2tvIC1NGoKOCi3aLMIpMy9uylIJHXmE8NVFdrOm7h3kvB5+POsWU0vxhUJ0Yzv7TnRjgTRlKyM644aznRgPZgKYR/ur4jygbpGcz3Ac/epC8qONt1VpMKb/NQmfisBBcGp662rOLtJGk20HamJIszakzEbwILGiO2uBvmVDwwO5Kf4K7iGwgvb7kvEcuZQsybuCG+2n0vJi8doQh8nOoTFPX2DRdSfuZtGnzMA4U6YK9ruNJwUWGtGO2QM4dvBJ4+zfZCK5aXLcYLkugK9tx27bBEHTCFnZ28E8kMCZ3cLdMoamDRX8i9StfamDbtFMwixNTu/yoYxFRL7Jnamw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GV2PR04MB11827.eurprd04.prod.outlook.com (2603:10a6:150:2d6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Fri, 19 Jun
 2026 14:49:02 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 14:49:02 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 20 Jun 2026 00:06:03 +0800
Subject: [PATCH 1/6] imx8mp_evk: enable booting Image.gz and avoid extra memcpy
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-imx-gz-boot-v1-1-143c60a572b7@nxp.com>
References: <20260620-imx-gz-boot-v1-0-143c60a572b7@nxp.com>
In-Reply-To: <20260620-imx-gz-boot-v1-0-143c60a572b7@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>
Cc: Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GV2PR04MB11827:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ff3e62-fad7-4edd-04eb-08dece11e6d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|19092799006|18002099003|22082099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: o+troeHIlA7M/J9kW725YuHb4iR6pJYj4WJHTdD+1d+qe6BzC3aS14d5v39qLbHdJgmbgapV1oDUhBSziHxbMKjXYbVrWX2UEvUmi1CneLMmNm5W6K//KCDTrdgJzgQOQzqpmMPx5uNAMR3isTVQGz7TCoDL3irv3rYMaBQR4CURgHi5gDhq5l28IEBn9aaz8BpKkdSZNjDPPqRwNBSAl1IuLzANl0uaXFFf8HaXE5g5iVmTrGIlwFHFBJ2WQzsDjLv9NrPg0+UL+r4ZfnCj1+gDofWsNKQrghkR3egMjbrOvNnycUi9H6P4fcTceAOPl76cxAeqgXdaEAppXhjVdQeirmbOh3OPcpGE5IVIjfFZHGYo1QlnQ58x8LMPvAKArTGLr/au0QA5MvJbrW6M9cn5/kZD8SrCooDliNrzuIFx5lB1yGJzdG/FvRUAXhLwKzoyVHAV1Wu+NnLt/dy4CiCn9yltitxwHKBuvenXLmT0RfAtipZaFQ9qghpnlzvdRNe3qKohuBvE818G+ChD/gJBCRE52VeL1H2tOobMCoE7XmzM2lOawkrKsAZbJFZSgJ5BC9AaoMw9FasSk90sCu/IBOBZO3kiCvbrQdyKYez3CugjjglZMfuq/PFTJ2lT65Pqc3xm1PF8sVNKpAG6H69B9tVckrwGJx/MDIHgVRc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(19092799006)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STZFR1lrcUZFbmJDcU1VRkpjOERwa2NjS0d2MFZ1UmxEK1JPOER2Q1NiYUJ3?=
 =?utf-8?B?ajNDTEc5TURIYUxSamdzZnI5Qkg5NmJIQ0ErTm01eXpvMXZIQVVTVjE5N0x6?=
 =?utf-8?B?L3M5N1FXWjEzTVdnVUUrVGFUejlobzdBVE02Umg1ek1EbGwybHpBT3VuQ2dP?=
 =?utf-8?B?UHFmeS9zL0xoNVdobTU4WjdqZ0ZieEZ6MGF1T3EyaWkwaDFPUnR6cXhXWDVU?=
 =?utf-8?B?QS8xRVpHSFIwUzN4SmZ3MHNiMFB5eVNwTGdDbW9WdHVhRm8yYnlYbHdEUmxG?=
 =?utf-8?B?MkxEOTFVVzgyQytkQWthRndEeDVDcUdQblFwOW8ySzFOUTkvb2xmV2RqWE1w?=
 =?utf-8?B?MzhicWxXeERlM3A2N081QXFxTjlxZDUyQTM2dnRhcFFOSFg3SGZCR0V3OHFt?=
 =?utf-8?B?YmQ2VXZnUWYvQTI4aFlhUExDU1NGa1hBSFQ4OTQ4eGxnM0ZPdmNHZjRyLzNo?=
 =?utf-8?B?RmJyQWhhMGJrS0ZJTm13NHU3bmIvaXd3dzJQTjRxcGpNSExsQlJtSjEyYm9k?=
 =?utf-8?B?WlJoeXFsQ1FiZ3FLS3hWdGNlcHc2eGRZK3Q4azMxcVJyOU9MQVdzNUtTdThU?=
 =?utf-8?B?MGdyNW1FRnNDM3Nxa3JoQzlXT3pZaEJwYUxPR0hYbnpSNnlvTTIrbU50UW9X?=
 =?utf-8?B?S2lJSDFjblEvQ2J4M0g3WWFYQUIzL1J5ZFg2UkVNWndmc0ZxL2JqNFU2YlZt?=
 =?utf-8?B?R2xieVJKMnJvWWhyS0Fjem5jL3dJM2ZNTE8xRWVaa1h6bEhrY3QvMHB4QTVT?=
 =?utf-8?B?Q1lrODB1NlVCdDlwT3M0YUlNV0tNMlJRNVdHRDdaeVhudi9iejlIc002K2tQ?=
 =?utf-8?B?MmQwbU5VTFNKVGtqTnAvd25rUTlxU3U5dU9mUVdzSkNBYy9mTittUHhQd3JE?=
 =?utf-8?B?VkNhNnNPVWw0aUNiNEloN0NNdy9KaW96TDN4ZWxVM1o5VmRJeU5kWi9LanR2?=
 =?utf-8?B?ZDZYTzlPR0wzdDdjUC9iell3a3lnYWZ6dTZqQ1B0c3ExdFlTNXBaTi9aVVox?=
 =?utf-8?B?d1huamZtWWM1TEN6andMcnA1UmQ0M0xVRjJEakxSQS9ES21KaGY5Q05BbFJJ?=
 =?utf-8?B?SFFEOUtvOExFdDFEclpzS2ZoNHpkSU1aMERBcGplYzYwSVFuRTVGaWNuZnZm?=
 =?utf-8?B?OGFtZG1YdEhabTM1T2RMUEpoczNMWmJ5bjZObThDYzdGUnJDSUQyNG84VlJ5?=
 =?utf-8?B?R0h3WDd6QW9aTFdwRXlKUWdMUVB3S0JRdVpWeDNEd2tkNjRGTHRHS0lraWt1?=
 =?utf-8?B?MnRVNlk5cnJYYUFtVktnbCthczN0bjBIb2x6dC96S3daRWQvSVpvQ3JSaDZ4?=
 =?utf-8?B?blJCanFVbXVkWi9xMnFQcVFYeUFmQmJkY1ltVW9IQWxLdFl0Z2tyNG82UWJN?=
 =?utf-8?B?YlNhdXdQUGdadGtPVVVBblFPZWR3MHY3c25ZUDNLUEg3cmxDeVNFK3BtbnhI?=
 =?utf-8?B?SkJqOXUzeVV4bExzdnhKVUh0ak9pRUx5U1lKVVhGYlpxUys0WnBvMGtNcnBD?=
 =?utf-8?B?YWVma0MxMUkzQWxXRlpqV092R1JNeko3c2lSVjFzaHExMVhUTnhjUGEvN0kr?=
 =?utf-8?B?OW1RQ3Nla3dKY2pibDUwR2lpdStRQXdyaTA2WElQenZLZXUzOGYvQjRRbEJX?=
 =?utf-8?B?OGZnMlFMbm5zNWU0bEVKSnA1Y2taYXNldkluUnNDTFZ5S2xqVTJ3ZEI2ZjFQ?=
 =?utf-8?B?K0NlcmRkdUFydWxBK05LUWVQNmxlZkVkbHVhSC9SNUpENmMvM0xodktWTGxP?=
 =?utf-8?B?d2lsVzBzc21DQVpVd01hTndvTGpPYWRmc2tKRjdYRWhqb3V2U0FHL0pYWlZV?=
 =?utf-8?B?M3crLzBDTC9Fa2wwcnJYT3NvN0xBTzN3eVRGQWF5Q2VEWHBPVWxaSHhhU3NB?=
 =?utf-8?B?Y2RDYWhwYk13VjJpNTBtVlJXTHhSYURjY2NDRXdPMUFJSWxsSjYwYURpR3BP?=
 =?utf-8?B?bDNEZzRvcEkxTUNwWDNISnRybkZaYnNFNzU1aHhORkc2SzR5MTJ4SllwQlgx?=
 =?utf-8?B?RVBDc2NmV2NFQkxOTXl0eVRlTlM2MGFMOEN5Sm9iL3JOLzZGOW45S1h0VHlO?=
 =?utf-8?B?RWFXVktPc1Z2aGRxbzNJRERJNjFQRE9WaTZxU3liK2lEREl3elRIanhVT2Zz?=
 =?utf-8?B?c080QTdaUnljMVNiRmZZS0NLZ3JUTDNXV0FzVEVoMzhaOWNlaUU2S3hvY1RS?=
 =?utf-8?B?L3RiK0hhbW5MQ3lOZVlDWWRzVzVtVW04bEtxRzBUWEZLajg5b1c3N05QTEty?=
 =?utf-8?B?MUxXSlJaMDQzemhhdkUyOFh5Nk9lZVg2d3RuNnREclpIb1NaVWdvcWlxMFQ4?=
 =?utf-8?B?RXFyb0xaQ2IycDd1bjJjQ3pRSkVVcGVVYkYyK01tem1PT016STBnMS9vVDNa?=
 =?utf-8?Q?aA5RO4N6BfQcYVw9VGzLjhgLd1THOZVIgl1Ao?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ff3e62-fad7-4edd-04eb-08dece11e6d3
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 14:49:02.5166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KvXareGinakkfBJD6L6vf5ppPhLTwOL/ejyWzDvVYV/2En4BOP4RcQBJUAky9SiZmtaO5qgBlELkyWbDuhu4RCBWNwig1vqxgd5v2kb3IiWOrvC/AItn25ZgCS/PFQpp
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

Set kernel_comp_addr_r to a high memory region (0x80000000) to provide
a dedicated decompression buffer, avoiding overlap between compressed
input and decompressed output.

Also adjust CONFIG_SYS_LOAD_ADDR from 0x40480000 to 0x40600000.

With TEXT_OFFSET=0, the kernel is relocated directly to loadaddr, so
separating decompression and execution regions is required to guarantee
safe decompression without additional copying.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/nxp/imx8mp_evk/imx8mp_evk.env | 2 ++
 configs/imx8mp_evk_defconfig        | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/board/nxp/imx8mp_evk/imx8mp_evk.env b/board/nxp/imx8mp_evk/imx8mp_evk.env
index e994b93b168..dfc922e6215 100644
--- a/board/nxp/imx8mp_evk/imx8mp_evk.env
+++ b/board/nxp/imx8mp_evk/imx8mp_evk.env
@@ -10,6 +10,8 @@ fdt_addr=0x43000000
 fdtfile=DEFAULT_FDT_FILE
 image=Image
 ip_dyn=yes
+kernel_comp_addr_r=0x80000000
+kernel_comp_size=0x2000000
 mmcdev=CONFIG_ENV_MMC_DEVICE_INDEX
 mmcpart=1
 mmcroot=/dev/mmcblk1p2 rootwait rw
diff --git a/configs/imx8mp_evk_defconfig b/configs/imx8mp_evk_defconfig
index 7af538ee367..a74ce5a60d3 100644
--- a/configs/imx8mp_evk_defconfig
+++ b/configs/imx8mp_evk_defconfig
@@ -19,7 +19,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x98fc00
 CONFIG_SPL_BSS_MAX_SIZE=0x400
 CONFIG_SYS_BOOTM_LEN=0x2000000
-CONFIG_SYS_LOAD_ADDR=0x40480000
+CONFIG_SYS_LOAD_ADDR=0x40600000
 CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0x20400
 CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000

-- 
2.51.0

