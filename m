Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C4AD358E8
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 09:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03F7D83DA9;
	Thu, 29 Jan 2026 10:10:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IobHf4tW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27BEA83D9C; Thu, 29 Jan 2026 10:10:36 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCA0783CD3
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 10:10:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TK7mZxhPk0dTZ4tZE5BJKCJ1u64MBs9JbNAt57OArBxDeBjOxN99637TUAQNV1TJtiyIv84jUUvenkjJQJIFOGXMoZggYV6pI8jQWq3l+xnnhhcE3dX8pUl4KWFeHuXyLSqCU2D2fmZdiVOyuDib/UXJ7N1H+8DtAnoSnoT9Pvw+lAjyBvEAlWk+dCYZjlL4afessPZmBcfFymonFuhHb8Q/IJstouTZsxl8o4+hnbYRAITNdRRpOXmBx5CTPQtIBRboo0Uzgh+9zI7wvOzFBuZq9MqeJ5YSq9oiTWV4tZZVa/Icp68CPOR+OhCBIFezVY2qoI/84/NdNICjT7sjsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zb+7T7oxOvHkQrNEfv+d3mcSOFlONpro8UzanXX6Dwg=;
 b=tnh6ARVJ9eD08cCCJE/6h8m2tJicjZSgxTRMBH0UIQcuWBmTPrmf9U1R/QpplD4S195i/wpLSL9fal1BrFp/dJjvJtzMti/M0ERYUDmQ3T7inNkzYYX1Yv2jfwvnYPdWKrFCrjsCEb6kQYamq/6GB8UGHQeujtG60qSf6Z8zmghAe+Pchi33cM5+REWg9slHQZBfZeErQQXRR73RtjvZ391V+rtzURpsfkIrGt++kBl/iFaSVmLM32qhtoe57Qkyk6JziJfQyXhIbZsjy/9kYnC7tUFjofdAm4EuhmiofsaTozOmikXzvATuJLW5zaI6N7caIBmrLGBE/v+KYa1cUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zb+7T7oxOvHkQrNEfv+d3mcSOFlONpro8UzanXX6Dwg=;
 b=IobHf4tWtPwgK8jz45ZGEh2EiKu5Pz3T3VPbrmnmD7TXmjIsanQunOEoQs/t4iYurOdhMa+MMlmnqOeYJiR0f/MY3RMItYOTXgqEc7Jjv8nEc0XAPSNOimt1n8CP1/6pYuMmJe7RNLPPmMsK+CI2vudxvJOoxvlnXQaP00blPIRi6MY22tL1W5q2Df/Zy2ZxFiMHByrSd1u7MsBQs1wEhaKR3pv7OW3OW4HrHh4Y+bl1sE6Ol0rJEraandTJma3NetNnc2yHo8UuHptshLz9VD/mxJDjueikVuINm54AYAkaGneyXKGfPGgktfbNbb0wx0wuncnoIMeBkgMRH0ewWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PR3PR04MB7484.eurprd04.prod.outlook.com (2603:10a6:102:8d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 29 Jan
 2026 09:10:29 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 09:10:29 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 29 Jan 2026 18:24:58 +0800
Subject: [PATCH 2/4] remoteproc: imx: Add i.MX95 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260129-imx95-rproc-v1-2-035b2dbf3e57@nxp.com>
References: <20260129-imx95-rproc-v1-0-035b2dbf3e57@nxp.com>
In-Reply-To: <20260129-imx95-rproc-v1-0-035b2dbf3e57@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PR3PR04MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: 806960f5-fcb2-419f-7c9c-08de5f163f72
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDNDejEyYUtxZUk4azBTMFJFMnBtdU1zdmZZVW5KcUdtQ0k2bDJDaURMVWI4?=
 =?utf-8?B?c3pCNk5BdThIb2hTR3kyMm96VFYza29NMDFHWHNKZnJjNWE3QTg1TXFxeUN6?=
 =?utf-8?B?dHRleERMQjlpbE1rMEZhRjE3d0hIUUdBMHV1RmlKMmtJVmp3OFE3Vm5MMmNW?=
 =?utf-8?B?ZXYyMmhqc0dFUU1uVGdLcjEwNnc4L1RJQUExeUwzdnRuS2dyOGVzRGk5cnVC?=
 =?utf-8?B?VUlXcEx3cXc0NU9NeSt4QTZIMUlQcmpCSjBZSSt1d1l6UzZPaU5id09YQ2FM?=
 =?utf-8?B?MkJ2TjNEbUFIWjllT0s5bmtaZVBocmZud1dadmNHdmRmUEhURitrbDgyMXFK?=
 =?utf-8?B?QnFLbXFLelNXMjVjd3FIVjIyUFhpdi94UmtOSjg0aHR5TGhtbDQ1aFFhVFUw?=
 =?utf-8?B?YjYzYzZFVHc0b1BIMXVQNmw2WlVLTm9ESUF5RTB0bUNHeHZoS1ZoZVlyU2Zx?=
 =?utf-8?B?Wk9vVnd6V3N0alZmSDZkb09qbEZqY2RkL3NTWDU0TFFQVmZ2eVNMS3ZWVnB6?=
 =?utf-8?B?UHVSQytIRHdWVmtMcW91Q2pKVmxYbHZCbWgwWCtqRXhlNFRSYjZlbTlrYUtY?=
 =?utf-8?B?RWUycE9RVzZmM1ZrSmcxeDkzNi9ldEpMSlFRL1R2Y0VmWjZTK2J3dFJ6Skph?=
 =?utf-8?B?SzhpR0YzcHlONm5WOEdvSGJZSWVEZFh1YzhpL1hOU1hlNGRPOFc1UlZGeCta?=
 =?utf-8?B?Mmc5M0lzaGQrUFNVTWNCYTduRFRrdDVZK3JDT0xLbkxyMnhUbEl4aFlqT28v?=
 =?utf-8?B?d0VyTHFESUZkd0JDVmxBOVNkSldyV2ttQzlTOFhXVDAvVU1GY09sM3I3R3B3?=
 =?utf-8?B?VHJackVMZUJsNkpKSmU3TENzVFhPT01yV05RZWFmbFo2WnFWdFpPNmxpY1E2?=
 =?utf-8?B?Mk5oZmNGMGU1SmVJMHcvUHdDR0NGdFFsZEordHI4QWtKVjFZb256M2ZuM3g2?=
 =?utf-8?B?cW5ZSHVyMU93Sm1nRnJ3a0QrSCtNam5sUlhib3hlbkZhNlBjUE1wd09EUVc2?=
 =?utf-8?B?UDFnZVlEa09veEVGKzNJb3dQSXE3TjJrNHNvQmVOZTNrUHVGSDhzbWdITnpR?=
 =?utf-8?B?S0ZrTXVuUko3c1lGc21kdTJONCtnVUkzY1QvbHBvZkNQMjBPdm9hU1ZjaVFW?=
 =?utf-8?B?dFZzQlUvU29YME51RUh4c28vUGFiNEQ4bmx5R01SbHBYRmFpZE5JRFJ2R1pP?=
 =?utf-8?B?T2FHWEdRbUl1bkR3M0g2ZG5NaU8vVHlOQWNIYURIZVRpQ3hjcmd1ZmlPbG9w?=
 =?utf-8?B?SHdCNGJnZkEzOHA0V0tUdWZHQzdpcEIrSENmTFBPaXBoeGk5K21icDM5NmdJ?=
 =?utf-8?B?M1Q3TUZqcFA5MWRpNkxoRjNXV0hzV21UVmcyQnNUd2o4QmY0bnBOYlhDYWh1?=
 =?utf-8?B?d09lMmZVSW10M2xIdmVDa1Q2N2dFaW1VaHZnaWtMalBIbmdhcTNYd1VQSE9N?=
 =?utf-8?B?TFdVWjZsSU5QVnlQaDFKQnl5QW1LMGo0V2txbXMxcGlBL045S2w0NjlhTXRT?=
 =?utf-8?B?UWYyaXc0QUxyVW5rOXpUWHpjUXA5TkZvdzdjWS9UZXE2SUlCeHpPVDhvbzNu?=
 =?utf-8?B?WWhnU1liVzZrZFZQTC80Mk1peVczSW9CWGJFZ0RnbHZiSHRNNDM4a2JVR3A0?=
 =?utf-8?B?aGxNbldLdWlVdTVyTFZrcE9iVW9vNDgyK013ZVVjWWwydW5FVVpSenVkS2NO?=
 =?utf-8?B?bDBZUk5ZOU16dWNDcmthNk5RMlBCUmdoUXVOL1dvY0pteXZlZk9vRjlnR1d1?=
 =?utf-8?B?RmtDQW9JOWtIc0Q5NXJQelRHdnVEN1Z1RXJaNDlaRjU0eU84bGU4UDJvSnFq?=
 =?utf-8?B?ZGR0RUx4dXN2bmJ5d0hXa2ZQYjhHZ2Q2bm03N08xMW4vczN5OTlXRGpoSWhH?=
 =?utf-8?B?d0xCU0VoWm9KaHZITllXNjdBRTEvekliMExWT0duRWNqY0UyTmlkSWl6cTEx?=
 =?utf-8?B?NG8weG9LbDdpbzhwU0VBNi90Y28wUU8xS3JkMHBtcThPMTY2RnVTMDN4Wms4?=
 =?utf-8?B?QnhJaTdIaXgzZnl6VzBlMUM0Nm5VTkNzb0o4eVZxZlVIT0owc2ZlTG5TaEtF?=
 =?utf-8?B?VzUwY2htSytMTGN1NGNIbHFDTCs2L0RGMk1ZSFZOKzZkeXJOSW9KR1NkZ1c4?=
 =?utf-8?B?S1BSSHNaMlN4TVVyR25wZUsvRzFBZmdJaVVVSUV6ZTlHSE1LWkVtYVRiR0hF?=
 =?utf-8?Q?HCGiyp4kLdbhdmMiof6huLA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUlKTGhDUlg1NFlQSUFBdHUvZWZWUk5jQnZldFpWZko3ZVRUcHV5cHZESi91?=
 =?utf-8?B?TXR1NUJYeXUxS0xpaWFEQk9SSklJRk5oQWxVWnFGbEpFQXZEUGJhL3lSNVJw?=
 =?utf-8?B?MGNyVXNSNkZkeEtDcXF3YlhOMFU4dHk1SWlvNi9vbURoaDdOc0hRRjBnRWZa?=
 =?utf-8?B?VWJkKy8xS3B1WkNNb0VqbUhGRzg3RjZIUm05SVRtbXZmQmRWRENrTTdaM2ZF?=
 =?utf-8?B?Q2NQQlNkWXZPMVBqNlMvRkhUdUdIQlJ5REozK0VzTlRJTUFKOG9nTDRIZFdT?=
 =?utf-8?B?QUNUZUdWVWM0c0g3RmtLdEU1RnhsYkNUUkQ3VEt6TW9rTXFKTDBmWWNKQ0s5?=
 =?utf-8?B?UXpjdHpmQjU2QjltelZQbEJPY1JjRFp3SmMyb3o3MHpBMlVOV1VJNGcrQm1Z?=
 =?utf-8?B?LzNGT1dsdkhDL0FGSDdsOXhWWnFhZzF1c3dGek5yQVRCcHBVSDhXcSswWEJw?=
 =?utf-8?B?ZkNnZkNZcEY2TU93RHRJM3FONDc5bGxVTzdMWGVDUTVoa3g5Vyt2akdDMCtT?=
 =?utf-8?B?YkFoNkt1MFNqSHcrdzZsekV4L3RjMVpYdGt0R1YxQ1FhajNPNmdDRVpqM3VO?=
 =?utf-8?B?SEhLWXZOMEk1MmJNMUdzM3lSVXE3VVRPVXlENVIycUhNSXZDVTdyRTRLdG1t?=
 =?utf-8?B?aUdyd2ZKb25lK3VWRUdNY2k3R0FHQ2xhM0hpVDQ4R1I1QnBxK2RaNTNUMGFk?=
 =?utf-8?B?Wm42WjlwS1J4S0tzUjFZbUJTWWN1SEZWNytaTnJOQ2hSdGl6akJocDNGUURp?=
 =?utf-8?B?NXlwZ3BTR0g1ZDUxem9RUGxBQTh6SFNKQXVLdkVYQmdaTU1XYXRZSEorVHdS?=
 =?utf-8?B?YkVpOEQzajU0N3Z2L3ZScVlTeGZOVFpzVU1FeUdCRnpTdG12UUZQekxkM2gy?=
 =?utf-8?B?dTExeUNvTW50KzdlZW9OMEIzWFNURUZiUHJwZXdFVGVuTG9JUmlRSUdSMFBQ?=
 =?utf-8?B?eHI2RENCdnpRVHFhM2R1RGlMYWluY3lDZEx3a2o0ZU0wVzJjUktTaEo1Y0ky?=
 =?utf-8?B?c3hjbmFEYTlIVEJBT2szR0VRd1ArVU84dHNsdUFLZHFWOXhyZWxjT0tQN1F3?=
 =?utf-8?B?dXo3TXJud0dtSHlTakVMeFJIeXI3OGwwNjJWRVl0Z1p0cXJqME5Ia1A4Z0hv?=
 =?utf-8?B?Rm9OMG9uVmx0ZWJ6d3NyWUJaQ3RpczUvbU9FenE4Q0VYaWcyTks5a0N5dzdG?=
 =?utf-8?B?eU8rVHM2ZXFYNTM4bG0rTTRaN1R2bXFjWEUydC9sU1hGOWYxZjlhNEdyOHQr?=
 =?utf-8?B?TkFlTUpYVnoza3BuRXNYWkovalJhbFZEL0JUamhtNk1TVEpoZzFLTmE0TEJ3?=
 =?utf-8?B?RDRJL3hFMGlMcitUbVQ4anZHNkZaWU1EdHVhNDE0ZS93SExJdmF2VkxKd2dO?=
 =?utf-8?B?aHVmMnNmK0RxeW1TTVFtV1hnQkZ0WEEvUnF6TVJqZFJYOXJ5TjFkTy9oQU1y?=
 =?utf-8?B?SDJSdVJRT2ZSc3hXS0k2TUs3Y2xzZ0I5MmFJbDhTUmh4L0gwc3FiMlY1MGxj?=
 =?utf-8?B?dkZmbXZwR1pBNjM4aFVaYTh4TGd6NzVJRDJVV1Z2K2lrdlBkNDZ4MElqOHc5?=
 =?utf-8?B?dmNsdGhZbWJKb1BUeXFMZGc4RXpMWGdIcDVJS0k0Y0RmaUtjYnFtZzJtK1Iw?=
 =?utf-8?B?ZDk5bHhpRTJxWUorVlNUK3BrV2RQNFllTDJZTEs1TFRKamR0dzh4V3VFTnhY?=
 =?utf-8?B?Tk1rbjJmdzAxUERDaWhKVlZHZVV6Z0l1WkhRQkVGaWpGR1lka0N2QjQzdGl1?=
 =?utf-8?B?b0dMaHhCemFKd3phWTJpRTJrUnZlVjVhaWhwakt4ZGJWaDBMcXl1amhRQU1E?=
 =?utf-8?B?czMrckd5ejlHNTR4QVB1aHo1ZktWblhZV3gzN0xoZlBJTjZxL0VVeGxFNEsw?=
 =?utf-8?B?bXByMDc3a1djTHNpOGc0aWY3Y2cwVXZJVzYzd0RpL3N5WVBDNm5DZWRRVUt6?=
 =?utf-8?B?RGVIU3p6Y0lzN0tFM1h1Yk5nbUFrOGZiV1BDTkNvTVVxUnlUVnFBQ09oalNq?=
 =?utf-8?B?SXk5ZmkzQk9CSkRvdHZmSHZGa3Y2N1dwSmFqMWtpOGc0NCtRdTk3bkh2MFVD?=
 =?utf-8?B?dC96R3NpaVphKytXVWFZcGhaNWNlWjlDMmtJQ0NyVll3RURoSnJKelp0ZVc4?=
 =?utf-8?B?YkJHSzNzYTdVN2I1QW9mbVI3TE9PNTdJeHJtOVhVdFNJTlg5WHEvRTZxMXJ5?=
 =?utf-8?B?NVE0RFZCZFBWMVpmZW5Yai8vWEpCQWNsSitIdlNUU3Q1T1E1Z1VQVlNpbGR2?=
 =?utf-8?B?WnVGeXY3NWRiY01UUEgxZUVZT1FhNmlRdVpCbjB6a0RaUlhmTVpxbEJCZ2NL?=
 =?utf-8?B?ZFR2U05OYWJlVUlSYWNyd3F0UXhBdk93QnZlT2hUc2g0SCs2bjN1UT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806960f5-fcb2-419f-7c9c-08de5f163f72
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 09:10:29.3165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ibwp5r4JcT4KU9vo507/RkV6z2aFlArYIszxCMO6uaNwn9ElWjG8mMzPwExDNRPYCKeB2Fwjff78pLu6mukV3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7484
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

i.MX95 uses System Manager(sm) API to start/stop logical machine or cpu.
There are two modes:
 M7 in a dedicated logical machine, use LMM API
 M7 and A55 in same logical machine, use CPU API

Extend the driver to using LMM and CPU protocol to manage the M7 core:
 - Detect using LMM or CPU API in probe using API scmi_imx_lmm_info().
 - Compare linux LM ID(got using scmi_imx_lmm_info) and M7 LM ID(the ID
   is fixed as 1 in SM firmware if M7 is in a separate LM),
   if Linux LM ID is not same as M7 LM ID(linux and M7 in same LM), use
   LMM protocol to start/stop. Whether using CPU or LMM protocol to
   start/stop, the M7 status detection could use CPU protocol to detect
   started or not. So in imx_rproc_is_running, use scmi_imx_cpu_started to
   check the status of M7.
 - For above case (2), Use scmi_imx_lmm_power_boot to detect whether
   the M7 LM is under control of A55 LM.
 - For above case , after using SCMI_IMX_LMM_POWER_ON to check
   permission, scmi_imx_lmm_shutdown API should be called to shutdown
   the M7 LM.
 - Add a new ops imx_rproc_ops_sm.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 168 +++++++++++++++++++++++++++++++++++++++--
 drivers/remoteproc/imx_rproc.h |   3 +
 2 files changed, 166 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 9eecbe70f0b..3f8cea127ec 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -11,6 +11,7 @@
 #include <linux/types.h>
 #include <regmap.h>
 #include <remoteproc.h>
+#include <scmi_nxp_protocols.h>
 #include <syscon.h>
 
 #include "imx_rproc.h"
@@ -37,9 +38,25 @@
 #define IMX_SIP_RPROC_STARTED		0x01
 #define IMX_SIP_RPROC_STOP		0x02
 
+/* Must align with System Manager Firmware */
+#define IMX95_M7_CPUID			1
+#define IMX95_M7_LMID			1
+
+/* Logical Machine API Operation */
+#define IMX_RPROC_FLAGS_SM_LMM_OP	BIT(0)
+/* CPU API Operation */
+#define IMX_RPROC_FLAGS_SM_CPU_OP	BIT(1)
+/* Linux has permission to handle the Logical Machine of remote cores */
+#define IMX_RPROC_FLAGS_SM_LMM_AVAIL	BIT(2)
+
 struct imx_rproc {
 	const struct imx_rproc_dcfg	*dcfg;
 	struct regmap *regmap;
+	u32				flags;
+	/* For System Manager based system */
+	struct udevice			*lmm_dev;
+	struct udevice			*cpu_dev;
+	ulong				reset_vector;
 };
 
 /* att flags: lower 16 bits specifying core, higher 16 bits for flags  */
@@ -65,6 +82,41 @@ static int imx_rproc_mmio_start(struct udevice *dev)
 	return regmap_update_bits(priv->regmap, dcfg->src_reg, dcfg->src_mask, dcfg->src_start);
 }
 
+static int imx_rproc_sm_start(struct udevice *dev)
+{
+	struct imx_rproc *priv = dev_get_priv(dev);
+	const struct imx_rproc_dcfg *dcfg = priv->dcfg;
+	int ret;
+
+	if (priv->flags & IMX_RPROC_FLAGS_SM_CPU_OP) {
+		ret = scmi_imx_cpu_reset_vector_set(priv->cpu_dev, dcfg->cpuid, 0,
+						    priv->reset_vector, true, false, false);
+		if (ret) {
+			dev_err(dev, "Failed to set reset vector cpuid(%u): %d\n",
+				dcfg->cpuid, ret);
+			return ret;
+		}
+
+		return scmi_imx_cpu_start(priv->cpu_dev, dcfg->cpuid, true);
+	}
+
+	ret = scmi_imx_lmm_reset_vector_set(priv->lmm_dev, dcfg->lmid, dcfg->cpuid, 0,
+					    priv->reset_vector);
+	if (ret) {
+		dev_err(dev, "Failed to set reset vector lmid(%u), cpuid(%u): %d\n",
+			dcfg->lmid, dcfg->cpuid, ret);
+		return ret;
+	}
+
+	ret = scmi_imx_lmm_power_boot(priv->lmm_dev, dcfg->lmid, true);
+	if (ret) {
+		dev_err(dev, "Failed to boot lmm(%d): %d\n", ret, dcfg->lmid);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int imx_rproc_start(struct udevice *dev)
 {
 	struct imx_rproc *priv = dev_get_priv(dev);
@@ -100,6 +152,17 @@ static int imx_rproc_mmio_stop(struct udevice *dev)
 	return regmap_update_bits(priv->regmap, dcfg->src_reg, dcfg->src_mask, dcfg->src_stop);
 }
 
+static int imx_rproc_sm_stop(struct udevice *dev)
+{
+	struct imx_rproc *priv = dev_get_priv(dev);
+	const struct imx_rproc_dcfg *dcfg = priv->dcfg;
+
+	if (priv->flags & IMX_RPROC_FLAGS_SM_CPU_OP)
+		return scmi_imx_cpu_start(priv->cpu_dev, dcfg->cpuid, false);
+
+	return scmi_imx_lmm_shutdown(priv->lmm_dev, dcfg->lmid, 0);
+}
+
 static int imx_rproc_stop(struct udevice *dev)
 {
 	struct imx_rproc *priv = dev_get_priv(dev);
@@ -146,6 +209,20 @@ static int imx_rproc_mmio_is_running(struct udevice *dev)
 	return 1;
 }
 
+static int imx_rproc_sm_is_running(struct udevice *dev)
+{
+	struct imx_rproc *priv = dev_get_priv(dev);
+	const struct imx_rproc_dcfg *dcfg = priv->dcfg;
+	int ret;
+	bool started = false;
+
+	ret = scmi_imx_cpu_started(priv->cpu_dev, dcfg->cpuid, &started);
+	if (ret || !started)
+		return 1;
+
+	return 0;
+}
+
 static int imx_rproc_is_running(struct udevice *dev)
 {
 	struct imx_rproc *priv = dev_get_priv(dev);
@@ -207,6 +284,14 @@ static int imx_rproc_load(struct udevice *dev, ulong addr, ulong size)
 	const struct imx_rproc_dcfg *dcfg = priv->dcfg;
 	int i;
 
+	if (IS_ENABLED(CONFIG_IMX_SM_LMM)) {
+		if (!(priv->flags & (IMX_RPROC_FLAGS_SM_LMM_AVAIL | IMX_RPROC_FLAGS_SM_CPU_OP)))
+			return -EACCES;
+	}
+
+	/* Only used for SM based System */
+	priv->reset_vector = rproc_elf_get_boot_addr(dev, addr) & GENMASK(31, 16);
+
 	/*
 	 * Before loading elf, need do ECC initialization by clearing the memory
 	 * region, if ATT_ECC is set.
@@ -239,19 +324,65 @@ static int imx_rproc_probe(struct udevice *dev)
 {
 	struct imx_rproc *priv = dev_get_priv(dev);
 	struct imx_rproc_dcfg *dcfg = (struct imx_rproc_dcfg *)dev_get_driver_data(dev);
+	struct scmi_imx_lmm_info info;
 	ofnode node;
+	int ret;
 
 	node = dev_ofnode(dev);
 
 	priv->dcfg = dcfg;
 
-	if (dcfg->method != IMX_RPROC_MMIO)
+	if (dcfg->method == IMX_RPROC_MMIO) {
+		priv->regmap = syscon_regmap_lookup_by_phandle(dev, "syscon");
+		if (IS_ERR(priv->regmap)) {
+			dev_err(dev, "No syscon: %ld\n", PTR_ERR(priv->regmap));
+			return PTR_ERR(priv->regmap);
+		}
 		return 0;
+	} else {
+		if (IS_ENABLED(CONFIG_IMX_SM_LMM)) {
+			struct udevice *lmm_dev;
+
+			ret = uclass_get_device_by_name(UCLASS_SCMI_BASE, "protocol@80", &lmm_dev);
+			if (ret) {
+				dev_err(dev, "Failed to get SM LMM protocol dev\n");
+				return ret;
+			}
+
+			priv->lmm_dev = lmm_dev;
+
+			ret = scmi_imx_lmm_info(lmm_dev, LMM_ID_DISCOVER, &info);
+			if (ret) {
+				dev_err(dev, "Failed to get lmm info\n");
+				return ret;
+			}
+
+			if (dcfg->lmid != info.lmid) {
+				ret = scmi_imx_lmm_power_boot(lmm_dev, dcfg->lmid, false);
+				if (ret == -EACCES) {
+					dev_err(dev, "Remoteproc not under U-boot control: only support detect running\n");
+				} else if (ret) {
+					dev_err(dev, "power on lmm fail:%d\n", ret);
+					return ret;
+				} else {
+					priv->flags |= IMX_RPROC_FLAGS_SM_LMM_AVAIL;
+				}
+			} else {
+				priv->flags |= IMX_RPROC_FLAGS_SM_CPU_OP;
+			}
+		}
+
+		if (IS_ENABLED(CONFIG_IMX_SM_CPU)) {
+			struct udevice *cpu_dev;
 
-	priv->regmap = syscon_regmap_lookup_by_phandle(dev, "syscon");
-	if (IS_ERR(priv->regmap)) {
-		dev_err(dev, "No syscon: %ld\n", PTR_ERR(priv->regmap));
-		return PTR_ERR(priv->regmap);
+			ret = uclass_get_device_by_name(UCLASS_SCMI_BASE, "protocol@82", &cpu_dev);
+			if (ret) {
+				dev_err(dev, "Failed to get SM LMM protocol dev\n");
+				return ret;
+			}
+
+			priv->cpu_dev = cpu_dev;
+		}
 	}
 
 	return 0;
@@ -372,12 +503,39 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx93 = {
 	.ops		= &imx_rproc_ops_arm_smc,
 };
 
+static const struct imx_rproc_att imx_rproc_att_imx95_m7[] = {
+	/* dev addr , sys addr  , size	    , flags */
+	/* TCM CODE NON-SECURE */
+	{ 0x00000000, 0x203C0000, 0x00040000, ATT_OWN | ATT_IOMEM | ATT_ECC },
+
+	/* TCM SYS NON-SECURE*/
+	{ 0x20000000, 0x20400000, 0x00040000, ATT_OWN | ATT_IOMEM | ATT_ECC },
+
+	/* DDR */
+	{ 0x80000000, 0x80000000, 0x50000000, 0 },
+};
+
+static const struct imx_rproc_plat_ops imx_rproc_ops_sm = {
+	.start		= imx_rproc_sm_start,
+	.stop		= imx_rproc_sm_stop,
+	.is_running	= imx_rproc_sm_is_running,
+};
+
+static const struct imx_rproc_dcfg imx_rproc_cfg_imx95_m7 = {
+	.att		= imx_rproc_att_imx95_m7,
+	.att_size	= ARRAY_SIZE(imx_rproc_att_imx95_m7),
+	.ops		= &imx_rproc_ops_sm,
+	.cpuid		= IMX95_M7_CPUID,
+	.lmid		= IMX95_M7_LMID,
+};
+
 static const struct udevice_id imx_rproc_ids[] = {
 	{ .compatible = "fsl,imx8mm-cm4", .data = (ulong)&imx_rproc_cfg_imx8mq },
 	{ .compatible = "fsl,imx8mn-cm7", .data = (ulong)&imx_rproc_cfg_imx8mn, },
 	{ .compatible = "fsl,imx8mp-cm7", .data = (ulong)&imx_rproc_cfg_imx8mn, },
 	{ .compatible = "fsl,imx8mq-cm4", .data = (ulong)&imx_rproc_cfg_imx8mq },
 	{ .compatible = "fsl,imx93-cm33", .data = (ulong)&imx_rproc_cfg_imx93 },
+	{ .compatible = "fsl,imx95-cm7", .data = (ulong)&imx_rproc_cfg_imx95_m7 },
 	{}
 };
 
diff --git a/drivers/remoteproc/imx_rproc.h b/drivers/remoteproc/imx_rproc.h
index 7a82dc4a195..1629bc7f6e7 100644
--- a/drivers/remoteproc/imx_rproc.h
+++ b/drivers/remoteproc/imx_rproc.h
@@ -51,6 +51,9 @@ struct imx_rproc_dcfg {
 	enum imx_rproc_method		method;
 	u32				flags;
 	const struct imx_rproc_plat_ops	*ops;
+	/* For System Manager(SM) based SoCs, the IDs are from SM firmware */
+	u32				cpuid;
+	u32				lmid;
 };
 
 #endif /* _IMX_RPROC_H */

-- 
2.51.0

