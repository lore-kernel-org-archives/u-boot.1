Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63EEEA3F22
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 08:31:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B4EB8341A;
	Tue, 10 Feb 2026 09:31:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DegUxHlA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B35383CBD; Tue, 10 Feb 2026 09:31:22 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E5788309A
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 09:31:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCOFd5qbVS1V1M+BjLb7xqOTrFDa09u0N5C8bk4Ryl3uOMSc2xJwvPo7OjMzske0HyIAcRmMYVzS5uz6umsZjPwRisyUbL5XjQx3L+Cvg2z1KkhmNiJvVL1QK0nY416okgjzJN2k/a3Hxo+X4FqiQFLkgS3PZnymVXehvKGPwy0Gxwdh2pLV2cMlNv5fAofZEJwVOu3XvOsDqNtgwN9NYy8c1g+Zdv9g8kGBXLZMU+uJwZKFV6a+jFOmYj2wjUTI3rsenZd5AsUUXERZIw8KAD6Mao0BQ1AqHFQF9lbZuSDjXwNa9lt8IhzPkzqEu5pPkIUmoZe2jx5uLHcd6uURjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6RyMLHVRgNtjHN/fYu8AhaBZElhnFGoeiXqwyp2gqM=;
 b=yeK4cA91ewG7ft+32lALDEEWycEQBKlWOzqTf6+5kq7bCjyLSRlMEv8kEZgg34NTYSsCv4JEH+1A9iZmagwnRJbShhBC6dM1bE1+xvTQixJCKXaGiuUvviRe58ubjHTBi/ViX1levX//3WPa/3XBr3qNXULECmwxyugx9BvjE40h9d0N8uGklPZsUIgJqko3f9ocMG37ZHUtkn6RfXVel5TxKk51PS0rm1pUNDLMEyXTTgGQVFN42kSoBz2CxVJ1lBKg8HcCkxmbdme1YkpFqzHnKDZWfBUSNBbd0ULlw8DR6svfJX0jiPQFpVfZKtQCvug9/y0IiqDUY5ugkF4BfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6RyMLHVRgNtjHN/fYu8AhaBZElhnFGoeiXqwyp2gqM=;
 b=DegUxHlAmqsHx83YHLMwr3n+ErmE6NkHLJkonfx+L0DgcHXLEJkxxdhkfwnurO2YWEE5NMAY91FuHj8XyBtIkQE/p9VsbcV06q7jqdg+xfBbeL7v6y38CMaufDm4UjqrNHtrZIOdMx8QoKAPsn5JAowPHlGV2NR7F3sVfN2odl4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18)
 by DS0PR12MB7678.namprd12.prod.outlook.com (2603:10b6:8:135::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 08:31:15 +0000
Received: from PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d]) by PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d%4]) with mapi id 15.20.9587.016; Tue, 10 Feb 2026
 08:31:15 +0000
Message-ID: <cd8fdd50-8e90-4e98-8fd7-654590ade561@amd.com>
Date: Tue, 10 Feb 2026 09:31:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: Enable NFS support for all Xilinx platforms
To: Pranav Tilak <pranav.vinaytilak@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, Padmarao.Begari@amd.com
References: <20260130114148.1817379-1-pranav.vinaytilak@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260130114148.1817379-1-pranav.vinaytilak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0020.eurprd05.prod.outlook.com
 (2603:10a6:803:1::33) To PH8PR12MB6939.namprd12.prod.outlook.com
 (2603:10b6:510:1be::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6939:EE_|DS0PR12MB7678:EE_
X-MS-Office365-Filtering-Correlation-Id: 73e1bb35-bd16-4ad7-8c3f-08de687ec14b
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aXBWQ0FQVHZZMEdnRkFJdEJ0UHAvM3BSNm1zNUZtWVZlVlpQR2h2VnkwTXNJ?=
 =?utf-8?B?dlNtY2pwRmlKcGYrNjE1Q3ZMS2lnaDhiaWZwRzBEYmpaQzloa3JvTFdmVmVj?=
 =?utf-8?B?bnlmWndPbVFFKythWEpxcEtwbEtHWUJDNUlJSFo4Ly9wVkNwWWNhSFcrcjFJ?=
 =?utf-8?B?bGlmTmd5MG9MS0c1L25mOXhhTkJZcWhzTGFUcm9JWC8vek42U0tVdFgzY3JE?=
 =?utf-8?B?WkR0cTFSYncxNHljMmRwcm1SZzhFTjlNM0poaWFmWFpHSElhNE40czhBWW1v?=
 =?utf-8?B?dHhDOHJocFVOT0FyS3ppMGJENVdwd1Z6dkNPUDM0SnZCRzFreEgxZ3drbkVM?=
 =?utf-8?B?SUIyQkJHcHFaTkE1SmtvWC9FYlVVdWdRLzczYUZPU1RpSURMdjhLZi82Lzdo?=
 =?utf-8?B?RXd4dHdHajV5TXkwWGVYb2twMmM1cmtLT3NWUi80Y2NPZklqQjgybHZ5QWk2?=
 =?utf-8?B?L3lQYlVQcFR1aFFrdkFEanM1aFJTRTZyclZVZ2pDVmZnUEdnRTJiZVYwb0ZW?=
 =?utf-8?B?dHZoQ1E0bFN2WWQ2VTllVllZdWt1aWZ2YmtTdnQ1dExjMmZZR2lPanJhOFhh?=
 =?utf-8?B?Wm9hWDVveXpzZVV3WXNmOXhZa3llTUdGbUF3bWIyZ0F0S3BaTjhPU0owUm5V?=
 =?utf-8?B?eW1ZN1lWNHpSalZtZU5IZWhmc0t6TFhVbjNnQUR4TmJUQXlnaTNrNjlmZTlW?=
 =?utf-8?B?bDZyUXZJdWg3b2Y1WXZqK2QzdTNBeE5IMWc2Y09KRnhPYlNzOE8zeWlaQ1RY?=
 =?utf-8?B?NlU5YXAxRVM5STVUNmtjSUFUOHprUHFPQzJnNEt1dmhNc0E0ZW5XaWVldE9C?=
 =?utf-8?B?R1hhMm9jVGFEUTZYV2FlMG9VdldUM1NJNWd4ZTBJNVBpR2JpQmFKb3lmUUZr?=
 =?utf-8?B?bFcxRndMcWRVeDdkRThwQTdXVWhaNTNUMkdYOTI4TnBzeTQyTXhQcUozd21z?=
 =?utf-8?B?VUJWckZSTFc3NVVSY3BwRFBBZkgwUW5UaWM2dUc5VlM2R2NObnRCNWpDVVFO?=
 =?utf-8?B?SkZOclE0LzI1bHpGaUNPYmxrVlBFeXRsdFdxQnkvc0dwY1FESVF3ckpWckhx?=
 =?utf-8?B?a2liaVcxc01TWVdPVVgyZWlxRlZRY3ZsWUw5Q2Nua3g5UjNzaG9aRmNhZFR3?=
 =?utf-8?B?dGlINTloZmJwckFRbXFZRW9tQ0VLVGhrUzQ5MkxyNUFoMDZwSndlSTRoeWN5?=
 =?utf-8?B?S01hVHZuaDFzTHU5aUdvV1d1OFJCc1hWUVg3bmNwTmN0eWNTWGRvQTk0SzZ1?=
 =?utf-8?B?ZmxyN0t4bEw4K1l5Y0Y3UVNqWHpXM28rdHZSRUFpUjh2T3M4bDkwaGpFY2pr?=
 =?utf-8?B?eWEydTMzSEw0MjN3bXdMeVJ6SHArZlZmY3lScDNaZUNEZmFhNGcvUlBjQjlE?=
 =?utf-8?B?dUVuckxFL2pDMUVtQnJiRnUrM2tnbVVyYVovRDVmTlVDSS9BSThyOCtqTm9I?=
 =?utf-8?B?Q3dvZTVRcmkxeTZPbzFLRzFPeXBrN0dNWVdPalpEMUY5dEdFNWwrVHlxNkdP?=
 =?utf-8?B?enh3NWU3VVlLSEllNEZORXViOUd4WUtKcHlZVHlUNEk4NStGLzBvYUEwTTMv?=
 =?utf-8?B?QW53RHhobzJMYnNqajdvZjhDYU9pZ2JZUU53b00wdDMvRTRmMWt2a1FzaGky?=
 =?utf-8?B?TTR3UVZZeDlWblJEUEQrNU9GYndBR0xKc3Q4NzdFVWhXbnhxcmxpWE9ObFN4?=
 =?utf-8?B?UGRmQVJWRitRVGN0T0ZlWThFQVZBK0w3VW9JZGVLbjFzMlVNbmkvWW16MnJq?=
 =?utf-8?B?cEZGTUpwL29wNHFXc2ZxMU1zZFc3UE5wTFg4R0NWelVJall6amxaWGlpUDVO?=
 =?utf-8?B?aloxeVZqcHAyVWFMU0djUU9sSkZzWEFUSHZDTmpXR1BVQlRDZzBtdkRIdkxJ?=
 =?utf-8?B?aFk5N2FKaGRJWXYyS3YreHp2UEpYVDFTWTNYd2Q2OTUvWEZEZnRud28vNkEz?=
 =?utf-8?B?Z1JEVTlJTXFrZkpPdjNUdnlLTmxCUUNyWDJtOHFxSEhjQVNyQjVBR2hhUGRH?=
 =?utf-8?B?V0hLa3hwYzJINVVkajQxZU1MMFBSUEp3cWR0Uko5L3dmRkdlbllETlp6S2t0?=
 =?utf-8?B?QzNaMDZFTms0VXRicms4bEplam9kWk8vN3Mzc3dtZmJwRWxjMmVOTnF3dDZO?=
 =?utf-8?Q?Zcw0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEtqbWpiV1dyOFFWWC9VU0hFYkRpYWxISHJjVEJRVG1LWVJ2RkZDSnZRZFN5?=
 =?utf-8?B?Q083NUlJSHRQaDVKc056UStPb05PRU9YWG8rOHhKS2QrYmZVNk5nWFdFdVY1?=
 =?utf-8?B?cStWcHdPSFdqdTNrWmFJaFRuclkrcExKQk1FQWhjNmN3UitYZk0zUEx3Q0Jj?=
 =?utf-8?B?U3pFcjBESUk4eXVXWm4yUXl5TmZta2p0TnFINFVPQlVnSjBxNThmVllNTkR3?=
 =?utf-8?B?Z2U0Nk1POGJuOENFZU1SN0V3d1dLMGJNWlIwdS9zcG1DTExOb2hocysyVjEz?=
 =?utf-8?B?ZHAyVytia04yL0ZjSHJmd1hQYmxDc0l5UHUyeFpQdTVybXptVHdpM2YyMlNT?=
 =?utf-8?B?ZC9JL3k4eDY0VzFpcUJlNTlnSFdvbXFjOTZDMVVlWGp6NUFyRWtCVS9QQUwx?=
 =?utf-8?B?bGpYaDB0YkFLTDNwTzN0WnowZDUxaFRBYllYbGFjTmsyQWxZMmpIQlRUUXJn?=
 =?utf-8?B?V1d0dFk0Vnl6cEllcWEyK3N1YWVEcW5CNTYwKzc0WmlhWWhCQ09yaWM4U1FR?=
 =?utf-8?B?WXRNNjZZdkZacmFGNmZQalgzMnpFRXduaWk2dmVhcncvQ0N3VnRkY3Jpa3hk?=
 =?utf-8?B?VTl5TnRoZ2N0cTIyeUpSQk9WV1hubW13cVI1bExlQXpMRGhOelJzQ045UVlE?=
 =?utf-8?B?ODJvd0p5WWFUQm5vNGU5V3NzV3Nhc2tJSW90cndQLytsU3ZqSGtVRk1wUEx3?=
 =?utf-8?B?b1VkMk9sU0lzWlpwSkFPMzdwNktQRnlEYUY5RnNDeXNzdXFvcks2NTdVWVNF?=
 =?utf-8?B?bDhKc3J0aEJnMnpKNFlBM1lYVXB4QmJ3K0JZbmp6Y3JrczRzMnh4d1E5bThI?=
 =?utf-8?B?M25MMlBrZWorZWo1c2paVXJaakZ6YWo2VDd6V3FnL0t2SHppQjFINnVJVThB?=
 =?utf-8?B?MmVseEtSN1hhTEhwcTVnUWVtblVqRTI3M1VxcThzTkJYY0grQVB2a2NtRjZa?=
 =?utf-8?B?ZUVmWktrb2dKSXlMMkt3M3p6TXNEdHF2SCtQUllXUnZ4K2oycGJ6VXhVV3Nq?=
 =?utf-8?B?amQ3YnFWWWpiclhQNGM0bWhiM3ZaRHhMTmkvNFl5T1NwWFAwRnJ1Y0lRUUhI?=
 =?utf-8?B?L1RET1RQNHo2WVRYYko5L3B2QUUzN0VVeVVJcFQ4UGwreFVDS0dxUUswZExl?=
 =?utf-8?B?dDVVOXViQjYwSGp5OXByZFZHMGdQQkV6ckF0NGdjVkRLZGU2NHFEdXpyb0U3?=
 =?utf-8?B?S1ZYS2hPbWU2Ynh3NGVpTzhoMUVWOE9DYnNROUtuMEovKzQrTStiUSt4ck9u?=
 =?utf-8?B?N2o2VERiNUdRNmFYTWVvU0JQQXU0bVcvM0lGOEk3aXdGbXlxOTc3alVlcjhu?=
 =?utf-8?B?T0lVUHhid3hUMXpZUVZJTHAwSTBOOXNxWXZ2cm5xLy9nbDEwWWQrOUN4L2Ex?=
 =?utf-8?B?bnU4SXVRUzN2OVJ0Q2o5MTh1dmROUy92b0djb1d6dkRZVGZrcDV0WVVsRFRM?=
 =?utf-8?B?bUUvWUhhUlhqbzVXeC9rUFlhanpyL09WcXJSN0F3U2RjcWN4eC81aUMxTGlE?=
 =?utf-8?B?Qm1KNk5PL1k1MDFCR3BWOW1zQlpsQjBMdHpXbExuS296L0F2TmdwVS82Q1Fy?=
 =?utf-8?B?RlNUcVQ2OFVSay9tRFhZZXRzSUNsSVFZMWdjdFdWaFFKM3hLSEgwVS9FWVRL?=
 =?utf-8?B?QnQ4Mm5ZN0M3RlVBQ1hpeTdka0dLaVowQVRaWERnNnRiREVaRkIweThUY1Q4?=
 =?utf-8?B?UDBZSGY4TzdGVHRCV3hVUHlMdWRvZFNJNU0ydUJRZDE0eEw0YnZ1TVNNelc4?=
 =?utf-8?B?M1BsV2hJR0tjbXM4aENxUFZLQmtFMzU3a3NhM3ArVGEvVUd5RU80QVNhWUNR?=
 =?utf-8?B?TGo1UW8xRUZ3Uk1HNHEwMmlTQi8rbktoT004SWxjZTlvTmtYbWZGOWpNdHZv?=
 =?utf-8?B?MFVNUk9LZU5xMkhvSHRMUEo3RUg1d09PK0dDMGVuK2VlbzY1bXVvN2VNTXpa?=
 =?utf-8?B?VmYrTFlLVGUxWWlrSlh0cEVzTjU5NWl3WVRtOTMyM0syMUh1NXlZM3NFMWFH?=
 =?utf-8?B?NEtXOW1GSDJrUEZYTkRoejV6NENIS1p3TEo0N3Nud3FyUzBCbGVLVzlPT3k5?=
 =?utf-8?B?NzFxcWVtVGlXNHI2MDNjelRPNlFKQUl6aWRDai9hUmdUcHNGYTN1d2lCZDJk?=
 =?utf-8?B?UWVDY2FUVzB5TktSYUZ6VVBWMmZmOGhDMFVBQVB1NUhlMURXZlZGc0k3RXlI?=
 =?utf-8?B?TjB3NVh4Zk5LYkFUV05tMlFXZGhNbFBPWXB6anZpaFg2VkZJV0dSV0dlM092?=
 =?utf-8?B?UVVLK0JHOFZFZTJ4Vlk4YzVTdXRXM09paVdpcEliUElKa0E1K0VoUEh0Tllw?=
 =?utf-8?B?cGJUK3lKMy9aV1JCSzBLOG1jUVdQOVovNkJuKzYvK091RGFmOEc1QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e1bb35-bd16-4ad7-8c3f-08de687ec14b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 08:31:15.5940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWJAg40FjM+gVnEkFsIK4lGrsd/0cB5Ta6hLKFXL4IqWedZ4KfbMe6O5lZ53QOa6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7678
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



On 1/30/26 12:41, Pranav Tilak wrote:
> Enabled the default utilization of the NFS command on all Xilinx
> platforms to facilitate booting images through the network using
> the NFS protocol.
> 
> Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
> ---
>   configs/amd_versal2_virt_defconfig       | 1 +
>   configs/xilinx_versal_net_virt_defconfig | 1 +
>   configs/xilinx_versal_virt_defconfig     | 1 +
>   configs/xilinx_zynqmp_virt_defconfig     | 1 +
>   4 files changed, 4 insertions(+)
> 
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
> index 0344089030c..94dce5c191c 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -49,6 +49,7 @@ CONFIG_CMD_SF_TEST=y
>   CONFIG_CMD_SPI=y
>   CONFIG_CMD_UFS=y
>   CONFIG_CMD_USB=y
> +CONFIG_CMD_NFS=y
>   CONFIG_CMD_SNTP=y
>   CONFIG_WGET_HTTPS=y
>   CONFIG_CMD_CACHE=y
> diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
> index 323b5606566..3410b874a04 100644
> --- a/configs/xilinx_versal_net_virt_defconfig
> +++ b/configs/xilinx_versal_net_virt_defconfig
> @@ -46,6 +46,7 @@ CONFIG_MMC_SPEED_MODE_SET=y
>   CONFIG_CMD_MTD=y
>   CONFIG_CMD_SF_TEST=y
>   CONFIG_CMD_USB=y
> +CONFIG_CMD_NFS=y
>   CONFIG_CMD_SNTP=y
>   CONFIG_WGET_HTTPS=y
>   CONFIG_CMD_CACHE=y
> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
> index 652121e27a0..e8d6f4cf6d6 100644
> --- a/configs/xilinx_versal_virt_defconfig
> +++ b/configs/xilinx_versal_virt_defconfig
> @@ -52,6 +52,7 @@ CONFIG_MMC_SPEED_MODE_SET=y
>   CONFIG_CMD_MTD=y
>   CONFIG_CMD_SF_TEST=y
>   CONFIG_CMD_USB=y
> +CONFIG_CMD_NFS=y
>   CONFIG_CMD_SNTP=y
>   CONFIG_WGET_HTTPS=y
>   CONFIG_CMD_CACHE=y
> diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
> index bb79ddf989e..a00000be224 100644
> --- a/configs/xilinx_zynqmp_virt_defconfig
> +++ b/configs/xilinx_zynqmp_virt_defconfig
> @@ -83,6 +83,7 @@ CONFIG_CMD_SDRAM=y
>   CONFIG_CMD_SF_TEST=y
>   CONFIG_CMD_SPI=y
>   CONFIG_CMD_USB=y
> +CONFIG_CMD_NFS=y
>   CONFIG_CMD_SNTP=y
>   CONFIG_WGET_HTTPS=y
>   CONFIG_CMD_BMP=y

Applied.
M
