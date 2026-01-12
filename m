Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A59C9EC77
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 11:54:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F234836AC;
	Mon, 12 Jan 2026 12:54:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0k/yM0CB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F7F7836AC; Mon, 12 Jan 2026 12:54:13 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32315830CA
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 12:54:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3xfs8+UzsytXkOSuyT267CGrStB+42dLiPZ16i6wPnoh6fhlcWooyDru2irvsJ6v2oPPnGZI9KN2k8nGpqU9UVNfexM1oVvzoQjecxV1w9B+/hFKCFujxqjEwFHXA6qsOhrUaDqyj9M6Cf2VHa/1bbk8spFNZIbHb6sAuqXmsSNUfKafWvQiumuMntvauVF4JfFWEf/A36cJtYBL/gxPBBT9wcZM33+9sHdEndEXm/AAdun4ZZycbkg0LkGE1WVFE+qzMEEyjmRzuTs1TKkAOQ//ysdNX+M10Zit/+SLOuGzpM7y6Ycn4ZDR68T+6Lm3KcaIw6cIIpfF5g2ZK90wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6LXs4JBnWRdgqfkn4smf1T6qGInvvaRETLZ6ngRmNFM=;
 b=kXYEqyESlOnRS6kWGe2AVr0Xy0joQp2QpfgXeosPx68v8Je0alS/R4k35PdSUa0bJjoFfSexWKemDf9BTbBB2jhWF1stXeKq/4nQvN9UW1ouQw++b7VjpFYttjw1941350XlFJwWu5rRLgh1vh0GFz+ownirY5B4iYOQ0Oj6g68PtbUF+nvs+ATOtZDAN7vR/Ljta95ATziZf7Y3n7EirTc/zjtAIfyhyv0d8IVuFQF84Qukuk8uHFpQSE6pylGGrQ+bZoAYLOIwuyApJew/Ze4XaeHbKEghqh6WMGcOax3i2TUnHYKmN9UkXp59zQxmA3rDX9/FFK4Brkf441xEEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LXs4JBnWRdgqfkn4smf1T6qGInvvaRETLZ6ngRmNFM=;
 b=0k/yM0CBe407IUzWEIohzZ3cK4onqxbXKZCDlmbVQ8TBzAXBIs4Xu58YjIgsTESgcrvSNAHt1k7DB2Zbhd6MX3alWh6p0Y0KtZdXrTwCSIIaWL6JgoJbHyDH9JfI7g5c8cRVfhEI+GAQOaHUB0wJrgfvKY6tXCm8Su+25iEnu7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY8PR12MB7217.namprd12.prod.outlook.com (2603:10b6:930:5b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 11:54:05 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 11:54:05 +0000
Message-ID: <d914e68b-7f5a-4e7c-9d79-bcf18af15125@amd.com>
Date: Mon, 12 Jan 2026 12:53:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] board: zynqmp: add cmd for getting boot auth state
To: Neal Frager <neal.frager@amd.com>, u-boot@lists.denx.de
Cc: igor.opaniuk@foundries.io, tomas.melin@vaisala.com
References: <20260112100253.2778715-1-neal.frager@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260112100253.2778715-1-neal.frager@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0032.eurprd05.prod.outlook.com
 (2603:10a6:803:1::45) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY8PR12MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: d45cad5a-03e3-4896-c186-08de51d14989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7142099003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2tMMThSMUgxZGFoMnpHWVFKREIwVUNleHduKzYzenFJTFI2cnJjSjJjR3R0?=
 =?utf-8?B?bktXUlRDYm5jZTNDQStaVmpQZ3k4Ly9vY1RYck11ZTVzVXNNSDV2WU5pc1VK?=
 =?utf-8?B?TkZaWmFlQTErN0gvZ3VINFNKN01kWHpUVjdXYWdWTlVZVVFOcGhFS3NZU3Nl?=
 =?utf-8?B?aVZMTzA2MU5KNlFsZCtxZmo2ZGxIdXdDbjQ0RlRjMFNrMkRDOUdTck5Lelln?=
 =?utf-8?B?VVJYc2VoTkI1c2RCZWVwaS8veDFWM25lcWFZNkd4V3dFbW01Ynk4UzVDa1B0?=
 =?utf-8?B?SGZyTE5RVWpmcjVwc2t2a0NhdkVDTGlCUWF3WWYveEI0RTYrVmhpTWZlOHVC?=
 =?utf-8?B?b2tkV0ZRUC9rZFM3S3pNelQ1WmtvSmFPV08yclpERGVSNFowTm9PNEJ5czhD?=
 =?utf-8?B?LzUvNmlRRUJkMFFGQS8za0NTdjNqSDhWVHBzTXp3cUZNQUN1alQ4TEpKRDBQ?=
 =?utf-8?B?c0ZPK3RzZFhtbHkwUC8yZ2dZUDl0dWNHSWU5UEhESGpNcFJqTG5NMHFPTEdC?=
 =?utf-8?B?Z2RoeFd4RTRLNW5HU1Q0OVMwUFJXSThqc2xIcUUrUnZsK1ZEYTQ1MXhNRkta?=
 =?utf-8?B?aGV2WmtmR1VEUlE1REltaDRONjYyOHpaUDRsN0x6UnJuaVFmSFFlY3ZaMGVF?=
 =?utf-8?B?YnEwYTE1YytkdldhVVpVeEpLT2s4bmNnd0J6aGxuL0kvYXVCTmhHYWtZcjFW?=
 =?utf-8?B?SUpib20xVnMxQ3hyeGFVMXBkSzhZK2xRNno0dEJwdEorUmw2MW42ZTE3Tmp1?=
 =?utf-8?B?OFRLZ25kQ0ZXVEQ2STY1U2JrampnOWk1RSt3eUVKQytUZkRuVGU0WUpMOTM4?=
 =?utf-8?B?QUhNa09ZWndDZHFFMWVvOEJqQ1I5WDg5bFptYnlqMXZ1dHpaKzBWWFVZaGNP?=
 =?utf-8?B?Qk9yWEVoYkJ6YWtmYjBvQVN2VTZaRTRxcHNFbXRvcktnS0VNZnZKS0d1MHRw?=
 =?utf-8?B?TVdpMjZhbk9NdVpRblRHcyt4a3pObWJGUU9LQmZCdFErMDl5UXJXalArS0dO?=
 =?utf-8?B?V1l6Y0dSdjVlcEs2RlE0UmcxOVJhSm9pTktSdlZBWTBSQ1NVb0lybmU1MHhm?=
 =?utf-8?B?U3ovQ1ZEREhWd0xyUmJ5QnY4MC9SZGZwbkVmTzRmUWpicFkvc1FUdTFJYWdD?=
 =?utf-8?B?RStpaTluNVVMUDRyRkdCYXczeHI2RXBuWThwSUtsUkYzMTJ3clprTXFVeHZv?=
 =?utf-8?B?VHU4cnJVd1hVdWhxdmVXdTFlTHJFbHk1eE9sMUFraWJYNUIxczM3Ym1ucjV3?=
 =?utf-8?B?eHhnbThDeTRrRyt2Rk5MRE1oTllNZVBWcWRiZ0REZFVOLzUxbzk0Yk9ZM09w?=
 =?utf-8?B?QjF3S2tsUmVUZndKa2RBUTdNMFZmajhnMHpqdlZ0SHdXMy9EZkFKYXhCR08w?=
 =?utf-8?B?U090bUFxTXkvZGx1RUJoS3Jwai9HQ2l4RmZHUkd6RFpiUFNQbjhBMDFTczJi?=
 =?utf-8?B?M3RlQ1F4OTgxc3h2Uk1hQkVjYytSb0tHb0xpVWxZTGUwZWtFWmhEZkhQRUFW?=
 =?utf-8?B?YnNmOHpJYVQ2V0Y5MjlIdi8rN1U2QjJibkpYV21qNE1SbnU3UVlRSHVxczE5?=
 =?utf-8?B?RHBKRTFXSG1ySVhwc1h2Z3Jmc2QvbEVON28wQ0VUci96L203bGlLRkZQb3Bv?=
 =?utf-8?B?NFl3RWJTR2I4YmdLWG5rY3hORTRYYUVKbjZwODQ1SXJ1em5CNC81QWxCR1lu?=
 =?utf-8?B?V3JPNmwzMDkyMkdndllmWnE0dklXMjBQd01tY1M0WUxPQjRTVE1naHpqZTEz?=
 =?utf-8?B?d0NrZ1ZIUEVpR2U4K2JGTW9HVmdCRWRobVdkdlo0QmMyVktBaDNiVE1CRDFy?=
 =?utf-8?B?WUl0SkRsenRZUUZ0TzI0bzNERGl5RDlpdEZ2OEEvQ3UxQXJDVTBHa3R4bjZ3?=
 =?utf-8?B?dW1BWFA0OW16djg4ZW0yQ2I2NjBZakZla0oxMEJTMGRZa0FheUhCeW5kSVE5?=
 =?utf-8?Q?u5tarC2OXSl3pWk4DtW9wzVZ96QNw2Hl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7142099003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWZjdWZwaXQ2eCt3Mm1VYlIvbkRvMDJnL3U4S0kyWUIzMnRla1VaU3h3N3FQ?=
 =?utf-8?B?QzhIOHNmdTZEbndEZTNtM0xOTnV1K3VCYXhacUwxQkg1RDFBb3cycE9hZEhZ?=
 =?utf-8?B?M0JMMHErUXU2RXNsMDl2SlZrMkdrQUZzQ3hMSGU2dDFWeEM4dVpNRWZXcDdX?=
 =?utf-8?B?UTBXV1doS0JZQ3hoMENPOS9UbXpxM09OcVVMMS9GNjcxSGxpN1l4emZHYkJv?=
 =?utf-8?B?UjZhSlFFZnZsMUpiTUs3VERNaTF4Y1FyRUtjSFpZVGNhY1JET21IVEJHM2tC?=
 =?utf-8?B?NkZ5Q3BlNkprNTllMWRxVUhoaThOT2VpOUNja01xQnRNNmhNMHB0L0NuTkh0?=
 =?utf-8?B?MU9DZWhIbVA1RTF4bUVUVGV1eG96SmJpTlFYYWlacHp5TkNReThIVjNYZnMw?=
 =?utf-8?B?WGJQOWx6Z0xvT3krRGwvVjZlS2g3YUdVYnhrem9JcXN2RU12VU5sSGhuWHJR?=
 =?utf-8?B?d1liNmora3A1bmVZWS9uVVY4T1dQSkVMRXRjV1ZUbVRRSG5VSUhialdqajJK?=
 =?utf-8?B?Yk5tUVF2V1dzemJaK0Fra0E2YkU1R2pEM0FXV0VFNmY5cVgvWjB6UzlPanRW?=
 =?utf-8?B?ZnYrYklHb3VoQVZwYzZ1cGx3b3RkUW11MnVxYUpxMzFIR21jZmp2QUR6b1N6?=
 =?utf-8?B?aEVRblJBRnZvcWhJVkd5Z0lvaGg1c0tjQlF3eTllYWRlSjRZSXE2UVJIaWZS?=
 =?utf-8?B?ZU90c0J4M3RmbjJGcW9oUFFFWkRKdXhIWWFKRkt5d2JmZ0o0TktNWlR0bXFz?=
 =?utf-8?B?eGI3UFlVRFBUa1Rtb1BHUFVHeHNabWptbXRrRnc0clo3eG4yOXY5VVQ4TW8z?=
 =?utf-8?B?Zk45Y0FPVFFEcXpsaVhGdC9UNTJrS3pzQ1hCNWZJTVJMVjdFMTdaWEwxVzRT?=
 =?utf-8?B?cThwR3JzZ2c3MVFoc3IyZEhiU2tzZVg3OUFpbHdXNFRRRzdkUXVjZ2lVMEhO?=
 =?utf-8?B?UnpXRGpsc1B5NkJ4WWpjcXJhN3pZUUlINHRUS0dZT0hNd2g4RTlpMEcxcyty?=
 =?utf-8?B?ZnR4K0hQT1EwejhsK29DT0E0UVc3VXVqZ1pqNlR6d1lUVWVISFFsdEpzanRp?=
 =?utf-8?B?bnI3MVdFUGc3YmM5QlM2dzA5dlpIY3VWejNuRzRUaUhHQ1pmQmYvQmczS0VN?=
 =?utf-8?B?TnRWc3JReHV3UHBDWldYeUlkWWxjbHZReVpsNGFQdHdXZFZFS0k3MGRnaGNO?=
 =?utf-8?B?SENVUmVwaE5UbnROZ3ZwRlNNUU05RGxkUGFzZTgrY0tCM2xTWnR5aVdtYnhi?=
 =?utf-8?B?cDhIRjYzMitObDZuZzQxNUNsL1F5V0daZjZSR0d6akRUaVBEQThRVGJOVlBp?=
 =?utf-8?B?TzJNeUpaOXRHRm1BVnZBV1kzWHQ0VTBsZEwyWHlZdU95aDRTQ1dhQituZjJ1?=
 =?utf-8?B?cjhFR1RNZGlqNDlxVkVLTG1FMEJrT1VBT1k3c0lIM1pvdjM0VU8rN0VhUG0v?=
 =?utf-8?B?ZndXdUJmU1huU1NMOFcwVHIrSmhYNFZCQ3BqamNsYUwyVHB0dEZSSFNwRnJy?=
 =?utf-8?B?a0RoZDh4d3V1dzI2N2I0T0dJb0dMVlZ4Y25Ddi9YcWZMTjVMb20zcHBHVmNH?=
 =?utf-8?B?S2I4S1dMeHlNUFhzbUVmZU9XNmtGVXlCTHNzUk5YUTBiVkM4Q2VhVXVybXdZ?=
 =?utf-8?B?S2tISU80RGhEc1NBWlh1dzJuelUxOFFrNUNQYU11RTNhQW5OeE1ZdGJWQ1Zy?=
 =?utf-8?B?UXQ4SUNGNnhUM3NGcTJ5SHBuRUpvZEtWbUdBNmNlL0NXK3lYQ3lVem5kYlFX?=
 =?utf-8?B?ejZwY09LTTZiWUlya281L1Y4YkVuQVlTdUorblBaNG5kanU2OUgxRTFNZ01Q?=
 =?utf-8?B?czg4TGRKOVlOaVBvU2EyT0JGTGhLQXJoS1FZQ2xUWUY5d0hKSElIK3NCNW00?=
 =?utf-8?B?Sm9ZL3ltNkJMdWdQYnlvdzdPRFR2a1M4NERaTVhIRTh1L1FvM3AwNDh3dzZV?=
 =?utf-8?B?RXBjMml3MENWVlBKcG02eEJISlBvd1BkQnRTaHRlb1ptc2dMbEZTTHIwZTl6?=
 =?utf-8?B?RWF2ZzRWKzFKYnVTUU05dnJibU1UTEs2UDJaMFlaekxzV0tsNXZ5bGIxVlFB?=
 =?utf-8?B?NEpiUE5LQmIwNGd6N1poS2IwTUE1K0dqV0gvTGVTaTNLaWZ1NVZSdE5DSWE4?=
 =?utf-8?B?aHBISTBSaDJuVk9HK3NhejVSU2xRV1h4Y1ZBNm9YZFhKNzdMelRhQU5LUUhs?=
 =?utf-8?B?M0FEVCs2b0pBZnNza1pidnBWNVhwN0p6RDlhaGpGZFBMTHMrT1pwTDREU2Vx?=
 =?utf-8?B?bndmdFJYMDQrcE05SzhHYytpT3Vuei9pbVY4VG1GODlhT0x0U2kwdnRUUTN6?=
 =?utf-8?B?SmpPT2EvSVlESjZwSDlDNmV3TWRXNXB6TzdibkhwUEhzSWpYOWJZQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d45cad5a-03e3-4896-c186-08de51d14989
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 11:54:05.7870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SSC0cs5vlkzTbRVh2O+naAUKKMmkPWSQ9IoTd9TXMs1piBJ+3dntzc8aThqjk7jW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7217
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



On 1/12/26 11:02, Neal Frager wrote:
> Add command for checking if boot was authenticated.
> 
> Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
> Signed-off-by: Neal Frager <neal.frager@amd.com>
> Reviewed-by: Tomas Melin <tomas.melin@vaisala.com>
> ---
> V1->V2:
> - extended zynqmp command with verify_auth sub-command
> - changed return value, so it can be used with scripts
> V2->V3:
> - separated status and ret values
> - replaced BIT(0) with ZYNQMP_CSU_STATUS_AUTHENTICATED
> - changed env variable name to "boot_auth"
> V3->V4:
> - removed unnecessary zynqmp_verify_auth function
> V4->V5:
> - added newline to zynqmp_mmio_read error msg
> V5->V6:
> - changed printf statements to debug
> - simplied status check in if statement
> V6->V7:
> - improved help message
> - removed unnecessary change to U_BOOT_CMD
> ---
>   arch/arm/mach-zynqmp/zynqmp.c | 32 ++++++++++++++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/arch/arm/mach-zynqmp/zynqmp.c b/arch/arm/mach-zynqmp/zynqmp.c
> index c0398a466ff..cea6f8f4a99 100644
> --- a/arch/arm/mach-zynqmp/zynqmp.c
> +++ b/arch/arm/mach-zynqmp/zynqmp.c
> @@ -362,6 +362,35 @@ static int do_zynqmp_reboot(struct cmd_tbl *cmdtp, int flag,
>   	return CMD_RET_SUCCESS;
>   }
>   
> +static int do_zynqmp_verify_auth(struct cmd_tbl *cmdtp, int flag,
> +				 int argc, char * const argv[])
> +{
> +	u32 status;
> +	int ret;
> +
> +	ret = zynqmp_mmio_read((ulong)&csu_base->status, &status);
> +	if (ret) {
> +		printf("Can't obtain boot auth state\n");
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	if (status & ZYNQMP_CSU_STATUS_AUTHENTICATED) {
> +		debug("Boot is authenticated\n");
> +
> +		ret = env_set("boot_auth", "1");
> +		if (ret)
> +			return CMD_RET_FAILURE;
> +	} else {
> +		debug("Boot is not authenticated\n");
> +
> +		ret = env_set("boot_auth", "0");
> +		if (ret)
> +			return CMD_RET_FAILURE;
> +	}
> +
> +	return CMD_RET_SUCCESS;
> +}
> +
>   static struct cmd_tbl cmd_zynqmp_sub[] = {
>   	U_BOOT_CMD_MKENT(secure, 5, 0, do_zynqmp_verify_secure, "", ""),
>   	U_BOOT_CMD_MKENT(pmufw, 4, 0, do_zynqmp_pmufw, "", ""),
> @@ -371,6 +400,7 @@ static struct cmd_tbl cmd_zynqmp_sub[] = {
>   	U_BOOT_CMD_MKENT(rsa, 7, 0, do_zynqmp_rsa, "", ""),
>   	U_BOOT_CMD_MKENT(sha3, 5, 0, do_zynqmp_sha3, "", ""),
>   	U_BOOT_CMD_MKENT(reboot, 3, 0, do_zynqmp_reboot, "", ""),
> +	U_BOOT_CMD_MKENT(verify_auth, 2, 0, do_zynqmp_verify_auth, "", ""),
>   #ifdef CONFIG_DEFINE_TCM_OCM_MMAP
>   	U_BOOT_CMD_MKENT(tcminit, 3, 0, do_zynqmp_tcm_init, "", ""),
>   #endif
> @@ -446,6 +476,8 @@ U_BOOT_LONGHELP(zynqmp,
>   	"	48 bytes hash value into srcaddr\n"
>   	"	Optional key_addr can be specified for saving sha3 hash value\n"
>   	"	Note: srcaddr/srclen should not be 0\n"
> +	"zynqmp verify_auth - verifies if boot.bin was authenticated\n"
> +	"	Create boot_auth var : 0 not authenticated, 1 authenticated\n"
>   	);
>   
>   U_BOOT_CMD(

Applied.
M
