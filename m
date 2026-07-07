Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EE6C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 03:57:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A086D846B4;
	Tue,  7 Jul 2026 05:57:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WgMTB/SB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C0F384844; Tue,  7 Jul 2026 05:57:05 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D53B5801A9
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 05:57:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNFBUAQYxWq97U59JKWEvgxgtz4pAuWsA511nagsHl1yC0BpLb4J3nLgo07WtiM4jrf2A9NOz57YSQ0kfk1nPltdDrH+TLFPFAfJtrKdSzXuFJlogBfkJba4MxNzUlfUtqRX10mGjoRF5gpzLN3tGI/JT+81vru/bxFaKCZBL/XWOXBwgE40KwMf9MQXIZYR5ghN/RA67xyZ1IPwCvrABcohXzi068fwzFHXEQPaKzk7zrcZf2KDpd3TE8l65/MuLLPP/BptGXs7O2x5I6JlIHljItse+RoXbCXqnMuOPyPyWJWAdmEw407scjP5uoHtx//QdyMZptS+bS5OG75zAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Op16YXnkG/QrvMTQaS+GIj3kwB00UmarZ0UqBKrBXqw=;
 b=suHCranDympaMPzjpeuyt5Oi43RZduD7444iFVULYhr+sqGOhEbhoidLYAo+w/8k5rFRDVWvMBHoZQTw1SfUYYxBchhV+EfI0w15c+cdbpYHebm7xvVYN1U3X2MINHcT8KxHMy8w4UIjS4cS3gtI+l4PwpN+9u84iHWi0kI8Jhj4ttJzo0I+yxr+nkZszJ3SbgyBIKur6higJeGdEtLYfmbuHaTpDddyKDGyGvLuygeFLxQvwwvIyHpKjG5CBgbjZWynHqDpgQo8W1I9wrkqeR6ilZ0Z4FSCEjnqVsg7spqgokCSQPTOukJ1qsK4Lb+4HYbC6AvchcMq+c1DLZCmJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Op16YXnkG/QrvMTQaS+GIj3kwB00UmarZ0UqBKrBXqw=;
 b=WgMTB/SBO+uCWOGpMw3BPrrl5Y491pO6Eq+nss+OQBlifDfjwIOH50vQ/WGIvCffhqmoyEgoKia6ZeDdAhYhvcsNeYv/od1+/t/AyapndOVe2l1V2qtnpPANzWGMprM7ivolM90yO2AAoXO4mWt6fhoq9dguHiDkshtO6sNTf5EWx24wgs3g6FGV3YUnIyF9vpFdi1DIC/Rs1iyk/TwGt4fz+PaMfztxJJwOCjvjrkEsGNOmu178jgj9fdmUoWBBqMeWuYqwFct1BTeNPWgBnpApoQoekLubRF4sY+xEarMKSj0Tjfi0rsfxRWx3XQJsyXHsdZU/pAmkGzBNq6wYjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by DU7PR04MB11235.eurprd04.prod.outlook.com (2603:10a6:10:5b2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 03:56:59 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 03:56:59 +0000
From: alice.guo@oss.nxp.com
Subject: [PATCH 0/3] net: fsl_enetc: Add SGMII 1G support for i.MX952
Date: Tue, 07 Jul 2026 12:00:24 +0800
Message-Id: <20260707-imx952-v1-0-1262c7c6f7e9@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANh5TGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwNz3czcCktTI10zi0SDNHMDSwMzkyQloOKCotS0zAqwQdFKZYZKsRC
 x4tKkrNTkEpAJSrW1AAOtfpJuAAAA
X-Change-ID: 20260707-imx952-68a0f709064b
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5PR01CA0151.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::11) To AM9PR04MB8114.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|DU7PR04MB11235:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a5c883e-28f4-425b-fd97-08dedbdbcbb5
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|23010399003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: OEoBL/PLPhpgTmo4puBcXxN2bC2IIaPtJ71r+K1pw9HukQEd/ULowap5HnXgyIbn4zzDZs014X7ezLBS3wQ9zhJyWRIQj1pK2uleiXSA8eHABQGL0eNZhcft6axAEGr673F9KgaZNFwzhtkCwlc9AJjKtSHlyLA4QjppIQWul0hDtBBSkiiSHnU1K0LJOmq7B5VK2GBl8xiUU7vz75hpgVvTNVXGpC9KA7aN15OHxlyRkaLfaXAFQmZbdc5RELduaRVlgr8QxQUlG9tpsQU8HPz8WcTL53S+WaKWLj+Kuh3AvzuDLTxS2NbIo5YIYeS60g05SZ6m1oOHRI3ydmSJDwj1QG8IA7Fcg+QQGpuNo7Pmrl2Te+QbgA9DQ4mGKp4kB0tYtwzNRta218y0Khava5OFXrEAT7UKcP6tKaCHqRU+wfl0F8+4ay+YzJycVCX7uTb29SfoBU3QulR+CQVUvWWUF+hcHW/u2y8xKt/xZ21a13FEz3F6Lwn4nK5F9F++C7IHFBCXV/e3dULV1mNH9RQ2g9jdp1tEWrdflKosctL/wf9xIUyO2J9sk+zkkpEBRLX1fGBJ2/Eaql90NHOu7Pc5nIMizzoTuyTkU3tvkWLi0L1EQ5SJi4RjG0ybtr5hpH1ZKhHkmQw5AhqGK8IBirNudS7aHzD+7DEwkdSaxxw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(23010399003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDU3MlJ4U1dzdDQyaTBieVBmSTVTdCtmQ1lGam01L3NlaTBoZkxTbEtCOXNm?=
 =?utf-8?B?R0J5UnB6VlBId1B2cVJnT0lpekFUQnNWeEFTRXJEZnNXbGo0Z2VSd3BFU1l2?=
 =?utf-8?B?d3B6cUZBUWNBM21sVzNJNmh4M2tRMmREVzZGRW0valUwYVhNMTIvMUlCcktY?=
 =?utf-8?B?ZUo2MjNkWHdtREtleUQrczNJMENVb2U3ZnlBYWdDTyt0dmlUTkhDWWI5K0Rh?=
 =?utf-8?B?QlNWK1gxTGw5RzNsczBaT21ORFBVcldBbDdqUjRJWjI5RVZ6d3BBRDJ6blZI?=
 =?utf-8?B?eTU3bW0yV1JaWUlSTy9FMXp3UzJENU43MnRidWZpUVVzT1VqcENRQndVdGg1?=
 =?utf-8?B?QmRyOFVsRG5ET0FsNGtwV1JHWFl2eGFlcjBTdXFrOFJNdkdaQ1YyUG13ajY5?=
 =?utf-8?B?RWpRMnJSb2NnYmpodUVmVEVHRjZod1c3REkyTmo0bGo3TGlmOTZXYkRMTUpv?=
 =?utf-8?B?eG8xYnRFRURQcktSVTYvaGs3T3hPcmttclJlZjNGOWVUaTJiSmNPalhWa3g5?=
 =?utf-8?B?d2pCU2pTWFJlVDFWL3NZbnNRSDRUUUc3TWdvOTNxL24wQTVqdXFvaDhZSEE1?=
 =?utf-8?B?REo5S29kczdrbWtmQTg4WUtUNFM5U2ZJK0lpenhCQTRqQjZsdzFHblQvMnpi?=
 =?utf-8?B?ZUFzSWtVZnBucGtKb212KytpVXVmSTk2M3g1YXluSkpiUHp5a2YvdUx0dkVt?=
 =?utf-8?B?VDA2ci9IVVpTR2hVTTRUYjFOZCtNUERsUmxBRFBJVlhyZHpDUFhPVU1vbFZM?=
 =?utf-8?B?QlY0YzhPaGphdWdsYytURnRNMmJDTk9xZGkxZ05GSFVCVWtqM09SSko5S1FJ?=
 =?utf-8?B?UHpiaWRZSEFvN3J5MCtzRDUxUWE3dHZxRTNZWUx3cisxVTFobDZvTGRqM0U1?=
 =?utf-8?B?SGIveDYxZDIvZmQ1N0grNjJvMlZ1RWJkUUE1bTdKaFpuU3FjYzNMQnJBNVM2?=
 =?utf-8?B?M2hTbmkxaER2WjBYZXNtNnhvQVNHR0haRS9UUmg4SEVYZTZuc0R5SHFPWkZv?=
 =?utf-8?B?c0RDRzdTZFV1aC9FempCWW8xZTduRkVWZFlFTVN3QkFTa0R5L2FYZmY4ekdZ?=
 =?utf-8?B?YTVLVWlpbmNGK3RhcTEvZTZSUDRmLzl1SWVwR0FRa0xJUmJEZkcweEYzcVF2?=
 =?utf-8?B?U2RhSkNocDhwMzJtNS9wb2ViVG9GbjlxeW9ueUVYb3hKaFROQnpJY1BJNytH?=
 =?utf-8?B?enBIRXdjcG05QkFid0VVRS9UTWJlVjhmVkM2b25hSWpKSXdieTZTM05MVElt?=
 =?utf-8?B?QWszUUM3ZlpveDlvWjlMajYyaGQ4eXJCMFZBYlV4Z29rZTQxcS8vTFRUR1o3?=
 =?utf-8?B?OE5wOWFqRWtvb1RnTFMyalhMWlc4Njh1M2FyRktJZWphVnZOQkNCeDkzMzJn?=
 =?utf-8?B?SStwRkhYVnBFbklBWmR5WXJHM0d3VkZUTWtlZnVueEJQODFKTFZSdlpRZmJt?=
 =?utf-8?B?d2llVEtEWUxxZkUrNVExRzVNS1BOVkdXTktXRE1vcTJ2RTRyTituNDdaYlEy?=
 =?utf-8?B?Qzd6eUV4V1VqUUdlZFpmeWF2MWtaRUMwMnNNcHJyajQ1ODNjR09mcHZ1c3cx?=
 =?utf-8?B?NXFpbE5TeWdzU1RnRnkyZEFlYTdONDFNMUNodzVBMGtwWXpkcU5XUkJKbTBK?=
 =?utf-8?B?WlIvMmZzWjZtb2w4VDZ3d25sYUs2c2RlMzNCdXhCYjZwTWo3Sit2NnNSYTBT?=
 =?utf-8?B?bU9qcElmYXlnWFJVQnB5Y3pHSVJHbW5rQVR5UysxK1ArZTVqMWRHd0dGczh3?=
 =?utf-8?B?T0YwVzVNTjhvbHZnL1M1NXBoTEJEdXJiMGxCSHZ5OXIxcFpZWVp2eEdmQnQ3?=
 =?utf-8?B?eWRNY0pzRHVVT0NYMEJHLzd4V1p5eWc0eWk0dUVTdm1GN2s5bENmcTcxVis2?=
 =?utf-8?B?VmRIbDhaUlM5NVBrSWd2S0JiZ254dXNPTkxTMlRHMFJKTlp1OUtTK1FnMVZr?=
 =?utf-8?B?N0FFeVRFczJ4c0NCa3lnVFlJaGdQNXhMZURiWFdrcW1xckpLZzdPc1MrYXJ5?=
 =?utf-8?B?U3BScEJCTUtYcTdYSEQrSXhhYkdWT3dPVmRORGthS0RNRnlYbzEwRGZnbHFl?=
 =?utf-8?B?VlBLL05TZnhHVXhTYy9xc1NHS001MDROU3BaYXpxb0J0Q0dHV08ySm9PS25J?=
 =?utf-8?B?WitiWnNCOW13Yjk4T1NiOXU4cUU1VHFQblVQT2hmbWpnOWlUeGt3VmgxNHJU?=
 =?utf-8?B?aGxUTkIzak93ZUI4Mlo2MUVsYXFKYnFGck96MUdjNzM4M0t0d2M0K3BObHJa?=
 =?utf-8?B?dmdFWEJuWWVpUEdQNUZZMmlMa0RrMnU2cVBWczNaemJGeWlCKzVHMVlrQnRr?=
 =?utf-8?B?dDU3Y29BMmVFemluZndUaXc1OENJRGY4dzluUGpvQ1RnK3VXd1gwd1JEZS9V?=
 =?utf-8?Q?6a2SzqhpbwCtiZhFpRdgdeahwItuWC9XFknIT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5c883e-28f4-425b-fd97-08dedbdbcbb5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 03:56:59.6868 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OH1IIf8M4k/ibONtuU8eGh0Sqw8gGKN6FgvV4oyAZigzanxiQutHdui8GD31Z6DLpOx3j48WDSR+tD4GjGkidKeEOPX5nnc8d0WD/pI3QIf6ceo05fDFNtgrjzOqgKUS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11235
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

This series adds 1G SGMII support for i.MX952.

This series depends on the i.MX95 SGMII support series.
Link:
https://patchwork.ozlabs.org/project/uboot/patch/20260707-imx95-v1-1-5b4b0f03d5e3@nxp.com/

CI:
https://github.com/u-boot/u-boot/pull/1007/checks

This series depends on the i.MX95 SGMII support series being applied
first. This series is based on the current u-boot/next branch.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (3):
      net: fsl_enetc: xpcs_phy: access PMA/PCS via MDIO_MMD_VEND2 on i.MX952
      net: fsl_enetc_xpcs_phy: Add 1G SGMII speed mode for i.MX952
      net: fsl_enetc: Add SGMII mode support for i.MX952

 drivers/net/fsl_enetc.c          |   4 +
 drivers/net/fsl_enetc.h          |   1 +
 drivers/net/fsl_enetc_xpcs_phy.c | 294 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 295 insertions(+), 4 deletions(-)
---
base-commit: 6e79ea7417e823c4419893b07777d3375e5c8f22
change-id: 20260707-imx952-68a0f709064b

Best regards,
--  
Alice Guo <alice.guo@nxp.com>

