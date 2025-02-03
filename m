Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C70DC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 15:23:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98A3180079;
	Mon,  3 Feb 2025 16:23:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x6qi5bdg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FE4E800CF; Mon,  3 Feb 2025 16:23:03 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF35080077
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 16:23:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LkXrXBhB+DUHd6FQMlM9qClgYdOHXV5vPRSFqawDAoUNvQNgkta9eOPr+2/CXZf3WhIRRz7xbcYlcKEkGZg4jcJcFMz9slzuF741q1o9hHpnb6aeOI/4mc62G0H+FOpRXO/AujgEa+Cltaj0VOYDqG33wDvzmRtTwZT7lPIy+NfrgfCE0jkk/lgtXm6PcmchBSBjfmqA9W6qZza78FNTQtqd8CUGtcW70pHpgEGn7D8Qanj0BKeS8TLu5B+RXZUAAcmucw+DW6Yk8ZSiDTNeKFZNwnyDyBdwOFsDHSwCoR90mIWv/e2arDBsZrRrT1g4bVcJkVE9VHuaVEU8+D9U6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdGe+pwtfOFfjoeTeXRS70Y1bROymKTST149//wbK0k=;
 b=aH9cIxdzUY8DykdfGYKrCx5gOYJsxVdcUqxcAZevFt9geelTTLW9bt7S3UIlqOHbYW3l5+0YLyG4zE8v85Oxw6HCWVB814d8qrvkaw/1rUB4P3LYKyTojM05ohF7Rai9+8gXMyktbhLFe/may4ne6QsEnoHSqf3BwwUrau47ja7/Oo3RgFuopXrRrECoEU4nygcFKdUjEu9vDPtjIrWwbYK+SuMoEI9NTuYf6OcWw2A8VF4GEeC8VSBID2RlQU/WXfHhNu2jNCbWRAUBCyWva60OfNkSGkt5qIcfc3bVyKlQZjkDhMx+GlYVver8YpovVrnFBts4CvnpMT4s2TSKJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdGe+pwtfOFfjoeTeXRS70Y1bROymKTST149//wbK0k=;
 b=x6qi5bdg/YcGIm6NLKKHCJd/eyoXyNrFAO+d1CdWfzLwHD4yPEVjdz0Dvbcg7cB+o8bjh4NrE09SpMcrVL9YHlROjQlixl7k8r55oxrMWeoWNNMYMBk8zOPa7G7IRwBR6+EtkTHbdOlpy/l+WM/PNBN0IkVqKCZlbvAikQDSVpw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS7PR12MB6072.namprd12.prod.outlook.com (2603:10b6:8:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 15:22:57 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 15:22:57 +0000
Message-ID: <dfc58bae-06c7-484f-be1b-a3c5acf58cd3@amd.com>
Date: Mon, 3 Feb 2025 16:22:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: Kconfig: Select DM_RNG for LWIP
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, git@xilinx.com, Adriano Cordova
 <adrianox@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
References: <a594ad9352a4935df53d664a951473a2b1f5fafb.1738594978.git.michal.simek@amd.com>
 <CAC_iWjJ05Ge10G8KgXEqb7zuRboYxH7KVQC8FdrjptTfTpZ74g@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAC_iWjJ05Ge10G8KgXEqb7zuRboYxH7KVQC8FdrjptTfTpZ74g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0010.eurprd08.prod.outlook.com
 (2603:10a6:803:104::23) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS7PR12MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: e17f5c7f-3aff-4bb7-b848-08dd4466a352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WE9Sdm5VRUtuMXkrb1hsQWVjNUJjOHp1dHBkM1FoYkM4N3FaN3pYUTlIaGNR?=
 =?utf-8?B?eC9xZzhBSDhERlZZRE1mL0NvdDJiUnJkWGJMWWhEMjVFK2hxeGpES1Eza2lp?=
 =?utf-8?B?aGJTdmFLUDZtMDlrdlI1M1liYlFYOVZ4S3FKZVFDamprd0N1WWxyUXR2cHJp?=
 =?utf-8?B?cHlSSnBZb2E5ZE11ck96ZklzbUUxT0taaTA0QVN5SzRhTGV5cis5MHhzQmV5?=
 =?utf-8?B?NUJNcE5BSmoyMjArU2xUZTVlVldQL1MvTGJHb0ZuRmhwWkhtVE5zRVkycFVP?=
 =?utf-8?B?RHNJNnVXN2hHaVhxTGV5UUdpelNlMGR6S0lMRXBEc2cxWkVtd3VSZHcwMXB2?=
 =?utf-8?B?SXBJU3JpTjRTL1BuTmdsSU0zbjU3SFZYRDc0bVRhY0hrWHZCNkZPTElteGg0?=
 =?utf-8?B?ZFNCQTNkM1FTcHRDYUhnR2ZYWEZQOUZ0YjRCTG81T1ZDQTV6ZDNsQjBVbXR2?=
 =?utf-8?B?SDRNV3o0c1dLTjRCT0FjRG5xQWJzQjFvUHR0NmdjcmVoYXJubjNZZGtNMlRz?=
 =?utf-8?B?SGtxR2w3alZRbUtYUmU5U0NGVWdxdnFQQTNNNWFaZm9rZERkZURrMzd4TzFL?=
 =?utf-8?B?STdRRW03QmZqSHRTbVMxSjcrNzNiUG1VVmFmLzVEUjJzRCtBblI3Nm8wYURt?=
 =?utf-8?B?Yk00cVdzWUJJUk9YdS9NcWhpdXVnYm1jYnFYT21hdlN2aEI4TXNJUnJhcHJ2?=
 =?utf-8?B?ZExOY0MxYWV4aGRuYjBXdEhrZlZRZElFcTVYQlZIRWhpcS9hUnFkWnhPZ2Fq?=
 =?utf-8?B?MlY0RGtNN0g2NE43ZjBpOUZqV2d6TU5FWnFtSmFtWndlMTlxSzA5N3FPM0t3?=
 =?utf-8?B?MjVUNjVjcUdlUDYwUTlEZ0U5d3NFY1ZsNUdPZFp3VVVLN3BIVE1GY1BFK0pM?=
 =?utf-8?B?dUFCNEhSVFN2R0hCOGpIM2hhMUE4Wm0ybkREZ3pJTStGNHFkSXEzVFB5TUNO?=
 =?utf-8?B?Mjdtei90d1MvN3RMUG1USjk1enV6eENxeHRVbkRLTGhqb21ld1RtTEVFVTcx?=
 =?utf-8?B?UmxDVHNHQm9PdWd1VEhrdzFOZXd6U1dyTjUycTJRSGdGUTYzS1NWK3VXcDAz?=
 =?utf-8?B?dHV4SlljMFN0QW9RQWJZWThVaENPcHFCcVhSWUhxdUtidmx3NUZmdnJxQXNv?=
 =?utf-8?B?NmpqVDgxRXB2VzJnYXlaTGN3NXEycyswZWNtUnh4MlcvNXJHSGU3WlBCckl6?=
 =?utf-8?B?QnMzNmc4cnhKM2c2a0dVSVBjckNiMnc3RGhGaDU0bFN3K21HQU1lbzRFSnA4?=
 =?utf-8?B?VTVsMWIrMGpUeDRDYmNpWXVSeWYrMGNRNnQvUVEvQUFMWXByUCtheFZLTXVX?=
 =?utf-8?B?VlZhdS9PS3NuU0tmQmZSQlRUMERNSmVQUitsdDgvQU5DblZtaWd3cEhvWXQ1?=
 =?utf-8?B?dDhNNUdIcW42Y3hqcllnQTNQS0w4R0tJaVozbUtlUlpFblM5UVFmYUpKak02?=
 =?utf-8?B?WGxQVTlLREcxSlJBY2RvQk5tVlRPaHFld3Jxa1g1azVmTG96NEZhWFpQd0ow?=
 =?utf-8?B?dlQ5ZjEzelBrR2NWUUcwb1VLaHd6QUpSMWZmMCtySHUvS05abjFJUlVCSVNp?=
 =?utf-8?B?REMydjNBVEZibnkzY0xNVWhmTkJFZGpOYW5xNVllQWlZdzhDWmZ4N1B5Lzli?=
 =?utf-8?B?YXFyNU9mMS8wMjN5SHhDbUxxMTJickNhay80TzMyd1VlWVFFc25jbVNhWEQ1?=
 =?utf-8?B?bkdTR21xdUtzTHpUejZrVGd0cWoyYWRYNEtYSFBZQmVicmxuN2VQMk8vOW9S?=
 =?utf-8?B?YThXVjBXb1pTV2pYL3Z5YjcwQ2hISTljUnF5cFdnM1dhMjkxWFlNanFKQm5K?=
 =?utf-8?B?ektjbXhmMGFNdjVjNzNOOXd5ZWpmRTZ0UXNyc05KaVp5cUsxMnZYTmpNMlpa?=
 =?utf-8?Q?J8wk6dYO8nbX7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3NNeFpxby9yZGdxTDJXbDBkSVNLdlgxTE9rLzRuN2JVVVFCKzBFK2E2VjdS?=
 =?utf-8?B?Q2hOeXhETlZHN3pDM0thYVZBU0lRTU1Ld0Z1NEFkN0Z4VS9CNFF0eS9SQ2dy?=
 =?utf-8?B?QjNySDJ2M2YxUVRMNXY3Y013ZUFtSU5WK2R4eDNVU1ZqNmlCRnd1RUdtTE9F?=
 =?utf-8?B?SDY1bWxUTm1wVk1YNTFaMElpQzFhWlp6eVFxRk0vdHl2cGhFZUY4bDRnQU5o?=
 =?utf-8?B?MW9JS0FJZm1ORlhIbTN6ZzVPOUJVcHRSZkZydDhuWXp5cDFPalFLa1VDM1Nz?=
 =?utf-8?B?a0ZNVkhpdDAxVDY1VXZZT3VMUFJSUHJlNHF4UjlhNDhYa2NjOVdBWVU1S0FC?=
 =?utf-8?B?b2wycXJmbXpndzE3TzNsZVB1NVpJZ2lLUVZqNjczOVRxV3g5dVJSYS8vaEs3?=
 =?utf-8?B?aFVIK0FOSFNZVTdDSTRIUE9TbmY4ckxSOVROYlZtR1hqQUJtQnRsdzloMzA4?=
 =?utf-8?B?cU9JTUQrUE1Ib3RQWkZOVVJmTXpmanozOXp0L0dWZG9naUJERHltazZtRUhF?=
 =?utf-8?B?UFVtSGRoY2xUU2NhdEhRS0hpYW1Yb0JZQnJMQmNxc0RkcWI0OTBxcU9raHNs?=
 =?utf-8?B?OHlvVXpwOFI0b3EyaklPUmJJL3FhY1RIaDM4QTRlTUNZY1liNjZBUmJ0Tjdu?=
 =?utf-8?B?SmZ3U2hadTd2N2FVaTBtNUU4UkQ5cDR4MndDOHlweWQvUUJTaGdJK1JOb3lq?=
 =?utf-8?B?NlBxb3ZubzY1dGg0enBTRHVVSVNWZHd2bUFpSWE4dVZFTDNYbzdDQzN0Rml3?=
 =?utf-8?B?eC9LZnFBcThUeEEzejg1WDI3RHc4YmYzUTE0TGpXZFpQZkJTZ1JFcjZpbjRQ?=
 =?utf-8?B?VHkyek1uQjlZSkZudUltcEpLK0wvdkl3Z09XRWJ0alhXVTZmWUNpdVdTVkpE?=
 =?utf-8?B?Z3NoWUpWdG9mWE1pY0VuTkdSd1FGZ25nQVAxaytNL1ZRa3gzNzhkNFd1THA3?=
 =?utf-8?B?VXpsc1RnZ2ozS20rdTRhWjk1ckd6WmhRT0ZUczZMOVV6aHNKaU4raUM3Wk4y?=
 =?utf-8?B?b3llNUZ2VVhxZ2hya0NmTWFGcVVGSTAxNTNaVlJFS1NKeW5tL3FTK2JQenNi?=
 =?utf-8?B?WFBtaTFmL0hWY3dub2V2cW5YaGVVK0NjRVFvSUxFSG9PU1J6WGRNS3RDejlD?=
 =?utf-8?B?MWp3R0cvSzJKU3prRGlEOFh4eTRDMFgzZ1owZldnOTJJcU5TV2RjZjhIMHhQ?=
 =?utf-8?B?bEJlTUN3R2MvSkx2dHljUkVIR1ZaTENKR3FNVXNKRjl2VmJZYWxjZkt2NTJL?=
 =?utf-8?B?Y1FuUTkvV2dKekFxTlRBa3U0OWZXcmdQdFByLzRtOHBEUnVEaVByZWdzSCtS?=
 =?utf-8?B?MDhIWFlBRkpKQWVHNjhIckp4c3EzZkhsMVpFUXJVNUs5UEZZYXZlQnNUd1hS?=
 =?utf-8?B?YkxMMng2KzM1VGxiaE02Sk01a0NXRU9zL05TeHpaM2ZCNU94cVFqbnNNU1JU?=
 =?utf-8?B?eWVFVFc1NS9wUkcwUlhiN2ZJQ1R3U3hqRjNFTUF1VEhMWGdjOG9BaDRoQlBQ?=
 =?utf-8?B?Z2x3L3ZFTTZoa2Iyd0tIQnJFMGNGTlZHVnFYZjJjK1J1Mk1tczNVMkZIbTBH?=
 =?utf-8?B?UlhtMk5UNThvd1l5aTRzU3VyUXpaaittNnowZEM0czFBZEdSV3FTcit5bU5J?=
 =?utf-8?B?OW5vMUFtM2pjQXhLTVFDSDIwV0FRTGEzelE1TjR3Y081S0wwVlBFcWdRRUxh?=
 =?utf-8?B?U0NnT1VJRlAwUEY0RzFmTmx2N1VHRGdRY0hEYjJ1SWR6Mm1Ga3hzSlBSUEFE?=
 =?utf-8?B?QXg0U2VESnZlSE5EbkNjREp1WWdhb2hSSitTQ1oraEkxWGlrOSs4YXVVQ3Jp?=
 =?utf-8?B?OHFHZm5Id2E2Zk9TRXR1dmlRWVlobTdpODh6NzEzQVpiMHc3dlVEZFlnVVZU?=
 =?utf-8?B?ZmJDc0pCbkFpdE5WVUZ3WmhnbVh5ZU1laThkZjNrR0FhQjdQV2dYdEVTVVN6?=
 =?utf-8?B?SThvaEFMNVRHckdWMDE1Ykd3TEJqU0psK3lXbTNYeUZGRE5ja21XSEhsV2lh?=
 =?utf-8?B?Ylh4SWRkcnE0NlZhUGtSY3c1WVVNcElhUVp1ckZ0S2QrVkhFYUt3WmJpbUdk?=
 =?utf-8?B?cVJGOXhMYTBzMU80ZC9GaUtjVUlQRENBRHZta1pFRWRrM3hPWmRtZktOcDVM?=
 =?utf-8?Q?BorC27AuohTUTXy1O7ubMGWxi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e17f5c7f-3aff-4bb7-b848-08dd4466a352
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 15:22:57.6301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wGAbTIFCZ1V0r8hEY1Y0gUA+4AioV45WVMjIAH+1xYJGeNfC99ruukpuqfxeBecX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6072
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



On 2/3/25 16:13, Ilias Apalodimas wrote:
> Thanks Michal
> 
> On Mon, 3 Feb 2025 at 17:03, Michal Simek <michal.simek@amd.com> wrote:
>>
>> LWIP wget.c/mbedtls_hardware_poll() is calling dm_rng_read() but dependency
>> is not recorded anywhere that's why select DM_RNG when LWIP stack i used.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   net/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/net/Kconfig b/net/Kconfig
>> index 24508026200d..6c684624fd6f 100644
>> --- a/net/Kconfig
>> +++ b/net/Kconfig
>> @@ -249,6 +249,7 @@ config WGET
>>          select PROT_TCP if NET
>>          select PROT_TCP_LWIP if NET_LWIP
>>          select PROT_DNS_LWIP if NET_LWIP
>> +       select DM_RNG if NET_LWIP
> 
> There's a WGET_HTTPS symbol, I think we should add that there

You maybe right but there is only WGET symbol used.
obj-$(CONFIG_WGET) += wget.o

It means likely wget.c should be split to HTTP and HTTPS version or add some 
ifdefs to that file.
I of course prefer to fix this issue which is visible with microblaze 
configuration which one of my patch does.

Thanks,
Michal
