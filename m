Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EB3C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 06:36:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8776182139;
	Thu, 24 Apr 2025 08:34:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AxXg93UU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C2BA81D5D; Thu, 24 Apr 2025 08:34:55 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::625])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F98380FDA
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 08:34:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e1+wtXYS8UZWss8vQomhiLUTDUmxya4CY1t67XkD9p1uNBk2stAajb/g6aBzOjdlMMs28zBU7Vep8NxrVoBMLJVz4E3AgduT5/4giiuHL3GYGAKYXbPGH+tjq7ZO57m4u95P66El7Yj+ifGPPyyxMofLSfPduvscE0Kd21Aa2VE6cGRUth2WeIRTKJYh+6VneaI/bHn6NX4KlaiP2q3UhyqmnsrMhqq0cHo+PjdEStPse8G+yuPKh1sOk4QyERgfVYB+qqA9mQ/31j190LQy0C0So7uIr8HPsMhyvyBy8RAN1XLgQau+i0WoCAcq8DNN65OGTkTkl0F6oos3jKue3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkqenDqBFb7qxd1GNtejehb691o/o+YUW9V9gDr092Y=;
 b=bXIXRyLm7OieAuayJp1/en9XHrhlJ2ETga4zSnabX6hBrDBlroP2xDjz31+D7BdIKhNt+N4K2w1pRdCJCbCynF/XjQsDBWuHvZssVuC6l1HMeZva3q5+GkqMBKnec2y1bEd+enbiV+X14EwdLN6owtRLxe6xDnhvULCDCVtc+nFYetmogUAWp9RI2dO3BwY9ZeMrSdEKGF7bN3cxjvy5T9G1x/8YH3UJ7LHdZP0V/KoS4h6m2+LgSNzoYfLCuEVaDqaj+m8iLP1M/pIVdXNn+B6ho8r2lHFknHIc0jOjvP1iyTKcG3o6RMtmL4ABiZ5pVaMdchmNZ7eoh+tpSRtlTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkqenDqBFb7qxd1GNtejehb691o/o+YUW9V9gDr092Y=;
 b=AxXg93UUhXbxro1S32GUw+i+C/ISge2wqe8Mah2x6iBvu9GtwkqnqilwhUlT0OViTr01+60vYUdaQJgbmkR9fqdIVcqJ5HlVjouibfxN5YmgYJ5YIX4t3Y7cYfYGM8DzsFYdZuhXqZ0RUmn2y1MQeqh26Fh3LSD1Y9a4uZX60u8/68edpaG1awebWmFhoTcRVhPqCAB3FcLdCCxDUcr2h9HQu08OCwiohSeuvcBKOh3x73M0bP1+JNCUbD++ck39LbHTTMh2M9J0k36q9pNxCfwthD9vK1TXC/RuG6Kb++cOXI2whHY/tP8qQeHpRHEdy1YqyAyYU5EXnzSJ5yeK1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI0PR04MB10661.eurprd04.prod.outlook.com (2603:10a6:800:265::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 06:34:51 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 06:34:51 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Thu, 24 Apr 2025 14:33:11 +0800
Subject: [PATCH v10 15/21] imx: Kconfig: IMX8_ROMAPI is not configured for
 i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-imx95-v1-15-10a8449b1e5e@oss.nxp.com>
References: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
In-Reply-To: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR01CA0140.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI0PR04MB10661:EE_
X-MS-Office365-Filtering-Correlation-Id: 87570799-7300-43aa-29cd-08dd82fa1e0c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T1h4aFZGc09aSnA2Y3NvLzJFRmRyMmdicFVsS0dRcWowZ0xpTlVkdUQzNXdN?=
 =?utf-8?B?M2hmeVpZZkRKQTZid1dqMzJwanFNZzNLS0pzNFo1SUZjSktxVkZ1TUdyRWps?=
 =?utf-8?B?R2ZXQ2hjZzdmYzRrSjdmcy9tU05FUU9rTHU1TE0rMDJtNG5ucDhyWHhZbjB4?=
 =?utf-8?B?UTdaUHV4UTdBWXVXaVFuSHhUQ1RjZ0EzOVMwOWNrMUhRMDB4TTFidUN4bk1y?=
 =?utf-8?B?QTIwdCtLbWtaejNqZmtiR1BJNXZjcUtROHR1Mldaby8xMjBBTm5HMWlaQU9y?=
 =?utf-8?B?RmhDNGY4U1JxTWJ1Tk1WQVZ6S2Vhbk1QMzFLdzludmJrcDJLajhpYmxyR0Qr?=
 =?utf-8?B?dmcxUGZQTmwxc2V4aXd0WmkyQkNFVmNkSE5SVHk1N3NUbDl2a21ZT2EzenNT?=
 =?utf-8?B?L1VqcDhldmV5NjZIWnc0Q2lzOHFVVS9neHBjZ295Rm9YNXFiSG8xZEtvVmpl?=
 =?utf-8?B?MzNOK1JHWTBHYm00YTN3L2V0dVJqK2dmdFdLN0VzcEJMek9xQVoxMFVWL0lk?=
 =?utf-8?B?eThTZkFXdCt5L2FkTDhaKzhtTWJ3Wno1dGFaMG5pMncrRnJHTlpMRStMS01T?=
 =?utf-8?B?UkxNSDNXWlNwTFBwVzJZL0dvbTMzekVYc21HUnFRWTRXUDI4T08rQzkwdDNa?=
 =?utf-8?B?OGtCYlNTM0o4aEdibnRCcUY3SDlURklOa1orVlFwWEZTTitKdlhTRDF2MHVB?=
 =?utf-8?B?MW5UUWdRUXErQi82ZU5zRm9hZDJHZ2ZvVEppdFBiY05lVjhOR3R1VVVFVUtY?=
 =?utf-8?B?eGJncnk2U3FKSFY1S1lWVUl5c3l2TWdSNktXT1dFRDRFV0llaFV1WURSTXJV?=
 =?utf-8?B?YmRqUllEQTFXUDVLeU5VdmpRTHpNQUxsNjhmenlkUzdGdVZiZ1ppK1VjZ2Qw?=
 =?utf-8?B?eXAwc3RJM0xjS3RORktZOVMrZGRZRUFWVkNRalFWbWZLQzB5VUdpSE5NTjJ5?=
 =?utf-8?B?aEFrV1Y2VkpnbXF4VGJoaVdiRUZMQzdaZTg4YStxQVB4Uk9zT0d6Y2lEZHFp?=
 =?utf-8?B?NXl4Zy8wZ21HdHphTWdyeG5zMGdUWVNYeWpERnVxU0swRll6RER2WUFnOERs?=
 =?utf-8?B?KzFid28wLzZIV1EranMra3VaVlh2RlhHMFlBbk5hL2xLa3M2d1JPajlrVDFn?=
 =?utf-8?B?RTQ5bXhmWTVmMEVZSXhxS0ZtVFd1bm1vUkNoM3ExUW9XTHhiWmZSb3ZRQUdQ?=
 =?utf-8?B?anExYWVEdVlhSGRQRGpYY3JRQnFZdHY2dnBnR3M0RVNRUllhQlVoZWNkbTE5?=
 =?utf-8?B?VTZ4Tm83ZlE2anpJa1ZtMGc4dCtwN0lKSlp5UTNwYkR2ckhMU2xGMnJEK1R6?=
 =?utf-8?B?VkF5K2tEQnVOUTNBbkxRZ010T0Q0Q2JKaWVCNVVFdFQzazRiWkc5bURXVkky?=
 =?utf-8?B?cmJYMEZlOUR6eGdOc3grNE9TcTZaT3djOWxRZzc3a1R3bnJ0c0hsUTd4ei91?=
 =?utf-8?B?aHJqeGp1N1pMaEhBd3U0QUdyVUdZbTJpQXd3eWE0clkrRWpHbnRKZkw5TWZE?=
 =?utf-8?B?a2txVmZ5OWhlR25ZQlEzdFdDdUludEJGT3QwYjB5WXB5bXVFajE1ZmJWR0tN?=
 =?utf-8?B?RXYzbkdaeHhPcnlIVWhKaVVMb2RmWkhCSjZ3RWdZQ1p6UnZibHRMejVodUtH?=
 =?utf-8?B?YXE0TUt5QkpXV3I4T1YvVXRHVGx5cTRONTRzWXZxZENVZVgrbnUvTCtDTFFI?=
 =?utf-8?B?aVJqK2k3Y0VLc1pvUjg3OFhkMmFOWjY0REpSOXlLbm52OGZuckxXcGNtSjVi?=
 =?utf-8?B?eUlLVE1UOEI1YXU1ak40Uk9uM0JtTDU4aTlRd3V0eXVBZUdraGppUi9JUUxZ?=
 =?utf-8?B?dXA3V0hLWTZnSHQ4UU1JVm1iZ01qNE03ZjQwYnc4QWM0d0NaWVRndG53WjhM?=
 =?utf-8?B?bzI3M0lCbEI1YmVpUW9pcnNQTElFSmxOQmhTQXExMmk0bkxLSFNycnh5dFE0?=
 =?utf-8?B?NmU1YmlZaHZVYzZqUkNFbU9zTjFPYk1vYzJwOWU3ME5hV0FmTEFvbHNPUzRu?=
 =?utf-8?B?NTh5TDF1OGR3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NENsNFpvNGVFZVg4YVRScVAxQ2MwNDNMVzM2NkY2a2dhdWIxWFdDeDliQ0Q2?=
 =?utf-8?B?ZndqL05CNlNOamtQcWtHbUdmQ29uNmg0YTR4TEZCdGtPdEV5Wm9RbUVsRndq?=
 =?utf-8?B?UUN3blBrbjRNTTBhdGd3cXA3V21XTTZlSXFobkxEUDV6WVVSUkxVenErQzBK?=
 =?utf-8?B?cEV3a1VpazZydVVjaWp0Zk80cDZKak55QmlMV1dMV0NjZmg4cUZvMTY5T0hu?=
 =?utf-8?B?clh6TjZaaGQyZExjTWIrWWpUUE9iSVpVT1JLZk1RTFlRWDVCbWZFZDhDS0F3?=
 =?utf-8?B?T2RDM3ljOVdmaGRSaS92R2ludnpjRFdEa05xR3NEMlVJS0x0UzA2N0dJdW1R?=
 =?utf-8?B?U3JPaU5zVlUzK0RaYnZ3aW1rbktlUmYwcWdNMGJSNEZLMDEvWEd3NkRma0V4?=
 =?utf-8?B?bFhubEU1aGNSdVRSeXpQeWdlT0l2b2JDdXdOdmc1M3VJVzEwaDEzT2tKdzNh?=
 =?utf-8?B?aHE0dEtFOTdKNDg5QlJPVTFEbWN0V2hESjhGcXpGMW5UYmppRzMrWU1FWHQy?=
 =?utf-8?B?cFdlNkt1YTVCQnBTQ1krWHJHVkZ2NjdsWnZzdk9vOHVDVkRCck13SHhuSnJV?=
 =?utf-8?B?MHpKLzhLeFB6WnlBQWY2MUhpWEF2NjdXd2lGRUwxZ2EyZzlIMnNrMXo1WmFV?=
 =?utf-8?B?RGZQb3VZN1ZONzBmSDNnU0gzUEEwRUZLUTRaTnBPS0VGS0VJc3hBNzZQWmsw?=
 =?utf-8?B?d1NPL3N4eEd0Sk96QlRXTnVvbVVXcm0wR0hvU216YmNZWVFRSDJZL0kvL2RJ?=
 =?utf-8?B?ZXVmMVJLcDNPQjhETk9RY2hia3B0UmJwdXZ6RTNEU2ZGQUNHVGFpbGhzSHRI?=
 =?utf-8?B?ajdIRFlyZjNtaFl2Yjc1UWgxUzdVSGdPc3hheWd1UE81clEvR3lrQzJDRytM?=
 =?utf-8?B?K1lMbzdpUmxHSEJ3SzJ3eWM0d24zcWVnb05uR1VCcW5GWlR1bTZEZEVZU1pl?=
 =?utf-8?B?QzhyZHNWbmE5aVNLR2xTb29xZXdLMll5dzZOdU5GaFM1ejRYUFpMV01LY3Jk?=
 =?utf-8?B?WjY3Wkx2Qmx3b1REVlVmUWN3ZFFZYlVia3ZtVXBVcWd6ZGJ0enM5RDdCd0l6?=
 =?utf-8?B?dnA4QkdoZmxBZHQ4dFBtSDBhWjc4QTZ2UW1sZDVDM25Zd0Z1NWowNnVON2Z6?=
 =?utf-8?B?dWhIZHQ1ellHN1F5UTA2QmNXdkZ2dWlRTDNka25KU0FHZ3A5T3JpQzd0eCsy?=
 =?utf-8?B?aWhIL1gvYTlwcE5iWldpYmUrK3BYcUE2Zmt0d1dJZFZEL0hmY1A2TFg3MHcw?=
 =?utf-8?B?OGo1WUxjY3YrUWdRNEtXeG4xeVMvMVpKOURWLzVRNDhhWHowaGVJUmc0WW5B?=
 =?utf-8?B?REpaa0JZMEhwamk1VlR2RiswOWJWck5YbmxLclJ6cDU3OHlkK1M0akFSWnph?=
 =?utf-8?B?cEZjZlNUOUFGRlpnQUphOFFITDNoSldsamEwUzlQUVMzeFlUQmt0SDNXMm40?=
 =?utf-8?B?WjM3V2dNLytrN3lnVVgyUVhzMDRlSzE5ZGdzUG0yL0FHRHBpV2lQNzVTNS9a?=
 =?utf-8?B?bUJmYVczdHZaTTVqTTQzTXpZOHhFSUFlVVlTUXRpeEFxb1ErOU5zM0lzbGtl?=
 =?utf-8?B?Wm5FUHd6REc0UFFWcDJEak1mb2hKb3hCSEtYMVhOUlJJWjBwZjRxbnJNYkhn?=
 =?utf-8?B?QzJUVHRtS3lzZGxqd0RGQlN4MWlqcWI4M3NqRnY5ZXhjWlBhSkE4MnNCL1hX?=
 =?utf-8?B?eWYyVnRvbU4rUHZJS24rakdUOXEwTlUvY2RBMFpxMk16eitzUkhvYUVvdUQz?=
 =?utf-8?B?TGRvZFE0OFJCKzNsL2NodUovOFFaT2llakhvWDh3c0tHTURaS1F4NW5XQmRn?=
 =?utf-8?B?TnROYWtmZG12ZU5HQmZCaUVXOFlhNHQ2am9WZ3BoRkxUTFZYTFQ4OTdzbWJs?=
 =?utf-8?B?bjZRMnlVNFFjZnRXdG9jS1J1MmhzNnpQWVlFbGZxbU8yWkVndlQ4V29oc0xk?=
 =?utf-8?B?RGJFdU9XRFVwdkI4L0FOaFFDZWtIUkpiU0tZMzZjWFNscHhxcDZFNGl2MkVk?=
 =?utf-8?B?bXJlN3N0b0E4RzlrSDc5aXdBbSt2aDFEOWN5SWJ4aWFkQlJvUi94dzRNUUtX?=
 =?utf-8?B?QzVMYjdWNUU5M2xZSE1WUUlTVzdjZXdLTnhWeFNIeEVXSzJpcm1hWmJocTI3?=
 =?utf-8?Q?/3JZESyfsT7fNzVUtxH0JfhJu?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87570799-7300-43aa-29cd-08dd82fa1e0c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 06:34:51.6024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uOCYW6e466ai1mZ9ZLLyCW8wGUu4gNCFbTMOC4bCHxGP0JdbEdGFsM+jlxZqMLeOsA29gNrOSHIZPqDaszsNyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10661
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

From: Alice Guo <alice.guo@nxp.com>

i.MX95 only supports low power boot, which means A55 is kicked by M33.
There is no ROM runs on A55 in such case so that deselect IMX8_ROMAPI
for i.MX95.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 134e42028c3..e4014226582 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -180,7 +180,7 @@ config DDRMC_VF610_CALIBRATION
 
 config IMX8_ROMAPI
 	def_bool y
-	depends on IMX8MN || IMX8MP || IMX8ULP || IMX9
+	depends on IMX8MN || IMX8MP || IMX8ULP || IMX91 || IMX93
 
 config SPL_IMX_ROMAPI_LOADADDR
 	hex "Default load address to load image through ROM API"

-- 
2.43.0

