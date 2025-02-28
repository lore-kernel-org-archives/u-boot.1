Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50840C282C5
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 10:55:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0A02811B2;
	Fri, 28 Feb 2025 11:55:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="T6cs6X65";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35A22810F4; Fri, 28 Feb 2025 11:55:02 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::61b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 617E08120C
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 11:54:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y0DbStZdV+MuE7t5Xcr7x/0ExtB3jc0NyvxR4rqENmHEs5AQhbQDrnwfa4JzG+BukzwqSa0jjIoBByHsW9Ge6inbanDyUSYt+GOpoL4Ggcd95jpY9hk1Bo5RImiOhQ2ss4gSJIvnihG6TSc4AgmL43zarbRPI0NMU+QgfS/vaevq+EUlQPwSgWjmntiY5jW3I0qi/WW6BnEHcjR+I5KH93WhPxujRa74PGunD1LmnegcLRFKqaG10eWYcbMauCsc1HVbD2atjx3t/TlUEl7hu2z72mfuxZ2MpOd7kTB4UabgVDVAN9NLN9JCAsEFhPPxWsq9Gm8lZMGGDJ7wmeR+lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euoCfgEyNIjKygIFQEdk40hnSxJ9anyhoNm+L0j4GVY=;
 b=j1xdQFkfXsNQAJWchLvnaM299RN0EjZvPCw0xAqb1Njr/qIteG3Viy96FesYwfNytX9/UlHuaSbaBNFC+TmRrJ1DksrIAh/HEZCCBfyPcxyoFXGC7rYI0C7V7fpkvFwHGplZqtU75uE07aM2SGygPeiXdi3DbLuEK2NssjGbXO6H5hcL+xe+XVo1OCN0y1CfxqKQ5asblg8mhBrfI7T5LLPrBgCx3qcYYusgrktCMwTXpZopuhhBGLz7w0bxtMhXhYzQsOzUSjurf4LVDwqU0gfpEP+953PHvZNf1qHrzWri5KGkG49EshpiNg5Q6ZemCo91nrDRe+pPBcsHBV5F1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euoCfgEyNIjKygIFQEdk40hnSxJ9anyhoNm+L0j4GVY=;
 b=T6cs6X65voKAJMItZN2gH4AwxB+msaDZDTeonMDr91K01HF6drxYyVBAS9yLggxRYq4VKehd0LDgZBVAEYOQd3AMj/BMoVrvfwsmXFBI/9medNdFHQc/hwMTq9O9fblqnoYsvGsBC5JGATxQLSzO8oVEkWmuBzFVxa/1ix9rmWwuEJHJ5hx0keedyLDTfwB03lrDsHVeohjA47x6pfs9PioNgm4v9d3WPejaipHid/ugWNXTb/2h4I1HtlTDOOwUrVIR2sUIb1Dn8NbDnioRifLzvEh+nUCqW8OaetoINIpyA8xiey55vaAQf85SUybJmO1o+gsF9bkcaYJQ8f5wYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7845.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Fri, 28 Feb
 2025 10:54:57 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.024; Fri, 28 Feb 2025
 10:54:57 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 28 Feb 2025 18:53:57 +0800
Subject: [PATCH v6 06/20] scmi_protocols: add SCMI Performance domain
 management protocol message IDs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-imx95-v1-6-09594e93cc9b@oss.nxp.com>
References: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
In-Reply-To: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c143189-854d-446b-5393-08dd57e656f8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGZOckxSK3lXeU5hdmtzMklXT2dGZXFvdHVSQXFGbThsWXVlN1g2cENnamhC?=
 =?utf-8?B?L3J4TjNNWTRYUEViMndxSG9MQm1ZaW5OMnZWZlpqWEU1Nk1YR2hIdFBNUFZh?=
 =?utf-8?B?V3NtNktweDU4VEprZHBQVDdzRGhmTjVTdFJwVTBhVmZZRDdmTFJycWs1L1Ay?=
 =?utf-8?B?UHJhZ2ozQXU5NDFBQUM5cHlNaXM0VlRjeWM2ekYwUE5HU1h3V3lXb3ZhWGsy?=
 =?utf-8?B?WnhWMzlHc3FwSlpxUDluNDFDa1hzRHVKNW1UbTRJRUQvSHpUQ0hWM2p1dlFT?=
 =?utf-8?B?Y2xzc294SUY3cXJha255UnZjR0JiYzBGaGhSeExIQUE0c1BCb1dLamRHek5B?=
 =?utf-8?B?bGFlRlk2VGJEN0JyemtSVWpGcGRmWENJcUF0UE8yKy92ZUdTQ0VPUXMzSmlu?=
 =?utf-8?B?Z1kzaUpZVk5KTEI5VHAvRFhNcnlFR3FBb2REMXhaLzZpOUUyMUhkdmNEY25N?=
 =?utf-8?B?cTh3MFN6MkNhRXBqRkVzdDUvZXhnQjFkTHNKdHFqZ1gveWRueWtVb1NqNFdU?=
 =?utf-8?B?NGxzSytMK1dhZ3puYlkvTzhGbWtWbUIxRSt2b3E3dWhqTTlSdlBNRnVKbzZw?=
 =?utf-8?B?M3NNaFZmWXMrVWVBUERJK1YwS25pNG12SzJwcUh1YndzVXBITENFT3gxd3Ir?=
 =?utf-8?B?dUtqaS9YNmNRZVNQbU1xencvSEorYjdPVkh6bVY2eUYvbDlGbENIWkw1TlFs?=
 =?utf-8?B?UExyRzVsUTRYSkhQa3l1eDdIM2FCN01XUWsvYndOTU8vRTg5U0U5ZFdlelRY?=
 =?utf-8?B?OGdFb21OdFpMWjE5UkZWTXIxZ3l4azBMK0luMUN4dGRTMlYwN2hQOUdKSjJx?=
 =?utf-8?B?djZVeExaMmpDd1Y2cDlrSkY2RURwazl4NXIyOUhUYWNNdjg0WXBLeUh6cGFw?=
 =?utf-8?B?SXA1OFc3ZDhuNyswazZhc0hYb3BZcnE5Z0xaVFJmSmt2bkp5TWRDcWJteTVq?=
 =?utf-8?B?TkIwblQ2dDZ2TkxmTHl2U3M1bHJ0VnN5ck9XZ0Z4a01BS0s1SEhsMS9vNmlK?=
 =?utf-8?B?aE1sY2paSEtqMGs1bU9xbVpGTk5YcWtYdjlPbm9LMmFtY1d5QjFLMVJubWlI?=
 =?utf-8?B?TVNHdUtaWDJFaVltR0gvbG9iVjB2bkt6VkdaSEhZUlNUR0hVeG9vMGpLMW11?=
 =?utf-8?B?WGYxSEk5eGxTTHJYVldKTGFJWWNGY1E2ZitmekJnZmNWRUxkY1V4MkNLWXM2?=
 =?utf-8?B?eldCbXd3c0k5c2NDb2FUNE5zZzZUbndyTHFLazhCRk45MVdkK2UyQVdtYjdq?=
 =?utf-8?B?bENJMzd3QkIvakFxd0R5cVcwMnNtdDFNb1JJYUMrREh0NHB6ejhNeERodElm?=
 =?utf-8?B?R0pscThHQ1pocnFuNjZSbS9ISlY2L2JETUZlbXJnUWx0TjlXekxuekhyQXpW?=
 =?utf-8?B?T2taUGQxd0xzbmpMSGs2ODdqbGM1NE5CWXFYR01obWVsUkZzd2J4NUtROFIw?=
 =?utf-8?B?VTVtem9tQzZyVk5JZWQ1endXWWpscXFtcGhuVnY2b05ZeHdmUU1qY3JueDlJ?=
 =?utf-8?B?bW1TUU5ING45emJvZ2JyRk44UmFKanlOcEk4RlhlNzhsSlJEM1FLL3NjL29u?=
 =?utf-8?B?Uy95cnVJb0lYMDlzRWpvQXdaMCswMllwMnhoWnpQMy9XNzNmbkdjdDhrYXJz?=
 =?utf-8?B?WkV5SXRMSk9wVkR0VWpxYXlpaGE4NlFsL1IyTnVzZjdSUFZXeiszTlJleFVr?=
 =?utf-8?B?by9FWUt0ZjZlWW9IZnlESG5SUzhIaEZyVDZTTlhaVnFKYy91cC9salI3MUFX?=
 =?utf-8?B?ZExCWjN0QUVCYUtLTjdGaWVxTlhIQ3RRUklNakVES2hwdE5ySURmaDh0TC9W?=
 =?utf-8?B?T0pwUEJCNklVL2FEWmNHS2o4bHNQNjFGczR6cE1vUW1Lb0xUL1ZlVFkreUZT?=
 =?utf-8?B?OVF2UXF6SHd5TmxRNTJrbkFuMHA0WnA3b1hYY29RbjNscnV4bFFHd0YrdWpT?=
 =?utf-8?B?Q0VkQkFGaVJqTm91UENoTG9XZ0orRExrM1BLR0ozWkJ4d3k1ZVJ4N3g5ZDFI?=
 =?utf-8?B?STVHRnZ6dzh3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzR4UnY1ZFJocENZMjhBOFdjNWlvRlAxY3d1dmRBMlZaMzVYY1doSmF5Y09Y?=
 =?utf-8?B?M0dOc3BYVnZaYXprOFNvSUVuMXBHUW4wM2hQbjFmcWVEK216QzFkU28xRHV6?=
 =?utf-8?B?bHNGcTJ1cjR1cXZmQ2lGdUZXdmFnaGlSWXc4Mkc4czVoazlJRUplZE9YMlUr?=
 =?utf-8?B?cllzRFNWV2RFamxLU1hobEVBaTh3bDlTQ2w3NWxwSHY2QmY3YTFqbHdrYm5y?=
 =?utf-8?B?dXRMSWhScEhHVGFSNlhpbm45L2FtTVlJYTdua3ZBbnpaRmZ6RFl2YVVjcmpq?=
 =?utf-8?B?ckdrS0NuUmZGdGxMeThYYVM5VE0vaGVvbnllZnBkcGdlOTZYSnoya1BQQzF0?=
 =?utf-8?B?NDltNWtsZW5rN1Baek9QZHJ0Q2lLSmI0NnRnaEgwMXRzOUpsVWw3R055U0hk?=
 =?utf-8?B?bW5xYmQ2NVhudkVRTnJYbDhkOHhlM2F0ejFJTGhyaklkYWRtWEdWODQvakZB?=
 =?utf-8?B?Yk5tNkNObmhtUFFkMFVHYTZKamc5ZGJGVUlMby9aTkJ5NmhBY2lnV3dza3dM?=
 =?utf-8?B?S2ppMEJXT3pFOGFhSDBUcjZZdW9GS0UyMDgrYlZRMHE0c1N3ckhOMWhNdmFF?=
 =?utf-8?B?ZWg1dW00akFaWlVBQll6T0FrVndBeE1EVjk1MWZOUE1WakZKRXIxcDgybG9x?=
 =?utf-8?B?TDBMWGhja0psZjdmMTZTaEpwMDRuMUFNbnN2YWpCeml6dFV4SWFIU1hMTjFh?=
 =?utf-8?B?STkrTlN0S2Y1aFJUL3lPUWN0bUVTQXNFd2haOTZONUNJeTZ0Y1Z3RnVUQ1lp?=
 =?utf-8?B?eUlUOTdiNHZxQjZ6c1F6T0c5NUVidDQzeVU5YkRLYUpuQmd5TGJDaDYvVHNj?=
 =?utf-8?B?c1l4ejdnWW1jK2VVNThka1E2dnhEdWV2N1Y2c21EKzFuckdkVmxLbUwrQi9r?=
 =?utf-8?B?dVVUNm1iaDM2NFljZXlPVEVrOUNKMEZFZTJQZzl0TEpWb1dCV29oUG5FelVL?=
 =?utf-8?B?aWxEUlBka0E1eUFITEtRa2ZLV2wwQkh5dVVYT3pQVWsyZ1I4QStITHg0VXk5?=
 =?utf-8?B?OTgxUkxIUlpRdGoxbnF1SmZEL0tSRldqNWVwUGpRRE9KV0NTbkwwMGNOWDUw?=
 =?utf-8?B?aWVxVlQ0Rk0xNmV0aHdxRTVpWE1kZkpoV29HYWNnWE94Q2VKZUtWMHhrQnlP?=
 =?utf-8?B?eGMvTjMvY1FoZ3RCcFF3T0lOaWIwL1k2dmZ2TUxKYXZQdlF0UEhXVUVmRWNW?=
 =?utf-8?B?c1RXbS9vWDMyTnR5ZUgwQUZ5SU9xR3ZlMlllVm1nbHBFNm50ODhzRGNydmln?=
 =?utf-8?B?RkRyMVlSTG94UnZrK3o1ZHAyNGJSa1JKK05hSmpRS2w5NEErc3dhQjZueDho?=
 =?utf-8?B?K3RqNUViZFpzZnRnQ29meDdXejV3bGM1RDVmWFV3Mk91QWM3RGhVQ0dNYnls?=
 =?utf-8?B?SmI5cnVFOWtVd2UwRXBUME4wT0lVdis5R1ZvcStPYzc1OGMveDRkdlJOQWtR?=
 =?utf-8?B?Slorcy8wdGhaNUlzUVAwQVYxZXpWWDk4WUF3VVkwT3RuZkRtaHVoRDdFOTRp?=
 =?utf-8?B?N0tjZmQxVkJQWStYY3VKMzdyOUdXZ3Y3OGRDZ1RpT0xQUytpc2g1L29DU3J0?=
 =?utf-8?B?SnViMTV5Ync1c0lOcURxK0p6SVA0Nk5XajE1UVJOZzIrZWZ6UFZaY2NuYVJ3?=
 =?utf-8?B?SlpocXFKeUt6SUhxbHFQSTdMVHVyc3RXNE16RzN6UDhiMjE5R2xYTFZIMU4r?=
 =?utf-8?B?RWFpQzQweVdhanI4OGFsYVBCdzYva0NCWUdWR1FJVmRhUzRaRE0rUU5JTDBG?=
 =?utf-8?B?Wk5MUzg4dnh4QWpZTzZ3bGtaUVJ2Nlh0SXhRRGIxVnQvWFEzbG1WcGoxcHgz?=
 =?utf-8?B?eTRsYU5LZVE4amRZL2plc2RLSThGZ01YWVNDS2lQZi9mZFFFeUV3L0tJTFcz?=
 =?utf-8?B?QjljYzBTQ2RaeXBEOGp1dlU0MUM1UWtWeGZIc1hqMnUxcnlTa2ZNOWR6TUVo?=
 =?utf-8?B?a0J1U1VoZWFIM3Bhc2dDZXkwSFBjUXA0c2N2dlRKbGJLa2p4WU4wcjlPUERQ?=
 =?utf-8?B?dE1HbEI3TlJSK0pySm1jTWgyOFlKUyt2Q2pmSTBKcCtFVUcrbXNNUnRnOElN?=
 =?utf-8?B?aWpKSmtLem9pcFprVG9UeDdPaG9OK1hQUlZqRXNUZmpiWjBWcnVIS2Nla1VW?=
 =?utf-8?Q?pa1TQqHuQu5s3w2UVm4Ie1fbw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c143189-854d-446b-5393-08dd57e656f8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:54:57.1666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJ9SjIH5WXsYM3tyD2fnmAE1eNpoBsIwGRxn33lFVJwsBwezuLuffxcZeQLhqxZVK36GPtRiLKXZFOuCkatcYQ==
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

From: Peng Fan <peng.fan@nxp.com>

SCMI Performance domain management protocol is intended for performance
management of groups of devices or APs that run in the same performance
domain. The functionality provided by the callee-side can be used by
passing the corresponding message_id.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 include/scmi_protocols.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 06de4a601f..34f272c448 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -1046,4 +1046,22 @@ struct scmi_pinctrl_config_set_out {
 	s32 status;
 };
 
+/* SCMI Perf Protocol */
+enum scmi_perf_message_id {
+	SCMI_PERF_DOMAIN_ATTRIBUTES = 0x3,
+	SCMI_PERF_DESCRIBE_LEVELS = 0x4,
+	SCMI_PERF_LIMITS_SET = 0x5,
+	SCMI_PERF_LIMITS_GET = 0x6,
+	SCMI_PERF_LEVEL_SET = 0x7,
+	SCMI_PERF_LEVEL_GET = 0x8
+};
+
+struct scmi_perf_in {
+	u32 domain_id;
+	u32 perf_level;
+};
+
+struct scmi_perf_out {
+	s32 status;
+};
 #endif /* _SCMI_PROTOCOLS_H */

-- 
2.43.0

