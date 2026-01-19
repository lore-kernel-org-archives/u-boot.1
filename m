Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61216CA5FFB
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 08:08:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5F0680B98;
	Mon, 19 Jan 2026 09:08:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZaJQQtKj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4444E83015; Mon, 19 Jan 2026 09:08:20 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAAA0800AE
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 09:08:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CNEivLEO5ftH++QxPCMja/ZMIL+pCHCwN1M6897yGdK4gp8TYzXw4CZ8JuJJhQpB+YnpkUOynYtePx8N2M+jBf+ftlflfkIR/0hFkQv5IghqEOOSQxr0abQ9/yUlp/KiDHZFYtP3oDFNOOfKacrB0INA4FrJK+3cYhj3GOt5o/j7ba0EK8/tXg50T5s9F8lQcZFkk4XvIK6V+LZTGZdgiQU87WjV+/B5uH911qwW9DC5Z+lVflc4/gHePW5DVFYdnnSc8pztKSQfLNAjuCs5eZxicaWqkN74i0lPx09vIlfhgFTXkVi03BVlBvSNVxrXwB7OgmefMshYxPwlFI8XGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkrL/gd+fVCaPH6/2+PQkCszbNp2eC1TNZuZtVjapF4=;
 b=ir0aUV+peWdhz1BO/gTqotCJ2Dnql0dujj/W+cLYw1YGb8Q9wj3nW337ft9JgWHCs2uwGFdf7n4XgOR2rvAOo7yvclCjprW8KybE9uXSBrYOwksuNdfLjYd76svzsdO6cROoGGnVqCy5/V0TECILwvHLjizpvvC3XLYtl6M7fbsqYUy8T+KW2QVPBfiEMNqU+td0Zgnbcvfm4FvwjaQCmXdyl53K01ZK27SpSqErl2tQNwb+O0ahieCWcKHk8d7ll1fTVNf04b+GKk7WVa2NQu+2jevg+EQ2GQv/yDN6PI0d0uOmXpSiGybgfPGwa0JYITx2qJIqfCzRRtq14WCjkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkrL/gd+fVCaPH6/2+PQkCszbNp2eC1TNZuZtVjapF4=;
 b=ZaJQQtKjsADQx3LGG0KIGkKOo9Dtu7kuLc/qJzN9q87tmaZcnX6c4XWDqqQleudeDCxQB8P0MXUtV2EmgyTO2Ndeojg9wTICWRwJbXuTui2e3V/JHNDPA9ag716MD4mG1hm0iOipq5izm5VMTblMEHF4vPc1+l5teWkLL8xAUtE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BY5PR12MB4212.namprd12.prod.outlook.com (2603:10b6:a03:202::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 08:08:13 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 08:08:13 +0000
Message-ID: <aac874ec-a52d-4197-b7cc-d75f748b2451@amd.com>
Date: Mon, 19 Jan 2026 09:08:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: zynqmp: Add SPL support
To: Sean Anderson <sean.anderson@linux.dev>, u-boot@lists.denx.de
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>
References: <20260106224202.754923-1-sean.anderson@linux.dev>
 <960bd4b8-3643-4e78-ae70-b29453ae083d@amd.com>
 <9377f5ad-4118-481b-adc8-49048691c9f6@linux.dev>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <9377f5ad-4118-481b-adc8-49048691c9f6@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::13) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BY5PR12MB4212:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e963f62-0cf7-4328-8c77-08de5731e445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YkFxNllPNlNYWW9zaVRncno4T3BUM3duUVYvdUFKU2p4VzB0b3VkWGs1d04x?=
 =?utf-8?B?ZVlsTlQxRVYzSld6Qi9aSjBLMVdhRFgrUFh2bE16ZVlvZ2RYcCtMUTF5MytW?=
 =?utf-8?B?eUFMREZUWUhGZUhYYzlqQUlCeFZjUVk1Q0xHUGF3WG51aHNvQW1PcU5HUmF4?=
 =?utf-8?B?TERLYlMvQUg2WkN2MjY5aSsrVWNuVDE5d1ZzMDVOc1BVSmowMWNZMjBTb1JY?=
 =?utf-8?B?SHVGYVNDY3hlMnphcXFHSkF6VlpMeW9vUFdTVzFlWDRxSGRqdjlHZ0ZDcVdP?=
 =?utf-8?B?eEo3bWpmUE83RlZxSzJhZ0dReFJ4eHdLdkZ6aVRnQ24rTzNXYjVPbFQ4L0hw?=
 =?utf-8?B?Z1U0ci9CUHJVc3EvWUJ4clRrU3F0VDJ5bG4yRC9CNnRza3BUOWtLSXhXTnND?=
 =?utf-8?B?dnZjT2NvRjM5bHZ5RmdpUUZockxyc3hmQkkyS2xIaEVRL2lLRGxpc1VkQmJ4?=
 =?utf-8?B?d210dUJPN0JlUGJyWkpPdnZEWXF5Q003RldDeDBodC9maVRmNUdMOXlyeXFh?=
 =?utf-8?B?UW5JSXprbXdjTDlKUlAvVWxuMEo1TUo5ZHFQMVRjdkdpbE9jL291dTRBcnZZ?=
 =?utf-8?B?YUlPYWlSeWJuc1B0aEJTdGxuMTZ3V1dXQ2dNMk1NYkplZCt3dXVnYkY3Mm9T?=
 =?utf-8?B?WWcyUUszSGpoQTIrZXJyNnBRdVI1aXJJdE1nenpuT3orM0lyeVRPNzkvODV0?=
 =?utf-8?B?eVA1WThLWFVkNFZ0dTZBK20zYkI0dGgvQk04QlV0QWMxeXVINFMxcWtUOEtX?=
 =?utf-8?B?Rkw3S1lGNS9XazFyZzlKNEFud2NsRktyb011dzdlMkwzazVYU1MxYUNQUkUw?=
 =?utf-8?B?T3RXWkdGWnZ3blZYMDJoekN6NG5FQ1kyUk9YZyt1UXJPMTVnU2NFbWlJOGZW?=
 =?utf-8?B?OUNLU2E4SEIwSy9ZM3JuNUZXdG1KK0dSZ28wWWZWUkk5d2dObUFCRnF6a1Rl?=
 =?utf-8?B?bHBGUEFjdU42QnltZVdBNjhITWtPcm1RaWpFU2VZaDdmd2NhR1drWmtrTS9l?=
 =?utf-8?B?a0lOU0JhYmc2dXAwSjUzMSs2TjJ1SVVSSDRUcnhUenRKK1c2UFZVV1dQc1Bu?=
 =?utf-8?B?THBFeG9qdUptZWk2SFc0YXZWY29DVmJiRFpkblJFWHBPQU0xVzgxb3d0WGFv?=
 =?utf-8?B?dE1LVzF3d0FSTnk4ZURyN2Mra2V3akJJb3ZhTTNRbUhJcm5lYUVpUW9PeWJL?=
 =?utf-8?B?MFU4bEc1aGdSRE01bzBUNFlWajVhS0oycjJVdjFxVVJaZ21STk9PQWlsWVND?=
 =?utf-8?B?eWFsSWVxTWRDSXQ4WE0vTGFTN1FRdkd0SUhEeEtyTmlJdGswYTh6bzdsRVpG?=
 =?utf-8?B?aERNZFowYjJJeGE1c1VpVFlxcE1KK252emUvVXJmcFBMM1hHbzRNa1hsRUt6?=
 =?utf-8?B?N256OEVKQktrVmE3R3FwRE8rWE4yeTM0OWV6bWljTmhBdTJRZGFFeHdtVUkr?=
 =?utf-8?B?N25KS3FkUThaK0cxeHIxREMxb1JrZlY2VTRWQUwrMkNkZkVBYUJ0KzBBUDJX?=
 =?utf-8?B?UXhGVlZTSGh6eHRoNmxUSmhtZVJLbmtDVHJYUThNVzhuTHdyTWhSOW1xYThG?=
 =?utf-8?B?U1RtSmV2dFY2enRxMHN4UkVIdXN0eFFUYTBDcWpaZGVwNlJSMWh5cm5MZnps?=
 =?utf-8?B?L0FYQkZrZGcxemtSU0U3VVdkWGVTdjdSK1FrNVllVlE5b1lwR09yQUlvcTlG?=
 =?utf-8?B?YnpqdHhHWkRiWlJaekNUN3dFK2tZT3BheVZEQUk3VkFURC8yTGtXbW9sdzhB?=
 =?utf-8?B?Q0xqcklVdVdsOEEyZW5qZFpqRDl0SjRsU09yYnJURlo3UVd4d0VxZ2NRb0Uv?=
 =?utf-8?B?ZkZvb2RrRmRIeGtEbUdEL2FVVVV4c1JFVHhiYmtsTC9PMVJaOXFERFBKeGVQ?=
 =?utf-8?B?MmxKODF1dlc1TVZiaER1SkNvRDFHaVN2VHZzMkF4V1Y2SHVLVG9ST1ZLWkJG?=
 =?utf-8?B?MFBiL2hHRmhGM3FIOE1OVXYyRGp0QXNVUWtrWDNRRTk2K043N3l1MWZPZkQw?=
 =?utf-8?B?M2ZjNlNxMENpdUVDTUNjSmlTODU2SmwyTE9XOXhtVTdmb0FxbzZMdDRYb2ZL?=
 =?utf-8?B?UTNwSGp5LzcxeG8wTFJvTi9WWENhSTFudXI1bXY0RG4rVHhMbFljbDkvSCtN?=
 =?utf-8?Q?TX9Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzZBVEpWaElNZGdlbFlIMHFqS0dtMndtQXdCZFNBcVJ1UTQySFV3dllLVTNh?=
 =?utf-8?B?cjgwYzlTMk5vR2RuVHFEVGJnNDg3aWhsZi9ONUlteWlRWFJLRG9naG5PUUpS?=
 =?utf-8?B?NXNaMURTbVcvazBydGN0bzFON2txMmxyN1BwbTlDOGgrMDFWWFVBNzJRK1dP?=
 =?utf-8?B?T1BqeUxKRVhwSnBVbnplTVF1ck1kRnZCdCsyd0pGaTRDZGN2U2NnWEhYYkpY?=
 =?utf-8?B?Nmtmdm9LSFpjS0xDeDVnKytTWFZ6TlhCV25kN0dGbDNMaVQzSTdqWk9QNzBK?=
 =?utf-8?B?VEJLRU9JSU5FZ3NxRng2Qk1YWDM0QjF6N1ZVRDFiajdoWHRLVmlsQ1VRblZy?=
 =?utf-8?B?QXpuT0tuZGVtMVlRZEtNemk5WGpOZXBQSnRwTzR4dUJoaVFZblduaVZ0UEVi?=
 =?utf-8?B?N2hNdG53aUJIWkowSHUza0NaMWRTWmMzL3NjbjZPZk16YXVBTU9TZDVVQnVt?=
 =?utf-8?B?RWFBTHhkYlJJQjV4N3lCT0tTN2ZjZUN1SlZnb0ZlQ2RUai9Obk9VR05renVm?=
 =?utf-8?B?azFqUmZNL0RjcUxTNGlsbS9xWjNuSWFzaFFDOVdzYVplbWJpbFVFbExuT0hZ?=
 =?utf-8?B?OHZ6NGRENVRqbkl4RE9ZK3B4dEltYklHZWE2VUhWMG1BQ2JFL3VtWlVQWkM0?=
 =?utf-8?B?NnB2S2pjVE5iL0xVM1ZWZW5LNHg3aGVvbW1od2tQTVZIRGV0V1R3SDNzNUw0?=
 =?utf-8?B?Q0FDeWRlanpCK3I1Z0xOZ0tsUDdndnNSK2tlV3JLV2dGUG5UWVd6bzFxNUR6?=
 =?utf-8?B?QndDb003b2MvNkJJWEh4NVM3NFZIeGsrdlFwNWEzczlmLzAxbiswaFZNWWl4?=
 =?utf-8?B?R3YwSjRMNjBXMEoza09vK2ZTZWYyb1NyWUUyT1MyY0JwOTJ2V3l4Z0FMWmJ5?=
 =?utf-8?B?YnlXVVdxcFdmdUtuS3BIMlp1M1czUlhiZ1o1YlFmRjNBOEU5MmRnSGFpdkVU?=
 =?utf-8?B?ajBxeVRHSkVIelNHck10bVRKUzZOcGdzY1lmWldQQm9iY3NvdzNkcGpjaDhO?=
 =?utf-8?B?MG1BS1dWMGJXVGgvOVBZVVB6eForcDU3RExGTEZJZjF2cE9XWkRyMnFYYUlj?=
 =?utf-8?B?NktrVmFPa1VMZGo3ditQUHhiaGJiMFl6UkVmNDZncWNWWnlLY3NwM2drdjU2?=
 =?utf-8?B?OFRQV1QxbHA0Z2l2UWduMG1ORHZpNmdhaTFMSXhRZTUrYU01eXh1V01OS0tT?=
 =?utf-8?B?SGdacVFHK25HeWJ6eWZxaE8vZEtwSi9xNjk5bU5aY2Z2ZU5aVEpVQkhyODR0?=
 =?utf-8?B?b3hoYTFTaC92VXRuKy9yb2xheUhpY2lVTkpZQ1lVUnIxZ2l0SFhmWGpYQ2ov?=
 =?utf-8?B?RVFvT0pFU2FaNDBxVTg2NG5mVTVreFFxeUc0RjlHODRUZWVwUUovT3Y3MmFy?=
 =?utf-8?B?S0hveWh4Tm54RW9IYXVaZk5xaVJOWW1Cd0RER2p3aU1rcSt0bjVpUmVtQjdY?=
 =?utf-8?B?ZjJIVTByS0kxL2ZYUmhrcno5SWRPVFAyNENOSGNKWkl6bko2YUNhazBhY2Fr?=
 =?utf-8?B?ZTVmYms3QUhqczBSUzFQNy9WcHZqQnBmQ3M5OHF3Q1l3KzNFUkJQd09oc3Jw?=
 =?utf-8?B?SmU1QXF5b0txOGgyMTN4b0cvYnkycEo0dmdvVUlCQlRjbGMzL1Z2NGxLYlhv?=
 =?utf-8?B?WjZKZ3VobkVvVkFoYWZNaTdJOHQyRUxtc21MMisvaEV5MVdZbG5wTUhDRCtD?=
 =?utf-8?B?U3diOUtSL3NrNDJleU9RSVdCMHc2YUxicnpYbmpPUEZHc3NvaWFmbGc3OUVH?=
 =?utf-8?B?VlUyRHVvcGZROFlrZXlGV01nbVdrbExNNUlGRXAvNGZ1SDhvNWlkYzY3cTB4?=
 =?utf-8?B?WTZhR2JGekhZZXJpQmx4VThJZzJ3NUd4Si95Mm5KWlJocjJrT1dNVzByMkYz?=
 =?utf-8?B?bFdhZldRTkhRQlRZQ2YrNHVSNjRxODg3L0hQb2VaalRUUGd2ZUZpb0ZkMDIr?=
 =?utf-8?B?V1hWeTVqWjF2NURXazJvTUlpOSs0ZmZ5SWw5Yjk4UG1JNnZHbjlJdzJsZ21q?=
 =?utf-8?B?WjZIaTFoanV4aVgyNno2eER2TS8vclpNcExNb2pqcklqYkx1R1pzdUtiUnpV?=
 =?utf-8?B?ekJuaXc0ZERGNUdyeVZ5dDZsRmcyMmtCaTVtV0VBeHpZWXZjS3FzMTVmSzda?=
 =?utf-8?B?cTBhaHI3d0JkOU53ZDVNYW5TaDlyYXhONGlRZ3lIWm5PNCtZRzJoMHNkOFhB?=
 =?utf-8?B?eXZFd3ptMVRkV3VGOTRGQklld1ppOTBhRm02emtOTWYrR1oxMytQekxSbFQz?=
 =?utf-8?B?cWZBcEJNUGdxWXRFbUEwRUZnSTMrd0EzeXJPK1JYOXNzR0k1N3kzL3FmYyti?=
 =?utf-8?B?RmhmMGZvZHM0OXlCUDFGVnBnbjgvT25WOUxCb0wyNlAwVGpuSzAzZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e963f62-0cf7-4328-8c77-08de5731e445
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 08:08:12.9493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9azkvNCfCyCQcOogZh5xEcYEwB1u0++shO28HVm+G429LRMOdIW024A0hPj62FXD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4212
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



On 1/16/26 16:59, Sean Anderson wrote:
> On 1/16/26 03:17, Michal Simek wrote:
>>
>>
>> On 1/6/26 23:42, Sean Anderson wrote:
>>> Although the pinctrl pm requests are implemented in the PMU firmware,
>>> PM_QUERY_DATA is actually implemented in ATF. In SPL (or when running in
>>> EL3), ATF is not yet running, so we need to implement this API
>>> ourselves. Do the bare minimum, allowing SPL to enumerate functions, but
>>> don't bother with groups. Groups take up a lot of space, and can be
>>> emulated with pins. For example, a node like
>>>
>>>      display-port {
>>>          mux {
>>>              groups = "dpaux0_1";
>>>              function = "dpaux0";
>>>          };
>>>      };
>>>
>>> can be replaced by
>>>
>>>      display-port {
>>>          mux {
>>>              pins = "MIO34", "MIO35", "MIO36", "MIO37";
>>>              function = "dpaux0";
>>>          };
>>>      };
>>>
>>> While this isn't backwards-compatible with existing devicetrees, it's
>>> more than enough for SPL where we may only need to mux one or two pins.
>>>
>>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>>> ---
>>>
>>>    drivers/firmware/firmware-zynqmp.c | 100 +++++++++++++++++++++++++++++
>>>    1 file changed, 100 insertions(+)
>>>
>>> diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
>>> index f8a9945c1da..77911757177 100644
>>> --- a/drivers/firmware/firmware-zynqmp.c
>>> +++ b/drivers/firmware/firmware-zynqmp.c
>>> @@ -427,6 +427,102 @@ U_BOOT_DRIVER(zynqmp_power) = {
>>>    };
>>>    #endif
>>>    +static const char *const pinctrl_functions[] = {
>>> +    "can0",
>>> +    "can1",
>>> +    "ethernet0",
>>> +    "ethernet1",
>>> +    "ethernet2",
>>> +    "ethernet3",
>>> +    "gemtsu0",
>>> +    "gpio0",
>>> +    "i2c0",
>>> +    "i2c1",
>>> +    "mdio0",
>>> +    "mdio1",
>>> +    "mdio2",
>>> +    "mdio3",
>>> +    "qspi0",
>>> +    "qspi_fbclk",
>>> +    "qspi_ss",
>>> +    "spi0",
>>> +    "spi1",
>>> +    "spi0_ss",
>>> +    "spi1_ss",
>>> +    "sdio0",
>>> +    "sdio0_pc",
>>> +    "sdio0_cd",
>>> +    "sdio0_wp",
>>> +    "sdio1",
>>> +    "sdio1_pc",
>>> +    "sdio1_cd",
>>> +    "sdio1_wp",
>>> +    "nand0",
>>> +    "nand0_ce",
>>> +    "nand0_rb",
>>> +    "nand0_dqs",
>>> +    "ttc0_clk",
>>> +    "ttc0_wav",
>>> +    "ttc1_clk",
>>> +    "ttc1_wav",
>>> +    "ttc2_clk",
>>> +    "ttc2_wav",
>>> +    "ttc3_clk",
>>> +    "ttc3_wav",
>>> +    "uart0",
>>> +    "uart1",
>>> +    "usb0",
>>> +    "usb1",
>>> +    "swdt0_clk",
>>> +    "swdt0_rst",
>>> +    "swdt1_clk",
>>> +    "swdt1_rst",
>>> +    "pmu0",
>>> +    "pcie0",
>>> +    "csu0",
>>> +    "dpaux0",
>>> +    "pjtag0",
>>> +    "trace0",
>>> +    "trace0_clk",
>>> +    "testscan0",
>>> +};
>>> +
>>> +/*
>>> + * PM_QUERY_DATA is implemented by ATF and not the PMU firmware, so we have to
>>> + * emulate it in SPL. Just implement functions/pins since the groups take up a
>>> + * lot of rodata and are mostly superfluous.
>>> + */
>>> +static int zynqmp_pm_query_data(enum pm_query_id qid, u32 arg1, u32 arg2,
>>> +                u32 *ret_payload)
>>> +{
>>> +    switch (qid) {
>>> +    case PM_QID_PINCTRL_GET_NUM_PINS:
>>> +        ret_payload[1] = 78;
>>
>> Macro for this value please.
> 
> Why? This value is used exactly once, and its semantics can be
> directly inferred from the previous line.

But it is not clear what this is referring to. I expect it is amount of MIO PINs 
but macro name would make it clear that it is not random number.

> 
>>> +        ret_payload[0] = 0;
>>> +        return 0;
>>> +    case PM_QID_PINCTRL_GET_NUM_FUNCTIONS:
>>> +        ret_payload[1] = ARRAY_SIZE(pinctrl_functions);
>>> +        ret_payload[0] = 0;
>>> +        return 0;
>>> +    case PM_QID_PINCTRL_GET_NUM_FUNCTION_GROUPS:
>>> +        ret_payload[1] = 0;
>>> +        ret_payload[0] = 0;
>>> +        return 0;
>>> +    case PM_QID_PINCTRL_GET_FUNCTION_NAME:
>>> +        memset(ret_payload, 0, 16);
>>
>> Where is this 16 coming from? I expect this is max number of chars of function.
> 
> Yes. It comes from ATF. I can move MAX_FUNC_NAME_LEN to
> include/zynqmp_firmware.h so we can use it here.
> 
>>> +        strcpy((char *)ret_payload, pinctrl_functions[arg1]);
>>
>> you should check that arg1 is between 0 and array size not to read value behind.
> 
> This is guaranteed by the loop condition in zynqmp_pinctrl_probe. I can
> add an assert, but we have one internal user so we don't really need
> validation beyond what would be necessary for something like

But you never know who use/call this code in future.

> 
> 	for (i = 0; i < ARRAY_SIZE(pinctrl_functions); i++)
> 		pinctrl_functions[i];
> 
>>> +        return 0;
>>> +    case PM_QID_PINCTRL_GET_FUNCTION_GROUPS:
>>> +    case PM_QID_PINCTRL_GET_PIN_GROUPS:
>>> +        memset(ret_payload + 1, 0xff, 12);
>>
>> Where is this 12 coming from? Macro for it.
> 
> NUM_GROUPS_PER_RESP * sizeof(u16)

much better.

> 
>>> +        ret_payload[0] = 0;
>>> +        return 0;
>>> +    default:
>>> +        ret_payload[0] = 1;
>>> +        return 1;
>>> +    }
>>> +}
>>> +
>>>    smc_call_handler_t __data smc_call_handler;
>>>      static int smc_call_legacy(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
>>> @@ -493,6 +589,10 @@ int __maybe_unused xilinx_pm_request(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
>>>              __func__, current_el(), api_id, arg0, arg1, arg2, arg3, arg4, arg5);
>>>          if (IS_ENABLED(CONFIG_XPL_BUILD) || current_el() == 3) {
>>> +        if (IS_ENABLED(CONFIG_ARCH_ZYNQMP) &&
>>> +            IS_ENABLED(CONFIG_PINCTRL_ZYNQMP) &&
>>
>> This logic have to change a little bit.
>> There is also CONFIG_SPL_PINCTRL symbol which likely needs to be enabled. But if it is not still this code ends in SPL and just extend binary.
> 
> PINCTRL_ZYNQMP is not enabled in any defconfig for U-Boot proper, so it
> will not normally be enabled in SPL either.

It is in xilinx_zynqmp_kria_defconfig

Thanks,
Michal
