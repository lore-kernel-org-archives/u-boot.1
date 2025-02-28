Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8D3C282C5
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 10:56:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9806811A7;
	Fri, 28 Feb 2025 11:55:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="OuA0WQg8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A075F811A7; Fri, 28 Feb 2025 11:55:28 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::62b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA5FA8128D
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 11:55:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S3BUbLqdSTgu3ihhFKZ0rHkDjpZJDt0003PqBlOcXuRAKuRejfZsVaj9nraKINvAq0PIA0g5B0lzcbYNRwB3J/Y1KMzfNOklCm7bbYJ7LrhVUDzouHZTiWxOoziDuiDD0hOyd9b0MOa0Y715MtNQFiPIJQCPaZyhQhjzljYgrc1YqqmozW5BChaV3AdehCU2ys3YpFeai9f14QCCSMDz5sdmTO91/Picj6cyQ3j1GUhJosxyMB3sr4Z937EjKHrXJqVq6sUplhUR+MCjcL15sy2Clmuf1o8kbobaVKSLMs6YXHWkY2zLvahxTouxgD7o5XqmL+LHZlzcJVpkcJVybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnXDWRLGcOmOopdsFkKHPfX9D/0atVWca6wd6Yzcels=;
 b=FBH8fe6B9ZZm/iBzlYViWmMi98RpYejEdbnjlSbc1zE6e+7tb3C+0kZ/Jf15O3JZLRyrrp/TA82II1+HLREtCgaYNUTkdWigUN8cVSW0UdahYyw6pWnTNNvA3kHBA3KWrfRP5JeYi42aCLCD1zVweFL/VhTT2qgK9mK06iu5fjBUFUqpTQjyKA3JQ6W9PCna+6/38R1hE7n2AYrhTmdJ+YFUhHubw2j8EA9GiktZxsrV03B84cbJw+5wtyCNRLV4j250VD/EQxmMJKBNWLkLiNEgfGsSgP9+MYAsGhPvJhHPvobWtshuRNt4qMpBsKXt6lAYRjE/TbzZwl6Zp8QjDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnXDWRLGcOmOopdsFkKHPfX9D/0atVWca6wd6Yzcels=;
 b=OuA0WQg87sDXvE3xxvbS6iun+3t7K99cRt1B7cJAQ11k1oetFJ+BUQBEdJ/BIoL1T6+AnXR22XdhMgqpvkzRFT5j81dTXseB0uLxuuNf79cBOQRRdC4t2SPybmaitm8rVfQmEbVVxxQZK4/gP0SltLDM1S+JPHtXJPPcIKQq/1eGU5DYq+vPpRpCHC497gmUV3QeWFGFggSPLT0gcBpqR7hgNzKZas5dHSMcis1/Sqj/ejubTzBeaObxDoe5FVyV/8N4QnIfolRxGC599lKlx+PpaP2ElDyhmf1PRHlr/uoiWSWPJSyTX8JivMTDuOE23boPErIgd+//GljNMDkeQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7845.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Fri, 28 Feb
 2025 10:55:24 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.024; Fri, 28 Feb 2025
 10:55:24 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 28 Feb 2025 18:54:03 +0800
Subject: [PATCH v6 12/20] spl: imx: use trampoline buffer to load images to
 secure region
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-imx95-v1-12-09594e93cc9b@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ae2377-166b-4a58-8edf-08dd57e66725
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXZuOVZYcHlIa2prQWViTXBlTFppOS9odVliczFLV3BIeVpSQzJNQWE3UU9a?=
 =?utf-8?B?YTV3cHJtMXYrL0tEZHFVdTg1VkVOdTg3RHNrMjUvTlludVN5Qm94K3FRbTZt?=
 =?utf-8?B?a2k1eUhoajhwUVJXMWp3YysyRjVmeFF2ZXpsb1UyclNFTmp5WUZBK3A1YXZO?=
 =?utf-8?B?WHk5cVJ6WVRzS1c1SzU2ckJkM2s4VHRDQWtNc0hXbjVyV2ltaFNLd0ZFeHcx?=
 =?utf-8?B?TFhqUVB3NXphYjdMMFI4YTlXMDI1OGN6K21FQTVEeXc4dkp5Y1NZNWl0dUkz?=
 =?utf-8?B?WEhGRWVKMGpwQW9KdTBoVzViODQzU3ozWDZzTS9NczZzTjdRTDZid3NNdkFU?=
 =?utf-8?B?dVlzSXdtZ0VoTmpRMDQxWWJXQjA0MTJWQnJ5c3pCR3diYUNrc1RpbWdVUVBK?=
 =?utf-8?B?akdsQnE3WGx2VVpzdm1sQlZuKyt0cVhvcFVnOXl4K2VRbFA5bCsyNHZjWC9H?=
 =?utf-8?B?OVRFeGlqeWlZQmRtNmtjd2Q5anJMcXlJYlpVMkRGSDN2OUt3TTFpYmFPQ0tu?=
 =?utf-8?B?cHZLbGRTMzF1L1JtYlNvU0ZzbGx3YlhQRkZMclJpY1ovZGNabVNsNFE1bGVM?=
 =?utf-8?B?TVdIbzZ3Vy9xM0FOOE1Zcmd5aisxczNyRE1oRmZ4VURrTjVlZ3ZGczNsYU5m?=
 =?utf-8?B?TGtVOGd1R05vbjh1c1pvVFhOMm5GR01XUXZ6WGZjaTgyTG1ydXdMakVYSUZq?=
 =?utf-8?B?YlJBb1NtS2xzQ2pmUkZpMmhGOTNqa05VSnV5OXFvNjA3dGF5RzFyYUZNcjdU?=
 =?utf-8?B?MEJlYXgzNWFFTC9CQTYzQkRFMEhqQnJNRGU2SkpzUFI5MTByOVBOMitDbk5S?=
 =?utf-8?B?dHFUR3AzMHZyQVRFMXIwYUttTmJwTkR6dGtLdU0zd0hXQlNZSzJUYnhnUzlp?=
 =?utf-8?B?WUJlZFZoTjhSeXUvSGVQZEVOaUh4eDk0ZkliNlhCWmR5WVBOTEttbGZxaExi?=
 =?utf-8?B?d0ZGbFF3bm5XWTJNU2xZM0VSMVNBdTlsdzZpczlydUZBdUJ4b0QwaE1BdjhR?=
 =?utf-8?B?TUNJREYreFljRUNndVJjb1liMUptdHplL0YrSFlpRjNVNWJJZTBZd21ZdU5X?=
 =?utf-8?B?RTY5dGJKSXV0dlR1a1ZWb2lOQnkxdlhUaCt5UjJJa2lzYXpIMVZraDBCZlE1?=
 =?utf-8?B?YzRyY0xpUDhBN0FyTkxuWFVEcGI2d2JwOGhjSmxSU3hZc093cyt2UHU3blJB?=
 =?utf-8?B?N21OQWttZ05hRFREcXZiNXg0T1hwTDFMTUp3a3p1UjdJR3JIRE5ndEx1SEFt?=
 =?utf-8?B?YVR2bk4vMjNSWHBOd1A0dnVBMm5CV2JIbld6NHE5bXM1VTduWUljMHVnVDcr?=
 =?utf-8?B?M2dtcDkxYzhkRzNCWnFISkdTOExLbXZhMDB1RUZTNXNMem9ydlBNNStZV2ZN?=
 =?utf-8?B?czQ2cmhUMldKK1lnWWZBTjhxVlplZGZNRXl4ckJrSGNYZzkwMHlQUVk5SEwz?=
 =?utf-8?B?eTRGaWYraG5MSStxb29tQ3ZNTFBPUWs2Z3NXVTNkUlM2QjVtQmFld1ZBVjJM?=
 =?utf-8?B?MTdBUklaWklJN0FiV0NwZFMyNFNFdzBZT0ZwSlJtRCtTQ3h5VFlua01rWG9V?=
 =?utf-8?B?clNzM1RTbkJYU1RNY2VYWTY0Um5mN3F0blhZOENSTXFIN21NbGljejZVMEhS?=
 =?utf-8?B?cHI0N3Z5Sml3YTFVdDhIdFNEelZSYkFYcXBmelFBcVdKc3FZQjlqTnJGeEo1?=
 =?utf-8?B?K3JlbCsremxXd0tLSHhXc2xaOURIdHN5VXl6a1hoQTlnWG1PZVB0Mms0My81?=
 =?utf-8?B?UEJpZ3RTVlZnUTBLZTBzbWtXeFVkR200NWZCRWxKM3pPSjBnOE42U2ErQmhL?=
 =?utf-8?B?Y1I5c2xoRTlTZkRJWUtyMHlZclBxa0JKUlRmeVFlTXFlRGpnUGN6Q281eWNI?=
 =?utf-8?B?US92T2RFUm9aN3JDM05YdzhLbUZTRG1JK2FYOEFaNVBjUFVvYWxvV1NLRFpr?=
 =?utf-8?B?NGRMc2xZaGJ0cGlYOG5LMmtSb0M0b3Z2R21CQWNrYjFtMFhnUWc2U0IzR2JG?=
 =?utf-8?B?MU1qamdNRzVRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1dUenBhaVlZTGVhZEl6QUNyeXJLb1dnVlVYS2JWY1diYlFXdy9VUmIvWUxn?=
 =?utf-8?B?MFhZTWFmT2lJaU5kSFdTYnV5WEM4ZFpmQjgyOVV1Z1Rzc2NQMVJkT3NSZzJV?=
 =?utf-8?B?REVlTXVjdFJsV2RGdERDRm8raWltQmExNkdLVjlqcU40SGduVDBPa3NLZUhl?=
 =?utf-8?B?Q3M3RUlYajBLRHV5cUI0NkV2bDY3YVp3Y2FYakQwRUFtb3JFZWMzVnBLSk5Y?=
 =?utf-8?B?UzR2clJOTTI1ZlpoRzBNMUthcVJJbjQxeXY5VTlNbWZTSGJ5VVhUekVTekdL?=
 =?utf-8?B?QThHRlpLekRtT3Q5MnNabFhvVnQyeUdCcGdTUDAvMWM0eTRsTDFrSlg1c1Rr?=
 =?utf-8?B?dnA0Z2VPRzBXeS9wRm5WalRHcHlhdHdESnNjeGo1Sko1RERXMEtaRjB5ZW05?=
 =?utf-8?B?dHB5VnFSV0s0UWE2OCt0S2JPeVVoano1OTJTWkZoQmxqeDU0VExxQjVxVzNj?=
 =?utf-8?B?VVErSEdYZDA5azRqSm01Zmc3VjY0NWZtMTVYczBaTG1Rc053MVB6dm01NTE1?=
 =?utf-8?B?T0dJS3E2cTVLUVV0dm9iSkhVekhVbjRlWDQ1QzhOMUFCM0d4QlFCRW9zKytM?=
 =?utf-8?B?NXAvN0h2QWV5YzBKNVJUYkVMTm5ST0p0RkwwRC83VXVHY0FaSVpSa1RuOS80?=
 =?utf-8?B?cTZ0L01pTXVmQ3FyRkRLQjBHUWNIak5nRzZtaysrMDd1UmdsVGJPamVJSTlj?=
 =?utf-8?B?K2ZTeGhicDhXTzFFenJISzhnWUo3eGhJZllyZzVxR2ZDelpFZ29BaG95Smsy?=
 =?utf-8?B?QWE2c0hNMVIzc0NTWFo1Ykp0LzhyVzd0R0hSeE1vWmtsMk1HeHN2azh0RVo4?=
 =?utf-8?B?dlFwM0RJTFZOYXJkT0lrQW5KVUR1U1F0SXRRdUFTTlNFZmxFUHY3ViszVkVr?=
 =?utf-8?B?T29yVG1GU2tvOVlmZERSbUtybDZqV2JFYlRjS3JMT3krOGRSQVo1eHNxdW1N?=
 =?utf-8?B?K2ZQVS8vcFZubUpkcXNhdlBsdCtJUE5JbVpzVHZTS0Q0cEhpVzdXYUJ6dWQw?=
 =?utf-8?B?c3I4UkF4MldWV3BWRzZaTTdQZzB6Z1Y4VWtKNHZ3YVRDUE9UbkUwSjFKUmFF?=
 =?utf-8?B?WWNXN0gwYS9wYUgrcmxXQXJnTE9hU25kRUZtdFUrTjBDYWZoOElaekxJdVIw?=
 =?utf-8?B?cXpGVkRaUlRBQnh4RmYySW10MGFDNGRyMGhZWXdXbTQzT0R3eUJQQ0pCK21N?=
 =?utf-8?B?RmpDd20vV1Q4T3RwU2ttOXB3Q09wUlYyaGdVU0d2WEo5Z255WUw2VWdId3p4?=
 =?utf-8?B?emdqVS94UEF5MExPeUM0dWFMbE41QjBQN3dHUHE4SzZtVmpiOCt6WXZDSFlF?=
 =?utf-8?B?cWRaVXh1MFZRM0w5dm1wL3FPdkpwVTF0ZVIyL3ZvOGVVUkRjRXlrQXF3NFhO?=
 =?utf-8?B?NG5CYWNQbU1hTkdBeERjUHVGK0ovWDR1WDgrOTUzclRZWi9IWUtJczBhTmFY?=
 =?utf-8?B?ZDFtbWQ1UmZGYmZtcGtBREIvT2lQaTc0aFVFRUxsbFVvOUMrclVZTnZuc3Ir?=
 =?utf-8?B?SDVsblZXRGNYblZwWWl2SVArNFo0dWtGRjZHalVDSHpLU3ZPZDN6MDlsQ1ho?=
 =?utf-8?B?T204cVBreXZjWEE4eUVWdnlCWndwUzVrSVFEYlNUd09aRGRhN04veFp3NFYx?=
 =?utf-8?B?RDJFRHRLY2REZFhQNnowL2FHdFZRQWhKd1BkMlJyeEVtbmlTeVk4TUVhVVYz?=
 =?utf-8?B?YXlzK2ZSMjJMNG9uVWIwaklyMUFKR1FFSHhQSWYzbGdGRmgrSWhFM2lHejU3?=
 =?utf-8?B?L2F0THpqZkhwSnpFU0RSY1RIRm9sQTROY1FKTGMyY0ZRWnBRSjlUelJwbGR0?=
 =?utf-8?B?RDFDT3JEcmJ2NUl0R2NkK2cycXlLR21OTm5QdktXRUg4RzFtUGdhQ1M1RldE?=
 =?utf-8?B?MVR0VFh3SUNCWHVvZlR2ZE1VWGxoQ3lQbUU0Q0ZyTnZIeklZdXF6V2ZWUXVX?=
 =?utf-8?B?QU1EblBIZVNKLzZKTHoxZDB5aUhkNmlwQWQxMm9EcmJ1WWhZb0xpcWd0MUUz?=
 =?utf-8?B?ZDJqOWtCaEpldlp1cGlwWWY0YS94V2dLZmNUK2dsSjBYMmpZTTl1OEFhditm?=
 =?utf-8?B?QVd1VUVlTjByT21hcFlSTlRLSHU1ZmxCTGFxbzBMNmVFaFl1QTVEbWMrZ3hu?=
 =?utf-8?Q?SPxXpp0I4qNXEc+KNEmVxciXW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ae2377-166b-4a58-8edf-08dd57e66725
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:55:24.3483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJiih+NZ9qsE4C+D2SEo6idNx+iknobHhsrlIExJJd87O2Vse8LEuVJfQumR6NQ5lPbGyhbqVKWcZIruSYlA4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7845
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

From: Ye Li <ye.li@nxp.com>

When SPL loading image to secure region, for example, ATF and tee to
DDR secure region. Because the USDHC controller is non-secure master,
it can't access this region and will cause loading issue.

So use a trampoline buffer in non-secure region, then use CPU to copy the
image from trampoline buffer to destination secure region.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 18 +++++++++++++++++
 common/spl/Kconfig                |  6 ++++++
 common/spl/spl_imx_container.c    | 41 +++++++++++++++++++++++++++++++++------
 3 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 217e7ed41a..1bacf52657 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -786,3 +786,21 @@ enum boot_device get_boot_device(void)
 	return boot_dev;
 }
 #endif
+
+bool arch_check_dst_in_secure(void *start, ulong size)
+{
+	ulong ns_end = CFG_SYS_SDRAM_BASE + PHYS_SDRAM_SIZE;
+#ifdef PHYS_SDRAM_2_SIZE
+	ns_end += PHYS_SDRAM_2_SIZE;
+#endif
+
+	if ((ulong)start < CFG_SYS_SDRAM_BASE || (ulong)start + size > ns_end)
+		return true;
+
+	return false;
+}
+
+void *arch_get_container_trampoline(void)
+{
+	return (void *)((ulong)CFG_SYS_SDRAM_BASE + PHYS_SDRAM_SIZE - SZ_16M);
+}
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 7d6780936d..29bc119bb2 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -362,6 +362,12 @@ config SPL_LOAD_IMX_CONTAINER
 	  Support booting U-Boot from an i.MX8 container image. If you are not
 	  using i.MX8, say 'n'.
 
+config SPL_IMX_CONTAINER_USE_TRAMPOLINE
+	bool
+	depends on SPL
+	help
+	  Enable SPL load reader to load data to a trampoline buffer.
+
 config IMX_CONTAINER_CFG
 	string "i.MX8 Container config file"
 	depends on SPL && SPL_LOAD_IMX_CONTAINER
diff --git a/common/spl/spl_imx_container.c b/common/spl/spl_imx_container.c
index 2c31777fcd..47fb2e65e3 100644
--- a/common/spl/spl_imx_container.c
+++ b/common/spl/spl_imx_container.c
@@ -14,6 +14,16 @@
 #include <asm/mach-imx/ahab.h>
 #endif
 
+__weak bool arch_check_dst_in_secure(void *start, ulong size)
+{
+	return false;
+}
+
+__weak void *arch_get_container_trampoline(void)
+{
+	return NULL;
+}
+
 static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 					  struct spl_load_info *info,
 					  struct container_hdr *container,
@@ -22,6 +32,7 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 {
 	struct boot_img_t *images;
 	ulong offset, overhead, size;
+	void *buf, *trampoline;
 
 	if (image_index > container->num_images) {
 		debug("Invalid image number\n");
@@ -42,12 +53,30 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 
 	debug("%s: container: %p offset: %lu size: %lu\n", __func__,
 	      container, offset, size);
-	if (info->read(info, offset, size,
-		       map_sysmem(images[image_index].dst - overhead,
-				  images[image_index].size)) <
-	    images[image_index].size) {
-		printf("%s wrong\n", __func__);
-		return NULL;
+
+	buf = map_sysmem(images[image_index].dst - overhead, images[image_index].size);
+	if (IS_ENABLED(CONFIG_SPL_IMX_CONTAINER_USE_TRAMPOLINE) &&
+	    arch_check_dst_in_secure(buf, size)) {
+		trampoline = arch_get_container_trampoline();
+		if (!trampoline) {
+			printf("%s: trampoline size is zero\n", __func__);
+			return NULL;
+		}
+
+		if (info->read(info, offset, size, trampoline) < images[image_index].size) {
+			printf("%s wrong\n", __func__);
+			return NULL;
+		}
+
+		memcpy(buf, trampoline, images[image_index].size);
+	} else {
+		if (info->read(info, offset, size,
+			       map_sysmem(images[image_index].dst - overhead,
+					  images[image_index].size)) <
+		    images[image_index].size) {
+			printf("%s wrong\n", __func__);
+			return NULL;
+		}
 	}
 
 #ifdef CONFIG_AHAB_BOOT

-- 
2.43.0

