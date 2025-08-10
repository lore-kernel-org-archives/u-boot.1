Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D948CA0EDC
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 11:05:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24A868211F;
	Wed, 20 Aug 2025 13:05:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IcnQNH4p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28E1B82B07; Wed, 20 Aug 2025 13:05:15 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAFD0801DD
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 13:05:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZuigMtzgVoDW+Zkji1XBFN4DuCESP4FgnvSCY16+nggAsZXjt1Uy5lPNe/dfiqnzIPXA8+RTzuni7p/FJGAbT6ubNNGCKhBQQRSl1gFgabkxeT18NTa0kBOF92g9gmpmMzoA1nHCm27Gww/XFA5T5awmSP6UDVSK49tWFUSsGPnznBH8se2rUTWqf1vHJzy82P0yc+VKV2sT/VtkU/pH7Fl9DI2FS7VcXYuK5e5iMhLKYoySYa/Xh1cLAghaxM93TPL4JK6H2oJm+9oQR0/AHhpyyVt5+4ed7CXkQ+Uu0R+Ii/a7Byn65UVRukWsRCOSZzb5Aj1urdvF7NC8fC+NtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=reiWdL17QpKJfFGt35PrSVcwqo4khvX1fO3Rh2tCuu8=;
 b=Mab2SmlhrR2sVz8nWJcsUgOtygFLaFol6zZbW2VzP4kSmlDPE8yT6p1KtnQYhPGUnh+lifIIIo2uIyFlDVsE9KFnICCPAE5kDNdS494MC2wz4zMIovRUsb1S9yfe/0LINWQpOns+LyZt2ITAcq70Gx9HIQauYY9dYPihopiZ0EgkkXpvCf9QF2JvBMVtcLiK5f9b0HSdInMTinvCHNOSBx68Q0chu4MKNy+6b1fR/STLtKTZr1SyGdhbt+Jpdpg5LSpoK/p5uAqLre0p4BcYeztw5Xk4m4JB8+e/2QxaUTtKbHbbx8GRhqZ7Q9yO0XZ6OnDpm2lfAzQ3kf7VhKy2Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=reiWdL17QpKJfFGt35PrSVcwqo4khvX1fO3Rh2tCuu8=;
 b=IcnQNH4p7GGnmphlGp+Vm1H2M1EgFwELcZGsSgosxpduN3Knabt/yTvVEvZN+vhPTKAcRGhOWG7t7esdfXstkeE29PHVKbctOxB3GJZ0mRBw+1gqZ+DJEXO6XoTdxkGuF43bmHkHjYaZGQFHbSIlgI2HqdM8yV218pLoVqyRwXEsPGNynml6Rw05RNJnPXCuoYId9Suk4ZCG0OgNpKj6wynQ8TKE+svL4gRpKotMCSxucxG+O3MVeZ0RV2ob4id0YRVdFI+Z7yMM7+GpNEPOJJpvF+71Q6gc51rTqm0NA01hpMa0XaaeQltP4RZChU/C7yR3E6UJ4ha7HnV439V4vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB10364.eurprd04.prod.outlook.com (2603:10a6:10:560::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 11:05:07 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 11:05:07 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Subject: [PATCH v3 0/2] Restore support for i.MX95 A0 silicon
Date: Mon, 11 Aug 2025 05:59:34 +0800
Message-Id: <20250811-imx95-v1-0-569d8014172f@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEYWmWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCwNL3czcCktTXUODJNMkQ4tUg8QUcyWg2oKi1LTMCrA50UplxkqxtbU
 AXvvv7lsAAAA=
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR03CA0120.apcprd03.prod.outlook.com
 (2603:1096:4:91::24) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB10364:EE_
X-MS-Office365-Filtering-Correlation-Id: 27de00ea-985e-437f-b539-08dddfd96c06
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|19092799006|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGVCeG5WUFk5L3VhV0tjVGZXdlNXdXI1aG1Lb2prV1VOQjdqL3U0QkszTUR0?=
 =?utf-8?B?Mkl2TzIwZjVrMFp2dHhvNEFJZi9xQ0VudTQ1VDdLRFdralRSRVJCVWJSazBw?=
 =?utf-8?B?UVRreUFlR1A5b3ZGT0NrcUwvOTVTeXE2TTRRZE5pMkNHOVlFdXYxSFB6V1VG?=
 =?utf-8?B?NmY4ZzlkOWozUzRCSSt1eXFIaGRhZlh3NmJVZlhIcnZxQ1p5YUhHZGVpN3F4?=
 =?utf-8?B?VWJsREFaaXg2Q25iVThwYkZNV2EwQmFGcDBuZ2NmUHZOVHMzQVJlRzlzYUtJ?=
 =?utf-8?B?Z0NLQXBpZ2VjK3VVQWdTS3FvWHVUbEhsSDlRTFFTUWN6SlArM1R5RVpnYVpt?=
 =?utf-8?B?dHRWM1lya1JNOExRRFlBTGtCUk00b3dkc05IZEE2eTYrTEhoWWxhdWw3eC9X?=
 =?utf-8?B?U0tGR056ZjBGVFQvSndUZFhERGlCOUZZcnQ4UFJnMTAzaWlFZE03STlLOVRB?=
 =?utf-8?B?a3ZoaFp3dHlzaTNHT0Z4djl2WHljMng0WUYyMWlsOUFBTWJUNDhMaTl5ck8y?=
 =?utf-8?B?VlRiOWNPZ1kwQzB6VGZ0RjdMeUxrTnlKZ1dNdi9EVC91ckR2M2hDZFlWRE9L?=
 =?utf-8?B?TXRDbDhaRnZXakFSVWZZeHdtMWEzYjUzMmhCZU5mWnVCWnRKbTFFOVhabUFa?=
 =?utf-8?B?UUZvMGJsZS8zMS9IZ3lvS3RTMzBxdmx1SEdxdGk0WldSZ1F3Q0wvWHI4bGww?=
 =?utf-8?B?N09TNExXUXkrakVzSktaUVZRM29QZFZvenRkdW5YeGpPUG5PNnR4QWxpeDUy?=
 =?utf-8?B?NUs3NTQzbW9YSlkvb0hOR0FDeFNaVzc5UE00OStZbjU0dHZwTjdlZEZxL1Nl?=
 =?utf-8?B?enpmVTIyMm5iUGh0RHZ4Qm5hdmRETVUvVGg1c2h1aGkvTFdrNFd4Mzd2Tmtk?=
 =?utf-8?B?ODVQOFhhOWJEYU45U2JVWHV3eW13cVdTdTNOaFJWeTZ4RW1IYmlqMlJ4Njhz?=
 =?utf-8?B?RGIrSDdPcmFOU2VjSi9XY0ZVQkF0MlFoMjFaWUtoTS93VXNxKy83TkY5MWxC?=
 =?utf-8?B?OStUUnVKeTFLdG5YYW4vYjN5RzRqS1lxVVQxV21lRHZxM2ZqVGZyQ1hiZXNs?=
 =?utf-8?B?SWFjMXVzL3cwdy9mRFRqejJCeE1NM25aQU9RRlhpNzRQVkxXeTExRkF5RytJ?=
 =?utf-8?B?Qmw1dTdpUEp3ZUQrMWpYWERoa1FTR3cvT3BUTWpzREc5OWVxWGpJOU9zbEVz?=
 =?utf-8?B?ME9LQjhraFhjaE4yRlNuRmpuTnk5VnBYL0E1STF4MGpBOGgxdUtxR3U0OUtB?=
 =?utf-8?B?eVZ6TkNTS3llU0JQczVnamxRSUIzNnlXcmpMa0lqNlNXOVNkL2JWaWFwbFRC?=
 =?utf-8?B?dEZ2VmtGTWkrV3M2Uzd0KzJXYTBHZ3IyRFE1YWo5SmswcDFycjc0eC9jQ0pv?=
 =?utf-8?B?dG9Jc2dEUVBXUVJlekpMWFhDc29EQzBvWG9MbVJma1BhcTNXa0V1WS9oVUVh?=
 =?utf-8?B?YlBINzAxMjh6ejU3RUxkS1RobWcwbmVYUmNiMGVZRWJFMzZaRS84M3NqTnJ1?=
 =?utf-8?B?NFlyS21KUk02aW9GNHA1Ulg2TkVVRW56ckNMaGVaN09QYmlPdDh2S3NEeDhT?=
 =?utf-8?B?a2w2MjkyU2VVVG1pSSsrRWM1UjRKTHNCU2V5WiszOFBQOCtLWVd4VXlhd1Nx?=
 =?utf-8?B?SVhzbTZxZ3RlNHJJaFNhMWROMlQ1azZQQ2ZqcTA4UGxnandCbUZ2cW4rYXI1?=
 =?utf-8?B?dFJwM1hxTEQySFVXQk0zbVdxSldmcmo0a2Fob2dYWlUwWHJNdHI0anlLRTR6?=
 =?utf-8?B?WGUvaGdKK1ZwMTRON09LcVpzcmFZUHQ3VngvTVZURXZQYzFhVE1vTlpldGMr?=
 =?utf-8?B?bkRrVy9WOHJUSXlDWUJ3K0FIemlITVIrWnNNcVJicTVzK1AxUm52SFZQclFM?=
 =?utf-8?B?bjFZaDdrYXZ6Qm5uMXcrMlg5dC9ScE56eUM0UW9aNVp5STB4TnpISk0xR1V5?=
 =?utf-8?B?UU9waUt6L2VEak1yREFmWklhUWFWdHhQSlFMMkpmSmszYldMN3VyNUVSbFFv?=
 =?utf-8?B?b3pYYk9hRnB3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUQza1pUTlN0S0hwT3BVRE9SemIzL2JELzNEeU02eHdsYkNES2NtVTJITEJE?=
 =?utf-8?B?dnhIa0l1ekJjNXZpSlVJU0l6SThzRExsbGx3c2p3WmRuMHpTVlRZNTdtNWM4?=
 =?utf-8?B?UUF2d0JhaXI2QW1VMVlSeGlFZHIrbHVtUm9qbnBUOEJvRHd5YUplQVFvUUFM?=
 =?utf-8?B?OWIzYWJabVNFdTc4dCtnNENtcEZkMjJ1S2ZoTm05ZVFVblR0ZllNNDM4cGZj?=
 =?utf-8?B?R3JRcXNNendCMDhGVUhCR0Zsd3RnZktnWjVMK001SFJaeFZ3NUJDS0tId2Iv?=
 =?utf-8?B?YkcwV2gza2R3NEkxR2MwTjJNc1JoWG1GU0JxOU1tUTNrSUZ1VnhSQ3RaaVRB?=
 =?utf-8?B?cVdBeVFtMnBpUm5EQjhqd1Y5K0NnY0IwZ0ltMi8xUFdPY3dPbVkrNzBockNr?=
 =?utf-8?B?QlVDWExTSDVoTXNMQzJwc1A5Vm94a0EzdXBrYTlLNDl5aWpUK05PYTVQRzhF?=
 =?utf-8?B?ckxGYVlVTE5DQUs5ZzUwckQvS01ud2RjY3JrVXpKS2VzNlVrazduUkpkYVhz?=
 =?utf-8?B?dno1UUVZRTNPSVFjVUhsazBya1RPNmNjNkxhUXFJT2ZZcnNDTzJiMi90MDBC?=
 =?utf-8?B?N2ZDWXFoZjMxaGxvYlZzSXR1NEVCZjByV3ZOTzJFVUl3N3dzSUNvcGUzbzhJ?=
 =?utf-8?B?cUpHTkVmTzZkS2k2WmZiMTVJVXV2dnd1U01iQjhWeVF6cVZKR0hrbG1jSFZZ?=
 =?utf-8?B?cHQydDNpay8ySzFFM0hRaGZmVFBOek9yYm9DLzc4bEVkeG9kcjZVV1RTelZ6?=
 =?utf-8?B?aVBxZ1NzcmpDQmFnTkM2MGVXOWRraE1MMXltR242eHlMTnM0Sys3MnYwRkJX?=
 =?utf-8?B?Y0pWenFCdnZvWTAzejJFcWZHQ0pIWjNmNHdDcFY2VFNhaVo1Q2p4Rno4SkQ4?=
 =?utf-8?B?T2ZjNWExM2FDR2Y4NVJYOXZIcjQ2dDRuMXM4N2xEWmVrM3FLOXFoV3RKb2ZY?=
 =?utf-8?B?UFl6Q0hyTlJXOTZSWEhpckhMbUMydVhXeERXeFRHZ3BycVFuMlVGdm9ueDVN?=
 =?utf-8?B?emtsUEp3TXlKRm5hTlN0bTB3VDlRekxOb3p0ZFVEVE1ScTc0VjE0Ly9Eaitp?=
 =?utf-8?B?eEs2U3JvVHU5cWVxVEVCditzcUk3NTB5ZTg4aW5sdjRqU3FSR2h0N01xTGU4?=
 =?utf-8?B?VHRoNDVYRlZiMUpLL0JZWk1UVXIrN3RmdHY5cXRCK1hjN3JHc1ZNQ3Nsa1VD?=
 =?utf-8?B?MElYM2JsYXhBVTdoTXQxcHJXWFh0Uis2N0gvQjZwWm5salR0a2NFSWxxV3Ja?=
 =?utf-8?B?eno3OERPSEhZKzFXMktzNXZrZlRCdWZjZGNpd1QwMVlDK2VQazBWUmlOQUd0?=
 =?utf-8?B?MjZaTng3QmU2SnZndG1XdkZlWXFrdlc0RGo1eisySXh0cDJ4QkV1MmRzZFR1?=
 =?utf-8?B?SkROZ05vU3dxRDFqUGtSY3M5YWkzbDE2TDh0RkpDZXZIdVc3MzU0dDVUYk1C?=
 =?utf-8?B?dmMzMFBzVm5jaStyOVl1Q3Z2akVWSjVoYlBWVkJpWHV2YnpjVkY0eWhmb3Zh?=
 =?utf-8?B?SWdkRlg1clc4QkpjUm1HTnJSY0NWTTcvaStyUkwwK2RNY2hMQk5FTitwTFBO?=
 =?utf-8?B?VkVWUUZjQzEvZkVRVHA2bHFRU090QXlNd1hENE0rWlRRTHpjaW0wVHJPVmRQ?=
 =?utf-8?B?ckpmcFp1UEc5OW5HVkZDRThzSmtZSE9pc0tYckFheXhUTzg2RnpKdGZBampt?=
 =?utf-8?B?aVd1MVZiRnJQNG9adThsTnJmeVFGUUxMdmtUYzZHdEp5Q04zTVdneExsNU4v?=
 =?utf-8?B?MjRJMXVxeXZwdDVaSFduYWVmV3VjUFFuQnVRN2lpRXc1SXB3bE9uVjU0dVNL?=
 =?utf-8?B?U01ncm5pUWZla0tCVnl4MHNnWGtQOUFSbk5uRGlIdTRsM1VtanV1dGpYTDgv?=
 =?utf-8?B?NzgvZjFWUm9yUWptTDhqTUdHckswRjJHUVMyWXZCNUZWYW9pUElNVlhiVnRx?=
 =?utf-8?B?YXJJSU1WL2w4cHlST1NWREdhbGtaTmdhclE5dFFva28vZkpNNG1YZm5HQTBS?=
 =?utf-8?B?V3VaNk5vSWdzVkkyR2U5YTlkeXpBWGJVZ0FqTU9XNlJLZHN6ZkFPdGxCeDUw?=
 =?utf-8?B?OWtPcm5XZWFFN2FKQXIwbnlkcXBoOGdEM01ORzRxYzBpQkRwTFhTRnBhU2NO?=
 =?utf-8?Q?4FKFjTrv2ctrIwz8P0cihteXd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27de00ea-985e-437f-b539-08dddfd96c06
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 11:05:07.2561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gATsF2lcTtyYJB4P1oe8rxl2T27GqYrrHJnyKRFJ2+1mk9d6wgWyvjyxm8W6530d2U+kF9qa+hB5AtwrkltQ3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10364
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

Changes for v3:
 - update the binman etype to generate a configuration file and a .bin
   file
 - update Get ahab-container.img in imx95_evk.rst
 - rename configs/imx95.config to configs/imx95_evk.config

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (2):
      binman: add a new entry type to support .bin file generation for the i.MX95 platform
      imx95_evk: Restore support for i.MX95 A0 silicon

 Makefile                                  |   3 +-
 arch/arm/dts/imx95-u-boot.dtsi            |  44 +++++++--
 arch/arm/mach-imx/Makefile                |   5 +
 arch/arm/mach-imx/imx9/Kconfig            |   5 +-
 arch/arm/mach-imx/imx9/scmi/container.cfg |  11 ---
 arch/arm/mach-imx/imx9/scmi/imximage.cfg  |  16 ----
 board/freescale/imx95_evk/MAINTAINERS     |   1 +
 configs/imx95_19x19_evk_defconfig         | 153 +-----------------------------
 configs/imx95_a0_19x19_evk_defconfig      |   2 +
 configs/imx95_evk.config                  | 150 +++++++++++++++++++++++++++++
 doc/board/nxp/imx95_evk.rst               |  42 +++++++-
 tools/binman/entries.rst                  |  12 +++
 tools/binman/etype/nxp_imx9image.py       |  85 +++++++++++++++++
 13 files changed, 338 insertions(+), 191 deletions(-)
---
base-commit: 0c558bbad9e7581808b358091d1fd979f860e8ac
change-id: 20250809-imx95-10b5b18e0ad7

Best regards,
-- 
Alice Guo <alice.guo@oss.nxp.com>

