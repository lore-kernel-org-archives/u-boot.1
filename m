Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FF3CCA476
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 18:07:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 604E083965;
	Sat, 11 Oct 2025 20:07:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="R6CaQJOV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D96AA83C2B; Sat, 11 Oct 2025 11:06:56 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C595E83A8D
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 11:06:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kovSelMPwpepZw/p/kXg9cNImgaz7YeVQNZ0uymfoWKGp/QWesEEKTrDZ+kweqHfuiVjPIkh9p0Yb4odsG4WGlfJiL2KPrG0i2KjCA7J4I/g0I1GGlVSf8NcyMDA9N3v7c13ilL0PefkCmFSnZoKmhaIcVkSsR16d4Y5Vo1tVKIjRL76j5kX/j8t91KXMUqPxCp2J3/n5ocFR0FM3Rx2illwDOnPrfLDTdx+8BZIjQv8u7LpY9Z/Vtj7H/eG3t62N1diS7P37ZTeUV5s4zaGzMj6Kjt5ZemKWz9e5X1uD/7mT2gBgSRb8McnXpx0OqAYNyQhlTdcUCTr5VPxIAWSGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rDyX/zZCbWg9p2ogqNxi043zT0ItK46TLhSHN5zLhN8=;
 b=sUrlSXIaVecaHamfi4h98UVLBIlcVZm/qihWyyy6eiWT87pnQcHtiBuekpSXmBOV7McWVVZw8Cf7B3r5BYnOfAKFxdDaOB5JyyG05iSJRc2JscukD5kzUk+hJLPFP87MIdkYmC1ygye/w52xWMDRed7DwVt9DXsTm9rzx3KsULm6vGN9bDgkti4u0rIXaA7flbvvZ4p8+uhO3MAYSEdcU12oL5HDv55pHHNt0XjSZZymyAPb2k/OuZ1eupa1EmNDzkLbWggcI7971hfr3bWDFhpwtEhJe3FTB+FoJ0qGcJGu/G0h01H/6gglIW+7KTJz0+u9LOZgBljHcWc5+GU/8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rDyX/zZCbWg9p2ogqNxi043zT0ItK46TLhSHN5zLhN8=;
 b=R6CaQJOVEFE7K8RucVdYJmrlLA4h+xGCsVeEiNAFM0HNTf1lLx1gQIBYr59oQQ7xpU16dQUwy8AoPKKEL+I6iyPJ9K1Ir3rjbc8qAHr7wFyJQPSnHhAPX7N52paLxyNrPcuwcqOOf1khYX3CH7R26D2Uxm6V+hJX3rh49Ht7JRb/WAE3aTv00+Jp+6qA6WwPa3SgbkmMhqiKWMQ9OmWSzS5C+kZoS2D9eyXceDssJr/Qv8FVk9gkokoD+xxPpWepQPcYAeM5x+f11m/UdyQ0/NwJOwyUQr0abYUsE3Qx7bRnASKQ8Vxno2WijgXKN03te2B/j0207XglWuSUp6ltqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU6PR04MB11160.eurprd04.prod.outlook.com (2603:10a6:10:5c3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 09:06:52 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.007; Sat, 11 Oct 2025
 09:06:51 +0000
From: Alice Guo <alice.guo@nxp.com>
Subject: [PATCH v2 00/10] Enable USB and ENETC on i.MX943 EVK
Date: Sat, 11 Oct 2025 17:05:39 +0800
Message-Id: <20251011-imx943-v1-0-3331e2dc3a35@oss.nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOMd6mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0ND3czcCksTY10Dc3NDg9QUs+Q0MwMloOKCotS0zAqwQdFKZUZKsbW
 1ACnVeq1cAAAA
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 marek.vasut@mailbox.org
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Minkyu Kang <mk7.kang@samsung.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, Tim Harvey <tharvey@gateworks.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Hanyuan Zhao <hanyuan-z@qq.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU6PR04MB11160:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d457857-9b75-4bce-0882-08de08a58444
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2prS1laS2wrMGxRbVJXd3BQV1NBSUZaRjFHOThmYXgwb1Y2NkVGU2J5RkFk?=
 =?utf-8?B?eDhZRHVrZWdPSjhiQlo5VVBST3I1MmVlVHdFbWl1bnlqaFc5MVVQWTFtUmZm?=
 =?utf-8?B?d0FpVHYvWlQwcXhPQmFiK2JRMk1lN1lIajhGWk1CcUpEZ0FEeXh6Q3N4MkxR?=
 =?utf-8?B?WkpNTlVlQi9weFRZWG5OeTZ4WVpPcm9ndXlRd08rYTRWUE9xUXhtTlY3WGla?=
 =?utf-8?B?Z0ZqM2RKZWx4LzUyUUIwQ1Vzek1HSWxVU0RVYXRleWdGVlJPanM0eUd3Qkxi?=
 =?utf-8?B?WURFZEZMdTVBS3NPbGU2OGdBS2dLWFVlRjRZK3dFS3ZIbE1DVkdQYXpwdUUr?=
 =?utf-8?B?SVRqM1Rua0NnRnExMmxPb2pLZk80T1hGMThoczcveHRraUFwcUpMc0tueU9N?=
 =?utf-8?B?UDNZcXhiTUpSWWt4cHVqK2lIVGJ6dWJoTEFUeGM3dk9TdUw4SzdRQ3loZUZz?=
 =?utf-8?B?TTR5MTJ6eGpmaHFMUHlOMEtVdFdBa3VBTkVqcjRHWmt6dE9ZRjFEYVYveklH?=
 =?utf-8?B?M3NodUJlVFFiV3IvM3VKTnFLT2hmNS9LSzk0a25vUGYxWnpjalkzVUs0ajZJ?=
 =?utf-8?B?ZDM0VmZBVStCcGJ0cmcyaGp4cllFUGZiK3dBVHZjWlAyV0p0T2FCMFYybjMv?=
 =?utf-8?B?bXAzdWtuUzBzVlY5YTJJVGNBeFBoNVpNcDY4ZVc4VFBucGNubFhaYW96KzVk?=
 =?utf-8?B?VFNtOUl1c2p3R0xCdUtudURNWnEzL2w4b3Y5Y0YwbGxxTTdOYnFJaHpyQ2hU?=
 =?utf-8?B?aS8zTEJSck04VFh6ZzVPa0htZUdrZE1uNGU4MlpJbndwL0lnOWttbmtvTUlI?=
 =?utf-8?B?R1crV1BTMm5KTkNZRUlJREdVL2tSSlJHSlhkVU5aWFBUMXVZZU0wclZhQmhr?=
 =?utf-8?B?cWFwRTFCTmxINjgybEwzcS9IbXlPU2xrL0ZSUzZya1haeXpISU00QzhpQ3NP?=
 =?utf-8?B?dEVRZHR1NndCUzgwSUhITml0MzZJbGxGRUdmZy82T09CRGRyUUpkSVJIcmg0?=
 =?utf-8?B?TjZSbjM4N01lSGxjWWtTQnJkWHkyQ1ozaFlmUUwwTE80Ym94eGVTZ1hpcFVV?=
 =?utf-8?B?TzBqWVhSa2lIVzQxSllJUFdkQ2tLSklia21OL3p4eGQ1ZTdLYUNLU1FObEtJ?=
 =?utf-8?B?WWpiTU9KTWprZjNMcFlpQ01TeEl6cjJva0Z1WU56bG83dWp2OE9YbmFWSXRH?=
 =?utf-8?B?U1JkWFZMNW02S2tqaFlKMmVNalp3UWM5ZVcxVHFXVVVzcThhZXM4YTc0M1RG?=
 =?utf-8?B?Z01YU1k4M0dwTTVaeGxHU1VRWFdPaDB5UkNZQ0MzUXJkOFUzd2xqQzJwQjly?=
 =?utf-8?B?dUNPZVJNMnlpbHU3TzdNY2RXWTg2MGVOZ3EyTWFsZVlNRVVxNDBib3JkUTdM?=
 =?utf-8?B?SVZlQmFGV2tkMXJodTJIS2Z4YVJ2QVc3a1I1YXBOMGhEaUkwbGxid0I4djIy?=
 =?utf-8?B?eDFBdXJMMEN3M0ZsdHV4bC9QYnc5ZEl4cm9UQnprTnIxWEx1c1FDY1B4NlJ1?=
 =?utf-8?B?aFdnOEd5aEw4VXBSSzVGdVhlK1BsOCtJQ28xUGlWT3NWTGFPRitUWGI5VzM5?=
 =?utf-8?B?RE9IZklGVnJ6TWlSUHlmZjhtU1JmbjFxeURTZFQwZWdyV3RrUU5KL2tXRjc0?=
 =?utf-8?B?SUQya3YwanI0R2hvMHlOWTE0ZFFHcUlrbjZrS1pWNno4MnhreWwzUWFEaHIz?=
 =?utf-8?B?V2RDM0pyZFdiUks4MXhGb2VabWpiTWJDK3NIR01RWHdnS2NOeTZ4eFI5MGdN?=
 =?utf-8?B?Mk55L0NTcFdCTzBySFB5cFZSVzBOcmpRVGFYaTdtNzFENHNqQjlnYUlydlMz?=
 =?utf-8?B?anlzYlhhaTcrYmEwR05nSk5ycWF3R08ybjVGSnlrUGkrVFpxbEVDTWRmVDkr?=
 =?utf-8?B?a1RSdDd2MUdCam9jemd3VWx2TlJoZmZZbnFFck0yNVFSTzhCc2dGY1UzSENO?=
 =?utf-8?B?eExBSGt0MWNlV3ZFTDFjekdoaFZmL0gyMWhOTnZvZE1qc3IrSitrOXR3ek9U?=
 =?utf-8?B?MTlHT3Y4ZWwvZGJCRDA5WXVpUWQ0Mml1SWZZYUN4djFWM2FXV2VJcTJER0di?=
 =?utf-8?Q?xfIS6e?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(52116014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUUwTjd5V0d5TWJjTXZJa3lJemRyNndyOXN4TmRpZFluVzFkWGw2cE9BdXNk?=
 =?utf-8?B?Skc5NzlxQnkvOHRNU0VobHhlWTNuVHgzeXJ4M1JLKzJHU1RublRJVERNOTQx?=
 =?utf-8?B?ZnFnbGYxSjRHSmZMbldkbkZvd2pSekJ2dmNRbUNvcUdzVXZIMndqNUhFbjF2?=
 =?utf-8?B?K3JCOHpHbm1sOURXZVpoRnRhRCtlem9aMEpCSUNXSFlpZzZKVzQyS2RFaTlz?=
 =?utf-8?B?cEk1Qlk2Rld1dk50dGQ3SXhqY1hIbDZVLzAvZi9Jbk8zRlNJamtTZmQwWlhr?=
 =?utf-8?B?UjhtOWRqc0tEWnArcWIrc0dIQUJhd3lQYTdNcUlRc3prUHlsTmlHcWhzVVN5?=
 =?utf-8?B?OVZIbVRqdFM0NHlodXIvNENEdllIc2RIWWFIYmZsY3IrVEg2WVpCeHdFQXJH?=
 =?utf-8?B?czZod2w4eThGamhIYU56U003ZnM5Y1JQanZ3cnQ0Q2xrOEZvdVluWVdwRWUy?=
 =?utf-8?B?VE1KdHNSbDZxQ0FkeGxxTXF6UHlRUWYyclFUd0FjK1ZMZExkaC9BN0tReTZE?=
 =?utf-8?B?VDdBYm5MQU5lMzRWUUxmZ29aTG5XY1lGc2sxZGFNVHpXNTREeTVrcjFTQkEx?=
 =?utf-8?B?ekJyNXR1SDRkTlczUThMdHE1ZGZOSDNES1Y1c3BaWlIrMWxNUFgrNTJNVEZo?=
 =?utf-8?B?MFBPL0RKR21UN3p3N2VFL0dTeFE0dU9vazNVejJ4UWNaTHR2endoT0I2N2JH?=
 =?utf-8?B?SnJWNDlGMnQ4OHBPVTd3MXk4M1NpQ05PZlZGZ1BoWUtNaFdtaS9iT2xKZ0pD?=
 =?utf-8?B?SmlmRXBIZHhxK1ZIMEVRcnlTU1BCR1FreFZEVno2U3BwNjV1RTFtd0svNlEw?=
 =?utf-8?B?dVFLMUhqdjc0UGlUdGR5bWRtZWJ6VVhaR2MvSFFHdnowcHgvaGxONlBpNld0?=
 =?utf-8?B?TFRNanIzS3E1M2xzMGlkL3BwVkQ4bjFkZ0hOajJaQ3ByY2tuQ2xCc3VYbEhK?=
 =?utf-8?B?TFNCdGVNOTI3WEFvRXdZei9qNmZSZmY1ZTlMUjFJZ3lNNHJBUVNzOTFXRlA0?=
 =?utf-8?B?T09GY3REWEJOYkNsSmlsd24vcGZXTkFCZEk5SHFqNG04SThnNk1SMzhMNENP?=
 =?utf-8?B?MlFKb3hFTVRWZ1o0OGF3RVI2aWdtcmJLMHdaWWhpZ3hwVHVhNDhON2JjM2l4?=
 =?utf-8?B?T0VLU0Q1by9DSUE0SDJSSGQ3Ykxic0xxcGZjQmFOS01uMFZxbEx2SnI3ME9D?=
 =?utf-8?B?KzBEbm44Ykw2U2hMVGI2UGxKMk9WVmIzNVpqb0UxNSs0OEU3SE1XRkR4RWtH?=
 =?utf-8?B?U05GdVNRMnpKTGdzbDJrV01uY1NSNVYvVHQzeXdzdEpmSWpBR2ZoZVRCa1NU?=
 =?utf-8?B?ZG0zeFRNNzBUTFF4MHdOckVuZWlibGoyU3ZDS2VjYWRzUm9qU1RIdmxOSXlF?=
 =?utf-8?B?enVGa0x4TTVaM3FmbTZSU3lOTENxamFCVUJhSlZkdDd3RzVrekFVemdGbXdx?=
 =?utf-8?B?ZTA0OXNsUEhIWXZ3bWw5UHJoZWNCc05ZdHVBOVY2Yy9EanVyb01uaGRpZmZX?=
 =?utf-8?B?QnVOOTRWZjFRT0RtMm5iKzVQUi9DTzc0NmhNQlhKZnJ1a0VSalRoN3ZkejZN?=
 =?utf-8?B?bXhIL29Ba0lIWjN3Zm1NQ3MzSXM1ZTJvamJaeW52MzVCcHV6Y2lhbFQ0NGVB?=
 =?utf-8?B?dlo0U2cyUFhIdGVielpyVjRmVTVPQ1ZiTXV3VG5OakgyVFlXcTh3UnV3RVNq?=
 =?utf-8?B?SVptajFEbkpFUEpZSFNYQm9uNXdMMzBUS2EzOUR3clRlSTRVMGFPUDlsR0Fo?=
 =?utf-8?B?TjFmWTgwTFpJK2RvekpxOWpJRDBvVjRYSUdtNVNzTjRFaHZqbjNiSG1RTTB1?=
 =?utf-8?B?MXJ0SEVWeEYwanUzWTN3d1NFdDRhemQwOXY0THVscFhSSktoRUkyTStldDFQ?=
 =?utf-8?B?ZHZCQ3Uzb0NsT3hUanVKd29tbFgzK29LVzdIQWFUUnJOVFl2ZVF4UzRLVUxR?=
 =?utf-8?B?c2hJd2dnMm5nOHFXTzFWRVBtVWpVaDhxSUJYRGxhVkNkWU4xblZLNklMTnYz?=
 =?utf-8?B?OS9CLzdjbUEreldHT3g5SUxVRzlrdHBSWGI0THlOUElRV25VUTNWZ3VZRVJx?=
 =?utf-8?B?d243RVkvS0NzK3p2SXJROTlBOFFUbTdNa2lpM2NxOTBiS0N5ZnhTTXo4N3Vi?=
 =?utf-8?Q?VydyjqFZG9OlfD6zQ3E7o/vJe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d457857-9b75-4bce-0882-08de08a58444
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 09:06:51.8249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hp9NJ4O+CZwtSiu6Nj7+O3n8bO1jjx3DRRvcfzPAINP3ZK+Ayiz/y7nuxRqti53h94q581uAUxSkEfscUzK9Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11160
X-Mailman-Approved-At: Sat, 11 Oct 2025 20:06:59 +0200
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

Changes for v1:
 - Adding USB2 and USB3 device tree nodes with required PHY and
   regulator support.
 - Enabling ENETC1 and ENETC2.
 - Updating Kconfig and DTSI files to support these interfaces.

Changes for v2:
 - Resend patch series with updated To list.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (6):
      usb: ehci-mx6: Extend support to i.MX91, i.MX93, i.MX94, and i.MX95
      arm: arch-imx9: Add USB2.0 and USB3.0 base address definitions
      imx943_evk: Enable USB 2.0 controller host mode
      phy: imx8mq-usb: Add SPL support for i.MX8MQ, i.MX8MP, i.MX95, and i.MX94 USB3.0 PHY
      imx943_evk: Add support for booting from USB SDP on USB3.0
      imx943_evk: Enable ENETC1 and ENETC2

Frank Li (1):
      Add serial# for SPL SDP download

Ye Li (3):
      usb: f_sdp: Update SDP driver to support PQC container
      net: fsl_enetc: Add i.MX94 support to NETC block control driver
      net: fsl_enetc_mdio: Add support for phy-supply property

 arch/arm/dts/imx943-evk-u-boot.dtsi       | 182 ++++++++++++++++
 arch/arm/dts/imx943-u-boot.dtsi           | 234 +++++++++++++++++++++
 arch/arm/include/asm/arch-imx9/imx-regs.h |   5 +
 arch/arm/mach-imx/spl.c                   |  10 +
 configs/imx943_evk_defconfig              |  30 +++
 drivers/net/Kconfig                       |   5 +-
 drivers/net/fsl_enetc_mdio.c              |  25 +++
 drivers/net/fsl_enetc_netc_blk_ctrl.c     | 338 +++++++++++++++++++++++++++++-
 drivers/phy/Kconfig                       |  14 +-
 drivers/phy/Makefile                      |   2 +-
 drivers/usb/gadget/f_sdp.c                |   2 +-
 drivers/usb/host/Kconfig                  |   6 +-
 12 files changed, 835 insertions(+), 18 deletions(-)
---
base-commit: 8c42f534d7e1956192ef8457fae884469f60ff13
change-id: 20251011-imx943-07710ed6cf60

Best regards,
-- 
Alice Guo <alice.guo@oss.nxp.com>

