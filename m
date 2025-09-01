Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1717CCA0FFD
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 06:33:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F44D83990;
	Mon,  1 Sep 2025 08:33:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xi/7KbrE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DA70831B4; Mon,  1 Sep 2025 08:33:29 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9772F83965
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 08:33:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6y9WfBqOuKpbLvZfac0k0NrbJxMz5G9VcRUOWEgXAo2X3v3Ky/JJnfp8/CENLSMSymQgsaOz0j4fE6OOhYo1t0cfMHokNnYG9xGpAcUPGOgLmmAh05NTtSXcgNUGQHzFg6p9tMxPqQ8j+WmOgAlmcXdUb/wDerHrnGu4WWhw5TqWAFOzQMoels7zMins7k3Ph9ZMGdETu2BilWuXa+tIiMiV2e0NCJGH5UaK4p209gb2elabHnD5Xf52SSLTaGTxzpBFpfarvqZI6XNkYLsaNLC3NG3ZqCmlOo90hnRqlqBclJhc2RU0wA9zUSjBoS25Gkc9O67YB0um/Bpylqw8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Uhtt7m7P7KEMR2BJwEjxXYT2m4zlHH5cmvRcEBbh3E=;
 b=USS+VmN4W9uw73bdyqIlCZ4WHUiY2JZnzzkLcA5yLzP91QdCq9XARtN94lvY0hR9l3Mbjl3o5oK2pgyw+LBiaHqteYQ+tVwp+gIf/gkxOPcm9KiYF+0pFAWIHuSIs1mBGODV8YkBLm3JYs6MbG92fkRGjO6ktaJmsnar5g+6Fz3PDKXBmy2OVmOSRxlhw+su27KgdRfhiUKzx33cWhRh+TmMRMedWb4y5JhFC80VkqgasucTwYr/yqBKaxl4r/ki8sRn5FzY3nrlyA5ruJt7YusykaSV/8dHiMfcCwkV5VVEvwLN59wXUXwzQwOsaQAhuczvaSpG31ulx+08GktwQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Uhtt7m7P7KEMR2BJwEjxXYT2m4zlHH5cmvRcEBbh3E=;
 b=xi/7KbrEU+x9gW7LapcoyVP5389Q913mReMjT2o+xp4BADsy2bXRiPefPPDBTkr5Lb/QN96uOzpNAEHCxQsFt+PS3w3s48IfnNb70Z5k1BmSUOtoDGZsVQYec6mvY0ULrpwymhWJ+WoSYwKTjIM9as9etwROTXscFBvdbbapJ9nXU8TS+oXlSnaidkVBpZU5TAmYlH3WtVmJi38vzE/vOSKWt7ti4sczu4AU7O3FEDR0pdLDzSOsqPeGWDurvGrsNiwMzw1vCssEpMjocoghxhPzyXYb1pxni5SxHpqwBAwFy+5ftgsYlNz+aMs7qpsrvsGyjXNRQcB7RYnRmdV2uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10231.eurprd04.prod.outlook.com (2603:10a6:800:23f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.14; Mon, 1 Sep
 2025 06:33:16 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.015; Mon, 1 Sep 2025
 06:33:16 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de, Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] mmc: core: drop space before newline in trace printf
Date: Mon,  1 Sep 2025 15:44:06 +0800
Message-Id: <175671244827.14594.10245734596191485972.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250829021131.28451-4-bhimeswararao.matsa@gmail.com>
References: <20250829021131.28451-1-bhimeswararao.matsa@gmail.com>
 <20250829021131.28451-4-bhimeswararao.matsa@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB10231:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f09f985-9c5b-41f0-6340-08dde92166a5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|19092799006|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzRLMmJSRDBKOG9OQjdEeGNCTVA3L2thbmF0U1NXTmx2UEozTS80azZkYlhu?=
 =?utf-8?B?RmtTM0FTNXFwbUh2UnhtYURLOWRvZmEwa0xlcVhlUUpyTUJnclZ1Zy8xcnRi?=
 =?utf-8?B?SHFZTlBoeUxQRkM1dHp5enQzQU1lUVp6dTZ0c3dqMlRoTi8xSGhTcTJ2M3du?=
 =?utf-8?B?RThWcTY2eDJrUm9zcVZEZWs5SlJUUk5IZVM3QUtuWUZleXJaemxMWG5RUnEy?=
 =?utf-8?B?M3BHZURxZkkvRGl3WG1mVzhtczB5M1k1OG1JUmM0a0dOWklHRnBaMHVSQWJ0?=
 =?utf-8?B?YTl4VUo5eVBtTzlPYSt0MHBEeGxFYXo3cEFBK3kvL05oeUlOeXlvV0xsTlBq?=
 =?utf-8?B?a3p4OTI5NG95NG45OEdxSldIUmI2ZVVoMGlnQnFaNGpOazNMNGhkMlRsdmho?=
 =?utf-8?B?UHJNUkpkcXQ0emVOeUcxM0pLQldwbnlrOEMwcXExTVJmdEg2eXRmbzFCU1dC?=
 =?utf-8?B?TUlHTWVveTNkYkN3Wi9yMmliSmt6VEU1VTdpdkNXcTdhK1NDNWV3eGw2VWZE?=
 =?utf-8?B?dnRtdUNkNm4wdDAzTUd5anB2Y3FYWTJvaFM3VFVKUS9FYU1yUW5IL1VHTUFz?=
 =?utf-8?B?c0xxM0VQMm5QYURIMnVaVFJFdHRsS3JxVy8ycllDa2t1TXJTcEYwbG5PUTA4?=
 =?utf-8?B?ODVmeHo5KzlUOVlZS1dKWU8wMDNLOXdFMWhXeGpWYk1WdUhnSTg0WEd4eTZK?=
 =?utf-8?B?T0lsc2Y0WTdMMzFGREtyQW5oWmNSNXgvZmVUSTRHUTI3QzVyUG5HYWJ1cmx3?=
 =?utf-8?B?V0oyTlE4SWxwL0hQc1NJbzM0ejlqYTdTcWsweUZad2Z6N2dVZE5KSVpoLzM0?=
 =?utf-8?B?SFFSNWhISWFhenJxZ0d2UnVvbVJkQlIreU1uK2ZmRmc5NTg3d2tqeVZYNVdN?=
 =?utf-8?B?VGFWL2k1NDdaUGhiRGJHYWhWUnhpck80cGhmOGpoNm9HcE9UOTBSanlsYVlC?=
 =?utf-8?B?Q1NsWjhTdldtQS9PcXJXR0xKemJISElHemQ3aXgwWTYzTkhiK0lGUWY5SW9z?=
 =?utf-8?B?TmlmWXcrTzhHcWRPUU04NFpWNmZ4bElKNlFNMWpZR3lHd1UvVjBuc20vb1cw?=
 =?utf-8?B?cTJad1FQWEYvdGx5aGlEcDRmS2VNUmdna0c1RTQvdmovenhGcVVjUDlxcGlV?=
 =?utf-8?B?MkQvTVFyYzNJOHA2TXFuakNHL1JLOElUUytsTzllcHdVUnU0NUhoTWFHb2pJ?=
 =?utf-8?B?R2VlUlhvOUlJaFp1VTUwTVBUcDBMUEdHMWo3STVUcHNaWHRWbFJMeUduL1p0?=
 =?utf-8?B?RjJMZkJ0eDhqZFBOYmI4QXdGc3NxSHpQYkx4dkVwRGR3UTk0WGhpU3o5Q3ds?=
 =?utf-8?B?Q25KSVNNL01sdkVsRUYwdVp3b2ZwdlBtTWV2TjByOU9JNlBObm54eWh4aDk3?=
 =?utf-8?B?bFBVTDFoaEJ6UVpSSE1BZHdsc2cxOHg0Q0tLc04xbEE5dGlJVEZKbzJSOERI?=
 =?utf-8?B?U1ZhNGxmb0FiSzZzVUtsUDhlSG5nbXNHdjhEdnhLQlhaRjllSTlINTJEUG11?=
 =?utf-8?B?RjdFbFVwNWsxbGtwWU9qdWFlQWNudjlxdU1QYjZBTWZZd2FWSjBjODM3WW8v?=
 =?utf-8?B?bW90WXN5di93bkM5eWx5ekVJeFdNRWgvejJEcnlwdHd5bHlLM1lSNkd0akMr?=
 =?utf-8?B?Z0FjTjhPMnZ1M1JJSjhINkp1M3l3SGFvYVo5eU5aeUpXT1poRnMwYWpneHQz?=
 =?utf-8?B?c0p6aTQzRU9UYllwUzRJaStsaStrS2xvLzBsKzNCdDY1VFhEYnBWQmtlVUhi?=
 =?utf-8?B?V0J4TFJmdDA1a2NMMVZGSVA4ejdVaDkzWk9PL2k2bFBTeHFmMXQwN2ZBOWgz?=
 =?utf-8?B?QVMvZG42NkF6OVNQT2V3cUNXMU9GazUrNHhyM3NRdkt3a1ppTnR0dU1rYStj?=
 =?utf-8?B?cEYreGdBaDVJQ1h5Tk5ZWkw5VzNrTVZYdVlZQTlZR1YzSlg1emo4bnVqZVNX?=
 =?utf-8?B?V09Ec0ZKSXFvTXc5bmRmTGJrUzVBTWRIRloxZ1FNZklJdC85NFViZzBxaG9p?=
 =?utf-8?B?NTlGenFzVXJRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VitzVVJaMndpVHljTlQxWXBxTko2aE96M1JvMUFzMmRHaU5UM1psUmU0M2lm?=
 =?utf-8?B?T3dYMGhvOGxzcWNrc1kzcnYyQWtPOE5MOEtNZzg4Q29BeW9PWWUweW9sL0hh?=
 =?utf-8?B?YUJEQk5Zc0pCNjNkRFZRcno4aFNaa0R3QXpscE1PSDJuc1dzeDcyUktaK1ZO?=
 =?utf-8?B?VkRGbVJaajcwNFZCQUpiOExWbDJSRVFqdUtZejAzRnZOdG9NMllSWitLSmZV?=
 =?utf-8?B?SDd4Uzk1ZER2WEYralNZTkhGcnA3VEcySldjb2VkOWVCZDQxUURTU3lDQkxv?=
 =?utf-8?B?UEFBRkhsbmVEb3hBajZGaDMzODIycWcyMTBISncvWksyV210QndKN2grbG52?=
 =?utf-8?B?TlpvTnAyWnFCQTEyZDZVcFEwa1ZwdmFzYUwrZG1Kdm5FSVZWQ0VMUldnRU8r?=
 =?utf-8?B?YWpjMEtzaXFGZ3diR0doUDNXWnBmaUw4cjM5VE5pVWx4ZnQyL3B4UGx0cUdD?=
 =?utf-8?B?VGJ6bm9iL00yQWpJSERMRjRvSUNldURIZEQwdFAvQXBhM1VsTzBIM3dmdEwy?=
 =?utf-8?B?eXR5NnJXN3h3Z3pnZFJEeURaWjluVGplVEoyNUg1TG0wRHE3Q05URU9CVFN5?=
 =?utf-8?B?SmJ0V2x2NXFHQ0xQVXE2b2lvNFMyZFRQR3lUUGdYR1Q4VkNOc3d4aFhNZXox?=
 =?utf-8?B?c09LRnhZRld3YjFZWjFuZms4YU04c0k4VWN1OGVGY0pXeHF2eGl1Sk15Vko2?=
 =?utf-8?B?THlqMXR0TEdqSTd4OTdjazJoRlYxY2dYRW1rSC9lblF0dG1BVmVPbHVjdnBu?=
 =?utf-8?B?WUIrVkt0S0JybFRJR1lzMGptS1ArcVQ5VTJycXpwYXczQWw3ZEc0Um1MRkk3?=
 =?utf-8?B?WHNJQTBHalRocUh0SjJIZG40L3pGOW9LN1E3bEJ0ZFNrWlZ4eTVzR3pXTy9J?=
 =?utf-8?B?cjhMc0FyM2xRSHVLbm5HSFVGODdRREJUQ0NFMEpaWUQydWpCSFdzK0djNjMy?=
 =?utf-8?B?cDI4NldaeXd1aFplL3ArUCtieVNFUWxwTks1OWtlbUxZMS91cjBTNjdLZisw?=
 =?utf-8?B?dzZPclJnVEU1NVI1WGk4bVoySFBjOFpvbnJlMVB0eWllTDFRMEJEd3pDQjRJ?=
 =?utf-8?B?ek9QQ0hRbWNJNnh3R0pSN0JRS2EzSTgwQm9XckVQOXFVSTFTVWRWWWVZVEgw?=
 =?utf-8?B?cXd3bVQ5blhlcklldWVvUGczRUFyWDYyWk5heXhKbi9GNzhxL2FXUWJOa0h1?=
 =?utf-8?B?TTlhN2RpVE5CMXZkV1I5YncrTkFRTGt2TVYydk1QZ1NSVDkvMkdwbTgrTU94?=
 =?utf-8?B?djk3U1BMUjduMjN4WGFJc1hkUUdCR1h0RHNUZXgzTCtJQnJaRkthQkt3UkNL?=
 =?utf-8?B?Q3hGa3dVNDExSTdiaU1ZQjdSWit1bk9McEszZ2o5NnVwaHNsQkVpdmlHT3Yv?=
 =?utf-8?B?RFNZRFdGc0VjaTJ5bjZuZktoYkcrSVYyaWVlS3Ryd0dadU9QQTRYcGZQcDBK?=
 =?utf-8?B?S0dQSnRmV005OUxva0hQN3J3Ym40SHJoWWczM0ROb3BROVo3M1BxNzRKamV1?=
 =?utf-8?B?ajZ0TGdPMGVVRE11VHROeDJRRzV1eUxmTzVDYkRORU83ZURtNGcyQm92TUZR?=
 =?utf-8?B?Ujg0RmpIV0hrdWJoQjgwSklKZng1UHQwenFES0lydG5MNU8ydTQvSEFBNlZs?=
 =?utf-8?B?S1pJSzQ2TGxWNFV1V3lkSGI5Z1RNZ1d4RmNFWnluVVJJcWJiVkpkTHh3Q1pQ?=
 =?utf-8?B?YUNLSUNHbG11LzEzcmZ5RnBUSnF4bkd2c1pwaUtPQ3BQaFhZUFFWMjR4NlFN?=
 =?utf-8?B?aUlXVy9zQUp2YkFhalhjQzRIMWxaa2s0REVMV0hXNkJNQkFvQmZkMEtoR2FH?=
 =?utf-8?B?c2RZTVVROEFvQm9JaUkzWFlmL21zb1RWZE9LeXFBQ2RCL0VQMnlJYm1HcFJz?=
 =?utf-8?B?SHJDWk9FVTM1b1lPU3lDdmZEd0czWG9qWE5uRW4rVmh0WDNFeldOaTEzdHRU?=
 =?utf-8?B?STVRaVpRbkNCVkZNWVlhMGpJdXY5ZVMyL2pjRWRvQjNkOHE4endlRGt1ZmFW?=
 =?utf-8?B?dzNRZlBTYS9UV09XbENZK056WDdCMDIraWx3VTM5R2lON2cyQTJVaTNTRjZt?=
 =?utf-8?B?bWlvSkViRXNDODNlZlJWcnRHZklmK0ZCWjNVUDJXaEU5OGJXQlZZQUc5endI?=
 =?utf-8?Q?UYD932Bnw3X1e2J4HOwPvPso/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f09f985-9c5b-41f0-6340-08dde92166a5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 06:33:03.7336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dP3fICD4D7GUOVsbG7AJo46gpBIdne8IOMuZLnTFRzCMeZAwaogb/41a72av8OBClVYLxfwp6bWDR+BLJTjaWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10231
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


On Fri, 29 Aug 2025 07:41:31 +0530, Bhimeswararao Matsa wrote:
> Remove unnecessary whitespace before '\n' in trace printf
> format strings (checkpatch warning QUOTED_WHITESPACE_BEFORE_NEWLINE).
> 
> No functional change intended.
> 
> 

Applied, thanks!

[1/1] mmc: core: drop space before newline in trace printf
      commit: 140562d3a2b447079499d773a7d21ec1728692cb

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
