Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9C5CE7D0C
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 10:24:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5967588D8D;
	Tue,  1 Oct 2024 12:24:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dn9oKGze";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68D6789166; Tue,  1 Oct 2024 12:24:48 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::622])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B18B688CC3
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 12:24:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hj1L+xVR2vQ9B/ZitwKDJMAiwqDmPumdQ96JSsKWzXkuzHBnCA96P5qghGX3Cmos+lYcRSGn9imetI4YRcXFr9kyG13XD9BDIcChQSMH4Rxk1ScYME1Wg5FxA63LKS3Ir+PJAuIvp8w8fJULgPUXIlHIphhr6ivrQVlUK/mYPdd39PEfSnPekzw4VFaY/AiHqU4AE1tvSjnx0dM4JCNzn0XCE+qSSf4YwsIccn/AJiUt6YIBlp6MuFQro/2kvpdqYNCIsGGxZW/ci+hrSQrueSBkw5ebkeLK1oYM6la9EWkakPSjYBc0VTgfY/5PaNFAy7g+jYTMH9hmizsVM9nALQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ub2mICaoURJ8RvLsyDC83AKBrVoRNEx0djIGSGsBeSQ=;
 b=xpDMWL8qQrdBFO7p4xGrwakF2SCZrzVrI7KWyBQbyumNmXamEa3EfHJhL1ahMQKY3a9xEbN6IZ/95baj+NmkRf+u0zR2zAWXMfv7hUWlr7J85VZ6uxQ+gE+ojw/TBNtNdK9vixF6j55GzcHUrfeGoe8A7Bvp2BMl7Dm5yDCe5ztMMd8FIc0nGHuXwMGh3U+NlcnWbKPDRvwaOqCwXx9J+hhAyPzbIvfIgIoT/oMVcFadSVYXzBknsIgRQKVOV/j1CwWQqAie9qbE9vfGI97NFisTYS80oh8j5eJP+HgSRPq3fxQG2i+8mTuk86JWb7ooXoyjmq7LmpLr99EXfZ8wsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ub2mICaoURJ8RvLsyDC83AKBrVoRNEx0djIGSGsBeSQ=;
 b=dn9oKGzeNKado7xJs5wLud8/6XsyHN+knr4U4t3CULhoXIu6E4Dxjk9WIK9/MNuoXJYcTnFaGN9Q8R3iwNG5YBR4jK3CAj8druaTrN+hV8xg6k2Cw1PyB78e6zSics2nTmLNLd/z5Z7VZ85Y5apoqX8nWITeJiCKnOytPtPULQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by IA1PR12MB7662.namprd12.prod.outlook.com (2603:10b6:208:425::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 10:24:37 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%6]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 10:24:37 +0000
Message-ID: <a3bcf751-194f-483d-8e5b-10d6eb6e98a1@amd.com>
Date: Tue, 1 Oct 2024 12:24:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] arm64: zynqmp: Update the usb5744 hub node as per
 binding
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: marex@denx.de, fabrice.gasnier@foss.st.com, git@amd.com
References: <20241001050529.17922-1-venkatesh.abbarapu@amd.com>
 <20241001050529.17922-8-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241001050529.17922-8-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0028.eurprd09.prod.outlook.com
 (2603:10a6:802:1::17) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|IA1PR12MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ab9161c-bcab-49e8-19e8-08dce2034037
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SW5IRHFJNkNPZ05IL1dVMlRxTkZCWTlhMWtWenZOWk1FQW94Z01pbzJjMmdq?=
 =?utf-8?B?T1lHZExJdHF4Y2RnZTZ5ekVFSTRzRWFkWkFvdVpTYjNEd21UcEZtLzh6ZzNR?=
 =?utf-8?B?aUNMaS82dm9IT2hZSlJuNXArMEFmZU9lWnkySXpaWVp3bEh4cFBJQVdhSHhX?=
 =?utf-8?B?bXpxS3I1VFc1OU1GRDg0WWhnWXBBSEhwenQ5UWhnR2NRN0NUdWhhUlJnY3o1?=
 =?utf-8?B?aVZQU1RpcERPMVk0dkhTNmFiTk9hcURMQU4rT3BySjc5WjBzNHdvV3RIZnht?=
 =?utf-8?B?ZjdFWVZDTHEwdkppRGJXV2JFWGJ4czNEZXllR0FvYklNZ1lCMEV3K1BPRUg1?=
 =?utf-8?B?Y1FUNWM1YkRLcm5wTFhsdEowTVV2ZmZ6b1lBendpWEErUno4THRmYlFpMUlL?=
 =?utf-8?B?MWlZWHZJNkxjZndOWEsvcExxeWJqc2l4MjEzWTdKK1BTMk8wd2tEVGNJcFZO?=
 =?utf-8?B?Z0FRLzN4bUs2S2laQm8zcW83QVJkMjRZd2tIVjhuSW5SVTdrbUg0ejhKbGxs?=
 =?utf-8?B?em5LMHZaczZkSHc3WFQ0clA5NjlVV0NmeVFSS3hBM0hmQzloMVJ5bGJXRkdF?=
 =?utf-8?B?dVM0TXpZa0FxUVFIcE94WHIzMFRjZUp5TXZUaE5ZaWpVaUg3NWhIRlM0a21z?=
 =?utf-8?B?U3dJcUhvS1lpeE1wRUdpUzk5UDltZUI1cTlYNm91SCtSc2JkdURLd1JGd3VN?=
 =?utf-8?B?M2NJTDY1OWlnL09qb0FDL2VtNFIwVGhzeDlxT25JUjd0dXhqTFdMZ3E4dFRK?=
 =?utf-8?B?WXo0eFRXL0VEVldiMFA4ZG5TSmg3UmNtV0xsanZjcmN4ekF5ZjNYQ240bjFG?=
 =?utf-8?B?Q2xybnVGWnIrcDFhcjB4Zm1Ca1RkcHlKeG9nQUs4RW9NaUNMUlZlZTFxbURD?=
 =?utf-8?B?clRZMXJtRUVrYjdXbEROVnhzQXNvR1ducG9mcWZDdGRqU21CSlJ2NnJRRXl3?=
 =?utf-8?B?OFE1d3k1cnJ2ZkVhWHYzZStGczBxalFIUVdwRDkxRUV4eE9wRXpQMERuZnl5?=
 =?utf-8?B?elJCMCttdVRvM0NieFd3OFk1ejZTbGtIQ0xINFNQK0hJN1pYczFFaFZ5SE9p?=
 =?utf-8?B?NzNEL3dWWXcwUGUzVVBqM0oyL3k5djJHdzRnSW8yZ2FyMlR4U0lya0VXRTcw?=
 =?utf-8?B?WmlkdzQ3aWtZUnhlcklYOGJsTjYwQkE2b29XZXlCcFlCMG8xRDlNUTQ0OEpK?=
 =?utf-8?B?aHVNTjVPWjVYVDFkemtyNFIyOUd1OEpGVWFvQWhYa2dkUFFNVkJJU2N2Z0ZQ?=
 =?utf-8?B?LytaWTRMeDRtR3lBS3ZzM2F4VE1iaTVmZG1aZCtwYWRTNFJUK2xMUG95VFRm?=
 =?utf-8?B?NFhNL01iM0NZRkhpcml2OEtud3Jna1VwVVBjaFkxWHZNUEZLTTQzTDdkbktG?=
 =?utf-8?B?S01kOHg4aW1PbVU4QjZFY04yMFJmbEd6TUxzeTZjbWxCaGpnSzAyV1hzVmNr?=
 =?utf-8?B?c3Y0TjE4eFgxUk85bUVsN0pybCtTYkE3YXIxcWVTclVycjNOdkN1bWsxRzds?=
 =?utf-8?B?ZWhSbXVwbzg2VHhPb2NLamUvTXNmeWRVYkFvNlRuN2hSMVJ3YVNNM3hwTTEv?=
 =?utf-8?B?dDF1d3NndklVOFF6dXBKZ0Mzdno2S1E5d2JFVHlQbjhGYTJZUkdoK2dLMDg0?=
 =?utf-8?B?ZUdxU1BpL1dCcWZPbExVMFJiSnl5b2VxWnpxWmlpSFFTa05FSzdkcmphZ3JX?=
 =?utf-8?B?MDk0WnpnbWZHRGpyOStMREhXb1pOK3lMVitkNTFJVTRZWU5LU2FrNGM0cDh1?=
 =?utf-8?Q?AFlh92rCW95UDGENUY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d05qSUh5RWlNL1BBK3lmbHk0V3BqdkJod3d5cDY3NktPWjBaNHp5OVZ6dkJB?=
 =?utf-8?B?VGdtZGUrZytrOWkzbWtJc2l5SzduMnp2NjRmM1Nuc1JZZUE5Zmp0bmloK2hs?=
 =?utf-8?B?MWwxcUtzWWFBaVBvZWx5Q3NSQVRIaVVBbnJkKzd0bnQzSHJvcWk0UGNoTE9J?=
 =?utf-8?B?ZkpCZ3dGRFRxd0ExdDF2dGY2SmIwTFV3enpxMlhaNjhhbWxGeERHaG9LUzNG?=
 =?utf-8?B?d3cxeG5RUlFJMFRtWlp4czYwZVVBbkIyODZYSTFkT3phaTROTWdHb0p2UDNB?=
 =?utf-8?B?Wk0vNml6M2JiV2MrZDJXWUhMd1RNQVlERXh5cC9OWmxlRUFKY3Z5ZlBiNUww?=
 =?utf-8?B?dTlQWENkYW1WVEhpQjhUZXBZYTg1a3BoTE9nWGdRZHZBd0x6amNwREM0Ujlp?=
 =?utf-8?B?UXM4cDNXZXBkNzUrdDUxdWw0M3Zwdkp3R1l6eXNxR2pTcEtVVVFFSm9ZZDFZ?=
 =?utf-8?B?K2NMdytZS3hFNTNaZVppQVlEeHc1aEw3ZVgyMDFQVXpPYm9MU3c2MG9lVXpv?=
 =?utf-8?B?QnhmNnBjY3h5a045RG5zaHpTTzI3RnQyOWw5eXhjMUdHMHVuODIzZHE1MXpv?=
 =?utf-8?B?eGhIMjBWbnV0MmhBbFFON2V6VUdsUEVKcDFJMC8ya0FXS0J6SkNOR1QwVVZ3?=
 =?utf-8?B?MFBZVTlUbHQrOTVqOENRbEdnMGpJVXVWUnhsRWFmWW9yTEJscjVKNG15QnRX?=
 =?utf-8?B?ZFVkbVVQTnY1WVhqdXFnU0lyWUl1bllnTzMvTUU2VTN0dnRCQUorbmkzZWRR?=
 =?utf-8?B?cmtOZmdoeXVmOVQ1TEEwdDR0Wk9IbGo5SmpmN2lBRUkvZnFJYlVuekV2Wlpx?=
 =?utf-8?B?eGQ3OHcybTdSaXBwM0JzMi9YK3g5ZHNSL0d0YUNqcFdjVXBrWkNNV0NyRWhQ?=
 =?utf-8?B?WVlGRnNkZWtuNEdrODh2WDVTTHV1TGtsRHV3N3ZPMVFBU3ZtdDVyUGFTbk9B?=
 =?utf-8?B?aWVOOEtOK1NKNThDT0NONVpuaTZLdXU1OERMYnNZNkRYU00ya3dLL1ZwOURU?=
 =?utf-8?B?V2VJcVBHY05udWhpcmdPMmVqaytSZ3R0aGcyWEVMSWtRTVlCTTBSYnFhZFNL?=
 =?utf-8?B?RVNFV01Ic1pzSHhKSmU5dVBJQ1NHeCs2VXVlTG8rYm9Ub0liSWZJREN4dXg5?=
 =?utf-8?B?UVVIcjk2TlYzVFlMN0JHTnNDTUkxbVF5QVBDTjRKUkNObkhPN1lzQStnZzRm?=
 =?utf-8?B?WnhtQmgwQWZ3S0RzWE1KSURnVnYvRVZuOVNpOHZySGlRcXo0d2QwbWhBLzFG?=
 =?utf-8?B?T2orWStTdnkyNFN0dk9XVnRWMDFZQlZPMkRkbXB0dENUY3kxTmhqTDdaLzI2?=
 =?utf-8?B?NG1HejAzbDBMNnpweXg2ZXFQcURRdUovRlprbTFXOUp3d0R0ZEFQaXNGV1dp?=
 =?utf-8?B?VVl4cXJPbXpWc2F6aWlCODUxL3hpeTJSN2ZxQ3hQejFMaGg4VmhkRk1QdkRC?=
 =?utf-8?B?WHd3WDB2WERjVCtpVEx2dStUNWNiVEtROEtSVnJXZmZyTHU1UXREOFZ3djNv?=
 =?utf-8?B?b0x2K1laVUhsenorWC9UK2N6UmxqUUZBWkJVRjFXUFZvcXcrTjJRcTMwd1Fz?=
 =?utf-8?B?MlE1RUtxRHZpdUsybWdGTlF3Tk80b3B3TUc0WHJvZmwwRmdrajJwS1g2amRk?=
 =?utf-8?B?S1FOamN2bWl2TEphS0E5WHU2c1RLWnZvaXhtVjZ6VkdCZTR6R0t2SDZBM1I4?=
 =?utf-8?B?K2ZKYk9ELzBYV2UvVGp0c2VQaGliclRzSlY5MXh0Q1RaSGRXMjM4MUtUYXhv?=
 =?utf-8?B?SUdYaVNoZGZKVWg0czNnc0YyMHZYczBKbFY1c0NDTVRQZjVuWnhlRU9wYmFp?=
 =?utf-8?B?SFhsMHBxaWxvTjVFYTNQcTZNc3pCdXdVMENpWjhjdDFBbVFocHF5NTZmT2lv?=
 =?utf-8?B?OU00MWtiZUdFd3YvbW0rWVJpNkJ3RWVlWXpPME1BcW94NFpIbU1wWm1mZ2hl?=
 =?utf-8?B?NHlMbVVvcGYwVmdRZFFOYjBLTTJwV1RnQ3FuWGtqTHI5aUhYTmZvQUNVYXVM?=
 =?utf-8?B?NG8zOFEvWHhBb2FnNjdjS2NOZmJLcThNL3NQNTBHTFRPd1JkL2czM2IrK3dk?=
 =?utf-8?B?Z0NmSnhheDhsdEVXZkJra0llaHV2YkpHWW1VYkY4VGU2ckFGMGJkcDlmMjNp?=
 =?utf-8?Q?CGYuiSnzbKytrTzKA57G2Hb8o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab9161c-bcab-49e8-19e8-08dce2034037
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 10:24:37.1907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A6QVIcJ5vSgJQLI05/b+JdvF7+HCk5ZFYlNqHFcdteA24WTqKObyovSlsap07+rx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662
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



On 10/1/24 07:05, Venkatesh Yadav Abbarapu wrote:
> Updating the usb5744 hub node as per the latest upstream DT binding
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/
> tree/Documentation/devicetree/bindings/usb/microchip,usb5744.yaml?h=v6.8.8
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   arch/arm/dts/zynqmp-sck-kr-g-revA.dtso | 48 ++++++++++++++++++++++++++
>   arch/arm/dts/zynqmp-sck-kr-g-revB.dtso | 48 ++++++++++++++++++++++++++
>   arch/arm/dts/zynqmp-sck-kv-g-revA.dtso | 18 ++++++++++
>   arch/arm/dts/zynqmp-sck-kv-g-revB.dtso | 25 +++++++++++++-
>   4 files changed, 138 insertions(+), 1 deletion(-)

I went over DT schema and this is passing that's why.

Acked-by: Michal Simek <michal.simek@amd.com>

M
