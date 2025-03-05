Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0863C28B24
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 13:32:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0EA580FB9;
	Wed,  5 Mar 2025 14:30:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VXl6gyXa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D31F80FDD; Wed,  5 Mar 2025 14:30:28 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97287817EC
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 14:30:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VML+laZYW2aCE4e4sECHhOhne4GQ6NtfA+jbbtWQU04XpBhvxvvWHayl7LQ/g3riYK4y8UFWnLRdgJ6HfVIsgCFuUR0JjzqtzTI4XfZoTTANhl4dC3V4iBaDluMY+BrC+97rJumJQM6nzk1Kffb60m8W2Zhdt68FTPF3Az0xRTS7dh/z66lkAsyCGGC1HG+SsaQRdHex1DDz5xjcqUjAAShfm+q0UgTP6lUrQKyBDP2l04p+1YpMfd/+FXcA4oO1nkjfRFazv2b7nqcVMBT8Y/bb5fLOpfacf19QckHHbYK1ZIuZRfmrjtHh1I3c8ua24ieuhJ9DZqs7Zgdc22+wbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2J36dF3vEryUof6U358QmtTKCzPgAxP6ObywnOm2Ags=;
 b=fT94pjueo6yDVlB9wXd4239Swf6xFITOhA5nVkcYgQ8YMfwa/WeRnrFGsJ01am1Xl8liGLbOsaEmMSg1u3XdSeVnmN9PcyEe7QHX6/3rSyVZq9jaKDh9OZ1HCGPdPNHSj8kenN0fZVlZJ4PU87LKyVZ+dDFZ3hqDD/nBSK9DKZwlhXp8GHn7dRQJdLX3owXi0nJuJh7RnBdS6UiR2KBjcKFcEWwXd20Lqmh5jfsyKvYC8tA/7DyAEG1Ze7KPww/TdMYfr1bmimPjR8stQrX7gPz7rLUdAErpeAFvrZZZxWLn9LNtxVmKgCtEzqewxki/38o03Qitz4cTRdMluuxbtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2J36dF3vEryUof6U358QmtTKCzPgAxP6ObywnOm2Ags=;
 b=VXl6gyXa+66Hjb1G8Ld48cT5+5BAJdRRQpj0Q0QG09QNbjNy5mkxyeWe+EZuvocsqHhQVT6iIavjV2R16+uOQFgex/Ij/gzkVm8/r5qd8vFCcofE6D/DEITNmJc7XS2Enshd4ruMU1cLaHvwkmMgPgESI9Fph6UB5GbYguSUJHLhoRfTEdQXr9z8vdWquJPoGqeAwXdUT/XqxFfEq9FFpD8xVERI8/2AufsRDA7/EygQxeW6051DRTDF9YgHHW0yn9x16FtIbjsgumvo+rVC0bpb4Fn2sWNsVorLV9V1YKr0ZmB6DaPTEbecjPfSkEkY1LduWRiOv5lDISui/OsP1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI2PR04MB11028.eurprd04.prod.outlook.com (2603:10a6:800:27e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 13:30:22 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 13:30:22 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 05 Mar 2025 21:28:31 +0800
Subject: [PATCH v7 19/19] Makefile: add some files to CLEAN_FILES
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-imx95-v1-19-286d15acbb8a@oss.nxp.com>
References: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
In-Reply-To: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI2PR04MB11028:EE_
X-MS-Office365-Filtering-Correlation-Id: cab1cb49-7edb-4368-e6f7-08dd5be9e13d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vmt4Vk1iL0NPbU9GQUpRSWZmZDFyMzRvd2xiWldGUHRiRFNwVTd3L3JNSUtt?=
 =?utf-8?B?Wld1NWtHd25VMThsSzFnYjVzYmM2OVpRY3pjYllQU09MSkE2bUtaNUM1bCty?=
 =?utf-8?B?dmpFeExOM1BSQzJDcEE5NFdLSmZyRW94aTMxTXFENlFGcUZHcGlOUm1vNVcv?=
 =?utf-8?B?ck1oOUF3dlMva3hvV1R1WnVGVTNzZTN6VEx6bjJGVnhGUTFtSkZZQjNCVTAw?=
 =?utf-8?B?UXFBMEcrQ0k3dXQxSlRFYmpLMkRaMHF6VFFPaFdmQk5EdjB3a3NOZkVFa0ph?=
 =?utf-8?B?QmNvVm9iYWxxNjNVL20yVjhZMnFHeTJFamZJYlRQRVVpTzdZWWlQcnh1UDV4?=
 =?utf-8?B?cjlSRTdLekVaRlF2WXlRcFp6dnZMeWxjTnVuOGFDQW9tWTJJRUZVWGN5eFY1?=
 =?utf-8?B?RFFqTGdMR1RVeXRRaHZ0UEVtNGtpN0ZDdUFqTDhveXhuQ0ZrQ1RRZDlQU2Na?=
 =?utf-8?B?bmN1Q3FvV1h4MU85TVB4bU1kYzJvVm53TjYrNG9WUC9VejJJNzc2NEw2ZVZ6?=
 =?utf-8?B?Tlo2Z1VJZ0NhTktaL0NkMTlINW45a045cldBblJha3QxTCsrbWNzRjA3Mzhu?=
 =?utf-8?B?NGplVml0clNKS0R3OExjUFFBcVZocjBLS29Xd2l0ajB4VDdicXpqSStSY0ds?=
 =?utf-8?B?R2RseUdmODVXNjAxbWZ2U3RHby9XdUR4N29lRVRUNGxwcGUwWVVzb2t4bUtT?=
 =?utf-8?B?Z0RSWXVuMnRUd2V0Y0MxZW5jS2ZuWExBVFdRbUJvR3NHSGhRRWUzSnROeTRL?=
 =?utf-8?B?SzlzbXBNRzh5QWRxNHUrN2JHTUV5RzRlSVA0eG5Sdklkd3V2TjdscGU2STdZ?=
 =?utf-8?B?RkZacnUwVmQzTmlSd3lvSjVWRkVDbFU3NTZScytGbUkvZWdaa2J5MmltSVdp?=
 =?utf-8?B?Q1RsNlgvTTBKWFVMNEdGNmpLNUc4bHBXdFVDcWJPRHorNUpvR2JiOFgvQXBt?=
 =?utf-8?B?TTE5TDNBc3dBT0NUQVBHVG9ZbjdRQmpMMUlYU0Z5ci9yM3dRb1hmYTlaRnUz?=
 =?utf-8?B?RFUwQ3hET3pxZ3huaUxhZkhpd3F2dnl6Q1cveVM4aEZON1ZPUjdnVG52TG9v?=
 =?utf-8?B?WHN4bW4wNHpUZEMrMjV0SSsxREcySklLZjVwdGNHTC92YlRHZVZ4NGdKZGdm?=
 =?utf-8?B?UFlyVzJsem5sM2RSeVFRQm90RFdSeHFLbExpaGdkdWJqUGp3NVU0ZG1XMFRW?=
 =?utf-8?B?S1o0ay93dGxNbGFKVGpySkR0eFhJSWRObUtaRXBOTFpNeTBtZGxRYnc1ZjdF?=
 =?utf-8?B?emdlQ0ZTSjNvQlNQU1pnWWdlNC9tN1dyTTMycXNNOEQzUkFPd3BVL0J6Wkhp?=
 =?utf-8?B?UDNLWjYxQkZ0Q3ZkVk9JMFVOLy9lVEs1bm1HcnFQaExwaTJnYnd2aFMxblBC?=
 =?utf-8?B?T1VES0ZqVFI0Q0xVWjY4SWxoTVJDNDdLdi83SWo2aUdtcEdhcGR4NE1OSEUz?=
 =?utf-8?B?bTVLSXRhWkpmK00zMzV1QS9aUmlObXF1WUNSUm9CR1o4Q2FxeElzekhjclFQ?=
 =?utf-8?B?RHE0c0hXV2lERXpFUGdkYkFKY1JpZWt6WW1vSG5yYndWL0xneDNnRzhZRStB?=
 =?utf-8?B?Z2V3R1gzemxlSytLemhINkMzY2xicldDMTkzNTM4Sk5OYXl4am55dVUzSWto?=
 =?utf-8?B?RjVpTmszTTdaUEc1Ni96dm0xMTQwVkFLYjdmaWV6WFgrZTBXbmxXb3JlZDND?=
 =?utf-8?B?ZnplZGlaNm9MdUVjRW00TGtnS1hVNDkwYS9sRUN1RE50QmJIa2dPTFFQUk9O?=
 =?utf-8?B?MlhXSUlHM0FFZmU0UHhzMzMrMjE4dFVzcVNydXdVOFg2NVRKU0FvQUVuOENF?=
 =?utf-8?B?QjEzakJTY1JWeW1TNk5ISExZU1N2VUFCOEd0QUJseC83aURkWGJCamtJTFE0?=
 =?utf-8?B?blNCclN6b21wYXk0LzNycDlOcHlDUkFPeklLWHIzTDcwbnBMaE8wZmQ5TTM0?=
 =?utf-8?B?SUNuSVNTVkZyMlRZVXNwUEZ5ZHhSWlZLdDBRV3FUdmdNOTJGaVFRSWk2VldP?=
 =?utf-8?B?MXE3MVZKcXZnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDYvVHlieW9hK0IzV2xNKzNndlE1T3lKclh6NWdKWmxIdFBmMk4xd2xWSDFT?=
 =?utf-8?B?dkRKcHF5MFFocDlNd0NjZ2w5TStJNnRrdW1WdFRDR2FIR2ZvbnNaWk52RTI1?=
 =?utf-8?B?OC9WY0NOSUp5VXVOaFo2ZlYwU2ZIRHpSWVRNUG83bjhZMVZIMktaVHJjR3F1?=
 =?utf-8?B?dlkxcjgyZnR1NUJSS1c4Nk9zZ2s0TUwvOHpMNFhiTDNVaVRnaTNRajlXYnB4?=
 =?utf-8?B?azFvYkxYWGQ0VnVGdjFMbjYvQmszQlVEUktKcHRyRU1ZTS8zc3gxajJNVTVl?=
 =?utf-8?B?Vm1mNVhOZVV4NHJuNUppa2pBNFVTcXU1U0xCMERuWWI2NllTZTc2QmdKWXhw?=
 =?utf-8?B?U05icE50RCtwQW1SSFFJUitUSXBQVU8yN0RYNjViSzk1Mk4vMUpwOXdIMmo3?=
 =?utf-8?B?MUVBOHRKZWlNd280azNEZk1rQ2NlVHh5cHoxSUp1dFdYRHdNZmJUQ3hCNHhq?=
 =?utf-8?B?SWswOU9TazZmditnN1ZYVmlUY3NUOTRna0cvSFJ2cU9ncENtdEpMRjNEYU5y?=
 =?utf-8?B?QUdPaVFpZ2NJb29UMFlIUkpuVUVocGpSbENqM0N6NUpXLzNHV0F6VjJ4WHg4?=
 =?utf-8?B?RWFhK1FTZWNOYnVWQnZVUTZyOENuUmdYRE04NTQ2TjY1WWs4UW5mNEV0SVFv?=
 =?utf-8?B?U0EyQWRWRmU1NkZBNTh6OSt5R0U0M2FrRUJQeW56aGVPcTBXU1RnbFZvSHBB?=
 =?utf-8?B?UEtoVmpSczBzWkZmQ1RzcExVNlNnWUtpOFpZWmtxaWtuOTdyc0pGYkUyY3Zu?=
 =?utf-8?B?TVhmM29KczJpc2EzS3RFU0ZvTVBsWTJGUU9za21qelFYTHhHYjhzd0xlbith?=
 =?utf-8?B?Y1NEN0ZIV25zbnVqMEpiNm5iaVJPcVZiNlB4RFRXSG5USHFtNnZZRm5ENk5o?=
 =?utf-8?B?bzhtcGk3b0llc0d5SnZNazg2MmlvWFIvckpqalBQR2NMRjlaeGs1Z0ZmYmRx?=
 =?utf-8?B?T3NLVUhaSzc3Yzcva2tza0dRckF4SnFIZjh0OHFIclZFS3VFZk56Q08vMUVN?=
 =?utf-8?B?SFhQZTlyRVhDTXo2M1JPc1hCbjRpV3JscHAzT3g1bCtyNStLM0tqYmFlZVlF?=
 =?utf-8?B?ZW9PK05vOUQwMXh2QnVUM1J4di9pQUpiRkt2Szl4cWpUL0UyYnFSRUE4Zmp2?=
 =?utf-8?B?eGpseFpPRm9Ld3pGWWR4Wkd5QmZBWHk1QWlnM3l4RncrYmExSUtmRVd4eVRz?=
 =?utf-8?B?YUZDODlhWEdZNEhsNU5lWmRJMFZXV1ZoN0ZPNGllcjl6NzNGYy9mYnBMcm9L?=
 =?utf-8?B?VkJ6Z1Fjd0Z4WlZPSWZpZklwZmh3dXB2aEN4Q0IrUFhVN01XT1BTeENKbjl2?=
 =?utf-8?B?WWVkcmpsck1EQXZUMW9rWFVnVTdzNFhJclc0ZVRiNkhDdzNkM1ZPL3JuKzNN?=
 =?utf-8?B?SWMrSmY2aEZxaUttaEQ1WGJHcHNHd3BZa0g1MHBieXZ5MEVrZnlOZWoyeW12?=
 =?utf-8?B?NzJsbmxmUlBWaUpDam11SVJpV2gzQlZZZXNwbnpqVHF2WjhZTHNlZ3Q1U09K?=
 =?utf-8?B?bnlFMXRSNFNFeXdraFRVU0EyeHQyUVp6ckU1alZqVjJqZURaekk3NUc3Snky?=
 =?utf-8?B?RzJYRU9JZUtENTQzK2Q2MTczZWNCMXA2ejJQelZOUmtCVmpSZ2p6cE82MWxm?=
 =?utf-8?B?TnJyWUdNUW4rSUYxRmtIaThSaytkSGxIa3hXSjk3M3pXSnl2cmQ2NTJaMzA2?=
 =?utf-8?B?YWN3YlJQcHJDNUxVdTZCY2ZNRDlKZFltVDNhL0hJeFltUnVrMlJOMkp0cHpP?=
 =?utf-8?B?eCtvTE9WWGpZNTRDR0Z4RDJkTlk0THQzU0syZU1tZHZnaFFPbUNCeWFLS0ho?=
 =?utf-8?B?cEx6WVhZa05uVENwdTZNYm1NaWEzWVVVelFFM3RuT3Z2dm9EenlkckExdUxV?=
 =?utf-8?B?d2I0Tms5MHp5WHpTSE9UdHZtVS80YytyTy81QzNRR1JlUXQ4VXVYZkExa0Ns?=
 =?utf-8?B?S0hCaHUvNVpCb05UbE5wcHhpWWJBd0VSdjloZk5pUlR4MjNXbngvK09zN1pl?=
 =?utf-8?B?RzE2d0Z1SHJldFdyd2hwaEprc2dKcGpOcUJoU2ttVnYzM3BhbU0xbnJRVjVV?=
 =?utf-8?B?c0owUUQ3SUIxNm9MUm1YK1RLeTVaWXZ2bldDSERsV3kwVlQrTGZxZXd6bGVX?=
 =?utf-8?Q?W7LqqbwH5aZmP6aGjG3tI/xh9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cab1cb49-7edb-4368-e6f7-08dd5be9e13d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 13:30:22.2534 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqklZDA4wvUwAOO/ke/vhkCWbm0TVBM69q2RNw5yEOAV9e+rxZ34Grkjtp8k/MrEtxqUf1scFphv8owa1Gm2Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11028
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

When building the flash.bin of i.MX95 with binman,
mkimage.imx-boot.spl, mkimage.imx-boot.u-boot,
mkimage-out.imx-boot.spl and mkimage-out.imx-boot.u-boot are created.
Add these files to CLEAN_FILES so that they can be removed when running
"make clean".

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 5f90cea11d..20b5b3fa7f 100644
--- a/Makefile
+++ b/Makefile
@@ -2229,7 +2229,8 @@ CLEAN_FILES += include/autoconf.mk* include/bmp_logo.h include/bmp_logo_data.h \
 	       itb.fit.fit itb.fit.itb itb.map spl.map mkimage-out.rom.mkimage \
 	       mkimage.rom.mkimage mkimage-in-simple-bin* rom.map simple-bin* \
 	       idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb \
-	       Test* capsule*.*.efi-capsule capsule*.map
+	       Test* capsule*.*.efi-capsule capsule*.map mkimage.imx-boot.spl \
+	       mkimage.imx-boot.u-boot mkimage-out.imx-boot.spl mkimage-out.imx-boot.u-boot
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_DIRS  += include/config include/generated spl tpl vpl \

-- 
2.43.0

