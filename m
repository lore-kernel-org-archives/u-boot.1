Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370E8C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 14:30:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FAAC8171B;
	Tue, 22 Apr 2025 16:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="T0ypoU1u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE002817C4; Tue, 22 Apr 2025 16:30:10 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64D33815D1
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 16:30:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2PkkEGlEq52nRJei2TEHH27VtjA/QBkodToppG0ReVmLT4qtxfYr+MrjrInYdR4fMn2GiXpTNmy1R2Fivcr4bs0locKkf6r+YzGSnZblkRA7jKto9I+jpEZkfDUnDGxPsVnC75ECg+MDYO3shRaN6gZbGWJCaLazrClKhHMp/BjJ/MBevRez5BMveVwQ7wBBkCwa8uyME7/P9SbehluI6N7hfZjssjJikHW3EUmhGjEZHnAkk67qdI/zUdaUa4MTQoVh2bA+8zymSaQdOadamfPRlRC+bcbyeGk3FtwGMZ0RY10ouRnlM0qV8/pk2bRDWmgsi4bVlQG+lIsvfecSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIlppN6KemymnOKa0Ed/Yv3+fNl6m6i70jLYGTfG9uw=;
 b=csebwpygSXAoEMwWGO2AmoQ5oOaEPPZs7PvwjPzdgdetZPG5dNziRaJT1BMqrWuH+b+G+VNLY2dsRHtSky4S3Fg8Hab5lZsEM9WNHAXwGfb0UudjWnsjJAyINANPhKtNJ+9JDv8qf7n2dOhpCmjFwKWRzll0d1Z1ZW1h+t2UGPuLMy1BKP1WSZ+QKxd2/fC9muGmSmyptBSxnN1ApbIwtqComdClVOvqH8Oh7DSII5STQyoXiB+QbtNzL9s+fjHMVVOeFLvVsPQ7XsW+S95bC5EMc9QoLBxh4EgtyT/nOCY5FooqrvzdgYdmwiZEDbl/MWyon2tqx7BEDqEZXczLBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIlppN6KemymnOKa0Ed/Yv3+fNl6m6i70jLYGTfG9uw=;
 b=T0ypoU1uyfSgzm/KWpeduai+uA2CxUCMMIbj/dpb5/BkLlXma/Eg6YHg10eidTEjNvAGGJFRWzjTY5C/0+y9BvsDyemWYcGP1r2eNZheIXPZKi9YSB+AtszlK1JXS6y+12fIgScJ9NVCsc+La1F03aIDDP1DAiTx/TAsTo67d8Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU4PR04MB10550.eurprd04.prod.outlook.com (2603:10a6:10:586::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 14:30:06 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 14:30:06 +0000
Message-ID: <11fe3319-8a26-47b7-873e-774140c146f6@cherry.de>
Date: Tue, 22 Apr 2025 16:30:04 +0200
User-Agent: Mozilla Thunderbird
From: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 2/3] sunxi: add "fake" FEL pin support
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de,
 Yixun Lan <dlan@gentoo.org>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, linux-sunxi@lists.linux.dev
References: <20250417000539.3709-1-andre.przywara@arm.com>
 <20250417000539.3709-3-andre.przywara@arm.com>
 <b7ffc468-1970-4eba-85e1-47aaced0161a@cherry.de>
 <20250421222939.69832f73@minigeek.lan>
 <e2d354dd-4be6-45b0-b263-7112b9320692@cherry.de>
 <20250422131121.7a491909@donnerap.manchester.arm.com>
Content-Language: en-US
In-Reply-To: <20250422131121.7a491909@donnerap.manchester.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0428.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::11) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU4PR04MB10550:EE_
X-MS-Office365-Filtering-Correlation-Id: afb38662-bf21-465c-66e4-08dd81aa2d57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUVJWng2NWRMRVlWSWdXQ1VDcGc5UXFTSUxHMWJyeFdONWwwQ1krUjhiMDNi?=
 =?utf-8?B?TTJhaGlBUTlqWVFvQkpHaDY0RHlHclFxMTBiTkRDcWRuWkphOTBtTElLdGlE?=
 =?utf-8?B?bnZvbitvdThxcWdhWjNCQ1J6UGc3VnhVS0lXQkxWNzkvQU1mcTNVMkR2ZlJm?=
 =?utf-8?B?bFl6ejJIV3BUaUtETTkxNlgxVEpBVnlBMitXQjR2VExpOEU3d3hYek5NMWlE?=
 =?utf-8?B?TkRTM2kwZFIvMzBNVHJmeUNtYkg0VE1pK3BiQ2NmbEZWT2NJRUU4WTd4WDlY?=
 =?utf-8?B?U2hRQTUvQ3BZZGVHMGFDMkRPTmIzVWlZczBVcUVlM0FmbmR0SlZpU3oxaG1z?=
 =?utf-8?B?L0w4M2xsVmkwSnhVbXNDVDFRQ3hXTVU5RGp1d0k0Q3NzRzdGajVmTHF5NGdW?=
 =?utf-8?B?VmVsbnlIL09hdVdIZzlGaCtMNGZtRGZHeUI5cjF3bWUvVHF6SmtjS0VPc3Bx?=
 =?utf-8?B?NTBZT2ZoVGlaZjJ1OGExTXh3MXFMa054QysrVWdCaGorbVlzbnJWU1duYnNL?=
 =?utf-8?B?TDQ1VjdOMFdpd2VLNWdFaGdsd3VzTkYzVXp6ZkxtUUkxZjNxSys1bE4zWVl5?=
 =?utf-8?B?OFhuY1E0SmNRbXJ3Z0wrWUVjaEYvaE9Eaml4QklMNjFOdVNEYnAybVArdGtU?=
 =?utf-8?B?T2V4d0s3T0VUVGRWYW94cmVzeUNYN3cxODJzbVlXSkxjRVBUdGNNbUNWeGNo?=
 =?utf-8?B?TWdPQkhaMmV4alFzc1NQL1UxQWwybFdWc3kvRUdFb3NPbDFyeWZmMGlYMUhU?=
 =?utf-8?B?WGtJWkE4WnFPbW8yUlFHYzZJNEJlY25mQzJqUWt3czVtRUtVUEIreC9iaTNl?=
 =?utf-8?B?a3N6R1k2UzB1aGludUxOK1pRVFFDWld2UUl3MjUwY0NsRTFCTnBSbk11QXlW?=
 =?utf-8?B?Vld6eTBSN29vMnFSdFpmV3p5ZTlUZU5LdmgrM3dGazJRZGpVaEgrZE9IS1gw?=
 =?utf-8?B?SHhCODlsclgxcCtGNVhsOGZPVXdGbkw1TDYxMHJSVnJoM2xXcGZKVDNCdnhI?=
 =?utf-8?B?QkFCMXZVTkYwSnloWHhrTlducFdSck91S082N2xadCsyZ0Fxdzl3blNMVVJT?=
 =?utf-8?B?Q2lhNHJYYWsxQlU0QnB0Q0xUNzNERlNackZSVEVXelY1dStZdU4zelBvMUhK?=
 =?utf-8?B?UVZUam5TMGEyWXp4UHB3WEtYcHBWdWQ0dlh6d0pocElZM1lKazVNUW1xQXZL?=
 =?utf-8?B?T00rWUR4U2tHMGs1S3R2aTRFZTV1cVhQYUdtcW5NZ1VHTnZkZUxqSVhJNXdU?=
 =?utf-8?B?dXhJQkNzQmRCNXFNUGhaSTJ6TERnUUJLcW5vR09rdDE0NFVHb1Y4bndBNlVk?=
 =?utf-8?B?RXV4MGdOSWl1c3ZmNzVoaU9aOE9XVTh6TUNENWs1by9obGRaaCt4T2Y0bjRL?=
 =?utf-8?B?MUt0V2FmdTUxR1JXV2RpMDFvZDdQbW1qWG4yRlV2ckhJTlp2VzViUmRUVGFn?=
 =?utf-8?B?MUFReEhlR2hSVnVLZUhodXhTNzFVOUNrVFJXOW14ZGF3aDFpS1NqOTBRRGov?=
 =?utf-8?B?K2ZlRmxZRkpQMVkydG5NWU81b2NGS0Mxa3pmZldWMUVqVzRHQStGRWZZTko1?=
 =?utf-8?B?NTZhVis1bWprTFIxcnlrQy9KUi9rYUJHcDRtNGYzNEZrTDg0ZXBiNzFHS3FM?=
 =?utf-8?B?aDNUdTFMRGF4ZEVIMDJ1R3BWSTVpTTVIT0hzS3hHVDlWMEoyYWMzYmgyMG01?=
 =?utf-8?B?d1l1Y0lHcDJWTFAzQVNwSUlIdUU1Njd1S2FWV2xtZUE4bG13YW42dWNZbkFK?=
 =?utf-8?B?eHh4TFFGaDZGRTJhdEU3UkFXMUJVSm1QblJ3cHZXUllZUG9KQU12bTg4Ymk4?=
 =?utf-8?B?ckptdmN3aFhmQ1hVMjQ2akl3TzNhR2Q0WC9pQXRQMjBXMURxd0s0NStZUDJm?=
 =?utf-8?B?bmdSYkt3MFdoNUxENzhob0pVbWgxaDNFUmdxeTU3R2JsUTV3MFlIbXNrRVN6?=
 =?utf-8?Q?A2D/aB+LnAc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkRKZWllamZHdFMvQm10d1VpemRxWG1RQ20vSGhtZ1pKM2ZlSm4wMDNUelhH?=
 =?utf-8?B?L0l0VmVxdUo1d0R5TnNmemFpSkxubmMzbThDcjJIYXdjbENQalM5VTRNK3pV?=
 =?utf-8?B?b3JCaU54SXRMNHBFZW1YUzQxTEFzYkhGU0ZUZGRKbWgzeGxYMUlLL3VpaHQ4?=
 =?utf-8?B?NzcwY3Q4N3dQOEoremVaL0JHUktnQURTblU2MENxbG1aUEd4V1BldE5VY2Jy?=
 =?utf-8?B?MU5pZWxJT09oQjJPL25rdEVlWmZJRXlQQWxBZXRKOUZTK2tSdVQyTmRkODZQ?=
 =?utf-8?B?SWFvTm1OL2gyQk4rRzkwaGplUU9hLzR1dnlkZEw2R0EvSlJUNmZqVkZiYUtI?=
 =?utf-8?B?OVpndXlrd1FWMVU4RWhXWUJHeWZidmh4ZzBRbUFiWXIva3QzRFczVVJVMy9r?=
 =?utf-8?B?em5zN1lZWEtNL3FTVnBRNlZmUENmZ0NVOG1NdUwxdnpaMWpjN1QxZFY2VjlJ?=
 =?utf-8?B?MmVjR1ZSbzlVdmg0OEdMcXd4alBoR3BSVnpVeTIzVWM0Tmx5NjFEUWlCMGY4?=
 =?utf-8?B?KzdocHdnSTF5THpxcC9YMlBzRE93NnRRanZPTkd5eG0yVVY4UWFrSDllbGxY?=
 =?utf-8?B?RXRLMHh4WXJFL2RLNVhrTitZT0pzY1VSNStMelJYWWczN0tFL1FWNUtCMVFL?=
 =?utf-8?B?U040bHgzMHJHRm1ZMXAwOHUzTkk3SCtHQWtaVTlrRGJKcmc2N3RSR00va0tE?=
 =?utf-8?B?NmdwNS9oNmV0ZlNYTDZmSHh5QW1BakFIL21adFpDRysxc1FlYUR5d0FGbEtN?=
 =?utf-8?B?dkxJYlcxZ0w1eDhiZlhuYWp3R1l0d2NENDkrQUxqaGZ0cFRUc3hxYllqYURI?=
 =?utf-8?B?MGZwSFBSa1hKUG9jc00rcGRqengySUJOYlBoSzc1OTFVS0VEcG5NejUxUEl5?=
 =?utf-8?B?RTJwSytvMGh5NG43OFcwa1l6ZmNYdUdiVXRmSi9SZlJIOEszVHhiK3haQmpx?=
 =?utf-8?B?SHZ1dWoxQ0JocndtbDVhYlIyQU9laGJFS25oUXN5SUNwbjhSazgxQjEvdDk1?=
 =?utf-8?B?cjF5MmtnbUNtcUZZQWZBOVVKMGE5WVk5NnNvbFBXSTJ6WGV1U2twVEhhWHJu?=
 =?utf-8?B?N1ZOQVRoU1V1Rk9sWjZoOStHZWF2d0NJN2N0UW9CUERaNGF2Uk5iY0N3MXE5?=
 =?utf-8?B?a1lTaWd4RkNET290aDNlTnNDYjY4dnQ1ZTRGVEtXc2RtbUFqQ1lMY0hQVUls?=
 =?utf-8?B?bk9LWXg4OGZWMkdoOWhUbVhwcGlNbkpONkNRWFhzVTQwRTZFUGtwYmNlQWxV?=
 =?utf-8?B?Y3lqNzNUS0FGNFo0aGhIRm9uTkRBT0tXTmJIbXBkNzJDK0M3ekFDNlkrQmpH?=
 =?utf-8?B?a0dScmtLZkVDS1ZMLzFteXdZbDhtOHBMa0dZMkwxV2hSRjJwYjVvdDJLdjVw?=
 =?utf-8?B?a1ZIV0VJYUtjaHkrMUpuM3cycExTRXBiYjhnbFJ1U2srWHlsY3ZjZXhNaUo1?=
 =?utf-8?B?emJRMjBsalFjWFV6blhRT1NqSGVVT3lvUmdYU2JPMGdBNitKQk12NDhTazYw?=
 =?utf-8?B?ZnRDQlNaVTlJU1BGdGhoQUNib1F6MC9uY05jeC9rVmx6MndJcm5LTktkajlS?=
 =?utf-8?B?VFlWUnV1WkJFWm5LNkIvQkl0a3diUVlXeHVpb1k2U0VXTFZ6aXEwOU5VeklX?=
 =?utf-8?B?YUEzSnhrY25tTHVSYTZScmRYcGxNTE5UNThXbDlaVFJvcHQrbTc0Q3BhUW5r?=
 =?utf-8?B?WHhYb2VweXlMTWdWYVBnd2JFVUNrQjErMmFCeDdOWUhjc0xyaTBpWldrQldu?=
 =?utf-8?B?aS9ZQTA3ZG1IcDVXRnlMQmRHY0F6a1JxWGRpUnVGbnd5SVBjY1FnR3lBcnpL?=
 =?utf-8?B?Vm1yL3M2SnJFem4rU0c5S3EvTWVXaldPZkVmUjJZOEFiMUdMdVlTNzhpSkFU?=
 =?utf-8?B?eXhpdmdiRExIelpYZGxja3Z6RDJOR2R1eklib3lNSnJhaWY1c0NGOVBVbU5F?=
 =?utf-8?B?bUZlbkptb3dreWhVeDM1RThkSkkzSlpraEhOMGlWQVAvVnVrNDNtRXA1cUpP?=
 =?utf-8?B?enl0OU9Md1NDMnZLRWluSG5HMUYyNUxNRWRKNStoczdmMEltQlNJMUxhWFBI?=
 =?utf-8?B?MWxLaUIrMExUa2lMU243c2dsNi8rUkJtcDh2TlE0aXgvRW1nYysyYTZhbStG?=
 =?utf-8?B?VkpleWxIM2wzYzMvU3dhNTRXVlArQ1BkRi9FRjBtMmJCY1hQTVdURjRDVFRS?=
 =?utf-8?B?SUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: afb38662-bf21-465c-66e4-08dd81aa2d57
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 14:30:06.3279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xi9YrfPeAFZSwg6VmIvGolEh2FcnuSSWR1fJbWGhE+d/A+9EtRYvkL/2NEJ45/YLcVQObF9034Gv5nAqGOFhOObAWkoSlnwLcYc3mQGkQNA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10550
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

Hi Andre,

On 4/22/25 2:11 PM, Andre Przywara wrote:
> On Tue, 22 Apr 2025 12:49:40 +0200
> Quentin Schulz <quentin.schulz@cherry.de> wrote:
> 
> Hi,
> 
>> Hi Andre and Yixun Lan,
>>
>> On 4/21/25 11:29 PM, Andre Przywara wrote:
>>> On Fri, 18 Apr 2025 13:28:23 +0200
>>> Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>
>>> Hi Quentin,
>>>
>>> thanks for having a look!
>>>    
>>>> Hi Andre,
>>>>
>>>> On 4/17/25 2:05 AM, Andre Przywara wrote:
>>>>> Some boards with Allwinner SoCs feature a "FEL" key, sometimes also
>>>>> labelled "uboot", which triggers the BootROM FEL mode, when pressed upon
>>>>> power-on or reset. This allows to access the SoC's memory via USB OTG,
>>>>> and to upload and execute code. There is a tool to upload our U-Boot image
>>>>> and immediately boot it, when the SoC is in FEL mode.
>>>>>
>>>>> To mimic this convenient behaviour on boards without such a dedicated key,
>>>>> we can query a GPIO pin very early in the SPL boot, then trigger the
>>>>> BootROM FEL routine.  There has not been much of a SoC or board setup at
>>>>> this point, so we enter the BROM in a rather pristine state still. On
>>>>> 64-bit SoCs the required AArch32 reset guarantees a clean CPU state anyway.
>>>>>
>>>>> Any GPIO can be used for that, the signal is expected to be active low,
>>>>> consequently we enable the pull-up resistors for that pin. A board (or a
>>>>> user) is expected to specify the GPIO name using the
>>>>> CONFIG_SUNXI_FAKE_FEL_PIN Kconfig variable. When this variable is not set,
>>>>> the compiler will optimise away the call.
>>>>>
>>>>> Call the code first thing in board_init_f(), which is the first sunxi
>>>>> specific C routine.
>>>>>
>>>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>>>>> ---
>>>>>     arch/arm/mach-sunxi/Kconfig | 10 ++++++++++
>>>>>     arch/arm/mach-sunxi/board.c | 31 +++++++++++++++++++++++++++++++
>>>>>     2 files changed, 41 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
>>>>> index ab432390d3c..f1cfdb548bc 100644
>>>>> --- a/arch/arm/mach-sunxi/Kconfig
>>>>> +++ b/arch/arm/mach-sunxi/Kconfig
>>>>> @@ -825,6 +825,16 @@ config USB3_VBUS_PIN
>>>>>     	---help---
>>>>>     	See USB1_VBUS_PIN help text.
>>>>>     
>>>>> +config SUNXI_FAKE_FEL_PIN
>>>>> +	string "fake FEL GPIO pin"
>>>>> +	default ""
>>>>> +	---help---
>>>>> +	Define a GPIO that shall force entering FEL mode when a button
>>>>> +	connected to this pin is pressed at boot time. This must be an
>>>>> +	active low signal, the internal pull-up resistors are activated.
>>>>> +	This takes a string in the format understood by sunxi_name_to_gpio,
>>>>> +	e.g. PH1 for pin 1 of port H.
>>>>> +
>>>>
>>>> Why not use the DT for that? Then you wouldn't even need to assume the
>>>> polarity of the signal or whether pull-up/downs need to be activated, etc.
>>>
>>> As Yixun Lan already pointed out, the DT is not available at this
>>> point, and doing several pull-ups to get this information from the DT
>>> into the SPL image are really over the top for this purpose.
>>
>> OK, we do have something "similar" for Rockchip boards, via the
>> sysreset-gpio DT property in /config, see
>> arch/arm/mach-rockchip/rk3399/rk3399.c and
>> arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi.
>>
>> I guess something similar could be implemented IFF there's an actual DT
>> in SPL (or even TPL). We for sure have DT in SPL for most if not all
>> Rockchip devices, and probably in TPL as well. Hence why I sometimes
>> forget other Arm boards may not have DT in those stages :)
> 
> Yeah, I know, there is some push for DT anywhere, but it would be quite
> some pain for sunxi, for very little benefit. We are very tight in the SPL
> code size for some SoCs, up to the point where for instance enabling this
> code here made the build break on some SoCs (I found something to free
> some code space elsewhere, might send that later). So pulling libfdt and
> DM code in would require going TPL, I guess. But I don't see the reason,

We are also very limited on some Rockchip SoCs, see PX30 which has a TPL 
without DM support and where adding a printf (there are already some) is 
sometimes too much to fit into the SRAM, so I understand. We do have 
some other SoCs that have DM enabled in TPL, e.g. RK3399 imply it.

> really, as I tend to see the SPL more as the continuation of the BootROM,
> which manages without board specific knowledge at all. And for the small
> bits of info we need, we can happily use Kconfig. Most of it is actually
> SoC specific, not board specific, so users don't get bothered normally,
> and it just works (TM).

Jonas has started to support "generic" images for Rockchip boards based 
on the recommended hardware design specified by Rockchip themselves. 
Most companies do mostly respect it, so that seems to be working quite 
nicely.

Depending on what exactly you want to support with U-Boot, a DM-less SPL 
may be difficult. e.g. if you want to support a fallback storage medium 
for loading u-boot.itb (or proper, don't know what's being used on 
Allwinner) that differs from the one used to load the SPL by the 
BootROM, then you possibly cannot rely on the BootROM initializing the 
PHYs, controllers, pinmuxes and pinconfs. KConfig may be usable for this 
but that will make things cumbersome to support.

> There is tons of work and cleanup to do on the sunxi side, and were
> already have quite some backlog, so I want to avoid introducing more
> construction sites.
> 

Fair, it also doesn't mean that what's currently added cannot be 
migrated later on :)

[...]

>>>> You can have the property in the -u-boot.dtsi then if you want?
>>>>
>>>> While the FEL button on the X96 is "fake", it does what it says, just in
>>>> software, maybe that is close enough to "hardware definition" which
>>>> would make it suitable for the DT (well, we also store binman nodes in
>>>
>>> Yes, I have a patch to add this particular button as a GPIO button into
>>> the DT, so people can use it for whatever they want in Linux (trigger
>>> reboot, update, you name it). But this is rather orthogonal to this
>>> problem, as mentioned above.
>>>    
>>
>> Mmmmm but this will be in the Linux kernel DT and I assume you want the
>> same GPIO to be used in U-Boot and in Linux, so it would probably be
>> best to make sure they stay in sync? How are you planning to do that?
> 
> On the Allwinner side we were syncing the DTs regularly for years already,
> and had no conflicting or different bindings at all. So I prefer to think
> of "the DT", with Linux or U-Boot just carrying slightly different
> versions for some time.
> 

If the kernel DTB is coming from U-Boot, it should be much less 
difficult to keep this synced. But if it isn't, you would need to patch 
it live before booting the kernel for example.

In any case, I think the conclusion is that DT cannot be used (yet?) for 
that so this thread is now essentially just me being curious :)

Cheers,
Quentin
