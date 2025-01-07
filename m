Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10D4E77198
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 07:01:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86D1D8060A;
	Tue,  7 Jan 2025 07:59:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uaQtKr9v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAAED806F9; Tue,  7 Jan 2025 07:59:40 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::60b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6987E806F4
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 07:59:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7eD+vxy2V1g9G06qY53oTgo3IWjYzYs/gayWPQjdTBuajtvn8+5sF2vv3SNMFp2gSjPaSYaZQ5IhT0BIMGb7k0xC9VM5HfeArHJW7WkK33qwM7LloRfzzbhdAnhlOR7jh7MTsEXECRfNvT2ijkudVx1R46kn39V1wexywfhRQbXbWd1DJMZlGbTxstesQPK9xpwcMa78qinyfkDp1tutkldVwfpBVxchCeFUVUROSRt+WniQDXCUJDtUVvDvwU/DQpzByXcrHKsT2us0swaSUNzO1sn/Si+Id52R0Wx6xfsDxEOz62DUrcqmff7goFci6C3en5gx2j6CwzW6XvKdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzzueAfaaSkuTwVeSVpjMEV6Dd63tC1lLr247Doj82E=;
 b=UKfVQ/iB4AITB2WPenmlSw608iA4S6kb9Of5o7cxEnDjlSUeoqFQ+1wHLhIb3MYOgdnIU9sgBHQMyFg3kXB3bs135RmNNw/03+XeWa/QRcBwcB/dX0cQuLsnoyfk/lsPWAvy2U5HZoLVSYtI/UK8xLYVjf3/oGctZrw7roiBggSrBQwnr57Y4XkPxZ1aXaJsqM/wKMbUmVA0zDcDmYsMdQkjBP/0wWPyYMFQuErq2uIcN9ixFwd0+Z2XsDIOB/ulb+ljSOS/IPgIUo8LLYo1R+qpOEotaqrPm71ZPZIUZoabPpoOQWPqkMmk4t2uWKqJTLYB84QIThHFgjy3Q47fDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzzueAfaaSkuTwVeSVpjMEV6Dd63tC1lLr247Doj82E=;
 b=uaQtKr9vWxOurCTPiSK7SpTauYAEIEdXgU9oyWusgGvD5j6vNLeuTv+w7KBmAbuF2WI4ch4fIkYg6Bh4T2wrTXMAcNFhw3dyjEE9uRJPNMqYcFjvxI1HCNrbbrbl8b9JkPlaGYBHEik3W2a47TQjezeS+tYfPkZPjtDeXG7kPWaLqtAn2P3UyQBPjyiAzcsN9Vai7VEZP03MeJGTssOD9xm4618SihXHqdW0qeFKHj5ffo9Q0ubJfwnP4ST9sRF0J06XnfcYwaKEhXUiH/xWZL7R0DIfpQb9eiujsZQjZTIf/mr4FfU9OWjwY6xygUaiB682BubYYeg0mXg1Kvczqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10523.eurprd04.prod.outlook.com (2603:10a6:150:1d4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 06:59:32 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 06:59:32 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 07 Jan 2025 16:05:13 +0800
Subject: [PATCH v2 13/16] imx: imx8mq_evk: Drop DECLARE_GLOBAL_DATA_PTR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-imx-bootstd-v2-13-97671b1694cd@nxp.com>
References: <20250107-imx-bootstd-v2-0-97671b1694cd@nxp.com>
In-Reply-To: <20250107-imx-bootstd-v2-0-97671b1694cd@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB10523:EE_
X-MS-Office365-Filtering-Correlation-Id: c30db6ae-6861-4c27-73a8-08dd2ee8d6bb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjBxVTJaeWdFaVM3UlpuWWIzcFFhL243LzVXd2dabmtXS3pjV3J5a1lYZVFS?=
 =?utf-8?B?OThiT1pSMTJXbHRoUUFnTmxSN0pHTGpGa2hLYXJoTVFHYVJsaXA4cDU3V0FU?=
 =?utf-8?B?VHM0Vk5EMHhqNUhTK3gySEV6ZG5sN2IzU2lxbXFEWDlxY2c5LzlZTlBEbTNM?=
 =?utf-8?B?dmRmT3E4UTdUU1p1WnlPYVdZa2tJd2lSS1hZRWZhZkR3U1BjY2Q5Y1k2eXFj?=
 =?utf-8?B?M2pDUFM1U3ZzeVdLSk96ZVUvcTJ5aG9uOWR6SHhkL3lkOWpPU1B3b3dFN05K?=
 =?utf-8?B?Z2h3ZG83aHlrV3ZUNUlYWGQrVTdZMGh6OVJVUnB1Rmk5THd4NVpvVzB4d1hu?=
 =?utf-8?B?d25pdEdtOVVBOEpPVTZyOFhYdy80cnZzSHJLaklhcVF6WENQeFBkREprNDZu?=
 =?utf-8?B?R3YwbVB5eS8wbUpwTEZBSXFwRFJmTTYzMWcxdUtXZVJtRDlmSERLQUFvcWVy?=
 =?utf-8?B?eDNaaURxc2o4QUpqeng0NEdmM2NHT2tUSmY0cnRTWkZ2STNLSVpYV0JrMkM1?=
 =?utf-8?B?Y0Y1cGJ5dXZzc1N6TGVNWlR0dHFVN0RzRStaMUF0S3JMWEdnSVdTR1Uxdngv?=
 =?utf-8?B?WlphdG5Rc1FnaTA2SFFxK0JhNFBCTUNad0w5d0w0amRhbGxGTUVsaWlySjVZ?=
 =?utf-8?B?NW9WTHJLMmxaMzBPdXA4ZHdDNHhZY2dVdEtJUUE5QTBvVlVsYUlMVVJjYzlh?=
 =?utf-8?B?MThnSjlwOFc3ek1PcHVMc2dlK3hmblJXYWQ2SWVqMlZUSjBQZ01hc0k0TnVH?=
 =?utf-8?B?dkppdTZZeEpJeGpnY2hoOTVVcTVnVmRLYWVvY1hVeWo1VUIrTndHVnl5RHR1?=
 =?utf-8?B?TlFheW9oeStXbys1TkhBbW1WUHAwbkMvandnNWx1L3BoTU45U1hBSnEvZFFK?=
 =?utf-8?B?ejR3eXh0T0o2T2xqTkVvWlFPTGlNSC9DSnBjRkhLY2JsNVUwcDNHR09PMjBs?=
 =?utf-8?B?M3dmNFBiV2d2Yk5ybFJXUWdiM3U1QjMwUlB6Z2xXREdMSS9YOHpRNVV1N3NW?=
 =?utf-8?B?NHZoMzhYblYyUWhENklrNVRKYVJmbDZhY0ExeHFnckg2STFweVIrVjdGNVox?=
 =?utf-8?B?REhodGRmUzQ1VmVTMmF4S1JDc1dpSkg2b1lxQTU4ZEJJWGVqT2hnMUFtb1kx?=
 =?utf-8?B?b0Y3OGc3R0FTRjZXV3JicHlQTk5ZdDFybGZGRHJWWWRXeXlEdjIyWnlibUxB?=
 =?utf-8?B?N0hlWFZtY3A0c1BIMkE2MGNWN1hZR3lQb3V0SkZiYnJ3cXlGblpQd2w5U2JI?=
 =?utf-8?B?OEZCTUo2c0JraDVpK1B2TnoxWlJCRzV3M2txeFNUU3UwKzdOUXFoVjZ2U2xp?=
 =?utf-8?B?NTBJZzlKUVZENysxOE41cHBTclYvMm9QeVE4TkFZRW1EUUFhLzFHelpNZXlD?=
 =?utf-8?B?TEFHWWtZRjJybDNjMDFzdmw0c3JDeGI0K3pvcktuVWFtbzNJdGdUVm1KUkJD?=
 =?utf-8?B?c2lILzVvT1d2Z0ZSZHpEcFg1ZjFMYlNQTm8xNHlXQ0ZoZnBldmwzVUtSSmln?=
 =?utf-8?B?a1lFbWkzdnNvT2JzL0hHd3FDdENTTmZZdWM4SFZobWZOWkFXamF1MmY0K21C?=
 =?utf-8?B?S1kxL1F6NHBTaGZ5bnNyWHowbXVSMVNGTmZsT1BEL1FjOW5kVUtaSHZadUQ1?=
 =?utf-8?B?cjE4clo4MmlXbm85ZjFnd1U1Z0JqWDEvVTlBZkRuYWwxc1AzS0R5NnlWZWhn?=
 =?utf-8?B?bHVlcG9XS2cxRVI1RS90a1ZCYTA3OXl6dFV5cmwzK3ZCUWs0cnRyNGVzZTMz?=
 =?utf-8?B?N2FFWFNjMG4ycDVpOE5EN0dFR0czblNLR3RwWXVVbWdueU04UFhhZ2JSRjN3?=
 =?utf-8?B?VVg0c2JKZExmSkRFaFlXZ3Y3QkhFUXVaTGltWXU5UDN3ZHdXRWZVVlRieVc2?=
 =?utf-8?B?NEc0TjA5dG5YN2hNTTErS211TlhDc1Rtbm9vRWhrRVNDKzdKWk9VL1liUWxs?=
 =?utf-8?Q?ZC3Z6xFUgafbh6xJrmJxJhLMj2Q8jgpd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTdyZm9YWkhBeGxpUzVZTDh4MFI0T3R2M010amIreCtFRHdFRzJrbUpNeHEr?=
 =?utf-8?B?TG1mMjlwMGpRaitEOExjcURkdTZ0akxnenRnRG05NENvQ0gxRmY0SXRBREVS?=
 =?utf-8?B?a1dXeVQ1YkdoM3JGSTdkR2FGSUgvL3dNblluNEJZTHpTRXBEdmdkU3RCYUYr?=
 =?utf-8?B?MitURGJqOVlLOU9rWW5tYVE3eWZxajVNc2FGYlBlNFVsUVRhbnV2YkpEUGUv?=
 =?utf-8?B?SUphb0ZlWDVzU002SEVkWGNoTFIyY01hT2pWRjZJU0NJSjBnbHh0ZU9VR0s3?=
 =?utf-8?B?REFNUUt1SHpFN0lHNWxyWkZtcm5QUVJlblJqSkZEUE5LVTV6TlhDaE1mTXIr?=
 =?utf-8?B?YmF2MnlyeUNKVm1WbEk2VXU1TUlvNU42UGZrWTlQdHgwVFc1QTFmMlNuUjhz?=
 =?utf-8?B?MzhlM1VFcmd4dGxhNFRkSW4rRk9mcVZGNk5zMzJ2dzdlVVNzSzJrMnAvcTBv?=
 =?utf-8?B?Y0lqaTVCMU4wWUtjU1BpYjZJRndUbFJ6dDVtWXRQTFJvT2NCZjRnZzRuSElZ?=
 =?utf-8?B?aGxoRldvdkpjN1YxUWgwZnhhek1KbEsrL3lOSW1jRG1YaGtybVVDdkJPaVBn?=
 =?utf-8?B?aVZGcXp6OHJVUHhzeDJyWHM5Y1RrTkROVHl2MSsxRFlpY0JmZFE3ZVpZMS9w?=
 =?utf-8?B?Qk5IN3dmTE8yZ3ZBSkJOQUpLVCtBdVViVEVKNVIzNVJHTVcyejczandTUE9B?=
 =?utf-8?B?NmhWM05ENTlOeWdBWEZsSlBSakxzQmlyanZSTzdxeGhybjJRUkZ6eVpsVFJ6?=
 =?utf-8?B?YTBwQmFMcGtaV00yVmE2R2J3VE9kVzBRN0w2Z0dpU24xS0ZHc0dsL1VYVy9F?=
 =?utf-8?B?eEJsMmhnWFE1RG85WVlldFkzUWJzdW5UTVoxVzArSm1UdWg1UEtFcGZ2RGN4?=
 =?utf-8?B?YVVWcDhueklPK3lTQmNEcUdzVVlHMlBOWE1mUFAyNC84ZVl0eTE2L0ZpWXpL?=
 =?utf-8?B?aHAyc1VBSHFQK2FpQXBOWUJQNXoyTVZwZ2NlZUhML296WlUyOEVTOGVQZGJz?=
 =?utf-8?B?bGV6Rm0yZzdlWW9OVUNTajR3cENCcTlOckE4NCtSSnl0a1ZQK24zbEJwakly?=
 =?utf-8?B?TitCTnBzZnppWW9OWC9Ua1dOaElRTzVHQkpJU09jVGEzRlV5cGR2MXI1T3BM?=
 =?utf-8?B?a21HcU5jZUF0dzMxbCtGb2tETW0vMUlhSndPRWltV1lBbUo5NDJzaDd0ZVFC?=
 =?utf-8?B?M0JuK3dKN1YwaUR3cWJ2cmJnU1Vodkw3T055QVNBekk0T3F3TW5TRlJTZVNa?=
 =?utf-8?B?eEUyY3lnbjFjeGxla3pTSUszcHdsZ2dhWWlQWFhlVGJZTU9ITUNNMUc1L2xJ?=
 =?utf-8?B?RWJKaE5ZOG01cGdWb1lQTXhDdVlpZ2dZbSs0WFJjbkJUY2taN2pTekdVRk1z?=
 =?utf-8?B?aDFpUjhuN0ZuZEZOKzVNclhzWmJHZWZjNXk0ZHdOOFlXd1ZXZ3FzZVQrUjFX?=
 =?utf-8?B?WEplempvd041T2haaTFnbGhCMVNBQW1SS29NdGlpQWlHQWFHMjhGcVdEdUp0?=
 =?utf-8?B?d0JRTVczYldOVkNMcE4zSVVBU2pvRG5jOURDcUJ2eXRsWDU3WVFXZE0xdkZW?=
 =?utf-8?B?aHcrUDcwYzlDcU13L21hbThuSlQxQ2VwWDl4bEhpbEplcFM0cTc2RUJVaVAz?=
 =?utf-8?B?LzNnYXVXUk1kbHRzWktUZlp4UWhacWR0VXNqMjVZSS81VGNGcWM4eGN5d0c0?=
 =?utf-8?B?bGg0WVB4T3J5M3FtemVXVXhEQWtrclBvTGdURUlrYzhvWmY0dTI4VHFoeHhU?=
 =?utf-8?B?TzVpM2c1eVBuWEtnWERkU0YyZWlINU5LS2tpV2ZVNmtYN2pUNmdTa0VQOG96?=
 =?utf-8?B?ZE1ML3NHaTF0aVczNjNVMDVnaGpVMG1UVzIwa1E3SnlESnU3QTlFWTI5QnhB?=
 =?utf-8?B?SzM1MEtOY3pDUVRKK2hNeXFPRjV5ekVxMm9NbHZMTFJjamFCODd1SzY4bzhQ?=
 =?utf-8?B?eEdaaldnbDVvRk9BK1l6MlhHYVVYRi9CemhJSWRiTkxBZ0d1b3YyOFRWa1hE?=
 =?utf-8?B?WVlkMTlITDdhczA5VE1mWEhjaXhldk1xbVFLKzE1WTVyU1M1N01mbWRxSGUr?=
 =?utf-8?B?OHU5VFVoT3R3Zjh5ZytLcmRlUCtDR3pHd1lLeXI1NGtiZjFlWFRBbzJWSUFr?=
 =?utf-8?Q?mhqgrQUJg2XLL9p3ubSDV7ox/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c30db6ae-6861-4c27-73a8-08dd2ee8d6bb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 06:59:32.7568 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6YpuCfPG+JXf/eCqtHp17SGIob2f2OvhVZ1hYeGN+mfCQKr7jE0o9jy0IhiXAZCQB8e3tI7PmIL3iwoyhlCf1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10523
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

There is no gd used in the board file, so drop DECLARE_GLOBAL_DATA_PTR.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8mq_evk/imx8mq_evk.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/board/freescale/imx8mq_evk/imx8mq_evk.c b/board/freescale/imx8mq_evk/imx8mq_evk.c
index 64a2f258f7a6f9bbc58466a47efa0098ec2a2333..f833996d5248eba637b443d7bc66141c3aff8f9b 100644
--- a/board/freescale/imx8mq_evk/imx8mq_evk.c
+++ b/board/freescale/imx8mq_evk/imx8mq_evk.c
@@ -6,12 +6,9 @@
 #include <asm/arch/clock.h>
 #include <asm/arch/imx8mq_pins.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/global_data.h>
 #include <asm/mach-imx/iomux-v3.h>
 #include <env.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 #define UART_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_FSEL1)
 
 #define WDOG_PAD_CTRL	(PAD_CTL_DSE6 | PAD_CTL_HYS | PAD_CTL_PUE)

-- 
2.35.3

