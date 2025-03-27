Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C30DC3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 09:01:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F68D8070C;
	Thu, 27 Mar 2025 10:01:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pSZxQnIO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86C1C807D7; Thu, 27 Mar 2025 10:01:01 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::620])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDFE9800C1
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 10:00:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7UM9KoshAhejJfHglEDGuHx9T3YbifB/Yp8iLJPxWr4FeirKvTwVgqpWklBzvMjHnVrDKaaEnnHwBDirmdgxfpp2W48/jSwcC+IPNot0jncTLJFKAI+7TNsc3K1tIHoIUioDZknFk34ouDrwKPEu8nD5u1kplIOoUGZVBOdL20mN8Aj250I7ScOPD0FQDdcV4m8PfMXamKBpSslKbFBPM4bIHfHNEEBS93ce0cLUninMwo8OJKEaRpNWGQWPKRG6Mh/YKeaKePO78qCGENEZrf49EkwjHaDQDT2LyuE3vC2PkVF9DBxc7CqKw8MTg4FC30/MAgAKPav9tv4DLb6sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPZYBeicniiJbEpw3GpUh43/mdMkN+MLpS2PWXrpv50=;
 b=wdp8yvancXVE9IcUse5Oj4cY3VATSOQsWrAfiVnzjkyCIk2nL6JtImudPrcCPVbNo3VUjScpeUuCaJ+MWsZcOw/TF+bY7/cVZB+zQIGAyi9hWE5hC/8RjNPR+IVcn2QxEh3bLKYtyFwOfiL6LjgBgd4/KTSCccq2aSAlVE4CVaeqpcSPK8iLtiCJigxEoPI8yqOTYi286WZUxCudyuFZe9+GkfiWdvhkRic3wzinZe+2iCkWfC9EvjODPc1T3Dl6Ugy5ZF426T+RZWxYAxcWzfkiSZGhElAVlxKw+5YiQiRRRplt+YxAe086d42E8b3F6ev42ZIpMFikhcs1UJtQsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPZYBeicniiJbEpw3GpUh43/mdMkN+MLpS2PWXrpv50=;
 b=pSZxQnIO3+T3qs9Rm2GAR4v7up2LSXHcxlXW3EGIUybWqdzNlJxoqQ/t+aCOXVQ+14YxAJlWgCv+ZB/+i7YV6VwE0IaX5Bcw/0mGzEqL9iZO6y9mdLbehl++XW/fdUfehBFms8/wog+ax/1rDuCPXyV5btq0v+POein7X5D6W5U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY8PR12MB7588.namprd12.prod.outlook.com (2603:10b6:930:9b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 09:00:55 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8534.040; Thu, 27 Mar 2025
 09:00:55 +0000
Message-ID: <d986be35-bfbb-4f11-98dd-19bbec102d5e@amd.com>
Date: Thu, 27 Mar 2025 10:00:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] topic: zynqmp: Remove zynqmp-xilinx-xdp platform
To: Mike Looijmans <mike.looijmans@topic.nl>, u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Fabio Estevam <festevam@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Paul Alvin
 <alvin.paulp@amd.com>, Prasad Kummari <prasad.kummari@amd.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Tony Dinh <mibodhi@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.68f99027-b22f-4bd9-9418-ab6179f4cea2@emailsignatures365.codetwo.com>
 <20250326161534.183270-1-mike.looijmans@topic.nl>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250326161534.183270-1-mike.looijmans@topic.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0210.namprd05.prod.outlook.com
 (2603:10b6:a03:330::35) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY8PR12MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: 29399e29-5513-42b1-fc29-08dd6d0de263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkVTUkNzZFdoZUgrdHRidndIMXNJd1FtbWRrekdSa3ptODF3U0pMOEdIWnZw?=
 =?utf-8?B?ZmprdnZETUtEYkVrUGNUNWRzamVjTnRRNWJsS1AwVithQVkwcUhOVWNLRldP?=
 =?utf-8?B?a3ppRGViTFRSK3RsYUxDWm1tQ1JTTmhyQ0ZUeGl2QXplNldRbzdnZjRFRlkr?=
 =?utf-8?B?c2szNmRKRk9hcWVZSi94ajJteWhCSklDSmRhME4zTlVTOXg5TFpDSWZydCt1?=
 =?utf-8?B?L0FQMnRBb04vaHZrK2xUc3pwc3dDWFNabzFZamlETFU5UnBKUTY3NnAzVURh?=
 =?utf-8?B?RXlIam1FdDZUWisyRC9hYmNoNGNqMVZHUDFqYVRkS2I0OE0rNC9DRGpabk80?=
 =?utf-8?B?M2R5SWQvYTRSYmU4aFI2QUtDQ3kxOVpPL2RaYnIrY1F2MkVBLzlEOVdrOXpJ?=
 =?utf-8?B?SmxHVXRVMEpzSnhTL3Fsdjl2SXh1YTdQcS81WnlBTWhLMHowVWtjL1BpazZs?=
 =?utf-8?B?QjJXd2w1NzczNkFaUWlmWHFYNlhoZ1g3eTYycjlVVjdacmxCTzl3N3h2V1lt?=
 =?utf-8?B?TlBHM0xaRy8zYzBPbW10TFB4UFNpcHFnaXBOQkZ5RlJ5S0MvN0sxcTgvR1hZ?=
 =?utf-8?B?M1MvcUZNbWlWLy9EeDFGOTVZWmpkZWpNcmp5WjBsQkt2ZFVWN0U1Ui9zUTAr?=
 =?utf-8?B?QkJNY29ZejFPYmVpejYrT3NxdE1uY2JTNmtJU1RRbHVyTmVSMzBmckFpR2tq?=
 =?utf-8?B?Z0p6aXZyRElKM2NQdXJra1dubTR6VGdrYllPeHNoRzN3VGJWTGhXQ24rK2hW?=
 =?utf-8?B?Sjk4bEp3VnVuTzFyUE82NEx4L3BIcWtjKzJwQUsrZi9sNlR0MVp2ekhUcm9l?=
 =?utf-8?B?WUtRaFU5Q2JCTGl3U3J5eFl6Tnp3ekt5THB1NkF4OFdROSt4ejVKWnhJN0Jh?=
 =?utf-8?B?SjJ3TldsellCTERvTHU0bm5kRFg2SThXVHdhNlJ3QndkN1d5RlViRkoyNFV3?=
 =?utf-8?B?WllUNVVNTnFRNkcwbGpvZGlxZjRqQ2xhZ0pDS09hUkhhdlUrZ3E0Q05GQ2hl?=
 =?utf-8?B?L0JJankzdTJ6UFd6aDJXZnNZUS9PNkxPVGdZcmpOVmVaL0g3MWR1Slk2eVVp?=
 =?utf-8?B?ZW1IRUpqRmEyTVlFaTZPVTkzUjQyN090VllUaytiS3JuTkZwWUhjRWxLUmdS?=
 =?utf-8?B?U2I3cjhKRnVJTHpUUUJESjhsZFMzK21Bb2pTYmluaUZYTWxnNC9DcGRBWHhx?=
 =?utf-8?B?cHBYQzVKMUh6N1RCbVliZHhIK3drcVh1RjlsdVU1TVAxeWgzTHVGTk5Fak5E?=
 =?utf-8?B?ME9Hd0F6Mk1FTUFvdGZ5N09reWU4N1BqUnV2YUZJbHk4STdNWkpRRGF4M2dj?=
 =?utf-8?B?R3ExMCtIOWZOQTBFSWhuUjBrTFpCV1VwMEYrNXRsbVdGSTM5VCs0ZllnSXE2?=
 =?utf-8?B?eTl4VWQ2ZFRIVUhaSTdqNzE0TU5CMlkvK1JSSnNldHJadEtkNlJVS2VUdEZ5?=
 =?utf-8?B?Z2ZMRGhzWGJEb1E2RUVnVTJaQ2FaNmQ0b1BVTjZEbEF6YVlFZWhIVWdONnRN?=
 =?utf-8?B?dlVLQUhyQ3ZKNkhSN243akZYRU8zcTdjUWh4dVdlV3FXZUdkd3dXZktGZmpU?=
 =?utf-8?B?SDk0RzJuTVpWODlLQ0xvajZOcGxzZ0ptNEwyOC80SlRyWG5XQ084Sy9sV2M3?=
 =?utf-8?B?ZFV6dktWc0pOZ3BGV1pOMHRaQXlFZWhwY0pSNlM2Wk1zNEFHUkZnVGlXczlx?=
 =?utf-8?B?cWszZUFaRUkrTUEyQlRLQnhNNFFObHlmNW1va1htYXBMNzNiR0VjRHl1N2VL?=
 =?utf-8?B?QWpBdXRZZWxGMWpMOVFBK1lvVFBxcUx6ejVpK28yZ2FFNzBJSXdlSXJXenoz?=
 =?utf-8?B?b3FDZHJhWHVScEVINm11WEdrVFJxaTEzR21tYjd4ME9HZWgrSmplckhNa0Jk?=
 =?utf-8?Q?jMHH6PApniE1+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVZXOVJkZFR1OUxLN1VpL3ovdGR2QnRzT0o5VWhRcXdJZTFlSU8vVHBCOVlo?=
 =?utf-8?B?Tm53S1VGN0xMcnp6eXQ5ZlcxcXVTV0ZDYk1sL1RJUkUxQ0pkU25paW5jZjNy?=
 =?utf-8?B?Z1F6MmtOZlhDbjZTR1JaUmEvMllwcGh2S0NTTHNTd1dTcW1JTnRvYnM5Lzlt?=
 =?utf-8?B?Und4Y2Q5VnF3cVU2V05RSTZlN1E4MklhVEQrdTd2L2tMdmtmcUQyNFE4bmhK?=
 =?utf-8?B?QUpyVFdzVFdFVVl2cXl2SG5yeW1LZkRBMHE2cjYwNVRJdndzOENraTczVGh3?=
 =?utf-8?B?dGMrRzRxWDJISzgyNmVGeE1wRzQvdWovTU1jVEJzZ1QzcHdHNnY3SG5yOStC?=
 =?utf-8?B?RXZHZ1JGSGtvc2V5QmxCbDNRcHQ2WWlkdkNxdUVQaUJPbVJCT3pQQjY5K0xr?=
 =?utf-8?B?eXpSSVF2Ylc1ZWprL1FjckF1ZGpZaDVvaGduc2d2cDJpZXBlN0pXU1ROSXFS?=
 =?utf-8?B?enB6MWpickhMNWRtck9zVXdsWldPNWp0QTA0dDdQQ1ZuZEI0SzVKdHd4bUR6?=
 =?utf-8?B?R3BiTzdTY3F6TTk1MjBZYXVCdFk3N3FpV3pPbDllOEJacWpvT0laYWJUMHZB?=
 =?utf-8?B?Nmw2c0x0OHVyRk9zVWlidTRhSzJmZVpZOGpNQXc3VDhLOTY3WTB4VUhodDdn?=
 =?utf-8?B?QUFuZE9XUWdHYjQxcTV0T1NFeXBBekZNVzRmejVmdjI1SlJFME5uNjBJWTQy?=
 =?utf-8?B?UUw2NTdDdGdYVm9PdlI3SkV3bW9LWXV4VGVUTHVMRnVmSFZvZUNYWkVVMDAz?=
 =?utf-8?B?YzgydlFDYmNzMktjZUpIMlROZVBFRWc0bklKV2NaMnl3KzRyeWY4OFN2YVdq?=
 =?utf-8?B?SjRWK1g1OTdaajFYaVN2dk5meEZaZWhBRkpzYnV0ZEVNaTZuZHBwOTRKRlpP?=
 =?utf-8?B?NDJtYjJPUnNiT1lFSW9tNlFOZXE2Y1o4emZQS3lmSHVYaW5hc2l6ajNCVHNh?=
 =?utf-8?B?VVVDOWlRMTRTeDhTVGd4RTBWV3lVaTdjYjlEMjJxKzhFMXZnL2ZuQWdJRVd2?=
 =?utf-8?B?dE1iT0RLVk45TlNHZzF2Mlc5Sk1hSjdUOFFRdndoUUlwM2x6eWlvZjFUV0lx?=
 =?utf-8?B?WmlVY24vLzhTa2Y0WnJkbHhXZnpmU3lhZDR6Nm84K3g3alQwQU1yRHVhRDR5?=
 =?utf-8?B?Q1EvVUtQaUxlWUN2SVhmK2J5bmVnV3YyQVJ5NkNiRkF6MEdIRGRZR05XdE5i?=
 =?utf-8?B?dUh1RnpGSXVZMGQyQlo1dGxMd3MzT0t5WVZjdWUvUm5mZ0JOMHdPQ0hUdEto?=
 =?utf-8?B?bktPM3lkOUpDeWtJUnVmMEZIRlZTUE9hQ2JxNkMvWHJhaDdVRUY2NGxuZ2d0?=
 =?utf-8?B?aTNtY3poa003bVNzSkE2UUhWakJFMGpxK05tNExxdmVsUjVoVHpZdFhtckRM?=
 =?utf-8?B?VEMzajZiT3liV3NBQWVRbFkyMDVwbWg1Y0ZHNGNrOHRzMTFyOERCY1FLVlpl?=
 =?utf-8?B?TzkrY1RZVXhJbjZyMW5IUCt0OUZodUVPQkdqQWZUUTVwT0JQaG82a3Q0Y0Zi?=
 =?utf-8?B?Rk1hcElEZ2RKbWVFZXY4N0pjelliKy92dXUySGg4eWh4R0JVRHp1clhLdFVH?=
 =?utf-8?B?Rm8weGQxUHVyemxRZDl1dmlJMUFQalJEMkF2S0NYbG8ydmVKZUk3VGZ5V2Vh?=
 =?utf-8?B?VEN5djhXMk5qNG9rTlhkazJYc05HRWpIdkNobnZJWkdDcTR5Ly9sSnQ5MktK?=
 =?utf-8?B?bzJQUFUxWWw3UG1kQXNrY2NmMEZyVzJEbVBWc0RxNWZSU1p2SStURmxmWVU2?=
 =?utf-8?B?dFNGTGZrRFl0L0d2TFc5RDVDYUZRcGpZbnRzSnozazBjamFLTXlZNXg0R3Av?=
 =?utf-8?B?cnUwcUZDcGRXbThyWDVRSzlSRDVMN3JUdFgzRUZiMWVNaEpNaXB5ZHFrL1dO?=
 =?utf-8?B?dlBPUWxpT3pKcldkVjhRRlNnZmo1dkRyT0ZpTy9kdDgvQWFFN2hZWWgvWm81?=
 =?utf-8?B?Z0c4NnlHampTMkVDWG9PWm8vNFU0VFExQStmSjZFN3hPTXZPZUNJSEw2TFMy?=
 =?utf-8?B?TTBzOFpybFpTRUljUFJWc3ZBbXhVVFE2eXl4dktFektSZitKTldNSlFpU3lq?=
 =?utf-8?B?VDk4YUcvQXpvc3c2eWI0bFExZVNtbmppcVNRY1JDNXZCOThSMDE5ZVBqWGtk?=
 =?utf-8?Q?h06FQPgcLc2AG0SkjHb/uPv3K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29399e29-5513-42b1-fc29-08dd6d0de263
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 09:00:55.7954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o6Mp8zI3numqQAc6uBs+gW/tLsrFM4/suTszYtHFF3CTJDEaZsxJFRZdzy8o976d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7588
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



On 3/26/25 17:15, Mike Looijmans wrote:
> The "xdp" board went out of production years ago, remove the remnants
> from the U-boot codebase as there is no point in maintaining them.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> 
>   arch/arm/dts/Makefile                         |    1 -
>   .../zynqmp-topic-miamimp-xilinx-xdp-v1r1.dts  |  117 --
>   .../psu_init_gpl.c                            | 1030 -----------------
>   configs/xilinx_zynqmp_virt_defconfig          |    2 +-
>   4 files changed, 1 insertion(+), 1149 deletions(-)
>   delete mode 100644 arch/arm/dts/zynqmp-topic-miamimp-xilinx-xdp-v1r1.dts
>   delete mode 100644 board/xilinx/zynqmp/zynqmp-topic-miamimp-xilinx-xdp-v1r1/psu_init_gpl.c

I still have this board and happy to continue to maintain it.

Cheers,
Michal
