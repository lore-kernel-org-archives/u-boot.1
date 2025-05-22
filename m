Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADDEC54E65
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 05:55:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 540D182E28;
	Thu, 22 May 2025 07:55:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l7qEM9v9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44FC282E31; Thu, 22 May 2025 07:54:59 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3368B82E26
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 07:54:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pxedrxh5FKi6TONUhPuCINxXugcw+ksL+3rSv4toBx5vpTOgAGZGSnG8eLpGqJbAdLMfc92gey5VM1TYjIqAjMuUhQf+fyxzbp37YfBDzeMCmw/HgTm0nRYKQXm11cGPtpHL0Vqb13GCIyQuSUTMOVGG7LCCgqKf0tuMoBsS3hV1XecDjELJdkPnS4erVXsGg2QeY4q2J7Or41vEwHcJleJWw5ke3PO+vbBWXo63A90m0BEd8aWGbJRqyc8hT0ztDw24adsraIozjFa+DyTzeDYeOS1atrBcuHXVNBfqZu9dHFEgsz5XLM7nA+KhonciYqLp02WGBhqW4gIlddvgRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBEXNlwGh2CofAvh3Lv5ln4J1dr6WXvnqDvvipi7AGc=;
 b=WfsWugWLd2MegAvabhbeI5/ogHlotBb5Mk+Nc4NytBT+OdOLNqaTj/oAtj2HMqFd6DZqRKEbZvAeh0dlvsA8dr43zafeX3KSkQ+P3HV8ykROxPNhArUFI3a74u2bxdilzc0Pg208lct4eIg+k0aDih7eZjx8GuZPt3fX2S7nmtGqJfCvUysPsd8jWfsGyf/JPbJIQyXlfJHHT/w1YhTS4+TVGOx3vYDtmMPKz/VEgkgRH037LUz3gcc86AQu8KVyOtgaAX5fYkSrrRPvN1Oow/KLeCaDEppYGTA4iSASWCHk7BSimRtN8cLHRrSNhWsHTphdvTFRXN+I0SebexM5Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBEXNlwGh2CofAvh3Lv5ln4J1dr6WXvnqDvvipi7AGc=;
 b=l7qEM9v9i3FQH/WHSfRcIoO8ubPJCDlV0sBu6mibEb6WPRQKC99F+ZZvApipeWCyMBUIHFkTZh60GNhqDimpjemL22eMeY9/Aezo0PxJS4hlJH9f4NTubqF6qi5JdG297u0zVR7+t3ObwheJD44R++d4BKG92KFiPOU2phFD1ns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB7616.namprd12.prod.outlook.com (2603:10b6:208:427::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 22 May
 2025 05:54:51 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 05:54:51 +0000
Message-ID: <c09545c8-a074-44bf-bac4-778381763a5f@amd.com>
Date: Thu, 22 May 2025 07:54:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 7/7] usb: onboard-hub: Add conditional compilation for
 I2C initialization
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Anand Moon <linux.amoon@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Beniamino Galvani <b.galvani@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 open list <u-boot@lists.denx.de>, "open list:P200"
 <u-boot-amlogic@groups.io>, Wayne Schroeder <raz@chewies.net>
References: <20250509070258.5077-1-linux.amoon@gmail.com>
 <20250509070258.5077-8-linux.amoon@gmail.com>
 <78cb05b6-3014-40f0-947d-f2b8f737fcaa@linaro.org>
 <b581293c-9ab1-4fd5-965a-66469926acb9@cherry.de>
 <CANAwSgQRK4zNot8+R3xXX9SadtJ09H5ApezGApKtt-D2KkBbfA@mail.gmail.com>
 <c5f26b7c-b205-42f6-b315-c50bdf4ff0c0@cherry.de>
 <5c8a4460-6d11-46d0-8863-739c94682120@amd.com>
 <62fd78fc-b82d-4876-9a52-b95b07d3e393@cherry.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <62fd78fc-b82d-4876-9a52-b95b07d3e393@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0157.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::26) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e198cc7-bd22-4222-7c87-08dd98f52b05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWptNm1OZXFYM2tmdFN6a2JrN1JJVW1nQ0xYZVZNc3BMK2FQak16c2FGNTRs?=
 =?utf-8?B?SUR1T253SlBTNWFSa0JZSVhVT3F4Ull2WHBOTkxodUhrR216ekM4dmVnOVpZ?=
 =?utf-8?B?ZzFhMUc3bFJ0Vzlwci8rSllGcjd4cXhwMFVZeTFmTzdhNC9oUFJQYUFnTzlR?=
 =?utf-8?B?L3lPY0RBTTROazhsQXRCUnlYekkwdDFQNEFvWEpmUGY5QisxK3Z0dzJYK0I4?=
 =?utf-8?B?TEZUOEVBNnU0aUxmaWQvc2tHYkt2TEZSd0ZDSTU0cUtWcm14TXZnRkF0eGdk?=
 =?utf-8?B?S0NsbndxaGs5T1NOQWVaNWVxQklDaWl4WEFWeldOYnVLUEVDYS93ZWlYU2Zn?=
 =?utf-8?B?bHhmRnlYNXVRNENQejZvNVBDeVZmWmJCVW9Qc1IxdkdhRFBCYVcwbzBUbkdV?=
 =?utf-8?B?VzBzdmRtcUV5V2diL3MvbUxvb1k3TFhyemt5SjRDeG8raUNaSFZkWStqMS9l?=
 =?utf-8?B?RGp5WTVlQ25JRzFSQzhpWm1zbEVtSDlpT1JSSkFLUlYyRTZUTjdWUVoxYWhC?=
 =?utf-8?B?UVJMNlFHd3hUSkx3MkpXKzlTR25oNkNsb1Z3LzR5eWpEZ293aWhSRWJVRzJQ?=
 =?utf-8?B?Q045VnFIcytCNW1FYmsyL3d0R1owakMxSUxKbUdIYzJEOUk2MVYyMWw5ekJX?=
 =?utf-8?B?NWduT3FEZ3FOejFXNFQ0enRwc080Ny82RE12YkFERkNyOWVtdlYzNUtac0t2?=
 =?utf-8?B?SkdQVDdiMUdwa1dUSFVsVFhkeUdhNHRlYm1PR0hUaXlpRVBsNlN2LzRhU1NM?=
 =?utf-8?B?cGhUTXEreFlXSU12bEZDMkZTdWI4NTJpUG1SM1NiYjUxaE8yZkVHWVJMUC9Z?=
 =?utf-8?B?WjM3OU10TUlMcmNFUm9UUUhFamtsRXp3Z2hDTFBoWlA2aCthRU05NmZrTFJY?=
 =?utf-8?B?KzcwaUJYdkp0TjNVMlZxbGlNUy9sdlJSdEdBVnFFNkFmdng4bCsrQ0xYTzgy?=
 =?utf-8?B?MG5CcUwvVVlqQjFVanZBM1VxQU5vaFhTMFowWXFaVkdibHBhcnUxU2h1QUox?=
 =?utf-8?B?VTA0QzhEeDFnRlYzUkJXa0J1dndQWE1ITk5nMUhuV3ZhOFNQTnNxWU1ISU91?=
 =?utf-8?B?R0hhZ1BBZ29CandsRDc0dnVGUU5ra0tqaGhEWHh3MHZ3L3M0UXlEWnZUcGFZ?=
 =?utf-8?B?T2EzUngzaHYvTFdOdkNaMGpsYlFJaFc2NDVkOHdKUGl3cGxZOWYyMlgrNVdl?=
 =?utf-8?B?bFpZdWlYb3BZS3JyR3NzaXAvNWNZeTVIUWUraEJtSUk1Q3poRDNROVRrak9o?=
 =?utf-8?B?WjJOLzRVZ3VEYk16aUxDYVQ1OVR3R2VCZkJ3bDVzZHBCK0dMeGgrZVBwSWVp?=
 =?utf-8?B?Vk56bUYxWndkMGVUZ21talRjQ2RtS05rTlBQUjJlNjQwN09udjJ4ZHhyL2hG?=
 =?utf-8?B?Sk9MMXZYd2YvWWJZSXlzQ004MTNNa0FXNHArYVp0NXBuZWtjaFJSc00vWVhz?=
 =?utf-8?B?Z2NaVUUrZG5RcWFZaTMwWDlqc01kWndUY2Y3MHE4bmk3MXNERyt3VjR0OXg4?=
 =?utf-8?B?QzVzZmcxTWZzWk05RVRyYTRYaUdUY202alp5WUFwaURYNytmMnlhdk5NQ2ho?=
 =?utf-8?B?em1taTROZ2g5R1pxdWl4Wi83M0NEQW9jR01wQTcwRnMyQnJrRzNDWDVjdmU0?=
 =?utf-8?B?ejZoZ0pQd3lMRkg3NU13QmVQNm54b3NYdTBxM243V04vKzYvM05DTFZGR2JJ?=
 =?utf-8?B?alJWcXZhTFY0dFB5ZmRTV25IbXk0NGd5WkFUTHVhc08vV3BWbVMyZXloQ21L?=
 =?utf-8?B?K1hrRUQyaTZRN1J0b2s3UDlzdkVEVGZCdnE4ODU0akFqTUxYVzZWZVBkWDRs?=
 =?utf-8?B?MFZxWlNpR0gvMlp6cnRZMFBNWDZPQlQrMFg3aXdJQ2twc3l0ZjF5K2MxaDN2?=
 =?utf-8?B?dUY1Z0dSemJjM0hoSUpmZmlzRkdibFlHVGQyQ2JBWTJKVWx4RllLa2FGeTAw?=
 =?utf-8?Q?ex1bFXEnq9w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2FKLzEzMUV6S1ZSUU5ySHZjS0tpMEZhYXdTb20wUkhXZCtJTlFsRHhOdmNW?=
 =?utf-8?B?dFRRbVJ4V2F6MkJuMjNTZktpYktIYUJQaFVHMC9NYnV5OTBzRDJNaXpvZzlL?=
 =?utf-8?B?dVNPVSttMWNzMlNSaVh2d1lucmZ3MkZxa1FyUlhROStGb0Q0K3Bud3M5TGtY?=
 =?utf-8?B?VFBkR01hRFNib29NTkdCYzZUU2VZSUFBSHRnR1grYkF0VE42TE55NGRUS2hT?=
 =?utf-8?B?aGRjSmdqaUN1MTc5bEhib29oNTNlOXdaUUl2cis1dFBBTkwzUTVrZHVhaW1y?=
 =?utf-8?B?bDZvNi9MZ0MwQ2VRVTdTOFY1L2NNVVBlMVE1eEljRWprdnJWQmxpOVBPOWI4?=
 =?utf-8?B?bzg1UjR5VVdWOUdrUDVaYmNndVVXQTQxRkxrV0ZScmtheFgwZjZkQlB5T280?=
 =?utf-8?B?azhCTnRNb2RqbW1pZi9TaUhNdmI4ejlvZWg1MW85T2RXbmFKWm9XZnEzWDlW?=
 =?utf-8?B?Ny8wTlROMnh2blJXRFJaR1FLUG5CbExsVW8vNDB5L0F6NGtHZngrVlpaeHJ5?=
 =?utf-8?B?dUZhcEhMTmloTmxScFlHTmxGaS9FR0xjeGZiN21EUzBla1FtU1h2ZzMzcVpY?=
 =?utf-8?B?eWJJMHpGSmloUkdCNEF5WXQ3MHJWOE1VN2Y2UlFxRjltM1NXN2dnenM3T2F1?=
 =?utf-8?B?SjRObWVJRTVXWlVKem84QjhaNnN5dnA2Uk5QMHZCUUJ2a29qc09zZUVVbmg5?=
 =?utf-8?B?YWliYmR1U2FzT0YzVVFnUDl4QWlXajJKcVV3aDNvVGtOaFMxZjlkU1N0YjFp?=
 =?utf-8?B?dFJxd3U5d3d5c25aNGE4dWlZODBiOVVKbzRyTVlUSkVUbHFHS3JXRjF4N1dH?=
 =?utf-8?B?bnM5R3lXZlBjK2Y4b0V4MHFLR2FjVW9uVWZNdkxkTkJxa2RHb2h6OHFXc2Nq?=
 =?utf-8?B?RXpya25tZEwxOVR0cnZ6MXdRTW5TWndIb0IxSXkzakFmWmE5d2hjQ0dsUzU3?=
 =?utf-8?B?bGpJZkpzcUllTU5NRkt0Q2daZ09lbG1MVXNUTzYxV0VaTkxhOWl5Q2xpaE13?=
 =?utf-8?B?MVE0WE9lcTRZc3h1SlBpNWxwRnV3R2pPcnJEWDN1aEkySkpqcW50L1pNbE8v?=
 =?utf-8?B?eEU0ZTg5bldhSEppZWZNUllscUxEVmNWM29uRXZxbGtaMkJNb2F5VG9iSW50?=
 =?utf-8?B?M1ZMT1VSSkRjUmFlVzhJdkxjdjE4a1UrUTQ5WDkvVk5PR0M4b0NLRDlHbGVp?=
 =?utf-8?B?cVFPQ3lDU042eGZVZEN3dDg2K25KNE9WaE50ODRWR01BRTRaSTVLMGE3NDZp?=
 =?utf-8?B?Nzk5amVNaW5OUDJ6RTZEb2ZrOHhjdzEwU0ZqOStaVVBLZUtVYU05VGZ5VFVG?=
 =?utf-8?B?Mmg4TjZlUlcyTWhZbk5yUXE4M0NDcXo3RExGbHJucDRIR2xmTFdTZXhEQ0lx?=
 =?utf-8?B?eHI5K0NDNkJtUFNscmtwdk5laUpmeUZxcFJFYTJLc2VDcHZFK3psRnRhM3U5?=
 =?utf-8?B?T2VwN3ZrTGxzeWZIZlNXR09ONVJlZFI2bDVnOXlwY2l6NTlZaVpwUE45T0Vu?=
 =?utf-8?B?Z21raHpnWk1xSGZpL0k4T1hQd0tIM21uUWxEWTdwZlYvQVN2YmFka0NxUnJV?=
 =?utf-8?B?MWljQStORHgzcVJLcDNldThQWUY1YXYvZXVaQkd0Z1ZmL3owOTdtVXJTU1VJ?=
 =?utf-8?B?Rm0ybDZpdHhKSEh4WHJ3YW9hb1FMRTRJb3JrVU1yN2piYkd4Z3l0OE9ZZXN2?=
 =?utf-8?B?T1hoYzhaY2RvNjVLcGhKTzEvZHZDajdWdnRscW1zL1c1N2NLNlp2Z0JLRVZE?=
 =?utf-8?B?RXpKMWVMVXZrdnZpbml0bEhoY1FIYjN4OHkxN1hvR1lnTnNqN29JbGxwU1VW?=
 =?utf-8?B?cU1BdFZVV01ndmw4R05EVVlJOWZtQUN6S0F0Q2FJQlUwMjlLeVNiM2NDZjFU?=
 =?utf-8?B?RWkxaVlLM2twTGgzMENZaW91bWU1amJoUURUYjdzcSt2Z29pTXI1bkh3aDlz?=
 =?utf-8?B?bXlEbVNVUU9GL3dLd3U5czU2TndFbUY5ZmRSZ0wxSHVZK2h3RW9hYjFWcXoz?=
 =?utf-8?B?WjUrMExrUGVoVzlKWmlpVjNzMFIxS1k5TGdIV2NHQmtZTXFDRWJ0ajJzd1JO?=
 =?utf-8?B?L1FYQUV1dklldzdsVC9rbkhDQURCNjhRdUNzclQ1c3ljOW9mT1JReTZIeGp0?=
 =?utf-8?Q?cdBhzWGmI5FjgvA6Zl9ff9bMI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e198cc7-bd22-4222-7c87-08dd98f52b05
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 05:54:51.5007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bp0bkNVLyMIK7hZk1XOqC+VWtH1RcSoWEVQvRqopBpRdCqeYgZ4eldT+46WsBk6/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7616
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



On 5/21/25 17:18, Quentin Schulz wrote:
> Hi Michal,
> 
> On 5/21/25 4:34 PM, Michal Simek wrote:
>>
>>
>> On 5/12/25 09:06, Quentin Schulz wrote:
>>> Hi Anand,
>>>
>>> On 5/9/25 7:45 PM, Anand Moon wrote:
>>>> Hi Quentin,
>>>>
>>>> On Fri, 9 May 2025 at 17:21, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>>>
>>>>> Hi Neil, Anand,
>>>>>
>>>>> On 5/9/25 9:57 AM, Neil Armstrong wrote:
>>>>>> On 09/05/2025 09:02, Anand Moon wrote:
>>>>>>> Add conditional compilation for the usb5744_i2c_init() function based
>>>>>>> on the CONFIG_DM_I2C configuration, to avoid compilation failure.
>>>>>>>
>>>>>>>     CC      net/net-common.o
>>>>>>>     AR      net/built-in.o
>>>>>>>     LDS     u-boot.lds
>>>>>>>     LD      u-boot
>>>>>>> aarch64-linux-gnu-ld.bfd: common/usb_onboard_hub.o: in function
>>>>>>> `usb5744_i2c_init':
>>>>>>> /home/amoon/mainline/u-boot/amlogic/u-boot-maineline/common/
>>>>>>> usb_onboard_hub.c:74:(.text.usb5744_i2c_init+0xfc): undefined
>>>>>>> reference to `i2c_get_chip'
>>>>>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
>>>>>>> maineline/common/usb_onboard_hub.c:89:(.text.usb5744_i2c_init+0x1a0):
>>>>>>> undefined reference to `dm_i2c_write'
>>>>>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
>>>>>>> maineline/common/usb_onboard_hub.c:96:(.text.usb5744_i2c_init+0x1c8):
>>>>>>> undefined reference to `dm_i2c_write'
>>>>>>> aarch64-linux-gnu-ld.bfd: /home/amoon/mainline/u-boot/amlogic/u-boot-
>>>>>>> maineline/common/usb_onboard_hub.c:104: (.text.usb5744_i2c_init+0x1f0):
>>>>>>> undefined reference to `dm_i2c_write'
>>>>>>> Segmentation fault (core dumped)
>>>>>>> make: *** [Makefile:1824: u-boot] Error 139
>>>>>>> make: *** Deleting file 'u-boot'
>>>>>>>
>>>>>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>>>>>> ---
>>>>>>>    common/usb_onboard_hub.c | 4 ++++
>>>>>>>    1 file changed, 4 insertions(+)
>>>>>>>
>>>>>>> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
>>>>>>> index 1242513c631..92e3f3a92c9 100644
>>>>>>> --- a/common/usb_onboard_hub.c
>>>>>>> +++ b/common/usb_onboard_hub.c
>>>>>>> @@ -30,6 +30,7 @@ struct onboard_hub_data {
>>>>>>>        int (*init)(struct udevice *dev);
>>>>>>>    };
>>>>>>> +#if CONFIG_IS_ENABLED(DM_I2C)
>>>>>>>    static int usb5744_i2c_init(struct udevice *dev)
>>>>>>>    {
>>>>>>>        /*
>>>>>>> @@ -109,6 +110,7 @@ static int usb5744_i2c_init(struct udevice *dev)
>>>>>>>        return 0;
>>>>>>>    }
>>>>>>> +#endif
>>>>>>>    int usb_onboard_hub_reset(struct udevice *dev)
>>>>>>>    {
>>>>>>> @@ -222,7 +224,9 @@ static const struct onboard_hub_data usb2514_data = {
>>>>>>>    };
>>>>>>>    static const struct onboard_hub_data usb5744_data = {
>>>>>>> +#if CONFIG_IS_ENABLED(DM_I2C)
>>>>>>>        .init = usb5744_i2c_init,
>>>>>>> +#endif
>>>>>>>        .power_on_delay_us = 1000,
>>>>>>>        .reset_us = 5,
>>>>>>>    };
>>>>>>
>>>>>> I think you should completely disable usb5744_data in this case
>>>>>>
>>>>>
>>>>> I would recommend to go the same route as the Linux kernel which has a
>>>>> special Kconfig option for it, c.f. USB_ONBOARD_DEV_USB5744 which adds
>>>>> the necessary dependencies.
>>>>>
>>>> On Linux kernel, it needs to parse the device node with i2c-bus.
>>>>
>>>
>>> Seems like it does in U-Boot too? c.f. usb5744_i2c_init() with 
>>> dev_read_phandle_with_args with i2c-bus?
>>>
>>>>> We probably should be careful and figure out which boards are actually
>>>>> using the usb5744 and add this symbol to their defconfig so they don't
>>>>> regress.
>>>>>
>>>>  From my initial analysis configs/xilinx_zynqmp_kria_defconfig
>>>> which use CONFIG_USB_ONBOARD_HUB
>>>> I believe using DM_I2C to guard the code is the best approach.
>>>> it should be around .init() callback to guard this to work.
>>>>
>>>
>>> I disagree. The driver clearly supports the USB5744 and the driver is 
>>> compiled regardless of DM_I2C support which is required (as far as I 
>>> understood, maybe that's incorrect?) for being able to use USB5744? I don't 
>>> like hidden dependencies.
>>>
>>> Also, I believe Neil's point is we shouldn't try to probe the USB5744 if 
>>> there is no DM_I2C support, simply excluding .init() callback will probably 
>>> just render this "support" of USB5744 non-functional?
>>
>> USB5744 can be configured differently. We are using two configurations.
>> 1. no initialization over i2c
>> (but still you can have a need to have driver for reset or power)
> 
> Fair enough, some hubs are configured "properly" by default so don't necessarily 
> need an interface. Such is the case for the Cypress HX3 we use on RK3399 Puma 
> for example. The default is enough so we don't need the i2c interface even 
> though it's exposed by the IC. Thanks for the reminder.
> 
>> 2. initialization over i2c to start the hub
>>
>> And there is also one more configuration via SPI.
>>
>> It means I don't think DM_I2C should be real dependency on getting usb5744 to 
>> operate.
>>
> 
> Would diverge from how it's handled in the kernel (today) though.
> 
> Can we please follow the same logic as in the kernel though? Meaning we should 
> report some message if the i2c-bus property is present but DM_I2C is not 
> enabled, in which case it's likely a misconfiguration of the bootloader.

Make sense.

M
