Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4265D41C14
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 10:05:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1510483655;
	Thu, 11 Dec 2025 11:05:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BRAcrU9u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8817A8389A; Thu, 11 Dec 2025 08:18:33 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 866E6807C0
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 08:18:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qda//9RCWA+bSYK2J9PqE3iIMfMRI81+WOKuqxbav5piLGz9ZEdWIawVdWVz7AA89Hsjvwc9kp1T0kxMixXLoVofGxN0T270j5SmiQABHK8jr0ErmonjiWV4hLUxbtU9zoEiGD2yHpu8gYX25d9eBRy8R1i1Dhav9o849P3MG2HIC4urYF++XetPnYkRB/Hz2dfinfeoqQSmvWJ9IPRrwIL7qw7BlBZbf39UMiA4OP2mn9SO07xnNGo3WohOUKbOhORPpWaqBbUiVupQkFyl/sWQInvZDdBrSmOWGL+mcc+IIbwZHZk9UlNzBlwDQQ8wM5CtQIru43ACWxlS4G3yiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DMcp1ljQ4Ih8MCF+8h6ledbzveGdeKee0+DphQ65TQ=;
 b=PIRfemiLhIkVDkXCw8mUZhy/NpxKI3/Zxfhq0jHpWeTYHzTAHDGc/e6OMZ2/a5iHfnW0UGmEFOryJFxvOyYf6AY5sOlSw+NBccPevaUzmS4I3VZaAoQJaZt3Seix+DUF5aYG+dX+tsoHVllU3dakxiBo28Dg0Fv83O3N+PMl4Lok4F8trPdzlygjxTiMc232W3C+YC8FFxZIfULkhnmNOzQmXwEoOEn2MtJo7pRmq4Qhtu47Nae+QbWyEvfgrRaEr6xYRW44FzR4FynTQqxCZFxORSTz7tYi1BbA/YcZVGUqrqGLbOwEqdetmEXhuFTVNp6hgi7B+WAkvyWl+xrljQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DMcp1ljQ4Ih8MCF+8h6ledbzveGdeKee0+DphQ65TQ=;
 b=BRAcrU9u0Et/+TSHGgsixtq6+NNdx1zk1cEsr/j83j7UFL3HWMaZMat8bTLF5EdDtqIbIHGuMwEKoKPSbYcZAfNpMI8MVH3YH1vh5enJyLqwJVTWMqP0MyvcRyLDtvZsaRBA5DqIrysD5HirPfeTQSdOc1hY9Oo0fd4H4r29YzfD3Qhoy3gwKranKAgf6P1vIXEhWytS/rtZPH5WDvUVS6ns1aWj/nquw+sthrdtAP+/sIqYZE/cYeiIfcZIfcyuZAQSwWbpZr4xAxIiZra00Zwsx2cj2kZ99UKSIrcQRHcC71ehw+RJTHlI36KKyqqSkYBSe/h7GWxSUkMhL3JI5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DUZPR04MB9920.eurprd04.prod.outlook.com (2603:10a6:10:4dd::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Thu, 11 Dec
 2025 07:18:29 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9388.003; Thu, 11 Dec 2025
 07:18:29 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 11 Dec 2025 16:31:43 +0800
Subject: [PATCH 1/2] clk: scmi: export scmi_clk_resolve_attr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-clk-scmi-imx-fix-v1-1-9579567da829@nxp.com>
References: <20251211-clk-scmi-imx-fix-v1-0-9579567da829@nxp.com>
In-Reply-To: <20251211-clk-scmi-imx-fix-v1-0-9579567da829@nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Alice Guo <alice.guo@nxp.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, Ye Li <ye.li@nxp.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SG2P153CA0039.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::8)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DUZPR04MB9920:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e3a5b3-ec4e-4640-9b02-08de38857bac
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|7416014|1800799024|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXJyM1pCQjEwSFpiaXZkRCtnbGxGOHBCd1M4WTUxR2M1ZkpsZy90VnMxUm5h?=
 =?utf-8?B?aE1UTHdsYzVma2JXZHpNeG5BR1l5Y2lCNllxMFBLOFhoSWxhUFFGYTBaUnQ3?=
 =?utf-8?B?NjJxai9ML1pCa0p1UXAvUFYwK1RmcXhUV0U5YlV6WVpnengrbElTR3dxOHA0?=
 =?utf-8?B?RUo0ZEdKQnRIaVBvRWdrMkxCaVZqdzVsWUE0YTBxTE9qU0hhenVRRk0yL051?=
 =?utf-8?B?MkRpUDVPUXpnQUhqcERwWHA3TC9lYTVFZFIzbWV2QUZQUTV4ZDZmNEhrcldi?=
 =?utf-8?B?dXpvSGwrcTJpdks2YVovdzFIbTZLZTZHWjduVnltNUFNZWhqT2QxUERYVldP?=
 =?utf-8?B?UnNGU3Q0Ynl3dDJseDl3cXVTQW1pRUZrOUVwcGwrK2k4SXVyNnl3Q1hmZDZ1?=
 =?utf-8?B?dUhLZ2NaSS9yMW9VTzFZQ29iRCt3NlhjYm5oc25VeUM3dGpxbkpZdzRGTjlN?=
 =?utf-8?B?dUNBOVFwOUJjU0pkR3hZZkRLWFdLL05EVGl2TkhBc3dHVmMwRHJRWUhDd3Jz?=
 =?utf-8?B?NnBFTzduZGcwYUpQVVhwK0NTc29QTUUrUXVTL0RXem9HNnd3QkY4Wnh5NFQy?=
 =?utf-8?B?bisxVW5jVi9FdllWZ3pRMEhhaWRkTEdudDdxaHY0bEtGNXN4SC9OeUNUMkhh?=
 =?utf-8?B?cTdUVEswS3U2cUU2NkJiazEyanRiRldIT2hTdnM0VkV5b1hWeEpMc3BYY2hS?=
 =?utf-8?B?L1ZHbVc0c1k2dFRNTXo0VUhqeWFyMXA5R2dWNUZrM2lMbXZPSnd2RGUvZTFn?=
 =?utf-8?B?QlVtK1ExOEhuODJZTlNkbjBjTVFVK1B1c3ZFNFdaclRkUHhNMlJaNDJ3SlBi?=
 =?utf-8?B?dG01bXNSRU9NV2RRY3prVitPUXZhR0RycmhUVTB5T1RCOHdBYXE2R09HeUxF?=
 =?utf-8?B?RHBmNE5RLzBLY2ZYL21nTVFKck9sN2k3UHB0OWpJa3YzazlKOUhwdHQ2NzBn?=
 =?utf-8?B?b3UzZmthL1ZTS2wydURQTkRnOXAxUzd5TGVESXNyMy9HQ0lwcWdQNlk5ckhi?=
 =?utf-8?B?dk5hVkVSc2tXMXpLcmViY25HT2U1TVl0YStJdE8zdEkzZ29sVmRqeUhmYmdI?=
 =?utf-8?B?eGxNTXFwVHU5U3E0bkljUm1GQTFlZjVwUjkwUDhDaEZidG9WMVNPaDRqNDNS?=
 =?utf-8?B?RW1SUXhQQ00rV09VQThGU2JGOXdGdVNaQWhUVnl6aHIzVkUyZ2w5U0U3L25a?=
 =?utf-8?B?M25iLzVPckpyL1pqV1pOWWVONmR4TytrZ3ljaEY1Uko2a2pZY01TVHk1QU9E?=
 =?utf-8?B?RGl4UHhTWW1tOFhyVjdlTk1IRWhzSjdnT3h4SjBkSVlYSXk5L3pUcWxTZGZr?=
 =?utf-8?B?V2FLRjJPVEl0bzVLMEFaVG1WNng0Yk5EWmlJU1Q0UjRqTXMxWkpnTklTRHVB?=
 =?utf-8?B?ckMrL2Fsa2p5bW5VTHZWNm1HbFdCNEFxaTd2STdOVVdHOFI5YURNL0NpNDRY?=
 =?utf-8?B?Q0pkR1luelV0N0VKOU1qQ3lJelYvRGx3RGJMMjRobzVGb28rR3pUalp4Q21t?=
 =?utf-8?B?aHpVWWp2emMycFJacFNBZDRUYzR1OUdCMDRCWkErdGJsOUVMaHNmQk9VM2Jx?=
 =?utf-8?B?SXN1MjduTjRzOXZMWG5tWDNYcCt4Mk5maG1pbEpoMlhZNkxNanBtRWJCdUN5?=
 =?utf-8?B?Q1pJdGpYWTlETGNEcmoxWlZNOURLNXJWQ1ZCeTdISFVIS2FiK2hXMTMwNHpE?=
 =?utf-8?B?amlVR3JhVUN3YkJxTU9JbDJpeC9XcnlKdVRvNHRnMlhZaUxMSUJDOVRDc05k?=
 =?utf-8?B?UzR4bktyR2pLT3VrSlo2OVN3SmVGOVluTTRyVEJNcXl1ZGlQNU9FWVpUMXZU?=
 =?utf-8?B?YjNyd1dyb2tSK2VFeUtoUU1LS1JRSE1yOHFUdWFWbFROcitzQUx1amRSclB2?=
 =?utf-8?B?UXczYzJYYW96alBscG1qVUtGRGZPdG5pN0hVTVRpVkZka2FQV2xNTTlQRGtU?=
 =?utf-8?B?ZkFXUG5QQjRUVlFVUDhMWDBTM21OTkVEZlNZR051dHVJVVhjRFBHNnh4UnBQ?=
 =?utf-8?B?dk5IMjlVNjVMT3RKVXBXOUFubXd6M0FsWmJmZWRDRDZNTWc1bS84TWtLNlJ4?=
 =?utf-8?Q?kD2ifJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(7416014)(1800799024)(376014)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1lNYW9WMG5QOHhoa0xJaitsb3hmbldIK1hoU1BYWEE5NFMyVDJodHFiRmU0?=
 =?utf-8?B?N0hOaVJrYjRrWUpJaWM4UTNXcHVEME5MVHRFMHBLQXdCOURJK0VIQUdQbVBv?=
 =?utf-8?B?amNPbmMrd1pHTDB2K1Q1YUJjUTY4bTNIcU5TTXZxUW5NZWtkYmFYaXJZTFFR?=
 =?utf-8?B?dGNuN05sU0hzaWZOeGtRWlNNeCtnWjcxa1FCbHdhc3FUZmZyZEhDaFdlZ25w?=
 =?utf-8?B?ZGd0TG5iSmxhTWZOdmRMZnpHcmhwRnk1akZUMWFqcUF3L3JCM1czamVRZ0ZI?=
 =?utf-8?B?Y3lTMWJMRGprcDkzZzB3SnErSktaOEx5Sk5KRVREN0VmZFozTHdTN0draGM2?=
 =?utf-8?B?VzFRVXY1a2JJTTlEaDNYak0wZWdDUzAwL08wVVp2ay9yVk45Z25HUDhaT0VJ?=
 =?utf-8?B?bFBxYmJIbkxYZVV4Q3Y0czh3bjNHZ3FlNExKWW56c1lxQlIrazBpTkNic1FL?=
 =?utf-8?B?QktTYnpBdE8zS1RyUkltUVVnSUErU3hHRWEzbUtITldRNitUOFd6OWErUzdy?=
 =?utf-8?B?V1dKODFjWHpobnlRdkxMRUpzWDBhZFhrL1NNcVRkK0tmNXV3Qi90UFNhQVVI?=
 =?utf-8?B?aEhUeEdTNFR0dXZ5WElmNUhYM0JxdFFqTXZLOGJFRVVkOTJFSm5NOTE5cnJX?=
 =?utf-8?B?UDJUY2VVT24zYzkreFVwTjJzYnZCVmJkZG96YjIvci9CdmNoNHpseTlyUzVJ?=
 =?utf-8?B?NEl5RzVia1VBc3dEaklCaXJKWmgrTWhMRlkzbE5SOVVLVUhDVWhkbGExVFZr?=
 =?utf-8?B?YndNbkFWd0doeWRIdVY3RTRYOFRIRXBqQVNJR1dzNkxwZkw2MjBoZlNlL1la?=
 =?utf-8?B?TVBmNHlmSUUyMFpFK1RtNjQzVU5ld0ptSGdyUENac2lSYnNTNFlpU3RhcW1s?=
 =?utf-8?B?NlhhUUFzV3loK05WSVJ1MEV4WEJNeVZTMndyYjJwR29udHhZQlpEOHlHS1Nu?=
 =?utf-8?B?UjQvVUk2S0wrV0hCUzdKZ2l5Ty9xL21uWFdxOWVRaWdjS3NEZkNsQnE1aWZm?=
 =?utf-8?B?TWNDenRlTnlmSVQvL3dIOTczUTVRSFJIWDQxbXNmNVh4bXBKVEFiWVZ4Qytr?=
 =?utf-8?B?OEEwY1JsblpCRE1YVnZuSEhTM1F0d3VxWWZGazRiZjlLWXhJdi9USTJMUnlB?=
 =?utf-8?B?eC9jYmRUWFFqVGhUMlZsRFovYTkyeFkwbk5kckRJamFaTHpydUppQTd5NHE5?=
 =?utf-8?B?cWxkNTJzRHIxVXZBbm41MmxMWDZ3VTBXcGNlSnYxZGk2bVl1Y2FNd0kvS2lU?=
 =?utf-8?B?TTVBcTY2NG1ibXVadVBqMjYxVks2SVlOWFk1ZEpZREQ5SjhJSjROQ0k1ekM5?=
 =?utf-8?B?U3RtUmROeWUycDJRUHFhbVhYV0JRZDBsMkdYNFo5UWQxSC92WTlvU3lsbkda?=
 =?utf-8?B?YTAyaVpsSHEwbkNJM0MxeGVUQ0lXV1pMc0U2Q3FoMFJOcThWaW5Ka25malgz?=
 =?utf-8?B?VjFSQlhQUHJKenhFbjNQMVRjbjc1QVFwWVU2d0IvMnErT2NHUVNaazRzS29h?=
 =?utf-8?B?KzRBRHlOQjFiM0ovQmgzOHgvcWdQTXV1WW5PWkpNTWxsNTVkakJNS0NlaEUz?=
 =?utf-8?B?akhiODYrelh5Q3FKZTBtMC9zUHMyckcwMFF4US9Qd1JseG94MlR5WnJ0b2N2?=
 =?utf-8?B?OTdVRG53Q0NVUHZIdlFRM041L0JGT2c1Qkh6MmJlVVhhYmhTRVFQc2crUXEv?=
 =?utf-8?B?bXFkT2tyNUFIZWdhYnk5OFhsWS9Nc1pIdG83THFrYjNlU21iL3I3Z2tTeEtt?=
 =?utf-8?B?enVTcGlheDdqaE9YUHQzdW5HWXd5Nk1aRmxmUytZRzMvbUdNZFQvc2laSGpa?=
 =?utf-8?B?VkhlSWJlbHoxdDVXc1BpRkRFMFhzQm1YL3hNdlFPWFVwRVY4cFY5NUxzbHNv?=
 =?utf-8?B?U0tJVElTOWxLSTYrRERxOXhob3ZQOTJRcjdTbFRyeTZKZXNkUktlNnBVY2pV?=
 =?utf-8?B?SXRCeDkwUitSV3d0eUh2MWVpZmJtcmZDYmtZSkF0ZmlYdjcwSkM0NHg0YmZG?=
 =?utf-8?B?dW96dEtZeTlJV0JZS3ovemVIcUlueFFqakdrSFl4alJEek0ydkJTY3p4c2w5?=
 =?utf-8?B?RUROTU1DYWtPUEFHOVczbEtzYjFaY0pUd2dYT1BPQ3IzQjEydlRCbEorRjVW?=
 =?utf-8?Q?9p20plXPBdszzVPS6hSitKjHm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e3a5b3-ec4e-4640-9b02-08de38857bac
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 07:18:29.2288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3vYcuPsIcp78Ul0/zJobfdHJyLaSz+Pk3uPkQuEPSIIuS2DEWGTjNnKpxuLog6xgP2Cl/xNZ/sbn3LDNFW+yYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9920
X-Mailman-Approved-At: Thu, 11 Dec 2025 11:05:15 +0100
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

With commit 3547e315c188 ("clk: scmi: Defer issue of SCMI_CLOCK_ATTRIBUTES"),
the SCMI clock names might be defered. However the SCMI clock may be
input to other clock controllers, such as clk-imx95-blkctrl.

Without the clock names being resolved, there will be error:
clk_register: failed to get hsiopll device (parent of hsio_blk_ctl_clk)

So export this API for users.

Fixes: 3547e315c188 ("clk: scmi: Defer issue of SCMI_CLOCK_ATTRIBUTES"),
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk_scmi.c | 20 +++++++++++---------
 include/clk/scmi.h     | 12 ++++++++++++
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index cbd44f310b1..bc665e0bd3a 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -6,6 +6,7 @@
 #define LOG_CATEGORY UCLASS_CLK
 
 #include <clk-uclass.h>
+#include <clk/scmi.h>
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <dm/device-internal.h>
@@ -170,7 +171,7 @@ static int scmi_clk_gate(struct clk *clk, int enable)
 	return scmi_to_linux_errno(out.status);
 }
 
-static int scmi_clk_get_ctrl_flags(struct clk *clk, u32 *ctrl_flags)
+int scmi_clk_resolve_attr(ulong id, u32 *ctrl_flags)
 {
 	struct clk_scmi *clkscmi;
 	struct udevice *dev;
@@ -178,7 +179,7 @@ static int scmi_clk_get_ctrl_flags(struct clk *clk, u32 *ctrl_flags)
 	struct clk *c;
 	int ret;
 
-	ret = clk_get_by_id(clk->id, &c);
+	ret = clk_get_by_id(id, &c);
 	if (ret)
 		return ret;
 
@@ -188,7 +189,7 @@ static int scmi_clk_get_ctrl_flags(struct clk *clk, u32 *ctrl_flags)
 
 	if (!clkscmi->attrs_resolved) {
 		char name[SCMI_CLOCK_NAME_LENGTH_MAX];
-		ret = scmi_clk_get_attribute(dev, clk->id & CLK_ID_MSK,
+		ret = scmi_clk_get_attribute(dev, id & CLK_ID_MSK,
 					     name, &attributes);
 		if (ret)
 			return ret;
@@ -197,7 +198,7 @@ static int scmi_clk_get_ctrl_flags(struct clk *clk, u32 *ctrl_flags)
 		if (CLK_HAS_RESTRICTIONS(attributes)) {
 			u32 perm;
 
-			ret = scmi_clk_get_permissions(dev, clk->id & CLK_ID_MSK, &perm);
+			ret = scmi_clk_get_permissions(dev, id & CLK_ID_MSK, &perm);
 			if (ret < 0)
 				clkscmi->ctrl_flags = 0;
 			else
@@ -211,7 +212,8 @@ static int scmi_clk_get_ctrl_flags(struct clk *clk, u32 *ctrl_flags)
 		clkscmi->attrs_resolved = true;
 	}
 
-	*ctrl_flags = clkscmi->ctrl_flags;
+	if (ctrl_flags)
+		*ctrl_flags = clkscmi->ctrl_flags;
 
 	return 0;
 }
@@ -224,7 +226,7 @@ static int scmi_clk_enable(struct clk *clk)
 	if (!CONFIG_IS_ENABLED(CLK_CCF))
 		return scmi_clk_gate(clk, 1);
 
-	ret = scmi_clk_get_ctrl_flags(clk, &ctrl_flags);
+	ret = scmi_clk_resolve_attr(clk->id, &ctrl_flags);
 	if (ret)
 		return ret;
 
@@ -244,7 +246,7 @@ static int scmi_clk_disable(struct clk *clk)
 	if (!CONFIG_IS_ENABLED(CLK_CCF))
 		return scmi_clk_gate(clk, 0);
 
-	ret = scmi_clk_get_ctrl_flags(clk, &ctrl_flags);
+	ret = scmi_clk_resolve_attr(clk->id, &ctrl_flags);
 	if (ret)
 		return ret;
 
@@ -312,7 +314,7 @@ static ulong scmi_clk_set_rate(struct clk *clk, ulong rate)
 	if (!CONFIG_IS_ENABLED(CLK_CCF))
 		return __scmi_clk_set_rate(clk, rate);
 
-	ret = scmi_clk_get_ctrl_flags(clk, &ctrl_flags);
+	ret = scmi_clk_resolve_attr(clk->id, &ctrl_flags);
 	if (ret)
 		return ret;
 
@@ -402,7 +404,7 @@ static int scmi_clk_set_parent(struct clk *clk, struct clk *parent)
 	if (!CONFIG_IS_ENABLED(CLK_CCF))
 		return __scmi_clk_set_parent(clk, parent);
 
-	ret = scmi_clk_get_ctrl_flags(clk, &ctrl_flags);
+	ret = scmi_clk_resolve_attr(clk->id, &ctrl_flags);
 	if (ret)
 		return ret;
 
diff --git a/include/clk/scmi.h b/include/clk/scmi.h
new file mode 100644
index 00000000000..9c669ba4adc
--- /dev/null
+++ b/include/clk/scmi.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef _CLK_SCMI_H
+#define _CLK_SCMI_H
+
+#include <linux/types.h>
+
+int scmi_clk_resolve_attr(ulong id, u32 *ctrl_flags);
+#endif

-- 
2.51.0

