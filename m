Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26ECED41173
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 11:21:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1994883015;
	Thu, 15 Jan 2026 12:21:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="EUwxah5t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C4B883623; Thu, 15 Jan 2026 12:21:04 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 277CA80325
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 12:21:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BwWrv+cp8NguwQ24RvCHbLH9driXNZJP1ritINO878AmTbOwlM3LQjrn3gpPGGnoqOxJKHZmxO26As6iyjXbWopGe12oUxcrPFLAP4m08iAT8mbOhreZLKTsqqX2SNVALRgI0YHKaiilXZyXEybBAa/8UqGu8F7e0IxIYFi6CYoMRqjMDuPneYtxtGmisHLS4HbEcVyHGWPaSIr5eZFS1xTx8qLdW/rK4B8+5dReycfd4QJ6hseh8R4VbtqG+5Ine2bQ84vQd//FxhzImPLkbKJJzHwvJJbFKDZLCdWez/ONgLVSmrIFkhPXfZaDQLGC1HbZ31hucGKIiYZy79Dr5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HC3K3c/90G+8VQlXqnUR+stZZwADrYLt4PhKPGAW3g=;
 b=u1igkkpz67kSPVovqo68RU17r0lGymcjSuR+dxpMUdA9C4xywY3FaHkIUN0Dur+kIRpGn5ZgO0KMuHoajw/eJt6JZkDcVY1CNworrbO0m12x1BI6ZwHTyxeO+6FPvqfMlNH27Ob5ihjtsbR2stdDD2RskPVgpojgY54/Jyow6dFVxkD8eVunKb2pjd/NGr3YqWFERtrHnG9Vln4jowPRji7n4/P1+CkGlGRZptMpCSu+fUpGByVUhYibhYl8+DKLKvIfV0Tk0UOkRB42vBYZxsd28v0mL7PpzUSR6kc7XcQ2JJU97vc1NnE0WuBVhM0cuvTGPdn7kPvuPTi1gdmy3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HC3K3c/90G+8VQlXqnUR+stZZwADrYLt4PhKPGAW3g=;
 b=EUwxah5thOYLb4JMuuFA/opMcM6+UpteCOYlKXRx990sjs0SL2OrCvFT1Mg0gpBBWkde6ookqTxBdae5XqqzCHD2LIN1ySozsbCKFZ73iPZadzBVOaqh73aqaBIbcbWFAKUlNxYJUa8voHwvhhwulPX+MI6+4Krlxj9yKVW2WwM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI2PR04MB11075.eurprd04.prod.outlook.com (2603:10a6:800:27a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 11:20:57 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 11:20:57 +0000
Message-ID: <eebc8fe5-5622-4816-aa00-867b52fd08fb@cherry.de>
Date: Thu, 15 Jan 2026 12:20:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] rockchip: Add initial RK3582 support
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20260107230747.3552391-1-jonas@kwiboo.se>
 <20260107230747.3552391-2-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260107230747.3552391-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0265.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::14) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI2PR04MB11075:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b4dd0dc-1c9d-41e8-c05b-08de54282781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NVVDSGNELzdHc3pxVlVmSHYrN0FIVjZMVGFEN2dPWER2dEYvMjBUY2RiUTRG?=
 =?utf-8?B?V0FQWjh6Z3hKZnVQWGx3YmJRRUxScnltckc4REdRTEd0cDkwNDY5akxpTmNN?=
 =?utf-8?B?WE9DU0wvNU5MZXlpVzJLSFJtZjlDTWZ4bEI5YTFkM1ZRbEVDcXBZM0NvSTgv?=
 =?utf-8?B?WmlRbVNCekx5cGJGdlc2WU8yNHRuMC9vaVY2ZUNST2hmRldKcHFpaStWckZW?=
 =?utf-8?B?Y0Zzc0FZTDE2cWY1MFBpd1JwRU1iZVB1aGVIZWxSNXJsanVLVHdPc294eG9m?=
 =?utf-8?B?Y01McmtFN04ydUNwY0JKeitNOTF1SnhnVGtrVmpQd0JXUXN4RnE4cXYxY0I4?=
 =?utf-8?B?blZ5MlBNMHFnT0U2aXpSMGlDdDcrRFZkSEpWQWJQT1g5eUpRU1RIS1E1ald2?=
 =?utf-8?B?dU5QWUFHR1lsOHI5Tks0QWlIb3ZHOHFjU0dob1B3QVRQbnR4QXA2aldudnlx?=
 =?utf-8?B?VzBRdFczRWNsRGliVXZ3Q1Q2dmZ4YnhCOVVZd09EdjJHS3BLRHYrVFZFZ3Rq?=
 =?utf-8?B?Lzg0N0d4a0FCWDREaWwwQlo5ZjRmbDZuWGNJYzZKNE9wQVFjbDZ1akV1ZDZX?=
 =?utf-8?B?ekFiMmFkcmljRVlZRnIxd0g0V2lQbWlGbnBEdFhIaEh5a1J5dVZHWDhaWld5?=
 =?utf-8?B?SXgwdEs2VmJpcjJDUWNyM2tmRDJaWVdHTUlKZStGQm9YSzhJMHpBaFJWOTht?=
 =?utf-8?B?enliMVlUZFN6NjhKakdOZTNnYTJscU1Ra0dOU0ZCWFcyK2dGeDE5UFdzb1lV?=
 =?utf-8?B?YkdjV0RYQmxjU0xJbWZqZHAxVWhhZ1BpZEkrWCt6Y1QzZVdZc0dycWgrZzlz?=
 =?utf-8?B?UURsUmdxZHdhRnI2S0xSVjhLOEI0aTVhbVFVYmc5dGRHWE9Qc0s5QmRzTFpT?=
 =?utf-8?B?VjIvc1dlYVFrZkV2Y2c3MjluQzNiS1FDWkZlRFp1Tnkxelh3bmx5Y29OWDhz?=
 =?utf-8?B?dzhESW16R2ZrNzFnRzVQMzFlMXpBdS9RN1RnamhBa0ZaTFBreTUzUHRzb2dH?=
 =?utf-8?B?cGhYRWZRY1NkeHkrR1p4eDRBdi9sZm83SjYzcXJhWU1LK1V3eHFxVXBadVAy?=
 =?utf-8?B?dWpGakY4anMzdVJtMGc5VDEyWDRtS2lVY0x0ZVV6UEgwbTZXMXZTZ1l0QnJO?=
 =?utf-8?B?U1daMTBRU0tONjNwZThNenhpUzNEdEhVN0dJTFBmK09yb2ZhSGNmaG9EL3h0?=
 =?utf-8?B?ajdDbnNDNk14eXNJNmdxN0VWTEtsRVhuU0pRcnlPYnpUQ0JBVTdDSDJhQTJZ?=
 =?utf-8?B?ek0zR3FlWm4wWW85b3FQMzY2VnpMRFhkaXFIMGpQU3IyU2NFTnNpNGZ4Uldy?=
 =?utf-8?B?WkZoY0h4eEtUMDVDNWExclo5QlJXblF1SkxvRDVOQ2xOQnkxczhMSUM5UTV1?=
 =?utf-8?B?NUFQYjBSazNIOGJaYkRMekdHK0VKSVVPRGNnY2NTSEVBbDlVbnNmZWV6TmNR?=
 =?utf-8?B?UG4xd3U5Z2VCZ2tKT3QxSDkySVFkVHYzWTRpYXg2Ky9JR1BtUStYbURkbnBO?=
 =?utf-8?B?WkZYSlF1Wmo2dFZITmFEWjNFZEQxUDJSWmJSZGE5dTB4NHh0eDFFOFhLK243?=
 =?utf-8?B?K0dPTG56NUIxWXpDOXRleGZjekpxZS9TN1E1VmVPRS9ZZ2hqeUhDOHhySU13?=
 =?utf-8?B?UHdydHQ4eUdnSUowMUZyNC8xK1RNVjAxKzA2bDdlTlQrUXl0OXUzc3lnT3VN?=
 =?utf-8?B?VEIyc1hJeXZrbnNjTEVPT0pDTk5PYTI2SENvcml3Z1RGNXJvR09EOUtiUExi?=
 =?utf-8?B?SVNUNWF4MDB6dE9tYzJ3b2pjSGlWN3pMMExUbkgzbThVWGVYMDI2MnY3cmJV?=
 =?utf-8?B?WlVRVVNLQjIraUdvY3RvakxQdkpaMVhZVGZyNytoeFNvWk5LYzhyTmo4S2V5?=
 =?utf-8?B?L2NPMmFWK0ZSejczYlZ3RHhGV2l3ZnppaGpLTUpDVk9JU1B5KzYxajBzVWh6?=
 =?utf-8?B?VEEyUjNza0FrTGFNQ1pGK0pmSUdUaTBVZVdjMzdmTnZDalIwNm8yblo2L1k2?=
 =?utf-8?B?c3REL2hSRkdvclUvcG51RnI5VHF0cTVmMnZFY3c2aHNjWENOQ0hySWZic0JI?=
 =?utf-8?B?NWU2TVFsaTdGNDhpTWhRYjR0SjJCN0RoZ0IxRmFjMXBHZVNsRWtSNm0rMi91?=
 =?utf-8?Q?Q3bw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzE0WDhJZXVsNjBEby85S2Y0ditLR3pEQWtpNnVkN09QelhHcXROVG9ZdFVo?=
 =?utf-8?B?RTkwakRuajByYS85a1U5cWIvektpUC85cE9ybWpZbHUxb1pSNHE0bUE5S284?=
 =?utf-8?B?UjdRU0xKL0h3R0owMFJVQ1NjS2hkY2hVWUtqaktUclMwc1dWYjE4T0ZoZFZG?=
 =?utf-8?B?b2VhSGwrVmVCK3dpMDRLV3dqSGhVNmFEVVZsMnRadzYxREdtNDN1RXJaRm1V?=
 =?utf-8?B?aWgrMVdlTSszVXVxcnI5cC9tMjRtVnUzTnNpeDdlb0ZvWHllcDhNTHNGUWZm?=
 =?utf-8?B?LzVlRWpnZ0tMSHhWdWtFOG0yZDBZdkdvcXV0WUtoZlFJT2dCeWVNOUszRWxn?=
 =?utf-8?B?Y1A3ZU1MTGlqcTFMSlg2NjlFbmZFTGtseGRlWSt2cXlUR3lxNUFKY2d3ckQx?=
 =?utf-8?B?dGZad2MyWjIyU0VGQkZIKzk1THY4d1VQOFRmWFZ0QlFjODUyNjU3NzJCZkps?=
 =?utf-8?B?M2tRTDcwaE9ScW1Qc2xPa2FBZU45bTl4MnlWR2N4ZlR1WDUxcWVnRTJxbDFO?=
 =?utf-8?B?QXgzQ3Y3TXo4NjBnNzRPcEQ3THRrWjBnZXlZT1FsbmVoQko3VUVCallocWhB?=
 =?utf-8?B?QXdvZGRZdU1sdWdxTmROdnZYeGJTWi9EdzJVektMUXlwaGhscUdudk5GWDlj?=
 =?utf-8?B?RFhZTVpBOWdycGtmbFVmNFZtbmwxcHRFRE0xTVRCQTlIbmZ6SWFBY1MyZXNv?=
 =?utf-8?B?SGxDYmxybG5QOUVRR0gyZjJIZFFzMmRCWVhRRHF4aEhGdzY5TXhEU2tuTTEz?=
 =?utf-8?B?dngxVFV1SVcya2t2dFVyTlZwa1pYZmN1WE9nYUYxdVNTdHk2V2J1c2V5bjA5?=
 =?utf-8?B?MW5NZHNidDREUjZEZjVMemN4bkowcTQ2TEc2RXhmRkVkOXJQdFlnNGVHL3N6?=
 =?utf-8?B?dkNRWjkra3doeTNEUk1vSTNQaVpSMXNaZjJnQ3dvTG5yVmIvdUZURnVOK29R?=
 =?utf-8?B?TlJ4Q3F0Q1NkaWhiaUo5TjVhNW9jUFRBTGszMjJyaU91MGJEZkF3VGtrM1BJ?=
 =?utf-8?B?aUNlbTd4RWhaWitmWk1BY01CcHQ2TktRM25VdGd5ejJ3RnlLZWlqS1NHVHQ2?=
 =?utf-8?B?SXAzSFFzbEhKL2h2c2I4cFFHNEJHU2RsOWhtWHIzRE1aVDBucUhYcE93dVJZ?=
 =?utf-8?B?RUVsRFRqSVhmelVDemYyRkVKbXVxbWljTkY0RkVQL01CMm5GcnZ3dkkxVTNH?=
 =?utf-8?B?YjArUUxLT3plV2hVU1RsbjdFaGJ5ZlduZHMzSVNCSWE1dHAzd1Y4bWhWbTVT?=
 =?utf-8?B?TUVkU1l2bFpOSVZBM1hNcGd6dTdMSENKb3JzSE1ka0VVNGc1N08xVU1uaGlM?=
 =?utf-8?B?Qi85cCtFOFpGUCtGbXNNeFpGb2JHc0Z0UXBFMzZnajlRY2FvT2tnQUFkTG90?=
 =?utf-8?B?NG8yRXhSalRLN2ZBcU5vOXkzTS8xaU1ySWdkekFrbVpZRzNlbUJBb1RMeE9L?=
 =?utf-8?B?cFArby9iVUhPNlM1aFNlclBsQ0U5ZG92Q1lYNGFiSkhqeUxXekVXRWFkY2Fv?=
 =?utf-8?B?NDZTMDFRWE5uYUJ4d25MUTVxL3cxUjY2Y0svQlhtY0xzVXpEZmZlZGRNZ0c4?=
 =?utf-8?B?aDFIWWNlSEFOMnk5L0tndXlob3NXMzEvYitsaDJRcDkvczRtclhJY3VacWNB?=
 =?utf-8?B?TE5VSVF2SXRrcGdyWUQybXlEd204Uk42VkN2MWc3RkRsdElRWVFwT1I2MFY3?=
 =?utf-8?B?V2xjNktjdkRWOFlOaG9NWVp6YzlScE9QSnBEMm5LMzU5dDVLZGJSL3JCb3Ew?=
 =?utf-8?B?YUVSVTBWZGh3UlI5T0NvKzZsbmVMQVM1MnN1QmhEK3ZMOHV1NklEUUp0TGRl?=
 =?utf-8?B?Y2V2cy9Pbjd3bkRsakppNE9UQ2pYd3I0U0h3S3lIVXZ5aTZyYU13L2c2QWxG?=
 =?utf-8?B?ZWdMbmFnbGhBaUpYOW1nMGcwNUtUZmxLR3N1WUo4YjhRYTBIWjFtUm1CeWhG?=
 =?utf-8?B?bGpWTUxJWXVnVm1ZeDRIT3FoL0d0SkdYcWNONGEwWTk0K3ZEQ2xDRXVFY1hq?=
 =?utf-8?B?dTJxZjdsZStBUm1QUmNkbUxBRTM0eGFYVG1iOGRtcHV4akQ2RE04L3RDQy9Y?=
 =?utf-8?B?bnh2UkQyY2pNdGlReGVIWnFNNkFMeGJGaGZXejlXV0R1VkJCYTgxbjFBRWNU?=
 =?utf-8?B?ZW4xQ1QvTklhc1luREduOWhScDc4aWgwTDM5YTZHSWdObms5RGFBakcya2xq?=
 =?utf-8?B?TnVsODZZMlc3K1Zoa3NOK09VcThsSi9ERGxsbkFSU0MrOGNBRm0zazFuSXRp?=
 =?utf-8?B?R0RhUE4rQ2J4UTk4QVZCMHl1cEpVNWFHeEY0YWRvWVpSRU5NSktSbXlraTl3?=
 =?utf-8?B?b1FPMWJBN0hwS1hiUTh4ZnE4M1RoYUVvYWUzNWpPM0RPNU12TGlldz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b4dd0dc-1c9d-41e8-c05b-08de54282781
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 11:20:57.2411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QPwAg8WdRzD/TqMQnxxFWjMr5gObDjCjJWIT1QRPU80AMzPRQWz02JOBWb6o5+Z54vNpTiPX4K+dDabh51Ecs5u40IpKTxx7NyiedRqC0Xc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11075
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

Hi Jonas,

On 1/8/26 12:07 AM, Jonas Karlman wrote:
> The RK3582 SoC is a variant of the RK3588S with some IP blocks disabled.
> What blocks are disabled/non-working is indicated by ip-state in OTP.
> 
> This add initial support for RK3582 by using ft_system_setup() to mark
> any cpu, gpu and/or vdec/venc node with status=fail as indicated by
> ip-state.
> 
> This apply same policy as vendor U-Boot for RK3582, i.e. two big cpu
> cores, the gpu and one vdec/venc core is always failed/disabled.
> 
> Enable Kconfig option OF_SYSTEM_SETUP in board defconfig to make use of
> the required DT fixups for RK3582 board variants.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> Changes in v4:
> - Update policy to always fail gpu for RK3582
> - Drop code and comment related to RK3583
> - Update rkvdec node name to match latest mainline Linux DT patches
> 

Should we really patch the rkvdec nodes if they aren't stable yet? But I 
see this is something I already reported on v3 and said it's up to Kever :)
Should we support booting downstream kernel with (I assume) its 
different paths?

> Changes in v3:
> - Apply same policy for RK3582/RK3583 to match vendor U-Boot
>    linux-6.1-stan-rkr6 tag, allow use of the GPU and one vdec core.
> - Update rkvdec node name to match latest mainline Linux DT patches.
> 
> Changes in v2:
> - Refactor code to first apply policy to ip-state and then fail cores
>    based on the updated ip-state
> - Add support for failing rkvdec and rkvenc cores
> - Append soc compatible to board model
> - Not picking up t-b tag due to significant changes to patch
> ---
>   arch/arm/mach-rockchip/rk3588/rk3588.c | 215 +++++++++++++++++++++++++
>   1 file changed, 215 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
> index 6324c6f12867..c1138ffcb87f 100644
> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
> @@ -7,6 +7,7 @@
>   #define LOG_CATEGORY LOGC_ARCH
>   
>   #include <dm.h>
> +#include <fdt_support.h>
>   #include <misc.h>
>   #include <spl.h>
>   #include <asm/armv8/mmu.h>
> @@ -240,6 +241,16 @@ int rockchip_dram_init_banksize_fixup(struct bd_info *bd)
>   
>   #define RK3588_OTP_CPU_CODE_OFFSET		0x02
>   #define RK3588_OTP_SPECIFICATION_OFFSET		0x06
> +#define RK3588_OTP_IP_STATE_OFFSET		0x1d
> +
> +#define FAIL_CPU_CLUSTER0		GENMASK(3, 0)
> +#define FAIL_CPU_CLUSTER1		GENMASK(5, 4)
> +#define FAIL_CPU_CLUSTER2		GENMASK(7, 6)
> +#define FAIL_GPU			GENMASK(4, 1)
> +#define FAIL_RKVDEC0			BIT(6)
> +#define FAIL_RKVDEC1			BIT(7)
> +#define FAIL_RKVENC0			BIT(0)
> +#define FAIL_RKVENC1			BIT(2)
>   
>   int checkboard(void)
>   {
> @@ -285,3 +296,207 @@ int checkboard(void)
>   
>   	return 0;
>   }
> +
> +static int fdt_path_del_node(void *fdt, const char *path)
> +{
> +	int nodeoffset;
> +
> +	nodeoffset = fdt_path_offset(fdt, path);
> +	if (nodeoffset < 0)
> +		return nodeoffset;
> +
> +	return fdt_del_node(fdt, nodeoffset);
> +}
> +
> +static int fdt_path_set_name(void *fdt, const char *path, const char *name)
> +{
> +	int nodeoffset;
> +
> +	nodeoffset = fdt_path_offset(fdt, path);
> +	if (nodeoffset < 0)
> +		return nodeoffset;
> +
> +	return fdt_set_name(fdt, nodeoffset, name);
> +}
> +

Wondering if we shouldn't have a name that is a bit less close to what 
you would find as API in include/fdt_support.h or libfdt? SO there's no 
confusion when reading the code where there are callers to this function?

> +/*
> + * RK3582 is a variant of the RK3588S with some IP blocks disabled. What blocks
> + * are disabled/non-working is indicated by ip-state in OTP. ft_system_setup()
> + * is used to mark any cpu, gpu and/or vdec/venc node with status=fail as
> + * indicated by ip-state. Apply same policy as vendor U-Boot for RK3582, i.e.
> + * two big cpu cores, the gpu and one vdec/venc core is always failed. Enable
> + * OF_SYSTEM_SETUP to use the required DT fixups for RK3582 board variants.
> + */
> +int ft_system_setup(void *blob, struct bd_info *bd)
> +{
> +	static const char * const cpu_node_names[] = {
> +		"cpu@0", "cpu@100", "cpu@200", "cpu@300",
> +		"cpu@400", "cpu@500", "cpu@600", "cpu@700",
> +	};
> +	int parent, node, i, comp_len, len, ret;
> +	bool cluster1_removed = false;
> +	u8 cpu_code[2], ip_state[3];
> +	struct udevice *dev;
> +	char soc_comp[16];
> +	const char *comp;
> +	void *data;
> +
> +	if (!IS_ENABLED(CONFIG_OF_SYSTEM_SETUP))
> +		return 0;
> +

Isn't that guaranteed to be the case as ft_system_setup is only called 
when CONFIG_OF_SYSTEM_SETUP is set? What are you trying to prevent (e.g. 
compilation warnings?).

> +	if (!IS_ENABLED(CONFIG_ROCKCHIP_OTP) || !CONFIG_IS_ENABLED(MISC))
> +		return -ENOSYS;
> +

This means that if one enables OF_SYSTEM_SETUP but not ROCKCHIP_OTP or 
MISC, then this will fail the boot even on RK3588(s), correct?

Should we add a select/depends on in Kconfig somewhere so this cannot 
happen?

> +	ret = uclass_get_device_by_driver(UCLASS_MISC,
> +					  DM_DRIVER_GET(rockchip_otp), &dev);
> +	if (ret) {
> +		log_debug("Could not find otp device, ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	/* cpu-code: SoC model, e.g. 0x35 0x82 or 0x35 0x88 */
> +	ret = misc_read(dev, RK3588_OTP_CPU_CODE_OFFSET, cpu_code, 2);
> +	if (ret < 0) {
> +		log_debug("Could not read cpu-code, ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	log_debug("cpu-code: %02x %02x\n", cpu_code[0], cpu_code[1]);
> +
> +	/* only fail cores on rk3582 */
> +	if (!(cpu_code[0] == 0x35 && cpu_code[1] == 0x82))
> +		return 0;
> +
> +	ret = misc_read(dev, RK3588_OTP_IP_STATE_OFFSET, &ip_state, 3);
> +	if (ret < 0) {
> +		log_err("Could not read ip-state, ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	log_debug("ip-state: %02x %02x %02x (otp)\n",
> +		  ip_state[0], ip_state[1], ip_state[2]);
> +
> +	/* policy: fail entire big core cluster when one or more core is bad */
> +	if (ip_state[0] & FAIL_CPU_CLUSTER1)
> +		ip_state[0] |= FAIL_CPU_CLUSTER1;
> +	if (ip_state[0] & FAIL_CPU_CLUSTER2)
> +		ip_state[0] |= FAIL_CPU_CLUSTER2;
> +
> +	/* policy: always fail one big core cluster on rk3582 */
> +	if (!(ip_state[0] & (FAIL_CPU_CLUSTER1 | FAIL_CPU_CLUSTER2)))
> +		ip_state[0] |= FAIL_CPU_CLUSTER2;
> +
> +	/* policy: always fail gpu on rk3582 */
> +	ip_state[1] |= FAIL_GPU;
> +
> +	/* policy: always fail one rkvdec core on rk3582 */
> +	if (!(ip_state[1] & (FAIL_RKVDEC0 | FAIL_RKVDEC1)))
> +		ip_state[1] |= FAIL_RKVDEC1;
> +
> +	/* policy: always fail one rkvenc core on rk3582 */
> +	if (!(ip_state[2] & (FAIL_RKVENC0 | FAIL_RKVENC1)))
> +		ip_state[2] |= FAIL_RKVENC1;
> +
> +	log_debug("ip-state: %02x %02x %02x (policy)\n",
> +		  ip_state[0], ip_state[1], ip_state[2]);
> +
> +	/* cpu cluster1: ip_state[0]: bit4~5 */
> +	if ((ip_state[0] & FAIL_CPU_CLUSTER1) == FAIL_CPU_CLUSTER1) {
> +		log_debug("remove cpu-map cluster1\n");
> +		fdt_path_del_node(blob, "/cpus/cpu-map/cluster1");

Check the return code and log (+error out?) if there's an error.

> +		cluster1_removed = true;
> +	}
> +
> +	/* cpu cluster2: ip_state[0]: bit6~7 */
> +	if ((ip_state[0] & FAIL_CPU_CLUSTER2) == FAIL_CPU_CLUSTER2) {
> +		log_debug("remove cpu-map cluster2\n");
> +		fdt_path_del_node(blob, "/cpus/cpu-map/cluster2");

Check the return code and log (+error out?) if there's an error.

> +	} else if (cluster1_removed) {
> +		/* cluster nodes must be named in a continuous series */
> +		log_debug("rename cpu-map cluster2\n");
> +		fdt_path_set_name(blob, "/cpus/cpu-map/cluster2", "cluster1");

Check the return code and log (+error out?) if there's an error.

> +	}
> +
> +	/* gpu: ip_state[1]: bit1~4 */
> +	if (ip_state[1] & FAIL_GPU) {
> +		log_debug("fail gpu\n");
> +		fdt_status_fail_by_pathf(blob, "/gpu@fb000000");

Check the return code and log (+error out?) if there's an error.

> +	}
> +
> +	/* rkvdec: ip_state[1]: bit6,7 */
> +	if (ip_state[1] & FAIL_RKVDEC0) {
> +		log_debug("fail rkvdec0\n");
> +		fdt_status_fail_by_pathf(blob, "/video-codec@fdc38000");
> +		fdt_status_fail_by_pathf(blob, "/iommu@fdc38700");

Check the return code and log (+error out?) if there's an error.

> +	}
> +	if (ip_state[1] & FAIL_RKVDEC1) {
> +		log_debug("fail rkvdec1\n");
> +		fdt_status_fail_by_pathf(blob, "/video-codec@fdc40000");
> +		fdt_status_fail_by_pathf(blob, "/iommu@fdc40700");

Check the return code and log (+error out?) if there's an error.

> +	}
> +
> +	/* rkvenc: ip_state[2]: bit0,2 */
> +	if (ip_state[2] & FAIL_RKVENC0) {
> +		log_debug("fail rkvenc0\n");
> +		fdt_status_fail_by_pathf(blob, "/video-codec@fdbd0000");
> +		fdt_status_fail_by_pathf(blob, "/iommu@fdbdf000");

Check the return code and log (+error out?) if there's an error.

> +	}
> +	if (ip_state[2] & FAIL_RKVENC1) {
> +		log_debug("fail rkvenc1\n");
> +		fdt_status_fail_by_pathf(blob, "/video-codec@fdbe0000");
> +		fdt_status_fail_by_pathf(blob, "/iommu@fdbef000");

Check the return code and log (+error out?) if there's an error.

> +	}
> +
> +	parent = fdt_path_offset(blob, "/cpus");
> +	if (parent < 0) {
> +		log_err("Could not find /cpus, parent=%d\n", parent);
> +		return parent;
> +	}
> +
> +	/* cpu: ip_state[0]: bit0~7 */
> +	for (i = 0; i < 8; i++) {
> +		/* fail any bad cpu core */
> +		if (!(ip_state[0] & BIT(i)))

Is this guaranteed to be properly set in sync with FAIL_CPU_CLUSTERx? 
E.g. can I have a FAIL_CPU_CLUSTER2 but none (or only one) of the big 
cores in the cluster not marked as bad in the ip-state OTP?

Shouldn't we check also for FAIL_CPU_CLUSTERx here and disable all cores 
in bad clusters since we are removing the clusters anyway?

> +			continue;
> +
> +		node = fdt_subnode_offset(blob, parent, cpu_node_names[i]);
> +		if (node >= 0) {
> +			log_debug("fail cpu %s\n", cpu_node_names[i]);
> +			fdt_status_fail(blob, node);

Check the return code and log (+error out?) if there's an error.

> +		} else {
> +			log_err("Could not find %s, node=%d\n",
> +				cpu_node_names[i], node);
> +			return node;
> +		}

suggestion: Flatten this into

if (node < 0) {
     log_err();
     return node;
}

log_debug();
fdt_status_fail(blob, node);

> +	}
> +

Please add a big comment here explaining what the below is for, so we 
don't have to guess what the intent is based on the code :)

Cheers,
Quentin
