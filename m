Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E35C36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 10:38:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFCE3826F3;
	Mon, 28 Apr 2025 12:38:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="sLQy//nn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5B29826F3; Mon, 28 Apr 2025 12:38:39 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9118182145
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:38:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LqpklRfNSw0YXEwJ4Jg3YqLqY4AzwJdia4+3Uo8Qbv1OVpotaVo/T11BPJxewAoJnn8ZKgEudU+y7mWgt3sv+BQb0GLatxPFSfAC50ZwjjDtWGvXxmyY8aEKOgGHQVX2wF4fbCafSdpp/a8Zi1A4OZTdyrgo+MYjIDWFRVUqGkVmkod47Guc/H7frVmPZik2iV+FP845jJvTi4Gz61R+vcffwU0wVbEvxQJf8BU+MrtiK0laUfaRMCjdyFIuRhrGJBRBf8oQavExtYqo56K9CVaaMAqCpIHVuuGsKu0TEHc6qYD0JcupHnAnZprIkj4rGNMzTnUM8q3jUSfBgX4EjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XBmZfh/6mwyXIJx79ushPmEBcQzlWtLrvWr0wfw0kw=;
 b=g9LDQpP78vTFi6MWraxYxcVsejpFXHEKygs4RMl8fTZEWP1XpWnlswaGCAeeCL1y6+zCDNvOPYG06dkpr1/Nc5lKvKTl4bq5Qgd/k7uqVZP/+b4l7eay7+H1u5CuUJVbyY+oBGhPNRebtYs+9a44lcCMg4SqukT8KoMuHHNU9ctY+zeMUE8w7MWbNuJKhi9rXkSIzkqDY36iFU4+Kmmt59WD+Ntmqlk8c7j56+SU9QwkT1nd5r6LndRUKULt5WuqWmaFBnrwwRqmo5VB7cXDv71+Sb1gVsHGFA+zKTCjDU+muYbJrBgxC0VyRr/5Wx9sN9PfKHD9+qo7B0CpLIY90Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XBmZfh/6mwyXIJx79ushPmEBcQzlWtLrvWr0wfw0kw=;
 b=sLQy//nnnjRaGmnhOSFX9tsauwQNLmO8YzYQPM+osx2wsPJEBG9Cgizrq+FRoA0p00Y9ojnehtDfY0+UcPEd1f06EuX10QEHdqCU/XCoNGpgBalTG3xj4TbFfCZll8DPuL3QVY8BXdH2pFgwmBvTdcOMNMG393Ngirgqq+5lYCkp/0x7OXwupK3GyHaIYG777kxlJ1bgd1Oo/Dx5SHRdgNCXiOyySrhRks3VL0ksSpoIwx9EaXY8WES7JJnPifoViFINJTTKFMlha8OfQnvA/Oo1/7BYiTiq+vsWIy0mekMiooQlmkMwb3223FrWjYUZUhmyFHngjx0OdPVd/qLJvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV1PR04MB10393.eurprd04.prod.outlook.com (2603:10a6:150:1c9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 10:38:35 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 10:38:35 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Mon, 28 Apr 2025 18:37:26 +0800
Subject: [PATCH v11 03/21] pinctrl: nxp: add a pin controller driver based
 on SCMI pin control protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-imx95-v1-3-a3df9c340ace@oss.nxp.com>
References: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
In-Reply-To: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>, 
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV1PR04MB10393:EE_
X-MS-Office365-Filtering-Correlation-Id: 0961b7fa-80df-4076-fb25-08dd8640d420
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDV1Nkd4NllxZi9rcjFlT1Zpd0w1cW5icnMxUlBQeWRzUGJPSnFyRTVDSGYy?=
 =?utf-8?B?YzNjWHU4eFJiYmJ3bGI3c2x2QWlIeXdKL3owVFEwQStCV0x0L3JSQXI4NVFx?=
 =?utf-8?B?NHpHSkd3N3Y0RndvQ1VSc3dhQktGWmoxL01SV0hlWlQ5NVE4MElja3EweXMw?=
 =?utf-8?B?M0tVdG1OaUMzV3NFTklpM0NTRDJOUC9sRVo1aWlFQmV4VzBSaU4vaDBORTcz?=
 =?utf-8?B?S29DTGJvT09RWTVXQ1lTY1MxdUlqMkdJR2dyK1RsNDAyZzhoaG9RanFCYXFk?=
 =?utf-8?B?NDNuSCtJVmR5SGFJODFuUjQzQjRlVVFQNSs4V29xRFZCOWdiNmVNRGhERm1K?=
 =?utf-8?B?MzY0WU50SHhGUUlqa294eEpnRnhHaGU5UkhZeU5kOGdZQ2FadXNvNFBqNDFw?=
 =?utf-8?B?d0pWQ0pDOEd3RUhmaUY2anp0R1Jucmw2RTIyekFRTFR5MVlmTXF6WXV1Q0RQ?=
 =?utf-8?B?dlpUOFN5NjdnMXFYVHk5T29DYktlR29MNEpzYUoyVnprYktQQSsyNHJrTFZG?=
 =?utf-8?B?WTRNNVdobk5iUEdpWGpyaUVNNFY4ZC9uRFovcWMrV0FaQUJuakVxQjRCb0JY?=
 =?utf-8?B?S1oxek53Q0dFUjJ5WTNvWGhoTXAxTVV3eVl1Q3c2UVJuWjBmeFM1UEFCcDV1?=
 =?utf-8?B?U1QrQUwxaEJJdlpyUS80Y3kvN29FeU9kYXVyUW9JODF0bG1PbWZwTmVkeExY?=
 =?utf-8?B?WFE1cmRyemIrS3VObUQ1dFplUFJGY25kZHVPMU1UenExQkRabGhXaHI5QjlE?=
 =?utf-8?B?WVhlTGJ3WldNZVp1eXNhTThCRVd3enF1ckJUdG9qZmpKNzNpTkpyWDVpa0pI?=
 =?utf-8?B?aXF2Zk10TlRab0M1VlpMT3ZaVVNwMHA4VGNLSGpOdlI1dUlFN0czOWNQNkpB?=
 =?utf-8?B?Ny8zMUlRQkdvRHl2N0FPZFcrMkRBMlZiOFgrUWxDWGhXbHFrU1F1dW5BazJP?=
 =?utf-8?B?QTl3QWpGM1NqQjl3VFUzZkRpM21oOGpvc2NDTFMvY00zZGplYUU0TXgyVHpT?=
 =?utf-8?B?U2Jvc1hPTXhGYkxKMGpWSkQ3ZVU4d2FGeVZ6THpEUlJWT0x0NU15RVFyUWs1?=
 =?utf-8?B?RGFVWGlzM1pRcWs4N3Evc3pkOVppZkhZZFNNU1NuNHpuei94YjRJc1BQaDFk?=
 =?utf-8?B?eWRycWVXbWxRb2gwYXJYaFJzbzBaSUl5NkR1cFBKbjM4ZzZXcm50S08yaGxU?=
 =?utf-8?B?SlRFcGplcTk4THFsS0FWeXhkMzhvWE9YSnZXd1lHRDRwR0Y1T1FYVFJXWkhv?=
 =?utf-8?B?ejNqTXJ2Wmc0bUFkdEFJRU9oQW0wUTJGbU9yWXlUTWlXc0ovdjVUT2U1d29u?=
 =?utf-8?B?WHY5R04wV20ycFZnVDY3RU9lNVVlZy9ENzdkKzFjSnBJeTBqdVJGamJWZGhQ?=
 =?utf-8?B?a0dVY3RtajIyYWJzc05ORThva0VxMWdHVGtEenJzK01BYkdxTTBqSzR1RmR3?=
 =?utf-8?B?QXRERWJTZnNOaE9nMFhjVjZrV0JSaSt4aGZJYkxuNG9WeS9HaG0wR2Npbk1x?=
 =?utf-8?B?SUhIblVrcER4NEY0MU1tcFptTDlPWSs2VHFGamFma3pPZ0Zkb00xVkxUaFB1?=
 =?utf-8?B?NmRvcWMvT21FeHpnOVFZS2xlWlIvWS9ZaDk5VmhxK0xIOXk2WG1oMlFLNXdk?=
 =?utf-8?B?SHlVNzhhQ0VLZjR5RXY0Zk9INlNITmxMNWNjZ2VOSXhQQ0Z0cEZnREpGZzZY?=
 =?utf-8?B?Vk9EYTF0dEI1bzErMnJaSC9yUzZNdlF6RVVMQ2JEWml0aWUxM01LODhSdldD?=
 =?utf-8?B?VGdjMFlPOGowT2RGNEJzZXRFYzhMVll0eENxZnFieXc1YmpBRlhIWFFXNGNL?=
 =?utf-8?B?dllwcWp3em5BZjNoQ0Y4WGJqdzV6Y1NTYm81elJxdXhZb2JudXlyaTllcGx2?=
 =?utf-8?B?TkwvaTd1cHQ1WXppTy9OblVGbnpTZnE2RDJWb1IyTEVZK2ZNMTY1Ry9jbDRB?=
 =?utf-8?B?eVZCcG9iVTNlWDZJeXFuTDZRbzk5SU9VcnFyamtqQ0FJbDZKMG9FM1VpeXc0?=
 =?utf-8?B?VHBZQkhTRlJ3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnIrUDdxeFM5RTJmcms0RHVPQzFkTkhpUUxuSStCNGhaa3AzQmQ0YlgzSytC?=
 =?utf-8?B?c25QWVpFb2pRaEp4YVEybm5jU1RWNFcxYU9rRnlWTUhTejByMW1Lc04yWXRC?=
 =?utf-8?B?Nk5keU1oQ3RPeXNLTHhndXZSN0k1MVBZRHBRa2VXOSttWWpGTGI3aGlCaTVI?=
 =?utf-8?B?Z010T1lObXJETnQ2RVBoTE82cUh1SmJSbk5Jb3E4VGhRNFlhNzVMY2V5cytM?=
 =?utf-8?B?SlJEa3F0NzBpelEyM0lpTjVSdnhsc2VkUXVBMEJHV0RRSzJ2QlJqdzNFbFR5?=
 =?utf-8?B?d3pmV0VZbkhnRCtDOGNvWTlWd0Ryai81ellHTktreTN1MnJSOGZ4cy9RSTVk?=
 =?utf-8?B?UUdyNjhQMDhLMmJHUjRBdjVsNDU2R29odUlYZjNjckZKd3pzYklQdWxJM3F0?=
 =?utf-8?B?cUVpWDVOS01tcytWZ0ZwRGlCdElScjRiM0RMb2RsRHVWY1J2WjNVaFBPb0c2?=
 =?utf-8?B?dXh4Mml0TW1GK1UyeHhOQmlxNWJHUmdwMDZEbTNJRng5TkcxODB2UXJUYWNP?=
 =?utf-8?B?ejRHRG42c2lPd1N2Y2IxSnBEeThWODVFVmhiWm4zQUcxMWliMExIa09vbGNN?=
 =?utf-8?B?RHVEd3hoeEtaZlhkelcwQ1VQNEY0d0d1SUlsTGF4NEVBMkhWWHFBM0NCTjZ6?=
 =?utf-8?B?VHAydHA3aG9KQXpIUU0xSlZvamlCbEp1WW1reVR0ZFJlNW9XTVZsN3lORCt1?=
 =?utf-8?B?cmpLZU8zcDJpdjNqdC9NRUtXWVZTOUgrZjcvRFNtaXpZY3Ztd28vWkRRaEx0?=
 =?utf-8?B?YjltV055UFREUmlWVXV6MHgzMndHS1JzWjArQTQ3ZUdzaHNTSnFnS3c2VVVG?=
 =?utf-8?B?MGdwb2V5U1JoaUNXWVJxMkJSdVFyNXV1L3RtQUw3eVNTUDkrdlUzS082cmxx?=
 =?utf-8?B?UzBWdEh5VVFpakZtdExmc2QwU1B5SHU0Q0gwZDd4a1JhMklaV1ZvNTB0QkZn?=
 =?utf-8?B?Q3V0TGJGQzNqK3A3UDI3MmNEbjlhYjJsTmgyTVZIZGpOSzJjUWEzTzZ4N2F0?=
 =?utf-8?B?d1ZlcDFVVzI1VkJLYW14Rjk1NllyQUx5SVcvd1ZVYVdzbHArdVBCTEdKQ0dM?=
 =?utf-8?B?MDE5M0x3czdDRVFmeHhXbndzcUI2eVZKK1VqTkNjTFFleTBDTlBKMXMrcWU4?=
 =?utf-8?B?NEZuY3hwNE1paWZYK3RzbTZHM0ZRNDVDV0ZWNGVpSDhXY1M0dUhyODA5c3pS?=
 =?utf-8?B?eW9UU1ZWZHN2MkFBTmZKaUgzSDg0M0I1K0JjRkl1MlkrcVR0ZDU1VVh3Mnpz?=
 =?utf-8?B?OStUVGhqalB3ekRPNlQ2ZUxBYkJnQnIyWjhXTDdvZWxuL0cxeWN3d3lsZHBO?=
 =?utf-8?B?blVtSTNSbkd4NkRzRnB6UmhwVkF4OTBNSlNScTRadjJQTWJqMHJ6ZHR6eUh1?=
 =?utf-8?B?Z0ZRR3YvcXFmcWFSYk5GcTA5dnl1YzRmL3IvZjVoODVJZXlYVXBoYWtLREdt?=
 =?utf-8?B?YVdtc080amprTi9aMG9jMXZDRkZ0UUxaeVU2RDlNS3cwc1doN2dmVDd5bEJv?=
 =?utf-8?B?U0RNTFg4U3dGUms2QlI0YjJ1Q2gyMjRDN1liZjJScC9NaHJUTXUyL2xnZTAw?=
 =?utf-8?B?bzl5UmNWaTJQQmdDdWhBYlV5QlJ6VHRJeVNnTVhIMU1sc0xYNkRyaEVaMFlW?=
 =?utf-8?B?aEliSUZkYWx4OVRudzdPaURDdUMwUU92bDhtTWxiTXRwM09wbmtQTk5vdjB2?=
 =?utf-8?B?eFQ1NHhjWG5EbXdqdHlPY3YyWm01SFU0ekduM2w4K3dHOFhua2s5ZGwyL3Iv?=
 =?utf-8?B?S1RYNHNGNUpYUnhlZ01sS0ZKTmUrVEgzczg2YUYzUkxQWlpHV0wzeHZ4eDZ1?=
 =?utf-8?B?SlJvdkVsTkxCUmFRdUdxSGpXZGJiakcwWE5DM0kvWVpCVS9vT1dTWFcrSzJG?=
 =?utf-8?B?TXBtNUlFaEE0eExtampwSEtpSjFuVDFGY3FScTFGaHZNNkg0bHNhT21DaHBE?=
 =?utf-8?B?MzN3QngyaW1EM29mWXRVWm0wVC9NSjFIY08rRUdZOWk4bmZjSEdNNHRXTE1U?=
 =?utf-8?B?TVBWb2FnUGNpWldzd2dZT3gzTExFU29FZlZWaFJncHNGeUR4RnpjNTJNVk00?=
 =?utf-8?B?VlJvN1hPckJOdWk0OUdMVjJjdFdRZFFCTzBqMEMwaVVId0I1TmhzUWFCM2Nz?=
 =?utf-8?Q?4SXf34BPFvNSJU1p6JZGvKwXx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0961b7fa-80df-4076-fb25-08dd8640d420
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 10:38:35.3340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1oi1nvBYwfebfZ/2mgMpYhq5d3GYNegnCmQn8+xlOPREceN+Nb3EeGfwEpYWcm9iqDHLdHQty9UgIT287+sSPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10393
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

This patch provides a pinctrl driver based on SCMI pin control protocol.
Currently, only the PINCTRL_CONFIG_SET command is implemented.

Signed-off-by: Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/pinctrl/nxp/Kconfig            |  13 +++
 drivers/pinctrl/nxp/Makefile           |   1 +
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c | 157 +++++++++++++++++++++++++++++++++
 include/scmi_protocols.h               |  36 ++++++++
 4 files changed, 207 insertions(+)

diff --git a/drivers/pinctrl/nxp/Kconfig b/drivers/pinctrl/nxp/Kconfig
index d13c5f2a6d5..84d9a3641ff 100644
--- a/drivers/pinctrl/nxp/Kconfig
+++ b/drivers/pinctrl/nxp/Kconfig
@@ -139,6 +139,19 @@ config PINCTRL_IMXRT
 	  only parses the 'fsl,pins' property and configure related
 	  registers.
 
+config PINCTRL_IMX_SCMI
+	bool "IMX pinctrl SCMI driver"
+	depends on ARCH_IMX9 && PINCTRL_FULL
+	select PINCTRL_IMX
+	help
+	  This provides a simple pinctrl driver for i.MX SoC which supports
+	  SCMI. This feature depends on device tree configuration. This driver
+	  is different from the linux one, this is a simple implementation,
+	  only parses the 'fsl,pins' property and configure related
+	  registers.
+
+	  Say Y here to enable the imx pinctrl SCMI driver
+
 config PINCTRL_VYBRID
 	bool "Vybrid (vf610) pinctrl driver"
 	depends on ARCH_VF610 && PINCTRL_FULL
diff --git a/drivers/pinctrl/nxp/Makefile b/drivers/pinctrl/nxp/Makefile
index 44e37c631e5..7d861ae52c1 100644
--- a/drivers/pinctrl/nxp/Makefile
+++ b/drivers/pinctrl/nxp/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_PINCTRL_IMX93)		+= pinctrl-imx93.o
 obj-$(CONFIG_PINCTRL_MXS)		+= pinctrl-mxs.o
 obj-$(CONFIG_PINCTRL_VYBRID)		+= pinctrl-vf610.o
 obj-$(CONFIG_PINCTRL_IMXRT)		+= pinctrl-imxrt.o
+obj-$(CONFIG_PINCTRL_IMX_SCMI)		+= pinctrl-imx-scmi.o
diff --git a/drivers/pinctrl/nxp/pinctrl-imx-scmi.c b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
new file mode 100644
index 00000000000..5b7122b08a5
--- /dev/null
+++ b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <asm/io.h>
+#include <asm/mach-imx/sys_proto.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/devres.h>
+#include <dm/pinctrl.h>
+#include <scmi_agent.h>
+#include <scmi_protocols.h>
+
+#include "pinctrl-imx.h"
+
+#define DAISY_OFFSET_IMX95      0x408
+
+/* SCMI pin control types */
+#define PINCTRL_TYPE_MUX        192
+#define PINCTRL_TYPE_CONFIG     193
+#define PINCTRL_TYPE_DAISY_ID   194
+#define PINCTRL_TYPE_DAISY_CFG  195
+#define PINCTRL_NUM_CFGS_SHIFT  2
+
+struct imx_scmi_pinctrl_priv {
+	u16		daisy_offset;
+};
+
+static int imx_pinconf_scmi_set(struct udevice *dev, u32 mux_ofs, u32 mux, u32 config_val,
+				u32 input_ofs, u32 input_val)
+{
+	struct imx_scmi_pinctrl_priv *priv = dev_get_priv(dev);
+	int ret, num_cfgs = 0;
+	struct scmi_msg msg;
+
+	/* Call SCMI API to set the pin mux and configuration. */
+	struct scmi_pinctrl_config_set_out out;
+	struct scmi_pinctrl_config_set_in in = {
+		.identifier = mux_ofs / 4,
+		.function_id = 0xFFFFFFFF,
+		.attributes = 0,
+	};
+
+	if (mux_ofs) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_MUX;
+		in.configs[num_cfgs].val = mux;
+		num_cfgs++;
+	}
+
+	if (config_val) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_CONFIG;
+		in.configs[num_cfgs].val = config_val;
+		num_cfgs++;
+	}
+
+	if (input_ofs) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_DAISY_ID;
+		in.configs[num_cfgs].val = (input_ofs -  priv->daisy_offset) / 4;
+		num_cfgs++;
+		in.configs[num_cfgs].type = PINCTRL_TYPE_DAISY_CFG;
+		in.configs[num_cfgs].val = input_val;
+		num_cfgs++;
+	}
+
+	/* Update the number of configs sent in this call. */
+	in.attributes = num_cfgs << PINCTRL_NUM_CFGS_SHIFT;
+
+	msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_PINCTRL,
+			  SCMI_MSG_PINCTRL_CONFIG_SET, in, out);
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret || out.status) {
+		dev_err(dev, "Failed to set PAD = %d, daisy = %d, scmi_err = %d, ret = %d\n",
+			mux_ofs / 4, input_ofs / 4, out.status, ret);
+	}
+
+	return ret;
+}
+
+static int imx_pinctrl_set_state_scmi(struct udevice *dev, struct udevice *config)
+{
+	int mux_ofs, mux, config_val, input_reg, input_val;
+	u32 *pin_data;
+	int i, j = 0;
+	int npins;
+	int ret;
+
+	ret = imx_pinctrl_set_state_common(dev, config, FSL_PIN_SIZE,
+					   &pin_data, &npins);
+	if (ret)
+		return ret;
+
+	/*
+	 * Refer to linux documentation for details:
+	 * Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
+	 */
+	for (i = 0; i < npins; i++) {
+		mux_ofs = pin_data[j++];
+		/* Skip config_reg */
+		j++;
+		input_reg = pin_data[j++];
+
+		mux = pin_data[j++];
+		input_val = pin_data[j++];
+		config_val = pin_data[j++];
+
+		if (config_val & IMX_PAD_SION)
+			mux |= IOMUXC_CONFIG_SION;
+
+		config_val &= ~IMX_PAD_SION;
+
+		ret = imx_pinconf_scmi_set(dev, mux_ofs, mux, config_val, input_reg, input_val);
+		if (ret && ret != -EPERM) {
+			dev_err(dev, "Set pin %d, mux %d, val %d, error\n",
+				mux_ofs, mux, config_val);
+		}
+	}
+
+	devm_kfree(dev, pin_data);
+
+	return ret;
+}
+
+static const struct pinctrl_ops imx_scmi_pinctrl_ops = {
+	.set_state = imx_pinctrl_set_state_scmi,
+};
+
+static int imx_scmi_pinctrl_probe(struct udevice *dev)
+{
+	struct imx_scmi_pinctrl_priv *priv = dev_get_priv(dev);
+
+	if (IS_ENABLED(CONFIG_IMX95))
+		priv->daisy_offset = DAISY_OFFSET_IMX95;
+	else
+		return -EINVAL;
+
+	return devm_scmi_of_get_channel(dev);
+}
+
+static int imx_scmi_pinctrl_bind(struct udevice *dev)
+{
+	if (IS_ENABLED(CONFIG_IMX95))
+		return 0;
+
+	return -ENODEV;
+}
+
+U_BOOT_DRIVER(scmi_pinctrl_imx) = {
+	.name = "scmi_pinctrl_imx",
+	.id = UCLASS_PINCTRL,
+	.bind = imx_scmi_pinctrl_bind,
+	.probe = imx_scmi_pinctrl_probe,
+	.priv_auto = sizeof(struct imx_scmi_pinctrl_priv),
+	.ops = &imx_scmi_pinctrl_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 7abb2a6f36b..279ebbad440 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -24,6 +24,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_ID_SENSOR = 0x15,
 	SCMI_PROTOCOL_ID_RESET_DOMAIN = 0x16,
 	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
+	SCMI_PROTOCOL_ID_PINCTRL = 0x19,
 };
 
 enum scmi_status_code {
@@ -1005,4 +1006,39 @@ struct scmi_voltd_level_get_out {
 	s32 voltage_level;
 };
 
+/* SCMI Pinctrl Protocol */
+enum scmi_pinctrl_message_id {
+	SCMI_MSG_PINCTRL_CONFIG_SET = 0x6
+};
+
+struct scmi_pin_config {
+	u32 type;
+	u32 val;
+};
+
+/**
+ * struct scmi_pad_config_set_in - Message payload for PAD_CONFIG_SET command
+ * @identifier:		Identifier for the pin or group.
+ * @function_id:	Identifier for the function selected to be enabled
+ * 			for the selected pin or group. This field is set to
+ * 			0xFFFFFFFF if no function should be enabled by the
+ * 			pin or group.
+ * @attributes:		Bits[31:11] Reserved, must be zero.
+ * 			Bit[10] Function valid.
+ * 			Bits[9:2] Number of configurations to set.
+ * 			Bits[1:0] Selector: Whether the identifier field
+ * 				  refers to a pin or a group.
+ * @configs:	Array of configurations.
+ */
+struct scmi_pinctrl_config_set_in {
+	u32 identifier;
+	u32 function_id;
+	u32 attributes;
+	struct scmi_pin_config configs[4];
+};
+
+struct scmi_pinctrl_config_set_out {
+	s32 status;
+};
+
 #endif /* _SCMI_PROTOCOLS_H */

-- 
2.43.0

