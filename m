Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA06D3B7EA
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 22:55:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1337683B07;
	Mon,  8 Dec 2025 23:55:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="jAytTdla";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="jAytTdla";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FBC383B32; Mon,  8 Dec 2025 23:55:50 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB96183AEE
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 23:55:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=u9QNHxgosOrJq3WytVqK0wwJcW20tts7PrKtWH3dDQbOH550krQb4sE9WIW+XFZyF2Xo2my1PH/FpvMJxXoIb/GI9zbKC38ZE+0XFGheQp6i+QjpxeFlajpHKFb46uuTIm1nmWR1iuIUW3B03pzznh5JHc7yG1x/LqbZlQCL1Bs5qqrcKLZEDfjboCeS9wMq3SjykXPFy3ZZN4vzMBZf6fshxxlFypG2ZzS37HpH86gn9nIr/BFHLgaBMl7hn9Y2idnBswt5+9a9ejZdJMOcqR3WIMe1dOAwfYB+a8rcl0I7Tf4nvJW9g+ZkCLKx5fYXTy2bZ7ZwzQ3Bim0Owm4Blw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fp9tVhz7Z4WzZv+irk6ZfESWQwJOUbyCUTED1TGPcA=;
 b=WQ7Ivw+kOxOCiZaXcU9MfnhfkBvTzx1kfJehJE1U8lrYy7qzRCr1f2ISc/ooS/PTA6ABtBPdwC/xKH04zjkyAZ0teSaWlvpDuf5VNhSmTewxYGx4LkmegSLQDbM/rGiltadHFH2Hw35lyhjWMERs0jexHY3D1GJf35KBSQ/aBdIlU5fzRgvL7W8glPeOP1RiOBxfkID/Lxb7WMhScDKnUkrbDmKrmFOpHL46GUQU+H2swS55/Xmv3K4KlBoiPY+LhZfkuOglYOQiLiY9CDAVSIWczVB4iMwNFMgoMv6wEyrtGkSybG6Wq4eWgI2EkYpelMK70GElgAIw4eDMw24t9w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.86) smtp.rcpttodomain=amarulasolutions.com smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fp9tVhz7Z4WzZv+irk6ZfESWQwJOUbyCUTED1TGPcA=;
 b=jAytTdladWhkLxKc6Cu3YaIV6j2H9TvvoGserNCQMcoC3welJnEAAYHKBVrvu20TGqgJS+8PNpcMXJjB3Rhld5Lo/DPPdnXA4Gi2CXVO96l8IUgoT5zQmwnfaYpYJooRZGy1hQCe5Ox6CmsHLcOu/2WOaxwWxJTCiueNwoQT+KBLknYfh0bRi8AHuTViLM8x+YGwtSJo886eNQAyFnZMgA2X9hZ0jxGU0Yg+YMMEtKkXkrLoTrXaAmU/7QinzZrk7lGspbMz3bl99hElXyydQ33UAzYoHdDMlEEbbwYbbtv88/YxxKamTfjLLfOiSutXHG93tPFfQTCHN1XtWDpOyQ==
Received: from DU2PR04CA0009.eurprd04.prod.outlook.com (2603:10a6:10:3b::14)
 by AS8PR03MB7207.eurprd03.prod.outlook.com (2603:10a6:20b:2ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 22:55:45 +0000
Received: from DB1PEPF000509F5.eurprd02.prod.outlook.com
 (2603:10a6:10:3b:cafe::8c) by DU2PR04CA0009.outlook.office365.com
 (2603:10a6:10:3b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 22:55:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.86)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.86 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.86; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.86) by
 DB1PEPF000509F5.mail.protection.outlook.com (10.167.242.151) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.8
 via Frontend Transport; Mon, 8 Dec 2025 22:55:45 +0000
Received: from outmta (unknown [192.168.82.133])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 3E2ED20080E8B; Mon, 08 Dec 2025 22:55:45 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (unknown
 [52.101.65.126])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 7304520082B64; 
 Mon, 08 Dec 2025 22:55:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nBWuZ5C0ily2M9guDo4mfQBpOffyuat1TMd2IGSL1spRTQXKyhqmlLw8pmhlH3zkic8PZaHDPFB8BHgPS3qFy9APnYm1ASr92aemWnqqsbxNEJPkYsvy6WDeZ87VCEgVBB14qk51SL7Gegh/IWyocP/RToyQmEwuy4mamoMaKtXpFuu4XAANZEnEpm2WEUrf2Tc8rwdXKoQD7CSZaByBgYpPLgTe/crgZ3SHMjpC+6jgWMXdOesipUHB+EdlQ2oMnNRx63Re6oqHCAn1RouNRGwbmfSYmLn4D9isFfJUGRBAb6kaKhTw43FgXyiVCAd64O0s/IYeyMh4FnlOC3MMoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fp9tVhz7Z4WzZv+irk6ZfESWQwJOUbyCUTED1TGPcA=;
 b=WFTk9lqr7qrPfib+Rx5z6wDl/7ZdSpmOdwKWmoSvixqWWcbXzmD0XW23OK4TbWirIwyDGciB/QU8bSE3QbsM1rDKmCGp+fjbupc+1b0WU857BKhwmw607H5oaveFZH4Por0RjpFVh65hoGNxZ+z4QhzWxrZ7lnSIwy1KOcThRwnPXl24LkvsHZ0YuGqCNwTIwFdFUZui0VkDZAaLe73at4mFDl4buUWTJp0Pg5vdfoHyDUq7i8+40dIWFLh9/qAxMzc2Ekxwr+epy+56zKtzw6whIW9sPD7ZxOaDXU/8sVBAB3ngof6y26ZWbLqhPEYGGKqaEcIogpTegCYDZodPGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fp9tVhz7Z4WzZv+irk6ZfESWQwJOUbyCUTED1TGPcA=;
 b=jAytTdladWhkLxKc6Cu3YaIV6j2H9TvvoGserNCQMcoC3welJnEAAYHKBVrvu20TGqgJS+8PNpcMXJjB3Rhld5Lo/DPPdnXA4Gi2CXVO96l8IUgoT5zQmwnfaYpYJooRZGy1hQCe5Ox6CmsHLcOu/2WOaxwWxJTCiueNwoQT+KBLknYfh0bRi8AHuTViLM8x+YGwtSJo886eNQAyFnZMgA2X9hZ0jxGU0Yg+YMMEtKkXkrLoTrXaAmU/7QinzZrk7lGspbMz3bl99hElXyydQ33UAzYoHdDMlEEbbwYbbtv88/YxxKamTfjLLfOiSutXHG93tPFfQTCHN1XtWDpOyQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by PR3PR03MB6394.eurprd03.prod.outlook.com (2603:10a6:102:5e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 22:55:37 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 22:55:36 +0000
Message-ID: <3d0a90ad-f5aa-4a2b-89c6-1f9dbb8e1c60@seco.com>
Date: Mon, 8 Dec 2025 17:55:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: designware: Allow disabling designware driver in SPL
To: Ralph Siemsen <ralph.siemsen@linaro.org>, u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
References: <20251208-spi-designware-spl-v1-1-21e6f519a4de@linaro.org>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20251208-spi-designware-spl-v1-1-21e6f519a4de@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0040.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::15) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAVPR03MB9020:EE_|PR3PR03MB6394:EE_|DB1PEPF000509F5:EE_|AS8PR03MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d409f5-554e-4af2-0d98-08de36acec1d
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?SVg4K2dqOHZRNldZMXNRTkt0bUw5eERaREVDOGpQZ1VzbjJBTmZFSGZRcGtO?=
 =?utf-8?B?YnlhK3ZqQ3M1RnRxN1FLeEJxdit4UEFwMHUzaThkblhRRFV4RTViTVY0bXRT?=
 =?utf-8?B?SkU2TEp1dllybVBpMEtlcEpXWDUyTmlsK0pVbUdWdHpuWHVBdVd1cDVxbVFv?=
 =?utf-8?B?cUtiNHNHaE9tQ1lyeHFUTk9rbWoxZW9KRHNJTWpSTmswWW9MYXgvazA0ZURz?=
 =?utf-8?B?dTRFOFovTHJzYXBNdWRYeDloT3pCdWU0WEd2TmJXaGlESTNMcWFJWHR3aWhy?=
 =?utf-8?B?VS8zcDNhQlNPbWttbkJrRGFVUjJMcmVhWUtVT2prRXcxVGpPbFFqT0gzUjVN?=
 =?utf-8?B?WGlleUpMZER2RzEvWDFWNFg0Vm9NZWpOMmNkMkJiNE9sbVFOWXlNc0U4aGlp?=
 =?utf-8?B?eDg5SnBRYjdtaUxsdTNRakdEdFVpY29KcXRRRGlZNnBJQ0M0TXVZREw1dlAz?=
 =?utf-8?B?NEZ4bHBYVHhEbnpQamt3UjJZR0lHMkVlU2pvUWh4S1NjTVhYMGh1MllzZitG?=
 =?utf-8?B?NTZVVm11bmx2cHRXaEExY05meUFWN1BBRkRQUC9IcnJtRldsQkdHbFBOZzFo?=
 =?utf-8?B?ZjN1NXJlaXhMY2pCT01aT3UyQkVzWTR4SUJ4RVR5UGtPM0FEakkzMlJ6cThm?=
 =?utf-8?B?VDlNY29Jc3M2Tm1rMHNFWFMwRTl5NUwyMEdRL01ZbVgwa1VrK3k1Q2VyWXd0?=
 =?utf-8?B?QXZOaE42allBcmlaVEtjc2xEZnROeUd3N0hYdy9FVEVZb3FjQ1E5TDQ2VVRG?=
 =?utf-8?B?aG9meXlpM2NFRzlUa0lPOHVvTlNaT2xOc09xeENFZzhMbU9tQ0pROGdzbE96?=
 =?utf-8?B?SDA5b2VOMGlVbFFablIwODRJUE1yN0t6SHhlS3p6ZTZrMzJsc2lVdFBLdDl1?=
 =?utf-8?B?VzhISU9GbFAyUS9xc2pGaCt4aWtpYnA2blpXeC8xQWw5dFJqMVVjR1pKRHJ2?=
 =?utf-8?B?NWJhYkFIV3RiWlhBMy9uT2ZkRm9ybThHNThHZFAwaC9xaGQ3cXJoa2lHQ0RX?=
 =?utf-8?B?NEY2YThkUGdCcVRmelJCU0V0cGhacS9meU8vV1dRbVNPcnBwR2lSem1nVlEv?=
 =?utf-8?B?RTQ1RnIzdWN4OWN2S0pMZ0VNbUFJU3llQjNsU3pESjBsMW5UdjlwSlZER1RS?=
 =?utf-8?B?OGhyTW1PeVZiWm52YllUWUN4MDRIUTI0NjVuK09LMXVKN1RzMU95NmxIRDI3?=
 =?utf-8?B?bVE0K0RmcklZNllvd2oxbi9MekROeUlFalZPeFV5L2VXOG5jcDFEWTA4aVNE?=
 =?utf-8?B?eE1LTHp4RHpVOHdRdHhTdEdWTEdRL2RucXNBMHh0NzVjVnc1SDd6N1JwYXVR?=
 =?utf-8?B?UWl1djBZUFNsQUpXc3QxYy94MWNDdW1IYlBHbUxrS0RrVm80V1JBOFVMdkxq?=
 =?utf-8?B?aTRsTUpBMVRTMFg5N3F2eDUzTDgrRnNwdld1VllZL3dLWHZ3SWtPMHFtRnl4?=
 =?utf-8?B?OFprcnFJTlRZRWN0dzJGdS91TEtlQXdoSUlmU2RIaEkvNzFXaHJaR2ljamxY?=
 =?utf-8?B?WGdYM2pVY1RKdmpYZ1JjazBnMkl4SXdwejBzNmZCbnA0QldZOHREL2JBWnFD?=
 =?utf-8?B?NjRtK0loQWZBemVVUlNROTlBMVdJWWhrN3FXSHlsNjNHK21zclpySVVXU285?=
 =?utf-8?B?ak0wejh5QkJLZXZIdjJXOGhHdjBSQmdhYnUyM2VsdG1peE5ab09ZZU40VHU4?=
 =?utf-8?B?UWtsZGE3RVZ0MVM3VjVDYm02SktjZlljVmVUYnJTUFg0MG9mSWd2aXZ6Qy9F?=
 =?utf-8?B?aG1iMEJYYjlUZHhKRko0eElpUkNnWEdDODRpK2p5dDFPMGhGMk0rS1lJWjk3?=
 =?utf-8?B?YXhMZFVCb0lDUEptc2ViQmg2MSs4N3M0WUJkZ0htMnByY1Z4dXQyamxiblhY?=
 =?utf-8?B?TG40WmtFMFczSGlsc1oxdGRRR0NLTEEwYjNtakZVeTByNnIySWg0RGFGcmlr?=
 =?utf-8?Q?dDVAGGkm1sEd/1WItJXuhWb2CzYiWhAf?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAVPR03MB9020.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR03MB6394
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b3778f9f-5f73-4924-5709-08de36ace6bd
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014|35042699022|14060799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WVVXYzJpNVlRd2Vab1NRZ3FVL25FMjY0YzZjKzlNd2V6Ni9HcGJsdytoOXJY?=
 =?utf-8?B?N3BSRWpIZHdqd1pieTJGZEx1U0o5dHZNcVJvUzdkQUJaSlAydGVGRnZaVXll?=
 =?utf-8?B?ZUZXWTF3TFp3Y2RQTGVIdGhJVmhYaVcvY0IzTzNMM3FOTG1NNXFkWGZ2b3JG?=
 =?utf-8?B?REMxRW1hWHlDKzNtV0c5MUxscTg5UlNudG85MEJUWXhoR0haMXVZQ2V4SSs2?=
 =?utf-8?B?eTdXaVYyWWsxc0VIM3kySHpuL2I2M0JtcDRpUWtsaXJNQWhTQWFObTErbWtZ?=
 =?utf-8?B?VVY1SHp5Mi8rQ2lGUWcycmI0YmU3WDAwczdtZUxLS2ZBSWNNclJaZVpRNllx?=
 =?utf-8?B?bXRhb0ZoYWxMMXl3b1hsdnVkTHJaS1kzMjhDcU11bXdRc0lxd1U5VFF2U0VW?=
 =?utf-8?B?S0dsOTROYUU1bEpTQSsrTklpaXkrNVRtM2FKMk9IZERML2dIeWo0Z2VqRlJl?=
 =?utf-8?B?NlF1KzVvNW91cXU5Q2ZuTVRvVjRUY1RIaUQ3aXB3VnpNMlk5MEcxclpDUnpt?=
 =?utf-8?B?ODVxU1g4YVpUVEVKRmh2YUVDa2NHdFptdlo4SjdKMG1BeFVEc1hZRGNtRTdM?=
 =?utf-8?B?NGRaTVJJZldjNXpVM1FMRVJVazVEMkhiYjVqMmlreG1nWHhldEZ6dDQ4akpY?=
 =?utf-8?B?MXliSFJCVzFwOEMyVUErZk1iek11Yms2TTVrWGtzVnZLL1Z1RGt2K21JU1JM?=
 =?utf-8?B?Vm9tdVRqREUrUUhlZG1CWHBJV2JpaEJCYWNZNkJZdmwyN0Y0c3VBa2h6ZFp4?=
 =?utf-8?B?MFBZVXNWL0RPLzlzMHcvV3RnNnlMNWl3NjBFdk13OGVPN3VpelFDQzhoMGY4?=
 =?utf-8?B?STV5RFdOcldNa0NqZk9tYUN6QTBNcElxaHF6cWZCWDF6dDZ5Y011ajVmdHp4?=
 =?utf-8?B?dk9OczUyMmJ5QlJscSs4QmxCRmlBcXRWeVVkcmQ2OS9sL3FZbTVBdWErSE5q?=
 =?utf-8?B?Qk5LMTYvM2N2ZFhHRXFrcXJiRGFkYlFCNnkwQTV2UEVHTFBHaFpLQ3JrN2tq?=
 =?utf-8?B?d2o0UWxsZHU3ZjNNMFF6WTYxZUxMbzFIV3RSVHBvVDN2NTBRZzFXaytLa3Nq?=
 =?utf-8?B?MlRveUZuUWF1cXQ2eFBxcFhJSmY1dWQxQmpzUlZDbnRLV1NXTng0bXJDMkcr?=
 =?utf-8?B?WmxiV0hIMXgwQjNlTDYvdjFHTkhKVWhZVXZOTHpZS2grTDVob3Z3WkZFcEJ5?=
 =?utf-8?B?S2ZiNDdCM2hIbVM0a3MzZlV6dGZRZlRRZnJlbVZUeTB5akJVWnZjQ3lUdTFQ?=
 =?utf-8?B?VVdnaWRtTlVmVEJEVDFvT3ovZjZ0VmNvVU50d1BoS01KMFY4eTJ1WDQxQ2pQ?=
 =?utf-8?B?NmdWMHlqRE92ZTBCUGxJMEV1N3MwNCt6WU4yNHBXUyt5eHl3STZqRTd5Qjh1?=
 =?utf-8?B?eUxzZlhMZUhrWjNHVmFYd2RxTWdmOWJYQ2wyTXZ3cGp6Tmc0ZmpDZFJxcFRG?=
 =?utf-8?B?cUtjVDFwTE9iZWRKK2lFVXlYMGRNQTRYbGY4MkxaeWJwOXhsRkQ1c3l0bm94?=
 =?utf-8?B?Z2dDREh1N2hmVGVUbHZ3a3lvMzhkNkVUNGFSanl4aEVPUTVQYklQSUNnRE8x?=
 =?utf-8?B?R1cyY21tbVp4N1VFdkUvRWdWdXprSHRtTWx0SEdtang0Nkt2M01rcWVTRXVp?=
 =?utf-8?B?YkJGelFZVGEzbEc0UHRmdnpYVGZ6REtIOXZyUkRzVVREV1BKNE9tanI4bGVr?=
 =?utf-8?B?OGp1bEV1ZHFhQS95VzRLaEJIaW4zeVBFdDhPcERuWmxMN3FxZUxGT0dKZmFS?=
 =?utf-8?B?UGpOdTFsUHFndDdyR1U2N1EvTTEzZ2dYdGc1TlBSR01IcWpLS0VZK2FlL3Fp?=
 =?utf-8?B?U0dKY3ZZR3BlMUJtd2VUcVlUMXlvaTBaU0lOSGV4a3F1VU5qb2Y5aVk0Z3p3?=
 =?utf-8?B?U2NpcmlxcDZFc0xZYnhaUkRPTk1Hb2x3czNYV2k2MmxBUVJwSTFwbzlyY3dp?=
 =?utf-8?B?ZWN1dU5YMlJsb2Zickp3NjVXbWVSYzFpcnBmK0Y5V0pEeEo2YWluZGYrWVZo?=
 =?utf-8?B?WGtrV0dkc3BvOHdjbERkdDhjWnZwZnVRTVJjU3pXdEU3SERWUTFUVm8yYzRi?=
 =?utf-8?B?U1JnQ0hOVEl1dHFsczZSR1ZTOGtQOUtMenZnRVRScTlBK01tWEEyUGVkdWJY?=
 =?utf-8?Q?zWVQ=3D?=
X-Forefront-Antispam-Report: CIP:20.160.56.86; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(35042699022)(14060799003);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 22:55:45.6048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d409f5-554e-4af2-0d98-08de36acec1d
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.86];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7207
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

On 12/8/25 15:47, Ralph Siemsen wrote:
> To reduce SPL size, make it possible to exclude designware driver,
> while keeping it enabled in the main u-boot.
> 
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
> ---
>  drivers/spi/Kconfig  | 8 ++++++++
>  drivers/spi/Makefile | 2 +-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 2afb15fff1e..94054ba39b0 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -223,6 +223,14 @@ config DESIGNWARE_SPI
>  	  access the SPI NOR flash on platforms embedding this Designware
>  	  IP core.
>  
> +config SPL_DESIGNWARE_SPI
> +	bool "Designware SPI driver in SPL"
> +	depends on SPL
> +	default y
> +	help
> +	  Enable the Designware SPI driver during SPL.
> +	  See the help of DESIGNWARE_SPI for details.
> +

In addition to Tom's comment this should probably be moved out of the
SPI/DM_SPI if/endif and made to depend on SPL_DM_SPI.

>  config EXYNOS_SPI
>  	bool "Samsung Exynos SPI driver"
>  	depends on ARCH_EXYNOS
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index d5d1e543588..0dc2d23e172 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -35,7 +35,7 @@ obj-$(CONFIG_CF_SPI) += cf_spi.o
>  obj-$(CONFIG_CORTINA_SFLASH) += ca_sflash.o
>  obj-$(CONFIG_CV1800B_SPIF) += cv1800b_spif.o
>  obj-$(CONFIG_DAVINCI_SPI) += davinci_spi.o
> -obj-$(CONFIG_DESIGNWARE_SPI) += designware_spi.o
> +obj-$(CONFIG_$(PHASE_)DESIGNWARE_SPI) += designware_spi.o
>  obj-$(CONFIG_EXYNOS_SPI) += exynos_spi.o
>  obj-$(CONFIG_FSL_DSPI) += fsl_dspi.o
>  obj-$(CONFIG_FSL_ESPI) += fsl_espi.o
> 
> ---
> base-commit: 0e0a198a68be71148f5ec27ef86796174f91436f
> change-id: 20251208-spi-designware-spl-d85d6a26e5e9
> 
> Best regards,
> --  
> Ralph Siemsen <ralph.siemsen@linaro.org>
> 
