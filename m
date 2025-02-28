Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104C4C282C5
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 10:55:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 740C581101;
	Fri, 28 Feb 2025 11:55:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YQWaKCNC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E348807D7; Fri, 28 Feb 2025 11:55:10 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::631])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D26DD81269
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 11:55:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvCQPTQ0+bmdxakd+VjdGH5WcrHe0/czEe5orMWNk2HTXrDOZbCKeMTeUpRy8kptHuBvoWJ9Ck9nF8/R/aWeV+JCXcb8uZKh5GvSF4txetVSrblWol7XE2Vx8N6eoeOlawSzSNhxSNKOouiCsDZlp8cEMHbA4+5VQKdF2ZxSRMdeTQqfkl8MF4JdMj6ygh3lmer7kpphelh7AjhLKxff5883uqNQCDPO9RqxqOmbLS3x6Sc15pGlxidbIxC3i/N5IhnKHI4kqeccO70ag0Z/8UNCDDMiajrkmc9Fn8PCEifDr6HUBiSNwqGVbWOVdj31aRi/D7FpI36R87WmHUDE3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pn+tWS9pCWD+KN5Ty5zKTzGEOekb8gYhm/j7XGVJFYo=;
 b=aRT28EoSw7j6x7aGLTKGKZ1GDNaBGB/mm+ZMDgsBpyfiB/iLrq3TtGzrhKhvPLoK9dP3TPCcK3vGNCH9l61eycL/74QB58Duj8weyejWSCi/p7u4MX6D1Esl9Jmi6DN2SYCNiEYnHuooSBseAHFRzUJuWW/vORiaStyv4yHW/MAGT/UTiukaMlgs87C6Pcbv91CckzXKfZ51KczymKIhOdt5+JKXyFtX6WJLUxIOKWRD/lkYtoz5M1T0QTf56f7fXQErDrO19PkHmVlI4ToPAUu15MDpUOcxCURfhuoZBIzaThLTD3GJVRLgymMPe9AJ1hD1tFK/6tup2QGyQdMZnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pn+tWS9pCWD+KN5Ty5zKTzGEOekb8gYhm/j7XGVJFYo=;
 b=YQWaKCNCkHeML+5kHtdAwkuR4Wk6BVeApZBd+Ls52ISbbFLo3YA86pNpdZdsQyVqUUly07RV6ynJnTpbskROzvXXMj+jv20cdA8HJE0xVv4vif1nF4bE5MoC7iLjd2Ut0kRgFrvxtnFSlaCEYJj6d/Y5dqcYwjCCZIHoTKYcT4kvU2QQxViAcnRaOR41tJpRL++OSSXVWuby+8FemtHGfUl++P/5bUGS63gnhnhLwsH8wbGuv3oeMP1orjuYnu4iCMmw+TxXLVRsBxawlQl0t1XtflxhpMsNF3zeFN4cLcRZcQU//+eOiFS8iXRS7Nzi972ZlrIuS3dA5VaVlgp1NQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB8PR04MB7116.eurprd04.prod.outlook.com (2603:10a6:10:127::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 10:55:06 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.024; Fri, 28 Feb 2025
 10:55:06 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 28 Feb 2025 18:53:59 +0800
Subject: [PATCH v6 08/20] clk: scmi: check the clock state/parent/rate
 control permissions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-imx95-v1-8-09594e93cc9b@oss.nxp.com>
References: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
In-Reply-To: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DB8PR04MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cf8f1aa-28d8-4267-dc68-08dd57e65c66
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rmt0MVNkUzdTTFJaWE5oNStJRUExbHVKODVnRFE0cHFENy9UOEMwZTBVYm1B?=
 =?utf-8?B?YWkyYlpVQUNsTVFVUDQ5bkNrWU1YSmZtZGFkYnVOZzcvRTcwV3ZDcGF2VlV1?=
 =?utf-8?B?NktpRllzT1NPazBaRGtXYUxnR003M3dhUjdaTllpS08yZnBHd0wxa3ZiLzJR?=
 =?utf-8?B?c2U2Ry9naTVrdXEvOVBkSWRBK2hpeGlEMTRyOW9pNlZoaWRvWHU3cG41YWNJ?=
 =?utf-8?B?a2xyS25nT21VMXVZOGJkaURONzZ3WXdhSldEUDhmUmVJallPVmM1TUxMMTZs?=
 =?utf-8?B?bjk0RWNZd0IreWxkMnBkbXlCK0NVbnhsQUd5dE5qVkVoWlk5Rnh3SVRhM09a?=
 =?utf-8?B?dTVqK2MxYThyUnZOdHBTK2lLcHUvVEJ0RStUdis1b2JFMjM2ZlFJTDJTdVZS?=
 =?utf-8?B?VnA1WDIzeThJa21yb1ZURFlZOGp1VEV5UGtCbTVqMUp3S0lHZTJnY2E2ZU9O?=
 =?utf-8?B?NC9QMFZER3hNWndvMDR3UGQxRVlGd0J1VlRQRHV3dS8yVkx1ZkwybENlc1Bt?=
 =?utf-8?B?N1JucUlKSTRlbFZ6bkR6dGlpS1psUXNPcmswbGRVN2IwTjliSEtwc2M5VXkz?=
 =?utf-8?B?dlo0V1o0OXhJbjlVMjhwNVlLK1RSa0pnM3AxeDZ4K0drc053N083RzZ3a0I3?=
 =?utf-8?B?Y2dDZ2NQaGpYUHBSNkowZFA3V2tJQ1hqSnNnS211cEQwUzRCNlNSbVRRSFY5?=
 =?utf-8?B?eHNlQVRDWW5RRHA5cW5xR2RIeUsreCtGYWxzNm5ZYVozMjNtZXcwNlpGNW9E?=
 =?utf-8?B?VjN3QnVmVlB0MGpsTm43MjZhNkV0TUVRa3JvOHB5d1FxSW5JMEVreGVaRVEr?=
 =?utf-8?B?dnJBcmpuTHkxelRKNk5YNndqRlIxZGIvSnF5d0JieTY1UTRsZ1lUTkY2TndX?=
 =?utf-8?B?ckQrWmdrb3FGcCtER0hmR2R5SVY2VHV0ellmOUJBTHRJeWpuZjhBd1djdHJG?=
 =?utf-8?B?UjZmSVJjbUttODJJUitvM3ZxR3hEV29SWHNkcFcrV3UyWU5maC9Id0J3cDFP?=
 =?utf-8?B?Q2Z3di9VYWxFV3lUeXJ3ZUZ3WDV6UFVCc1pJMWx3K3k0dlpQMEd0aXNtWk9z?=
 =?utf-8?B?aSs5QTVnYUw4MG5yeGV5Zit5aHREUXVzRnlyWWZ0VU5SaDlmbVZqT1g5MHFR?=
 =?utf-8?B?cGhUbVByUW1GZzlhN2E4bm12TmxzV1g4NVZ3ekZ1WkpSTnB4OWVCV2J6WVdO?=
 =?utf-8?B?Mm5UM2ZuakdsV0R6SXdWL0FrYlduOFhJc0R0NnA3YThRWFBka3hod1N5Snh2?=
 =?utf-8?B?NWpwTEVHOWNtUi9nWmpzNHZMUlFjcWdyT2NFenRneXA5K1dIQTZnM0tyUE1Y?=
 =?utf-8?B?aE8yOWJ5cmwzN1U2T2VBZVp3cVl2T21hZ1ZodUdpU1dHc3Q2cFI4WkZnWGpp?=
 =?utf-8?B?UUVYMXM3RmVaQXJudGVZV0NUY3BhMko0c0NFSHhzWlpQMDdXak9QelpGRjc1?=
 =?utf-8?B?Vy9MV0pFU3g1SC84Y1UwRWN6bnByTlR3TkNrNHkxVWxRNmxhNmxjZnZuZVFO?=
 =?utf-8?B?ZzJsdlJBZDJXaTNVYTlkTlVSeHdzNElxcEM2VDhHZFcvdlBHZnYyM0VqdXVp?=
 =?utf-8?B?d1oxR3lvbkpxdndiRlU0QnJaaExEYVJHQXU1MGs2V3J0QzFOV1grZVV4ZjQ0?=
 =?utf-8?B?VFh0blo2VCsxMG8rSzI5akxKYmZWR2FqK1o4K2s2ME45NGxESlZ0VEkxdVA3?=
 =?utf-8?B?THVRSHFaZ0E3Q1J1U2d1ZDV2UGVCeThkdEhNNTFMRmlBQTFheGVOSWZWWVZ1?=
 =?utf-8?B?ald4SUx6cDU5alZMNmhOaFF5QWFYWSt5cytJSlUzWk5OaVhXenVJeU9kdjhp?=
 =?utf-8?B?VEQzUlZZVjdvWXRhU3hsQXh1cGllSTZLNGEwYU5xamFYUEJicUdtNU9LVW1S?=
 =?utf-8?B?U0U4bWdhVENOTVVteWlETjJGVVF3Tk1Qb2hZWURBZXFkUk1vVnZITzhUWEI1?=
 =?utf-8?B?dmhuZzA5TTVhQU1xRjRvK0dMcDRGS01uR1FTd0Naemc0TU9HeXFkTy9IMW5P?=
 =?utf-8?B?UHRZVStlR2JRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TE1VNkduQS9uM2FNc04zN0lFWTQ1cnhHeWZiLzkyQVoyT09FQWZMeFUyMU94?=
 =?utf-8?B?VlR2QlpIWGYyUnE0MXdZRFpFQ1MwWjhUb1FUUGpGdk5kVXBiSXlBcFJMNys1?=
 =?utf-8?B?V043NlJ3eVBMRGZxM1pCUWZLcmQ4bUlHQnRlQ0k0UXNkK3NWZUs2NUZtbHpi?=
 =?utf-8?B?MFR5SFVYT2pqUGlPZmZIVVlzUVJBbmtpNmg1ck4yZ0VFTzBuRUFhbEJKd0pG?=
 =?utf-8?B?RWxwYzlqVjVrcEJPZzFUVk1KNndhSnQ5WG5Qc085d1lwVDBLK3VzVURQL1BY?=
 =?utf-8?B?UkpQQU0xUHcvWVNFcGkxcU1XSnNZNjVlUktoWHNPNnRmY1hjemtSc0NKcXZs?=
 =?utf-8?B?bGhWVjFpdUNYVjM0OVk4M1NuN085SytYR21QaVRGci9uRGphZXhtajNIMTdP?=
 =?utf-8?B?NmFybElCQW5yS1Z0SFFVTzhocEJkNUswTG1lWmROOEtKdVg2c094OEdEZko1?=
 =?utf-8?B?QkpITGptaE1VbVZTaXpjQW9YNndQcGVETTQxWXVHLy9pOGtvTGFrQk4ybm5y?=
 =?utf-8?B?SkJHYWNvZTVqdVdxSGRuazlSbjFFUFBOQmUyWmFMTWhKQmo2UXczY0p2K0hJ?=
 =?utf-8?B?dU1ETzlLS1JqRTA0YWNLbTYvczI3SElUaDNVVEdUTzIzRU96ekIvVlBqb09D?=
 =?utf-8?B?QjlDbjNCTTU3djRDVDMzZ0IwWnZYMmUyaDArZFVvaVYvc3pkVlh1SFRjdUo0?=
 =?utf-8?B?cHlML1Q3Vm9nMGc0azljUXZOSURLdGsvaDd1UnFWM25rSDYyNlhnam5ONkQ5?=
 =?utf-8?B?TmFUQ0J1NE5ZUFNZTDFzdmRLT3NsUWM2a3FQdm5ORFRrNzIvQ2V5VXJNUFNX?=
 =?utf-8?B?cnM2dGJQTmMyOVI0SktTK0VCSlZ1VUdvTlVERjJETW9uVStnNm85aGQwTkMw?=
 =?utf-8?B?YmZVV2s5UWJ2QzFUWEkyYWxOMXlnL0tWcEZxcEcycWxHVzJrbCt4d01STDdU?=
 =?utf-8?B?aGNrbkpxS3BMVERKdHY4VVU4MW5SS1hYUy96VkVqQ0pHT3hpRHlyVHo0ampw?=
 =?utf-8?B?TFd5eThweDdTNU9XZVZhdjcveWRhY0pZZVl3V2VTaHBGT2Q1aXVVUFZ6a2N5?=
 =?utf-8?B?YTB6Q3dyaU9UeUZ1aEF3RW83bGRhY1BUUTlpdmZKNzJjRlZNaVFXR1pXUkNw?=
 =?utf-8?B?dm1LVlgyR012N3hBR003a04yZVdOTmRtS2JZNFpDV0IvZVJrTE8rV2w1Uk1m?=
 =?utf-8?B?elZIQnIrbGZUUWdGUy9GWWxHYUVWS3FVc2NVbTZWUEVUTUtxZHNUamJQTFZ1?=
 =?utf-8?B?UkhxUHc2ZDJDM1E2b1JKazRTSXlEQVFaR0ZuSG1hREVCK3BRQlBzdnNKTzBM?=
 =?utf-8?B?VTNoSEtCcUY2M1JRb3ZMWUNXYVdzODl3Ulo5Y2tyK2pRZk1TRjk5eTlvZDRq?=
 =?utf-8?B?R09qVTJoL0xvVm8zWXA4dTRSbnNMdVVRWGJMNHpQSGI2UEZqdStzNmsvK2VJ?=
 =?utf-8?B?L1JybExlaHVhVW1lWUltaW85blFHYkFGNmYzTEdGSjBIY2F6Sk5NZU15RUsx?=
 =?utf-8?B?M2NKWWZFYjhvYlBPZ0tqT2JEQlNzazZWV1Jjdkg5aTJWb004NysvWkhNM2xF?=
 =?utf-8?B?WHkwOXhMRy9sY1JtNy8xMndsMVI2WVUrczFZNjNlck1QSVVmRUcrd0N6dDZ5?=
 =?utf-8?B?ak9UV2w4dUtVRGkwUm5xWitWZjRJUW1ld0g4V3FDMHlWcGJTZG1QYWd5SzdB?=
 =?utf-8?B?SlBjRnFZNW1adzFvQnhyVzNCdm5udXJ1SlZwai94dFhkdEk2b2JoQ3ZzQlBR?=
 =?utf-8?B?OWI1eGJwZEhNSTBqZXk2TGlpalIxMXNQbmt0WU5tU3I4NzlhZEc5dmZydno3?=
 =?utf-8?B?ZE5RQXZTanBGMU11eUZhKzhsU1psdGY1N1pDOUNGbk9vOVN0d1o5eUhOZlBM?=
 =?utf-8?B?YngxRG8waUtYRHZocUYxODlGakkxMjJqRjlVQk02NUVUTEN3QmRPeFFRTmFW?=
 =?utf-8?B?TmxSM3BZS3UxampLOS9kV2N1MlZRczVmc0IwUzVqSnNFWTRuU0QrV0VOQ2Zm?=
 =?utf-8?B?U28zVC9KalIwSkRRVU44TXdPRzQrS0xJeDFHakdLc0hvdE9IckphMmpBM01X?=
 =?utf-8?B?U0Rwc1R5N3BlcXNQMGVxa2svMXlyMU5nY3pwUTJreVZNbCs2TGtVZ09mMUJn?=
 =?utf-8?Q?x/ZuCiWnilzVKK+ukQcVS2sjf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf8f1aa-28d8-4267-dc68-08dd57e65c66
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:55:06.2559 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M7yvOhlfmITeXqgGsd5VY58DLR3tCY7WyzqYvYXZ5Uu251+/sQqXkL+yIBqBN/phxw/2Kp3vkUWc86pXvVmBdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7116
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

Clock driver based on SCMI clock management protocol in Linux checks
clock state, parent and rate control permissions. To be consistent with
the kernel driver, add this check here.

When using common clock framework (CCF), use the clock signal ID to get
the clock registered by clk_register() in scmi_clk_probe(), and then
obatin the struct clk_scmi variable with container_of().

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk_scmi.c   | 172 ++++++++++++++++++++++++++++++++++++++++++++---
 include/scmi_protocols.h |  26 ++++++-
 2 files changed, 187 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index 84333cdd0c..4fce92d064 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -12,6 +12,56 @@
 #include <asm/types.h>
 #include <linux/clk-provider.h>
 
+struct clk_scmi {
+	struct clk clk;
+	u32 ctrl_flags;
+};
+
+static int scmi_clk_get_permissions(struct udevice *dev, int clkid, u32 *perm)
+{
+	u32 version;
+	int ret;
+
+	ret = scmi_generic_protocol_version(dev, SCMI_PROTOCOL_ID_CLOCK, &version);
+	if (ret) {
+		debug("get SCMI clock management protocol version failed\n");
+		return ret;
+	}
+
+	if (version < CLOCK_PROTOCOL_VERSION_3_0) {
+		debug("SCMI clock management protocol version is less than 3.0.\n");
+		return -EINVAL;
+	}
+
+	struct scmi_clk_get_permissions_in in = {
+		.clock_id = clkid,
+	};
+	struct scmi_clk_get_permissions_out out;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_CLOCK,
+		.message_id = SCMI_CLOCK_GET_PERMISSIONS,
+		.in_msg = (u8 *)&in,
+		.in_msg_sz = sizeof(in),
+		.out_msg = (u8 *)&out,
+		.out_msg_sz = sizeof(out),
+	};
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret) {
+		debug("get SCMI clock management protocol permissions failed\n");
+		return ret;
+	}
+
+	ret = scmi_to_linux_errno(out.status);
+	if (ret < 0) {
+		debug("the status code of getting permissions: %d\n", ret);
+		return ret;
+	}
+
+	*perm = out.permissions;
+	return 0;
+}
+
 static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
 {
 	struct scmi_clk_protocol_attr_out out;
@@ -32,7 +82,8 @@ static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
 	return 0;
 }
 
-static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name)
+static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name,
+				 u32 *attr)
 {
 	struct scmi_clk_attribute_in in = {
 		.clock_id = clkid,
@@ -53,6 +104,7 @@ static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name)
 		return ret;
 
 	*name = strdup(out.clock_name);
+	*attr = out.attributes;
 
 	return 0;
 }
@@ -78,11 +130,49 @@ static int scmi_clk_gate(struct clk *clk, int enable)
 
 static int scmi_clk_enable(struct clk *clk)
 {
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (CONFIG_IS_ENABLED(CLK_CCF)) {
+		ret = clk_get_by_id(clk->id, &c);
+		if (ret)
+			return ret;
+
+		clkscmi = container_of(c, struct clk_scmi, clk);
+
+		if (clkscmi->ctrl_flags & SUPPORT_CLK_STAT_CONTROL)
+			return scmi_clk_gate(clk, 1);
+
+		/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+		debug("SCMI CLOCK: the clock cannot be enabled by the agent.\n");
+		return 0;
+	}
+
 	return scmi_clk_gate(clk, 1);
 }
 
 static int scmi_clk_disable(struct clk *clk)
 {
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (CONFIG_IS_ENABLED(CLK_CCF)) {
+		ret = clk_get_by_id(clk->id, &c);
+		if (ret)
+			return ret;
+
+		clkscmi = container_of(c, struct clk_scmi, clk);
+
+		if (clkscmi->ctrl_flags & SUPPORT_CLK_STAT_CONTROL)
+			return scmi_clk_gate(clk, 0);
+
+		/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+		debug("SCMI CLOCK: the clock cannot be disabled by the agent.\n");
+		return 0;
+	}
+
 	return scmi_clk_gate(clk, 0);
 }
 
@@ -108,7 +198,7 @@ static ulong scmi_clk_get_rate(struct clk *clk)
 	return (ulong)(((u64)out.rate_msb << 32) | out.rate_lsb);
 }
 
-static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
+static ulong __scmi_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct scmi_clk_rate_set_in in = {
 		.clock_id = clk->id,
@@ -133,9 +223,33 @@ static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
 	return scmi_clk_get_rate(clk);
 }
 
+static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
+{
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (CONFIG_IS_ENABLED(CLK_CCF)) {
+		ret = clk_get_by_id(clk->id, &c);
+		if (ret)
+			return ret;
+
+		clkscmi = container_of(c, struct clk_scmi, clk);
+
+		if (clkscmi->ctrl_flags & SUPPORT_CLK_RATE_CONTROL)
+			return __scmi_clk_set_rate(clk, rate);
+
+		/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+		debug("SCMI CLOCK: the clock rate cannot be changed by the agent.\n");
+		return 0;
+	}
+
+	return __scmi_clk_set_rate(clk, rate);
+}
+
 static int scmi_clk_probe(struct udevice *dev)
 {
-	struct clk *clk;
+	struct clk_scmi *clk_scmi;
 	size_t num_clocks, i;
 	int ret;
 
@@ -156,29 +270,44 @@ static int scmi_clk_probe(struct udevice *dev)
 
 	for (i = 0; i < num_clocks; i++) {
 		char *clock_name;
+		u32 attributes;
 
-		if (!scmi_clk_get_attibute(dev, i, &clock_name)) {
-			clk = kzalloc(sizeof(*clk), GFP_KERNEL);
-			if (!clk || !clock_name)
+		if (!scmi_clk_get_attibute(dev, i, &clock_name, &attributes)) {
+			clk_scmi = kzalloc(sizeof(*clk_scmi), GFP_KERNEL);
+			if (!clk_scmi || !clock_name)
 				ret = -ENOMEM;
 			else
-				ret = clk_register(clk, dev->driver->name,
+				ret = clk_register(&clk_scmi->clk, dev->driver->name,
 						   clock_name, dev->name);
 
 			if (ret) {
-				free(clk);
+				free(clk_scmi);
 				free(clock_name);
+				free(&attributes);
 				return ret;
 			}
 
-			clk_dm(i, clk);
+			clk_dm(i, &clk_scmi->clk);
+
+			if (CLK_HAS_RESTRICTIONS(attributes)) {
+				u32 perm;
+
+				ret = scmi_clk_get_permissions(dev, i, &perm);
+				if (ret < 0)
+					clk_scmi->ctrl_flags = 0;
+				else
+					clk_scmi->ctrl_flags = perm;
+			} else {
+				clk_scmi->ctrl_flags = SUPPORT_CLK_STAT_CONTROL | SUPPORT_CLK_PARENT_CONTROL |
+						       SUPPORT_CLK_RATE_CONTROL;
+			}
 		}
 	}
 
 	return 0;
 }
 
-static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
+static int __scmi_clk_set_parent(struct clk *clk, struct clk *parent)
 {
 	struct scmi_clk_parent_set_in in = {
 		.clock_id = clk->id,
@@ -197,6 +326,29 @@ static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
 	return scmi_to_linux_errno(out.status);
 }
 
+static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	struct clk_scmi *clkscmi;
+	struct clk *c;
+	int ret;
+
+	if (!CONFIG_IS_ENABLED(CLK_CCF))
+		return -ENOTSUPP;
+
+	ret = clk_get_by_id(clk->id, &c);
+	if (ret)
+		return ret;
+
+	clkscmi = container_of(c, struct clk_scmi, clk);
+
+	if (clkscmi->ctrl_flags & SUPPORT_CLK_PARENT_CONTROL)
+		return __scmi_clk_set_parent(clk, parent);
+
+	/* Following Linux drivers/clk/clk-scmi.c, directly return 0 if agent has no permission. */
+	debug("SCMI CLOCK: the clock's parent cannot be changed by the agent.\n");
+	return 0;
+}
+
 static const struct clk_ops scmi_clk_ops = {
 	.enable = scmi_clk_enable,
 	.disable = scmi_clk_disable,
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 0d8c177025..2684f4177d 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -731,13 +731,15 @@ int scmi_pwd_name_get(struct udevice *dev, u32 domain_id, u8 **name);
 /*
  * SCMI Clock Protocol
  */
+#define CLOCK_PROTOCOL_VERSION_3_0	0x30000
 
 enum scmi_clock_message_id {
 	SCMI_CLOCK_ATTRIBUTES = 0x3,
 	SCMI_CLOCK_RATE_SET = 0x5,
 	SCMI_CLOCK_RATE_GET = 0x6,
 	SCMI_CLOCK_CONFIG_SET = 0x7,
-	SCMI_CLOCK_PARENT_SET = 0xD
+	SCMI_CLOCK_PARENT_SET = 0xD,
+	SCMI_CLOCK_GET_PERMISSIONS = 0xF
 };
 
 #define SCMI_CLK_PROTO_ATTR_COUNT_MASK	GENMASK(15, 0)
@@ -776,6 +778,7 @@ struct scmi_clk_attribute_in {
 struct scmi_clk_attribute_out {
 	s32 status;
 	u32 attributes;
+#define CLK_HAS_RESTRICTIONS(x)	((x) & BIT(1))
 	char clock_name[SCMI_CLOCK_NAME_LENGTH_MAX];
 };
 
@@ -858,6 +861,27 @@ struct scmi_clk_parent_set_out {
 	s32 status;
 };
 
+/**
+ * @clock_id:	Identifier for the clock device.
+ */
+struct scmi_clk_get_permissions_in {
+	u32 clock_id;
+};
+
+/**
+ * @status:	Negative 32-bit integers are used to return error status codes.
+ * @permissions:	Bit[31] Clock state control, Bit[30] Clock parent control,
+ * Bit[29] Clock rate control, Bits[28:0] Reserved, must be zero.
+ */
+struct scmi_clk_get_permissions_out {
+	s32 status;
+	u32 permissions;
+};
+
+#define SUPPORT_CLK_STAT_CONTROL	BIT(31)
+#define SUPPORT_CLK_PARENT_CONTROL	BIT(30)
+#define SUPPORT_CLK_RATE_CONTROL	BIT(29)
+
 /*
  * SCMI Reset Domain Protocol
  */

-- 
2.43.0

